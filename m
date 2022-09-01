Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644C1ECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiIAAad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIAAaU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABDD56BB2
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id k9so20313530wri.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=5+ckIDZAAoQ96Z/lwz0pSCfyVgJt+I5FQnr5SSG0NHg=;
        b=hUeg2BmrhMpL88pdVZ7jEA9eg4aQTSJAGgfHrvh620FdIj3OrD3StGiQT6Nh1nNRJl
         H3YdbnsEtmMryMOoFgmGFhm8/Z+I7/9KiIUugmx/e1+zNnMsPYqEuKyfZGQaWHxXLAJp
         cpxI8W54RmYZ6qhQVgI/aLb3vjs7z2RRwOHXnKf08SGHV3/d0oX0xjQE3cdl23QUz0aB
         7FZlBu/7J7TTcksQqPvHAfeUjeWrTuFd6tzyfVG4XNxkVcLFt0jqAZHOQ9ObVqHXYSH3
         BB+UJNQJF7jJ1A16tpuZGKUlg+soxH/MPDIM+w7qwmDBAq9ca3IHrfi/cqcod07rcoHd
         jILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=5+ckIDZAAoQ96Z/lwz0pSCfyVgJt+I5FQnr5SSG0NHg=;
        b=Rge3NH4Q1y8qWwlxsUhBV5IR4WWajve0m5IdQ0tpn1y8AYsVqpXkPK5iNTU4xjTaNX
         c7a4uHCkLggAw+UJPOM7ypzatLcyYrqwL/bfV+NVTNML7ieU+BtSkFS3jyx2vKu9UZDQ
         ArY1VoeDMT74Q6kZQBIzuZNVjw5wwVA96Ubg2vAZTifkpskB9ouw0HDLV12BfwI1WBTP
         OcBlK4aEIF/SrWxEFBgjryLmiZk8V+di6EdvZB5nUvPnlbRDVwVxfoQsr3iiCyLBx+Bt
         0IXjTEeijGtjQ+bNoGXK/0kZZXxAPT3uJhp31W8OmPOJxcqkWuJjuL38PSVYewMhcUdq
         qDsQ==
X-Gm-Message-State: ACgBeo0Hajf1rb1NXQ506RW+8JK3fijL6owOC6Ay10RxSbRDgnSqAdBp
        e7t7ZbVMk2Sj2pmJ8L9STWdG/KAnk6w=
X-Google-Smtp-Source: AA6agR7uPxziZCcXHDZpC1XRiek31QKoSYsHARVdzIBdldb9vuuBeWRCPtbmySzqS8sgNhtyN/3GtQ==
X-Received: by 2002:a05:6000:616:b0:226:d80b:76ab with SMTP id bn22-20020a056000061600b00226d80b76abmr10325560wrb.547.1661992207119;
        Wed, 31 Aug 2022 17:30:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6-20020a1cf606000000b003a5fa79007fsm3428898wmc.7.2022.08.31.17.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:06 -0700 (PDT)
Message-Id: <ee627a09719a4a7347c97783c1bf8f9cb9ddbf89.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:45 +0000
Subject: [PATCH 07/18] chainlint.pl: don't require `return|exit|continue` to
 end with `&&`
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

In order to check for &&-chain breakage, each time TestParser encounters
a new command, it checks whether the previous command ends with `&&`,
and -- with a couple exceptions -- signals breakage if it does not. The
first exception is that a command may validly end with `||`, which is
commonly employed as `command || return 1` at the very end of a loop
body to terminate the loop early. The second is that piping one
command's output with `|` to another command does not constitute a
&&-chain break (the exit status of the pipe is the exit status of the
final command in the pipe).

However, it turns out that there are a few additional cases found in the
wild in which it is likely safe for `&&` to be missing even when other
commands follow. For instance:

    while {condition-1}
    do
        test {condition-2} || return 1 # or `exit 1` within a subshell
        more-commands
    done

    while {condition-1}
    do
        test {condition-2} || continue
        more-commands
    done

Such cases indicate deliberate thought about failure modes by the test
author, thus flagging them as breaking the &&-chain is not helpful.
Therefore, take these special cases into consideration when checking for
&&-chain breakage.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl                             | 20 ++++++++++++++++++--
 t/chainlint/chain-break-continue.expect    | 12 ++++++++++++
 t/chainlint/chain-break-continue.test      | 13 +++++++++++++
 t/chainlint/chain-break-return-exit.expect |  4 ++++
 t/chainlint/chain-break-return-exit.test   |  5 +++++
 t/chainlint/return-loop.expect             |  5 +++++
 t/chainlint/return-loop.test               |  6 ++++++
 7 files changed, 63 insertions(+), 2 deletions(-)
 create mode 100644 t/chainlint/chain-break-continue.expect
 create mode 100644 t/chainlint/chain-break-continue.test
 create mode 100644 t/chainlint/chain-break-return-exit.expect
 create mode 100644 t/chainlint/chain-break-return-exit.test
 create mode 100644 t/chainlint/return-loop.expect
 create mode 100644 t/chainlint/return-loop.test

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 898573a9100..31c444067ce 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -473,13 +473,29 @@ sub ends_with {
 	return 1;
 }
 
+sub match_ending {
+	my ($tokens, $endings) = @_;
+	for my $needles (@$endings) {
+		next if @$tokens < scalar(grep {$_ ne "\n"} @$needles);
+		return 1 if ends_with($tokens, $needles);
+	}
+	return undef;
+}
+
+my @safe_endings = (
+	[qr/^(?:&&|\|\||\|)$/],
+	[qr/^(?:exit|return)$/, qr/^(?:\d+|\$\?)$/],
+	[qr/^(?:exit|return)$/, qr/^(?:\d+|\$\?)$/, qr/^;$/],
+	[qr/^(?:exit|return|continue)$/],
+	[qr/^(?:exit|return|continue)$/, qr/^;$/]);
+
 sub accumulate {
 	my ($self, $tokens, $cmd) = @_;
 	goto DONE unless @$tokens;
 	goto DONE if @$cmd == 1 && $$cmd[0] eq "\n";
 
-	# did previous command end with "&&", "||", "|"?
-	goto DONE if ends_with($tokens, [qr/^(?:&&|\|\||\|)$/]);
+	# did previous command end with "&&", "|", "|| return" or similar?
+	goto DONE if match_ending($tokens, \@safe_endings);
 
 	# flag missing "&&" at end of previous command
 	my $n = find_non_nl($tokens);
diff --git a/t/chainlint/chain-break-continue.expect b/t/chainlint/chain-break-continue.expect
new file mode 100644
index 00000000000..47a34577100
--- /dev/null
+++ b/t/chainlint/chain-break-continue.expect
@@ -0,0 +1,12 @@
+git ls-tree --name-only -r refs/notes/many_notes |
+while read path
+do
+	test "$path" = "foobar/non-note.txt" && continue
+	test "$path" = "deadbeef" && continue
+	test "$path" = "de/adbeef" && continue
+
+	if test $(expr length "$path") -ne $hexsz
+	then
+		return 1
+	fi
+done
diff --git a/t/chainlint/chain-break-continue.test b/t/chainlint/chain-break-continue.test
new file mode 100644
index 00000000000..f0af71d8bd9
--- /dev/null
+++ b/t/chainlint/chain-break-continue.test
@@ -0,0 +1,13 @@
+git ls-tree --name-only -r refs/notes/many_notes |
+while read path
+do
+# LINT: broken &&-chain okay if explicit "continue"
+	test "$path" = "foobar/non-note.txt" && continue
+	test "$path" = "deadbeef" && continue
+	test "$path" = "de/adbeef" && continue
+
+	if test $(expr length "$path") -ne $hexsz
+	then
+		return 1
+	fi
+done
diff --git a/t/chainlint/chain-break-return-exit.expect b/t/chainlint/chain-break-return-exit.expect
new file mode 100644
index 00000000000..dba292ee89b
--- /dev/null
+++ b/t/chainlint/chain-break-return-exit.expect
@@ -0,0 +1,4 @@
+for i in 1 2 3 4 ; do
+	git checkout main -b $i || return $?
+	test_commit $i $i $i tag$i || return $?
+done
diff --git a/t/chainlint/chain-break-return-exit.test b/t/chainlint/chain-break-return-exit.test
new file mode 100644
index 00000000000..e2b059933aa
--- /dev/null
+++ b/t/chainlint/chain-break-return-exit.test
@@ -0,0 +1,5 @@
+for i in 1 2 3 4 ; do
+# LINT: broken &&-chain okay if explicit "return $?" signals failure
+	git checkout main -b $i || return $?
+	test_commit $i $i $i tag$i || return $?
+done
diff --git a/t/chainlint/return-loop.expect b/t/chainlint/return-loop.expect
new file mode 100644
index 00000000000..cfc0549befe
--- /dev/null
+++ b/t/chainlint/return-loop.expect
@@ -0,0 +1,5 @@
+while test $i -lt $((num - 5))
+do
+	git notes add -m "notes for commit$i" HEAD~$i || return 1
+	i=$((i + 1))
+done
diff --git a/t/chainlint/return-loop.test b/t/chainlint/return-loop.test
new file mode 100644
index 00000000000..f90b1713005
--- /dev/null
+++ b/t/chainlint/return-loop.test
@@ -0,0 +1,6 @@
+while test $i -lt $((num - 5))
+do
+# LINT: "|| return {n}" valid loop escape outside subshell; no "&&" needed
+	git notes add -m "notes for commit$i" HEAD~$i || return 1
+	i=$((i + 1))
+done
-- 
gitgitgadget

