Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 273E61F453
	for <e@80x24.org>; Mon, 22 Oct 2018 21:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeJWGNm (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 02:13:42 -0400
Received: from mout.web.de ([212.227.17.11]:33889 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbeJWGNm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 02:13:42 -0400
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7srs-1fSOno0hTU-00vMi8; Mon, 22
 Oct 2018 23:53:20 +0200
Received: from [192.168.178.36] ([79.237.252.49]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M7srs-1fSOno0hTU-00vMi8; Mon, 22
 Oct 2018 23:53:20 +0200
Subject: Re: [PATCH] commit-reach: fix sorting commits by generation
To:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>
References: <20181022211037.22719-1-t.gummerer@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <13bdda53-b751-182b-4aa8-d9a5c03f422d@web.de>
Date:   Mon, 22 Oct 2018 23:53:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181022211037.22719-1-t.gummerer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ihMO0JKOmpPXqQJ7lRtm5ud/rmAc1QIl32DGGaJxAds+skd4Snj
 41sODpim0InIM25jcZlH6kAZ/4qyVoFeSyP25YKU9Ynp0cEsO/UUsTgYRF5LXlCNQsXskys
 JKiLJcIw+llEkccgQIrvEEBZx8OQstFI2J6ikMU0MWbApyX5i7kYLuTUxXZOtY1Hi4Y4DeC
 N2KPy4SrSCYX7Qm0RleYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:e58xgJiLoxw=:E/n0WOIKTA78PbTnI1+nsq
 AoW2VhRMpXJ9pWFjB1/IoG9VPdqp5pxNpuLm9p+NG1tqWjRsEdMNwZ/FOeIpCXYaiNsQDKKMY
 2k3X6Hvuh7+wxT08KlV2Yx0Kc/IVyby4pfrPCDIn6W64KxzNhEV7L4f0yR6wbXrEow2we65os
 1AbHshyo3dxMD62iS1SgmP/oW5OohKTQTkY20clfQKoJR/7dX81PDPulyRPkHkQYrAShIDhrF
 YSoQO8hxjpWfWZzF2p2tSR1U26bBKsZbwteeZd+zwDenNq2NpfHbKLWGD1tW+6+VBiXFHLgTw
 GoyvUoJYigUqajE8U9tfr3sL+rXgiM5FzceJlsfPZ3rc7gkC5Ok7C+qtUEy0KCi+9dunKqnMh
 CCgy87+4tc4djsGKqhg2IhzoEQDYjd+ELXyIi5WBrDlejNez5rfyPm6sXmQ/KOl0ojL6ALaXk
 EB0pT8HOr8kwciFXoIYajaNFDbqHch/gFOrY2vsN3VQIlz8fLO8QXa2FVaLb050Gse23u+zdD
 7pXTfz8xarGJ+woVDcpWKOtMNHQhnCOsZm8PHpu0vtquSQGr7ZA04YLBS6aO4B6fu7bOYIr+R
 ey5MT6YDbO5OsGAclhUAZcwrPqAV/sK7LJjVhtCYnrkpTNhSTIQGDdVPQ24noZk83EyvBWJ93
 nKfZUzm6RK5/rJ9SFujB8SaiecnxiP9sn5Tkw+UkAJcp9L1lgNDJ/bIg1Lie3E6+6RucUcPtf
 5fxBJf4mNJwhjk7TTyNr78jf+gmNbQbDdG/tLJmKMS4KtLLs7PZAkvxmI/wT9qHuBpvRnvspj
 oqeeW8XE9mTlvx4zcBDHiRuDamaUxcFWwaLPQbz9ol/j3jujMI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.10.2018 um 23:10 schrieb Thomas Gummerer:
> compare_commit_by_gen is used to sort a list of pointers to 'struct
> commit'.  The comparison function for qsort is called with pointers to
> the objects it needs to compare, so when sorting a list of 'struct
> commit *', the arguments are of type 'struct commit **'.  However,
> currently the comparison function casts it's arguments to 'struct
> commit *' and uses those, leading to out of bounds memory access and
> potentially to wrong results.  Fix that.
> 
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
> 
> I noticed this by running the test suite through valgrind.  I'm not
> familiar with this code, so I'm not sure why this didn't cause any
> issues or how they would manifest, but this seems like the right fix
> for this function either way.

Right; I sent a similar patch a while ago, but it seems to have fallen
through the cracks:

https://public-inbox.org/git/d1b58614-989f-5998-6c53-c19eee409a2f@web.de/

Anyway, your implied question was discussed back then.  Derrick wrote:

   The reason to sort is to hopefully minimize the amount we walk by 
   exploring the "lower" commits first. This is a performance-only thing, 
   not a correctness issue (which is why the bug exists). Even then, it is 
   just a heuristic.

Does b6723e4671 in pu (commit-reach: fix first-parent heuristic) change
that picture?  Did a quick test and found no performance difference with
and without the fix on top, i.e. proper sorting didn't seem to matter.

>  commit-reach.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/commit-reach.c b/commit-reach.c
> index bc522d6840..9efddfd7a0 100644
> --- a/commit-reach.c
> +++ b/commit-reach.c
> @@ -516,8 +516,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
>  
>  static int compare_commits_by_gen(const void *_a, const void *_b)
>  {
> -	const struct commit *a = (const struct commit *)_a;
> -	const struct commit *b = (const struct commit *)_b;
> +	const struct commit *a = *(const struct commit **)_a;
> +	const struct commit *b = *(const struct commit **)_b;
>  
>  	if (a->generation < b->generation)
>  		return -1;
> 

Looks good to me.

René
