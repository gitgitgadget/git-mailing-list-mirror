From: Ismael Luceno <ismael.luceno@gmail.com>
Subject: Re: Git push over git protocol for corporate environment
Date: Fri, 02 Oct 2009 15:54:45 -0300
Message-ID: <4AC64C75.8090809@gmail.com>
References: <m3pr989eyt.fsf@localhost.localdomain>	 <00163623ac5d75929b0474e66b96@google.com> <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFD33D15E3477187EB2B9A765"
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 20:55:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MtnID-0001a3-Sg
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 20:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754522AbZJBSzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 14:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbZJBSzk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 14:55:40 -0400
Received: from mail-qy0-f173.google.com ([209.85.221.173]:52041 "EHLO
	mail-qy0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbZJBSzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 14:55:39 -0400
Received: by qyk3 with SMTP id 3so1130878qyk.4
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:openpgp:content-type;
        bh=9qu+/b5rwggeyHs6ZaVGm/Y0tBOIsKeUKe1uCR5FT0k=;
        b=YUe2vxgYym+EZwSDUrpWyplRWB7noGqWrbu9ymdkcT3j4q8D1VP3iMJinapZwmjO4p
         9uwFS9+HJo9LnW+O1+6oVhH2nhecD1vGtzj1JD0wZX5xHSy2rruKTquxxmuQ7bOjULLZ
         TtODv8hrMxoh06BW/q2cXLf+Fb9+/abjnZEOE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:openpgp:content-type;
        b=Ya1fHmIcTd8geWmX16PMWFJfGv1z6axUWiib98BAe1GX5a4HV91vTP14Y1VllVgUb3
         hJNYy5wXiwWOp0IrZYPU1sL5O3YvphPmhI4nCbndLq+LDkupGVfnBKu5oRboGwSgeHP+
         od6yMmYJ3NtNo6rjyzfHdb2gItJzbuSmVTFeA=
Received: by 10.224.83.21 with SMTP id d21mr1397998qal.10.1254509743463;
        Fri, 02 Oct 2009 11:55:43 -0700 (PDT)
Received: from ?192.168.1.181? (r200-40-215-58.ae-static.anteldata.net.uy [200.40.215.58])
        by mx.google.com with ESMTPS id 22sm80759yxe.11.2009.10.02.11.55.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Oct 2009 11:55:41 -0700 (PDT)
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090701)
In-Reply-To: <76c5b8580910020741p2024f6c0w70be53338924e7e8@mail.gmail.com>
X-Enigmail-Version: 0.95.0
OpenPGP: id=EC8E5C9A;
	url=http://ismael.initng.org/ismael.gpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129454>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFD33D15E3477187EB2B9A765
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Eugene Sajine escribi=C3=B3:
> I think that this is what is missing right now in order for git to get
> rocket start and spread inside companies: secure and easy to maintain
> mainline hosting.
>=20

It looks like your problem is using cygwin. It's more complicated on a
MS-Windows environment, and personally I think it's a _very bad idea_.

Git is really easy to use in fact, you just set up the repo with:

  mkdir repo.git
  cd repo.git
  git init --bare --shared=3Dall

--shared=3Dall makes the repo readable to anyone, and ensures push rights=

to users under the same group as the user setting up the repo. You can
change the group with chmod of course.

SSH access will be needed to push, unless the users can remotely mount
the repo via NFS or any other protocol.

Pulling is possible over http too, you just need to make
hooks/post-update executable. To export via git protocol you must create
an empty file named "git-daemon-export-ok".

Besides setting a web repo browser and git-server there's nothing else
specific to git.

--=20
Ismael Luceno


--------------enigFD33D15E3477187EB2B9A765
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkrGTLsACgkQ/mxY0+yOXJqlEACgsg66ejBP+PYPEE/sdzkHBF3W
uucAn060DVGfOovQAOEKdqKrxbgOeaOR
=9h1/
-----END PGP SIGNATURE-----

--------------enigFD33D15E3477187EB2B9A765--
