Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28CB71F404
	for <e@80x24.org>; Wed, 14 Feb 2018 23:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032154AbeBNXtG (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 18:49:06 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40133 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031901AbeBNXtG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 18:49:06 -0500
Received: by mail-pl0-f66.google.com with SMTP id g18so9445618plo.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 15:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bHM++j3Sy6VTODD6BYChCFx1ICIOQ8M+Z4MagK7rtZg=;
        b=vaeGdENuKco5yUV9N4ThQLwxbzUfDYwhopYHh9IypQRCvvsmPphCUhmV3cw6Z9BR7z
         DlZ06EafAY3nLARZOAa1b/M1vaFspV1zGFMBiNLxPvtztor/r/PcZBtMQxl1x8kI/PHg
         eZRCL4+BNLZlMSnSRU7pbVUlr/SK/Jv5kPszWW+EvHXh605M0mpO66rCgqtgNApnrz2G
         KMIiDOp7cRMVbu2+ymyBgaEGTY30ir1dqlliI63r+T59OB0ZXwuPHTTGSgjT1CKeeDEJ
         nxp60r/Qe5vmBji5zwBZtBminoZNPmqAFXohqY9vLQfLW7Q+F732nL2ha9xfS/qcN6pk
         slXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bHM++j3Sy6VTODD6BYChCFx1ICIOQ8M+Z4MagK7rtZg=;
        b=MyvSjNjQMeh32ADQB5zgiZbaAZFjhGJz8rOcfEx1dESly+gbdQRECvAV8skisTNmBt
         ftuBT07dwY1jTYHFjMSy4uBoy7Cw48Kvxmj7yFUBpH5mky/fwpTiXXaekt3iXHnEox2Y
         2egHshoZa4tl4K/Vx0WCrhTJ1uQI+nlh1566HY34NjCgy2Ig6D4QW36Vm5y7c6s5XFyV
         WJjUt8mEn8A3rxONGN2rGLado9UjKS6Ah/rbOgjQOjEuQ+NPaQMZgtkpcDhlI0NinHpJ
         S988z8q/g1Q3F6+/E8TXM46rKBlup2oLU4uDrtiDAD1yyUNradMmUE4Xcg4WBJs4gtKH
         S27A==
X-Gm-Message-State: APf1xPDJQXP6+kYpVuIJNDaxF/+G/MVBHsvhR65nfOSACRpBhtMOdI4+
        FSGhgkZfUQC4MwA2oH5kqsI=
X-Google-Smtp-Source: AH8x2268FQXYs1zKsTq6/3aYvUR59a7fik6FWHktA7DoC0cyDSQnhUNz7YAreulUg6qLgJtB2UhRJA==
X-Received: by 2002:a17:902:5382:: with SMTP id c2-v6mr665359pli.102.1518652145333;
        Wed, 14 Feb 2018 15:49:05 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id a138sm3360766pfd.47.2018.02.14.15.49.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Feb 2018 15:49:03 -0800 (PST)
Date:   Wed, 14 Feb 2018 15:49:01 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@slb.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 6/8] git-send-email: unconditionally use
 Net::{SMTP,Domain}
Message-ID: <20180214234901.GF136185@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180214222146.10655-7-avarab@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> The Net::SMTP and Net::Domain were both first released with perl
> v5.7.3, since my d48b284183 ("perl: bump the required Perl version to
> 5.8 from 5.6.[21]", 2010-09-24) we've depended on 5.8, so there's no
> reason to conditionally require this anymore.
>
> This conditional loading was initially added in
> 87840620fd ("send-email: only 'require' instead of 'use' Net::SMTP",
> 2006-06-01) for Net::SMTP and 134550fe21 ("git-send-email.perl - try
> to give real name of the calling host to HELO/EHLO", 2010-03-14) for
> Net::Domain, both of which predate the hard dependency on 5.8.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  git-send-email.perl | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 85bb6482f2..69bd443245 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1143,10 +1143,9 @@ sub valid_fqdn {
>  sub maildomain_net {
>  	my $maildomain;
>  
> -	if (eval { require Net::Domain; 1 }) {
> -		my $domain = Net::Domain::domainname();
> -		$maildomain = $domain if valid_fqdn($domain);
> -	}
> +	require Net::Domain;
> +	my $domain = Net::Domain::domainname();
> +	$maildomain = $domain if valid_fqdn($domain);

Now that we indeed require the module, any reason not to 'use' it?
E.g. is it particularly expensive to load?

I haven't checked the assertions above about minimal perl versions
including these modules, but I assume they're true. :)  So this looks
like a good change.

Thanks,
Jonathan
