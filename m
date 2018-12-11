Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED07C20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeLKMmv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:42:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51745 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMmv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:42:51 -0500
Received: by mail-wm1-f67.google.com with SMTP id s14so2076917wmh.1
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 04:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=pYzmuFAnCb1qQ0234N/LOXJkpZSaQ9dvSKJSrYRmCO8=;
        b=fiSlA1nY8ONflVc6S9pdI6ZdKiBhcCaL7n+QIL6qSYFV9yPa3/EmKNBvNjqbWcgTZK
         8+qvwgj72riAxHklN6lwnpGrR12LrfxGyvM7GbXXW0ouZjzgKkLtRlOXARYGM25XD5D2
         r2mqSoM6pnPwNDMj819bBQDFO60LL3Nny68F49WYuOc0UO66IQXZsvvMM3fkHs2Rdaah
         35kN33tudnoutzp+67DPxrUSf8wbjKFYy6FyZkVbSdU7ZTsfFF94gceN1conqWsSYfhm
         LHNwUgL0V0/mZBHxwQ81a2cYNM4Q2CP9MDZKKKiGdlTnuvk2yrZrfuNPejkM7xaBkI+T
         d3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=pYzmuFAnCb1qQ0234N/LOXJkpZSaQ9dvSKJSrYRmCO8=;
        b=Lmp2TAr44Suf72jAG9bKfHLKE5OpRKb11sH2C/XWElJneGGAhgIDi6eXOcxdMBXnZi
         vKuGNg2ugB8l4N3RYexixt1cKc4O1M/ulottdKZqYJf2aew299H0tAAZq3y5dRXzIBBM
         6b/RFK8RD+y0+o+JU/fASVmGFDV55eKRgiRSgpli8Vs3JUuK5vKmrz6gt4BxSFPjHQ7F
         kELrTWaK1AfWgnklzW2e2eOCGI+Api4CwmtvZYafjvJE0YxrbigwtoO7WPcE7a6OULKY
         1M8tmsOjT3DCvmnnF4T5iovSQyhUup6FEqFvwzuw8oUjdgJI3yYyAopELRMCqCAiWAu8
         mKIA==
X-Gm-Message-State: AA+aEWY+ANuXzlkBE0ckX+6dkzZzCEuzLD9mip2KeQIwJsuMWofvmOex
        8mLyi3ixvaDVlUYQ24n0PQA=
X-Google-Smtp-Source: AFSGD/VcyaeZlg0rxts+KjdQRSwTU+EdWJgUxv2LQu8YuPnt6I/W0qwGY/9p2QP5MnwaO7QwF0xf4A==
X-Received: by 2002:a1c:83c8:: with SMTP id f191mr2152465wmd.134.1544532168350;
        Tue, 11 Dec 2018 04:42:48 -0800 (PST)
Received: from szeder.dev (x4db2a4b1.dyn.telefonica.de. [77.178.164.177])
        by smtp.gmail.com with ESMTPSA id f15sm15579132wrt.10.2018.12.11.04.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 04:42:47 -0800 (PST)
Date:   Tue, 11 Dec 2018 13:42:45 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/7] test-lib: parse some --options earlier
Message-ID: <20181211124245.GT30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181209225628.22216-3-szeder.dev@gmail.com>
 <20181211110919.GC8452@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181211110919.GC8452@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 11, 2018 at 06:09:19AM -0500, Jeff King wrote:
> On Sun, Dec 09, 2018 at 11:56:23PM +0100, SZEDER Gábor wrote:
> 
> > 'test-lib.sh' looks for the presence of certain options like '--tee'
> > and '--verbose-log', so it can execute the test script again to save
> > its standard output and error.  This happens way before the actual
> > option parsing loop, and the condition looking for these options looks
> > a bit odd, too.  This patch series will add two more options to look
> > out for, and, in addition, will have to extract these options' stuck
> > arguments (i.e. '--opt=arg') as well.
> > 
> > Add a proper option parsing loop to check these select options early
> > in 'test-lib.sh', making this early option checking more readable and
> > keeping those later changes in this series simpler.  Use a 'for opt in
> > "$@"' loop to iterate over the options to preserve "$@" intact, so
> > options like '--verbose-log' can execute the test script again with
> > all the original options.
> > 
> > As an alternative, we could parse all options early, but there are
> > options that do require an _unstuck_ argument, which is tricky to
> > handle properly in such a for loop, and the resulting complexity is,
> > in my opinion, worse than having this extra, partial option parsing
> > loop.
> 
> In general, I'm not wild about having multiple option-parsing loops that
> skip the normal left-to-right parsing, since it introduces funny corner
> cases (like "-foo --bar" which should be the same as "--foo=--bar"
> instead thinking that "--bar" was passed as an option).

Yeah, that's already an "issue" in the current implementation as well,
though there are no such options that require options as argument.

> But looking at what this is replacing:
> 
> > -case "$GIT_TEST_TEE_STARTED, $* " in
> > -done,*)
> > -	# do not redirect again
> > -	;;
> > -*' --tee '*|*' --va'*|*' -V '*|*' --verbose-log '*)


Anyway, I had another crack at turning the current option parsing loop
into a for loop keeping $@ intact, and the results don't look all that
bad this time.  Note that this diff below only does the while -> for
conversion, but leaves the loop where it is, so the changes are easily
visible.  The important bits are the conditions at the beginning of
the loop and after the loop, and the handling of '-r'; the rest is
mostly s/shift// and sort-of s/$1/$opt/.

Thoughts?  Is it better than two loops?  I think it's better.

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9a3f7930a3..efdb6be3c8 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -264,58 +264,65 @@ test "x$TERM" != "xdumb" && (
 	) &&
 	color=t
 
-while test "$#" -ne 0
+store_arg_to=
+prev_opt=
+for opt
 do
-	case "$1" in
+	if test -n "$store_arg_to"
+	then
+		eval $store_arg_to=\$opt
+		store_arg_to=
+		prev_opt=
+		continue
+	fi
+	case "$opt" in
 	-d|--d|--de|--deb|--debu|--debug)
-		debug=t; shift ;;
+		debug=t ;;
 	-i|--i|--im|--imm|--imme|--immed|--immedi|--immedia|--immediat|--immediate)
-		immediate=t; shift ;;
+		immediate=t ;;
 	-l|--l|--lo|--lon|--long|--long-|--long-t|--long-te|--long-tes|--long-test|--long-tests)
-		GIT_TEST_LONG=t; export GIT_TEST_LONG; shift ;;
+		GIT_TEST_LONG=t; export GIT_TEST_LONG ;;
 	-r)
-		shift; test "$#" -ne 0 || {
-			echo 'error: -r requires an argument' >&2;
-			exit 1;
-		}
-		run_list=$1; shift ;;
+		store_arg_to=run_list
+		prev_opt=-r
+		;;
 	--run=*)
-		run_list=${1#--*=}; shift ;;
+		run_list=${opt#--*=} ;;
 	-h|--h|--he|--hel|--help)
-		help=t; shift ;;
+		help=t ;;
 	-v|--v|--ve|--ver|--verb|--verbo|--verbos|--verbose)
-		verbose=t; shift ;;
+		verbose=t ;;
 	--verbose-only=*)
-		verbose_only=${1#--*=}
-		shift ;;
+		verbose_only=${opt#--*=}
+		;;
 	-q|--q|--qu|--qui|--quie|--quiet)
 		# Ignore --quiet under a TAP::Harness. Saying how many tests
 		# passed without the ok/not ok details is always an error.
-		test -z "$HARNESS_ACTIVE" && quiet=t; shift ;;
+		test -z "$HARNESS_ACTIVE" && quiet=t ;;
 	--with-dashes)
-		with_dashes=t; shift ;;
+		with_dashes=t ;;
 	--no-color)
-		color=; shift ;;
+		color= ;;
 	--va|--val|--valg|--valgr|--valgri|--valgrin|--valgrind)
 		valgrind=memcheck
-		shift ;;
+		;;
 	--valgrind=*)
-		valgrind=${1#--*=}
-		shift ;;
+		valgrind=${opt#--*=}
+		;;
 	--valgrind-only=*)
-		valgrind_only=${1#--*=}
-		shift ;;
+		valgrind_only=${opt#--*=}
+		;;
 	--tee)
-		shift ;; # was handled already
+		;; # was handled already
 	--root=*)
-		root=${1#--*=}
-		shift ;;
+		root=${opt#--*=}
+		;;
 	--chain-lint)
 		GIT_TEST_CHAIN_LINT=1
-		shift ;;
+		;;
 	--no-chain-lint)
 		GIT_TEST_CHAIN_LINT=0
-		shift ;;
+		;;
 	-x)
 		# Some test scripts can't be reliably traced  with '-x',
 		# unless the test is run with a Bash version supporting
@@ -335,15 +342,21 @@ do
 		else
 			echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
 		fi
-		shift ;;
+		;;
 	-V|--verbose-log)
 		verbose_log=t
-		shift ;;
+		;;
 	*)
-		echo "error: unknown test option '$1'" >&2; exit 1 ;;
+		echo "error: unknown test option '$opt'" >&2; exit 1 ;;
 	esac
 done
 
+if test -n "$store_arg_to"
+then
+	echo "error: $prev_opt requires an argument" >&2
+	exit 1
+fi
+
 if test -n "$valgrind_only"
 then
 	test -z "$valgrind" && valgrind=memcheck

