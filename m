Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C786720248
	for <e@80x24.org>; Sun,  7 Apr 2019 07:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfDGHPo (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 03:15:44 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45072 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfDGHPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 03:15:44 -0400
Received: by mail-ed1-f67.google.com with SMTP id f19so1860467edw.12
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 00:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OcwcsVosMDgDidWMmPARkfZ4PTukzAHwrqYT+V5Dm20=;
        b=AhS9wY5WJsrwYqVb9mAj0xR12T16LD9xT7h5zEL87LzYjnAyL5hfR3Q3gkMRkaNrUh
         OGj6vaYKdiNAIoG7Rlau9AtliGqspxaGbByeXr7kL2xKS2FBP4ZW9sDqFls2WQx+ujyD
         vmBmesdBo6MFlVchKHZJXLgRuGySDIpobDM2o9FFacgwmi/VyB5FkQgAnN03Ah3qxw1p
         3jREHCKYrV4aBNEwOq72/rDF9NU0Jk9OIkFwWXtv5mgwPr8xj/w58KwUKSY1qQBr5Y3y
         OSKqi/dA4a9NKJHzb4AkFmpuswr+XXoCaTrgR35XfM2h8xt6yP6Y2kIVB6qYtUK3Tc7s
         jcgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OcwcsVosMDgDidWMmPARkfZ4PTukzAHwrqYT+V5Dm20=;
        b=qtVCyfWcMS+2MmbHdHHgzQceeMs9tsXG9UhmuLgvuYmGmH9mRCjeGOpGM1qbaM15yf
         6kfSWhCCIjR9kke/Agq6qLQVWlG87OUCEtm6hiaScKk//NWScy2vkLwxYgBpcAhtn9Wu
         qLWATbPuxuypp/j/X3sm0HK716Gx8lL4EsEDgSSJ9NMlI28Xi3VcHgws7SYeuMZDXb17
         5IoD8UZaEcRZ5kRUGFiigDmRW5xaBgQEgNO3TpccKxuqI8LovX1Fw4yPiXgZxqb7BkNv
         KxZdsQ5/E7D2XCFUrKKWJKOWkcExoyM8dtNcfnEyCC0ybSypeyvwUL5YZ5lQhk0z+KXq
         KhrA==
X-Gm-Message-State: APjAAAXAuKiBC/NQbCl0MmQCLZP+rRbAg1/ZpaLELpNMifbNgIIeaHTw
        TEBIYquRmjqSY1bljF9apGOfF2MiCnaidCtxM2xg1tM8
X-Google-Smtp-Source: APXvYqwVT56Xwbnk3i9+bSe/+c9iH0FIrlMJbgYbiaCpQzndNY2GOshmWmlSM8kqfrHhrE3/hyNR+v/5fue+2mRK8mg=
X-Received: by 2002:aa7:c959:: with SMTP id h25mr14418556edt.107.1554621341992;
 Sun, 07 Apr 2019 00:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190405213100.9577-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190405213100.9577-1-rohit.ashiwal265@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 7 Apr 2019 09:15:30 +0200
Message-ID: <CAP8UFD12GXV80SVi5UR=mpBox9DFWw0Fp2wrf+1FEXbUdX1ReA@mail.gmail.com>
Subject: Re: [GSoC][RFC v3] Proposal: Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        git <git@vger.kernel.org>, rafa.almas@gmail.com,
        Stephan Beyer <s-beyer@gmx.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Fri, Apr 5, 2019 at 11:32 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Here is one more iteration of my draft proposal[1]. RFC.

Nice, thanks for iterating on this!

As we are close to the deadline (April 9th) for proposal submissions,
I think it's a good idea to already upload your draft proposal on the
GSoC site. I think you will be able to upload newer versions until the
deadline, but uploading soon avoid possible last minute issues and
mistakes.

In the version you upload, please add one or more links to the
discussion of your proposal on the mailing list.

> ### List of Contributions at Git:
>
> Repo                              |Status                      |Title
> ----------------------------------|----------------------------|---------=
--------------------------------------------------------------
> [git/git][8]                      | [Will merge in master][13] | [Micro][=
3]**:** Use helper functions in test script
> [git-for-windows/git][9]          | Merged and released        | [#2077][=
4]**:** [FIX] git-archive error, gzip -cn : command not found.
> [git-for-windows/build-extra][10] | Merged and released        | [#235][5=
]**:** installer: Fix version of installer and installed file.

Nice!

> #### Overview
>
> Since when it was created in 2005, the `git rebase` command has been
> implemented using shell scripts that are calling other git commands. Comm=
ands
> like `git format-patch` to create a patch series for some commits, and th=
en
> `git am` to apply the patch series on top of a different commit in case o=
f
> regular rebase and the interactive rebase calls `git cherry-pick` repeate=
dly
> for the same.
>
> Neither of these approaches has been very efficient though, and the main =
reason
> behind that is that repeatedly calling a git command has a significant
> overhead. Even the regular git rebase would do that as `git am` had been
> implemented by launching `git apply` on each of the patches.
>
> The overhead is especially big on Windows where creating a new process is=
 quite
> slow, but even on other Operating Systems it requires setting up everythi=
ng
> from scratch, then reading the index from disk, and then, after performin=
g some
> changes, writing the index back to the disk.
>
> Stephan Beyer \<s-beyer@gmx.net> tried to introduce git-sequencer as his =
GSoC
> 2008 [project][6] which executed a sequence of git instructions to  \<HEA=
D> or
> \<branch> and the sequence was given by a \<file> or through `stdin`. The
> git-sequencer wants to become the common backend for git-am, git-rebase a=
nd
> other git commands, so as to improve performance, since then it eliminate=
d the
> need to spawn a new process.
>
> Unfortunately, most of the code did not get merged during the SoC period =
but he
> continued his contributions to the project along with Christian Couder
> \<chriscool@tuxfamily.org> and then mentor Daniel Barkalow
> \<barkalow@iabervon.org>.
>
> The project was continued by Ramkumar Ramachandra \<artagnon@gmail.com> i=
n
> [2011][7], extending its domain to git-cherry-pick. The sequencer code go=
t
> merged and it was now possible to "continue" and "abort" when cherry-pick=
ing or
> reverting many commits.
>
> A patch series by Christian Couder \<chriscool@tuxfamily.org> was merged =
in
> [2016][16] to the `master` branch that makes `git am` call `git apply`=E2=
=80=99s
> internal functions without spawning the latter as a separate process. So =
the
> regular rebase will be significantly faster especially on Windows and for=
 big
> repositories in the next Git feature release.

It looks like you copy pasted the Git Rev News article without
updating the content. The improvement has been released a long time
ago.

> Despite the success (of GSoC '11), Dscho had to improve a lot of things t=
o make
> it possible to reuse the sequencer in the interactive rebases making it f=
aster.

Maybe s/rebases/rebase/

> His work can be found [here][15].

It seems to me that there has been more recent work than this and also
perhaps interesting suggestions and discussions about possible
sequencer related  improvements on the mailing list.

> The learnings from all those works will serve as a huge headstart this ye=
ar for
> me.
>
> As of now, there are still some inconsistencies among these commands, e.g=
.,
> there is no `--skip` flag in `git-cherry-pick` while one exists for
> `git-rebase`. This project aims to remove inconsistencies in how the comm=
and
> line options are handled.
