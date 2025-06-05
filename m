Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D863E20FA81
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112957; cv=fail; b=YAWbi8lOKytbsEhDws2GT10vHs7ZodCYiX1tBd20U9PrcBQQQpRls049PH29v9N0AU/ZxN7Omxtsi0Q89/K3Ymm5vDBm+H2l710hytc4261M7rnB+JIBYrGdCKb+PDOapeKWD3YFtQPsbNyIogvKFHR8I6YYzYnSUWjnBuHduUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112957; c=relaxed/simple;
	bh=m0Jz382WE9BwGBoKz9f4PxjyAcKHAED8YUyyjrocx4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZohhNO5+Kz2MeAmsD1quOeG6Y6XeC7IdTHFr47EaJ+fybAvxBRVIRuLPdWOFbiQSpmtggiV4rDOpai9ed/aw83TV/tGLwdvh/NAvr09WQKS2YLgu3MVNYBsJ2nT5cY8ISi5fAK0NwlLVYrVNzqoUnZJF9AlcwijwEO4JAtErgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IKV61oE/; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IKV61oE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDJ3tt3VPiiESWZvciOlzQ58dWuHEix4dGT5nLLPZvNSr/Cro/SycQ0YwV5WXtvPsVTMgsvqPxRQOupCzjYM4Nj1NPigNkI1qzZLyMrNitbukj1WXkqukk/BsRAdqxBxyAbhWoh/sBbFIRqeK+Bg3hpXsWTaaWpEG3ojQQk0Pe/qLbVHLhoHPlATQu5DnlEdvEqeWeHEfMFCOtcQlL9M38NaqzXpFMFeolYCamrjMtPy3cUZrjH5ummTmqGmiM1uG5jN019m+oK5iMgQ6qrZex+olJoOMRQwTUbXfYDxAcmnr4nf9DSH4FQeecbf6qqgHVcg3IT4nsQb1xllubg4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgqxBGp93kQOZw1AJ8sPzkXAmlkm3fikhrqJb7S9zB4=;
 b=fNzGItB1m6daLrSXBeGQI4gA/VzgfWYT+46EvDr9FB17MHC0Ztw/R+mp09D4cK82Ze+UVLSKqnjmpo+sashQ3x3gxbEM/3FUU9Nj3Nd1/l41AqzPmj4CJGpi2wn2PhcxPNY9oZ4qG2n0pAJ8sFSsr7UJiWqmTtESRIkaWxnIb4iqjEZ8NypSYR9I+sBJy3yr6f+jFNGyCl2FHvUg3Xh8pXx8pH+QRD1AB3xEu/9PTCmMy8f+QrV4/YpETwN1klg4K5bRvLeiOb+lPYbdjpYLUkQ1ndjZLtOdeONcXVdQxo8wU3oLzwzq/i/s96tvMSe1RfwhRpY700LQXMQhqWCclw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgqxBGp93kQOZw1AJ8sPzkXAmlkm3fikhrqJb7S9zB4=;
 b=IKV61oE/ov0A+DF+EST+G+9zpwnQ+hQ55Y/wlDBFwJ+f7CDIqrOgWlSjwJPBSbnY6lFithGIumeh0Ahsmhr4cSjVvhlUdV/jsOPd82Jd7QrUeQY+417WN0X7ZUWsSIFylVwY80R31wOVnID7FAoGpUJ0jYPUMHlkaXu36jfqZVMflpc1mCVwADEE68i7Zq4EchnSfjAMhi0nPYaPaLB/b6W0nWF+5cwFsaXl3QdqQdR5MEKuvkI1bbezAkqE0JNjiWfPqnAXoG/s+0YVChjpfo6Io2fP6GwFltMZfcIYsTGWeR71g1SahrTrg+4XbouTWzBB8+PI2bst4op4zG8NAQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 07/10] imap-send: fix minor mistakes in the logs
Thread-Topic: [PATCH v13 07/10] imap-send: fix minor mistakes in the logs
Thread-Index: AQHb1fXFnO71u/DQF0Kn944Q/IgSHA==
Date: Thu, 5 Jun 2025 08:42:29 +0000
Message-ID:
 <d38caeae5e24f5d173664db0a25003a516060959.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7773:EE_
x-ms-office365-filtering-correlation-id: 26dc6221-fd35-4b2e-f2ed-08dda40ce7f6
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|12121999007|15080799009|8062599006|19110799006|8060799009|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?WO6jRUcb2XXgK5VBmm63X0uHq/wq409c+xv3N5bfmjEAwHjqtNgbrzrxeD?=
 =?iso-8859-1?Q?kgj28kNqvhFl711R6+CyDLMocgcdsG4gEwt9C/ZEDULu1AL3ScHSQxrbOS?=
 =?iso-8859-1?Q?XciSclVrGyixYW23r9/mBEeFz8fgEJ+4yAajXCuje1dGUQn4TRdemweJ61?=
 =?iso-8859-1?Q?Gja8Cl6yq+PRn/Yn1NVKROkyrVPPxFUhQqAnALrGpTBArrx0br2zVCMWlC?=
 =?iso-8859-1?Q?xm1B6l6DRRhONJsA4GGj0WR/N1MQc98q4yBI9nT20RdsQ7EQv3VC6mVuLA?=
 =?iso-8859-1?Q?jE2hLlaY9FPQ2Yjf8uj1dVJgxWTYx1lh1UtaawwoE4Rb+apwilvcYMjFty?=
 =?iso-8859-1?Q?F5Oyofqigxk4GZLKoKdjuiRiVeTUZ8HTdZ8avchzBUC6sJKXz1d8C+QrdP?=
 =?iso-8859-1?Q?gWInezVdLThVD+Y5kryGMTrb77uwCncGJrNkVzGJuNVfyDdsif/nHs7s7j?=
 =?iso-8859-1?Q?DJuEFHeH7rZYRoVdEELV06RPX1hHCK1pG3zrhmbtgyxucAh4pjxH1IItxV?=
 =?iso-8859-1?Q?xpdO9jiI+C7sDLxZfKJ74Dot+Y7m1Kf4B/Gk1HgK1LgbRgbBfvn1SGM/Mz?=
 =?iso-8859-1?Q?OOzRQ6iNEVYH1RahNVP7fcRzLonWXCdgjhQ7nAcTJuRhwiDjwucy+pkOlq?=
 =?iso-8859-1?Q?RoyNng3Oz43+gAFS+Ir6FRzWwfCEd6yLzWRR1J2F0F4LUXGhgGAKZC/CNs?=
 =?iso-8859-1?Q?eLiL2k9UGh27VhNLAcow5dqJ35gYRbmYqASLC4na2Tnm/UsDDLhClHNDHh?=
 =?iso-8859-1?Q?zJirsZMsdol56VQCG3Cmm9xDQHa8wfLvrGA0FcKYcGp57OD94sdv/0XNvB?=
 =?iso-8859-1?Q?UosRBmD4qLNzy0cAcngoBNGFBby9D/wKAIyjq7DgBdzJDiY1CICUil+Q3J?=
 =?iso-8859-1?Q?sd3noPpfMqK3PMTkY6+jG8HlVOMrT/JUbDVEyhKmt4QlgpLJMr6d8Y8NqC?=
 =?iso-8859-1?Q?YREfROlaCwY39SYmUZx0qf1MI34a/1aP6Z8NvNDFtR2nVD3in8JMqtEW4I?=
 =?iso-8859-1?Q?9m9b3MtAyJWgCSJzVItPxFpINTYLTAZCqgc/pv8/JqQTcL2Bncp2tShqbh?=
 =?iso-8859-1?Q?M9DewIIZimE7b3BnT0VbjGWXtivwMFgBa2leym29oPu+7kU7xgntftstGv?=
 =?iso-8859-1?Q?LzCBVqoerQNQftII2eg3azk2gRAAsX+JL62lmxgCJVtypwwJC3loe9oGKg?=
 =?iso-8859-1?Q?7hRx7qOzm+PdFj+fd5cJ3Pzz5dIRstem8FK9G4LGpT4jcw9ZN+ZE7dxQB7?=
 =?iso-8859-1?Q?6rIayRfKQzo2JBj4SBm3ZFbHjrbMQ9hF2OHbon6w4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?W3SOvg/Y0HxNL6Aqk3C7M/ngR/+Z8dcv6sgLEfZBxPGP5JBCew5sy9lX5E?=
 =?iso-8859-1?Q?j3KkEWeVf+Uzg1oHLPs8kqKF/n8Ynu/STYSqiZpDWyNXEL/Q77TPQAyhZn?=
 =?iso-8859-1?Q?zqVfVi4KGLl4wGTrKzFvh4y1tIawtz6m5TpVmifHs30SgLqEKNP9SlijLn?=
 =?iso-8859-1?Q?Z2pIrCi7VhXJkijQBiqKlghAW4c8SDQdCkmA5XEntKd6wA2oJ7jpcGw2ZK?=
 =?iso-8859-1?Q?cCF+CclsglmG4Nf8jnWFrYllAyvXwTBv5OlC7Vbd+63rFExQaWNTghyKVB?=
 =?iso-8859-1?Q?/Sl+nWl80THWrTGqBhFdMVPp4t8lemOlNJ2N8Sz3LgXDqK8gWa5w98zDN4?=
 =?iso-8859-1?Q?Nxi9Zsguz9SUOuxHH56LtfGKTPJPnbrR8GKZ7gXrDsTSab6LaPGG0FRZ6k?=
 =?iso-8859-1?Q?KiW2PVvz036Ww2xXQrXjwOcNm9Rgnrj5kkvz4uq3dnodd3dX6cLVTE68eG?=
 =?iso-8859-1?Q?XH6McMtQCOSu+CUXTb5JbjRvu1PfX43UzjQgnOkB/11E+xssYV/zgoTInP?=
 =?iso-8859-1?Q?g1IG5Ik1C6Gip+TE9ye2hWBxuWHCUYyqJamJPPkYlfectAi3X1hWtCu1yl?=
 =?iso-8859-1?Q?M2i3E0qsPCsO/0LTbdC0Yv+BpEizELxJfsONDyWsmkMmzKFU7Vbmgr9crl?=
 =?iso-8859-1?Q?mBEFUtPlzkVCWmaehjTQHdhCIHDbXsjcqpUsX03+FJ5WnIZ09ZQftDLSsi?=
 =?iso-8859-1?Q?QImfSlHFX5IwcY9jfDPE+JiDxTEenxFrGqrl/kueidEW3UsArataxA9vgW?=
 =?iso-8859-1?Q?5xQ1OAmonoQrAZ5oZ4bg0f5UfONXgNtzxz2L2u8TbUWk8AjG42UQzpHlLb?=
 =?iso-8859-1?Q?lQqCmzeUMujvJ3uv/NOK8itrJB/vW8Spjg26v9GDnUWzkMVTjvZWMKVO8Y?=
 =?iso-8859-1?Q?wF1n4HSGX4ZHFNBPtrQk8qYP9Iy9m9aLpxFsg/I4/FGsd74ZmLIg2EYvTq?=
 =?iso-8859-1?Q?XHu9jvfjf7DdhUOiAinr/D1CHjQhi6RJNUUEBjKewE4nCsBp4hL/RB1xjK?=
 =?iso-8859-1?Q?NHh44wUUquLuhNtedEAvdFm7Pt5UfTKsAtIj7WYRhSLPWDqTB/pRhSx/sw?=
 =?iso-8859-1?Q?+iuhwD9IiXGw/xZU3P1AJlWbsu5VhT40g2hEcEdTqfRNBG7NzSTcmhq4IW?=
 =?iso-8859-1?Q?/sQbVVAlOnuHWYZDyP200hI7sTwpneXS0q43FKu6nz9VxXCBQra9zMp2d1?=
 =?iso-8859-1?Q?0vs54FahKzMbtak6g4JJR8E6P95z3lPUFpSk+XnP6eFibGlRqNkIret8U7?=
 =?iso-8859-1?Q?lhZ+sK3foZ1EnUXDKxjPT+eHhdZYU0cP2cG3VvU0w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dc6221-fd35-4b2e-f2ed-08dda40ce7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:29.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7773

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0e51bf2b85..dcc12e5468 100644
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
@@ -1020,7 +1020,7 @@ static int auth_cram_md5(struct imap_store *ctx, cons=
t char *prompt)
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret !=3D strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
=20
 	free(response);
@@ -1128,7 +1128,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		imap->buf.sock.fd[0] =3D tunnel.out;
 		imap->buf.sock.fd[1] =3D tunnel.in;
=20
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1147,7 +1147,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		for (ai0 =3D ai; ai; ai =3D ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1185,7 +1185,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
=20
 		addr.sin_addr.s_addr =3D *((int *) he->h_addr_list[0]);
=20
@@ -1199,7 +1199,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
=20
@@ -1211,7 +1211,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
=20
 	/* read the greeting string */
@@ -1342,12 +1342,12 @@ static struct imap_store *imap_open_store(struct im=
ap_server_conf *srvc, const c
 					goto bail;
 				}
 			} else {
-				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				fprintf(stderr, "unknown authentication method:%s\n", srvc->host);
 				goto bail;
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "skipping account %s@%s, server forbids LOGIN\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
@@ -1603,7 +1603,7 @@ static int append_msgs_to_imap(struct imap_server_con=
f *server,
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
@@ -1712,7 +1712,7 @@ static int curl_append_msgs_to_imap(struct imap_serve=
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
@@ -1796,13 +1796,13 @@ int cmd_main(int argc, const char **argv)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret =3D 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret =3D 1;
 			goto out;
 		}
@@ -1824,7 +1824,7 @@ int cmd_main(int argc, const char **argv)
=20
 	total =3D count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret =3D 1;
 		goto out;
 	}
--=20
2.49.0.639.gf77f2423e1

