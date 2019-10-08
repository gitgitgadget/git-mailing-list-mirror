Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430C81F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 19:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbfJHTq7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 15:46:59 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33156 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbfJHTq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 15:46:59 -0400
Received: by mail-lj1-f196.google.com with SMTP id a22so90993ljd.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 12:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7iHAbGLBtFz0l9hz4EZHk/iEX2EuCtviNqNzqgWnBk=;
        b=ncKN5VChwVdbhvN2bF7Bu6obbfLY67rd79HsjyKLPJSa+BpegwVSfAI33yXSyL67Gr
         YdwDw8IlBMj6O2NSQ/ugIZ3eRtG4wtNjlLGMeGqBNNb5snur7X5yEVPUPVWiTfSHLKWX
         gtdFof6zP2/2QiNrLy2ZUIiBAmOOsNXMEiqMMjErzFuJKPLpMlaq/OMGNMxLdyCg7b99
         +eydKoybz48xTHeWSgY02JXXdmzk3DP0w4rHW7JYOYbVE6L528noMNcpiLznf0y2kgp5
         8Hi0RUHvnhU8AMo6JKR04jnaTak9JW5ejGHtVUBCWEjmbBnLOL7RJr4jKhYmJZOBljKS
         TxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7iHAbGLBtFz0l9hz4EZHk/iEX2EuCtviNqNzqgWnBk=;
        b=Y87TetBA0beqDDX5p1lGqOpO2Bolrf1UA8Cmop1H1Gn1WyOduTsDEUQvYrGd8GK86t
         INpV+KWR8aDWZAMojneEg/kJex7GSAC9CHUaIFf3Wp9qH4IjMM8jsyHbfctQe30e8Ksr
         gTs7A5fyfhe1czthL3fhrvVUsfh/8tZFwhdL/yjqWeqY7JYCnPgyMc8VLum0P+/8uWvU
         Gz0cl9GudEJ+g8HXJQetZ44mXgga6HqNBqN/4/pQFqXo/YBq/q4ovLffPo6r4YDqSm/q
         cYMWLFLxKKukf/jiuS2Abb6ouW1GQAIp/Cp/8kJ5civfvDIwm7nYGhjc+eknQbFw/4LH
         dTsA==
X-Gm-Message-State: APjAAAURvsbJ5xlCK62T7VgWjAlWRjs87rrgFYwH2UMC5dnULQiazQo0
        x+oVMecxiEIdkdu1sBkrS0LeuGwWsctwiHb95KQ8Ilfv
X-Google-Smtp-Source: APXvYqxlTuWkV9klNl3xmgRzvQmase5IPzNL4KZxOOPnywfs6WS741PMuoWjFIQ/5XGsnWQfSzYjY9ItK+4y1+gB328=
X-Received: by 2002:a2e:1648:: with SMTP id 8mr21008668ljw.194.1570564016773;
 Tue, 08 Oct 2019 12:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com> <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
 <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com> <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
 <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com> <CAGr--=Jiu-haHMX2fc8AB1uGWT1OMw5=M3_CuGWVzrYmO0uq3A@mail.gmail.com>
 <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com> <20191008175938.iqibournnxam4r6d@yadavpratyush.com>
In-Reply-To: <20191008175938.iqibournnxam4r6d@yadavpratyush.com>
From:   Birger Skogeng Pedersen <birger.sp@gmail.com>
Date:   Tue, 8 Oct 2019 21:46:44 +0200
Message-ID: <CAGr--=JM2uTyyymUxHw6vhE9H=bzAO_E_yzrmuOhuuk-td02CA@mail.gmail.com>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

On Tue, Oct 8, 2019 at 7:59 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> On 07/10/19 06:52PM, Birger Skogeng Pedersen wrote:
> > So I kinda got this working, but only when focusing the commit message widget.
>
> Isn't this the point of your feature? You change the view when focusing
> the commit message widget. I remember you were explicitly against doing
> it as soon as all unstaged files were staged. Did you change your point
> of view on that?

Yes, kindof. Sorry for not being more clear about the intent.
I would prefer that the automatic selection of a staged file happens
also when adding files while the Commit Message widget is in focused.
For instance, if the user focuses the Commit Message widget and then
hits CTRL/CMD+i a staged file should be selected (if it isn't
already).

> > I did not manage to get it working when invoking "do_add_all", (e.g.
> > when pressing CTRL/CMD+i). I added this:
> >
> > bind $ui_comm <$M1B-Key-i> {do_add_all;select_staged_file;break}
> > bind $ui_comm <$M1B-Key-I> {do_add_all;select_staged_file;break}
> >
> > But it seems that the "select_staged_file" procedure is invoked
> > _before_ "do_add_all" finishes. So that's not working. All changes
> > gets staged, but no staged change is selected.
>
> Hmm, that shouldn't happen. select_staged_file should be executed
> _after_ do_add_all, not before. I haven't looked into your patches yet
> though.

I don't understand why it doesn't work. I'll play around some more with it.

> > And I'm quite stuck. Do I send the unfinished patch, so maybe I can
> > get some advice? Or is it better to just wait until I have the perfect
> > patch ready?
>
> If you are stuck on something, and want to share the WIP feature to get
> help/comments, you should mark your patches as "RFC" (Request For
> Comments). This can be done by passing the option '-rfc' to
> `git-format-patch`. This will make your subject prefix to "RFC PATCH"
> instead of just "PATCH".

Sorry for not doing that, I'll take not and do that next time.

Thanks!
Birger
