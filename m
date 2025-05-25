Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA420B1F7
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199303; cv=fail; b=eNTbtD4cnsR23jXPeksOEtGcaWAQcrW5bw7vUJcO5uyLR0Pl3ywW6Q68qOWRdWoGgQEOpo4e6PoLv7aOTovx3VKl/UumJVilynVfrWG7ZiO2+upl0mJTd03+XGyZdpDWsAGo4OzY58fPzZV3GOHyzxwBfAwgebFG+Ym/0lAWoHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199303; c=relaxed/simple;
	bh=+pYgv3zftNhgrLh5t/z76e6HfhK2Y2Vw6uNJpgRL5oY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l1RtIphOHguhTvNxpBsuu97obaczmSouzO30O0N6xBvFO5cOdf9cVXZQCr2X11jPMLAd1QxkDghVPvRONjZBay8eLilqcx2inKAQQSpojbZU+Q1shEo2882mh3P4ePauoWkJRZAFJKOnMZz2om8TRr25GcIrVFPRpiYZqWNJSqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t5RpQ5WH; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t5RpQ5WH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SghrotZvlj+sKoNCx6BLG328hmVCtNX2E8uh8n5JtR8niyME6ihQmuzgca6Ll+mFtTefjGBhL+Noovbi576laBrfAHzo7rkXC25GHDjouvEpLuXCNLDiap6BxxiSQ9mDvbABI89pGXZR8RImb5bLzRIH2fzXyb14LbAyCDShcOv4bwma/JUYS0alKO3CE0XbJwdGSPZ/LUY00cioJk4a2j1oHWueNdmPUJlaqLiOQl7daDPgwcqMSOF6qsVJYC75HdpvW2JyJLbFOjetsIBzPc/DEoDElZRzSux+UHiVKYjYKCFKXT1g0gzaNHE1cqhPQRfHmL/hNhR9AmXU0w4/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbXofGLaCCrA1IxEzrGKoUY+k1TOJ9CW3/vqAxc0CiI=;
 b=su6dKMkRMHcNAPF25W5UzoDam9EcSXb0kGRMmPTjhyq5tt5mNlv5BASxkJFy85j3gqvr0UgH4vAOaYCPDMqW9tPDcEKtpse8zcAcm00a12LPLbrudE0aLgIf8LhqW33OH10rC1oR27gNU+CrXkvXT3kFkLb+qy3O0v0EjujwWme/L7VROelQJNoIBZF3Gd+Gj3yGO3Jo5TvIQI6bM/UPxhJFxrod15yAL3iKis5UyGSAKBe+wNUtBaaj2FDnyrYULpxVzxNXdYAMLg8ds+anc5sIehV0bGPAWBRxO6rrN8ES2L0Ix5vmN4t8b/ZSmjeLas0qB93weWxQ5sGAh8Kj2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbXofGLaCCrA1IxEzrGKoUY+k1TOJ9CW3/vqAxc0CiI=;
 b=t5RpQ5WHeXcv4b5VhHtZsNmXcbeLFQOfaEsiJguneO2WbRWoGbDI9ZE06F1KjPU/LS1MksSIbJleJwYiG2X0w109Y62uSrxSJ0cR6mrvldZc5HlZWUmzX5s+TbZ/BYojBrn4C13E3w0Y0Tcr3AdjAIXqsCPEEP+GKI0KLtyrq7QX4CRL/r6uE0Yedueb6K+EYnVARE2lH6aVnVYyWmH2F2dUir2mhUB3KXq9JJTgOiRgqKSZzIx1hBkJ4QYuXnSY0VCmaV7ef4R3k2iEhX8uA/hUFtcLIXDWdaiKsbC/I8OoImmVyx06CVz1+PHfejwpnmyndGpd/df60kRNCwU97w==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:54:55 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:54:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 1/6] imap-send: fix bug causing cfg->folder being set to
 NULL
Thread-Topic: [PATCH v5 1/6] imap-send: fix bug causing cfg->folder being set
 to NULL
Thread-Index: AQHbzaaBPlkkrkKI7kOZFaJ4GfU9oA==
Date: Sun, 25 May 2025 18:54:55 +0000
Message-ID: <20250525185447.29982-2-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250525185447.29982-1-gargaditya08@live.com>
In-Reply-To: <20250525185447.29982-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: 1c944d16-683d-4d10-73ec-08dd9bbda3f8
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|41001999006|12091999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?31iTCJltJ3BnRCWZWXYd+bqB9wwJc8KOQDJ/jJlJvWsR5+RCsB6Gp8Mn6C?=
 =?iso-8859-1?Q?eUYPol2JbyiLN2sfqhxOtO+c79ALYie74QzJ/mLnz93PPzXX+tt/dk0hlL?=
 =?iso-8859-1?Q?0+jurNXHhshZJOcURwEMXG773GiR+zXsEVmd9zHtJEyQG4CkiZH0f0isvA?=
 =?iso-8859-1?Q?2OFL5r8CFUSYIxFMVNlBaWiPHQCJPtfIuC8hqqIik1TFvPBBSi9YpGs9fM?=
 =?iso-8859-1?Q?VNQL/lGuRgbw8oxQW0/SqPjnVkqH9HUTlsgjemfCvCzTQtY9mvGK50tUlY?=
 =?iso-8859-1?Q?xM4yIuesvMegxqPEmwncjh+hyg7fnIrjRwd0ooMUIn5Tf7dQpzhha5EGMv?=
 =?iso-8859-1?Q?1nz7D6VGy2d2gPWdUHLmCfIuWcrgN/FHyPwMYL5a/HK5/KG3IYY/aEJjJ2?=
 =?iso-8859-1?Q?giHD8O+wXKdKpHKASUS1Ah4Kp5z5thvBqJ0YhBaVT3/Tivy+vGgLkvUSmE?=
 =?iso-8859-1?Q?PHXbLdlAt8GsgO2pz4XX6vyuAyZKWPypk8XDNdoyZr6MDS+4MELbjZTipp?=
 =?iso-8859-1?Q?gJEt4P0DzdYM5FUkMF/Al7/ewTfzh5CspIaCW/X8jO4mbnkRbMwny7IeDI?=
 =?iso-8859-1?Q?L6BtzvCG0XeXJeVqWOjwNijmuckopniBHiNx67uyCwdfKvJAxM8CfuowDY?=
 =?iso-8859-1?Q?odQXzZI2Nzi4x2Uth+jILZDzB7cuVGPLKhNjiMYd3mo5fTEJ2qBJQCF2eU?=
 =?iso-8859-1?Q?ik/eQkjeUF5Q8+3/sRfxXY902RxvfhZlWufRGlljrg7HQh6WsE7CpL5oVC?=
 =?iso-8859-1?Q?FNDyeYrdGfLSPDEX6s2suXbiQVMZCAJYN1FnHDb4vgxRppflwABUlQ9vf5?=
 =?iso-8859-1?Q?n6mMYltK+v04mLT1r61bipQF/f2v2FnD3/Wnrwb5rQcYQ/K4a7Z95HYFk2?=
 =?iso-8859-1?Q?dCoMaihnlblM1wJAXMMzmjJGd+chitTCioygjwvWJp3HRb3D6I5rd3O3zy?=
 =?iso-8859-1?Q?ldu8hEbQadH8baKuOPNM5TPJg1EbBd86FfJ/Znru6Ul0j1/SvtnGDLCA/F?=
 =?iso-8859-1?Q?auVhRYQRT5H1wZF41BQBCPBeGHJl20Ka8HKTmmM/Q20fnh1HPiBhIc8r8V?=
 =?iso-8859-1?Q?0IbgsgEtx7B7tTCSS2fJDjHYyV18PvCXp4FypOXeEeZtGK4/Is0Z+ioqTu?=
 =?iso-8859-1?Q?GhamLx3kh2Yy1tcSIz7BrQcJI1ofpgr9LIlwwHm0hSG55+WcBbRqfqKgVx?=
 =?iso-8859-1?Q?W+3fGcI/OLI+zEsHjI+scxyzOrgcE7Vra8n7Pm3pesz+APsbR5TsWBsiA5?=
 =?iso-8859-1?Q?VS0KAQO5HHDyaPuyziOAM8rR0nNPRCREBI80szmoU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Euq4mfxMbfVefKvi4THXeH1gzAOVi8DXXSBooyt6JP8Q5VAyjXO05qdYm5?=
 =?iso-8859-1?Q?+/ZZjhv21D0VOyHoKcsPfbCxl+3tUnoS8RzTnHlc5P6OSTxylVJQXo6TRL?=
 =?iso-8859-1?Q?OAGp8XG9wrSmTijfm4WEFoR8LjHvzogzOXZkzdO7DCy4qqrE1X/RL0wPhm?=
 =?iso-8859-1?Q?7+TIi1yzX/Q1V2uSfDJqtdjX2sxps0TMlIWNnC/MWZBbj4KMYiab84dQ9p?=
 =?iso-8859-1?Q?ibjDkBUCCitfVhu6e+3lnbO1IO+AC4gJBmApqQm1z3MREHPyxylkQLBhl3?=
 =?iso-8859-1?Q?/E+Yh7mbQsqifnGfR2CVWrmYwxuhHDWzdn1b5+z5Du0uHyPCAusqdCacpS?=
 =?iso-8859-1?Q?0UuvmqzP1jkbRRVihaMR4Kg4Fo1kG7ngtxPxPd+8rqr5sgpn7hGCwc6E9G?=
 =?iso-8859-1?Q?sB6OWWW9pnsJY4lQtDojzQIhpq8abFnX2h4ndq+dyvla6pZiSGxlDsfE8X?=
 =?iso-8859-1?Q?HzFvgOrVDE4y3h4I78I6pezm4LJeWqHIS99PLYsNauzGm5CJXxqXDEnGrl?=
 =?iso-8859-1?Q?K4Cfz+Ff1PY3ngHnFRv5AtL2UmajlvBXYR8iu7Dn61PqhfUVqZcm5GMvLH?=
 =?iso-8859-1?Q?Dq6Uov5G3tbn5G6oe9UM4ZMre7IkgSRhAnI8xX1SVw0tVAtCA7XQW6LLJi?=
 =?iso-8859-1?Q?D/6IQZ7GMs57emObFQihjkD3dd3Xgq7Uq7lDa+bZT9T+zfZ5lzCgjspGBC?=
 =?iso-8859-1?Q?XIQf6zTIZ74zLVzIU06sj/n7v9QXfMMDZWigQTiTbIr02yziw60ZiydAP0?=
 =?iso-8859-1?Q?YIEMRnEp5Z91NkfoJLOJZkdlzjgbl6pyqpjnoU46UPlW5MqCqBrABOhWIX?=
 =?iso-8859-1?Q?tyGWHgRnL2p2FwiN1+1grQQtSDLYfRLL4bAzDCX8atddNb7HFNdgPCSwe5?=
 =?iso-8859-1?Q?5YWdf0eDWU1bHA9u5/Z4rJCcgoVCOPB2F/1+cQl/rvLezjRtNs1IpW/ccn?=
 =?iso-8859-1?Q?NLUGTDqXH038chGF8l0VYYs8vtBwf3yOgmPilnakztY+LPWLamupX6xreQ?=
 =?iso-8859-1?Q?H0peKSwy7Po28PT0uI6feOxOM76AlwPS4yxXOFw2vt1s0wWQasy4QwGMJi?=
 =?iso-8859-1?Q?wg6rbktV0HAPqaWzikqbd5O8/Y6i3v8sBHWRopMneGz33ekszVNgHf0g7N?=
 =?iso-8859-1?Q?132CMcwSwLgsTva8jVKcg1trf+KlxZxAY/ShN4nqv6Y6JSCQIidQbGqEgJ?=
 =?iso-8859-1?Q?rtmDQjhQ6dL/T1Ole8lIBFSnQgqzmOkhdl1Q2NnSMwQ3vAJexPCo9zp9mN?=
 =?iso-8859-1?Q?IT/Ob2/N3/l/4F3JWQ8537xZn2UN5zoJL3RD/08IE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c944d16-683d-4d10-73ec-08dd9bbda3f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:54:55.7970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07=
)
resulted a change in static int git_imap_config which resulted in cfg->fold=
er
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed fo=
r
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const c=
har *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port =3D git_config_int(var, val, ctx->kvi);
--=20
2.43.0


