Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9ECC1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 19:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeAMTrK (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 14:47:10 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:46178 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbeAMTrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 14:47:09 -0500
Received: by mail-it0-f41.google.com with SMTP id c16so12719542itc.5
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 11:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OZh/ErLZ9dHvFe2GuV13dh4iBq8jZfD85HkLYtCDmvU=;
        b=MKdWBOflqZCS/lQBetVpwhu8ePLt/681hvFEpJ4iBR/2e00ZO5DqEZ4opASGKqcWJw
         7syewW0h+fEi2CHolsLWsrVpHqMOaszv4sMIoqGya0ZERs8MCudQWfdbCP1UrQlS6+ig
         YSGvYTom5fgeviQUFVawAE5HLjAI2UjkDi0iZDddfxR1eT8twNeuDluANznmcm+h7Gl2
         hgrBprEfuXuugnf14XtCr2ej6w2UBq6tgZqVV+LnfnV10A+n6CJBg3BNHfRqzQQsEvJV
         fZKfACdZnbtVh5vEK8zAShfNvtjCe86okmvu4wKZPiGOobz2A8w6xxgiXv1+fZlaQCOu
         J1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OZh/ErLZ9dHvFe2GuV13dh4iBq8jZfD85HkLYtCDmvU=;
        b=VP5ajjB5aN5y8CG8ukBrV/hCsIBE//5GrvqwLp8Qicsyl2N0d3TK6KkRTDSQYiOgox
         rOqrWRL2j0M60pYLk5oWBoQwPY4NYqdxAMuJG3aWbWzZZZr589KTyt2Sp1Zw/VtWV/Zy
         +9iQZR97dk9R6TI8LlWEWK/BaGva+U7e4HOl0BWgXehKSXF0E+0sCFRXeeYxcpHvrhw1
         nNAUugyXgz/ri2BRMFPMZY8ybwOWme3y4+52hfxXtiEXPqHptxtjSga5cG9965NDacCI
         Cd0YOAbymQHx1tjmlOIYEvXvgy5FCw3kKb7HHTbSX2FQqr9U9rsRjomNQab5vcTmw1gM
         Nnrw==
X-Gm-Message-State: AKwxytfDOF+5NTkPlzrUOK7Wb5mCMu0ZsT52JFHEQoAZvxeDQffDiZO3
        /4jvASCkRxfsTeER68XB23zyqUDoH5B2CF79GYc=
X-Google-Smtp-Source: ACJfBovORUjkWhJpwLV3+6ElZnMfPlqcUxmqVKbQzju09T1SKq5hMjkgqq28JOWWszid3npzVAI2NAHe7hAgc+RQU/A=
X-Received: by 10.36.137.84 with SMTP id s81mr1703503itd.75.1515872828794;
 Sat, 13 Jan 2018 11:47:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Sat, 13 Jan 2018 11:47:07 -0800 (PST)
In-Reply-To: <CAP8UFD06ZThD=FiccGrYLKpJz6R8NAUzFzMv+zrD4MisfJSbTw@mail.gmail.com>
References: <q7h9lghcob2s.fsf@orange.lip.ens-lyon.fr> <alpine.DEB.2.21.1.1801051217190.31@MININT-6BKU6QN.europe.corp.microsoft.com>
 <CAP8UFD06ZThD=FiccGrYLKpJz6R8NAUzFzMv+zrD4MisfJSbTw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 13 Jan 2018 20:47:07 +0100
Message-ID: <CAP8UFD3VrA5e1NsrnLsdAwWAFiYcf1ghoMogWC=U7oXKAO_bPw@mail.gmail.com>
Subject: Re: GSoC 2018 Org applications. Deadline = January 23, 2018 at 18:00 (CET)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Matthieu Moy <git@matthieu-moy.fr>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 8, 2018 at 12:03 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Fri, Jan 5, 2018 at 12:18 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Fri, 5 Jan 2018, Matthieu Moy wrote:
>>
>>> If we go for it, we need:
>>>
>>> * Admins

From the application site I filled in the application forms and
registered as an admin for this year and sent invites to Stefan,
Matthieu and Dscho. If one of you guys accept the invite, we will have
completed our application.

>>> * Potential mentors
>>
>> Count me in as a potential mentor.
>
> I am ok to be admin and mentor.

>>> * List of microproject and project ideas
>>>   (https://git.github.io/SoC-2017-Ideas/ and
>>>   https://git.github.io/SoC-2017-Microprojects/ are good starting
>>>   points)

I copied the above pages and the application page to new 2018 pages so we have:

https://git.github.io/SoC-2018-Ideas/
https://git.github.io/SoC-2018-Microprojects/
https://git.github.io/SoC-2018-Org-Application/

I updated a bit the above pages but there are probably more
improvements to be made. Especially I kept only the projects that both
Dscho and me accepted to mentor last year as it looks like we are the
only possible mentors this year.

>> I have spent a bit of time recently to document a couple of Git for
>> Windows-specific projects thoroughly, I could easily copy/paste them
>> there, too. (Yaaay, Markdown! Now, if only we could use it in Git's man
>> pages, too...)

Dscho, please copy paste what you have in the above pages.

Thanks,
Christian.
