Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FB9020248
	for <e@80x24.org>; Sun, 31 Mar 2019 19:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbfCaT3E (ORCPT <rfc822;e@80x24.org>);
        Sun, 31 Mar 2019 15:29:04 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:38412 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfCaT3E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Mar 2019 15:29:04 -0400
Received: by mail-wr1-f52.google.com with SMTP id k11so9093405wro.5
        for <git@vger.kernel.org>; Sun, 31 Mar 2019 12:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L3zA12dWTtnPuTNXhmTAEHJ0HObwSkejgOTfrUZvn6I=;
        b=Qn5tJsaxdA6WCzMyJ57UkMwOYKgnfTT3b7TRCfsNmCIG5WPArpsvCU1dr82HeJjOEv
         UKJiZLdPM1UVw7z52ghxYlXXv/MSJRLNayD3rgQcfk2+DT010B/bil28obFOatW7C8Mr
         v1HOB99D+8Hf9qqn7T6fEOR8ZC8X79D4MstK/bQ1UQmsgrsC8MHP51s4vN7g/nRQ/f5D
         j45vIxr8ugctXMiF1eNuRj3fPMYhNRy2QMxpdQGxjiTIuEzWL+maJ9siD8Gq/46NKiAy
         sEcTpIYLFSK21ZIUx8cg0YcFjxy6bLbLDqIQ5lRy0svPI1N5IXewf1ZxKnUidG7sNOl5
         yyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L3zA12dWTtnPuTNXhmTAEHJ0HObwSkejgOTfrUZvn6I=;
        b=Rp+zDNiZuMwc3Z/UosUaO2tS4XJSHuitCdOVCLjzGEXNgUQPZS6YtpuQ0U7yi7ZGFI
         E/fN9EK7VYJVS8+9pBeRTz3zxmi5Z4mhOrdQPWQEZszwp/twndCgksyFWg6HPAY/i3/U
         AE1Uo2pBhNYNOsrzS1oJ6jj0MCR2b8Lv+e0t9F62z6rsOpdYo+snCBPqiYtJp3mk5AZX
         Ypd31FAjXu/dRcIEvfobiPiz88hyWj0pYH/nGOAHvj6HwtIHZ3AkAgmWx16YdA/MqXq6
         WkNzyXTsfPnk8JakE+QiDClXe5p9kOK/2uUcQAqCO0sPfrVCb2/Dl9Z0OZ2qp3PO6Ktd
         vyNQ==
X-Gm-Message-State: APjAAAU1Y6I0IplstjkYzu33nRMPho8pJoQUWro/peKR4t5qMmdST0Gs
        d6Fms1f0j7pcL03zj0D031hXay78S/P9nVFj5co=
X-Google-Smtp-Source: APXvYqz1eAcgldh/KvLBrF2Bqz64fWrmxbZjR2MeziRdCumPOXVBf+6y6ezwCYVUnFRB9bIMtm3i0Lw4WNfvBFHrlss=
X-Received: by 2002:a5d:6a08:: with SMTP id m8mr37586472wru.30.1554060542208;
 Sun, 31 Mar 2019 12:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAMknYEPrrpxESK0onwTHRbVwcZE2YQpT=RVzjb9JfEBEXt4NRA@mail.gmail.com>
 <CAL21Bmn0BQirS=vyTRHBx_kfuEp1JY4uw2wkjm5w_pgwgjA5iA@mail.gmail.com>
 <CAMknYENndiGBkC75aaYwWQZ0rkR5Nn=2L8f-PTzBNOXmhhHWZA@mail.gmail.com>
 <CAL21Bmm+KVsBWm8BJoqMP6LLBr1620quyTO4K7=yPoNWkvvxUg@mail.gmail.com>
 <CAMknYENqM1Q_2v+0_DJtw41M85otpYzbVbbKPyh2NVZ++u=fpg@mail.gmail.com> <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com>
In-Reply-To: <CAMknYEPN2rPsX8CcJVosi-S1W8bLTmMMvgS8E-SwyR74gevtcA@mail.gmail.com>
From:   Olga Telezhnaya <olyatelezhnaya@gmail.com>
Date:   Sun, 31 Mar 2019 22:28:50 +0300
Message-ID: <CAL21Bmk+=id0jat1O1vQLXBV=snXgK81qFit8_xXNogQM31Pyw@mail.gmail.com>
Subject: Re: [GSoC] Unify ref-filter formats with other --pretty formats
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=D0=B2=D1=81, 31 =D0=BC=D0=B0=D1=80. 2019 =D0=B3. =D0=B2 20:45, Kapil Jain =
<jkapil.cs@gmail.com>:
>
> On Fri, Mar 29, 2019 at 7:23 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
> >
> > On Thu, Mar 28, 2019 at 11:14 PM Olga Telezhnaya
> > <olyatelezhnaya@gmail.com> wrote:
> > >
> > > Unfortunately, I can't consult you properly about structure of
> > > pretty.c. I guess that would be your first task of the internship to
> > > dive into it and think how to improve it. By the way, you could try t=
o
> > > make more detailed documentation and that could be one of your first
> > > contributions. It will help you to understand the system better, and
> > > other contributors will be happy to read it.
> >
>
> i traced the cmd_log() to understand the point at which pretty.c could
> be used, i only got to userformat_find_requirements().
>
> struct userformat_want {
>     unsigned notes:1;
>     unsigned source:1;
> };
>
> what are notes and source flags used for ?
>
> olga: what approach did you follow to figure which logic in cat-file
> was redundant and that ref-filter could be reused there ?
> does it include picking any file, go through it entirely and then pick
> places to be replaced by ref-filter logic ?

I just explored how the code works. You could see my commits here [1].
Oh, that's funny, I forgot that I started from creating pretty.h. I
could choose between pretty and cat-file, and I made the choice
randomly.

In cat-file, interface was so close to ref-filter, but the way of
obtaining data was different, and formatting logic was coded twice. We
decided that cat-file gets the data more efficiently, and I changed
ref-filter logic, it works faster now. Then I needed to reuse
formatting logic, and I am still working on that (do not worry, it
must not be a reason for merge conflicts).

I guess you will have another workflow: I don't know anything about
how pretty gets the data, but the interface differs a lot. So you will
have another tasks.

If you have enough skills to debug the code, I definitely suggest you
to go through all formatting process step-by-step (both for pretty and
ref-filter) for different type of input, that will explain you a lot
and maybe that will give you some ideas how to achieve the goals
better. 1.5 years ago I didn't know how to use gdb properly, and it
was much more important for me to start doing just something, that's
why I used debug prints. The meaning is the same anyway.

The most important advice that I can give you: think about whole
process, then try to design your steps so that they could be as small
as possible. I mean, it's not a good idea to make big patches (more
than 3-5 commits), especially at the beginning.

[1] https://github.com/git/git/commits?author=3Dtelezhnaya
