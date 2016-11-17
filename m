Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65DA2021E
	for <e@80x24.org>; Thu, 17 Nov 2016 09:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751788AbcKQJkK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 04:40:10 -0500
Received: from mout.gmx.net ([212.227.15.15]:57612 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbcKQJkH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 04:40:07 -0500
Received: from [192.168.178.43] ([88.71.246.160]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWkep-1cIS5o2GcN-00XvwD; Thu, 17
 Nov 2016 10:40:03 +0100
Subject: Re: [PATCH v15 09/27] bisect--helper: `bisect_write` shell function
 in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad1-f3a59b1f-9cdb-4d91-b28e-2501facdcb45-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <ceb2c50b-0ca7-115d-eb0e-316389569e36@gmx.net>
Date:   Thu, 17 Nov 2016 10:40:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1ad1-f3a59b1f-9cdb-4d91-b28e-2501facdcb45-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VOyAqhs4GijuM4E2OT7Y24g5rP6U9bXXv1vMBICjNSC149ev1qE
 WK9yzB9cX5Axmmu7b7KJF5WSuOiVHGtFhHimA+xUoBUN9fWpj+TSu/Oi+NNhx1kHq0hR/TF
 u8L9A7I2xHNKhJnnAS2PncH0o8CyMNIac1j+hS725zJ0R5WN7ZUXPhJOWh9P6tP/bNd4Fmx
 Urwj+wTLG/DY14xvjgxgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DQ8DRqaBE4Q=:wV+dbTARQju8gpK6Dm8g23
 ykp/5Wvfd8GQMEIFWtrS9pSbAEstF/MpayKmic7xdq2tgSLlUenjfyMJtdenNwXMHl59gBd2u
 ygfSkGFMOzj/lWZ7Mu3lON8cszBF3SHVilX/TJddQQGjQEcGzclC0wVYa7KmX4sSgNLdM3VLv
 V4yZNfkTf3L18eLpbhCx4+x1idxrRnwd1Q4/oCkabw0aphbXc4Cl30iuJ4lQISYKVLklQv5+n
 R6j6uMQS3jg/z8GSMAYXGKGABolII3ZOsuEqP8N7uhliPIQCn26XujZ/jDP82i77hlmBrVOd+
 Ex+vdoKTywFH4hHhxNGmtGvLO+Gk3h9oJXeMkqiEeHXNYDqfn5VSwazAl49A3BEjK/sDRlAJL
 das8K3VyobMPAjMhUNU2l+0moztZEVzJZTUkb5i8Yq9dELmgynBWmdnbvCR+pNPrRpIeI5pny
 /slMv9jCOXqU512MIZ1Onbm++fMe5bqggl/6JiQ5/VdRryyAzLfkZI8vhEQGm0j0jISY85svI
 R+HlNVdKEtGIh5YNdHyJtOTuhEhnii50CW7H/FTc32qSKIupxymGrZSan+o9/a2/E7fvHfsyt
 1eI8OIW3zfdxx6n4QX3Uf1DptG7TmDvP3PrCSW+qeLT+fbI+9l4s2JhiXDtPM+VF71EBr72v0
 QNmqSPYqLPELyTmilyvTy1z47n0AiDeUXZ1ltFBpwzC585oft0r0/6qR/P3DT2zKt9i1KZZoG
 mBz6uch72jJC3TV+TuwgUlE7pMt3AM6D3sKP98Aphb7MahQpB8H7BPuRsYOEwgkl3iUaoxmH1
 S616tIq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I've only got some minors to mention here ;)

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c542e8b..3f19b68 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -19,9 +19,15 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
>  	N_("git bisect--helper --bisect-clean-state"),
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
> +	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
>  	NULL
>  };

I wouldn't write "<TERM_GOOD <TERM_BAD>" in capital letters. I'd use
something like "<good_term> <bad_term>" as you have used for
--write-terms. Note that "git bisect --help" uses "<term-old>
<term-new>" in that context.

> @@ -149,6 +155,63 @@ static int check_expected_revs(const char **revs, int rev_nr)
>  	return 0;
>  }
>  
> +static int bisect_write(const char *state, const char *rev,
> +			const struct bisect_terms *terms, int nolog)
> +{
> +	struct strbuf tag = STRBUF_INIT;
> +	struct strbuf commit_name = STRBUF_INIT;
> +	struct object_id oid;
> +	struct commit *commit;
> +	struct pretty_print_context pp = {0};
> +	FILE *fp = NULL;
> +	int retval = 0;
> +
> +	if (!strcmp(state, terms->term_bad))
> +		strbuf_addf(&tag, "refs/bisect/%s", state);
> +	else if (one_of(state, terms->term_good, "skip", NULL))
> +		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
> +	else {
> +		error(_("Bad bisect_write argument: %s"), state);
> +		retval = -1;
> +		goto finish;
> +	}
> +
> +	if (get_oid(rev, &oid)) {
> +		error(_("couldn't get the oid of the rev '%s'"), rev);
> +		retval = -1;
> +		goto finish;
> +	}
> +
> +	if (update_ref(NULL, tag.buf, oid.hash, NULL, 0,
> +		       UPDATE_REFS_MSG_ON_ERR)) {
> +		retval = -1;
> +		goto finish;
> +	}

I'd like to mention that the "goto fail;" trick could apply in this
function, too.

> @@ -156,9 +219,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		WRITE_TERMS,
>  		BISECT_CLEAN_STATE,
>  		BISECT_RESET,
> -		CHECK_EXPECTED_REVS
> +		CHECK_EXPECTED_REVS,
> +		BISECT_WRITE
>  	} cmdmode = 0;
> -	int no_checkout = 0;
> +	int no_checkout = 0, res = 0;

Why do you do this "direct return" -> "set res and return res" transition?
You don't need it in this patch, you do not need it in the subsequent
patches (you always set "res" exactly once after the initialization),
and you don't need cleanup code in this function.

>  	struct option options[] = {
>  		OPT_CMDMODE(0, "next-all", &cmdmode,
>  			 N_("perform 'git bisect next'"), NEXT_ALL),
> @@ -170,10 +234,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			 N_("reset the bisection state"), BISECT_RESET),
>  		OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
>  			 N_("check for expected revs"), CHECK_EXPECTED_REVS),
> +		OPT_CMDMODE(0, "bisect-write", &cmdmode,
> +			 N_("write out the bisection state in BISECT_LOG"), BISECT_WRITE),

That info text is confusing, especially considering that there is a
"nolog" option. I think the action of bisect-write is two-fold: (1)
update the refs, (2) log.

> @@ -182,24 +249,37 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		usage_with_options(git_bisect_helper_usage, options);
>  
>  	switch (cmdmode) {
> +	int nolog;
>  	case NEXT_ALL:
>  		return bisect_next_all(prefix, no_checkout);
>  	case WRITE_TERMS:
>  		if (argc != 2)
>  			die(_("--write-terms requires two arguments"));
> -		return write_terms(argv[0], argv[1]);
> +		res = write_terms(argv[0], argv[1]);
> +		break;

As indicated above, I think the direct "return ...;" is cleaner.


~Stephan
