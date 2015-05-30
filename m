From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Sat, 30 May 2015 14:37:39 -0500
Message-ID: <CAHd499BRhfbfGOWv217QT5GwLpOkY4B3j8t3MACGXz-ZdQbYtA@mail.gmail.com>
References: <20150501175757.GA10569@book.hvoigt.net>
	<CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
	<5547C961.7070909@web.de>
	<CAHd499CRge9Y6VzdC_ngXS4WxuQ9HizXQJzLpX3iQStY5Cg=6g@mail.gmail.com>
	<37f399418bbebb3b53a50bf8daffcdc0@www.dscho.org>
	<CAHd499Do2aB5E_=aDzkoDssEbgz181rH36X28Oe7Zcok2f=zBQ@mail.gmail.com>
	<20150518123036.GB16841@book.hvoigt.net>
	<CAHd499CETM2jmZ2iJk=AoXtjLUCQ==u6q9Z5P-3EVGSY48FY_A@mail.gmail.com>
	<20150519104413.GA17458@book.hvoigt.net>
	<CAHd499D9vOtLOBj2s5EOfsojSStZY+HdZR35icZ5cssLNkcD-A@mail.gmail.com>
	<20150521125122.GA22553@book.hvoigt.net>
	<55691DE3.70200@gmail.com>
	<xmqqbnh2ateo.fsf@gitster.dls.corp.google.com>
	<CAHd499B+icDskcsR7zxPfZ=8Nqwg14eb2h2LBuDx6=fnoO24AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 21:37:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YymZn-0005Ec-Or
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 21:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbbE3Thm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 15:37:42 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37462 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753815AbbE3Thk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 15:37:40 -0400
Received: by igbsb11 with SMTP id sb11so36822212igb.0
        for <git@vger.kernel.org>; Sat, 30 May 2015 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7M+wmH62dh5Kz1rUIqFBMXEj/6tZz/hLR5FYUIrYL0A=;
        b=MMeHpm3KbQnM++TfkuW73RPjEAHS5alhXFcOTNROauNv7bKEMPyK2Pht6hj03wv+F1
         MurdRMgh4IvPNgl6KakzeU1DbJS7MK+TuNODy5/ZoESlN4OYgQ/9HgiTelY8NKFuLllx
         5dHgfmaWyA7ARkBIDRFTEtwCYge0N7Mlnvjw2dMgZUDRq+iBzxUT+n2nEmFfLpCk/2A6
         3souqsERjegiOV+wLaPk2BK5pgynB0K4qX84NZCD3nWbM7r71fPJLIfxnwiUoTpDZkcw
         h7DBQk1EX/rzv/D+9NM44Lt/DhehPloTPvrZ4tIYNgctd722iFMPxojws4hDGNzeVU/I
         xDjA==
X-Received: by 10.50.67.146 with SMTP id n18mr4399885igt.40.1433014659419;
 Sat, 30 May 2015 12:37:39 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Sat, 30 May 2015 12:37:39 -0700 (PDT)
In-Reply-To: <CAHd499B+icDskcsR7zxPfZ=8Nqwg14eb2h2LBuDx6=fnoO24AQ@mail.gmail.com>
X-Google-Sender-Auth: m545HvPijf0BmkhS1XO-fifC_2E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270304>

On Sat, May 30, 2015 at 2:19 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
> On Sat, May 30, 2015 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>
>>> In the meantime I'd like to ask, do we even need to add an option for
>>> this? What if we just make `diff.submodule log` not use
>>> --first-parent? This seems like a backward compatible change in of
>>> itself.
>>
>> Why?  People have relied on submodule-log not to include all the
>> noise coming from individual commits on side branches and instead
>> appreciated seeing only the overview by merges of side branch topics
>> being listed---why is regressing the system to inconvenience these
>> existing users "a backward compatible change"?
>
> Backward compatible in the sense that it does not break existing
> functionality. For example, removing -D from `git branch` would be a
> backward breaking change.
>
> Also not everyone has a disciplined merge-commit editing policy like
> the Linux & Git projects do. In fact (especially in corporate
> environments), most merge commit messages are useless and
> auto-generated. It's in fact very common (depending on popular
> tooling) to not have the ability to edit these messages. Example:
>
>     Merge branch "topic" into "master"
>
> This is the defacto message you get when you use Github, Atlassian
> Stash, etc. any time you merge a PR. For repositories that only accept
> changes through pull requests, it is not possible to generate a diff
> log of submodules that is useful without showing the ancestor commits
> on all parents. Right now 'log' literally gives you the following for
> a submodule that has a mainline branch that does not accept direct
> pushes (i.e. only PRs):
>
>     > Merge branch "topic1" into "master"
>     > Merge branch "topic2" into "master"
>     > Merge branch "origin/develop" into "master"
>     > Merge branch "topic3" into "master"
>
> I would argue that this situation is common -- more common than what
> you would typically see in a well groomed git repository that does not
> use PRs or always does rebase+ff-merge.
>
> That is the basis for my concern. No functionality is broken and
> cators to the common case. But I guess since we're discussing 2
> distinct workflows, it makes sense to have 2 options for viewing the
> submodule logs. Because if 'full-log' were indeed the default, it
> would cause a lot of noise in the well-disciplined-merge-commit
> workflow.
>
> From a high level (to explain my motivation for my simplified and
> arguably naive suggestion), I work with a lot of amateur users of Git.
> They always complain about using Git and how "SVN is better". Yet they
> do not accept the challenge of learning Git, which is a very
> complicated tool. Much of git I would argue is not very beginner (even
> user) friendly (although things are certainly getting better). With
> such an advanced tool, with such complex configuration and behavior,
> and given all the friction it causes, I can only do my best to offer
> seemingly sensible alternatives to adding MORE configuration.
>
> Anyway it's just a thought. Glad to get feedback and I see both sides
> of the fence on this one.
>
>>> And it's simpler to implement. I can't think of a good
>>> justification to add more settings to an already hugely complex
>>> configuration scheme for such a minor difference in behavior.
>>
>> Careful, as that argument can cut both ways.  If it is so a minor
>> difference in behaviour, perhaps we can do without not just an
>> option but a feature to omit --first-parent here.  That would be
>> even simpler to implement, as you do not have to do anything.
>>
>> So, if you think the new behaviour can help _some_ users, then you
>> would need the feature and a knob to enable it, I would think.
>
> I don't really understand your contrasted example here. Can you explain:
>
>     "...we can do without not just an option but a feature to omit
> --first-parent..."
>
> Again thanks for the feedback.

I'm having some difficulty with the tests. What it looks like is that
the test repository is created by calling test-lib.sh at the top. Then
by the time the commands after that are run, it's inside the temp
repository.

At the bottom of t4041, I add this:

    test_create_repo sm3 &&
    git add sm3 &&
    cd sm3 &&
    echo > foo.txt &&
    git add foo.txt &&
    git commit -m 'foo.txt' >/dev/null &&
    git checkout -b topic >/dev/null &&
    echo > topic.txt &&
    git add topic.txt &&
    git commit -m 'topic.txt' >/dev/null &&
    git checkout master >/dev/null &&
    git merge --no-ff --no-edit topic >/dev/null &&
    cd .. &&
    git diff --submodule=log sm3

But this does not work as I expect. How do I add a submodule and then
simulate creation of branches, commits, and merges, prior to running
code in "text_expect_success"?
