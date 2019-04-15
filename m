Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DCA120248
	for <e@80x24.org>; Mon, 15 Apr 2019 02:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfDOCzZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 22:55:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45202 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbfDOCzY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 22:55:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so19747594wra.12
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 19:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xFfhqbZXcQCFziTXAU4Xn4XwIU+tEMzYs5j9nGxdOSw=;
        b=lGaRy9kNz+YfHwYZxB02dUHBlZlzt9+EwiKsv/+Jvx3V89sD7e5HvNgG1ixPToe2E7
         1mnvzFPhcDLnrb/BYNZ+zOVW2sXsMEPf3qY4iMbLpI7pHKCU0hBJOqYvaWa2Za+6EhfJ
         25xRWDnGdvyYnAzDkzL6hJ8Xk6C7lvq805X32ChYE6crbipcCMB+bS1dhNYlL9xmN07Q
         3RMaIv1w+Yg9jSlKeQSXedF2aO/bGQVXjy0EnM2guaVDZVLgOhTHqHvSbF53DhkK9F8k
         f6TgTWYlRLBai2KF20HrwgDRdw1FaGaXrXwIpeKWPh7XtF5QmbJkiPnAem7vz52x2YDc
         o63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xFfhqbZXcQCFziTXAU4Xn4XwIU+tEMzYs5j9nGxdOSw=;
        b=VI1fHnNtVydqowcCHJWRFaKuD2ADWLBv0WmUCL+pCNRH9+hfatJC57FcOWq9dmT4b8
         y9DSUMU+DPikaICAepot43lCzbOJmt4yZaJgqFcrN+1bOD2a0/gxAo6S6AgRomh0rfvB
         PSHKJffFFCHQcg5QYPMJzfoUZCBMEegS6+KkXAGqZDhbVowwMy2AcWXWsANum+DnU/En
         zs7rLbu6GDh+kXlirnFBKs1sLrXV7BM71A66GzqJhfcpHhH55FARiLxi5WuOaMj34S/M
         tHfdcJO+bZis1OHzNcYLZHbxL2tg2zCaYtCXl3bZXRsYX8nqw6wQFccs12EeuRhlb9DB
         v7IA==
X-Gm-Message-State: APjAAAXGgOyBwtRXItAiR9kjq/RFvQKPnKwH43KQsZWNPNrlMXBdftHG
        vqRLqhro6D1pW4eHRdusorw=
X-Google-Smtp-Source: APXvYqxp3cP4TuqtjnH3mgiGhNSaQQZghUCe+Q9ZO2tPh82u1ICxSYyGsiEH57uWNFvF6KJA8Xb8Xw==
X-Received: by 2002:adf:b68d:: with SMTP id j13mr47225262wre.50.1555296921982;
        Sun, 14 Apr 2019 19:55:21 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d3sm34641288wmf.46.2019.04.14.19.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 19:55:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options (by default)
References: <pull.167.git.gitgitgadget@gmail.com>
        <pull.167.v2.git.gitgitgadget@gmail.com>
        <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com>
        <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 15 Apr 2019 11:55:20 +0900
In-Reply-To: <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 14 Apr 2019 11:35:58 +0900")
Message-ID: <xmqqy34cugdj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:


> Do you mean more like
> ...
> I think I can agree with either of the two positions...

I am guessing from the earlier iteration that you wanted to say
"unless it is given explicitly, we turn it on".

As this last-minute style update that was botched, and a typofix in
the proposed log message in 8/8, are the only differences, let me
locally fix 8/8 up and replace it.

It was very good that this round did not have to touch 1/8 which is
shared with Denton's keep-base topic; otherwise replacing would have
been a little bit messier.

Here is what I'll use (unless it gets further replaced by v3 or
later, that is).

Thanks.

-- >8 --
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Fri, 12 Apr 2019 02:37:24 -0700
Subject: [PATCH v2bis 8/8] tests: disallow the use of abbreviated options (by default)

Git's command-line parsers support uniquely abbreviated options, e.g.
`git init --ba` would automatically expand `--ba` to `--bare`.

This is a very convenient feature in every day life for Git users, in
particular when tab completion is not available.

However, it is not a good idea to rely on that in Git's test suite, as
something that is a unique abbreviation of a command line option today
might no longer be a unique abbreviation tomorrow.

For example, if a future contribution added a new mode
`git init --babyproofing` and a previously-introduced test case used the
fact that `git init --ba` expanded to `git init --bare`, that future
contribution would now have to touch seemingly unrelated tests just to
keep the test suite from failing.

So let's disallow abbreviated options in the test suite by default.

Note: for ease of implementation, this patch really only touches the
`parse-options` machinery: more and more hand-rolled option parsers are
converted to use that internal API, and more and more scripts are
converted to built-ins (naturally using the parse-options API, too), so
in practice this catches most issues, and is definitely the biggest bang
for the buck.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c          |  9 +++++++++
 t/README                 |  4 ++++
 t/t0040-parse-options.sh | 14 +++++++++++++-
 t/test-lib.sh            |  7 +++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index cec74522e5..acc3a93660 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,6 +6,8 @@
 #include "color.h"
 #include "utf8.h"
 
+static int disallow_abbreviated_options;
+
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
@@ -344,6 +346,10 @@ static enum parse_opt_result parse_long_opt(
 		return get_value(p, options, all_opts, flags ^ opt_flags);
 	}
 
+	if (disallow_abbreviated_options && (ambiguous_option || abbrev_option))
+		die("disallowed abbreviated or ambiguous option '%.*s'",
+		    (int)(arg_end - arg), arg);
+
 	if (ambiguous_option) {
 		error(_("ambiguous option: %s "
 			"(could be --%s%s or --%s%s)"),
@@ -708,6 +714,9 @@ int parse_options(int argc, const char **argv, const char *prefix,
 {
 	struct parse_opt_ctx_t ctx;
 
+	disallow_abbreviated_options =
+		git_env_bool("GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS", 0);
+
 	parse_options_start(&ctx, argc, argv, prefix, options, flags);
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
diff --git a/t/README b/t/README
index 656288edce..9ed3051a1c 100644
--- a/t/README
+++ b/t/README
@@ -399,6 +399,10 @@ GIT_TEST_SIDEBAND_ALL=<boolean>, when true, overrides the
 fetch-pack to not request sideband-all (even if the server advertises
 sideband-all).
 
+GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
+the default when running tests), errors out when an abbreviated option
+is used.
+
 Naming Tests
 ------------
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index b8f366c442..800b3ea5f5 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -203,20 +203,24 @@ file: (not set)
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --int 2 --boolean --no-bo >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
 '
 
 test_expect_success 'unambiguously abbreviated option with "="' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --expect="integer: 2" --int=2
 '
 
 test_expect_success 'ambiguously abbreviated option' '
-	test_expect_code 129 test-tool parse-options --strin 123
+	test_expect_code 129 env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+	test-tool parse-options --strin 123
 '
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --expect="string: 123" --st 123
 '
 
@@ -325,6 +329,7 @@ file: (not set)
 EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
 	test-tool parse-options --no-ambig >output 2>output.err &&
 	test_must_be_empty output.err &&
 	test_cmp expect output
@@ -370,4 +375,11 @@ test_expect_success '--no-verbose resets multiple verbose to 0' '
 	test-tool parse-options --expect="verbose: 0" -v -v -v --no-verbose
 '
 
+test_expect_success 'GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS works' '
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=false \
+		test-tool parse-options --ye &&
+	test_must_fail env GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true \
+		test-tool parse-options --ye
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 562c57e685..c14ebe68d3 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,6 +57,13 @@ fi
 . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
 export PERL_PATH SHELL_PATH
 
+# Disallow the use of abbreviated options in the test suite by default
+if test -z "${GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS}"
+then
+	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
+	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
+fi
+
 ################################################################
 # It appears that people try to run tests without building...
 "${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
-- 
2.21.0-313-ge35b8cb8e2


