From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Mon, 11 Nov 2013 20:43:43 +0100
Message-ID: <5281336F.7070103@googlemail.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>	<xmqqhabilpzx.fsf@gitster.dls.corp.google.com>	<52812CC0.5050805@googlemail.com> <xmqqd2m6logx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E8LQEOQ2cFhbrLWoXTBCBmNBnHEakQM5l"
Cc: Ken Tanzer <ken.tanzer@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:44:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfxP4-0004qW-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755362Ab3KKTn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:43:57 -0500
Received: from mail-ee0-f43.google.com ([74.125.83.43]:43045 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755351Ab3KKTnq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:43:46 -0500
Received: by mail-ee0-f43.google.com with SMTP id b47so2695798eek.30
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=MBfKe3MtWX7vELTjp1Jkykq2rPttVQFgZMFG7lSnBGM=;
        b=IYFgkJZzChc1DJDnMVjy274qnTh67MXQyvvC5ZzPhBWFgj8fV7vpJAyFAqr7wYiu3f
         HNqw0eeC/bdtZZPl75JWTjyna/w7qE+JELgBdRP2gao8R0Sb+5iYeVXyfHHFvk+FIcFu
         T6OSEq0f4ocIKsmKJ/DgxIUh+y8pDw1bQIh0Ua+TU5MV9/khrOXb214n3R2y2Q9dx1v8
         W53jyESyKACvMOQ8TdRdz+1UJy7r2ZSQXShRewizoY2Lex0MJg1UIVoECtxBD9bCJUtX
         Gk0rK//hDrYZYvgeAm32A7YYqkVE2FhkhNFcQr8gsv4Nzgy8eF4gLk0SW6qdqSAnllTS
         Q26w==
X-Received: by 10.15.109.130 with SMTP id cf2mr15867eeb.146.1384199024951;
        Mon, 11 Nov 2013 11:43:44 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m54sm58411589eex.2.2013.11.11.11.43.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 11:43:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqd2m6logx.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237641>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E8LQEOQ2cFhbrLWoXTBCBmNBnHEakQM5l
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11.11.2013 20:37, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> I do have this global config
>> 	core.safecrlf=3Dwarn
>> regarding line endings.
>=20
> Oh, that sounds very suspicious.  If the payload has CRLF, CR and LF
> mixed, that would immediately violate safecrlf, so failing the
> application sounds like the right thing to do.

Not having read the man page, but copied this global config
from some '1000 git tips in 5 minutes' years ago,
I do expect a setting set to "warn" to actually not change the
program flow except some inserted prints with warnings.

>=20
>> I was using 1.8.5.rc1.17.g0ecd94d
>>
>> Trying to understand the problem,
>=20
> Likewise.  Thanks for chiming in.
>=20

Looking at the file we have a mixture of LF/CR, LF only and CR only
ending the lines. The formatted patch does have the same file endings
on the respective line of that file here.

I was trying to change just one line ending to 2 lines (LF CR -> LF LF)
with a hex editor, so there it becomes a smaller (and more debugable )
patch. I also tried LF -> CR and CR -> LF, but none of these small
changes seem to work.

Stefan


--E8LQEOQ2cFhbrLWoXTBCBmNBnHEakQM5l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSgTNvAAoJEJQCPTzLflhq3IEQAJL5xJIzjrj29JaXrLezTUub
09FW+YzAc0Y9coGVBw4VZ+E1/lnp0jdpcocGCB8FpE8Y9v+xHp92yoTlySSPhViG
ixvC1bWYqxxAMgwatLE/PXQs54RgM3qZ2J6vRSFRpanz3iq6XQ/Gx+ucLlgCwVkd
w2uztuzKrjtxXWDP3hkP3Wb/0FiQC6ZVziX4K9c/PeXMJ6i7JLjxzc5gNRcMUKBY
3EAk/Td5R7HBXay+n2x/u6C2mxmfUeL4d9n5On5WrRHOCOXF3uY+Sv1xGGmOOaTX
TDbw/Jv2WpyktY5m4R2P2IuUB2uEVzOqKzLIEl/WoIbw34q8OWstVivubW4zeEe7
AQtMCJx/gA7teYPn5ZF/MYxAVbUgsswFGzuLuWnmlxQYFhqujr+0+afmIUV9mNck
AW7uKknFgqII6N3eGcg15n+irigPV8YDBZF449qdNhwsAoFE0AJcur6R9YRVL7+f
bV5q9jDhX9LHOBvdwALOzJaVeOnhioeByzj9tlGHYybwReMmeicGoDw0LWPisAch
FKLTeGXCkpiwkyaJ5zo/PiHMjbRk+wmugrGxud4hSBwie6foAIRWKBvh5GqrTTgj
xZCJZoEWZpvJTR2Qu6cRTZg5/0vPixGaTlomMJaCwARAzX4sGi4VsagVLlNZCcbq
cN4jr+N6ZeR+ARsjrKT+
=jkEk
-----END PGP SIGNATURE-----

--E8LQEOQ2cFhbrLWoXTBCBmNBnHEakQM5l--
