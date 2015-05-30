From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Sat, 30 May 2015 12:54:20 -0700
Message-ID: <xmqq382dc043.fsf@gitster.dls.corp.google.com>
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
	<20150521125122.GA22553@book.hvoigt.net> <55691DE3.70200@gmail.com>
	<xmqqbnh2ateo.fsf@gitster.dls.corp.google.com>
	<CAHd499B+icDskcsR7zxPfZ=8Nqwg14eb2h2LBuDx6=fnoO24AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 21:54:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yympy-0007NR-G9
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 21:54:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757088AbbE3Ty0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 15:54:26 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34407 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754790AbbE3TyY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 15:54:24 -0400
Received: by igbhj9 with SMTP id hj9so36945307igb.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 12:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=skb2LkB5ic4D++9uny9SuUY+RYx94C7RREgOVzS75Y4=;
        b=O6owhl+7wyOA1Vw3JKwrdiUCwh3BLfFFbM7bcnwI20lfbjDl+5vYr1jB+oQ4MgUung
         W1+Vfnaju0Y5GeD+AcZL3HpRChvNFW+iZUSJz4ntZt9nWwBx+kEtGUGFNFxBHv4mAjRv
         tSI90+w8zmXvn3jDUiNX1ecgI2hPsQCNOjmpMlFOwnOj4Em7COdK0YLAy0L8sm4cIt+4
         gP/BByfL9jYs+1QG1VeYFhRbRujNZADl+kVBc6rfCAee6OVB5uKK3oDhm3JhmECHPx2x
         k2WM9Whkr0rQ2zYp41o5P2lX4vEByA5DhY36cO9fv8L7PmxOPRKNc2izheeL5SzOzyQF
         KC1w==
X-Received: by 10.43.139.6 with SMTP id iu6mr3975334icc.32.1433015662556;
        Sat, 30 May 2015 12:54:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3d1d:5ddf:1454:826b])
        by mx.google.com with ESMTPSA id b8sm6922431ioe.23.2015.05.30.12.54.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 30 May 2015 12:54:21 -0700 (PDT)
In-Reply-To: <CAHd499B+icDskcsR7zxPfZ=8Nqwg14eb2h2LBuDx6=fnoO24AQ@mail.gmail.com>
	(Robert Dailey's message of "Sat, 30 May 2015 14:19:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270305>

Robert Dailey <rcdailey.lists@gmail.com> writes:

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
> functionality....

And adding one-line-per-commit from side branches does break
existing functionality.  You seem to be arguing that more
information is always good and does not break existing
functionality, but summarizing by omitting irrelevant details *is* a
feature.  Do you honestly believe that a change to make the full
"log -p" output in submodule log be a "backward compatible" change??

>     > Merge branch "topic1" into "master"
>     > Merge branch "topic2" into "master"
>     > Merge branch "origin/develop" into "master"
>     > Merge branch "topic3" into "master"

It is not a real argument; it is something you can fix by naming
your branches more sensibly, which would make you a better developer
regardless of how submodule-log is shown.

>>> And it's simpler to implement. I can't think of a good
>>> justification to add more settings to an already hugely complex
>>> configuration scheme for such a minor difference in behavior.
>>
>> Careful, as that argument can cut both ways.  If it is so a minor
>> difference in behaviour, perhaps we can do without not just an
>> option but a feature to omit --first-parent here.  That would be
>> even simpler to implement, as you do not have to do anything.
>
> I don't really understand your contrasted example here. Can you explain:
>
>     "...we can do without not just an option but a feature to omit
> --first-parent..."

I am not sure how to phrase that any easier. Sorry.

Assuming that you consider output with and without --first-parent
does not make much of a difference (i.e. "minor difference in
behaviour"), instead of dropping --first-parent unconditionally,
like you seem to be pushing with the argument, we can
unconditionally keep the --first-parent and do not change anything.
The end result would not make much of a difference either way, and
not doing anything is much simpler than dropping --first-parent.

Hopefully you can see how absurd that line of reasoning is.  So do
not make the same argument to push for changing the behaviour
unconditionally.

If you think the new behaviour can help _some_ users, then you would
need the feature and a knob to enable it.
