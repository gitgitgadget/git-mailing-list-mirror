Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 815BA2021E
	for <e@80x24.org>; Sun, 20 Nov 2016 20:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbcKTUBi (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 15:01:38 -0500
Received: from mout.gmx.net ([212.227.15.19]:64116 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbcKTUBh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 15:01:37 -0500
Received: from [192.168.178.43] ([88.71.227.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LomN9-1cfRLB2O9T-00gm01; Sun, 20
 Nov 2016 21:01:34 +0100
Subject: Re: [PATCH v15 15/27] bisect--helper: `bisect_next` and
 `bisect_auto_next` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <8bd0682f-e35e-a50e-24a9-fd3a53454ed4@gmx.net>
Date:   Sun, 20 Nov 2016 21:01:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1af0-5d688c2e-868d-4d8c-a8fd-9a675f7f01da-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:6O6PDIrqLwc8eb1bRVSw9LPaYQ+Mhuq/dE0b5QHon5S73jyEslN
 Sow8Pxq1EC48nTuWXDwWL14wTKmWRy4sQKDlWvaf2NArTyYbyESRfULtKIEgZxvX+/DXA5F
 dfB3f5MYWAtC50vow7ai18uTF03BZediIWA5pq4/HhyCntj9liZLQ5SPYa4bVlgAYfVFC0p
 NBO64L80EV5tq3wF3bFwA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JGBYrsWGgfk=:yFBwmcxrywvnR90Y+DG4Ov
 TXMyJ0TlbWQ86p/r5+4GGMUNf6fH7HnUOPRit1wD8aZYuxvZIC0m4OWgzDTo6mSEZOATg2xRZ
 Quet28tsHba5qGHdU/Iuvl8BXe3/I0+VI2NkdQsZEQfPRLQ+6b2BICRM1RnvtqxRrGfpCqI7T
 IbgxpI09c170S6x6Rqto4+JsgVfLHFf88yL9sY1HUp5svdZHXcg3r6XRa33jAqXR4oUqR1AzV
 rh701gKOc58/w0l52PP2xZB1hyHexmeyKkMY7qYnZPLTP4DtyZpPcig8WQFOyG3WNGHOQiOIG
 3FCeWz4GUzULtsL7lcP7P9ullZdX4bc1KNPYZ/3Vh0SzkBetw7VDEEeSxzGLjrl5Pxcdp/zL9
 TxFQn/tTMdnsj/HLf50Wj1fse0lGUwQL6n6uRRBScn8bC0rTwGpbvE277YUqN4UaRwoHnLTeo
 SMz5lE38Ct74qCjYLSrQz4IwhPfVAz1EZjR8r5LsdgD01jEC5GrsHxEFX6O2bvkfjBoHJRt3x
 JsBNS5OZJV3sKOnVyAKLnOyDwNuTKqLaDDOpmydWd8ACYU0HGqT+eccDQRNXCnFx5CDdzy4CI
 T+jGbVgDosEgUHr5zzxnwxTqpNmv9RcvnslJiImpXCY7iDF5TWcbPz+/vgdEIv08d2T4TurOn
 HmzZyKysopaO/xl23MMRZIWHbeaR6mrdQa6nuDINoxEkC3YNcasOWRN5FY0Kf+1cOAfPPqs/l
 IZEbfFG+SB7sPSIrqixsRq4DbzGpjsM3VuhxJjeiiKYQkIUkgvfgqvIpd64zDKddh4pJFZD3R
 7KtFvnM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

this one is hard to review because you do two or three commits in one here.
I think the first commit should be the exit()->return conversion, the
second commit is next and autonext, and the third commit is the pretty
trivial bisect_start commit ;) However, you did it this way and it's
always a hassle to split commit, so I don't really care...

However, I was reviewing this superficially, to be honest. This mail
skips the next and autonext part.

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/bisect.c b/bisect.c
> index 45d598d..7c97e85 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -843,16 +878,21 @@ static int check_ancestors(const char *prefix)
>   *
>   * If that's not the case, we need to check the merge bases.
>   * If a merge base must be tested by the user, its source code will be
> - * checked out to be tested by the user and we will exit.
> + * checked out to be tested by the user and we will return.
>   */
> -static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
> +static int check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>  {
>  	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
>  	struct stat st;
> -	int fd;
> +	int fd, res = 0;
>  
> +	/*
> +	 * We don't want to clean the bisection state
> +	 * as we need to get back to where we started
> +	 * by using `git bisect reset`.
> +	 */
>  	if (!current_bad_oid)
> -		die(_("a %s revision is needed"), term_bad);
> +		error(_("a %s revision is needed"), term_bad);

Only error() or return error()?

> @@ -873,8 +916,11 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
>  			      filename);
>  	else
>  		close(fd);
> +
> +	goto done;
>   done:

I never understand why you do this. In case of adding a "fail" label
(and fail code like "res = -1;") between "goto done" and "done:", it's
fine... but without one this is just a nop.

> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 1d3e17f..fcd7574 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -427,15 +560,24 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>  		no_checkout = 1;
>  
>  	for (i = 0; i < argc; i++) {
> -		if (!strcmp(argv[i], "--")) {
> +		const char *arg;
> +		if (starts_with(argv[i], "'"))
> +			arg = sq_dequote(xstrdup(argv[i]));
> +		else
> +			arg = argv[i];

One is xstrdup'ed, one is not, so there'll be a leak somewhere, and it's
an inconsistent leak... I guess it's a bad idea to do it this way ;)
(Also below.)

> @@ -443,24 +585,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
>  			no_checkout = 1;
>  		} else if (!strcmp(arg, "--term-good") ||
>  			 !strcmp(arg, "--term-old")) {
> +			if (starts_with(argv[++i], "'"))
> +				terms->term_good = sq_dequote(xstrdup(argv[i]));
> +			else
> +				terms->term_good = xstrdup(argv[i]);
>  			must_write_terms = 1;
> -			terms->term_good = xstrdup(argv[++i]);
>  		} else if (skip_prefix(arg, "--term-good=", &arg)) {
>  			must_write_terms = 1;
> -			terms->term_good = xstrdup(arg);
> +			terms->term_good = arg;

No ;) (See my other comments (to other patches) for the "terms" leaks.)

[This repeats several times below.]

> diff --git a/git-bisect.sh b/git-bisect.sh
> index f0896b3..d574c44 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -109,6 +88,7 @@ bisect_skip() {
>  bisect_state() {
>  	bisect_autostart
>  	state=$1
> +	get_terms
>  	git bisect--helper --check-and-set-terms $state $TERM_GOOD $TERM_BAD || exit
>  	get_terms
>  	case "$#,$state" in

I can't say if this change is right or wrong. It looks right, but: How
does this relate to the other changes? Is this the right patch for it?

~Stephan
