From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 21 Aug 2013 14:53:38 +0200
Message-ID: <5214B852.7090504@googlemail.com>
References: <5213EF74.7020408@googlemail.com> <1377038334-15799-1-git-send-email-stefanbeller@googlemail.com> <vpqhaeje8e0.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC31D3504D24B2FB166ED21C9"
Cc: git@vger.kernel.org, mfick@codeaurora.org, apelisse@gmail.com,
	pclouds@gmail.com, iveqy@iveqy.com, gitster@pobox.com,
	mackyle@gmail.com, j6t@kdbg.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 21 14:53:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VC7uv-0000Ud-SP
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 14:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751802Ab3HUMxh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 08:53:37 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:35583 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698Ab3HUMxg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 08:53:36 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so212824eek.22
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=AKvs5vdrsaYjuYqV8GphvLA/y335UjpeDaHYPn+3GZE=;
        b=xpyRh1j60tuKYGEcclyouw+uGc1J6kGaUiU7Sy4o4b+q5Fo3ntC6/n0Z04lLEbAu7M
         xxaHwzCg1JeBZmU07b1J91hS4RAZO68tezB4asOfOR+/O00q+kwcrwqUN1lRpulK5lqI
         xMy6KiRzfBAvzfB54FpJVz/gbQuWoli/AJShYu5ZpeRaYyQg0R/54At9OPujzmLn8mMh
         g7ga3/jDTgHeh3I+KZWSPYtMdgHKpBw2k0M4tFyOkVdfP1t1E/uZhDPUZEKV1NbHK9z4
         Jk/N9+tYvqKP4JTpMyvEpzaTN4rVpi76MUcpegzm/S6cNpvMfx2o20T+LC2CrcAETxyw
         mPXA==
X-Received: by 10.15.100.198 with SMTP id bn46mr10170846eeb.11.1377089615829;
        Wed, 21 Aug 2013 05:53:35 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id p5sm9616988eeg.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 05:53:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <vpqhaeje8e0.fsf@anie.imag.fr>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232699>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC31D3504D24B2FB166ED21C9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/21/2013 10:49 AM, Matthieu Moy wrote:
> I tend to dislike these "set a variable and break twice" to exit nested=

> loops. Using an auxiliary function, you could just do
>=20
> int f()
> {
> 	for_each {
> 		for () {
> 			...
> 			if ()
> 				return 1;
> 			...
> 		}
> 	}
> 	return 0;
> }
>=20
> (Matter of taste, though. Some people may disagree)
>=20
> A good side effect would be to move some code out of cmd_repack, which
> is rather long.

Thank you very much for the review, it helps me very much to focus
on the small details.

I intend to have the C code in this patch as close to the
shell version as possible. This goes both for functionality as
well as style/organisation within the file.

All the additional changes, such as this one
(Or in the previous mail, retaining the error code of subprocesses)
I'd like to put in small follow up patches changing just one thing
at a time.

But as these follow up changes heavily rely on the very first patch
I will first try to get that right, meaning accepted into pu.
Then I can send patches with these proposals such as making more
functions.

Thanks,
Stefan


--------------enigC31D3504D24B2FB166ED21C9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSFLhSAAoJEJQCPTzLflhqMtcP/1ht/r4TZg+Ofqe3mNPG4QBW
oUd+l6qzKqn0EMaj83a0d9YfaZq2hwavGCWQQiUaqUFo9Kv87svSVBaw35U7doOZ
htRS8TMYulPmmPziQ8ovCntIZvwUBg5nFEaTNOY8d0bBetFyaFaoyU6ctjL6ucpl
dueZ25jZdP3iPcD+9bHPxaJzjx9yeczaEoEdGy62aqKBZBcc7Um/VBb3QPAeGyvc
QpLN/CXPfYKAE73WtbGRXoqttgNLnIxYf5mnDZTsQFpkyabZXIgi33yrmgjri7oj
5BlsIwe+Z1dVlFyfaSaSPMYo5FUUQjFzsyUKF4UIjWIth9H9PWe0aj1WBkdMxMss
/eUWGBU4prOX5TiGEToV4Qn9AvUCEx+1IrXNawM9q7eDWZRva9qKq4chleatcrPO
SdezZYciJv9qfjlA5eqIHPye4dJl8j6SIIgml58tPgReCfyMGrVt5PXzJb3Zpwcx
dH72gMYOuQCsibH2gFac8iBin2xu9HuRw+OtGXTt1m8+Z709flhT2101Vg4pZLyU
Kzx3HluOm7E0dCU0teqs4PrywiNfhnhZp44to5xWJA/qo5G+ea2Hh9J7rlPyaC5p
g0OR/IsWziPj4cOnGzli57i/IczsIPmOT/m8TwsGAXyKucj3a5j7saH7wQDHdPFv
0i7V+//3zYoRdhr3QKIS
=iuq7
-----END PGP SIGNATURE-----

--------------enigC31D3504D24B2FB166ED21C9--
