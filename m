Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DF3E20FCF
	for <e@80x24.org>; Thu, 30 Jun 2016 05:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbcF3FiQ (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 01:38:16 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:60091 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbcF3FiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 01:38:15 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rg7cB673Gz5tlH;
	Thu, 30 Jun 2016 07:38:02 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 3DD2252D1;
	Thu, 30 Jun 2016 07:38:01 +0200 (CEST)
Subject: Re: [PATCH 1/9] Report bugs consistently
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
 <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <5774B039.8080802@kdbg.org>
Date:	Thu, 30 Jun 2016 07:38:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
MIME-Version: 1.0
In-Reply-To: <8615dc276828a3f99a27ff2eda9909548a7d435e.1467199553.git.johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Am 29.06.2016 um 13:36 schrieb Johannes Schindelin:
> @@ -955,9 +955,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
>
>   			if (!sha_eq(a->sha1, b->sha1))
>   				result.clean = 0;
> -		} else {
> -			die(_("unsupported object type in the tree"));
> -		}
> +		} else
> +			die(_("BUG: unsupported object type in the tree"));

Would it perhaps make sense to remove the _() markup (here and a few 
more instances in this patch)? It's simpler for developers to find the 
code location when a "BUG:" is reported untranslated.

-- Hannes

