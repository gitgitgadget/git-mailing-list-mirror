Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 344B31F404
	for <e@80x24.org>; Mon,  9 Apr 2018 00:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeDIAiP (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Apr 2018 20:38:15 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:44639 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbeDIAiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:13 -0400
Received: by mail-qk0-f182.google.com with SMTP id n139so7518445qke.11
        for <git@vger.kernel.org>; Sun, 08 Apr 2018 17:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=mMfoVj2vjg6sSkHAJT8gQgVQ6AbPUJ1aDA9KcGprHAQ=;
        b=kigRckUmULGPoS929TRPbQRE0ER7S7yjAd+Er+qSVx1fbCh8dd6CfBGFIXgFLOSQyb
         2Akl+Yk1A9w7Wj1v4ClAo1Wv9ks25DzPjQge3b5Jwp6f6FlfCE8TjDDLObUDALuOtnXt
         b5BSnKX7DkoadD9Q2guzYYqL2IsIW4FsBajXhZffQcTys9TuQHUelaBbkIFbidUBkDZV
         LpaTpdUd6wm8nchnN9SdPlE5QNKYTBfkJT/mKgTAmUZWoAhaH+tnY5SbCFBggm/ELEwm
         JUdo6k6NVso3hWxVw9vI+wMZ/V7JV0GWZ+KFR3sxbfBJ4iZ3OaWV8k1FuFyNPjqXBgtT
         DZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=mMfoVj2vjg6sSkHAJT8gQgVQ6AbPUJ1aDA9KcGprHAQ=;
        b=ePC61y7jX9QZUdo1ioGMJ3jr1a2t9fkiENLIdkzdWr0ioogcvTdUXzb/3PSehtGfhA
         6GGyEqkxpwXY3r5E0xTV+y//RcU2RtwlQnSvjH+XMIh4skAzT0ksFPwWbTPk3qq8HnT6
         bKACTyhei/pBpxv25xACS2QbG27QEF9+DI5nsgadug5zpv1wtjq2mSdn0wVZpJQIP3kH
         Fmiv7jbhqQ4IAfn/YJQc1GgpfKzPiX7IZeH+VOdoY/6FUVcX0AKesFo93RRX1lvXrfMN
         OjaTgH5LfTaTY8XoPBQtZcOyl7NP2+znQPq363yyGG9+x0crbZiCghLVcI493ryT6GKS
         zQyQ==
X-Gm-Message-State: ALQs6tD0zBeKVPWs230/v69I9Lg1kvBki4rutTsEghZ6S96fQg6d500E
        SU9lkz76xqNGAzBQSAe8nEs0wOymW3IeUDXnxSk=
X-Google-Smtp-Source: AIpwx4/b3Zn5mLBOX25B5MiNCRTzlCvh7fK6AqyaBKhimJ3AdtXgSLJMxaeHRresyBV6wZNshOAaNvO+vS8X+UyVBWI=
X-Received: by 10.55.159.140 with SMTP id i134mr45962373qke.220.1523234293198;
 Sun, 08 Apr 2018 17:38:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 8 Apr 2018 17:38:12 -0700 (PDT)
In-Reply-To: <20180408142417.GJ2629@hank>
References: <20180325134947.25828-1-t.gummerer@gmail.com> <20180331151804.30380-1-t.gummerer@gmail.com>
 <CAPig+cQ8VzDycUMo-QOexNDBgQGEGj2BPmPa-Y0vhGCt_brbhg@mail.gmail.com> <20180408142417.GJ2629@hank>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 8 Apr 2018 20:38:12 -0400
X-Google-Sender-Auth: HLiS-RtyTYxKPZKlwmG1lxhsXWE
Message-ID: <CAPig+cSGxMgEwqXDb4-_AWbdvm5=x-dgwi4mKqDbNfex2KDm0Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 8, 2018 at 10:24 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> On 04/08, Eric Sunshine wrote:
>> On Sat, Mar 31, 2018 at 11:17 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Let me think through some of the cases here, of 'git worktre add
> <path> <commit-ish>' with various flags and what the UI would be with
> that added:
>
>   - no flags:
>
>     $ git worktree add ../test origin/master
>     Checking out 'origin/master'
>     Checking out files: ...%
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
>
>   - -b branch:
>
>     $ git worktree add -b test ../test origin/master
>     Creating branch 'test'
>     Checking out 'origin/master'

Did you mean "Checking out 'test'"?

>     Checking out files: ...%
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
>
>     Would we want to omit the "Checking out ..." here?  I'm leaning
>     towards yes, but dunno?

To which "Checking out" message do you refer, the one showing the
branch name or the one showing the checkout progress?

I'd probably agree that showing both "Creating" and "Checkout out" is
overkill. However, see my response[1] to your "fixup!" patch in which
I explore the idea that unifying "Checking out 'branch' and "Creating
branch" messages may be a good idea and get us out of some UI jams
which seem to be cropping up.

[1]: https://public-inbox.org/git/20180325134947.25828-1-t.gummerer@gmail.com/T/#m5d38b0c6427609e8c36aa6af83d518791c1e1581

>   - Original dwim with --detach flag
>
>     $ git worktree add --detach ../test
>     Checking out 'c2a499e6c'
>     Checking out files: ...%
>     New worktree HEAD is now at c2a499e6c Merge branch 'jh/partial-clone'
>
> Looking at this, I'm not sure what's best here.  I'm not sure I'm a
> fan of the duplicate "Checking out " message (I assume that's what you
> meant above, or did you mean just "Checkout ..."?)

Taking [1] into account, this might become something like:

    $ git worktree add --detach ../test
    Preparing worktree (detached HEAD c2a499e6c)
    Checking out files: ...%
    New worktree HEAD is now at c2a499e6c Gobbledygook

> I als don't think it gives too much context compared to just "Checking
> out files: ...%".  I think it gives a bit more context when that
> message is not displayed at all, as it shows whether files are checked
> out or not, but if we do that, when we create a new branch, the amount
> of output we'd display is getting a bit long, to the point where I
> suspect users would just not read it anymore.
>
> So I personally don't feel like this is worth it, even though it may
> give some context in some cases.

Fair enough observation. The idea suggested in [1] may keep output to
a reasonable amount.
