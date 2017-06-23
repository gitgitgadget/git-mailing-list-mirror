Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1465620401
	for <e@80x24.org>; Fri, 23 Jun 2017 09:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754655AbdFWJxl (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 05:53:41 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:6518 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754606AbdFWJxk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 05:53:40 -0400
Received: from [192.168.2.201] ([92.22.42.39])
        by smtp.talktalk.net with SMTP
        id OLHVdme3McpskOLHVdGwvX; Fri, 23 Jun 2017 10:53:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1498211618; bh=2KDYH3fjXXfz7TkOxJ1MIp3Bzt037wjq3ymNGRKUJro=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=rdHNb9HtmuS1xpj43WWyQaR46tcJket0tpBLg402hPcoCf0yGKnn1cSb9heP6S0Vm
         RKoagtd2NsMPbHa2dYk8sXuoix+BEipzkkT4j7AsQ94vwxxsoRWGnpHjJDYzgf91iI
         TVB3fsvFEo8b0JQmc2R+IFhd42B0dkFMRRGPDqj0=
X-Originating-IP: [92.22.42.39]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=0UCMmuyk8Ln1ykD6Z38Clg==:117
 a=0UCMmuyk8Ln1ykD6Z38Clg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=extA4yZ_AAAA:8 a=YwgSsaPVgTRxjFwEDlIA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=hVSmkA6k2N-FF26V3nNA:22
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
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <bc0c32fa-2df6-a4a3-5966-8efabfa349cd@talktalk.net>
Date:   Fri, 23 Jun 2017 10:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp83fg0h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJztU6J51YlMV/Xpw/bZp1LmLCikFmrKCiWv9EMtlxdxGMr2wFlkJOalwWPIGabcGzF68dEJH/Igjit7VUTeoJBgSn8CcZ+JJ6f4lzwUoEBVELaxKk8p
 B5IA2O3LKmy+Fkm+y5z5duvYz5cQO5aNYtPFvQVNZoUQrLzXhrU4MqgMuu/Mwb2qZeT0dSDuMJS/sIiJPJiIQU+iwyDOK3z8SpKKIdi5x3AqrsXsfUvmGoIQ
 ZlajpW2yTMBkNOlQB8byZuHZ9YCsLORlRm3Pk+rnEJLSElR6af9Cz5z01FcTcVJ2IPLEaNKDTenfkPPVIiaf0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/06/17 06:07, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>>>  git-rebase.sh                 |   4 +-
>>>  sequencer.c                   |  11 ++--
>>>  t/t3404-rebase-interactive.sh |   7 +++
>>>  t/t3420-rebase-autostash.sh   | 136 ++++++++++++++++++++++++++++++++++++++++--
>>>  4 files changed, 147 insertions(+), 11 deletions(-)
>>
>> I've merged this to 'next' but I probably shouldn't have before
>> making sure that Travis tests passes 'pu' while this was still in
>> there.  
>>
>> At least t3420 seems to fail under GETTEXT_POISON build.
>>
>>   https://travis-ci.org/git/git/jobs/245990993
> 
> This should be sufficient to make t3420 pass.  It seems that t3404
> is also broken under GETTEXT_POISON build, but I won't have time to
> look at it, at least tonight.
> 
>     $ make GETTEXT_POISON=YesPlease
>     $ cd t && sh ./t3404-*.sh -i -v
> 
> to see how it breaks.

t3404 passes for me,
$ make GETTEXT_POISON=YesPlease
$ cd t &&sh t3404-rebase-interactive.sh -i -v
...
# still have 1 known breakage(s)
# passed all remaining 95 test(s)
1..96

Also as far as I can see it passes on travis -
https://travis-ci.org/git/git/jobs/245990993#L910 have I missed
something? Do you want me to submit a fixup patch for t3420 or have you
got one already?

Thanks

Phillip

> Thanks.
> 
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

