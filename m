Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F51C433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 11:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiATLY3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 06:24:29 -0500
Received: from mail.exedio.com ([80.150.73.7]:50078 "EHLO mail.exedio.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230523AbiATLY2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 06:24:28 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jan 2022 06:24:28 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.exedio.com (Postfix) with ESMTP id 03580185EE2
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 12:17:25 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at exedio.com
Received: from mail.exedio.com ([127.0.0.1])
        by localhost (mail2.exedio.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id d14F4Tl3xKtu; Thu, 20 Jan 2022 12:17:21 +0100 (CET)
Received: from [10.20.20.109] (pc129.dd.exedio.com [10.20.20.109])
        by mail.exedio.com (Postfix) with ESMTPSA id 375D41A86C
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 12:17:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=exedio.com;
        s=20211122; t=1642677441;
        bh=/daX4QAQiAprqZFt3fO/Ygv62wFcUmePhYmvFrEqRYM=;
        h=Date:From:To:Subject:From;
        b=EVM0KQ3Pv4Tla/kMnk1uMtFNjsh8cUrm4QRgIFFvyd+L0LfQ3Ur+IA1hY3++XTrwf
         7qOMDw1MGt3/Y0sqhTJgpzih5ZGB+e59p9GqchCihvxOCat+2XAzC7jeAyJxb2EWuT
         9IOcNdzYXwxB+VrAzPsgliWy3xfhrXyTwqQR8SMKbBsrSwy8ZnBO2tr1I+FX6Qxfdu
         qKYsaSavPBI3UNm94xOALKADMfUyiwiKBGSLJ0mvEZB3W/aeKEjArWJ7sHz4xInX2B
         c5Z9Yq90zNiof4Rm00sfdW+LY7C+Dl/anOxhZO567OFz3b20H/Hp8iWunNL0Cn/i96
         iFiAsZUbUFKNA==
Message-ID: <5c60fb69-f042-5b59-5ba6-55f5fd2377bc@exedio.com>
Date:   Thu, 20 Jan 2022 12:17:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Uwe Hausbrand <uwe.hausbrand@exedio.com>
To:     git@vger.kernel.org
Autocrypt: addr=uwe.hausbrand@exedio.com; keydata=
 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
Subject: gitk: Possibility to select a default view
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0Rgi97aSZjn4EGQI5AlIGPzH"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0Rgi97aSZjn4EGQI5AlIGPzH
Content-Type: multipart/mixed; boundary="------------EaCssUQfPTOaulJ3jmKjxlR2";
 protected-headers="v1"
From: Uwe Hausbrand <uwe.hausbrand@exedio.com>
To: git@vger.kernel.org
Message-ID: <5c60fb69-f042-5b59-5ba6-55f5fd2377bc@exedio.com>
Subject: gitk: Possibility to select a default view

--------------EaCssUQfPTOaulJ3jmKjxlR2
Content-Type: multipart/mixed; boundary="------------h5G9PIiYAACCkZnvq1o0QAj1"

--------------h5G9PIiYAACCkZnvq1o0QAj1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJIGFtIHVzaW5nIGdpdGsgd2l0aCBhIGN1c3RvbSB2aWV3IGNyZWF0ZWQu
IEluIHRoaXMgdmlldyBJIGhhdmUgY2hlY2tlZCANCmFsbCBjaGVja2JveGVzIHVuZGVyIHRo
ZSByZWZlcmVuY2VzIHBhcnQgb2YgdGhlIHZpZXcgY29uZmlndXJhdGlvbiANCm1lYW5pbmcg
SSB3YW50IHRvIHNlZSAiQWxsIHJlZnMiLCAiQWxsIChMb2NhbCkgYnJhbmNoZXMiLCAiQWxs
IHRhZ3MiIGFuZCANCiJBbGwgcmVtb3RlLXRyYWNraW5nIGJyYW5jaGVzIi4NCg0KT25lIHRo
aW5nIEkgZG9uJ3Qga25vdyBob3cgdG8gY29uZmlndXJlIGlzIHNldHRpbmcgdGhpcyBjdXN0
b20gdmlldyBhcyANCm15IGRlZmF1bHQgdmlldyBzbyBhZnRlciBhcHBsaWNhdGlvbiBzdGFy
dCBpdCBzaG93cyB0aGlzIHZpZXcgaW5zdGVhZCBvZiANCnRoZSBkZWZhdWx0IG9uZS4gT3Ig
bWF5YmUgdGhlcmUgaXMgYW4gY29tbWFuZCBsaW5lIHBhcmFtZXRlciBmb3IgDQpzdGFydGlu
ZyBnaXRrIHdpdGggYSBzZWxlY3RlZCB2aWV3Pw0KDQpJIGFtIGFzc3VtaW5nIHRoZXJlIGlz
bid0IGEgY29uZmlndXJhdGlvbiBmb3IgdGhhdCwgc28gd291bGQgaXQgYmUgDQpwb3NzaWJs
ZSB0byBpbXBsZW1lbnQgdGhpcz8NCg0KQmVzdCByZWdhcmRzLCBVd2UNCg0K
--------------h5G9PIiYAACCkZnvq1o0QAj1
Content-Type: application/pgp-keys; name="OpenPGP_0xA5D07F73D1B1A25A.asc"
Content-Disposition: attachment; filename="OpenPGP_0xA5D07F73D1B1A25A.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBF/y7/YBEADS9TlEf6IZVap94RYT2GTaeJcbg05QzVxt51dC/XvSoRdbQ/mZ
MWhYuJGtxUbuzQU57Cl9lsqWuy9FBODGl4bTd/XUs8IrG0eM30fdJShVJ224BGG/
WKQ7BlTpZ1D7W3wk00Mr14Oeg4BLshDf19oEP1O4Iw7LuETF78t4joBKAKVczSYG
ytRgJYw+Ai1MylQJ/75Vx8c10KqiBtgkLOseJjEAdHv7Z0Fso3dZ+Grb0CcM8X0r
L0DSk2k/LbdiFnxOOcJLyiNI4BU0z/I91UWwgAE0ggxUgTMcE3W8xUeWhxrctmWz
kMNUgqiZrLF7E7Xc1blbW4gh4sNXEr2ski3M/+ADMDwDDHhVSOM87q3j3j8t+TWb
0H8Y+uFxQmSjoUmLKhJ8pLKAcUgztXnxbWOH73yP0DSpNf27uqebUkuXacIbql/F
RoPnu8nNS9Ak+8+8v7ZlIF2o+KTLPZQvlTf8UWPdm53pkgwnwVKZgGhvuYo1Qb0K
m6w793nytx/SZ+6iCWRztC2TY7BzOZmUBGPH/t1+Hm0gHRtp1fwYibnOWxftdVoP
XJS2Y2vvs9M7zclJE/bN3yxXMNqWatqeB8/+RC0kR4StlcU1qtC4k9IzJ+4QsQjT
AvOspomFUQFrT73XyrtLCBliZZKjYUbfZkhzV5S1ZIfNTilUkwYzBaWtoQARAQAB
zShVd2UgSGF1c2JyYW5kIDx1d2UuaGF1c2JyYW5kQGV4ZWRpby5jb20+wsGJBBMB
CAAzFiEEoKnInp/dsJyX+BQppdB/c9GxoloFAl/y7/gCGwMFCwkIBwIGFQgJCgsC
BRYCAwEAAAoJEKXQf3PRsaJakgEP/jA/zWDSPqohBbQLuRau47C1cLl+xLvb4jMp
q4aRaSHTnjH/oha+pglbrIoLeCqrW9dh5Z8XjfJzkN4EUsNFMHiN5lIDDOftKWD4
nsufWCt8PjyfpoMBoJks84wavwpFT/Jq69jkIW0yHmjWFIOsoVE8gwpDp88LLn+i
9SRcTzWN3PD0cZXFrQZTM59oanag1POVQpUz4cQ8TSIJB4eI80eOUUYCEyITfNki
4oThJeLPYAixW4lvEO6hxBkQpFRd+uLJTcNb7SA97Q5XVrl8R3JEfLsHPeIoMrxB
bOOQY5XyEYFhqbvOjLr83VZqhmwtOfIxastzUs/3pnN/je971YYC6mi8fA76et94
pn/xmnxePQUkj90pzDRTeWthcwhXqdIdqe/vM87RWLZ/DVsKuANurG6JRIK5fjAP
zZMNJcEUikoUJZ56afLYI0OIqbbVEsaS+/gTPUKPXh+VoJ4n3uhsOKGfaNHfltdL
wSeDI83rEZcSj0ybB/arIklZzl919OihrN/bqvkOi4auEbIlnWpQ7VzAXdjvsn1i
85YOw2S7SdQicw/+6IU1+ctWhdlw18PkVQlx1B6GOLj/RphlzysxIz9gEAA1eBng
6cuFwzE7tFsBHeT3WQbaobmgrrdI3uy2mzwEwF87u/sHifbMJhXEbTtN77ani2l4
AzpHb2RRzsFNBF/y7/kBEADTJDQHPn0Ak6BNBEoY69V7wIz3fGnFGbiCPyZCWlng
q6ANFdNOSqw1L8snNTb4HdVZKc/vPYH5Z4e5lBl0doN8YZMQR2xlE9hoGzDcAs73
kyQbjR/YcF5kjutW6XXw/6AiWQ+0Esdg9QF/n23/2dmnGcF5AdGYrTuRzVwl0eFD
klI/3+5LpE7rAMPQY7pBOYyZbnxgcyuRlUlbgDB1f4wp3mFEFHMVqofY+AeLY1cb
oTdoLB2pkJqTU0jvOLF0HUE7ltACTmmVcV2NSHwB14aitYnp452MuftBtm6E8Tqj
feVtbQzEM5x3VzATwRbRnuYG9ST1wlvBeW9g8SqBbQSg3YNdRys4YEp6EBMHqn+T
jXT+XsEjvzaohkMRm2BR1UEGATjdpncUhFfg1Jat1EEedXXctQjT5KMnZGjWXvki
jw48WNrhPjJciIHOc9loDHiBxjdAZvKFKL9c/aeGwkmxUhVxR1VIQlyg82+hHWKf
2ODTPMGPYeH9KyDZ51+/QcGFWUfoLXUsEMaz4pGP56di1br5DfhTIu4aCt5Vy4Ch
ZMaUx6okiPjYGRIu3/I9EZbl2oa5QiXGvR4tdcfd97kjIpUaLi6G8ycAVEk5ySbc
Kd+cQQ0tBSMjPO8CA4mrriHK5TipABqjXU1n6C6yDEsBU8G6watLQPsX7l0vlMHi
IwARAQABwsF2BBgBCAAgFiEEoKnInp/dsJyX+BQppdB/c9GxoloFAl/y7/oCGwwA
CgkQpdB/c9GxolpbjBAAtPbH9huL68PgpS5E8DjpsEQ/2C8rYH4xBMQT6Eo1REvH
GodwEw1049m9tx84KwydXsXo0BOKuvkhrA8hJV8R4SVVsf450M855P6+4Zace98z
BOjmTicivIIVB2jyWdPyY6qvSJ1UsZa03eKyHa2xu7IOqkbBpaEsNnci3hLTXSrM
JyhAZAg76OHDeE0tyKf/gl3SGeXR/mNTZiSvZwVCG8t0pQBImKGXzYu+4DsCx56t
2306PeF2BNNLpmJxo/mVP47Aw5t+3+Iu0rrrPK9+tphoW+BTVkiHysHzqF9x4CJl
e/lilsFObPvjR+u4kYuxJPODge3Ske45cpLLTehUufblvqb/7rio/3Lc4Ix8fUHz
DBU9CNH5bvy3UpLhSWygB39P8Aepe3MtmervXxgWxHckSKhIPEsFpRvsYmAwtVk7
dK7y/0VSdAurrD5oTAklQ+viReE6XEL0EKZd3+Vjaut/iocuVRsbVIePknmsVtIo
K0eaMWAPgFss5YOY1nwXVPvEsodYqZmhKGvt/ITdCUVpWFXRVxMj4emaVVjJwEuh
NS5usfXnyu4WI7Vt7fGL/f2ruGzIAtz4jYrME0WE9hQimMYV0G6z4eUCmBw//J/H
4bC82q1o33byB2TicwBMaboOCbXL9zuGCrRXJ3E47LyqQJNYFVPiui0/7lvWXC0=3D
=3D+rpZ
-----END PGP PUBLIC KEY BLOCK-----

--------------h5G9PIiYAACCkZnvq1o0QAj1--

--------------EaCssUQfPTOaulJ3jmKjxlR2--

--------------0Rgi97aSZjn4EGQI5AlIGPzH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEoKnInp/dsJyX+BQppdB/c9GxoloFAmHpRMAFAwAAAAAACgkQpdB/c9Gxolq1
Xw/+PcgQh875SAqZBzuNCZJ6CCDZTveMfZJ75NCH6qagHhEq4PDMvPIhdaa9mQLI33S8G93o771H
stHDObMnV9DJBKKrNODzF1iWTWgD0S76KpTRnQPjvVoQvNiM+bpAwqr8w7osxa64ml4qgIk6wPrb
AdpkEZ/qVNMiYeg6R8JQaAd3OvcinMZaNcU+2iEjWOelXOV4DVytyLu8sbq5/fYAx8mwKqRb/boJ
vrzrEM/i0jXbePZsBdGUbeZiLhsdNGeKq9oZ/BZ8A+P+vbsCZUZhB0tqChmAx3ZRjPj4aOzVm62J
/qLNjOcfyWMe4+g3r1WYjM/MqCekFC0kFaySbrF5FzHUFVBUNdLPsKNxAvnDMPXMjtGp6j5Kdm3/
b/fjXf9MVHm4aA/ysdWytHjqAJZWzVANxPRVhFtGhoD1Sk2K2nAsyrcDQmjCCCZ+zohrOYP+pIBf
Zcvk9MFGlEr8ihDUMwzFl/OUTzp4P+beI0lBx1v8nOdpXLrNDKIyV3gYgeEzexdUI3p0W5Llr0XF
iRtEXJNl25zVIyZCvjAsJYwk+7jNrkHXTGiSaeAfghbAx9RVf9CuIRvNfqHsC/nZ7zhzRb0l/pGt
cLIs7yRb6cVKWPAEIRCIwlST3tmQUcMAgqLM3KNm5H89ODaCmgHTc9OnrS8JQndIspnS4H7JVFII
JkI=
=iIOp
-----END PGP SIGNATURE-----

--------------0Rgi97aSZjn4EGQI5AlIGPzH--
