Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF2320286
	for <e@80x24.org>; Sat, 16 Sep 2017 13:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751249AbdIPNpF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 09:45:05 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:49159 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdIPNpE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 09:45:04 -0400
Received: by mail-wr0-f181.google.com with SMTP id u96so3464534wrb.6
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FPcC9ru4bSs/qkMgpaqZQmnGcGa1xQm9gbuE+BaP7vQ=;
        b=fKLxYqEedgNEj4YsMiSNTE0ThuaClTsnV9/dfNjFAsuy7jtsHQtSfAdLstm0wPupO/
         599HgMaYR+vBjWJRFVO298ozwZe3zP7tthGAL+cDT3s0zdUiTZLcqc8hupRod7esa4n+
         SfMzBiCxZLTEUlPh6bexXALBXjmYr9tkcFyEapYX6JfuWm7yPyQAVyyPT2D5R8zswnwf
         j8X/SUmw90DQWV/YOCTC9joKueL4EclmyAUxpGhulB2X0gKRg/wI3cfvpthdjUajBWt7
         I53s3uCUst5xtvH2UOS/mJQHN8qIiPjHM4LvtLvMn4ACw50nZTvpFSoGNvcET2QSUXJg
         kmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FPcC9ru4bSs/qkMgpaqZQmnGcGa1xQm9gbuE+BaP7vQ=;
        b=WkeRNr2J6I/jSXEfi10ZHK9l9T+Zs7QXFAhkZt/EVHjtRp09yLSG98ddftBHW/3ybD
         /s1r/aUwnumu2sHs7awJRVq//qbS8QQjNgzK76urRxTam3Y0YgSpZTM9yV5F+b2o3L+I
         1/QkLormizjU7f3I5D94VJyN9LEfLOFXcu+IS70RpdKxHJz/ahDUgC/FiUL8MDhdwj+f
         w7n484ToLsyQGshqkofuLwstK0G5S1xSh/fPnypm3Mepc59LUYdtNneYSgA99ja5AfRn
         69Qwv09D9R4PoMb8AVXoQgXSz1x34zqsQKznl6yV7KXUzozfBJ/L6yylfY72iXuo8PGU
         31rw==
X-Gm-Message-State: AHPjjUhSqWhGtnbkfIVDMC6/ADxrZBvA313uhdwlVdjyl7KBD0POc8jP
        Wd2KA5CJCQP2PJdGlo7zjq33uIF6y+NHmlaUpdc=
X-Google-Smtp-Source: ADKCNb47nQPP9VKHMI+lM0v1Zdvdi5Oy5vaOnxThwjW9sANCWFmrVpphri99fBPc6fbntYiooaSjTf3rzGiDyYe798k=
X-Received: by 10.223.196.228 with SMTP id o33mr24207203wrf.253.1505569503558;
 Sat, 16 Sep 2017 06:45:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.207.196 with HTTP; Sat, 16 Sep 2017 06:45:02 -0700 (PDT)
In-Reply-To: <9e004c75-bc35-06ae-8479-9440059c4d0f@gmail.com>
References: <oo62vr$pvq$1@blaine.gmane.org> <CAN0heSqGfxrFTwuaxgppZTx+3U=g_Qs4PyaCBF6ddV_PbvdpTQ@mail.gmail.com>
 <CAHGBnuMC_10krsdZe2KiQ4jjiL43kogn--dWjPgca_p2xgmQMA@mail.gmail.com>
 <20170902000417.GE143138@aiede.mtv.corp.google.com> <a47058cc-8ffc-4484-c247-3c8d4f827c07@gmail.com>
 <xmqqbmmbwuq0.fsf@gitster.mtv.corp.google.com> <9e004c75-bc35-06ae-8479-9440059c4d0f@gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Sat, 16 Sep 2017 15:45:02 +0200
Message-ID: <CAHGBnuMBD1kVJoFLB-apUKbKJipOW3XTGqO+5W8jesY100ZFcg@mail.gmail.com>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 16, 2017 at 12:41 PM, Andreas Heiduk <asheiduk@gmail.com> wrote:

> Therefore I would avoid "definitive wording" like "will drop" and use
> vague wording along "there are various dragons out there" like this:
>
>     The todo list presented by `--preserve-merges --interactive` does
>     not represent the topology of the revision graph.  Editing

I tried to avoid this introducing sentence from the original wording
as it reads like from a scientific research paper instead of from a
user's manual.

>     commits and rewording their commit messages should work fine.
>     But reordering, combining or dropping commits of a complex topology

There is no need for complex topology. If you reorder the two most
recent commits in a linear history, one gets dropped.

>     can produce unexpected and useless results like missing commits,
>     wrong merges, merges combining two unrelated histories and
>     similar things.

"can produce" is much too soft, IMO. Reordering commits goes wrong,
period. Like wise "unexpected and useless results" is inappropriate.
The results are wrong in case of reordering, and wrong results are of
course unexpected and useless.

-- 
Sebastian Schuberth
