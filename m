Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F00C203EA
	for <e@80x24.org>; Sat, 10 Dec 2016 08:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbcLJIPi (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Dec 2016 03:15:38 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:55090 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752360AbcLJIPh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2016 03:15:37 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3tbMNl3l0gz5tlF;
        Sat, 10 Dec 2016 09:15:35 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 478EE1E71;
        Sat, 10 Dec 2016 09:15:34 +0100 (CET)
Subject: Re: [PATCH 2/2] mergetools/tortoisemerge: simplify can_diff() by
 using "false"
To:     David Aguilar <davvid@gmail.com>
References: <20161210032144.25503-1-davvid@gmail.com>
 <20161210032144.25503-2-davvid@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <37d8bc43-9f24-b8e8-cb52-de9cc9b2adde@kdbg.org>
Date:   Sat, 10 Dec 2016 09:15:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20161210032144.25503-2-davvid@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.12.2016 um 04:21 schrieb David Aguilar:
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> This patch builds upon da/mergetool-trust-exit-code
>
>  mergetools/tortoisemerge | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mergetools/tortoisemerge b/mergetools/tortoisemerge
> index d7ab666a59..9067d8a4e5 100644
> --- a/mergetools/tortoisemerge
> +++ b/mergetools/tortoisemerge
> @@ -1,5 +1,5 @@
>  can_diff () {
> -	return 1
> +	false
>  }

Why is this a simplification?

My concern is that 'false' is not necessarily a shell built-in. Then 
this is actually a pessimization.

-- Hannes

