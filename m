Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2EAD211B5
	for <e@80x24.org>; Thu,  6 Dec 2018 16:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLFQcM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 11:32:12 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:44015 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLFQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 11:32:11 -0500
Received: by mail-io1-f52.google.com with SMTP id f10so817688iop.10
        for <git@vger.kernel.org>; Thu, 06 Dec 2018 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PJUarkMQK49DlVPi2UqQhsAwZAa5toleroX3tA1hsxo=;
        b=IBDBo85C/E/zhSjnGZwNGewUstmkfg0UgJ6WNPNkr5flq0Qy5EI0RfXX8YxDx9B+9F
         nu3pw/gbzv+J+oxqjAR7J0yQKM4i4GQM0v94mvM1FWD+QJ3AycSug8vNW9VPZgD0V77I
         SonC8luEfNr0fEuOEWJRuAiZOdoiAB5biq0TS0uXp2qs9Z/MlHiu5qiIU8GNoGf2E1g1
         w723enB7ulLCHN5ZnIO6Af1TLk6+O3LFF4f3GsAxFcyCiPk9/5ozkvJ7a/TfNuh4DZ3D
         55NsUIgbDnXCdm1ROdwYv4b3NF5FQXrU2ipE1TOwDxmOiFa6meHJoTdMIvwYZLwhzoDu
         7Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PJUarkMQK49DlVPi2UqQhsAwZAa5toleroX3tA1hsxo=;
        b=WI5fo9f6r3H/7HOM1ygMw7tFvFIQgUFTGMOS4PCUiufazA5TC4orpbDh8KmcAedHk3
         QgwE3EuQ3IX/VmyylrWGqO1ax5AL7hYnzyhFSIcC0OG4qlNJu9kk1V9Eb8Ji3R97yXJS
         wBqvIdy+3YT5nDxrQ8tWteW7pwJ9Q++mx4+KFk97lbz/vvL/XYH63gLNrsUdSS5kFQ5C
         IFFCqBm23F7R5MioK+vUJAt+zSEc85FWDfntrD+B4DCNTmWbBmxr3vnjrXV4/L9trZ+o
         PAAIxlbGGkR5qNHtFy5aG8XnRi5F5Mpgzso1qISxlBB/+hdePVJjbGPxUR3hOi5J8emR
         HuRQ==
X-Gm-Message-State: AA+aEWaXKQbQV+X/fUko3VceQOcoAGmwBD5PBLvV6Sz0ajAktnBSrCCO
        SllmLYcHBT4lT7dUMlilLEgky2lh5ihayUn0hBw=
X-Google-Smtp-Source: AFSGD/Xb2ix2NNOhchKPaN/og0fXmhCohNsfFfmN7kd6RA1nqwA8LUy3RZlqxoWdHTzS8teBQ5vtFBkYNWZgVwt2kmI=
X-Received: by 2002:a6b:8f8d:: with SMTP id r135mr24843076iod.5.1544113930362;
 Thu, 06 Dec 2018 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <CA+YJQx72dMybGWyzNMUcNcVZnpDTHoaONcC-AQdqt=C_8aEdXg@mail.gmail.com>
 <CAP8UFD2xv6SK+qPXKr5hQ0ZctOR5K-BNg1wdBy5=fp2DVBZMHw@mail.gmail.com>
 <f9f644daa705c78ef348a4a808d88bc01e7bdbd4.camel@gmail.com>
 <CAP8UFD3cD5KtvPJK5WkWGVUT6grbL=xL2MV1YWNJGpOjD3uRiQ@mail.gmail.com> <278123655fbdb565aed16bba804711774716c554.camel@gmail.com>
In-Reply-To: <278123655fbdb565aed16bba804711774716c554.camel@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 6 Dec 2018 17:31:57 +0100
Message-ID: <CAP8UFD3VCzEdtfRqi_d2ibPtTN0uocGW+CshY_5m16TW1_YUdw@mail.gmail.com>
Subject: Re: [BUG REPORT] Git does not correctly replay bisect log
To:     lskrejci@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Dec 6, 2018 at 3:43 PM Luk=C3=A1=C5=A1 Krej=C4=8D=C3=AD <lskrejci@g=
mail.com> wrote:
>
> Hello again,
>
> after looking into this today, I'm not sure if this can be considered a
> bug - it's just that I expected Git to check out the exact commit to
> test that was there before resetting the bisect. That made me uncertain
> whether Git restored the correct state.
>
> When I looked at what Git actually does, it became clear that the
> behavior is not incorrect but perhaps a bit surprising.

Yeah, I agree. I suspect, but I am not sure, that the difference of
behavior is because in one case we only check merge bases once at the
beginning (maybe because the BISECT_ANCESTORS_OK file always exists)
while in the other case we check them more than once during the
bisection. I haven't had time to look closely at this, but I would
like to.

> When Git replays the bisect log, it only updates refs/bisect/bad,
> refs/bisect/good-*, refs/bisect/skip-* and reconstructs the log in
> .git/BISECT_LOG. After that check_good_are_ancestors_of_bad() verifies
> that all good commits are ancestors of the bad commit, and if not, the
> message "Bisecting: a merge base must be tested" is printed and the
> branch is switched to the merge base of the bad and all the good
> commits.

I am not sure if you are talking about running `git bisect replay` or
sourcing the log in the above.

> Basically, some state is lost because Git "forgot" the first good
> commit from the log already was an ancestor of the first bad one.

The BISECT_ANCESTORS_OK file should be there to avoid forgetting that
we already checked the merge bases.

> In other words, it's as if I just started the bisect with the following
> commands and just pasted the whole bisect log to .git/BISECT_LOG:
>
> $ git bisect start
> $ git bisect good 94710cac0ef4ee177a63b5227664b38c95bbf703
> $ git bisect good 958f338e96f874a0d29442396d6adf9c1e17aa2d
> $ git bisect bad 1b0d274523df5ef1caedc834da055ff721e4d4f0
> Bisecting: a merge base must be tested
> [1e4b044d22517cae7047c99038abb444423243ca] Linux 4.18-rc4

Yeah, when we start a new bisection the BISECT_ANCESTORS_OK file
should be erased if it exists, while it shouldn't be erased when we
are already in the middle of an existing bisection.

[...]

> And indeed, marking the merge base as good switches to the correct
> commit after the bisect. Marking it as bad will fail, so at least you
> can't make a mistake after replaying the bisect log:
> $ git bisect bad
> The merge base 1e4b044d22517cae7047c99038abb444423243ca is bad.
> This means the bug has been fixed between 1e4b044d22517cae7047c99038abb44=
4423243ca and [94710cac0ef4ee177a63b5227664b38c95bbf703 958f338e96f874a0d29=
442396d6adf9c1e17aa2d].

Yeah, I think this works as expected.

> Once again, I'm sorry for the noise. I guess it wasn't clear from the
> man page that something like this could happen and that made me think
> that this was a bug.

No reason to be sorry, there might still be a bug related to the
BISECT_ANCESTORS_OK file or something. I hope I can take a look at
this more closely soon.

Thanks for your report and your work on this,
Christian.
