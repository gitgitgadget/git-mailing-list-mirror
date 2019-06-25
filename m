Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39D221F4BC
	for <e@80x24.org>; Tue, 25 Jun 2019 13:41:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfFYNlT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 09:41:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45416 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730220AbfFYNlS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 09:41:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id a14so27178719edv.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQ6bGiqz4a2cNG6935V15lPG6hJOhxhpuDE2K4gYTHc=;
        b=N3/uKG0/H6psUt7bC0JR5irI5meP1JovrG+8wu+lmdw5l/hfnTFWD97gj0nHntWXZR
         X54i+9Bxf+s7+F0rUQqUqn0WFLwQw5D1m3TagrjAUkQ+xhrxDtKoc+xO6Dar8sq1E2/4
         bqnBMmgLGvuxCv+Ld52glFSXO6nfk53e6Cb0LDKhkoijWrhKiwVv2mx89+gb9I63bMlx
         0vXftLfkmGtgk5IcmZgC4sWCYxv+j1XHJtstu66JJ9tFnUsWloW4xv/EkRVZYZd9QskX
         PhLt3I9rOPjRlkP66FfZlVGvVRI3Z3e03hxWsMoiX0ojm1DIbXzfB9FZCaywWVlSWGee
         pmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQ6bGiqz4a2cNG6935V15lPG6hJOhxhpuDE2K4gYTHc=;
        b=rJCIQcWi8wm7v9u8tNosBZYpn/GX85kqsc0YXkwRUulLj2fBM/9/3D//FbzGQuq67S
         pcNDhqbVaxtosznNcSkG3E5s8R0unFNr9BHkkP6NNWqzZAJB6PlJYH9v09kcqY960hF5
         IvIHadD8cp6pERLz/KafTZoZFIQAy1CP7P9kHJxtwqFGazEZXMmEe5uBdZGgLvqWhfpk
         S2PJNHtpV0zXDnHWeaXfoA6RhuENkt9tlcidKN51aFqI+VR1AC0pGvjq8Gc+OTgyKgby
         g/VugWvBnUgdlE9UVDtWkdQwyP05/v6QBjqdsjsQ7GadmmnrDmXN/+qYG3YEhS0M+2aL
         vPaQ==
X-Gm-Message-State: APjAAAXYBPE2jzFqwmn3+QtRjhK/v9IhihXMXmEn3nS5gxxA0V+ikxfp
        ovUghQGL4WZfTZCtv8JuwEEeV2yjE18=
X-Google-Smtp-Source: APXvYqyEN0zFPXFgRoW7vvV+m12kV4cArMJ62Wn2g0w1D+jQvxDpbFauGmKTQEXZjFUz/Eelbp/XGw==
X-Received: by 2002:a17:906:158c:: with SMTP id k12mr25643172ejd.83.1561470076012;
        Tue, 25 Jun 2019 06:41:16 -0700 (PDT)
Received: from ubuntu-N150ZU.booking.pcln.com (access-114.38.rev.fr.colt.net. [213.41.38.114])
        by smtp.gmail.com with ESMTPSA id v11sm2448445ejx.24.2019.06.25.06.41.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 06:41:15 -0700 (PDT)
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
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 09/15] builtin/fetch: remove unique promisor remote limitation
Date:   Tue, 25 Jun 2019 15:40:33 +0200
Message-Id: <20190625134039.21707-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.22.0.229.ga13d9ffdf7.dirty
In-Reply-To: <20190625134039.21707-1-chriscool@tuxfamily.org>
References: <20190625134039.21707-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As the infrastructure for more than one promisor remote
has been introduced in previous patches, we can remove
code that forbids the registration of more than one
promisor remote.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/fetch.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 13d8133130..5657d054ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1465,26 +1465,16 @@ static inline void fetch_one_setup_partial(struct remote *remote)
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
-			      "configured in extensions.partialClone"));
-		return;
-	}
-
 	/*
 	 * Do a partial-fetch from the promisor remote using either the
 	 * explicitly given filter-spec or inherit the filter-spec from
-- 
2.22.0.229.ga13d9ffdf7.dirty

