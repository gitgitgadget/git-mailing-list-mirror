Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DD4E20248
	for <e@80x24.org>; Sun, 31 Mar 2019 17:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbfCaRpx (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 13:45:53 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35500 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731279AbfCaRpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 13:45:53 -0400
Received: by mail-oi1-f173.google.com with SMTP id j132so5446091oib.2
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MQXkZezh4evt5I/UGzN2XH7IPYUZjoKafrwbCXjqhuc=;
        b=H8CoVmt4SXnNEB/PME5zECZcaoeTQtnwaHI3pIyRTybmU4Ru2pEdt5WnRDW0K8veTt
         JeWIIgwyZMH9vloU8o9mrvVSjiaNSpLp2zvM5Yt8k32/VWwjdUHSCK6MKUA3xb+8FJIR
         XOccjDw5moheOyAexrHwggZfeP6lPZnximk2Czj7h1dsNKWQ0SExANCgHt9bBaL3H9Ep
         ySH0h7kVYE9DRmdwu+UXYWQwS8qwFqMPq8rE42YpDRb2kNue2GMlamtnSnuZ5ey59gRI
         DEH8fGzQUFGYqwXSGqMs1CLYMl9n4LAMBE1Bcap2M75oe22MwpdjRIwwQ+cN45Ty9yxB
         me5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MQXkZezh4evt5I/UGzN2XH7IPYUZjoKafrwbCXjqhuc=;
        b=BOWGN527tDo2ISe2bpJcagE4+1xZMqVbfhm+Jb2SuLBQS39nbQLFvqr1Godh76NmwG
         h2ceyjOLMZbVArouJN+u4iuiO6IVHDZXLVHNY787H7j4mKasKxxHFQcot2+NOgXIB0M4
         H9jGTo7iFUOYwO3QjT3oyGVGAEf6OzQiEH+XCRdobm8oYKqQ+Wk/oyf1DYhwdhnj23qd
         h8+7ZndLVy8ONciXpR2fFGJMUD8krHuD33cjJqWZ9mja6cEnHqznAgJ0GjwC3tl2IYyS
         Nl1X6y5RXSLHI1+Q66+uKormeJZH+F6FGINxvFVqqa389eSTKTflH4ekEef4MipV9HnT
         dIhg==
X-Gm-Message-State: APjAAAVDbzm7/yTEzfKbVCgkKRI+J4tG/laf3GAmqNCIDpTn+l1/irDD
        9QGXZ6VMnUy88+6JMruZ9yBciWlJnSdgCLbm+Q0=
X-Google-Smtp-Source: APXvYqwQasmQe1Ol9uS4g55BDv6IZRG/Dsd4rBr/smrGK2cvIoQvcwoMobn5T5sj4t4zSZmMIdDLoWTpemFJuDHvuC8=
X-Received: by 2002:aca:fc8f:: with SMTP id a137mr10012609oii.141.1554054352116;
 Sun, 31 Mar 2019 10:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
 <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
 <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com> <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com>
In-Reply-To: <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com>
From:   Kapil Jain <jkapil.cs@gmail.com>
Date:   Sun, 31 Mar 2019 23:15:40 +0530
Message-ID: <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 29, 2019 at 7:23 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> On Thu, Mar 28, 2019 at 11:14 PM Olga Telezhnaya
> <olyatelezhnaya@gmail.com> wrote:
> >
> > Unfortunately, I can't consult you properly about structure of
> > pretty.c. I guess that would be your first task of the internship to
> > dive into it and think how to improve it. By the way, you could try to
> > make more detailed documentation and that could be one of your first
> > contributions. It will help you to understand the system better, and
> > other contributors will be happy to read it.
>

i traced the cmd_log() to understand the point at which pretty.c could
be used, i only got to userformat_find_requirements().

struct userformat_want {
    unsigned notes:1;
    unsigned source:1;
};

what are notes and source flags used for ?

olga: what approach did you follow to figure which logic in cat-file
was redundant and that ref-filter could be reused there ?
does it include picking any file, go through it entirely and then pick
places to be replaced by ref-filter logic ?
