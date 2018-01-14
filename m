Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 899AD1F406
	for <e@80x24.org>; Sun, 14 Jan 2018 10:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbeANKS5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 05:18:57 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:34172 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeANKS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 05:18:56 -0500
Received: by mail-pl0-f65.google.com with SMTP id d21so1752587pll.1
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 02:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMGANf+eQUOopHPJc5WEBMeisK0fiGt9c7pmgH2wzhI=;
        b=Ra0Z0PxESHYFiWB1+EsIzJK5TlF1m0Pf0iyqBlOumB9UMRxII9NfXwPuhqhKUlLnTd
         ORL4Jd/VBLnDsiN3ZGUmjlMUA8L+IY0x2D4UFjmwEJ/i+/C9kYZ6DqNTuj/rvl3F4NgA
         jPf749+7Jp8oHEPgG+YoetMkhdN0nKki2UKfKYxBgAridqZnzJGgHFoCI7QOxmgVCYjQ
         wIXTaOHUDzAqZ5GffgK2429L2YvxHiZktofryEDGMJt1zPP5hbnu8hPVI1osLhHjqVQ6
         D6jxdRrsIOAOO68Enh4CRSu96J3GhNp2M3a+KBbI/yz5Wb3651WUfjF3ZrIV9b/V+M6+
         CTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMGANf+eQUOopHPJc5WEBMeisK0fiGt9c7pmgH2wzhI=;
        b=mHzvd575gOuezWx/f33KYU489hx1GgpblWUoLjD5AlCh9MTMc3cJKb6W+IBBINHEuy
         pUYbwFRPgOvzTFMrio6SFNSHKPfRyPJGmQ4gtnhiR5cNTz0z93V5JiyQ2khkYRvmGkVU
         hHcaC9n7td+aQmtSUAlFl14voyEtWe2b5Akw+2DA4uztUbEpe6mjXkTY4FB9RuvMMgX4
         BzG/RcucAzoZL2kS5HtShcy0kP1y5i98N4A4FKWzGX1FAzGTj3nwW04SsX9cm7wdsbFY
         I25NmR1ZkSzVXuNIGavz61OnmbWcimxYEZs1gX7krXB4OMUdnGITG0ptnEIPbM2L26Yj
         NQ7Q==
X-Gm-Message-State: AKGB3mJ5lmh53HJ7dkgs1ED80R5vScxZ2oihu1aVOXSFj4bn848YDu24
        0ZeTh5GbJozwPqr9C2/x6aafhw==
X-Google-Smtp-Source: ACJfBotJHcC6wvjCC8sBbabfCfG5FyaR1upcvT4So+G3u9jalyNH3Q5aj1X5RvMorwYGhhyQuniTVQ==
X-Received: by 10.84.133.198 with SMTP id f64mr31153148plf.266.1515925135956;
        Sun, 14 Jan 2018 02:18:55 -0800 (PST)
Received: from ash ([115.73.186.82])
        by smtp.gmail.com with ESMTPSA id i125sm50430746pfe.151.2018.01.14.02.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 02:18:55 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 14 Jan 2018 17:18:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, larsxschneider@gmail.com, bmwill@google.com,
        peff@peff.net, Junio C Hamano <gitster@pobox.com>,
        szeder.dev@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 3/3] read-cache: don't write index twice if we can't write shared index
Date:   Sun, 14 Jan 2018 17:18:20 +0700
Message-Id: <20180114101820.4273-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180114101820.4273-1-pclouds@gmail.com>
References: <CACsJy8A_moFProjfPAJFn2aP52w5qdYdOu4Ygox1qMMitNUHLg@mail.gmail.com>
 <20180114101820.4273-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a0a967568e ("update-index --split-index: do not split if $GIT_DIR is
read only", 2014-06-13), we tried to make sure we can still write an
index, even if the shared index can not be written.

We did so by just calling 'do_write_locked_index()' just before
'write_shared_index()'.  'do_write_locked_index()' always at least
closes the tempfile nowadays, and used to close or commit the lockfile
if COMMIT_LOCK or CLOSE_LOCK were given at the time this feature was
introduced.  COMMIT_LOCK or CLOSE_LOCK is passed in by most callers of
'write_locked_index()'.

After calling 'write_shared_index()', we call 'write_split_index()',
which calls 'do_write_locked_index()' again, which then tries to use the
closed lockfile again, but in fact fails to do so as it's already
closed. This eventually leads to a segfault.

Make sure to write the main index only once.

[nd: most of the commit message and investigation done by Thomas, I only
tweaked the solution a bit]

Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c           |  5 +++--
 t/t1700-split-index.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index c568643f55..c58c0a978a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2561,8 +2561,9 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		if (!temp) {
 			hashclr(si->base_sha1);
 			ret = do_write_locked_index(istate, lock, flags);
-		} else
-			ret = write_shared_index(istate, &temp);
+			goto out;
+		}
+		ret = write_shared_index(istate, &temp);
 
 		saved_errno = errno;
 		if (is_tempfile_active(temp))
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index af9b847761..5494389dbb 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -401,4 +401,23 @@ done <<\EOF
 0642 -rw-r---w-
 EOF
 
+test_expect_success POSIXPERM 'graceful handling splitting index is not allowed' '
+	test_create_repo ro &&
+	(
+		cd ro &&
+		test_commit initial &&
+		git update-index --split-index &&
+		test -f .git/sharedindex.*
+	) &&
+	test_when_finished "chmod -R u+w ro" &&
+	chmod -R u-w ro &&
+	cp ro/.git/index new-index &&
+	GIT_INDEX_FILE="$(pwd)/new-index" git -C ro update-index --split-index &&
+	chmod -R u+w ro &&
+	rm ro/.git/sharedindex.* &&
+	GIT_INDEX_FILE=new-index git ls-files >actual &&
+	echo initial.t >expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.15.1.600.g899a5f85c6

