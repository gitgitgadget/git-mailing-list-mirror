Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 154801FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 21:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbcKQVcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 16:32:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:63265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751986AbcKQVcM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 16:32:12 -0500
Received: from [192.168.178.43] ([88.71.246.160]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M1n4s-1cvkag3wKY-00tlnj; Thu, 17
 Nov 2016 22:32:09 +0100
Subject: Re: [PATCH v15 12/27] bisect--helper: `get_terms` & `bisect_terms`
 shell function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <b54f7f46-a3c0-3334-24fa-e8d1e7d8f653@gmx.net>
Date:   Thu, 17 Nov 2016 22:32:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1ad5-0f90c88e-2077-4155-94e9-7d71dbbac38f-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:l12k3ylN03kTgq+S2hWNNjW/+ZBn/kOUb0z+9rt1z4FwiMB365L
 VOrFLXE/svg3I1Gx8ZF2pVXzhHk5aTkUGyR+pHfcCoGFbwZUmQk7i4LisujsGxKo7blyvRU
 f3rl1quwb0mjj/fCmEPWOTZpsFc6Oq+fsAGR0OhfHdgX91tBmamR9l8migLc+hwbjHnRdmX
 xemgouEcQn/O/2Ze7orQQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ihhSYA0cIC0=:FDZOPKB6xh4pnQjota1dAM
 EFnet/Bhj3oinmb61htqysti6p+F66DXrtH0HlTQKRvHWe/b3b4PVd2TxqD++H6plOk514OQd
 525XvSYHEMGyYZTbR8XZjZhmL6aEvl8VGY/cj2L+HwtVdgLlaMKIyn56HCNbaGljnyXpj8dRy
 3CZKJxxZslPnaX7r3ApnnHVWwySsprNZfR6+ilKCwmJbenrVL95IZh966B9uocl21s1zJf/Ov
 Jdlc320ozHTiAw+Dw7LAa1W0gjCU7c9qIeu0f0kAuttDnD8ykkgbjDZU9PcYwLypkGTKTgYLK
 ETlmb36B9TrVUTeK9QES1FfsziwNxVzpSq3N8iHQoXZUO4rv2xFO1GG6IaKVdq5kKgOVTj2a0
 mSltAjniSl+exjQvi6/6G7+0eDNIVxcocQEPlI8tvjIB48fQZUXrhzWZR2vdY3duFKnejNC/+
 h++H2odIyfklCZlvcQ14c7d4J5QFFBtGtogm8HbhrVH8kHPIkasR9js/W02sQSbrEAhVIZbR7
 +upfTlnXjMj6FgcJB2GLh0inV5r7gnO0KoIjen6vcjMSHBh01KnX/aoNQVIrNyq8aeCE+292X
 CfPkfk6yJSBL29hR1WCXRgsGiDw+2wES4UKoqwGE5yaW6IlDrcn7SIFYdwnsKQykMc8JwpQkd
 39dbcqt9HyRokI+Xdbhg/X5RN1Eso5cCmmKxVcFkV07NHX+jxbweVRxTbz6CPOYWZBQ6s6njN
 H4R2BMWk8A7pEDjA4UQIVWqq90Pq4DTNOtN3AErrjGM9GmAIdGmEptL0Eqdc/louPjtKe1FMs
 Ms3fj5u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 317d671..6a5878c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
[...]
> +static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
> +{
> +	int i;
> +	const char bisect_term_usage[] =
> +"git bisect--helper --bisect-terms [--term-good | --term-bad | ]"
> +"--term-old | --term-new";

Three things:

(1) Is that indentation intentional?

(2) You have a "]" at the end of the first part of the string instead of
the end of the second part.

(3) After the correction, bisect_term_usage and
git_bisect_helper_usage[7] are the same strings. I don't recommend to
use git_bisect_helper_usage[7] instead because keeping the index
up-to-date is a maintenance hell. (At the end of your patch series it is
a 3 instead of a 7.) However, if - for whatever reason - the usage of
bisect--helper --bisect-terms changes, you always have to sync the two
strings which is also nasty....

> +
> +	if (get_terms(terms))
> +		return error(_("no terms defined"));
> +
> +	if (argc > 1) {
> +		usage(bisect_term_usage);
> +		return -1;
> +	}

...and since you only use it once, why not simply do something like

return error(_("--bisect-term requires exactly one argument"));

and drop the definition of bisect_term_usage.

> +
> +	if (argc == 0) {
> +		printf(_("Your current terms are %s for the old state\nand "
> +		       "%s for the new state.\n"), terms->term_good,
> +		       terms->term_bad);

Very minor: It improves the readability if you'd split the string after
the \n and put the "and "in the next line.

> +		return 0;
> +	}
> +
> +	for (i = 0; i < argc; i++) {
> +		if (!strcmp(argv[i], "--term-good"))
> +			printf("%s\n", terms->term_good);
> +		else if (!strcmp(argv[i], "--term-bad"))
> +			printf("%s\n", terms->term_bad);
> +		else
> +			die(_("invalid argument %s for 'git bisect "
> +				  "terms'.\nSupported options are: "
> +				  "--term-good|--term-old and "
> +				  "--term-bad|--term-new."), argv[i]);

Hm, "return error(...)" and "die(...)" seems to be quasi-equivalent in
this case. Because I am always looking from a library perspective, I'd
prefer "return error(...)".

> @@ -429,6 +492,11 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		terms.term_bad = xstrdup(argv[1]);
>  		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
>  		break;
> +	case BISECT_TERMS:
> +		if (argc > 1)
> +			die(_("--bisect-terms requires 0 or 1 argument"));
> +		res = bisect_terms(&terms, argv, argc);
> +		break;

Also here: "terms" is leaking...

~Stephan
