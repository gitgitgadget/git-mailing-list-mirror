Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020106.outbound.protection.outlook.com [52.101.188.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF2414DCD
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 13:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783430745; cv=fail; b=kZwQBYjhjlWTTn3DwOSBFHRLv7U0sSoHFz8aengZFA3jvKpZJm82UenhNEm9lSFre/V3GFJyoBaCk7cnHWKJW8hnVz0WfMhKSmy1fKPRrvne8o2LPbrhzLkJ550kAzNUzVzrv8kxYuf3SEYawTmEfseHQw4EAKmRPShscrS9bOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783430745; c=relaxed/simple;
	bh=q0Bp2jPx2pb9r5NEkpsmZdxOdNQS5l6Ezp8omZrDObg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TQtUe9NqKqvZc8euHKz8WLPUHVx4rvELPbVSHFf70IvpyBPOizjj/9AHCN0x/3SiHglcg/6hEdX1nHwNLB6fymkNSe5rn0Ev9Jjun3LuhJedWWApmwbW8dLa28yRCsZw7L1awIbbQAkXKaafDwKRj/rRw8W7uBTEWitoQKZxxv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualitasag.ch; spf=pass smtp.mailfrom=qualitasag.ch; dkim=pass (2048-bit key) header.d=qualitasag.ch header.i=@qualitasag.ch header.b=cP1mgv9p; arc=fail smtp.client-ip=52.101.188.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=qualitasag.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualitasag.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualitasag.ch header.i=@qualitasag.ch header.b="cP1mgv9p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsJuhQRHuteetGoIlSLMJSnhtSeGMk2RrJzJG6w47qnT8DZuio5PDOBS25w9t0WlQ+jRXiupcsXcVTASlEApTW9DIktvDmqZ7COFyAhEnvEgz18dibFT1jn5WQuDPL2wJwK9T9zv+q5LLyA83y2MEqAN7pxaqJ7UttQx2nNjCqqG1oD9A1gWJInAR/JaojKxjBDaFb0L8JUFexWhBYfBHzpPbKb9Hhk3wEjbxAu9rOw/HvQTiJtjwzwTJME7i3DbdghkVQLjPc/H+B1vgjrkaoJQwgg0uNoYwjTARNwcz4vmYAvxcdlKq0++85barH5PIREaV7axk0816Uv2QiLn3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQmcjk71/ojCbnu9BWnyz1RTMbm+HeIjxvSljHLDYuo=;
 b=n6mVYaFGT9PBgrfBpP2DDBcQ2pEs3Hxix0mnLPaA5YPi/ATxlSue91em2NtFIo/vpt2I+zmiFXGOH+pz4VFVU0QgUYZcxO8D28niT4srZBGDBhqJLJzCcYqXRvoG8kXIhL6qP3r1Q/7ZBQzLVBccLYBJPHaCebyjCwSYH2e1i4blTFtC08SbELVdB0LYwyQy/ir3YlXebCQoqnzrUaHdAsME2z0CNqiQdTNWKbM3GgRfHZUn4l7WZrw30751+t9QiUlr6i8HMV1HP/Cvi/N62SWfp6QLnlnTHG4DMh26vyLQ1DvKh/9VT20fycVChvAEUjQwdJLaQEVRMUl9u3N66Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qualitasag.ch; dmarc=pass action=none
 header.from=qualitasag.ch; dkim=pass header.d=qualitasag.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualitasag.ch;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQmcjk71/ojCbnu9BWnyz1RTMbm+HeIjxvSljHLDYuo=;
 b=cP1mgv9pQsP7dAHSM7kJmuVQjM1gnbypOjpMMi6TYQcjfH21zYZzeX8zZN+E5ddUud3uUKwNwR34sf/mZ+xSBSyqLSoeeQIN/DOezwMvdLebdCgWQmcwxzPVXOaGrwDkFqXXLKsu0l04SySmOjbfCam4FAtBOSVJMpSI8JYoTP3afM2Jse10dtxTqp/c4CAJzEUEyX6fEhnxb8OthnplfIwkqx+zkx/zeoDnqLqh2/F+YrZmFI6P+CXEVZeQg9nzqExHxBPS4no4vENpbg6sebKv3GEkblLyXTXUJ9FyeeqsSx7LCwVGmPGsyP3HT3a4MJ0MB0A/czui6+kAIwOvEg==
Received: from ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:ae::14)
 by ZR1P278MB1233.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 13:25:38 +0000
Received: from ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a07:bcc9:d6bf:cd99]) by ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a07:bcc9:d6bf:cd99%4]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 13:25:38 +0000
From: Berner Martin <martin.berner@qualitasag.ch>
To: 'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
CC: "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: AW: CVE-2026-55200 libssh2
Thread-Topic: CVE-2026-55200 libssh2
Thread-Index: Ad0N6/53o/EQsu93S4KT/Zd4eDBGtAAG47iAAALDtbA=
Date: Tue, 7 Jul 2026 13:25:38 +0000
Message-ID:
 <ZR5P278MB19812C0AE7089DB237227299F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
References:
 <ZR5P278MB19814B2CA717210492C13A73F0F02@ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM>
 <26531fd0-4a21-c8ef-84a9-25c871cde303@gmx.de>
In-Reply-To: <26531fd0-4a21-c8ef-84a9-25c871cde303@gmx.de>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qualitasag.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR5P278MB1981:EE_|ZR1P278MB1233:EE_
x-ms-office365-filtering-correlation-id: 667f319b-5eb5-4b8c-f8d9-08dedc2b3c31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 zKuKvuhUkbfIy9pc3T0ST7Jn/wS6d9pQyUppu3x9wZjGMl6HPjTyUrwYi2NdLTttsDg6ndJkPRQbtWafFe6IEcmsPKFULBvPwcGy1DvWhQxEJrK0plKV9uCRvGnljFRgpjRuhHB4t6tJruzNz2Ylx/QnlSFIVZ05Z3Vpq1JznoUudPlN8YkcczdgUSz4HHjpIYHdFNzfEnDQPIGWxXKXGdxLgGgkILQXM+Vew6RMo5nD6Mj6Kbg2PadIZqNPvpd2XWEy0krJo7vShvs5sc2espyupC97QBUcTi2azVfRXAJUAHjfDltijb+83p4yb78bOiO7cJR7Fb3k26Q+BL2tl4+4nzNwoSOyPJSdBtgzGqtJ1FnpIqnHEN7vTFsSkEBTb6AhhXiHHdK+d6Fr2WGYIHXsNUR2nvjXgD2iYzGApAKmakV6It55YkYW6WzdoGHz77M8cM0ZjJT37fU9/Py2HK/5jgNwojJKovrVWmX0flLKeSgM/sF276T6aegSoYt2su1VYBa/OTBfb+ktL9wfxRVMR0+6eZWfqlhCX5WzmMp7xISxVk4yxvqpS+wY2cAwKhrNG/4CYCLFMQGo7FIOyZw5ztTfaQWArSVcP0CMOddmH1Nj1Edd03UIfW4Jit7tElxN5u0Hy+QVIDq9w7WZwCv7QeKIn+oCfDUcRx+mF4Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MlWcVuThZOdJatBxobFzCaGDTm+p9zZgMQy2Yckw2pIJIACBn32S8+1gWF?=
 =?iso-8859-1?Q?9aTegb90gDzFivdXwcIrnIsnuO3c/BZ0bUAe38Jm5EyHNrzCnjmmfW+RrW?=
 =?iso-8859-1?Q?lF1wJSsFMI+tE+QH30FDMrEnG80vJ7V3QkFVP9KTdkxsYJ4EtTPeZ2O4d4?=
 =?iso-8859-1?Q?gc8v7fdRRJFv6w/vHNoF+V5N1EEJUuylDhHDUwi6gdSchyoO3AkR5/p1QL?=
 =?iso-8859-1?Q?Iga4jHYBfIC6pBNG3bu0RsMUGaN6SvBSoWri3CBEpZgUS3DE4VJ/863ioI?=
 =?iso-8859-1?Q?De6I3vpPUe/jr4mTu+s5XmP4jqS5xnOLnaI+vTGmju0WaUSabJV04xlSHE?=
 =?iso-8859-1?Q?7J3oNAfQ/EKZTI0ykyy1ziIxvjWRFPLurjd85COT4sK0x+8/b1+pkUA9vX?=
 =?iso-8859-1?Q?WRphI/yMHScbmKJMvjmSZpjSoqJTDjzRZwZS6zGwjMQsgGwbtPQbQQNzuH?=
 =?iso-8859-1?Q?Bk/Yg58b4QWzdAnx+Ry0borHoMYFgfwF89du/yXVt8DyFdT8tMl+lDTfx0?=
 =?iso-8859-1?Q?U5ob6XKs6gMEavSV4EeJo/vqBO6D4qwz70kW78DdQhAaaEL/Y/OKOO/c+0?=
 =?iso-8859-1?Q?pqTcLaYSvBm2BfDG+9NPw1ywEECPRuRRNR7wypL1pb2TcwZbmzLjOZeDM8?=
 =?iso-8859-1?Q?Xdnyr1HZaEvVdO/rMdsXDdaNPsEBNndzk6PN8HkwP1gopDNkCEbYL/AQsZ?=
 =?iso-8859-1?Q?7qxurgZndZHRp/isLHepexgo+r9/1IWkn7vz5E3syaEzgNGx/dr2UcqDg+?=
 =?iso-8859-1?Q?Zf9MNUHqEfvAvBAUTQlSs5D6gzHqP01b/okP/zBfuJhwhM72ESJsNjomp4?=
 =?iso-8859-1?Q?RqwSPqdFRG0RvO5CbRVpQ9xs2K29spAplLm2xoiOxQBVqCQWuGVLC4hyc5?=
 =?iso-8859-1?Q?cFKO3PWlNuukDM1nQxKvBIiwnQfQ/cic0QYLRE13euIa4LyyvoiqJeWQx4?=
 =?iso-8859-1?Q?4SHdm0nVSjdjWb5hzdW7NpbkfpEqObqr0nBRe1IaE4BPw4KOGhjScAlORZ?=
 =?iso-8859-1?Q?sHjJwLPj44SLUAcqPceD9wgVBK44OXSYtywuu9Bp/KJ5IaZl87g5a+zPrw?=
 =?iso-8859-1?Q?GIelszPKaZec9w845GfAyiy0KOu8D2P0UjkjhCgcULJmdEhHgwnArc8HTi?=
 =?iso-8859-1?Q?01mPJ+NxTrKXOkLBUNmqP/Or2B3/kE42PiuQtWYZNB7NTwvmlWGIYtRy7h?=
 =?iso-8859-1?Q?AO4/cnDH7+r6/h2O3BpmDuvFPc/6TMNyPOLzWJkIW3/MNvTBUL5zar0yFZ?=
 =?iso-8859-1?Q?OG+vIrzcrR0vYv9KoXMNeG1/sFnwLcbEjbLQm6cv8VzPdAb2Nh43p+4tFD?=
 =?iso-8859-1?Q?7UtLO8NWr1yra7wG0TpjxgNPqF7WSGqrpXSW1ejqV9+ZSX3J437eWSl8Tl?=
 =?iso-8859-1?Q?K+l7DogVMAJr/YUQJ1Wj2iTkjNlBrgD9fxvhG3u4Y8k+m/sydq1L5eBpKx?=
 =?iso-8859-1?Q?XyKVNdXaQzUZrnUFjq1ypz5f+oJ9D7UihM0TJtzaYq0amYaUW4o8FB+Otu?=
 =?iso-8859-1?Q?f0lm5cLTlIKJ9NXWz3QQyA6cqYd8x65icIH+cqN8LPpoMkmxKOotg+ZeLG?=
 =?iso-8859-1?Q?S7jq/a28lVgUkMCAyIlAbARWcJN2dZ4VqN2plJHPB6DiVwJ2ZlCLdLmZTX?=
 =?iso-8859-1?Q?HK+16jTMHKIonqdhfmh1QhpwZNwGoWRpYjmQVyC27TFPoHQgHF+iTyQX6E?=
 =?iso-8859-1?Q?2JURt8PV1EAZ769oz6Uhm1hmKj0/rBDDdPBRgrrsEQ8OFx9jP+yxGTAoBO?=
 =?iso-8859-1?Q?wkP2pdll3cgJwkSoBkBO4q9obSw2zdylBOKrgkh4mSRdlOXeM7XlCf8jTX?=
 =?iso-8859-1?Q?JCUhDrNlgg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qualitasag.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR5P278MB1981.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 667f319b-5eb5-4b8c-f8d9-08dedc2b3c31
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2026 13:25:38.4329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bf92dc3f-ac30-478d-836e-9628882ad7b4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pUkL8VtNJjyFLFXpivNdcqkcS+hTAnYV1z58d/izxedLZod77Vha1FKVLGHKI7/lodBdnsqzbwFq3rJPa0y+LKjZUMlHuvKgL9yole++jV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1233

Hello Johannes,

Thank you for clarifying that the use of Git in any way cannot lead to the =
use of libssh2 and that, therefore, the situation is not as critical as it =
initially seemed to me.

I apologize for the wording that may have sounded demanding. That was not m=
y intention and was partly due to the translator. My days as a software dev=
eloper are quite a long time ago, and the languages in which Git is written=
 were not among those I worked with. As a result, my ability to contribute =
directly to the open-source community is rather limited. However, my employ=
er supports the open-source community in other ways, so we are certainly no=
t just beneficiaries.

Thank you also for your explanations regarding MSYS2.

Kind regards,
Martin

-----Urspr=FCngliche Nachricht-----
Von: Johannes Schindelin <Johannes.Schindelin@gmx.de>=20
Gesendet: Dienstag, 7. Juli 2026 13:56
An: Berner Martin <martin.berner@qualitasag.ch>
Cc: 'git@vger.kernel.org' <git@vger.kernel.org>
Betreff: Re: CVE-2026-55200 libssh2

Hi Martin,

On Tue, 7 Jul 2026, Berner Martin wrote:

> The libssh2 library appears to be relevant in the Git for Windows build.

For some definition of "relevant" ;-)

In Git for Windows, `libssh2` is only used by `libcurl`, and the way Git
uses `libcurl`, there is no code path to using libssh2 functionality.

Therefore, I do not consider this critical enough to rush out a new Git
for Windows version with a fix.

Besides...

> Git depends on libcurl, and libcurl in turn depends on libssh2.
> However, even in the latest build, the version still appears to be
> 1.11.1, which I understand may be affected by vulnerability
> CVE-2026-55200.
>
> Is that correct? If so, when can a patched build be expected?

That language "when can a patched build be expected" can very, very easily
be perceived as quite entitled, and hence have the exact opposite effect
of what you intended. You might want to be more careful in the future when
you plan on not even offering to help while demanding work to be done in
an Open Source project.

Back to your question why Git for Windows still only includes v1.11.1 of
libssh2. The answer is rather trivial: MSYS2 (on which Git for Windows is
based through a healthy collaboration) includes only that version:

https://packages.msys2.org/base/mingw-w64-libssh2

And the reason for _that_ might be rooted in the fact that both the
repository as well as the website of libssh2 list that as the very latest
available version:

- https://github.com/libssh2/libssh2/releases/latest currently redirects
  to https://github.com/libssh2/libssh2/releases/tag/libssh2-1.11.1

- https://libssh2.org/ says:

  Download
  libssh2 1.11.1, released on 2024-10-16. *link to Changelog*

Easy explanation, right?

Ciao,
Johannes
