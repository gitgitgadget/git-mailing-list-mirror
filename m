Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F328F1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 02:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfBFCvh (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 21:51:37 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfBFCvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 21:51:37 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so2441342pfc.3
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HQb1+0AX+T2lMT5mHjnp21vnjDJg6FDxikXgEP2x32M=;
        b=LthQ4HGZ28iMj9Z3Tg+uQ9yTuXSwYOXvI+3pne3YKIF9Vxt1h3+yazuZqqdy/o0pe4
         9Q8a2m+fwUrWoV5iGn6fRY9KxC+yEUSuylULijsif+lyWFX2+ntsWSShKv8iXPTQc7ah
         IXs/9LTB27KMymOSYLb4q6h8li9tNLiyAaBhvlD2t+tPm0uaotNbXP4JBNBGn0kW+p3Z
         vKzCn1yuvR6/O4D72ndEoku76PHrr/8LnId33Q6BuVfaab1YP/Yy85VfAVDTwCDa1/Vc
         2sfPEQM5iD38WKOOp1LVDt+QG96kTRHGY9h8/t1qTjw6F73/0mItYI4KoD8a826QpY3o
         MtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HQb1+0AX+T2lMT5mHjnp21vnjDJg6FDxikXgEP2x32M=;
        b=eDMI3uZRIqgzbfuuZI02w2WBsMAq8UkS2u3H+7g5ONT8xBJo8RNsJKHt65HcOXh/0b
         Pq1Sa32j6l4Tf1vB9IhAe/5h/Vqen5NHs6g2Uhr6YSOoDVVOYF3LaojYa2GSAMPPlm2B
         ceOqvSYNrsVjokaTLNPIzZktR064A7uBiAQN0cQ17FnrSx/m6hxCSAAlt6JivhWCv8Km
         SeKN8mW2iU0oXsTNpCLYAlQ1qrAUFnojUhuyQrybU2No5dbzd1432uX2bGXWcEEaHuEi
         tTUHNP/492bgxLoMm0oHjZnVAZMzeOhsE3Ga9n7X3eqlaDbiuEz9Pi6dHAi5ojdj2hQt
         tT1A==
X-Gm-Message-State: AHQUAuaC5C0jvN0jGds+GIYK2oCcIeeaLa6IaYfUQj2Ur9cVJ91f3Xo7
        SrW0ryzDEyL6Pq1cHU3WJrOawL8C
X-Google-Smtp-Source: AHgI3IYMQzElRmzoup+SSXBXPbOmMfJWfX2cciFE+ziiVZb9IKMC84MZaArx84GV6y8fIQp3Oxscrg==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr2051262pfg.162.1549421496243;
        Tue, 05 Feb 2019 18:51:36 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l8sm273863pfb.68.2019.02.05.18.51.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 18:51:35 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 06 Feb 2019 09:51:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] checkout: count and print -m paths separately
Date:   Wed,  6 Feb 2019 09:51:15 +0700
Message-Id: <20190206025115.26163-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190206025115.26163-1-pclouds@gmail.com>
References: <xmqqimy8a1gx.fsf@gitster-ct.c.googlers.com>
 <20190206025115.26163-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 0f086e6dca (checkout: print something when checking out paths -
2018-11-13), this command reports how many paths have been updated
from what source (either from a tree, or from the index). I forget
that there's a third source: when -m is used, the merge conflict is
re-created (granted, also from the index, but it's not a straight copy
from the index).

Count and report unmerged paths separately. There's a bit more update
to avoid reporting:

   Recreated X merge conflicts
   Updated 0 paths from the index

The second line is unnecessary. Though if there's no conflict
recreation, we still report

   Updated 0 paths from the index

to make it clear we're not really doing anything.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6e33850d9f..e762b53542 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -260,7 +260,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 	struct commit *head;
 	int errs = 0;
 	struct lock_file lock_file = LOCK_INIT;
-	int nr_checkouts = 0;
+	int nr_checkouts = 0, nr_unmerged = 0;
 
 	if (opts->track != BRANCH_TRACK_UNSPECIFIED)
 		die(_("'%s' cannot be used with updating paths"), "--track");
@@ -385,13 +385,18 @@ static int checkout_paths(const struct checkout_opts *opts,
 						       &state, &nr_checkouts);
 			else if (opts->merge)
 				errs |= checkout_merged(pos, &state,
-							&nr_checkouts);
+							&nr_unmerged);
 			pos = skip_same_name(ce, pos) - 1;
 		}
 	}
 	errs |= finish_delayed_checkout(&state, &nr_checkouts);
 
 	if (opts->count_checkout_paths) {
+		if (nr_unmerged)
+			fprintf_ln(stderr, Q_("Recreated %d merge conflict",
+					      "Recreated %d merge conflicts",
+					      nr_unmerged),
+				   nr_unmerged);
 		if (opts->source_tree)
 			fprintf_ln(stderr, Q_("Updated %d path from %s",
 					      "Updated %d paths from %s",
@@ -399,7 +404,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 				   nr_checkouts,
 				   find_unique_abbrev(&opts->source_tree->object.oid,
 						      DEFAULT_ABBREV));
-		else
+		else if (!nr_unmerged || nr_checkouts)
 			fprintf_ln(stderr, Q_("Updated %d path from the index",
 					      "Updated %d paths from the index",
 					      nr_checkouts),
-- 
2.20.1.682.gd5861c6d90

