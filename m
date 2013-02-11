From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv3 0/5] Add git-credential support to git-send-email
Date: Mon, 11 Feb 2013 19:40:07 +0100
Organization: http://mina86.com/
Message-ID: <xa1td2w6g0e0.fsf@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com> <20130211165136.GC16402@sigill.intra.peff.net> <xa1tk3qeg46r.fsf@mina86.com> <20130211174811.GK16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 19:40:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4yJ0-00031C-C1
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 19:40:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758805Ab3BKSkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 13:40:19 -0500
Received: from mail-ee0-f50.google.com ([74.125.83.50]:32770 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758777Ab3BKSkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 13:40:17 -0500
Received: by mail-ee0-f50.google.com with SMTP id e51so3394895eek.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=U52M71bfvRR+VVLf6TRSiPreMYPlZjxEZNaF9GPNlk0=;
        b=mvD1dl9oLmL3HSZnYH9ZXklRW8b52YRFKa8HwueO44o2WKH/JeErzR9VpYkltjmn1Y
         k2Qsf9eIl6nE2BoGdR4Qpe8GpT9eeZeFwY/zE5hd1bgiXPdl4pZOhiEXSoCULBEypv8c
         /pyjM8y+dRw9z1EOG2bgWiaxjyzqaYEcH7w6Ghoc8G/u08deRt3NdxDCsQHJLWbGGbov
         8MsGvbiPTAiBBmT/3DkYn/DR/eBYpRo6DORKAow1Z6Op+XTmsmZOM8yNbqOtodBMm/BY
         gAyF3NwWHaICpdLN9AagLCJD/di2VEX60NYdz1umykhBEwS+cY1DS5qalcCX7BQN0qe9
         3q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=U52M71bfvRR+VVLf6TRSiPreMYPlZjxEZNaF9GPNlk0=;
        b=TbSt8gS1LS8u59f5puI9fxbY4epjHrWvKqwBYNeM+3Rnusd1omF0uDXhnJOoEbvEit
         E0cLfAg8/lLIiX+vuTjiBz81CIhkwC0zeE6YmLd6hJCXGhpeNySjj5XLm4IqArNG2nzm
         EFc3TqdD5461CecLQ9ALNv61vaUId3+hvVWODBqjsTWGSsAW9sPQllgfdJFl6QSbJ/mG
         +epi/BXSFdAFUzvehJUEmz6cNu8O6e6wPgl4xbTKl6wvaHnDLGfb8Z5k7I45SjQV44hH
         cNts/gxIxwOnbqhYO96z8DmW9v7FXqYCi+fliPmXwLyGIaAFPGXlOU/0fLeI0zL20EPo
         T0AA==
X-Received: by 10.14.206.132 with SMTP id l4mr52609319eeo.38.1360608016220;
        Mon, 11 Feb 2013 10:40:16 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id l8sm29939195een.10.2013.02.11.10.40.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 10:40:14 -0800 (PST)
In-Reply-To: <20130211174811.GK16402@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQkQo9MHMDn3t5KIY9o7ZFHhh6rFThmJdDx0YT4yvJevEogezHOH8P7nQT97hZEMKwjxGtDdMS5uXgeVRsPUr0Zl0X/ueD3KuP0gWZys3n3LqBXtn9kDPAMKbVeesZi/0jinJ/PPh+7M/A5ClM1U7Na+Ov8qwls0+GAZdSk3uuszg4T9Hy+JZAUFdHQ3ego0CHbe0mzA6hmlpvHeKca8WrN2TWzt2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216073>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11 2013, Jeff King wrote:
> Based on our discussion, I think it would just need the patch below
> squashed into your 4/5 (this handles the "undef" thing, and I also fixed
> a few typos in the API documentation):

> @@ -1152,7 +1155,9 @@ sub credential {
>  	if ('CODE' eq ref $op_or_code) {
>  		_credential_run $credential, 'fill';
>  		my $ret =3D $op_or_code->($credential);
> -		_credential_run $credential, $ret ? 'approve' : 'reject';
> +		if (defined $ret) {
> +			_credential_run $credential, $ret ? 'approve' : 'reject';
> +		}
>  		return $ret;
>  	} else {
>  		_credential_run $credential, $op_or_code;

Yep, that's what I did as well.  Thanks for spotting the typos,
I actually changed some other wording as well (most notably
CREDENTIAL_HASH -> CREDENTIAL_HASHREF), and also added some unrelated
patch in the middle: <https://github.com/mina86/git/commits/master>.

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

iQIcBAEBAgAGBQJRGTsIAAoJECBgQBJQdR/0hq0P+gLfGHGcSFRyCGP+EbWGkgG2
6znNXq+huqJsztcPUdMj0QbTjKMXqk/qbwlM0z1hZ7mc9C8fpvwnsYbYt4TY+Bm2
78+8EPkEkd7Mm+8a7y52aHZsELwWd6U4nYG3dWBJ8ZbnOmzNKZ7s0f/sPNTbpOTp
Va8Qnahven551MUfrqS5Y51Itt2PGbRgyDpmCMomCGFeTJTAZCoyOA9ttVN1J4Px
UuUzI9bNzpascxb7Eszp+6eUJk+5hCEv4S3n3PPJ4E0B+4gHVr71R5FRc9QugCt8
GeIQEL4WKX4lm3lI9h/npkIPQhYF4h8esgkmYuw/SqSOhe/meW/v1CnIIhnMd7mZ
/IDlf0fRdmrA1vMm6GNjLwOXYyoUio7BQWv0g/AgyxBbbUqG26oFmTeuv5vXSVPD
8GE7wI5xxKkchGUlOlBALxo9jECncy6sfK+GyLnlRta5eP/484j974xwCEQWbVda
IMZPNYhRzufYYYg6hgukUrodlm4fPzQhJfavfvlSChUeffr+Juu+9Vz2h18AGDgw
VbgXTl0Apr+uu5v1o3yLlWqlSS0y0CsUi/reSqD/9e6C9vKnJhuqxVUvWzoUvy9o
OOCki5tJf9vg0s8pzpev6Tc6OzRYcPStvMNY2DYA2yL+w5iODNVhHmd/5QY3BjIM
1mOarnroFV7MLbaDVZOs
=bev6
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
