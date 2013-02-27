From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv4 6/6] git-send-email: use git credential to obtain password
Date: Wed, 27 Feb 2013 17:09:55 +0100
Organization: http://mina86.com/
Message-ID: <xa1tobf5viuk.fsf@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com> <cover.1360677646.git.mina86@mina86.com> <32bae1f3c7159035ea3fb5f61ab622cbff30293a.1360677646.git.mina86@mina86.com> <vpqhakx4z4c.fsf@grenoble-inp.fr> <7vehg1kb09.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: peff@peff.net, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 27 17:10:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAjaW-0001k0-JX
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 17:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754926Ab3B0QKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 11:10:06 -0500
Received: from mail-ee0-f53.google.com ([74.125.83.53]:63724 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab3B0QKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 11:10:03 -0500
Received: by mail-ee0-f53.google.com with SMTP id e53so634508eek.12
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=dRadULmCCBfFNeW3D5bHNB4LI5MjXzd8nXSt2YMWX8c=;
        b=bzmJd4zw4zADjzyBlquToKgu6qlPP60opTpeVAqLJd6srJd25Y//g6xVcMsT68gX8L
         Q1IpqbUCORpnUm02Y/HEDh7a0LX28Co1LhBB1L9g61X3yRy8yxoUS7+4etR9OtMmh44w
         Qw8tPoK5vmoyEmsINepxM1YJJDx1A6+ekAJ9Jp5EOBVw7KqpHSg/tO3vAaf6GdLl7afR
         HZhHvbKEH8DE2J0k6G/ElbmfvO1imEZzBYVN2c5dPIcR/mPkKzk0IOlJf8E5151pusBY
         rEKeIWCHeWDEEl740hUm68Q3T3f0ViTe3Us0ooHtthlvYQ23Tgcwnsi58pkIDmN9G4fN
         aFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=dRadULmCCBfFNeW3D5bHNB4LI5MjXzd8nXSt2YMWX8c=;
        b=eKwOef1N4G8QJBE1k2a2UXK4XHLf0/6ZjHrWtVy+eV1Cdvds/qkGRDeqNKj1HOl27o
         wfyuRQdk6zvCakUyABlCQcOskgvgHgWecps8AdQNl6sjfF+0x6JvwK/T429D4B6APqZB
         7+InfeQvKZJwiIfKdsMa1ikDWRFxjjeeAvzMLsW/6FkTLnOQF7wp3GR49ce7d1vXndgB
         Rra2CSZlly9ITpD5ENnn8C7DDox4qrGvNOOn+vuDP1FKzlPcp8Wpy+5VN8bVrcpWRBhS
         /z0cL6reIssod1ixPrs6OJceICfaZwJVeO1NT2rlXf4D1kCT5hqjwOvqV6fypeprt4yd
         Rzrw==
X-Received: by 10.14.215.193 with SMTP id e41mr7405294eep.32.1361981402372;
        Wed, 27 Feb 2013 08:10:02 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:c193:3dc1:6c35:807a])
        by mx.google.com with ESMTPS id a1sm7191835eep.2.2013.02.27.08.10.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 Feb 2013 08:10:01 -0800 (PST)
In-Reply-To: <7vehg1kb09.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQnp7wk8yFGAu0WKc7BBdQZO2+U/pRWjCAzOUS5TvNXPK//wUd5jb/2jZQ/mVdE2/EkR4ZBUkjuBafTK7RxS26WLirVkdxkoPiC5jV92ObgJ/aTKc5lNCdBUYe4zW5PELPh3qft8wJDH83QjkiN9ucGJQc6myjCJ6WZbJ0iSsr/usnvr0I7SWNM7CoIHQlMtJa0bcW6I7ZWWxrdu+P/vxSjAXTBj7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217216>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 27 2013, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Michal Nazarewicz <mpn@google.com> writes:
>>
>>> +	$auth =3D Git::credential({
>>> +		'protocol' =3D> 'smtp',
>>> +		'host' =3D> join(':', $smtp_server, $smtp_server_port),
>>
>> At this point, $smtp_server_port is not always defined. I just tested
>> and got
>>
>> Use of uninitialized value $smtp_server_port in join or string at
>> git-send-email line 1077.
>>
>> Other than that, the whole series looks good.
>
> Given that there is another place that conditionally append ":$port"
> to the host string, I think we should follow suit here.  Perhaps
> like the attached diff?

Damn meetings, you beat me to it=E2=80=A6  I was just about to send a patch=
. ;)

> Thanks for a review.
>
>
>  git-send-email.perl | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 76bbfc3..c3501d9 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1045,6 +1045,14 @@ sub maildomain {
>  	return maildomain_net() || maildomain_mta() || 'localhost.localdomain';
>  }
>=20=20
> +sub smtp_host_string {
> +	if (defined $smtp_server_port) {
> +		return "$smtp_server:$smtp_server_port";
> +	} else {
> +		return $smtp_server;
> +	}
> +}
> +
>  # Returns 1 if authentication succeeded or was not necessary
>  # (smtp_user was not specified), and 0 otherwise.
>=20=20
> @@ -1065,7 +1073,7 @@ sub smtp_auth_maybe {
>  	# reject credentials.
>  	$auth =3D Git::credential({
>  		'protocol' =3D> 'smtp',
> -		'host' =3D> join(':', $smtp_server, $smtp_server_port),
> +		'host' =3D> smtp_host_string(),
>  		'username' =3D> $smtp_authuser,
>  		# if there's no password, "git credential fill" will
>  		# give us one, otherwise it'll just pass this one.
> @@ -1188,9 +1196,7 @@ sub send_message {
>  		else {
>  			require Net::SMTP;
>  			$smtp_domain ||=3D maildomain();
> -			$smtp ||=3D Net::SMTP->new((defined $smtp_server_port)
> -						 ? "$smtp_server:$smtp_server_port"
> -						 : $smtp_server,
> +			$smtp ||=3D Net::SMTP->new(smtp_host_string(),
>  						 Hello =3D> $smtp_domain,
>  						 Debug =3D> $debug_net_smtp);
>  			if ($smtp_encryption eq 'tls' && $smtp) {

>From reading of SMTP.pm, it seems that this could be changed to:

-			$smtp ||=3D Net::SMTP->new((defined $smtp_server_port)
-						 ? "$smtp_server:$smtp_server_port"
-						 : $smtp_server,
+			$smtp ||=3D Net::SMTP->new($smtp_server,
+						 Port =3D> $smtp_server_port,

and than the other part would become:

@@ -1060,12 +1060,17 @@ sub smtp_auth_maybe {
                Authen::SASL->import(qw(Perl));
        };
=20
+       my $host =3D $smtp_server;
+       if (defined $smtp_server_port) {
+               $host .=3D ':' . $smtp_server_port;
+       }
+
        # TODO: Authentication may fail not because credentials were
        # invalid but due to other reasons, in which we should not
        # reject credentials.
        $auth =3D Git::credential({
                'protocol' =3D> 'smtp',
-               'host' =3D> join(':', $smtp_server, $smtp_server_port),
+               'host' =3D> $host,
                'username' =3D> $smtp_authuser,
                # if there's no password, "git credential fill" will
                # give us one, otherwise it'll just pass this one.

Either way, looks good to me.

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +----<email/xmpp: mpn@google.com>--------------ooO--(_)--Ooo--
--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJRLi/TAAoJECBgQBJQdR/0o5AQAJFRGD2r9Jl+dhi3NEpFfy+Q
19dGzNtSQeE4+6KdybnH3cmgg19uLkhKSVLbbAUGRLiFUlkGoLTkC9Fv6RGEnphQ
6zQqMGuv45EtClvYfVEmAsOBXkHcRKZqi9I+GWSkD1pB2yy4P8nAQL5n4NfhkqCE
qod5wg9w3cuNEuzJL2hXBhdSt9jacZr5/Qr0ksWXSJto+sD0JnmjOyuSPpKYosg4
rsYw76liRt7Nd+oVM7fKkKATG5e4YUe42JncVI8mYXFYN/j0ceGCgeAnyLvDY21v
KRvGTl1u5aDY/nCQepovCsY5p1X4eoI/mrABzmz9xuQrb7pBJJdL1MvEoS8GNh3M
AUe4bYNPJ3Ym4wA1IsLGV5kA8klOJV2nypUcrhJ2VhboANrB1qbKaRMTDgwwCzIh
A/DnlX06Zd70XJdKtKZiZncDHQgLQxoEIuOEfljLgIAvOyotoHbDXXOLlxQMhbFy
U7lKJXx2IJH16OHyRGoMzu5/EotfsIHPvrs8OZdWOk/HJ2zksjPA6IQXNNPCQ3bV
DKXTYPH/sTaNCUzeFFwU0ax4XEInftUZNlqmQekMLdteaQkQRfE1HqCN0Dglxucf
jHo4ar4k0NbfpL7NJFjNiG8d+L5rpBXW/D3qETHbOoANbIAnxqFrsx7R4f1prwwi
XpQSHmgupSH5641Lux60
=5DUY
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
