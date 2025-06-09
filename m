Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D0218585
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483775; cv=fail; b=a2giUEDQ7VeaQoCoW696RHiDyPeTES1uhU3beEcYs19DQp7bAss/Hj6ewuWs3HcfoVOwoOEw4Yq2vcynwVB04T9cZBYEpbu4AaJHFkLVN/0k2/V4NPekp7qKjuqc4QZnbvjUDybP5FZQuNrYOuczY/aLSkUl7wSNz4x/SC4g7ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483775; c=relaxed/simple;
	bh=nyA7Euc6wBaSXG3mHUC8L93KJbnVG7DkL3OjHsI0Vmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PO2z2imO/yuqVEVQxmmtI8q6h6bTQQcVW/GAo/utGIbhHb6R4PxrybhTdDsFkYk+1FxpyV5HuT4MWp3OkWBzhsBJxjgQwOvh9paZpDHwtilAgiknpbp4Lpvno6W7towUYXJ6rt0TChqUtUvoTCeygE+YhfFP//B1aHlJPvHT/wI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U9l6xf8C; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U9l6xf8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KlEwh9QmkceSZZZYWrYPTuYEz+5IqIiGAj/IqDtVm3BuiPTjEbS9uXQKK54UF4mrLt95DjzQ6y8XomHZ/KL3ptLQ31duSv9+puKdFe6djnp+UjWQFYXPnFeG08qfHY4p/rqQygiuwDAEVaoFSHgqTT6Mv5ASkh0Onn+hBPariN5MdSco1q4md+AUNDw2/wNjZB0ybHsV8Mf/jQ1kSZSb8szSzpL+DqSLvWo7T6TlzF/DwWlO0fh+5jT6ToMLNGcOMHH9augQnP7XrsIo6wed9QMct99tcCpd6qRHFxg9vJRq5r9D4kGrXtMtUOqdp3/V5xA2ObE/DWfIOET3KbAvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaUcvsgVrsahjJiil4lWPtCYmAfRA2VlgqYref1tFyw=;
 b=Pf4RD056pwBCthR5m48QzslS2rtzD5TFzYwlwPEimDXPGEFV0b7IFgTDN8ngFkBin3lLLLrzZ1iJRnkepaXLOXXNvI08sz0bukJR/zvFgfi342DjM/h0l/xBx08rnH5lLB7JEqCTUiLrGVHoYwKKny6iWm9CrZwi1Tyn0xT+iCsCfy3LsHJ5dyI2Hq0PlejmGkGDqviQ4Z83UTPsaEQg20lliDAIktSxeY2M40vFGtjNDk3uahmWdwC9D+tbLeOjl7I/vRRLSA82Er5IgsykP6FLJj1LjTQgCsXjqA/A67lh/qtsRr+WtbksDIjXZfds7S0LgiXlSVFLovbmeBCfgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaUcvsgVrsahjJiil4lWPtCYmAfRA2VlgqYref1tFyw=;
 b=U9l6xf8CoQCk3IDetYpuKIMT3/c6pszzriODmk/HS1VE6lYQBVMWNA/8/OC4R8vPChCx6b/fJLbXZtDxGaApXm0wLtVLKVWtYY59ieTl6sfRk8b8VFDCIu19CKHP3PPT1PHOQSMc32PjGJ4VyxptZwnq7Dvr5iaCl/FUkx/l/N7PdKn4xqhTYXwxuSrolL/U+ctddVEagTxAo0Ao4lkotHYzx6Qon6t4DrBgWp3hasyc1rCfeSjoqBXPLwzHrl16OTlxWg77sXNopbFtGsdN5nr5ljZ58nyN+9MLNdNIKGMVJc7/k6HyxA3fs//42GroxG7S7yzLzg8HsEoTPXL+nA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 10/10] imap-send: fix minor mistakes in the logs
Date: Mon,  9 Jun 2025 15:41:29 +0000
Message-ID:
 <PN3PR01MB959755A74E971E58C916E3FFB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: f99dd218-33b9-4c9c-4c4d-08dda76c40f2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|12121999007|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyKfJ2+Hj0mPNoakipCzI5VCKFB2zBhIKJmpsS8EvsFbjjcpfvCVknn24Rpr?=
 =?us-ascii?Q?X7bYBk8jT7taiV7M74eHjPgrszDdkpqJBEwkymnfziDM2Xvg9XeiTgOYgQW2?=
 =?us-ascii?Q?8guLIFa/6Apf6OiULLaqCTcR+4G1HUaOjbKdxzcXA4O+TN+ZGYPjtPKxPcB5?=
 =?us-ascii?Q?7t3Ey206DdONKdq8Y2RXxsx6/WalIpXuokJ86pgH0HejVIvp4R1zg+sSDhxU?=
 =?us-ascii?Q?cBXy8mTSpZOr5NDZyRep7PtpDP7r8KCv+p6WQkv3lOxjqmiEogbI6zglqmZR?=
 =?us-ascii?Q?vZ+kHEciUKYtG0/2HVs+lsXw0x6aaHpcL49V0pJTFQhlueUsCpZHu3f7jngS?=
 =?us-ascii?Q?dV14rMYeAK2UlY2T+8UX2hsJoy/DG9h4PiftCz6NdbRMJNJQlipbgUADHu4e?=
 =?us-ascii?Q?DfIid1FUmcGZpPkbmFqMpj2EsOM9JMXHrtAA6Uaq4qjuzxAk3UW5yiPjaD0J?=
 =?us-ascii?Q?IkHH2//zzIe7KTRcvu7Hh/HEdSTdo7FeG+IIPIKMvMHeOAUjdFmELKrOsKpC?=
 =?us-ascii?Q?2d+6/ZKmJZj7EeXz287uxpat2PPXhfcJ4mZKR23m+byxeiLSb9ZmklFI+Lix?=
 =?us-ascii?Q?EQDQGkBrRcJStVMAhtDkEAVlsOB6OJqO0UadQN5kXJvapN4TG6CnKsPp/cAp?=
 =?us-ascii?Q?Zy2Hq4Id5v0q+wiktIet9Ms3vmkLVa1Ig46tbK4zbm33W6HW6jMAgqdRyE7d?=
 =?us-ascii?Q?x+vqPuZJjy73VlHHX7ccr5Q7SVeJpxo3zyNtGwCCz82L0qgbhWzCrraibOcM?=
 =?us-ascii?Q?dMIpXPWeOXoOcDnZJ+YAJrqC+6chBW2Mf+udH62MNLwIgTwUk4DvRa+jOSVJ?=
 =?us-ascii?Q?6DniPVYXnJSqKjlwaD0e8e4wFe7wgCQ28P+mWkXVG1bt+tuUr/z+yKxO3X8B?=
 =?us-ascii?Q?QkJ1LCyjrRx4JWS3b6f3eX2ukZtW1xpnZCbJJPvhXr9Rknyykb2Rxz5IXJxW?=
 =?us-ascii?Q?ld2hcQKHpUrlBfK65rfkD0EN6KqMe/0xAjWvyooY+vu9cQc+Qo29YVFiqwfX?=
 =?us-ascii?Q?pLtk+EdhaHgQ3Y9iQbks4jhx7h9jHWvQ9UqW+1dKFFlolwwYD83PcZun6PFE?=
 =?us-ascii?Q?lpP2HGorUf+Lw57RFfDtghglAbfoOLfnvgqaippXpHZIYo4DK/M/LhWebcxN?=
 =?us-ascii?Q?sS1y28eKlba9k/EAKH/mGImxM6oc1aSWxOFg9xwxoqR1igw/I+ONPCmimEMq?=
 =?us-ascii?Q?rs0mWQL7DTJo+cTlnwukEdsomCO4uWzjkhdONRGGdd0cotN4YBgzY2clW/0?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ccs1iDO+jA6ooj5DejtgCTSXEzhUvtstGv20tnAW4C8ehwc5O0nrMQv8rV6r?=
 =?us-ascii?Q?gEQTa032/SGQM09IWSmiuSaRA6VcxA0SsMWdGk53AFTL1enNAPNnBfWfdrXJ?=
 =?us-ascii?Q?JjD+rYu5Btflc2d0dM7qgZ5KusEjgLe4J5U3Ty+XroIBCDcmxx4wxmmV2tFL?=
 =?us-ascii?Q?Uk28Ie36Q66iH7ZZnh64tNMButUzaX342hWRfANDzwbGDA/3xyA9hdwdrA4O?=
 =?us-ascii?Q?LTSA3Ag634/d3lhwx26cs7A9gceyK7izED5YyI68iy1K5VUw8oAHYfFasEmr?=
 =?us-ascii?Q?3++qAgd5SKbiGFkn6XCxIyY0IWmVBIiWxZhI5wWcAosjWd0xOh2f/90FQOqm?=
 =?us-ascii?Q?mgOigkD5lpOWdA7rfhlejN6R34YSMSSLvs/QFAMQeehu/AKkmmhmr4UiCr1P?=
 =?us-ascii?Q?xAS1nHJKh3+rTbbAEj7J0VtrFB5caSvVp19qa7h6appbQvP8vfiT5/rO6CZz?=
 =?us-ascii?Q?gNTmruqTlNMW6/NC2rCwVqRqHXYf1C8zTvWjAmolykdXQPs+TSwPPkE/HZCg?=
 =?us-ascii?Q?Fc38FtpEPz5IJFj/b/00kZgAgCqUIM6OnG+bOBa1HmTeOLFt0AVfTqS/wxhT?=
 =?us-ascii?Q?la+e2qm5KcgAc7MHmC+DT+bANegl5V0EZj14b5AfanO/rsn9KjQiUrJyb5oU?=
 =?us-ascii?Q?yK0oUXVsZdnnNXbyL1w0WdtPDq82go2ekSGTpktTIArH24XU1uU+vK0/RUtW?=
 =?us-ascii?Q?17lb6DBkJMTKA0cGrQ8AoRangy7D444RDvf7nazk3juUY4EXZ3lvSbLxk+lL?=
 =?us-ascii?Q?7/Mpepjc+8n7Is2XpCDqm3vMh08Q99lK+DpkorFjoNxKMon7GfXeXJ5OO1Gf?=
 =?us-ascii?Q?Y2xAYbsls6S0S5QJ2gj5wkt2qjkiiqnEm0h4D2vg24qzWrpbo6uci+Xn0YjF?=
 =?us-ascii?Q?RPV+7tn+EeVaOijbUDeAbes2Ciuea/U9AwIXkn+Kpudt79bIKUHJTjfJYzN8?=
 =?us-ascii?Q?QCDGw+IfYqU6v0BKKkW8xdJwPezpTxNc731Uyx+iPHF/hgfQDEHNMdrdymj5?=
 =?us-ascii?Q?fb4AlvW+W2+1J//c05SKp08l9sk3QGqzSLnfEW36J+sQB1+S1lwz1elzD83q?=
 =?us-ascii?Q?5MMu0jYL2yX10/le57gfZRogLQd+h+9RcWiMP6t7UujY8urGAlYgM5NZroIB?=
 =?us-ascii?Q?ecfdEEciFbaSCm05hwgpXnWy4JzNgCsqbYwLFxSU1LZN64ImX4PAmKqGas5+?=
 =?us-ascii?Q?v8FjpU5hOkRXdkVj2m55vA4DaXg/HrMj1G6zA5ENarP3Q8wyxYyWC2v3r4U?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f99dd218-33b9-4c9c-4c4d-08dda76c40f2
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:34.6572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 7d5df3d049..f465a51213 100644
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
 
@@ -1026,7 +1026,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1166,7 +1166,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1185,7 +1185,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1223,7 +1223,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1237,7 +1237,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1249,7 +1249,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1302,12 +1302,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
@@ -1811,7 +1811,7 @@ int cmd_main(int argc, const char **argv)
 
 	if (!server.host) {
 		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
+			fprintf(stderr, "no IMAP host specified\n");
 			ret = 1;
 			goto out;
 		}
@@ -1831,7 +1831,7 @@ int cmd_main(int argc, const char **argv)
 	}
 
 	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
+		fprintf(stderr, "no IMAP store specified\n");
 		ret = 1;
 		goto out;
 	}
@@ -1851,7 +1851,7 @@ int cmd_main(int argc, const char **argv)
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0.824.geaff4db692

