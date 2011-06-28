From: Mike <xandrani@gmail.com>
Subject: Re: Undo last commit?
Date: Tue, 28 Jun 2011 15:31:23 +0100
Message-ID: <BANLkTimZN4swfY13zMjkCbAc9UsGSix02Q@mail.gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com>
	<m31uyrutx7.fsf@localhost.localdomain>
	<20110619003718.GA5628@elie>
	<201106191237.55825.jnareb@gmail.com>
	<4DFF382A.5030206@micronengineering.it>
	<4E09DDAE.30801@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Massimo Manca <massimo.manca@micronengineering.it>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 28 16:37:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbZPv-0000Zx-6w
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 16:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab1F1OdY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 10:33:24 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49138 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758315Ab1F1ObY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2011 10:31:24 -0400
Received: by qwk3 with SMTP id 3so130885qwk.19
        for <git@vger.kernel.org>; Tue, 28 Jun 2011 07:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qsw8L4+PJbOpr3DquTN321cFmLhts4079FkXQNF6Rd4=;
        b=qyQkNLjMekl0gVvWWqs3NU8+jDjALMVXbLGsk+hsthbNZksrlng4GUiUQLH0NCXTrJ
         jhILvmXTGLjL7icaV74XKwIta5nPxrD8GzaucIBJJvL9P2vhKS5HPnBhG6tWcHlQuXtp
         IQ2DOuYqXpDEn6fRJoL+f1jqrL8olXalDN11k=
Received: by 10.229.42.73 with SMTP id r9mr5681057qce.189.1309271483337; Tue,
 28 Jun 2011 07:31:23 -0700 (PDT)
Received: by 10.229.39.78 with HTTP; Tue, 28 Jun 2011 07:31:23 -0700 (PDT)
In-Reply-To: <4E09DDAE.30801@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176401>

I've created a 'wrapper' for git which stops me from making dumb
mistakes, it is working really well so far. I will add your ideas to
it... thanks!

I do think that git needs polishing in this way. It was designed by a
very intelligent programmer... however they can sometimes be the worst
at user interface design. I think a lot of people are missing out on
how great git is because of the learning curve, and also the slightly
odd naming conventions.

"git reset --soft HEAD^" can't be picked up that quickly by a
beginner, but git uncommit would be obvious! So I have to agree with
Holger. Good design makes something intuitive. I have used DVD
recorder / players that are so badly designed that I needed to read
the instruction manual. Something complicated can be designed to such
a degree that people rarely have to read a manual, and they can pick
it up really quickly because it's obvious. If you disagree then you
might need to learn something about good design because what I say
isn't opinion it's a fact. Flame away :)

Apologies for stereotyping!

On 28 June 2011 14:57, Holger Hellmuth <hellmuth@ira.uka.de> wrote:
> Let me play devils advocate:
> Wouldn't it be nice to have a command 'git uncommit' (in core git) th=
at
> would be an alias to "git reset --keep HEAD^" ? And if not already do=
ne, it
> should hint at "git reset --soft HEAD^" in case of failure because of
> conflicts.
>
> It would be a nice companion to the not-yet-realized "git unadd" ;-)
>
> Holger.
>
>
> On 20.06.2011 14:08, Massimo Manca wrote:
>>
>> Hello,
>> I several times made the mistake of a wrong commit also if generally=
 the
>> error born for a wrong add expecially:
>>
>> git add . in a directory with some files that haven't to be managed =
by
>> git.
>>
>> So, as wrote in some emails here, if I wrote something like:
>> git commit -m "Added file.c" -a
>>
>> I tryed to solve with:
>> git commit --amend -m "Added file.c" -a
>>
>> hoping to have a status like before the commit and then sending:
>> git reset .
>>
>> hoping to have a status like that before the wrong add.
>> But this is not what git status say so, my solution to solve commi
>> problems is ALWAYS:
>>
>> git reset --soft HEAD^
>>
>> that for my point of view works better then all others permitting to
>> redo last add and commit to solve not only a -m problem but also a w=
rong
>> git add command.
>>
>> Il 19/06/2011 12.37, Jakub Narebski ha scritto:
>>>
>>> On Sun, 19 Jun 2011, Jonathan Nieder wrote:
>>>>
>>>> Jakub Narebski wrote:
>>>>>
>>>>> Mike<xandrani@gmail.com> =A0writes:
>>>>>>
>>>>>> % git reset --hard HEAD~1
>>>>>
>>>>> Errr... here you screwed up. =A0This reset state of you working a=
rea to
>>>>> the state at last commit, removing all your changes to tracked fi=
les.
>>>>
>>>> Or rather, here we screwed up. =A0Jakub and others gave some usefu=
l
>>>> advice about how to recover, so let's consider how the UI or
>>>> documentation could be improved to prevent it from happening again=
=2E
>>>>
>>>> * In this example if I understand correctly then the index contain=
ed
>>>> =A0 some useful information, perhaps about a larger commit intende=
d for
>>>> =A0 later. =A0To preserve that, you could have used
>>>>
>>>> =A0 =A0 =A0 =A0git reset --soft HEAD~1
>>>>
>>>> =A0 which would _just_ undo the effect of "git commit", leaving th=
e index
>>>> =A0 and worktree alone.
>>>
>>> Another issue is that Mike haven't realized that `--amend' option c=
an be
>>> used *in combination* with other "git commit" options, which means =
that
>>> the solution to his problem was using "git commit" as it should hav=
e
>>> been done, but with '--amend' added.
>>>
>>> I'm not sure if git documentation talks about 'git reset --soft HEA=
D^',
>>> and when to use it; from what I remember it encourages use of
>>> 'git commit --amend' instead (which was I guess most often used rea=
son
>>> of using soft reset before there was '--amend').
>>>
>>>> * Another situation that comes up from time to time is making a ch=
ange
>>>> =A0 that just turned out to be a bad idea. =A0After commiting it, =
you might
>>>> =A0 want to discard the erroneous change, like so:
>>>>
>>>> =A0 =A0 =A0 =A0git reset --keep HEAD~1
>>>>
>>>> =A0 The "--keep" option uses some safeguards to make sure that onl=
y the
>>>> =A0 committed change gets discarded, instead of clobbering local c=
hanges
>>>> =A0 at the same time.
>>>>
>>>> * In the early days of git, the "--keep" option did not exist. =A0=
So a lot
>>>> =A0 of old documentation recommends to do
>>>>
>>>> =A0 =A0 =A0 =A0git reset --hard HEAD~1
>>>>
>>>> =A0 which is the same if you don't have any local changes.
>>>
>>> Yes, it would be good idea to examine git documentation (tutorials,
>>> user's manual, manpages, perhaps "Git Community Book" and "Pro Git"
>>> too) to encourage use of new safer options of hard reset, namely
>>> '--keep' and '--merge' instead of '--hard'.
>>>
>>
>
>
