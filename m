Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8222D7BF
	for <git@vger.kernel.org>; Thu, 29 May 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535682; cv=fail; b=KuxrPgXHGMBEudSGLsUpwagWJ7UewsN0ngNK1I0W55W81q3ZPokz/OsG50Ok9DlMjIUB32iGSif/gIHC+C4Rw8wbcjM2/L4R3qxvpByJojytv0mw8eLBDLBiDE6WpoX0+n0SD19XLuWjiOF03dRuXCBFS6Cu7bGSuOE8rOMrAjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535682; c=relaxed/simple;
	bh=VSJ1Ks1E6+IsKwLBW3ab6E/azzSLaAS+gn296znJmd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PcIb8lhBRMr+PmfsHLT3zKHmYmNjz6uVFP6EmKtOH42/WQTNY6IusWY5uAtgvCC2yQz/m9H2YcnpviyoPfBcR5EPfsU9nTznoCy06DIhjZHoi4zHarYrQAhJddsFbNao2jcNXlmapMvIO9X9km6Ml/tOKXEfxjVYeEmrRsV2v7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=m2Rkl820; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="m2Rkl820"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vOAl6TISw/l/n8AP3PUhSEls9J5cdngrjgnaEVtPmgJjsW7E1NFkZO7/ra13tJro6o0UR1AhzNHlx7yPfGjtYSWzxWfWNUef1e71Eeri1mqRfvum/7YUF7vn67bRoGM2zr2SueBrFQJgcM4m6hyB8jvOTXc7v6eGO1oNBU7XOMqIeb1/PYKOtWrhHyjUrqn2VcGbar+ZsVicu46Hr9d21xLwXH66LjCl0BVzj0vHRv5tkeG8XMHVrrXPX5xrIJiNKKpD+KxXq7su1/itKs0FOqI23oO7zXIUhHvDonhmOhrsiqIOQumWBPO6BcmikSLLs9167SLG+2dOX/iN1TRl7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2WMY6CKMCQ3eJxQXw9kZiPPnkis8GdAvOIi93md/rU4=;
 b=bb8mOsI75Xs3Cb0JGRvlTdGYHMbKxX5wnvYfMwSv1vKVA3NPN7acEH6wxHqpf+SVR3a2OyI0xlQo23P2JvJgnhl5LHM/adR8b3TYs7cXotcZhzaDih0XbcWti+ZuGFkE2PklzujMVKg2SzldHeRd9MvqqfZgblvCVkUNcfb9xD4SnqPdvshFaLZRnYV9UtMt4e9AG/Bnu3sVSvqkDe0evRRPACDudsltuuXLFJbBbzBYpxMQeH8WjaR0QQkgZHMyHYFEnOahlZOFd7xzSyfwNhhicjj5Z3kmJrRPixLivWkhHwa9gSPA88TH/fV1FUQxpE6xHKaEO6ClvrlXsMmGdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2WMY6CKMCQ3eJxQXw9kZiPPnkis8GdAvOIi93md/rU4=;
 b=m2Rkl820NOtNxI2hLRXHQV6thOTmryV5wt0o9Upgo1UX1Ee/aDthm2EXlL5l9W6eRy6fXrc1t4q0Vo7lqWrEfM48cjttJOxipHtGxOLrnl88kBIp5sK7QoWyZNxeLGLL+LTwOmNTumpGif126nrIqkZHj4wAkLvo+Op4PSinqSI+WH0j5bPCX1Pn4SkjQ07L+LUAlOalwwrStLka2+gUFXQPuf21j9UYb91nUWlHKbQJOlCkqEhfKo5A3AwszwOeqp5EPfnQLBLPvuaaTagzowkOVDS4Yahzli7I6lRn03ZONFt5gFcPl90OkuAuZhFddmVer5u8RfXjV643XnL5zQ==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB7067.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 16:21:11 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.029; Thu, 29 May 2025
 16:21:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v8 6/9] imap-send: fix numerous spelling and grammar mistakes
 in logs
Thread-Topic: [PATCH v8 6/9] imap-send: fix numerous spelling and grammar
 mistakes in logs
Thread-Index: AQHb0LWw+4wwY/2NfUSVs8SupVwxdQ==
Date: Thu, 29 May 2025 16:21:11 +0000
Message-ID: <20250529162020.45187-7-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: a15b0592-1748-4204-ee99-08dd9eccd342
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnVpqwGBbaZZW1pMskFQwysuxXN7DAhaOkc26eC2prW94wJ1McwOEI2x87SsboUyTSH6jJdlEFqySs0xoaQZCuCIizsWTtzlJ6VOJrz6Sug0jfMN+qfhAqsj2ETVhn3WZ5ZQ7OJ7loScYisEUt+sA8HDbdlk8H3xzgwX2hgoGvrD2SsORFAP2QjYBdlRefzdGwvBRXzUcf0WPigIyrBazBjjtxjjd+yuxAbkBXpD03NQIni2tY1mI3Ex9rnNMeWSxF0QtJcQLmsLzKTn6t/ybQ3gedZteawifXtEutt0n9qmISA8kiJY+QCb495AMx+5h0B2YJVqssNaXuembp+nvokK1AuPxjM2C16Z248TTPooWD1cTeNa41TDRlJZqF5AatJCPS2ld0cp0RmdoRWhkLlQlvn9ShVJPRQ9WWs4qnAkg+whoT4Mw41roXcbnQkCDjO2AEfD5dSHfe4hda9krbsItMSA4lbq29mvJID85CU8DEA5ky1ydZiSZAeBf0zzBc51Kg5ig/xg1kWeB3Kza75aMlEXXkUm+Y9rtF2rW12DxYY0QXzsr+hr7Owh40aAzbXeUrfrZUxpd/b6bQ7nmsIiLpzG9mkduxQ0z6Px17rwtJh3rfwZgufKHMaILtt8XcQdnq/gkL+KB1m7G5XoJeva50W0Dk31sDZ5m9U0aD+ahbV3mF2dwY/SqLJtz6pRoPC5SxPg9z16IAhZSvTQvtkepuWncRaRTqlVv1RWz9i54=
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|12121999007|19110799006|461199028|7092599006|8060799009|8062599006|15080799009|41001999006|102099032|440099028|3412199025|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?I4/eC42odnC7brSa6vQdOpZkn+0ppx4DWFSLTIR2xq88++6RdqPpys2y7g?=
 =?iso-8859-1?Q?jbzAolNhR9dH8BLqfeuCK42kMN+beCvKsA5vwTssIU0UXU+C4rQ4al9h3H?=
 =?iso-8859-1?Q?5SoPYZpHa2dnFlHXGJlV0TmltCQTvSyiwiL0k2JPQe3wzpGwnbMV9hyvMu?=
 =?iso-8859-1?Q?VjY78Bva1i69ILRs83tnqD2xqjI0Mer+Joqo/Ea1zD2L/NSURJb92VluPd?=
 =?iso-8859-1?Q?DfL6DqLAgQwoTw9UGxcX/NmCKfcO0NU0+x3sEv4aFq5LB8/GqrHKMF+wDB?=
 =?iso-8859-1?Q?p94zENkFTNoJX903kQyIT2TCNkhcR1L6bAZRYSvO+4oAUwS+x4u0MX4NVr?=
 =?iso-8859-1?Q?syntNvfXBWB4pj7sCdCMetNL1g7WJMBotx8YYZk9uzYnsKUjhTJAOairz/?=
 =?iso-8859-1?Q?HoMsjQuz4+LowB3pKGEmwQuuWWRUyAbSyTLLLc+aDrpnDR0n+smpTKAlFC?=
 =?iso-8859-1?Q?qryHXQ7/xl0aC8mIXu3c+0cCzWZu4OMDe5XifmLlvAmR3c5Tn9g6uX892z?=
 =?iso-8859-1?Q?/Ov4SNGfOcRNcxmCtNWfJbdEW0T79XpkhlKTivNoTo/kajRO8SKjYBLW+3?=
 =?iso-8859-1?Q?xN99gPHwTck8fvWrcLqTIvDU3h5jla/auBlEcQL/a9dxVNDO5Yxu9WYka/?=
 =?iso-8859-1?Q?QKnIsYyNIJkUCpPBKYiWeZ+WVnv08Qx53mwtJA0hSvsFABB0dugQRhfIYj?=
 =?iso-8859-1?Q?noCUYIPB9wnCXkUIKyFZuOQ0/a6JHunGmsFBPwqn5svdrleHWskEOE69A9?=
 =?iso-8859-1?Q?yxpEw3jYW0sr+pStT0EiwLp/XPw/Fdw8Sw/JMCQ83ydyEK+rtr48LwgF0r?=
 =?iso-8859-1?Q?Sk0quytZv2kvqVoBv4BoFnq7fNOrMkDmZpy3+vjWwExQzyRJravlzkwcu5?=
 =?iso-8859-1?Q?hJReoRs4nYYsfr09g5gRJxyHUPjrDDFCN0RK66MK9ePDCAt9LvE0+quxR6?=
 =?iso-8859-1?Q?4bDrW4zhSAlTJfWXAYY1iqUid71YI9dctiAudl/n/gyUL9wghY3alfS2Bs?=
 =?iso-8859-1?Q?wuv/Wp4fny+FBEOqpok5yls6zUktfjMKtJqKMQps86hsyiGGV5cbI8yMAe?=
 =?iso-8859-1?Q?fGpYIC1mlWPRz7lAdOtoUPvwJ9adkJ50bN+eg0XdodK7gqJIHDB9D0fkFm?=
 =?iso-8859-1?Q?M8pskkqL/iem3IZxfVVNMaYLwMoqbcy3k6ozfScpqLTWSi5FHP7Cuzh58o?=
 =?iso-8859-1?Q?RTbSmG7/jPGQSvqK2D+MpxW7edNGLNHBWI2WwXNvG3O0eHJim3CEOZHoKR?=
 =?iso-8859-1?Q?ZzNbUbpdAvsbH0UfImDgfVgiiVmZpf+GaY+rds6hU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UFF9JJ2raJMP0GBOp1O8XfoAB4TKHXihbM/djmiOXa2gFF0PLXmIJwNRQo?=
 =?iso-8859-1?Q?RSGGclOFVQTnBHyUxpeUaGpJyQgi7Ci0DymW+KXzFJMjJVUHHYkfUXFi6G?=
 =?iso-8859-1?Q?IUKGgCEhe0JVFJ423Ht/nFHCNRvpIxvCyNHBgV9r6FyGsj8+cvU6O32XKJ?=
 =?iso-8859-1?Q?Cg+JWeH4CLOJ53rarO/YcPn424t5X0/NJWiLlOtGuOtNGbldFULv7xiV+I?=
 =?iso-8859-1?Q?4kILSqndy8iiZ6rZ2hGACj/FQXVhTY7XqGVbNKV2AL2P1+yeTl5R3Ckq36?=
 =?iso-8859-1?Q?gb1Ju19ZhdHQ1gJREC5kbiNRwv9BvuCx6WjNWIOGeu3HJtzHxBe6/yW8sR?=
 =?iso-8859-1?Q?bsTp4YswEUdayeXMLBz/Ctke4I75cGRMVh+N1Hs/SAsjXi3Pr8fU1vJvfP?=
 =?iso-8859-1?Q?8H9Gjev8Jn5inJGSST2uxnnWkUVfNPfrs75rFrATX5iwva6x420762jBRo?=
 =?iso-8859-1?Q?cEUcVJvNaIWSsPGAntesccC5ql4XghVIkVjovMN4t5O8k/KCGzM6at7Mqx?=
 =?iso-8859-1?Q?a/FWs5JTbjFTLDis+aQBDIf3lqo3XvsoORbuDapp/8TxNl2BH5EUs68i5G?=
 =?iso-8859-1?Q?oI94ptaJBspY2kKKwjgMJf0RVijN8Fvw9r5v46+XCiCsJjTflvAwyczRce?=
 =?iso-8859-1?Q?bcX+t5YOBjFPJmQ6ZgQA8R4gU4Q+l3w/UbDBmlSXKQT//7Vj9rZ2gafzT9?=
 =?iso-8859-1?Q?QDiWtJdsh4W8qCsv/PjGsJY8S83MJ4TyWGbV9F0WYK8Rdulo+Ccqhe9Way?=
 =?iso-8859-1?Q?Z8bBr93K8wK394pAvxgVbD9L5zWUgYC6ZHNgb34MixP+UnVJ0xJsLSiKJN?=
 =?iso-8859-1?Q?79/Or05YBo6LUAcw+2IJdlfYSA5xvJf6U1YXzaGNKS6qmkxhcp1Jx69wIM?=
 =?iso-8859-1?Q?P1gbtAAJf6xQR2GfRIEWlJqpfwP+//NIoy42bK3z7fpWMsznrg4pTbs/+L?=
 =?iso-8859-1?Q?SKWpQIcFyI6lOI7m3cucd8MI2if50ZD9olM47htKf1Y6O0OfJoq1Qo984v?=
 =?iso-8859-1?Q?OhR31R6dql/xX29upy5SSekbF9gMopHqfFRUkroRq/jfW+oPtwHNem3vvo?=
 =?iso-8859-1?Q?MFowKbOttzTZYUvQOkmkTOV6CQBtzAlcUc27mo2L2dbsyOluDDgq4H7fGn?=
 =?iso-8859-1?Q?f+g+2tZuf/QKxj7qyD++DmDescQzu93jYaK5CUxpJpfjZHRHEX2rwXAUFM?=
 =?iso-8859-1?Q?hfpI+rEY16x6YuIEiN7pYAo3djKVSDbq0BvkbncxJ5PHZS8f6ijct1SnPv?=
 =?iso-8859-1?Q?kr/0MrmIFQ4qeL37YPdK3vgo4ZRicSpZBejTcRTXo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a15b0592-1748-4204-ee99-08dd9eccd342
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2025 16:21:11.1055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7067

A lot of spelling and grammar mistakes were found in the logs shown to
the user while using imap-send. Most of them are lack of a full stop at
the end of a sentence and first word of a sentence not being capitalized.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 337f1049ca..d99eed0659 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock =
UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
 	return -1;
 }
=20
@@ -249,9 +249,9 @@ static int verify_hostname(X509 *cert, const char *host=
name)
=20
 	/* try the common name */
 	if (!(subj =3D X509_get_subject_name(cert)))
-		return error("cannot get certificate subject");
+		return error("Cannot get certificate subject");
 	if ((len =3D X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeo=
f(cname))) < 0)
-		return error("cannot get certificate common name");
+		return error("Cannot get certificate common name");
 	if (strlen(cname) =3D=3D (size_t)len && host_matches(hostname, cname))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
@@ -905,7 +905,7 @@ static char *cram(const char *challenge_64, const char =
*user, const char *pass)
 	decoded_len =3D EVP_DecodeBlock((unsigned char *)challenge,
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
-		die("invalid challenge %s", challenge_64);
+		die("Invalid challenge %s", challenge_64);
 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, deco=
ded_len, hash, NULL))
 		die("HMAC error");
=20
@@ -1050,7 +1050,7 @@ static int auth_cram_md5(struct imap_store *ctx, cons=
t char *prompt)
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret !=3D strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
=20
 	free(response);
@@ -1144,12 +1144,12 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, const c
 		tunnel.in =3D -1;
 		tunnel.out =3D -1;
 		if (start_command(&tunnel))
-			die("cannot start proxy %s", srvc->tunnel);
+			die("Cannot start proxy %s", srvc->tunnel);
=20
 		imap->buf.sock.fd[0] =3D tunnel.out;
 		imap->buf.sock.fd[1] =3D tunnel.in;
=20
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1168,7 +1168,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1206,7 +1206,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		addr.sin_addr.s_addr =3D *((int *) he->h_addr_list[0]);
=20
@@ -1220,7 +1220,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("Error: unable to connect to server\n", stderr);
 			goto bail;
 		}
=20
@@ -1232,7 +1232,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
=20
 	/* read the greeting string */
@@ -1340,13 +1340,13 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, const c
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN.\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
 			if (!imap->buf.sock.ssl)
 				imap_warn("*** IMAP Warning *** Password is being "
-					  "sent in the clear\n");
+					  "sent in the clear.\n");
 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass)=
 !=3D RESP_OK) {
 				fprintf(stderr, "IMAP error: LOGIN failed\n");
 				goto bail;
@@ -1591,12 +1591,12 @@ static int append_msgs_to_imap(struct imap_server_c=
onf *server,
=20
 	ctx =3D imap_open_store(server, server->folder);
 	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
+		fprintf(stderr, "Failed to open store.\n");
 		return 1;
 	}
 	ctx->name =3D server->folder;
=20
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
 	while (1) {
 		unsigned percent =3D n * 100 / total;
=20
@@ -1648,7 +1648,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc=
, struct credential *cred)
=20
 	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
 	if (!uri_encoded_folder)
-		die("failed to encode server folder");
+		die("Failed to encode server folder.");
 	strbuf_addstr(&path, uri_encoded_folder);
 	curl_free(uri_encoded_folder);
=20
@@ -1704,7 +1704,7 @@ static int curl_append_msgs_to_imap(struct imap_serve=
r_conf *server,
 	curl =3D setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
-	fprintf(stderr, "sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
+	fprintf(stderr, "Sending %d message%s\n", total, (total !=3D 1) ? "s" : "=
");
 	while (1) {
 		unsigned percent =3D n * 100 / total;
 		int prev_len;
@@ -1788,13 +1788,13 @@ int cmd_main(int argc, const char **argv)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "No IMAP store specified.\n");
 		ret =3D 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "No IMAP host specified.\n");
 			ret =3D 1;
 			goto out;
 		}
@@ -1803,20 +1803,20 @@ int cmd_main(int argc, const char **argv)
=20
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
-		error_errno(_("could not read from stdin"));
+		error_errno(_("Could not read from stdin."));
 		ret =3D 1;
 		goto out;
 	}
=20
 	if (all_msgs.len =3D=3D 0) {
-		fprintf(stderr, "nothing to send\n");
+		fprintf(stderr, "Nothing to send.\n");
 		ret =3D 1;
 		goto out;
 	}
=20
 	total =3D count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "No messages found to send.\n");
 		ret =3D 1;
 		goto out;
 	}
--=20
2.49.0.638.g602e07a80b.dirty

