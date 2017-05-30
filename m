Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E875C2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbdE3RGD (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:06:03 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33463 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdE3RGC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:06:02 -0400
Received: by mail-pf0-f171.google.com with SMTP id e193so77879814pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hyNJqWK9MmGp21xLdrSShwytq+7WCrteyFxJJrUPvf8=;
        b=Yj3r7geJsfJ0MMUnoISkKxwCpLh/i9NbApAIckaEdtvTOQwRU1PNuyHA2WmFZR8lrl
         lCjhRj8CPvhuXG+HvYMlzQBJcH63j8x6bkOnahEclmILmmY/eRH7LDdKNY6LEHF8XFtY
         642yyhVS7u0okPNiI/kYDKcHixRykcmAF1yZiU65GSQqNua8voDVTbJI3zclq6w6bXCx
         RlN9d9royr2gIIEYfewkCi5dyde8pzrWKTK61uN9YD7pRRfK8lEgEUy+W2hu52BuPq8e
         PYBeq1jkCpEiG7tOTNy8WE+0h2jXhUwrspVlTQWaFJy+F7JTS4Q/etTzs5EEz/4dYIHx
         5tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hyNJqWK9MmGp21xLdrSShwytq+7WCrteyFxJJrUPvf8=;
        b=SshAf7jufefKqdfc+FAG1ItG1S2wauny/CK44fcj4uzwIS1HaxX1rEfHnvTHBiClps
         +EZ0sVH+qACG9XCfjwkkc9Vg1OPH0WvLjT2lkjCB9hcy0E0i/nm5X96j1V5yY4nmod0Y
         wR4ynHUxkwmmnGJZkaFaTaElkNXjDVCW0YJo6O0TnbaDym4p9fgtN+THqgvgA5hUOKne
         XZpLEw1P7Xq5SG7qMO+tvB/EzUT9+1auWiprOGGLgnRIh6SIO7+7NtN3coMFWw3+vtc4
         9fI0ltsNTGRi9Hpi1DnvVVUdbDP/0GGncSmIZahhYnLWH8c3PwZBlrhPSIfUSAVkSFrn
         /3zA==
X-Gm-Message-State: AODbwcCN9tl8c3wxwmk1cJz/TI5jssULBHvBO+Wpl3RZRSeP7Kv2dhcm
        qOryvllEx8EulK3Deiwsrw==
X-Received: by 10.84.231.139 with SMTP id g11mr69919308plk.71.1496163959886;
        Tue, 30 May 2017 10:05:59 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:308e:e3d5:272e:65c])
        by smtp.gmail.com with ESMTPSA id c7sm26783773pfk.103.2017.05.30.10.05.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:05:58 -0700 (PDT)
Date:   Tue, 30 May 2017 10:05:57 -0700
From:   Brandon Williams <bmwill@google.com>
To:     John Shahid <jvshahid@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git push recurse.submodules behavior changed in 2.13
Message-ID: <20170530170557.GA2798@google.com>
References: <CAE5=+KX57KM+6n9NpePw9KYPXFy7UH-WRgSwaJDnvRofYFXm7Q@mail.gmail.com>
 <xmqqinkk8jqm.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYHNpsasqhTY2WrCYgNU1if-pK7UznJV9AWEhxVf6_GvQ@mail.gmail.com>
 <CAE5=+KWzhhn3b14WoCXQD4Qb2gLd5soQQAUk7NTZeZnGgV61DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5=+KWzhhn3b14WoCXQD4Qb2gLd5soQQAUk7NTZeZnGgV61DA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/30, John Shahid wrote:
> Junio, sorry for the poor report. I totally forgot to describe the
> behavior that i'm currently getting vs what i expect.
> 
> Expected behavior:
> 
> We have a parent repo on a branch called "develop" and a submodule on
> a branch called "master". Prior to git version 2.13 if we had an
> unpushed commit in the submodule and ran "git push origin develop
> --recurse-submodules=on-demand" git would happily push the develop
> branch of the parent repo and the master branch of the submodule,
> e.g.:

Yeah my patches would definitely break that kind of workflow because
they assumed that if you actually provided a refspec + --recurse that
you would want it propagated down.  When developing those patches I was
trying to avoid needing to add an additional flag to do the propagation
but given people were already relying on this behavior it looks like
that may be the only course of action.

> 
> > Pushing submodule 'sub'
> > Counting objects: 2, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (2/2), 242 bytes | 0 bytes/s, done.
> > Total 2 (delta 0), reused 0 (delta 0)
> > To /home/jvshahid/codez/git/t/trash directory.t9904-diff-branch-submodule-push/sub.git
> >    3cd2129..69cbc06  master -> master
> > Counting objects: 2, done.
> > Delta compression using up to 4 threads.
> > Compressing objects: 100% (2/2), done.
> > Writing objects: 100% (2/2), 283 bytes | 0 bytes/s, done.
> > Total 2 (delta 0), reused 0 (delta 0)
> > To ../pub.git
> >    7ff6fca..945bc12  develop -> develop
> > ok 2 - push if submodule has is on a different branch
> 
> Actual behavior:
> 
> After the change mentioned in my previous email, git would propagate
> the refspec from the parent repo to the submodule, i.e. it would try
> to push a branch called "develop" in the submodule which would error
> since no branch with that name exist in the submodule. Here is a
> sample output with git v2.13.0:
> 
> > pushing to ref refs/heads/develop:refs/heads/develop
> > pushging to remote origin
> > fatal: src refspec 'refs/heads/develop' must name a ref
> > fatal: process for submodule 'sub' failed
> > fatal: The remote end hung up unexpectedly
> 
> I hope this clarifies my bug report.
> 
> Stefan, one little correction. I don't think the commit called out
> this behavior. The commit message was talking about unconfigured
> remotes (i.e. pushing to a url or local path) to not propagate the
> refspec and preserve the current behavior. Judging from the code and a
> test case that I wrote, this behavior is working as expected. That is,
> git won't propagate the refspec.
> 
> Cheers,
> 
> JS
> 
> On Mon, May 29, 2017 at 12:20 AM, Stefan Beller <sbeller@google.com> wrote:
> > On Sun, May 28, 2017 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> John Shahid <jvshahid@gmail.com> writes:
> >>
> >>> It looks like the git push recurse-submodules behavior has changed.
> >>> Currently with 2.13 you cannot run "git push
> >>> --recurse-submodules=on-demand" if the parent repo is on a different
> >>> branch than the sub repos, e.g. parent repo is on "develop" and
> >>> sub-repo on "master". I created a test that can be found here [1].
> >>>
> >>> A bisect shows that the change to propagate refspec [2] to the
> >>> submodules is the culprit. imho this is an undesired change in
> >>> behavior. I looked at the code but couldn't see an easy way to fix
> >>> this issue without breaking the feature mentioned above. The only
> >>> option I can think of is to control the refspec propagation behavior
> >>> using a flag, e.g. "--propagate-refspecs" or add another
> >>> recurse-submodules option, e.g. "--recurse-submodules=propagate"
> >>>
> >>> What do you all think ?
> >>>
> >>> [1] https://gist.github.com/jvshahid/b778702cc3d825c6887d2707e866a9c8
> >>> [2] https://github.com/git/git/commit/06bf4ad1db92c32af38e16d9b7f928edbd647780
> >>
> >> Brandon?  I cannot quite tell from the report what "has changed"
> >> refers to, what failures "you cannot run" gets, and if that is a
> >> desirable thing to do (i.e. if letting the user run it in such a
> >> configuration would somehow break things, actively erroring out may
> >> be a deliberate change) or not (i.e. an unintended regression).
> >>
> >
> > Before the refspec was passed down into the submodules,
> > we'd just invoke "git push" in the submodule assuming the user
> > setup a remote tracking branch and a push strategy such that
> > "git push" would do the right thing.
> > And because the submodule is configured independently, it
> > doesn't matter which branch you're on in the superproject.
> >
> > Looking at the test[1], you run "git push --recurse-submodules"
> > without any remote/branch that was called out in the commit
> > message[2] to not have changed. Is that understanding correct?
> >
> > Looking at the test cases of [2] we did not test for explicit
> > "still works with no args given", though one could have expected
> > we'd have a test for that already. :/
> >
> > Thanks,
> > Stefan

-- 
Brandon Williams
