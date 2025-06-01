Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697FD1A5BBC
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767146; cv=fail; b=dQVT/x0kNkXIXN8JPFEI3cMxMLQMObgjPqs4YGbtHiQXNhr+ErTq5XPIcsQntaJHhV9zxjgZJlveqqc+77haYowvY1QdODAKY9/aOsapytdsyR0xKC1zFuNvo7CnqovH2JojQsgVWctXQrvRgi+g/dHbol7AGJo/mCS8Tbqrm70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767146; c=relaxed/simple;
	bh=I08v9CKp9/kfs6WfvzSZydk+l5Xf0zi0o9SHdX3d4aw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hLcvrADzjvsC4ZDonsAhkS0EMa+fk79k/sZmljLlgTJ0m15a4OTSloILPfPgOhB1MrjgzBjoTf0mL6Py3fpILq5YWzWhjYE7DTf69e0qF+mTMBzNYW42rEidjeD9FoQCabq2scNABa8GoJIbbnTfQbBoo2xPim73N5NXZgNVy9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=MoRltYln; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="MoRltYln"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UKtufSxostpzmRQ6/mTZ3BmmLM3ezUHD8cliIgbYGtDnEeuEst2eW9ENQa47iafau5BzE6ixOscYVwEVL5oJzgc4bptgd9MmabD3VVY6dA21cTubVlAVuU3LQn6C/xGuZdwDq6M2Xkxe9CVih1EtWtxVRZBIld11hGN+5ZV56pL/eTjAvViCGAxIa+0GIroHjCBw+JXHsFrPlTuo+qWpwFrYO5biHbMBGN7xsayCubMmJv21/0/Tb7wxE1SGjYSx0IupdTUvt/k4HQaZatzgRSRDoRyN87Wlmf2Gr6y1JM1d9m0+p7scYXdShqfVjJcuSWP6TZr6kTvD2MaTTcHfag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YX2UvlZesg4ts8ncNAxALMXwAvAxBkf+Tnthwl9cKwk=;
 b=nOIWdj2/9GM/8L+x2anjn21dI6ddT7lN2TuyGyizQZynzSmhQM0rLA1pjZf6RKrhvagSkTiTSDhddwztmml5DnYCoDnvkHNDEC9LdUQl7bUZEEBdFM1cIAXm3+WO5y1lexVTFoB11SAk6/fJ4txie5zYbHrl0VJeL9Lc++/hl1UQPw+Eo2gRTp3hEQUXz7MYFhYWeiYTLLPmJ1kXkNDBOdkejIht4gzgPdX9BL8XQhWgcudL1gxNqOLhaEKVWAX5nluRBX+c2UZJQh8V6bpE3f5YMLloTjkHRkHJQlwl6VYGk52aVQdntjprMdv4NNfg5yb7L9J6PrT+9Rbfek0DTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YX2UvlZesg4ts8ncNAxALMXwAvAxBkf+Tnthwl9cKwk=;
 b=MoRltYlnRX0OacqhNTtccmbm2nHHFOLEg68p3DsERtLTyiY3MLkN3NMKwkaFAf7Yt0ue/ldKZRkvZCcu1F7Q7WZ8jvX35ksLDqV/nJTzVfkTeQEzKt8F7J5BhI6dlRu+4jr8XnrC1qLK2orKsTmZw+wBVGwEkKEtZg1/Zufw8VmMWZMTmU9mUUwZmcBAEalAnlUpnr/aAGZyxOxinYzzZ+A5wNtX6FLbLhOpA3J75aRXAi9INqTrVKs1laKIyPbFbCwAeUB5Ez8M34myA1TWLjNWWXPVqGAs4pL4ywlxO/7+eMr5kK9VgiJYnNuQCnyQ5Ur4Vbo0YH+zSxlrPkAMgg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 4/9] imap-send: fix memory leak in case auth_cram_md5
 fails
Thread-Topic: [PATCH v11 4/9] imap-send: fix memory leak in case auth_cram_md5
 fails
Thread-Index: AQHb0tCb+B/ICV0rEkyPP2SHa0is/w==
Date: Sun, 1 Jun 2025 08:38:53 +0000
Message-ID: <20250601083821.2440110-5-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6304:EE_
x-ms-office365-filtering-correlation-id: a5c4b97e-b1d6-414e-ea74-08dda0e7be16
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|8062599006|8060799009|15080799009|19110799006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?32KbCvDfhM1YT6Ej+QzYcVDK++lGjZjkd6ynOtjt7Z+VE4zAlH6bxavdlA?=
 =?iso-8859-1?Q?qmxJCE6QsWayjwJYVOLy935pTEeicatoAtPNPlKyhhojNea7uIJhtlBExZ?=
 =?iso-8859-1?Q?GTm7dM5YELrpR0sxPbKkXkmTVy8AVFfHYKvrUwlp8XH4BXaoXeR+T2zgA1?=
 =?iso-8859-1?Q?Loj8DIKGqX+UGQSDGMIouw221XCO/a5c/7fdqyhfUhftbpFcZtkjwcLekq?=
 =?iso-8859-1?Q?HQtFffyvAWs8FFBt/jSs5e/+M0oKVjYh5qsb2GfOYes6aLLzZh9YFMFr/c?=
 =?iso-8859-1?Q?aQevDCKeSwSAoyCCYim02BE8wty4XV0FL65DgdnzNHRxBmZAOw7Y49P8oD?=
 =?iso-8859-1?Q?FKpVaXC1emVYecY5Qk9VyiIvo3ilb37FDTUShuzTBT8R5QenfUQwyBjuo2?=
 =?iso-8859-1?Q?ICWQqt2oSEKD/G6MLyUhXVi8xqC7tl8X+IhGMxaFaYHcvBubk/gdzC8r32?=
 =?iso-8859-1?Q?tu39r0gJ1FPqS9Nhv7dYeU8ci3UD8jjlxhzAhrPZjBnxw5Xi+r8sTAET6m?=
 =?iso-8859-1?Q?cRRhD90GoHib0cOvS+LqI8cpb1cvNDdYs29Lrn7df5L8pNxGpAjJCJYqUE?=
 =?iso-8859-1?Q?wGGxzR8fTvmGZBKluqPe1SKjO9iUS5LyCW3uopqBTnQ235p3NbOXOW0Gg3?=
 =?iso-8859-1?Q?tsFfXCrNTfNIeadd/l2OT1j0Y1vW9vI2zCAAq6IptmnLUZScLzFGrNiOP1?=
 =?iso-8859-1?Q?ZMNuxEsbDisJu8Ln8XMUlKLVXUzNwW8qHwCddQar6sfUE/47hXDW+YDl8x?=
 =?iso-8859-1?Q?2vIZ6OJ3mkpaZV6C8nvfNITbzAKmigr4DP8hnGlXX1UFVrHD2cyByuFKFw?=
 =?iso-8859-1?Q?reIx/jsuzXfTn5HvxL2IXtUiLtMfCzxXrPqIZfUWafJg65w8AmpZ1Lefn6?=
 =?iso-8859-1?Q?Ouen6NjIRGt2LKrUPTwgkHmfBO8b9Bpi8vgto4exUQ/qNisu5fOI0dtGT3?=
 =?iso-8859-1?Q?zgD8ixrEsjyyDWAyx/UWzYEEwnX1IyrcYbbhy2uFZ/KOM22VykuqQE3mPz?=
 =?iso-8859-1?Q?1YUVwhWJpvI6h2lGZcM2x2kesH9aD6VIeh2Lt3xayi8dxRVmfJarLt6i9E?=
 =?iso-8859-1?Q?ZQ5ZDc7oLVmnYBYPSMktUZ4onxoXJ+9zJ50TWab7LNm/ySTrBooKfTs4Gt?=
 =?iso-8859-1?Q?129TKOO7GxHS86zRWLn7nfBGXplUvipwvYw98Vd+yfbGlYJ7A9GXqhcLMZ?=
 =?iso-8859-1?Q?JnHvYRUClEVDg5Urch4T06nTrns5FRwmBFqb4J2y+smNecD4OTm8JiDg2L?=
 =?iso-8859-1?Q?keDDoxjBwKzsFtQk6xXA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gaHicyHzdWAJt1PZJm466YmSLBJoXlIrLWSoKZzfgX8I0J5fUxdl5HWz8m?=
 =?iso-8859-1?Q?B27zQwE+Ejicc7Rs5fo9EmpRXzwnc6OvIGElQReme+/C0bTBxzD6pBolVC?=
 =?iso-8859-1?Q?BTO4l2ht9Y0DvTdxgBQLxQvoFXuH65FfrP+0b6QLnvqseYf14ki/ESZ3e6?=
 =?iso-8859-1?Q?l6RqQs0pZPMun7fJscyF+9jM3nlEphYz9p0rh8rDkXS9enlPPHe/Vk0/fu?=
 =?iso-8859-1?Q?9kazIl9YgS8NaVJUCTnF/u1V7X9cezS8sEqgRHtfywyKhyfq7gmmyAkx9m?=
 =?iso-8859-1?Q?oTEQDYHzkwyO/SLN6Ucr1WY7Ph5kzbyC74S+k5VHK5gvoBSXO15Y5RNMia?=
 =?iso-8859-1?Q?3PmXNF5Xf6Y5iZ3wft8xVcBClpHY6yao80vKBrjkyu0okdrNBjqQxEaqvv?=
 =?iso-8859-1?Q?jQ7GC9Z5QtdV9eG9wKjqTbaLZwSTJSzU13/wcmwxrovmUTdjEKwsB90vJX?=
 =?iso-8859-1?Q?hU/si0Lyobs3QC3Vk41FvPEtXNTWaaAYaNDerdfy+lZANej6UL3yilhV/U?=
 =?iso-8859-1?Q?XIa8c3C73DzSO41furi0sY/Ur59/7DQV7Ge7ikk4gVftqrhSniSp4zhlhs?=
 =?iso-8859-1?Q?IVomHKpn9Z9W7NOi+6s9lk2G0sUxGOLsBqDcwXUiDR7coq8PXaHGb1iaAy?=
 =?iso-8859-1?Q?ynmDbUdksfVHSQaZXBawo3cTaFbyOIZY9BT9LXgtzOzlo2jWZ2JuqIDtwK?=
 =?iso-8859-1?Q?TFT+Radr0p5RtGBwhztNtkpSPrzWqaCJ3QzzxpXndmhdQU4sc1eXrar6Qm?=
 =?iso-8859-1?Q?Wak7b3Krw4b8xm/q06s6w4gdzqfwIiROC7sevHzNEWuFHQExVaFFWORRzi?=
 =?iso-8859-1?Q?jmqsrl3rjbvtlK3gCFtiKn/wehM9WjxWOT3sUIRSGPHX3vWncbByhbFVk3?=
 =?iso-8859-1?Q?aKxsNjFDlxkugStwYk7yTdcSWHrWKmX7AwinEc1u0D04h/8UT/+4gvfyui?=
 =?iso-8859-1?Q?ZnTgSH+zMIwTD8Ojrg2Gk5ki6F9Z4eEeWJNluOJahAKcSAW/eWZGXd0fi9?=
 =?iso-8859-1?Q?+Q/HUSL4QaFH9QJp2nEGGA3G4ELHNJ3o/Xbm5hKoTIrssoYp/rosrXBtXU?=
 =?iso-8859-1?Q?Z72DSF/6BkBRP3/mHgYbpXjAnaxZdC6rid86p4G5CrsNNjLDOjtET5uiBV?=
 =?iso-8859-1?Q?v151OC4otCO/rTBKL2fsiSSSqzID0QjACCDMo2/pBjcKgThVdv2SFnAqUE?=
 =?iso-8859-1?Q?x8qtDONE8e02aw48cVWA48kiJ9+Ftp8QDZSNFEtIp4EB9AUnQH7Jj9blWN?=
 =?iso-8859-1?Q?LBbhJMLkbPGqrQUoh7e+LBAqm9kw7pcqVaQG3uWBk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c4b97e-b1d6-414e-ea74-08dda0e7be16
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:53.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index bc26abd150..e169c5e919 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1049,8 +1049,10 @@ static int auth_cram_md5(struct imap_store *ctx, con=
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
2.49.0.638.g5e24c6cde8

