Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEA525D559
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199310; cv=fail; b=gttZjvq/EN4r1p50KtMWDki604n/LoY7CqpR1K078f6a4o2xc9DXHV7pHL/48L1buXS0ysmwJ5boV6RF/bSXrIYGiJ0omqp8qocvFnveiYtMPo4rMZ0uPM7rEyf4FA5DSW2t8ShByeGL4/vE/XJQepTmaPcYTjbCR5O0/VQFHhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199310; c=relaxed/simple;
	bh=eFyzfSXtWH2vMRTKrIz+7JEekGwiqL5SPA+tqCd3HHU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R3lzdDPpQ/sbJVTj5GYWMv7KfWOj6pHGBFoscPBqi7fJprWG5QLb+W7Tfx85Aj+ljve9s4KNmpS1kXL0stlqV0sMjwnH0jz1zynwmZPnf8K5HZFk84AWa9EDZaB/Ag/b5VpWa1so4Dk/tqsfnbY2/VLdYbmL6GqsXWx7AZYVDT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QazowdpV; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QazowdpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T8R/9WpLgoPCftc8uU/hxTjOzJsFnhMjVMIXL7xN6v2ldvLJAw/6GNsyooCJ2ye2cchqJwhGlElRLTSqp4uiJ0yOtO1BP5b0eG6aCp0xfCoYIBmMVuwm+Vb1YOcsYMvVranuZsI9aYa9c5IcSQDXfp9rfbSWXT3vVnEfLpdS9tukPLPzek9CQyL1ik2pj20kV3Xnx46vSiHE4/WS+ChQoVoQvW1NYcL+AahMnAL4645GozknGXhCjIwVIERgJbQ49OLiAj9l+OP9l7L5W7NyNxH7QY8vIqkT9m8vp8EMOHtM1r+y8+bsV3nFqwmNVD//noN1L/AdAw/hge5JeVP8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4sPZCvgV0VqEM23mDa0zUagBkyJQk/LLrhu+cO1SXKM=;
 b=Bh67snMAeq/DWybs9g1Dqr0bVR0HVeOFKRBVAqiGf8fmRyaGwK5EbW59eFDxxnt8VVtRy1fq82ECbn65cJ534F3OqMyryOwscUTlPakr8yoqn24HS/r4zLwToDulnULkRApzjy8zLvZW+6/2ATjOuAzpP4ORATe3bjG7/r0j4RnzH9Mu9LZnXdnc6aItuYphVpmbeuRh6ve6mIm9AskkwNU9kszVwC6fGvBVAlIdMMPa/NSz9XvXoyEoVpxTDQKlRYpKgO3ro6zCJVDrHomwOAJnd016gp5L4hIzke6ADkFiqPr+dffZyYJ88Hwo/5Sw4DTLCNPuRiAa/kX8/j/TxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4sPZCvgV0VqEM23mDa0zUagBkyJQk/LLrhu+cO1SXKM=;
 b=QazowdpVQ4zxW8ojWVz3Wh+aFAyCCxJvYHyyNSmjJMpYgSKQEw/B1WbIl7iy0HHcu91j+M/kQhHysGhLs6vpeCDkmRCtowifCKWVMBIJBZFsAPduprBLVPlMcITpQcteM+WWw9QT91izrAFZsBk04YXL2nZxtz0I5yx+TjKVaBhaxOFKpEaTLxOWzKT3ehVleoyLHKnl9q83JbP7e65RKpPEdLnaF/F+D9dd8BwyqZcFSz2FRb9Qsbi2cM6Jagb9bqDZ2HCUn1anQTCmCbcls5SSdBW2ov8RLzBUb74RxNICqMlftUXRrMjgVO4YJ5mCjb2Uh94ZaJLsf+68FgIhMg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:55:01 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:55:01 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 4/6] imap-send: fix memory leak in case auth_cram_md5 fails
Thread-Topic: [PATCH v5 4/6] imap-send: fix memory leak in case auth_cram_md5
 fails
Thread-Index: AQHbzaaErMaIOfsolE2jnjLEErtjfw==
Date: Sun, 25 May 2025 18:55:00 +0000
Message-ID: <20250525185447.29982-5-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: fe5ab524-0437-4922-ce46-08dd9bbda708
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|41001999006|12091999003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NT+yfXMCeRuyR28Kv88y+J1o5wptEKK2DEHXdE/Fhb4QkagZmquWLKCtW/?=
 =?iso-8859-1?Q?nzYDLMCE8ToJqEdSYRlsePtkEpqM2sNLGgLJIwKQtRW3+YVOU9cIlqfLJS?=
 =?iso-8859-1?Q?+4MnymVQ90e08sJ19/K9jMixRhM+mGDNC6fC7iYy37qplmCrZLuaZXYqal?=
 =?iso-8859-1?Q?/9GI5NCpqPi3oGpcrdQftUzBQJ2wqijTm3q3EmbYKwVPEZJT40sqiljd19?=
 =?iso-8859-1?Q?VcS1cGq3VLTN+6vLzmbco0WItmPa2AbVFSFaUbEA8XfZZki+toIcBIn/4Q?=
 =?iso-8859-1?Q?Z5t4TSdMuUQrrItnyGrDbYsqseYqRyOrjxdLE3NNBH0+UUm9Po1h/mXBot?=
 =?iso-8859-1?Q?zL8rjkNFZ0Szf6eyjCLvET+aLHVxa4cAJ7dt7+uEWnMaKvbOFpkYgrDVli?=
 =?iso-8859-1?Q?7ofUYoaaHjEGOG8LBEEfmab4BPse76Xyf8glDLM7G7bNehpXDxsiToq/sD?=
 =?iso-8859-1?Q?ksAqRbXPiB4ftE+Rw6Gy81X1cJkIZtvuRG+fKFc85UA+HWmEyQuYiyCukM?=
 =?iso-8859-1?Q?5dbloDArlDWICX1dLi6U1ds4YkvGnA2rIpug3zQFj018jpo7NhcLZYs2Sj?=
 =?iso-8859-1?Q?3DQHTWzGpGCI1L5sDcJ7qCeiF2zOV0PVApl+azBg9tPva6nMdSe3jd74Ie?=
 =?iso-8859-1?Q?oaFYPiEeNrSGzW3Qc+KGrm5APBowRviX9eZ4PiD4cNKi+SGUWsKszegYzn?=
 =?iso-8859-1?Q?n4gZWgr04crCgfp3BBX6TrqOG/kksDpDgJAoJ0g+XZx7312GXoLAN63Xeq?=
 =?iso-8859-1?Q?7cgPp1gn4xeA8wz4Zad9ROGGgvGZkGu9m41kmdjZpYaiv3LppCVLzj9Dgz?=
 =?iso-8859-1?Q?IkWDh5DZ3KxYVM2iIsgIWRmmTXvIO3GUElu2YuZO0LyDi+yukfPcIL3rsp?=
 =?iso-8859-1?Q?tkDHNUPVi6kpxmcqF8DWGViTkFNnamEK3tcJNfsAwGkAUDQ5puDwmNU7D0?=
 =?iso-8859-1?Q?e2n6KxCD+aDl5nQ4uE7Wvm2tPz88iJpI1IQ3DZ/xbAiRVZ0pWb7yVkQDdu?=
 =?iso-8859-1?Q?nQhvexEDL89ynSoDwKNZL6BXqnHtRJjZs+n0B0tqPe3/JDOD6GmZc1zHED?=
 =?iso-8859-1?Q?LKlgjpvuZVdCeUmDG376ExTeh2Exs5V5VHnGSlTjoTckg/VCuwXQQ9M7kG?=
 =?iso-8859-1?Q?ERLErfzeiGJgsb7m68yqsSJkNV/syHNr68iTn9CV5LcjSXbSe5u0Oj0Wsk?=
 =?iso-8859-1?Q?W+d5zqqMS0Q9jvAmjJQAlDtGvPt3plJ2oTK3ZB5mMapMNRW/7PcYpmSBOv?=
 =?iso-8859-1?Q?hJPE7CoXM2k+hOcyLFnQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0tpCkMyZstGEI7fN4WQZV5VObAk5VWiWhl1hEpA7hyEQFAiZLvMicYTUzd?=
 =?iso-8859-1?Q?Pv8ZnrJ63lx4yF2g8qFO4SjimGx/qwOCXSAr3Iua31x2q33Hf8dW9RSltj?=
 =?iso-8859-1?Q?PpJLbcceKE/33w+R2uUroV28A3qxuLNelasDzmgCiHM8AyyR5xaVbe2M5A?=
 =?iso-8859-1?Q?W7wBu56yfdeFmsUVtoIceN9c+EEWd7+7p2Vsh4aU/o55Y8Pw017Jm9EQfI?=
 =?iso-8859-1?Q?QKjvm2obk5Wa1qV01fPc05fVtLNvwE0ecQZRtrKx6JOykRk1ViYfoZ/oJc?=
 =?iso-8859-1?Q?kL8YuPhlQ0q9F44x30EfLo7BCIRcAzigqmDVVYEKU9Dc5M2SNbKH/9g7jK?=
 =?iso-8859-1?Q?GgnUWgZvnZz48aHNSkli8gztlDf63qMPLKzTyeuN4BnoLAyVU0IwNNdGvw?=
 =?iso-8859-1?Q?mYAp9yZRnOEYmcbcnmYg6oHB3SGLqZ5iY2M8o6oSITuvyFOFCBWWn/5GtL?=
 =?iso-8859-1?Q?ssfZrW+lbM0s98/M0ZdqnoRZ3BukftO53d4gyCCcQbFTTKKnEVvc4twbve?=
 =?iso-8859-1?Q?iDAYrtPbcIr7znDVIA8pXl88evmV2TVnoirVgcJC6QbgimhR1b1Ql8LTnu?=
 =?iso-8859-1?Q?bgDUGh0HcIzFwxKGfwsfB36/NX0QiONh74R2dkD3/rQE4SFUZzZriTktPW?=
 =?iso-8859-1?Q?SBlTm032GLdx5GlRA/MEXUDI+rHYuuyUcmXsrFqMCCEEPF9alTJJT87Cxv?=
 =?iso-8859-1?Q?tVIQCAcxFfzIDpR0XNOgxuqPf2NAV/oNxK1u4swQd4PKrUj7bHL/isxJe0?=
 =?iso-8859-1?Q?eciJSMaoWM/NNm7HoAsr04g3gLgjG8hLy7ycf4PD7mlnKbUVl7puRlcjVQ?=
 =?iso-8859-1?Q?+BGeQxNiGVN+yuPSvYuyLRneTifPIOxY5LROFkTYnkflgLf7yDGFtM3VOV?=
 =?iso-8859-1?Q?4LT4ea16pfsf6o4OmzSAZzDCbQayFnAX8xUSfdiLoQDZXGGQdUjdsKD+PF?=
 =?iso-8859-1?Q?XxmlWUcums988t5D0HaFFN37Ycxlao4mNAQNvBgxSRfzOmnJyhNcTZgVG3?=
 =?iso-8859-1?Q?vb4mAKMKwFm5NL+N7UJw1fh6ZKg6fdKb1unDydBLImahHXUB3PsO1crJ/y?=
 =?iso-8859-1?Q?NXaVJwblwbRv57/jQSJMXbceGqMfrX9MhK/RmcA0CzLw1Jm4VBLNoG5Gl3?=
 =?iso-8859-1?Q?jUgtnwGGbI9+fuwbXee0bezDlPDv32hdXKnoj8wVLj4UcDbA63ZIXyAqu4?=
 =?iso-8859-1?Q?KPoiMMOlgj2695FIz8kd/Tr7GT3NIfuDTuN8d1FvnlYyWBp0iSkPQlrnjO?=
 =?iso-8859-1?Q?h/aZsCSXaP3YLL49SV52eVKxfHCtIg/OMb4INkbV4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe5ab524-0437-4922-ce46-08dd9bbda708
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:55:00.9708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index ad54aceb28..87abfd15f3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1046,8 +1046,10 @@ static int auth_cram_md5(struct imap_store *ctx, con=
st char *prompt)
 	response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
=20
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret !=3D strlen(response))
+	if (ret !=3D strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
=20
 	free(response);
=20
--=20
2.43.0


