Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0752A1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 19:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbeHNVyY (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:54:24 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36912 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeHNVyX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:54:23 -0400
Received: by mail-yw1-f68.google.com with SMTP id w76-v6so17025766ywg.4
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 12:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qiw5tlynEslA+2Du2hQLzc4BpvvJBnhGAcItosI2Czo=;
        b=IjhTV3gaHKayCbg7pW93AgRc1LOcyhHNQa1jhYkpHOiMiObJw1qDGTkcw5QaF6ZcVe
         L21lWHMgIblM9l8/LVxp+9foHmh6HFbCTOtwX1C4aPYrIZIc4+tKQ+rHiBHNSTjcrhg2
         Kl+oA+TjSM8zRAkxe5jTYnN3Cd/jXUX+4w0yneVUx+zsgIuD4T95u+7MZTDNb2OVHUoH
         zIoXfOoXY6qS2IaHi1S9/HFEQzcTQag5Y7fgWxrzTReYR2LxmB3elj1eyIuhBMmFRo8b
         FiOuuMxlm+MlTc9HNdcpiSbvpFcfurqUJHiWrCSZIacsxlApHnCZ7VXQ7oSlBvEaEub4
         iAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qiw5tlynEslA+2Du2hQLzc4BpvvJBnhGAcItosI2Czo=;
        b=qW6mhZnhRs5NYu35sY5xcnSB0AuAd0FJJLEPfyTtm+FJCB95fCetwJ5A6O1/6fzURP
         vW9RNHXeGK0Ovj3OOcBxk6RM2cevnavDUAWMfg5z3H1Lkz+5IVAMfCTJrh/r78fYNXVH
         1vFIWW3uL39F4OljkGQP/s9CfLuBqYwmhhL5Lm55Z+/Y8IXRzvL9EVU55iBE2pCyHgpM
         kVBTaJJ0SpJyPFcAn3LBsxE5zck9ESTkkWItt1xcNiN61+PaHeOmpaAyv0wDKhUjUiHI
         7uP/gOHc5umJ0qC4fsTPH/uV4L4evHxcqIaylTdEIEVSKpGAhyM41MPAI87Fu9lClO6d
         FBZA==
X-Gm-Message-State: AOUpUlGD3om8Qmu7nxXm+M9apL2V15mSJJxncWGt4OjwNYIcNP8wB/ed
        H4IpfjppBGSJGeT7ClxDfCXmrpS9ebPudwIFkSMQPxaGEmo=
X-Google-Smtp-Source: AA+uWPzxgbDhdzl8ej2/82OTkuX4CwvgWVjaf80sq+gddKt9cz0yHiekKlTrVuZo1ar0MV97NiwfIR0PZNfjEJxdInU=
X-Received: by 2002:a0d:c5c7:: with SMTP id h190-v6mr13344463ywd.421.1534273547564;
 Tue, 14 Aug 2018 12:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-5-sbeller@google.com>
 <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet> <CAGZ79kYVw3AXLyB1fx07WojN3dLuxJLDrbWwC_7M=9aoB9YuCg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1808141713510.71@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1808141713510.71@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 12:05:36 -0700
Message-ID: <CAGZ79kZhLsUZL+bfoovV+U6W-zX6npERRG86fS8+1GsTQmKoHA@mail.gmail.com>
Subject: Re: [PATCH 4/4] range-diff: indent special lines as context
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:54 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Stefan,
>
> On Mon, 13 Aug 2018, Stefan Beller wrote:
>
> > > > The later lines that indicate a change to the Makefile will be treated as
> > > > context both in the outer and inner diff, such that those lines stay
> > > > regular color.
> > >
> > > While I am a fan of having those lines colored correctly, I have to admit
> > > that I am not exactly enthusiastic about that extra indentation...
> > >
> > > Otherwise, this looks good to me.
> >
> > Can you explain what makes you less enthused about the indentation?
> >
> > Advantage:
> > * allows easy coloring (easy implementation)
> > Disadvantage:
> > * formats change,
>
> This is it. It breaks my visual flow.
>
> > but the range diff is still in its early design phase, so we're not
> > breaking things, yet?
>
> Indeed. We're not breaking things. If you feel strongly about it, we can
> have that indentation, I *can* get used to it.

I only feel strongly about it now as that is the *easiest* way to make
the colors
look like I want them to look. And I really value colors in the range-diff.
Earlier you said that color-less range-diff is nearly useless for you and I
thought it was hyperbole, but by now I realize how much truth you spoke.
So getting the colors fixed to not markup files (+++/ --- lines of the inner
diff) is a high priority for me. So high that I would compromise on the
indentation/flow of these corner case areas.

> >   (Do we ever plan on sending range-diff patches that can be applied to
> >   rewrite history? I am very uncertain on such a feature request.  It
> >   sounds cool, though)
>
> I remember that I heard you discussing this internally. I am not too big a
> fan of this idea, I have to admit. The range diff seems more designed to
> explain how a patch series evolved, rather than providing machine-readable
> data that allows to recreate said evolution. For example, the committer
> information as well as the date are missing, which would preclude a
> faithful reconstruction.
>

Ah! good point. Though we could just work around that and use the email
date for the new author dates. ;-)

> And that is not all: if you wanted to "apply" a range diff, you would need
> to know more about the base(s) of the two commit ranges. You would need to
> know that they are at least very similar to the base onto which you want
> to apply this.

You would say so in the cover letter "This is a resend of sb/range-diff-colors"
and by the knowledge of that tip only and the range-diff you would
know how the new series would look like, even if it was rebased.

> And quite seriously, this would be the wrong way to go in my mind. We have
> a very efficient data format to transport all of that information: the Git
> bundle.

The bundle format is very efficient for machine transport, but I thought the
whole point of the mailing list was easy human readable parts, i.e. you can
point out things in a diff, which you could also do in a range-diff to some
extend. We would loose some of the "fresh eyes" as you'd only see the
changed part of the series. :-/ So yeah even for the workflow this seems
a net-negative. I just thought it would be cool.

> Let's not overload the range diff format with multiple, partially
> contradicting purposes. Think "separation of concerns". It's the same
> issue, really, as trying to send highly structured data such as bug
> reports or code contributions via a medium meant to send unstructured
> plain or formatted text back and forth between human beings.

ok.

Thanks,
Stefan
