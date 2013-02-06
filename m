From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Wed, 06 Feb 2013 14:26:46 +0100
Organization: http://mina86.com/
Message-ID: <xa1tpq0dpo89.fsf@mina86.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com> <7vvcafojf4.fsf@alter.siamese.dyndns.org> <20130130074306.GA17868@sigill.intra.peff.net> <7v6226pdb7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org, Krzysztof Mazur <krzysiek@podlesie.net>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 06 14:27:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3521-0003Nh-4e
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 14:27:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501Ab3BFN06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 08:26:58 -0500
Received: from mail-ea0-f169.google.com ([209.85.215.169]:48433 "EHLO
	mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3BFN04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 08:26:56 -0500
Received: by mail-ea0-f169.google.com with SMTP id d13so611420eaa.14
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 05:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=mni0A5hhqeE459jkzGGKY+3NBdTYndOS8WTWsURRou8=;
        b=atNSaH8XqUBi8n8QugZCoGmFkULYKknkUw5iGcEtwinIYguiSteJr5WYIqm4T/8G34
         XyqQqL9i6m2QOYVXbqENsLmhb0U+uIOsR7rbnE0223eOS2f+/uiNqN3Hu5faWCGZUUk2
         /7Ije9+lVn4AG7PYgh+3kDEJMjJGvSzhaqqR93g4qcecACfv21y/FDF93HgnPOjN99aQ
         YNpvPnqYsUjGkJsVvaTWBV9Dd38nXiwPYxc9TUO/ZaelobQVC9/Sob0CXfVDhPsnD8SQ
         NaJ54JrzxH0ANutyu5Fj26FYM8RW0GaAvWThRgCTyOQ94ddTa+NhkMJXYIaRrxiePyJH
         hrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=mni0A5hhqeE459jkzGGKY+3NBdTYndOS8WTWsURRou8=;
        b=aWB/HGkMgEinwswyUnLjSIAVWgt/SX0GU1jBNIY/UpqPUqHEyJi4UqGziTqcdrgmHG
         gmMOM2mM5jzi4iXtEP34sQ3gY3At2kFSapiaFUF8gjx8Apq+xH9GCdyHy02Z4nwId816
         M0toKnCdaR2rmfnF+Jrso6/7yJWFO1JoSD3vSePILm9v8t7+X11aOChapBMcgoKhKHJZ
         R4kVKGwHbvdwqTCUybKyS4G6PMEAX1qMAJCcvIW2HNdRxxKdAj18kSgazGmem+7vgYdF
         k8jcJllg4gVRNkZ1BmKSnsHEu3pcvitXmX9XKRzlbZsbsjTBURP9QG+LiH/6ArAi+jkq
         aPYA==
X-Received: by 10.14.178.196 with SMTP id f44mr97025118eem.14.1360157214946;
        Wed, 06 Feb 2013 05:26:54 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:e809:df2d:46af:f661])
        by mx.google.com with ESMTPS id b2sm36797312eep.9.2013.02.06.05.26.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Feb 2013 05:26:53 -0800 (PST)
In-Reply-To: <7v6226pdb7.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQnXjjEkK0rSbEpBpkIgy1WaLd0CimTGS1RvoI0WqMF3qm9Qf4YZQmKxnvHZb46Jji4zGxs6WiSTSWTQxhnRpPAN72PhPGfvij9Egwf95yNfWdCZqij3zEPhNg8q/FDsBY6DL5lc/JTLBMU3VvEl+hKsx+DgMOCUdTv0s/TuWK7/joAJsLWub01YhUOs6jJImwQVJMG2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215577>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06 2013, Junio C Hamano <gitster@pobox.com> wrote:
> I see a lot of rerolls on the credential helper front, but is there
> anybody working on hooking send-email to the credential framework?

I assumed someone had, but if not I can take a stab at it.  I'm not sure
however how should I map server, server-port, and user to credential
key-value pairs.  I'm leaning towards

	protocol=3Dsmtp
	host=3D<smtp-server>:<smtp-port>
	user=3D<user>

and than netrc/authinfo helper splitting host to host name and port
number, unless port is not in host in which case protocol is assumed as
port.

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

iQIcBAEBAgAGBQJREloXAAoJECBgQBJQdR/0hV4P/0OY7kd32HVD9D6L07S3nVPG
N2rgh0WL2NQZaHjqJ7Gp34QJymkyRTj+JtkK2GZqIpl5s9yyl4szEWROgLjCJO3K
V5mnVLOMlJvQ+64gV5JHW5KNAbus+huiCEJTXac1Hjmex64x93xhGR0ImjZO6djC
XGQVIBFwy/acN3HbdZdZzYXdAePw/JaYsHUAJGx9DwBNUmMNs2Jp/3lbKmVR7UNY
lc9fjjFwO++JwjEdRiD0v8XtNvusGaSwuyE9QoJ2MhTZSZYhwL3qAg3S4ukgpDmq
aG0qrUH10NRH7ObTmo/MdtR6QhCM6/qiY22Wm05xGUpq5TtK4Cjw0ICEdyNQl6HY
6JGkOA8gU5B/O9QMVosSEAwly5zNf6zcZAGd3xWyckwAQrkZslyvJA2okHVSZ0A5
+XC1dtLFLVYdzaBOE1OVxFowr7XJZUlTLJZar+wH2zhDsrFkjpIRyVp1Gy0O15Ik
NngfE2TCoO3qgpdCkC6ZTs6YnLkYCqOYUQCD21maME7uEKh0sMKnBnGCrH87jphm
kk6m7QXFUbPK2RiUZjOMHb8jvgV93/sGq7uifwFv9r1phPZ/mGyCyW3oAe92KJA1
5/SN8REuIzo5q4Xq5fGNpgTeiSx9og62DSK6ydYaY0waIhQY5DMwhRg8enqXRRWe
7jJMu8K//ZJL/yFoHwKW
=lbBz
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
