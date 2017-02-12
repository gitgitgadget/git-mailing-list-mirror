Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF9211FC45
	for <e@80x24.org>; Sun, 12 Feb 2017 21:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbdBLVyk (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Feb 2017 16:54:40 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32810 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751417AbdBLVya (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Feb 2017 16:54:30 -0500
Received: by mail-wr0-f194.google.com with SMTP id i10so21678700wrb.0
        for <git@vger.kernel.org>; Sun, 12 Feb 2017 13:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ijcwoPFDv02ymF0dMpNp1+zgHPCGiAffdFD5yzHVJoU=;
        b=eMdMR1vY5KFurpehVYSh4WCLphD/hcsHI+bwBPBGs39bkFQhicx1IKZrj41SJQ8zmD
         ZxaiNNR9af0hLA9F1YDVKZZdw+gUaDGg8hHsjUvzP5GDoA0GpvcV1/pv6gn1fVa+5bDj
         aRA/JwLQOEz8d6fYYPSqocVveZlicj8NIDXc7wbPFPw2zUrgmN3zPHGH+NbHZWXiftm+
         UhdAzCp/0fKBGH+rl29hXC+LoQvwZ2DNK//MJKO1WCcAJ//DFZLfrljE9pkh2JNn9yAw
         SfG3KGbnaJeeA52AI+IKLH+myXpQcsnfqJmf0+tQWaztD5AdI+g6FbhH3DXtsmiVUMsK
         +ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ijcwoPFDv02ymF0dMpNp1+zgHPCGiAffdFD5yzHVJoU=;
        b=LdrUgP5y2ivf1tgM+jt2mKPj2x8g+MS161qnejPF0tF8YDHPCLJV/tJDVZzGIyuN1S
         HfKxdnBvaKZBEnRFQ8Gv4ctOqrwTGxcbha60d/AZkiMx4Ss8/TGYA+CnEcyI72/MOm71
         0L9hkMbzR5jCEzs/T6rlPdn+Dc2CPqvZgmiB7IqUlt0ao7+A/erlp/9GXXn9j0nDEIE8
         bmuWy9GKVU824ldwXOy5zvwAuFiK8CexPoyAeNKEhYjyu7ZJxlIghU3EHWr5fZwpQeVy
         hb062wPazFLaX/+v46G0pRV3G910kjSo0kYLV5xvxmgPmxNr2cs6Ds/wt7/YoCxZszNL
         uliA==
X-Gm-Message-State: AMke39lJI+/ivE3Kbv7MVrpg/49HAdvwiN3wqgBeAYa5o5PQl7a+C+rR98KQJCB403gWAA==
X-Received: by 10.223.177.202 with SMTP id r10mr16689234wra.94.1486936469252;
        Sun, 12 Feb 2017 13:54:29 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id k18sm8223134wrd.62.2017.02.12.13.54.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Feb 2017 13:54:28 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 7/7] stash: allow pathspecs in the no verb form
Date:   Sun, 12 Feb 2017 21:54:20 +0000
Message-Id: <20170212215420.16701-8-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g86e6ecc671.dirty
In-Reply-To: <20170212215420.16701-1-t.gummerer@gmail.com>
References: <mailto:20170205202642.14216-1-t.gummerer@gmail.com>
 <20170212215420.16701-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that stash_push is used in the no verb form of stash, allow
specifying the command line for this form as well.  Always use -- to
disambiguate pathspecs from other non-option arguments.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     |  1 +
 t/t3903-stash.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/git-stash.sh b/git-stash.sh
index 769cee9fd8..a184b1e274 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -704,6 +704,7 @@ seen_non_option=
 for opt
 do
 	case "$opt" in
+	--) break ;;
 	-*) ;;
 	*) seen_non_option=t; break ;;
 	esac
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index d568799da9..22ac75377b 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -881,4 +881,19 @@ test_expect_success 'untracked files are left in place when -u is not given' '
 	test_path_is_file untracked
 '
 
+test_expect_success 'stash without verb with pathspec' '
+	>"foo bar" &&
+	>foo &&
+	>bar &&
+	git add foo* &&
+	git stash -- "foo b*" &&
+	test_path_is_missing "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar &&
+	git stash pop &&
+	test_path_is_file "foo bar" &&
+	test_path_is_file foo &&
+	test_path_is_file bar
+'
+
 test_done
-- 
2.11.0.301.g86e6ecc671.dirty

