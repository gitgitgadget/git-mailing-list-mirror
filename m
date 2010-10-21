From: Drew Northup <drew.northup@maine.edu>
Subject: Re: Git terminology: remote, add, track, stage, etc.
Date: Thu, 21 Oct 2010 16:06:42 -0400
Message-ID: <1287691602.24161.67.camel@drew-northup.unet.maine.edu>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	 <m3ocar5fmo.fsf@localhost.localdomain>  <4CBFFD79.1010808@alum.mit.edu>
	 <1287660007.24161.10.camel@drew-northup.unet.maine.edu>
	 <968F09BD-2B2D-44C4-9C0F-BF7BD20041F0@gmail.com>
	 <1287665760.24161.33.camel@drew-northup.unet.maine.edu>
	 <EE0A3DAA-DFE8-4F70-B321-0B1CA63B1341@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thore Husfeldt <thore.husfeldt@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 22:07:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P91QV-0005L7-7I
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 22:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396Ab0JUUHq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 16:07:46 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:41176 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755181Ab0JUUHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 16:07:46 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id o9LK6mCH019804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Oct 2010 16:06:53 -0400
In-Reply-To: <EE0A3DAA-DFE8-4F70-B321-0B1CA63B1341@gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=4
	Fuz1=4 Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: o9LK6mCH019804
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1288296422.66926@Q7JZy8gYqcy4JJGj+qofyw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159558>


On Thu, 2010-10-21 at 16:06 +0200, Thore Husfeldt wrote:
> On 21 Oct 2010, at 14:56, Drew Northup wrote:
>=20
> > That's not what I asked.
> > [... good, concrete example omitted...]
> >=20
> > $ vim A.txt
> > $ git stage A.txt
> > $ git commit
> > $ vim C.txt
> > $ vim A.txt
> > $ git stage A.txt
> > $ git stage C.txt
> >=20
> > Should the last two commands fail?
>=20
> No, not for me. (Is this in reaction to Jakub=E2=80=99s suggestion th=
at an
> =E2=80=9Cuntracked file=E2=80=9D, like C.txt, cannot be staged before=
 explicitly
> tracked?)

I hadn't read any of his comments to mean that, but I could be missing
something...
More than anything else I was trying to feel out possible workflow
issues. A lot of people are going to (continue? to) confuse "git add"
and "svn add" if we don't make very explicit what we are up to. As you
are not suggesting we outright replace "git add" I wanted to be very
sure as to what you mean to do.

> Maybe this is what should happen:
>=20
> $ git stage C.txt
> git stage: Contents of previously untracked file C.txt staged for nex=
t commit

This is reasonable. I would probably say "...untracked file C.txt added
to index and staged for next commit" to emphasize the existing "git add=
"
idiom, but that may be superfluous.

> > Now, if "git stage" were an outright replacement for "git add"
> > there might be more use (but I'd still not be happy about the corru=
ption
> > of the idiom).
>=20
> I tend to agree. But look at, e.g., Figure 2.1 in the Pro Git book
> http://progit.org/book/ch2-2.html . That view strongly enforces that
> something special happens to the new =E2=80=9Cpink=E2=80=9D file, dif=
ferent from what
> happens to a =E2=80=9Cyellow=E2=80=9D file. After this helpful discus=
sion, I don=E2=80=99t
> like figure 2.1 so much anymore. A red arrow should go from =E2=80=9C=
pink=E2=80=9D to
> =E2=80=9Cblue=E2=80=9D with text =E2=80=9Cstage the file=E2=80=9D.

I can see why this would get your attention. I have to admit I ignored
it because it didn't match-up with the bulk of documentation in any way
I had yet made sense of. Once I had made sense of the idiom and looked
back at the graphic I shrugged and wondered why the author had chosen t=
o
illustrate it that way.

--=20
-Drew Northup N1XIM
   AKA RvnPhnx on OPN
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
