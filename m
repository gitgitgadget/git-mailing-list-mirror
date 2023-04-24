Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19716C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 17:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjDXR2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDXR2j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 13:28:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A54FC
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 10:28:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-95678d891d6so810081766b.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 10:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682357316; x=1684949316;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyzzXat1HLHTRyQcfQCmDRa3WHfmnd49q85xb1Q41zQ=;
        b=eNoSlIYvFwumb1dP5PlmgpIutKL4sVDmqU81Sqzs5SZkKlLvXap9V5TschpxgO6PTK
         Dp1+Fydj48bmfvrVRBfFHS4tZuPdcoC856MBFCZ/T78/yTppjy/NZqmoF3FbfFwHsyuZ
         umyAdndL2auikA8W5tbhbLXCTjyQu2lw0d/t5j3EIfTbIvkwR0a0nRmxt5Zc3dHNW1WZ
         UcE/uYDIfogwAtIP03sROotwe1Hz25iiRLo7ZFP0yFpSmg7OBxqEcRKHkJd4wHtEA5/l
         8kYzWE8II7iPM7rE/Rz4kDRMC2hLIjWKLpft43aF/5V5AdR+5GAibaJSRuAWboOKeS5l
         3d+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682357316; x=1684949316;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UyzzXat1HLHTRyQcfQCmDRa3WHfmnd49q85xb1Q41zQ=;
        b=Uwc2Hz+r4k7oQGL7G1VeLCcKaxf3V3hQPoAgYBMl10NHI5abhBcRJHy5q6vJuEnidu
         ZbxgpfT+kGCBQ05sw8HEzfkhMgxBKTKhRp7dKa+Wt/9OCZtGkU+TPCSJ1aIRA/VaZqqa
         nqX8aoz5fhjRf0qApFfFD8hHfksgexlj4whngXDbrrowJ9Sr48D2W2FBwkkT4/pE2hsq
         nhtRa8nStRT0T7roKr7BYg0BxZZHHYp7YLXKe/zGnCPoEBs6xxoukYIJliHDJR1eTT6J
         jqkXhEduPmgCNUdItzo0MZb1UKi3izss7e6Qpz+rzyjMLe2k/ebLKOWqcsate+8MPGDV
         oKhg==
X-Gm-Message-State: AAQBX9f9OgsS6MQ0KTQOCLWLPMxR7psuFBRV1h7lKxe275gjfyWnDaCm
        tQWbCKn4m9EMiHaxq6T8ZY2s+Lsm5+gSBY1MPjGGItba8gE=
X-Google-Smtp-Source: AKy350YMlZdDJ2/OCP+OGFYSpBpCftCoNfMzHDPAKSxBGasuRBha3Y2BYt8w01wiWqrMNWsCjF4gjNo/M68wmWLAwRg=
X-Received: by 2002:a17:906:f152:b0:885:a62c:5a5c with SMTP id
 gw18-20020a170906f15200b00885a62c5a5cmr9978196ejb.46.1682357315608; Mon, 24
 Apr 2023 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACMKQb3XsPG=gnmoBdL7Eh6dV2h-LEbGHs+QpBr1g9yV+SSmRw@mail.gmail.com>
In-Reply-To: <CACMKQb3XsPG=gnmoBdL7Eh6dV2h-LEbGHs+QpBr1g9yV+SSmRw@mail.gmail.com>
From:   Aman <amanmatreja@gmail.com>
Date:   Mon, 24 Apr 2023 22:58:23 +0530
Message-ID: <CACMKQb34Mk_37KhVyaj4cb1JnrZPXXmcAhE_QeV=EcF7CRVKPA@mail.gmail.com>
Subject: Re: On understanding, exploring and abstractions.
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a follow up for everyone.

On Sat, Apr 22, 2023 at 9:24=E2=80=AFPM Aman <amanmatreja@gmail.com> wrote:
>
> Hello everyone.
>
> This is Aman, I am a high school student. And,
>
> "I DON'T know how computers (and modern software) works AT ALL".
>
> I have no idea, except about the abstractions I play on. I understand
> the case for abstractions, they are what, (arguably or not) run the
> world forward.
>
> But it is really , And by really, I mean really frustrating. To the
> point where I don't quite enjoy programming (despite the fact that I
> have had exposure to "programming" for quite some time). I am
> fascinated by these things around me, computers run the world, and I
> REALLY want to understand them, just for the sake of it (I guess).
>
> I believe what made computers fun, in the old days, was the ability to
> really talk to it. (even Linus tells this in the "beauty of
> Programming chapter" in his book, which was written 20 years ago!)
> Even C feels like an abstraction, hey the "magic" of compilers, and
> libraries.
>
> Even people around me, and 99% of people I find on the internet, to
> discuss issues like this, too, don't know how a computer, and modern
> software (which runs the world) really works. And people seem to get
> fine by it, which is not necessarily bad, but really frustrating to
> me.
>
> And my question is, How do I do it? Should I try to build my own
> computer? Create a CPU in Verilog on an FPGA. Write an assembler,
> bootloaders, operating system kernels, compilers, etc.? But what about
> wanting to read how the modern systems work? But if I want to know how
> LLVM or Linux works? Or how a modern compiler is created?
>
> People have discouraged me to read source codes, and software
> architectures, saying it may not be worthwhile, even IF you could do
> it. So what could be done?
>
> Maybe, the right question isn't what to do, but why do I want to, so
> perhaps we can systematically deduce what to do about it. So why? I
> guess, if you see life as a playground, and I have come into this
> world, I'd be an interesting task to learn how it all works. This may
> be a bad idea, and I am open to others. Since nobody I have met, yet,
> has expressed something like this, I don't know if I am living in a
> rock (probably I am anyway).
>
> But learning how a computer (like your phone) works from scratch,
> isn't that interesting, and not knowing, down right frustrating to
> anyone reading this email? Or is it just me for some reason?
>
> And it goes both ways right? , even if I create a simple compiler,
> it'll still be a simple one. Won't it be more interesting to work on
> things that I might use, and others might get value from too.
>
> So this is the dilemma of an 18 year old, confused about what to do about=
 it.
>
> (btw, If you reading this, are a hardware person, making chips or
> something, do you feel like a king/queen? since everyone builds on top
> of what you do)
>
> Regards,
> Aman
