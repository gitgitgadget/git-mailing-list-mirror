Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_MIXED_ES shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58E120A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 21:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLMVXV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 16:23:21 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42347 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeLMVXV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 16:23:21 -0500
Received: by mail-qt1-f194.google.com with SMTP id d19so3886210qtq.9
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 13:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8ZtC+Vklu0LYJXVdPqVlVmwV0emdImPq+OzgdOX1qI=;
        b=BOM3ClCeUtO1QxwZOeNjtnajFFOP+NQf9UO4shKnfL87pcrr/UZVfkvzidHLGi/5sQ
         WQcVmnKfJpg0NmkyNkM8CT3xlW4yPaAoPWeEpH8kTjVpyN1jQEXeM0yXVJyaylb8k2jB
         1WHo8/8cLEzW7zGuH1iUOol6nau3QYMWSgj+gxAIcLFBMI521sJuzcpAjFCjgZ0EPUlq
         LyYZVRD4wcWQT/12UfhIcPneeeaNAZTFJyVnVhwI/Qcq8KaW1x3O71whBG0NfT3/Ze5a
         Qa2gb1Nt/+f/uE504enaPQPdfdo26ABk/1fI39SX9KpEukCVJJ2HJpvTt4YSyAaBrSJU
         lY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8ZtC+Vklu0LYJXVdPqVlVmwV0emdImPq+OzgdOX1qI=;
        b=sX/LJ3pNRiyW8lS3Q5F7aOSz/gVlyT2Zebmj1Yz4uleIbaCyF8vHDtFvBt7IaowpMe
         GwWLEEmK0rIE28nuOsW8QIwih95FT3vqZKQN1jlQigwykcT/j5UG1HQAGAikriXfEVFM
         UCw3a9Mi/s9s/gB2wiC0BDVjZmt+U9CF65YoMV6qS3H/DJB/ECC7mSdzPeV2FFg4InJK
         nSVC4Ir3eCUXEs00ysDNzmhWp/gCyc1HVHGKShvhlncqI4lydFASjcFhMmhcM4AaEuHh
         I4+Z+sIOKqaETgGfr0vleunYGB6JzsdA/wqJ5eG8mk0iASolqTConlYEDfdjlYQBiFiO
         0cXA==
X-Gm-Message-State: AA+aEWYjISSkYfRJg/8IB64uWfyEl0x1IlCqptkON+OFYT2X+4vxJp4K
        7636Z25Z38ni4OZyolVzQyF1Kc6j
X-Google-Smtp-Source: AFSGD/VJUwz8hSsiCkCW72P16fPoMNPMYvOguRXVqnvk9p7hO9vwQz2SvboL5rWpQMxYOx5+QDSLYQ==
X-Received: by 2002:a0c:8542:: with SMTP id n60mr385342qva.205.1544736199409;
        Thu, 13 Dec 2018 13:23:19 -0800 (PST)
Received: from localhost.localdomain ([142.154.219.74])
        by smtp.gmail.com with ESMTPSA id f13sm1552840qkm.52.2018.12.13.13.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 13:23:18 -0800 (PST)
From:   John Passaro <john.a.passaro@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, alex.crezoff@gmail.com, peff@peff.net,
        mgorny@gentoo.org, John Passaro <john.a.passaro@gmail.com>
Subject: [PATCH 3/4] doc, tests: pretty behavior when gpg missing
Date:   Thu, 13 Dec 2018 16:22:55 -0500
Message-Id: <20181213212256.48122-4-john.a.passaro@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213212256.48122-1-john.a.passaro@gmail.com>
References: <20181213212256.48122-1-john.a.passaro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test that when GPG cannot be run, new placeholders %GR and %G+ are
unaffected, %G? always returns 'N', and other GPG-related placeholders
return blank.

As of e5a329a279 ("run-command: report exec failure" 2018-12-11), if GPG
cannot be run and placeholders requiring GPG are given, git complains to
stderr that GPG cannot be found. That commit included low-level tests
for this behavior. Now, test it also at the level of everyday user
commands.

Signed-off-by: John Passaro <john.a.passaro@gmail.com>
---
 Documentation/pretty-formats.txt |  6 +-
 t/t7510-signed-commit.sh         | 95 ++++++++++++++++++++++++++++++++
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 582454a4f7..4a83796250 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -144,7 +144,9 @@ ifndef::git-rev-list[]
 endif::git-rev-list[]
 - '%GR': contents of the commits signature (blank when unsigned)
 - '%G+': "Y" if the commit is signed, "N" otherwise
-- '%GG': raw verification message from GPG for a signed commit
+- '%GG': raw verification message from GPG for a signed commit.
+  This and all the other %G* placeholders, other than %GR, %G+, and
+  %G?, return blank if GPG cannot be run.
 - '%G?': show "G" for a good (valid) signature,
   "B" for a bad signature,
   "U" for a good signature with unknown validity,
@@ -152,7 +154,7 @@ endif::git-rev-list[]
   "Y" for a good signature made by an expired key,
   "R" for a good signature made by a revoked key,
   "E" if the signature cannot be checked (e.g. missing key)
-  and "N" for no signature
+  and "N" for no signature (e.g. unsigned, or GPG cannot be run)
 - '%GS': show the name of the signer for a signed commit
 - '%GK': show the key used to sign a signed commit
 - '%GF': show the fingerprint of the key used to sign a signed commit
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index aff6b1eb3a..d65425eddc 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -170,6 +170,48 @@ test_expect_success GPG 'amending already signed commit' '
 	! grep "BAD signature from" actual
 '
 
+test_expect_success GPG 'show custom format fields for signed commit if gpg is missing' '
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	Y
+	EOF
+	test_config gpg.program this-is-not-a-program &&
+	git log -n1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" sixth-signed >actual 2>/dev/null &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show custom format fields for unsigned commit if gpg is missing' '
+	cat >expect <<-\EOF &&
+	N
+
+
+
+
+	N
+	EOF
+	test_config gpg.program this-is-not-a-program &&
+	git log -n1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" seventh-unsigned >actual 2>/dev/null &&
+	test_cmp expect actual
+'
+
+test_expect_success GPG 'show error for custom format fields on signed commit if gpg is missing' '
+	test_config gpg.program this-is-not-a-program &&
+	git log -n1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" sixth-signed >/dev/null 2>errors &&
+	test $(wc -l <errors) = 1 &&
+	test_i18ngrep "^error: " errors &&
+	grep this-is-not-a-program errors
+'
+
+test_expect_success GPG 'do not run gpg at all for unsigned commit' '
+	test_config gpg.program this-is-not-a-program &&
+	git log -n1 --format="%G?%n%GK%n%GS%n%GF%n%GP%n%G+" seventh-unsigned >/dev/null 2>errors &&
+	test_must_be_empty errors
+'
+
 test_expect_success GPG 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
@@ -240,6 +282,14 @@ test_expect_success GPG 'show lack of raw signature with custom format' '
 	test_must_be_empty actual
 '
 
+test_expect_success GPG 'show lack of raw signature with custom format without running GPG' '
+	echo N > expected &&
+	test_config gpg.program this-is-not-a-program &&
+	git log -1 --format="%G+%GR" seventh-unsigned >actual 2>errors &&
+	test_cmp expected actual &&
+	test_must_be_empty errors
+'
+
 test_expect_success GPG 'show raw signature with custom format' '
 	git log -1 --format=format:"%GR" sixth-signed >output &&
 	cat output &&
@@ -250,6 +300,51 @@ test_expect_success GPG 'show raw signature with custom format' '
 	tail -n1 output | grep -q "^---*END PGP SIGNATURE---*$"
 '
 
+test_expect_success GPG 'show raw signature with custom format without running GPG' '
+	test_config gpg.program this-is-not-a-program &&
+	git log -1 --format=format:"%GR" sixth-signed >rawsig 2>errors &&
+	cat rawsig &&
+	head -n1 rawsig | grep -q "^---*BEGIN PGP SIGNATURE---*$" &&
+	sed 1d rawsig | grep -q "^$" &&
+	sed "1,/^$/d" rawsig | grep -q "^[a-zA-Z0-9+/][a-zA-Z0-9+/=]*$" &&
+	tail -n2 rawsig | head -n1 | grep -q "^=[a-zA-Z0-9+/][a-zA-Z0-9+/=]*$" &&
+	tail -n1 rawsig | grep -q "^---*END PGP SIGNATURE---*$" &&
+	test_must_be_empty errors
+'
+
+test_expect_success GPG 'show presence of gpgsig with custom format when gpg is missing without errors' '
+	echo Y > expected &&
+	git log -1 --format=%G+ sixth-signed >output 2>errors &&
+	test_cmp expected output &&
+	test_must_be_empty errors
+'
+
+test_expect_success GPG 'show presence of invalid gpgsig header' '
+	printf gpgsig >gpgsig-header &&
+	tee prank-signature <<-\EOF | sed "s/^/ /" >>gpgsig-header &&
+	this is not a signature but an awful...
+					   888
+					   888
+					   888
+	88888b.  888d888  8888b.  88888b.  888  888
+	888 "88b 888P"       "88b 888 "88b 888 .88P
+	888  888 888     .d888888 888  888 888888K
+	888 d88P 888     888  888 888  888 888 "88b
+	88888P"  888     "Y888888 888  888 888  888
+	888
+	888
+	888
+	EOF
+	git cat-file commit seventh-unsigned >bare-commit-data &&
+	sed "/^committer/r gpgsig-header" bare-commit-data >commit-data &&
+	git hash-object -w -t commit commit-data >commit &&
+	echo Y >expected &&
+	cat prank-signature >>expected &&
+	git log -n1 --format=format:%G+%n%GR $(cat commit) >actual 2>errors &&
+	test_cmp expected actual &&
+	test_must_be_empty errors
+'
+
 test_expect_success GPG 'log.showsignature behaves like --show-signature' '
 	test_config log.showsignature true &&
 	git show initial >actual &&
-- 
2.19.1

