Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBB04203E1
	for <e@80x24.org>; Fri, 22 Jul 2016 02:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbcGVC34 (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 22:29:56 -0400
Received: from mout.web.de ([212.227.15.4]:54788 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbcGVC3z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 22:29:55 -0400
Received: from [192.168.1.180] ([66.131.38.59]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MRD4x-1buVIf0m2p-00UYKB; Fri, 22 Jul 2016 04:29:51
 +0200
Subject: Re: [PATCH v10 12/12] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:	Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
 <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <7a408f75-74d9-7e59-35d6-3a931414a7f9@web.de>
Date:	Fri, 22 Jul 2016 04:29:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.1.0
MIME-Version: 1.0
In-Reply-To: <010201560a4782ce-8d6545f1-2454-492b-a2c6-6e0f2ac824d4-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:G0oDSI1vU7I56ZNsaaMKs1/9uHRrCv0gLzrQ4IF32sTGaU7Hda9
 3I8cpSPnB6oa+ifjiYfFivCOvcZmhZ2kGwWPpnq7dTsk3XrGw46mU1CpwDU6iLx4yvh7znn
 S6TQw/4H5T1O5NrdNEpZKWBsrhxQWWvD0BwMmx4CRr8f1dLgksigP8WZZLxrtt8FRNeR2mc
 cU8zPSL565EPl9vdIBhMg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:k3DCbhWpa/M=:kQRF+ROGk10TXq8ZhhBBzs
 l1xcCo2NMnAfdV3fQamhuUEtWZb6hZBohU8nSCyeGHpsfEIC3qfG6L9tU7bChzQKlfYKSHhL8
 522WzYkj9ZbwPyQilheb00XDo/R0VRrNWDYYJ3CQuOgDVNY6w6l8U9vB+Hrim0L1oz1+loTbH
 MK1rDSPVuQcPrjLSLSN0xDDdtOTfeDla5DlzFwMVvSGG1UNTs6upfK48F5bhhMgUC4vDsmy+2
 A5U9dQP72MpyvXUrSgjwSxuD83MTH6Dszsem+N5fec46OF1Z9t8j4cyH/wYcCZkGJs1Wq0Tg1
 t3gP8n2l7/cufU4mb2wWSy/nx8ic3htZ1x5f+ExkLrD8clTViYiEjdEtKmMifRc15scK/TfBE
 9n5G7z97Z2ldor9eAELoJ9e1NgWqAXBfxD0c2Dy4Vh3cxe61Jwl3sD2ffnue/azAyBRdXJvMG
 x5IKxHqCARkmmqFKHBTOnYGtRHGrxuANBTLj/UfbVAv+jdJwb0zRPt8U/g6kOcAnMHxYTov38
 VZnp8zoiMWlbB+AAxVDtN7qMtA7LFdzyhnSLT8T34pk11w1QSdaGtQj6xTpezAyoweNv6O7wO
 SNDQI5Zrz3NSEmn0fx1g9HgdLQvouPB4v2IYJz5Tt3alJ4dtkORR7oAZtve5kfyNNrhLGCTn7
 bvNaFivQHjfbKtKIGWleifKKA2Kt5Ba+3npv071ghvF5e4a2f9rs2RyPdG9AfqvClycbEBxa2
 09FlJUo+E0bHdqzcDft/guyE4RpAqqjcfO6zZOR3DKaUf6SoRhSHsvFuKBCFIlbVDO9MtS3Nr
 xirytC/
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org



On 07/20/2016 11:47 PM, Pranit Bauva wrote:
> Reimplement the `get_terms` and `bisect_terms` shell function in C and
> add `bisect-terms` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> In the shell version, the terms were identified by strings but in C
> version its done by bit manipulation and passing the integer value to
> the function.
>
> Using `--bisect-terms` subcommand is a temporary measure to port shell
> function in C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired and will be called by some
> other methods.
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  builtin/bisect--helper.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++-
>  git-bisect.sh            | 35 ++---------------------
>  2 files changed, 75 insertions(+), 34 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 001096a..185a8ad 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -8,6 +8,13 @@
>  #include "run-command.h"
>  #include "prompt.h"
>
> +enum terms_defined {
> +	TERM_BAD = 1,
> +	TERM_GOOD = 2,
> +	TERM_NEW = 4,
> +	TERM_OLD = 8
> +};
> +
What does TERM stand for  ?
It could be TERMinal, TERMinator or just TERM.
Something like BIS_TERM_DEF_BAD .. may be more intuitive,
and may avoid name clashes in the long run.

And why are the defines 1,2,4,8 ?
It looks as if a #define bitmap may be a better choice here ?
How do we do these kind of bit-wise opions otherwise ?

>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
>  static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
> @@ -26,6 +33,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>  	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),
>  	N_("git bisect--helper --bisect-next-check [<term>] <TERM_GOOD> <TERM_BAD"),
> +	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
>  	NULL
>  };
>
> @@ -359,6 +367,43 @@ static int bisect_next_check(const struct bisect_terms *terms,
>  	return 0;
>  }
>
> +static int get_terms(struct bisect_terms *terms)
> +{
> +	FILE *fp;
> +	int res;
> +	fp = fopen(git_path_bisect_terms(), "r");
> +	if (!fp)
> +		return -1;
> +
> +	bisect_terms_reset(terms);
> +	res = strbuf_getline(&terms->term_bad, fp) == EOF ||
> +	      strbuf_getline(&terms->term_good, fp) == EOF;
> +
> +	fclose(fp);
> +	return res ? -1 : 0;
> +}
> +
> +static int bisect_terms(struct bisect_terms *terms, int term_defined)
> +{
> +	if (get_terms(terms)) {
> +		fprintf(stderr, "no terms defined\n");
> +		return -1;
> +	}
> +	if (!term_defined) {
> +		printf("Your current terms are %s for the old state\nand "
> +		       "%s for the new state.\n", terms->term_good.buf,
> +		       terms->term_bad.buf);
> +		return 0;
> +	}
> +
> +	if (term_defined == TERM_GOOD || term_defined == TERM_OLD)
> +		printf("%s\n", terms->term_good.buf);
> +	if (term_defined == TERM_BAD || term_defined == TERM_NEW)
> +		printf("%s\n", terms->term_bad.buf);
May be a switch-case ?
Or at least "else if" ?

> +
> +	return 0;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -369,9 +414,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		CHECK_EXPECTED_REVS,
>  		BISECT_WRITE,
>  		CHECK_AND_SET_TERMS,
> -		BISECT_NEXT_CHECK
> +		BISECT_NEXT_CHECK,
> +		BISECT_TERMS
>  	} cmdmode = 0;
>  	int no_checkout = 0, res = 0;
> +	enum terms_defined term_defined = 0;
>  	struct option options[] = {
>  		OPT_CMDMODE(0, "next-all", &cmdmode,
>  			 N_("perform 'git bisect next'"), NEXT_ALL),
> @@ -389,6 +436,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("check and set terms in a bisection state"), CHECK_AND_SET_TERMS),
>  		OPT_CMDMODE(0, "bisect-next-check", &cmdmode,
>  			 N_("check whether bad or good terms exist"), BISECT_NEXT_CHECK),
> +		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
> +			 N_("print out the bisect terms"), BISECT_TERMS),
> +		OPT_BIT(0, "term-bad", &term_defined,
> +			 N_("show the bad term"), TERM_BAD),
> +		OPT_BIT(0, "term-good", &term_defined,
> +			 N_("show the good term"), TERM_GOOD),
> +		OPT_BIT(0, "term-new", &term_defined,
> +			 N_("show the new term"), TERM_NEW),
> +		OPT_BIT(0, "term-old", &term_defined,
> +			 N_("show the old term"), TERM_OLD),
>  		OPT_BOOL(0, "no-checkout", &no_checkout,
>  			 N_("update BISECT_HEAD instead of checking out the current commit")),
>  		OPT_END()
> @@ -399,6 +456,16 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix, options,
>  			     git_bisect_helper_usage, 0);
>
> +	if (cmdmode != BISECT_TERMS && term_defined)
> +		die(_("--term-bad, --term-good, --term-new and --term-old "
> +		      "can be used only with --bisect-terms"));
> +
> +	if (term_defined != 0 && term_defined != TERM_BAD &&
> +	    term_defined != TERM_GOOD && term_defined != TERM_NEW &&
> +	    term_defined != TERM_OLD)
> +		die(_("only one option among --term-bad, --term-good, "
> +		      "--term-new and --term-old can be used."));
> +
[]
