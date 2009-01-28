From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 02:15:51 +0100
Message-ID: <20090128011551.GB7503@atjola.homenet>
References: <bab6a2ab0901271504j73dce7afjf8436c3c7c83b770@mail.gmail.com> <bab6a2ab0901271510y1e3e6912t82ff16e0f912d4b6@mail.gmail.com> <alpine.LFD.2.00.0901271655090.3123@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: PJ Hyett <pjhyett@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 02:18:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRz4K-0007t4-0G
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 02:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbZA1BQw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jan 2009 20:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbZA1BQv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 20:16:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:38871 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751241AbZA1BQu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 20:16:50 -0500
Received: (qmail invoked by alias); 28 Jan 2009 01:16:47 -0000
Received: from i577BB3F1.versanet.de (EHLO atjola.local) [87.123.179.241]
  by mail.gmx.net (mp007) with SMTP; 28 Jan 2009 02:16:47 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+Htk5dKkWHzvlmmOSSpsRCEjbvdK2kyAmDirUr6r
	aHxmmRnQRvlP05
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901271655090.3123@localhost.localdomain>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107442>

On 2009.01.27 17:00:54 -0800, Linus Torvalds wrote:
>=20
>=20
> On Tue, 27 Jan 2009, PJ Hyett wrote:
> >=20
> > ~/Development/github(jetty)$ git fsck --full
> > warning in tree 0d640d99b492b0c7db034e92d0460a7f84b22356: contains =
zero-padded file modes
> > ..
>=20
> Ouch. This is unrelated to your issue, but I'm wondering what project=
=20
> contains these invalid trees, and how they were created.
>=20
> Zero-padded tree entries can cause "object aliases", ie two trees tha=
t=20
> have logically the same contents end up with different data (due to=20
> different amounts of padding) and thus different SHA1's. It shouldn't=
 be=20
> serious per se, but it's somethign that really shouldn't happen.
>=20
> What project does it come from, and how did such a tree get generated=
?

I guess that's still from their webinterface that allows to edit file
directly, without having a clone ofthe repo. The initial(?) version use=
d
to create such broken objects. It also got the order of entries in a
tree object wrong IIRC. Back then, Scott and myself tracked that down o=
n
#git, to their ruby(?) stuff that creates the objects. But maybe the
breakage is back?

Bj=F6rn
