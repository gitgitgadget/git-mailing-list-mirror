Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D18741F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbeHOCMv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:12:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45330 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbeHOCMv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:12:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id 139-v6so17535551ywg.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=De5hjMrGokYPyVBP+u255lZmchs51SCxkJdiM1Pw114=;
        b=AH4vq1ztdcHhfWXX1uK0o6UQErzphICYPfMCzPx2lPkeQHF6lDMsjzIsdoUhrjzZAn
         Bl5mUSSlIjzDgf+7wGCesAjR81iykHNJLSthZKu+parEw4FavEuPmOaw7mmFFIyGx2LS
         75FSf3+S8juFmEYcfqFQw4xnpVUpI39p84ucRa3mZ6GtT848yBNUQPXCnTOZw9eQSEb2
         1zCSSn+aS9rqvfnoqNe9aD+bSNQVMtTAk9WacOcMi8epDmWhQzBUE/o4x0atHUjSnq1I
         4HubaI+akFcTzu1+H7i2NnsvKThD8iyBXJ9NAZTTVK9+wzJGnBVX9dbNFSKVzZUYRaFe
         j5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=De5hjMrGokYPyVBP+u255lZmchs51SCxkJdiM1Pw114=;
        b=i1MzQ0jUss48FbiEUonxueSoZb7p4ZxjqRIA4eUFplN1FmrO2RtzrCprdefqNu8Anh
         /Rv0reofFwGf5sYUWFedYhoGBFa5UvQdUXbXBBUNPw3KV5BnXcStxWGYDbsx3C1oaTvi
         krghtczBbPvxYIU6+bQJtJUrtp2Ieos9bP/KN1WlHuliNZer9immMOxPqpQVadz9jw4c
         KSnyZEmEqfOsk2wT3iAX66J9gbpqUlg30L41h+ckRhaTAQ1D+OqzVRYutpMcKtcHigBF
         DLpq9DK+BD4ylQM84QMOb0LpUCJfUxiCwfOx9CFUsQCSLTMTKmsXTPtk23t/Sil/Pz23
         XzNg==
X-Gm-Message-State: AOUpUlHZtzC7kCqerCh7FkuZiuBUbKbmD9Nou5LZTaO+s/uWo+AyYBo4
        8ZYji4bes7fvZMhpP+8mAvBCM4Vz5LiJW2/nXAne0A==
X-Google-Smtp-Source: AA+uWPzBV+kTZqGs3bkNp3CVdl3ffsZuvN/YnTYEr6MF/2BsC+nBj3u7N3hKZTt9UhM1ErUkhZaJmH2uhffoL5zgp3Q=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr12649097ywd.500.1534289002274;
 Tue, 14 Aug 2018 16:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
 <20180814223820.123723-1-sbeller@google.com> <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 16:23:11 -0700
Message-ID: <CAGZ79kbhwyMTmnwhuaOLOnffaEX_G1L7dR=qvV6Rjncq0POq7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] store submodule in common dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     joakim.tjernlund@infinera.com, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 4:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> >  path.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > On Tue, Aug 14, 2018 at 3:27 PM Joakim Tjernlund <Joakim.Tjernlund@infinera.com> wrote:
> >>
> >> I am trying to create 3 submodules from the same git repo, each pointing to a different branch.
> >> Since the repo is somewhat large, I don't want the 3 submodules to clone the same repo 3
> >> times, I want one clone and then have the 3 submodules to point to different commits.
> >>
> >> Is this possible? If not, could it be added?
> >
> > yup.
> >
> > According to recent discussions, it would be just this patch.
> > (plus some unspecified amount of work, TBD).
> >
> > I thought about proposing something proper later, but here is the WIP patch.
> >
> > Thanks,
> > Stefan
>
> My understanding of what Joakim wants to do is to have a top-level
> project that has three subdirectories, e.g. kernel/v2.2, kernel/v2.4
> and kernel/v2.6, each of which is a submodule that houses these
> versions of Linux kernel source, but only clone Linus's repository
> (as the up-to-late tree has all the necessary history to check out
> these past development tracks).  And that should be doable with
> just the main checkout, without any additional worktree (it's just
> the matter of having .git/modules/kernel%2fv2.6/ directory pointed
> by two symlinks from .git/modules/kernel%2fv2.[24], or something
> like that).

Ah! I misunderstood due to fast reading.

For that I think you are interested in the feature added in d92a39590d1
(Add --reference option to git submodule., 2009-05-04), i.e.
both the update and add command take the --reference flag
that can be pointed at another repository such as an outside
clone of these three submodules, so some deduplication will
be performed.

> Isn't "common_dir" stuff used to decide if each of separate
> "worktree" instance (of the superproject) shares ".git/$stuff"
> with each other?
>
> Unless I am grossly misinterpreting the original question, I fail to
> see how changing .git/modules to be shared across worktrees possibly
> affects anything.  I am puzzled...

I did misunderstand grossly.

Stefan
