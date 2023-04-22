Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB875C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 15:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjDVPyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDVPyf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 11:54:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FB11713
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:54:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so4901497a12.0
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682178872; x=1684770872;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ImR8uNQ5G8fReE3PKjqelYu7hFn4Vq64pByV0SX+d+c=;
        b=Wn9bx5+4w3p3dZKOht5j00hKZbpd9s3NRAOgIHWgMhLyWQePFVpZlpFlfPxZPQZ55h
         vhLXITboY1e0qhWf/ye7QugYB3QwrgGab4RQ316oJr3x/Ne+Dlr9BszwO3yO/VJOe12M
         /xgN5exi1zzHka/91ZWrhyavVORGhcoFaoKJE6Ml8vHng00jF8nhtBoSiCtIMLmTdaba
         PF9NmPAtC0AwGYGdrbQysncw4JF9dxVyWuEVEtjm2CqGWOQPtfNg43WzhKxnPDwrJLGp
         0Rdka3eI/z/G0YNdwHiBpHgTeamEuYccHHwb/HLfqPG5Qpv2RPL6NRm+FeRjXyEfb2FR
         1yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682178872; x=1684770872;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ImR8uNQ5G8fReE3PKjqelYu7hFn4Vq64pByV0SX+d+c=;
        b=fmWWSam5QSIIryVfxvpM6tzchjqFgC5UToEMpsXUrZkhBSCvpLEBNxTD+YEDapuj9G
         IvhJYEOQ7Z4Bx1xVP/jjcG/O7ZfVuzHtFiCOl4J//SrU2zDdq/jo7LNrUtMHv2DzX+Pr
         Kt08Od+lp2IdHEXk3icJvv/16CDXtErfz89u/NvevOt7EbarWJSYDa6rUPEmTHfW4mRw
         uh5SV9P6IQu6bI/YOg5RDx7jgrX/3g5fralb9tPvyo9rLMz7JmcMXny4PGiWfwq4kX1V
         0PYQbTOP91cI7sfh/AIkDxqgo6xX8WzKaiUFNzhYEG9Ku7fxcmPtxLC9wr550E6DLrGr
         LS6Q==
X-Gm-Message-State: AAQBX9eUjSPOlm4HWlygvAtufDXxLr8iF7QPJRNDai5BfNTLR4CxH82Z
        /xFjTkJ6UnrBywIi7OtR0LHdV6rbFwqnaJRWwnGTMrpOFflSeg==
X-Google-Smtp-Source: AKy350aRvpWhgAA9w0yXKIySA9eHXgwFmfjwUREt8XX4+nY88n1BwXbETMAApUYwh3VMYVAclej/fyUO1xinSuVltl8=
X-Received: by 2002:a05:6402:1348:b0:509:d371:21dd with SMTP id
 y8-20020a056402134800b00509d37121ddmr666528edw.25.1682178872270; Sat, 22 Apr
 2023 08:54:32 -0700 (PDT)
MIME-Version: 1.0
From:   Aman <amanmatreja@gmail.com>
Date:   Sat, 22 Apr 2023 21:24:21 +0530
Message-ID: <CACMKQb3XsPG=gnmoBdL7Eh6dV2h-LEbGHs+QpBr1g9yV+SSmRw@mail.gmail.com>
Subject: On understanding, exploring and abstractions.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone.

This is Aman, I am a high school student. And,

"I DON'T know how computers (and modern software) works AT ALL".

I have no idea, except about the abstractions I play on. I understand
the case for abstractions, they are what, (arguably or not) run the
world forward.

But it is really , And by really, I mean really frustrating. To the
point where I don't quite enjoy programming (despite the fact that I
have had exposure to "programming" for quite some time). I am
fascinated by these things around me, computers run the world, and I
REALLY want to understand them, just for the sake of it (I guess).

I believe what made computers fun, in the old days, was the ability to
really talk to it. (even Linus tells this in the "beauty of
Programming chapter" in his book, which was written 20 years ago!)
Even C feels like an abstraction, hey the "magic" of compilers, and
libraries.

Even people around me, and 99% of people I find on the internet, to
discuss issues like this, too, don't know how a computer, and modern
software (which runs the world) really works. And people seem to get
fine by it, which is not necessarily bad, but really frustrating to
me.

And my question is, How do I do it? Should I try to build my own
computer? Create a CPU in Verilog on an FPGA. Write an assembler,
bootloaders, operating system kernels, compilers, etc.? But what about
wanting to read how the modern systems work? But if I want to know how
LLVM or Linux works? Or how a modern compiler is created?

People have discouraged me to read source codes, and software
architectures, saying it may not be worthwhile, even IF you could do
it. So what could be done?

Maybe, the right question isn't what to do, but why do I want to, so
perhaps we can systematically deduce what to do about it. So why? I
guess, if you see life as a playground, and I have come into this
world, I'd be an interesting task to learn how it all works. This may
be a bad idea, and I am open to others. Since nobody I have met, yet,
has expressed something like this, I don't know if I am living in a
rock (probably I am anyway).

But learning how a computer (like your phone) works from scratch,
isn't that interesting, and not knowing, down right frustrating to
anyone reading this email? Or is it just me for some reason?

And it goes both ways right? , even if I create a simple compiler,
it'll still be a simple one. Won't it be more interesting to work on
things that I might use, and others might get value from too.

So this is the dilemma of an 18 year old, confused about what to do about it.

(btw, If you reading this, are a hardware person, making chips or
something, do you feel like a king/queen? since everyone builds on top
of what you do)

Regards,
Aman
