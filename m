Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7001F453
	for <e@80x24.org>; Tue, 19 Feb 2019 14:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbfBSOTH (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Feb 2019 09:19:07 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:34466 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBSOTH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Feb 2019 09:19:07 -0500
Received: by mail-ed1-f41.google.com with SMTP id b3so16935896ede.1
        for <git@vger.kernel.org>; Tue, 19 Feb 2019 06:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DAMuDaMP4bkFywLNjhSVT3SwYfUArLNUcDrMtf8bOzo=;
        b=C3WwXtKZ+uSWC76Ydk3stcTISfpfqbn/To8fABZTVz2CLGPAUzfXjtEHiVaM7l0cBR
         Es5IHlYdWv/EBobpT8fkTKhV95a25HWeZiRJ28GqeG3D2Z/EJxm+AxMID201bMCJu2Hc
         NpVvqW9gI84gS0b3yZaflShYNGOKWY6crnPG2DR43ntkBHkya93n1vLJfuVfxBQBkCrg
         OaQXf8pktNin+VLVAFJGGumVG/uXAXcTaFLoEImNc2FkTnfDYXquLWo82oHio8jdPfAW
         N02Lz+Dee0iMGmQSRFO2BfWO/ShJbr6bcxpQEbDDO1QWFZ1TpM6RhE8Z51z8R0pMA2uv
         Rf3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DAMuDaMP4bkFywLNjhSVT3SwYfUArLNUcDrMtf8bOzo=;
        b=nuh9A9LJ2x8nZpAIWSNRyJS2PaNHXKQbAIlBFjhILNpbDeNvjdpM34XDt6DAAsRMI6
         0aUetUnZb/GTbLMJA4CX5w1YRf2iJDuLwcFyBFqJ2NntyaCKPa0shfn/2R3G8Da7zJpc
         pok6vJeofSynfHKKvoGIcOHYjS+z91Gh86zy6FbzsXEYZZ4lfqJlds7FwPetYGJL2gL0
         D/XaFIKWEz5RtUOj7/TwE3/to3UAA8OtTBzvywjuSDxScaVCjcJMsNVu46wBbaAWdILL
         fJufuHiCXrK/hAn5kXhg12O1T2qfJBLwuJtHHOY5kE3tmZ/ASWWVXlCvC7YlAj6k/L9o
         iHsg==
X-Gm-Message-State: AHQUAuadLW8bcIZ+8UefZOO8xhiJ1K0EM7/LeS0MQtkxEAhPa+/rRYL4
        V6jSe3nGYqPt7OuQhj5Os/aMqdK7Piu1piSr4p1pyh5PQzY=
X-Google-Smtp-Source: AHgI3IZlNmHzJpQoJnKDnS9UHSr+QaSEOL8yql4Jd6LzYPAhG5x884HmXJu+qKVnx2KQ4kiqPyhX4RRrqAq26GJZIVY=
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr20416182ejz.7.1550585945242;
 Tue, 19 Feb 2019 06:19:05 -0800 (PST)
MIME-Version: 1.0
References: <CAJPSwc1GuifK9BdssWQsf+oVY0Aw+PLM1pgAiis7UdV1tZrpew@mail.gmail.com>
 <CAP8UFD22QMJyiJmQO1YVFmBkZuzex58+QBbTbdCCVHa8OGCQJA@mail.gmail.com>
 <CAPig+cQHx_BuxwZS7+juBdgKyAWhStU=9kFhs2hf=wjOMGAd7Q@mail.gmail.com>
 <317468c6-40cc-9f26-8ee3-3392c3908efb@talktalk.net> <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
In-Reply-To: <CAJPSwc0Xu=HoF5XrqnFj_1ZrshM3HFb78tJkXOTWZ=HJX8Akgg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 19 Feb 2019 15:18:53 +0100
Message-ID: <CAP8UFD2a6D1W_X0T3O8FTinBwVC1qoBk+jx84B-dQzRrieu_Xw@mail.gmail.com>
Subject: Re: git rebase --continue after solving conflicts doesn't work anymore
To:     =?UTF-8?Q?Sebasti=C3=A1n_Mancilla?= <smancill.m@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 19, 2019 at 3:03 PM Sebasti=C3=A1n Mancilla <smancill.m@gmail.c=
om> wrote:
>
> My system is macOS Mojave 10.14.2. I normally use Git from Homebrew (curr=
ently
> Git 2.20.1).
>
> I investigated this further, and I think I found the problem on my end.

[...]

> I also did bisect Git (I never though I would be bisecting Git itself).
> It landed in this commit: 4d010a757c (sequencer: use read_author_script()=
,
> 2018-10-31).

Thanks for investigating this.

> And the content of .git/rebase-merge/author-script is always the same:
>
>         GIT_AUTHOR_NAME=3D'Sebasti=C3=A1n Mancilla'
>         GIT_AUTHOR_EMAIL=3D'smancill@jlab.org'
>         GIT_AUTHOR_DATE=3D'@1550530007 -0300

When I look at such a file I get the following:

GIT_AUTHOR_DATE=3D'@1549569954 -0800'

so it seems to me that a single quote is missing at the end of the
line in your file, which might explain the error.

Not sure which software is writing this file, but from what you
described it might be the tig you had previously installed.
