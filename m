Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49D951FD09
	for <e@80x24.org>; Wed, 31 May 2017 22:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbdEaW5M (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 18:57:12 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35027 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbdEaW5L (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 18:57:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so19882974pfb.2
        for <git@vger.kernel.org>; Wed, 31 May 2017 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6MA1fP/0Rm3qR0vjmOUBxny8hNQbTWYlKaIetFy05M8=;
        b=aEvhWQ4on0Ae70GVAzlR9hM13B8V1WYsfIPK+6fF54T7Ezg6vf3UIrcZUjRKs98/Zn
         rd/0mnEEuNP2PCsg/s6rsGsHY6mBqTCUjEFIXj/zoQJf4SS4PJKyOg/mWzRyR6REcEwI
         UJEIIR6MGoWdnqKQH5x3eEeqSMVu6Zfr3X190g+2hpeEADejpFnsyf9PUfYMVHJN+y4G
         AJOOSNyM40OG/yVkWNTRyGBO61AiuVF5FsaP4QgGOJoSNb1hSWgoS3JUBH7dlT2SX7L9
         RHJHzXYzgzbrWXA1s/veQW6wB3WRaABuzs5sYDZ9WbP/Ucuv4w4w/XuLqoMzqXDma/I9
         FMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6MA1fP/0Rm3qR0vjmOUBxny8hNQbTWYlKaIetFy05M8=;
        b=sezFyyaAKrBvigAXidA+aEr5VkP05BWv+9iNdPHSa9zdNo8Q5IleLCukIxZtfl+B7L
         GHsKNryqJcRSj2WhDQDxlWaCUKdN09+fv2CiN5YtTFoex75TIUFLbLPeyZKjWI2K/m0C
         yPYzAg4BP1yeEhVv5r1AovZM2WHd947sLB2BPbdvSaeCEHfBYMagSgptn+J7XIUgnegD
         HkNvxzV4Yo1JU50yEXllYOihvtRUlpf2iOsG7QoWIst1f4+0jTSR63qKPaJfZsFMUujs
         XhNWiAruob7cT0HVtCNJRt1SBVVDSJEYGIotbsrpKNiQdGSs70Cdz77VydW4MT76gwLb
         yggw==
X-Gm-Message-State: AODbwcDny3aMdgjsDHVNnmGmInxnqVrr2HLhbSqna6rHhRvxsUPCCPiy
        dIaP5+TtBXdAb1M5Eyg=
X-Received: by 10.84.232.71 with SMTP id f7mr94169485pln.168.1496271430956;
        Wed, 31 May 2017 15:57:10 -0700 (PDT)
Received: from gmail.com ([2620:15c:17:3:7d83:2ad9:ff5e:9a6f])
        by smtp.gmail.com with ESMTPSA id m12sm29528542pgn.30.2017.05.31.15.57.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 31 May 2017 15:57:10 -0700 (PDT)
Date:   Wed, 31 May 2017 15:57:08 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Brandon Williams <bmwill@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Net::SMTP::starttls was introduced in v3.01
 (Re: [BUG] git-send-email broken: Can't locate object method "starttls")
Message-ID: <20170531225708.GE72735@gmail.com>
References: <20170531222455.GD72735@gmail.com>
 <20170531224415.GC81679@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531224415.GC81679@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 31, 2017 at 03:44:15PM -0700, Jonathan Nieder wrote:
> Subject: send-email: Net::SMTP::starttls was introduced in v3.01
> 
> We cannot rely on the starttls method being present in the copy
> of Net::SMTP shipped with perl until v5.21.5~169 (Update libnet to
> CPAN version 3.01, 2014-10-10).
> 
> Reported-by: Brandon Williams <bmwill@google.com>
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Hi Eric,
> 
> Eric Biggers wrote:
> 
> > There seems to be a bug in 'git send-email' caused by this commit:
> >
> >     commit 0ead000c3aca13a10ae51a3c74c866981e0d33b8
> >     Author: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> >     Date:   Fri Mar 24 22:37:32 2017 +0100
> >
> >         send-email: Net::SMTP::SSL is obsolete, use only when necessary
> >
> > When running git send-email I get the following error:
> >
> > 	Can't locate object method "starttls" via package "Net::SMTP" at /usr/lib/git-core/git-send-email line 1410.
> >
> > The perl version is 5.18.2, and the Net::SMTP version is 2.31.
> 
> Thanks for reporting.  Does this patch help?
> 
> Regards,
> Jonathan
> 
>  git-send-email.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 0d90439d9..3441e3cf5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1354,7 +1354,7 @@ EOF
>  		}
>  
>  		require Net::SMTP;
> -		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("1.28");
> +		my $use_net_smtp_ssl = version->parse($Net::SMTP::VERSION) < version->parse("3.01");
>  		$smtp_domain ||= maildomain();
>  
>  		if ($smtp_encryption eq 'ssl') {
> -- 

Yes, that solves the problem for me.

Eric
