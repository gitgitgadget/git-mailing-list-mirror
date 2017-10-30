Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29CF41FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752545AbdJ3Qe5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:34:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:60113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752111AbdJ3Qe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:34:57 -0400
Received: from [192.168.178.43] ([92.76.242.15]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrIPo-1dAotf0j9A-0135fD; Mon, 30
 Oct 2017 17:34:55 +0100
Subject: Re: [PATCH v16 Part II 6/8] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <af5f503a-6c2c-436f-ae74-cfbb11cb7a7f@gmx.net>
Date:   Mon, 30 Oct 2017 17:34:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:eGt+B6tjqfeHVTQ16fNlnskefgC7vWtfS1hWfbLbXyCWZ6XPrxz
 Ks+cWJZ3ef6kOX6oYkCkof6oGmJEGGhJ3/RAKYM0r6uIh+HhfjWFtz9ZyF1g9HVUQiZKXd5
 a9grf3tiovyGxm2UTXZMX2ptW1n6ThsLwaWmAq9FlPcTheRNcml9Y3cQeiG8cGaytkhlMMy
 rvZNYiQ3HEDM2ZjRuVdTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FY1VlhvFyAE=:G/ig3yZZFWRyyLKGjJZMq3
 sSMfY5bjp/f3RtNWFyVHNvng4Na4Dfg++Iew+ja19dasFXYN/vJwMBDCwca58DvONegUXjA1k
 I1bmW/sZI1EuXATbP+ObP6X3XSPUkUm9uJMVHrn+vn9Iz9bdBnZeVWH4yWWSeDHZ7FoDE1MRT
 Auu0iO+CBCdLMls2G0yBgFzNatZZ5hAAsZIGicXIIWseBwIWndpnvC3hUHhneXGMpTIlGl4hx
 lxsRFLpUS+1qsVyyHIALA5bhdbJT2b363X2egHHgCZFVfuLmA/73qjQE5R8HzU6Fpp78vsuDx
 uKqpSJEuaiYgruW4HFAcn1Cjq+oWVncUtuulkfWKaG/4XwSwpLEFwj5J5818HrE2oImTmqcAe
 EEa9EGgx0xLzinBNew1PDOib4YNt1qg2wPpWoNZEArYxSacQ1siYPQw2zlMIziLRXcbJ/TXyZ
 OnsV0hzCkAT7ww2+ctxIzzDzcGQPhdXlm39AYWsmUIzCSmxXRoG9kw0zSurMnLgZo5CsfMk0Z
 MjMCE6a1p3pR2dv17H9UmliG26Nmsfm87C3NXSqQZ/+xsQ2nSzgzHsk+AOj6/m8GOyJz5XELg
 p3JRP/Fjo3ICn8uX0ZuXnq6yDX/ssNRzGzaYl1FcWKpFIBXzy2H2/PMXy0DGgzbs05wN5coOZ
 VZvv4aniJ5zUjgKV7KZ8iH8OtIdJD4O6ePr433EcL7raqx5YbBpL90iXmGH5EDnJ8YSBF2hIV
 BwotFrX30Ps35x3sTNtY73//CydAHQOxJXa6XRtCjr2hCXyHR2KDI04PGvuhobMPmdM08WW1O
 4oLttMluR2GLw1/X1vW6PTeGloqB4uLE88ht6jDoyR9Ibjb9ec=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/27/2017 05:06 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 0f9c3e63821b8..ab0580ce0089a 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
[...]
> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int i;
> +
> +	if (get_terms(terms))
> +		return error(_("no terms defined"));
> +
> +	if (argc > 1)
> +		return error(_("--bisect-term requires exactly one argument"));
> +
> +	if (argc == 0)
> +		return !printf(_("Your current terms are %s for the old state\n"
> +				 "and %s for the new state.\n"),
> +				 terms->term_good, terms->term_bad);

Same as in 1/8: you probably want "printf(...); return 0;" except there
is a good reason.

> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--term-good"))
> +			printf(_("%s\n"), terms->term_good);
> +		else if (!strcmp(argv[i], "--term-bad"))
> +			printf(_("%s\n"), terms->term_bad);

The last two printfs: I think there is no point in translating "%s\n",
so using "%s\n" instead of _("%s\n") looks more reasonable.

> +		else
> +			error(_("BUG: invalid argument %s for 'git bisect terms'.\n"
> +				  "Supported options are: "
> +				  "--term-good|--term-old and "
> +				  "--term-bad|--term-new."), argv[i]);

Should this be "return error(...)"?

> +	}
> +
> +	return 0;
> +}
> +

Stephan
