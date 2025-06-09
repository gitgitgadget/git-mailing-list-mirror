Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59E281524
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453726; cv=fail; b=sanMI8JNvgK1TSzGCv5U8w8Phwd3g0bfSSOc144bxc7pCZQtXANlOqxIWEJxQHwmmAiOPp4ziELe9Re+qeZY5qi109upOnJBlM5tfHZb4RGrrVZijFH26QmL3+HL9R35OG3g75s8YhIyOYycdcxq4a0Ro5fTMX8CGYyG+VcbxjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453726; c=relaxed/simple;
	bh=/OqESX2Rq7ZivP3bm486tHF28Mx6kvQbXEIwUYpNVKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gVEpc/8pD0aggvz6i30sPlFgE2hW6PTtfWaJmiOBOus53iHidy8Sf+Nz8NoL6ndwHsgsbH5i20NQYIZ85p0Du17U0Ap9HoqF38F1/nWG4y7WC89V6GxcUwgDbiO0eF3chv3u46gJ91mX74JhHykXsFBntLXmPyy781kdh22Vq50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=s1ty6u4q; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="s1ty6u4q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nGMALe5uEOlUehRCh6YKSdQQkXsWTVZ18ownmzFj/0d+nggsv0690vSlHtSeua+Ypl/EXDRA7zd1SeHzHBKC3JYqCUKmlipQa2ADWrO48dqgI1GnJaxCGCiyhVmpVJ3NCkWKV3175qKigD32kzVlxM83reTzGqAnwBws5kbu+oXqL+cuzrGQLgG8OsSYxwg7TQt2OmKiYFGMztzjUX0sH/SP/z0U7dnsacXrJgGZT5+dGlar+THmOcE1uzPkqRa/OFnBIZY7hNiQB201FcfMGv+e0zMWCXUQkkuE8Xi0GSsOZOvwD0I28pcn2VGmJtZ9MelHFkfpqeY5GwUty9nIXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ISmcxI3VhCTPljT4M/b9+3sUbD0GoMM+2OFH2r5rZs=;
 b=QFN+N+rBodPzWVmkbkyo3iYqO8359nupZQFxv1LjbqDATbNRJwsbpZ9WIggIDmLxWnXvhzSgAVSBd0RjWUQVoaKE14vVJXT3Zv+YWUiU1O2zC+x9AkX/gS5gGeVPPU+NxJn6qyQvDubA6oUWVFwnHrVN+tUTwsrwdForrhviz5CbCtZoScMN35rnguTO5WMbiUGoKX5BHF6dd+kIsWy2EZLSK4JrQ2GTVLEO2RJY/i+bnzbFmOBBs9CNAncfvPWigSW/SN9iIWmf1Wm34bSoXNGDROkDKnbPpDd4Vw0jIqxKu7X8uf7Q4EyJTDNcRkPNIpgdtLQvVectgcB+EGQOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ISmcxI3VhCTPljT4M/b9+3sUbD0GoMM+2OFH2r5rZs=;
 b=s1ty6u4q7Dznb379Roh92tNJ+S4rAIWGsfzSSNaQ8F5/O7ihPrvJ71IE1vJUBkI3XVb15ivAUcx4O924rH9RmZkiZkqTnohDF0f7Xg6u/Fe3Uas8v/Oafgq6ZfEsxemqYSFji3mq2EtlLYuqyndqJwg9aZCRWUnQZ0n5R22s8lOP1M21G9I+T6+1lzrlLD3JVhBfHsMVxdHWsLke2w3HxGPMQfemzyq+yABsE91Oy0OmTlhtKXXYeiZhD7naIIMqg0WLkPr1gX2e4i3PGJTo/IrPpgPtN0ecwtlFMs+9tW3g7UiPQz4Xb8Qb4B8CkBevoVMXiTFXHzehFf1q6UIVZQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 10/10] imap-send: fix minor mistakes in the logs
Date: Mon,  9 Jun 2025 07:20:41 +0000
Message-ID:
 <PN3PR01MB9597BFCC2F5B5E8247C23A7AB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 0323aeff-4cd4-46fc-78b8-08dda7264908
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|12121999007|15080799009|41001999006|7092599006|8060799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hp6aGbBocg2WvW3VVkghU9NzVAnq1wp96jVtV4vfdnFgBJi0mu2G/5GVpHVi?=
 =?us-ascii?Q?ET8OgXiI8ABQOE5F5fOQmEJK0wAapCwfBXPm80NeIAAw+zBL/IKZMMjoIBoN?=
 =?us-ascii?Q?HpU5LSWRdRfyedapV7zB6Npg3xtAaapgKM45H1Y2rjJc5oBNUcsqeh67zn4z?=
 =?us-ascii?Q?yRz4+d20SnBOmRBeLlxD77Kgj2hTVKG0WZhlHdOH7pWlYysmhKeCOqfmJgHV?=
 =?us-ascii?Q?JyrkszRjkhVgW0nBrq3NSeeOo8dyYEDWZDzolKf30QG5IqTMW1/MnhR/jINT?=
 =?us-ascii?Q?7sDmWn+Mv8tClVODeJsE+qwg2hXzGoI9jqm4WbzfZyh3rlS4PBfsx7NOOBXS?=
 =?us-ascii?Q?JKSba99X1PPGxxbdQY8hp6LUJWSL566nhsYPhcDVbdhn/zFOt0a/bjvh8jSD?=
 =?us-ascii?Q?nQU0NNT7I7PmoYwzilReCMcyipv7Mx4gBmy8iZGFDp2eq19FtoEmJS5Xy8zh?=
 =?us-ascii?Q?gSK0DRBozMX3ibszH/kzIfY58850EilF89rkSkFdovkxXM/ClPDOcqsQxtcA?=
 =?us-ascii?Q?L+El34BzxkiV6V8Ic75qY6Mt8fvzLQS1zDJwm3ddbS4YHrIw1nzGdLkqC08q?=
 =?us-ascii?Q?vAVI4v8P97GExy9nt2Ycjyn1WjV7UoniiWeUDMIG4KlIh3lnO6Pa9L6veCn5?=
 =?us-ascii?Q?JfSBfq5bi/k6qQi5LoXCU0EYtH85sPUa7Ktz5JkV3//8VIGDItiEELZhcJXh?=
 =?us-ascii?Q?MP73GnMxHlPS4Be2r5VM9C3zvn1CMefbasA170wLcS84nyzj2r6ejoGoA+l1?=
 =?us-ascii?Q?Fpi+HagVOgqiRvYL9Yqt5BzPjhT+3iwlIP4K/QfvRN6uOEs1oRRacedJW4Db?=
 =?us-ascii?Q?33/jYxfGZ1bpekvz4+JdYVDD7kxGxUA5iyFodPCQ5rUIVkKC8/wcDQIzXwm9?=
 =?us-ascii?Q?Gy/dmjnMQEL7DVVyHqvAT3TjDMw+R34EebWIWEnlAe5sqihFJT2NUMqAxepY?=
 =?us-ascii?Q?nYiOvQGyfNDmwK9/DAwJaDInec3NhK2HEUDtsPA7DWCUp4E4AmiwDhGJttXR?=
 =?us-ascii?Q?87d3yFAu8OufsgJTuzImKPP19BLf5RlU83CtJZ/c1pOCKg38bFRgVfYAic91?=
 =?us-ascii?Q?1xyk4N/5FahnuhmuPOF3Iliy58va8ZS4q+Zou3O8EpEap7ww+nccfgmb/34P?=
 =?us-ascii?Q?tq6YGFHehqU076CZ/92/HaKoadGqDvl8DyozEyx13cQ9tWYgjMjjqacWzFya?=
 =?us-ascii?Q?cLcxQc0Gyrc9552NYMmDB9fDDhEJizkrF94spQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P8XRUISMUIzUu77DQWsUQKnD6GdlcgmRu5jqhDiq9EsiQhUy3Jm4bsMiL30E?=
 =?us-ascii?Q?GxZ5INewj+G3LXwezymxw9fSpUZxoauwmN+uhW9R0bHkD3ZJpsLow4NIWwrR?=
 =?us-ascii?Q?JPC3psj29XXgvtW5Zl3k/hBVkfbYiTar4/kh2njZcB3eE16izSar4giRHb9S?=
 =?us-ascii?Q?RQx7YeVESq2f2Bo7k87R3nfSEsie+/0qnqqeM/dVcPQvuh8hyBYBzc9ciqJU?=
 =?us-ascii?Q?e04m2iyEZk+aMZ8M181Jqe5ay+3KUcGvnXVQwmdog8cMR/v3HjkGHG513xJr?=
 =?us-ascii?Q?+tckW1CJjUrY0g0bh/IAfvrfvC0zWCu9BJZFxdaMgaCjj2cEa+/PcPPUKnNd?=
 =?us-ascii?Q?2WPC5yRpoFauy4QA4Hnrl4dANfgBF0H6SYxqF9V4pzIrLESzNWjqNplSfqTt?=
 =?us-ascii?Q?px1qQHTCW/+WN7yZSkmKXM7AK/2bTlzigPTpdnlZ3UAjS1p7IQgKXMd6ZCFD?=
 =?us-ascii?Q?mpQfTCIBPdWqaaW17it2QhGqjirPxMRiiV22/q69fAMcjMTx/HpEZUbRTYkM?=
 =?us-ascii?Q?lSbb3Yin4vlyrPOBYKTVro2bEFBXcIpXUbsGoA4t4iSRhPA/uWkQDWWZiixo?=
 =?us-ascii?Q?fGZzf3udW9as+tWTOtxqs7bLFb4e41mj/Hgp7SMtvpFD3wNeCyy8C+r3deQl?=
 =?us-ascii?Q?QUw9yHWGuTHYVbQ5S2k5U/m51SC1e3NZcCzPrHFl2HHAoic3qMZl9yl8Iqlf?=
 =?us-ascii?Q?H27tok44BxXtFl8Jz7wgxZ7zmzbCFq0x9OcyEa1VrKL2T7sWrgVMXn3Tf1Rt?=
 =?us-ascii?Q?h6AbgM95wGeV7TCTaeKGeFbOSnCSJ7ihqwEMb18ETbAdb0EgmlTS01y1MAYe?=
 =?us-ascii?Q?tYcWEtflqbA0hRBKhTqiTgLI34v+4PzCMlbZf4/G+mMyPUWmEeNrjunW/Kmv?=
 =?us-ascii?Q?Vd4J7113e76KwUL0/VsoElfHEQcsoYWV8dbt9ujg4Fg2YpmJTKn6ELw9e0q6?=
 =?us-ascii?Q?7YeRzr/U5l9wCAhdhd7deuSAGDF6WkIm5L8PoAGR85C/HTB+fDW7mGVkinP0?=
 =?us-ascii?Q?IrzPNFZU94byFv088T+3kyNkhxLiHyvOnQK2yvjBrAnFUDZCGGNRfrTFUQKt?=
 =?us-ascii?Q?2ek6ZgB+jJFSHmd+XFpQTLCVYkZMaTq93X4h7fzkeLHvd2cqXDeKvxn35HrX?=
 =?us-ascii?Q?gI1e6SpNRfQu6BQUgMCkTKTL1Geq7Lf4vxF8esBnZyQYZXUBLo7/HbmRsAEy?=
 =?us-ascii?Q?o8Ip1u5hX8SF/Q3Y1PwIhwBKOBLzGmuKdQVgz/XAT1TrmR8+VK1ea/0rt/k?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0323aeff-4cd4-46fc-78b8-08dda7264908
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:43.5670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

Some minor mistakes have been found in the logs. Most of them include
error messages starting with a capital letter, and ending with a period.
Also, abbreviations like "IMAP" and "OK" should be in uppercase. Fix them.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3d6bcd7e88..16c2e641ac 100644
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
2.49.0

