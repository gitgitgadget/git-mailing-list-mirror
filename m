From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH 1/4] Build in git-repack
Date: Wed, 07 Aug 2013 18:45:50 +0200
Message-ID: <520279BE.90704@googlemail.com>
References: <CACsJy8A-xo97MC-vBmqCrvvSDMWKd_MxnRrTBSeSqcQ1HifzJA@mail.gmail.com> <1375884049-14961-1-git-send-email-stefanbeller@googlemail.com> <1375884049-14961-2-git-send-email-stefanbeller@googlemail.com> <vpqzjsth8wt.fsf@anie.imag.fr> <7v38qlec2w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5530CB842CC66032981DBE64"
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, pclouds@gmail.com,
	iveqy@iveqy.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 07 18:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V76s3-00038z-OZ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 18:46:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757259Ab3HGQpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 12:45:55 -0400
Received: from mail-ea0-f181.google.com ([209.85.215.181]:45626 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756869Ab3HGQpy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 12:45:54 -0400
Received: by mail-ea0-f181.google.com with SMTP id d10so956381eaj.26
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=Eb3eDFO/owdGGXPX/rr+RkJvkOvkC9MU+n91+6p6sOU=;
        b=g5GhN+oJgKSdBMIcPSwXEvl7losUuiJP+HGQglA8T1mMYpvdYLU1B80oVkGqjbGjql
         9h/oDZYnEIcsZAFA4UzD6Xdvt8KqzSgaol/0Z2JPVk9P44qOzIp0TXAHcCvbwzCCr7IY
         2jA1hXjx9vLqqTOqXXxcALQu0jn5oT1/yGt0gImIFrCXoJq22LGhl06JWB5NJmbpoT6n
         plirlWzRzGzOF8xlrZwpbHttL5RB2sylpG2BF2ovZ15o/FRHGyIGb+aSbI4hcgfCzbBo
         9Mihdr67/+U24akFtxHMYkHurmFckgGSdd4KksHtLRNGBAWUYJ4ZhXTmDHxOSVj8PkhU
         ybAw==
X-Received: by 10.14.221.72 with SMTP id q48mr3884592eep.94.1375893953375;
        Wed, 07 Aug 2013 09:45:53 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id r48sm4004734eev.14.2013.08.07.09.45.51
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 Aug 2013 09:45:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <7v38qlec2w.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231836>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5530CB842CC66032981DBE64
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2013 05:48 PM, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>>
>> seems overkill to me: why don't you just let cmd_repack call
>> update_server_info(0)?
>=20
> My feeling exactly.  I would rather see a patch that does not touch
> pack-objects at all, and use run_command() interface to spawn it.
> Once we do have to pack, the necessary processing cycle will dwarf
> the fork/exec latency anyway, no?
>=20

Thanks for clarification. That was my initial idea as well,=20
to not touch the pack-objects logic.=20

However Duy send that patch (basically as is,=20
I just made it apply again),=20
and I guessed that I'd get to results
faster with an already existing approach.

I will reconsider and try to remove the additional logic from=20
pack-objects again (so it will not get touched) and move it to the
repack itself. It is just a way to understand, 'what needs to be done'.

Stefan


--------------enig5530CB842CC66032981DBE64
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSAnm+AAoJEJQCPTzLflhq34IQAJ4NKm6ZSaJnzH3Y0ritS3Cx
9//wMSG3oBuGzO0iqZt07CiZDbhMYMFy99C17EFZDRNdXtM+sKjpewgQGLggngjH
dOiYajcjC3ZZthSp2DpJP02Ef1LzcSrLonCOeJwo2ch6keA3X1eErEPDcOBlLy+6
Uw6870cBRsAsk4JOJ3MKU32kbsrBVVpRPxb4L6uFYP2+FnRwVRsT9MuAKbClG5EV
enC54dNJ2KvgdBTuw5kEVKYdpV7j7MCHaf7IHkF9gtJdK1XX9u7GqyhaRJauob99
dn1z3Zvuem6OAxaEM6f1lK3MAWOFeQwRKTFC2Jv3ymtSGoKhKWQwZTXCOSjKmASN
pZa9pEWT4SFNunxKHBFPREq9YiP7VcUSU/gOY2GPvPCt3N5CAzHsFHxzq4CO4Boe
SXysNbYi9XX5ijT+JNcSL8TFSplKXXJdAvFd2yYp9EPurcNDg0+KJrdqIq4uPZK/
17yxY5wTLXIxPnTPAlQccUJIhvgCvULeBPj9yZw/I6NkT7hrRzb0uZxZOL4WqR17
tLQBeKx2DwiHZ6i5JREDAx9lcvSHUHklPC18SWqOT+GpDMONSA8+qdVDdYsCsfdB
Pu1/3VtabbDLZnI//6KEkEnIEJLpteSQ67bM43wow8MHY2RZs/9t36n7evI5nn6+
Ocyxh6oGbzmkv5wPkVP7
=+Iv0
-----END PGP SIGNATURE-----

--------------enig5530CB842CC66032981DBE64--
