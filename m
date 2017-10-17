Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23A4A1FF32
	for <e@80x24.org>; Tue, 17 Oct 2017 19:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966005AbdJQTfQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Oct 2017 15:35:16 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:56494 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965952AbdJQTfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Oct 2017 15:35:15 -0400
Received: by mail-io0-f196.google.com with SMTP id m81so3491426ioi.13
        for <git@vger.kernel.org>; Tue, 17 Oct 2017 12:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SHLqroh7ZQWBo/xqL+sJ3re8S4LPxsQ2fCZLymbzoR0=;
        b=IIzic+PRKr8tz0w9YElUSMOTPAbmJ2BmKrTJDye91t3gLmouVgqTo+6tcDVHsZtduM
         MYnd4bUv1SVtaVSur4aH7cn7jKYAQj04LC1TFCHBxk8Z4rSMLSJDwporA5cEiqLUubS7
         OPtzONNzndjoHdmqwVJO8msWRGV7nuwsXiGunPbmo+lRtlHFhTpUElAID2vL48dSPhMz
         ngj+/WNMwGMIicOi/p+AdP1sqUGTfrbmYXvkU4iMPCL3vBkCCEQKIyYNOyTh3q+ltB/t
         Uw5zUDjxGCcp3fKd0ykGfzWWWLDWxnVsWnialcpEVXhT099ybHuwuP+rln7s/+a4fFQJ
         9BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SHLqroh7ZQWBo/xqL+sJ3re8S4LPxsQ2fCZLymbzoR0=;
        b=WgIgqty8iHBm1TQCf6cZ6cnD4wm63pfJmQ2DZfVCRNKqK3r0P8lOnMNtNIIuXdCTqB
         2cPxKG7JBZSrMDCiFPvVXWZ2lqKbrYoYNbpDLWsJVk9KV+AiY5D0FCPXNjijO16nO8JP
         cmkfNBMN1H4FkAbDoiZ8hdHo7kTwIjkou5dO6lSxp0Ix4YeRJ+6B4XdUqnyyRTx0U+k+
         ytN4AYPiwH+snSHORxRTvrgVHKQZbsg5M4kcwo8xSs9b+ccITCVk5e2xIATIp1bGJBAn
         YYtKb+ccZ9m53/XoGVpbnUQK1dqvtEvbryf7yXOJS2fnbgQVVH0XVN8n4ijPklJHw0fh
         VS7Q==
X-Gm-Message-State: AMCzsaXZiwWfno1XGfKAC9Z6eTzd6j0AYsi7lkdPi6UF1v3F47tINp5v
        zbSdw/5E0qyTfJqJcRcSLZ5qZE8+
X-Google-Smtp-Source: ABhQp+T1VWK+dK7OU4SPX1hd+uqOTEa+Oy6MCqcdLkOSF55HhrGYEyHSZwqlVmuQurJtR9lrQtGdjA==
X-Received: by 10.107.13.134 with SMTP id 128mr19419183ion.160.1508268914558;
        Tue, 17 Oct 2017 12:35:14 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m12sm5616840ita.10.2017.10.17.12.35.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Oct 2017 12:35:13 -0700 (PDT)
Date:   Tue, 17 Oct 2017 12:35:11 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] fetch doc: src side of refspec could be full SHA-1
Message-ID: <20171017193511.szbmrclju22a6p5l@aiede.mtv.corp.google.com>
References: <xmqqinfepguv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinfepguv.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Junio C Hamano wrote:

> Since a9d34933 ("Merge branch 'fm/fetch-raw-sha1'", 2015-06-01) we
> allow to fetch by an object name when the other side accepts such a
> request, but we never updated the documentation to match.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/pull-fetch-param.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Good catch.

> --- a/Documentation/pull-fetch-param.txt
> +++ b/Documentation/pull-fetch-param.txt
> @@ -23,9 +23,11 @@ ifdef::git-pull[]
>  endif::git-pull[]
>  +
>  The format of a <refspec> parameter is an optional plus
> -`+`, followed by the source ref <src>, followed
> +`+`, followed by the source <src>, followed
>  by a colon `:`, followed by the destination ref <dst>.
> -The colon can be omitted when <dst> is empty.
> +The colon can be omitted when <dst> is empty.  <src> is most
> +typically a ref, but it can also be an fully spelled hex object
> +name.

nits:

s/most typically/typically/
s/an fully/a fully/

With those tweaks,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
