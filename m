Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9AC20E01A
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112960; cv=fail; b=lFagfFxW+0dfYireJKMwIQRO0YTnetQb6rGYvyQ0FIhJM3qNbTH9hsTeS8lBXRJGQiqD6v0R2zyP6jY1xFEYw/iGUh3hy+NJtd1iEnaO7sjDZ3TH0MHNYdMDvUGxw+RMm/As6Hbxncrvoea7bCRR9xVsdpYlsDnKl0rO895PPak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112960; c=relaxed/simple;
	bh=uY9KSjUVWDz/sNhQFT8Tz4kZjLHkMcTneOlF4Cu1pNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ISkG1vlWM/lwnaAybRae2D2G2DW8MYYCwoTy4yR+1WZwt69eki2UVQ2YspJyq5NxsZJSjK1frxOFWxSnnzBP1XuDiUOkbcXfCGXB1WXxkEChXo1YYmj1XyjQzfoIruoVgg2oyr+RnVs3faFP8bdnfgT89i1pgPpG9w2jAMQ79LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=L64aPTBg; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="L64aPTBg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSsnW9+kBup0xJ+r3is4Mx9+rvMcy/28UcCUiCJ7t7t/r6TzTtYkVr1k9H9u5FOEUQjP8xgSFnc9TM4qj4/yKPVdf4SgAKkoKIDs301qXsPMxNjODoSc8icra+NRR8rJKFnAzSBBbkxAA7pd/jPVt6SF3EmDFYNJ6QoKbVcum51b4YlSLSKLg3kt8nglZtFINr9V4I0+RLJOJ+nGEMignXfNaxVDQpuWUg0tGoE7DJFMVrU8IS24Zf3b20D+FUg6WmtF7tWTwSRbUH9esi9krQrlIlQHq9z1hT9aixTNl0Ts8uil6lXybkLtn1lmNJ73aLiEykC/+HOwP2AlEWZvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5e3jdVujY0kW00wAxPnkhleS7MbGyqZs4uOzP+4ENFQ=;
 b=LxExoFHCVoXq3iVwNdO85vNa9mgLs5/bIzKg2qyz7HS+5UEVg90gABF0JmS5K+vuOcOlA92wyEQunJVS8DIk8LGCFbuafsVOGW+J+9NIatNut/uxCIVvvBck69RnsELYMg5NmVPkWcOaD8g83SxlvTgh0nHqgGwNefHPOpz8ic1eVtqvmbB3xil4S+CHIVYhoT+L83fbUJXZA2DQ3jjHKjQuYFGeaANeqckDSNtqnJAP+5zmpmDl/3/RjTyzFbAGaSgxzV9mhSbSusUZ9r4Noq2/zp/577mnvm6RuiY3x70dl8JP8ldZSEGeUglYDTHpwRSHOahlX6MAaaz20dwvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5e3jdVujY0kW00wAxPnkhleS7MbGyqZs4uOzP+4ENFQ=;
 b=L64aPTBgB3TpRkrNSIfLCH3pMg/m4h1qZtXqu88e9/9pE0nqCkt/U4+8lOlTIbsoXItdLI9uV0zS4IUijLOuSxArbOEFCU/WbC8GBu2Dev93dPqmkpYub6A6aXPaXmZo93c6NyAYQ3RgmzKrME6gI1Z63obTNxWfovBYO4sIpMqrtztDSWNJ6okaLBvgFlKzveSXVnJftNlFV9Y8A8O34YuAX8GYI9XmzFJCf2x1AY1s7mzQ4rzxyyluAFmKmsdXjI27LdQ2Ugko2vbqveY61bGFj7RpEVTV00kWmKEP7MVeQawEwww5u2I8T5qHFHwTZs1FqxvlKoQfHR5+vW6+CQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 08/10] imap-send: display port alongwith host when git
 credential is invoked
Thread-Topic: [PATCH v13 08/10] imap-send: display port alongwith host when
 git credential is invoked
Thread-Index: AQHb1fXFg7nhc6imU02BF0AhAc/9Og==
Date: Thu, 5 Jun 2025 08:42:30 +0000
Message-ID:
 <3ba02f2b0c09fc8a652ee043820801f1f3f3a6de.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7773:EE_
x-ms-office365-filtering-correlation-id: a71545aa-efe3-413c-25cf-08dda40ce87f
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|15080799009|8062599006|19110799006|8060799009|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1xYEUhed0dXHH9sOkLQ+OQAcy05YMIwmd/mKNNftKO7joSPUb1TBVfNJHa?=
 =?iso-8859-1?Q?3RHKKxqmj0nX1pjosEi4IhzMR5LbCrK0kwgYRSiX9abgc2u77vJF29oRho?=
 =?iso-8859-1?Q?N0aG+NnTFdVa+VuhKjRW3pcGxQ6NjSV4akpSd6oaS2rBnW0oI/K+fpkXeX?=
 =?iso-8859-1?Q?45qOz0YmdWzf66ZdlHhmTRRGoX2KINyp13yCbx3/Rv5iWIbI/oyUDgKDuP?=
 =?iso-8859-1?Q?enJmzDbGJMJk0VzP03ZQn+XWZt7rSEAJ7+WEKfcwaZYfSZxlL7CFnnBxte?=
 =?iso-8859-1?Q?ubM3numGFiG6EyG1Nn0vZv8QXy2Q8FQN5VpNHfwrsO13n2QSPhx/FzZggV?=
 =?iso-8859-1?Q?x4xYC7UVrq23RnOrxrAvdP9JoHzxgH6LZyRrYge8HxWIiMa8LP0qMF2R6E?=
 =?iso-8859-1?Q?GFj9xQx9gMVSneS+g4YnZP7NDwp+WDZ2LymhPzmbctz4jV28Fqp24spzSH?=
 =?iso-8859-1?Q?yKASH4Xdbdex98cVfB+anFP4ilqllizz0RJg3Ej9daJzL9DSgdKSUZioKZ?=
 =?iso-8859-1?Q?W/clPvp0clQ33LW7aUQiA3iuJJObLpHiDQXDQD2wuevk9XjQjuTNCzc7Iz?=
 =?iso-8859-1?Q?ngdE9/JXR76UKVv1vY5HUfdZsWOEyjiMN7nGZMa/0QSvxbFrEAxkpHr0Aw?=
 =?iso-8859-1?Q?bKVcVm+h6azk83oIegW0Jc6MxJBsBVkotcNTYHBVIoV09rEMickMNZI2og?=
 =?iso-8859-1?Q?3BRTriRwTNOICtYTBrgn5YORXCqAHLnN/jnRysdb0L6xyOwJfxwAmQoRdK?=
 =?iso-8859-1?Q?cSZrYYe58DgQFL1fQs/hksJ+lggn5qAdSS98KyU1m+Jty3srYq+dSn6Xhp?=
 =?iso-8859-1?Q?nZNTE+HI/5hsfR13xwisZR2owMVkh05yRiaQrGnxkqN2Xv2jYg0rbCogPH?=
 =?iso-8859-1?Q?p7FMwVkssiAKE2G2NNDr61WHQQ+Ty5nHM9m9e+OJSxqrqIhnuMXMF1K/gS?=
 =?iso-8859-1?Q?JnA0m9wV8bC5wioVYW6lF9FKanANtRugGXkvTFUrw+16rvEmnkeBnDLvsi?=
 =?iso-8859-1?Q?CfmAlExw3QesejuwiI16AKXWPdaU8pU3CUFUzksa2gt+fxkZzdnK0A1WTB?=
 =?iso-8859-1?Q?fmBgIhGqg3xxBZCumHAXljGc/ieFGZ72UzAFzPn0yZHFsWFOA6mxzz5f64?=
 =?iso-8859-1?Q?6RGN2+dIYzA2P3jY5kCd4pQmerQydaTNpq666RsUZ7eIg6QYBhnE8CowAb?=
 =?iso-8859-1?Q?pipq7rHeZk5Afb+Ezxzkj4O4KXDlhcQUQUk=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xgkF+GqC3pym2cKa6BLDYb8UlsdyObW3wDKYOpiaIEdmOH7atv8WTJRb4u?=
 =?iso-8859-1?Q?oNPrxMqqc0OPl9HTM801KZOfJ8R0Az8/PNMQ36w3Dp6tq5gCRjKD2pZxvC?=
 =?iso-8859-1?Q?7nG3Z6hOFkLzBI3hsGVqFS4797l2IbYcJatGrIufh239QZoaXnwsL46Hdo?=
 =?iso-8859-1?Q?NjhXUxrHJgi7bofcv4bdASnptDs5R6RRdWj71zh4v8gdSSk3cBOLnhtTWE?=
 =?iso-8859-1?Q?nG+VkJePu5/gbff2WdQ7rZsB6hjb3UjaAI+FcUXF3GzhBIwlpc5N+V1LtO?=
 =?iso-8859-1?Q?XhhlNAutPupJ//r8hrowRECVcvGQky1sSjCHjfjxf1afkb/328GVM3r18F?=
 =?iso-8859-1?Q?+Mn5bBbjNOvWIigYY8oPefCjBjqxrrMcSec4YXbys3KSr4o+46nDPzZEGP?=
 =?iso-8859-1?Q?Lk7w6cuKTOzikRo5+sMT//Yeiq9l4KZ2LKPZEMUjYwr26CbScWuSN7aI5d?=
 =?iso-8859-1?Q?UamsTc8mBbTjbnR7Ic+GiqIp2gwMPhrj8gsonFqXQ8Th9Pc5ALRY8XsAJg?=
 =?iso-8859-1?Q?0RE2AxJpGf8WIEHFrwKHPzAlDZwCJzjeVUzNLNxocss+x0PMu8CIvyzolB?=
 =?iso-8859-1?Q?KwW6JKN7JIScr2KKwkz86Ug8mICZb65yhJUU1Sbd7+m1tUeamY59ahA+Du?=
 =?iso-8859-1?Q?cRJTKzryUeEhjerscvV4JdiQu6ZcLENfMABuwnFj1PS7ttoJE26qBVlNhj?=
 =?iso-8859-1?Q?/McV54tE1wINYFnEZJEJjfbWKDJKULsQt90RjNTg6veVjZfO/FdHqvhrmY?=
 =?iso-8859-1?Q?sb7rkZggJ1Jv0RiyxOaVI8CYl7wc5ef5daJME6ibKfKK16/vUze6o4l7DZ?=
 =?iso-8859-1?Q?saOhg1a3G0M5WkOJl+LCqZ6hQGIFCRNHtvu4EwmqpGS2+t7NTSl5Oh3g6b?=
 =?iso-8859-1?Q?pSHy0ZElPJmnRayumZMH7ckHkFdKdpZmcXebq/kL7epAnMtusCy7a9pF5u?=
 =?iso-8859-1?Q?R4hhobTjlEie1vBKZflmiaEUyczUd6KsXxA+P3AQNS5Vn9F5y6YKl1q6ZN?=
 =?iso-8859-1?Q?5If421+gewDx6L6+I3+JSkgnuEb8K1cvZdsQQQflTZ4eLkdvcHDrfJp0QL?=
 =?iso-8859-1?Q?DQiQ8ZDzfXTF+CEDll6EUdkFqpvQCa3cwdeTZg6rF2P6D3MReFdgrOo9NC?=
 =?iso-8859-1?Q?n1yAogIIb5JNLhcAzZKLbmIY26O5LEzTTv91Ea53Al4YQl0wMe066SwiJK?=
 =?iso-8859-1?Q?BTnXMxMSqQP0QqI5QHyL8R7Otwne+3g7rrUkmyE/l7KEbNQ4ibfjBvyK2M?=
 =?iso-8859-1?Q?ex5ZHcUKiF0Dk9m5rgRK+Vk2MHxmujuTlZ1AWKjWw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a71545aa-efe3-413c-25cf-08dda40ce87f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:30.2473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7773

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
index dcc12e5468..edc6b1ec25 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1083,7 +1083,7 @@ static void server_fill_credential(struct imap_server=
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
2.49.0.639.gf77f2423e1

