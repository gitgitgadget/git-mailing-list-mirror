From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: url.<base>.insteadOf with empty value
Date: Fri, 14 Oct 2011 23:09:55 +0400
Message-ID: <6DA2F444-C774-4F22-8EF0-BFD8F3308A4A@jetbrains.com>
References: <54556728-92C0-4992-9831-0D582C383235@jetbrains.com> <7v8von1mnd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 14 21:10:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REn9D-0002mi-6N
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 21:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755899Ab1JNTKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Oct 2011 15:10:04 -0400
Received: from mail1.intellij.net ([46.137.178.215]:36372 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753961Ab1JNTKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 15:10:03 -0400
Received: (qmail 13621 invoked by uid 89); 14 Oct 2011 19:10:01 -0000
Received: by simscan 1.1.0 ppid: 13488, pid: 13612, t: 0.1711s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO ?10.0.1.7?) (Kirill.Likhodedov@jetbrains.com@109.167.130.96)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 14 Oct 2011 19:10:01 -0000
In-Reply-To: <7v8von1mnd.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183597>


14.10.2011, =D7 21:57, Junio C Hamano writes:

>> If I don't specify any value for url.<base>.insteadOf or url.<base>.=
pushInsteadOf, Git substitutes all urls for remotes defined in .git/con=
fig
>>=20
>> If it is not a bug, I'd suggest to add a note to man git-config abou=
t this.
>=20
> Please assume that what the documentation says is clear enough for wh=
oever
> wrote it and need no further clarification, so you would need to help=
 them
> understand what additional things you may want the documentation to s=
ay,
> by clarifying "add a note" and "about this" a bit.

I would add the following to the "url.<base>.insteadOf" section of git-=
config:
:::: If empty value is specified in insteadOf, <base> will be added to =
the start of any URL.


> The "insteadOf" replacement is meant to apply for any URL we use. I w=
ould
> be surprised if it did not affect pushURL; it would be a bug if it di=
dn't.

That was the question I wanted to clarify.=20
I thought that pushURL shouldn't be affected by insteadOf, because it i=
s not affected by pushInsteadOf.
Thanks for clarifying that out.

> On the other hand, the rewrite done by "pushinsteadof" is meant to ap=
ply
> only when remote.<any>.url is used for pushing.  See t/t5516-fetch-pu=
sh.sh
> part of the patch for 1c2eafb (Add url.<base>.pushInsteadOf: URL rewr=
iting
> for push only, 2009-09-07). It would clarify what the intended intera=
ction
> among these configuration variables.


Yeah, that's clear. My question was only about insteadOf behavior. Sorr=
y for making it not clear enough. The behavior of pushInsteadOf is comp=
letely clear from the discussion thread I mentioned and from t5516-fetc=
h-push.sh

Thanks.