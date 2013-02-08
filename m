From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv2 4/5] Git.pm: add interface for git credential command
Date: Fri, 08 Feb 2013 02:37:53 +0100
Organization: http://mina86.com/
Message-ID: <xa1t6223poum.fsf@mina86.com>
References: <cover.1360242782.git.mina86@mina86.com> <cover.1360242782.git.mina86@mina86.com> <78516627e893e54d5aafe0694d1face9a37893de.1360242782.git.mina86@mina86.com> <vpq38x8m06f.fsf@grenoble-inp.fr> <7v7gmj66fq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 08 02:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3cv7-0008Uh-Jo
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 02:38:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759453Ab3BHBiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 20:38:04 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:57400 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab3BHBiD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 20:38:03 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so1348643eaa.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 17:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=YFb/d3u4uMjvoEOoSVxcQZNHMjTBeMOrh708MsJOQxg=;
        b=YbSSPDDqSK3uKXA9btO+A9fvSRK1Ikt24iGlEVJTv5Rby0gop6ADtCJ8cc2MoS34CO
         roD/LKbuKiiuWfpQB9lrrwTTEnEP9QPDdvJOIl8cs4Tz7NWKroAJ2fp1Z2PY3RLT00y3
         SQPUbGE34Wtnk2iJMD+W8MzRqfuwtHV9/mqPGXhWSHjZpIJTeL4j9mRU6PmQsl99zr5s
         3RUoLsQdPVzvMar+Qws3ovp2I5zJU0L4tHc1KmHS83DRxCzR/X/FYTxTmq7EiVZaUr7T
         x0kOvWTho0sK2YSAqb9PiLyAMWpb8yDIOOunAJSXNfL/yKEc+Pr7SQKLLYtDVqG9Cqgh
         VFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=YFb/d3u4uMjvoEOoSVxcQZNHMjTBeMOrh708MsJOQxg=;
        b=Mr3KiihcRtGugebINvfDKcj+sdB0q5qP/mlBOq7pFDolVmgMGFvbxyFN6YWNp+7Cuo
         AWiCPOyPoOB1V51GvZ6peQJhvSQsnyKwRNuPHj1savGMq2RJwBEDXCxWWqZdkbTNl0py
         vTaPbmP7Q5GJBoa55/c8WqvK3gytzSHe4WptceuZQOb7oVJSwg9iknDRm8sH47+e+oZQ
         Hgq79yKwjRmLWK8H1dLTa4f86e7oBFSi0uVZATlY+YKlCtx4zU+4kkjmUOD0iATzj5+p
         /ntoIoOLra3dSY2Bfb+D5Vj27ULe+kKOpaHkP5SUOk6hTuPo/6asMHmugJGS/i8l1hEs
         vEmA==
X-Received: by 10.14.194.195 with SMTP id m43mr10122500een.44.1360287480721;
        Thu, 07 Feb 2013 17:38:00 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:bdef:84b9:750e:31d0])
        by mx.google.com with ESMTPS id s3sm6459210eem.4.2013.02.07.17.37.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 07 Feb 2013 17:37:59 -0800 (PST)
In-Reply-To: <7v7gmj66fq.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQkt1T6DmG+KVMXIC4lLcl/1wwrGZSD/z3CDtEn3FQoaLvcZiLG9feWXxUZwi5MJyyf9A+HmmMIHC4Xia+ZUJ4oogCLOriRAl4gZ0S6tRPr/5Y8aq1v+CWK1ruEMPaiBCcIgrfPICNzZfx8yW+YxgpplLWk84a9C7Cr88WC4TYG7YIbLQ5+aTaa152qiT2D0rE8SdT5g9q2GEif33PyLfwZWbfrbSA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215741>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08 2013, Junio C Hamano wrote:
> I'd actually be more worried about the error checking issue
> Peff raised during his review.  I have a feeling that "when in doubt,
> do not cause harm" is a more prudent way to go than "I do not know,
> so I'll let anything pass".

I can implement whatever checking you wish, just tell me what to do in
corner cases I've listed. ;)

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

iQIcBAEBAgAGBQJRFFbxAAoJECBgQBJQdR/04BgP/3LO99kGxBtvOvDK1GO48GBU
BkJEXZz0S8spyEbmEpWtZRJZ/r3ij1WUVL8Z3DXmm+taazikxKMRdEPP519iEZv7
ZbxcwsavRHtkrs2ZiP6CpE4InxXi6FvmSeg2TCOcFXK+nMxjuok42O14Errhlh4v
EZIJk65ej3NG0vkH+TnuqNv13F0Yx0byR9VuHkp2KXrS6yrIv7X+KDojVbtFk3k9
V3a66HBAs8V4Netrnog17hEpxL+/S3MygdS/JjBVm1zHGcNXI8dhipfZELqd0gMJ
fVP8AKpw9V7EJLeFIgpDRUzrweSLAm5K4VdsBmAEPJIK9ho82tEOo7kQ28ZpbHQI
kppvqym/JqzXoPETP0VmGIuyFHwTjeqJ/hj4iTNcP6tC9/pCC1HjI6KJZ5znPKws
TunYotA1/QWDHNHouCZOe57ivmJiu2HGYVqCLTAgdlZngevoG08CgjrORfofpOvL
auqhvI9urPS2ys7v/zwJGSGwuVUMm8WurllZs1u50PFCRo0GM7wRyxVWe/JORj9G
ETLSeVnlyqd6D0VlhBbNWpVnpDId68xW4N8wuYNBgUVcrw9Rcbh3P9rzOz31yGuD
Wr9iSEeRScLX7PSJIggvMU8uL/DHROZjI6m/3iR0mJPjU4Dfr9eNpwNr15Dzgt9O
6NRhd27ZJvZnT4UEVoC2
=RUyw
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
