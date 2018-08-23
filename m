Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8FB1F404
	for <e@80x24.org>; Thu, 23 Aug 2018 20:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeHXAHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:07:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45911 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeHXAHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:07:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so5668448wrb.12
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 13:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=DtMOcbK0xa2ijCb8s2hYOxWWt9GylhQNEHNli/P2ctZoNiruUv50tzHttZq/jZRUBG
         rULXHAoKES5CsG7wRvlNtYLbkCM4MhymkgWSoigA5zbo8EQcgdHMFht5oS+6+iRNmXyD
         CnB8UW+A8p6BquPhnDavmUCAFOvVifVPZrFojpt6dBuUFPB3s4yXRX7UN+qK5BDgFUWz
         eEa8SVqkpvELPoYHmu69J968fM7iSUk90tSiSEJieFpMKwpPR3t8tdXZb7Zur0/8nsx6
         WfKZiR7DWl3yUQP1E/9CKIBTNivPFKC+xwUxIocdqO+u9aNDfXmYVEMUnArHZ1omlJbG
         NHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=HsnT7MUUvfKUVEbRLQrezuy/6W3GTEUTdm2wfU6Wf2bvSGuGaM5gVcPV1X204Xtuux
         j3K0n7bOij159mRzhfNpy7s+ld05ujSsWAxbOAzBM5PVZLdqG7Nq25lXHlN/A2nwkzKh
         idxWEunWCRKlBKuJIYe64JCRNwjG62xVD/47l4+ydBSHIMcXL/MctREuBzSMRFZX3IC9
         Cv1j6XEwubGoa2JHbJnJGF7rearMxe9xoOgyaDs21CZBXZ4qqsvZ5KxJPpLawofdxVmR
         U8ZiJaByfFDwhfop7BUbZ9mJkZ4GkyTJXcWAfXFA7acldg002Y4x6v/SBAGZ7tRg9liu
         scug==
X-Gm-Message-State: APzg51AnqzAqbeukn51cjPN9Pq8oIUbOmkjffTeFidYlXaRS+ojjClwS
        AooRf+IULBKOdrcVm4QpBuLAdExkBaA=
X-Google-Smtp-Source: ANB0VdYcq/6A49Kv1aedFWVJZFgqQd1XR2kg7Ehfzyjmaxn/RiutG7RD4rvZqym5Rut/Yesf17g4Sw==
X-Received: by 2002:adf:ef51:: with SMTP id c17-v6mr13664419wrp.182.1535056584615;
        Thu, 23 Aug 2018 13:36:24 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q16-v6sm3641898wrn.41.2018.08.23.13.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 13:36:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] tests: fix and add lint for non-portable head -c N
Date:   Thu, 23 Aug 2018 20:36:00 +0000
Message-Id: <20180823203604.5564-2-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823152502.3886-2-avarab@gmail.com>
References: <20180823152502.3886-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "head -c BYTES" option is non-portable (not in POSIX[1]). Change
such invocations to use the test_copy_bytes wrapper added in
48860819e8 ("t9300: factor out portable "head -c" replacement",
2016-06-30).

This fixes a test added in 9d2e330b17 ("ewah_read_mmap: bounds-check
mmap reads", 2018-06-14), which has been breaking
t5310-pack-bitmaps.sh on OpenBSD since 2.18.0. The OpenBSD ports
already have a similar workaround after their upgrade to 2.18.0[2].

I have not tested this on IRIX, but according to 4de0bbd898 ("t9300:
use perl "head -c" clone in place of "dd bs=1 count=16000" kluge",
2010-12-13) this invocation would have broken things there too.

Also, change a valgrind-specific codepath in test-lib.sh to use this
wrapper. Given where valgrind runs I don't think this would ever
become a portability issue in practice, but it's easier to just use
the wrapper than introduce some exception for the "make test-lint"
check being added here.

1. http://pubs.opengroup.org/onlinepubs/9699919799/utilities/head.html
2. https://github.com/openbsd/ports/commit/08d5d82eaefe5cf2f125ecc0c6a57df9cf91350c#diff-f7d3c4fabeed1691620d608f1534f5e5

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 1 +
 t/t5310-pack-bitmaps.sh       | 2 +-
 t/test-lib.sh                 | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index d5823f71d8..c8f10d40a1 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -41,6 +41,7 @@ sub err {
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
+	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
 	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 557bd0d0c0..7bff7923f2 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -335,7 +335,7 @@ test_expect_success 'truncated bitmap fails gracefully' '
 	git rev-list --use-bitmap-index --count --all >expect &&
 	bitmap=$(ls .git/objects/pack/*.bitmap) &&
 	test_when_finished "rm -f $bitmap" &&
-	head -c 512 <$bitmap >$bitmap.tmp &&
+	test_copy_bytes 512 <$bitmap >$bitmap.tmp &&
 	mv -f $bitmap.tmp $bitmap &&
 	git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
 	test_cmp expect actual &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8bb0f4348e..44288cbb59 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -867,7 +867,7 @@ then
 		# handle only executables, unless they are shell libraries that
 		# need to be in the exec-path.
 		test -x "$1" ||
-		test "# " = "$(head -c 2 <"$1")" ||
+		test "# " = "$(test_copy_bytes 2 <"$1")" ||
 		return;
 
 		base=$(basename "$1")
@@ -882,7 +882,7 @@ then
 		# do not override scripts
 		if test -x "$symlink_target" &&
 		    test ! -d "$symlink_target" &&
-		    test "#!" != "$(head -c 2 < "$symlink_target")"
+		    test "#!" != "$(test_copy_bytes 2 <"$symlink_target")"
 		then
 			symlink_target=../valgrind.sh
 		fi
-- 
2.18.0.865.gffc8e1a3cd6

