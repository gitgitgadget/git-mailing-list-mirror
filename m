Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1746F20259
	for <e@80x24.org>; Wed,  7 Dec 2016 14:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbcLGObf (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 09:31:35 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36735 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbcLGObe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 09:31:34 -0500
Received: by mail-wm0-f52.google.com with SMTP id g23so170755427wme.1
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 06:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WK+XmRmDd1+wpdwVC6wQMCcyURHw6Vjpp1w3cGhYqCU=;
        b=Qx1RsOIhmUhywi3EaGUgnhG6VObPS3SO4qOHDhmQEU1cB3QXmsqijHPDkawYvB5Oyr
         FH9IZS5T6164XlAxg4EgxOzK+XOLaMzEF9prSL71n8rhzvjTMSY4xFGVUNgN705TCtlf
         LGQDWy3l5HduuFA0FVCbledVgJEIUZ8rjaUHNEyqLWUa1y9Dy6MmyKwtOl4BhF9T8rQ1
         W7XHt+WxndYgeso3MOjGw1CxP7lAsCiopbh9RN6+svF8rvx/B8eGTEZjmS65cjU9WMlu
         h/vh3OQJHrnY2jG/M5LwjYF/7YD5FyL38Q/g+ZcRkh4S6+SF9HZyRgRIwgT+inGKi1Jl
         X+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WK+XmRmDd1+wpdwVC6wQMCcyURHw6Vjpp1w3cGhYqCU=;
        b=HZeVL5l4X0UDQkxT05rdbMhek2wB2KeGJx8qit6Z6vmJw9+W/+CcY38NKq63/aMO4y
         ryegDUy78H7L/ZZb6RRxevng68aLuENrNWXDDXMYsqoaHfxUUwQyJhxG1c3aX4AwDN1W
         DT/BKlnLmJNcaiI9Bj3B7aoeWcVrHPAbyT5cRDvdpCnIqjigJduokQH5XibPU5V2+yZN
         iRn76YkqqnICWIK7z886+tDCfevBiO6HqHy8KLCWMCdc21u3HE8klcFsgzlgFhE2RGTS
         JnE2AjewikIe4NaPXFX6Sux9mUazdnW8b38koyFOi2GkWi+6uRUz4ssd9Wgl1pe794v7
         ejrg==
X-Gm-Message-State: AKaTC03fVWBZuG7JTlSJaprytb2F1OApN/lPgTt9a/aVOI4J7lSSlF+T/bdmml8O8rbw0JClZT4a4d88zcJbAA==
X-Received: by 10.25.209.73 with SMTP id i70mr18116408lfg.24.1481121092895;
 Wed, 07 Dec 2016 06:31:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.221.217 with HTTP; Wed, 7 Dec 2016 06:31:32 -0800 (PST)
In-Reply-To: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
References: <xmqqlgvs28bh.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 7 Dec 2016 15:31:32 +0100
Message-ID: <CAP8UFD32PcT4XgnRFaP-St3i1D-6XG1wY6qKn3bgWPKn1Y4Qwg@mail.gmail.com>
Subject: Re: BUG: "cherry-pick A..B || git reset --hard OTHER"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 6, 2016 at 7:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I was burned a few times with this in the past few years, but it did
> not irritate me often enough that I didn't write it down.  But I
> think this is serious enough that deserves attention from those who
> were involved.

Yeah, I agree that we should do something about it.

> A short reproduction recipe, using objects from git.git that are
> publicly available and stable, shows how bad it is.
>
>     $ git checkout v2.9.3^0
>
>     $ git cherry-pick 0582a34f52..a94bb68397
>     ... see conflict, decide to give up backporting to
>     ... such an old fork point.
>     ... the git-prompt gives "|CHERRY-PICKING" correctly.
>
>     $ git reset --hard v2.10.2^0
>     ... the git-prompt no longer says "|CHERRY-PICKING"
>
>     $ edit && git commit -m "prelim work for backporting"
>     [detached HEAD cc5a6a9219] prelim work for backporting
>
>     $ git cherry-pick 0582a34f52..a94bb68397
>     error: a cherry-pick or revert is already in progress
>     hint: try "git cherry-pick (--continue | --quit | --abort)"
>     fatal: cherry-pick failed
>
>     $ git cherry-pick --abort
>     ... we come back to v2.9.3^0, losing the new commit!
>
> The above shows two bugs.
>
>  (1) The third invocation of "cherry-pick" with "--abort" to get rid
>      of the state from the unfinished cherry-pick we did previously
>      is necessary, but the command does not notice that we resetted
>      to a new branch AND we even did some other work there.  This
>      loses end-user's work.
>
>      "git cherry-pick --abort" should learn from "git am --abort"
>      that has an extra safety to deal with the above workflow.  The
>      state from the unfinished "am" is removed, but the head is not
>      rewound to avoid losing end-user's work.
>
>      You can try by replacing two instances of
>
>         $ git cherry-pick 0582a34f52..a94bb68397
>
>      with
>
>         $ git format-patch --stdout 0582a34f52..a94bb68397 | git am
>
>      in the above sequence, and conclude with "git am--abort" to see
>      how much more pleasant and safe "git am --abort" is.

Ok I will try to take a look at that next week.

>  (2) The bug in "cherry-pick --abort" is made worse because the
>      git-completion script seems to be unaware of $GIT_DIR/sequencer
>      and stops saying "|CHERRY-PICKING" after the step to switch to
>      a different state with "git reset --hard v2.10.2^0".  If the
>      prompt showed it after "git reset", the end user would have
>      thought twice before starting the "prelim work".

I am not used to hacking the prompt or completion scripts, so I would
appreciate if someone else could do it.

Thanks,
Christian.
