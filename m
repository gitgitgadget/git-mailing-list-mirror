From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Sat, 9 Jun 2007 00:38:27 +0200
Message-ID: <200706090038.33799.simon@lst.de>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart27478905.DjsfKquT1r";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: "Benjamin Sergeant" <bsergean@gmail.com>, git@vger.kernel.org
To: "Han-Wen Nienhuys" <hanwen@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 09 00:39:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwn6l-0006Lq-5q
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 00:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031192AbXFHWio (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 18:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S969549AbXFHWin
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 18:38:43 -0400
Received: from verein.lst.de ([213.95.11.210]:41694 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031153AbXFHWim (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 18:38:42 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l58McWo6000541
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Sat, 9 Jun 2007 00:38:35 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49516>

--nextPart27478905.DjsfKquT1r
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 08 June 2007 20:13:55 Benjamin Sergeant wrote:
> A perforce command with all the files in the repo is generated to get
> all the file content.
> Here is a patch to break it into multiple successive perforce command
> who uses 4K of parameter max, and collect the output for later.
>
> It works, but not for big depos, because the whole perforce depo
> content is stored in memory in P4Sync.run(), and it looks like mine is
> bigger than 2 Gigs, so I had to kill the process.

I'd be generally fine with splitting up the "p4 print ..." calls into chunk=
s=20
but you have a good point with the memory usage. The old approach of callin=
g=20
print per file did not have any of those limitations. Han-Wen, what do you=
=20
think? How much of a performance improvement is the batched print?

(I didn't notice any immediate difference, but then I have a very fast=20
connection to the perforce server and usually small changesets)

Simon

--nextPart27478905.DjsfKquT1r
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGadppWXvMThJCpvIRAosiAKDu/hIP5c//i1mG5BsdVuWUMkbR0ACfW1aV
9qWW0WsXdBVjR/eFNBUkLEs=
=72fJ
-----END PGP SIGNATURE-----

--nextPart27478905.DjsfKquT1r--
