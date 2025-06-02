Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCD21146A
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862042; cv=fail; b=Sdo/P9Dx5whJe8tMeqXFapUxGIMX2bnHM8OGL4azK9FPFAR+FtA6Dr3E+layaEbIF5FTRfL22POrgJrfYsq/1fjJbf4ICfP6dvZD8q54YsYUew4gvWQBUB9EhuGZyTC6d1zROfE71itYxv+rjsD6TQnTOmSH6Te2XQqfnoajaFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862042; c=relaxed/simple;
	bh=+WHu8S0ZzOKdIcZb2wdX9dWbJX85sAT38RYbnPfI4Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pTlqdqQY6igkOEvT/xbRtaHu7PgJuaFoE1LPS8iCagF9OLW2ffycVzFZrLSG0m+dlc6ezPdKJivOn0cxyrwmgM5p9PhROw/84qkIotoqqorDM26jZsGbF7nbt+khjslCOC8Wt7X3LoFTrTSscK9Lz6V+ar0WizfmnX3tHxbXG6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=odvWy5yj; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="odvWy5yj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nrOdkljP6xd6NFc/5snn2HZtGv1ttrh3uZwT/t+nVK7LEisa+oqYroDsSHGIyMPLmfjhGqv+AfOEa4vQQs+3rfGDAMfZEy3ZG56elExdL8v9HPYdeIt7lFs7fjU9criHmHBkkF0X9VSZVSU/OSKKA1yTQUAKnftaA36YVav1gmfWFimANU7ewTIvFuXoV1IE6PeqZcwLroMP+T9WvPa7fJ+1L5dl9dNj8OxoXRjP1DC0WjoHFp2t5ctX6/ejQGjSki1Gkar9YqOKCWcTkoOpDr83ebWm9kUx6dG/PA2aoX+a4zj8PfDbx5MSMcilRvEyYEf3e/f97i7rQVuDf1MDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzL5S0YMYuQmKgiGlmsQR7exsMrUyJ9XzD1507Q9Ljk=;
 b=TpEzWTtz403rCFR4N8H0JMKVy4BWKTShSdLk6X5lT2VScejaTBAO/8uvQ0psN+OwNegDXv3NCXsz8H6CjkQNiSLHCJVnREySm8O7AfHJPrd6EFAQD7wUikEyFO+DseEJvbfXWvFHYCwDzSZ9R+uREJr8lDOkEe/MAjHAfoP88EtqPg84huxV6bx9dF2uKNiirwJfqQGruKkHoP0ViPXDLChN1v7RyfnH+cPCmNLYldKBpLZ5S60izvP2Cz2yhbySJ7wBCOswP7H4VHHY8YkQ6wkIXWpa2CWTILQrYwDTyjN/zESJabUEPFylsQlNtGVbcWLhoo7HCxQVfBYkoouBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzL5S0YMYuQmKgiGlmsQR7exsMrUyJ9XzD1507Q9Ljk=;
 b=odvWy5yjm0Yeq5tJ1LSJEwFN+6Y+9eZ3iI8XjA5cFtRJFRBBcaRq/Va9/FgAAA6Pzm7XgZqo/wACZ/t7fJiM/weJ6SnylcP0DDa0a6bIf6vXlaVTs1ZDhWgDJ+LhZ/692qm6jOAq+5EPA0Lih3NKZwSwAjzXlsdEJd/ziKzMgdZXmKwiQisxSmYPFcqCv9J2yy7zjJNAb6UBoTALOXEkh9rGZH27j2hfXpN424bepb2fp60o5Q5mxfzBCIDd+nBUpDY2GXyLazQWTnVUTkHRdawNgwNJtwNQk2a0Ag05fxfX79jdOSUTnkOJGPS55SEESx19aEbkWr/SVlT7hFhj8g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:30 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:30 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 07/10] imap-send: fix minor mistakes in the logs
Date: Mon,  2 Jun 2025 16:29:38 +0530
Message-ID:
 <PN3PR01MB9597041744A834D1794E9775B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g36d50d01f0.dirty
In-Reply-To: <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D3BADD7CDE568825A2D0B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250602105940.75439-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: b8fac899-c503-4967-9c8f-08dda1c4b034
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOlhpewOab71vRR2/Xe/BBKxZo8r96D+vZUSTBWo3jlEsxYF91JZJsxJp/GKa8Cg0dP21OZ8V3x+9NRE7gnjd4CXiFiMaLQxhvUN7/W9dz8DKWDSVEG5AqIdjk1WZ9ETIFkII3919bz635lJc9+/cjvsGWC4fiSfo+ox94kpsARI9LMrU1W8N8+gdLRa2fErO7JLLSB+igyOVd9n+BrbDn6p3oiqW/Urm5P6LPWwZWfEeC+J16vxDI9JdA1niuEFUhr1ecN4rjgEsetIcBTztJjok+MfN+bumGfubk3RcLyjfMj6bOs13U+mLI6UMLbm/ATI9T/rL9s6ztF2iI3ZGQgeQsjQ1BZ3aMHEegg/x7JqV7HNsgdgVwc2OPq9MIF8bfyAqoHpFjzH4H/X2MfQc1hbi6jLYsLpLZtgzLA9IsAPxO2PtPtBrzWJcf6MEX7MxJ6dBSrFzOOHGtn0hztrY8MF7faSfDg9ENigm0b2+kco7jROy74O9Gn4/1mqb770dPiAUFBdcFDR84APTWZ5YTHDzwA/wJWvM5MpLswtXZCqikcpuOUrWyYy3moTA3JMunh8JwuTAGEVwoQfR6jEu9CLL9mM+H5AwDpL1nlS1ODP9RFZ7x4jfOrZOTIhVDti/9QH6dDDWuca4bf/f8o8raDnPaTD5MxlR4P7ypTg8VAj9u7jmcmqE1baTrImbl4xFqaJNXNkoqFfrIlk/QzmFLSt/yVlgk1rV1//ZcNw04HwAc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|12121999007|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NAqLrVeHwcqSPedf+449CdZ5WK05UuLu6cySTFiBNZU0pTz4I6V5kuKGPEwK?=
 =?us-ascii?Q?n/uDCaxLol50JSdfulOVRjVvnYY5o5ekD6qtjyLgzKvr9CUcegOCnv0PlQ3F?=
 =?us-ascii?Q?bHv15k1PUrfpO47iKuL19/vWNCy9IJiWJPSlJ5+HAvKarQ4UQo6MueaHQdSa?=
 =?us-ascii?Q?gs8V/VcKU+vxOabUv2fduf0Df3MmKij0oVQHtng3P+ruZG6szRgTrf4QevyT?=
 =?us-ascii?Q?jFTgdEBj5NceZ+ylwZzCd8tR1t0ewRA+RH/7sf4m+Nv7KUmX1BMeA6BytfnX?=
 =?us-ascii?Q?JyhSaWeue5s9X7j2Pp22gn/ENe5EicCgZkw5uIM5di60//RDbu5SbMtLpBhr?=
 =?us-ascii?Q?8gDnIO9RvMnoJm46rbHzs9xhJslMBkB2aF7fqS81gnx6vrMm2u5b6yKAmh3X?=
 =?us-ascii?Q?dWwhQ3hmnNAKA23P1oIEMJZX3MuS5L7wa/eGxFvyh3CwTeIJX2++XhUn7XxN?=
 =?us-ascii?Q?9+X1vbovvqm0w1oa3cHUmYvwskjUqbrB2sNPNfuIQSlfiCZvsCVYBtIJURfR?=
 =?us-ascii?Q?hqFefITr2y//oVRjDHn9v+cXkeuHVnK+w2NZ4I99Ygzk0+XXpqUIRNsbKifU?=
 =?us-ascii?Q?RdYKzcSQDGKUvSEO+0Bb3Ufhnu6vsZ5rNOUeU087cg0b1ZXzj6jneWPchZVQ?=
 =?us-ascii?Q?rYkfMQCqMKKVneZR34AUDzpEd1kpNA7NLg/k4M09yx25iRJS5+yROv8xL2i1?=
 =?us-ascii?Q?SPviPc6zLbquat5Cpts7uOpU/8gW2M9RKHPehsTpi5+xCWvxFoNQga6oLZ6K?=
 =?us-ascii?Q?QThfbJgoGmM9u4mPQ7BSMFnR3s+lwgLq/PhYLmci8OqQw6CS3X7dwoWgnbUe?=
 =?us-ascii?Q?NOaz8dKmSL1loWBn0Bs5Ws36NbKL2XfFOejHn9kgEKQmNYGyBitNEJfn2but?=
 =?us-ascii?Q?7M+ebyIpjRXxNwb9RWiXNcpWAItw8zXyiYqsI/CGq6uQS5BvVkgbxuEQQjsy?=
 =?us-ascii?Q?HsYpIF0P5/F57AJicSzD3zHZ/ecFs5A5O0um8AVlI/fNsJy7qC4aygvQg6Bl?=
 =?us-ascii?Q?+rawTOZaQJz0f2Q+7fDQVzSsrm7WJKvL+VPx0W4/4CB+KDesRZZ5bqOOV1Ox?=
 =?us-ascii?Q?XP9mR6csjPQpJYJdlPAvPd+bsU8evKN9Gu+l8PkWDavC2BHbP3ObV6knL2WE?=
 =?us-ascii?Q?lXXn5MhZ9QF2mR/rWquu/TvuvzbnXruB06dE7JPnaon774eEH9EEuF8dNFys?=
 =?us-ascii?Q?quzlc9z08C9J020R7uLzmDcbyP0odxFBq8iXsw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qFdJ9gV0LF0rGxRCrEfUGjySRVkNprIb7VqMj4VNaJGME6U0Na70TtuWywRF?=
 =?us-ascii?Q?AGfyacNpM20cJbRG5fyUUt7Gw3UV+qPHZlQYNdRh01HIXQWlgm3/V7mYytD9?=
 =?us-ascii?Q?KzySgpNyKytH76TcTCRtu21sZpZs1P5OyFr8hdet/j38R95/DjzYs5Ot+8o5?=
 =?us-ascii?Q?yNU814vw2ScP437yYMKG22KD2PRoNsLHoX4dmhmWSZsLIqtp12ABXILYnODG?=
 =?us-ascii?Q?lkaJehqWpjWbM5shLTxKxE/GSm5g1c7IH97BKE8/tX9ivaqkMAccR0rAGL9D?=
 =?us-ascii?Q?PIwl1NPEWOHLVzMbxQFPEW9LmALtLaRoO9GwzwxEhJ6lz3LzwjjT3cgauQaZ?=
 =?us-ascii?Q?426+QBBkVa2pegpD19nHWLGk0hHslpTejbK6Pmz9K2ISb/0pP7Ozmbww6pwb?=
 =?us-ascii?Q?/mSsLsG3Jq4CI2UqJln03XwpPw92r2hoZmHXBgVBrNnw6/tiA7eaH4yZ1kEx?=
 =?us-ascii?Q?MQe/ZGZKtEKRcLMcpADKJpwE4Xm68ElWLbAM3qU3NEEmERnsjStQduPG8JXl?=
 =?us-ascii?Q?t6251+aSHhF5AR7tUOmlhZoPoqeY7Sy1EPZh0+HnWZ62eXfgSrS/HiW1d2ZI?=
 =?us-ascii?Q?3sxcS5ncqEfprC+R+IT8OSiiHGUnJUR1/EC3jOKseQe+JUWMSZ2aNnCm1SSx?=
 =?us-ascii?Q?iH37CA+54g03w5NDXfXJINAZu88X0/3OtTZ/fCRc5KOHkWYt1zD8edJiJUUL?=
 =?us-ascii?Q?dubLeZ9EptlaBTG/qSsZe/RBXoAszG+SDhIAGFN648kcsjK5w1xM5YJmWVD7?=
 =?us-ascii?Q?ocAXphi1bFejZwHjczqPRkvQDFk6MmvByDXhvYOBoHwRSEA45whCFKocqtX0?=
 =?us-ascii?Q?L5ihukGpvJOtWqBv+t6j4C6l0cICaW211bpVfizLdiefZWCLZXP8TTdCyf+P?=
 =?us-ascii?Q?57M9LScTR05s8ZyLMfHnzFgoIZtVW0UxfXxFw6cXk9IgZmZelphQXzYI/7IP?=
 =?us-ascii?Q?VcP8JAtat4eCTk9EFzoGTy2hjQBi7lPoqMg0HuJaQhyzRnrLzrG58zoKO3Tm?=
 =?us-ascii?Q?3zywYrtprMZbDJKZiFFmd0HlWf+FPlH0fCkPi9R/YMyU93QUMFuOaSDWlRsj?=
 =?us-ascii?Q?NXENz7OAsC4lKYHW8Uz0OlRiY3oGY2iRrZCwUQvwczecXEKZydkBQ8fWRMkg?=
 =?us-ascii?Q?uMyDYgPTkZFgoT3q5EicfajbpYzjH0t/HwWPS3KtTUj7yGph4RZlj5hIt1w6?=
 =?us-ascii?Q?hhRA2Sk4DbrdBGH7iX0H3ac5vNMzd6nyd/T4PpjNM7HPZx4nbysvaiV0gax4?=
 =?us-ascii?Q?Q4wKHppnZ+RIhFpFuWZR4V2J7r1ZDrs/tFbVrCzJZqGzxipXobI5/tOw/hGl?=
 =?us-ascii?Q?eosTwMkFtJv2D/x4eX70BOaT?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b8fac899-c503-4967-9c8f-08dda1c4b034
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:30.1293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 0e33baca7d..3a1940e4a4 100644
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
 
@@ -1020,7 +1020,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret != strlen(response)) {
 		free(response);
-		return error("IMAP error: sending response failed");
+		return error("IMAP error: sending CRAM-MD5 response failed");
 	}
 
 	free(response);
@@ -1128,7 +1128,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		imap->buf.sock.fd[0] = tunnel.out;
 		imap->buf.sock.fd[1] = tunnel.in;
 
-		imap_info("ok\n");
+		imap_info("OK\n");
 	} else {
 #ifndef NO_IPV6
 		struct addrinfo hints, *ai0, *ai;
@@ -1147,7 +1147,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		for (ai0 = ai; ai; ai = ai->ai_next) {
 			char addr[NI_MAXHOST];
@@ -1185,7 +1185,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			perror("gethostbyname");
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 
 		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
 
@@ -1199,7 +1199,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		}
 #endif
 		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
+			fputs("error: unable to connect to server\n", stderr);
 			goto bail;
 		}
 
@@ -1211,7 +1211,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			close(s);
 			goto bail;
 		}
-		imap_info("ok\n");
+		imap_info("OK\n");
 	}
 
 	/* read the greeting string */
@@ -1342,12 +1342,12 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
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
@@ -1603,7 +1603,7 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1712,7 +1712,7 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
@@ -1796,13 +1796,13 @@ int cmd_main(int argc, const char **argv)
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
@@ -1824,7 +1824,7 @@ int cmd_main(int argc, const char **argv)
 
 	total = count_messages(&all_msgs);
 	if (!total) {
-		fprintf(stderr, "no messages to send\n");
+		fprintf(stderr, "no messages found to send\n");
 		ret = 1;
 		goto out;
 	}
-- 
2.49.0.639.g36d50d01f0

