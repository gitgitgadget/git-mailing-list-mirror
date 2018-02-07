Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBD8B1F576
	for <e@80x24.org>; Wed,  7 Feb 2018 07:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbeBGHUP (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 02:20:15 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:4574 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750777AbeBGHUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 02:20:14 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zbt581fTWz5tlH;
        Wed,  7 Feb 2018 08:20:11 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 189301D15;
        Wed,  7 Feb 2018 08:20:11 +0100 (CET)
Subject: Re: [PATCH] t0050: remove the unused $test_case variable
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20180206231303.8483-1-avarab@gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <bf3ad52d-4aa3-8678-9466-3996f6cba11c@kdbg.org>
Date:   Wed, 7 Feb 2018 08:20:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180206231303.8483-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.02.2018 um 00:13 schrieb Ævar Arnfjörð Bjarmason:
> The $test_case variable hasn't been used since
> decd3c0c28 ("t0050-*.sh: mark the rename (case change) test as
> passing", 2014-11-28) when its last user went away.
> 
> Let's remove the "say" as well, since it's obvious from subsequent
> output that we're testing on a case sensitive filesystem.

Am I misunderstanding the message? I think it reports properties of the 
test environment. And the tests do run on case-insensitive filesystems. 
IMO, the message should be kept.

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>   t/t0050-filesystem.sh | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index b29d749bb7..606ffddd92 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -7,14 +7,6 @@ test_description='Various filesystem issues'
>   auml=$(printf '\303\244')
>   aumlcdiar=$(printf '\141\314\210')
>   
> -if test_have_prereq CASE_INSENSITIVE_FS
> -then
> -	say "will test on a case insensitive filesystem"
> -	test_case=test_expect_failure
> -else
> -	test_case=test_expect_success
> -fi
> -
>   if test_have_prereq UTF8_NFD_TO_NFC
>   then
>   	say "will test on a unicode corrupting filesystem"
> 
