Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26217202BB
	for <e@80x24.org>; Sun, 10 Mar 2019 15:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfCJPF5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 11:05:57 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33428 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbfCJPF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 11:05:57 -0400
Received: by mail-ed1-f68.google.com with SMTP id d12so1862145edp.0
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QuIbmpSxVFBHn06gGuYGfF9cbO1NGh/UwzI+pA5SE+Q=;
        b=ggDe+1hh4Xxz9WrS1uUtyZH0WcSe5WgCD/qAD9O570lCBXgGqaIURLK93DVXTm4ILt
         KxxIaW8mC41JV/PKMAxmmO0+u0cUJk9iVCkMdLulgnjFu1dtJB7xii4WxS/bhvku3m8o
         cFNVhO9MJPzbEBY0d0576jYPME3JML7sDzebYLTsqW0sAxacOHl8jvQ1UGftBU7GcJ3M
         i/nFIU5iSO9Qxc1rZF07X34afn0OvlRyjsCcOGIxe67dX7RtHOSNeEuWSvC8vbZSSwDw
         iibrY4piTjK0sPpR/zj1eleC2y9/Szm/hPVZUqsG90pXINIf+oOWRG7NfrJNngB0siaD
         lVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QuIbmpSxVFBHn06gGuYGfF9cbO1NGh/UwzI+pA5SE+Q=;
        b=DyaSj9mKCgjnDkqP9pf5swFXdApt18hSf+Prb40LKQIMy3KAhNogJX0B4MYj+0bqAg
         JuokqicjWJxWTqalpFfkVuqMzFpyhMTlXNTGjqbfRXBPVT1sWwieUeQCYbarpuvSpk+l
         F5YPBdWS7p+yv33mfZFQDgrH6MZL/pxcSjEIQrcGP1xntT0W577q7BE3muquDEGFtWcg
         BRzX7TZToL3z3sE+r79nJUD1ineWWAumC4lI2YABDZoM6ziCabv+bQPiXWKJk6h2Jmgm
         1tFP5Uzn19daRgOGpSeaS5aGwOvEhK0iYVkx/VMC8YxOky5D9HOTQp4PECYiaFInONyS
         fKVA==
X-Gm-Message-State: APjAAAW1fzwXZcR16tonBxp9hiCm4uCKt1xtQ/qxQ5iru87/R2OYE9Kx
        aO0tBA/QjptmLo2RT+//jh5BBo7zlLpywdefjp4=
X-Google-Smtp-Source: APXvYqzQzaiplM4aqx7cIPrmDkMRoLWHLzDpNb8KNhN6yCkjtra4aSPLCW8xRQWHmTnFLqUOLZ6S/01E3G0MbVbZ0EE=
X-Received: by 2002:a17:906:d541:: with SMTP id gk1mr18946225ejb.92.1552230355024;
 Sun, 10 Mar 2019 08:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190309154555.33407-1-ttjtftx@gmail.com> <CAP8UFD26Zxt1FvwAajV48eBbhPv_q5oSLTekWxApcNpg=xRn3Q@mail.gmail.com>
 <CAOAu_Y+GeHHsxVmqLajtM41H67L83Rxxkp3SqJ-G4GBv=uTDYg@mail.gmail.com>
In-Reply-To: <CAOAu_Y+GeHHsxVmqLajtM41H67L83Rxxkp3SqJ-G4GBv=uTDYg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 10 Mar 2019 16:05:43 +0100
Message-ID: <CAP8UFD274-iDkqPm8-WGXbUmcVqjDE7bSg2bwA-17TWJivn0jA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] tests: avoid using pipes
To:     ttjtftx <ttjtftx@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 10, 2019 at 9:28 AM ttjtftx <ttjtftx@gmail.com> wrote:
>
> On Sun, Mar 10, 2019 at 2:06 PM Christian Couder
> <christian.couder@gmail.com> wrote:
>
> > If you take a look at c6f44e1da5 ("t9813: avoid using pipes",
> > 2017-01-04) you can see the following:
> >
> >     - it changes only one test file: t9813-git-p4-preserve-users.sh
> >     - its title starts with "t9813: "
> I adapted this format in my second version[1].
>
> [1]: https://public-inbox.org/git/20190310080739.63984-1-ttjtftx@gmail.com

It's better because each patch changes only one file, but I also
wanted to say that for a microproject you only need to focus on only
one file. So I would you suggest you keep only the patches that are
about "t0000-basic.sh" and drop the patches about
"t0003-attributes.sh" and "t0022-crlf-rename.sh".

(https://git.github.io/SoC-2019-Microprojects/ has now a "Only ONE
quality focused microproject per student" section with more content.)

It's also a small nit but your patches start with "t0000-basic: " not
just "t0000: " though the latter format is more frequent in existing
commits than the former.
