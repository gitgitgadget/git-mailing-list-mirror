Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C18A1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 06:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeIHKxI (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 06:53:08 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:46541 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIHKxI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 06:53:08 -0400
Received: by mail-io1-f51.google.com with SMTP id y12-v6so3175524ioj.13
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxRRDwsxa5GUKuETRQuxPSLen499TXl9Yjo3mlNYKAk=;
        b=N/zEPyBzOOQL306FyUkd5AOv+KIAdjJ2tFLBbShogTBqDIBeg4dolAUdAHWLkKz1vg
         Lb2Wq2M5XotKPbg67V/8UX49UCpq26fNjen2TxvtzEKt3yYXjSIwk70CMDDjPv3ERvb1
         UxoGckLvUeCHJZ9My+op0rkEWB9+hpfj3m08SsaR+CCLueb0NUn6ShfcZ1lySoBQVRsC
         hLq+DFhsNzn+MAsb7ehRCMdZAZ5bO8p81zXVyPAFGgMRRln2s7hrKKShfFnkfe+Q3HcV
         77P87l9KvhzKvFoUMnldAMOHXV+jK6z9eMdCt3dVnnEQHprs7clOaElM68/Bo12eTpRU
         FQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxRRDwsxa5GUKuETRQuxPSLen499TXl9Yjo3mlNYKAk=;
        b=U/ZhuZOUSm6+KouqGx7IvrxrmEvxAvLq4y2Ss+SLINgEoqyoeeNhpmKToCGqRPjbmN
         fIISk0Dhn5igwAWC+4pvjNR938x/odMDhBoWqfibHulxxzA0h7TOGOpT477i0VgkCE6l
         xtnRj42Ik3RJ7n+YTfBdWEJII9ZpeTVlSGEgMlTUc5rWh4456E5J/YiCVu9pTVDx9LUs
         a9qhFtPrO4BSas7HbQRg4xZiJmxjEzXG7AJmr3tUhF3Kb1rVmivDLMqsRtx1uuXfNTgu
         srDLoRkzOEvCCJKCH1nU19BDJzZDPimN0b+s1MdFkiL3vWJYbkw00dC6D4sdPGauqa4h
         2nNQ==
X-Gm-Message-State: APzg51DZnPB8tag5HxntjSjN1QeAncTcQCSLzRLx5myIA6KqpL5Xjwt4
        23rQTDYu8/GsDjkJqpGz4nKabv18QGaNdCOrVGA=
X-Google-Smtp-Source: ANB0VdYw7j8e7hloDQ1M7EInRzAumIGprbYaPyFTNndyepOdQwyntRcKTBfQM1J9NjwJlmd2VFMpt0VGa5bfK8QM+7o=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr8343792ioe.282.1536386915376;
 Fri, 07 Sep 2018 23:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJmnt9Yfed1W7F=C+dzac3AEe7nRq2cNP335MepTczboKJNoEg@mail.gmail.com>
 <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqbm99xngs.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 8 Sep 2018 08:08:09 +0200
Message-ID: <CACsJy8DymnKk+Xo6UPQyAsToNpkSX4Ae+jzc04+0qXrZ6bmb3w@mail.gmail.com>
Subject: Re: Temporary git files for the gitdir created on a separate drive in workdir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     hultqvist@silentorbit.com, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 7, 2018 at 6:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Hultqvist <hultqvist@silentorbit.com> writes:
>
> > Considering that the gitdir could be located on a different drive than
> > the workdir wouldn't it make more sense to create the temporary files
> > in a subdirectory inside the gitdir rather tan in the workdir?
>
> I do not think we intend to create temporary files, whose final
> destination is somewhere under $GIT_DIR/, in any working tree;
> rather, I think we try to create them inside $GIT_DIR (or possibly
> if the destination is a file in a subdirectory of $GIT_DIR, then in
> the same subdirectory).  What you are seeing definitely smells like
> a bug in the worktree code, perhaps getting confused by the fact
> that the full path to these places look "unusual" by starting with a
> single alphabet followed by a colon (IOW, this may manifest only in
> Windows port).

I agree. Auditing the setup code did not reveal anything though. Our
code should recognize these unusual Windows paths as absolute and
while I spotted an incorrect use of '/' (instead of is_dir_sep) it
does not explain the problem here.

Hultqvist, if you set environment variable GIT_TRACE_SETUP to 1 and
run "git status" in G:\Test1, what does it say?
-- 
Duy
