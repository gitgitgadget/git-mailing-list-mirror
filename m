From: Simon Hausmann <simon@lst.de>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 23:46:10 +0200
Message-ID: <200706112346.13628.simon@lst.de>
References: <20070608202236.GJ25093@menevado.ms.com> <200706112042.16331.simon@lst.de> <20070611201232.GA4649@steel.home>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1225131.18pgUSNuPU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxriA-0008Ma-Le
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 23:46:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752832AbXFKVqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 17:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbXFKVqD
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 17:46:03 -0400
Received: from verein.lst.de ([213.95.11.210]:50839 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832AbXFKVqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 17:46:01 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5BLjwo6020029
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 11 Jun 2007 23:45:59 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070611201232.GA4649@steel.home>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49890>

--nextPart1225131.18pgUSNuPU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 June 2007 22:12:32 Alex Riesen wrote:
[...]
> > > And, BTW, don't you have a small problem with filenames with
> > > spaces and quoting?
> >
> > I'm not aware of any problems. For example in our depot we have filenam=
es
> > with spaces in them and they appear just fine in my git import. Did you
> > run into any specific case? It could very well be that there's a bug
> > somewhere that I'm just not hitting myself, so I'm curious :)
>
> No, I just looking at the source. Does python have some magic for
> running programs with system() when passed a format string? Like here:
>
>         for f in filesToAdd:
>             system("p4 add %s" % f)
>         for f in filesToDelete:
>             system("p4 revert %s" % f)
>             system("p4 delete %s" % f)

Ooops, indeed. Makes me realizes that I've never actually submitted files w=
ith=20
spaces in the name :). For now I've quoted them with double quotes like in=
=20
the other places, which is better than nothing. Thanks for spotting!

> BTW, sometimes you quote the names, but obviously wrong (think about
> filenames containing double quotes):
>
>                 system("p4 edit \"%s\"" % path)
>                 editedFiles.add(path)

Indeed, for file names with double quotes that doesn't work. I guess I'll h=
ave=20
to change that to subprocess.Popen then :)

Simon

--nextPart1225131.18pgUSNuPU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbcKlWXvMThJCpvIRAnpbAJ9yPjR32Ioaa2IsYommccJ9IxOnPQCgh78k
PdZ9DybUiQp0KaobbyZ3zno=
=apYt
-----END PGP SIGNATURE-----

--nextPart1225131.18pgUSNuPU--
