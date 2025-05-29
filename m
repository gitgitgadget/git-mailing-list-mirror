Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A022DFB1
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535684; cv=fail; b=sZD3ElCx6cNmX6fuVtTvIuZcbcVOdJk1PibfvqLtkSJeeJ25uTcFRpGjLbEGt5xwgbK/vU7SMA2/zvVhKOgeYXs2Bo1ZE3/bIGWnlRLH3JoMhmDq0eWwr9rhFtIQ41kICgYlqMnOAhNlgEODC4mfgho7+Rfs09Y6Otsvj/Iyp4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535684; c=relaxed/simple;
	bh=f7cFKhufJz8i/R9cf0z3QfIrtQrltzzIPKJwy6YEDN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMPeZ9m3iHGTosqKut8l1Et863tzdbE/qbdS6gngh72Bxk7oH0nFK53gtp3fWpM6t36Vv+CkkKzEzsG/JnV9XweC0HTBj0WwWiZkqrEziQLP3ToLY8f1/i+HDJ0Ge3Blm8zeoCjvWLd2v6GaV3lLBqeBlfKK3VleFOUEd5xOlG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GZpHwoZY; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GZpHwoZY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JshhmCGJv/MGn6e9LrMiGT8OsHjJpVduKBXLWnf+4D9vyeVe3gFHdMkD301DSkFZ764Pdijwt2bE2N9wUW/sYTRsnefcDDstG/HbWc375mTeEIiabH0ifCxRMNUeiRid44eB8tf8od/jhrZJ38RiIGNt20sLcWChIuaj66GJXnBCGkP3in1U8sPnZ0Ue82HBpDLrrmpEnH1A6QiGrpSxB83xEXNHegmJhJfHhIVIuBtwC93VxiJV4J+SlzT9dFLyWGNRPsZ2HvAqI/09PtZ1vVYxbOCADs9Tg5fiogkBLXlHbe3SllAd6fc348mlIwWSzqaXSiJogBs8Q4U0h/2fPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6rj3Zy+uc24IIniDIctHal+De7D7ZwA5DnYEQ51fK0Y=;
 b=AFO6T4BDgbimAn+E18lT3ZvHWegrMu83N0iAdDcTzABukdQrkWYHVQX91+RDs2LWTJw35nDxfyFLA0g5y2Cgxlfzy0HYIAHcRyfGFjU7ziKoemDVzB6nNFKl6VKFJDc2uE2yQQA1Cm02aoBA5YDDkttIds2fJ617EvbuMffvEPJRUhkcyptYpYnTu7fEcjK8OiILfIS8uECiFT4JCN9dtuipE682Tq0F9J/y1FvvjQdYROpiGXrjBmVKOIqvAef18d28sCTMDs0Ck2o6B7wG8Zt3b9hT6EsPMPaqO252jZADO8Nq2b8QSoRPGAmwSVH1E6m68mOx07JTBsxqARnJuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rj3Zy+uc24IIniDIctHal+De7D7ZwA5DnYEQ51fK0Y=;
 b=GZpHwoZYctwZE5VowtRXOgppcyG88yYi0pLgqwCEGg4yEVLU9IjHi9JlogfrWt4wBIe4rOWOiAwt3fDepgPswCJgCZ5TaD7JZvKIhyj/VqoKcLovXX3c+Dqd+lbCNkDpxvjL3uV7qkpE7g8OZFgol1suvhiHfl2L63XQl2zQtX6HdpgM50PAuGF2T7WjvTbVIQ+lcTViw/j8+LO/DRG1SUCphQEBl5fKJX6wcpYpgRGeZtgG0qwE8mb6s4fXaaQ13lqh0RpViGRq+rfOfLakQOqn+GsCFjTOL6aMw81B8TQizx+KYaqq/V9AZtpdImDWNfiUZWYlP+N2Br9Oybt68A==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:12 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 7/9] imap-send: display port alongwith host when git
 credential is invoked
Thread-Topic: [PATCH v8 7/9] imap-send: display port alongwith host when git
 credential is invoked
Thread-Index: AQHb0LWx+DfKHJIG8EOgLuK+rFxEHA==
Date: Thu, 29 May 2025 16:21:12 +0000
Message-ID: <20250529162020.45187-8-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 11e40913-a56d-4c98-e842-08dd9eccd444
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgni4KszE9nsgeho7zZNmvopsHta1uNPiUb4HZPge0kEFuv6mpSw48H6FRCRVQFGaqPmaMMUr/Wz/Plz6Kxm69m94vZut3HexGUlGkz3locEfiAdtdEZ75kGXavBadKrcCKDzLe/fXO7/Mjpdb1nQ8edCJkO/S8mPoiATaLB0MQ7PNaZbnCykPPV1OdbYIQX33BA5MhryQPaLD1AOKMKeHLQXuIPjY4YUMbzoLkQms+OhSIpU8vI+wDRv86U5g0AMwNfhbTt/irPualiDrwHPp6WVcAHVIl0XVGqtk4VxE4oI52Oc9Tuofc43M42xOJPQdDwNep7CwPeJnb8IqGugITOhOHz76ckvJlVwEeiJQtIlF0jGMJY9eI89HXpiUlokaLC44GSk0lkjViYQvTqMoyeop3SZ49kJuj0LJi3Z3brrHIMolW0BtEiwkcDddnrbGcyl368HXPze40PUOCwQlRnUwg6xD0HiLGvzlcLfXQxgM7cd4MvuhSb4K4LjvOThI/PnNnccBDF8VgbHLkrSawOp+islzSRGxfqBB3LznPoh7qG4Zh88rCQHYYEI8GRkDUsl86SZCYwHubgE1hGf9GjcCzLmM8XduZzjjTV8H1q6nmuQxhnDpxZd3yqoiOT9u3inklWjuaA6tRdN49+XSyRZwrTkhs9watwBa7Pn+s2agdZSQIm6LyiVDiSHrqFPcVTHlUMSB0GQyWzfKxVjFzPi1RIqLp0gz0Jxvg6MlL2yc=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?7j6QXrM0ZTyFc1vw2hRbLkVmrBqG1KV0Q/7TyNJ1opcBfs/BTFMq168/RX?=
 =?iso-8859-1?Q?AV0tBbKmVZUp17N/OdVKq2iodFgoqQIDaR1Al2vYk0N/w8KK0J5hclLYk2?=
 =?iso-8859-1?Q?5NDEZnNNK5gy6FrBpknWSRbpGHSSC9jprvPRsVDu9EHt/HMK/UcMs8WjnB?=
 =?iso-8859-1?Q?+0PMX+PWlSaDwnnvJCii2mf28qd6amyFdN5fCLSnoSwBwHi0dHg7KwKIJk?=
 =?iso-8859-1?Q?aMTe3U7/3MX6MNTqKhEIIRZJtZwoqLu86KBRYIfOtGfJOwnRgqfhzBuNup?=
 =?iso-8859-1?Q?YEv6rxINr4uXydThOBmZ6PGbJzjxP5iwZNzP1l1UZY1ZYZsFE6yOoLbD/n?=
 =?iso-8859-1?Q?KtKFcksF/yd8/r3CPy6Q7iLI/GC5GneK/a6tlnlreHkCuhhaxgGo/K0uX1?=
 =?iso-8859-1?Q?Ok7QmgVGphd68Tt/547GDYafFjSf2cXEdjoN6/nQ13tV0A64eLqI29oTer?=
 =?iso-8859-1?Q?/jcboNFP9Kyy9zZgudM33P9HsjGu8qM5IyIxGZtetY+aYpD+htU3BgV7V7?=
 =?iso-8859-1?Q?orHBNrCOV1u94ESanhABGA/OK2fV2ZM+15f1svyBgCyc6Rqsp2+K4wOLu5?=
 =?iso-8859-1?Q?5OLCBhIoPUtuSSGptOCxf23bWnD6MKn1UIzdED/6dAAL6mw98Bjd4OgJe0?=
 =?iso-8859-1?Q?AcRS+OLut47EQutm86Ws/lA1uHFjrSB/UWdJd3zT0fLALRUVdNqQpJgSTx?=
 =?iso-8859-1?Q?S/UrQx0EHsTCiuytn5wLJWKb1pluAqcaRpL9IDdb0WBXxID9H4TiDDW9XM?=
 =?iso-8859-1?Q?d8FU2pFXzA3N9VlqK5qkUf7Yaaj/VKFjqV+ASD/0M6EL02nq74ifHRS/Yr?=
 =?iso-8859-1?Q?cPkQIW2D2bvjmmvbzgDv4h3RhX1nzlRxG/02TtnQspSHJMmbEMtjiFwaz0?=
 =?iso-8859-1?Q?iD9ZDLy+l/ntzvqvH8Oz6YrZXeT8POCvTncqjXpGDPRDbX2jv/E8Y42DfK?=
 =?iso-8859-1?Q?6UWJj/cbPO90LIHxoy6rkFBX/W97VbB8dK2c2R5senXBebmTNtQiDwz+um?=
 =?iso-8859-1?Q?Aqjh8nWtsUGzsbe5A64aLyUnMgLuTqQsLp2kTazcMSmplas4fXBfb40HXq?=
 =?iso-8859-1?Q?XSTvC3KZZwe7sHnSPLG8br9u0XkTs8+X/3xCFmWonX+s0NdM+bLbvyE+4y?=
 =?iso-8859-1?Q?aPP2rvHC99scvNr7w2U4PUVSGYLCMLxCL3FFJ/u9WO8n8Zyio3hQGc+Y6n?=
 =?iso-8859-1?Q?2ZvCliU/YoX//XcKryvqEE4Bdic+peS0bYM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?C6mXOsTdj2X9zkwM+DBMJSoQK2tBY6XOJwf5g5g8eh0TOnZSpE4hOFxKAj?=
 =?iso-8859-1?Q?hAHu7k5pYUSecX9vc26SiTtNNygc4c8DNK1OhxgCthx9tjRKFOeV02kIY2?=
 =?iso-8859-1?Q?6M8YV4WtJPb9FUU0AuQwb901leu0jCXTxuWDpdiUNaeL237g/im0B0D83l?=
 =?iso-8859-1?Q?L0hsBJlVONU7y30iO54E5rL3s+biafgvLR1C3srYawVhETLUzErupBxXpq?=
 =?iso-8859-1?Q?ohInFRI6sOqIb6+qZFCp80bnwHK0v+fkMDb2ziwS3pjPqP2tc8GvVkx9fB?=
 =?iso-8859-1?Q?gsI3gpC1YQs0/pvwTepHBxbfOI9RZIpjnYjmOi/+cfAZMAICrfEd8s7U2X?=
 =?iso-8859-1?Q?h82kn1v+qO3K7up68LqWl5/54WGB0sEqGLbc93ny92rOtrkrU+Ihh6TLfH?=
 =?iso-8859-1?Q?OUFzopooAiTGXDMC/p3pfqa392LYL5YofNVqxw+axeILiSv0sQBsXJKEHk?=
 =?iso-8859-1?Q?uuE91WD2/+gkYTAb5/nM4B6r9Fb3tIo8AgGuVqdk82veE8ozvhb+V/HACf?=
 =?iso-8859-1?Q?C+/UlGfNjxPAVcIEO0/Tc/sX7ywhxxMK9D8zLEt5hpkrnrPt09pMhUGZP5?=
 =?iso-8859-1?Q?5odPtlOhel10F5Yvhn3vu+Wn/imnwTMboeBGhV05in+4ODnCgsxRAjEKCG?=
 =?iso-8859-1?Q?vgWW89dvoEhOiFgW4WAuea7e1C/lWIxpXkmODPlgGYMpKBTUiW59Xv4Siq?=
 =?iso-8859-1?Q?LSh9lKdHq2sFKc9oh485oa2xgad0796h7UBBeQrTi6d3arA2VSu3quFpDm?=
 =?iso-8859-1?Q?eBQG3PUuQzNCA55HoVb9ylPHUp+uCxwzePrw5i3YZAzq7UpgD1Xb4cgzHu?=
 =?iso-8859-1?Q?8l7Y8MzeVkvy770SRXPPINTKHxkLBoyRKqU9i0n3lhUQKir+sD4LnF8Bcx?=
 =?iso-8859-1?Q?oN0YvBMvfxofwrK3+/I8xT8um43Z4TFMh2PpctwnoYlz9G1NYNgf9eQbUH?=
 =?iso-8859-1?Q?qmDXy4eP3FdJ74/s0KiUkCXE5c9kC1OWTMUgzJUNy4i4BsFWM8gGaANNpN?=
 =?iso-8859-1?Q?VG64FYQYocNE9kdD7ira0qv5ebSHex42iNNbqqX5RO9dGA9h/O9AYEZ0Xa?=
 =?iso-8859-1?Q?ubySfiAyheHAORQsfyHPV3f9LjZpwLnmevdKl+J+zV0L7Jr+EF/7CEsH2z?=
 =?iso-8859-1?Q?dgz783e2u5oK0OO4Yu+r9LIH2LzTKmO9u5UEa+l0J7DXVQM3WcFxeh9zw8?=
 =?iso-8859-1?Q?EdMmhyb5kntfNjmKdFz6b2dgCpmim/L3G8TP6ZW0uMcVmyMRXIqNTSKb7E?=
 =?iso-8859-1?Q?QzhSSvL3RG2EyA7Bj69yyuz3c2V8uO84FK7EIY8Hs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 11e40913-a56d-4c98-e842-08dd9eccd444
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:12.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

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
index d99eed0659..c963ce62d8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1104,7 +1104,7 @@ static void server_fill_credential(struct imap_server=
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
2.49.0.638.g602e07a80b.dirty

