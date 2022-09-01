Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0ABECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiIAAar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiIAAaW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:22 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F568E9AF
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:17 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso459446wma.2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=8nXOFB8iiBeRF/i/hK7RJVYSnBTXC+aXlO0UIqySsxM=;
        b=ZZUJaREAwrji8ocTDI6Ih0KUCSEnB129yiAoSXpTjBqUX+MKGnb3MeuRCzS6TxVyZp
         MsnCemIBAxAEPGo9KRkvim6reDNL8PNaNbPfSRP/iQLrfSdt0snKNzzA2QYJCoJ2dvFA
         xLp2w5UmtR7zdSjTOcGiZSpJOc1MLnbF4QT3QEflFz0ZvJxF4PTSUqo3zow1g01crXF9
         gX9zlL+0+S8WWa/flRL+i8GcQfrPshSxXvqO2RYePkgH2FO2IZX7HU1NsONoAGxzkCbb
         7LNn1BmAtqa7ihbCVt5/Q2vwSg/f6UjojKCOC4LjdPrr3bip/vxt4iOaUcYhTzKai5z3
         qy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=8nXOFB8iiBeRF/i/hK7RJVYSnBTXC+aXlO0UIqySsxM=;
        b=k5/yDOEitcva8bm3XzPuol0G3Bzou3laLa6ZzTWrXos/MOzcf8TR4mM2flFHx56SYJ
         pzcJiUtNrdkaDYiei3DdF7IlfoNQ37lTXnzvtOOa9iKcZIaAL2N8KcB7ulu7tq2LbUlW
         A2lEZRAF/W9I3rBeLmr1W27OWzr69Y7iNr1Bwg56/+qmsJkMgFZpTfcUk4qH4Ny6kspC
         XpmtyRTgYtexIgPH7/qC52OC+apW8AoNvGu5fJALlV3kB4ScvsUXiJGIy1MOJdiw9iyg
         s9fLmhmlBfi/9RSsu8qgw4d1mk8OKaQZ2K9P8w4r9w8llhTU9ILb5IDI3i5RSJUrCkOC
         XzMw==
X-Gm-Message-State: ACgBeo0s10AEv/5+XU3HbB40JFNCVr74siHNPa0iLKxLaPKZqOQhwSzq
        vjZ9XvW1ru80Trl9zgaSsiDuq56cT5g=
X-Google-Smtp-Source: AA6agR4S2n8eS5Q1zAZMhWuZzYOwaf3MQiU3+TLxDPLpjuMYZ5wiaxyypwtobB8bC9QR+XP4gpn29Q==
X-Received: by 2002:a7b:c051:0:b0:3a6:36fc:8429 with SMTP id u17-20020a7bc051000000b003a636fc8429mr3309124wmc.78.1661992215059;
        Wed, 31 Aug 2022 17:30:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c154900b003a60ff7c082sm3896750wmg.15.2022.08.31.17.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:14 -0700 (PDT)
Message-Id: <7814d6a51c47ace670db6e185f71e1640d53aab1.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:52 +0000
Subject: [PATCH 14/18] t/chainlint: add more chainlint.pl self-tests
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

During the development of chainlint.pl, numerous new self-tests were
created to verify correct functioning beyond the checks already
represented by the existing self-tests. The new checks fall into several
categories:

* behavior of the lexical analyzer for complex cases, such as line
  splicing, token pasting, entering and exiting string contexts inside
  and outside of test script bodies; for instance:

    test_expect_success 'title' '
      x=$(echo "something" |
        sed -e '\''s/\\/\\\\/g'\'' -e '\''s/[[/.*^$]/\\&/g'\''
    '

* behavior of the parser for all compound grammatical constructs, such
  as `if...fi`, `case...esac`, `while...done`, `{...}`, etc., and for
  other legal shell grammatical constructs not covered by existing
  chainlint.sed self-tests, as well as complex cases, such as:

    OUT=$( ((large_git 1>&3) | :) 3>&1 ) &&

* detection of problems, such as &&-chain breakage, from top-level to
  any depth since the existing self-tests do not cover any top-level
  context and only cover subshells one level deep due to limitations of
  chainlint.sed

* address blind spots in chainlint.sed (such as not detecting a broken
  &&-chain on a one-line for-loop in a subshell[1]) which chainlint.pl
  correctly detects

* real-world cases which tripped up chainlint.pl during its development

[1]: https://lore.kernel.org/git/dce35a47012fecc6edc11c68e91dbb485c5bc36f.1661663880.git.gitgitgadget@gmail.com/

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/blank-line-before-esac.expect     | 18 +++++++++++
 t/chainlint/blank-line-before-esac.test       | 19 +++++++++++
 t/chainlint/block.expect                      | 13 +++++++-
 t/chainlint/block.test                        | 15 ++++++++-
 t/chainlint/chained-block.expect              |  9 ++++++
 t/chainlint/chained-block.test                | 11 +++++++
 t/chainlint/chained-subshell.expect           | 10 ++++++
 t/chainlint/chained-subshell.test             | 13 ++++++++
 .../command-substitution-subsubshell.expect   |  2 ++
 .../command-substitution-subsubshell.test     |  3 ++
 t/chainlint/double-here-doc.expect            |  2 ++
 t/chainlint/double-here-doc.test              | 12 +++++++
 t/chainlint/dqstring-line-splice.expect       |  3 ++
 t/chainlint/dqstring-line-splice.test         |  7 ++++
 t/chainlint/dqstring-no-interpolate.expect    | 11 +++++++
 t/chainlint/dqstring-no-interpolate.test      | 15 +++++++++
 t/chainlint/empty-here-doc.expect             |  3 ++
 t/chainlint/empty-here-doc.test               |  5 +++
 t/chainlint/exclamation.expect                |  4 +++
 t/chainlint/exclamation.test                  |  8 +++++
 t/chainlint/for-loop-abbreviated.expect       |  5 +++
 t/chainlint/for-loop-abbreviated.test         |  6 ++++
 t/chainlint/function.expect                   | 11 +++++++
 t/chainlint/function.test                     | 13 ++++++++
 t/chainlint/here-doc-indent-operator.expect   |  5 +++
 t/chainlint/here-doc-indent-operator.test     | 13 ++++++++
 t/chainlint/if-condition-split.expect         |  7 ++++
 t/chainlint/if-condition-split.test           |  8 +++++
 t/chainlint/one-liner-for-loop.expect         |  9 ++++++
 t/chainlint/one-liner-for-loop.test           | 10 ++++++
 t/chainlint/sqstring-in-sqstring.expect       |  4 +++
 t/chainlint/sqstring-in-sqstring.test         |  5 +++
 t/chainlint/token-pasting.expect              | 27 ++++++++++++++++
 t/chainlint/token-pasting.test                | 32 +++++++++++++++++++
 34 files changed, 336 insertions(+), 2 deletions(-)
 create mode 100644 t/chainlint/blank-line-before-esac.expect
 create mode 100644 t/chainlint/blank-line-before-esac.test
 create mode 100644 t/chainlint/chained-block.expect
 create mode 100644 t/chainlint/chained-block.test
 create mode 100644 t/chainlint/chained-subshell.expect
 create mode 100644 t/chainlint/chained-subshell.test
 create mode 100644 t/chainlint/command-substitution-subsubshell.expect
 create mode 100644 t/chainlint/command-substitution-subsubshell.test
 create mode 100644 t/chainlint/double-here-doc.expect
 create mode 100644 t/chainlint/double-here-doc.test
 create mode 100644 t/chainlint/dqstring-line-splice.expect
 create mode 100644 t/chainlint/dqstring-line-splice.test
 create mode 100644 t/chainlint/dqstring-no-interpolate.expect
 create mode 100644 t/chainlint/dqstring-no-interpolate.test
 create mode 100644 t/chainlint/empty-here-doc.expect
 create mode 100644 t/chainlint/empty-here-doc.test
 create mode 100644 t/chainlint/exclamation.expect
 create mode 100644 t/chainlint/exclamation.test
 create mode 100644 t/chainlint/for-loop-abbreviated.expect
 create mode 100644 t/chainlint/for-loop-abbreviated.test
 create mode 100644 t/chainlint/function.expect
 create mode 100644 t/chainlint/function.test
 create mode 100644 t/chainlint/here-doc-indent-operator.expect
 create mode 100644 t/chainlint/here-doc-indent-operator.test
 create mode 100644 t/chainlint/if-condition-split.expect
 create mode 100644 t/chainlint/if-condition-split.test
 create mode 100644 t/chainlint/one-liner-for-loop.expect
 create mode 100644 t/chainlint/one-liner-for-loop.test
 create mode 100644 t/chainlint/sqstring-in-sqstring.expect
 create mode 100644 t/chainlint/sqstring-in-sqstring.test
 create mode 100644 t/chainlint/token-pasting.expect
 create mode 100644 t/chainlint/token-pasting.test

diff --git a/t/chainlint/blank-line-before-esac.expect b/t/chainlint/blank-line-before-esac.expect
new file mode 100644
index 00000000000..48ed4eb1246
--- /dev/null
+++ b/t/chainlint/blank-line-before-esac.expect
@@ -0,0 +1,18 @@
+test_done ( ) {
+	case "$test_failure" in
+	0 )
+		test_at_end_hook_
+
+		exit 0 ;;
+
+	* )
+		if test $test_external_has_tap -eq 0
+		then
+			say_color error "# failed $test_failure among $msg"
+			say "1..$test_count"
+		fi
+
+		exit 1 ;;
+
+		esac
+}
diff --git a/t/chainlint/blank-line-before-esac.test b/t/chainlint/blank-line-before-esac.test
new file mode 100644
index 00000000000..cecccad19f5
--- /dev/null
+++ b/t/chainlint/blank-line-before-esac.test
@@ -0,0 +1,19 @@
+# LINT: blank line before "esac"
+test_done () {
+	case "$test_failure" in
+	0)
+		test_at_end_hook_
+
+		exit 0 ;;
+
+	*)
+		if test $test_external_has_tap -eq 0
+		then
+			say_color error "# failed $test_failure among $msg"
+			say "1..$test_count"
+		fi
+
+		exit 1 ;;
+
+	esac
+}
diff --git a/t/chainlint/block.expect b/t/chainlint/block.expect
index 37dbf7d95fa..a3bcea492a9 100644
--- a/t/chainlint/block.expect
+++ b/t/chainlint/block.expect
@@ -9,4 +9,15 @@
 		echo c
 	} ?!AMP?!
 	baz
-)
+) &&
+
+{
+	echo a ; ?!AMP?! echo b
+} &&
+{ echo a ; ?!AMP?! echo b ; } &&
+
+{
+	echo "${var}9" &&
+	echo "done"
+} &&
+finis
diff --git a/t/chainlint/block.test b/t/chainlint/block.test
index 0a82fd579f6..4ab69a4afc4 100644
--- a/t/chainlint/block.test
+++ b/t/chainlint/block.test
@@ -11,4 +11,17 @@
 		echo c
 	}
 	baz
-)
+) &&
+
+# LINT: ";" not allowed in place of "&&"
+{
+	echo a; echo b
+} &&
+{ echo a; echo b; } &&
+
+# LINT: "}" inside string not mistaken as end of block
+{
+	echo "${var}9" &&
+	echo "done"
+} &&
+finis
diff --git a/t/chainlint/chained-block.expect b/t/chainlint/chained-block.expect
new file mode 100644
index 00000000000..574cdceb071
--- /dev/null
+++ b/t/chainlint/chained-block.expect
@@ -0,0 +1,9 @@
+echo nobody home && {
+	test the doohicky ?!AMP?!
+	right now
+} &&
+
+GIT_EXTERNAL_DIFF=echo git diff | {
+	read path oldfile oldhex oldmode newfile newhex newmode &&
+	test "z$oh" = "z$oldhex"
+}
diff --git a/t/chainlint/chained-block.test b/t/chainlint/chained-block.test
new file mode 100644
index 00000000000..86f81ece639
--- /dev/null
+++ b/t/chainlint/chained-block.test
@@ -0,0 +1,11 @@
+# LINT: start of block chained to preceding command
+echo nobody home && {
+	test the doohicky
+	right now
+} &&
+
+# LINT: preceding command pipes to block on same line
+GIT_EXTERNAL_DIFF=echo git diff | {
+	read path oldfile oldhex oldmode newfile newhex newmode &&
+	test "z$oh" = "z$oldhex"
+}
diff --git a/t/chainlint/chained-subshell.expect b/t/chainlint/chained-subshell.expect
new file mode 100644
index 00000000000..af0369d3285
--- /dev/null
+++ b/t/chainlint/chained-subshell.expect
@@ -0,0 +1,10 @@
+mkdir sub && (
+	cd sub &&
+	foo the bar ?!AMP?!
+	nuff said
+) &&
+
+cut "-d " -f actual | ( read s1 s2 s3 &&
+test -f $s1 ?!AMP?!
+test $(cat $s2) = tree2path1 &&
+test $(cat $s3) = tree3path1 )
diff --git a/t/chainlint/chained-subshell.test b/t/chainlint/chained-subshell.test
new file mode 100644
index 00000000000..4ff6ddd8cbd
--- /dev/null
+++ b/t/chainlint/chained-subshell.test
@@ -0,0 +1,13 @@
+# LINT: start of subshell chained to preceding command
+mkdir sub && (
+	cd sub &&
+	foo the bar
+	nuff said
+) &&
+
+# LINT: preceding command pipes to subshell on same line
+cut "-d " -f actual | (read s1 s2 s3 &&
+test -f $s1
+test $(cat $s2) = tree2path1 &&
+# LINT: closing subshell ")" correctly detected on same line as "$(...)"
+test $(cat $s3) = tree3path1)
diff --git a/t/chainlint/command-substitution-subsubshell.expect b/t/chainlint/command-substitution-subsubshell.expect
new file mode 100644
index 00000000000..ab2f79e8457
--- /dev/null
+++ b/t/chainlint/command-substitution-subsubshell.expect
@@ -0,0 +1,2 @@
+OUT=$(( ( large_git 1 >& 3 ) | : ) 3 >& 1) &&
+test_match_signal 13 "$OUT"
diff --git a/t/chainlint/command-substitution-subsubshell.test b/t/chainlint/command-substitution-subsubshell.test
new file mode 100644
index 00000000000..321de2951ce
--- /dev/null
+++ b/t/chainlint/command-substitution-subsubshell.test
@@ -0,0 +1,3 @@
+# LINT: subshell nested in subshell nested in command substitution
+OUT=$( ((large_git 1>&3) | :) 3>&1 ) &&
+test_match_signal 13 "$OUT"
diff --git a/t/chainlint/double-here-doc.expect b/t/chainlint/double-here-doc.expect
new file mode 100644
index 00000000000..75477bb1add
--- /dev/null
+++ b/t/chainlint/double-here-doc.expect
@@ -0,0 +1,2 @@
+run_sub_test_lib_test_err run-inv-range-start "--run invalid range start" --run="a-5" <<-EOF &&
+check_sub_test_lib_test_err run-inv-range-start <<-EOF_OUT 3 <<-EOF_ERR
diff --git a/t/chainlint/double-here-doc.test b/t/chainlint/double-here-doc.test
new file mode 100644
index 00000000000..cd584a43573
--- /dev/null
+++ b/t/chainlint/double-here-doc.test
@@ -0,0 +1,12 @@
+run_sub_test_lib_test_err run-inv-range-start \
+	"--run invalid range start" \
+	--run="a-5" <<-\EOF &&
+test_expect_success "passing test #1" "true"
+test_done
+EOF
+check_sub_test_lib_test_err run-inv-range-start \
+	<<-\EOF_OUT 3<<-EOF_ERR
+> FATAL: Unexpected exit with code 1
+EOF_OUT
+> error: --run: invalid non-numeric in range start: ${SQ}a-5${SQ}
+EOF_ERR
diff --git a/t/chainlint/dqstring-line-splice.expect b/t/chainlint/dqstring-line-splice.expect
new file mode 100644
index 00000000000..bf9ced60d4c
--- /dev/null
+++ b/t/chainlint/dqstring-line-splice.expect
@@ -0,0 +1,3 @@
+echo 'fatal: reword option of --fixup is mutually exclusive with' '--patch/--interactive/--all/--include/--only' > expect &&
+test_must_fail git commit --fixup=reword:HEAD~ $1 2 > actual &&
+test_cmp expect actual
diff --git a/t/chainlint/dqstring-line-splice.test b/t/chainlint/dqstring-line-splice.test
new file mode 100644
index 00000000000..b40714439f6
--- /dev/null
+++ b/t/chainlint/dqstring-line-splice.test
@@ -0,0 +1,7 @@
+# LINT: line-splice within DQ-string
+'"
+echo 'fatal: reword option of --fixup is mutually exclusive with'\
+	'--patch/--interactive/--all/--include/--only' >expect &&
+test_must_fail git commit --fixup=reword:HEAD~ $1 2>actual &&
+test_cmp expect actual
+"'
diff --git a/t/chainlint/dqstring-no-interpolate.expect b/t/chainlint/dqstring-no-interpolate.expect
new file mode 100644
index 00000000000..10724987a5f
--- /dev/null
+++ b/t/chainlint/dqstring-no-interpolate.expect
@@ -0,0 +1,11 @@
+grep "^ ! [rejected][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
+
+grep "^\.git$" output.txt &&
+
+
+(
+	cd client$version &&
+	GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. $(cat ../input)
+) > output &&
+	cut -d ' ' -f 2 < output | sort > actual &&
+	test_cmp expect actual
diff --git a/t/chainlint/dqstring-no-interpolate.test b/t/chainlint/dqstring-no-interpolate.test
new file mode 100644
index 00000000000..d2f4219cbbb
--- /dev/null
+++ b/t/chainlint/dqstring-no-interpolate.test
@@ -0,0 +1,15 @@
+# LINT: regex dollar-sign eol anchor in double-quoted string not special
+grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" out &&
+
+# LINT: escaped "$" not mistaken for variable expansion
+grep "^\\.git\$" output.txt &&
+
+'"
+(
+	cd client$version &&
+# LINT: escaped dollar-sign in double-quoted test body
+	GIT_TEST_PROTOCOL_VERSION=$version git fetch-pack --no-progress .. \$(cat ../input)
+) >output &&
+	cut -d ' ' -f 2 <output | sort >actual &&
+	test_cmp expect actual
+"'
diff --git a/t/chainlint/empty-here-doc.expect b/t/chainlint/empty-here-doc.expect
new file mode 100644
index 00000000000..f42f2d41ba8
--- /dev/null
+++ b/t/chainlint/empty-here-doc.expect
@@ -0,0 +1,3 @@
+git ls-tree $tree path > current &&
+cat > expected <<EOF &&
+test_output
diff --git a/t/chainlint/empty-here-doc.test b/t/chainlint/empty-here-doc.test
new file mode 100644
index 00000000000..24fc165de3f
--- /dev/null
+++ b/t/chainlint/empty-here-doc.test
@@ -0,0 +1,5 @@
+git ls-tree $tree path >current &&
+# LINT: empty here-doc
+cat >expected <<\EOF &&
+EOF
+test_output
diff --git a/t/chainlint/exclamation.expect b/t/chainlint/exclamation.expect
new file mode 100644
index 00000000000..2d961a58c66
--- /dev/null
+++ b/t/chainlint/exclamation.expect
@@ -0,0 +1,4 @@
+if ! condition ; then echo nope ; else yep ; fi &&
+test_prerequisite !MINGW &&
+mail uucp!address &&
+echo !whatever!
diff --git a/t/chainlint/exclamation.test b/t/chainlint/exclamation.test
new file mode 100644
index 00000000000..323595b5bd8
--- /dev/null
+++ b/t/chainlint/exclamation.test
@@ -0,0 +1,8 @@
+# LINT: "! word" is two tokens
+if ! condition; then echo nope; else yep; fi &&
+# LINT: "!word" is single token, not two tokens "!" and "word"
+test_prerequisite !MINGW &&
+# LINT: "word!word" is single token, not three tokens "word", "!", and "word"
+mail uucp!address &&
+# LINT: "!word!" is single token, not three tokens "!", "word", and "!"
+echo !whatever!
diff --git a/t/chainlint/for-loop-abbreviated.expect b/t/chainlint/for-loop-abbreviated.expect
new file mode 100644
index 00000000000..a21007a63f1
--- /dev/null
+++ b/t/chainlint/for-loop-abbreviated.expect
@@ -0,0 +1,5 @@
+for it
+do
+	path=$(expr "$it" : ( [^:]*) ) &&
+	git update-index --add "$path" || exit
+done
diff --git a/t/chainlint/for-loop-abbreviated.test b/t/chainlint/for-loop-abbreviated.test
new file mode 100644
index 00000000000..1084eccb89c
--- /dev/null
+++ b/t/chainlint/for-loop-abbreviated.test
@@ -0,0 +1,6 @@
+# LINT: for-loop lacking optional "in [word...]" before "do"
+for it
+do
+	path=$(expr "$it" : '\([^:]*\)') &&
+	git update-index --add "$path" || exit
+done
diff --git a/t/chainlint/function.expect b/t/chainlint/function.expect
new file mode 100644
index 00000000000..a14388e6b9f
--- /dev/null
+++ b/t/chainlint/function.expect
@@ -0,0 +1,11 @@
+sha1_file ( ) {
+	echo "$*" | sed "s#..#.git/objects/&/#"
+} &&
+
+remove_object ( ) {
+	file=$(sha1_file "$*") &&
+	test -e "$file" ?!AMP?!
+	rm -f "$file"
+} ?!AMP?!
+
+sha1_file arg && remove_object arg
diff --git a/t/chainlint/function.test b/t/chainlint/function.test
new file mode 100644
index 00000000000..5ee59562c93
--- /dev/null
+++ b/t/chainlint/function.test
@@ -0,0 +1,13 @@
+# LINT: "()" in function definition not mistaken for subshell
+sha1_file() {
+	echo "$*" | sed "s#..#.git/objects/&/#"
+} &&
+
+# LINT: broken &&-chain in function and after function
+remove_object() {
+	file=$(sha1_file "$*") &&
+	test -e "$file"
+	rm -f "$file"
+}
+
+sha1_file arg && remove_object arg
diff --git a/t/chainlint/here-doc-indent-operator.expect b/t/chainlint/here-doc-indent-operator.expect
new file mode 100644
index 00000000000..fb6cf7285d0
--- /dev/null
+++ b/t/chainlint/here-doc-indent-operator.expect
@@ -0,0 +1,5 @@
+cat > expect <<-EOF &&
+
+cat > expect <<-EOF ?!AMP?!
+
+cleanup
diff --git a/t/chainlint/here-doc-indent-operator.test b/t/chainlint/here-doc-indent-operator.test
new file mode 100644
index 00000000000..c8a6f18eb45
--- /dev/null
+++ b/t/chainlint/here-doc-indent-operator.test
@@ -0,0 +1,13 @@
+# LINT: whitespace between operator "<<-" and tag legal
+cat >expect <<- EOF &&
+header: 43475048 1 $(test_oid oid_version) $NUM_CHUNKS 0
+num_commits: $1
+chunks: oid_fanout oid_lookup commit_metadata generation_data bloom_indexes bloom_data
+EOF
+
+# LINT: not an indented here-doc; just a plain here-doc with tag named "-EOF"
+cat >expect << -EOF
+this is not indented
+-EOF
+
+cleanup
diff --git a/t/chainlint/if-condition-split.expect b/t/chainlint/if-condition-split.expect
new file mode 100644
index 00000000000..ee745ef8d7f
--- /dev/null
+++ b/t/chainlint/if-condition-split.expect
@@ -0,0 +1,7 @@
+if bob &&
+   marcia ||
+   kevin
+then
+	echo "nomads" ?!AMP?!
+	echo "for sure"
+fi
diff --git a/t/chainlint/if-condition-split.test b/t/chainlint/if-condition-split.test
new file mode 100644
index 00000000000..240daa9fd5d
--- /dev/null
+++ b/t/chainlint/if-condition-split.test
@@ -0,0 +1,8 @@
+# LINT: "if" condition split across multiple lines at "&&" or "||"
+if bob &&
+   marcia ||
+   kevin
+then
+	echo "nomads"
+	echo "for sure"
+fi
diff --git a/t/chainlint/one-liner-for-loop.expect b/t/chainlint/one-liner-for-loop.expect
new file mode 100644
index 00000000000..51a3dc7c544
--- /dev/null
+++ b/t/chainlint/one-liner-for-loop.expect
@@ -0,0 +1,9 @@
+git init dir-rename-and-content &&
+(
+	cd dir-rename-and-content &&
+	test_write_lines 1 2 3 4 5 >foo &&
+	mkdir olddir &&
+	for i in a b c; do echo $i >olddir/$i; ?!LOOP?! done ?!AMP?!
+	git add foo olddir &&
+	git commit -m "original" &&
+)
diff --git a/t/chainlint/one-liner-for-loop.test b/t/chainlint/one-liner-for-loop.test
new file mode 100644
index 00000000000..4bd8c066c79
--- /dev/null
+++ b/t/chainlint/one-liner-for-loop.test
@@ -0,0 +1,10 @@
+git init dir-rename-and-content &&
+(
+	cd dir-rename-and-content &&
+	test_write_lines 1 2 3 4 5 >foo &&
+	mkdir olddir &&
+# LINT: one-liner for-loop missing "|| exit"; also broken &&-chain
+	for i in a b c; do echo $i >olddir/$i; done
+	git add foo olddir &&
+	git commit -m "original" &&
+)
diff --git a/t/chainlint/sqstring-in-sqstring.expect b/t/chainlint/sqstring-in-sqstring.expect
new file mode 100644
index 00000000000..cf0b591cf7d
--- /dev/null
+++ b/t/chainlint/sqstring-in-sqstring.expect
@@ -0,0 +1,4 @@
+perl -e '
+	defined($_ = -s $_) or die for @ARGV;
+	exit 1 if $ARGV[0] <= $ARGV[1];
+' test-2-$packname_2.pack test-3-$packname_3.pack
diff --git a/t/chainlint/sqstring-in-sqstring.test b/t/chainlint/sqstring-in-sqstring.test
new file mode 100644
index 00000000000..77a425e0c79
--- /dev/null
+++ b/t/chainlint/sqstring-in-sqstring.test
@@ -0,0 +1,5 @@
+# LINT: SQ-string Perl code fragment within SQ-string
+perl -e '\''
+	defined($_ = -s $_) or die for @ARGV;
+	exit 1 if $ARGV[0] <= $ARGV[1];
+'\'' test-2-$packname_2.pack test-3-$packname_3.pack
diff --git a/t/chainlint/token-pasting.expect b/t/chainlint/token-pasting.expect
new file mode 100644
index 00000000000..342360bcd05
--- /dev/null
+++ b/t/chainlint/token-pasting.expect
@@ -0,0 +1,27 @@
+git config filter.rot13.smudge ./rot13.sh &&
+git config filter.rot13.clean ./rot13.sh &&
+
+{
+    echo "*.t filter=rot13" ?!AMP?!
+    echo "*.i ident"
+} > .gitattributes &&
+
+{
+    echo a b c d e f g h i j k l m ?!AMP?!
+    echo n o p q r s t u v w x y z ?!AMP?!
+    echo '$Id$'
+} > test &&
+cat test > test.t &&
+cat test > test.o &&
+cat test > test.i &&
+git add test test.t test.i &&
+rm -f test test.t test.i &&
+git checkout -- test test.t test.i &&
+
+echo "content-test2" > test2.o &&
+echo "content-test3 - filename with special characters" > "test3 'sq',$x=.o" ?!AMP?!
+
+downstream_url_for_sed=$(
+	printf "%sn" "$downstream_url" |
+	sed -e 's/\/\\/g' -e 's/[[/.*^$]/\&/g'
+)
diff --git a/t/chainlint/token-pasting.test b/t/chainlint/token-pasting.test
new file mode 100644
index 00000000000..b4610ce815a
--- /dev/null
+++ b/t/chainlint/token-pasting.test
@@ -0,0 +1,32 @@
+# LINT: single token; composite of multiple strings
+git config filter.rot13.smudge ./rot13.sh &&
+git config filter.rot13.clean ./rot13.sh &&
+
+{
+    echo "*.t filter=rot13"
+    echo "*.i ident"
+} >.gitattributes &&
+
+{
+    echo a b c d e f g h i j k l m
+    echo n o p q r s t u v w x y z
+# LINT: exit/enter string context and escaped-quote outside of string
+    echo '\''$Id$'\''
+} >test &&
+cat test >test.t &&
+cat test >test.o &&
+cat test >test.i &&
+git add test test.t test.i &&
+rm -f test test.t test.i &&
+git checkout -- test test.t test.i &&
+
+echo "content-test2" >test2.o &&
+# LINT: exit/enter string context and escaped-quote outside of string
+echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
+
+# LINT: single token; composite of multiple strings
+downstream_url_for_sed=$(
+	printf "%s\n" "$downstream_url" |
+# LINT: exit/enter string context; "&" inside string not command terminator
+	sed -e '\''s/\\/\\\\/g'\'' -e '\''s/[[/.*^$]/\\&/g'\''
+)
-- 
gitgitgadget

