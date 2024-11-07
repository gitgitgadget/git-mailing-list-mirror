Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2059.outbound.protection.outlook.com [40.92.91.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B015185B56
	for <git@vger.kernel.org>; Thu,  7 Nov 2024 19:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731009179; cv=fail; b=FTKQfpvPfPgWL7PsAJCW6WxNf6d8o0Y4StRR822vpoQubK3WUN27AK02ijEwrm2yG6bg4mcIJaXbUxjwSlSKXkT1L04hAa6hEQiIUMlCVSHvDQOMgcBh0SUUPztLiyOGOsEsQ12UgqK33P/QdgmxZx9hla5arHeJLASW/OefE5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731009179; c=relaxed/simple;
	bh=WOHh5iaptuh+dCzZmbLrhwW1Lv7i4tNOKTYRwbFnuUE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+SFb8G5TDEDmHm2C46T+UESiy1WurNpFek67FEVvWTtWajs5/VQsBD7DAaem5mFa9rM1cmQ/x/SRN80Dn12Bw+uD5ZkFqgZkjYZdPVFZ6eTYAmHxlQk/b3W/YEysUGCyURIxUKiD1fIf2TXWX1z88DLYqI4iKCk6wdP4EcxTD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b=I8qCfvvO; arc=fail smtp.client-ip=40.92.91.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=HOTMAIL.DE header.i=@HOTMAIL.DE header.b="I8qCfvvO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lC4Jb9uMHgf7qv+rak6AUbtIqWSOP0ztcGshh/oBM8H7easxLuaC45kadBZ/SxudZgUsrb27Gq3S5C51/5GdYGVGTxu+VK/A0gXnJ+ye2pRM+VzGQxp0DYXFFIh3JGJlUKwnJWj9R0bShL+LDo3RD94UDuYCSkeDMz5iAidgr+NoG2FxHKnXMOJmZcjKqviH/DjDZfA9uTff1Rfvf9vCvWLwYs0mw/KB1tJ2r8DDuVDKOHMPNvJAxbzXx8Lqj1A7wW2zSIPio1Y4d+SY8/80qhavNOQT2CmQARwgoxCUULNaZQXfYE4Hf5zmGyYCUXioagqA3/OlBEN6u3S1luZFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOHh5iaptuh+dCzZmbLrhwW1Lv7i4tNOKTYRwbFnuUE=;
 b=gpxSKAN/13GFSTeplakAx+AJLS5DDu04VcjkqtJvHgPoOKT9cpaeNOMRwm60OGOwjDVjOr9QgzI//DmFiIC5QzIl/0mykbUX4WKNLiHM5NdWz795YYqCy0uVKtZTkNtk/R0EG/ysrnR8r/JxSfWggDEXGATjbYcTyJ5tdRkwang41r3blawD113VHorWlMYnVqoDgtcVeyvFWv8Ro7B47xNGK9OkNfABp+zbwYx8sq6s2RXyAZYgze+Y0xF2hFBZlpn7LcIOOeXbo1KkoSTxT7ywHimqFvYf3MY1h9M+jjTa8pSXEDjSv6gfBOMpKg+GQjAKUF80v8A7U9JcqfsAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=HOTMAIL.DE;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOHh5iaptuh+dCzZmbLrhwW1Lv7i4tNOKTYRwbFnuUE=;
 b=I8qCfvvO1mf3oHhgtgG9l7JjhaGm2Vuqa6ugtWp7IcodnSu/q5XT6glY+HRureDwZ7PcLjMgVGo6EtxpHQuC0XJF9iQYKQEJ5Rz3dPzlN0awyyF25G+E5E/cIH6X6+IF4WlxUZA2TY9wLSOwKAsqjbCU8VZw0F79R880yFApRD/x0n7OuZwwf1AQJ61XYDp+w4llLob6u66YbB1DVgzkyV7T8RtwjY11nIacEymtIFQoawWKMQH9m5CXypCqWPiePfWEcfPfEuDKTVitq31MFEvLU9vd8fG82uwiqbLRtfyt1UDVXAT+9nl5+9KBs9TpvSSTAC+ZJsjDfo/ZTNqBhw==
Received: from VI1PR02MB4991.eurprd02.prod.outlook.com (2603:10a6:803:c3::13)
 by VI0PR02MB10926.eurprd02.prod.outlook.com (2603:10a6:800:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:52:54 +0000
Received: from VI1PR02MB4991.eurprd02.prod.outlook.com
 ([fe80::8485:dcea:9af2:54bb]) by VI1PR02MB4991.eurprd02.prod.outlook.com
 ([fe80::8485:dcea:9af2:54bb%4]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 19:52:54 +0000
From: Marco Stephan <marc.stephan96@hotmail.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>, "phillip.wood@dunelm.org.uk"
	<phillip.wood@dunelm.org.uk>
CC: Junio C Hamano <gitster@pobox.com>
Subject: AW: Git revert cannot be aborted if the repository directory has been
 copied
Thread-Topic: Git revert cannot be aborted if the repository directory has
 been copied
Thread-Index: AQHbLYr3V59uWnSviEq/qZGwhvgUwrKm5D6AgAVYZU8=
Date: Thu, 7 Nov 2024 19:52:54 +0000
Message-ID:
 <VI1PR02MB4991B262D45E1DE143494F13E65C2@VI1PR02MB4991.eurprd02.prod.outlook.com>
References:
 <AM0PR02MB4980D186BDC087336C760132E6502@AM0PR02MB4980.eurprd02.prod.outlook.com>
 <c1a8eb10-ac62-49f2-a40e-36c41bbdc991@gmail.com>
In-Reply-To: <c1a8eb10-ac62-49f2-a40e-36c41bbdc991@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR02MB4991:EE_|VI0PR02MB10926:EE_
x-ms-office365-filtering-correlation-id: 43212fe8-8b8e-4afc-2695-08dcff65c50e
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|15080799006|8062599003|461199028|19110799003|7092599003|15030799003|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BeD3E7NqUCXYV6INqZ1FkpNEly2dVjFjEXdhKCiJ2wV2fMZZQwig4Jv2L5?=
 =?iso-8859-1?Q?B0ONXpCGXcsYRxUgrQDpxFlexwHxAMDdEJUtuxFXg+7gWoQIvAJTLl9jYa?=
 =?iso-8859-1?Q?fqvGZ+3hDsuqyi4geO7aHfw6fERTRKXMdyNmfMh9vvL1xdvkwscTmxxEDO?=
 =?iso-8859-1?Q?b6aCudylDU8T9qkZdSrNmYEI+T/5N+DhjYE7K0FithkVHBJWVeiD5aBckw?=
 =?iso-8859-1?Q?ihuEHJZlQWsL5rInp9fct2lZB/DQ12DUxlesQJivP8B+WM9nw1Z62WIL3a?=
 =?iso-8859-1?Q?kMtWdlw7Nzu3iaatcEA+oeEKmapyT7UPKPh2fsKQdKMUzzGCBfJUlqHIOt?=
 =?iso-8859-1?Q?zhJBzlsed1km6nknFlUcqmBb+fhYeFPSmiUwdafUzeSvgYa/fC2mwedwHk?=
 =?iso-8859-1?Q?si/kiNH/fJoxTf9NznCqr0Y2TMPlmPqo3Pig23NgwSwzDmBHJpQCL+eJlR?=
 =?iso-8859-1?Q?4BG29epUypTSfqK/JYQivGnkx7RQ2rNjdDbH82aXkreNKAUYI7oJht4tKz?=
 =?iso-8859-1?Q?egR+VwDMRmFu1IxCqFwY/rq91dDiNX4+c6WF1THUJrKZYpF95G6JP3MmVX?=
 =?iso-8859-1?Q?EGgoeErLxw2Yh7S3AMtyf59igIf3peUY/+l1Pp7LaHPLyBvB/to0MGqnTL?=
 =?iso-8859-1?Q?4DQbEO5CLTT4c/JMlnoihOg1c9LaQZaIGQ+Yp7a7qVC1sbt+czXDrwcSbb?=
 =?iso-8859-1?Q?9F0dLs+h1wYB2DZcIcdRbNlPCiyy0YrigbHaIqKJJXMSlrKQncAl3ZUJOg?=
 =?iso-8859-1?Q?8zeQUTn9HiIOON+O0koiBBpCtn/61TCwmkc4zP7vNkkasZLgvjvOJJdRTn?=
 =?iso-8859-1?Q?i6EEePbZ5CdRf0sUcb8lxjj1U01OJiP5auh2giNO7myN97q9y64/OxpVdM?=
 =?iso-8859-1?Q?OgtxK5+oKrDHZl8lZtwxsYm1RouZ024bR9cTf2iJc7ovtMj/iP5Gsm4Z49?=
 =?iso-8859-1?Q?tW8+z+9kOvc3Gpi71vYQwC6DxEPq2odJVU4VduyKCqHuH+a82EXz4OaRQG?=
 =?iso-8859-1?Q?JgarcIaXRioO0MHJh47yFPckfb0SVUp1lhuYdBsw++hVbCVA7gRM8dazH5?=
 =?iso-8859-1?Q?5YjV7So1lh5Cjn8OKhnAlNX5LVzb48egiMqFhSG50/tj?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ykH/CC1W/CKxBI4fzyl+6S/iE3Ai+8sN6/m1yVjaEQRslOfi8U62x/ZV/Y?=
 =?iso-8859-1?Q?vYghLWtVnC/56KadTQcJzIIabtyT5SOWf2g5U+VPM5kjW3ECQDkNYhrxdx?=
 =?iso-8859-1?Q?C4jHVVx+t8p84uk2Xs1TQN4lqJcATu3LGdogRbiW1+pDlFCOsIIPO+Rb+X?=
 =?iso-8859-1?Q?WqWmfnUU+DYfkLCMegCwnY1R3aLTwWfG28EnHJ7SohF4NMGY7+x7cDbmEh?=
 =?iso-8859-1?Q?MBeoW75GHCiX7wD1hqFG7uz7V+3Wq26jEV2g8Ox+NRX3zBqcDXCM3nzV4g?=
 =?iso-8859-1?Q?mShPEnUj3M5R7fPf8/Lqll+VMubHuEGdkHiwT1FbSqcemTVd4UdLfLWewA?=
 =?iso-8859-1?Q?w6mQ3CWE//mCT1WS3+hh2Sbn1a5DbRnvuwzIbcgXiRPdc4w8A2px3q+0b+?=
 =?iso-8859-1?Q?3tt74PYA2UEFQzLOMMMZyThoiESWc218yx7FxzKQa3SX9LZUuDbZQMRWR2?=
 =?iso-8859-1?Q?ku/3mIPUQIniXsl0n8kt9A5aHVndm509L1CkzvklejqORbJCixah27ZhjP?=
 =?iso-8859-1?Q?Qy/8ySyGMfV7rpJaMQXFuR4akJToKv2iAAk7TS2APl6a0F6kTFK1Nih7cs?=
 =?iso-8859-1?Q?5aZ+o/Vuu7Cmdawj3Yv6cqTB1jGPfRbjnNgnGIbzF0NPbZkvXwhxLo9m3x?=
 =?iso-8859-1?Q?yWR/tU4+zZ5Hg2ycYw9vchBcv2yg3k2IOgprGDMlOrPg8d3wa2PpAVSRin?=
 =?iso-8859-1?Q?EScvHczWhuDh/AXCRTTBE+mjgqsJ18YdMvHQVYaPICTvakq+iKA1OhsBGG?=
 =?iso-8859-1?Q?cKS7cx4N4Y/6fYgIfuaadSsu73FFI8HceiiWl3hlNV4PlqyQ/jkCz6ompK?=
 =?iso-8859-1?Q?8v0rQAbcHOoo6zOn00YJoBRmGzHo1+ev/MM36zAdkBhP7wSxLGI+tZKynW?=
 =?iso-8859-1?Q?a/QYtv4bbeHdmKLpruwRxUZdIMSHefzfo/MmYAJMSFYXuSOxP1m/mmAYLX?=
 =?iso-8859-1?Q?aWe9wWnMIOZC6m7rZa/vf88MymHEkuvpCaYSGvadsMj9KjSu9xxVL3zOie?=
 =?iso-8859-1?Q?pBOQJMf3lm2XSBVp33/HDcXlsPyPy4zFAA6v+nSBoHhiEvnnAbE3i1dOxl?=
 =?iso-8859-1?Q?EdCDrcQlrIkR2otWaVQK2IrpqV3OTkicIRDiu5r5kFg81aU9Oql7vxHV3S?=
 =?iso-8859-1?Q?UulOdit6O/i+Qxh7AXjcurWwc2FwvvdcYheXGEU3KUY0cJ0tEPR3DGrLb5?=
 =?iso-8859-1?Q?qIg37amRDl3ijqFOdRQ4Z/+eOLT/VxQeFKaGZ3tuJ5dio1e8M9Ip1czKXv?=
 =?iso-8859-1?Q?vOIZeYV8kOVo95dZXFJDuLuIXsHriB6dePwy2li2thvHK7nknPyZFpQnlc?=
 =?iso-8859-1?Q?EvifkR5XYJRumQvAQiDDKvbJbX+vqiesrVRtOdpskFRIOko=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR02MB4991.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 43212fe8-8b8e-4afc-2695-08dcff65c50e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 19:52:54.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10926

On Sun, Nov 4, 2024, at 10:55, Phillip Wood wrote:=0A=
> "git revert --abort" is a wrapper around "git reset --merge" so I wonder=
=0A=
> if we should change "git reset --merge" to refresh the index.=0A=
=0A=
In my novice opinion I agree. If "git revert --abort" is just a wrapper for=
 "git reset --merge" then I think "git reset --merge" should itself refresh=
 the index. Other commands (e.g. "git cherry-pick --abort") seem to perform=
 a refresh as well.=
