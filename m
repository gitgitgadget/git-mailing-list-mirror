Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628B91F404
	for <e@80x24.org>; Wed, 10 Jan 2018 19:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753812AbeAJT0E (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:26:04 -0500
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33419 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753802AbeAJT0C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:26:02 -0500
Received: by mail-ua0-f182.google.com with SMTP id z47so74029uac.0
        for <git@vger.kernel.org>; Wed, 10 Jan 2018 11:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nTAMcOMaTOXyVzpAVJnM2T+J4pwP+GLsLSIG6AsHfbQ=;
        b=n8x2bDufDJW7wBsXrKig7VpBcwBc0POmBOck/xqOrQGcq9tMVaYGP2WXAVpiCZ3ilT
         3el7+MS8o5xfVejgfwjtiscyAM0sjogzonyrzGdoxdUCJNXquy/1Pqi0Sk3qhtcTCnTM
         FiukANiSv4Wns0fRMGcvUtcXigSLeRtCT1WcZgHU59VPBs97Y8PdbMvBD/2pgs2ooFEY
         PEfrOrx1L+VpPyv/xEIFauMTR0xbeYWFH2ynPOFw2a8XvZUb2U9RDlB0kUM8PnqDwJTj
         xq42pD131/TWN5f3/kCjNb9n0B2r71VSWt8nPME8h1TZbxxeMdqQqBd9iLxwJsjNgTd1
         yPXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nTAMcOMaTOXyVzpAVJnM2T+J4pwP+GLsLSIG6AsHfbQ=;
        b=ErvQb0pxBYYZfvpsLzY9RnQdw8niQFgQhtJ1cVCj3F1C6k1Tsq0LhiFth9ZdM1bIlC
         11cVVjUJzhlNLUFCycN7PncZRuO5Ut+x3drcKLbNZ2trsPowytHsa8zTCyHOtpU1y72A
         vEkhrHzjB52bL1jhFN44QOM4gt7WJX08W/n40FSogf+ffkAz0GGz1kuZ1UxLHY3elO5p
         6gEV9slvUfY/90E6ynmkue4t/LGI7mteKTx/g5evf1AFvszuwLTZQmGeDthmCW3o5c4M
         hiJkZZN5H/1ib7c/W2A1dSN1BTRtZHExHm+xloH5tXiZIhkRAp/GVsuUAe/+m5c63EnV
         K8xQ==
X-Gm-Message-State: AKwxytdGfHVIb8bgpnsFIDGcWV4LOPxrcTYbqhvCT2j9mY8jJY1Bbe9Q
        N4IwK4DQTiCRCCsOpO68mJt+auXErsD43uAHyCo=
X-Google-Smtp-Source: ACJfBotC99BreP/LQs5hWC6p9TM4vDU7bIdYJoDd/qlfzRzFZYse0UtB9Ucl2h/G71HwurxdHmz9uDmlVroimybeLus=
X-Received: by 10.176.49.222 with SMTP id e30mr20061420uan.170.1515612360556;
 Wed, 10 Jan 2018 11:26:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.11.153 with HTTP; Wed, 10 Jan 2018 11:25:59 -0800 (PST)
In-Reply-To: <xmqq1siy30zd.fsf@gitster.mtv.corp.google.com>
References: <CAKdAkRQuj1hfKeckjuR2oP+8C1i+ZR36O-+aRYif4ufaS_zs+w@mail.gmail.com>
 <CAKdAkRTK=0Kafc-nhvJTu+9m-pp=BV3Oc-gu6ssjZZQm95pC_Q@mail.gmail.com> <xmqq1siy30zd.fsf@gitster.mtv.corp.google.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Wed, 10 Jan 2018 11:25:59 -0800
Message-ID: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
Subject: Re: prepare-commit-msg hook no longer run for cherry-pick?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 9, 2018 at 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Dmitry Torokhov <dmitry.torokhov@gmail.com> writes:
>
> >> I had prepare-commit-msg hook that would scrub "Patchwork-ID: NNNN" tags
> >> form commit messages and would update input mailing list patchwork to
> >> mark corresponding patches as "accepted" when I cherry pick form
> >> WIP/review queue into branches that I publish, but that recently stopped
> >> working if I do a simple cherry-pick.
> >
> > This seems like a regression, at least for my use case. Unfortunately
> > my mail seems to get lost in the mailing list noise...
>
> Possibly.  Can you bisect to see which commit broke things for you?
> That would allow people who know what they themselves broke better
> than I do to take a look ;-)

Right, so it looks like the master works well, it is next(?) branch
that is troublesome (apparently we pack experimental internally?).

I bisected it down to:

commit 356ee4659bb551cd9464b317d691827276752c2d (refs/bisect/bad)
Author: Phillip Wood <phillip.wood@dunelm.org.uk>
Date:   Fri Nov 24 11:07:57 2017 +0000

   sequencer: try to commit without forking 'git commit'

   If the commit message does not need to be edited then create the
   commit without forking 'git commit'. Taking the best time of ten runs
   with a warm cache this reduces the time taken to cherry-pick 10
   commits by 27% (from 282ms to 204ms), and the time taken by 'git
   rebase --continue' to pick 10 commits by 45% (from 386ms to 212ms) on
   my computer running linux. Some of greater saving for rebase is
   because it no longer wastes time creating the commit summary just to
   throw it away.

   The code to create the commit is based on builtin/commit.c. It is
   simplified as it doesn't have to deal with merges and modified so that
   it does not die but returns an error to make sure the sequencer exits
   cleanly, as it would when forking 'git commit'

   Even when not forking 'git commit' the commit message is written to a
   file and CHERRY_PICK_HEAD is created unnecessarily. This could be
   eliminated in future. I hacked up a version that does not write these
   files and just passed an strbuf (with the wrong message for fixup and
   squash commands) to do_commit() but I couldn't measure any significant
   time difference when running cherry-pick or rebase. I think
   eliminating the writes properly for rebase would require a bit of
   effort as the code would need to be restructured.

   Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
   Signed-off-by: Junio C Hamano <gitster@pobox.com>

With this commit the hook is not being run unless I specify '-e' flag
to cherry-pick.

Thanks.

-- 
Dmitry
