Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A809920382
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfDAQlU (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36389 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:20 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so122041wml.1
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xvVqrtz4KuRtT7e+5l9Em2GkoUPl0NAf+wMQJ1Lrje8=;
        b=D9AN4eE0SE5FAdewRJJ7nlOrNF9DJJ8SbXWc+1X0U+sMiWUjOU+N0qtoDjH5vSqj3z
         GgO624fwgwmd2nd4p+Pzc9DGTpy4+ztT6jdHoTnDTgSDTISCmTqdfkiPTXYvevbMdSpp
         fE40ekllZoDpPVT7pW6nhat+wyBFJA5qCBuK2RLjFIvHPDJdUX7/VMW5DV3ieaheVJW2
         zdtZxgkQqKwdPH4Jx3JKCZIHCytnJjZFix0+YYxipF0oyvcCTWfpu1v/Xux+glMBM/dA
         fNR74Rh3fSdCIr31753zwNdbbCy6dIvaPVrZAuLMixVc9gMnCtTXCuWUf4ywSv71xTiK
         5mNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xvVqrtz4KuRtT7e+5l9Em2GkoUPl0NAf+wMQJ1Lrje8=;
        b=YmaYuzkEom1tiaZGZnzsSrzenkZCSzp6o3aZLoVQJi/7ZTJQ6jGYv5ZjEp99/oHb9y
         w0zlx5F/Q4MeNbCDPZAhx8xlGUe1exbYKgu86xNZm62xTIv7sr3mZy3Mt3/RHnwLKseh
         AJVt5yAwBhMi745qEsPKKn00Avc0x+LsAFTHn5aSXpG7IH1LlsRUz2t0RSn0vIZOmRN4
         YHNXXVHpmH+TZpUs4nLAuyiwYyDzpNrpe1IZezYEPMca7DbIRoSovWT1kl717x7C5UaD
         nE9o4djf3llNuC8C62fjOLRfconrHEI4v0mY1cQmKBez00daKNBRHdqGqwfdcdb2fkhc
         6fyA==
X-Gm-Message-State: APjAAAXCdD3WP/WLm6awK/t92ry3skXdo3TG+4zYHAL+7qJ8/RXhZxnY
        Yz/xMg/PJNd9YxsPc5ivm7BUlGUL
X-Google-Smtp-Source: APXvYqxNN3+p1zuPH71iQezkx1nTn6rtYS29lTBx+VTgmszk1y/iKXKu5+Z+V80PARa/AsOuovvUow==
X-Received: by 2002:a1c:c504:: with SMTP id v4mr331082wmf.45.1554136877949;
        Mon, 01 Apr 2019 09:41:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:cec0:101d:3e80:8542:d1d4:667f:a0da])
        by smtp.gmail.com with ESMTPSA id s10sm11749070wmh.0.2019.04.01.09.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 09:41:17 -0700 (PDT)
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
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v4 05/11] promisor-remote: use repository_format_partial_clone
Date:   Mon,  1 Apr 2019 18:40:39 +0200
Message-Id: <20190401164045.17328-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.21.0.203.gd44fa53258
In-Reply-To: <20190401164045.17328-1-chriscool@tuxfamily.org>
References: <20190401164045.17328-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A remote specified using the extensions.partialClone config
option should be considered a promisor remote too.

This remote should be at the end of the promisor remote list,
so that it is used only if objects have not been found in other
remotes.

If we are using promisor remotes other than the origin, it is
because these other promisor remotes are likely to be better
for some reason (maybe they are closer or faster for some kind
of objects) than the origin, so it's logical that we try to use
them first.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 promisor-remote.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index d1fcd1a8bf..6a689737f0 100644
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
2.21.0.203.gd44fa53258

