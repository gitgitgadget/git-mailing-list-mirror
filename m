Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87BAE1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 13:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeIHSaD (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 14:30:03 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:50361 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHSaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 14:30:02 -0400
Received: by mail-it0-f66.google.com with SMTP id j81-v6so24152441ite.0
        for <git@vger.kernel.org>; Sat, 08 Sep 2018 06:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zdrd/BoRKb/TAiyuYuu7q+IumDyjHPqKIZ+tcV0Kz18=;
        b=pBLDZWuQM34CuZOR5Io/U/3+GdF3kkiZQRm/DyqQsmTIUTQ8gYZ4kP2XYu62nPDgvM
         8VHzVFncZ5odNlqC42fiaQgaoqGkcZWoLft9biTKHSIw6pKkntJW1NNuzM//o5ILYN1f
         VWB66CbYez1yFKQztSpjPee3oeDmQ2s7HR5s08goBwyddbyZa5H27OFn90q92dW0cleh
         O1lt3Xz1dgUN2XbAPUcOxEIYcc8QxfwZ4sRIF+QFQAbHfDpkClmxQRplTKOfIzlhw2hy
         8l7Rl5141vEl0s4SDiHRv0ov0FE9TFAtJcCPKkJXzVsv734iknMSIcC1Q3OIgdqr8U+E
         cQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zdrd/BoRKb/TAiyuYuu7q+IumDyjHPqKIZ+tcV0Kz18=;
        b=aSeA3+zxsiI6J/nWYXpakCQj9jZ4cK1CGKBnHkMv7UPRBV7E/Hyyz8yhwvVhiT+ehB
         Dv/lLiSk+r9evaiHulDhVV7Tj5xm5xv9KkIpcpo9PkWq+3fx63ERsxFbhQabYhbeyIMW
         f3RdM34szePO16zWvbMbV2GI6TmlwN9JOLn/JnZm40YcWtQ09Joq5cWJ/kcRrYOR16sm
         M1yavamgY5uyEhiqyDW+lJng4ysHxwZBUakWEmsLFf+e/muFKJrOz6WTjIUcOB44SJtd
         Liza7KQiuWfFvBM9t6VxcY/uxzMx/COSeQglpnwMGfzHjy0EAwU+i40iVM7ztNrBOweX
         jYPw==
X-Gm-Message-State: APzg51Dk1G5gjRrLCmikdzcg8itM7YqHL3ydrNjsW3f6eXJXMsxAF5ig
        x2+tZDYtiNSi8B/k+Ne16V30OsbopHtpwk9tevRJXA==
X-Google-Smtp-Source: ANB0Vda7ybmqa615acIL/lfYsFgrhnOqpaEINGVvpzk30890hwE/agjeiC2HbSI8g3nji3Fmvh+Xht4rAzas0FHC/G0=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr10306240itk.62.1536414251952;
 Sat, 08 Sep 2018 06:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com> <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
 <CAJmnt9ZOCJfGFJ98xD17BYU1P=nRZ=eG16Oj5DjTMaF7H6WTvg@mail.gmail.com> <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com>
In-Reply-To: <CACsJy8AMaUmWO2zi9+Dpr9_ZHE7A0rSs63h646w4uokyKRAdUg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 15:43:45 +0200
Message-ID: <CACsJy8DdxmVd_jBG7Tp1e7k-BUc6R1=oWzPZ3z6xUZs2XU9rMA@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     hultqvist@silentorbit.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 8, 2018 at 3:09 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Sat, Sep 8, 2018 at 11:28 AM Hultqvist <hultqvist@silentorbit.com> wrote:
> >
> > The bash commands are using a git and bash bundle that was installed
> > in parallel with gitextensions(a gui for git)
> >
> > G:\Min enhet> set GIT_TRACE_SETUP=1
> > G:\Min enhet> git st
> > 10:40:28.881927 trace.c:318             setup: git_dir:
> > C:/Users/hultqvist/Drive.git
> > 10:40:28.881927 trace.c:319             setup: git_common_dir:
> > C:/Users/hultqvist/Drive.git
> > 10:40:28.881927 trace.c:320             setup: worktree: G:/Min enhet
> > 10:40:28.881927 trace.c:321             setup: cwd: G:/Min enhet
> > 10:40:28.881927 trace.c:322             setup: prefix: (null)
> > 10:40:28.882930 chdir-notify.c:67       setup: chdir from 'G:/Min
> > enhet' to 'G:/Min enhet'
>
> Unfortunately this looks good. Whenever those files 'index',
> 'config'... are created, they should always be created in
> C:\Users\hultqvist\Drive.git, not G:\Min enhet, including their
> temporary versions. I don't know if there are any more changes on the
> windows fork that could affect this though, I only checked git.git.

BTW do you notice these files showing up after any particular command
or they're always there after cloning? Perhaps some command got the
".git" directory discovery wrong and assumed $GIT_DIR=$GIT_WORK_TREE.
We have a much bigger problem then.
-- 
Duy
