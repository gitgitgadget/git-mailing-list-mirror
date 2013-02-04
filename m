From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCH] git-send-email: add ~/.authinfo parsing
Date: Mon, 04 Feb 2013 17:33:58 +0100
Organization: http://mina86.com/
Message-ID: <xa1tmwvk9gy1.fsf@mina86.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com> <7vvcafojf4.fsf@alter.siamese.dyndns.org> <20130130074306.GA17868@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Krzysztof Mazur <krzysiek@podlesie.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2P04-0006gb-1J
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab3BDQeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:34:09 -0500
Received: from mail-ea0-f182.google.com ([209.85.215.182]:60798 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756391Ab3BDQeH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:34:07 -0500
Received: by mail-ea0-f182.google.com with SMTP id a12so3006512eaa.41
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 08:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=A8JcmD2VhRzJfTW4D+cBO9R5fMS9JOcZ9f8RHlrK8SQ=;
        b=f+Sqv4NldMa6noeF/knTGDC2k46Ke+JnHn1Bhr9wdPgyj7bQ+BVVkoY7PPwQCXPoGa
         9+0dnw+KwDJyp+C06qnOK7Yz7jC1ffWY8TwM6wUJR87McQF8TGGfAwQ2cz+Lbxb5SKe/
         ceBhs3rnRgDuHDIIzEmIJkU2FN5I3cDzr1YcYjZvZrKe1fNbJJ9ICo03kD9o7JB7h4Ag
         2IFmsYMJT6uF4uxUJpmra7+IBk8oSqMrOtWyqK02do4d6jITXfCPlRsY5oJz2MxvXY7k
         f5RgVziC8i6hygXknNG4x08AmWmenVdUeby4iDI0OUjo/llYDYT5lRuKprsqJULB6ev/
         s/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=A8JcmD2VhRzJfTW4D+cBO9R5fMS9JOcZ9f8RHlrK8SQ=;
        b=KIiY8zkc599S6fxecMpZ/sNAPP8TKYCuWSpvvfHgH7MI3PyHSBAX5mUbsqg4JJRZX7
         acB0eGZD4Z7YfVLZbwEtuG7mnoudaEQyZ1tOVAzE/YpGo+JMjibrEPnYwuICAmZuXy5s
         DSmuiklqUN0SLAnLApGH8XxobusfunjRNdzlTR+ZBueUAXkvbhBh7S7YVsUiD1zvILXt
         t+24A+HQkFXV+FLkqPYfIRSPqSKnumS6sD43v7kw0x30SWSMP3WDjpkU8MS7ZcK+Lbvs
         BvF+ZR6yig9fzJsxV+2m5RGY6XW8WQjKWqQcvD9GfUkmhrzFiAYM9JqQKuxJEB0ErV2L
         vC2A==
X-Received: by 10.14.200.137 with SMTP id z9mr57591752een.20.1359995645386;
        Mon, 04 Feb 2013 08:34:05 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:d0a1:df4c:fabd:9ed4])
        by mx.google.com with ESMTPS id f49sm28044894eep.12.2013.02.04.08.34.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 04 Feb 2013 08:34:04 -0800 (PST)
In-Reply-To: <20130130074306.GA17868@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQms2c4VTW1JidBpY9O1s29X8mMi6cpezD4E1D8wTUYcsJSXwpH9pxEp+kR4ujWjKm5a5hmwS+MXr+MqqG+qlWqVlHblSrIe2xi1ScIDYnzFI7MNFR57rjKVt7UHbyO92G+oOiDmy9ORmMutPOuauGocNUjrqGHuubYHjg1L9sl/ZHbee28mOgtmumfTVHWczeaiQueD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215387>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30 2013, Jeff King wrote:
> I do not mind a .netrc or .authinfo parser, because while those formats
> do have security problems, they are standard files that may already be
> in use. So as long as we are not encouraging their use, I do not see a
> problem in supporting them (and we already do the same with curl's netrc
> support).
>
> But it would probably make sense for send-email to support the existing
> git-credential subsystem, so that it can take advantage of secure
> system-specific storage. And that is where we should be pointing new
> users. I think contrib/mw-to-git even has credential support written in
> perl, so it would just need to be factored out to Git.pm.

As far as I understand, there could be a git-credential helper that
reads ~/.authinfo and than git-send-email would just call =E2=80=9Cgit
credential fill=E2=80=9D, right?

I've noticed though, that git-credential does not support port argument,
which makes it slightly incompatible with ~/.authinfo.

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

iQIcBAEBAgAGBQJRD+L2AAoJECBgQBJQdR/0saQP/3u9/o5QChYQ3/lY+eGUbcx/
NdiaDgBduJ6iMUHKOS8qF2mK2/riQNA6PYEO7gPzVrK/1pNa+AOvl2DKpgTBdUZh
a7Z88N6SxvcdXorH5n55OcSHLbsFvo2lqbRG5yr5vh/CZlBUOD4nDusbrr1cUNEV
vi8hRQ5vot/3gXJDnLhP5FgMxEkn58PcT665262H1WA/W3jrS+s08Y0vz5TTj3af
yhloqdwCh0AXHqRJs/1N9B5M0/s15MqClClcRi9HU6iKmwgnFKu7Jyr3WoIuPSD1
4FYHFcvm2iVUW1nK5wMhIze/9wpOiEQbVP2lVDI5PKIeUP0gZHB8cvlhjxKN3RdO
tm7B5hqx5zNiRoR8mZ3Tj16M7Y7DGwxJyo4xA/1Lc9bUleKNn1mvmA+VJQVyoCQ+
jHFAhrBhWUgrLtvD5CSCgYHYtle7d2Z4iYH9U87O88yxiy6LNtduKEkTymhnzKkK
6dEL3c9lkRmeDLsZISzsems4w3uO3TTYsutX02dJcgXRZ2isvcuNlKdgjOl0sVHQ
xdrx6rLoUIn9Xn5KO8W2d9UBxCNDGedd6MIDFPNYzPB5C2NQSP3CefSEoGb/b2vD
3mJKc8462V9NjTohuQn3O23nJuiDh8Gzbr2HwcrpJ1HS6rzk98amPdGOxdl+Vw1y
ihP9weUuKAs5K+oTDng1
=pCfv
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
