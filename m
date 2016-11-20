Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E8082021E
	for <e@80x24.org>; Sun, 20 Nov 2016 20:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbcKTUBf (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Nov 2016 15:01:35 -0500
Received: from mout.gmx.net ([212.227.15.15]:49738 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751328AbcKTUBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2016 15:01:33 -0500
Received: from [192.168.178.43] ([88.71.227.20]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiTF6-1clCVQ30do-00cexf; Sun, 20
 Nov 2016 21:01:28 +0100
Subject: Re: [PATCH v15 13/27] bisect--helper: `bisect_start` shell function
 partially in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <52f6241f-e584-d830-ca66-084dc509c7fe@gmx.net>
Date:   Sun, 20 Nov 2016 21:01:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.5.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1ad3-ea75ed97-2514-427e-8e57-9f10efd4e6e9-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WfVlqZNxtDGd2ZzRCJX8Wr+7MclHYoutrmmqhAyhkS2AJha0lR4
 a8RfH89DvGa9rxfa1yT0A6POvYT4stfxNzLShtUUNgEYDJObxtmy6kqHvOEJlkgDLK9Wt+d
 wNOUlxdvkEg4EPUm3L1ohvS+EA1Iw6UkU/FnLPL/LL/ABd56ffuEW3DzRVT78oL83Ocwj6U
 /+k+1FukEXTIgkBEkXXyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xEO+Yvzzlmw=:8VqrhxMvJTcneggXU13af/
 wV1qaL8qvF2mgArfahrBkMrGyx6F57x+GX8OtEZdIcsX0xVuonRWDxAxNKlbenVMmKcsS51wq
 qb0/5rYsPbRx9+3aX5NSVH8I5gUhTrue4/lraCWfK2J6ltc6zJHXFFzvGOM9jMnzGl7wIw3IW
 7qeX9vSsMi4JHtKfIwsxmAmxLcodWf4lPNx/G52xZnZ8SFRWy8SxEuqBZCoYqXKIK8SHiDFPo
 KvOiz7M0Idz1PmMBpffNyi3G3ET37kkAxPYmIF8cuaXzN/oyoDiHH/Zrxty5jUD2X6gvKrCWB
 j4xo4TJJI72XQEdISsfd2TWVr6ftCitFrgujHw6SCZ9/LtP4ONdF9JXaZNxPH1AgZu8jfNpib
 NPLJPL/9U/zHkFneqds5wR8syOOZfObKUbewD9w3IZYUOvPlSla34Xez2d8oTOHt3SZ61wVtI
 /xy2ZOzZ39Ljbp8ecGQ2J6zOukH0X/33Megtfkp88a+y9cK2bTJ5fTyggRGR2QvxuDC76k0Ow
 Mk/W/Mzj6XWRCXUASjypkS+LVow7+WispHbS+8rL24sdYZFkxRv64kLSznv3/rt94l72hSsPE
 xUBmVP8uM7zZqM691FNc6UIAwnKwzD2qk9pzbHC190I2D1n6qSB43Ai9reJWYWUw8uvC+nMMV
 kmPOHQFtXYme0wSm7ImhU/nvP3+5cO8VC2gqLc9h9oEogQw0WGGFbUsQRk5NhuWux+T9WpIE/
 umPNXPKICAgOJSqtu3syPrDoOrCxIp2Y7zyIKJ03V+xCRFvSrdGik0T1Imn/Y7i3AwqjPcd4B
 ufipXKa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 6a5878c..1d3e17f 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -403,6 +408,205 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>  	return 0;
>  }
>  
> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +			const char **argv, int argc)
> +{
> +	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
> +	int flags, pathspec_pos, retval = 0;
> +	struct string_list revs = STRING_LIST_INIT_DUP;
> +	struct string_list states = STRING_LIST_INIT_DUP;
> +	struct strbuf start_head = STRBUF_INIT;
> +	struct strbuf bisect_names = STRBUF_INIT;
> +	struct strbuf orig_args = STRBUF_INIT;
> +	const char *head;
> +	unsigned char sha1[20];
> +	FILE *fp = NULL;
> +	struct object_id oid;
> +
> +	if (is_bare_repository())
> +		no_checkout = 1;
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;
> +			break;
> +		}
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		const char *commit_id = xstrfmt("%s^{commit}", argv[i]);
> +		const char *arg = argv[i];
> +		if (!strcmp(argv[i], "--")) {
> +			has_double_dash = 1;
> +			break;
> +		} else if (!strcmp(arg, "--no-checkout")) {
> +			no_checkout = 1;
> +		} else if (!strcmp(arg, "--term-good") ||
> +			 !strcmp(arg, "--term-old")) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(argv[++i]);

All these xstrdup() for the terms here and below will leak memory.

I recommend to use xstrdup() also at (*) below, and use
free(terms->term_good) above this line (and for every occurrence below,
of course).

> +		} else if (skip_prefix(arg, "--term-good=", &arg)) {
> +			must_write_terms = 1;
> +			terms->term_good = xstrdup(arg);
[...]
> @@ -497,6 +705,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			die(_("--bisect-terms requires 0 or 1 argument"));
>  		res = bisect_terms(&terms, argv, argc);
>  		break;
> +	case BISECT_START:
> +		terms.term_good = "good";
> +		terms.term_bad = "bad";

Here is (*): use xstrdup("good") etc.

And then, as already mentioned for another patch, free(terms.*) below.



I personally am a friend of small functions and would prefer something
like as follows...  (This is a comment about several patches of your
series, not only this one.)

First, replace the current set_terms() by

static void set_terms(struct bisect_terms *terms, const char *bad,
                                                 const char *good)
{
	terms->term_good = xstrdup(good);
	terms->term_bad = xstrdup(bad);
}

ie, without calling write_terms(...).
And then replace the *current* set_terms() calls by set_terms(...);
write_terms(...); calls.

Second, add

static void get_default_terms(struct bisect_terms *terms)
{
	set_terms(terms, "bad", "good");
}

and use this instead of the two lines quoted above (and all its other
occurrences).

Third, use the new set_terms() everywhere instead of settings terms
members directly (with the exception of get_terms()).

This sounds like a safer variant (with respect to leaks and handling
them) to me than doing it the current way.

~Stephan
