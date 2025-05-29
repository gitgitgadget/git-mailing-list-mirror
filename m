Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5255422F173
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535686; cv=fail; b=OoN4r20q2KRoJekFdQXt8wxoHJn2m55ZhcEpOjtLXxUFUL5rEJWO5yJPX77r5GinqfziBzaxvCkxS0TfeFE7wHaCvTOunnSIS9BdFb5w355tpQ9L1tcM8WVSNw6udzRKnHvHuj50Q0F5zMzNV50d6QPtIxXguZ5QPNSdA1o6oDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535686; c=relaxed/simple;
	bh=0EkU5Z1rwh8M6vvcOWDegvxFSUyU6N5SvYN132trdXk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJmVL/jVAM5NcY4m4UznTkfwgU7Gab+fMS0rcCyfZQHg5BzbkpfmVZ/zMflaZL/QZuJkRTEJScmhfTaDqrfr+dHYX/KULH8HGkZlOZzeuLNWPc/I3eXDHZ/U3ynA4Du4+6FJxMQwTLJwaym20McP3L10gTjXH0HBgiW+dct2GwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QjIUyey1; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QjIUyey1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xThBrmr8n6nW2COVS7ONnac/48VmGLrwO/vV2D00c2Y5BjSdz90nNuxv4VCXcxoidqmn2d1h0gIowsNhw1W6r1wIPCcMqjK0Ul8KMikytXJM6vSA1YcewHVyRmPOxerv/ST+KLqAhwViFY8iE+FFvWI6WYltHenFr0KRLjlj7VWuGDqZAgyGnC3EEsWSNH4+iC9eFRRABzLYLaWlPmarDCDN29bhTrWWHXS6r3+Z7wM52609aeFc1KqSUUtESeZLYgpg9zhu/q75f2urqYGCoAJiCkbxzDfXAPh03MVZkOYArj9p5w+XSiLmlOsok3hGdkmXtmWjNoah+dfz/cAHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnlb/L0FJY7q0XvbnT4a87KnEK2geCHBqPyzlfeX33o=;
 b=kzc1K85o/w+ew2/eJu9+sUf86e9EPI1Ff3xFYcO1VzOy5Oi3KFWnjtxozsItkAaZmXTLGIfX/QMc40wtugmlBK6K9wzEGohV9u+5OTTL/dEoVNvbNC3JLNdKJFJmzFNBTLrEEVmd1ZY7pXuo/Qw2l4YKwvnoByUJ4wcIjubGT78iqRNZVRPczybMnrkBDiH5lFw8B22ohTwjEIZdSCs4/qlQ1+DemmGKEzZveQ/uUVs72K0cg2GhvonSvBaAxiOZTnJ4ntxEmKqI/tPPPco2LXXHQG53qspgPXvpuk5WsCEnAihNImn1+uBYCK5msNMLakPF+yVhkbfeFsd3cfWINg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnlb/L0FJY7q0XvbnT4a87KnEK2geCHBqPyzlfeX33o=;
 b=QjIUyey1KCVjhmtR2r7R1LFUzmLuQ4CwQfBnEPK/h090pXy/YwPYhXBaW9inwzQbNxG8531V05lWgBhAakiwLQqB80SKc32RTNpuNyo+gGGS0NWOPlOcSoZki0rG8LPkUFoon9Z/fi3mZNEpIPyoYUh+m+39C+VLIhlCX+uZkdGcvBD0J9YJsLwSXtfFzUlFRVy3u8JI7sNPSoOxLK7VifWO0fyrWCiDN6/LGF0YuB47GC7IzSiVTKu/FGaRzzenXCAvghM+KB7SuyWWcOTgTl4DwMLRxI4VxD4RWjw1vfd2oSfMsm36RtuJRSRptUn1GvybGsJRwmPOyt0UMhRtPw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:14 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 8/9] imap-send: display the destination mailbox when
 sending a message
Thread-Topic: [PATCH v8 8/9] imap-send: display the destination mailbox when
 sending a message
Thread-Index: AQHb0LWyjMnuInwsik+JQDBrppBTTg==
Date: Thu, 29 May 2025 16:21:14 +0000
Message-ID: <20250529162020.45187-9-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250529162020.45187-1-gargaditya08@live.com>
In-Reply-To: <20250529162020.45187-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|MA0PR01MB7067:EE_
x-ms-office365-filtering-correlation-id: 137265be-4011-4431-481e-08dd9eccd53f
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnF5oAkD/pH/rmlyDdSJoN75CxnTFQYjEO0oyXpuggIWXYDxQQ5Mkr5BQ23f0K8s2l0AI5aSaHpVXl2lSvJ5GumLIsGwX36pFaHZ9Mi9Nc4S0vrGp5hKH8ImBbxpxLOkYtzRv+afRZW1+i5ySZwQGCPsRa9fEeOvPPkH+MpIda4JWoTvGfJWGb2UHcctyEdwAyoyNfB8ttca8/DSaO5UIN3u7FWe4XGCTTz/rXLCjO9lxdY1FEyFNjYk8Hl10WUVcwuJ3hm8/rmJ7HvOlQCaeneDtiHrJ3fDTHDEhPNoyf7+sXVsjuTmongkxUtrdwo0VMvIQE+9/A5Gtbw35tmYIW7cW0AdgDOMiHFe7H1B6D2D+WuYeHhvAFuUnKM9ACArhbXZFIgyYmsJ7NXow1NkxgX57uFx6Nd35ifprNkK+CJqWs4ID2wANVCfWJTQ95Z9G90sFOUdeVHGdsGAcH9TULAIPh7aEc+CU8OJ33VYcjoScHkgO8u0F+/dlm+UnY8+5iEVnkdOJLdQf16PpUF+KAl6W3ZZJp1BMAFPro08AdH7ouH9/pFRMc5NqqGMNBdyVzM/3VvkusZoTeiVQcGjOnDrkmQHkWEjkOeSIMYAFvqsoFwVy0776XCt6+/YpF85H4NnbbTtRCItfTMqCGaAVNg6653Uu+6IztKmH5IHua9fHykVQo0Rlj70Z9ugQvlsTc66XhhP6qOy70V39N73D9KTueIr7wkph2cAe1KG9YciM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|56899033|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?wCnj5WByKHfHJoZCfwrqA/22eOGUKyb+ggWc61XP9vzzq67V5GsceqDfPV?=
 =?iso-8859-1?Q?amQY5r8agZoaVCySf0fJbzVUn27eYyO50IIZqdPMpXibDboZN2tpIMdUOW?=
 =?iso-8859-1?Q?jSFuPo355ZX+r1QWg51cTih3Pxa+T3sJw4geFlVD2MSFhfgxdR+hq3QJdF?=
 =?iso-8859-1?Q?Zvjuc4XkbiVxYUAAB7dbmxlYAGTWDB+MaEJymc0S60cDuPpBLkEA16uZxQ?=
 =?iso-8859-1?Q?v8kgYGK3emHXB0YkasYuPh1pRMfxfUcOrUpygjcLRFfmR8hfzPn4zuQ36I?=
 =?iso-8859-1?Q?CfsxLnhIvaywJWhB6Fp48n54+ID4+mlDwc18LgAUeM+IaYLeAyDjcN5wj7?=
 =?iso-8859-1?Q?RvS7E3FOw1Ml3u4iV1Bmjokoydk56IwhQRyYNm+NZIw4u8/B/Y0iI+z3IF?=
 =?iso-8859-1?Q?oyjR50lj5iwY6dVsSGUDv42EKWOBwPP+XCXIeZXkIfvyBNrPEyVn1uqaXV?=
 =?iso-8859-1?Q?MPPqB4ommpciE7v/2VEoHUFNyJ3+05Adnod7JOS/E9XRdGT1xsU+pR65DH?=
 =?iso-8859-1?Q?JgO9oD3uTwn1T3JV/ivx0j//Mw6Ui9OyBRXr2YKxpBPpQIVsFs23MWSbrP?=
 =?iso-8859-1?Q?sZFEnwu0TTyrIIIEPBS5cxNyVOal5N2flUxTfhDwyw28pp3pQYjptfvTR6?=
 =?iso-8859-1?Q?I0f2zjXDFcxGS0FLeJMiZ5RkXPzur92+0OWSkeG+JzcQVBL8VPhzSepCO2?=
 =?iso-8859-1?Q?/QpMNCvpG31Nm+TQORlxJdJduX8is/ROGf5UQ0ADoB1+1icfTjC4DTaVpZ?=
 =?iso-8859-1?Q?QEEmO1bvmeDXGNlpON+AwfeEupq2Ss1Ie7gZ84DK6GqaXgU5JuNZaXF/bj?=
 =?iso-8859-1?Q?cJRM+NW1HpNodeq8BJgRpumRtfss4yeM6mYm+eh0pwLttHMDRh7hid0Xx0?=
 =?iso-8859-1?Q?jPG/nSOsVfJGcOIYqH8uFy0Adgx3E1IIeJlY+6lbL/8jfG/e2GPY8p0oTa?=
 =?iso-8859-1?Q?piKghHvwscMTiL0A55sBYmnCEDABMbmH/YBZCWEsdjMEDZ6dtTkTHAfSc2?=
 =?iso-8859-1?Q?C5pIWSPMFRKpyaaKxiD+kS+MM530v9AHf3EGR20N2bS6FO4rVTKa0M1N3L?=
 =?iso-8859-1?Q?Ml9VpKGMJbPxPuGVgdA3fPYxOwVDDQ5j1sustPXVptxrA2pZnuaNDDPQrt?=
 =?iso-8859-1?Q?Fihlim57Q3ldOVL+V4qZJAk9+dTESyaJlWj2OIKJcIXsoeB2I/ha9k5W++?=
 =?iso-8859-1?Q?NC+Ow6UxiHAGgQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?x3uWI7vJwWYQfUmJ2rABOtz6Bor0yFkCW+FA2jtGUmZwUX0rgyFhbC3YtK?=
 =?iso-8859-1?Q?e1GVpcBIAY/WEJIpvWeXqpCZyWtKRVEVrjqFKRWJ0KEIeDxJ6BB775nlbd?=
 =?iso-8859-1?Q?BPc1Nhxh/HC6LFvMYgUZIziM+MzOrjAClZQW5x8ThyyLzC25iNyj3zeKn1?=
 =?iso-8859-1?Q?uFz3hkVduCQKqqtOJjnfxr/OvP60OAeODb7yh71+NL+8x2zCprW/uEtxpI?=
 =?iso-8859-1?Q?HYupKLBMACrApLWybbo0NnEmVz+RXL9I/VLHluJHRxxzNvMn7e20AytXEM?=
 =?iso-8859-1?Q?0ltZ2eb+ZiDk0U52EzsUfqq/ZH+wc569FuZIIbd87AhXLCc1dzA9yfxtH0?=
 =?iso-8859-1?Q?f8pHw1EFaI1SmH9Kwedqy93xr9fTUn5tnDCM1+u7kWY5pQFaOsiZZl9xiA?=
 =?iso-8859-1?Q?ZIt7+VZBzSv91d/v+G/4KZTbTIa9HsK72ai6JsuCrWnh0+Sy9ze6K2J0Ag?=
 =?iso-8859-1?Q?z30twlCFxFm59gFji98J1/OzzIBa9IMuNwppFs2QDGM4whtWXxTJL+mJlL?=
 =?iso-8859-1?Q?bNnAzGnChhG2QfCTDQGHYtEvoQIHBvHxUJDMX/qANQ9Q9hjVG1AmL+pu6E?=
 =?iso-8859-1?Q?YLpev4ZuxdIMdekVThaMPxlI5zIyACbC19xzYPXhkQ76+gePFbn2MSDpGu?=
 =?iso-8859-1?Q?vKQlVL9BYsSQ5yN9o5NxbjCnQh43pWkOn97U9yNA7f9W90QceWIcRWwGQk?=
 =?iso-8859-1?Q?14ulsLMWZ54i1zj3uFlWes/Hfa/vJY2xwyXkIGoZJTktg75gYmMO9xfBx1?=
 =?iso-8859-1?Q?ZFrE6qlIHsHSgsLR+K9aF+ImpU5rUKo82MJb5vpHQcRqKnzAjFRrV37Kll?=
 =?iso-8859-1?Q?uU/tLqUUwZW8Dd6CywJY8peEaXpsLwyjZJ9JpaTTDAmdeUfEvi3Y3mrJjk?=
 =?iso-8859-1?Q?F/w4fAKsHxdWbqDPc//ti+jzQwwOeuSMfNdsTX8fa/vpgvBCMgudQJHPLK?=
 =?iso-8859-1?Q?EjhI/q/aN8YnOCZ/wvJBJs4dMfZLFNd3pq0SXFsQaC8D8pMFLqxevQ0yiI?=
 =?iso-8859-1?Q?wwwn6kTpV2L40DnywVj36EaoW0dKUJtiN2CuE1wR/kbx+yV7o5IZOkm3TG?=
 =?iso-8859-1?Q?OxZI8TkBjRMiumtnzZWhUeM9d6ZNpj2yDPcza3DHMNtjAYzqhXQnNd2Obk?=
 =?iso-8859-1?Q?UpzOQFKVK2NHXZPZxUT73+knOBr0vGbxrLAyya4UCE8qTg++MOJmybYufh?=
 =?iso-8859-1?Q?0rQUYXSE9O40LzW9xRn29kLPVXbJX/W7Xti6M5+IiRuNd6Xuvw6xFdEndr?=
 =?iso-8859-1?Q?7dBUpZsH3Tt4noMRTlxoYU+4Q+K+J+SwNym4dgA4A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 137265be-4011-4431-481e-08dd9eccd53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:14.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    Sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index c963ce62d8..95b78fda42 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1596,7 +1596,8 @@ static int append_msgs_to_imap(struct imap_server_con=
f *server,
 	}
 	ctx->name =3D server->folder;
=20
-	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total !=3D 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent =3D n * 100 / total;
=20
@@ -1704,7 +1705,8 @@ static int curl_append_msgs_to_imap(struct imap_serve=
r_conf *server,
 	curl =3D setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
-	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total !=3D 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent =3D n * 100 / total;
 		int prev_len;
--=20
2.49.0.638.g602e07a80b.dirty

