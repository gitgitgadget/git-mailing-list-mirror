From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Mon, 11 Nov 2013 21:39:42 +0100
Message-ID: <5281408E.10601@googlemail.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>	<xmqqhabilpzx.fsf@gitster.dls.corp.google.com>	<52812CC0.5050805@googlemail.com> <xmqqd2m6logx.fsf@gitster.dls.corp.google.com> <5281336F.7070103@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F7aCasHSu1jCxk7QRGea6q33aw9FU1ekv"
Cc: Ken Tanzer <ken.tanzer@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 21:39:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfyH1-0006tw-3X
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 21:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883Ab3KKUjr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 15:39:47 -0500
Received: from mail-ea0-f176.google.com ([209.85.215.176]:44988 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708Ab3KKUjp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 15:39:45 -0500
Received: by mail-ea0-f176.google.com with SMTP id m14so2446525eaj.35
        for <git@vger.kernel.org>; Mon, 11 Nov 2013 12:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=1tG/WrW63+54UL2kx3nUykSnZFHEbrQgnMayM5X633c=;
        b=XFOMHL0CqQQ+7ew2bgQSFv+pUtpNQjUXva/HUxhFHJI8cWYLYPrzjvVneZSMFj8bu7
         Me6DgW7fg5uVVpupLE76nqo0C0DWZTJa9WI29n1+l28dDhLlwogZe3zkwZQGeN/GfZnp
         n0+30CpEP69V7uMsVXfldulyyG5lDiozNlD+k30FpKBhZX29WTaTDEv1daF3NIvoEa4l
         029bb/Vsb+YLxtRFq/GCEH3XmSXpjs8Rr5XZ3AkLzAE8pRasT+LKvb188Rcw+67oZB5G
         2NcwWVQFHrqlH9FTfnV78g3VKfW3/ZasM6BNm97U9fCNkcbaNdV/ixNn+XEtTVBpRMxm
         NoMg==
X-Received: by 10.15.98.9 with SMTP id bi9mr4456502eeb.67.1384202384610;
        Mon, 11 Nov 2013 12:39:44 -0800 (PST)
Received: from [192.168.1.9] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id h8sm67236112eew.16.2013.11.11.12.39.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:39:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5281336F.7070103@googlemail.com>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237644>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F7aCasHSu1jCxk7QRGea6q33aw9FU1ekv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11.11.2013 20:43, Stefan Beller wrote:
> On 11.11.2013 20:37, Junio C Hamano wrote:
>> Stefan Beller <stefanbeller@googlemail.com> writes:
>>
>>> I do have this global config
>>> 	core.safecrlf=3Dwarn
>>> regarding line endings.
>>
>> Oh, that sounds very suspicious.  If the payload has CRLF, CR and LF
>> mixed, that would immediately violate safecrlf, so failing the
>> application sounds like the right thing to do.
>=20
> Not having read the man page, but copied this global config
> from some '1000 git tips in 5 minutes' years ago,
> I do expect a setting set to "warn" to actually not change the
> program flow except some inserted prints with warnings.
>=20
>>
>>> I was using 1.8.5.rc1.17.g0ecd94d
>>>
>>> Trying to understand the problem,
>>
>> Likewise.  Thanks for chiming in.
>>
>=20
> Looking at the file we have a mixture of LF/CR, LF only and CR only
> ending the lines. The formatted patch does have the same file endings
> on the respective line of that file here.
>=20
> I was trying to change just one line ending to 2 lines (LF CR -> LF LF)=

> with a hex editor, so there it becomes a smaller (and more debugable )
> patch. I also tried LF -> CR and CR -> LF, but none of these small
> changes seem to work.
>=20
> Stefan
>=20

Just having looked at the CRLF conversion code of git,
and then at the file again. This file seems to be a special nasty kind,
as the number of LFs is equal to the number of CRs in the file
(373 of 0x0a and 0x0d each), but only 343 occurences of LF strictly
following a CR, so there are 30 CRs and 30 LFs.

This shouldn't be as problematic as my first thought was, there is
never a direct comparison of stats.cr to stats.lf in convert.c.
The CR and LF count are only compared to either the crlf count or 0.

Stefan






--F7aCasHSu1jCxk7QRGea6q33aw9FU1ekv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSgUCOAAoJEJQCPTzLflhq44AQAOp3/UrW4IzMXACg9xwW6zjt
DskJRCCf/bdmajnjN5wqR49vwylBWRp1T0GuTisGGytmfEXW64KmolDmY8SgDIEu
/hEyhTkqQHmU4X98+SLXyEA7QBW1H4G/cZ+s+g7qr8FqfCDb+mbDl/ZISEVq8PzU
58U0Xq8oaZZ5j5ssbXJBI08FVYMPzEoi2XWKoh9g2AOtewWpikxj6qdOekn7Lv0R
Tk3UKBd02Qbj4bptC4xnfUHR8q+Gtae1EaSTsyiYuSEow3LklhkRrsDEfY2c7StV
TDKgMXtxWZPslnowQb2/W97JWXOZliwql8lKx+pzEH5+ekdv0xWlbw5vOy/uaexk
epO5oOix8+9EliwyL0rTv1P1kq9yQyU0LMCJT3lldGyqR/qEZlLz4PcipowrB1V1
J0pcxxDX9eP8JdXLhJrsuSje2HATCVhfByOEdqlj0jEgfy7G3B7x2Fr6jFtNuVoP
huGuiULg21vvINz35SmbF9Sjdp+tHbyXkiFY4sL9KXFI9zLCvnYqUKwFdRvjLP2p
xQ1XdbLgrE9DH7uRLI75P7iUdAvaXf//C/h7R3mVEE3FVSXqodkP1aU88KkRUr5Q
QSINBYKiE6dvyulJ+FODHi3x6D5P5CzEhcoS3Q4sFeFTJCESXQwFEkRVOONWSOqK
pCd/d2e5xSsg6NwEQs54
=lSFl
-----END PGP SIGNATURE-----

--F7aCasHSu1jCxk7QRGea6q33aw9FU1ekv--
