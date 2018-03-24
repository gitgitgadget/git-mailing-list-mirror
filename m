Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C6301F42D
	for <e@80x24.org>; Sat, 24 Mar 2018 07:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752065AbeCXHpw (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 03:45:52 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38419 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeCXHps (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 03:45:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id u3-v6so483196lff.5
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 00:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sABkAFw3VRvZCZap0IoEBe6X4SAhtHN+RHLafJuy8s=;
        b=kMUCFsV5rOnHRD2MJTVX0eydaXSzx647d5lgzOWorgtkxngX7HyR1gFkzASIRCuVKB
         O+SEQyr2GptC+tvgtsl7TgE3S5cW83T3TL62WvKgA6NpCUKXUlCeBoNWkNZbX8C3IkrV
         +iKYwLgpgRyAnLy6yU4cbAvw7qoSW7GsQhUKt8UzNgsUtDwkWTdrp3ipJb+NplWzjDXO
         K2wuHGTi2R7ycA7rB/zaDfGh61sqLeXPWjOn3l+A93KLVKAybhMutbsSk/u8/+ZbQS5O
         vJHITOp1L52KqT1v4uPK+OHsD5QHtLd8VlfKRFQYLqNzMu61P0TYLfAPNz0MhFKG6x39
         zmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sABkAFw3VRvZCZap0IoEBe6X4SAhtHN+RHLafJuy8s=;
        b=R0h84u17kUv/IbjG9HswLfCwQiJWmjz5t9AeW9F42BGYLxvZz3gJ9xFWd/zSfdBjF8
         QHSRAfoLh8+t5NOmR7IXeb0TWZJxFI2/QTKtIgRbwepirjBsu/MrpiU0Ddg60vH6yF1M
         ZNQSDXMCO66c8sNElM0q0Tnyne+t+TKBTWGuM5fiw7c8hq736FhBUl0zlABeDq3lNDOa
         aVEA5XNkv1gRieFj7Fs9wQovbcwCGEudai71F6ZU+Zid8JpEet7wPrJm5apU724Iz+xp
         NCxyeb/pFRTeFBCbeuGHuLyyZV9gnAU4jby1XUyd6VIXoRKqqhxnZMELhf0k2q5Iim6Y
         5pfg==
X-Gm-Message-State: AElRT7HSXGbjdtvtE59bTM7Yhv2vRtcbM1R3PIZCeNOIC8efZsOLAS+F
        moLq7oBsWxOhCoRkwvysLuw=
X-Google-Smtp-Source: AG47ELvcaG6gTdKtmQS9BY3A6kYzRw2Cer5j44qUiRJu8U69x+glhoziBd1knPTQ5IQrBeetj2bhZw==
X-Received: by 10.46.111.8 with SMTP id k8mr10260968ljc.112.1521877546394;
        Sat, 24 Mar 2018 00:45:46 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g7sm2313741ljj.50.2018.03.24.00.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 00:45:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/36] t/helper: merge test-genrandom into test-tool
Date:   Sat, 24 Mar 2018 08:44:42 +0100
Message-Id: <20180324074505.19100-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180324074505.19100-1-pclouds@gmail.com>
References: <20180317075421.22032-1-pclouds@gmail.com>
 <20180324074505.19100-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Makefile                              |  2 +-
 t/helper/test-genrandom.c             |  3 ++-
 t/helper/test-tool.c                  |  1 +
 t/helper/test-tool.h                  |  1 +
 t/t0005-signals.sh                    |  2 +-
 t/t0021-conversion.sh                 |  4 ++--
 t/t1006-cat-file.sh                   |  2 +-
 t/t1050-large.sh                      |  6 +++---
 t/t5000-tar-tree.sh                   |  2 +-
 t/t5300-pack-object.sh                |  4 ++--
 t/t5301-sliding-window.sh             |  2 +-
 t/t5302-pack-index.sh                 | 14 +++++++-------
 t/t5303-pack-corruption-resilience.sh | 10 +++++-----
 t/t5310-pack-bitmaps.sh               |  2 +-
 t/t5313-pack-bounds-checks.sh         |  4 ++--
 t/t5314-pack-cycle-detection.sh       |  2 +-
 t/t5316-pack-delta-depth.sh           |  2 +-
 t/t5546-receive-limits.sh             |  2 +-
 t/t5547-push-quarantine.sh            |  2 +-
 t/t5608-clone-2gb.sh                  |  2 +-
 t/t9300-fast-import.sh                |  2 +-
 t/t9802-git-p4-filetype.sh            |  2 +-
 22 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/Makefile b/Makefile
index 895b170fe3..d0bc6cfecf 100644
--- a/Makefile
+++ b/Makefile
@@ -661,13 +661,13 @@ TEST_BUILTINS_OBJS += test-drop-caches.o
 TEST_BUILTINS_OBJS += test-dump-cache-tree.o
 TEST_BUILTINS_OBJS += test-dump-split-index.o
 TEST_BUILTINS_OBJS += test-example-decorate.o
+TEST_BUILTINS_OBJS += test-genrandom.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
 TEST_BUILTINS_OBJS += test-sha1.o
 
 TEST_PROGRAMS_NEED_X += test-dump-fsmonitor
 TEST_PROGRAMS_NEED_X += test-dump-untracked-cache
 TEST_PROGRAMS_NEED_X += test-fake-ssh
-TEST_PROGRAMS_NEED_X += test-genrandom
 TEST_PROGRAMS_NEED_X += test-hashmap
 TEST_PROGRAMS_NEED_X += test-index-version
 TEST_PROGRAMS_NEED_X += test-line-buffer
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 8d11d22d98..99b8dc1e2d 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -4,9 +4,10 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
+#include "test-tool.h"
 #include "git-compat-util.h"
 
-int cmd_main(int argc, const char **argv)
+int cmd__genrandom(int argc, const char **argv)
 {
 	unsigned long count, next = 0;
 	unsigned char *c;
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index a0e95c13ed..eb20b7d8fe 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -16,6 +16,7 @@ static struct test_cmd cmds[] = {
 	{ "dump-cache-tree", cmd__dump_cache_tree },
 	{ "dump-split-index", cmd__dump_split_index },
 	{ "example-decorate", cmd__example_decorate },
+	{ "genrandom", cmd__genrandom },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
 	{ "sha1", cmd__sha1 },
 };
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 721a1e1b09..f7ec6ae0c3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -10,6 +10,7 @@ int cmd__drop_caches(int argc, const char **argv);
 int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
+int cmd__genrandom(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
 int cmd__sha1(int argc, const char **argv);
 
diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index 46042f1f13..c16947cf5d 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -36,7 +36,7 @@ large_git () {
 }
 
 test_expect_success 'create blob' '
-	test-genrandom foo 16384 >file &&
+	test-tool genrandom foo 16384 >file &&
 	git add file
 '
 
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 46f8e583c3..9479a4aaab 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -19,7 +19,7 @@ write_script rot13-filter.pl "$PERL_PATH" \
 generate_random_characters () {
 	LEN=$1
 	NAME=$2
-	test-genrandom some-seed $LEN |
+	test-tool genrandom some-seed $LEN |
 		perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
 }
 
@@ -267,7 +267,7 @@ test_expect_success 'filtering large input to small output should use little mem
 '
 
 test_expect_success 'filter that does not read is fine' '
-	test-genrandom foo $((128 * 1024 + 1)) >big &&
+	test-tool genrandom foo $((128 * 1024 + 1)) >big &&
 	echo "big filter=epipe" >.gitattributes &&
 	test_config filter.epipe.clean "echo xyzzy" &&
 	git add big &&
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index b19f332694..2ac3b940c6 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -282,7 +282,7 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
 '
 
 test_expect_success 'setup blobs which are likely to delta' '
-	test-genrandom foo 10240 >foo &&
+	test-tool genrandom foo 10240 >foo &&
 	{ cat foo; echo plus; } >foo-plus &&
 	git add foo foo-plus &&
 	git commit -m foo &&
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 6fd264cff0..f9eb143f43 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -103,9 +103,9 @@ test_expect_success 'packsize limit' '
 		# mid1 and mid2 will fit within 256k limit but
 		# appending mid3 will bust the limit and will
 		# result in a separate packfile.
-		test-genrandom "a" $(( 66 * 1024 )) >mid1 &&
-		test-genrandom "b" $(( 80 * 1024 )) >mid2 &&
-		test-genrandom "c" $(( 128 * 1024 )) >mid3 &&
+		test-tool genrandom "a" $(( 66 * 1024 )) >mid1 &&
+		test-tool genrandom "b" $(( 80 * 1024 )) >mid2 &&
+		test-tool genrandom "c" $(( 128 * 1024 )) >mid3 &&
 		git add mid1 mid2 mid3 &&
 
 		count=0
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 266d052efb..af4d9b8876 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -101,7 +101,7 @@ test_expect_success \
      ten=0123456789 && hundred=$ten$ten$ten$ten$ten$ten$ten$ten$ten$ten &&
      echo long filename >a/four$hundred &&
      mkdir a/bin &&
-     test-genrandom "frotz" 500000 >a/bin/sh &&
+     test-tool genrandom "frotz" 500000 >a/bin/sh &&
      printf "A\$Format:%s\$O" "$SUBSTFORMAT" >a/substfile1 &&
      printf "A not substituted O" >a/substfile2 &&
      if test_have_prereq SYMLINKS; then
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9c68b99251..3bac1f20e0 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -16,8 +16,8 @@ test_expect_success \
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
-     test-genrandom "seed a" 2097152 > a_big &&
-     test-genrandom "seed b" 2097152 > b_big &&
+     test-tool genrandom "seed a" 2097152 > a_big &&
+     test-tool genrandom "seed b" 2097152 > b_big &&
      git update-index --add a a_big b b_big c &&
      cat c >d && echo foo >>d && git update-index --add d &&
      tree=$(git write-tree) &&
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index cae8c2e882..8132642163 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -12,7 +12,7 @@ test_expect_success \
      for i in a b c
      do
          echo $i >$i &&
-         test-genrandom "$i" 32768 >>$i &&
+         test-tool genrandom "$i" 32768 >>$i &&
          git update-index --add $i || return 1
      done &&
      echo d >d && cat c >>d && git update-index --add d &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index d695a6082e..7a62947f74 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -15,17 +15,17 @@ test_expect_success \
      while test $i -le 100
      do
          iii=$(printf '%03i' $i)
-         test-genrandom "bar" 200 > wide_delta_$iii &&
-         test-genrandom "baz $iii" 50 >> wide_delta_$iii &&
-         test-genrandom "foo"$i 100 > deep_delta_$iii &&
-         test-genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
-         test-genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
+         test-tool genrandom "bar" 200 > wide_delta_$iii &&
+         test-tool genrandom "baz $iii" 50 >> wide_delta_$iii &&
+         test-tool genrandom "foo"$i 100 > deep_delta_$iii &&
+         test-tool genrandom "foo"$(expr $i + 1) 100 >> deep_delta_$iii &&
+         test-tool genrandom "foo"$(expr $i + 2) 100 >> deep_delta_$iii &&
          echo $iii >file_$iii &&
-         test-genrandom "$iii" 8192 >>file_$iii &&
+         test-tool genrandom "$iii" 8192 >>file_$iii &&
          git update-index --add file_$iii deep_delta_$iii wide_delta_$iii &&
          i=$(expr $i + 1) || return 1
      done &&
-     { echo 101 && test-genrandom 100 8192; } >file_101 &&
+     { echo 101 && test-tool genrandom 100 8192; } >file_101 &&
      git update-index --add file_101 &&
      tree=$(git write-tree) &&
      commit=$(git commit-tree $tree </dev/null) && {
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5940ce2084..3634e258f8 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -19,14 +19,14 @@ test_description='resilience to pack corruptions with redundant objects'
 # 3) object header is always 2 bytes.
 
 create_test_files() {
-    test-genrandom "foo" 2000 > file_1 &&
-    test-genrandom "foo" 1800 > file_2 &&
-    test-genrandom "foo" 1800 > file_3 &&
+    test-tool genrandom "foo" 2000 > file_1 &&
+    test-tool genrandom "foo" 1800 > file_2 &&
+    test-tool genrandom "foo" 1800 > file_3 &&
     echo " base " >> file_1 &&
     echo " delta1 " >> file_2 &&
     echo " delta delta2 " >> file_3 &&
-    test-genrandom "bar" 150 >> file_2 &&
-    test-genrandom "baz" 100 >> file_3
+    test-tool genrandom "bar" 150 >> file_2 &&
+    test-tool genrandom "baz" 100 >> file_3
 }
 
 create_new_pack() {
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 20e2473a03..f6d600fd82 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -284,7 +284,7 @@ test_expect_success JGIT 'jgit can read our bitmaps' '
 '
 
 test_expect_success 'splitting packs does not generate bogus bitmaps' '
-	test-genrandom foo $((1024 * 1024)) >rand &&
+	test-tool genrandom foo $((1024 * 1024)) >rand &&
 	git add rand &&
 	git commit -m "commit with big file" &&
 	git -c pack.packSizeLimit=500k repack -adb &&
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 9372508c99..4fe4ad9d61 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -163,8 +163,8 @@ test_expect_success 'bogus offset inside v2 extended table' '
 
 test_expect_success 'bogus OFS_DELTA in packfile' '
 	# Generate a pack with a delta in it.
-	base=$(test-genrandom foo 3000 | git hash-object --stdin -w) &&
-	delta=$(test-genrandom foo 2000 | git hash-object --stdin -w) &&
+	base=$(test-tool genrandom foo 3000 | git hash-object --stdin -w) &&
+	delta=$(test-tool genrandom foo 2000 | git hash-object --stdin -w) &&
 	do_pack "$base $delta" --delta-base-offset &&
 	rm -f .git/objects/??/* &&
 
diff --git a/t/t5314-pack-cycle-detection.sh b/t/t5314-pack-cycle-detection.sh
index f7dbdfb412..f31995d3d2 100755
--- a/t/t5314-pack-cycle-detection.sh
+++ b/t/t5314-pack-cycle-detection.sh
@@ -73,7 +73,7 @@ make_pack () {
 }
 
 test_expect_success 'setup' '
-	test-genrandom base 4096 >base &&
+	test-tool genrandom base 4096 >base &&
 	for i in one two
 	do
 		# we want shared content here to encourage deltas...
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 2ed479b712..0f06c40eb1 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -47,7 +47,7 @@ test_description='pack-objects breaks long cross-pack delta chains'
 # repeatedly-modified file to generate the delta chain).
 
 test_expect_success 'create series of packs' '
-	test-genrandom foo 4096 >content &&
+	test-tool genrandom foo 4096 >content &&
 	prev= &&
 	for i in $(test_seq 1 10)
 	do
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 10cb0be2b7..0b0e987fdb 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -44,7 +44,7 @@ test_pack_input_limit () {
 }
 
 test_expect_success "create known-size (1024 bytes) commit" '
-	test-genrandom foo 1024 >one-k &&
+	test-tool genrandom foo 1024 >one-k &&
 	git add one-k &&
 	test_commit one-k
 '
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 113c87007f..faaa51ccc5 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -39,7 +39,7 @@ test_expect_success 'push to repo path with path separator (colon)' '
 	# so make it likely for us to generate a delta by having
 	# a non-trivial file with multiple versions.
 
-	test-genrandom foo 4096 >file.bin &&
+	test-tool genrandom foo 4096 >file.bin &&
 	git add file.bin &&
 	git commit -m bin &&
 
diff --git a/t/t5608-clone-2gb.sh b/t/t5608-clone-2gb.sh
index 191d6d3a78..df822d9a3e 100755
--- a/t/t5608-clone-2gb.sh
+++ b/t/t5608-clone-2gb.sh
@@ -21,7 +21,7 @@ test_expect_success CLONE_2GB 'setup' '
 	 do
 		printf "Generating blob $i/$blobcount\r" >&2 &&
 		printf "blob\nmark :$i\ndata $blobsize\n" &&
-		#test-genrandom $i $blobsize &&
+		#test-tool genrandom $i $blobsize &&
 		printf "%-${blobsize}s" $i &&
 		echo "M 100644 :$i $i" >> commit
 		i=$(($i+1)) ||
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e4d06accc4..dc79df7b04 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -2654,7 +2654,7 @@ test_expect_success 'R: corrupt lines do not mess marks file' '
 ##
 test_expect_success 'R: blob bigger than threshold' '
 	blobsize=$((2*1024*1024 + 53)) &&
-	test-genrandom bar $blobsize >expect &&
+	test-tool genrandom bar $blobsize >expect &&
 	cat >input <<-INPUT_END &&
 	commit refs/heads/big-file
 	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
diff --git a/t/t9802-git-p4-filetype.sh b/t/t9802-git-p4-filetype.sh
index eb9a8ed197..1fc9b33aeb 100755
--- a/t/t9802-git-p4-filetype.sh
+++ b/t/t9802-git-p4-filetype.sh
@@ -237,7 +237,7 @@ test_expect_success 'ignore apple' '
 	build_gendouble &&
 	(
 		cd "$cli" &&
-		test-genrandom apple 1024 >double.png &&
+		test-tool genrandom apple 1024 >double.png &&
 		"$PYTHON_PATH" "$TRASH_DIRECTORY/gendouble.py" >%double.png &&
 		p4 add -t apple double.png &&
 		p4 submit -d appledouble
-- 
2.17.0.rc0.348.gd5a49e0b6f

