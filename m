Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242F31F6BD
	for <e@80x24.org>; Fri,  3 Feb 2017 13:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753230AbdBCNjC (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Feb 2017 08:39:02 -0500
Received: from mail-ot0-f176.google.com ([74.125.82.176]:35993 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbdBCNjB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2017 08:39:01 -0500
Received: by mail-ot0-f176.google.com with SMTP id 32so14292456oth.3
        for <git@vger.kernel.org>; Fri, 03 Feb 2017 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GRIOZd5HPn+kfh1VlraYi51QmupTJutpA5ZVTbZ4Gxw=;
        b=iBSreih5s++LNuPTuKgM+RMwvT4adMVl2Q6fv2G9llTdJaSgXO1uWNjpQ//s05ePTN
         svj8U8Ri9tcApqiQRqbSkC0zLc5FBsteYQpm/ckhRQrBYW1zj2I6kDVq5SSjHBmcubDm
         CtMtRhBWRvqbaqZFZpKbXTKZlrfuYFWBifPyIPKTByxprQTYLUcCgLx96CMmV4CLEQjn
         xVk2qJMOOHaWJed3cg73tcfVvZ+qE5C3WmttTbhZU5frH4N6/52V/88TEWGQO6LFqeVO
         qXcpr2AWSLyfa5luqQE2rAsUXSA+ZTTr9GjCBOZ1/Qbjbd6eBpl8CaugxTGeAEeEUFC9
         SVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GRIOZd5HPn+kfh1VlraYi51QmupTJutpA5ZVTbZ4Gxw=;
        b=MptYdJBQIZGAcoANytRRcXMc29xNd2K5bA3H/Ra+HdS4rW7KoYSt0DVe0NvCjFW0iC
         dxqpvUAXjUuKxbHZyiTMM2f0MYwfe7O0k4tDoRr2Sttw6xucqTn8fw9MYL+FBkyUVfW2
         fO3lbXK7IPYxGUYSzNs03JIHq0Vav7CzOqxjQaoLMmKu4IqqkXVfAxGaNoD3iMChw5pr
         Hujg1//S+pn6rC8zfL09m0Rdr5ae5oJaVCGDxhyYnm1czMc9L7J+jt9chZjEHxk4TVO3
         g6xgvyGQlCGYSoaxHThCM5F4xctCWbdeDXk5+cFAAG3VmU6DsYfigoC4G+aipe8Tc6A0
         NW+A==
X-Gm-Message-State: AIkVDXKUAOJatUwi4WZdUnavaLJfAUHtg/TSAZVuIvK2XucF3FwHDdnsA2lfUyghcaXWdGopGdVyHF0ADNLBfw==
X-Received: by 10.157.37.54 with SMTP id k51mr6189961otb.271.1486129139667;
 Fri, 03 Feb 2017 05:38:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Fri, 3 Feb 2017 05:38:29 -0800 (PST)
In-Reply-To: <87efzg7oq3.fsf@kyleam.com>
References: <87h94d8cwi.fsf@kyleam.com> <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
 <87efzg7oq3.fsf@kyleam.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 3 Feb 2017 20:38:29 +0700
Message-ID: <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
Subject: Re: init --separate-git-dir does not set core.worktree
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 2, 2017 at 7:37 PM, Kyle Meyer <kyle@kyleam.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Thu, Feb 2, 2017 at 10:55 AM, Kyle Meyer <kyle@kyleam.com> wrote:
>>>
>>> As of 6311cfaf9 (init: do not set unnecessary core.worktree,
>>> 2016-09-25), "git init --separate-git-dir" no longer sets core.worktree
>>> (test below).  Based on the commit message and the corresponding thread
>>> [1], I don't think this change in behavior was intentional, but I wasn't
>>> able to understand things well enough to attempt a patch.
>>
>> I'm missing some context. Why does --separate-git-dir have to set
>> core.worktree? What fails for you exactly?
>
> Sorry for not providing enough information.  I haven't run into a
> failure.
>
> In Magit, we need to determine the top-level of the working tree from
> COMMIT_EDITMSG.  Right now that logic [*1*] looks something like this:

This is much better :)

>  * COMMIT_EDITMSG in .git/modules/<module>/: set working tree to the
>    output of "git rev-parse --show-toplevel"
>
>  * COMMIT_EDITMSG in .git/worktrees/<wtree>/: set working tree to the
>    path in .git/worktrees/<wtree>/gitdir, minus the trailing "/.git"
>
>  * COMMIT_EDITMSG in .git: set working tree to the parent directory
>
> This fails for a repo set up with --separate-git-dir [*2*], where the
> last step will go out into an unrelated repo.  If core.worktree was set
> and "git rev-parse --show-toplevel" returned the working tree like it
> did for submodules, things would work.

OK. If I read this right, given a path of any text file somewhere
within ".git" directory. you are tasked to find out where the
associated worktree is? I.e. this is not an emacsclient executed as
part of "git commit", correct?

So you need some sort of back-link to ".git" location. And
unfortunately there's no such thing for .git file (unless it points to
.git/worktrees/...). I'm hesitant to set core.worktree unless it's
absolutely needed since it may have unexpected interaction with
$GIT_WORK_TREE and others (not sure if it has any interaction with
submodules too). I think adding a new file "gitdir" would be a safer
option.

I'm not entirely sure if enforcing "one worktree - one repository" is
safe though. The first two bullet points are very specific and we can
assume that, but ".git" files alone can be used for anything. In
theory you can always create a secondary worktree (that's not managed
by "git worktree") by setting GIT_WORK_TREE and "git checkout -f"
somewhere. But I guess those would be temporary and nobody would want
magic to point back to them.

As a fall-back mechanism, I think after magit has found the worktree,
it should verify the found location is the correct worktree, with "git
rev-parse --git-dir" or something, and alert the user otherwise. I
think "git rev-parse --git-path COMMIT_MSG" should give back the same
COMMIT_MSG path (and it applies for any files in .git dir, covering
all three cases). The user could add some magit-specific files to tell
magit where the actual worktree is when they hit corner cases.

If the use case is limited to editing COMMIT_EDITMSG only (after it's
generated by git), it may be best to add `pwd` as a comment to that
file. You won't have to go through all the magic rules to find it out
(*). And it helps non-magic users too.

(*) well, you do, because you probably can't expect everybody to have
latest git version.

> Of course, the issue above isn't a reason that --separate-git-dir should
> set core.worktree, but the submodule behavior is why we were wondering
> if it should.

I'm not a submodule person, so I'll pass that "why" question to Stefan.

> And so I was going to ask here whether core.worktree
> should be set, but then I confused myself into thinking 6311cfaf9
> unintentionally changed this behavior.
>
>
> [*1*] This is done by magit-toplevel:
>       https://github.com/magit/magit/blob/e34f4e8eb00f292e8c475489fa7caa286857a421/lisp/magit-git.el#L400
>
> [*2*] https://github.com/magit/magit/issues/2955
>       https://github.com/magit/magit/issues/2981
-- 
Duy
