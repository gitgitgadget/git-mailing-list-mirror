Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A690720323
	for <e@80x24.org>; Wed, 22 Mar 2017 21:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbdCVVCY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 17:02:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:49630 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932578AbdCVVCY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 17:02:24 -0400
Received: (qmail 25011 invoked by uid 109); 22 Mar 2017 21:02:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 21:02:23 +0000
Received: (qmail 30977 invoked by uid 111); 22 Mar 2017 21:02:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 17:02:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 17:02:18 -0400
Date:   Wed, 22 Mar 2017 17:02:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH 1/3] t5615: fix a here-doc syntax error
Message-ID: <20170322210218.6jyzg53k55ixodt2@sigill.intra.peff.net>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
 <20170322200805.23837-2-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170322200805.23837-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 01:08:03PM -0700, Junio C Hamano wrote:

> From: Jan Palus <jan.palus@gmail.com>
> 
> This came as part of jk/quote-env-path-list-component and was merged
> to 2.11.1 and later.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This should be applied on top of 5e74824f ("t5615-alternate-env:
>  double-quotes in file names do not work on Windows", 2016-12-21)
> 
>  t/t5615-alternate-env.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
> index 26ebb0375d..d2d883f3a1 100755
> --- a/t/t5615-alternate-env.sh
> +++ b/t/t5615-alternate-env.sh
> @@ -77,6 +77,7 @@ test_expect_success 'mix of quoted and unquoted alternates' '
>  	check_obj "$quoted:$unquoted" <<-EOF
>  	$one blob
>  	$two blob
> +	EOF
>  '

Thanks, this one is my fault, and the solution is obviously correct.

-Peff
