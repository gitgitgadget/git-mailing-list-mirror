Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03E7420305
	for <e@80x24.org>; Tue,  9 Apr 2019 16:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDIQLy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:11:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46897 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfDIQLx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:11:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so21619028wrw.13
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L5QqTPdBPcJY8lzGpbv831cXvWC5SIOb/3P9ycLHAig=;
        b=bT2yUw2GtNLcbYjBiouLgYRua6Kk+HdCyMyNQIPenaIlRhTbyGT+8kXfJl3GGHmLPl
         iBBD3UyQRPiLmt9FcB2XvKYLA75QdasLXC+NCdQrg2b0WogXg4FhWBJUq5LOjt1PfOjR
         CUj6dzTIWjNdtWt07Kzff03MQvobEDemfA4GUPP/wGRUYkODZ11z3vXLSrwz7hriqHWM
         I+CWkkRSi/hcE3HOfBv5sJAAWRlS5ahXu+2NgAS1sfMloXLFp43Mmlo2j0PakTa/y/4F
         d+opoPq+tnVfyrWrEelNFibGOK116aBsjWAElNm/7pLk3UavvP6aa44dswy0ectnNFsh
         Db/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L5QqTPdBPcJY8lzGpbv831cXvWC5SIOb/3P9ycLHAig=;
        b=I0x/5OED9OHPx9sWOVdjdMTfuKjAhIZDRCIhMy2i56SYQ7qIaWZWcnASkpE+ehTLo6
         xMJqwW39orXp50rUxev2ytYfULSs4+S6DRlt9hdmZuo3JSV3i1RSe/1RNvUxP+DvR+JW
         v5xpP1NxhcQBdCA1E8UaGLVS4N43T08faVhFDA/e7wW974jsJXqi+MdH3bfY73f+Iq7J
         /az9x8MFLw/sOP4+ZT8A+AMvDK8+bimmgvEMFYFZZzeWxyGHY4ThO2YwAlnTrQrwjjfh
         fO0dnwCrsTVg21CzGkxmgiBKncoaXLEIZYgnsTkjRjPihSuyT+ZNuH5GaIqkpfaMTX6D
         Q0Lg==
X-Gm-Message-State: APjAAAUBq4foERy/KHyw3nn3E/Mvb77UWoqjZNDcDQk07bKkI6+MVjBA
        Mp7fxpieRzD6vO/yMuu5BMDYylgI
X-Google-Smtp-Source: APXvYqxiQ4hwdcXWHV9utx8HPO+Z7LmbQk39tbcRSBt+34V+Qgoj+lvGHBXeBhN3GnCNsbhTWUUgnw==
X-Received: by 2002:adf:828f:: with SMTP id 15mr22858326wrc.17.1554826310959;
        Tue, 09 Apr 2019 09:11:50 -0700 (PDT)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id i2sm4356012wmg.47.2019.04.09.09.11.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 09:11:50 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 06/16] promisor-remote: use repository_format_partial_clone
Date:   Tue,  9 Apr 2019 18:11:06 +0200
Message-Id: <20190409161116.30256-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.750.g68c8ebb2ac
In-Reply-To: <20190409161116.30256-1-chriscool@tuxfamily.org>
References: <20190409161116.30256-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

For simplicity and to make things predictable, this promisor
remote should be either always the last one we try to get
objects from, or the first one. So it should always be either
at the end of the promisor remote list, or at its start.

We decided to make it the last one we try, because it is
likely that someone using many promisor remotes is doing so
because the other promisor remotes are better for some reason
(maybe they are closer or faster for some kind of objects)
than the origin, and the origin is likely to be the remote
specified by extensions.partialClone.

This justification is not very strong, but one choice had to
be made, and anyway the long term plan should be to make the
order somehow fully configurable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 46271eb3e3..737689d044 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -40,6 +40,18 @@ static struct promisor_remote *promisor_remote_lookup(const char *remote_name,
 	return NULL;
 }
 
+static void promisor_remote_move_to_tail(struct promisor_remote *r,
+					 struct promisor_remote *previous)
+{
+	if (previous)
+		previous->next = r->next;
+	else
+		promisors = r->next ? r->next : r;
+	r->next = NULL;
+	*promisors_tail = r;
+	promisors_tail = &r->next;
+}
+
 static int promisor_remote_config(const char *var, const char *value, void *data)
 {
 	const char *name;
@@ -76,6 +88,17 @@ static void promisor_remote_init(void)
 	initialized = 1;
 
 	git_config(promisor_remote_config, NULL);
+
+	if (repository_format_partial_clone) {
+		struct promisor_remote *o, *previous;
+
+		o = promisor_remote_lookup(repository_format_partial_clone,
+					   &previous);
+		if (o)
+			promisor_remote_move_to_tail(o, previous);
+		else
+			promisor_remote_new(repository_format_partial_clone);
+	}
 }
 
 static void promisor_remote_clear(void)
-- 
2.21.0.750.g68c8ebb2ac

