From: Ittay Dror <ittayd@tikalk.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 01 May 2008 21:58:14 +0300
Message-ID: <481A12C6.6060900@tikalk.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <2e24e5b90805010939g182de387i59722605ff93d72e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 20:59:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jre08-0004vQ-FM
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 20:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532AbYEAS6j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 May 2008 14:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758386AbYEAS6j
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 14:58:39 -0400
Received: from smtp105.biz.mail.re2.yahoo.com ([206.190.52.174]:29065 "HELO
	smtp105.biz.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1758301AbYEAS6i (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 May 2008 14:58:38 -0400
Received: (qmail 43553 invoked from network); 1 May 2008 18:58:37 -0000
Received: from unknown (HELO ?192.168.1.9?) (ittayd@tikalk.com@84.108.89.36 with plain)
  by smtp105.biz.mail.re2.yahoo.com with SMTP; 1 May 2008 18:58:33 -0000
X-YMail-OSG: 9IGhRl8VM1lJ_XoCLTOtcHqId8YC1YpnMBIm8EVn7toQfCzf4j_GfzAJ1uY.ffuZ.3beohEu0TMXB4Xtc0d_ibrxGpxeA.IjMeYYG6igz7iN.lBQEIm18LZYTD7pnyc-
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <2e24e5b90805010939g182de387i59722605ff93d72e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80930>

Sitaram Chamarty wrote:
> http://www.markshuttleworth.com/archives/123#comment-118655
>
Here is the comment from the thread, my comment on it is below:

 > This is a very strong point for renaming, but it is not necessarily=20
an universal one.

 > Here is one example of the issue: one developer renaming a directory=
=20
in his branch, and another adding a file to the original directory in=20
his branch. What happens at the merge ?
 > - Bazaar renames the directory and puts the new file in the _renamed=
_=20
directory.
 > - Git renames the directory with its files, but keeps the old=20
directory too and adds the new file there.

 > Bazaar=92s behavior certainly is better for C. However it is not=20
universally better.

 > For example in Java you cannot rename a file without changing its=20
contents. So, moving a file to a directory different from where its=20
author put it will almost certainly break the build.

 > The bottom line is, both behaviors can seem valid or broken,=20
depending on the case. Neither is perfect. At the very abstract level=20
file renames are _not_ a first-class operation. This is especially=20
apparent in a language like Java.

 > Content movement is the first class operation. Things like moving=20
functions, etc. The question is how one can handle that and whether the=
=20
current strategy has a path for improvement. It could be > argued that=20
once you commit yourself to explicitly tracking file renames, you are=20
giving up a slew of opportunities for handling the more general cases.

 > One thing is for certain, a 100% ideal solution is impossible. It=20
would have to be aware of the target programming language _and_ the=20
build environment.

And my comment is that in this example, about Java, I think that=20
manually fixing the package name in the file (after noticing the build=20
is broken) is easy. On the other hand, if the other developer changed=20
one of the renamed file, then manually merging the change in the file i=
n=20
the old location to the file in the new location is not so easy: you=20
first need to discover that this happened, then merge the two files (an=
d=20
you still need to fix the package name).

ittay

--=20
Ittay Dror <ittayd@tikalk.com>
Tikal <http://www.tikalk.com>
Tikal Project <http://tikal.sourceforge.net>
