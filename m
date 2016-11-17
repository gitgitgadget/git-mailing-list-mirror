Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F93C1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 20:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbcKQUZK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 15:25:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:63090 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752522AbcKQUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 15:25:09 -0500
Received: from [192.168.178.43] ([88.71.246.160]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LrePN-1cmhMC3mcH-013RHr; Thu, 17
 Nov 2016 21:25:06 +0100
Subject: Re: [PATCH v15 10/27] bisect--helper: `check_and_set_terms` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1aca-0c26fb8c-404f-4f57-afe7-7ebb552a1002-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <b7691fac-9642-f87d-f23f-5175b5ead05b@gmx.net>
Date:   Thu, 17 Nov 2016 21:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1aca-0c26fb8c-404f-4f57-afe7-7ebb552a1002-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:RNBirpgxJ8DfSOvQzIJPr+l2C/43lhG6h2QL0feEKMz4GfgbGpL
 iaBVjETUIV3xjSO5AqrkBCVSwLZpjZfeil5bwYg03mxuS1JBrcyAea4kfbqgUhhpU7S95Hj
 URPnnOoiYW9adjpJa6y3itZuSwhhObY+nf67mphzVuQNJ/XaK5nNtatPvhhDt8VCbaIHKZC
 G311LtUOawewOOms769dg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sg8U+R6YsS8=:JdoOPSRpZIuE4Ac9qaif/1
 yhQlRWnCNTlY9I2naYwHd/8Dz1f6LlDHogaFEtR2g4IDdfDFGDTgQjWNtCH4eak1cZh2O8PSC
 k/vbXjtcUoSerBpk/Q/ahIY3utul0IdBMpJZoxHNRUm7w95aRWJvCfaKG91jx7SGvrcfa3jGF
 PloUZLJOTL14MYQDezYtZvvLxtfud8+d3FYJf73W7tZa+GPpqfTzU3eLGrdQzMCZgDD8lupGv
 YraI31ZRb0YTMT4q07PZxAVieY9EsvPr/xRw8gYkUAtfMEOXj4KSIc7iFvHbvGp8gHDna3DhN
 AgNqa4/XfQk/osF9y3mzlDsN6uA4eNVL4y57Vnn4X1yN26Tdj8nKXUXf6IfTfBk5PpfNjnPHk
 9dJLJfXoHD+Gcppzj/Kl/v/eFi+79a0TS4dQXlKIIEaJ2u+BQ5m65J5YWFgKd5Z1Kh6rXYsLF
 lnTY2c9DGLfP3sTfkK9Dk98O4dpBL3Eifc6TiAic9Uashpl9jznsNwnCB8ornVF0yFuCwP2no
 8L7k16UjdshU12z50bfHyUtVKhp2QqJwOp43PB5cdIzNTOs3PLfZUBGGhJZu3hNcd6N8Ya2GN
 X0q+erPtkEtkm+VlCNw1iq2Femga0bznTTTPgm7y+G/ON7ar/Pb7MM8sN/vwlyjZRC1L4RQk8
 tr3TEzg22VDoNIZTSFOnK+r5oZRTFRtkt1VnIWIE1qbz8E86EpG+2MKPh+6Lzft0v6kn/Xmko
 THd7S+66voHU0uDE79O3pPW7qakQrdawmMx1ubUZ+muNgpgRKLVVDTkbfWb0aJP0vgX8gi79n
 XYppla3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pranit,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 3f19b68..c6c11e3 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -20,6 +20,7 @@ static const char * const git_bisect_helper_usage[] = {
>  	N_("git bisect--helper --bisect-clean-state"),
>  	N_("git bisect--helper --bisect-reset [<commit>]"),
>  	N_("git bisect--helper --bisect-write <state> <revision> <TERM_GOOD> <TERM_BAD> [<nolog>]"),
> +	N_("git bisect--helper --bisect-check-and-set-terms <command> <TERM_GOOD> <TERM_BAD>"),

Here's the same as in the previous patch... I'd not use
TERM_GOOD/TERM_BAD in capitals.

>  	NULL
>  };
>  
> @@ -212,6 +213,38 @@ static int bisect_write(const char *state, const char *rev,
>  	return retval;
>  }
>  
> +static int set_terms(struct bisect_terms *terms, const char *bad,
> +		     const char *good)
> +{
> +	terms->term_good = xstrdup(good);
> +	terms->term_bad = xstrdup(bad);
> +	return write_terms(terms->term_bad, terms->term_good);

At this stage of the patch series I am wondering why you are setting
"terms" here, but I guess you'll need it later.

However, you are leaking memory here. Something like

	free(terms->term_good);
	free(terms->term_bad);
	terms->term_good = xstrdup(good);
	terms->term_bad = xstrdup(bad);

should be safe (because you've always used xstrdup() for the terms
members before). Or am I overseeing something?

> @@ -278,6 +314,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		terms.term_bad = xstrdup(argv[3]);
>  		res = bisect_write(argv[0], argv[1], &terms, nolog);
>  		break;
> +	case CHECK_AND_SET_TERMS:
> +		if (argc != 3)
> +			die(_("--check-and-set-terms requires 3 arguments"));
> +		terms.term_good = xstrdup(argv[1]);
> +		terms.term_bad = xstrdup(argv[2]);
> +		res = check_and_set_terms(&terms, argv[0]);
> +		break;

Ha! When I reviewed the last patch, I asked you why you changed the code
from returning directly from each subcommand to setting res; break; and
then return res at the bottom of the function.

Now I see why this was useful. The two members of "terms" are again
leaking memory: you are allocating memory by using xstrdup() but you are
not freeing it.
(That also applies to the last patch.)

Cheers,
Stephan
