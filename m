Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1729F20281
	for <e@80x24.org>; Mon,  2 Oct 2017 17:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdJBRlo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 13:41:44 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:56041 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdJBRln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 13:41:43 -0400
Received: by mail-qk0-f182.google.com with SMTP id q8so5940352qkl.12
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/5RkP5Bjm7TimCLuOmIEzCsW+W9WPNcAQV46VELUFn8=;
        b=YLtuCD/BrdodNJODkXAvOrozyvuLhnatVgpmM5eijgwRCfEt2Bn8SXAlSkjJGnfdfC
         OMC8Kgi+5Oo/hNS3GoPWDI7WOQiSfSx7NSb2wxSGQepyTDyhDsqH146XVmN2ZQpfIPGE
         2fmECc+xBcChTjtemBYRZUk2neARqT0UISz/DNph5CyjwIA8BIfAm2r26NKhjK32fsbX
         uTievShZfL64KgQt0mXAyHt/tia4wRC2AQ6cjUq4MGPdc8S7+Gcync/sM34e3VY5AS7g
         KCtboQ9ncKgiBPxcgCVLRbFzlMpqFJ/HSxtBPnLHM/fvgxQwn6nJRqom/MSIz+HfVgw4
         svlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/5RkP5Bjm7TimCLuOmIEzCsW+W9WPNcAQV46VELUFn8=;
        b=Bfb9xqn0j2eKICKAgeoUib5N/Wg0kcwQoYljL0Cmj45m+Hkh2PKrRHC4HvFincRzF4
         IF5kopCGw+iKiI/p5YCB54fOruJehpbrID6tYe/1sp+LuHdeHX9TdJBHOm9xlrA1A3IR
         fLHrSo85NGPWW8j1Ke07zP9KPOU1kXaBhvDdrBQbYiEyy2WHRgUNWH8XJanwv5PSOQb+
         Kbo8RdF4lE/1o2W+/hGQ89gy29RP6CLknEmoIYSuwYdnFxjXZrsv1Wxtikp70RZr0Efr
         MMppxSX0DK6aAzvOCIyYCLLslMpj0eD9nMBzctQAqbOAbFFIw5Fy2mEtzprr0zs1lsfj
         Bd1g==
X-Gm-Message-State: AMCzsaU1UouYyvXFLSv6FK+il3B+Yfb/D+VCUKzZFPemtXxP07yXkGjn
        E2pFB7gSONMgKan/9IhvStRZvarOtxireEpdZOIp1g==
X-Google-Smtp-Source: AOwi7QDDuJshzlkEacu6tikWFCJ2wBAv3ZtAvz8Li4cbGG7ZORcysVOvq34YfahdCzeKWbsS7w1Mbn772ZPIqkB4C7o=
X-Received: by 10.55.33.203 with SMTP id f72mr16556335qki.176.1506966102093;
 Mon, 02 Oct 2017 10:41:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.46 with HTTP; Mon, 2 Oct 2017 10:41:41 -0700 (PDT)
In-Reply-To: <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com>
 <E8C827ED458648F78F263F2F2712493B@PhilipOakley> <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
 <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley> <alpine.DEB.2.21.1.1709300110350.40514@virtualbox>
 <5fb263a8-d83b-64a7-812f-fd8e3748feb6@jeffhostetler.com> <xmqqtvzjv987.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Oct 2017 10:41:41 -0700
Message-ID: <CAGZ79kbghnWmvQweup=Z79HnVQQCMM65CKgEO3oqDoRp-Bj=2Q@mail.gmail.com>
Subject: Re: [idea] File history tracking hints
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philip Oakley <philipoakley@iee.org>,
        Pavel Kretov <firegurafiku@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> It would be nice if every file (and tree) had a permanent GUID
>> associated with it.  Then the filename/pathname becomes a property
>> of the GUIDs.  Then you can exactly know about moves/renames with
>> minimal effort (and no guessing).
>
...

> https://public-inbox.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org/
>
> I'd encourge people to read and re-read that message until they can
> recite it by heart.

I have rethought about the idea of GUIDs as proposed by Jeff and wanted
to give a reply. After rereading this message, I think my thoughts are
already included via:

  - you're doing the work at the wrong point for _another_ reason. You're
     freezing your (crappy) algorithm at tree creation time, and basically
     making it pointless to ever create something better later, because even
     if hardware and software improves, you've codified that "we have to
     have crappy information".

--
My design proposal for these "rename hints" would be a special trailer,
roughly:

    Rename: LICENSE -> legal.txt
    Rename: t/* -> tests/*

or more generally:

    Rename: <pathspec> <delim> <pathspec>

This however has multiple issues due to potential
human inaccuracies:
(A) typos in the trailer key or in the pathspec
   (resulting in different error modes)
(B) partial hints (We currently have a world of
   completely missing hints, so I would not expect it to
   be worse?)
(C) wrong hints. This ought to be no problem as Git would
   take some CPU time to conclude the hint was bogus.

For (A), I would imagine we want a mechanism (e.g. notes)
to "correct" the hints. This is the similar issue as a typo in a
commit message, which we currently just ignore if the
commit has been merged to e.g. master.

So maybe we'd just design around that, giving the option
to give the correct hints via command line.

So if the commit has the typo'd hint

    Remame:  t/* -> tests/*

the human would see that (and also conclude that by
the commit message), and then invoke

git log -C -C-hint="t/* -> tests/*" ...

which would have the corrected hint and hence deliver
the best output.

Maybe the "-C-hint" flag is the best starting point when
going in that direction?

Thanks,
Stefan
