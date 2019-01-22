Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1B5421420
	for <e@80x24.org>; Tue, 22 Jan 2019 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfAVOms (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 09:42:48 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36648 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbfAVOmk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 09:42:40 -0500
Received: by mail-wr1-f42.google.com with SMTP id u4so27651164wrp.3
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 06:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WVJxXAEBOVQVdJc9P/Qb7EZQRGeBngAdYMOrmxK5lho=;
        b=oa+M5oLTnIiYwy3os13P3p1FvHKfSOURJduGBNz+X+36DqMdbGLRd/EseUg+6OilnU
         0DkUAupD1Y2a2iM0H3WGoc6gFgz4gilxwYfZvI3VJ/gWeIc4vWy/FN5uw6NxeP19zBkx
         8sXYuarBw/i38U7XzPvEWyfF8xK4jrYV95/fAUflLHL1LwPhKvomo3bu7madnrM8618N
         ggQHnMDp7nqGL4zQZ0HDP+9bDezAYSRRjrCcMWzbWrqPhC4CbtHd7XEkbt1WbCbW8fjx
         pwR+ucNrgobukpSV0JvOpXKVufuoVrLYGEBmvCjzVpXkngpY9j1bd3L8jwFZ0KC28Fof
         2wNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WVJxXAEBOVQVdJc9P/Qb7EZQRGeBngAdYMOrmxK5lho=;
        b=owIxfkoR9s8+G6ZFem0JBu0++5NQ8gJO7kcBuRqJhJsXv2RTmpOJnKYD/AZIg/n8RJ
         r4G7IawGPYt2gq4QqDK7eXiCeZnBtBfW+IgciO27gQfuYN5ucwVGouv+xA+aJwlDP0UO
         G9UAWCKFicIU2tz/gWTJo/mzBmj5n1Y9XVSBS/6WrlZTJ5tXKPCjI2L18dZ/HrTvchDp
         6HtXKhon/C7UEHBdofKlZ6VX/h0pCg3J1ZN/B92fayOQDWg/eUJNLa+kxv3rCJKekUEC
         3ZNvEgiMSs9tjEdygu5N7G4aipDqfZOl7a71S5OO1326QGcx4dVi34yop/ac06SYJqdj
         NAkw==
X-Gm-Message-State: AJcUukeMV7Dr2TEAgUEyj2W6Tqxfw9FAUm7+eANIn9ZWVp33n9LUCfuJ
        lAldbnxw+jvx36HEMGzIeZsdzgJj
X-Google-Smtp-Source: ALg8bN7qRdQQBbdZQnGUZ2hSd0HQAlW4M+W7BeG7+A2F6enM7ylpUErU9FE9urYOv3aJnW16yESJDA==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr32667504wrm.143.1548168157788;
        Tue, 22 Jan 2019 06:42:37 -0800 (PST)
Received: from ubuntu-N750HU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id k26sm31266168wmi.28.2019.01.22.06.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 06:42:37 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 10/13] builtin/fetch: remove unique promisor remote limitation
Date:   Tue, 22 Jan 2019 15:42:09 +0100
Message-Id: <20190122144212.15119-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.20.1.322.gd6b9ae60d4
In-Reply-To: <20190122144212.15119-1-chriscool@tuxfamily.org>
References: <20190122144212.15119-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/fetch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 75746c50e0..ed883399c7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1464,26 +1464,16 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 		return;
 
 	/*
-	 * If this is the FIRST partial-fetch request, we enable partial
-	 * on this repo and remember the given filter-spec as the default
-	 * for subsequent fetches to this remote.
+	 * If this is a partial-fetch request, we enable partial on
+	 * this repo if not already enabled and remember the given
+	 * filter-spec as the default for subsequent fetches to this
+	 * remote.
 	 */
-	if (!has_promisor_remote() && filter_options.choice) {
+	if (filter_options.choice) {
 		partial_clone_register(remote->name, &filter_options);
 		return;
 	}
 
-	/*
-	 * We are currently limited to only ONE promisor remote and only
-	 * allow partial-fetches from the promisor remote.
-	 */
-	if (!promisor_remote_find(remote->name)) {
-		if (filter_options.choice)
-			die(_("--filter can only be used with the remote "
-			      "configured in extensions.partialclone"));
-		return;
-	}
-
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-- 
2.20.1.322.gd6b9ae60d4

