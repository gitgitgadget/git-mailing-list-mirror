Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE061F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeAJTCM (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:02:12 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:48208 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbeAJTCL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:02:11 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3zGz020lgdz5tlB;
        Wed, 10 Jan 2018 20:02:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 2526141FB;
        Wed, 10 Jan 2018 20:02:09 +0100 (CET)
Subject: Re: [PATCH] t3900: add some more quotes
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20180110095832.22077-1-dev+git@drbeat.li>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
Date:   Wed, 10 Jan 2018 20:02:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180110095832.22077-1-dev+git@drbeat.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2018 um 10:58 schrieb Beat Bolli:
> In 89a70b80 ("t0302 & t3900: add forgotten quotes", 2018-01-03), quotes
> were added to protect against spaces in $HOME. In the test_when_finished
> hander, two files are deleted which must be quoted individually.
> 
> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
> ---
>   t/t3900-i18n-commit.sh | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
> index 9e4e694d9..dc00db87b 100755
> --- a/t/t3900-i18n-commit.sh
> +++ b/t/t3900-i18n-commit.sh
> @@ -40,7 +40,7 @@ test_expect_success 'UTF-16 refused because of NULs' '
>   '
>   
>   test_expect_success 'UTF-8 invalid characters refused' '
> -	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
> +	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&

Should that not better be

	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\""

i.e., delay the expansion of $HOME to protect against double-quotes in 
the path?

-- Hannes
