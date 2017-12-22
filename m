Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 564AB1F406
	for <e@80x24.org>; Fri, 22 Dec 2017 23:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbdLVXGQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 18:06:16 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37220 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755934AbdLVXGP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 18:06:15 -0500
Received: by mail-wm0-f42.google.com with SMTP id f140so24064639wmd.2
        for <git@vger.kernel.org>; Fri, 22 Dec 2017 15:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lj3kLHAllV+NW1cn0cQm6MUnR5ECCf3wZ5BUOWiFyTY=;
        b=citt6ysGo4UNwx0qA6WIwvsP0Np3BioojFeTZlbAOKB+1B+nj01bm++xzoTi6+XdRF
         KL09Pgkh3AGJsjFOrFUDlc463lyTdW6CmGjbZjITVdIOFEXRRF2sQSKzBct4+cJOk/12
         XAB2IGvv79pHAHEkNbSlFCe8D4KUXfZLc1pRMA8jr13M7JeQ4+ATThVC5oIjOqApeTTL
         PftXyKIcW2WMHz2VUAD6/L4xoYXGPOBd7T069NSqIIT6KfJPyrTNQKZTIJk9JiuAvI/v
         EfnlYu8WSNyIbQgJE+C0MHB6oN3pjp/FCxkTemMTnCFZ8RgvsgzHgsYfQ8vUUCEscjiU
         MXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lj3kLHAllV+NW1cn0cQm6MUnR5ECCf3wZ5BUOWiFyTY=;
        b=pDw1dpdFhsd4sM1Q3AcneUI/PmyKjXazl/H4fMCfT/y0HngPI4g4Fuw8c/kLSdp9H+
         naycgjeiy+7lw+gqGWPjdiRmmuFVQ/RYQyQs9u5SE4UUJe2FKJBWX1vu1DyP+2EEY/dW
         ZNbIcL+ruCW3UYVxWId+9jXVwq7CCY/2uOWXxEvpf9LeiYHHcaBIRS6axZdHhjdmSJSf
         Q27l2f2AJ2wVzU1ycuHykTOAGxdZPS4mzi736Pe55xt5cWaIrMfCHT5iyCEjtTfDDZx6
         ksW2ecZMe0ZgGhL5EKAtRbjgY4GYC4gaIpDpBy0XJXp7r8HppQC4GO2UuiR1Mx2vyWw7
         2P9A==
X-Gm-Message-State: AKGB3mIyJLcOGwywv7ndMgT4LyN347VG8Mtw7128mCoFJ28D/NHYCKgD
        1yWeQtXtAxamE3PL2tJzTC9axgkrwhh8f91qgewAPdpE
X-Google-Smtp-Source: ACJfBoshUKUQ7xsIaAdJANmGFrhXkKjNcfRxsbUbGnBRV8TpqDuVF0MSctsUKnLuswxjDLSGnHeHCTu4ULe03ieW4w4=
X-Received: by 10.80.165.109 with SMTP id z42mr16323134edb.18.1513983974539;
 Fri, 22 Dec 2017 15:06:14 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Fri, 22 Dec 2017 15:05:54 -0800 (PST)
In-Reply-To: <CAEW+b66pCqTBz6o_aTK0byyKsDc8HRfHuqKf64Ob6pBtL9w2Lw@mail.gmail.com>
References: <CAEW+b659_v02v8z_dgWzVayb8ArBOD+O_Oky-F50JbJSP8vCKQ@mail.gmail.com>
 <CA+P7+xojknncFrP5qCB4EKG0MAoTUqFWS5g3Bj+Jq2_RO0fA3A@mail.gmail.com> <CAEW+b66pCqTBz6o_aTK0byyKsDc8HRfHuqKf64Ob6pBtL9w2Lw@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 22 Dec 2017 15:05:54 -0800
Message-ID: <CA+P7+xpt1cW-uokayYFJ5cr88FKBcn_RT3v7iLHyu7kZaS=wbg@mail.gmail.com>
Subject: Re: Usability outrage as far as I am concerned
To:     Cristian Achim <brancoliticus@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 22, 2017 at 7:57 AM, Cristian Achim <brancoliticus@gmail.com> wrote:
>> Can you show the output of "git remote"
>
> # in usb_subfolder
> $git remote
> origin
> $
>
> #in home_subfolder
> $git remote
> $
>

With the -v switch you can see where each remote points to (tho your
home local repo has no remote which is fine).

>> and also
>> clearly explain with details the layout of what the folders are and
>> what is or is not a repository?
>
> Take the following update into consideration and then reread my first
> email hopefully with improved clarity:
>
> 'home_subfolder' is the path on disk inside my user account home
> folder in the 'home' root folder to the initial repo from which I
> meant to do a backup.
>
> 'usb_subfolder' is the path on disk in the 'media' root folder to the
> initial empty folder into which I wanted to do the backup above that
> points into a usb stick I mounted in the default Kubuntu KDE file
> manager way of mounting usb stick folder hierarchies.
>
> Current situation is that 'git log' in both home_subfolder and
> usb_subfolder show the same hash with only one branch in both. From
> usb_subfolder 'git pull home_subfolder' is broken as in the original
> message.

Ok. So you have a repository inside your home directory which you wish
to copy into the USB stick?

So what steps did you take to setup the repository usb_subfolder initially?

You're basically trying to create a backup copy of what's in
home_subfolder into your USB stick?

If you're confident that home_subfolder is accurate right now, (ie:
you inspect its contents with git log, git status, and regaulr
commands to check that everything is as you expect), here's what I
would do:

cd to your usb stick, then run
git clone /path/to/home_subfolder

this will create an initial clone.

If you wish to update it later, you can mount hte usb stick, and then
just run git pull from inside the new subfolder. Note that you do
*not* run "git pull home_subfolder", as git pull expects the name of a
remote, which in this case is just origin (since the default remote
name you clone from is origin)

I'm still not certain what state you got in, but I believe based on
your commands that the home_subfolder is fine, and you somehow
incorrectly setup the usb_subfolder.

Thanks,
Jake

PS/Tangent:

If you never need the checked out files on the USB disk, and only wish
to keep history saved, then you can actually do "git clone --mirror
<path>" in order to make a bare copy which is a complete mirror of all
refs in the original repository.

Then you can update it with just git fetch, or git remote update.
(tho, keep in mind this clone would not have any working tree, but
merely a bare repository contents). (You can, ofcourse, recover the
files by simply cloning to somewhere else, or adding a new work tree
or similar.
