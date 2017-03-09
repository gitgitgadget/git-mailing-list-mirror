Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92F1C202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 16:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754776AbdCIQPv (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 11:15:51 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:32962 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbdCIQPu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 11:15:50 -0500
Received: by mail-wr0-f169.google.com with SMTP id u48so48402074wrc.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 08:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ubTN7saGQYZEADtboTDW9zF1q0HE2mpjNsXMUco5zg0=;
        b=G7RVqMT0iWb9jyNZhuxOvrId+SFyd8jllM6dT2nx3Bfz6qI7+x5kUdyStz4D53egNO
         TVwnP7GiBgy9HWu57lK1YBrR9WevPo3e1TPa9iowBrQDd5bIuSuS4GHkCEeVOUc3v3e0
         SrS7PGZmXzIYL8zvqUeVIIO01vBRk8vA+L12MdllKYZP74mOLP/wip8WseqK606JSZrI
         savXaRgzvLPD8rxiEm/30QfBiWy7ImQbkfvTOUNCdqK1PKCGrdl0QjwntlkkQUkfyMMQ
         WsmYvsReDekTsylSMgLr4sn8LEbsnZ0aZwWnTMssl5TA9piPSd/rxkPVWYFws/ruDRTd
         edHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ubTN7saGQYZEADtboTDW9zF1q0HE2mpjNsXMUco5zg0=;
        b=aBBy7bQib+v+X8jigjFnUEAHSO6miQNJdK0DvyOcewwP8GZhycImPRtr8pYy22OzLt
         TqkKhmfBmXRDzJdltvZT7sQ1V3e2stxIst9qMUol8q8jJRQ6K17rbfmz6JeMyRHiesN6
         D9GHpw6nbbXbdu7gSPnG5vdDrvKftMUs1yw+DGCPCPqNTHbmgTjuFfvJkvoV5TkRWOoW
         OkiNEsZG+TqDayWdDYcJVaaoO13YqjHgpyp3hw08hH806T0X3Dvbawpeq9M1jUH/uRkI
         GZZUZH/hgxFSC7Uegpzp7jzQLTDE7WNgwg/maE4b8v8kHdkj+8FA5WB6jRmIhzUiT1If
         M0Dg==
X-Gm-Message-State: AMke39mb3i4Yn+OXfxUPAc4X3McTv4oy1qxoto/BLmUvGbeMovJfuA39if0owmkJu0GYBao64onEFzU0bS7ljw==
X-Received: by 10.223.166.7 with SMTP id k7mr10763724wrc.52.1489076148345;
 Thu, 09 Mar 2017 08:15:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.28.126.201 with HTTP; Thu, 9 Mar 2017 08:15:47 -0800 (PST)
In-Reply-To: <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
References: <5e5b1b92-f7c6-2987-356e-1aab2bff557e@gmail.com>
 <20170308133348.2ovfsi44vq2rpgom@sigill.intra.peff.net> <CAHGBnuM3iM-kHdxdox_1i56uLbv7gQ5ZUY9Xqf4BG7G_kTf+jQ@mail.gmail.com>
 <20170308140110.wgdedquqwm75zws2@sigill.intra.peff.net> <CAHGBnuPGPcWwbrZX_92XDJu47bpH=kj2PZ7yWHK=MRfZ_RHXrQ@mail.gmail.com>
 <CAGZ79kbwMhL-ZnL-iYwPH=tWa8cNQbEGOYYQBw6OzFCMhOWE-w@mail.gmail.com> <xmqq8tof32x9.fsf@gitster.mtv.corp.google.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Thu, 9 Mar 2017 17:15:47 +0100
Message-ID: <CAHGBnuNv--R3FMpRWsvhFJU5_R2Rji=nCjqQsuXrK0UU30eByw@mail.gmail.com>
Subject: Re: diff.ignoreSubmoudles config setting broken?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 9:54 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Between these two:
>
>         git -c diff.ignoresubmodules=all diff
>         git diff --ignore-submodules=all
>
> one difference is that the latter disables reading extra config from
> .gitmodules (!) while the former makes the command honor it.
>
> This comes from aee9c7d6 ("Submodules: Add the new "ignore" config
> option for diff and status", 2010-08-06), which is ancient and
> predates even v2.0, so if you see problems with v2.12 or v2.11 but
> not with older ones, that would rule out this theory.

Thanks for reminding me of possible settings .gitmodules. Indeed I have

[submodule "scanners/scancode-toolkit"]
        path = scanners/scancode-toolkit
        url = https://github.com/sschuberth/scancode-toolkit.git
        ignore = untracked

in .gitmodules, which explains why globally setting
"diff.ignoreSubmodules" to "all" had no effect.

-- 
Sebastian Schuberth
