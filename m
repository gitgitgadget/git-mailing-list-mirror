From: Simon Hausmann <simon@lst.de>
Subject: Re: State of Perforce importing.
Date: Tue, 18 Sep 2007 08:58:21 +0200
Message-ID: <200709180858.25188.simon@lst.de>
References: <20070917193027.GA24282@old.davidb.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3543000.Z0HXOezftx";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Tue Sep 18 08:55:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXX01-000170-2A
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 08:55:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477AbXIRGzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 02:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbXIRGzx
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 02:55:53 -0400
Received: from verein.lst.de ([213.95.11.210]:41027 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754456AbXIRGzw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 02:55:52 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l8I6tfA5019814
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Tue, 18 Sep 2007 08:55:44 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <20070917193027.GA24282@old.davidb.org>
X-Spam-Score: 0.1 () HTML_MESSAGE
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58530>

--nextPart3543000.Z0HXOezftx
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 17 September 2007 21:30:28 David Brown wrote:
> I'd like to track a lot of code living in a Perforce repository, so I've
> been playing with 'git-p4.py'.  Is the one in the contrib/fast-import
> directory the latest version, or is there a better place.

This is indeed the latest version (on contrib/fast-import).

> So far, it is having a couple of problems:
>
>    - The commit comment is empty.  It doesn't seem to grab the Perforce
>      description, and the user seems to be <a@b>.

This may be a problem with the python output of perforce. Can you run the=20
following command?

	git-p4 debug change <a change number in your depot>

That should print a dictionary that has a 'desc' field containing the commi=
t=20
comment/log and a 'user' field that has the perforce user name.

>    - Every revision seems to check every file out of Perforce.  This means
>      that for the directory I want, every revision is going to take about
> 20 minutes.

=46or every revision only every _changed_ file is retrieved (using p4=20
print //path/file#revision).


Simon

--nextPart3543000.Z0HXOezftx
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG73cRWXvMThJCpvIRAsFsAJ4tTUa4jV2ul4yyH9Ykjh48efAHCwCgxqPt
i6KCyW7TqlZrsoqUA9eFfs0=
=Z7t1
-----END PGP SIGNATURE-----

--nextPart3543000.Z0HXOezftx--
