Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85C391F461
	for <e@80x24.org>; Thu, 27 Jun 2019 23:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfF0Xjf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 19:39:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53051 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfF0Xje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 19:39:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so7284037wms.2
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uSzdJGlC+7CuGH0kChg3GSifKwVp2uSbk5Z+EiJb4m8=;
        b=K3XFDTeshVch7B42/eFWos9CAIN+BdLjioSGE9GqzCNn8/bwUCGj3pQyLpP2CGLFGr
         ntmaJPDqPpOG4YWhqm7Jyq4FsFagtKgA9MtEAEDekQCo3C4vNZx8nneh1JhV7z0asH7h
         oH12QXtp2zEAnRmSJKNAllYXJonRaBCipe3wP++TnTZQUTpGWPoejAvnefUCeQNPPCTs
         VXKZspxvpeCGXu6iR44dhjQsf7mqXxaaqxfGAgtJ90+pQN64qDf4m7WNvspnD2qtUW8Z
         7A1oDsHyd9TqZ194znHBbTaZ0erP8JZTdpnGG8Chlitw9dZM3fPxhHkPIoL9kWPpmfFS
         726Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uSzdJGlC+7CuGH0kChg3GSifKwVp2uSbk5Z+EiJb4m8=;
        b=Ae3xXZqbjhiu3qVn2vlz1qP3yo2GUNs1/T676bqQ2jSnBUtdcf2/un8CSMzFvcvIz9
         8PhKjd/8TvnTaeqCKUOsH+X7zhBvqLvgYaUa4bCNMrQfTl3WqHk+a9GCtwtMGwHKD9qj
         edIzo7oXfqIhuP7F/9Hx6ejd41cA/qoMlORCgIxLXZEF4Pw7A7RBzI9RXc4AB1vemfWz
         6NtnSEry+kVlfcSEIFW1DYjJiQ95Ab3fipfp5Szrfh6CRjU7/W7DvRhhFa7BHnVdotXb
         qX3p5oYIH7IhMuUfu/XRcIP3BkqGglq51Bfci+XEMexhTJUakMLUYKeinnppnhvdwQSt
         hgNg==
X-Gm-Message-State: APjAAAU6eKcJZwYhJXDIsyHeMS93Nk1iU/vXjo+mtjL7wXLKKBW9sYWF
        id46u3lGcIXgbMY0asbfr/J2EFTunDE=
X-Google-Smtp-Source: APXvYqz4qS36Wt9ep9ijRU9StuKgIWbAMKcGrIPG3UNKpvmY9s0mnsMT+QcoHb6aR23XCXNUDEjEag==
X-Received: by 2002:a1c:8017:: with SMTP id b23mr4752851wmd.117.1561678770864;
        Thu, 27 Jun 2019 16:39:30 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x16sm720530wmj.4.2019.06.27.16.39.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 16:39:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     git-packagers@googlegroups.com, gitgitgadget@gmail.com,
        gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] grep: make the behavior for NUL-byte in patterns sane
Date:   Fri, 28 Jun 2019 01:39:09 +0200
Message-Id: <20190627233912.7117-7-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.455.g172b71a6c5
In-Reply-To: <20190626000329.32475-1-avarab@gmail.com>
References: <20190626000329.32475-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The behavior of "grep" when patterns contained a NUL-byte has always
been haphazard, and has served the vagaries of the implementation more
than anything else. A pattern containing a NUL-byte can only be
provided via "-f <file>". Since pickaxe (log search) has no such flag
the NUL-byte in patterns has only ever been supported by "grep" (and
not "log --grep").

Since 9eceddeec6 ("Use kwset in grep", 2011-08-21) patterns containing
"\0" were considered fixed. In 966be95549 ("grep: add tests to fix
blind spots with \0 patterns", 2017-05-20) I added tests for this
behavior.

Change the behavior to do the obvious thing, i.e. don't silently
discard a regex pattern and make it implicitly fixed just because they
contain a NUL-byte. Instead die if the backend in question can't
handle them, e.g. --basic-regexp is combined with such a pattern.

This is desired because from a user's point of view it's the obvious
thing to do. Whether we support BRE/ERE/Perl syntax is different from
whether our implementation is limited by C-strings. These patterns are
obscure enough that I think this behavior change is OK, especially
since we never documented the old behavior.

Doing this also makes it easier to replace the kwset backend with
something else, since we'll no longer strictly need it for anything we
can't easily use another fixed-string backend for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-grep.txt     |  17 ++++
 grep.c                         |  23 ++---
 t/t7816-grep-binary-pattern.sh | 159 ++++++++++++++++++---------------
 3 files changed, 110 insertions(+), 89 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 2d27969057..c89fb569e3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -271,6 +271,23 @@ providing this option will cause it to die.
 
 -f <file>::
 	Read patterns from <file>, one per line.
++
+Passing the pattern via <file> allows for providing a search pattern
+containing a \0.
++
+Not all pattern types support patterns containing \0. Git will error
+out if a given pattern type can't support such a pattern. The
+`--perl-regexp` pattern type when compiled against the PCRE v2 backend
+has the widest support for these types of patterns.
++
+In versions of Git before 2.23.0 patterns containing \0 would be
+silently considered fixed. This was never documented, there were also
+odd and undocumented interactions between e.g. non-ASCII patterns
+containing \0 and `--ignore-case`.
++
+In future versions we may learn to support patterns containing \0 for
+more search backends, until then we'll die when the pattern type in
+question doesn't support them.
 
 -e::
 	The next parameter is the pattern. This option has to be
diff --git a/grep.c b/grep.c
index 4e8d0645a8..d6603bc950 100644
--- a/grep.c
+++ b/grep.c
@@ -368,18 +368,6 @@ static int is_fixed(const char *s, size_t len)
 	return 1;
 }
 
-static int has_null(const char *s, size_t len)
-{
-	/*
-	 * regcomp cannot accept patterns with NULs so when using it
-	 * we consider any pattern containing a NUL fixed.
-	 */
-	if (memchr(s, 0, len))
-		return 1;
-
-	return 0;
-}
-
 #ifdef USE_LIBPCRE1
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 {
@@ -668,9 +656,7 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	 * simple string match using kws.  p->fixed tells us if we
 	 * want to use kws.
 	 */
-	if (opt->fixed ||
-	    has_null(p->pattern, p->patternlen) ||
-	    is_fixed(p->pattern, p->patternlen))
+	if (opt->fixed || is_fixed(p->pattern, p->patternlen))
 		p->fixed = !p->ignore_case || !has_non_ascii(p->pattern);
 
 	if (p->fixed) {
@@ -678,7 +664,12 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
-	} else if (opt->fixed) {
+	}
+
+	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
+
+	if (opt->fixed) {
 		/*
 		 * We come here when the pattern has the non-ascii
 		 * characters we cannot case-fold, and asked to
diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 4060dbd679..9e09bd5d6a 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -2,113 +2,126 @@
 
 test_description='git grep with a binary pattern files'
 
-. ./test-lib.sh
+. ./lib-gettext.sh
 
-nul_match () {
+nul_match_internal () {
 	matches=$1
-	flags=$2
-	pattern=$3
+	prereqs=$2
+	lc_all=$3
+	extra_flags=$4
+	flags=$5
+	pattern=$6
 	pattern_human=$(echo "$pattern" | sed 's/Q/<NUL>/g')
 
 	if test "$matches" = 1
 	then
-		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+		test_expect_success $prereqs "LC_ALL='$lc_all' git grep $extra_flags -f f $flags '$pattern_human' a" "
 			printf '$pattern' | q_to_nul >f &&
-			git grep -f f $flags a
+			LC_ALL='$lc_all' git grep $extra_flags -f f $flags a
 		"
 	elif test "$matches" = 0
 	then
-		test_expect_success "git grep -f f $flags '$pattern_human' a" "
+		test_expect_success $prereqs "LC_ALL='$lc_all' git grep $extra_flags -f f $flags '$pattern_human' a" "
+			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
-			test_must_fail git grep -f f $flags a
+			test_must_fail env LC_ALL=\"$lc_all\" git grep $extra_flags -f f $flags a 2>stderr &&
+			test_i18ngrep ! 'This is only supported with -P under PCRE v2' stderr
 		"
-	elif test "$matches" = T1
+	elif test "$matches" = P
 	then
-		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
+		test_expect_success $prereqs "error, PCRE v2 only: LC_ALL='$lc_all' git grep -f f $flags '$pattern_human' a" "
+			>stderr &&
 			printf '$pattern' | q_to_nul >f &&
-			git grep -f f $flags a
-		"
-	elif test "$matches" = T0
-	then
-		test_expect_failure "git grep -f f $flags '$pattern_human' a" "
-			printf '$pattern' | q_to_nul >f &&
-			test_must_fail git grep -f f $flags a
+			test_must_fail env LC_ALL=\"$lc_all\" git grep -f f $flags a 2>stderr &&
+			test_i18ngrep 'This is only supported with -P under PCRE v2' stderr
 		"
 	else
 		test_expect_success "PANIC: Test framework error. Unknown matches value $matches" 'false'
 	fi
 }
 
+nul_match () {
+	matches=$1
+	matches_pcre2=$2
+	matches_pcre2_locale=$3
+	flags=$4
+	pattern=$5
+	pattern_human=$(echo "$pattern" | sed 's/Q/<NUL>/g')
+
+	nul_match_internal "$matches" "" "C" "" "$flags" "$pattern"
+	nul_match_internal "$matches_pcre2" "LIBPCRE2" "C" "-P" "$flags" "$pattern"
+	nul_match_internal "$matches_pcre2_locale" "LIBPCRE2,GETTEXT_LOCALE" "$is_IS_locale" "-P" "$flags" "$pattern"
+}
+
 test_expect_success 'setup' "
 	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
 	git commit -m.
 "
 
-nul_match 1 '-F' 'yQf'
-nul_match 0 '-F' 'yQx'
-nul_match 1 '-Fi' 'YQf'
-nul_match 0 '-Fi' 'YQx'
-nul_match 1 '' 'yQf'
-nul_match 0 '' 'yQx'
-nul_match 1 '' 'æQð'
-nul_match 1 '-F' 'eQm[*]c'
-nul_match 1 '-Fi' 'EQM[*]C'
+# Simple fixed-string matching that can use kwset (no -i && non-ASCII)
+nul_match 1 1 1 '-F' 'yQf'
+nul_match 0 0 0 '-F' 'yQx'
+nul_match 1 1 1 '-Fi' 'YQf'
+nul_match 0 0 0 '-Fi' 'YQx'
+nul_match 1 1 1 '' 'yQf'
+nul_match 0 0 0 '' 'yQx'
+nul_match 1 1 1 '' 'æQð'
+nul_match 1 1 1 '-F' 'eQm[*]c'
+nul_match 1 1 1 '-Fi' 'EQM[*]C'
 
 # Regex patterns that would match but shouldn't with -F
-nul_match 0 '-F' 'yQ[f]'
-nul_match 0 '-F' '[y]Qf'
-nul_match 0 '-Fi' 'YQ[F]'
-nul_match 0 '-Fi' '[Y]QF'
-nul_match 0 '-F' 'æQ[ð]'
-nul_match 0 '-F' '[æ]Qð'
-nul_match 0 '-Fi' 'ÆQ[Ð]'
-nul_match 0 '-Fi' '[Æ]QÐ'
+nul_match 0 0 0 '-F' 'yQ[f]'
+nul_match 0 0 0 '-F' '[y]Qf'
+nul_match 0 0 0 '-Fi' 'YQ[F]'
+nul_match 0 0 0 '-Fi' '[Y]QF'
+nul_match 0 0 0 '-F' 'æQ[ð]'
+nul_match 0 0 0 '-F' '[æ]Qð'
 
-# kwset is disabled on -i & non-ASCII. No way to match non-ASCII \0
-# patterns case-insensitively.
-nul_match T1 '-i' 'ÆQÐ'
+# The -F kwset codepath can't handle -i && non-ASCII...
+nul_match P 1 1 '-i' '[æ]Qð'
 
-# \0 implicitly disables regexes. This is an undocumented internal
-# limitation.
-nul_match T1 '' 'yQ[f]'
-nul_match T1 '' '[y]Qf'
-nul_match T1 '-i' 'YQ[F]'
-nul_match T1 '-i' '[Y]Qf'
-nul_match T1 '' 'æQ[ð]'
-nul_match T1 '' '[æ]Qð'
-nul_match T1 '-i' 'ÆQ[Ð]'
+# ...PCRE v2 only matches non-ASCII with -i casefolding under UTF-8
+# semantics
+nul_match P P P '-Fi' 'ÆQ[Ð]'
+nul_match P 0 1 '-i'  'ÆQ[Ð]'
+nul_match P 0 1 '-i'  '[Æ]QÐ'
+nul_match P 0 1 '-i' '[Æ]Qð'
+nul_match P 0 1 '-i' 'ÆQÐ'
 
-# ... because of \0 implicitly disabling regexes regexes that
-# should/shouldn't match don't do the right thing.
-nul_match T1 '' 'eQm.*cQ'
-nul_match T1 '-i' 'EQM.*cQ'
-nul_match T0 '' 'eQm[*]c'
-nul_match T0 '-i' 'EQM[*]C'
+# \0 in regexes can only work with -P & PCRE v2
+nul_match P 1 1 '' 'yQ[f]'
+nul_match P 1 1 '' '[y]Qf'
+nul_match P 1 1 '-i' 'YQ[F]'
+nul_match P 1 1 '-i' '[Y]Qf'
+nul_match P 1 1 '' 'æQ[ð]'
+nul_match P 1 1 '' '[æ]Qð'
+nul_match P 0 1 '-i' 'ÆQ[Ð]'
+nul_match P 1 1 '' 'eQm.*cQ'
+nul_match P 1 1 '-i' 'EQM.*cQ'
+nul_match P 0 0 '' 'eQm[*]c'
+nul_match P 0 0 '-i' 'EQM[*]C'
 
-# Due to the REG_STARTEND extension when kwset() is disabled on -i &
-# non-ASCII the string will be matched in its entirety, but the
-# pattern will be cut off at the first \0.
-nul_match 0 '-i' 'NOMATCHQð'
-nul_match T0 '-i' '[Æ]QNOMATCH'
-nul_match T0 '-i' '[æ]QNOMATCH'
-# Matches, but for the wrong reasons, just stops at [æ]
-nul_match 1 '-i' '[Æ]Qð'
-nul_match 1 '-i' '[æ]Qð'
+# Assert that we're using REG_STARTEND and the pattern doesn't match
+# just because it's cut off at the first \0.
+nul_match 0 0 0 '-i' 'NOMATCHQð'
+nul_match P 0 0 '-i' '[Æ]QNOMATCH'
+nul_match P 0 0 '-i' '[æ]QNOMATCH'
 
 # Ensure that the matcher doesn't regress to something that stops at
 # \0
-nul_match 0 '-F' 'yQ[f]'
-nul_match 0 '-Fi' 'YQ[F]'
-nul_match 0 '' 'yQNOMATCH'
-nul_match 0 '' 'QNOMATCH'
-nul_match 0 '-i' 'YQNOMATCH'
-nul_match 0 '-i' 'QNOMATCH'
-nul_match 0 '-F' 'æQ[ð]'
-nul_match 0 '-Fi' 'ÆQ[Ð]'
-nul_match 0 '' 'yQNÓMATCH'
-nul_match 0 '' 'QNÓMATCH'
-nul_match 0 '-i' 'YQNÓMATCH'
-nul_match 0 '-i' 'QNÓMATCH'
+nul_match 0 0 0 '-F' 'yQ[f]'
+nul_match 0 0 0 '-Fi' 'YQ[F]'
+nul_match 0 0 0 '' 'yQNOMATCH'
+nul_match 0 0 0 '' 'QNOMATCH'
+nul_match 0 0 0 '-i' 'YQNOMATCH'
+nul_match 0 0 0 '-i' 'QNOMATCH'
+nul_match 0 0 0 '-F' 'æQ[ð]'
+nul_match P P P '-Fi' 'ÆQ[Ð]'
+nul_match P 0 1 '-i' 'ÆQ[Ð]'
+nul_match 0 0 0 '' 'yQNÓMATCH'
+nul_match 0 0 0 '' 'QNÓMATCH'
+nul_match 0 0 0 '-i' 'YQNÓMATCH'
+nul_match 0 0 0 '-i' 'QNÓMATCH'
 
 test_done
-- 
2.22.0.455.g172b71a6c5

