Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60531F461
	for <e@80x24.org>; Wed, 17 Jul 2019 00:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfGQAzk (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 20:55:40 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45266 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfGQAzk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 20:55:40 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so10988381plr.12
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 17:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hDzyBAg6w2T3fcMfOKgpx4hG3i025I1z0ELBH0hXGQc=;
        b=J2Md5BZHApfUC/7aNtrpLJgxAMfX1Io47v9r0zeVwYRhwnPWMMff5msmU9fNcYDNWL
         Ng/cneAMbGcUZad6QGOFOlUuSGYMsbyjiPUDNCCUosV/EQbIRooIU3UmmoubfAOeAQHR
         70A5wwFiyx7niDiBIvwLTCwKonpHfbZHHieUAVKrmZ8KeU37+VcQ2HCqBUX9WNtgQfX/
         Zw5J0IF9X3Nv28F/QLPA4dFc/x6C1pexX8BoW62TrJJFvuZpMcXZh9N6uB92AmBdnQwO
         ujultjKHCz8YvfR2s2xXyzIGmWMkJV4mvr/zLEMVROw+MX9rhxRHoeOyajUHdqPhvObP
         8O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hDzyBAg6w2T3fcMfOKgpx4hG3i025I1z0ELBH0hXGQc=;
        b=QOD4gqcZzl/O5OT7F70bbyC35jUXkzlIRjDN8uDw2LIJS4wmzsAwxr9epz/B8AanMU
         evRKH9NfozRIU1k7txeOfkIyi/ebKOOfbznJZ1bUCddUVXPo0ksnshjo/HcuTyrp/RBH
         2ZNGyjIrn9n6UV0nUGrUzyazrI9bhaqm1xaflSuFFdBghRGkDgewo9pTdoTxa44BjiA4
         07ezpC/xweyQcGWCEbQ5DzsjuF+Snw0mRTjzdd7FvliKGhsb4eqeO/XXA4RVzgA0VggK
         kzpmlpBOXmZOM3CG+C3BEWTmOYoTwKbY0FlMFBoH8ItVdxl9I7sl6yIM4Ik0sc+1/e0N
         DOJA==
X-Gm-Message-State: APjAAAWEzOnnpAdnkbNcWZWNOwHmxUZyGomyU8RFUJeN9zL9vBzOAjRy
        fz0ZJwC2b8U9fw5YW6N0pHY=
X-Google-Smtp-Source: APXvYqy4sFXMTqnfz6T0oDSX610ZyTydgD57t6Qv8x/hfKJoPvsZsDQktTnDL87YNtip2mjYzbZC8Q==
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr36024842pll.197.1563324939357;
        Tue, 16 Jul 2019 17:55:39 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id g2sm34145573pfq.88.2019.07.16.17.55.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 17:55:38 -0700 (PDT)
Date:   Tue, 16 Jul 2019 17:55:37 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [RFC/PATCH] CodingGuidelines: spell out post-C89 rules
Message-ID: <20190717005537.GB93801@google.com>
References: <20190702005340.66615-1-emilyshaffer@google.com>
 <20190709211043.48597-1-emilyshaffer@google.com>
 <CAPUEspgjSAqHUP2vsCCjqG8b0QkWdgoAByh4XdqsThQMt=V38w@mail.gmail.com>
 <xmqq8ssx53a0.fsf@gitster-ct.c.googlers.com>
 <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4l3l520f.fsf_-_@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Even though we have been sticking to C89, there are a few handy
> features we borrow from more recent C language in our codebase after
> trying them in weather balloons and saw that nobody screamed.
>
> Spell them out.

Thanks for this.  It gives a place to advertise future weather balloons,
too.

[...]
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -195,10 +195,24 @@ For C programs:
>     by e.g. "echo DEVELOPER=1 >>config.mak".
>  
>   - We try to support a wide range of C compilers to compile Git with,
> -   including old ones. That means that you should not use C99
> -   initializers, even if a lot of compilers grok it.
> +   including old ones. That means that you should not use certain C99
> +   features, even if your compiler groks it.  There are a few
> +   exceptions:
> +
> +   . since early 2012 with e1327023ea, we have been using an enum
> +     definition whose last element is followed by a comma.

This is an interesting one: it's super convenient, but we have received
patches every 10 years or so to remove the trailing comma --- e.g.
https://public-inbox.org/git/20100311163235.GC7877@thor.il.thewrittenword.com/

I *think* these were motivated by wanting to be able to build Git with
old compilers with pedantic warnings on, and certainly the last seven
years of silence on the subject suggests it's okay.  Should we be even
more prescriptive and say that the last element should always be
followed by a comma, for ease of later patching?

> +
> +   . since mid 2017 with cbc0f81d and 512f41cf, we have been using
> +     designated initializers for struct and array.

Can this include an example for the benefit of readers that don't know
what a designated initializer is?  E.g.

      . since mid 2017 with cb0f81d and 512f41cf, we have been using
        designated initializers for struct members ("{ .alloc = 1 }")
	and array members ("[5] = 0").

> +
> +   These used to be forbidden, but we have not heard breakage report,
> +   so they are assumed to be safe.

nit: missing article "any" before "breakage reports".

>  
> - - Variables have to be declared at the beginning of the block.
> + - Variables have to be declared at the beginning of the block, before
> +   the first statement (i.e. -Wdeclaration-after-statement).
> +
> + - Declaring a variable in the for loop "for (int i = 0; i < 10; i++)"
> +   is still not allowed in this codebase.

Nice.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Thanks.
