Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 599521F404
	for <e@80x24.org>; Sun,  4 Feb 2018 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBDS7D (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Feb 2018 13:59:03 -0500
Received: from lucaswerkmeister.de ([94.130.58.99]:57818 "EHLO
        lucaswerkmeister.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751990AbeBDS7A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Feb 2018 13:59:00 -0500
Received: from theoden.lucaswerkmeister.de (unknown [IPv6:2a02:8109:9a3f:f575:be5f:f4ff:fecb:74cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mail@lucaswerkmeister.de)
        by lucaswerkmeister.de (Postfix) with ESMTPSA id C63D31A9A26;
        Sun,  4 Feb 2018 19:58:57 +0100 (CET)
Authentication-Results: lucaswerkmeister.de; dmarc=fail (p=none dis=none) header.from=lucaswerkmeister.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lucaswerkmeister.de;
        s=mail; t=1517770739;
        bh=UPX+O5DnklZoLujmzY3R7I0whe87nq4X2D9J3v6TFPM=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type:From:Reply-To:Subject:Date:To:Cc:
         In-Reply-To:References:Message-Id:Sender:Content-Type:
         Content-Transfer-Encoding:Content-Disposition:Mime-Version;
        b=A9uOLD9pIjH8gQiXOKLHVgDa60FIozrFVAOKyelzNBlpC8ihRzdiyqR46VR2Xlsrf
         ckC8YJl3m2TL1BJDxl9xctifY0K9FVnkM1YmRujD9z10oW1unxXRo04vej9l20IE9U
         2/sB987Nn2G8rYHmZ2BmLG2kJ517Rs1OQHgDLAjk=
Subject: Re: [PATCH v4] daemon: add --log-destination=(stderr|syslog|none)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <772ae5fc-5f92-3494-613a-a44c0073e8d7@lucaswerkmeister.de>
 <20180204183037.23162-1-mail@lucaswerkmeister.de>
 <871si0mvo0.fsf@evledraar.gmail.com>
From:   Lucas Werkmeister <mail@lucaswerkmeister.de>
Message-ID: <0306739c-3fba-2528-f08f-831a31c202b0@lucaswerkmeister.de>
Date:   Sun, 4 Feb 2018 19:58:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <871si0mvo0.fsf@evledraar.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000103030801030001030007"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000103030801030001030007
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 04.02.2018 19:55, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>=20
> On Sun, Feb 04 2018, Lucas Werkmeister jotted:
>=20
>>  	     [--inetd |
>>  	      [--listen=3D<host_or_ipaddr>] [--port=3D<n>]
>>  	      [--user=3D<user> [--group=3D<group>]]]
>> +	     [--log-destination=3D(stderr|syslog|none)]
>=20
> I micronit, but maybe worthwhile to have a preceeding commit to fix up
> that indentation of --listen and --user.

I thought the indentation here is intentional, since we=E2=80=99re still =
inside
the [] pair (either --inetd or --listen, --port, =E2=80=A6).

>=20
>> +--log-destination=3D<destination>::
>> +	Send log messages to the specified destination.
>> +	Note that this option does not imply --verbose,
>=20
> Should `` quote --verbose, although I see similar to the WS change I
> noted above there's plenty of existing stuff in that doc doing it wrong=
=2E

I could send a follow-up to consistently ``-quote all options in
git-daemon.txt=E2=80=A6 or would that be rejected as unnecessarily clutte=
ring
the history or the `git blame`?

>> +			} else
>> +				die("unknown log destination '%s'", v);
>=20
> Should be die(_("unknown..., i.e. use the _() macro.
>=20
> Anyway, this looks fine to be with our without these proposed
> bikeshedding changes above. Thanks.
>


--------------ms000103030801030001030007
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
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODAyMDQxODU4NTdaMC8G
CSqGSIb3DQEJBDEiBCBCSSLr3bVFLqxTY7n7hwUVs3vnOgh5OfQ6MSK66xkLczBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3
LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwKa/jBsBgkqhkiG
9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZI
hvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMGwGCyqG
SIb3DQEJEAILMV2gWzBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDov
L3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgMCmv4wDQYJ
KoZIhvcNAQEBBQAEggEAuX6/0l9WuyMWn1RgWQNh1r+lRlYA5EsyODyJq0+divcYxuH9Ra2f
pKCi8Uj15/XbZTaJYKxBcGEihS6bH156SjOsRNj9C2eO9DoRlEwnxk5v3AkYkt7bqGwbNoYD
f9sauPtwDYPj20jVqR6lEIf+q84uMKw6GjOBPjT5U3xcCMYPYbWqTJX2po/RP+l72aVBpPom
JN6kTsIU5YIk0tIW2HS+i9cS06VFb1wPb/aQ6CbtCXPXT0SAE+FTJtqgrISRGjItxGEopefZ
Xyj4oVMUYMOHRKbx/eQVWb2ehFxBgztSuvOPMCCDIeH86cMNnfsmizzgGPv/+d4wpzn7E+3X
QwAAAAAAAA==
--------------ms000103030801030001030007--
