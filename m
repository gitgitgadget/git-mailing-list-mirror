From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH] push: start warning upcoming default change for push.default
Date: Wed, 14 Mar 2012 10:07:41 +0100
Message-ID: <vpqhaxrzh2a.fsf@bauges.imag.fr>
References: <vpqobs65gfc.fsf@bauges.imag.fr>
	<1331281886-11667-1-git-send-email-Matthieu.Moy@imag.fr>
	<1331288715.21444.38.camel@beez.lab.cmartin.tk>
	<4F5A4C45.7070406@xiplink.com> <4F5AF1A8.4050604@alum.mit.edu>
	<4F5E12A5.6030701@xiplink.com> <vpqzkblixmb.fsf@bauges.imag.fr>
	<20120312183725.GA2187@sigill.intra.peff.net>
	<vpqy5r44zg7.fsf@bauges.imag.fr>
	<CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, gitster@pobox.com
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:08:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7kBy-0003pf-EH
	for gcvg-git-2@plane.gmane.org; Wed, 14 Mar 2012 10:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435Ab2CNJIS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Mar 2012 05:08:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35815 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416Ab2CNJIP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 05:08:15 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2E93GPS009709
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 14 Mar 2012 10:03:17 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1S7kBK-0002fv-G5; Wed, 14 Mar 2012 10:07:42 +0100
In-Reply-To: <CAHkcotg1FKxfMR4Fe9Xfo_i4nuxzXdfVWe80HZu0wQEkiXhhmA@mail.gmail.com>
	(Dmitry Potapov's message of "Tue, 13 Mar 2012 21:08:52 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 14 Mar 2012 10:03:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2E93GPS009709
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1332320598.39388@0/NXWaHk8EVCC2CX4tES1w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193090>

Dmitry Potapov <dpotapov@gmail.com> writes:

> On Tue, Mar 13, 2012 at 1:34 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> =A0 1. If you are a new user who does like the implicit merge, you =
may
>>> =A0 =A0 =A0find it convenient not to have to learn about "git check=
out; git
>>> =A0 =A0 =A0merge topic ; git push remote master". But it only helps=
 you
>>> =A0 =A0 =A0_sometimes_. If master has had other work built on it, y=
our push
>>> =A0 =A0 =A0will fail, and you will have to do the merge yourself. S=
o it is
>>> =A0 =A0 =A0only helping you by omitting a step some of the time, an=
d you still
>>> =A0 =A0 =A0have to learn why the step is sometimes necessary and so=
metimes
>>> =A0 =A0 =A0not.
>>
>> There's a rule of thumb which works very well for beginners: when "g=
it
>> push" tells you to pull before, then pull before. This rule of thumb
>> works, but only provided "push" and "pull" are symmetrical.
>
> I am not sure what you mean by symmetrical here, because they are nev=
er
> truly symmetrical as "pull" does merge and "push" does not.

I mean "they work with the same branch".

> If there is a centralized workflow with only one branch then
> everything is simple, but it is not so with other workflows.

I don't get this. With either 'current' or 'upstream', both pull and
push deal with one local and one remote branch. The only asymetry is th=
e
case of non-fast forward (push fails, pull merges). But it's all about
transmitting changes from a branch to another, in one or another
direction.

> Moreover, doing 'git pull' too often (unless it is 'git pull --rebase=
)
> pollutes history with useless merges, making more difficult to review
> changes, or doing git-bisect.

What's your point here? How does it invalidate the rule of thumb above?

Whether you want to pull often or not, it does not change the fact that
you cannot do non-fast forward push (at least, not without losing
history). If the user tried to push, what would you suggest if not
pulling (or merging in whatever way you want)? Blame the user who wante=
d
to push that he shouldn't have tried that?

> I agree that the current diagnostic is not suitable for beginners.
> Not-fast-forward push is something that beginners should never use,
> but from this message is not clear what is the alternative to forcing
> non-fast-forward push.

Again, what would you suggest? Teach --force to beginners?

>> One can easily get in this situation even in a kernel-style workflow=
:
>> work from your desktop, push, work from your laptop, try to push and=
 it
>> fails.
>
> IMHO, when you often switch between your desktop and laptop, 'matchin=
g'
> makes much more sense.

Then, if you worked on branch 'foo' from your desktop, and 'bar' on you=
r
laptop, you'll get errors about non-fast forward push from both machine=
s.

> If 'push' fails then usually I want to force non- fast-forward push,
> because the new series contain reworked patches that already were on
> the other computer.

=2E.. but if they were not, you've just silently errased your previous
work. I have no problem with you working like this, but please don't
teach that to beginners.

>> but the not-so-newbies may get this once they start
>> creating branches ifever they have HEAD =3D topic-branch and upstrea=
m =3D
>> origin/master for example.
>
> The real question is what one expects from 'push' in that situation. =
It
> could be pushing this branch back to the upstream branch or creating =
a
> new feature branch in the upstream.

Yes. But both of them are covered by 'push.default=3Dupstream', dependi=
ng
on how you configured the upstream.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
