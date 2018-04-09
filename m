Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C87F1F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeDIUGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:06:40 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:46875 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754198AbeDIUGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:06:39 -0400
Received: by mail-oi0-f42.google.com with SMTP id e123-v6so8883477oih.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0zLsMme1uA6BVtsOAbFR4/+DMmTjCLtqMoAbWqdlMaE=;
        b=CRHTa+Vb8N/Oe5nkLfaqT055zB7YYOL0kiUO53tB6r7lJ/a1bEbK7zKUggNeuIzdzl
         dJf3J3tvS0rfq9Qkkuwpu0CLdWUXZCuNu9TpdW9Itjbk66uaRgvB3D6rfzFA+EXCP/3s
         jdtaF9tQe6uHblKyVY8oewG03LngYd8S2ed0GBkQKdb6WjH63PKqAdiVLcXKxCOl+w/m
         K38q5goeZKHCoKlAhRX0J8RGjq6STNZnNYL0biRNS3Crvrfh6ksVu2PJvaQQ2iR+mpRq
         X0yL2qOtyqpRWhHPNjbbw58KjB0t6gW+jJe2fkrUwNWOtYJ3bPjMJogZOAn+th3TCKqf
         ligg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0zLsMme1uA6BVtsOAbFR4/+DMmTjCLtqMoAbWqdlMaE=;
        b=iTXQZoiAFFrZaQMYZsFReJfz57ePPnPt0xmJEBQSW4VNd1il3v0ARCJV4YRrtAvnc4
         PWrL3Kd26tSetX/gluzD7kcvmderdmOYAHBWybeaNP6Cj4+HdxA8AOfb1/pjxBP8Rc8z
         NcbT3eir1fDTSWe9QcahdWjwsb/RqUlBXM1ZC/0SbNaEWscwNIO+dSEqFwlpxFNMQ6wk
         SpQBhkzjvf/eoh6KRDWxWDxTto3RA0MddBvanKqUF4iswEycIRwQKSmqFVaKaCpjesg4
         ra+xTdqACaT91XR97ri2LpRxEmESsECRPD0wv6CgBjC9Ach9zIXx+qv9K2EwzkVAn/sj
         Vcmw==
X-Gm-Message-State: ALQs6tDaac0Iud0CpKr36PtePKx4rnOn7XNly+E+arnHwzQZB1jLi8PO
        pLYsBtWXMh2klApD4HRcr/XVeOfoq8DlAjS+9jY=
X-Google-Smtp-Source: AIpwx4/Bs/OMn4/sXz7rCv6DsuneyPIGsvkyxnVc9dAB4zWma+h7GfjM+33XDDWt1/nyl3QwXShmZqBARWqARMMLvlE=
X-Received: by 2002:aca:ebd1:: with SMTP id j200-v6mr293586oih.110.1523304398263;
 Mon, 09 Apr 2018 13:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.69.145 with HTTP; Mon, 9 Apr 2018 13:06:37 -0700 (PDT)
In-Reply-To: <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com>
References: <CAFLu24=o0nQveRpMJV-6dhvft0H9PgdBahisBi4EEg=G0BwhpQ@mail.gmail.com>
 <CAGZ79kZ6xWijnZZpcogVm_JCX3nGMzN8ebKyh1vYygNc_dqGFw@mail.gmail.com>
From:   Hari Lubovac <hlubovac@gmail.com>
Date:   Mon, 9 Apr 2018 13:06:37 -0700
Message-ID: <CAFLu24kTRrAq3cOH5H1=nBT94p7uFSsaYJsUC-wN1brPFHk3mQ@mail.gmail.com>
Subject: Re: Windows > git.exe > the result of "git branch" does not always
 highlight the current branch
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't know which party compiled it. I'm pretty sure I downloaded the
installer from https://git-scm.com/downloads, although it might have
come shipped with Microsoft Visual Studio, which I use.

I forgot this detail earlier:

git --version
git version 2.16.1.windows.2

I'm a little behind; maybe I should upgrade.

I just reported the same here:
https://github.com/git-for-windows/git/issues/1623

On Mon, Apr 9, 2018 at 12:32 PM, Stefan Beller <sbeller@google.com> wrote:
> Hi Hari,
>
> thanks for reporting a bug!
>
> On Mon, Apr 9, 2018 at 12:26 PM, Hari Lubovac <hlubovac@gmail.com> wrote:
>> It appears to be just a reporting issue. Probably not a big deal, but
>> I thought I should report this, if it hasn't been noticed: when a
>> branch is switched to by being named with non-original
>> character-casing, then it's not clear which branch is current.
>>
>> Example:
>>
>> C:\repo>git branch
>> * bar
>>   foo
>>
>> C:\repo>git checkout Bar
>> Switched to branch 'Bar'
>>
>> C:\repo>git branch
>>   bar
>>   foo
>
> Is this Git compiled under Windows or
> Git-for-Windows as distributed by Johannes?
>
> AFAICT Git-for-Windows prefers to have a bug on github
> https://github.com/git-for-windows/git/issues/new
>
> Thanks,
> Stefan
