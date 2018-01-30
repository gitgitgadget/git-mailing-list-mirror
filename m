Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9866B1F576
	for <e@80x24.org>; Tue, 30 Jan 2018 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeA3JuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 04:50:21 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:56593 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeA3JuU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 04:50:20 -0500
Received: from localhost (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Tue, 30 Jan 2018 10:50:41 +0100
  id 000000000000007C.000000005A703FF1.000058A8
Date:   Tue, 30 Jan 2018 10:50:17 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/10] t5812: add 'test_i18ngrep's missing filename
 parameter
Message-ID: <20180130095017.GA7722@ruderich.org>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180126123708.21722-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180126123708.21722-3-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 01:37:00PM +0100, SZEDER Gábor wrote:
> [snip]
>
> diff --git a/t/t5812-proto-disable-http.sh b/t/t5812-proto-disable-http.sh
> index d911afd24..226a4920c 100755
> --- a/t/t5812-proto-disable-http.sh
> +++ b/t/t5812-proto-disable-http.sh
> @@ -21,8 +21,7 @@ test_expect_success 'curl redirects respect whitelist' '
>  			   GIT_SMART_HTTP=0 \
>  		git clone "$HTTPD_URL/ftp-redir/repo.git" 2>stderr &&
>  	{
> -		test_i18ngrep "ftp.*disabled" stderr ||
> -		test_i18ngrep "your curl version is too old"
> +		test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr
>  	}

I think we can drop the curly braces as well, as they were only
used to group the ||; leaving only:

> +	test_i18ngrep -E "(ftp.*disabled|your curl version is too old)" stderr

Regards
Simon
-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
