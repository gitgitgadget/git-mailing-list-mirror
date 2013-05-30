From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [git-users] Highlevel (but simple to implement) commands provided
 by default for git
Date: Wed, 29 May 2013 21:48:05 -0500
Message-ID: <CAMP44s313TM_5=DGax4PfyiNf_eoWgf8Ls1g5h_uZ6_j3-2b=g@mail.gmail.com>
References: <f611150e-a12a-47f6-97f0-8aaff3045338@googlegroups.com>
	<CAJri6_tm=tk6L1DT=A_BB25jm7b+2Uniw1uSCGtrY5_8X=t_hw@mail.gmail.com>
	<CALkWK0k8GkFYNkoGH4YCgmWtSR5rgFSG0dU9Aw2CO_arvuzKxQ@mail.gmail.com>
	<CAMP44s1VFxarV4Gp5KsxhFKJbmd033-DW8koe9P4XUZQcX4mrA@mail.gmail.com>
	<CALkWK0=Sn2myT3QPCWJnoxKH4hm4s7MaB=UrPixP87MFSwKoug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Br=C3=A1ulio_Bhavamitra?= <brauliobo@gmail.com>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 04:48:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhsuT-0003jj-93
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 04:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967321Ab3E3CsJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 May 2013 22:48:09 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:50425 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978Ab3E3CsH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 May 2013 22:48:07 -0400
Received: by mail-lb0-f182.google.com with SMTP id z5so68948lbh.27
        for <git@vger.kernel.org>; Wed, 29 May 2013 19:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=sPZpGe63x4bmb+fywdTnMT14g8L3tNT1wS0H2xvh3d4=;
        b=AuUWSd+zxkbF9X6fdYoojj0Ngm/OcJk2c3Mffif/VJCYxiv3HtSiLb0Sr3xUJnv6gA
         etoUgAfGVNeiIpLfz3aRJkQKNo2qzTDBIncw3ZMIqIkYrf/54HqCW3unJSNQecieSE1O
         eqNkgagTWDtCeDTlRGPLKw7VdLfAHqO4lPRBLcX+H7SgeR4HKEl8tD8V/WnLKCdxL6W8
         UIM3tUH1R36mwfCdJ+lzzDcpWqfrEzSZFSJD32R+Ik2MMAQwGVTwfMrG9cbYJfl2rdbs
         JaabDdqq/qtB+ARK9bSHW/SNqVY1SwfSQ9hLXgywNb+4SH39kf5sig2M98weRaSdNpjt
         hFGw==
X-Received: by 10.112.158.71 with SMTP id ws7mr2710385lbb.49.1369882085279;
 Wed, 29 May 2013 19:48:05 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 19:48:05 -0700 (PDT)
In-Reply-To: <CALkWK0=Sn2myT3QPCWJnoxKH4hm4s7MaB=UrPixP87MFSwKoug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225913>

On Wed, May 29, 2013 at 3:00 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, May 29, 2013 at 1:26 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> Br=C3=A1ulio Bhavamitra wrote:
>>>>   root =3D rev-parse --show-toplevel
>>>
>>> What is your usecase for this?
>>
>> Some Git commands expect to be in the top level directory (e.g. git =
blame).
>
> Um, git blame revert.c when in builtin/ works for me: what am I missi=
ng?

I meant 'git bisect', but 'git blame' has a similar issue if it's
receiving it's arguments from other git commands.

>>>>  out =3D !git fetch `git upstream-remote` && git l `git upstream`.=
=2EHEAD
>>>
>>> I didn't understand this at all.  What are you doing?
>>
>> Finding out what changes haven't been pushed out yet?
>
> ... but why would I want to club a slow network operation with
> something like log?  Yeah, I use git log @{u}.. all the time.

Then we would be out-of-date all the time.

>>>>  in =3D pull --dry-run
>>>
>>> Why?
>>
>> Because it's very easy to mess things up with 'git pull'. This
>> probably wouldn't be needed if we change the default of 'git pull' t=
o
>> barf when the changes are not a fast-forward, and print a message
>> suggesting to either merge or rebase, as it has been suggested.
>
> Yeah, I saw that thread and I think shipping "sane" defaults is a los=
t
> cause.  I really want to make pull more useable, but by making it mor=
e
> configurable.

Sane defaults still make sense, and still will happen, sooner or later.

In the meantime 'pull --dry-run' makes sense.

>>>>  unmerged =3D !git ls-files --unmerged | cut -f2 | uniq
>>>>  untracked =3D ls-files --other --exclude-standard
>>>>  staged =3D ls-files --staged
>>>>  modified =3D ls-files --modified
>>>>  deleted =3D ls-files --deleted
>>>
>>> What is wrong with git status showing a unified output?
>>
>> It's not easy to be used in "scripts", say, 'gvim -p $(git unmerged)=
'.
>
> RIght, but we shouldn't ship anything "pretty" for scripts, otherwise
> it'll become hard to understand them.

Not at all. The user is specifically asking for unmerged files, a
straight-forward list is easier to understand that a list with a bunch
of other stuff the user is not interested in, where the user has to
manually browse with his eyes until he finds the section he is
interested in.

Your argument is akin to saying that 'ls foo' doesn't make sense,
because the user can see 'foo' when he does 'ls'. That defeats the
whole notion of letting the user query what he is looking for.

>>>>   head =3D !git l -1
>>>
>>> What is git l again?
>>
>> 'git log', of course.
>
> I use 'git show' all the time.

Even more characters to type.

>>>>  current =3D rev-parse --abbrev-ref HEAD
>>>
>>> Why don't you use a prompt?  Use the one in contrib/completion/git-=
prompt.sh.
>>
>> While this is probably a good idea, not everybody has a prompt
>> configured. Imagine ssh'ing to a machine you haven't touched before,
>> or shouldn't configure. Sure, right now you need to configure it
>> anyway, but the whole proposal is to make these default aliases.
>
> Like I said earlier, I'm really not interested in sane defaults: I
> don't think all of us can agree on one thing.

This is not a matter of "us" (developers) agreeing, it's a matter of
the vast majority of *users* suffering.

If you are not interested in them, then don't distract us that do.

>> In Mercurial 'hg branch' shows only the current branch, and I think
>> that's more appropriate.
>>
>> Before I configured my prompt, 'git branch' was by far the command I
>> used the most.
>
> Yeah, we're fixing 'git branch' (by making it more configurable): the
> topic is in progress.

This is about the default. 'git branch' doesn't do what it should *by
default*, so 'git current' makes sense in the meantime.

--=20
=46elipe Contreras
