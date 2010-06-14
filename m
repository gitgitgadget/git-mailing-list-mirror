From: Zhang Le <r0bertz@gentoo.org>
Subject: Re: [PATCH v2 1/2] add --recode-patch option to git-mailinfo
Date: Mon, 14 Jun 2010 13:49:41 +0800
Message-ID: <20100614054941.GA28218@adriano>
References: <1276455040-14726-1-git-send-email-r0bertz@gentoo.org>
 <7vvd9mb2kc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 14 07:51:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO2Za-0003li-Uy
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 07:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab0FNFu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 01:50:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:54979 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab0FNFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 01:50:25 -0400
Received: by pwi1 with SMTP id 1so2535618pwi.19
        for <git@vger.kernel.org>; Sun, 13 Jun 2010 22:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iTPoHZUxshW0e4d32ePW9qvcimJ5cvZ/Vq7ISYsLRZM=;
        b=o9/6hOcQmxyJ1ey31Vf0AM3qE2FdEfjrKAwcHXqAIC9Fxx6CsWVeaW5xHMTu4iKbGb
         r3XzlzaDmQffyIzd8KgjhLucH8JrwTUObM7mauYTDHoISTVL3sDD7B4Wvon5KSLuhKvY
         Y0r2/IOFXSVcB6CFBA4sw3HBeuPPKu+Loc4Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rGqWi/g9IoqeLBJs+k0+51mrQk0QySB8tvt8xJsrj6tGOfj33NSXDHh4/gJDQloKx+
         NJy0H2UhPje6EWvaUdguCXTpVIhxLEGafKwFXz5Le1QDLmEG2uWTjZQEhNqp+Tq+nU72
         miM7De2dFpEdjQ40E+E+jBQCXxwHmwv5kMj9w=
Received: by 10.115.113.31 with SMTP id q31mr4154282wam.1.1276494624596;
        Sun, 13 Jun 2010 22:50:24 -0700 (PDT)
Received: from localhost ([121.34.28.151])
        by mx.google.com with ESMTPS id d16sm19866036wam.12.2010.06.13.22.50.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Jun 2010 22:50:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvd9mb2kc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149076>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22:33 Sun 13 Jun     , Junio C Hamano wrote:
> Zhang Le <r0bertz@gentoo.org> writes:
>=20
> > diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
> > index 4a9729b..73f51f3 100644
> > --- a/builtin/mailinfo.c
> > +++ b/builtin/mailinfo.c
> > @@ -830,6 +831,8 @@ static int handle_commit_msg(struct strbuf *line)
> > =20
> >  static void handle_patch(const struct strbuf *line)
> >  {
> > +	if (recode_patch)
> > +		convert_to_utf8(line, charset.buf);
>=20
> builtin/mailinfo.c: In function 'handle_patch':
> builtin/mailinfo.c:835: error: passing argument 1 of 'convert_to_utf8' di=
scards qualifiers from pointer target type
>=20
> I do not think there is a reason for "line" to be const anymore; it used
> to make sense back when handle_patch() was only about writing the patch
> out, but that no longer is the case.

So you have used -Werror, right?
Because my gcc (4.4.3) only shows a warning.

Will fix it.

My gcc also shows another warning:
builtin/mailinfo.c:836: warning: ignoring return value of 'fwrite', declared
with attribute warn_unused_result

Does it occur to you as well?

--=20
Zhang, Le
Gentoo/Loongson Developer
http://zhangle.is-a-geek.org
0260 C902 B8F8 6506 6586 2B90 BC51 C808 1E4E 2973

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEARECAAYFAkwVwvUACgkQvFHICB5OKXP0+ACdFkkxP1PHXzN3ChpI/pPPY2eC
vV4AnApP/CEjM3G7liZ2zq67eW+rM1M4
=Prrv
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
