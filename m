Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF6751F404
	for <e@80x24.org>; Wed, 14 Feb 2018 23:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032184AbeBNXxC (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 18:53:02 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:38729 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032143AbeBNXxA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 18:53:00 -0500
Received: by mail-pg0-f65.google.com with SMTP id l24so2856093pgc.5
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 15:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Gm0ov3XkpFTxAdUfU/mbQ0S5JYLVs16KYjKK3/g9yLY=;
        b=oWx24viMgaJkvUohLhcHCNZIw+F2QKheVdiJoW+Z7QFN7E0LWLTLPyaNcgiLh81mLF
         gQcBMDZG1jrItrWi/mAOy9p5X4tIf4TwHsR53HvF0DE19LOLL78NUvWD/Jcl/myrp44Y
         YeqR8EpGCB1TBHJzSSh9DtCwvImsYP2rA/A4DzelN6GVvjT6migYc4y7RWvnwDAodFB9
         gr3GWUzQ7Uj/zEhQDSvLwsKQS55s8EUBTOHVw775uCEMjstskAzErfWMtGwDvLCLL9Na
         GmcCy6v/0YfBc0RBikfnoIhxDIkQLO6azbCKrqwi46HvqkX6S35tpTw7IKzbAgjLk4ur
         IPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Gm0ov3XkpFTxAdUfU/mbQ0S5JYLVs16KYjKK3/g9yLY=;
        b=sMA0axpDdVy/Cg9pbbr5ru9hmCqY5zJV/ZI7Lfa3QSk9jdD8RbyKgXn6pWpJ6dWGIE
         DzC+WPFu90jxwkGqxcbQrbHTEg7zRsANgTekqMBRtWoc9icnVTwaBKGLfyvQLrVzh7GB
         lUlKXa5wkRSbuHVKKX4dnUrzodwAUb8CHuN3kvJm2nOrOKU/Qqauc2vQUsFArGo/+Rh3
         YW14Ia4SbLZhB2jFnGGZv8BwV+gqrlzPiNZs49sDEDyyXROAJsujrIZHRwFQ/SVkQESv
         0VVfNJqyd7pFDeGwYUxA55cNF+YDjRl2Syhxf732Xq3ngA+rTKlAinwh9pnxO5eeATI0
         SOEA==
X-Gm-Message-State: APf1xPDTVp3gIgoZnDxYRqeYUQMtOdt0XJKWOOQh+c+3GAITjMXyvitb
        rruV0VY03Dd1w4HcIpDr/9c=
X-Google-Smtp-Source: AH8x226jlyK9JiFJMHdBbIG94smSoIzlpHUUr3Mefj1aaq2s+ZbO6/xm1IRFcvYrcdyjmYEwL9Risw==
X-Received: by 10.99.170.10 with SMTP id e10mr573421pgf.92.1518652379608;
        Wed, 14 Feb 2018 15:52:59 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f10sm34012049pgr.33.2018.02.14.15.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 15:52:58 -0800 (PST)
Date:   Wed, 14 Feb 2018 15:52:56 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 7/8] gitweb: hard-depend on the Digest::MD5 5.8 module
Message-ID: <20180214235256.GG136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-8-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-8-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  gitweb/INSTALL     |  3 +--
>  gitweb/gitweb.perl | 17 +++++------------
>  2 files changed, 6 insertions(+), 14 deletions(-)

Makes sense, and I like the diffstat.

[...]
> +++ b/gitweb/gitweb.perl
[...]
> @@ -1166,18 +1165,11 @@ sub configure_gitweb_features {
>  	our @snapshot_fmts = gitweb_get_feature('snapshot');
>  	@snapshot_fmts = filter_snapshot_fmts(@snapshot_fmts);
>  
> -	# check that the avatar feature is set to a known provider name,
> -	# and for each provider check if the dependencies are satisfied.
> -	# if the provider name is invalid or the dependencies are not met,
> -	# reset $git_avatar to the empty string.
> +	# check that the avatar feature is set to a known provider
> +	# name, if the provider name is invalid, reset $git_avatar to
> +	# the empty string.

Comma splice.  Formatting as sentences would make this easier to read,
anyway:

	# Check that the avatar feature is set to a known provider name.
	# If the provider name is invalid, reset $git_avatar to the empty
	# string.

Even better would be to remove the comment altogether.  The code is
clear enough on its own and the comment should not be needed now that
it is a one-liner.

[...]
> @@ -2165,6 +2157,7 @@ sub picon_url {
>  sub gravatar_url {
>  	my $email = lc shift;
>  	my $size = shift;
> +	require Digest::MD5;

Same question as the previous patch: how do we decide whether to 'use'
or to 'require' in cases like this?

Thanks,
Jonathan
