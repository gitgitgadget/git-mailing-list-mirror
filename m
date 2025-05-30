Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E430C23506E
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626380; cv=fail; b=f0mjMXBNddqTFB7jeDdTZIXnNfNJhVtSw3oC0PoLvpUtyo7YzUIydPJlPyqhShLSco5002D1qRrHi9AJA+H2hUL5YA+hdoj3l1iAyU9DRkg4ryL0OzKHPUD/5Uvi0pWgrHCCfwHvMr6g56DeY/OiPoy5rUL1aZdoIq69S1zengs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626380; c=relaxed/simple;
	bh=eBZ2hhuTIB4fRt3NZn0U0a3uB/ce2aoodc8fH0e2WF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZwivHo4TcxaJS6Oq3RT2Tv7QKNeZo5zC0hNJ19+OJAlBA1mVj6XHaE98eOxLMsR7K41O8EzQROQTt8RAMzA6SR+Qs5H824v0UgNUu0MiVEyRjxHxDtvCwxG/i9+0voO65PV9UBMEOQKnMqOtfgVn+zJTJRWtYrd8OL0Uru10saU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=FFGNKCKC; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="FFGNKCKC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCm/i7Kh0em5M2RnBpFKa6c+YMnl2Ub5UsQbqDDPWO6gGsxOihmMH1mecqWDfOni7gHIwmz0Vdkw+kkMdTS3f510CSK9kzTvfHW2oVhclazEZOfQkiBc4AcUxWxcbBltxgaz6ZYyPFthiMt9x/SM/NDoSBxwuBQTCmMiVE3Bmeue9H72yz3K2zXvUI98q7/hjHL09pU0mmZ4WH+qfvn+N1AOAjRZ2LFABWC7of3kFj2guIl8GBuUIqFkl+OeUIHVxjPUAwdchlD4G9D+yZ/DBw0RbpjUuJZfiab88wrLD2KyyVkh5q2wXCAcPMepa/laAAAlsgVPboO1B/FhMrJ2ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihRcDDldTRvk7boBTMP6fgOHHMg6QgjcEibCy+sdtOQ=;
 b=rVrhI0WnI2QQezc10ox7m5P3QxboTlJOZ5cn/aYzowW4wFk9BRL1f7j29EEja09WMw+w/mIoEm1JF3FQG+6LqBmqG3JJWKHEB4qir0S30rMewR7G5gpmITYRXl9v6JfQQwU4JsbbU77pIIXLU9mK62pCt3lYQzpH4NnNVywbdLqF2FB77puYPTRTcY6jzWs43QoHv1w/vr4bUYcDTPXkoyrBZefEDca5JSeZs6N+2hu4LvWaY1/gwnPiLV60LAmN/Q1MoNgBajD9JIPfUnDkuCLAFHLK+MDjOJaq90NqfMz41ryWylvmHacin3xfzz4Gk4rsGuBQ9v0RskF7JhnrRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihRcDDldTRvk7boBTMP6fgOHHMg6QgjcEibCy+sdtOQ=;
 b=FFGNKCKCWQ3OB5WH4y3iBatilMEcb32enpQD+0bthtxF6k2fPaccpzozaxGATSYPlVNtCiuFdaklp/SzraHCXhpZ9bQr3c9nt6GDDe44bBQWeLo4i3bdAIREu+5cAf+fDYnPiURgXjUzfulfKMbKA1HfM+zzzltqOnkgjHnA0OBXl6p+1eG0106xwQUWINGS+kcsrpvuBeM+JYeLiHIve967DEWwa1bXsp/gAKg7L36Ew23PCNPFBkv18rEqRGqBlmoW+GaLvOUtO94ijjjLZ1dkYd/mdoolDbCInuCDx24gXUiZ6/oNng46WLAueCwO0rgiIAAFcXDS/VvZzERZoA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 6/9] imap-send: fix numerous spelling and grammar mistakes in logs
Date: Fri, 30 May 2025 23:02:19 +0530
Message-ID:
 <PN3PR01MB9597BE246D115B06E3CC2373B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 628e2f29-c78e-4506-d9a1-08dd9f9ffe92
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|12121999007|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CxCBDvHJDwXQ2Oh+3qmfzgrhl8HJGFAidjqnsAyNBJY6WKeUt5EZ/+i40x3I?=
 =?us-ascii?Q?+Sf+8LmIdTDAoprc7ErhTB3+3tRDZ7+T7nbUmSFtVtuUzaVxAzDDoFyaSOZk?=
 =?us-ascii?Q?8Y2GyK6o64PHzQzBQfXkbcHdton41oOtzbagHNvKZiKG6OoHSMEa89CfHgPE?=
 =?us-ascii?Q?4YO8/KodNjPqgO97strkGzB4JOxXlJVRwecS2XCw6quK7gqlps6YKtTny/mm?=
 =?us-ascii?Q?mFouKMuZJUm6j0ujoApjbqhKxjYwD65GwK0W/s+2jwAfRPoZrJHAQE3KaYvZ?=
 =?us-ascii?Q?LK2PHnvxQY1ex4W4ho/w9evJzVOdLIoP7WYlxjMDZn+CI4F91mGDLHKx/lIC?=
 =?us-ascii?Q?hBxDs+0u7nXqctmKp9VSrBc9sZUov/bMopyfiz0/m/rm+b9sbz/rOjrQR/mo?=
 =?us-ascii?Q?NyZlrnUK4oC2xawtX2aLOWdZUQb00CFinqsuiWro+Zu2NRTlOst7+QMikBtg?=
 =?us-ascii?Q?Wt4lNEGlWTpopJV4XmqWRlowe6GpWvBS31IXDv87gMUSErA9G61qgWb3vM6R?=
 =?us-ascii?Q?Vupx6Yda1DVt9WG5GzgXIwumy+dwASO+orGWCJJbxut95Ucnu9ouxOrwC0rG?=
 =?us-ascii?Q?YqPWYfzXrPx4eS7TFkMJJK62uTi2MhOVoLSIoe2bgM+FjG6X7VrFNdKNZ1vN?=
 =?us-ascii?Q?68k0MJ6C0llEDT3fTACK8Ktl5jcnCR4LMQH0JBR8UdrgZ0NwWGKrJtQDjjU3?=
 =?us-ascii?Q?GoM6j2D2egkSIiC8gRYVXUVAS8kOgV75pQ8RfN/eNeLgVZnD5wpcwcaOXpIm?=
 =?us-ascii?Q?wizm/+mGXQlWwdY5pzXlWntZhsfl5duuKDZCFXgfzhlV+4H52idLSCY3jOOQ?=
 =?us-ascii?Q?seQmS4QeVutgmODqaL13TK/yTg956wOjjJV2aCqSEf+Kpta4ka9A+5cjvpS/?=
 =?us-ascii?Q?vlD2c7NncxkqxiZNNm4li6EXnNnLDtd+CrqrGJVUNBvgcaUPMJlfa90mAikr?=
 =?us-ascii?Q?vW1/FXFOIq3hswKocEFnD5qncc9AHSARUq+vfJRbdp6yxumi7xO6kY0jGkQV?=
 =?us-ascii?Q?SHZVMCYqhwFQECU6FdqaQ3NRwltCbFdqD/vtalcn8lFyBJcp++/D5PFezP3Q?=
 =?us-ascii?Q?gCUlD5YRHG2LTSr9RlMyNyqQMit8LFpdtmgo1wbRvwENSYmeyo3+PaeI4Qdj?=
 =?us-ascii?Q?8dm5jKlIIJeX2/FjkvH1FuQhnq4K5qHGzniCwz1QcQUvD04hk6PXHSB2B8Sl?=
 =?us-ascii?Q?g2F5QZRfhc+Rwitqfrny32agg8SCyo4RG7ZU/g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S0aDUazEo48MpNTYuskiNZDvW+PaDNULQbanEj77ky4WSpXBXu79GX7pxGuA?=
 =?us-ascii?Q?goblt/rpZqCETR3413NtFTwGoeYVMJxwkkML97tOXrWB7V0rJCQnEQrXTcIM?=
 =?us-ascii?Q?dUy+9Rz6EJifuIFOu7/tjmSAIkfV6IHmLGYvRLonbTaYvUNrtSOzPBPUakQK?=
 =?us-ascii?Q?sdRSCBNtkULnWJMUANdvOk0vjHNDKTr+AicBxDViIO1G3Zqd9AP63ZaoWIDh?=
 =?us-ascii?Q?GsT2nmIG0DxMZJxkckvYxZaYuXq9DipmoZo4qcnhQaO3JrbBEavM7PVXDSld?=
 =?us-ascii?Q?vPqtqk0muUJsREGildxi8vQIzZAwNKTIkCr8CfzdpNErlJt346JKjoECaVsI?=
 =?us-ascii?Q?OBL3BuI2wmHv/LaCruVE8xVL75imDUZ11iZ7ZC8Ae8mP6TcUjCLtJ2ZZSVcF?=
 =?us-ascii?Q?9u5pgxUyOnhEOwG5z9fQbHKKLU2xXNMdm2pz86uZ+EKPEt8IBFt1bPCOh2BX?=
 =?us-ascii?Q?8JkUCSJprCFljk3Nenl6ltqZPXxE0iaa1F6WSxMClTDrpIkMd19piQTeKpm/?=
 =?us-ascii?Q?GmcZbPA6jhkrk2n26zf0Q+F5OyDxbLU5y7HB2NxAfqLJQDi8y11pvzadNg4v?=
 =?us-ascii?Q?lP/AoXgf7D1JorlUON8uaDvsnhwdjpnYXoa5fMHLgOjAdgu7ivY5ivmPlthD?=
 =?us-ascii?Q?X2kREXNFAq/TMtKSYYlrZ/jz83c5F2dnMeLJSr0Hj8PlV86DDJIgznuZfDy3?=
 =?us-ascii?Q?IsTV0rB1WYvsPYapk+V3z48P8cgBbDdyNPEpobB5V0CjH2CnYwmSRtKy3j8z?=
 =?us-ascii?Q?we5w1ay+gE8PaYpAP2u4lGMDLCRhzkXpZEkP97/aZK0O7jdn8fuknlfS6opq?=
 =?us-ascii?Q?ITSs49cWoPhEVeMVSv06EqA69YMVJoLMpI6K8WyIVK1Aor+OXbXg8shCZoiK?=
 =?us-ascii?Q?N03VMoS9Ks1UkDFIX+YhKyI+Ul15bo9SA8mavfZXPl3EQPZ2gIROzY5ESaMZ?=
 =?us-ascii?Q?fOm/miV9RsXm/nDDc83ghq7tLTSkkNyn0cafI8WIRVA2Ca/UM729kE69rUb3?=
 =?us-ascii?Q?stB4nfmWKG62jVdQ/yENPmh20Nv4ppBpFY089NLzrVrDX8t0tPc23lbUzLxy?=
 =?us-ascii?Q?33sqnYf+DHAM2p+zXqIdf4MalwFhHfQIsXN1hf4fskaG9eEnc1xiSpPVJnwu?=
 =?us-ascii?Q?KhPKj02zvIQo46OUaPg9eZ8fNDZQAwBRlrD5S/PSnoi9hRxn+XU6vYz9STt3?=
 =?us-ascii?Q?+dt8p7OuXwLDtQfxv8+IbHOSS3rO/djE3MWEKJZ0HD+s55Szz+03h1wFIqj8?=
 =?us-ascii?Q?4QUqG8vSrfNiWniIUpEdnEX3QM89iTTshtiE6tvWhRxoEqbVZH7UOizDKSn7?=
 =?us-ascii?Q?VaFV4UYfPl0j2MsHCGdHA6db?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 628e2f29-c78e-4506-d9a1-08dd9f9ffe92
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:47.8847
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

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
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in.\n");
 	return -1;
 }
 
@@ -249,9 +249,9 @@ static int verify_hostname(X509 *cert, const char *hostname)
 
 	/* try the common name */
 	if (!(subj = X509_get_subject_name(cert)))
-		return error("cannot get certificate subject");
+		return error("Cannot get certificate subject");
 	if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeof(cname))) < 0)
-		return error("cannot get certificate common name");
+		return error("Cannot get certificate common name");
 	if (strlen(cname) == (size_t)len && host_matches(hostname, cname))
 		return 0;
 	return error("certificate owner '%s' does not match hostname '%s'",
@@ -905,7 +905,7 @@ static char *cram(const char *challenge_64, const char *user, const char *pass)
 	decoded_len = EVP_DecodeBlock((unsigned char *)challenge,
 				      (unsigned char *)challenge_64, encoded_len);
 	if (decoded_len < 0)
-		die("invalid challenge %s", challenge_64);
+		die("Invalid challenge %s", challenge_64);
 	if (!HMAC(EVP_md5(), pass, strlen(pass), (unsigned char *)challenge, decoded_len, hash, NULL))
 		die("HMAC error");
 
@@ -1050,7 +1050,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1144,12 +1144,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		tunnel.in = -1;
 		tunnel.out = -1;
 		if (start_command(&tunnel))
-			die("cannot start proxy %s", srvc->tunnel);
+			die("Cannot start proxy %s", srvc->tunnel);
 
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1168,7 +1168,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1206,7 +1206,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1220,7 +1220,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("Error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1232,7 +1232,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1340,13 +1340,13 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
 			if (imap_exec(ctx, NULL, "LOGIN \"%s\" \"%s\"", srvc->user, srvc->pass) != RESP_OK) {
 				fprintf(stderr, "IMAP error: LOGIN failed\n");
 				goto bail;
@@ -1591,12 +1591,12 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 
 	ctx = imap_open_store(server, server->folder);
 	if (!ctx) {
-		fprintf(stderr, "failed to open store\n");
+		fprintf(stderr, "Failed to open store.\n");
 		return 1;
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1648,7 +1648,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
 	if (!uri_encoded_folder)
-		die("failed to encode server folder");
+		die("Failed to encode server folder.");
 	strbuf_addstr(&path, uri_encoded_folder);
 	curl_free(uri_encoded_folder);
 
@@ -1704,7 +1704,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1788,13 +1788,13 @@ int cmd_main(int argc, const char **argv)
 		server.port = server.use_ssl ? 993 : 143;
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "No IMAP store specified.\n");
 		ret = 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "No IMAP host specified.\n");
 			ret = 1;
 			goto out;
 		}
@@ -1803,20 +1803,20 @@ int cmd_main(int argc, const char **argv)
 
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
-		error_errno(_("could not read from stdin"));
+		error_errno(_("Could not read from stdin."));
 		ret = 1;
 		goto out;
 	}
 
 	if (all_msgs.len == 0) {
-		fprintf(stderr, "nothing to send\n");
+		fprintf(stderr, "Nothing to send.\n");
 		ret = 1;
 		goto out;
 	}
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "No messages found to send.\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0.639.ge2dd5d9d81

