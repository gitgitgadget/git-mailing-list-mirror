Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18F51F404
	for <e@80x24.org>; Sat,  7 Apr 2018 02:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeDGCUy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 22:20:54 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:41709 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeDGCUy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 22:20:54 -0400
Received: by mail-oi0-f51.google.com with SMTP id 188-v6so2781635oih.8
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mI6/CAwzbEZfZ52HX2bg+T0Qi0dVuQbUs9HFgXQLpSI=;
        b=QpI3CgkT+seL+ltKcL66meejzCFwRSh37mA6mZCB+mn3AZAjqqQu1tkIsgtyMb4ADl
         QW7ffBZthK7RASB1ekfxp+T6WO8aZn6RgSU5DDE/25VubMz0IC0hdJW4UNgGGjVPdcTc
         xmPzBe1zgL4U6ffp0hqpaqasUHYYXlv7sw49gjy4dIPEeLjpY8PzEcd2MkVT62htsFwY
         yqr+JhtOer6Xhvry8SX87R9PcosS+1wLx4BPEitVKkV4eITzEV7JxMgPWjV8OF9iyKp8
         y8Sug189kyI6sg+l77B+FYwEsm0v4yYZTeltRI9ZZ6QW1sSFwWVbyXjZ+Q66IUFx6iBn
         3Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mI6/CAwzbEZfZ52HX2bg+T0Qi0dVuQbUs9HFgXQLpSI=;
        b=LSoQ/SbzC6RwVBTF5TGab7g4JVF2YH2rK4rnRGwcMipljRVRdeQ++eMCCb2F1CQC6X
         ZmCDF3KO5UJDrNC2orVGoGImBvXbjirLbsoq7DNbfwVYrIz51PENsAT3EQDJwtkYhJxO
         nzOhcXA2kc3XpIPB+Pau9ar4MtEmN8B8DWmNQgMug0o/16xo+S2EdXY2N+jVvHfAOWKi
         a8zboDtPlz4EvhuBJHE1wa/l9bya4xyB98ocbR1dXSLw9l5Ls8qyPN3VfRW7Rl15NKop
         B8W63GlyDPHGaOrsd5OuOROeuqQvUtqOCNifzzL3EV7LjAvHPuUN+Edbrk+IZnEd4iqX
         HD7g==
X-Gm-Message-State: ALQs6tA/FWtGcPxXRoxHOhhC6ShC1X2SIkXrCT8HFJuxx9dY+9Rprdxw
        1/mqQh4LXmpOPmJ9RuK6qnX0ATa3JifIUuazowI=
X-Google-Smtp-Source: AIpwx4//EPS7Gdkwj5oFjmI6ncl8Ini3RDnSN7Zh8S9jtTdGhgMDCkIo9/WTJFwcVgnFpKBeZp7eNygiTZ0WoPUrmEQ=
X-Received: by 2002:aca:c2d6:: with SMTP id s205-v6mr15503076oif.220.1523067653527;
 Fri, 06 Apr 2018 19:20:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.43.98 with HTTP; Fri, 6 Apr 2018 19:20:53 -0700 (PDT)
In-Reply-To: <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
References: <CA+FnnTxbg97A4P3AP7n5RT8+=W8PY0yx3644Ay2Zi9xgKD2aoA@mail.gmail.com>
 <CAPig+cR19LS2vfjBQ71c3j2g61vSHnYRj1iSX1-V_E3Fj=kwOA@mail.gmail.com>
From:   Igor Korot <ikorot01@gmail.com>
Date:   Fri, 6 Apr 2018 22:20:53 -0400
Message-ID: <CA+FnnTzfJMBuSMAD7PgUurRu8jOpirEgM6=+=i91zdGLWmfUpg@mail.gmail.com>
Subject: Re: Is support for 10.8 dropped?
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Eric,

On Thu, Apr 5, 2018 at 5:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Apr 5, 2018 at 3:48 PM, Igor Korot <ikorot01@gmail.com> wrote:
>> Is support for 10.8 dropped?
>
> Until about a year ago, I was still periodically building Git from
> source on MacOS 10.5, and there hasn't been any outright effort to
> drop support for older MacOS, so I expect that 10.8 is still supported
> by the Git project itself.

This is promising...

>
> However, whether various packagers of (pre-built) Git support 10.8 is
> a different matter.
>
>> dyld: lazy symbol binding failed: Symbol not found: ___strlcpy_chk
>>   Referenced from: /usr/local/git/libexec/git-core/git
>>   Expected in: /usr/lib/libSystem.B.dylib
>> dyld: Symbol not found: ___strlcpy_chk
>>   Referenced from: /usr/local/git/libexec/git-core/git
>>   Expected in: /usr/lib/libSystem.B.dylib
>>
>> Now my question is - how I can upgrade the git console client for my
>> OSX version?
>> It looks like all installers are written for 10.9+ and the only way to
>> work it is to update the OS?
>>
>> Is there a version of the git console app for OSX 10.8?
>
> It's not clear what installer you used? Was it the package from
> git-scm? Was it from Homebrew?

I just tried the git-scm installer and got exactly the same error
during the runtime.

>
> I would guess that, even if the git-scm installer no longer supports
> 10.8, it is likely that Homebrew does. Have you tried it?

I don't want to pollute my system with Homebrew.

>
> If both those options fail, you can always build from source.

Where do I get the soure code? And how do I build it?
I guess I have only one option left. ;-)

Thank you.
