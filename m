Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965671F461
	for <e@80x24.org>; Sat, 31 Aug 2019 00:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfHaAXW (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 20:23:22 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38820 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbfHaAXV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 20:23:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id o70so5622532pfg.5
        for <git@vger.kernel.org>; Fri, 30 Aug 2019 17:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ghh6VJQglbmbAhMr88wl4QvTeb5xyLS8n8TPI5d/LpM=;
        b=kav0km8L6H98yAJ2vnwMfpHdcKwX9QYtPR0q76jKVg1WumiGc7h/5IuTvzpQrtG3Hu
         YMC/feho4NM0SOtmi8Px8+C8rNyoTAprr3ZMuFgT4xr7TDyk7ONmd6H/sdTSQDYAST8f
         u1d+1aTCww3VSBI3hAXGzhbQgP+vSNYtPKxlCqKP+Jsw/N8nCAQriX7hBv/aQj91Zz5w
         3Z5SWbIQ91anwv33JnBN42g7Ufs2uSZ+4iVSHYD9JxjrHfRDCduP2SeD2DG+XOu5CAQW
         pKDgqcCdA/ClQCp/iv0jck38h6ysyD5m9MgY2H8aZoWFH8RgxBMCkoRgn2VMT0l0vYK8
         J17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ghh6VJQglbmbAhMr88wl4QvTeb5xyLS8n8TPI5d/LpM=;
        b=cTo10rHvsRUWmYIdQDwT29jXmreQsiVOi4/BAccltze1xji2gSM3faN9Agp3WXV+oV
         HTZY1e97T+8v8E+rX+bheojDv9vx3kICTaM5Znnj6vVieV+Nb22Ds/ZNFgUzeI95UIK1
         N88e0EoqJfeMoMrfLa3YVXIz+DwcNNVfCK+am+1+eCot/pkA1MpvBDs+VZFyX8wAKwd/
         71UCDPt56f6BqWv9QOB8oGfsVoc+m04d1IKiJmEh8D6Qnw/5mNiT7picPSP44TG25ax4
         oPJzTfk/h65SGs9JllM86uS5LGTWo59DEijmm8jyu7iJzf9sS5wWpkUnHPCd2J26Zg1Y
         uyeg==
X-Gm-Message-State: APjAAAUONyhISAC1zcaX00JTpRuQFWKtGg5cm+z0ipd8NTGy+XKgMvjP
        teX3tfjaRtczGcUB2dFxDP8DAdi9
X-Google-Smtp-Source: APXvYqxRJfZzE1Q9ykGrdhGzDSzhDyNQ31GWvd+D4g5hfBUAk9GxCiCnmK9vUviXW40SQdnPttbpew==
X-Received: by 2002:a65:6102:: with SMTP id z2mr15012115pgu.391.1567211000594;
        Fri, 30 Aug 2019 17:23:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id d189sm8602449pfd.165.2019.08.30.17.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Aug 2019 17:23:19 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4] merge-options.txt: clarify meaning of various ff-related options
Date:   Fri, 30 Aug 2019 17:23:13 -0700
Message-Id: <20190831002313.8761-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.39.gf92d9de5c3
In-Reply-To: <CAPig+cRPGY4wEbUin3mDj0+nHigtndNWj6o-FHjKeCzgqY9Y5Q@mail.gmail.com>
References: <CAPig+cRPGY4wEbUin3mDj0+nHigtndNWj6o-FHjKeCzgqY9Y5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discovered on the mailing list, some of the descriptions of the
ff-related options were unclear.  Try to be more precise with what these
options do.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
Changes since v3:
  * Shorten the leading paragraph, as suggested by Junio (and Eric).

 Documentation/merge-options.txt | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 79a00d2a4a..94be34f941 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -40,20 +40,24 @@ set to `no` at the beginning of them.
 	case of a merge conflict.
 
 --ff::
-	When the merge resolves as a fast-forward, only update the branch
-	pointer, without creating a merge commit.  This is the default
-	behavior.
-
 --no-ff::
-	Create a merge commit even when the merge resolves as a
-	fast-forward.  This is the default behaviour when merging an
-	annotated (and possibly signed) tag that is not stored in
-	its natural place in 'refs/tags/' hierarchy.
-
 --ff-only::
-	Refuse to merge and exit with a non-zero status unless the
-	current `HEAD` is already up to date or the merge can be
-	resolved as a fast-forward.
+	Specifies how a merge is handled when the merged-in history is
+	already a descendant of the current history.  `--ff` is the
+	default unless merging an annotated (and possibly signed) tag
+	that is not stored in its natural place in the `refs/tags/`
+	hierarchy, in which case `--no-ff` is assumed.
++
+With `--ff`, when possible resolve the merge as a fast-forward (only
+update the branch pointer to match the merged branch; do not create a
+merge commit).  When not possible (when the merged-in history is not a
+descendant of the current history), create a merge commit.
++
+With `--no-ff`, create a merge commit in all cases, even when the merge
+could instead be resolved as a fast-forward.
++
+With `--ff-only`, resolve the merge as a fast-forward when possible.
+When not possible, refuse to merge and exit with a non-zero status.
 
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
-- 
2.23.0.39.gf92d9de5c3

