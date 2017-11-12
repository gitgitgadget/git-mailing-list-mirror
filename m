Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26080201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbdKLTTu (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 14:19:50 -0500
Received: from mout.gmx.net ([212.227.15.15]:50150 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751089AbdKLTTt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 14:19:49 -0500
Received: from [192.168.178.43] ([92.76.226.11]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mgc0l-1ebvtM0EH1-00NwkF; Sun, 12
 Nov 2017 20:19:47 +0100
Subject: Re: [PATCH v16 Part II 5/8] bisect--helper: `bisect_next_check` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>, git@vger.kernel.org
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <d0994817-25be-25b8-565e-d81c5f18b210@gmx.net>
Date:   Sun, 12 Nov 2017 20:19:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <0102015f5e5ee2ca-bf824205-86e6-4259-b7d7-a68e2fbb087d-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:WTCv0g7aqMYopJORzhE5jZoIw4tiF6Yp0zSrazkfucUdLWjSFkE
 aNW0DkPDqDgjHoe11ZPrNWbFt7IGg6B+F13yRMuUEePkp2MFUAaeS4nNh36AmFo/0p4XHe0
 Q4JK/O5Xi5Dq5xVHFv4jzxRUAn+MLxBv/POmjWYe78xY2Y3pW3H/Tjw/Zx/PXi5UkPrtux4
 sOObs83tgPo1RBombFuSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xWyuSAupJLI=:c2pir6mUA79xcgj2o8nTFy
 cHc1ZMzmovLDi+8t27ohHOvYhqipRtTmejn3MouL9HMkmyfJ3IXPM+9V+AdI5OsrmDsbRgAmA
 z3SwbHACZgMxxl78XTUDBWQsHHw+sjgGsech+5KNzFcmaXzCzaelXlF5kPvO1YjeybSZunBu4
 EyoCWkDNSjPlkwvSUuUuU6tR4GIWGt89nvb5xfVWgvPIVD9m67OE7gCVvBFTweEq1cqaFA2qB
 XCu0AvkmaRkKzX64VvTP3TzJxBlkcEPTSkm1fKWP4C+Rm2aDrkZ5S8mBqwoffDlZmZtD2ECWg
 Edm0VCPfR3XX8OOIaYr07D0K6WM/tSDdOsgBzBwIoFPdeK34eSV4cPK/+7y5TvNd60TX1keK2
 94OlTINZBWzEF4oW3IDMOo8ppe0A42Uk67DSzU59UusqUZVgs1GivfsVu24NbGRC9rcHznMfn
 ab0N3v77saMP5/UcYxztNm6JNCcLHy1oysRJAgk7yZJ1OYDNB6zHRu42mQmxYoLBjuVdfw0uC
 Up72opCXWwXc8sQtCw0w9q2HpV0No/ZLZNXe7vH+7F7NBl0lXsQ581juvxG6e0y114MNbmVHG
 3kxavBqgoBMyXUNDxXOzr6mB4JcjA4jPm4qaUQPaFmJUOQ4g78TBmNPXn8yfYbdD+0s38PxHJ
 sM4DofHGpXKZ64Idhk9Yt4c59uMo5uHOxar1nuyPt95SCBMvwBfD15blN88/tro0xdXe5APDx
 ZWFAnsS52MgmMVjqzBZ8s6FM86k3dXkhzzMUuN1H9Bcr3VJB6EdPoTF3rHa/JC/prY6UBKVqy
 j8V8OKQV+ZXu3a5lN2QcYM31ACxVfXq3Pzit0GAnr8Dk78xINs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

another minor:

On 10/27/2017 05:06 PM, Pranit Bauva wrote:
> @@ -264,6 +271,79 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
>  	return 0;
>  }
>  
> +static int mark_good(const char *refname, const struct object_id *oid,
> +		     int flag, void *cb_data)
> +{
> +	int *m_good = (int *)cb_data;
> +	*m_good = 0;
> +	return 1;
> +}
> +
> +static int bisect_next_check(const struct bisect_terms *terms,
> +			     const char *current_term)
> +{
> +	int missing_good = 1, missing_bad = 1, retval = 0;
> +	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
> +	const char *good_glob = xstrfmt("%s-*", terms->term_good);
> +
> +	if (ref_exists(bad_ref))
> +		missing_bad = 0;
> +
> +	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
> +			     (void *) &missing_good);
> +
> +	if (!missing_good && !missing_bad)
> +		goto finish;
> +
> +	if (!current_term)
> +		goto fail;
> +
> +	if (missing_good && !missing_bad && current_term &&

This check for "current_term" is not necessary; it can be asserted to be
non-NULL, otherwise you would have jumped to "fail"

Stephan
