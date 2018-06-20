Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95BA91F403
	for <e@80x24.org>; Wed, 20 Jun 2018 14:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeFTO5x (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 10:57:53 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33103 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeFTO5w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 10:57:52 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so3308287oiy.0
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 07:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ad7n0mpP+Z88KUSrX7OuqvpeX8FKIiyENihG+D8anlE=;
        b=ENJcK0Kp1o+zZrnw5TDHsP+JLdcOa1cE8lBUqn8D0Hk725zHRaqAfV4EdVypUo99vT
         Aw69JkfezSUj40xnMkv/NPpN0ab15Ws13xbIXxQNC+pE+TI8x2jBhXR1r1TNQWw860s4
         QNwzax7xuOMYVVqRy7UzeK6AfhyZAIZeMetE9rtW9Gyn3845+l4rJWsWAxiV9TiZIpI5
         NVqjjM6nxzCp0wYi8qYZawBH7ibNJ7GZyK7C67yFayDh/nEAlW7xV+iangviF+/DtZlo
         dt5tZ1nizztYAPHyy/g4bY1DgTpuP5VRAe10PAJaHcfoxrAzRh13MblbXE/EfFy+eB/Q
         8dOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ad7n0mpP+Z88KUSrX7OuqvpeX8FKIiyENihG+D8anlE=;
        b=Q3R0XCVoaqQZfvj8XetZox7z7LuUPWRz5V3aGqG9/uMXf/EyGzD2IEjGve9f7hyrOj
         kC2ylKthcvilIOu/WcLcLzC+CvKSx4DULIoBGW9zPa3kDOXPwF8/SrBYX2fbrS0P0BfR
         AkfTyCWhQ/6hKT1o0rRvuTO/5PVM0uE9V26YCROtrvb0eFZ9FwwpkVdCDcxl5UUg19E8
         v5iujLHl4G4JN6hs4XqiJS5J1uCz80zAOyTsT2UfPsyEeDyHInYP89UlG7N2KPm9cEvB
         OOOG6Ztf23gS/kScQlCT8Yq8OaSEnRxRHpr/X1bdY/z96KbCp3SWgbZ3NZpJhA+13iJi
         jOTQ==
X-Gm-Message-State: APt69E3OxKVy04cOU8LSW3CJd2dV7Q8XOKKI8H5iD6DP6Q6HOWM3oBed
        RsLMznS/wc9SaLdMh/piGIrWSsTEZNshIpqK3B0=
X-Google-Smtp-Source: ADUXVKLppiyYSB4QHFLYvsRLDhqbzK7W41f3y6KmBtg+YT0qzdZ4QXyVDSdFlVvAH170Idk9OXG6NImA+MZLZpHmE0E=
X-Received: by 2002:aca:5144:: with SMTP id f65-v6mr12580426oib.32.1529506672110;
 Wed, 20 Jun 2018 07:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180618111919.GA10085@book.hvoigt.net> <20180618155544.GB6958@alpha>
 <20180619102717.GB10085@book.hvoigt.net> <CACUQV5884fs2wp+R5a-99BbJGdEbujzu2iBny+PjPeL9JeOm8Q@mail.gmail.com>
 <20180620043956.GC6958@alpha> <CACUQV5-ynAv0p9MCRt0Yv9E6x+UN5z4uuaPOt1GpsK6A6MF2wQ@mail.gmail.com>
In-Reply-To: <CACUQV5-ynAv0p9MCRt0Yv9E6x+UN5z4uuaPOt1GpsK6A6MF2wQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Jun 2018 16:57:25 +0200
Message-ID: <CACsJy8CW1=Ea984s8J0Y6y4B6qJKZMdsXVFRQc8YcuoQNfXEqw@mail.gmail.com>
Subject: Re: Adding nested repository with slash adds files instead of gitlink
To:     Rafael Ascensao <rafa.almas@gmail.com>
Cc:     Kevin D <me@ikke.info>, Heiko Voigt <hvoigt@hvoigt.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 20, 2018 at 1:55 PM Rafael Ascens=C3=A3o <rafa.almas@gmail.com>=
 wrote:
>
> On Wed, Jun 20, 2018 at 5:39 AM Kevin Daudt <me@ikke.info> wrote:
> >
> > What this is about that when doing `git add path/` (with trailing /),
> >
>
> This is what I was referring to. If you search for 'Fake Submodules',
> you'll see that some people were/are intentionally using this instead of
> subtrees or submodules. Unfortunately the original article [1] seems to
> be dead, but searching url in the mailing list archives leads to some
> additional discussion on the subject [2,3].

Abusing a long standing bug does not make it a feature. I'm not
opposed to having a new option to keep that behavior, but it should
not be the default. If you use it that way, you're on your own.

> [1]:http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-96=
7e-0e48cbdd56cb
> [2]:https://public-inbox.org/git/xmqqy47o6q71.fsf@gitster.mtv.corp.google=
.com/
> [3]:https://public-inbox.org/git/CAGZ79kZofg3jS+g0weTdco+PGo_p-_Hd-NScZ=
=3Dq2UfB7tF2GPA@mail.gmail.com/
--=20
Duy
