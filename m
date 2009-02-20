From: Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] git-tag: don't use gpg's stdin, stdout when signing tags
Date: Fri, 20 Feb 2009 08:46:34 -0500
Message-ID: <20090220134634.GJ4505@inocybe.teonanacatl.org>
References: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="Rsp728Nwk8twChKq"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 14:48:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaVjd-0001XZ-Vb
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 14:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbZBTNqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 08:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbZBTNqm
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 08:46:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53547 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbZBTNql (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 08:46:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9FC9B9B287;
	Fri, 20 Feb 2009 08:46:39 -0500 (EST)
Received: from inocybe.teonanacatl.org (unknown [71.173.205.56]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A80C49B286; Fri,
 20 Feb 2009 08:46:36 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20090220113856.6612.qmail@0bbdb5719a4668.315fe32.mid.smarden.org>
X-Listening-To: Nothing
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Pobox-Relay-ID: E6407684-FF54-11DD-ABAC-B26E209B64D9-09356542!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110844>


--Rsp728Nwk8twChKq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Gerrit Pape wrote:
> When using gpg with some console based gpg-agent, acquiring the
> passphrase through the agent fails if stdin and stdout of gpg are
> redirected.  With this commit, git-tag uses temporary files instead
> of standard input/output when signing a tag to support such
> gpg-agent usage.
>
> The problem was reported by Lo=EFc Minier through
> http://bugs.debian.org/507642

I sign tags using gpg-agent with the curse pinentry often and it works
here.  Perhaps Lo=EFc has not set GPG_TTY as the gpg-agent documentation
suggests?  If I unset GPG_TTY, I get the sort of failure indicated in
the bug report.  With it set tag signing works as expected.

Quoting the gpg-agent docs:

  You should always add the following lines to your `.bashrc' or
  whatever initialization file is used for all shell invocations:

     GPG_TTY=3D`tty`
     export GPG_TTY

  It is important that this environment variable always reflects the
  output of the `tty' command.  For W32 systems this option is not
  required.

Now, I'm not sure if that's a reason not to include this patch.  :)

I just wanted to mention that it can and does work if you have GPG_TTY
set.  This is often needed for other tools as well, e.g. with mutt, so
users of the curses pinentry are best off setting it rather than
hoping individual apps work around it.

--=20
Todd        OpenPGP -> KeyID: 0xBEAF0CE3 | URL: www.pobox.com/~tmz/pgp
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Some people are like Slinkies... not really good for anything, but you
still can't help but smile when you see one tumble down the stairs.


--Rsp728Nwk8twChKq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQFDBAEBAgAtBQJJnrQuJhhodHRwOi8vd3d3LnBvYm94LmNvbS9+dG16L3BncC90
bXouYXNjAAoJEEMlk4u+rwzjd/kH/RFmuKxmReuHtF0HodmXtCNbfv6xjP3A3Vuc
ocPbIkD1BFbHs+cqLvMCdQu+Ic5HECclDETyW3ebxji+4RI594EvVOml5lv+hzdx
ZbEGJP5CY9n3dSSyZtEI1utGRVnKeX+p/OqbFmBlb/usfIhhTT9gEfODYk0imMT4
UxK71sqwfFE89PKIkShmdnG8II5QymJKGbzk2CmFrEwJ6T6xrm+AjnXUZUNvep3/
J47r0m+l2JnLcNPEJwddAI2RMdlFi2/klBbvBFzsZym+2WtTOxYRDsicGZylwd1C
XUGHUJ7+GafSO7LDg6It812HG+QulTJeYZ4omi8bdJ515snjpqI=
=giWG
-----END PGP SIGNATURE-----

--Rsp728Nwk8twChKq--
