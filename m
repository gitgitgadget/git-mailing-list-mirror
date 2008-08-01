From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: email address handling
Date: Fri, 1 Aug 2008 16:16:39 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808011608150.6819@nehalem.linux-foundation.org>
References: <alpine.LFD.1.10.0808011229400.3277@nehalem.linux-foundation.org> <20080801124550.26b9efc0.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011253580.3277@nehalem.linux-foundation.org> <20080801131127.20b3acfd.akpm@linux-foundation.org>
 <alpine.LFD.1.10.0808011316050.3277@nehalem.linux-foundation.org> <20080801132415.0b0314e4.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011335230.3277@nehalem.linux-foundation.org> <20080801135421.5ca0f6af.akpm@linux-foundation.org>
 <7vvdykqub6.fsf@gitster.siamese.dyndns.org> <20080801145804.85041bbd.akpm@linux-foundation.org> <20080801221539.GA8617@mit.edu> <20080801152720.56dbff09.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011534260.6819@nehalem.linux-foundation.org>
 <20080801154902.c60717e5.akpm@linux-foundation.org> <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 01:19:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP3tr-0003c1-Ly
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 01:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbYHAXRi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2008 19:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYHAXRi
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 19:17:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51858 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751143AbYHAXRh (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2008 19:17:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71NGe2R016845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 1 Aug 2008 16:16:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m71NGdKv009293;
	Fri, 1 Aug 2008 16:16:39 -0700
In-Reply-To: <alpine.LFD.1.10.0808011554350.6819@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.411 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91124>



On Fri, 1 Aug 2008, Linus Torvalds wrote:
>
> That's my argument here. Life is tough.  Not everthing is going to be=
=20
> easy. Your solution would "work", but it would be a horrid piece of c=
rap.

=2E.and I really think that the

	"=3D?utf-8?q?S=3D2E=3DC3=3D87a=3DC4=3D9Flar?=3D Onur" <caglar@pardus.o=
rg.tr>

example should be the one that makes you say "Ok, you're right".

The undeniable fact is, if we kept things in that format, even your bro=
ken=20
mailer wouldn't have corrupted it. You could cut-and-paste things, and=20
they's show up correctly at the other end, regardless of whether the=20
problem is with your mailer or with the cut-and-paste, or anything else=
=2E

So clearly, "=3D?utf-8?q?S=3D2E=3DC3=3D87a=3DC4=3D9Flar?=3D Onur" _must=
_ be the superior=20
format that git should have used, no?

Because clearly that is the most automation-friendly thing that _never_=
=20
requires anybody to think at all, and you can cut-and-paste it between=20
programs without ever having to worry about anything at all. No special=
=20
characters, no special meanings, no need to worry about limitations of=20
implementation.

So the fact that git completely FUCKS IT UP, and when you do 'git log' =
git=20
will have corrupted this to

	Author: S.=C3=87a=C4=9Flar Onur <caglar@pardus.org.tr>

is clearly git doing the wrong thing. Right?

WRONG.

The fact is, git does the right thing. And yes, it means that you canno=
t=20
just blindly cut-and-paste. And yes, it means that your mailer actually=
=20
has to work right for you to even -see- the right email address. And ye=
s,=20
it means that any number of things can screw up, and corrupt it.

But it is STILL the right thing. Because what matters more than your=20
ability to cut-and-paste or anything like that is  the fact that we sho=
uld=20
make things look sane.

The thing is, you can actually get git to output the crazy names. Just =
do

	git show --pretty=3Demail 37a4c940749670671adab211a2d9c9fed9f3f757

and now you get the email-prettified thing for at least the author. No,=
=20
git won't corrupt the actual message, so the Signed-off-by: lines will=20
still show =C3=87a=C4=9Flar's first name, but you can actually get back=
 that odd=20
format.

(In fact, --pretty=3Demail will do it as

	From: =3D?utf-8?q?S.=3DC3=3D87a=3DC4=3D9Flar=3D20Onur?=3D <caglar@pard=
us.org.tr>

which is admittedy _even_uglier_, but whatever.. The difference between=
=20
really f*cking ugly and really f*cking uglier is not really relevant).

			Linus
