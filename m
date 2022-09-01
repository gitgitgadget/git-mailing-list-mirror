Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A7EECAAD5
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbiIAAao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiIAAaV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:21 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6898D3D5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:13 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so446809wmk.3
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ylS7PjWkZoP2NA4NykpbUEsjOmimC7ie5JIkYd4cs3s=;
        b=BXXsESIQN80j84TNjAEQDbRGbdSMXEA6+tQ4wbtZHxjD4IytQifJXO3Fw44KwZOkwE
         KbYJRGf7CsNvaN+w+ngbSu4DY4+ZpRL0IbIoB6ZHa7G7SDonP1YE6o0iuBSN8zFjquwF
         zrAfCncHn2IUts1O/2OAr8uSQAdLebkOCJLJqgEEL8CLjLwJlCW/M2biFQQxA0oQkdZZ
         6RXp+is9eaAqmW5ZQ+DggP3BpZiPVtF3sLPr5L+J9RVb1EtIPjzSycnE0r7XR/WN8D1b
         Z0Z3ay+okoNtMZSvlnQ1suxb1sRABBi7cms7gWLUUCBDj4uSz+dfU+6KCy9J9pcm1r3w
         vnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ylS7PjWkZoP2NA4NykpbUEsjOmimC7ie5JIkYd4cs3s=;
        b=QxHkU+wm1GugI3EBehSyHU4xv0e5KlEWj4JS1wcT41tg78+UcPNLlEb0s69ITcyEPb
         DTEpA/z4OwBq4jsGS/J1tTKan3BMmbOY6o95IgydimVwjXwBnjwK31H7HCiZTGKn622n
         yzkputzgTUEQm2eJhBrtC7miWayjXAA0rmLidmEMoj5O1TKKksUG8r0RVElNBYxVrlNx
         A7QA+nTl775puFiFQ6NRKGi4+pqI8lD0pzZWcSHySsRBee7bcET+wX5SeySAhiJCoUDG
         cAtIMNXKZre0CCsIvjt4tyX0nhixi3Q2CRjBAg5UuhBPtYs1Cq5aDONOqnMUK0zcLbzs
         J5AQ==
X-Gm-Message-State: ACgBeo3YqpHtBLROpgIjXQNZvz4P7Z3Y/kUM++wFbQtcsJa4+YPBhhO0
        5EucaVuH220VG/B+Ymb/7id2JoQ53yA=
X-Google-Smtp-Source: AA6agR5rILCPW4jyHXtztyEfzqqGEgWg44ge/xm9IFur6NS7K0RfwmZtiC+oKJO8xl52A5dXjhS8Rw==
X-Received: by 2002:a7b:c844:0:b0:3a9:70d2:bf23 with SMTP id c4-20020a7bc844000000b003a970d2bf23mr392526wml.165.1661992211994;
        Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003a342933727sm3749201wmb.3.2022.08.31.17.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:11 -0700 (PDT)
Message-Id: <11bd449766dd6854466b214cf0d144feb01d4fd2.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:49 +0000
Subject: [PATCH 11/18] chainlint.pl: don't flag broken &&-chain if failure
 indicated explicitly
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

There are quite a few tests which print an error messages and then
explicitly signal failure with `false`, `return 1`, or `exit 1` as the
final command in an `if` branch. In these cases, the tests don't bother
maintaining the &&-chain between `echo` and the explicit "test failed"
indicator. Since such constructs are manually signaling failure, their
&&-chain breakage is legitimate and safe -- both for the command
immediately preceding `false`, `return`, or `exit`, as well as for all
preceding commands in the `if` branch. Therefore, stop flagging &&-chain
breakage in these sorts of cases.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                             |  8 ++++++++
 t/chainlint/chain-break-false.expect       |  9 +++++++++
 t/chainlint/chain-break-false.test         | 10 ++++++++++
 t/chainlint/chain-break-return-exit.expect | 15 +++++++++++++++
 t/chainlint/chain-break-return-exit.test   | 18 ++++++++++++++++++
 t/chainlint/if-in-loop.expect              |  2 +-
 t/chainlint/if-in-loop.test                |  2 +-
 7 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 t/chainlint/chain-break-false.expect
 create mode 100644 t/chainlint/chain-break-false.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 14e1db3519a..a76a09ecf5e 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -503,6 +503,14 @@ sub accumulate {
 		goto DONE if $token =~ /\$\?/;
 	}
 
+	# if this command is "false", "return 1", or "exit 1" (which signal
+	# failure explicitly), then okay for all preceding commands to be
+	# missing "&&"
+	if ($$cmd[0] =~ /^(?:false|return|exit)$/) {
+		@$tokens = grep(!/^\?!AMP\?!$/, @$tokens);
+		goto DONE;
+	}
+
 	# flag missing "&&" at end of previous command
 	my $n = find_non_nl($tokens);
 	splice(@$tokens, $n + 1, 0, '?!AMP?!') unless $n < 0;
diff --git a/t/chainlint/chain-break-false.expect b/t/chainlint/chain-break-false.expect
new file mode 100644
index 00000000000..989766fb856
--- /dev/null
+++ b/t/chainlint/chain-break-false.expect
@@ -0,0 +1,9 @@
+if condition not satisified
+then
+	echo it did not work...
+	echo failed!
+	false
+else
+	echo it went okay ?!AMP?!
+	congratulate user
+fi
diff --git a/t/chainlint/chain-break-false.test b/t/chainlint/chain-break-false.test
new file mode 100644
index 00000000000..a5aaff8c8a4
--- /dev/null
+++ b/t/chainlint/chain-break-false.test
@@ -0,0 +1,10 @@
+# LINT: broken &&-chain okay if explicit "false" signals failure
+if condition not satisified
+then
+	echo it did not work...
+	echo failed!
+	false
+else
+	echo it went okay
+	congratulate user
+fi
diff --git a/t/chainlint/chain-break-return-exit.expect b/t/chainlint/chain-break-return-exit.expect
index dba292ee89b..1732d221c32 100644
--- a/t/chainlint/chain-break-return-exit.expect
+++ b/t/chainlint/chain-break-return-exit.expect
@@ -1,3 +1,18 @@
+case "$(git ls-files)" in
+one ) echo pass one ;;
+* ) echo bad one ; return 1 ;;
+esac &&
+(
+	case "$(git ls-files)" in
+	two ) echo pass two ;;
+	* ) echo bad two ; exit 1 ;;
+esac
+) &&
+case "$(git ls-files)" in
+dir/two"$LF"one ) echo pass both ;;
+* ) echo bad ; return 1 ;;
+esac &&
+
 for i in 1 2 3 4 ; do
 	git checkout main -b $i || return $?
 	test_commit $i $i $i tag$i || return $?
diff --git a/t/chainlint/chain-break-return-exit.test b/t/chainlint/chain-break-return-exit.test
index e2b059933aa..46542edf881 100644
--- a/t/chainlint/chain-break-return-exit.test
+++ b/t/chainlint/chain-break-return-exit.test
@@ -1,3 +1,21 @@
+case "$(git ls-files)" in
+one) echo pass one ;;
+# LINT: broken &&-chain okay if explicit "return 1" signals failuire
+*) echo bad one; return 1 ;;
+esac &&
+(
+	case "$(git ls-files)" in
+	two) echo pass two ;;
+# LINT: broken &&-chain okay if explicit "exit 1" signals failuire
+	*) echo bad two; exit 1 ;;
+	esac
+) &&
+case "$(git ls-files)" in
+dir/two"$LF"one) echo pass both ;;
+# LINT: broken &&-chain okay if explicit "return 1" signals failuire
+*) echo bad; return 1 ;;
+esac &&
+
 for i in 1 2 3 4 ; do
 # LINT: broken &&-chain okay if explicit "return $?" signals failure
 	git checkout main -b $i || return $?
diff --git a/t/chainlint/if-in-loop.expect b/t/chainlint/if-in-loop.expect
index 03b82a3e58c..d6514ae7492 100644
--- a/t/chainlint/if-in-loop.expect
+++ b/t/chainlint/if-in-loop.expect
@@ -3,7 +3,7 @@
 	do
 		if false
 		then
-			echo "err" ?!AMP?!
+			echo "err"
 			exit 1
 		fi ?!AMP?!
 		foo
diff --git a/t/chainlint/if-in-loop.test b/t/chainlint/if-in-loop.test
index f0cf19cfada..90c23976fec 100644
--- a/t/chainlint/if-in-loop.test
+++ b/t/chainlint/if-in-loop.test
@@ -3,7 +3,7 @@
 	do
 		if false
 		then
-# LINT: missing "&&" on "echo"
+# LINT: missing "&&" on "echo" okay since "exit 1" signals error explicitly
 			echo "err"
 			exit 1
 # LINT: missing "&&" on "fi"
-- 
gitgitgadget

