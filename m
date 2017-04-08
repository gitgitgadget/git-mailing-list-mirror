Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 074D620970
	for <e@80x24.org>; Sat,  8 Apr 2017 13:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdDHN0P (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 09:26:15 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33143 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751812AbdDHN0M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 09:26:12 -0400
Received: by mail-wr0-f195.google.com with SMTP id g19so23519675wrb.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jbyhjHl989GC7famN7JQlG0fR7FT4JeqZ+OWji6ioao=;
        b=amQG6/nsReWo6GvgOIelLbrjEVwzZU0W1qZrSpdL2ebnbeDIwT/VrtQBosi5hWtkdv
         OPWdEZJDKSX+xb8Tma/RVokqyOJxl+ElPkIKpaMXqIknSs1eVjF+4xJxYJJAQuMXWQcG
         0PuBwBTAiTZxdE9OG+6UDW+aQJuyr0ObXjfOzE+6D97+Enl4NMA60GnQjJAhDcVY12zI
         TWD2wmrqgD5DOMuIn2cdRnGlea4msXodA4oWIfABUj3UYlWvnR7P4JD2CUXigPlkbL/4
         QjvtdmDFI6kJ1QtfyDdZDXHKeJSaRb9cBzuwGmiinUqKI+J/2m2vfV6YOCrPUyvusEeg
         UpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jbyhjHl989GC7famN7JQlG0fR7FT4JeqZ+OWji6ioao=;
        b=r9OAB7abwPOzXPeOMiQ8VJX4H4Ty61N2MUTH6YbCpTdXl5CxmVakwmQ1Y4rcoZmaGj
         BjoD3Qm46xtuV7oysoy+QPcR02hKbi0sATKOwOn/CsOii1zQtjv2b0HxMLds7u0ze+3h
         WRmJ295jY+dAbJjXDyk2OSJUV85h+4nvk46b4gKKxqcH6ytnENH/VhCPqBUV8kLwrkYf
         IQIbwA+JxZFlBK2J+gg2dNN7zKLDNxkKdYIlYW33WdnQ2nmurW4mPDItRM04kNG8cSs1
         26likyBhXxiNnug0rlt9Eh2AUZe1EEHMdMyiw3mCYRwlpG2MNwxbMPFIEzSChCi7veaV
         BI6A==
X-Gm-Message-State: AFeK/H1clmZXSGpaKe/NmKbX5sflSH28JIXtCa5ZGtf3x5J4IEYyWNOo+04A7dBU6qEPxA==
X-Received: by 10.223.162.198 with SMTP id t6mr41951266wra.155.1491657970346;
        Sat, 08 Apr 2017 06:26:10 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id v14sm2744864wmv.24.2017.04.08.06.26.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Apr 2017 06:26:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jeffrey Walton <noloader@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Kiedrowicz?= <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/12] grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
Date:   Sat,  8 Apr 2017 13:25:02 +0000
Message-Id: <20170408132506.5415-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170408132506.5415-1-avarab@gmail.com>
References: <20170408132506.5415-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the pattern types "pcre" & "pcre1" synonyms for long-standing
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
index 8564fe726d..1575f8f9ed 100644
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
index 83b0ee53be..b50f1dff43 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1522,4 +1522,14 @@ test_expect_success 'grep with thread options' '
 	test_must_fail git -c grep.threads=1 grep --threads=-1 st.*dio
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

