From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv4 4/6] Git.pm: allow pipes to be closed prior to calling command_close_bidi_pipe
Date: Tue, 12 Feb 2013 22:13:10 +0100
Organization: http://mina86.com/
Message-ID: <xa1thalh9qxl.fsf@mina86.com>
References: <cover.1360677646.git.mina86@mina86.com> <3bb6b7736eb4b0a958469be13d8c646faec1208a.1360677646.git.mina86@mina86.com> <20130212205141.GC25330@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 22:14:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5NAu-0000Fw-PW
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 22:14:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759411Ab3BLVNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 16:13:33 -0500
Received: from mail-ea0-f173.google.com ([209.85.215.173]:49210 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3BLVNU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 16:13:20 -0500
Received: by mail-ea0-f173.google.com with SMTP id i1so216599eaa.32
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 13:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=4wKZqxAzAA2PnGMGpfhhPRQ8C8EOOBMUQSNYHzlVyRQ=;
        b=SAWJfJqJdiVtw14tKu4MsYzOlRh5+xmpyCJLmH723NGy/uUgvH5C3PIlIlGsVXKj1i
         ZPN38e5Xsm3pgFe7rM3e7p53OXOxZkLuO6OyhKYgCSEfFko342eWbVPrauHGvCYoJojk
         lYGwGUL1Pt21M1gsiFRvOOpf9NNiFSgMl2dhVNleJhIX/OOzqW9CEBFzuSCkl18NCWiv
         +tl8Qo+l63qmCqMzujNpiA/jzuCMKv70h/fqZxtOpoD5lgez390Vc00CKja/6BkQk2OH
         rb9g9b/g9EceX2c+QogwLqvDzB/xA+OrWpVbAMKZKp9lyjIc2KN126uXJDXWKrcD2pLf
         CEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=4wKZqxAzAA2PnGMGpfhhPRQ8C8EOOBMUQSNYHzlVyRQ=;
        b=OlM4dR2G/BzqIGU7C3C+77Uxf7OyVjz20MIh2t/km/uNgzy9zHLdgzXiDeGv5t6bgw
         +WISk2ERWE6Y0GzmlQvempV8tDQgi5shZdVAmMtPcfehM+S2Dj4vCcVk9bkPA1Qy+1UL
         K3q51SQwi5Eic5kIdvJ+YtN/wtA07KwZ0FylDU+EVgJLY02sd42mnhfdg5m0By2hx9s4
         tVaaHGF9NZhXZUQu09MaD95v5xh0YV8DjJK2iR09CVVp1h5x5jnvQedSLu8jDugb7Ke7
         Wk5+QsamFTnyYvyekV463luFhBjALVEPS2qg3oglof4fCYIwMdEuE7HFIO3yWIhoR2tf
         12rQ==
X-Received: by 10.14.183.67 with SMTP id p43mr66400894eem.10.1360703597651;
        Tue, 12 Feb 2013 13:13:17 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:6552:be17:7596:e60d])
        by mx.google.com with ESMTPS id 44sm69870856eek.5.2013.02.12.13.13.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 13:13:16 -0800 (PST)
In-Reply-To: <20130212205141.GC25330@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQnC9hf5NA2Tna5hm+s6gOKP+BijLOJQwZwDmkcf30fuAzSMmMcZbSZZOqb7Ajx1jrlC9AAJovVsKbofKCf4I4Tac4Oi66W3YyqKavA/M5cHbMYOn2CyU8/jSYJQXJgDUSPyCVOlZZULlBkDdKnTPpqiaztX67fvWWbV/D1d8HmaaNrcqWpy7cosb5DNwttvglEh0cULJYOrvSO/xmF61J+vPoIO7w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216201>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 12 2013, Jeff King wrote:
> On Tue, Feb 12, 2013 at 03:02:31PM +0100, Michal Nazarewicz wrote:
>
>>  sub command_close_bidi_pipe {
>>  	local $?;
>>  	my ($self, $pid, $in, $out, $ctx) =3D _maybe_self(@_);
>> -	_cmd_close($ctx, $in, $out);
>> +	_cmd_close($ctx, grep defined, $in, $out);
>
> Maybe it is just me, but I find the "grep EXPR" form a little subtle
> inside an argument list. Either:
>
>   _cmd_close($ctx, grep { defined } $in, $out);
>
> or
>
>   _cmd_close($ctx, grep(defined, $in, $out));
>
> is a little more obvious to me.

I personally avoid parens whenever possible in Perl, but Git.pm seem to
favour them so I went with the second option.

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

iQIcBAEBAgAGBQJRGrBmAAoJECBgQBJQdR/0nVgQAI+laoHiapV8LkuYVbW/zVB5
uQM1IMBsytKXIZp2zRHiliT16nZE3GxU5PoeMzlBpShx2H3AqlaD9Mn09sIsTQ60
kw8fpLdvNegO0JjhD1js+yNvbjXZlWUPUAXq+kr9HL0CnCJedmB+VNWY0QQqvFqK
/1+X9TyAlwXKLx7HaYs0AEcfsHDecCjNiIY6V53Pw1AiyNjvXx8yvwhKp1VPkJha
Ny/g+iD8h721KADDO540eQANHVW1JIUcB8jwvXVU5YWVbYmsnWltPBzWzvvdJ8LT
YlSfVVaTTlfVdwsx4JVeNl3iuoxcZsW6AClAblJTz+TAJYUsAQ01M7xf9y1azKWz
Cjb86mUiQ5kmdyZRvaOzemzT9RV6nV6m/HIcA6MI50PFjyMoCR385dUDeMOUEwwX
arGrh/fvl36ugGjWjNQOKR27IYQDNZzN2i0friwsLvAcPt5d7Z653lEpJ7PGCuwH
YRyOud26BwNFhNj7xhsQqkW3LE/IxgG0HCfbNrZSrcCqyF7VbhNR/xbMurlYx0oh
uu7OOcRl1Ntg7SRKUubcOcBw37Ads2Mtf2E7SBhEgbunFfIL8eMpmSff3rsXaPkB
oKMU3t622O1rS/n8IoYW+tTj29V1Hmd3bACv49DjoqtzaZo66vabmCQFYShp1GHq
c0Nte7jgsl+nutc48QI+
=vmaw
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
