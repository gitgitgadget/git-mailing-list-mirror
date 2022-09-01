Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5113AECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIAAai (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiIAAaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:21 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC58B2C7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id i188-20020a1c3bc5000000b003a7b6ae4eb2so443786wma.4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=6vHtuz5wCziYtfU5pjHHqiPxIhRGBAGTH4/xxkFWUSg=;
        b=DN2xPkAAmEJB8b4zul7SmoxyGgj31fjBK2Z2ZaMEhWU+jSyPzbJWIl5SQTDpcHkLnB
         RbnP7gMetYTtR/kAMHN3Py4hLLXBWsasYI80Nqy6siVs8F9I2Rnxoxl2AsyqG+2J9iUg
         VL0P6M/iZPKp+9sMjB+VRobOPxEaFdR1isXQpntzY3WMMbEYqqSLBohvTKQAsaxh7UbI
         rrm9h89WgfPSZEy+8MWE9BQfN+7pZA962FvEdedIn6ApmYEglScOfy5+Ksr+ZbIn++Rm
         RQWDzXFmyNUdoXNywvMzmxmXqCo1+xTxdwVNth5jQCOeLozhrputo522eE2AnbKnKnIG
         Espw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=6vHtuz5wCziYtfU5pjHHqiPxIhRGBAGTH4/xxkFWUSg=;
        b=zNWjE1M/+ZX1jdLwEtHUqtKBaLeaGWl6jm0WQagIwMasyLfOg3UqcI/LBgBw/zmh7A
         8LX94wDezhS8wvdsvgHQKZDF7Bpkku/RiDFVSqSYufHsJDEfXVxk0z5uLZ1h57Ecth1H
         7/HaVpZjgZIekEafV5+xHl0KrXVwkbyjJan5S+FrBp+Yuz5C6VzlHet+Ovg/oUEe8mpa
         QFbf+m1bVy+n7J0jdRjFD1+0gPOVjZutq+Llhs2Z/dgvsYEqEW7pdLNAryiuNA/x4odg
         rpiqw1lTw4Ig+7dwPrnYbP2T+Gc5omqyKOW+ESGSn+VRYdhQAHnQmWSGeAlPM+aj6O40
         FZzA==
X-Gm-Message-State: ACgBeo01rKPVUj+biYWI4yIfJjCN4BMMCgT7H2yJdx9PUekIESgcv3bs
        it8v8MDGF8jtFsT4vomvWs9ibqLC+lY=
X-Google-Smtp-Source: AA6agR6cfDlRqCSIOgco1gEcPYqdzgL14w8A6Cg+QBN0DWiDgNi7XV1T36gINMuJLOWUySKm5HJW9w==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id be13-20020a05600c1e8d00b003a5e37f6fd2mr3414343wmb.33.1661992212914;
        Wed, 31 Aug 2022 17:30:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm3749243wmb.3.2022.08.31.17.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:12 -0700 (PDT)
Message-Id: <1049172aaca8e13f64201dc0ebf04ba5c655c0ce.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:50 +0000
Subject: [PATCH 12/18] chainlint.pl: complain about loops lacking explicit
 failure handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Shell `for` and `while` loops do not terminate automatically just
because a command fails within the loop body. Instead, the loop
continues to iterate and eventually returns the exit status of the final
command of the final iteration, which may not be the command which
failed, thus it is possible for failures to go undetected. Consequently,
it is important for test authors to explicitly handle failure within the
loop body by terminating the loop manually upon failure. This can be
done by returning a non-zero exit code from within the loop body
(i.e. `|| return 1`) or exiting (i.e. `|| exit 1`) if the loop is within
a subshell, or by manually checking `$?` and taking some appropriate
action. Therefore, add logic to detect and complain about loops which
lack explicit `return` or `exit`, or `$?` check.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                                | 11 ++++++
 t/chainlint/complex-if-in-cuddled-loop.expect |  2 +-
 t/chainlint/for-loop.expect                   |  4 +--
 t/chainlint/loop-detect-failure.expect        | 15 ++++++++
 t/chainlint/loop-detect-failure.test          | 17 +++++++++
 t/chainlint/loop-detect-status.expect         | 18 ++++++++++
 t/chainlint/loop-detect-status.test           | 19 ++++++++++
 t/chainlint/loop-in-if.expect                 |  2 +-
 t/chainlint/nested-loop-detect-failure.expect | 31 ++++++++++++++++
 t/chainlint/nested-loop-detect-failure.test   | 35 +++++++++++++++++++
 t/chainlint/semicolon.expect                  |  2 +-
 t/chainlint/while-loop.expect                 |  4 +--
 12 files changed, 153 insertions(+), 7 deletions(-)
 create mode 100644 t/chainlint/loop-detect-failure.expect
 create mode 100644 t/chainlint/loop-detect-failure.test
 create mode 100644 t/chainlint/loop-detect-status.expect
 create mode 100644 t/chainlint/loop-detect-status.test
 create mode 100644 t/chainlint/nested-loop-detect-failure.expect
 create mode 100644 t/chainlint/nested-loop-detect-failure.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index a76a09ecf5e..674b3ddf696 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -482,6 +482,17 @@ sub match_ending {
 	return undef;
 }
 
+sub parse_loop_body {
+	my $self = shift @_;
+	my @tokens = $self->SUPER::parse_loop_body(@_);
+	# did loop signal failure via "|| return" or "|| exit"?
+	return @tokens if !@tokens || grep(/^(?:return|exit|\$\?)$/, @tokens);
+	# flag missing "return/exit" handling explicit failure in loop body
+	my $n = find_non_nl(\@tokens);
+	splice(@tokens, $n + 1, 0, '?!LOOP?!');
+	return @tokens;
+}
+
 my @safe_endings = (
 	[qr/^(?:&&|\|\||\||&)$/],
 	[qr/^(?:exit|return)$/, qr/^(?:\d+|\$\?)$/],
diff --git a/t/chainlint/complex-if-in-cuddled-loop.expect b/t/chainlint/complex-if-in-cuddled-loop.expect
index 2fca1834095..dac2d0fd1d9 100644
--- a/t/chainlint/complex-if-in-cuddled-loop.expect
+++ b/t/chainlint/complex-if-in-cuddled-loop.expect
@@ -4,6 +4,6 @@
      :
    else
      echo >file
-   fi
+   fi ?!LOOP?!
  done) &&
 test ! -f file
diff --git a/t/chainlint/for-loop.expect b/t/chainlint/for-loop.expect
index 6671b8cd842..a5810c9bddd 100644
--- a/t/chainlint/for-loop.expect
+++ b/t/chainlint/for-loop.expect
@@ -2,10 +2,10 @@
 	for i in a b c
 	do
 		echo $i ?!AMP?!
-		cat <<-EOF
+		cat <<-EOF ?!LOOP?!
 	done ?!AMP?!
 	for i in a b c; do
 		echo $i &&
-		cat $i
+		cat $i ?!LOOP?!
 	done
 )
diff --git a/t/chainlint/loop-detect-failure.expect b/t/chainlint/loop-detect-failure.expect
new file mode 100644
index 00000000000..a66025c39d4
--- /dev/null
+++ b/t/chainlint/loop-detect-failure.expect
@@ -0,0 +1,15 @@
+git init r1 &&
+for n in 1 2 3 4 5
+do
+	echo "This is file: $n" > r1/file.$n &&
+	git -C r1 add file.$n &&
+	git -C r1 commit -m "$n" || return 1
+done &&
+
+git init r2 &&
+for n in 1000 10000
+do
+	printf "%"$n"s" X > r2/large.$n &&
+	git -C r2 add large.$n &&
+	git -C r2 commit -m "$n" ?!LOOP?!
+done
diff --git a/t/chainlint/loop-detect-failure.test b/t/chainlint/loop-detect-failure.test
new file mode 100644
index 00000000000..b9791cc802e
--- /dev/null
+++ b/t/chainlint/loop-detect-failure.test
@@ -0,0 +1,17 @@
+git init r1 &&
+# LINT: loop handles failure explicitly with "|| return 1"
+for n in 1 2 3 4 5
+do
+	echo "This is file: $n" > r1/file.$n &&
+	git -C r1 add file.$n &&
+	git -C r1 commit -m "$n" || return 1
+done &&
+
+git init r2 &&
+# LINT: loop fails to handle failure explicitly with "|| return 1"
+for n in 1000 10000
+do
+	printf "%"$n"s" X > r2/large.$n &&
+	git -C r2 add large.$n &&
+	git -C r2 commit -m "$n"
+done
diff --git a/t/chainlint/loop-detect-status.expect b/t/chainlint/loop-detect-status.expect
new file mode 100644
index 00000000000..0ad23bb35e4
--- /dev/null
+++ b/t/chainlint/loop-detect-status.expect
@@ -0,0 +1,18 @@
+( while test $i -le $blobcount
+do
+	printf "Generating blob $i/$blobcount\r" >& 2 &&
+	printf "blob\nmark :$i\ndata $blobsize\n" &&
+
+	printf "%-${blobsize}s" $i &&
+	echo "M 100644 :$i $i" >> commit &&
+	i=$(($i+1)) ||
+	echo $? > exit-status
+done &&
+echo "commit refs/heads/main" &&
+echo "author A U Thor <author@email.com> 123456789 +0000" &&
+echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+echo "data 5" &&
+echo ">2gb" &&
+cat commit ) |
+git fast-import --big-file-threshold=2 &&
+test ! -f exit-status
diff --git a/t/chainlint/loop-detect-status.test b/t/chainlint/loop-detect-status.test
new file mode 100644
index 00000000000..1c6c23cfc9e
--- /dev/null
+++ b/t/chainlint/loop-detect-status.test
@@ -0,0 +1,19 @@
+# LINT: "$?" handled explicitly within loop body
+(while test $i -le $blobcount
+ do
+	printf "Generating blob $i/$blobcount\r" >&2 &&
+	printf "blob\nmark :$i\ndata $blobsize\n" &&
+	#test-tool genrandom $i $blobsize &&
+	printf "%-${blobsize}s" $i &&
+	echo "M 100644 :$i $i" >> commit &&
+	i=$(($i+1)) ||
+	echo $? > exit-status
+ done &&
+ echo "commit refs/heads/main" &&
+ echo "author A U Thor <author@email.com> 123456789 +0000" &&
+ echo "committer C O Mitter <committer@email.com> 123456789 +0000" &&
+ echo "data 5" &&
+ echo ">2gb" &&
+ cat commit) |
+git fast-import --big-file-threshold=2 &&
+test ! -f exit-status
diff --git a/t/chainlint/loop-in-if.expect b/t/chainlint/loop-in-if.expect
index e1be42376c5..6c5d6e5b243 100644
--- a/t/chainlint/loop-in-if.expect
+++ b/t/chainlint/loop-in-if.expect
@@ -4,7 +4,7 @@
 		while true
 		do
 			echo "pop" ?!AMP?!
-			echo "glup"
+			echo "glup" ?!LOOP?!
 		done ?!AMP?!
 		foo
 	fi ?!AMP?!
diff --git a/t/chainlint/nested-loop-detect-failure.expect b/t/chainlint/nested-loop-detect-failure.expect
new file mode 100644
index 00000000000..4793a0e8e12
--- /dev/null
+++ b/t/chainlint/nested-loop-detect-failure.expect
@@ -0,0 +1,31 @@
+for i in 0 1 2 3 4 5 6 7 8 9 ;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	do
+		echo "$i$j" > "path$i$j" ?!LOOP?!
+	done ?!LOOP?!
+done &&
+
+for i in 0 1 2 3 4 5 6 7 8 9 ;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	do
+		echo "$i$j" > "path$i$j" || return 1
+	done
+done &&
+
+for i in 0 1 2 3 4 5 6 7 8 9 ;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	do
+		echo "$i$j" > "path$i$j" ?!LOOP?!
+	done || return 1
+done &&
+
+for i in 0 1 2 3 4 5 6 7 8 9 ;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9 ;
+	do
+		echo "$i$j" > "path$i$j" || return 1
+	done || return 1
+done
diff --git a/t/chainlint/nested-loop-detect-failure.test b/t/chainlint/nested-loop-detect-failure.test
new file mode 100644
index 00000000000..e6f0c1acfb8
--- /dev/null
+++ b/t/chainlint/nested-loop-detect-failure.test
@@ -0,0 +1,35 @@
+# LINT: neither loop handles failure explicitly with "|| return 1"
+for i in 0 1 2 3 4 5 6 7 8 9;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9;
+	do
+		echo "$i$j" >"path$i$j"
+	done
+done &&
+
+# LINT: inner loop handles failure explicitly with "|| return 1"
+for i in 0 1 2 3 4 5 6 7 8 9;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9;
+	do
+		echo "$i$j" >"path$i$j" || return 1
+	done
+done &&
+
+# LINT: outer loop handles failure explicitly with "|| return 1"
+for i in 0 1 2 3 4 5 6 7 8 9;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9;
+	do
+		echo "$i$j" >"path$i$j"
+	done || return 1
+done &&
+
+# LINT: inner & outer loops handles failure explicitly with "|| return 1"
+for i in 0 1 2 3 4 5 6 7 8 9;
+do
+	for j in 0 1 2 3 4 5 6 7 8 9;
+	do
+		echo "$i$j" >"path$i$j" || return 1
+	done || return 1
+done
diff --git a/t/chainlint/semicolon.expect b/t/chainlint/semicolon.expect
index ed0b3707ae9..3aa2259f36c 100644
--- a/t/chainlint/semicolon.expect
+++ b/t/chainlint/semicolon.expect
@@ -15,5 +15,5 @@
 ) &&
 (cd foo &&
 	for i in a b c; do
-		echo;
+		echo; ?!LOOP?!
 	done)
diff --git a/t/chainlint/while-loop.expect b/t/chainlint/while-loop.expect
index 0d3a9b3d128..f272aa21fee 100644
--- a/t/chainlint/while-loop.expect
+++ b/t/chainlint/while-loop.expect
@@ -2,10 +2,10 @@
 	while true
 	do
 		echo foo ?!AMP?!
-		cat <<-EOF
+		cat <<-EOF ?!LOOP?!
 	done ?!AMP?!
 	while true; do
 		echo foo &&
-		cat bar
+		cat bar ?!LOOP?!
 	done
 )
-- 
gitgitgadget

