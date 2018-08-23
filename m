Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 731551F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbeHWSzV (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:55:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36562 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHWSzV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:55:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id j192-v6so5968929wmj.1
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=sMGftxlcVqSf9Pklr+Nz7wrsHqyw+oMsDtSX9hlLvEXzc9xp+JMbMAWx4nyd++gkgc
         myGpNR09g8cLZ5/Xaers4/tsgVCnOFogHYkSdMTnrlkdTfSp9o1JcOi54RUArzt7BwQ7
         eBLq7IkYSoMXWVlLNDzu1U+/2OxHt5OSglzzPJt4PgqWgsUUqdqDK5ptgm3S7IYthSsr
         X55V6uwFPu5KPQBwEJGR7alW/NsHAI2FYaXc+i4RlwfxeM3qsxfgJUPv6OMZygZKzxfY
         w7/3U0P+04OGRCJ9jBfQKSgl8Kc9u2cAzFwFzH92YnhXp7PyeTDJJKc0+SgJNvw/LVAL
         6ZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjlYSJV6SEdnyWwriONhpEYg9dO/ThAdQz/nAcK3wWw=;
        b=ZW7Wot1SZre9UjUMP/WuSToJQNHzBtVd1gJPObYbB1aBUz3f2u1y6WMXSufGtCzpLu
         TbH+0L4nR23BnXf4Ss/Chy6Af+wBAoW/MEyM8dRyVCv7FAPQcHc08rDQJHYYWJ34q4Vl
         E5ixPPifO97TzmyPyvPHUrJdZx4QSjCa+34YsPN7dCErZ8jBZvfacpHHFLLW/ys74beZ
         eOdODUaji77y0CyjmNApU1soSYsDdYEoA4u2dAFuO6wJQaSIS3T07jDuOWAZS/8PYcyM
         VqIDij7JHvccW2eFUtkQ1A0m8NP3nQzRAQ0KV3QEyXLrZXd8IHmTEj61cO2bRf8mwyNb
         vlew==
X-Gm-Message-State: APzg51AhSP9HuBo4D2/4TuNQgwK7BxCZeuAZgzAUEdtMi7KXGeGL2H8U
        bsw/Zvwejql/7s2mN+X4rpkgs2Op6zI=
X-Google-Smtp-Source: ANB0VdbFNyWxGYKX529Ez8xGnLKOxn0XTYBGu2Wi4uDAyMyo/e3KugWOiJzXntn422bh8HeHu7BLZQ==
X-Received: by 2002:a1c:3a8f:: with SMTP id h137-v6mr5931406wma.41.1535037911120;
        Thu, 23 Aug 2018 08:25:11 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id u40-v6sm6391208wrc.43.2018.08.23.08.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 08:25:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] tests: fix and add lint for non-portable head -c N
Date:   Thu, 23 Aug 2018 15:25:01 +0000
Message-Id: <20180823152502.3886-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180823091427.1756-1-avarab@gmail.com>
References: <20180823091427.1756-1-avarab@gmail.com>
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

