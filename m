From: Jacek Wielemborek <d33tah@gmail.com>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 6 Jan 2016 10:27:33 +0100
Message-ID: <568CDE05.5040602@gmail.com>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <20160106002333.GA16090@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PT7h5gIXqO7bxFuHGSCL0u3ceDJWrtd8L"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 06 10:27:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkNg-0004vo-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 10:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbcAFJ1k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 04:27:40 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34960 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcAFJ1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 04:27:37 -0500
Received: by mail-lb0-f194.google.com with SMTP id tz10so19267517lbb.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 01:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:mime-version
         :in-reply-to:content-type;
        bh=jfwv29oWIA97N0gKakPd6Q5AlVexg6sQMlmyyVNntu0=;
        b=CK4NKoHX6Z5pbIp4sBV5F0J4SgcNtJIkbe+hKD/V7phZouemNVTMcvQWtD7VHuQHY7
         djzD/KMwwNVoYcEFX4lTq/vA7UJLF0+4AvEhZzC0H6gyruVxysSa5R1eQC23UQjidLje
         lew3td2dc66Te1skSzc2Irqfsvk9hWrOs4wqr14lesvuDsE0YrXpyOXqSFRol38sOIf9
         9eaWmICfc+nQcFn+nd0eoNHbi0ARHARcxTMCeP5KuWZBV+jL+FU8Bd539NATY9tg6EoL
         NeSsvDYTrgIyA6dLqO5jlFCKdZHWsFzHOjFxytr/ZVIbc5Io2q02d7q3+Y3y0QQ+ClST
         yzYw==
X-Received: by 10.112.84.44 with SMTP id v12mr34476945lby.46.1452072455576;
        Wed, 06 Jan 2016 01:27:35 -0800 (PST)
Received: from [192.168.0.50] ([185.5.219.249])
        by smtp.googlemail.com with ESMTPSA id rp10sm389930lbb.13.2016.01.06.01.27.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Jan 2016 01:27:34 -0800 (PST)
In-Reply-To: <20160106002333.GA16090@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283426>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PT7h5gIXqO7bxFuHGSCL0u3ceDJWrtd8L
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

W dniu 06.01.2016 o 01:23, Jonathan Nieder pisze:
> Jeff King wrote:
>=20
>> Git packfiles come from two places:
>>
>>   1. Local maintenance repacks loose and already-packed objects into a=

>>      new packfile. We trust the local repack process to generate a val=
id
>>      packfile (though the contents of individual objects may be
>>      untrusted, of course).
>=20
> I think we should reconsider such trust.  If one user creates a
> malicious pack, if another user uses read-only git commands to access
> the repository (after inspecting .git/config to make sure it doesn't
> contain anything scary) the result should not be arbitrary code
> execution.
>=20
> Producing bogus output or aborting is okay; arbitrary code execution
> less so.
>=20
> Thanks,
> Jonathan

I'd be happy to help you go through the fuzzing process - I don't have
enough horsepower and codebase knowledge to do it on my own though. If
you have an afl-fuzz question though, let me know.


--PT7h5gIXqO7bxFuHGSCL0u3ceDJWrtd8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWjN4FAAoJEGlViymZXJRvLQEQAJ+l2ch8pnVAta3xUCSyl35g
K9a9V2NgE59ZkIpXBO0ODtY+O4mGkCFmfXLXzV0giYkxagwNYomVBfw/RWOcWoZZ
OlIaHngBmt4DB3kYC6gFWPSaP95k6xPqUoKtPDL/iLXag5e6P3Xk5g5KFmmDIiR5
5KJzjidEebQsm7W+a+dJFYPWEGxi8TgEOvgMyyROI8QVElADw9kTvGodjbda5DAR
3hFbF155foBFNT9pe6qQs1gxIpn0v4jvOdmMxRze+ljBYoNNieXNAVPUKwt5suCA
1g4Lk7OjNzYh2/2kyFAgtdBa78fQq4X/B5mdzgzfnIiwQLvon0yLRkFCnj0wuHq8
oPlRpW7IXRBDcQiqNOvbiL8e25eQ/1qTgqG/GUbyAureXHXAtCBMjPKnHf0RGobV
UObeVA36oq8JZuQPIPs6agIsY89KECARbU1WUXSRRi4FMNcFaFHGEYxrGwvRHVwu
5PjjCdl3NGJ6rAC1p4Kvx+GoOR9AdIaRsjCT+5r1nZMLIyQDJX1vI7UckEnHHZFl
n5prfhl8DZvhmdA3pbhs71xzPPUMSz4PID7GOi3CKW+QHouxuEyPOOGj4wSHP3yg
XPnpXLAntGDRYMbKs49AgizIvlxit+XLn1+ahSAhRWJ62Yj5KFT/LICPxVRJ+jke
3hXdu0nnc85fW8yuVDqn
=+Q/P
-----END PGP SIGNATURE-----

--PT7h5gIXqO7bxFuHGSCL0u3ceDJWrtd8L--
