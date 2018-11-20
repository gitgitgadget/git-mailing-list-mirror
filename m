Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB6581F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 16:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeKUC66 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 21:58:58 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38712 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKUC66 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 21:58:58 -0500
Received: by mail-lj1-f195.google.com with SMTP id c19-v6so2177611lja.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 08:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLempr1Dz99HbVrN9jxUgfcxHVfLVKWWd+qNPGHVE4k=;
        b=YdpEHmoZYo7pXKLxBFw5/1wuI+OO02o9s0XpJ9NdL8913R4e4yaeb0spJK2Y4T9V7C
         9MAnXu8qwnoy84uwbXrzFWGSSr+XwuHQXwed07zLnlx/M702nawvtsVjyuglkwQFG3oj
         7Fa2q4/dDGbEnRFZMgHqm0LtvUG/ycqm9Tx0lQDDon1a1WlolItXQgAJyad4X1rFuWG1
         tEM2F9N3v90kEtmH1gXWCcK6ZQNgrBilZRNd6bgtb1neVnGV0g6xprktb4ubXro3G9uQ
         dLB1d6nevcw/3Fl+bELbbRMxT2GzdhF9U9W2fdemSYRI3k+psYOQyCWwyI0CKgJe5jki
         fTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLempr1Dz99HbVrN9jxUgfcxHVfLVKWWd+qNPGHVE4k=;
        b=PggMlgXqZ7LjmlNYG23UeRDXz5DtqdApzTxp9LUCMlEDw9hk5s7dUsMaZWbOqkjuEX
         RJls2hsXuBQC7BcrtwC+msBmpAVUWaFuQQWSM/F3p5cBI1QMyaGtcZhht9zdrHhfQJFK
         Rib//4VrnrhvGKgo57rJET9ScPDVdhtWCEjJeG4lWVW52g/28vFn/xbET5MPdtAUtMZu
         FJEnFJ4Jrf/wuZM75k0mFaDxEvtHuMFh552pvl9on7inY1FivjD2X+j8w8o5WZiqB/UV
         reiJzBBA83LdKbgTWWPZxRFZSr4rfyKtDgPdYrkdgUnAjEDqJ2tqjnT3fkx+WWNTBY1M
         rpvA==
X-Gm-Message-State: AA+aEWZw0oH2FtC53zTb/9VcCpgcNqRPD5OSWCejhSln4CCP0nDemvmw
        Nx/kGqndt1wy8/o8BcKwvNo=
X-Google-Smtp-Source: AFSGD/UlAESw2ho/uJr1DIMnPWcqNYuGi+kKlNAQ1eI666ZVvaeIKq+kWXIx+sVI5ql9FqjEC3BzTw==
X-Received: by 2002:a2e:5816:: with SMTP id m22-v6mr1553562ljb.177.1542731337875;
        Tue, 20 Nov 2018 08:28:57 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id r29-v6sm5633228ljd.44.2018.11.20.08.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:28:57 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     gitster@pobox.com
Cc:     carenas@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        newren@gmail.com, pawelparuzel95@gmail.com, pclouds@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        tboegi@web.de, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] clone: fix colliding file detection on APFS
Date:   Tue, 20 Nov 2018 17:28:53 +0100
Message-Id: <20181120162853.22441-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com>
References: <xmqq36rwcwtu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit b878579ae7 (clone: report duplicate entries on case-insensitive
filesystems - 2018-08-17) adds a warning to user when cloning a repo
with case-sensitive file names on a case-insensitive file system. The
"find duplicate file" check was doing by comparing inode number (and
only fall back to fspathcmp() when inode is known to be unreliable
because fspathcmp() can't cover all case folding cases).

The inode check is very simple, and wrong. It compares between a
32-bit number (sd_ino) and potentially a 64-bit number (st_ino). When
an inode is larger than 2^32 (which seems to be the case for APFS), it
will be truncated and stored in sd_ino, but comparing with itself will
fail.

As a result, instead of showing a pair of files that have the same
name, we show just one file (marked before the beginning of the
loop). We fail to find the original one.

The fix could be just a simple type cast (*)

    dup->ce_stat_data.sd_ino == (unsigned int)st->st_ino

but this is no longer a reliable test, there are 4G possible inodes
that can match sd_ino because we only match the lower 32 bits instead
of full 64 bits.

There are two options to go. Either we ignore inode and go with
fspathcmp() on Apple platform. This means we can't do accurate inode
check on HFS anymore, or even on APFS when inode numbers are still
below 2^32.

Or we just to to reduce the odds of matching a wrong file by checking
more attributes, counting mostly on st_size because st_xtime is likely
the same. This patch goes with this direction, hoping that false
positive chances are too small to be seen in practice.

While at there, enable the test on Cygwin (verified working by Ramsay
Jones)

(*) this is also already done inside match_stat_data()

Reported-by: Carlo Arenas <carenas@gmail.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 So I'm going with match_stat_data(). But I don't know, perhaps just
 ignoring inode (like Carlo's original patch) is safer/better?

 Tested on case-insensitive JFS on Linux. But I don't think it really
 matters because I'm not even sure if I could push inode above 2^32
 with this. Hacking JFS for this test sounds fun, but no time for that.

 entry.c          | 4 ++--
 t/t5601-clone.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/entry.c b/entry.c
index 5d136c5d55..0a3c451f5f 100644
--- a/entry.c
+++ b/entry.c
@@ -404,7 +404,7 @@ static void mark_colliding_entries(const struct checkout *state,
 {
 	int i, trust_ino = check_stat;
 
-#if defined(GIT_WINDOWS_NATIVE)
+#if defined(GIT_WINDOWS_NATIVE) || defined(__CYGWIN__)
 	trust_ino = 0;
 #endif
 
@@ -419,7 +419,7 @@ static void mark_colliding_entries(const struct checkout *state,
 		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
 			continue;
 
-		if ((trust_ino && dup->ce_stat_data.sd_ino == st->st_ino) ||
+		if ((trust_ino && !match_stat_data(&dup->ce_stat_data, st)) ||
 		    (!trust_ino && !fspathcmp(ce->name, dup->name))) {
 			dup->ce_flags |= CE_MATCHED;
 			break;
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index f1a49e94f5..c28d51bd59 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -628,7 +628,7 @@ test_expect_success 'clone on case-insensitive fs' '
 	)
 '
 
-test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
+test_expect_success !MINGW,CASE_INSENSITIVE_FS 'colliding file detection' '
 	grep X icasefs/warning &&
 	grep x icasefs/warning &&
 	test_i18ngrep "the following paths have collided" icasefs/warning
-- 
2.19.1.1327.g328c130451.dirty

