Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8AE5211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 15:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbeLAC7r (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 21:59:47 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45247 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbeLAC7r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 21:59:47 -0500
Received: by mail-vs1-f65.google.com with SMTP id v10so3581349vsv.12
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 07:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JrSdbPhvbfFShBQfXYgPopczX2P6InRsKTNcKcMmkc=;
        b=tBAyjeNrQjvDM3/Yg1wzGqo+tmS2OvqV3iEw/Qx1JaqC57LGIzCEwvwkXZafWEfXxB
         TFG3AKlq9nLdz0OcJ4OwM6ZnwgLoaU0ePvR8EQM76P+ONxCWig3kaEmwSwY9xfe2Rgwv
         fEp//ezDJ7Y+VSKlwWDD/bi+I00mvtEmB3ygbDWVbkytwlVEFBEWsop+d+OlMhN8LZHT
         mkdE079JUn8scEXNo8oVb72V+5xPfW5viRTtFapF8Bj61+coby0mKY7VKcJ8v9bTimbo
         r11WaWbc8SKNJXxuCN86UUemwLlLkG21kNJeNkTpeODvdIasMoDfVxUrwnNAEETSIi0H
         SWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JrSdbPhvbfFShBQfXYgPopczX2P6InRsKTNcKcMmkc=;
        b=bgs0y/rkHjlpbgwYubA6BwmV1hQSf4pvNCvZN9cBH3fmtae/pAhSoNreItWW1R4lRm
         ulUuUCqa7r0Ly5L7ehVhSGxDzXv43Be1c1gMOJ8EOY+cU2gBxlQ4Lj1b57GlEnZ/ZU1b
         y5HhAAer794E3Ca/eaMalYaqO/Dc8+vIWJKvm7VUzrC4rETKjHS+RQPquAZm49Zu4K6Z
         ukyD7uW4p7m0mRykbmc0x1NxPjGTw27Vw5yhpofrwicaGRZ0pdOkvcHae8XcUtgWACc3
         XjsRSV3Ax5qV71jEvxbpyz7LTzsPpZU9lsjKqCf+Ob7aC1EUP0LsoU3MDQ+hmmq0PNwL
         ZO3Q==
X-Gm-Message-State: AA+aEWYatqhTPYnPODBY9Wgm8b/UhkhetRFA+zpvXaQyBcjwsn6wj8Uf
        TcgYnbb3AyTn21rX8rLgXGxVQbZciSJs54bKv9c=
X-Google-Smtp-Source: AFSGD/WT8O0xwfP12A0MFzNedHpzjozhuhJFNY+I2rpZMN0kVesve/41R0CYcDpLaLlDGsRQ4hJ4bNNMTaTmxmIMF7E=
X-Received: by 2002:a67:3edc:: with SMTP id a89mr2757725vsi.136.1543593000654;
 Fri, 30 Nov 2018 07:50:00 -0800 (PST)
MIME-Version: 1.0
References: <xmqqva4fj62k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1811301429220.41@tvgsbejvaqbjf.bet>
 <xmqqpnumk604.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnumk604.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Nov 2018 07:49:48 -0800
Message-ID: <CABPp-BF8RupyfP69iqAVTXxEhBGyzVd-wUgp3y0pf+CbBFAQeg@mail.gmail.com>
Subject: Re: en/rebase-merge-on-sequencer, was Re: What's cooking in git.git
 (Nov 2018, #07; Fri, 30)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 30, 2018 at 6:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Junio,
> >
> > On Fri, 30 Nov 2018, Junio C Hamano wrote:
> >
> >> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
> >>  - rebase: implement --merge via git-rebase--interactive
> >>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
> >>
> >>  "git rebase --merge" as been reimplemented by reusing the internal
> >>  machinery used for "git rebase -i".
> >
> > I *think* a new iteration has landed (which has 7 instead of 2 commits):
> > https://public-inbox.org/git/20181122044841.20993-1-newren@gmail.com/
>
> "Landed" as opposed to "be in-flight"?
>
> You got me worried by implying that I merged them to either 'master'
> or 'next' where it is harder to back out ;-).
>
> During the freeze, especially after -rc1, I stop paying attention to
> anything other than regression fixes and fixes to the addition since
> the previous releases, unless I have too much time and get bored and
> the new topic is trivial (which often means a single patch).
>
> I'll mark the topic with the following, and continue ignoring it (or
> any other topics) for now.  Thanks.
>
> * en/rebase-merge-on-sequencer (2018-11-08) 2 commits
>  - rebase: implement --merge via git-rebase--interactive
>  - git-rebase, sequencer: extend --quiet option for the interactive machinery
>
>  "git rebase --merge" as been reimplemented by reusing the internal
>  machinery used for "git rebase -i".
>
>  Reroll exists.
>  cf. <20181122044841.20993-1-newren@gmail.com>

I've also got a reroll with an extra patch to address Duy's feedback,
an extra patch to make a small documentation clarification/correction,
and a fix to a typo in a commit message from the last roll.  But I'm
waiting for 2.20.0 to be released before sending it.
