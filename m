Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A0D1F576
	for <e@80x24.org>; Sun,  4 Feb 2018 11:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbeBDLsr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 06:48:47 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:40794 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbeBDLsq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 06:48:46 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id 232091A920C;
        Sun,  4 Feb 2018 12:48:43 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517744924;
        bh=JAD09s2mwOaK0fOWrVcDvCgaxnnsMR7XsFJCPguMDBM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:From:Reply-To:Subject:Date:To:Cc:
         In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=ly6kxn8Fo71yoAF1KEng/PMLTUkxce9T4JcoT9w6QTU2AnAtHENJ1MnzQ/427yx6Z
         IvGFSsd7vomyn8t9BaxXvi6Yl/N0N7NWeZmFpzxnpJRDfsW1vr1G4sO77+2l1RVLRZ
         j7J0sA0yglBfsP6rI9IehdrXBsKG8XXDy1Qompuc=
Subject: Re: contrib/completion/git-completion.bash: declare -g is not
 portable
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>
References: <1e618c0c-81ba-fa7e-8039-748bdfa5a6d9@web.de>
 <CACsJy8BKpniRxzDa8tOzEu=UVB0kMgv-n0tqZgp0Jreruqq-mg@mail.gmail.com>
 <CAPig+cQXT1ov4MjzSzqiLBzr4wN1XcP7aSxMP+_dhtWtYwhDAA@mail.gmail.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <f8500cbd-dd40-690b-22e9-a9f6a7d1eb8f@lucaswerkmeister.de>
Date:   Sun, 4 Feb 2018 12:48:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQXT1ov4MjzSzqiLBzr4wN1XcP7aSxMP+_dhtWtYwhDAA@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms050507030003010204090501"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms050507030003010204090501
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04.02.2018 10:57, Eric Sunshine wrote:
> On Sun, Feb 4, 2018 at 4:45 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Sun, Feb 4, 2018 at 12:20 AM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
>>> After running t9902-completion.sh on Mac OS I got a failure
>>> in this style:
>>
>> Sorry I was new with this bash thingy. Jeff already answered this (and=

>> I will fix it in the re-roll) but just for my own information, what
>> bash version is shipped with Mac OS?
>=20
> The MacOS bash is very old; note the copyright date:
>=20
>     % /bin/bash --version
>     GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin16)
>     Copyright (C) 2007 Free Software Foundation, Inc.
>=20
> A recent bash installed manually (not from Apple):
>=20
>     % /usr/local/bin/bash --version
>     GNU bash, version 4.4.18(1)-release (x86_64-apple-darwin16.7.0)
>     Copyright (C) 2016 Free Software Foundation, Inc.
>=20

Specifically, Apple ships the latest version of Bash 3.x, which is the
last version published under the GPLv2+ =E2=80=93 Bash 4.x switched to GP=
Lv3+.
Users can install newer Bash versions themselves, e.=E2=80=AFg. using Hom=
ebrew,
but that doesn=E2=80=99t help us here.


--------------ms050507030003010204090501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
DMgwggVnMIIDT6ADAgECAgMCmv4wDQYJKoZIhvcNAQENBQAwVDEUMBIGA1UEChMLQ0FjZXJ0
IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0
IENsYXNzIDMgUm9vdDAeFw0xNjA5MTExNDE5MDVaFw0xODA5MTExNDE5MDVaMEUxGjAYBgNV
BAMTEUx1Y2FzIFdlcmttZWlzdGVyMScwJQYJKoZIhvcNAQkBFhhtYWlsQGx1Y2Fzd2Vya21l
aXN0ZXIuZGUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDc0Z+cNtJrrj27JiZL
om5JsgGypjrFuBpvRJYjXVzx4gXYZcqAvTuHcQMZcBXItvZEE6DNbsKoFFl/DEpRxbnD3/uI
SEcrpQVqYu3iXcbvk7yA5IBG2HorgWVEA9DQROJD1qwxmS0sN76PtK5cWFPfUZ2A/UM+gVEU
WkWY+DSdO0nmWAyuvP3ArDHgAuZxf/J9HYzv8pRx6fpsqCLoauP6gHTA6hHApcjpUTRNX+Df
GGyDVhOaCp0lVDgtTxa1licpXwnDwFJVgX3F2rdxzISLwf3qi1775XiyFtqTX0jPB/YHHQD+
N+1lPNIPrXsBcUNXUxkwKMXNn5kUS5owIbg1AgMBAAGjggFPMIIBSzAMBgNVHRMBAf8EAjAA
MFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBvd24gY2VydGlmaWNhdGUgZm9yIEZSRUUg
aGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzAOBgNVHQ8BAf8EBAMCA6gwQAYD
VR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglg
hkgBhvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNl
cnQub3JnMDgGA1UdHwQxMC8wLaAroCmGJ2h0dHA6Ly9jcmwuY2FjZXJ0Lm9yZy9jbGFzczMt
cmV2b2tlLmNybDAjBgNVHREEHDAagRhtYWlsQGx1Y2Fzd2Vya21laXN0ZXIuZGUwDQYJKoZI
hvcNAQENBQADggIBAD0u0rjuzABHKM1fpWqrgq+h+vhCZFA/bzVuNvfHt45pN9vLJE4UzZf2
c9n9eui4yv8eCgevq+NMmckF8jqFpz3y8jPtNTzPvEA4jQwByAUoR8BkLLwpnRZhq/tgu1ZV
6csJVSwqBe7HsgTtdwg3+n0neOap/xuJV6FkDsM3ODdnP1otn2F8LXCFhHMo4KdnpqnKTc2C
Zhrm6NXkGeJ6G3EbGihnb+RLNs9NrF4h6X5R5jiXgEPE/Ln8CdQoz0PfXantJwoedwAUyJa1
EThxc9i6RCx4FdUaic6mbgsGWGZS6/URg3B68AEmjg+EUxjtRk8TGPlK6r2Uly8zjpLkioq0
e2t4c14Eu/+CYfCVA6wY6sqcfFjdAzg/qKcM7le8fU6rkQNwGHIAA/APi3yTDXc1vUEmSogG
qTnJkm/IFxRBJZPnpsXlhwXsJZdMxdY1TYarVeu+a93k5Gbgg9zfH0RYDW1cxY7iWEgMBOql
b/U73cT6T40PmfwDfu7O36qB3yZhMjDPOr061bToqoepV1BUVyKUmLWc2nCQtv5kHeow7Rgt
ZMbXIROSsTHiXgobAAy+K9U93GEG+hDN1JEBLQhpYFS7P40R99tvZtm3tym2t7qBeHCZcuMl
br9Fi/IymEyyKZaqOQjLRfUZqGMYLCnLu3ZXRB9I7u4FOtLEEE8+MIIHWTCCBUGgAwIBAgID
CkGKMA0GCSqGSIb3DQEBCwUAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsTFWh0dHA6
Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhvcml0eTEh
MB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnMB4XDTExMDUyMzE3NDgwMloXDTIx
MDUyMDE3NDgwMlowVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93
d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdDCCAiIwDQYJKoZI
hvcNAQEBBQADggIPADCCAgoCggIBAKtJNRFIfNImflOUz0Op3SjXQiqL84d4GVh8D57aiX3h
++tykA10oZZkq5+gJJlz2uJVdscXe/UErEa4w75/ZI0QbCTzYZzA8pD6Ueb1aQFjww9W4kpC
z+JEjCUoqMV5CX1GuYrz6fM0KQhF5Byfy5QEHIGoFLOYZcRD7E6CjQnRvapbjZLQ7N6QxX8K
wuPr5jFaXnQ+lzNZ6MMDPWAzv/fRb0fEze5ig1JuLgiapNkVGJGmhZJHsK5I6223IeyFGmhy
Nav/8BBdwPSUp2rVO5J+TJAFfpPBLIukjmJ0FXFuC3ED6q8VOJrU0gVyb4z5K+taciX5OUbj
chs+BMNkJyIQKopPWKcDrb60LhPtXapI19V91Cp7XPpGBFDkzA5CW4zt2/LP/JaT4NsRNlRi
NDiPDGCbO5dWOK3z0luLoFvqTpa4fNfVoIZwQNORKbeiPK31jLvPGpKK5DR7wNhsX+kKwsOn
IJpa3yxdUly6R9Wb7yQocDggL9V/KcCyQQNokszgnMyXS0XvOhAKq3A6mJVwrTWx6oUrpByA
ITGprmB6gCZIALgBwJNjVSKRPFbnr9s6JfOPMVTqJouBWfmh0VMRxXudA/Z0EeBtsSw/LIaR
mXGapneLNGDRFLQsrJ2vjBDTn8Rq+G8T/HNZ92ZCdB6K4/jc0m+YnMtHmJVABfvpAgMBAAGj
ggINMIICCTAdBgNVHQ4EFgQUdahxYEyIE/B42Yl3tW3Fid+8sXowgaMGA1UdIwSBmzCBmIAU
FrUyG9TH8+DmjvO90rA67rI5GNGhfaR7MHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsT
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnggEAMA8GA1UdEwEB/wQF
MAMBAf8wXQYIKwYBBQUHAQEEUTBPMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5DQWNlcnQu
b3JnLzAoBggrBgEFBQcwAoYcaHR0cDovL3d3dy5DQWNlcnQub3JnL2NhLmNydDBKBgNVHSAE
QzBBMD8GCCsGAQQBgZBKMDMwMQYIKwYBBQUHAgEWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9p
bmRleC5waHA/aWQ9MTAwNAYJYIZIAYb4QgEIBCcWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9p
bmRleC5waHA/aWQ9MTAwUAYJYIZIAYb4QgENBEMWQVRvIGdldCB5b3VyIG93biBjZXJ0aWZp
Y2F0ZSBmb3IgRlJFRSwgZ28gdG8gaHR0cDovL3d3dy5DQWNlcnQub3JnMA0GCSqGSIb3DQEB
CwUAA4ICAQApKIWuRKm5r6R5E/CooyuXYPNc7uMvwfbiZqARrjY3OnYVBFPqQvX56sAV2KaC
2eRhrnILKVyQQ+hBsuF32wITRHhHVa9Y/MyY9kW50SD42CEH/m2qc9SzxgfpCYXMO/K2viwc
JdVxjDm1Luq+GIG6sJO4D+Pm1yaMMVpyA4RS5qb1MyJFCsgLDYq4Nm+QCaGrvdfVTi5xotSu
+qdUK+s1jVq3VIgv7nSf7UgWyg1I0JTTrKSi9iTfkuO960NAkW4cGI5WtIIS86mTn9S8nK2c
de5alxuV53QtHA+wLJef+6kzOXrnAzqSjiL2jA3k2X4Ndhj3AfnvlpaiVXPAPHG0HRpWQ7fD
Co1y/OIQCQtBzoyUoPkD/XFzS4pXM+WOdH4VAQDmzEoc53+VGS3FpQyLu7XthbNc09+4ufLK
xw0BFKxwWMWMjTPUnWajGlCVI/xI4AZDEtnNp4Y5LzZyo4AQ5OHz0ctbGsDkgJp8E3MGT9uj
ayQKurMcvEp4u+XjdTilSKeiHq921F73OIZWWonO1sOnebJSoMbxhbQljPI/lrMQ2Y1sVzuf
b4Y6GIIiNsiwkTjbKqGTqoQ/9SdlrnPVyNXTd+pLncdBu8fA46A/5H2kjXPmEkvfoXNzczqA
6NXLji/L6hOn1kGLrPo8idck9U604GGSt/M3mMS+lqO3ijGCAzswggM3AgEBMFswVDEUMBIG
A1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoG
A1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdAIDApr+MA0GCWCGSAFlAwQCAQUAoIIBsTAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDQxMTQ4NDJaMC8G
CSqGSIb3DQEJBDEiBCB0+fs+oz+vDGidjfSSJJ6a1iBg1TA6TZXhQxX6z8gTVDBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3
LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwKa/jBsBgkqhkiG
9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMGwGCyqG
SIb3DQEJEAILMV2gWzBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDov
L3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgMCmv4wDQYJ
KoZIhvcNAQEBBQAEggEAYjysbExDDKs1wmP44tY8nGcTjLMOvjLjGBO1LT8RbtF9+GPznqmZ
Meq2vx5zkG5g0PxoDdcV4ZNSqF95KR2jR9JqUHk9sr9PTGepXP6MtQVzLv809txTAXYHfpU9
+7GnrZEeDXoGBWH1L7drc+Q4eX43HStTbd0n/Y7ZCyygwm/Y8/90JsNafSaqDSi7TUaXcE7r
opn4N63/8oEkjA/SBIN6Zceip+s6weHvQrIGYzsDuQBHznTMDoYhONvMRKYGuUDN9g5TkSLx
ORhJkhnqzMoqCzxNBpxomkTQoxF4M2JZD6+bK4tebT2g2j8AotsXB4CbHrUH/Zl5AvcAcKJb
xAAAAAAAAA==
--------------ms050507030003010204090501--
