From: Josef Kufner <josef@kufner.cz>
Subject: Re: [PATCH] Add tests for "Pass graph width to pretty formatting, so
 '%>|' can work properly"
Date: Fri, 11 Sep 2015 22:25:30 +0200
Message-ID: <55F338BA.6070201@kufner.cz>
References: <xmqq1te428xl.fsf@gitster.mtv.corp.google.com>
 <1441993845-25778-1-git-send-email-josef@kufner.cz>
 <CAPig+cRkSRSC0eaBencw8cFrd64sUBQE44aSJ0T2WyPg2JTFCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2J6Fuv7cTos4MT5lhq7wxhN44GKmf1oSr"
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 22:26:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaUtD-0001TU-Nu
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 22:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbbIKUZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 16:25:39 -0400
Received: from max.feld.cvut.cz ([147.32.192.36]:42105 "EHLO max.feld.cvut.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbbIKUZi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 16:25:38 -0400
Received: from localhost (unknown [192.168.200.7])
	by max.feld.cvut.cz (Postfix) with ESMTP id 51F2519F4BE0;
	Fri, 11 Sep 2015 22:25:37 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from max.feld.cvut.cz ([192.168.200.1])
	by localhost (styx.feld.cvut.cz [192.168.200.7]) (amavisd-new, port 10044)
	with ESMTP id P5Rcr32Y45yP; Fri, 11 Sep 2015 22:25:35 +0200 (CEST)
Received: from imap.feld.cvut.cz (imap.feld.cvut.cz [147.32.192.34])
	by max.feld.cvut.cz (Postfix) with ESMTP id 5A86119F4BD9;
	Fri, 11 Sep 2015 22:25:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.1.0
In-Reply-To: <CAPig+cRkSRSC0eaBencw8cFrd64sUBQE44aSJ0T2WyPg2JTFCw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277695>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2J6Fuv7cTos4MT5lhq7wxhN44GKmf1oSr
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Sunshine wrote, on 11.9.2015 21:37:
> On Fri, Sep 11, 2015 at 1:50 PM, Josef Kufner <josef@kufner.cz> wrote:
>> ---
>=20
> Missing sign-off. Or is this intended to be concatenated with the
> patch you sent earlier?

Just forgot to add it. Fixed patch on the way.


>> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-format=
s.sh
>> index 7398605..3358837 100755
>> --- a/t/t4205-log-pretty-formats.sh
>> +++ b/t/t4205-log-pretty-formats.sh
>> @@ -319,6 +319,18 @@ EOF
>>         test_cmp expected actual
>>  '
>>
>> +# Note: Space between 'message' and 'two' should be in the same colum=
n as in previous test.
>> +test_expect_success 'right alignment formatting at the nth column wit=
h --graph. i18n.logOutputEncoding' '
>> +       git -c i18n.logOutputEncoding=3D$test_encoding log --graph --p=
retty=3D"tformat:%h %>|(40)%s" >actual &&
>> +       qz_to_tab_space <<EOF | iconv -f utf-8 -t $test_encoding >expe=
cted &&
>=20
> You don't seem to be taking advantage of qz_to_tab_space's
> transliteration of Q to tab and Z to space, so s/qz_to_tab_space/cat/
> would make the code clearer.

I've copied another test which tests the padding without --graph and
added it to test the new case. I have no idea what qz_to_tab_space can
do. If you wish some clean up, it should be done on older tests too :)


--2J6Fuv7cTos4MT5lhq7wxhN44GKmf1oSr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV8zi9AAoJEN5YZWvcKoxvKX8P/1vsrkst9qDm0H98+muaishk
8tfy5jfOpYn1/wOUR7AO72bbz3GYbxjVdzdLSMCMctEuG2HqQMtJSPREL98mTvbR
ODxIY8ZO+Uo65HSbwYdms8APUEDxAYijkpaD/z5EACCuxd/dOm28blbZuNycnokk
eoLM5+mbZYaUIW6AyqeKTBMd7gkGzUA5aPXOL3c4s50G+8o31P66HyyKc2rW9wUp
d2ALV8ZLzrKniWHvh0i88xJCnkzxKohCYwmmpWzvFOGVOKBtv/NuvKRhMY0LYmkA
tNSmQL3qSfyWnO7z3N2mh3wNwcyIrZM1jnokRf34shYEqImaDND/IQTmBA7B5Ywc
ZdzhnjhtRvk5YPG+ReYz5uqpPjMf/QqvZJvpa3nG/zg8WK+K4Eh3cvWg6VTM4CQZ
nSVKtOom13l8gja1RzEktKaCX1IEPiXarnNyZW405fvbb41lefoSjPE74Cue4Mzh
MPA7wOl3dC4jl+wH7X3+7TAVOvWYdO90KvAyCaKjwX9Sh22UhAjmj/TZHj6XqaIO
3VYfUhF1V90DIKBpv5CA9UAgnB+x2f8ZFG7R9Tjs4yYcMIsVVGPMgvul84m9qAVN
dVjhiUdOC2gU75CarmRmwtzAD/p0YQF9RBYo1huPYmczMJ0l+hQNdA6cN+J1pl3a
qYRptzWbRFDqVpmnfx41
=5in6
-----END PGP SIGNATURE-----

--2J6Fuv7cTos4MT5lhq7wxhN44GKmf1oSr--
