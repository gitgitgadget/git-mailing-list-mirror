Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 562481F97E
	for <e@80x24.org>; Wed, 28 Nov 2018 15:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeK2DAk (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Nov 2018 22:00:40 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41934 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DAk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Nov 2018 22:00:40 -0500
Received: by mail-vk1-f193.google.com with SMTP id t127so6024677vke.8
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hj61KvzzL42XK+whkzqGU0irxMw4iEAYFR5YOkpUdqo=;
        b=m/vo1fLiGJrG7rDoYXQcrqo2ilHtkWdlKoZC+t4nl7NwSd3G97TFzL3t5I3gPFUJGi
         14j8vV7puwZ7aUGgvwjkPR9Cwux7iB1Yv6pfdoIdKqmDylU6/3Y/5k2BLpWp930FaL+G
         lmkaBuziEdb1DtZi/Ecume4CEyce45Otq9oC3K11DCT8mrfX/f83qAB6IleJggFAeFIm
         6SXjzSUiKju5ucX6TWSrsmlpsEPRzNWRDqBQr7Cd0uStxGyX6xO+UDtNhr3B92gTHfOI
         ZfOnZAuu922pQJIlCNleUGA/5gPa7VeopcqCDJLMiVH1Eue5tqbhcYO5orV+9r02Gm4d
         p8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hj61KvzzL42XK+whkzqGU0irxMw4iEAYFR5YOkpUdqo=;
        b=YY0tjv/zHiOadXXXfXG1ppycwvuugSwlameM/GT+iDlDBFSmLaWp8YbTr9USuVtBee
         dOtHx67LIVSgKIKi0ZEXiFx1DR718AH3a757O5aq20AzpKMNAPVnOB/pdzTn83YtCYLt
         C1FYzx41ACsIDKn0kFQxvj2Bm6kXCykOP6gPsQbd2/3KPfy8AiTLNxiAiQe1jtdLhh/r
         9E8xKFc5li247WAnjD94e7YqYiyHbvLe+w/OBVLoVpxC4Tz5biNPkF0S5Hhn1fofmkq+
         vJcH8bDlVIULf+XeyKo1385sc2zBYTLcKcDOBWddaRhmOzUX0IgZUaRNASJfazcvZWgA
         qq1g==
X-Gm-Message-State: AA+aEWaYzDEpjv1bgmE1AJbCPyYS+0mAmbYxAaKgFXEhrSNWlaLZHIJi
        oKkY7+4U+sOtcI0QNx0IMTdqNP+RSQc3Imsn/yE=
X-Google-Smtp-Source: AFSGD/U7XCIzyvooxlTUSHBg/Ub8q4aIhswPlLpy3h14gWvQ/o0e1+nIlwE+d6xN2yZsuiRatYR43I9GkbaX8zT8HiI=
X-Received: by 2002:a1f:ed1:: with SMTP id 200mr14012024vko.92.1543420711375;
 Wed, 28 Nov 2018 07:58:31 -0800 (PST)
MIME-Version: 1.0
References: <20181108060158.27145-1-newren@gmail.com> <20181122044841.20993-1-newren@gmail.com>
 <20181122044841.20993-2-newren@gmail.com> <nycvar.QRO.7.76.6.1811280000020.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1811280000020.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 28 Nov 2018 07:58:19 -0800
Message-ID: <CABPp-BFRrLUJDkyOz=UitGr0eKDxbVq1s19LpoOrY1FJKHsOUQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] rebase: fix incompatible options error message
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 28, 2018 at 12:28 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 21 Nov 2018, Elijah Newren wrote:
>
> > In commit f57696802c30 ("rebase: really just passthru the `git am`
> > options", 2018-11-14), the handling of `git am` options was simplified
> > dramatically (and an option parsing bug was fixed), but it introduced
> > a small regression in the error message shown when options only
> > understood by separate backends were used:
> >
> > $ git rebase --keep --ignore-whitespace
> > fatal: error: cannot combine interactive options (--interactive, --exec,
> > --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with
> > am options (.git/rebase-apply/applying)
> >
> > $ git rebase --merge --ignore-whitespace
> > fatal: error: cannot combine merge options (--merge, --strategy,
> > --strategy-option) with am options (.git/rebase-apply/applying)
> >
> > Note that in both cases, the list of "am options" is
> > ".git/rebase-apply/applying", which makes no sense.  Since the lists of
> > backend-specific options is documented pretty thoroughly in the rebase
> > man page (in the "Incompatible Options" section, with multiple links
> > throughout the document), and since I expect this list to change over
> > time, just simplify the error message.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
>
> This patch is obviously good.
>
> Given that you embedded it in the patch series that makes the sequencer
> the work horse also for the `merge` backend of `git rebase` in addition to
> the `interactive` one, may I assume that you intend this patch for post
> v2.20.0?
>
> Ciao,
> Dscho

I think post v2.20.0 probably makes the most sense.  I was unsure what
the policy was around changing strings late in the cycle, but figured
that the worst case with this regression is someone basically
understands what the message is trying to say but thinks it might be
saying more than they understand and reach out with questions.  In
contrast, if we decide to change the string and some translators don't
have enough time to translate it before 2.20.0 goes out, then someone
who doesn't understand English gets an English error message, which
seems a little worse.

I at least wanted it to be discussed, though, which is why I
highlighted it in the cover letter.
