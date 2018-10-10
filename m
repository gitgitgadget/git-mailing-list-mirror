Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89F041F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 11:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJJSXd (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 14:23:33 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38849 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJSXc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 14:23:32 -0400
Received: by mail-ot1-f42.google.com with SMTP id l1so4889967otj.5
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1upU4MTcc2CrX7czRA8yhmUdTJp4VUm2I8nVEBvgTk=;
        b=aMNRaJBmJ6nZ24yfFglWYytfEBseV0LyZV8eZBVlD9Ti0+dkkFqCshaLjOv7IfLmS4
         y08jZ/Tw6+walWUe4lkpLEERXDTAF7/kHJdU0p/9KGoe+5Korw+t86PVbdnhUQ2Xu0Pq
         IBwH1TLiPnQoVSNWfLJDSIC8Jpn35COvr0GOTi3jPFPPDqtmeGZKJwMx1TbePrWdWqrl
         YRaNuJXeBT1N4R30HtSZpxg5ILcrDSzdLbHQnq+PbcLxyz5C9+J/6qrs61SXmlWKfMLh
         /7GK3Ngf9M9gmGuMvqzbeDUo/TdukicIAL0TxLFCi4us46dA0VcxFsiAw8mMfaNI57Pb
         EUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1upU4MTcc2CrX7czRA8yhmUdTJp4VUm2I8nVEBvgTk=;
        b=RzyNs7BqxPPB6//vNi7I95TFVt4IZ6wgZ9mgB6QmBbo6N+67MFqM+GmRaYhfxjN0SX
         aKkcKCLFOjOdyrQHxZ9EyHIqD3Lu0HIfSpha3zFv2WBo9kAJDAImJW4NPF598R7/3DGN
         1NjqSrzjfAPfYIQ/oodDB6GuOn6TL+5511CRl3iBhZVtiB9jgM3wavZhrVnz58D5TgXs
         EFR0439kKKE4IoXcnYlrNcuBtok0+KrzVc0JEQf3WgpBtEMhqlGrJ/u7//7ZF5mlvJ0j
         Zhs3GNcU8DSUEaoagRnvKSGjyQRHsf7zw6yvOpUw8WRA/ZkSWmeshpWDbb9TZeRIgibD
         c5sg==
X-Gm-Message-State: ABuFfoijvuhxH0sL56WqB+DLWHrhe6tVC+nJURxiPyn49yei3LewlU/0
        LeVJdT3McatTAXkBjcslVzm4w+grD0FyY05MgjI=
X-Google-Smtp-Source: ACcGV6061LIQcN4vKAG+/QM8jmzfnUIVtqV+12MC4ZoN9PmIDz92NtUusQX7K0zA6l++aRoqyb7LR0kM9hg9p/EP+uA=
X-Received: by 2002:a9d:11f5:: with SMTP id y50mr2997592oty.306.1539169314710;
 Wed, 10 Oct 2018 04:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
 <20181009234502.oxzfwirjcew2sxrm@dcvr> <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
From:   Martin Langhoff <martin.langhoff@gmail.com>
Date:   Wed, 10 Oct 2018 07:01:43 -0400
Message-ID: <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
Subject: Re: git svn clone/fetch hits issues with gc --auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking around, Jonathan Tan's "[PATCH] gc: do not warn about too many
loose objects" makes sense to me.

- remove unactionable warning
- as the warning is gone, no gc.log is produced
- subsequent gc runs don't exit due to gc.log

My very humble +1 on that.

As for downsides... if we have truly tons of _recent_ loose objects,
it'll ... take disk space? I'm fine with that.

For more aggressive gc options, thoughts:

 - Do we always consider git gc --prune=now "safe" in a "won't delete
stuff the user is likely to want" sense? For example -- are the
references from reflogs enough safety?

 - Even if we don't, for some commands it should be safe to run git gc
--prune=now at the end of the process, for example an import that
generates a new git repo (git svn clone).

cheers,


m
On Tue, Oct 9, 2018 at 10:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Forwarding to Jonathan, as I think this is an interesting supporting
> vote for the topic that we were stuck on.
>
> Eric Wong <e@80x24.org> writes:
>
> > Martin Langhoff <martin.langhoff@gmail.com> wrote:
> >> Hi folks,
> >>
> >> Long time no see! Importing a 3GB (~25K revs, tons of files) SVN repo
> >> I hit the gc error:
> >>
> >> warning: There are too many unreachable loose objects; run 'git prune'
> >> to remove them.
> >> gc --auto: command returned error: 255
> >
> > GC can be annoying when that happens... For git-svn, perhaps
> > this can be appropriate to at least allow the import to continue:
> >
> > diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> > index 76b2965905..9b0caa3d47 100644
> > --- a/perl/Git/SVN.pm
> > +++ b/perl/Git/SVN.pm
> > @@ -999,7 +999,7 @@ sub restore_commit_header_env {
> >  }
> >
> >  sub gc {
> > -     command_noisy('gc', '--auto');
> > +     eval { command_noisy('gc', '--auto') };
> >  };
> >
> >  sub do_git_commit {
> >
> >
> > But yeah, somebody else who works on git regularly could
> > probably stop repack from writing thousands of loose
> > objects (and instead write a self-contained pack with
> > those objects, instead).  I haven't followed git closely
> > lately, myself.



-- 
 martin.langhoff@gmail.com
 - ask interesting questions  ~  http://linkedin.com/in/martinlanghoff
 - don't be distracted        ~  http://github.com/martin-langhoff
   by shiny stuff
