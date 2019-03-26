Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF2C620248
	for <e@80x24.org>; Tue, 26 Mar 2019 12:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfCZMu7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 08:50:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:54254 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCZMu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 08:50:59 -0400
Received: by mail-it1-f193.google.com with SMTP id y204so5030324itf.3
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 05:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8KJCPdOVhmD1IYghNRWrbAoqrz3pNpBH1tfQ4Vcxhec=;
        b=ccktHXtcSS+epPRHodTaqkufzaFpdnrpgL2+Q79bC5ta7NEPdsSI2fs4Kfhy2m7lLx
         1FblOB2OVhtUl+xh10auZrsR2dEUJz4Eq++6/EfUbSP1VaXyN/vCczgIYUbl+KXuJzYK
         SqafA7wJCNiWNCQMQAcOpwiBYcjFQAYhuQ/5XBTMUg+sx4w3SDABsBN6CgSBJLQAyRpK
         UHELmMsKvdf76/w0U4kbhVEXBBDpSkNrKbo2a6+Po9w8dDoYwlpw3eh0CY5IRQKi4VLs
         ECJ04Hq2S9XfnFyzcuKOQGTpKjKz3cV2GmmDT2KccesgoEGdBCwlLgfpMl4VTVDgslX4
         Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8KJCPdOVhmD1IYghNRWrbAoqrz3pNpBH1tfQ4Vcxhec=;
        b=fN4yybjZojA4k5zFMyDIwEAawXnhkMZY5umV1yFc6CxEjB0uFgteHw64DMOCBiRMLn
         gAkOKy1z4dqqYrL1ggVJK2MRTMFeojF7kx9hBw0BUkcaL5HzDqIhumtiZN5SJFIK60M2
         lRsMG6AVEpAcv/vjTQvX+gcQXFXR1x5LqZhzPTQKCMemDlQCz/QKTTMvoIcds5Rjhy//
         5LzppAAbZvBjPDWadU9U2UMU5Eb/qYonS7e4WGWMroV68A28aRDIEq3qmsSn73hjgkzC
         hD4qNfjCSVqRViZZ9378zehcoCM/wjLz2frgE2q3veUAbSiw8i+Bb8B62Uvpmx4+I6qK
         OdZQ==
X-Gm-Message-State: APjAAAVbNEo6MIRQ2KGFv6bcDjwxsUEsCm3eXjPWzt/uOnOTsjGhhxOq
        FlQr5eao9aUYnXjF+WVNJubDW1Qol7vL1U+kCXY=
X-Google-Smtp-Source: APXvYqyE/hkw9mMdSoZDK+l1z5HhtjplzME2bFjE4vOqWJe3AeIkoQzkBgqKWtNHCKwK3G/RIB4rNZwud0yOpj1AF6M=
X-Received: by 2002:a24:5493:: with SMTP id t141mr5830561ita.10.1553604658329;
 Tue, 26 Mar 2019 05:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
In-Reply-To: <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 26 Mar 2019 19:50:31 +0700
Message-ID: <CACsJy8Axa5WsLSjiscjnxVK6jQHkfs-gH959=YtUvQkWriAk5w@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 6:16 PM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
> On 08/03/2019 09:57, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > "git checkout" doing too many things is a source of confusion for many
> > users (and it even bites old timers sometimes). To remedy that, the
> > command will be split into two new ones: switch and
> > something-to-checkout-paths.
>
> I think this is a good idea, thanks for working on it. I wonder if it
> would be a good idea to have the new command refuse to checkout a new
> branch if there is a cherry-pick/revert/merge/rebase in progress (with
> an option to override the check) as switching branches in the middle of
> one of those is likely to be confusing to users (if I do it it is
> normally because I've forgotten that I've not run 'git whatever
> --continue').

Guys, I'm sorry for bringing this up again. Apparently I'm not quite
done with 'git switch' yet (not sure if I will ever be).

There is an interesting behavior in git-checkout (and of couse
git-switch). When you do a successful switch, CHERRY_PICK_HEAD,
REVERT_HEAD, MERGE_HEAD, MERGE_RR, MERGE_MSG, MERGE_MODE and
SQUAHS_MSG, if exists, will be removed.

This basically means that if you switch away, any cherry-pick, merge
or revert in progress is destroyed (in the sense of "--quit" not
"--abort" of course). All of this, I believe, involves merge conflicts
so you can't easily switch away unless you allow to destroy unmerged
entries. So it's still quite safe.

However, it leaves me a funny feeling because some "work-in-progress"
operations are destroyed, but some others (bisect, rebase) are not.
This is git-checkout behavior and I will not change that. But do we
want the same behavior in git-switch? Or do we want
no-destroy-in-progress-whatsoever? Or
destroy-all-commands-in-progress?

It may also be a good idea to attempt to describe the behavior we want
in git-switch.txt. I think if the description gets too complicated,
we're heading a wrong way. The current behavior so far could still be
described as "work-in-progress operations related to merge conflicts
are destroyed", or something along that line. But I'm not quite
convinced it's easily understood.

PS. git-reset shares the same behavior, but it's in a different boat,
I think. Or maybe I should scrap/replace that one as well.

PPS. It may get trickier with cherry-pick which can pick a range of
commits now, not just one. But I never used that feature much to know
what I'm talking about.
--=20
Duy
