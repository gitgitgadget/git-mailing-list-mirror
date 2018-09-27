Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F7411F453
	for <e@80x24.org>; Thu, 27 Sep 2018 01:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeI0HlS (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 03:41:18 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:44348 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeI0HlS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 03:41:18 -0400
Received: by mail-vs1-f74.google.com with SMTP id i25-v6so366008vso.11
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 18:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4M2AXJvgSC3+E19DesQWuQGaLX7D02c3LUmaQenKhy8=;
        b=LrHW1CX0RyVYVQbvwXT7sh5J76ebTChyRS3EKijFoWFRGYPg/D8Bcg60B/bj0dlb99
         wQock1HN1LIDbqaj9OvipoaIn0A9gHyaXvPTisOPFWlHTOquy/4tQ3jIhFP1x6zPKIRi
         ptqpP4fawWN78eNKdqYreJu4VT67cHYMHWPW8qOZn+UqSskSOTf6ElI5tSi8fjrfq5Qr
         7RJbQzJ/kjKVzbNpwchR7PTxYJHJTRgBDcYaspJjfjrgLHl3hnZg4umufciGmlBtpe+k
         /x9urfB09mTwMdYVG2b5fVgFRbVbr2z2OMxrhfXm9O0ym/rBqwEVfwBnu4xGxIhl1Dn5
         wq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4M2AXJvgSC3+E19DesQWuQGaLX7D02c3LUmaQenKhy8=;
        b=QocVyoW3HatqN/uf8JdaBTRNFL0ogFOJKV5b7MzrnDF9kmR7n/7BHCzmeDahxiy0vj
         +WkYaKBO98CnN1is7vGkL6x6cueiVOWiTcoSS7VOcs+cCMGsgm0RkxJAnJgqc5MBqYnp
         BtFxfa5QOMq8qkdHHzBvfjeMQRXwcIFnyC9RSCbNUejab3m3uhkpIdxr74YV8uj52hkK
         ZwPcz+BzYH1joW08oTFscaesLER3BIE1TeDn9D36t91Hdgb13SeUM4mGzJEgXdPjK2br
         XL1hdLJmQ21zuNOjFttHNIvuoaxL6JlejZbln6HnnkGQ6UI/y4g2h09Y9h3pxH6TlvCF
         Gv6A==
X-Gm-Message-State: ABuFfogMp+rFm5unuuZtV0Q56OuhOivQMmL7cFGh+C9QYd1LLvWI0aV4
        VijUC9ub1WJcMeIAjhHJ/MfVKYlC6G5VOwlXPr7I/sczNYHRwGugoBBdFT7ErfhuVxxJXGkxCUD
        s/KOMyynE7dJwbCTt/t9wJl15WYDboSBCGvg3kKhQns+5HPdvSs9uo7ASSUZ0HVM=
X-Google-Smtp-Source: ACcGV60mp5CxztkGDhBS3/2eWYSe2NRITW6QQdOxuAqPelmdXem3tCI2NQD92G7k2cIKPerndoSXGjivkv0H0A==
X-Received: by 2002:a1f:29d7:: with SMTP id p206-v6mr3493853vkp.22.1538011534735;
 Wed, 26 Sep 2018 18:25:34 -0700 (PDT)
Date:   Wed, 26 Sep 2018 18:24:52 -0700
In-Reply-To: <20180927012455.234876-1-steadmon@google.com>
Message-Id: <20180927012455.234876-2-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com> <20180927012455.234876-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 1/4] archive: follow test standards around assertions
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move assertions outside of the check_tar function so that all top-level
code is wrapped in a test_expect_* assertion.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t5000-tar-tree.sh | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 2a97b27b0a..c408e3a23d 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -62,11 +62,9 @@ check_tar() {
 	dir=$1
 	dir_with_prefix=$dir/$2
 
-	test_expect_success ' extract tar archive' '
-		(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile
-	'
+	(mkdir $dir && cd $dir && "$TAR" xf -) <$tarfile &&
 
-	test_expect_success TAR_NEEDS_PAX_FALLBACK ' interpret pax headers' '
+	if test_have_prereq TAR_NEEDS_PAX_FALLBACK ; then
 		(
 			cd $dir &&
 			for header in *.paxheader
@@ -82,16 +80,11 @@ check_tar() {
 				fi
 			done
 		)
-	'
+	fi &&
 
-	test_expect_success ' validate filenames' '
-		(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
-		test_cmp a.lst $listfile
-	'
-
-	test_expect_success ' validate file contents' '
-		diff -r a ${dir_with_prefix}a
-	'
+	(cd ${dir_with_prefix}a && find .) | sort >$listfile &&
+	test_cmp a.lst $listfile &&
+	diff -r a ${dir_with_prefix}a
 }
 
 test_expect_success \
@@ -143,19 +136,20 @@ test_expect_success \
     'git archive' \
     'git archive HEAD >b.tar'
 
-check_tar b
+test_expect_success 'extract archive' 'check_tar b'
 
 test_expect_success 'git archive --prefix=prefix/' '
 	git archive --prefix=prefix/ HEAD >with_prefix.tar
 '
 
-check_tar with_prefix prefix/
+test_expect_success 'extract with prefix' 'check_tar with_prefix prefix/'
 
 test_expect_success 'git-archive --prefix=olde-' '
 	git archive --prefix=olde- HEAD >with_olde-prefix.tar
 '
 
-check_tar with_olde-prefix olde-
+test_expect_success 'extract with olde- prefix' \
+	'check_tar with_olde-prefix olde-'
 
 test_expect_success 'git archive on large files' '
     test_config core.bigfilethreshold 1 &&
-- 
2.19.0.605.g01d371f741-goog

