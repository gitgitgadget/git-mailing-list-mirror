From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] post-receive-email: allow customizing of subject/intro/footer
Date: Thu, 21 Jan 2010 12:59:29 -0500
Organization: wh0rd.org
Message-ID: <201001211259.30704.vapier@gentoo.org>
References: <1263877931-26047-1-git-send-email-vapier@gentoo.org> <4B5888C2.60508@xiplink.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5044789.akm1SMsTf2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:59:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY1Jn-0001iC-8E
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754814Ab0AUR7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811Ab0AUR7b
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:59:31 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:53543 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754812Ab0AUR7a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:59:30 -0500
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 27FC71B403E;
	Thu, 21 Jan 2010 17:59:30 +0000 (UTC)
User-Agent: KMail/1.12.4 (Linux/2.6.32.4; KDE/4.3.4; x86_64; ; )
In-Reply-To: <4B5888C2.60508@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137680>

--nextPart5044789.akm1SMsTf2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 21 January 2010 12:02:58 Marc Branchaud wrote:
> > +	if [ -n "${emailbodyintro}" ] ; then
> > +		printf '\n%s\n' "${emailbodyintro}"
> > +	fi
>=20
> Since the script ensures there's always a value set for emailbodyintro, w=
hy
> check for it here?  None of the other uses of the new config items
> (emailsubject and emailfooter) have this kind of check.

the other values dont have newlines added to them implicitly.  if it's empt=
y,=20
i dont want to useless newlines at the start of the e-mail.

> > -	The $refname_type, $short_refname has been ${change_type}d
> > -	EOF
> > +	printf '\n%s\n' "The @refname_type@, @short_refname@ has been
> > @change_type@d" +	) | subst_vars
>=20
> Any reason why that last printf'd line shouldn't be made part of the
> emailbodyintro?

that could work

> So, overall, why not make generate_email_header() be simply:
>=20
> generate_email_header()
> {
> 	# --- Email (all stdout will be the email)
> 	# Generate header
> 	subst_vars <<-EOF
> 	To: $recipients
> 	Subject: ${emailprefix}${emailsubject}
> 	X-Git-Refname: @refname@
> 	X-Git-Reftype: @refname_type@
> 	X-Git-Oldrev: @oldrev@
> 	X-Git-Newrev: @newrev@
>=20
> 	${emailbodyintro}
>=20
> 	EOF
> }
>=20
> This would also let you simply subst_vars() so that it needn't support
>  piped invocations, no?  (Not a very drastic simplification, but still...)

if emailbodyintro is empty, this adds two useless newlines.  otherwise, thi=
s=20
would be fine i think.
=2Dmike

--nextPart5044789.akm1SMsTf2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iQIcBAABAgAGBQJLWJYCAAoJEEFjO5/oN/WBZ+sQAM57YDFOOXxP7gk81kWORN1x
xstxNSeW0T2vqBUCtgQ+VFLTmCO/Y1eXjhcdAtcttCtB36LbutOD8N8i7SvEvRys
IPAOxCUkF0nTInrF87NN4XnAsOe1y7hTv73RUQEkEkP/e16i2Kt45OjpPWQIRUb6
lACp1mmprGoHjXuTNlEi1+CNs/86MZHbX0vYZOqUN7n3xjBgrK8sDcvXj+9qw3K9
UYtXREbquBbbXk6x/q8FhgbmC//MRz4Ws99vZwoxZ7Dul1ZbJH4LqCfWLIyttuu6
vkFXHI7w1L3LrbL7EGvz0NbbKXry8k3u2Qh9xa/0u3+7tRLFKVa3c+X64jZSDeCo
ll5E4WBsYJrc8XQXeNkutrjrYenO/KRWLBBBx493hxAiNqKydYvLNSDnINCYyRIY
7BpA2DstumhrsjfasU+DQAz0Mj0EHOape90jm1o04K81zjoypFzURV/DgkEPBgp7
91WYwp4oRNge7JLLmzhzY7ZbH3QkXhx6QxisC8OFD6v3vhsr4WuxoV40Jy+EVn2i
ekTWm/3qfLw66/kBop9E3/+l6BAuGRxcR7yrFHYnGtd7YpcLalFXjhDDG/GUWz7D
nYK8UDgipoHUsqQBZOWy6+xQzSg77LKTa7oZLwnTxn6KIo2Zvki/75qzCqqoeNfU
DbyY0WaSCLriggxNsIOP
=8Jdc
-----END PGP SIGNATURE-----

--nextPart5044789.akm1SMsTf2--
