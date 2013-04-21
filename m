From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [QUERY] Why do we have git-completion.zsh?
Date: Sun, 21 Apr 2013 01:21:19 -0500
Message-ID: <CAMP44s0e=RTC_-JeFXxrdQ9Zhe8riqWKwdeae6rgwJccr_=7iA@mail.gmail.com>
References: <CALkWK0=NrJ-9mxSkOBw=kJ0CTJLUFNWBoGdqGcHEU6YqR-foFg@mail.gmail.com>
	<20130420184539.GA8586@elie.Belkin>
	<20130420185329.GB8586@elie.Belkin>
	<CAMP44s3yCW-pHVHc9WfL1BC7BKmnXxZ1WQyPRAMnx967=74_Kg@mail.gmail.com>
	<CALkWK0=ay452TbW-O+uBwqqMjLgeYw0V-j67vvzMqtVO-PnrXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:21:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTnec-00053z-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3DUGVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:21:24 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35182 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684Ab3DUGVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:21:23 -0400
Received: by mail-la0-f50.google.com with SMTP id el20so4603000lab.37
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 23:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=aM18rqIeBGC+4bloe6R/mOMSaanuA/QqKno5VTuppLk=;
        b=R3kcDNYMiiJNF3yhVWn07qbSUPoseM1lfwa1xLNO5A2WvL8yrLpwlwQTjyJ0cwt9W9
         B+1Rvu6+uJwwKvRp4wy3eN7jyPxX4Y0Mst+IP9lxYzkGSgTUBaXRohqdd4fMIfLMbPcL
         oIhbkF0CDcd9dIOPE2uh9dp4VfGRbfCtjsI4nQGvbIK50WngInQW5ok4kRVEYR7UB+r1
         /AFiPOocsaxUTFbpgpp+qx3DPkMtfWEr2GK44QRVR8BCsZHFPHJq8t92BSWQd3hXvgER
         a/g6Hl4YSWK7OfNVRRfzuGeHUC2x4WmqziMviA/aMptPHsNGw/6YWWw6tfL5Z/Wzxti3
         iWmw==
X-Received: by 10.112.22.198 with SMTP id g6mr6899439lbf.135.1366525279733;
 Sat, 20 Apr 2013 23:21:19 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 20 Apr 2013 23:21:19 -0700 (PDT)
In-Reply-To: <CALkWK0=ay452TbW-O+uBwqqMjLgeYw0V-j67vvzMqtVO-PnrXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221894>

On Sat, Apr 20, 2013 at 11:36 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> To complement the reason; the zsh folks (or perhaps it's only one; who
>> works on the git stuff), absolutely prioritize "correctness" over
>> speed, that means if it takes ten seconds to list all the possible
>> files to complete, grouped nicely, that's exactly what they'll do,
>> instead of the way the bash completion does, which lists the most
>> likely files, which takes milliseconds.
>
> I see.  Yes, I was looking for a reason like this.
>
> True.  I've noticed that my shell just hangs when I attempt to
> tab-complete too early/ something wrong, and this would be nice to
> fix.  Does it have to be a hard trade-off between correctness and
> speed?  Is it not possible to reach a fair compromise?

It doesn't matter, the zsh folks don't want *any* compromise:
http://article.gmane.org/gmane.comp.shells.zsh.devel/22475

> Now, I don't know anything about zsh's git completer versus the
> gitfast completer.  From a glance, it looks like zsh's git completer
> is much larger and stuffed with features that the gitfast completer
> doesn't have.  Although I agree that speed isn't the only parameter,
> can you shed some light on how these two compare on other parameters?

First of all, 'gitfast' is just the name I gave to the oh-my-zsh
plugin that uses git.git's completion stuff. The zsh support in git's
bash completion has been working for years, I just copied the stuff to
oh-my-zsh so those guys can use it easily. I also added my thin zsh
wrapper, because of issues with zsh's bash completion emulation, but
that's not specific to oh-my-zsh in any way.

Secondly, I don't see what "features" zsh's git completer might have
that we don't. Yes, some specific argument behaviors are nice, like
adding a '=' after --git-dir, and then complete only directories, and
completion descriptions, along with tag groupings, but all those
things are cosmetic, and they could be added relatively easy to my
thin wrapper (which wouldn't be so thin after all). It's mostly grunt
work, not something that requires a great mind.

Functionally I don't see any value.

For example, a difference is that when you do 'git show v<tab>',
git.git bash's completion will show refs, and only if there aren't any
that could match, show files, any files. zsh's version will show both
files and refs at the same time, and if you have grouping enabled they
would show that way, in the git.git repo I see them grouped in commit
tag, tag, 'cached file' (although showing tags twice is probably a
bug), and only the files present in the repository.

Another one is that when you do 'git add <tab>', you see the results
grouped for example in 'modified file', 'untracked file', whereas in
bash they can't be grouped.

Are these minor features worth all this slowness and complicated code?
I don't think so.

Also, the grouping requires a configuration like:
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' group-name ''

And I bet most people don't have such configuration. So all this
complicated code achieves nothing for the majority of users.

The reason why I prefer git.git's bash completion is that it has taken
years to develop, and using good development practices, borrowed from
the mainline git process. Many more people use them, have debugged
them through the years, and optimized them. It's relatively small
(compared to zsh's version), much more readable, and it even has tests
(which I helped to start), and it's much less buggy. It's basically
rock solid.

Just now I was reading about a bug in zsh-workers when you do 'git
show v3<tab>' in the Linux kernel git tree, and you can count the
seconds before it completes. This is the sort of thing that just
doesn't happen with git's bash completion.

> Or you could help me figure all this out myself.  How do I
> profile/debug shell code?  I'm feeling a little lost without gdb and
> valgrind.

For git.git's bash completion I just run a script that exercises the
function I'm interested in with perf. Fortunately nothing there is
really slow, so I don't have to track offenders (usually).

Unfortunately zsh's completion stuff can't be scripted, or at least I
haven't managed to find a way to either profile or write tests for any
of that code.

>> If they wanted my contributions, that would be awesome, but that
>> doesn't appear to be the case. And I'm kind of relieved, because zsh's
>> completion is monstrous code, and the zsh development practices are
>> not good (e.g. all my logically independent patches get squashed into
>> one commit).
>
> I see.  I've just started poking them with patches.  I'll see what
> happens for myself.

Yeah, I did contribute patches myself too. As long as they are
superficial, like adding a missing argument or so, they are fine. But
don't try messing with their precious "completeness".

Cheers.

-- 
Felipe Contreras
