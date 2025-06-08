Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B45213E6D
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380242; cv=fail; b=XBK8YPtQi1ZB6CrxRFMp17iwtZp43E5HdnruECSEYCLyb0CjzVzH5eszL1N4ZT2Rfymrd4vZ/lovp3RU+CYystcvtyWlmcz8qkxypVLcnBNx2nC0Npld1pbMHBEyzLXvLvxflqZT6cpq3GlMsHslotiLtnzptcCsCDfF2HALAYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380242; c=relaxed/simple;
	bh=8HIDF/+pZ+rhOKoWEiqsJiKTbKrHz0+a3DXtIr+zWa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d/sAuuaiNkZJyof+vsq48fO9HyZjYtsKTW4id/wmkPpDgA5Fvot2g6VZSSah1mrPkkaL0xhXlBRCF86w/p3hHEMeEQDHXjim42WoaC/v/ho3CH/2l/IO6vid4nvW7FtjzKLuYQ0daHd07VaPLvGkAZEfH40Pkm+7K+a4ThxTIRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Jd2f5BgR; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Jd2f5BgR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOV5xcEFpHRgWsqfjfEyvBtfcmnpoUiqK78e2gjdgG2tGYWPTRjtDrwP0prCuzLGy0zr0/mfWvDa77Arm7cfj+HmIZhCo2ahpMO7wqCQRkARKeNdaYc9TGtIFQ7z+S3knSsSxgeUEiBBeFTZc64BFiz3zQywKhwIhK/SRBeG4pK25Kuna1NCvloW+2pJc5Gi+aDYwjQBi9QarLOb8JctB/p3RO+nZdAvQpvYT4tUFcPto0QcCnQZynwQ5KuRoatlDlLNHs8Zdnb4l4fg1oBAW1u8/EgzghVNXKIuqAmeM6ON68HoRhfzrfQt/Tdcom6tL8oDPx5Gyp+C4VAbBRRFhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylrzHANaOSK4H9JBIVYzREMFCTM5ER3rqbNbc7gbtCU=;
 b=aT1YVRzGocnj+V1IulK97SxLME6M2lcqUfAYP64qXinyKU3QIcHRduVBPijPV7l3qoiWtdWQT+wmXm5Usq/bevA416a6gcndsjv/JDqXkbOFOVQCcEzVK+xPg0QkjTzjYo5/iKo95s7Lj8b7Vml4Cg2Go6f6yySk2cxb4YHBEpThM2uWd8M03unqmEFma3QZD/vuQkIsDTw0g/He+Nk1ziI6o7Y5oVtJvJuAXaDSrMa2Pnda+jwYir+FiiUswoDINFcLNqHw2jfX05yMQsrOYI5971ZOIlKCRv42TcxhxE17HBUMDYOixd2zHEJSeEo/67egftr5ekME7EivqO75bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylrzHANaOSK4H9JBIVYzREMFCTM5ER3rqbNbc7gbtCU=;
 b=Jd2f5BgRN53zk6C+hyPyJsftTmRleZDDoRh7lbb5UFk3G0N1tNVbNKEWQ05La1vw2+iFBMHH61ke8OKytXuRIKPR+QcOWs4Q5eCco2kyKkD8Ed6ybGkH3e5CIqAWVgnTAU6EjrXqPJDYgGWnh/a/6znZ+cQJQlN3JP4sViXqia5xKFjd2GtItvZspcrYvPbcn792+jY3KOnoBp2wTsRCRlhAAVpFDNRraoUgUg4zbMaaSvoqRxJmyKZ+Q5zgSPg+ZtYwzOU75x7YW4gF4lqRNNufmVuCJA8vq4cEXASv0dNgZh5LjpZPEdUuRXsNscdBqj5fDrEpWNpRh0+SfHvshQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:13 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 07/10] imap-send: fix minor mistakes in the logs
Date: Sun,  8 Jun 2025 10:55:16 +0000
Message-ID:
 <PN3PR01MB95979FCCDB31EB3927DECFE8B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fce3da9-07f6-4cf1-dfa8-08dda67b3776
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999007|8060799009|7092599006|461199028|19110799006|15080799009|41001999006|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qic3z92jCTyd9d9OsiHoA3Vdtm4lXQA+QJu4Ywtu5tx1QnRAJNgBpZ+5R2li?=
 =?us-ascii?Q?PxfsNlTpoiIYtGUdA6LHk3f2hlZgIKxDr+ge2ek6vLkzF9EvS+Pk5RL7UVH+?=
 =?us-ascii?Q?K1HRRypwHgH5LRvHLI1TdjzBnXsUybge//NmT2gio5XlE00yAiz826YbdIFx?=
 =?us-ascii?Q?r8458pfGEVjlup4TN1elr9nNMax72ouBQey3PIiF8+EUpfPgTpFzYYVGj/H3?=
 =?us-ascii?Q?7oo+qdfDUV4a/9reMhRNxLawFRFdVGgQxZTVWKvICm0kb9cwxFGVlHGfOMNw?=
 =?us-ascii?Q?RbRC4e/GQACGmDZKIN12kC/K28vtsRBr2DWIMFC+sSJLQsJAsmrgV8hXNj3d?=
 =?us-ascii?Q?r7Gevb+kR2IjyCvVxNNCpQKCFZORWWQm4v4LyhJxoBXUnA7A5z5aL+Pfzbme?=
 =?us-ascii?Q?c+qtBxAK8V0VXBHGCexV7auvu5h/zjAVkvRJGEZXvPAKwqOxBVZsxD/sHNcx?=
 =?us-ascii?Q?jUsWH/vyglUiRfmV28JVgvZ+gBC3j2tVXJq+41Er4LeG+jZxFdh2IHLda5I/?=
 =?us-ascii?Q?0Xz9rcnzd9uY5odohAiC8UqGG1iKX0JIVcDpgqTRcSHY9rBKLA64WwHxPVrM?=
 =?us-ascii?Q?Fv4YLNGJZ4XpbiD2tdCJ1tKO/wuI7qSgH8+Vnr2qX81UED8OdN5Hq6HB4+BW?=
 =?us-ascii?Q?fZyJ02yptLVFuspX8QrgUwrkiotTHfnOL3jp8lDrDgHvV1PTzqBaQfg99xd+?=
 =?us-ascii?Q?+QTbTbEKorOIjEpyOzzhW5yl80LZFfApV8t/DZAFDDZ3XCtHZ8yz1qwxTk3u?=
 =?us-ascii?Q?jpPpKlVtmL63Xo9xDoYDE0SvTGYgBUWN5HJoGlyz+/+Z8q3zYHQNKVImUBbh?=
 =?us-ascii?Q?m665vHl5LX6Ic17LpwLwnN2xLM9G/90dzXrI664vxieq0f62hIgTBJkOyQxm?=
 =?us-ascii?Q?Kx33KRWsLRi2XxrVMJFUmeyF4EfXHg1rn0x7fS7k46z3kwOufvsECQndekuk?=
 =?us-ascii?Q?QmM7s2N7oqe01GrPcdtZ0EkPRW9G4Qi12YqxMB9NUFORLFoYxKCiMDDhHD5e?=
 =?us-ascii?Q?R+Qgf0qESw+98RszoHNdBnYqxbC8Gz/m7DBmz/gLbKU7k8d7kQ2PC6hX47CV?=
 =?us-ascii?Q?gx2POhaAWP6YWJ3r4M4liH9VhKCWZT9CtBy6mroCrH9SyMuiV59A6Iyq+fly?=
 =?us-ascii?Q?VhMIKJuhjkdH9JOw3yIpGPzQsmUaooU9cUj0iwsfpY4p8TYIbTiLrBuYw9Eb?=
 =?us-ascii?Q?m+29skTMWCLHK0JWaD+Vx1l3WpZtN6ujtG/NBA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHdyLdDjX4ZaBmvmAut6ixr+GkryJNsKhu3v8h59z6yjzAXwmnp2oK8f65Bl?=
 =?us-ascii?Q?Y0JlzOTe+T4BLp/DRxn4ZO5w8yakx+fONl5MAd7NLZW2ftrRD2hEP0sfY85d?=
 =?us-ascii?Q?uY31QkPlhuM9ZVwlm6i9IfNuWatn6zrtjd7znJa3hLCds0pPMx+awpGPKFIh?=
 =?us-ascii?Q?GFkdDXQVaQYeH7IXV/UbUXeTb1Sy/o7xsUwsLgRbGUk4YBcxDcAzx/My6gWk?=
 =?us-ascii?Q?XVB0Pp0pz/MstOWg4y3Gx4DyJe12Mts6Jxh/7/qjpW2rscAsnOIz4O26bK/6?=
 =?us-ascii?Q?IfiE7WdPO9vcTCQWu27FY33I4AeOJZ4WaJNdKDBaimwORmlXoxcJ48UnYK7d?=
 =?us-ascii?Q?19IjLl0/UoC5z4CxOLndoGmi+jv5IMA4JPVlW0aO5XNA5ZYT/pbIoYEGwYEE?=
 =?us-ascii?Q?8pO7kkORS9mzVHWtURkLKQjxRRrL1XTmy4fzpzwAFqlZ3QVtq2kFdkXEpNMA?=
 =?us-ascii?Q?Oq9rnR5n8cyFtUOgNFue7BZ3cNAX5EkZG47Oyrg1m0qr/W7gKYcwGbKAoDwn?=
 =?us-ascii?Q?fuPcqdh1JcPqrHf6ByXw6QonBfNouwfaHaxSD9TzA3XnQbLPQnDm8TxL8gS3?=
 =?us-ascii?Q?dL7KUUfwWjOy2PWZOzab1/gsKurJ40VBGC82JZ5LO4wyAIp8WheF9IYUhpLm?=
 =?us-ascii?Q?K1OAM/1R848BBx5QDryXliHwQMWaUh2TZS9HBQmzAnihCfnf9+A2DlelReC7?=
 =?us-ascii?Q?xJ3fHXhUHMYcDpmTIBP70vKsNhPnlB5SFcNotG5yd86iJn5mCJ2io0K1NLyD?=
 =?us-ascii?Q?q1GICTk/KG2xzfZ0GGj5n6ddvfhpMZSCP4v8/zTYson+VpUMETUkYSx+bT4r?=
 =?us-ascii?Q?H4VZn/YODfmlK457+26GelxTPDbtGuW2UldkUfxcxuV5UrQnMUtSGGNDAJjm?=
 =?us-ascii?Q?VR4Q/1FVQ3HDKX2Tu+dEfUJpgyoJMoW4jirCrLsBsvsovQJKZb+Vnan0oh4w?=
 =?us-ascii?Q?y5GA6jdfXywg3B9HP5OOU2njFFtjWUfwzaaeoMXvl4jUPb9Iysmp8j8kZtSA?=
 =?us-ascii?Q?FNUF0enzBE18JsdILXrJAbnFxsRVk7xELuO30bkhqWZJO7KGzgvD2eWE7fUx?=
 =?us-ascii?Q?Xybr+B3taAVYKw6dZutw7j+fIJJCn0/tt8acasIcF7umZea41YwRKIKoB9HU?=
 =?us-ascii?Q?yA8MX2lDAaHMsmGYRQHKrnbHp2PszHXTmwPODQ8HrjAvWhl77zM1oV2mmtH+?=
 =?us-ascii?Q?4UFIFLlccuoEio5Qzj9idxRBhyKE0o4DNVgguqIGP03iEdKEy69tXcdyChE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce3da9-07f6-4cf1-dfa8-08dda67b3776
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:09.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index a4cccb9110..a9dc6cfad6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -205,7 +205,7 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in\n");
 	return -1;
 }
 
@@ -1020,7 +1020,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1160,7 +1160,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1179,7 +1179,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1217,7 +1217,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1231,7 +1231,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1243,7 +1243,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1296,12 +1296,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
 					goto bail;
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
@@ -1557,7 +1557,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1671,7 +1671,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1755,13 +1755,13 @@ int cmd_main(int argc, const char **argv)
 		server.port = server.use_ssl ? 993 : 143;
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret = 1;
 		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret = 1;
 			goto out;
 		}
@@ -1783,7 +1783,7 @@ int cmd_main(int argc, const char **argv)
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0

