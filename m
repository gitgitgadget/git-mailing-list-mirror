From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/1] Introduce a way to create a branch and worktree at
 the same time
Date: Fri, 11 Mar 2016 07:56:36 +0700
Message-ID: <CACsJy8AuBsF_rhuo_a_nqaVH1ApT3iAyozt1w2vkmvHmK17hZA@mail.gmail.com>
References: <cover.1457609615.git.johannes.schindelin@gmx.de>
 <CACsJy8BA7-ev9wTt6K45TgiNxOaBUXbN1P03U4EUAzAPy=7Faw@mail.gmail.com> <alpine.DEB.2.20.1603101417590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 11 01:57:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeBOI-000426-DZ
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 01:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933025AbcCKA5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 19:57:09 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:33628 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932949AbcCKA5I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 19:57:08 -0500
Received: by mail-lb0-f176.google.com with SMTP id k15so136980891lbg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 16:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pDvrFKlWP4M1BlVTDGtPUsjlTckPrnKFdQzdpOSA8fY=;
        b=od/5O0bfmlNf/7R/nhrzOAOPF/li/2U2b2ANmll884yEE7AyJf0HbZRNRKorMPyGkY
         V7YTfsf5h+Zwy4Srsf1HpUWrgcFr/t8VNKWVp8cqP+h0ifv5kEez5Qu38Akco2RuuZL1
         T7fP7y5VFQKG0aaqdTYJnBumhtb2yyyZbyAZJtl0A8USPzG+4U0QgVdm7oEAeoBlqZCi
         /9mNgWZYVcAKJxpsbf588I/tYwVLD9qri7y1vBMLCeEGgJ5ZC0Dd/uEr15hxslMc6RE9
         GzM4Sme7im24HLjR3qfNlgLlT3ivp/TDdxl9k/hih8YzQqx0eMkSs43pwCS64hAytD4T
         RSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pDvrFKlWP4M1BlVTDGtPUsjlTckPrnKFdQzdpOSA8fY=;
        b=BV9/UOpneVDC/CGxMTm7rsRuV7qeYZCrHiXX1iRiv5oCNZlQTLvf1wL8dCDFHjd/TI
         pFaICLqviWlpIDDdZ/fbv2jpKVNUw1OGWWWbpID3tKKkaQIL/HihyULnxpx7fJH5VCAI
         3yS7k6LnHxrF3v7Rs8fvH9nP4h1S6MF3IxhLGl0FrjdynoyJ2Rlx3xjN4e/bHBblBCFu
         qCH7mEGm8QenH+LLDCQfGnPg+Z1UaXHALzpEoWzkGbzh+r5puBhEIwyeetj5cZuJlUwG
         gdwweafyk09Bd15q4fXuacqSi/DhkupXZbG6jPA/NiWX35WxH42XlQsDEoLzee8AlYGL
         s0Yg==
X-Gm-Message-State: AD7BkJKyqb99nz3y3PgdHQQoMXY2sjfEeQMSu4vN2abNpAnMxYzbT9YM/RdaZ15VicaPhmyI17oQ7pAtibhvRw==
X-Received: by 10.25.211.75 with SMTP id k72mr2204097lfg.45.1457657825646;
 Thu, 10 Mar 2016 16:57:05 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 16:56:36 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1603101417590.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288667>

On Thu, Mar 10, 2016 at 8:21 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 10 Mar 2016, Duy Nguyen wrote:
>
>> On Thu, Mar 10, 2016 at 6:34 PM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > The invention of the `git worktree` command changed this developer's
>> > working style dramatically. Rather than switching between branches all
>> > the time, topic branches are created and checked out in newly-added
>> > worktrees, to be reworked and refined until the topic branch is either
>> > merged into `master` or abandoned.
>> >
>> > It gets rather tiresome, and also typo-prone, to call "git branch xyz
>> > upstream/master && git worktree add xyz xyz" all the time.
>>
>> You can actually do "git worktree -b xyz xyz upstream/master" for the
>> same effect. Maybe we can avoid "xyz" duplication with "-b -" or a new
>> option name?
>
> My branch names are usually longer, such as pull-rebase-prefix. And I
> really like the short 'n sweet "git branch -w pull-rebase-prefix master"
> invocation.
>
>> > Hence this
>> > proposal: "git branch -w xyz upstream/master" to do the same.

This assumes the new worktree is always placed at `cwd`. Perhaps it's
too specific?

>> > The plan is to also support "git branch -d -w xyz" once the `git
>> > worktree` command learned a `remove` (or `delete`) subcommand.
>>
>> "git worktree remove" is coming (will be resent after -rc period). And
>> I agree it's convenient for it to remove the branch as well because
>> that happened to (and annoyed) me a few times. I still think it should
>> be centered around git-worktree than git-branch though.
>
> Granted, "git worktree remove" should be the work horse. But why not have
> two ways to skin the same cat? I, again, would prefer the short 'n sweet
> "git branch -d -w pull-rebase-prefix" invocation.

If you put effort into making it happen, I'm not stopping you :)

>> > One possible improvement would be to add "/xyz/" to the parent
>> > repository's .git/info/exclude, but this developer hesitates to
>> > introduce that feature without the "delete" counterpart: those exclude
>> > entries would likely go stale very quickly. Besides, there might be a
>> > plan in the working to exclude worktrees automagically?
>>
>> That's needed because you add a worktree inside another worktree? I
>> know that feeling, but I've changed my layout from ~/w/git as main
>> worktree (and ~/w/git/.git as repo) to ~/w/git as a non-worktree dir
>> that contains all worktrees, e.g. ~/w/git/reinclude-dir,
>> ~/w/git/worktree-config, ~/w/git/lmdb... My typical worktree add
>> command is "git worktree add ../<some-name>" then move there and do
>> stuff. No nested worktrees, no need to update exclude file (and no
>> messing up emacs' rgrep command, which does not understand .gitignore
>> anyway)
>
> This feels to me like it is working around the problem rather than solving
> it. My worktrees are inside the corresponding top-level project for a
> reason: I work with multiple projects, and having all of their worktrees
> in a single $HOME/w/ directory would be rather confusing to me.
>
> I really want to keep my Git worktrees inside /usr/src/git/ (in Git for
> Windows' SDK).

I avoided it because adapting git alone was not enough, emacs' rgrep
is just an example that other tools may have problems with this setup
too. But if you still want to make git exclude them, I think you
should hook into the submodule peeking code instead of updating
exclude file. It sounds neater to me.

But if you go with exclude auto update, it's about time we introduce
multiple exclude files in $GIT_DIR/info. So you can separate auto
stuff from manual exclude rules.
-- 
Duy
