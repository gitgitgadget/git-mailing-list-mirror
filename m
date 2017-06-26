Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1EC20401
	for <e@80x24.org>; Mon, 26 Jun 2017 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbdFZJXQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 05:23:16 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:25184 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdFZJXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 05:23:14 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id PQEidsW7ocpskPQEidIR8C; Mon, 26 Jun 2017 10:23:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498468993; bh=c2heCNRj0jb3Gqd+OAa8aWFK0UFI8TyNjv59wJHKt0U=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DnlkNoEk//0jOVmxNaAGgnfXg+7PntWO/RMdfuX7cq6wlgT0+SMkR93uuzP2llM0+
         0Qcr9/N3sYPWtLgwkKYwB/sUnPnQomFkU/ACCQ/BiCkIDfhEO8pJtgLZc4Oudq3ix1
         UPjzkiaVJjWk3Iyw5hIMlbPQPBWhBo7MVE4oDuPA=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=Q3GZtBvRWziqsa1gdyUA:9 a=QEXdDO2ut3YA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/4] Add regression tests for recent rebase -i fixes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170531104213.16944-1-phillip.wood@talktalk.net>
 <20170619175605.27864-1-phillip.wood@talktalk.net>
 <xmqqa84zgwx9.fsf@gitster.mtv.corp.google.com>
 <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
 <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
 <xmqqfueqfxfv.fsf@gitster.mtv.corp.google.com>
 <xmqqmv8yedg0.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <5858ba2d-b88d-c2f1-2877-df0d1e8abc64@talktalk.net>
Date:   Mon, 26 Jun 2017 10:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqmv8yedg0.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNOjyhy+aGVAn1MhKX3bnltk4046DIrIB7Zb7THiHGpC9iEdHZzMVBaCv52frNX9tQLA1Vc0IAH2zXtlApXcIeYsQZfGGSO8UFJGgFq2YkgZSRneUSyZ
 Vh5FOXhLvVmwek0L/DD5iV2PmPfpRQwkFjd8KmOYvgInZilL3JLaCwRtzP95fE7KJdPqUVnS6DPN8748TjomHacxa6jfl6I4jh6iows1/DGV0oo8A9PYV4Wa
 g6uKjUBAWvc6LHTm03OJyRD0gyf2RMGjsqvj9nOpQnYTCbYfEr9niFKCw+qfvPVQr+T/1nD5ADm8KEtT6GbEqA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/17 20:01, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> For 3420, I can wrap the two-liner patch I showed here earlier into
>> a commit on top of the series.  
> 
> So, here is what I'll queue on top before merging the topic down to
> 'master'.

Thanks for creating this fixup, I'll remember to think about
GETTEXT_POISON when I'm writing tests in the future.

> -- >8 --
> Subject: [PATCH] t3420: fix under GETTEXT_POISON build
> 
> Newly added tests to t3420 in this series prepare expected
> human-readable output from "git rebase -i" and then compare the
> actual output with it.  As the output from the command is designed
> to go through i18n/l10n, we need to use test_i18ncmp to tell
> GETTEXT_POISON build that it is OK the output does not match.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  t/t3420-rebase-autostash.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
> index 6826c38cbd..e243700660 100755
> --- a/t/t3420-rebase-autostash.sh
> +++ b/t/t3420-rebase-autostash.sh
> @@ -178,7 +178,7 @@ testrebase () {
>  		test_when_finished git branch -D rebased-feature-branch &&
>  		suffix=${type#\ --} && suffix=${suffix:-am} &&
>  		create_expected_success_$suffix &&
> -		test_cmp expected actual
> +		test_i18ncmp expected actual
>  	'
>  
>  	test_expect_success "rebase$type: dirty index, non-conflicting rebase" '
> @@ -275,7 +275,7 @@ testrebase () {
>  		test_when_finished git branch -D rebased-feature-branch &&
>  		suffix=${type#\ --} && suffix=${suffix:-am} &&
>  		create_expected_failure_$suffix &&
> -		test_cmp expected actual
> +		test_i18ncmp expected actual
>  	'
>  }
>  
> 

