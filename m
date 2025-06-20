Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE051862BB
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401674; cv=fail; b=u/ZkSd1rIAO9/RRyzivbB97OG1LV8mbCauT3CDDU0vEV/Bz1D/g/NM2EEk6pskDr0OeWRaJap3sn/5DgxbNVOZrUXwBSAUS2V1ETfiP9Uvu5fe19iWm/60LcsQjhYlcrIH1P44NKNcHeEVcnz6ottOX9AhGYZMXnF6fx08tMR/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401674; c=relaxed/simple;
	bh=HwJRGfeQQALE1ZVU7nRReEp1wjLhKsoBztbqGrMtG0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XLM2qO0sjs1IKLA4pMKkXhKjqHO+5P2f83lcSy2mvwJAYzDXjxoVxwkxfacM/2UzgmI6SQ9ynSfhDPI0maKgvHS84FZvhe8xIs5rNGFNPSVgU4REhT36d/vh6nIK/0IPisHIQ1VzBWdlewiGkaFcWuULkPW4JyXQ4WB7JpYXT0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=k8f/F79R; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="k8f/F79R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYNS2lKujrvCX7l5XeJWrISXSfgrJJ6TeQ678hzvGzbtG7PNg5zPxJOxz1+Y7Xl7vi9UT07csP5u5pWuj9Z208TRi9kz86PyNFIYTM+GbvXGPIfjlyXMOwOa+JIvVyCt4o03yclvRuQXzDE6fv8zfkMNGFoU2aC9XZpiuNAoadq2NZEv21TvQyC9DgYr2poZgZ5Zqp2jWTerg0pehUMU6YXjwtO3XkMv5eZbYu4kEwhWBtxDascdh/y9J9zUTR1D7+HDCkRr4tdVuasjLPJSn34bpeG5NBhLIXADAOaBSOIiTJq0B9MdGUoS55PkCkK7k3H6XUOoCuNINzcCCI1//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP2i+bEj8jJyG8qN66XFKNUGgrwWZNSITNUPp79c/Ag=;
 b=CW8CjDQ54nAHLmb/HQlsp0e0LPIqP4O8RrtdTGLVf8mthifISPUfPw9xxXD66nxtW/fR1eUz7zPJEOu2uQavZ952WjDLymNwtAIAoeZa5cfmFPUr9z5fx1B7qcu6r1PfnjO03aI9SYPVRvfBtzlias0TfGpKdrRaT4Jb53HX8WRO9pr5NbCytVe9NZPpGhqfQbeAAKpLfhlGsyu+qPCJwLd3GtIaf84zGPELXeCdKQj2azCjcBXLNTJbcnQFtcrjiRQO1uB7cC7HGg8kyL8SgW9XsWzbRzrSrf5u2BacZMtruMC/AXwU6q4mTdRqWC2m42hH1e73PnW8rpqNRqGa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP2i+bEj8jJyG8qN66XFKNUGgrwWZNSITNUPp79c/Ag=;
 b=k8f/F79R3mZpHx6F1Q+5yt9Dtqw6Og5EFjF8rDGTCXqb6sg9u2LU91+VMgs5tC2X/WWvID5DkMVdEEb+bTQ5DCRNvJXpDnYgCOmfpRgIWDhpwln+krrRy6GhdAO5m1ulV+xISILuo59yqsghstUOvsMtodBvvaYKs+xuI/LBbXS41FahYbzbm8HLyfgvPjClt8FUc9SBxkcNAsOMTd1RaajhFZfKdIGpFfcTeyCv7U/4CdLCTC6BrtZdvgsMJWL9lho6a+1mgI+hDacF0TZpNpYUDKPOkb808xbf/Sp9KQCd2FcIQAOSbR5IaiQT+vHFnABm9Zp6IAxOUjezFsS52w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8150.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 10/10] imap-send: fix minor mistakes in the logs
Date: Fri, 20 Jun 2025 12:10:33 +0530
Message-ID:
 <PN3PR01MB9597C69D246A7D32200DCCF5B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 215e3c57-4533-49c1-b983-08ddafc568c5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|5072599009|8060799009|7092599006|12121999007|15080799009|461199028|41001999006|40105399003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KvfXhRcP4xRVJtc2RHYermjyU/WRypYVvUUdrfYy5dMcx2L1heubcJjbNy8F?=
 =?us-ascii?Q?LoqcI5TRBYgfi/pwgQaoybe9FHz++CiaxmyxzzixjWf4MaWqVRAo+B2R7v9L?=
 =?us-ascii?Q?1I4KqAzYMTc0w3srnibwfPfb/syrYb5HpGLXA/qR/rGu10Masp/SGEJO8KHD?=
 =?us-ascii?Q?j6EGd3N/9U3ExFQngQhXe5Z7Co/+QmtDNZNgLc5EDRynYaUObHe72uDk/NR1?=
 =?us-ascii?Q?mZhsbv52N8be+Wtja/RYFUjooEzQc86656WHZuYhaNlbOSq1nENuFb+/KOuw?=
 =?us-ascii?Q?S9GCjVSOQ1Zcb4xFkBST3t7RBtTUpeUPayDXKgoQ/4SU0+czvK7FaCidFy9E?=
 =?us-ascii?Q?xjPwRYF2saybSgrts0OWpGmZciC/giOKEoSV3DWlLddiE20uRoaXU/Byg3N1?=
 =?us-ascii?Q?QAN7rv+bUQh6i6IbKZTRRsTkx7CsqgZmZPTEGnznbcohyytGWba/GbF267mp?=
 =?us-ascii?Q?2VEAsgaCRqQuqIaZQ2NHE97TD6LJACBf7GhBwWxVai5n26h1qR7CWZfppD/5?=
 =?us-ascii?Q?CGG95EUht0S7VuEFCzKc7k5GFKAU1R8qCIhAXZFKXJhHyYj2kOME1yj3FUSH?=
 =?us-ascii?Q?w+P88ez+cwgfZqxgYnMwE8iL1yzu1GO4roivqgw0qHuYbSNk8ugtvufK7ag1?=
 =?us-ascii?Q?MZRA6sCa2X9lxuzXPLeKMgmkjdIXrBE7qXmaqpnEzHtU72lDWmCA4sp5d7kH?=
 =?us-ascii?Q?S4ZSTluoIwn7HJigS4ps81pmtrJ44HE+cGv92EI8pA5OPzQVHOpZMY26IZ3M?=
 =?us-ascii?Q?EBfxTwhSuc6FfUjM2xplvo4rnobyqQ+HydWkDtT9TzQ8SvRDbfDMFgQkNQEp?=
 =?us-ascii?Q?NNWWVpoTWSD5iyUBM0PVqD2paSb0vXXwvf5QKpw49aLK5QvYTj2y5nxYDCjE?=
 =?us-ascii?Q?H1ZUDf6soiMrMtSSEO78PB0xFUocJygCfTx/x4gCwUCJEDjK/6pPWkdAbfTW?=
 =?us-ascii?Q?QKvvxtQXiyOXbR1aNEoLxBWJ6cQcS21uDcqb5tUmhYZFgjZpmFcOwg8OHyvL?=
 =?us-ascii?Q?oX56q0mGjhFjQW+bcphlYFMfn4cGIcvyTD+VbNEHKTCjXJurTushxN3jsB4y?=
 =?us-ascii?Q?Klze9I3lvZDA2VJeDmg1ywLBjr+a9I9yjkLuW60U/bWFMFdNrRPWP+9X2ICs?=
 =?us-ascii?Q?+CcU71efPNyrlDLkfH6p8NsF8SQBgh8ugCC5hdBZnKcwsIoXZ86n/vGqfp0B?=
 =?us-ascii?Q?ByPGTtEp8ER8/KWCiSC8+YASzbE9ERI24q6h54cy8TLIfosblApGpUOP6LA?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oPy3RiSzhnreui/yN01H7Hh/yFoBCzIknXLqB74qTtSdF7OSdJPJNO7cQRag?=
 =?us-ascii?Q?NNqivxxmXW6HjdmirPjF2ysrcRz2vSVbY7E1z3yuF4YM7ke4IwJqqiWa7rn8?=
 =?us-ascii?Q?V4ZVUXcKXwF96suJT1Xcc5F9ALq2N545kxKVXs6kAgAZv/eRWI05+HYvQm2n?=
 =?us-ascii?Q?BU8uoxBHFvl6bEIZZtriVcOz/a1Tqv2gTB6LP6yXyuZ73aP2htglN+mSTuXf?=
 =?us-ascii?Q?tuYmi4EUM32f9uSKrY1Nu8TAtysXTNrb4J/yeXM0SLJ83XkZ6BnfS8n1R9SO?=
 =?us-ascii?Q?H01lRwrXiL346w48xLXCudMeBz/u7vEh85q4KIGW9+N0yco7KRsm3YTWoqVU?=
 =?us-ascii?Q?gc/lgUHT2RpPI0TIGeAd95n7urNh9bAMPppJKVXLJnzDS6PfjIGMYo7XTb97?=
 =?us-ascii?Q?07bCLdff4API/FvdT3x3MnEBAIAW2IQS7P2SpiUlooeAy+KgnNf03k2JZnI2?=
 =?us-ascii?Q?DlTwwOOWk9ha3T4j6Yrt8lqR6OuV1g8NrFiP0/9DxhrLMQvQPnqGKgKhD5dc?=
 =?us-ascii?Q?Pp/4EsNuXjNIMZz990ODUbI0PA1kOn3COsUqxaO3iBb0Pu2JyCWQsO8csiv7?=
 =?us-ascii?Q?iMt5bjbCozekD6B9qtL7ir0OLtlOJL3jbTiiSJT7h23d9yKkVbm+bDfG0t7d?=
 =?us-ascii?Q?j8ejMG1QxaFFTwyFajiwa3AVbiPLNmjTIxEuCJfSFHl/QOn0dXZOX0IvBCcS?=
 =?us-ascii?Q?lQQ0wA2Dfbe17mjPfOf0J1w76LpGBHMGug8uFqOSnf/ArwUIgi2k0HDhIDPu?=
 =?us-ascii?Q?JygP9uUC5NEcH1mgAvSY8YEClKUXbrm1s2uVSObtBYgSJtn4VQkwPPsxhSQX?=
 =?us-ascii?Q?qF/6OabER85L0hYG3U7p1VI+njAUBnLKyprBRA2Yh1olOg+UAwBXYkv2gWH6?=
 =?us-ascii?Q?BqG3Tw6YZQQ46G5DAQD/yzSrNftI9RUnc+RUyoAt3ZHNP1UpmvWiit2NgmKg?=
 =?us-ascii?Q?Qdy7+OkBEA3sTbCz4tsZWOFI7MWZHSxQiACKgceCJe5Y+XfFrP95PA4mjaA8?=
 =?us-ascii?Q?4c15ady0KPNfuC/t2WMbld+umG7f1StXq/xf+zHV/MBIbyEL1BME4fubJpCp?=
 =?us-ascii?Q?kN399gvvLg/hAsfl02tcqrX69lSqbZsz7j3hrVdxOhKttOO7Q9DtPmTh2N0X?=
 =?us-ascii?Q?DXdFGy84dBbFaptfUS0lKEe5InPFN9TGC+x1TRDzQIltdiTWz99jHEQmnYYy?=
 =?us-ascii?Q?R/cJxkmJXBkDdagWDRrkM/4kfwuvyzeG8e+WeldEQA3C9GO3nwRvizNf6/T4?=
 =?us-ascii?Q?234P+hbMiqq8Mzn/+c3w8L3MOaWD2knKSWvL2XNoFtEHEZ0ZHo1HpH0L/X8o?=
 =?us-ascii?Q?oro=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 215e3c57-4533-49c1-b983-08ddafc568c5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:56.1248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8150

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Abbreviations like "IMAP" and "OK" should also be in uppercase. Another
mistake was that the error message showing unknown authentication
mechanism used was displaying the host rather than the mechanism in the
logs. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 11a19ffeec..603e3d6fbc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -211,7 +211,7 @@ static int ssl_socket_connect(struct imap_socket *sock UNUSED,
 			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
+	fprintf(stderr, "SSL requested, but SSL support is not compiled in\n");
 	return -1;
 }
 
@@ -1019,7 +1019,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1159,7 +1159,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1178,7 +1178,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1216,7 +1216,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1230,7 +1230,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1242,7 +1242,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1295,12 +1295,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 				if (try_auth_method(srvc, ctx, imap, "XOAUTH2", AUTH_XOAUTH2, auth_xoauth2))
 					goto bail;
 			} else {
-				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
+				fprintf(stderr, "unknown authentication mechanism: %s\n", srvc->auth_method);
 				goto bail;
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
+				fprintf(stderr, "skipping account %s@%s, server forbids LOGIN\n",
 					srvc->user, srvc->host);
 				goto bail;
 			}
@@ -1804,7 +1804,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret = 1;
 			goto out;
 		}
@@ -1824,7 +1824,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret = 1;
 		goto out;
 	}
@@ -1844,7 +1844,7 @@ int cmd_main(int argc, const char **argv)
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0.824.gcc76007b2f

