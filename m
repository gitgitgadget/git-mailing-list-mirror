Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013049.outbound.protection.outlook.com [52.101.83.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913792459EA
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770639909; cv=fail; b=dDkLU+y69nlqOpRk8NQHuS52Ok4A6WHqJciuhKFBGljbnbeGfTGuUllVNu0x6qdepN2Nt/EWKhMWh/+wVtZMsakhtj9EB3/qn/BcrHVGCjjN0vsv3Ca76Kg9UwfJUKghdSZlIV5p4jJinPtSK9kce+dhApf/knF31nT/AAzwzfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770639909; c=relaxed/simple;
	bh=nRkvnIDKP8jp1y+vAiZjwrRUIAKv6IpQkOI9vdT2xmI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QBs4zrB0in5kBbR3zHKVcBNvcBkpOwjuox0opAwDRXE28umOTO1BQj2G5bbxBs4YwYgKRMXbpJ+CrQDQ7STwNyWdq+Oys41nCXrJqYpQ9D9tEkPOaXrCz5Mrm3/cyF58RLjPqnzi/XevBZYH7tR15EQ+3mRkZnme7GrZJUgT4Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com; spf=pass smtp.mailfrom=sap.com; dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b=DJpSA485; arc=fail smtp.client-ip=52.101.83.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sap.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sap.com header.i=@sap.com header.b="DJpSA485"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mAPz+LLNnTWBL2Y5ZQuUvLdrLyuFlG2YiOIJ2W1MGk9nPCC3/LCV6PCCMYam5zgOLXgitRka1T/t610GdRYQjLSigyATQLJ3dOB3Yw2B6jygYHjJq+k2Wif0Gm8kfnOPtZuBmAFRACDVrVXZOX8F0C3xln/UXMmUHgZqxaBdms3tEU4AgmI0ZlpDCDNHBLKo+UoaNRAA8W0ZnWuNCSFyX98nBQqBaJCeKNsoVeogux9jDgDFGlzARjSe0lGqyHktCASZVFBoy3bWujuv68qGUR4iAXet1sklODx2SseJ9HFX+BrLu6VLwHq3BLbcbIHEwnfzrSBSDdokiiyvZR56PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGqGpY7HdFr/32+I8Xy4CaR4oKnJ8db8MPZ2unRc1mQ=;
 b=KTI385LPsQhgtwfWaJRm31i+YCmQcNqUwErDLy9mFs4NHdx81HjrgoxwMLtjMRtSVuG478/nbl3uyL26UOkedIEMdgV9WC18LTomxvwLmS75YObbYi2x5nrmm00PekznrbFvwRKnvNl6kVHS9GspkdvU1kQLOMuXQPE3fLeg/qSMowZ/J6koJo4luSlgB1azDd7NJDJ0G3KWe9+M7grfvPtE4ZvNE2Gq9I7R+F5Ds5YmphGIGrqNN+2oP1DZuclyVbU8XXAZAAtqj4fNaVh45gl73NPXCHz2lwEiGuHhoQrHJbJzR3jVKJTykyhrNBpgKzJ6BZvWZxSDn4eglRLjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sap.com; dmarc=pass action=none header.from=sap.com; dkim=pass
 header.d=sap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGqGpY7HdFr/32+I8Xy4CaR4oKnJ8db8MPZ2unRc1mQ=;
 b=DJpSA485CxWBlgHO6Ll8npTTE96IFmqrJSwf7N0dYvzDquO4qRRIrrapRYbKGNkaKHkypHPAtmVcN1q5D4OG2IuFEnJtI5PUer0ihFkhty3CMXMbR1GmH8HbXI8/FXGQlCZXO7GmWrrsdAtYvyf3T718Dmf8shc2iBgmAKfh8meYljFlPi/I08lVsJ8yEA6z81DCOKWdbh8jh0fbsvmaV+aNLTdbyWaLlu1Z1AdTwDf8Nw2oHw781PR9xm+oCda3l6aAh1sjstgZWy6l41kV9mJ9U3hzKvczybpa4WqbSaGoXDo0bPwwGH6LtspMHRApcK72B8/5N+6RrZocYNoNsQ==
Received: from DB4PR02MB8535.eurprd02.prod.outlook.com (2603:10a6:10:389::9)
 by AM7PR02MB5985.eurprd02.prod.outlook.com (2603:10a6:20b:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 12:25:05 +0000
Received: from DB4PR02MB8535.eurprd02.prod.outlook.com
 ([fe80::a462:a824:26b9:da32]) by DB4PR02MB8535.eurprd02.prod.outlook.com
 ([fe80::a462:a824:26b9:da32%4]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 12:25:05 +0000
From: "Czuczy, Gergely" <gergely.czuczy@sap.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Patch: Enable static builds
Thread-Topic: Patch: Enable static builds
Thread-Index: AdyZvpJ+gzxYAfgMQ/63GVGnPAJ7EA==
Date: Mon, 9 Feb 2026 12:25:05 +0000
Message-ID:
 <DB4PR02MB853530284728178B3731BA419265A@DB4PR02MB8535.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB4PR02MB8535:EE_|AM7PR02MB5985:EE_
x-ms-office365-filtering-correlation-id: 1ddd11d3-ee2c-46b3-f5f7-08de67d6416f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|6049299003|38070700021|8096899003|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nE9UYvX8uqMuhfZXNJaZ8fDMv0xtLFEWD9RqD6EvYPpi1l6bBJE2GXpQdg2Y?=
 =?us-ascii?Q?kiAh80n58DNC5pD/Yws+YLWISJX3mG3PoecBybOJflV6/ZZ1IJHFRXGaaIlo?=
 =?us-ascii?Q?pdqstvIB+xqyXOyFEZKGv9LOkwEBhQatYlmU1kaUCZus+qnksq8Yt3N28M5H?=
 =?us-ascii?Q?PrAQ7WRbwTx4agrwmJO9v6JyMxczbjKnywiSl6+/t24V05TVVYAUMThGeEvR?=
 =?us-ascii?Q?MfvNSDGsRuiFrfD3VeLA8b0cOh/xDS6BvHWF/nCdatQO9BSCVjozGoBipC+Q?=
 =?us-ascii?Q?OIzmiPVbzUnvFic1qQuFkRwRpUK07t9o8QMR0Vag++sf/wyTiXkDnJLYTU0v?=
 =?us-ascii?Q?hc+TqeKgsxkHxNkwyKeYGTs1VoFaYF8LGiIfJigaLQTdTPraB8Lcr0Pr5ZII?=
 =?us-ascii?Q?+mE01PHxR3blx7zAKwCdlQIZCN1WW3pkggu76TwVt0Rbt6e2vkbKAU0eksuL?=
 =?us-ascii?Q?jGsgPnm9AslXux030JsbIarJBe1EyjUxJbJgAyxelTURVB2Nids0aAa0q6It?=
 =?us-ascii?Q?LZiFj4LKA3BWt56Gov5jzNekoQVuqGi8xpjpUdwRw/FXjQHWoZl2ByDA6bFA?=
 =?us-ascii?Q?1EG3NWHGU+ljR6f6zfWu0WLnvTlaruLYGkZQf+5Ft0B5jLV3N6gmWxpcjM0w?=
 =?us-ascii?Q?jegOTSYMocviUu1C2C/G5fW/DtL5HuNms6DLnXPsVSWx3ReIH97qnBcBMGq1?=
 =?us-ascii?Q?P/5NNpiVOms9MJfDhFKMa1dx7zPsxfkljpy21j1I2Q7EDwetmef7Q8UeTahC?=
 =?us-ascii?Q?VNnOhYbbPlaIiAZs5vO0jsfpLBOoMLl+E9hn0MaLqrwdvzCQM+1//bIxAz3w?=
 =?us-ascii?Q?eVlvHtbOAI0jSoqCQ7CY9nWpVlo7x1rMPcXDdLsp8VezXYjyVDYbIr6e9uN5?=
 =?us-ascii?Q?xcWtbFGDqslKsh3msJ9ZvDFMc/yKDBHkUU6M9PEFOyXRgPm5NYcYvqXGlrKz?=
 =?us-ascii?Q?7vKoGgFeN3NlsbMCHB633aDJa3Wjoqcbngvz9bDmGq6NANvQP0TrHrkCvF+o?=
 =?us-ascii?Q?1XrguOBBmQwJ239XVJanBz9vfD3mbcogG2d+m9Hiq0KS9CfE/uuAeQQHPg9A?=
 =?us-ascii?Q?jZvLLXwc6kLGWdhMQqjUihvfUAQ9SI4ESawBZLr0z71i//r18YOGLgYalq7A?=
 =?us-ascii?Q?WXzeX+reWFSfsQDn4NjSXZ7j+oy2TFCIed9IMKPwGa4CtfxqWyTkEjkwPair?=
 =?us-ascii?Q?NHUhLxttf7CFHqxH/cavmdSMok8s9T6DL5Qvmh/hyK9c2EL8/Tw8yAmSjK+d?=
 =?us-ascii?Q?3Aw30hP7KpKODJWCL8r2zA6BjWUrv0emuBHcK3kbyYfyddtpHs2BxrXLcIiI?=
 =?us-ascii?Q?4YSYCcj+zJjcRfWdWexHbXO9/53L4iBGzk+HILrFTc3ia1I7RJAbD2cTUGzG?=
 =?us-ascii?Q?5+WAiIQPwmGZ1Z5LXnAsQqqRqGJT4Zc75lAJCuXSz2wz6J+5VRGh0KdVh7Lz?=
 =?us-ascii?Q?ZjLzuRYsBqpRjmNd11eKFgoFQdqhCZuj/lCnlCtqt6rV0HmofKhTzCxkev6c?=
 =?us-ascii?Q?Ib3j/2QQ4jVffnhrAdQkzWFewJgE6aERoBOSm3nnqJWcHdawN9JvT7xJkCAv?=
 =?us-ascii?Q?DRfk/u6du1jAIZQUOO87i3cx8igsxOyQBjCbjLSKk3AlgdPcijKhQpF4PJ+v?=
 =?us-ascii?Q?5aHLNv522XCqWuaxLpXLcMw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR02MB8535.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(6049299003)(38070700021)(8096899003)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JiP1F1M+jJ29HO3MEfBphAEs1TQpiH13YW5ZTit9TDH44hgDbXCMnb9n+oSM?=
 =?us-ascii?Q?rP3UEKNrQEMTqaTCVstYWmh+dVJ5ZvnGG1ndMlVLSTQWiuYgs3pJxDBMXYYz?=
 =?us-ascii?Q?mujGVEV+1rPAVhW5hjwMT/ndSuhHAtYyz9+rZKmO6AG8pCIctji1199CKvid?=
 =?us-ascii?Q?PNfXD4a2OpoByjxDU+Ueq+o6Qt7fFdQTWz5fpytHzaDvaJQNwKsJVW5QMWob?=
 =?us-ascii?Q?FhdmpdAmBlphN/MHCunTPvjT+UgCAP0B0aOZZhQo0whUzj47vV6jk2W6FTbs?=
 =?us-ascii?Q?LKIfPN+LLe0mu8sSFHhDNsGjSZgbZem/NwzOIVBCXtLrGW6NMF3dxm/KTJLf?=
 =?us-ascii?Q?rp5y/NNvlz/VLiYJ6khGhWK5K/MKbNXkxx/XbIifyAPbUy0mEwVyrD5xqs4Z?=
 =?us-ascii?Q?9vhcJrVKQ3cZK73IN6Oa5RmWF0uf1lp7fSiz0zdOK6+G1lBLXd8QITg3I2ZJ?=
 =?us-ascii?Q?jzJon6bffKoyF9GLHlG2ou4aHwXZucBmyzbTRi0PC7Njv1Jza+hs1lrS1uEU?=
 =?us-ascii?Q?utMDHoXbbZ5ZAB2D4ERSeihfnt4oxsF8uNTfQqg45VDIWY0ANrBxNNKqVOrs?=
 =?us-ascii?Q?GT6x+lDEdZ6uUvkgrupKWDP3haFXHAAGVuA91z0H/1fds4ZRenwrtySFEzbo?=
 =?us-ascii?Q?nu4G8uYsk1HKxwHub+kRCefyi/r1NZwPTgSIM4bs33rUWU2m5AxQZ5avs12N?=
 =?us-ascii?Q?TaH+zcyrM4ORv82PVkRbpSMk/sg2j8eDJIJ7lhARFAtN9bpgGXzLeP306Pk0?=
 =?us-ascii?Q?2xOJ8z65l8/Lz51YqM4Z4PzqdsD243pVF72MboLRGMaMuyfoknmel2IogGky?=
 =?us-ascii?Q?ssZEnfXyDmiev048m+b8MJW0+OQLpFX7eRq0s3ZjSn1+GMD89CvJgN1kKWW+?=
 =?us-ascii?Q?ovt/aPnbm4wv2P0+OOcUlnSzKkwkhFunY+xw1nAy0Yn2UcasiVH5OVQeVmGS?=
 =?us-ascii?Q?/bpcCS8F25u8yzJkdEW2Dv4SXp4E+vLwzlEM+4TGqneSQVhbc2trgN7BOF1Z?=
 =?us-ascii?Q?pTo/J+FTp/M0fBI/UCC09wPXoABefn5enKcO/hD+GJAIoiMkhG949axHmf7+?=
 =?us-ascii?Q?5yof4OqdeIM+2+/dY/jJerO86SfkDLXybASl4A8ePYEBjXPLPfD+SoT/bWRK?=
 =?us-ascii?Q?vJVBkCGBZ8DdGMnKAXKH2Auk71Yfq6kI8U1C2Zqn0UCAwslCMaWsg//9OCH0?=
 =?us-ascii?Q?qOH6y3m6pVvnk136K3S0iHzHnQuBMWfnc5+9F69XfksF8EjU2HBWeiEs8P8D?=
 =?us-ascii?Q?ciqvsfFyalW2TDNpDm5gaET53ThZ/7RXyXwMdQ6OIMsRiByBNAkQHJBk+JMk?=
 =?us-ascii?Q?fNQS4O/QwuTpJUi9m6LqJvpPkAGkJOpoODgVCulU3Gh8ESA7gN3oUC9u7sfL?=
 =?us-ascii?Q?gruAKsTY8D2FS8Jaoc/xGChc5nlLqRxJpVHz7kGtQr46GIL1gtRjg3RaKIW5?=
 =?us-ascii?Q?RKl8APJpoiBZjuvOG+PBGTGQsvAvcmj7TD16253ZB8T3P3KwovFuBZe4+Z+3?=
 =?us-ascii?Q?c0IdT6elldkWKyYuEUFuuYmx9RHgZFm4AZStI2KrqF6DUxxz+jsW9XjpYtlf?=
 =?us-ascii?Q?sXB8c2coYxpvMx970t7TmYFxTE8vN89VCNlDv9IxnmIH15XFn8tIKy81E2KE?=
 =?us-ascii?Q?taXsiKnh4ewl5BsIY/IaY/ahS6MI8fMjR5XE58jrQKVwVlOCD2wLFJ5NaH8u?=
 =?us-ascii?Q?BmoYQjUluNmKm/p3y1/8WHsy1SmxUZQOBia666HgAp+feAR0p3hJConpRI5e?=
 =?us-ascii?Q?oy/p3vBgbg=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_004_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB4PR02MB8535.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddd11d3-ee2c-46b3-f5f7-08de67d6416f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 12:25:05.1426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 42f7676c-f455-423c-82f6-dc2d99791af7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NAfPOusdBlKgDBz/8lQ24SmcEFDBuye3hB/L/pMvjrWz9W7M+3UaBumqBlpN6yGi5P2JhuAGsI+1BTSTY9IZuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5985

--_004_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_
Content-Type: multipart/alternative;
	boundary="_000_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_"

--_000_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

We are building git statically in a container, however this require a tiny =
adjustment, and I would like to submit our patch, allowing others to painle=
ssly do the same. The attached patch applies clean to master and v.2.53.0.

Changes included:

  *   Makefile: Add the STATIC_CURL_LIBS to targets where needed
  *   Shared.mak: Define STATIC_CURL_LIBS empty by default
  *   git-compat-util.h, usage.c: The symbol "error" is conflicting, so it =
is renamed in order to resolve this conflict.

Best regards,
Gergely


--_000_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1605964591;
	mso-list-type:hybrid;
	mso-list-template-ids:-545512776 -828500764 67698691 67698693 67698689 676=
98691 67698693 67698689 67698691 67698693;}
@list l0:level1
	{mso-level-start-at:0;
	mso-level-number-format:bullet;
	mso-level-text:-;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:20.25pt;
	text-indent:-.25in;
	font-family:"Aptos",sans-serif;
	mso-fareast-font-family:Aptos;
	mso-bidi-font-family:"Times New Roman";}
@list l0:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:56.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:92.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:128.25pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:164.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:200.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l0:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:236.25pt;
	text-indent:-.25in;
	font-family:Symbol;}
@list l0:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:272.25pt;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l0:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:308.25pt;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We are building git statically in a container, howev=
er this require a tiny adjustment, and I would like to submit our patch, al=
lowing others to painlessly do the same. The attached patch applies clean t=
o master and v.2.53.0.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Changes included:<o:p></o:p></p>
<ul style=3D"margin-top:0in" type=3D"disc">
<li class=3D"MsoListParagraph" style=3D"margin-left:-15.75pt;mso-list:l0 le=
vel1 lfo1">
Makefile: Add the STATIC_CURL_LIBS to targets where needed<o:p></o:p></li><=
li class=3D"MsoListParagraph" style=3D"margin-left:-15.75pt;mso-list:l0 lev=
el1 lfo1">
Shared.mak: Define STATIC_CURL_LIBS empty by default<o:p></o:p></li><li cla=
ss=3D"MsoListParagraph" style=3D"margin-left:-15.75pt;mso-list:l0 level1 lf=
o1">
git-compat-util.h, usage.c: The symbol &#8220;error&#8221; is conflicting, =
so it is renamed in order to resolve this conflict.<o:p></o:p></li></ul>
<p class=3D"MsoNormal"><br>
Best regards,<br>
Gergely<br>
<br>
<o:p></o:p></p>
</div>
</body>
</html>

--_000_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_--

--_004_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_
Content-Type: application/octet-stream; name="git-staticbuild.patch"
Content-Description: git-staticbuild.patch
Content-Disposition: attachment; filename="git-staticbuild.patch"; size=3102;
	creation-date="Mon, 09 Feb 2026 12:21:55 GMT";
	modification-date="Mon, 09 Feb 2026 12:25:04 GMT"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBpL01ha2VmaWxlIHcvTWFrZWZpbGUKaW5kZXggOGFhNDg5ZjNiNi4uM2RiNjIy
MTZkYSAxMDA2NDQKLS0tIGkvTWFrZWZpbGUKKysrIHcvTWFrZWZpbGUKQEAgLTI5ODEsMTQgKzI5
ODEsMTQgQEAgZ2l0LSUkWDogJS5vIEdJVC1MREZMQUdTICQoR0lUTElCUykKIAogZ2l0LWltYXAt
c2VuZCRYOiBpbWFwLXNlbmQubyAkKElNQVBfU0VORF9CVUlMRERFUFMpIEdJVC1MREZMQUdTICQo
R0lUTElCUykKIAkkKFFVSUVUX0xJTkspJChDQykgJChBTExfQ0ZMQUdTKSAtbyAkQCAkKEFMTF9M
REZMQUdTKSAkKGZpbHRlciAlLm8sJF4pIFwKLQkJJChJTUFQX1NFTkRfTERGTEFHUykgJChMSUJT
KQorCQkkKElNQVBfU0VORF9MREZMQUdTKSAkKExJQlMpICQoU1RBVElDX0NVUkxfTElCUykKIAog
Z2l0LWh0dHAtZmV0Y2gkWDogaHR0cC5vIGh0dHAtd2Fsa2VyLm8gaHR0cC1mZXRjaC5vIEdJVC1M
REZMQUdTICQoR0lUTElCUykKIAkkKFFVSUVUX0xJTkspJChDQykgJChBTExfQ0ZMQUdTKSAtbyAk
QCAkKEFMTF9MREZMQUdTKSAkKGZpbHRlciAlLm8sJF4pIFwKLQkJJChDVVJMX0xJQkNVUkwpICQo
TElCUykKKwkJJChDVVJMX0xJQkNVUkwpICQoTElCUykgJChTVEFUSUNfQ1VSTF9MSUJTKQogZ2l0
LWh0dHAtcHVzaCRYOiBodHRwLm8gaHR0cC1wdXNoLm8gR0lULUxERkxBR1MgJChHSVRMSUJTKQog
CSQoUVVJRVRfTElOSykkKENDKSAkKEFMTF9DRkxBR1MpIC1vICRAICQoQUxMX0xERkxBR1MpICQo
ZmlsdGVyICUubywkXikgXAotCQkkKENVUkxfTElCQ1VSTCkgJChFWFBBVF9MSUJFWFBBVCkgJChM
SUJTKQorCQkkKENVUkxfTElCQ1VSTCkgJChFWFBBVF9MSUJFWFBBVCkgJChMSUJTKSAkKFNUQVRJ
Q19DVVJMX0xJQlMpCiAKICQoUkVNT1RFX0NVUkxfQUxJQVNFUyk6ICQoUkVNT1RFX0NVUkxfUFJJ
TUFSWSkKIAkkKFFVSUVUX0xOQ1ApJChSTSkgJEAgJiYgXApAQCAtMjk5OCw3ICsyOTk4LDcgQEAg
JChSRU1PVEVfQ1VSTF9BTElBU0VTKTogJChSRU1PVEVfQ1VSTF9QUklNQVJZKQogCiAkKFJFTU9U
RV9DVVJMX1BSSU1BUlkpOiByZW1vdGUtY3VybC5vIGh0dHAubyBodHRwLXdhbGtlci5vIEdJVC1M
REZMQUdTICQoR0lUTElCUykKIAkkKFFVSUVUX0xJTkspJChDQykgJChBTExfQ0ZMQUdTKSAtbyAk
QCAkKEFMTF9MREZMQUdTKSAkKGZpbHRlciAlLm8sJF4pIFwKLQkJJChDVVJMX0xJQkNVUkwpICQo
RVhQQVRfTElCRVhQQVQpICQoTElCUykKKwkJJChDVVJMX0xJQkNVUkwpICQoRVhQQVRfTElCRVhQ
QVQpICQoTElCUykgJChTVEFUSUNfQ1VSTF9MSUJTKQogCiBzY2FsYXIkWDogc2NhbGFyLm8gR0lU
LUxERkxBR1MgJChHSVRMSUJTKQogCSQoUVVJRVRfTElOSykkKENDKSAkKEFMTF9DRkxBR1MpIC1v
ICRAICQoQUxMX0xERkxBR1MpIFwKZGlmZiAtLWdpdCBpL2dpdC1jb21wYXQtdXRpbC5oIHcvZ2l0
LWNvbXBhdC11dGlsLmgKaW5kZXggYmViY2Y5ZjY5OC4uZDhlZTEyYTRmOCAxMDA2NDQKLS0tIGkv
Z2l0LWNvbXBhdC11dGlsLmgKKysrIHcvZ2l0LWNvbXBhdC11dGlsLmgKQEAgLTQyNCw3ICs0MjQs
NyBAQCBOT1JFVFVSTiB2b2lkIGRpZShjb25zdCBjaGFyICplcnIsIC4uLikgX19hdHRyaWJ1dGVf
XygoZm9ybWF0IChwcmludGYsIDEsIDIpKSk7CiBOT1JFVFVSTiB2b2lkIGRpZV9lcnJubyhjb25z
dCBjaGFyICplcnIsIC4uLikgX19hdHRyaWJ1dGVfXygoZm9ybWF0IChwcmludGYsIDEsIDIpKSk7
CiBpbnQgZGllX21lc3NhZ2UoY29uc3QgY2hhciAqZXJyLCAuLi4pIF9fYXR0cmlidXRlX18oKGZv
cm1hdCAocHJpbnRmLCAxLCAyKSkpOwogaW50IGRpZV9tZXNzYWdlX2Vycm5vKGNvbnN0IGNoYXIg
KmVyciwgLi4uKSBfX2F0dHJpYnV0ZV9fKChmb3JtYXQgKHByaW50ZiwgMSwgMikpKTsKLWludCBl
cnJvcihjb25zdCBjaGFyICplcnIsIC4uLikgX19hdHRyaWJ1dGVfXygoZm9ybWF0IChwcmludGYs
IDEsIDIpKSk7CitpbnQgZ2l0X2Vycm9yKGNvbnN0IGNoYXIgKmVyciwgLi4uKSBfX2F0dHJpYnV0
ZV9fKChmb3JtYXQgKHByaW50ZiwgMSwgMikpKTsKIGludCBlcnJvcl9lcnJubyhjb25zdCBjaGFy
ICplcnIsIC4uLikgX19hdHRyaWJ1dGVfXygoZm9ybWF0IChwcmludGYsIDEsIDIpKSk7CiB2b2lk
IHdhcm5pbmcoY29uc3QgY2hhciAqZXJyLCAuLi4pIF9fYXR0cmlidXRlX18oKGZvcm1hdCAocHJp
bnRmLCAxLCAyKSkpOwogdm9pZCB3YXJuaW5nX2Vycm5vKGNvbnN0IGNoYXIgKmVyciwgLi4uKSBf
X2F0dHJpYnV0ZV9fKChmb3JtYXQgKHByaW50ZiwgMSwgMikpKTsKQEAgLTQ1Nyw3ICs0NTcsNyBA
QCBzdGF0aWMgaW5saW5lIGludCBjb25zdF9lcnJvcih2b2lkKQogewogCXJldHVybiAtMTsKIH0K
LSNkZWZpbmUgZXJyb3IoLi4uKSAoZXJyb3IoX19WQV9BUkdTX18pLCBjb25zdF9lcnJvcigpKQor
I2RlZmluZSBlcnJvciguLi4pIChnaXRfZXJyb3IoX19WQV9BUkdTX18pLCBjb25zdF9lcnJvcigp
KQogI2RlZmluZSBlcnJvcl9lcnJubyguLi4pIChlcnJvcl9lcnJubyhfX1ZBX0FSR1NfXyksIGNv
bnN0X2Vycm9yKCkpCiAjZW5kaWYKIApkaWZmIC0tZ2l0IGkvc2hhcmVkLm1hayB3L3NoYXJlZC5t
YWsKaW5kZXggMGU3NDkyMDc2ZS4uMjc5NGU1MWE0YyAxMDA2NDQKLS0tIGkvc2hhcmVkLm1hawor
Kysgdy9zaGFyZWQubWFrCkBAIC0xMzAsMyArMTMwLDUgQEAgR0lUX1VTRVJfQUdFTlQ9IiQoR0lU
X1VTRVJfQUdFTlQpIiBcCiBHSVRfVkVSU0lPTj0iJChHSVRfVkVSU0lPTl9PVkVSUklERSkiIFwK
ICQoU0hFTExfUEFUSCkgIiQoMSkvR0lULVZFUlNJT04tR0VOIiAiJCgxKSIgIiQoMikiICIkKDMp
IgogZW5kZWYKKworU1RBVElDX0NVUkxfTElCUz89CmRpZmYgLS1naXQgaS91c2FnZS5jIHcvdXNh
Z2UuYwppbmRleCA1MjdlZGIxZTc5Li40NzJmNzY0ZTZjIDEwMDY0NAotLS0gaS91c2FnZS5jCisr
KyB3L3VzYWdlLmMKQEAgLTI4Nyw4ICsyODcsNyBAQCBpbnQgZXJyb3JfZXJybm8oY29uc3QgY2hh
ciAqZm10LCAuLi4pCiAJcmV0dXJuIC0xOwogfQogCi0jdW5kZWYgZXJyb3IKLWludCBlcnJvcihj
b25zdCBjaGFyICplcnIsIC4uLikKK2ludCBnaXRfZXJyb3IoY29uc3QgY2hhciAqZXJyLCAuLi4p
CiB7CiAJdmFfbGlzdCBwYXJhbXM7CiAK

--_004_DB4PR02MB853530284728178B3731BA419265ADB4PR02MB8535eurp_--
