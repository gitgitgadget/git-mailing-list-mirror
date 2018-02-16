Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3D991F404
	for <e@80x24.org>; Fri, 16 Feb 2018 22:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750902AbeBPWDF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 17:03:05 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36741 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbeBPWDE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 17:03:04 -0500
Received: by mail-pg0-f67.google.com with SMTP id j9so3464449pgv.3
        for <git@vger.kernel.org>; Fri, 16 Feb 2018 14:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vj9K7SY3KLdURYLCpyXD42ToyGpJ4nrxIiL6mf7QHYU=;
        b=XVROEVQflaLfiIvnr8OuFCe24ASPzg+FbqdsLEieraSHOQMgU5DTTZaA2iQvYdvDUl
         /vAkrJ0INPyvTrzOddGwlPwCnL/F/NJWeoDokvb1hhzl8hOa7Gt2+T6klpOuwHZnftWa
         ZtAy5xmKGWUEkUMi1v7xoB/lPcBY8ImxVPcV7s8YptSd6kd3elf2LIbZFUljjYIpkO2f
         fYEwQDB3Krgym6vts6VHnlfVDF4o7HYrVwGAJnZ3XAXBVxDZKeOEZ/KK3xyeXeOiK2gy
         DcVVCuilQDpdgew0429r2hBihlpq0sLPXOEbzZBVI2rocb04MFXq5Kyj6JHYxMDX3q8k
         s3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vj9K7SY3KLdURYLCpyXD42ToyGpJ4nrxIiL6mf7QHYU=;
        b=svSaH5eIjKMDq6dcJ9E1RZZlk6QxjjHTokUDtibrxQKsUcLcjQEAWC9GmvdnOANxEB
         Idz4QBhLhRYT7n0YPWEJJmcqAsBuk/cXks8DTtipzvDayy/qNbmprtLevUCmWhXBd1cG
         x3wN7cumDH8mPspFjZAexLlVQiIn1X7gMzqf7+ccwzVXpnL6aFuhubddyKx50TeOuVdB
         KqVKmEAGaiGSdN6uzgJtzrhm5cAkmN3QOPeKv5OyQ10AWWgi+ESkw90+7i5pmE9g27tM
         9BZJidCtPOQlzrMYyTMvzzei/bvjjN0Z7mkIAdFfZkf/011JLXgWTMoOVIE5yPB8DfIx
         mnmg==
X-Gm-Message-State: APf1xPDAl4DKT2crGkIcFEWB8lAxzvNhQkAxVb9Mk2miT/B9QqbIIFf8
        Ds5uyV4No6Ef11pRXAHPvcQ=
X-Google-Smtp-Source: AH8x226QjOEPUD0bQRjYbsSdSVtxVFxdFWo/OPkAhVKOKD3Sv3/YP/dBZPMqb7hFR6IRXPJZ3ENo5g==
X-Received: by 10.99.127.70 with SMTP id p6mr6274536pgn.203.1518818583931;
        Fri, 16 Feb 2018 14:03:03 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id 6sm5347114pfh.96.2018.02.16.14.03.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Feb 2018 14:03:03 -0800 (PST)
Date:   Fri, 16 Feb 2018 14:03:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180216220300.GC216564@aiede.svl.corp.google.com>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180215045301.GC27038@zaya.teonanacatl.net>
 <87sha2f0j1.fsf@evledraar.gmail.com>
 <20180215212338.GL27038@zaya.teonanacatl.net>
 <87k1vdf188.fsf@evledraar.gmail.com>
 <20180216175519.GQ27038@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216175519.GQ27038@zaya.teonanacatl.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Todd Zullinger wrote:

> Subject: [PATCH] Makefile: add NO_PERL_CPAN_FALLBACKS to disable fallback module install
>
> As noted in perl/Git/LoadCPAN.pm, operating system packages often don't
> want to ship Git::FromCPAN tree at all, preferring to use their own
> packaging of CPAN modules instead.  Allow such packagers to set
> NO_PERL_CPAN_FALLBACKS to easily avoid installing these fallback perl
> CPAN modules.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
>  Makefile                                    | 6 ++++++
>  perl/{Git => }/FromCPAN/.gitattributes      | 0
>  perl/{Git => }/FromCPAN/Error.pm            | 0
>  perl/{Git => }/FromCPAN/Mail/.gitattributes | 0
>  perl/{Git => }/FromCPAN/Mail/Address.pm     | 0
>  5 files changed, 6 insertions(+)
>  rename perl/{Git => }/FromCPAN/.gitattributes (100%)
>  rename perl/{Git => }/FromCPAN/Error.pm (100%)
>  rename perl/{Git => }/FromCPAN/Mail/.gitattributes (100%)
>  rename perl/{Git => }/FromCPAN/Mail/Address.pm (100%)

Nice!  I like it.

[...]
> +++ b/Makefile
> @@ -296,6 +296,9 @@ all::
>  #
>  # Define NO_PERL if you do not want Perl scripts or libraries at all.
>  #
> +# Define NO_PERL_CPAN_FALLBACKS if you do not want to install fallbacks for
> +# perl CPAN modules.

nit: Looking at this as a naive user, it's not obvious what kind of
fallbacks are meant. How about:

	Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
	copies of CPAN modules that serve as a fallback in case the modules are
	not available on the system.

Or perhaps:

	Define HAVE_CPAN_MODULES if you have Error.pm and Mail::Address installed
	and do not want to install the fallback copies from perl/FromCPAN.

Would this patch need to update the loader to expect the modules in
the new location?

Thanks,
Jonathan
