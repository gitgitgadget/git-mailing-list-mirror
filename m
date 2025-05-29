Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE2B22DA03
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535677; cv=fail; b=CP/XWsLkYX75B3imxueHip/0QgHKoCJMy3+cSxOuRkkOGgxsc7Em4VuDpxih1zMZ/3+scLmgIK+iZ0f56Y1A9cKTngotTrIW47R8M83LsZ3eTx71FRkF/NqucIL9PxETNc4XiHw7OanvQYlalyyMjNQWasMwHSZ37hw9tHiftVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535677; c=relaxed/simple;
	bh=JsG7r+nzZc3jGc0LpIgrUnKH9jtG15h8pFOnoaR4D/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJwr/xvavCQxfce5sVP3vuuRo+3bwpvKTI4Jj++J1X7L34OTyAYKuRDi03jLSZe8lJZ47IQRW8LyBJqacP1CLQqSS7rvhIFGQsN8DKcgytsauZL7hIm/6VuI0/SGvfkqukudjUv6vI9TuqhjQomN5gi1+bsD97u/bZmHQdl51Vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uat/ylVI; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uat/ylVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYxEOkKtupLXKjk1IlYLv2Rgj6NSCT6QwHYTy9eGQV1eOGcYrigwIR/w/2remMz2hepMdmWfu9OM4QK1VvZYgQwa5MQfwaNzgbxvTLfnewqv3VacQ0LJJEuZw2EEedckHwgh1PjpVFos+AZjfnSLkHyflv4X3cx1TwpSsovmJyxXE/ozQTZpBqu9ZjBR7DkS9GJBhhZM7+HTQdPf9AOeHG0njkXKPwDIUuO2QqCfzrCm7xBDo3EdeBme4VXwpDZ2whBnpYTVjYeC2h8ZLaSFCWu9tEByMjGBHfI0axSO/I+RQLl8dRITubV7OziWhr2KqhxOT/TxSQoAwWxsRfWFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tcy0SSJR9/0Yb0Ta1Ar7N91HxXJ19/NH7+XTAUByzUI=;
 b=v4B7KLq0hJZbvYkPB/YxHFcNaf8R9RAg7ysc9eugjQQkBhcwsxwIk9EYd/rCJS9JT3sULUbnJBxovwOms468BsIhCHwtY8Pifo33FH70REalVFqiouA5kCN71SXyBVTLyBk4mYLoU+d/ONFv9ncoFMT7u1TEPCl5Szpbvm5X00pNvhTBEpgNWNl2vvDBKrF5KI1S5XVH6sTGNfjK8u76+jiy5Axf5XLM5WWDmx+/ZIAYl7r7/1cKx3cLomSkKpgg+6zv2M/z1l1RK9Ipgeekv7vCdKbrastIex73uRc7vN3vSn0vy/ndNPLNNAuCtxhtibvZxYIelR43dpw1HydPKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tcy0SSJR9/0Yb0Ta1Ar7N91HxXJ19/NH7+XTAUByzUI=;
 b=uat/ylVIyodCkIBARaWoo5KCF9VriWIxYreRsXzbeYRs/B1DHFIHyL6MHrczFAWN8pBinYVWIf1KmjjKmwscq3lvKL4PUbe8lE1L9+8Xw7kqWhJ7tKDx8eFCBa9MZGJKoS0uJtd14sHCg5CNXAQCFHjH+Hw+FaVEKAto2diNatDFOLhOyggBTksKb774gDi3Zrm0zMlCIu6rSpZ6aaeB1wXWKzlC8SVjTOsTehxtmepKNkiK8f6UlujO6YJmTm0C/K3QOjuX21j71ZnZRW+YdGaKryLAh5XWE1H17CO52D7jAkN6oacAkcxxPWPniOJ/7qpdrcrxaZewjsvluGe4kg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:07 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 4/9] imap-send: fix memory leak in case auth_cram_md5 fails
Thread-Topic: [PATCH v8 4/9] imap-send: fix memory leak in case auth_cram_md5
 fails
Thread-Index: AQHb0LWuP4MRWu5RUkeKfTmdrz+O+w==
Date: Thu, 29 May 2025 16:21:07 +0000
Message-ID: <20250529162020.45187-5-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: ab5cfd8d-c69e-4385-849a-08dd9eccd149
x-ms-exchange-slblob-mailprops:
 5fu/r660v9PcXSQ/czQan+5fCOfJxmE9ZzAokMqX37f2WsBpwI97eIH67pMM73VgeeaaG5LpFnlVqP2yYy4Xr2iBIlfU33BL85xhs2cpUye1HlObTRxuksjNG+KSn2DYIlVuzEr8hSXUQVfiUDB0TdwwM3l2RQHb83GHpytmar0DvAyTc74Dx9jGiz3aeZLIxXmXLWG/1nmEyjp76Co8irVHTURA9jDSObsVSdCdZhYf6Es2TpOC1wWU30ToIgz5Y1ZQzKRgVe7Uofc6BueygvvOuozyRL1c6Mt1l1LT5NVVtd+zXW2M+uAg0b+MYHpJS4AH6igJwPlPx6e7vqZjxRl7TNf5QENTGNK3yHipGkcJooS2FnmwHmSysFxRrf9p7dK0yGx0tvR8eOtjdHTkxzaLCW8yDWd442mqP7cfPm7OKDg1/J11Y6AoeaDvF4hanss/GpDyMUu1UCQkG13q7GvP6r8GUEH9MzHl0J5AodeMpxDaW+RGlvPT5dX7OV09yy2deiwe8dOR2CLbayMR/Pm5tMGcPYpuH8txZgEMIK4eM440obZ6WUKvl7rwZSwubFzA+tvblXWtyg0bmdoc9u8Mdq/Reaki5VrfCgxN99PA0MWFP67RQfZk4+nWx7CSqAUqjqXQMubrF5tXJubM4Rz8ON1YPY8G2zLnbSKzDaiZjT0CQ3nBBQ94NFhBLGSF/mIeOHXY9ZGUzCGoqy5tWnPzwOw8KuIN8LA7c6K+5Js=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?kvxtN+TsZ7+d0BZ/YyLOn3/QcX5oA9zrYGlGiDD+fsSuCvGjI7EemPuGeB?=
 =?iso-8859-1?Q?kiFy5xaej2OerSF4ix2hrLjBT3Izj3UgSdl2KPSIiDRDVliKmbCK/aqdNa?=
 =?iso-8859-1?Q?qt4te76tSjq6JLC0TeFfzQrJaN2Q5nR1nAE2NtsBws8j9WmXyiA3HMpgS/?=
 =?iso-8859-1?Q?9aZgIdUJrOmpWWJMj01nbATwbdXq5g7WOGZvOOhmiX1aawdQmOongOfHvY?=
 =?iso-8859-1?Q?MTDpqcFfsO4DGTMXaWyy7J41eudn08vNPu3oBD0c6DSIKGsrUHOzLd5FzW?=
 =?iso-8859-1?Q?KUHaQS8QTpNzHx+A6WRQcJ0+kjxJosLDR29EgCnBJ/DWoSmHgvyWE1coa8?=
 =?iso-8859-1?Q?Gum9EmuuSDZPhAVzn/yMcDuorjBCnZGRnCiFQcr9qoWXh1GkSKYL4C+LY8?=
 =?iso-8859-1?Q?PjJLf7FwBu5gw0GtMUqoXqNq+q3HBv9mtMr/DCn+TjkEuYQyCUwITwEMmC?=
 =?iso-8859-1?Q?Mw+TbtjkoZ1gamSSdMunMdsHNUK0/WBzufzJ4eDdzBUzjwHOq4BnYeLfvd?=
 =?iso-8859-1?Q?HlA7C/hm3LIrBzJciTLOJqlIpsuRxwJWcQz+WNxVtjZC6oL7Hu/yjFhFbE?=
 =?iso-8859-1?Q?Zo69gVCAxgWYB5kNAh2wdsZrr2hLlfxtTzx6Cz/MN8WqviFmsUfF7l03Cy?=
 =?iso-8859-1?Q?O1nwyADqfrh/N/9zkPREAFvEXDndf7JgaODi3Hl6ZJ/PrFaLb6sSHvTOI/?=
 =?iso-8859-1?Q?BmK4nnk6aFQwbEBPjneJAaTVjWFfF5pwRMwVngVggCunGmgxQNO3nVBTP9?=
 =?iso-8859-1?Q?2Rh2li6AfN4RLnVLCDTWwFR41qukHXU5mqzAN7UJGtTCu6ncb9JnqAHFcC?=
 =?iso-8859-1?Q?ijzjPC2JbfHd0JQeDFgrBbIlVt1vWdmwemv5xlAOpPLgZU8SQdoLI1n8sB?=
 =?iso-8859-1?Q?fA+Hj6uoS6iv4Ms9GIxcHqDq1deH/zWDnCo2KuLUp13y15qOpEJOMpEx1Q?=
 =?iso-8859-1?Q?SMT2dm7b9IBOO55uP9In/NGnpPG6YL9Snx1Euzf76Cj+kkXrwuU/T1SOQi?=
 =?iso-8859-1?Q?K+sJFdyS36paueDRHibCFXT5eLlHklxHpGXeVxDqtoXjnqW7ym98fA/BwK?=
 =?iso-8859-1?Q?bnhQKQb6ypXYa8d/ZwVHk5WGiSEo8bn9fi5y07BCZoYOohrDa6fTH1T3qZ?=
 =?iso-8859-1?Q?tafUe6lRdX56zF7PkQ6bKpeaCHuTBhvmTD4mF4kUU84e81YSwHAlZXKwVQ?=
 =?iso-8859-1?Q?P89q7/W4qE2lymp8jQmTfCO+3rnDn/Mgv2alYxBfUHl9jrSAz3k6SEkgqF?=
 =?iso-8859-1?Q?iHox+ipfk8I9SQXpX0iQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?jw3P9CbxLbcQdxOGNPU6owt0JsMpe/VqFMVC52QBBD/+OaYu2fxJDjaL3J?=
 =?iso-8859-1?Q?g3reg130pYvwPwERGlijbdM8Ivrn+unLOlQtFGXPpMImLLYOI7763sqmPq?=
 =?iso-8859-1?Q?LT0rnKiWXivrvFMmikDWzqongd/GeY1RcNJs/zlr1kiXwHME/ZkTq+C9f7?=
 =?iso-8859-1?Q?abKDftwqd//cpJjCGpZX1Jo9syDSwpWE2uIe6KVzYaa1JSgoAR+f1Px/Vk?=
 =?iso-8859-1?Q?bhLlAOADabTQ/HsbQ0lE8cLMBFN6SyTj8YE85+1wZRGAJrn2mGgwq0JItW?=
 =?iso-8859-1?Q?58jCxQn5Q/mU2V60SMJ40nlRiBmtNp6YYfEPfeM7AI/Yb8Xv1onN3HeRw2?=
 =?iso-8859-1?Q?XA7dbQfJTiaHEds+gm5fpUIDsbRKDCN3f/nfLv2WOghTimhbWJAyq6l7a5?=
 =?iso-8859-1?Q?d7NPdbDmqrcrU1z6BXy7myZl6WFx7GEcimVLXuLGC/Lv9rfSeLGwZx0K/+?=
 =?iso-8859-1?Q?i/x5MgpUmoMbRDERPH0e3Z53hwgx40eDrKBgbScnMlfMTKKrHuV/zGOCgL?=
 =?iso-8859-1?Q?PuBvrDjSJmAw0A72YxankQ3RtCXcG9my508oR+p004RLOfS01CMQR/Fkui?=
 =?iso-8859-1?Q?u5Da31NDv1a1GIY8/aibqpjrEqktWitC488GoOExC8vlk+H5EkXuFdDnv3?=
 =?iso-8859-1?Q?Ln+++y5H/X315Wc7wgOqfgVX4mOJB+qNGWlSXXmdN7FX1iX7jm7QETrYVi?=
 =?iso-8859-1?Q?kVuJZmVOVv0+tcb32PfypK+0P7m2+1mhQcQ7g13FZ0oXsCc+25R7Z4d2O8?=
 =?iso-8859-1?Q?Ylnx/DDfb0Io9lHvhrqghM1g/FzT7iT7IelV3sst7g98TEtaa1NDb7Mnty?=
 =?iso-8859-1?Q?PP/Ybedl1AITLDtnToNsGu1bQLVw2RFNkDDJhyJlXGDoo9LapRFN4MzSTG?=
 =?iso-8859-1?Q?u0jvp/pzeMN0qAszhoOCHWdTyYGe1V7hHo9I/0dciqFL5EWifsvX1ATTjD?=
 =?iso-8859-1?Q?ynos9reyslStmh97Scd4EyVDC3DKreD8wr1iXX8x+MA6D4nxwuTMG9Y0oX?=
 =?iso-8859-1?Q?C2SFT4zFn+7qI5p5TNySiPIAujaq2YzvidIcadI72OH1ULoj42nKu5FM+k?=
 =?iso-8859-1?Q?YzaiMsqZbatksL9UoruRFt8GEQuvvEVMdHUaCVb4tC8ED5DlBoRZQQhFtl?=
 =?iso-8859-1?Q?Laog//JhAt8WCTqCdc7ZAdr/V8mZIsbhoZHn7nZysBWzAnMqiMFiWdl161?=
 =?iso-8859-1?Q?EGEm1jhAx7iMxUoE2/75jPSEgLYkBv36MUX5+havsvs9uPukDEPk43mpVC?=
 =?iso-8859-1?Q?wIH9nBAPr5OoNTDEO8gb+eUAzm8zmYMxM4HLo1cjA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab5cfd8d-c69e-4385-849a-08dd9eccd149
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:07.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index c07ff98c3a..d0c7bac030 100644
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
2.49.0.638.g602e07a80b.dirty

