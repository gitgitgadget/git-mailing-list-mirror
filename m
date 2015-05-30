From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Sat, 30 May 2015 15:25:31 -0500
Message-ID: <CAHd499CQb0ubfRKbaKC6Ypitq4e2ChXmTpGbKDyCVv=nrsJj=g@mail.gmail.com>
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
	<xmqq382dc043.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 22:25:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YynK5-0001kd-Pc
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 22:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754462AbbE3UZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 16:25:33 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36196 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbE3UZc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 16:25:32 -0400
Received: by igbpi8 with SMTP id pi8so36808059igb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=M9abVH+Bx7VXrRiebYedbRfj3RoMLs6yAdyZh9LRJD0=;
        b=ztpCNQJDWuHtNIwOVi4QAyFQrQiQr880J+KSieYOpaLyEmlHmxfcuHBtSVL7fKv+il
         Fx685V42fXWp8AINlnfhsezXD/drQrvl88qqL3eISVnQRE2DRPfimz00jmR/nsqrUK3U
         qVFjnIfWtPwvU2g6M3lECVyaEtlunsODomXsCg+dsxBljUnwlM8M42uVWk7roDaAVNmf
         hWzzsQg4zOy8Qb/aT7wRpADEAskogOB+RGFEs0tzbwk+KciZEaBDXseMf52PlCFvUhfw
         HKpANPqLz35ruh0BZLx5cu/chcSro7xKOXN9zOkc+VPFj5yYoJOzJD4gU2zwYjkAVm0T
         V/7Q==
X-Received: by 10.107.14.193 with SMTP id 184mr17744677ioo.15.1433017531322;
 Sat, 30 May 2015 13:25:31 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Sat, 30 May 2015 13:25:31 -0700 (PDT)
In-Reply-To: <xmqq382dc043.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: gXb9bPlnnvRVyZws6onKSjnhqWw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270306>

On Sat, May 30, 2015 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> On Sat, May 30, 2015 at 12:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Robert Dailey <rcdailey.lists@gmail.com> writes:
>>>
>>>> In the meantime I'd like to ask, do we even need to add an option for
>>>> this? What if we just make `diff.submodule log` not use
>>>> --first-parent? This seems like a backward compatible change in of
>>>> itself.
>>>
>>> Why?  People have relied on submodule-log not to include all the
>>> noise coming from individual commits on side branches and instead
>>> appreciated seeing only the overview by merges of side branch topics
>>> being listed---why is regressing the system to inconvenience these
>>> existing users "a backward compatible change"?
>>
>> Backward compatible in the sense that it does not break existing
>> functionality....
>
> And adding one-line-per-commit from side branches does break
> existing functionality.  You seem to be arguing that more
> information is always good and does not break existing
> functionality, but summarizing by omitting irrelevant details *is* a
> feature.  Do you honestly believe that a change to make the full
> "log -p" output in submodule log be a "backward compatible" change??
>
>>     > Merge branch "topic1" into "master"
>>     > Merge branch "topic2" into "master"
>>     > Merge branch "origin/develop" into "master"
>>     > Merge branch "topic3" into "master"
>
> It is not a real argument; it is something you can fix by naming
> your branches more sensibly, which would make you a better developer
> regardless of how submodule-log is shown.

I just use git, I don't have the deep technical understanding of its
implementation as you may have. From my perspective I can't think of
how this breaks backward compatibility, or perhaps your definition of
backward compatibility does not align with mine.

And please don't over generalize and misconvey what I said. I am not
saying more information is always good. Did you not read anything I
wrote?

Also good branch names may help but that doesn't go into detail and
explain features that may have been sitting on a topic branch for
weeks. That's not a practical solution to the problem. Also branch
names do not determine or influence the skill and quality of a
developer, as you seem to imply.

I'll do us both a favor and end the discussion here, as I do not feel
you are being very patient or welcoming in the discussion. I sense
frustration on your side.

>>>> And it's simpler to implement. I can't think of a good
>>>> justification to add more settings to an already hugely complex
>>>> configuration scheme for such a minor difference in behavior.
>>>
>>> Careful, as that argument can cut both ways.  If it is so a minor
>>> difference in behaviour, perhaps we can do without not just an
>>> option but a feature to omit --first-parent here.  That would be
>>> even simpler to implement, as you do not have to do anything.
>>
>> I don't really understand your contrasted example here. Can you explain:
>>
>>     "...we can do without not just an option but a feature to omit
>> --first-parent..."
>
> I am not sure how to phrase that any easier. Sorry.

You mean you don't want to? That's fine, if you don't have the will or
patience to explain then I won't bother caring.

> Assuming that you consider output with and without --first-parent
> does not make much of a difference (i.e. "minor difference in
> behaviour"), instead of dropping --first-parent unconditionally,
> like you seem to be pushing with the argument, we can
> unconditionally keep the --first-parent and do not change anything.
> The end result would not make much of a difference either way, and
> not doing anything is much simpler than dropping --first-parent.
>
> Hopefully you can see how absurd that line of reasoning is.  So do
> not make the same argument to push for changing the behaviour
> unconditionally.
>
> If you think the new behaviour can help _some_ users, then you would
> need the feature and a knob to enable it.

First of all, you keep calling this an argument. Perhaps it is for
you, since you're being absurdly rude with me and impatient with the
discussion. This is a brainstorming session. My suggestions may not
seem rational or make sense, but this is natural since I am ignorant
of the finer details of the application.

You're really just overanalyzing my statements from a nonsensical
perspective. I am talking about not adding more settings to an already
complex set of settings. I am not justifying my feature. I think the
feature is just as justified as everything else. Git is FULL of tons
of little options to cater to niche workflows.

I am not fighting against having another option. In fact, that was my
idea to begin with. I am investigating and trying to discuss all
possible approaches and perspectives.

Your attitude is not very welcoming to those that wish to contribute
to the project. In fact, because of your attitude towards me, I will
kindly see myself out. I do not have time to spend my free time
dealing with this nonsense and irrational rudeness on a mailing list.

Thanks to Heiko and others that were more welcoming and kind.
