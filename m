From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv3 5/5] git-send-email: use git credential to obtain password
Date: Mon, 11 Feb 2013 18:17:27 +0100
Organization: http://mina86.com/
Message-ID: <xa1tmwvag47s.fsf@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com> <fd7997960cad569d57f5330f2416f702db414169.1360599712.git.mina86@mina86.com> <20130211170134.GE16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:18:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x0y-00020I-Er
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111Ab3BKRRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:17:37 -0500
Received: from mail-ee0-f42.google.com ([74.125.83.42]:61893 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab3BKRRg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:17:36 -0500
Received: by mail-ee0-f42.google.com with SMTP id b47so3271184eek.15
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 09:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=3L8BODVpKUts/vYuRk95/YIYUqiaULxBV5A5lYXaNdc=;
        b=nDiq+sYYhFXEVCEfFfMdtIaexMI10DJ2rune6qSlKWNig/mtC2ZzJiNzJbWCAxDI8g
         WbB8cs0r3qYoau7smLHe+FoYt4H5J4EXpzNlgk5tzUF43T5zoSE+KVPFyLGzTJjLq3hw
         gZ4a8S/Pugfrb9E+MHjIqGv90yaKgojS73+Xi+fWH/SbTbLJXkqyV+SdFC6hiCel6Tgf
         pNQlyDv/t/nKXglDzBV/gcOK9yIARiEiTUSSc90J7LWO1gHdbyjvSuR2HSAb847XoR0s
         Vo3icb76PR6fhQuoxE4zlIKMd7TB1NXx4Tocee0EFGsr8NV6eKvBaTDphQr24vjEMP+t
         5jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=3L8BODVpKUts/vYuRk95/YIYUqiaULxBV5A5lYXaNdc=;
        b=gP5Cm989ChR2vs1jzvw3DW+ZL1daupvJHxtVv7p2msZsgwzFq01+xxlpiCxuZe/sTm
         Upj/AsSKEDORsu3e4snbN2t0zClfTJnW4CMCxxZztFtnFAjfivL+9n6VgCb7ciiNkx93
         iIdSYdlmt4un5x8yxLaRjQaS43f6/h56+IIz9BT09p+dazqr6iFX00FBF8eck2uo/M5Z
         Z7ibxzVueLfZvCwIIsM9aYGJXlJYyE5aBDlgQDDkkewX9FBa1GnwkNGQvVPJy0l7d1mz
         uh/xVbnYEf7RootD0/3gP+WtlmTktgxxPh+E9EjgSP8j9NEckle10j5rZVThK8bt42eO
         LEtg==
X-Received: by 10.14.219.5 with SMTP id l5mr52822906eep.7.1360603054566;
        Mon, 11 Feb 2013 09:17:34 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id q42sm54353693eem.14.2013.02.11.09.17.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 09:17:33 -0800 (PST)
In-Reply-To: <20130211170134.GE16402@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQmmi0skTu42WFrzGsHtlJzw+30hVl8aDod+wScFHpufCzY953SLKLS2NxkhET3rEVMA5GqP1lu4CZE0HVkrTaATCs0MKiK8ZscrU+0/3M19KJkYuRtmeCN39BLFSvdaZqal4x1oox0rNGzc9MrNGG5c2FQdP1ZG6WvsvodsupkERS4S2UbAPXXrEtsG9OOmjUPHkZAxb4VWe0ojkh4A7XA94kx8qw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216059>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Mon, Feb 11, 2013 at 05:23:39PM +0100, Michal Nazarewicz wrote:
>> +	# TODO: Authentication may fail not because credentials were
>> +	# invalid but due to other reasons, in which we should not
>> +	# reject credentials.
>> +	$auth =3D Git::credential({
>> +		'protocol' =3D> 'smtp',
>> +		'host' =3D> join(':', $smtp_server, $smtp_server_port),
>> +		'username' =3D> $smtp_authuser,
>> +		# if there's no password, "git credential fill" will
>> +		# give us one, otherwise it'll just pass this one.
>> +		'password' =3D> $smtp_authpass
>> +	}, sub {
>> +		my $cred =3D shift;
>> +		return !!$smtp->auth($cred->{'username'}, $cred->{'password'});
>> +	});

On Mon, Feb 11 2013, Jeff King wrote:
> What do we want to do about this TODO?
>
> I am happy to put it off until it becomes a problem, but I wonder if the
> Git::credential() interface is sufficient to express what we would want.
> It only allows two return values: true for approve, false for reject.
> But we would want a tri-state: approve, reject, indeterminate.

Being it tri-state is not a problem.  The last can be easily represented
by undef.

> Reading the Net::SMTP code, it doesn't look like the information is even
> available to us (it really just passes out success or failure), so I
> don't think we can even make it work now. But it may be better to
> prepare the public Git::credential interface for it now, so we do not
> have to deal with breaking compatibility later.

I guess.  I left it as is since git-send-email won't make use of the
indeterminate values, but I can add it in this patchset as well.

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

iQIcBAEBAgAGBQJRGSeoAAoJECBgQBJQdR/0rq4P/iAGbFyhmrcfrkqUJ0AGy6qn
HY35uXZHRzIbxNRwlUEZzEOyhqyfoo63aiQXfVY7wSU8B4Vgc9+nIXAwCRGPL99P
5GCCb2MnDsxq1QzIKltWeGpF2rHfstrVNyRmI/VyysUHEn2Ln6NuQxhceqDFOYiS
3cNAGYhVBEaZqhX8NAkUrFXMi+Bh32OpHBnos6Zf5wX0N9TGYvJi+TghZuhKnqty
/LqSyvhQhgVR+4aT3oTcLZRJYCBPC487/SHqjoUoXLC09jf0nmr0nFLO8tbKkZRM
rN0TkWcRGJ/LcFrcJ/GHBI4uUB/WuZLBPt9YS6I+Qtwr2Ac4zIIRA7M6EI022b5a
5m4psP84XfELBcV+LtiIavGI8BRqTdJmDnJrZmQnWsY6pOI3GyUHRsjXG0heeErO
nhe0PqDlBNEjRT8Zl5LQtDl8TrsOJhTARBwXKdxSL+T8K6G/p3UeB20atC0LqnEB
8ige8ruzjqYIG97QgMRGd5aR+/jyFds9DVfT2GKKuzFWlblCDN3CA4S24UdlAXhu
4LP4STiM+o92GqTVEsTQZ53UNU+9eqLJvifunI/zr2e6PTmzGAsj/fOZdT2ndm5/
QQV9Ae0+VnclEqIPBLtjZqYXBwf1PCkxSFpgAsfnGyAh3WcofOm/CRXhNpmPKwkp
6dJRiXZ3bX7767WOEu6x
=KES4
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
