From: Michal Nazarewicz <mina86@mina86.com>
Subject: Re: [PATCHv3 4/5] Git.pm: add interface for git credential command
Date: Mon, 11 Feb 2013 18:14:24 +0100
Organization: http://mina86.com/
Message-ID: <xa1tr4kmg4cv.fsf@mina86.com>
References: <cover.1360599057.git.mina86@mina86.com> <2ec5dd694878055e9ce9d650889ee85369073568.1360599712.git.mina86@mina86.com> <20130211165331.GD16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:15:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wy6-0005nc-IP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757906Ab3BKROi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:14:38 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:60931 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757838Ab3BKROi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:14:38 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so3262310eek.14
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 09:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type;
        bh=cRGhqX1PYZyy+LNK6Zf/7r/8RlvQ6hi8eq33n5l/fRA=;
        b=AmAS/k+fPbyzm3LnpfSNY76crFYlZ5Bc7vEFnLrb9cB0mbCYy0ULlPfeJTjMij85x6
         toIhNujzOC8m1JFTkhtqSfd4E6bD3NUECzgx4gLrGpgXhPsVfo2x38sVYWfHOhP4YZHR
         JzJcdTph5f3OUSJ5X5++ZiSE7r3KcobLWK5o91sW7hjhf9fjm1E8nnsZJrrhVJiOPeuA
         N/FsSLV8NnjyPXsw0pvqqnlZ2BmXCv55uXI9HMuOxISUMcxnBibSxZY7c3/T5M6LR0rs
         ipxIBDogezDodRcy87otTUAaWayYQGYCii3EP7MddX9qgm2PsXECD0uH60ARh+23ylkJ
         kXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:organization
         :references:user-agent:x-face:face:x-pgp:x-pgp-fp:date:message-id
         :mime-version:content-type:x-gm-message-state;
        bh=cRGhqX1PYZyy+LNK6Zf/7r/8RlvQ6hi8eq33n5l/fRA=;
        b=cND5ollP/x6CqWNb9VKumnrn+dr1GQEGdlif4mPfhP+MX5Q8Rfn4j64ReAmx4mgnYs
         KCDBMiRzGUY0BZ5Wp2PYQls44TLjzllC99JCWjyZSKqyc+H2Yw0rhfTrslyXvql3GLIy
         jED9USk286PAduf1jL13oFBy16oPHPDH5BMyAmGWp62AKVywbM905R0LA3F6i6peze+9
         FuXgrYplRXLiZy/mb839YwlbGNYIilt7UiC6yaQws+4RYg74hwlQc4RhYvY4uTW9QVJS
         p2Ce5yZYDfZy0ZamirEpXvpCaoo6sm/NAS41/+nLw5SLY63RKIYiNq3Md5D8dzoabkiH
         x/wQ==
X-Received: by 10.14.225.72 with SMTP id y48mr14078523eep.45.1360602874730;
        Mon, 11 Feb 2013 09:14:34 -0800 (PST)
Received: from mpn-glaptop ([2620:0:105f:5:1d0a:8048:51b4:44a9])
        by mx.google.com with ESMTPS id u44sm3678374eel.7.2013.02.11.09.14.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 Feb 2013 09:14:33 -0800 (PST)
In-Reply-To: <20130211165331.GD16402@sigill.intra.peff.net>
User-Agent: Notmuch/ (http://notmuchmail.org) Emacs/24.3.50.5 (x86_64-unknown-linux-gnu)
X-Face: PbkBB1w#)bOqd`iCe"Ds{e+!C7`pkC9a|f)Qo^BMQvy\q5x3?vDQJeN(DS?|-^$uMti[3D*#^_Ts"pU$jBQLq~Ud6iNwAw_r_o_4]|JO?]}P_}Nc&"p#D(ZgUb4uCNPe7~a[DbPG0T~!&c.y$Ur,=N4RT>]dNpd;KFrfMCylc}gc??'U2j,!8%xdD
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJFBMVEWbfGlUPDDHgE57V0jUupKjgIObY0PLrom9mH4dFRK4gmjPs41MxjOgAAACQElEQVQ4jW3TMWvbQBQHcBk1xE6WyALX1069oZBMlq+ouUwpEQQ6uRjttkWP4CmBgGM0BQLBdPFZYPsyFUo6uEtKDQ7oy/U96XR2Ux8ehH/89Z6enqxBcS7Lg81jmSuujrfCZcLI/TYYvbGj+jbgFpHJ/bqQAUISj8iLyu4LuFHJTosxsucO4jSDNE0Hq3hwK/ceQ5sx97b8LcUDsILfk+ovHkOIsMbBfg43VuQ5Ln9YAGCkUdKJoXR9EclFBhixy3EGVz1K6eEkhxCAkeMMnqoAhAKwhoUJkDrCqvbecaYINlFKSRS1i12VKH1XpUd4qxL876EkMcDvHj3s5RBajHHMlA5iK32e0C7VgG0RlzFPvoYHZLRmAC0BmNcBruhkE0KsMsbEc62ZwUJDxWUdMsMhVqovoT96i/DnX/ASvz/6hbCabELLk/6FF/8PNpPCGqcZTGFcBhhAaZZDbQPaAB3+KrWWy2XgbYDNIinkdWAFcCpraDE/knwe5DBqGmgzESl1p2E4MWAz0VUPgYYzmfWb9yS4vCvgsxJriNTHoIBz5YteBvg+VGISQWUqhMiByPIPpygeDBE6elD973xWwKkEiHZAHKjhuPsFnBuArrzxtakRcISv+XMIPl4aGBUJm8Emk7qBYU8IlgNEIpiJhk/No24jHwkKTFHDWfPniR
 4iw5vJaw2nzSjfq2zffcE/GDjRC2dn0J0XwPAbDL84TvaFCJEU4Oml9pRyEUhR3Cl2t01AoEjRbs0sYugp14/4X5n4pU4EHHnMAAAAAElFTkSuQmCC
X-PGP: 50751FF4
X-PGP-FP: AC1F 5F5C D418 88F8 CC84 5858 2060 4012 5075 1FF4
X-Gm-Message-State: ALoCoQl++ktcMQyCyxKBZkJpNqKPGKuNj54RW01Zbax/dglcQHe4G7au5VUicG6TlhUCJbNiQEn/H/hV9L+dZbHOg/ypTZe+XJ7MHGjNwTjP1oFB0rv36MoYDLUTgg1MNggNdxpY2N8a3GEWiCqjTw4qGncYmgclZvWIwixYr/kHXTRsgBo+BxLtTgrgTg8dGaa62KOX5jQ25ggBr6UGpRIwbWKczCOJsQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216057>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 11 2013, Jeff King wrote:
> On Mon, Feb 11, 2013 at 05:23:38PM +0100, Michal Nazarewicz wrote:
>
>> +=3Ditem credential_read( FILE_HANDLE )
>> +
>> +Reads credential key-value pairs from C<FILE_HANDLE>.  Reading stops at=
 EOF or
>> +when an empty line is encountered.  Each line must be of the form C<key=
=3Dvalue>
>> +with a non-empty key.  Function returns a hash with all read values.  A=
ny
>> +white space (other then new-line character) is preserved.
>> +
>> +=3Dcut
>> +
>> +sub credential_read {
>> +	my ($self, $reader) =3D _maybe_self(@_);
>> +	my %credential;
>> +	while (<$reader>) {
>> +		chomp;
>> +		if ($_ eq '') {
>> +			last;
>> +		} elsif (!/^([^=3D]+)=3D(.*)$/) {
>> +			throw Error::Simple("unable to parse git credential data:\n$_");
>> +		}
>> +		$credential{$1} =3D $2;
>> +	}
>> +	return %credential;
>> +}
>
> Should this return a hash reference? It seems like that is how we end up
> using and passing it elsewhere (since we have to anyway when passing it
> as a parameter).

Admittedly I mostly just copied what git-remote-mediawiki did here and
don't really have any preference either way, even though with this
function returning a reference the call site would have to become:

                %$credential =3D %{ credential_read $reader };

Another alternative would be for it to take a reference as an argument,
possibly an optional one:

+sub credential_read {
+	my ($self, $reader, $ret) =3D (_maybe_self(@_), {});
+	my %credential;
+	while (<$reader>) {
+		# ...
+	}
+	%$ret =3D %credential;
+	$ret;
+}

I'd avoid modifying the hash while reading though since I think it's
best if it's left intact in case of an error.

And of course, if we want to get even more crazy, credential_write could
accept either reference or a hash, like so:

+sub credential_write {
+	my ($self, $writer, @rest) =3D _maybe_self(@_);
+	my $credential =3D @rest =3D=3D 1 ? $rest[0] : { @rest };
+	my ($key, $value);
+	# ...
+}

Bottom line is, anything can be coded, but a question is whether it
makes sense to do so. ;)

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

iQIcBAEBAgAGBQJRGSbwAAoJECBgQBJQdR/0zHoP/A/D12Ga2GQGThRv1JfSWDwE
E6wHshlKVVoTxcZ1ZElMMik5gCZbWolxf++gvv+uuC0rVVzRPUcIg5pDKg6M0IOQ
z/LK7Dwa+hIGKWUzZM6z+o/byBpzbCQtGa2kKXPxu0wMv4g2/+FBjD9g8BYJ6JiM
AfmvxTpqA033NIre2HegaNZfeej6sXz255NUR6jeeFhkMQgpudBYNxB+sWgN+FyD
wzLhkNVko2QZ+6k0+uoH2MHmmT7QFUfR8p31qM1DtT9Ckii/1mHI52vF0GHgB9IZ
yzo7T+7QxusnfH9wzjCzM1PGoRf/jcCScYgKWHoqqMZSMjtNrQSz6v3USQHQEvSN
+zyXRp/x+0+nCvrM7gHpFaZc0doL8Qsg/JhzL/RGbHsCSkc58E/u/quvXlTrcW2+
Xzw7YesE8v+eTnjbefaEJkuX7XygnKUoVyobe4nFjZtpEMNvTz8RsjQTIgG24H/Z
vaQtSj6y9CadLncpBj8uCWLKZRnG4zkFFPtFsV8meluzwHsXtEB5jfQTn1zvZTZE
LHhPsgT1fSjPJcwb+r3PPfP/5weZIaM7O2oTYhAK0ikhtGxVvDmdwWGBPdqdplSP
DwpzplbTX8cg9xcEOc4ba1Ni0PS9/djDEk9ne9h2dRhkJK4FQcIMol5Xh4dT+zM0
+Qx2qGJtitFeH9MHaMDa
=i+Tu
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--
