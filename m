Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF6541F731
	for <e@80x24.org>; Sat,  3 Aug 2019 23:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfHCXjm (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:39:42 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37641 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfHCXjm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:39:42 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so77649948qto.4
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cjsv+pkwppUtvwDMh5+BeLgCdgYzkOnVntyT5NjmjcM=;
        b=YRU2x8sjfm/+ROaGbLk4rie7YC9eSniwvJf23o7Uvpws6jn5DoG2+aM51Kd0+qjpP5
         8MFte7TJxAo6bokn58pybNPse33I53z3WTMa0wAQtFK6rvJC6RLqaSsAmNgabvWNIKGE
         61RFyH/bbmMZT8CydND+0S4tj/C20RlAc3cSuCc8s/zK8Wy364T0PnW12b6effZxhB9T
         de22NQ8mNEXa96FYaa98qPaewLshFn90+70jwOgu4WDC84daw12YJ5A8Urmo5CZwvJgk
         +Z7DqsoYZkKTf8vqFVm1cYAw3IhgiScu4Vduso3Q/43jMN/RR88LJ2lzCvr5AtDlQBm/
         J/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cjsv+pkwppUtvwDMh5+BeLgCdgYzkOnVntyT5NjmjcM=;
        b=M4AmqPDNlaDJem2GjL+xdGs6dQeZm1mb/gxZZ8SqffTWCsPYNaeJCL7Rn4xXjYZLXg
         dZvDcQTOvS7d5cm0oMf87vghrVAUscaec6m2CPC9rstFBPt/N6xjjvaqFa4Zc1tVSdyj
         T7UKPQQehiNrh15SzYNuTdv3A4YxCLJdjMZOFfWRojQ3h++oAl+yZ94ZSkBcFzK1fYpN
         xaElg0T0i/9easfdbzbTYT7G+TbyMP82clmuAhY3peIWs/chSb8RzkXM8Yne6iOvv4Yf
         OZK5hwUPgBtxD2QV4V8Xspr4HfYJg+Jt6DkNRV4N90NVBrQPD7e5iKpJ5LDcXtiadj0M
         ly0A==
X-Gm-Message-State: APjAAAXrFlNFQtWDwEgj4yEnBoVStvZRSW+kW1u2+WQ+2sl1MdLyNFep
        tWYcgP9f/Vo2590lX/7ecQGNXKjJNtsFzpGAAU8=
X-Google-Smtp-Source: APXvYqwpY93V4ur9L83K8Wvu9lfwoInQ/LCRuxBP9EVjGIh3DoUYqEbM4rwqIQAzMe6hccIfI4IHF3ncYmOmVRikDDs=
X-Received: by 2002:a0c:d1e2:: with SMTP id k31mr105414956qvh.173.1564875581148;
 Sat, 03 Aug 2019 16:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190708111459.135abe50@zen> <CAHd-oW5Q1PWDzWKpsmdv4ecUMrQTj4Vyh_SoVu6vaFeSFmxE5g@mail.gmail.com>
 <nycvar.QRO.7.76.6.1907101313450.46@tvgsbejvaqbjf.bet> <20190716211012.226b7059@zen>
 <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
In-Reply-To: <CAHd-oW61RFCySF+gUj8iYuV6afEoD0RD9oYE+N6rYd7rv3J2nA@mail.gmail.com>
From:   Brandon Williams <bwilliamseng@gmail.com>
Date:   Sat, 3 Aug 2019 16:39:30 -0700
Message-ID: <CALN-EhTugXw6J7eA=JznGGuk7d5FfMu7s2p44OYKZgOqaN1oOA@mail.gmail.com>
Subject: Re: Weird behavior with git grep --recurse-submodules
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Daniel Zaoui <jackdanielz@eyomi.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 29, 2019 at 1:27 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Tue, Jul 16, 2019 at 3:09 PM Daniel Zaoui <jackdanielz@eyomi.org> wrote:
> >
> > Hi Matheus,
>
> Hi, Daniel
>
> I'm sorry, your last message went to my spam folder for some reason :(
>
> > Thank you for your response.
> >
> > I really hope the change Brandon made is not a project decision. At least, it does seem to me like a bug.
> >

Since I'm the one who originally implemented the --recurse-submodules
feature to git grep back in
0281e487f (grep: optionally recurse into submodules, 2016-12-16) and
then subsequently changed
the implementation to do the recursion in process in  f9ee2fc ("grep:
recurse in-process using
'struct repository'", 02-08-2017) I can say it was definitely a bug I
introduced during the conversion
as I don't believe I would have intended to introduce that change of
behavior (especially without
documenting it).

> > How do you recommend me to solve this issue? Is there some place where I can check if some bug ticket has been created on this matter? I didn't find anything in the mailing list archives about this.
>
> I think I manage to solve the bug with this[1] patch. I'm going to ask
> my GSoC mentors to take a look and then I'll send it to the mailing
> list :) Thanks for reporting it.
>
> Best,
> Matheus
>
> [1]: https://github.com/matheustavares/git/commit/37aeeb3ab86b5dfebfaafeb98d34e379341a529d
