From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Merge seems to get confused by (reverted) cherry-picks
Date: Wed, 3 Sep 2008 09:25:56 +0200
Message-ID: <20080903072556.GA18449@atjola.homenet>
References: <20080903072011.GA14252@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 09:27:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kamlg-0005vD-OM
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 09:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbYICH0B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Sep 2008 03:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbYICH0B
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 03:26:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:57591 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751466AbYICH0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 03:26:00 -0400
Received: (qmail invoked by alias); 03 Sep 2008 07:25:58 -0000
Received: from i577B853E.versanet.de (EHLO atjola.local) [87.123.133.62]
  by mail.gmx.net (mp048) with SMTP; 03 Sep 2008 09:25:58 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+HKNceHQCHGNbeDc+vIVJT8S5w9Fcr7TbVuWjyR3
	efOMsfGgyZEQUx
Content-Disposition: inline
In-Reply-To: <20080903072011.GA14252@atjola.homenet>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94756>

On 2008.09.03 09:20:11 +0200, Bj=F6rn Steinbrink wrote:
> Hi,
>=20
> "git merge" produces a (IMHO) wrong result, when a commit from the
> branch that is to be merged in was cherry-picked into the current bra=
nch
> and later reverted on the original branch. Basically ignoring the
> revert.
>=20
> Example:
> mkdir gmt
> cd gmt
> git init
>=20
> /bin/echo -e "1\n2\n3\n4\n5\n6\n" > file
> git add file
> git commit -m init
>=20
> /bin/echo -e "1\n2\n3\na\n4\n5\n6\n" > file
> git add file
> git commit -m add
>=20
> git revert --no-edit HEAD
>=20
> git checkout -b test HEAD~2
> sleep 1 # Avoid race
> git cherry-pick master^
> git merge master
>=20
>=20
> That last "git merge" call happily tells:
> Already uptodate!
> Merge made by recursive.
>=20
> And "file" still contains the "a" that was added in the second commit=
=2E
>=20
> Seems broken to me, of course I want that revert to "show up" in the
> merge result, probably as a conflict for me to resolve.

I knew I would forget something... That's with:
$ git --version
git version 1.6.0.1.196.g01914

Bj=F6rn
