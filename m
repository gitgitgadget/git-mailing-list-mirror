From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/9 v4] bisect: add "git bisect replace" subcommand
Date: Sat, 15 Nov 2008 15:19:27 +0100
Message-ID: <200811151519.27426.chriscool@tuxfamily.org>
References: <20081111063904.7da4df94.chriscool@tuxfamily.org> <200811141034.06282.chriscool@tuxfamily.org> <491D4D02.6080004@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jeff Garzik <jeff@garzik.org>,
	David Miller <davem@davemloft.net>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 15:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1M28-0001Wf-R1
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 15:21:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589AbYKOORY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2008 09:17:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbYKOORY
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 09:17:24 -0500
Received: from smtp7-g19.free.fr ([212.27.42.64]:47519 "EHLO smtp7-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755556AbYKOORY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Nov 2008 09:17:24 -0500
Received: from smtp7-g19.free.fr (localhost [127.0.0.1])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 63D09B0150;
	Sat, 15 Nov 2008 15:17:19 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp7-g19.free.fr (Postfix) with ESMTP id 5EC2DB0138;
	Sat, 15 Nov 2008 15:17:18 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <491D4D02.6080004@gnu.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101069>

Le vendredi 14 novembre 2008, Paolo Bonzini a =E9crit :
> >> users could also set up a few
> >> special bisect/set-debug-to-1, bisect/remove-cflags-o2 and so on
> >> patches that you could use for purposes other than ensuring known =
bugs
> >> are fixed.
> >
> > In this case it is similar to Junio's proposal. But I think that fo=
r
> > changes like set-debug-to-1 and remove-cflags-o2, using the right m=
ake
> > command should be enough.
>
> Yeah, I couldn't think of a better usecase, but you got the idea.
>
> >> Finally, you could have a [bisect] configuration section with entr=
ies
> >> like "cherry-pick =3D BROKEN-SHA1 FIX-SHA1" and "git bisect" would=
 apply
> >> FIX-SHA1 automatically if the bisect tip were in
> >> BROKEN-SHA1..FIX-SHA1.
> >
> > Yes, but how do you share this between members of a team?
>
> That's a common problem with stuff that goes in .gitconfig.  It does =
not
> belong in the repository, though...

Why?

Git encourages people to develop by creating many branches of commits,=20
working on them and sharing them, and that seems to work very well. So =
I=20
really don't understand why _the hell_ people using bisect could not al=
so=20
benefit of from creating patched up branches, sharing them, bisecting o=
n=20
them.

Especially as, in my patch series, it does not in _any way_ change anyt=
hing=20
for people who just don't want to use patched up branches. They just ne=
ed=20
to not download any "bisect-replace-*" branch, or we can even implement=
 a=20
config option "bisect.useReplaceBranches" that default to "no" if that =
is=20
such a big threat to them.

I agree that the name of the branches "bisect-replace-*" may not be the=
 best=20
or that using special refs in "refs/replace/" might be better (except t=
hat=20
these refs should have in my opinion a special namespace to be easily=20
distinguished from others), but I don't think _at all_ that this should=
 be=20
enough to discard the whole idea (and implementation but that's another=
=20
story).

Or is there a god command I don't know about that says:

Thou shall not use patched up branches to bisect!
Thou shall bisect painfully!

Regards,
Christian.
