Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 295831FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbdFPOMO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 10:12:14 -0400
Received: from mail-qt0-f182.google.com ([209.85.216.182]:36348 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753993AbdFPOMM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 10:12:12 -0400
Received: by mail-qt0-f182.google.com with SMTP id u19so64733573qta.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KARXiWRyCF2m/k/uOLXdCvgxq5A304iyFX7d5OOlEqI=;
        b=lRznQh26Kh9rOZqGVIaTkh9yrAhyuGLdxrGNl7A3jRhpr5T0oceSoq8Z5LTWjP2dMr
         VVP6tIlgpaq9tZRiKejxROXxxFAe626Wz7SqlfaNm81rDTaBBrmedCnEaR2dmJs/4eVB
         rJSsoBEcNytdR+YT6wjuPW9UyV4tzTRUHEA0X5d/1Hq/MUMx6qHPIPSF14JGfz6nU73f
         TtDEv0qzvOOAGu9L6wAeYwJUL33yQCV8adOeaMxfyfDtR4yLa+aQkyN09g1EIUumcfPQ
         +ncvPgw7EAfCPWoeMcltvDqXzawC81gcDwdP7+W6DHitqVJgRUsxz5WeCCZohXm3N2B6
         4/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KARXiWRyCF2m/k/uOLXdCvgxq5A304iyFX7d5OOlEqI=;
        b=AwB3ryrrtQOIDGXY1l6/Vlg62Mp9ZZEMm1BE/Pi1Be9gk1teIhNTVBreiTXiGy+RBH
         Xt4OdPoe74GVvBx0Asjdb5TmTWRJqL9RRxqLZxJMdjY+ePujvPlWWS/08LHabf6XlXFE
         CBeafNYNBmHPF5PRZOlIzb3ec6PkwR0o+goS+Er8++FiNT6NHu9w3VIdGPNa120d06Gx
         XwY7h/ZI4ItLv/wpzLK1p4Ke1sNOj3v8izraWPzf8kMXti886BzQ9m5i/1HyXuRXMC8a
         vAPIHyMdwGF+JJqU2aq7k6TeXGT32OWfKIk0QlRz4nXr7/GB/ZgMOM8S/vOQQdeBm9UR
         gUUw==
X-Gm-Message-State: AKS2vOyGxKXEjIHdo0SafIMZgonVKVqd5kiCQVPwvvfuLcdw6RuWim8A
        DevyRGj44DIV4IMUu0vvqIrqZudzZA==
X-Received: by 10.237.45.196 with SMTP id i62mr13173490qtd.194.1497622326589;
 Fri, 16 Jun 2017 07:12:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.86.48 with HTTP; Fri, 16 Jun 2017 07:11:46 -0700 (PDT)
In-Reply-To: <CAGZ79ka=icZDS-6q2dGSxyeLxYw+Zd1M_DSWzmhmHYtbTQTvZw@mail.gmail.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <20170530181051.GA81679@aiede.mtv.corp.google.com> <CAE5=+KXPzY0QX+T26oUAHcV8HUYOCTrpuYN_Tb5cXxF71twmZQ@mail.gmail.com>
 <CAE5=+KUJr2=w3W=ZDTbd=L+8=KtwsV95Q7bcJassjzFncrnBKQ@mail.gmail.com> <CAGZ79ka=icZDS-6q2dGSxyeLxYw+Zd1M_DSWzmhmHYtbTQTvZw@mail.gmail.com>
From:   John Shahid <jvshahid@gmail.com>
Date:   Fri, 16 Jun 2017 10:11:46 -0400
Message-ID: <CAE5=+KWOxNxsLGEV3FEf0i7WM20ttE_34D7qHiPAvRAWi+6JAg@mail.gmail.com>
Subject: Re: git push recurse.submodules behavior changed in 2.13
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 12, 2017 at 1:27 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sat, Jun 10, 2017 at 6:28 AM, John Shahid <jvshahid@gmail.com> wrote:
>> bump. it's been a while and I'm still not clear what the next steps
>> are. I'm happy to send a patch but I would like to get a consensus
>> first.
>
> What do you want a consensus on?
> (Is the change in 2.13 a bug or feature? I considered it enough
> of a feature to not pursue an urgent bug fix. Maybe I misunderstood
> the discussion)

I was under the impression that Jonathan and may be others considered
the fact that `git push --recurse-submodules=on-demand` doesn't work
as before an unintentional change. He asked me previously if pushing
without a refspec will work for us and I responded with a yes. The
question remains if everyone is on board with change push without
refspec to use `push.default` in the parent repo as well as
submodules.

Cheers,

JS
