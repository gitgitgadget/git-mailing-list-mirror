Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 054761F404
	for <e@80x24.org>; Tue, 24 Apr 2018 10:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932746AbeDXKhu (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 06:37:50 -0400
Received: from mail-ot0-f175.google.com ([74.125.82.175]:37622 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932742AbeDXKhn (ORCPT <rfc822;Git@vger.kernel.org>);
        Tue, 24 Apr 2018 06:37:43 -0400
Received: by mail-ot0-f175.google.com with SMTP id 77-v6so14581350otd.4
        for <Git@vger.kernel.org>; Tue, 24 Apr 2018 03:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+qTdL9SeIme2xXr7KIsffEPL+sPxE4yvRJEUJ7BonQs=;
        b=JTTogByHrDWh/Dhz8+eL+qL6aP2OR9YN4g6Qn5zkcHJWDur16yTyP0hNTL6j28rWfp
         L/WDkv2W38UnwDUq7hzNo4WX6FDu/DZLcTsUWy4T3FIJTJdGZkgXzyI15TB7z13vT8xy
         DrkC8N6d6NwcpA87kNShD7h8H0yYaxKT6mQaOlD8NWmcIPv6NtZAt54U5bygl/fg40Tr
         Eo9pRTtOav12q/BeakRTZC9Eb+vdvB8zBqwlfI8m6ME8b0ETk0pYtDptelYhIKoD4eat
         lAOkAxmft9PfBxY7URlkobPEiS2zUk8R+k11DUp8DjmX062+f1eH7XpxVZyer2RLq3sx
         csEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+qTdL9SeIme2xXr7KIsffEPL+sPxE4yvRJEUJ7BonQs=;
        b=DysSPzTobfB8hW688qg6PaeM15MkHrskSXAwg7OMpium3pJaHO/Mt34g4ll0dRM+LY
         KnGazxhWnUTwIff6OxRHozfrnPgpgHFiUAfPwwHs3tJS9CpugubYNECZ/JSf61gVWo1z
         v90Mbq2jyBremRO+mAFND6v6J3O/14rf7lgLAhUswUbKnbxmvHw8l7plEhSA3lqaKcTf
         QarnJIgxh7pbZyZi/BGYFgfV4oMKMk+07m493tT2XuSvWmlinELD9pvpe8yEb6ohiTE+
         PGUKFZk0A+9F0F4LE2UKMvQoqWdk5r3duH+eSGdpyVH7V0WqcBJq0v7xpiHFYwgyn/WO
         vyRg==
X-Gm-Message-State: ALQs6tDGx91vVuh3mFxJAQ0iR7WNzkWyOQ/1hd0nOvgp/zTpnIZc4xvv
        UuxOPosgmBeeHyt9DnsHmekWvwzf5m4LqUzyZA8=
X-Google-Smtp-Source: AIpwx4+YTkNLwi/KbWEp+7MPcuDxLTGX6gh1Abhf0ex+0WRHL95df/ckyU2B7KAej/I8SU0Cm30O92thLKbHoDjSvRw=
X-Received: by 2002:a9d:388e:: with SMTP id p14-v6mr16573179otc.38.1524566262614;
 Tue, 24 Apr 2018 03:37:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6058:0:0:0:0:0 with HTTP; Tue, 24 Apr 2018 03:37:42
 -0700 (PDT)
In-Reply-To: <CAP8UFD1H9vUVkx2rCJ03954jZp==Wj+O06hO1YYPQcVHbSV_Zw@mail.gmail.com>
References: <CAEbJ=SN0h_eO+0CJQGEnEafhzgAYdgXByUqb_vsC1rgGw7jNAw@mail.gmail.com>
 <CAP8UFD1H9vUVkx2rCJ03954jZp==Wj+O06hO1YYPQcVHbSV_Zw@mail.gmail.com>
From:   Vladimir Gorshenin <gorshenin.vladimir@googlemail.com>
Date:   Tue, 24 Apr 2018 12:37:42 +0200
Message-ID: <CAEbJ=SMh0801GV6Yfibbj2ynL9sJQFpbi6N_q7UMXu-xayXoqw@mail.gmail.com>
Subject: Re: Git archeology
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <Git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Thank you for the reply.

After I got the reply from Szedar I was so excited about git community
passion for help. And your reply made me ever more assure in it.
Once again thank your for the comprehensive answer. I appreciate
Daniel German's research and going to try token based method in my
task as well.

Have a nice day,

Vladimir

2018-04-21 8:43 GMT+02:00 Christian Couder <christian.couder@gmail.com>:
> Hi,
>
> On Sat, Apr 21, 2018 at 8:19 AM, Vladimir Gorshenin
> <gorshenin.vladimir@googlemail.com> wrote:
>> Hi,
>>
>> My team and I as well as millions of other developers are excited to
>> have such tool at hand as Git. It helps us a lot.
>>
>> Now we challenged ourselves to be even more productive with Git
>> analyzing our usage history.
>
> What kind of analysis do you want to do? Is it the same kind of
> analysis as described in the "Token-based authorship information from
> Git" article (https://lwn.net/Articles/698425/) on LWN.net?
>
>> And there is a problem, which I believe is fundamental for Git (please
>> prove me wrong): how to find all overlapping commits, e.g. touching
>> the same lines of code?
>
> It is not very clear what you would consider overlapping commits or
> commits touching the same lines of code. If some lines of code have
> been duplicated in different files, for example, are the commits
> touching the original lines relevant to what happened to the
> duplicated lines? And what about lines that were moved from one file
> to another or in the same file?
>
>> I played with =E2=80=9CGit diff=E2=80=9D and =E2=80=9CGit blame=E2=80=9D=
 but without a reliable
>> result. =E2=80=9CGit diff=E2=80=9D gives only relative number of lines a=
nd it=E2=80=99s not
>> easy to track these number through 1000+ commits. =E2=80=9CGit blame=E2=
=80=9D has nice
>> output but without any information about deletion.
>
> Did you try 'git log -L' as Szeder G=C3=A1bor just suggested?
>
>> What would you advice me to do?
>
> If 'git log -L' and other git commands are not doing what you want,
> you might want to take a look at cregit
> (https://github.com/cregit/cregit) and maybe at other work from the
> people who developed it. The above LWN.net article is about their
> early work.
>
> There are links related to this tool in:
> https://git.github.io/rev_news/2017/05/17/edition-27/
