Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D1D1F85B
	for <e@80x24.org>; Wed, 11 Jul 2018 06:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeGKGuv (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 02:50:51 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35188 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeGKGuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 02:50:51 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so22641320iob.2
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 23:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RcnhH2yTbglIq0MCgOTnjB7TP47NvJ1SWj0pm6tTfdo=;
        b=AeBf6O5br4SBFo//At4FA6vtS3gBSgoSIKdLwBYtZxtulMRSsPYPEVILhYFmNR6GgV
         ugbNxhxZFqn9KPEXJkv/SnPawUZqbaEL1ZeFZF4JtFyCOH55+U1TYPtmnD5sEbUXPhqe
         9lgf3lB1yaa/SkiyBWXEz+QD252YnCLqMBGyhTWmKiacf2sBLHdDkSOpDUb7TbvS6dtz
         nEPIojnhDEDqEMEQLLq/S2JoSYcppTOwiU1LM0Z7QvpvZncjDSHA5yXGvHCS9PRnpfu4
         FID4/uB805hJwusIP2sdZ9Y9xFX89d8k3mvZoBknWMswhRHvNVLlvXBTawU45ZI3r0JK
         2Lig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=RcnhH2yTbglIq0MCgOTnjB7TP47NvJ1SWj0pm6tTfdo=;
        b=dh+3bGCGb6CmjZ1kg5gOZBevvbrbQMfgo1ujjppTDE9w8pBIbJyJqbH/JHnQKFWOWr
         PLIHiQec83JxIfv0mlirfdyNkKaTTRze7mEGdbVV07FdnaIh1bc3HokBLHsAFW5xNoOs
         k5Pu5wSBVwaQH1yzVZSlRyBd8+Y9iv5T5TmxrMWKq8gzsHif+wksPKasaGct0/7l9u3t
         M8n5wAhZhVDngWW+6FdzDCnYrXLwZneClpClChasVZ0aeUccVqJIatL0wSc1T7JZf7/C
         gKfSxnfpcKdt+W6l9ViEQ2Fo9gCWNMMrA4WOA46UgqhTWiyvNTlBmHu5JTsBEZ/3nS0W
         xTSw==
X-Gm-Message-State: APt69E3Ckf08vAB8+JvnuAz6sOlsFNPmLrWYQaAv9SHpIj4wV1gXYEbq
        8BD5i03rlFo1gKIsjJPXIRvtwg==
X-Google-Smtp-Source: AAOMgpdk+V81ewsZX31OBPWKBSXv03ibNS5wkvYfdnInJhyhqK0nmkB4m8tQj8HFDT59em650yp97g==
X-Received: by 2002:a6b:d90d:: with SMTP id r13-v6mr24075888ioc.247.1531291685410;
        Tue, 10 Jul 2018 23:48:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id b143-v6sm11308298ioe.66.2018.07.10.23.48.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 10 Jul 2018 23:48:05 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/10] t/chainlint: add chainlint "whitespace" test cases
Date:   Wed, 11 Jul 2018 02:46:36 -0400
Message-Id: <20180711064642.6933-5-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
In-Reply-To: <20180711064642.6933-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180711064642.6933-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --chain-lint option uses heuristics and knowledge of shell syntax to
detect broken &&-chains in subshells by pure textual inspection. The
heuristics handle a range of stylistic variations in existing tests
(evolved over the years), however, they are still best-guesses. As such,
it is possible for future changes to accidentally break assumptions upon
which the heuristics are based. Protect against this possibility by
adding tests which check the linter itself for correctness.

In addition to protecting against regressions, these tests help document
(for humans) expected behavior, which is important since the linter's
implementation language ('sed') does not necessarily lend itself to easy
comprehension.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/blank-line.expect        |  4 ++++
 t/chainlint/blank-line.test          | 10 ++++++++++
 t/chainlint/comment.expect           |  4 ++++
 t/chainlint/comment.test             | 11 +++++++++++
 t/chainlint/here-doc.expect          |  3 +++
 t/chainlint/here-doc.test            | 16 ++++++++++++++++
 t/chainlint/incomplete-line.expect   |  4 ++++
 t/chainlint/incomplete-line.test     | 12 ++++++++++++
 t/chainlint/inline-comment.expect    |  9 +++++++++
 t/chainlint/inline-comment.test      | 12 ++++++++++++
 t/chainlint/subshell-here-doc.expect |  5 +++++
 t/chainlint/subshell-here-doc.test   | 23 +++++++++++++++++++++++
 12 files changed, 113 insertions(+)
 create mode 100644 t/chainlint/blank-line.expect
 create mode 100644 t/chainlint/blank-line.test
 create mode 100644 t/chainlint/comment.expect
 create mode 100644 t/chainlint/comment.test
 create mode 100644 t/chainlint/here-doc.expect
 create mode 100644 t/chainlint/here-doc.test
 create mode 100644 t/chainlint/incomplete-line.expect
 create mode 100644 t/chainlint/incomplete-line.test
 create mode 100644 t/chainlint/inline-comment.expect
 create mode 100644 t/chainlint/inline-comment.test
 create mode 100644 t/chainlint/subshell-here-doc.expect
 create mode 100644 t/chainlint/subshell-here-doc.test

diff --git a/t/chainlint/blank-line.expect b/t/chainlint/blank-line.expect
new file mode 100644
index 0000000000..3be939ed38
--- /dev/null
+++ b/t/chainlint/blank-line.expect
@@ -0,0 +1,4 @@
+(
+	nothing &&
+	something
+>)
diff --git a/t/chainlint/blank-line.test b/t/chainlint/blank-line.test
new file mode 100644
index 0000000000..f6dd14302b
--- /dev/null
+++ b/t/chainlint/blank-line.test
@@ -0,0 +1,10 @@
+(
+
+	nothing &&
+
+	something
+# LINT: swallow blank lines since final _statement_ before subshell end is
+# LINT: significant to "&&"-check, not final _line_ (which might be blank)
+
+
+)
diff --git a/t/chainlint/comment.expect b/t/chainlint/comment.expect
new file mode 100644
index 0000000000..3be939ed38
--- /dev/null
+++ b/t/chainlint/comment.expect
@@ -0,0 +1,4 @@
+(
+	nothing &&
+	something
+>)
diff --git a/t/chainlint/comment.test b/t/chainlint/comment.test
new file mode 100644
index 0000000000..113c0c466f
--- /dev/null
+++ b/t/chainlint/comment.test
@@ -0,0 +1,11 @@
+(
+# LINT: swallow comment lines
+	# comment 1
+	nothing &&
+	# comment 2
+	something
+# LINT: swallow comment lines since final _statement_ before subshell end is
+# LINT: significant to "&&"-check, not final _line_ (which might be comment)
+	# comment 3
+	# comment 4
+)
diff --git a/t/chainlint/here-doc.expect b/t/chainlint/here-doc.expect
new file mode 100644
index 0000000000..2328fe7753
--- /dev/null
+++ b/t/chainlint/here-doc.expect
@@ -0,0 +1,3 @@
+boodle wobba        gorgo snoot        wafta snurb &&
+
+horticulture
diff --git a/t/chainlint/here-doc.test b/t/chainlint/here-doc.test
new file mode 100644
index 0000000000..bd36f6e1d3
--- /dev/null
+++ b/t/chainlint/here-doc.test
@@ -0,0 +1,16 @@
+# LINT: stitch together incomplete \-ending lines
+# LINT: swallow here-doc to avoid false positives in content
+boodle wobba \
+       gorgo snoot \
+       wafta snurb <<EOF &&
+quoth the raven,
+nevermore...
+EOF
+
+# LINT: swallow here-doc (EOF is last line of test)
+horticulture <<\EOF
+gomez
+morticia
+wednesday
+pugsly
+EOF
diff --git a/t/chainlint/incomplete-line.expect b/t/chainlint/incomplete-line.expect
new file mode 100644
index 0000000000..2f3ebabdc2
--- /dev/null
+++ b/t/chainlint/incomplete-line.expect
@@ -0,0 +1,4 @@
+line 1 line 2 line 3 line 4 &&
+(
+	line 5 	line 6 	line 7 	line 8
+>)
diff --git a/t/chainlint/incomplete-line.test b/t/chainlint/incomplete-line.test
new file mode 100644
index 0000000000..d856658083
--- /dev/null
+++ b/t/chainlint/incomplete-line.test
@@ -0,0 +1,12 @@
+# LINT: stitch together all incomplete \-ending lines
+line 1 \
+line 2 \
+line 3 \
+line 4 &&
+(
+# LINT: stitch together all incomplete \-ending lines (subshell)
+	line 5 \
+	line 6 \
+	line 7 \
+	line 8
+)
diff --git a/t/chainlint/inline-comment.expect b/t/chainlint/inline-comment.expect
new file mode 100644
index 0000000000..fc9f250ac4
--- /dev/null
+++ b/t/chainlint/inline-comment.expect
@@ -0,0 +1,9 @@
+(
+	foobar &&
+?!AMP?!	barfoo
+	flibble "not a # comment"
+>) &&
+
+(
+cd foo &&
+>	flibble "not a # comment")
diff --git a/t/chainlint/inline-comment.test b/t/chainlint/inline-comment.test
new file mode 100644
index 0000000000..8f26856e77
--- /dev/null
+++ b/t/chainlint/inline-comment.test
@@ -0,0 +1,12 @@
+(
+# LINT: swallow inline comment (leaving command intact)
+	foobar && # comment 1
+# LINT: mispositioned "&&" (correctly) swallowed with comment
+	barfoo # wrong position for &&
+# LINT: "#" in string not misinterpreted as comment
+	flibble "not a # comment"
+) &&
+
+# LINT: "#" in string in cuddled subshell not misinterpreted as comment
+(cd foo &&
+	flibble "not a # comment")
diff --git a/t/chainlint/subshell-here-doc.expect b/t/chainlint/subshell-here-doc.expect
new file mode 100644
index 0000000000..19d5aff233
--- /dev/null
+++ b/t/chainlint/subshell-here-doc.expect
@@ -0,0 +1,5 @@
+(
+	echo wobba 	       gorgo snoot 	       wafta snurb &&
+?!AMP?!	cat >bip
+	echo >bop
+>)
diff --git a/t/chainlint/subshell-here-doc.test b/t/chainlint/subshell-here-doc.test
new file mode 100644
index 0000000000..9c3564c247
--- /dev/null
+++ b/t/chainlint/subshell-here-doc.test
@@ -0,0 +1,23 @@
+(
+# LINT: stitch together incomplete \-ending lines
+# LINT: swallow here-doc to avoid false positives in content
+	echo wobba \
+	       gorgo snoot \
+	       wafta snurb <<-EOF &&
+	quoth the raven,
+	nevermore...
+	EOF
+
+# LINT: missing "&&" on 'cat'
+	cat <<EOF >bip
+	fish fly high
+	EOF
+
+# LINT: swallow here-doc (EOF is last line of subshell)
+	echo <<-\EOF >bop
+	gomez
+	morticia
+	wednesday
+	pugsly
+	EOF
+)
-- 
2.18.0.203.gfac676dfb9

