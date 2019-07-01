Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653091F461
	for <e@80x24.org>; Mon,  1 Jul 2019 21:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfGAVVX (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 17:21:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33654 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAVVW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 17:21:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so926442wme.0
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 14:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/8/hF+vDfQwR9XYatXRcM5x39X44gHxyP2myd+s9iBw=;
        b=f/d2VOxYET6Kfh31iEcoyeOdR3IcZGLJY6ueWX0Zjs1jdj1ARPRjXGp8akxTlDoKaZ
         EfshztyLSEXKSOaIFgU/0MrEn9Az7zK1M0TSUwJzEaJEiFxEbok+lDoE3tHRonL02XF+
         XlWB/9T2Jng3bQrWuJ+ZPbS2aXfZ2+eX86Xfkx9ZiZL+UTLX4NN0NaHtwx5g99/HYGZj
         JWDbXYLvXpMa1wn1GB69u4pXDwdd5u53ul4Qo8FQnAWmiHAntXiV4ik485v0rQp40/Go
         YVcg8/Y/lxgc/MNPv5+NiRkVc4pc7/Z2vHp6UzAIbd5JH6n9dNHAFjToFbY+U9rtlVdl
         iK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8/hF+vDfQwR9XYatXRcM5x39X44gHxyP2myd+s9iBw=;
        b=KiEuoI3yqNpVX175D7kOnsG6v1mx9gii7rWOuEjztqWoJz5wpulzt7vws+sswY/IMI
         j0MAqUJ8uA2BTbNZE/m6W4ByIE4aX1OpOn6fBR2LSq9Z1OHGz+W0lW0AB/7zdvd5PePd
         1boRIY2ffWzFd8AzkYuyn3gbby21wS/jrlnSbIwhFckU/InEIpz3CTvASa6i83iuaWLw
         N+O1BtTDXF8jF8QliOiFqSz+s3QwQ6zHBehiqY5rAwhtwzf6IjC3W2g4WOBp/+l/A0BR
         GlPdRq5ovhsZCGFbwShqjXlweX41a9rmPtlNMoM2A6UmJk0FoMLgl/FsuQRIe1zsee7s
         pyuA==
X-Gm-Message-State: APjAAAWf+CsOE7VfuijwqZt9VXBAEtp7o30gHI9Ws2RiPnJtS1xu7anA
        B+jVwruqenIu2nqfsHZeWeBbvQNxF3c=
X-Google-Smtp-Source: APXvYqzk+laz0I/HVV76MGHAj3eKy4x2xhavjJXiMhuPKSuuCExeClw/YJ9cgUJyDe9duAJ9a6LFVA==
X-Received: by 2002:a7b:cd84:: with SMTP id y4mr660525wmj.79.1562016080194;
        Mon, 01 Jul 2019 14:21:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s2sm466824wmj.33.2019.07.01.14.21.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 14:21:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/10] grep: drop support for \0 in --fixed-strings <pattern>
Date:   Mon,  1 Jul 2019 23:20:58 +0200
Message-Id: <20190701212100.27850-9-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190627233912.7117-1-avarab@gmail.com>
References: <20190627233912.7117-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change "-f <file>" to not support patterns with a NUL-byte in them
under --fixed-strings. We'll now only support these under
"--perl-regexp" with PCRE v2.

A previous change to grep's documentation changed the description of
"-f <file>" to be vague enough as to not promise that this would work.
By dropping support for this we make it a whole lot easier to move
away from the kwset backend, which we'll do in a subsequent change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c                         |  6 +--
 t/t7816-grep-binary-pattern.sh | 82 +++++++++++++++++-----------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/grep.c b/grep.c
index d6603bc950..8d0fff316c 100644
--- a/grep.c
+++ b/grep.c
@@ -644,6 +644,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
 
+	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
+
 	/*
 	 * Even when -F (fixed) asks us to do a non-regexp search, we
 	 * may not be able to correctly case-fold when -i
@@ -666,9 +669,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
-		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
-
 	if (opt->fixed) {
 		/*
 		 * We come here when the pattern has the non-ascii
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 9e09bd5d6a..60bab291e4 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -60,23 +60,23 @@ test_expect_success 'setup' "
 "
 
 # Simple fixed-string matching that can use kwset (no -i && non-ASCII)
-nul_match 1 1 1 '-F' 'yQf'
-nul_match 0 0 0 '-F' 'yQx'
-nul_match 1 1 1 '-Fi' 'YQf'
-nul_match 0 0 0 '-Fi' 'YQx'
-nul_match 1 1 1 '' 'yQf'
-nul_match 0 0 0 '' 'yQx'
-nul_match 1 1 1 '' 'æQð'
-nul_match 1 1 1 '-F' 'eQm[*]c'
-nul_match 1 1 1 '-Fi' 'EQM[*]C'
+nul_match P P P '-F' 'yQf'
+nul_match P P P '-F' 'yQx'
+nul_match P P P '-Fi' 'YQf'
+nul_match P P P '-Fi' 'YQx'
+nul_match P P 1 '' 'yQf'
+nul_match P P 0 '' 'yQx'
+nul_match P P 1 '' 'æQð'
+nul_match P P P '-F' 'eQm[*]c'
+nul_match P P P '-Fi' 'EQM[*]C'
 
 # Regex patterns that would match but shouldn't with -F
-nul_match 0 0 0 '-F' 'yQ[f]'
-nul_match 0 0 0 '-F' '[y]Qf'
-nul_match 0 0 0 '-Fi' 'YQ[F]'
-nul_match 0 0 0 '-Fi' '[Y]QF'
-nul_match 0 0 0 '-F' 'æQ[ð]'
-nul_match 0 0 0 '-F' '[æ]Qð'
+nul_match P P P '-F' 'yQ[f]'
+nul_match P P P '-F' '[y]Qf'
+nul_match P P P '-Fi' 'YQ[F]'
+nul_match P P P '-Fi' '[Y]QF'
+nul_match P P P '-F' 'æQ[ð]'
+nul_match P P P '-F' '[æ]Qð'
 
 # The -F kwset codepath can't handle -i && non-ASCII...
 nul_match P 1 1 '-i' '[æ]Qð'
@@ -90,38 +90,38 @@ nul_match P 0 1 '-i' '[Æ]Qð'
 nul_match P 0 1 '-i' 'ÆQÐ'
 
 # \0 in regexes can only work with -P & PCRE v2
-nul_match P 1 1 '' 'yQ[f]'
-nul_match P 1 1 '' '[y]Qf'
-nul_match P 1 1 '-i' 'YQ[F]'
-nul_match P 1 1 '-i' '[Y]Qf'
-nul_match P 1 1 '' 'æQ[ð]'
-nul_match P 1 1 '' '[æ]Qð'
-nul_match P 0 1 '-i' 'ÆQ[Ð]'
-nul_match P 1 1 '' 'eQm.*cQ'
-nul_match P 1 1 '-i' 'EQM.*cQ'
-nul_match P 0 0 '' 'eQm[*]c'
-nul_match P 0 0 '-i' 'EQM[*]C'
+nul_match P P 1 '' 'yQ[f]'
+nul_match P P 1 '' '[y]Qf'
+nul_match P P 1 '-i' 'YQ[F]'
+nul_match P P 1 '-i' '[Y]Qf'
+nul_match P P 1 '' 'æQ[ð]'
+nul_match P P 1 '' '[æ]Qð'
+nul_match P P 1 '-i' 'ÆQ[Ð]'
+nul_match P P 1 '' 'eQm.*cQ'
+nul_match P P 1 '-i' 'EQM.*cQ'
+nul_match P P 0 '' 'eQm[*]c'
+nul_match P P 0 '-i' 'EQM[*]C'
 
 # Assert that we're using REG_STARTEND and the pattern doesn't match
 # just because it's cut off at the first \0.
-nul_match 0 0 0 '-i' 'NOMATCHQð'
-nul_match P 0 0 '-i' '[Æ]QNOMATCH'
-nul_match P 0 0 '-i' '[æ]QNOMATCH'
+nul_match P P 0 '-i' 'NOMATCHQð'
+nul_match P P 0 '-i' '[Æ]QNOMATCH'
+nul_match P P 0 '-i' '[æ]QNOMATCH'
 
 # Ensure that the matcher doesn't regress to something that stops at
 # \0
-nul_match 0 0 0 '-F' 'yQ[f]'
-nul_match 0 0 0 '-Fi' 'YQ[F]'
-nul_match 0 0 0 '' 'yQNOMATCH'
-nul_match 0 0 0 '' 'QNOMATCH'
-nul_match 0 0 0 '-i' 'YQNOMATCH'
-nul_match 0 0 0 '-i' 'QNOMATCH'
-nul_match 0 0 0 '-F' 'æQ[ð]'
+nul_match P P P '-F' 'yQ[f]'
+nul_match P P P '-Fi' 'YQ[F]'
+nul_match P P 0 '' 'yQNOMATCH'
+nul_match P P 0 '' 'QNOMATCH'
+nul_match P P 0 '-i' 'YQNOMATCH'
+nul_match P P 0 '-i' 'QNOMATCH'
+nul_match P P P '-F' 'æQ[ð]'
 nul_match P P P '-Fi' 'ÆQ[Ð]'
-nul_match P 0 1 '-i' 'ÆQ[Ð]'
-nul_match 0 0 0 '' 'yQNÓMATCH'
-nul_match 0 0 0 '' 'QNÓMATCH'
-nul_match 0 0 0 '-i' 'YQNÓMATCH'
-nul_match 0 0 0 '-i' 'QNÓMATCH'
+nul_match P P 1 '-i' 'ÆQ[Ð]'
+nul_match P P 0 '' 'yQNÓMATCH'
+nul_match P P 0 '' 'QNÓMATCH'
+nul_match P P 0 '-i' 'YQNÓMATCH'
+nul_match P P 0 '-i' 'QNÓMATCH'
 
 test_done
-- 
2.22.0.455.g172b71a6c5

