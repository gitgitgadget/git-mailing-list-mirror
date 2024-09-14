Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2050.outbound.protection.outlook.com [40.92.91.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546913FD83
	for <git@vger.kernel.org>; Sat, 14 Sep 2024 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726354663; cv=fail; b=HJ3Kvb9pny0nsPQ+duEhDcZr74OoJaKWwcFDdeRaseDkVdCZ2BJAd6+hZR+Rxgzhsg1iUc2ucecVHwpUoltoA1jZgiCWd8aCNMc6WEDXutiySty7r43jQbExC/kSP2Fzazdmg9afQiQ22Yfox4bLM44kO/p8iS43hm/pCvjrwPs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726354663; c=relaxed/simple;
	bh=NFdYdQTRwBU41q8qCUIWsyKq+g64dpudCqMbo4FQKs4=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ug5C/nOsRKLHzNja9eixl+9ZVnit17eWAaQpGF/gTwwfsYRqt1yMjZ88oIbixyCQS6F2//CMMCX77P+l3+rJhCyWfRX799keIf0t1hKGO5iFM7HxD+u5r+65FmWkfuonyEJL6DUV0ywTHGEfuKUjR8bs48AE+CetmGdj/ABM2Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=F07HRX87; arc=fail smtp.client-ip=40.92.91.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="F07HRX87"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNyqpJkuG+WWM7NE8ZIXTCOA2zY89JZPMbLEt4mmsKkKipCF2/8Bm4ArYxNVl4rs3lY3BWPCBgE9GVr73+Xh70OhxX5AeGwzsTfIwt/BCNkbEhFD5nY/HdMNgoSMpktNTrqPXNIxqXXqJDeApwgSbNbH8t/qJyJvAUiCSwVdT2G3trwk9iJ4ch2T6xWisTXWbSRARMXIrpzx9vQk7KCDe8d9eambQ2y7XdS5M7W2UquEe/9c1uz+TH4anVNhpu1cqDBTm7JMaGDNw//OILWO+s9NNrvu6+qefklzDXjKCycbcTXgovhlN7AkJHO4vQBN3k4eVtjALHTRUbkka31PFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFdYdQTRwBU41q8qCUIWsyKq+g64dpudCqMbo4FQKs4=;
 b=gHy2XDq31O5zbQrQLopw+JbQzMaVpNLh2KRElcClMnQi1ZOv7HSeXkdwgRoldPbniRPQZkGfr8qcxwZ6cbaXXZtMV19voSmXHclLZ1m4XF0vnxRK3Mawa2TbhxC+Xy8aij3atkapAs5mx66ADCJKQ4tp3Dwu4z8uvnKG2uk8b6XVg3saM38ydN3JPEp+zNdpnJeTmOcAnxSyDYYu+I4DBV1iFSD9DtU/lGMrN/RmIvHrD/LoOVw3V9vAWHe2NzPhQE4PU3jzZrvX7Y7JhhyLxqC0beHMvJIV+vDjnI4o7g3nmhUeiwa3RLs7AqTJMN37h+X+lK2XU80eDpg3L31X1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFdYdQTRwBU41q8qCUIWsyKq+g64dpudCqMbo4FQKs4=;
 b=F07HRX87rCTKDwqXJHwyiiM/hxk0gFA/LD/YCNuQh3RQsuW15u0dEmZ7fTDkR5+5OivUmKUOGWUfQU3Pe9FcoNyhlwQtjDIzFQwo+1ApsxfSDlP7doOe1WAJLgY5rpMV11s4M7borCMs13PH0zNksIYgW2wt01bj+gEyl1g2rpTqPDZxFDeyXwz7tms60hKA8Wb3igZowetptYQ9NFYrfZC+TyxHEBL09FpfebYjxwYY965JQAcZXn7o3/a7b8AzxhDp1DElUwjGnOda4inOh1q3Swb65BkGmLNUTCCp27quTj0sLZOpiEfyiYhVUD2OKnQurQLHbgIB9RHI+DAi7Q==
Received: from GV1PR02MB8489.eurprd02.prod.outlook.com (2603:10a6:150:9f::19)
 by AM0PR02MB5842.eurprd02.prod.outlook.com (2603:10a6:208:180::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Sat, 14 Sep
 2024 22:57:39 +0000
Received: from GV1PR02MB8489.eurprd02.prod.outlook.com
 ([fe80::27a3:7bb5:712d:1d29]) by GV1PR02MB8489.eurprd02.prod.outlook.com
 ([fe80::27a3:7bb5:712d:1d29%5]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 22:57:39 +0000
From: Henrik Holst <henrik.holst@outlook.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: ./configure fails to link test program due to missing dependencies
Thread-Topic: ./configure fails to link test program due to missing
 dependencies
Thread-Index: AQHbBvdWX8QBBWlfjEaKg4WCTn+Zkw==
Date: Sat, 14 Sep 2024 22:57:39 +0000
Message-ID:
 <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR02MB8489:EE_|AM0PR02MB5842:EE_
x-ms-office365-filtering-correlation-id: 98eb92ac-5e44-4083-48b9-08dcd510a1fb
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|7092599003|8060799006|15030799003|15080799006|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 07gsShk8do4NosWLhbuBktjBzJ3PpYKPJ0AMfywED5Q+oQj/KxdTzzPp1yD4h9pFeh/ziX0CHGwOKrkzV3GCFTsjE3MWTF8QEZ84ymhY23NVDtiMcwIjB+nTdj8LA77ie6ETqKFu0gDDex7qJglswCyfi/Mr4qm7i9B0ZCB4Uha5a+pas7OxFDKzP2eC5T0KpoUSs16VtyLxFQtJarhD9NoaoDq6S/oD5PlGgOmEIYIxdm9eu+OJceepH6Ml7st74VvKKlk663UbY0D5sO1oIRHkFV8Og7nNDBwiN+r/bSDe0CbS+8qhTAJ58hDrxO+L7KYX550Dkrao6N6s5Ac3buHfVrumEHGpNZ2AOhcR2KzsLWjKW8XHGfVbRUILGoS4lNY23LneTwuj06kNo2Y7aourjpsL/i2aMNgJ0I0XCiNHpVuRUdimOH6+CT6MbncxhjSs2fEjvdWZQFAUKMUv7LhjlWbO04lTw956s1VLL6NUXvWxlCPsPDlhMVKgBwtpZHxujJlMxAgSiXibaCajq8L7N7rV4lkqQPrih3ihiOZIpaDMyf9yxKDJlaChnewlSI/qDihRJTPXW/IDl7gAD4vZOMkh8sn/J2rHnEhizDlwVnbG3DhL6dU3//UH1kaPhv3HCfd9NXaR5kjTDzt+DH4K0q4JeQMo1NJgqEsblPCPv0XCt/GqpIJfl5CghYzo8DzjkbFh7jVoRVYyzWj2jrX6FXbJPWQx336DGQzkND6Ssgk6Lq9e+8gDn0QKVSim
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jNHTF8S3nfwQeogspwzCHWDbdiA5ARZEBZ/ZNEuCMHp4Ui+yKn5h1v93j9?=
 =?iso-8859-1?Q?x2R5Z4ffVt9ryl0P/zrfqvgb0MoSv00oTfCZuQj4B5/8mDteygzCTu17+m?=
 =?iso-8859-1?Q?SZoIe3VzOGzwXhMaB050iPTDiH98zcNknR10mpdekQTB/Q1GvKGzxFkfQw?=
 =?iso-8859-1?Q?sPuIKnuRTk8G0JzJfFb/Ms6zFNN/zY9mGJrh15qOh1vOaHqGaKHHc8AK3B?=
 =?iso-8859-1?Q?sQXgD8tQd4fvvup63iW9zta0TjwhHAle+XdvdY4XpauLtEJsR+xGcO+OTR?=
 =?iso-8859-1?Q?+4lVVlMm+Dg0vfTgNwLhAUPs4l9vAWCKKnNw0W6dvX2C4439ENg+riWWgS?=
 =?iso-8859-1?Q?8QnGu7GxX6ida6u1xkGfJ7SIIUZ3hq0W059TYTinwvEzlFyogGLTOGO7FU?=
 =?iso-8859-1?Q?i4pd+P66UVBpszq0FSUf2D9RstwV8wf42MS33K6mCVbFDOmD/AgAFbdLcF?=
 =?iso-8859-1?Q?YUEpjFyoFtBAzjdpAmwKJ3YgEA9a6rmeqWsaxXl7UuAgTq0A/dlHNHeKIB?=
 =?iso-8859-1?Q?8QenyvyrqR3VxliNF/qHhEowZPqVxsDwsaQJBNq+GtzGvpGlXb4v+HCWA+?=
 =?iso-8859-1?Q?Im9q6NkAk5nABgr4mkkUtPSo+s3yA2xdCghqb1VrNc6JOx4rKUyWbLS6kG?=
 =?iso-8859-1?Q?tH7UvNjGa7IkXgcKtW9m9hs+Z8jf2kA1clY7buuafMyQ6YxdFQXp4LjF6z?=
 =?iso-8859-1?Q?NSOvHhAQLhlaWXSx/95hmIuJkkEU3TdTSSo27ryCO3fdrglW9kIDHkWqSr?=
 =?iso-8859-1?Q?7kvYCKHNKdjRPTUZXejOjGHQEAVtWw4GzD86BXLvAl3S4rbOvLo9GPTbPu?=
 =?iso-8859-1?Q?bnD0B1uGImzcwimMp5QBRwV3j89xcKYvYNBUWPsxc6j99INsV7ww7mExhU?=
 =?iso-8859-1?Q?UbBXABTsgOrpFFMtag7BCcbuII6Zxo2xu9s8DipDbPSsD2vjo3yKM/PV0o?=
 =?iso-8859-1?Q?/zSkrxhh4FGnH0SAfu745P7232GMCH5X3/EYfEV/ugLmQwbIwblq0kboYe?=
 =?iso-8859-1?Q?R+h3r8crWZO9x0iJ6iPcL2Um0TA+yBWP5WEdlpS+2EW30YX0ee7+G3KpZ7?=
 =?iso-8859-1?Q?vBPqY2F8fiiPQUUp1QC/QKa3pSBKFHlQHSaOkVCdx3C2h/ScK5Cc0+ey52?=
 =?iso-8859-1?Q?KSBoWiIv+8Gw7UGJBtsGyLbg3sGikMKXaEHL/2m8JESldbHo9CKE8xNyA9?=
 =?iso-8859-1?Q?M+VI8f7pZnNZriSGkhWgMTFTQMZLnB1Aq4fqCBURZDg7Ur6evCg4BkgSbg?=
 =?iso-8859-1?Q?RDP8QMyEuG6ijL59k8ow3M4zNabrzP4z8KzicMA00=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR02MB8489.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 98eb92ac-5e44-4083-48b9-08dcd510a1fb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 22:57:39.2987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5842

Hej and hello!=0A=
=0A=
I am tinkering with LFS 12.1 and I ran into a problem to compile=A0git 2.44=
.0 with https/curl support due to an error in the ./configure script for th=
e libcurl detection.=0A=
=0A=
The relevant section of config.log:=0A=
=0A=
configure:5462: checking for curl_global_init in -lcurl=0A=
configure:5485: gcc -o conftest -g -O2 =A0 conftest.c -lcurl =A0 >&5=0A=
/usr/bin/ld: /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/../../../../lib/libcur=
l.a(libcurl_la-content_encoding.o): in function `zstd_do_close':=0A=
content_encoding.c:(.text+0x78): undefined reference to `ZSTD_freeDStream'=
=0A=
/usr/bin/ld: /usr/lib/gcc/x86_64-pc-linux-gnu/13.2.0/../../../../lib/libcur=
l.a(libcurl_la-content_encoding.o): in function `zstd_do_write':=0A=
content_encoding.c:(.text+0x112): undefined reference to `ZSTD_decompressSt=
ream'=0A=
/usr/bin/ld: content_encoding.c:(.text+0x11a): undefined reference to `ZSTD=
_isError'=0A=
...=0A=
=0A=
If I set LDFLAGS to whatever pkg-config --libs libcurl says on my system (a=
ctually: -lcurl -lssl -lcrypto -lzstd -lbrotlidec -lz) then it compiles jus=
t fine. If I add LDFLAGS to the configure environment it will accept that t=
est, and then detect, as expected, the pkg-config settings for libcurl.=0A=
=0A=
Should not ./configure FIRST check for a pkg-config environment without ass=
uming that even the most trivial curl programs should compile without any a=
dditional dependencies like zstd etc?=0A=
=0A=
Thank you for your help and have a great weekend!=0A=
=0A=
Henrik Holst=0A=
=0A=
[System Info]=0A=
git version:=0A=
git version 2.44.0=0A=
cpu: x86_64=0A=
no commit associated with this build=0A=
sizeof-long: 8=0A=
sizeof-size_t: 8=0A=
shell-path: /bin/sh=0A=
compiler info: gnuc: 13.2=0A=
libc info: glibc: 2.39=0A=
$SHELL (typically, interactive shell): /usr/bin/fish=0A=
=0A=
=0A=
[Enabled Hooks]=0A=
not run from a git repository - no hooks to show=
