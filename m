Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963791F404
	for <e@80x24.org>; Mon, 10 Sep 2018 10:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeIJPUr (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 11:20:47 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40774 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbeIJPUr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 11:20:47 -0400
Received: by mail-pl1-f177.google.com with SMTP id s17-v6so9530233plp.7
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 03:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silentorbit.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=00OxMfai2TPh/9am8m3moGtB4Dymc1SZskQl16yLXsI=;
        b=MB+xCZomlk9wVbzrjOGvhLngam+HSWL9rJOsSiI5nHa+WlS2nGD7/xtxV4zUQ/SCtw
         rV8ckhGcv8G2BoYrLAeUx3mpSJpXwIF1cZc2+Qpy8B8r2L/5w6NszH4kfj58/gnmndv+
         831rIeDxn3wptk4LFhVIIb27NfNvwb95Aw7gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=00OxMfai2TPh/9am8m3moGtB4Dymc1SZskQl16yLXsI=;
        b=ds2btXkeRzYdElb4kVvZiLElTznZeK9Nnp8yKbsBKE2ml8BWdIAmU9j3Dv+3j098qP
         fpJ4LWdgj61Jtd1/jEDDa/lEcyMsLj9xAPO6yqrHucN1PtHPlB1L8UGjyoVsZktDg3yQ
         KO5CnIyChhpr/9Qza3xbR1nkmc0492gA+/rPwJodgbaDxsWWI1tDn4zkD8o0mrFnRQtN
         Ii2BnC10tfcTGuoyVUSF/u2PvoTlUyRA4OC8h+Q3r2HUl1hH7CgPhrw7FuwBEZDu2x3G
         HiCGSJ5Bu+oev3N2mVGLoVlojT25KcR4KZVa5x09TD8ZyE8YLzCmgiq8cy0Ywe31Diwg
         8Qdg==
X-Gm-Message-State: APzg51Cpx0QQxDp325zCuXiC3U1fjPzEGhNnv3TIOuG+FPuEN2rNIrLP
        NfKDaVjN6e/A1NabEmewRMAmWDn8CdDAi4tt3h5E8A==
X-Google-Smtp-Source: ANB0VdbhY3vTSUix3vKq/l4FDCX/ELBfWOUpEhBjVaY4KofuN164hIIPwAwblga3YWVoapSfzwdaTAH9/Qyq5rFMct0=
X-Received: by 2002:a17:902:8b86:: with SMTP id ay6-v6mr21361664plb.25.1536575243699;
 Mon, 10 Sep 2018 03:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
 <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com>
 <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com>
 <CACsJy8DdxmVd_jBG7Tp1e7k-BUc6R1=oWzPZ3z6xUZs2XU9rMA@mail.gmail.com>
 <CAJmnt9YxGoQO40GNQY=nTjGGaGB5X079koZ0QvCOZ4wd7ubkaA@mail.gmail.com> <CAJmnt9YgFNjzZfOW38WbyC-9AK4rtS3P6_dKN6hS1X+y932uiA@mail.gmail.com>
In-Reply-To: <CAJmnt9YgFNjzZfOW38WbyC-9AK4rtS3P6_dKN6hS1X+y932uiA@mail.gmail.com>
From:   Hultqvist <hultqvist@silentorbit.com>
Date:   Mon, 10 Sep 2018 12:29:44 +0200
Message-ID: <CAJmnt9aCfMGejO3B5ctZuCjJnE4K-dA1dwyz1uxoZwRBOJJqpg@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     Peter Hultqvist <hultqvist@silentorbit.com>
Cc:     pclouds@gmail.com, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sending again without HTML

Den m=C3=A5n 10 sep. 2018 kl 12:28 skrev Hultqvist <hultqvist@silentorbit.c=
om>:
>
> First I need to correct my previous observations.
>
> Today there appeared new set of config files in the root.
> I looked into a few of them and found that their content doesn't match th=
at of the repo at "G:/Min enhet".
> Instead separate files had content from separate git repos within the G d=
rive.
> These repos are not like the one we're discussed previously, they are com=
pletely within G: using a classical .git directory.
>
> I guess git is creating the temporary files as close as possible to the r=
oot, since "G:\" can't be written to, only "G:\Min enhet". and then copy th=
em to the final destination which in this case is the same drive.
> If so then we can't get away from the duplicate files, the duplicates the=
mselves are the fault of Google Drive File Stream.
> If git would create the config/master/index files within the .git dir to =
start with that would hide the clutter from the root but not prevent the du=
plicates.
> Is this observation correct, that git creates temporary files closer to t=
he root than inside the .git directory or a sub directory thereof?
>
> I haven't experiences any issues working with these repos themselves.
> One risk could be that the final "index" is an older version than "index =
(45)".
> I'm certain this haven't been the case since I push every commit to a rem=
ote repo that doesn't accept changes in history.
>
> I understand that master and index needs to be updated with regular use.
> Does config need the same amount of updates?
> I've considered that file to only change when I make explicit changes, no=
t during regular use(push, commit, status).
>
> Thanks for the help looking into this for me.
>
>
> Den s=C3=B6n 9 sep. 2018 kl 17:30 skrev Hultqvist <hultqvist@silentorbit.=
com>:
>>
>> Since this thread started I haven't seen a single file mentioned being c=
reated,
>> Usually they appear during work days when there is more activity.
>> I've never seen the files created directly, only a larger amount of
>> them once in a while.
>>
>> I will run process monitor and get back once I find out more.
>> Den l=C3=B6r 8 sep. 2018 kl 15:44 skrev Duy Nguyen <pclouds@gmail.com>:
>> >
>> > On Sat, Sep 8, 2018 at 3:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
>> > >
>> > > On Sat, Sep 8, 2018 at 11:28 AM Hultqvist <hultqvist@silentorbit.com=
> wrote:
>> > > >
>> > > > The bash commands are using a git and bash bundle that was install=
ed
>> > > > in parallel with gitextensions(a gui for git)
>> > > >
>> > > > G:\Min enhet> set GIT_TRACE_SETUP=3D1
>> > > > G:\Min enhet> git st
>> > > > 10:40:28.881927 trace.c:318             setup: git_dir:
>> > > > C:/Users/hultqvist/Drive.git
>> > > > 10:40:28.881927 trace.c:319             setup: git_common_dir:
>> > > > C:/Users/hultqvist/Drive.git
>> > > > 10:40:28.881927 trace.c:320             setup: worktree: G:/Min en=
het
>> > > > 10:40:28.881927 trace.c:321             setup: cwd: G:/Min enhet
>> > > > 10:40:28.881927 trace.c:322             setup: prefix: (null)
>> > > > 10:40:28.882930 chdir-notify.c:67       setup: chdir from 'G:/Min
>> > > > enhet' to 'G:/Min enhet'
>> > >
>> > > Unfortunately this looks good. Whenever those files 'index',
>> > > 'config'... are created, they should always be created in
>> > > C:\Users\hultqvist\Drive.git, not G:\Min enhet, including their
>> > > temporary versions. I don't know if there are any more changes on th=
e
>> > > windows fork that could affect this though, I only checked git.git.
>> >
>> > BTW do you notice these files showing up after any particular command
>> > or they're always there after cloning? Perhaps some command got the
>> > ".git" directory discovery wrong and assumed $GIT_DIR=3D$GIT_WORK_TREE=
.
>> > We have a much bigger problem then.
>> > --
>> > Duy
