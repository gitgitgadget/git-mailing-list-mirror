Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58B7C1FF30
	for <e@80x24.org>; Mon, 22 May 2017 01:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932083AbdEVBnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 May 2017 21:43:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34739 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756494AbdEVBnO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 May 2017 21:43:14 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so16331511pfk.1
        for <git@vger.kernel.org>; Sun, 21 May 2017 18:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xbfVv4m2UDBdrpJ3vuMg3ytYC3evI5M8yMpSw1RWF94=;
        b=WnIRMvYj12XhG93vWx0v8oRviZIlSF4kufsKdNaqzlb3sZqbgCVtSor5gKqFUCtUL6
         lkeNO4WnVmw8Qqk+8INI6mc3rjGV9vvxZ3tFWb/nBuypgCmutoukgcOF7Dt1nSnPBIVg
         vPpOjUs2YSKcvWjll5yZe2KYohXj8OXOQmcTNazazcd9psUvblHF7GHsz2ND2azFziy2
         iiBubGNX1S9LwNiBttK7oG7dhEdDqLIApOFR0rdA8IebBxIWL5f4yUwaHDaoOHOtG9/d
         sXGOw0z0sADU3RyOaOvVI5aoVtyEb8lGhAF7yv2EQ8XoJGB2RKKoeZsr0DIP7PmAPSk0
         v2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xbfVv4m2UDBdrpJ3vuMg3ytYC3evI5M8yMpSw1RWF94=;
        b=D3tm9QSwfW/q1to42bekbfjr4Ps0G3T4RLv2dBOV22FAVe3kukXLe7rQDXW8qlh3Lw
         wExO8VUfJMUnwK3I8ZaPqSsCoaNLxa9BsXg3J3BBUOPmOuYXsESrpHBx+Kl+iy9ONBaS
         YBtFFPJzW5vjh1r8QembIR5SrGviXgjeQo5IUBd4I+l6GsbEvRJp4BZ/Fzh3Bov5zIWX
         7a4dESz5CUpSjAsagRcNOOlbSGBWQXswwzXSyO/NWxEh6tXlcifi5vQXcf+1Oa4ddYK9
         ksWDThguF58Ky7tSv52OGFjnNF/c/t9464y6zuXS47EzMe1C+FsnSdXtbLfMfmr/5r0N
         Hybg==
X-Gm-Message-State: AODbwcAR+3+GR5XhL8SbXKflvJ7rEBCEWg9fRvQYzf5jFVkZPLQDFUZv
        OCEPcYMx+gBqCA==
X-Received: by 10.98.76.140 with SMTP id e12mr8423882pfj.142.1495417393424;
        Sun, 21 May 2017 18:43:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4439:f55c:c49b:d0dc])
        by smtp.gmail.com with ESMTPSA id u194sm27392728pgc.2.2017.05.21.18.43.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 21 May 2017 18:43:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] usage: add NORETURN to BUG() function definitions
References: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
Date:   Mon, 22 May 2017 10:43:12 +0900
In-Reply-To: <4a5619af-d695-ab6c-e603-368e38827455@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sun, 21 May 2017 23:25:39 +0100")
Message-ID: <xmqqpof1psy7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> Commit d8193743e0 ("usage.c: add BUG() function", 12-05-2017) added the
> BUG() functions and macros as a replacement for calls to die("BUG: ..").
> The use of NORETURN on the declarations (in git-compat-util.h) and the
> lack of NORETURN on the function definitions, however, leads sparse to
> complain thus:
>
>       SP usage.c
>   usage.c:220:6: error: symbol 'BUG_fl' redeclared with different type
>   (originally declared at git-compat-util.h:1074) - different modifiers
>
> In order to suppress the sparse error, add the NORETURN to the function
> definitions.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Junio,
>
> This is built on 'next', which has now merged the 'jk/bug-to-abort'
> branch.

Thanks.  

I cannot seem to cause sparse (v0.5.0-207-g14964df) to complain the
same way, though.

>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>  usage.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/usage.c b/usage.c
> index 7e6cb2028..1f63e033e 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -217,7 +217,7 @@ static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_lis
>  }
>  
>  #ifdef HAVE_VARIADIC_MACROS
> -void BUG_fl(const char *file, int line, const char *fmt, ...)
> +NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
>  {
>  	va_list ap;
>  	va_start(ap, fmt);
> @@ -225,7 +225,7 @@ void BUG_fl(const char *file, int line, const char *fmt, ...)
>  	va_end(ap);
>  }
>  #else
> -void BUG(const char *fmt, ...)
> +NORETURN void BUG(const char *fmt, ...)
>  {
>  	va_list ap;
>  	va_start(ap, fmt);
