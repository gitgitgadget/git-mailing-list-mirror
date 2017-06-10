Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A74741F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751799AbdFJBxL (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:53:11 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33531 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbdFJBxK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:53:10 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so174667pfk.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=VlU2cib8JTv3l62gNdS/6I86ByBloeoHkPBbtO7ACJE=;
        b=DkJc9W2ZXmGu+MaZTkSmU/GfBNUR/oCACXUrFpFgu9Ovg1gYn+ErsN0PM5dl1yzX7n
         kJZznzPRlugzf00iMlBUKhkdQlkNQ6fiNv5ojDQX1AZzgkidlIvC2yxf6Jtw8k9aRYdY
         VC9CaHvjNiuZdnGGbipRGQrUqpPZqus5loKhMbc/jY+FqIaB7X5PGLVWi46zXkEOCzTL
         4sDlSrpJq9dpcfBjmOkBGtMdki2zSTVtbUPkLL2U4h1QdP9Z5s43wL30XksPRoz0LjQZ
         1Qb8Cj3sBxB5te1YUz3gKdE25tULTFcWromD7axfmt327IXynHxl7wSBzQLSaa0JxdUu
         m5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VlU2cib8JTv3l62gNdS/6I86ByBloeoHkPBbtO7ACJE=;
        b=IsYahhi4dazxZMH4fzI8Ne3eCeKvzs5mIztXD9QMwm6eKNvyLklMNf+FULjmSpJnaG
         xnFAm1q+E0mC1m3mTyDi6mBli0SAAkO/t+sdbgZ0oTnmMYHFwAterQVTN9BXZoanoMFe
         DNRsccILh8ljTPBs93Xahjmu0Iq9YhDDHnlrjOBivssS7SDVIKwg9sydGBh1i8+shVV+
         WBOoFc7bCpKIXm/n16NkqQ9PLFMV5eqDYFbCe6w6hQOFK6r1UckAQ7p06yNTvREVwFmo
         H45jTwKWJ0KbxKFlVIh5DyPD3r0IwxezsZnLdszNfH6nRDOQAUN+yOOz44zqONMwecoW
         sYsA==
X-Gm-Message-State: AODbwcBx43rRMTvUmYctD+zPpq81lZx3DSqUuvSboRaF5TpkQ/b8D/Nx
        KaETHFoOvN0n+A==
X-Received: by 10.84.197.131 with SMTP id n3mr43904198pld.170.1497059590078;
        Fri, 09 Jun 2017 18:53:10 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:800f:e175:94b2:5f2f:a42d:438b])
        by smtp.gmail.com with ESMTPSA id i188sm5105602pgd.5.2017.06.09.18.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 18:53:09 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
Date:   Sat, 10 Jun 2017 07:22:36 +0530
Message-Id: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The status message shown for a paren-less branch wasn't so
descriptive and was a little confusing.

The message has been changed to be more descriptive to users in
such a way that it clearly shows the state of the branch / repository.

This allows the users to be reminded that they are about to make
their initial commit which the previous message didn't seem to do
communicate well.

A few alternatives were,

* No commit yet
* Your current branch does not have any commits
* Current branch waiting for initial commit

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 wt-status.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0375484..7bfdde4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1576,7 +1576,7 @@ static void wt_longstatus_print(struct wt_status *s)
 
 	if (s->is_initial) {
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
-		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Waiting for initial commit"));
 		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
 	}
 
@@ -1746,7 +1746,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 #define LABEL(string) (s->no_gettext ? (string) : _(string))
 
 	if (s->is_initial)
-		color_fprintf(s->fp, header_color, LABEL(N_("Initial commit on ")));
+		color_fprintf(s->fp, header_color, LABEL(N_("Waiting for initial commit on ")));
 
 	if (!strcmp(s->branch, "HEAD")) {
 		color_fprintf(s->fp, color(WT_STATUS_NOBRANCH, s), "%s",
-- 
2.7.4

