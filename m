From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [bug] git cannot find "git pull"?
Date: Sat, 13 Jun 2009 13:36:00 -0400
Message-ID: <20090613173600.GL5076@inocybe.localdomain>
References: <4A319CE1.6040201@garzik.org>
 <20090612011737.GB5076@inocybe.localdomain> <4A323C56.1090703@garzik.org>
 <4A32A814.5050802@garzik.org> <20090612202642.GI5076@inocybe.localdomain>
 <4A32BF52.50603@garzik.org> <20090613150451.GK5076@inocybe.localdomain>
 <4A33E069.4050401@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="O8/n5iBOhiUtMkxf"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 19:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFX9S-0007Ud-0f
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 19:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332AbZFMRgG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 13:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753641AbZFMRgE
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 13:36:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47508 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbZFMRgD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 13:36:03 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DEA56BB7A0;
	Sat, 13 Jun 2009 13:36:04 -0400 (EDT)
Received: from inocybe.localdomain (unknown [173.67.155.244]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EC32EBB79F; Sat,
 13 Jun 2009 13:36:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <4A33E069.4050401@garzik.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: ABA899BC-5840-11DE-B798-97731A10BFE7-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121511>


--O8/n5iBOhiUtMkxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Jeff Garzik wrote:
> Found it!  A forgotten package I created, a collective of shell
> scripts, was setting GIT_EXEC_PATH=3D/usr/local/bin.

Phew.  I was worried I might have to start drinking much earlier than
usual today. ;)

> Given that /usr/local/bin/*git* has not existed on my systems for a
> long time, it appears that this is a new behavior, being a bit more
> strict in complaining about an invalid GIT_EXEC_PATH, rather than
> simply falling back to the internal compiled default
> (/usr/libexec/git-core).

Without looking closely at the make files and build logic, is it
perhaps something caused by the previous Fedora git-1.6.0.x packages
passing gitexecdir=3D%{_bindir} to make, while the F-11 and newer
packages do not set any gitexecdir?

> Things are working again now that the local GIT_EXEC_PATH export is
> removed.

Glad you found the culprit.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
I always keep a supply of stimulant handy in case I see a snake -
which I also keep handy.
    -- W. C. Fields


--O8/n5iBOhiUtMkxf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBCAAtBQJKM+N1JhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjCe0IAIvNMdffoRtv2V1iyuI0g+5phi8YVycETwcY
N60P/ob6pm4PRnx1QvwOEAPy7oYcRkcL+LJ+/7oGRrt0sUuufAiKBCRwAIPS/F8E
X50/qv/RGuoTXaUyZgOfVmRPCk72G0q4JK02g7At1EjZ+BtRArBgTrbY/9ukGYJa
n1JP5V2PmNz48FG+m1nGL7gkRkxQwuCxiFVu0CFlPQ42/GkB3xWbW0iQPQGy4mh7
gIAUO5YZ7pvVh/APyPbNqgyavNlHJ4caQEPjhihDRyyy3Q1PgVttqi5Iffznx7+s
sZ40rQwgFjBQC6nVYoHgegXFBLDf1VLiZiA+Ewr1byHN/fyiLJQ=
=Uk9N
-----END PGP SIGNATURE-----

--O8/n5iBOhiUtMkxf--
