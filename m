Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F81A5B96
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767146; cv=fail; b=DT93IkrC+6RH70v2BzVm23flug0B/LSxvzGFZAmQQXDasI7odtUv07LqKejIhub/OTkAvwRIgxvpwlBbL2xrFEankVW/T8igKrljNUqTYzE51vYFB3utDKzmjJPelUJhFVGN8vRCc2/HyvqtbIbvaF+UToArkj36Wwbp96GTRAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767146; c=relaxed/simple;
	bh=FWWsxzsG6I4RAr/0UGjlvvEaeVSHRiHZygzOxX6ekDk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFlyT0OT8rYbn4h89OZ+0FKUM6WTW5T/maeztxlSOI2lGTW/UcVBjlpgqNtO//vZFO5wOe2Mfl5Mv4ZnPJXQ8Aijx4eOsEcrmPLlXpKd0Xb0ngRdrBVMzvDLL2IjoPPH1lXpAggKrpFru1ODcMu/9wZjWElXHDaR+ppSWid+Jwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ktQlyfFa; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ktQlyfFa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1/YmyCd9xFmUhC8+GRvtAUNgtNn/ORFz/qzAfKa8Ra+bQRw6UcRKwJ1V50ztXxH4O+cN0uAcCgeRn8p1+xMWthHLzG+1IPkjfvTMqPeYHwhpm0vIuNK5FfikA2h52XI8kU1OGFHCSzfNw+6vhRbK9Pp76b+HzGoDx2DHZsYIrkIr5F3QLWI7qrKR8P/WI1GTTeSwECQQcjrqUUCwQYb558HrGuMjDim90k4tLv8i3Flpkk5eI/UVQmxDZeDB/3pvIDkSmrwjyTi0SZZ62SaFZtcirUTCx/ekWXLHyxQ74iuWLNANMvXk/ls7oYnikG9ULPLaXajnroilPl2l9m5GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mnUcolynEEkc90hGMQkyt83peuJCLgUVp7WsrkeK3s=;
 b=ejQj5nW39PUmdE4sLisCJm1oyJ9JMZKE1sFgMg++KiZ9AF7M1Yw/FfMxcQ/sZV3UQ8FYevtkz68WtcDloRK/4dpHopnmBlJq8JS5n5TLhChQBDWrjTrjwZcSgqJ6/aQko/nHCN482BkY+3vy/3k8pSwLb9Nfkmy1F/z8uVwl0ndIgd6k7iogzBKCAYAQNB0SHNZmbOtloFFeNshNjwZdzcydSP3hVXHpUr5h1vE2jChWjT31SKS4F254CkDEXs3bWBfnotA/Z1nvj6QUR7Ayx0H2Z/TKF14QmeI6voLJMgLpt9VPi+b/HTpu4Gckf865I0n8f2QBr5Xid+BBZybo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mnUcolynEEkc90hGMQkyt83peuJCLgUVp7WsrkeK3s=;
 b=ktQlyfFap42+yk3QW1tW7C+U53tHNzPT4NJ9wTpiPtV/uP3Mky+2QCG0Wl4WCkzeco4NEyFZyR1UHEl9SV0g+c4sOryty27BNNJNGFq6TfwU84xzNlQI4/d97fWUbzzQ7xfnd+4hPMyJzFsWvPurKjkVI3WblojhvmQLAFzDKkbK67zoWVc+DqWgLr5FfGdxGU8Lneak6zYUIvYVXl0QHuhvNCu6O23AY64h4KcWWhC6v01wcJhYOntV1AC02+rcXui+Wcl7BfrtKYxWl5rMIipQ1+KvyAolW5b0erCyZFBu5w2l25UIGlVeJ13pEBQ/B+hRYRW/vusdzXR92kv7BA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9527.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.35; Sun, 1 Jun
 2025 08:38:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:57 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 7/9] imap-send: display port alongwith host when git
 credential is invoked
Thread-Topic: [PATCH v11 7/9] imap-send: display port alongwith host when git
 credential is invoked
Thread-Index: AQHb0tCcOoEKc11FF06s1nAL4ZZDfg==
Date: Sun, 1 Jun 2025 08:38:56 +0000
Message-ID: <20250601083821.2440110-8-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9527:EE_
x-ms-office365-filtering-correlation-id: 31be5b0e-15eb-459b-451c-08dda0e7bfb7
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5SefTt7Z8Tg9Ej4PDe/0MlUIXPIclfsHm3h8VR4El5VHsVYBiTtpcOsdcLroOa4U8aznldGXRY8tSh3VbVJew+hwkuUQg2IfJr5DKXOwqcl6WBhGMau/FpnUXNuXtRvV1h8x2VyCDBUFbFiMxq5WTK5qLNMpF6AkLOQX4Fh4mBPUkiUT0puASR5BOMxBvVWbvOI4Aeul0t8HAQevfzJNhJQ7AUEE7mOXyfl5tF79yd7AFIqLP6IXH2SK1Ox4SWkLKb146sbpLuZvPT85cQ2P0KADUO6oeSEfrn4Qnaox/+Bh8wOd4splyunLjjtD97GkeJ+uRjAWJE8vkrxAmUnGGV/OxuaRec4ucLiC/2L2k2IMgHLWpt8dGbULvRRX9y8dgOWdfLKK3qY6xi8Bx+fCLPdpWUCsVXmS9290l2a4EUYiisEVrBYpsCPgAWrOJxf/AHJ74Y84Rusr4sK9Duyy/Puwz3naRPTemBBCKbcFZ0MKXtjVsyvuU9zPhuB/YycdjpgobDgg2lknyupX9yotn+eu+X4T28p542rVkydjdzvvREB+34eTpdCSKZ9rUXlVpF/LvwiFjfvxAJFMgYDe8/FdErSjmyqTzICNni3AUZL0ljWlQmdLuFy6KbvjoUEyq5lX0snry/OxtX2Ui4tARdKykhA7OG4buTnNGQ6SqRaOaN7K7J+ghiL51dzkytf301tXf0xO6WSeQsSnUrfNOWl+kVhznx0eK
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|8060799009|7092599006|41001999006|19110799006|15080799009|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?fTeClMUs/Zl8wBAl9KFPJAeNW5Ie5OAY2CUZKBCOXMLUhd6/1C1dAsQnYp?=
 =?iso-8859-1?Q?uO7Lv02554PT30AhkmdOFTRlJCHC0g8qIRgZc/33B6jMXGnhWNcOLoPq2O?=
 =?iso-8859-1?Q?PaldUue6Mo0LxADVYEi/nbzRLRJBn5HKgUmjU/6g8hN22txbuILikZP4Cw?=
 =?iso-8859-1?Q?iM5y2J7LyH1NtuZf5wNHfY2A/TuLEpZIipJ9rkztE6xxJC0vvwvZ14P7hG?=
 =?iso-8859-1?Q?4gxOidTkkcGcM8gWlJV/Na55iPgnMR2hvEECQz60nG4ViuFkMTjQNkJZXR?=
 =?iso-8859-1?Q?9z3SZG1ZstpFv4T5ZhfKOc5X/X5ZLiXbDIwUwZqtcDsb8twDj60G8dMqXW?=
 =?iso-8859-1?Q?XaaOUAKEryqPkZutZe0dQP4tHRsAXuR+QLZ2/AbaRHbKZAF0aGJbn3KeTO?=
 =?iso-8859-1?Q?SHPD0D1S4EYwSKqq8pW3R7MxEC8c0Jb6O9/W4sgZ4N22GrtL69Ed3iVp3o?=
 =?iso-8859-1?Q?wGkzHtkoVWw6DRG8I4cmNf7XQcKczdbbifFVymSGhe4rs3P0hb8bxCoUKe?=
 =?iso-8859-1?Q?BhfVmt2OkKiFWxJCulqU9MViHtfcmyfz1VPDG9Uv08BTJdyUy4Br1+d7LJ?=
 =?iso-8859-1?Q?In6/A32mJRygiw3Lvza9QGQLpaIjVeKNaD1Guy+h22en3HCGU8csvP19sB?=
 =?iso-8859-1?Q?n3yNe6gAKj/dv5YlYJlxqmM1QlDNWs6Wh8kpamf2HkPBYNOyLRxO0qORmy?=
 =?iso-8859-1?Q?DwfgwMVAJnO+ywN8MBfBXCL4rOKclvsQgImYdNohPzJ/qwEqT4nFKovzYb?=
 =?iso-8859-1?Q?8eYFMc0XIIoilFmR1vhFjFmUCZd4vcy8zRUWUB86xZTyO+95sQ6y0Kqqxp?=
 =?iso-8859-1?Q?VMTNe7Su1xxVNftSxCquzrlKqrrp62aCqX1Pda7dCrXuMTpnEPGEM9Ls3c?=
 =?iso-8859-1?Q?c1XRTihoEZFQ6bisSBRSg9UE0VCq/Kpw1kwvjnaNF4c+maZa68ZgAdOJ2T?=
 =?iso-8859-1?Q?DXx36LcDTzu9eIhLi8Pl+UCS2OXKtDAFz6Y0biGVIuOIEvuMh/pzwZsEqe?=
 =?iso-8859-1?Q?mJ1iVI1G/BB8yhqU7gla5b7JEoxDNUnwvppJHgaSCNkF1VaFwD9Xq3P7gY?=
 =?iso-8859-1?Q?MDTahdF1c45rOXNVkzuibOGZJRDFOP85I2zor3K5nfMc61ecHlZNpcWVVQ?=
 =?iso-8859-1?Q?SaGlN9rg80RwVij4ORyMIRPUHkWh3fkp/PpLdAeYdwE1sc8WgiASn2mamd?=
 =?iso-8859-1?Q?Nfqp8cPp0UDDd3x5XVYgSneuMuxeN6FfKpE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?VviukfVwQTBCD+er52iFWykgHeRUnzlsf/rjFiOVGOAN+geiOyhIPxbia6?=
 =?iso-8859-1?Q?OP4OZ3ezxvSqT0lb5khcvsKJRn489qIZICSq1n4kh+0nHyarqB5zBt8crd?=
 =?iso-8859-1?Q?qQGZJXgaMNN+GvCFXii9AaAieGvf7iXbZEtyqlIcii5mwH0u6mfCvnCKzZ?=
 =?iso-8859-1?Q?YI/tbAwThJKwgBDyodUoI7W1uDq66RkYw573Ic3pkIn+0jV6D8TuitbVLM?=
 =?iso-8859-1?Q?XePASi7OhnZU6mCDOZF5JKLNux4qVujnHjX1u0JrbMFg81kQKjk6lzsYgZ?=
 =?iso-8859-1?Q?pY6MBXoiLegnLnuwRQ3Ig8wZFsnpwyPP1okRE1QIQCgL8B6X7e3E5VL40I?=
 =?iso-8859-1?Q?/5ndBFgyRBO7LtjF67HMVKsMfa8QpBG248/JMbtE3PSXFrwRkAHZ8bMD69?=
 =?iso-8859-1?Q?yLbxtEJjmOgbx3nK87PYTdfDzEP9sjIBB9GZWfRP1jnFDOREp6+vLkzIHv?=
 =?iso-8859-1?Q?CD6DtjwV20oX7jhM5jCzfwq5wAK4vkpFEa9h34EsCvLHAY05Kyd73T+qrU?=
 =?iso-8859-1?Q?yPh9fE/yOPgSveIFhmPI/J4w3gM8YnoJxCvtwd1GrQTnqpjrEZFyU0O8es?=
 =?iso-8859-1?Q?bY8VXBWbqLws1TRQOzjSRP0FIQMOIi64znwejdrFumxR9Xnyr2diby/R1i?=
 =?iso-8859-1?Q?iO/SIV9y+xnNlDxvvterrcUs+DpZCbig3F2sUkmuCabcW47IBr1Kx4MJ8z?=
 =?iso-8859-1?Q?SVj5wQSJ2CgWnPwz5Q3MUlHlUI/bNjGbbrdKoPiJZp+hgyIK57Rb8dkUI1?=
 =?iso-8859-1?Q?IcNWi991Zjvaaq9dvLGXRd/Xp1jFBE8M1qT1X1lLF1fAshXmdeKUv2PAOa?=
 =?iso-8859-1?Q?0xNiq1b32Zujy5gfas4iJbhvcaza7wpC3B0AHqJa3fQAmr/90cot72Og+G?=
 =?iso-8859-1?Q?fZ2VbTX9Y9tmFl0Np4ZuAeB6nbFEY/K6EyeMLpqn7iztrYX06NascZa6fG?=
 =?iso-8859-1?Q?tTMhGx902iYPuOuyvL/yR1DmOftMyP6YlSnWDp+B6FD87eQpiK34RX3wdH?=
 =?iso-8859-1?Q?+Bq5JG8z8mXfFvtdAUOBjFoY65bQwp/QS5mlTHwfQaPF4JgQPdp/ln86hJ?=
 =?iso-8859-1?Q?WMXIhmjIJ0opwdomGqcTafitlysblxUOrqTpAEYLYvJCLHTAsbFX4b2Ut2?=
 =?iso-8859-1?Q?vp9np+PCwb4fiZWW3Oi4L5z2Uw9OMTzZR6KgHQp0DGqQcV1LHaxkjLG2Ub?=
 =?iso-8859-1?Q?yaTbM68YJ/ecAVEewz0KILyNBUvQw+uWC5mCZt7PXP92Gys7OpVlyOtPeo?=
 =?iso-8859-1?Q?ADkhwGeEaJYEhaRx6tcPMRue8uoR5BjbJcXryDLIU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 31be5b0e-15eb-459b-451c-08dda0e7bfb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:56.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9527

When requesting for passsword, git credential helper used to display
only the host name. For example:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com':

Now, it will display the port along with the host name:

    Password for 'imaps://gargaditya08%40live.com@outlook.office365.com:993=
':

This has been done to make credential helpers more specific for ports.
Also, this behaviour will also mimic git send-email, which displays
the port along with the host name when requesting for a password.

FWIW, if no port is specified by the user, the default port, 993 for
IMAPS and 143 for IMAP is used by the code. So, the case of no port
defined for the helper is not possible, and therefore is not added.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 97e7fb197f..9c3c8d8c3c 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1107,7 +1107,7 @@ static void server_fill_credential(struct imap_server=
_conf *srvc, struct credent
 		return;
=20
 	cred->protocol =3D xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host =3D xstrdup(srvc->host);
+	cred->host =3D xstrfmt("%s:%d", srvc->host, srvc->port);
=20
 	cred->username =3D xstrdup_or_null(srvc->user);
 	cred->password =3D xstrdup_or_null(srvc->pass);
--=20
2.49.0.638.g5e24c6cde8

