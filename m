Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805F11FE90
	for <e@80x24.org>; Wed, 19 Apr 2017 22:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934379AbdDSWlz (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 18:41:55 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36180 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765212AbdDSWlw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 18:41:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id q125so7515653wmd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 15:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+U4MDEDcqTWqkQV+scfPfys81jiTbcDqH65ggVmre20=;
        b=U83AQlxJ6+MESuq4KAgFKD6wZrYzcYivuU+qHRRNRRE0IZCgXhyYW/iIy8ir44xWzk
         WIfs1pLM2LfPwL4uMyARuj9takn7ndOdYuuFWn5VHFPxPL4HvF8CcmlzXkPsoZkfeEWu
         /ZLm7TE6Icxzj4kf97ky3bjyGUdPDX9sOBeajg3q5jKOEakIir81AECus2q6AtHb8NmV
         5CjSBYMmJxMn6bnqCmSs072zDiy5AqfsjgGFP8PTu1TYblVtOCRl9j6Y0M/eniZNFeCe
         G5GqjnBxkhYlxegUiufYVbs5gpOegnIzWv3Nkd8hX3+P08TiFuiDzFE1lF5FWNxgbtlE
         k8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+U4MDEDcqTWqkQV+scfPfys81jiTbcDqH65ggVmre20=;
        b=JZsQvmOhcTvUKHjOBMjFNPkBh+/e7SjQX688Kv5Z088z6+netPLc5OBKiMR9sIR8ir
         z5NwH7kEp3KVm30dq+bb6lQzSqOXt5vIC76jB/XpyjrDKPTUDAtkKkPFR3Je4vYC4Msh
         aukgBU30AKnKPtqdCQ/T0HCAVwjj+3B65ZRvH92XhMZss9lK9jaCUx7ZxGFcgP+VAirQ
         7CdbBQN3dvhKPOyqjP9HOeDDDR2eVofLNA89Db5mrzq69VamAr7wGFNdB1Sk4ModinWs
         lj+5ujvCEUermsDw5XM9l5tEAfxI12bFLT0Y9DlG4Xh1625J1Mtf6TsmJ7G9M8X73CPz
         YauQ==
X-Gm-Message-State: AN3rC/6AT+v91KL2BJ1ItAZjnhjGGOK9Zbgu1iZdHU1vj1Z7ibqTUA/5
        lwsowGJPo1m+xLhM8/k=
X-Received: by 10.28.169.15 with SMTP id s15mr248147wme.2.1492641700820;
        Wed, 19 Apr 2017 15:41:40 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id q130sm21128996wmd.29.2017.04.19.15.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 15:41:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?Zolt=C3=A1n=20Herczeg?= <hzmester@freemail.hu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/13] grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
Date:   Wed, 19 Apr 2017 22:40:47 +0000
Message-Id: <20170419224053.8920-8-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170419224053.8920-1-avarab@gmail.com>
References: <20170419224053.8920-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the pattern types "pcre" & "pcre1" synonyms for the long-standing
"perl" grep.patternType.

This change is part of a longer patch series to add pcre2 support to
Git. It's nice to be able to performance test PCRE v1 v.s. v2 without
having to recompile git, and doing that via grep.patternType makes
sense.

However, just adding "pcre2" when we only have "perl" would be
confusing, so start by adding a "pcre" & "pcre1" synonym.

In the future "perl" and "pcre" might be changed to default to "pcre2"
instead of "pcre1", and depending on how Git is compiled the more
specific "pcre1" or "pcre2" pattern types might produce an error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config.txt |  9 +++++++++
 grep.c                   |  4 +++-
 t/t7810-grep.sh          | 10 ++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 475e874d51..5ef12d0694 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1624,6 +1624,15 @@ grep.patternType::
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
 	value 'default' will return to the default matching behavior.
++
+The 'pcre' and 'pcre1' values are synonyms for 'perl'. The other
+values starting with 'pcre' are reserved for future use, e.g. if we'd
+like to use 'pcre2' for the PCRE v2 library.
++
+In the future 'perl' and 'pcre' might become synonyms for some other
+implementation or PCRE version, such as 'pcre2', while the more
+specific 'pcre1' & 'pcre2' might throw errors depending on whether git
+is compiled to include those libraries.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
diff --git a/grep.c b/grep.c
index 59ae7809f2..506545c0ee 100644
--- a/grep.c
+++ b/grep.c
@@ -60,7 +60,9 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 		return GREP_PATTERN_TYPE_ERE;
 	else if (!strcmp(arg, "fixed"))
 		return GREP_PATTERN_TYPE_FIXED;
-	else if (!strcmp(arg, "perl"))
+	else if (!strcmp(arg, "perl") ||
+		 !strcmp(arg, "pcre") ||
+		 !strcmp(arg, "pcre1"))
 		return GREP_PATTERN_TYPE_PCRE;
 	die("bad %s argument: %s", opt, arg);
 }
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 8baed0f37d..0fb95c7438 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1512,4 +1512,14 @@ test_expect_success 'grep does not report i-t-a and assume unchanged with -L' '
 	test_cmp expected actual
 '
 
+test_expect_success LIBPCRE "grep with grep.patternType synonyms perl/pcre/pcre1" '
+	echo "#include <stdio.h>" >expected &&
+	git -c grep.patternType=perl  grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	git -c grep.patternType=pcre  grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual &&
+	git -c grep.patternType=pcre1 grep -h --no-line-number "st(?=dio)" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0

