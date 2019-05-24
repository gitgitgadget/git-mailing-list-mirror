Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDEB1F462
	for <e@80x24.org>; Fri, 24 May 2019 09:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390137AbfEXJtc (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 05:49:32 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50294 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389841AbfEXJtb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 05:49:31 -0400
Received: by mail-wm1-f51.google.com with SMTP id f204so8693494wme.0
        for <git@vger.kernel.org>; Fri, 24 May 2019 02:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yWUaIJxUh9ygdJvq8/Wlf2CMddN/280fQ4xNC4qVJZQ=;
        b=lkpCHDX5rUKCCdSIYpze7BKbJVTlNPH7l49xFb0DtD/s7sPzti2IyeAAbU5nJb+sb/
         0zh2X/nDz64eEghbNWhTmCdVCxvSVJ3s5yaTUMDKvFH0QZxBH3xKXAsVSOlBMEYYitAx
         6rhVP4RMoCjMnSJwFzKFR/IkiV++UASxyN4sJOjHP/stgw/eAMGP6Df+05I5XKlq16X5
         Xk4BGsmu8Lh49P5yOCZH3QWspZqvRHuNFacfWhVq474g596CA4G53Q3Bkh65TaY/bwzw
         nANPeeI5TEvaKSO87icwypF0t2pKBP7RHC+1qgClqCi6zkBjx5Iz0YfHzZFb71JCU/xz
         XdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yWUaIJxUh9ygdJvq8/Wlf2CMddN/280fQ4xNC4qVJZQ=;
        b=ZXCntRWDTwtWkFPejcNTO2+v+BmX4T10nVXGR1qBZQB4vmlmQHpr7H4kSA2xDCtW6W
         MDl/W7uI8Nv0R7Z/qKdSoRS2uYrR2ko/x0n8wSYzFgJw3KGx/MRbnyghs68hv+f9UUoF
         PkwDNA0WDlm8tIECTeeOMA3HxwuruFHEMQeGXc1on/WucwHsge1Mem/gStL7eYieNpHu
         fO5SWStD48C3oUurQUs53s+7rbmL8e9LPLXl/Uu982glX9zqsODK6X4cZxDzCDkJoSzA
         firEPve6VHQGD63kzIop8encIeIvteg07wAQh6ifNo1b1CPvlG9Bi+mkMxn6VP+eDGFn
         EvhA==
X-Gm-Message-State: APjAAAX8DoF8K9kcI9krV94uucSAWJqQLCbWui/RW+vfhFjrvNVBgKqv
        GiSeqhPfQRqhJuHfxmAfjAb1Vl/I2Hg=
X-Google-Smtp-Source: APXvYqydgMjQksUEsq+vCaC+dqE8YYRufG0735fyxuyfydivZxu9kyjb94ogp6+u70Igan120M+hdA==
X-Received: by 2002:a1c:4145:: with SMTP id o66mr14429115wma.68.1558691369516;
        Fri, 24 May 2019 02:49:29 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id y130sm1759413wmc.44.2019.05.24.02.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 02:49:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Karl Ostmo <kostmo@gmail.com>, git@vger.kernel.org
Subject: Re: standalone library/tool to query commit-graph?
References: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com> <be719a37-ffa0-26d3-eb9c-0f5ccde52e7f@gmail.com> <86blztq8ap.fsf@gmail.com> <87tvdkg7ld.fsf@evledraar.gmail.com> <20190523222031.GC951@szeder.dev> <f05405d7-c78d-a0e4-75a1-d623f977400a@gmail.com> <20190524093459.GE951@szeder.dev>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190524093459.GE951@szeder.dev>
Date:   Fri, 24 May 2019 11:49:28 +0200
Message-ID: <87o93sfahj.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 24 2019, SZEDER G=C3=A1bor wrote:

> On Thu, May 23, 2019 at 07:48:33PM -0400, Derrick Stolee wrote:
>> On 5/23/2019 6:20 PM, SZEDER G=C3=A1bor wrote:
>> > On Thu, May 23, 2019 at 11:54:22PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> >> and since the commit graph doesn't include any commits outside of
>> >> packs you'd miss any loose commits.
>> >
>> > No, the commit-graph includes loose commits as well.
>>
>> Depends on how you build the commit-graph.
>
> Yeah; I just didn't want to go into details, hoping that this short
> reply will be enough to jog =C3=86var's memory to recall our earlier
> discussion about this :)

To clarify (and I should have said) I meant it'll include only packed
commits in the mode Karl Ostmo invoked it in, as Derrick points out.

But yeah, you can of course give it arbitrary starting points, but
needing to deal with those sorts of caveats makes it rather useless in
practice for the sort of use-case Jakub mused about, but more
importantly a full XML dump of the graph isn't going to get much of a
benefit from the commit graph, it helps with algorithms that want to
avoid those sorts of full walks.
