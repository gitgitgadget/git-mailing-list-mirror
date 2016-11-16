Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FCC2042F
	for <e@80x24.org>; Wed, 16 Nov 2016 23:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbcKPXXg (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 18:23:36 -0500
Received: from mout.gmx.net ([212.227.15.19]:58682 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751652AbcKPXXf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 18:23:35 -0500
Received: from [192.168.178.43] ([92.76.229.29]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b4B-1bvq4h14TX-00Cyin; Thu, 17
 Nov 2016 00:23:32 +0100
Subject: Re: [PATCH v15 07/27] bisect--helper: `bisect_reset` shell function
 in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1aa0-0c1fed14-e058-4621-9958-973113d7e45f-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <1190e37e-d54a-7dbf-412d-8dff90ca677a@gmx.net>
Date:   Thu, 17 Nov 2016 00:23:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1aa0-0c1fed14-e058-4621-9958-973113d7e45f-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:iJzYFJeXMYqZ58f0dAiLY2pzJ29CXmFQP8GrV20j4ovseiFvCeC
 /vUH54Rw9btetRgw4atUeCgZSS6yMY5dDI6wtcJVmhjhdmEoIsb4T4NCQT2+V41BCDijU6/
 lxRCMPEcygE9L4EKMZP+/akjmHPbXGOFzyYNCiaaVa8k2b/ZAFV7mBhbKoP5ffPWGiLMG69
 3HSuchr9IVWiVB3rlCxBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T4a7cXaSzhg=:5101kOpgPFb/LjRNJzVLdc
 MRnodZ9Mt59SMcgRVYLeiMO5hEBtsDF/hySeFN6/1TVjCLCdZa3/DQVn9R0WhMopvOiXF8C/2
 hlt4CZrGZFu7OsolafQztIbrTZeHDe2nPvx01ehrRx/zkPehXIDn1k3HEiM4hjLKDCrPPxMGN
 7Wln54Tz+fGwxJNM+nmDcKZDODpRouHnXUBCDNmgoBN7q+YFKA+R4rx14dlrGJvDqgiwpfr5D
 xwlnmmLKo/S6toAQcLmjnDrBMmFaPMtCU4u+XYvPtwvLZKDmlNBb9vahvUYqi0kn60bBVX0Fc
 GQPkSk4LQ8TYnuowSAF0tF21Y7kSinesleSp0O/avx+tFr6oclCRnBFwU7Pdi91hsRfo614lg
 1e551d2PUTHUrarcdXUWyFdIje17nAXeQ2rn82kBaXWpNfpM+6R4WX92ISaK9ffXp2vHZb+wx
 4UFk5yQf/UJwtKinQhb5FkKk9rCuqV/6RhYd1TMyJYJFUECIGL7SZGj4h/A+KneMPwPA3UgzD
 UQqGRqyomFv7WmlotlNP1ldOap7TMCmxhe4bVecKrgyyiY2EoXJKowlZP1VjbVgnc8QdQOdE1
 /MT2Se+nOOrRLGLp3Yldno+FQugyi0eyM7UB7OOjfSoZjovHwzTGFqhBt3e4+f+aShTWhbx27
 qmiHyEWXYWpeaQv5d42mzm+yd5kogtDEXvdoMIOyJM7OnCDCAMuXd5EpHKTeVaT81QbRuKsip
 OkS33JTLxAtKQdx8ocxSS0EI9n26FJ2CMwj6Wt2VFbM34jWu752IzCTtOJywcJZYG5kclmL88
 i3+mMSj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 4254d61..d84ba86 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -84,12 +89,47 @@ static int write_terms(const char *bad, const char *good)
>  	return (res < 0) ? -1 : 0;
>  }
>  
> +static int bisect_reset(const char *commit)
> +{
> +	struct strbuf branch = STRBUF_INIT;
> +
> +	if (!commit) {
> +		if (strbuf_read_file(&branch, git_path_bisect_start(), 0) < 1) {
> +			printf("We are not bisecting.\n");

I think this string should be marked for translation.

> +			return 0;
> +		}
> +		strbuf_rtrim(&branch);
[...]
> @@ -121,6 +163,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		if (argc != 0)
>  			die(_("--bisect-clean-state requires no arguments"));
>  		return bisect_clean_state();
> +	case BISECT_RESET:
> +		if (argc > 1)
> +			die(_("--bisect-reset requires either zero or one arguments"));

This error message is imho a little unspecific (but this might not be an
issue because bisect--helper commands are not really exposed to the
user). Maybe "--bisect-reset requires either no argument or a commit."?

> +		return bisect_reset(argc ? argv[0] : NULL);
>  	default:
>  		die("BUG: unknown subcommand '%d'", cmdmode);
>  	}

~Stephan
