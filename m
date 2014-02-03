From: David Kastrup <dak@gnu.org>
Subject: Re: A few contributor's questions
Date: Mon, 03 Feb 2014 18:35:22 +0100
Message-ID: <87vbwwxfol.fsf@fencepost.gnu.org>
References: <8738k44808.fsf@fencepost.gnu.org> <52EFC551.8030203@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Feb 03 18:35:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WANQo-0001La-Ih
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 18:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbaBCRfZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 12:35:25 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:55745 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbaBCRfX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Feb 2014 12:35:23 -0500
Received: from localhost ([127.0.0.1]:54787 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WANQY-0001cK-JD; Mon, 03 Feb 2014 12:35:22 -0500
Received: by lola (Postfix, from userid 1000)
	id 291CEE09B1; Mon,  3 Feb 2014 18:35:22 +0100 (CET)
In-Reply-To: <52EFC551.8030203@op5.se> (Andreas Ericsson's message of "Mon, 03
	Feb 2014 17:35:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241441>

Andreas Ericsson <ae@op5.se> writes:

> On 2014-01-31 14:04, David Kastrup wrote:
>>=20
>> I'm still in the process of finishing the rewrite of the builtin/bla=
me.c
>> internals.  Now there are various questions regarding the final patc=
h
>> proposals and commit messages.
>>=20
>> Point 1) signing off implies that I'm fine with the licensing of the
>> file. builtin/blame.c merely states
>>=20
>> /*
>>  * Blame
>>  *
>>  * Copyright (c) 2006, Junio C Hamano
>>  */
>>=20
>> which obviously will not match the authorship of my contributions.
>> Since Junio has given blanket permission to reuse his Git contributi=
ons
>> under other licenses (see
>> <URL:https://github.com/libgit2/libgit2/blob/development/git.git-aut=
hors#L58>)
>> that I am not going to license my work under, the first commit in th=
e
>> respective series would replace this header with
>
> It's a long time since I wrote that document.
>
> Does this mean you're not willing to relicense your contributions wit=
h
> the license used by libgit2? That's what the document is supposed to
> mean and it's what I asked on the mailing list when requesting
> permission.

I make a living from writing Free Software.  It should hardly come as a
surprise that I will not hand libgit2 users like Microsoft or GitHub
software for unrestricted use in proprietary products without getting
recompensated.  They make money from their products without sharing
their code back.

So I'm not going to relicense my work under the libgit2 license
_without_ _recompensation_, for use by companies that don't license
their work without recompensation.  It would be grossly unfair towards
those people who actually pay me for writing GPLed software (mostly GNU
LilyPond).  Of course I regularly report what I worked on, and I expect
a temporary drop in my funding corresponding to the lack of
LilyPond-related activities.  So there is an actual cost for me to bear=
,
and I=A0will not bear it myself in order to support proprietary
derivatives.

So the price tag for letting the finished git-blame work (I've found a
few more optimizations making it more worthwhile) get relicensed under
the libgit2 licensing scheme would be in the order of =A410000.  It wou=
ld
take a rather good salaried programmer to reproduce what I'm doing righ=
t
now for the same price tag, and since my work will be available in Git
proper under the GPLv2 before anybody has to make any decision, there i=
s
no uncertainty about exactly what people will be getting.

If there is going to be significant use of the git-blame functionality
by libgit2, I claim that the gain in efficiency (and programming time)
would more than offset the cost.

And if there isn't going to be significant use of that functionality,
it's not important whether it's in libgit2 or not.

> The libgit2 license used as of today is still the license that people
> agreed to relicense their contributions under. It can be found here:
> https://github.com/libgit2/libgit2/blob/development/.HEADER

That's actually the license on some files.  The overall license
statement in
<URL:https://github.com/libgit2/libgit2/blob/development/COPYING>
suggests that the libgit2 code base encompasses quite more components.
Some of those are mentioned as being licensed under the Apache 2.0
license, incompatible to GPLv2 according to
<URL:https://www.apache.org/licenses/GPL-compatibility.html>.  Since th=
e
GPL requires licensing of a work _as_ _a_ _whole_, it's not really all
too obvious to me whether any part but the linking/unmodified-binary
exception will actually be effective.

But that's pure speculation on my part (I am obviously not a lawyer) an=
d
no skin off my nose if somebody wants to invest the price for releasing
under whatever licensing scheme libgit2 happens to use.  If libgit2 or =
a
variant of it reverts to unmodified GPLv2 (or later) at any point of
time, they are free to just take what is there without having to
negotiate with me (or anybody else), anyway.

And of course, calling the git executable and letting it do the work
will also remain an option.  That's likely what the simple git web
services do anyway.  "git blame" is usually disabled in web interfaces
for performance reasons, and I'm afraid that even a factor of 3--4 in
speed (which is what I'm getting with uglier real-world cases) is not
going to change that.

> I'm mostly adding it here for the sake of clarity in case people find
> this in the future and wonder what all the fuzz was about.

It's probably easy to notice that I can make a lot of fuzz about small
things.  It's probably less annoying when I do it in code rather than i=
n
prose...

--=20
David Kastrup
