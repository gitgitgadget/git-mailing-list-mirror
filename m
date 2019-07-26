Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D621F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387770AbfGZPJJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:09:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38820 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbfGZPJH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:09:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so54810536wrr.5
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UCbaawn9qITQQVmcx7WGR7ndms2+0yVqXlVziRzXhuY=;
        b=mCDP9L21Wzx+UC08PgO210NZER6dv0lscsGh1riUd3QcYXmQ/6uSRTeVK0o0u3eKyz
         UMrxbdGIXYVSv8cS3j3Rj5PBZe6iQtw443O6CiH657YKU7gmIt+AAqEUbkNtXTaNKb/+
         SnvtCncnXVa9ACR+mJJXc69LkAyC4qDKH4bijVwLZWfvFk5mnRku8PQiJrABmQ+iPZkY
         RVp5UVLF/lXEHr+Y8WX9nTZ+laevUFs9efN9jAKCiZNDqiUpvzmHdPBFLXqO+r8fSJza
         jlr/wmMj4wqjgHVVC1lymSkZKu6YWLdDAqcJFk9ns17Kcrce2Hq6ZCbHAiy21qy9w96j
         kqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UCbaawn9qITQQVmcx7WGR7ndms2+0yVqXlVziRzXhuY=;
        b=HboD/mf1WZ74Oy89El4IrGejsLnv5eylINz1rpW6RQUhYRPQ6HDHxHrU6/VNVr82M0
         KjBrem5NDpzeKtaSqsqzgtrpchhj+siYPpdsPA87J6nttU7K2MSCG8mPnUj150G53DRq
         DoHvdXuY0fZnIa52dwHwJvuJNN23MFaRSNi0Cuy6tBkN4dqT3O3HEFSi4xfoRFHMsBVU
         vp3DSl3wf2dZBt4zp4MGDhDfj5Et8L+M+ilOWVVyQ4UjHytHz9aka0qV9bVJU8VtwPIn
         cwuvLDZnOFUo7oAjwjTjEUvfeQ5Bxn8kouVdDXKCzkbmn+To6WHdoe24c/y1+jTyA/RQ
         yLIQ==
X-Gm-Message-State: APjAAAVUoVnvbQTGR3lu86fj9pqP12E4Wt+5yJEyOWr91f3o2QiIr5B/
        8c3ebWd8Jlti1OJHLZM1aKHoFPEM0KU=
X-Google-Smtp-Source: APXvYqxfQmA78N0V0cssm9jUpdOaJM8DsupAWi7OZBvalngkLNI5yzCK7bPi8b0vphh3f5EOADfKqA==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr104634014wrk.98.1564153745614;
        Fri, 26 Jul 2019 08:09:05 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p63sm4814341wmp.45.2019.07.26.08.09.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 08:09:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/8] grep: do not enter PCRE2_UTF mode on fixed matching
Date:   Fri, 26 Jul 2019 17:08:17 +0200
Message-Id: <20190726150818.6373-8-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190724151415.3698-1-avarab@gmail.com>
References: <20190724151415.3698-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As discussed in the last commit partially fix a bug introduced in
b65abcafc7 ("grep: use PCRE v2 for optimized fixed-string search",
2019-07-01). Because PCRE v2, unlike kwset, validates its UTF-8 input
we'd die on e.g.:

    fatal: pcre2_match failed with error code -22: UTF-8 error:
    isolated byte with 0x80 bit set

When grepping a non-ASCII fixed string. This is a more general problem
that's hard to fix, but we can at least fix the most common case of
grepping for a fixed string without "-i". I can't think of a reason
for why we'd turn on PCRE2_UTF when matching byte-for-byte like that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c                          | 3 ++-
 t/t7812-grep-icase-non-ascii.sh | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 5bc0f4f32a..c7c06ae08d 100644
--- a/grep.c
+++ b/grep.c
@@ -472,7 +472,8 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		}
 		options |= PCRE2_CASELESS;
 	}
-	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern))
+	if (!opt->ignore_locale && is_utf8_locale() && has_non_ascii(p->pattern) &&
+	    !(!opt->ignore_case && (p->fixed || p->is_fixed)))
 		options |= PCRE2_UTF;
 
 	p->pcre2_pattern = pcre2_compile((PCRE2_SPTR)p->pattern,
diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index 96c3572056..531eb59d57 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -68,9 +68,9 @@ test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep ASCII from invalid UT
 '
 
 test_expect_success GETTEXT_LOCALE,LIBPCRE2 'PCRE v2: grep non-ASCII from invalid UTF-8 data' '
-	test_might_fail git grep -h "æ" invalid-0x80 >actual &&
+	git grep -h "æ" invalid-0x80 >actual &&
 	test_cmp expected actual &&
-	test_must_fail git grep -h "(*NO_JIT)æ" invalid-0x80 &&
+	git grep -h "(*NO_JIT)æ" invalid-0x80 &&
 	test_cmp expected actual
 '
 
-- 
2.22.0.455.g172b71a6c5

