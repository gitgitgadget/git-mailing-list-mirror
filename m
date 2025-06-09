Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD124221FDE
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500627; cv=fail; b=U0US1rF02WRmNZH6OlbRRUQnCtbgDdlKLCSB7n/8AZ+eSVBr0TxPwx2gLhpttzcimGZYdM7dsK83eIYxBWfhBxZVrSJo88I4n9fscrjheYDsncaRRk7dt4cW7yzFiyEEp4msaKTWpehBSraNZHIQPTTDwVNeyWM5DJiCtoWLwZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500627; c=relaxed/simple;
	bh=knZZ1odSjYldayrex9oYe+AkG2DC6Gu2V1cxmaiOUvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2H8eMqkYntsWyTtCfL7O4jw7Hc8wRa/CtcqgpSZkYUng//tXpT6zw7882LZ/nldyLxJho3FbNSd2mc0EeMDGKr+pqGUk154oJ58OCXA4Nym9BvqQFljcy8mDj+4PE6z5DcVLPUgVx0k5feW4A6WwBRU8+CxUVwzy6mdNFuVlhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=iMLbqlo9; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="iMLbqlo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w01EAU66jmwaMDTjNXEqR9ns6lLLuEsr5LfO8qS7VUqFWv55jAfv+AQVArkIj7fe23DllAAxCpCgJRPTVEB0V5yGOHGlM5L2s+MzGgKzzVFpg2nJfzVWhsJsZ8rFjxzSqV1ZFPzjf0c+Dj/7DqrY4ip5g5LnLzSpS0/z7T2QlER6lopEy6Q+gIltrfd3TnuCvCKJr59mr0MZ12zxFH71FS2mF8OgAnDI4U0Gvq1nQIjwXbQsCdWV+BPFyNL73X9Mpw0YuTVtlYPJmF7lSVqe3xT0dQaDRviKYnNSO8IidgQwkHY9Iac12aLCPPMFun8zKXJQv0LOyFnjMb5fnlsQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pVcr0gcgp62F1ptRRQH7oQnjksdEG7/iVohXTMLK/g=;
 b=SM2JK08mOmZ/9bLnyrlgS4Pcij54jldkuZhViCMp7+17LSwK9V9/w4H3R/lUCn5US44sN7e65AjXebuVIq0V3BQu9+/3tksatmsdjlO/63pFV8A2FOykVvVScchSYAPtZuykM7Qy4wc6pogIaYhGtydoMKDNFkwgSvrdw2FxNRkOJ/XI6M7L77KI6agNDg0AtpiI+AKG13gjEra/9bZzsTgHN3vStzb611UVmwvH33DK3FXhl8cZLsdh6FTKtu0EPGBYEcpNToQ6cBMEWTW7h2GQ4BSsLWSwS837iLvDWQaOMJM8c85zTnA29KLJcyCohoIgVPkNBdjyS6I5QgRcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pVcr0gcgp62F1ptRRQH7oQnjksdEG7/iVohXTMLK/g=;
 b=iMLbqlo9jc19XS/txwjEwuh5yaDSYsvz4EPLh7PxDV0ygV5W3LDR0BCeSeu9MyI2eL8I0MEznqL4f8Fc+MxlpMWauxn5vH6YPcTg6kIUfc0eia/lSq0dEMk4oIZJuUuvfb15MUbn2umbBmbbpN4aVLrQytPvzoXaK/wv49sIsbdEqPB66S/cTxx/UOhrI9rI35A42codw+cvthcbyNbOt7nfkvJMzIB0yMc4J6T1rGR9z7rHZtsKF5JFkdLIwW3drfIZ0wARMgNPwoJGUX7aar7RHdAH+9D41edSD4mFHQpXToyVnTfEgQWaC8FqXHc3jF1QFGfYfDOaYfl4fSQjbw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 10/10] imap-send: fix minor mistakes in the logs
Date: Mon,  9 Jun 2025 20:22:55 +0000
Message-ID:
 <PN3PR01MB9597DBBB7C5DDF403A627E96B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609202255.4341-11-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd475f-0c4e-42f2-0d3c-08dda7937ed3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|12121999007|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MdoV0NYtVH7mxc8SeLdXRmOBbfgfa353BIMn5unNvuXWSHGk29WRVQlCldxb?=
 =?us-ascii?Q?8TGcltKP5OQebddV086JEKE0TY+BefYo0gio2hhkz+ryokhp0MzBBAbdhmZJ?=
 =?us-ascii?Q?pw4jIzPrRSNWfi5XMwjkJIXBOePgoWJxEzW+Thaccve8SQU0ILk+im7NdSZJ?=
 =?us-ascii?Q?2LDH2uguXFRMEVesohRHbA5BTB8f2ORny8b8gk5GhD45gJwj0hoQ1LKrNFMr?=
 =?us-ascii?Q?XOKEP7G7YZ8T90IEmCKX0+ZLDtSzxjx+lnisGXeWXxA1nshWfBS2W/96b3Sk?=
 =?us-ascii?Q?vNdmv4XmhsVSRTHNu5GXFB0IuhFc4GenO2zdchqj4ge2UTLPXd8bwwIondxT?=
 =?us-ascii?Q?xCG502G4LbyXE+zaR/iiwxXTpeDQgYEUecwIp0eZMdRF74QbQ6lm6Da+L/ae?=
 =?us-ascii?Q?UFJPRN2URQovhfxkrpTVquQSPpJvvwxCxqxmLfU3Mio0cHeKpiKhkhQM70v8?=
 =?us-ascii?Q?ioC3U/8+UTMJywQ5+1YHz2WfhLyGRstGufzsXrzQT9hgmLNSPHV/uq+EZGou?=
 =?us-ascii?Q?w3yaWqjDFfTKNjejGMJ4IaFp1Ddzp/ay0PO1I9xIzDDMJ1FmRNuCkpPOw9pR?=
 =?us-ascii?Q?rayVrUC8G6ySBHcM0aLnXD+MwLYLL1le4e3x+4r7OMHRfiLmb1fkZ2hh6s84?=
 =?us-ascii?Q?bmpl0ZyxuIT5BP6T4e5KGjMIbdRrw3/GqNA7DLPA2ajmYWmCUMs57IzMtZej?=
 =?us-ascii?Q?ofds85YOdQCfq3rJPHNZooyvQl8iSy6FyHrBeturNUQt9PseU/L/0J8BQGx6?=
 =?us-ascii?Q?65LnHsQEMDBSSrzUsvj1A0WMgVx2DHyLZ/EAz4EPKfZXrI8xfg2aBz3zsGIn?=
 =?us-ascii?Q?IMKN6yKyeD4L98kJIs+cWnpgO+iIzpYkLrJmvcmkcVj0iIE5rg3u+FSQBLRX?=
 =?us-ascii?Q?khh3JQ6YMsZ48luiFY/FUOtiDtIdbsh9hh8hH3kdeM5IgxXysHXS9yt90m1i?=
 =?us-ascii?Q?udZ7LJUncCtuzlEFkhig5Z+HgO6mkrsEEPfwf9j7qot3yOCwlAP2rpdFlEUe?=
 =?us-ascii?Q?QCGAJ5kfUM3xSAzqALdD4pahC5Lj+ic+EHPvXysw1Z7SxhfEbcLJaMeEtIXd?=
 =?us-ascii?Q?ZpOisX8ib+VefhvAgXxV3+IX6LgnRt6pWufN5ZRb98pb5ZfywfiBNTXM6qlC?=
 =?us-ascii?Q?3lrEz/Vvyfepez3nH/MRmTDP9wdbPl/O/8jAJL5/pA/x8Lyl59vdCa2dhKaa?=
 =?us-ascii?Q?nn4ZSuNHcFnXJ4rhb1lknHP3APxWd4VvkNiF2d5HTPwxAHzj8SJd90+a098?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHfeiyjzAj1auUwS0D2X4SfXeZlRCdrkp8DFTIRx5iLF+ZLsABDiSaiU9EFz?=
 =?us-ascii?Q?LZDCcQOAYSdSQ+/p+qPrtQMmSVFm1Wv8wRw84fJyMzs4oGA0XCEGHyETEH50?=
 =?us-ascii?Q?hYmKfh83r5eQ5D2tP9w6uLz3UxVckyJcdOP9Hr5WTJdKUxY+Bs5P64CFixtn?=
 =?us-ascii?Q?h8p7xtLT9tiLjmmuNaND98bOw1qRdLsyhgK65u+qmezvnemg/+rRKkExrq5K?=
 =?us-ascii?Q?IhITY70kJHEgB7xt0WKmJJYa3Bxe1fHCmUljASXT6oNPdpIcLuY7s+jdI445?=
 =?us-ascii?Q?eOGgle24bfoWtNye35EEe7kaAjsn+eymMRsiajUn7k3MAv5hdFyU5FvaIzN6?=
 =?us-ascii?Q?F6IXoPXaOtV8Rc42rUBqZeLziblQwYbFrzOwhaBOamJbX2+kv84bik+JEj4H?=
 =?us-ascii?Q?jdulcZHowvM8qSD4nLifhfupcoO3Vk6hZkiLDfgmE9Np+2jqRoyByvD6CfR+?=
 =?us-ascii?Q?CCvc8kltbXpUtHohHZvz3dbu3Y493O4uSv108dL4oFUB4/cWIppLp5nfyp+x?=
 =?us-ascii?Q?A8alZd/5jbK2QnSPPTXFJABXW3Ctb66Jwe27mG/PdWkJtz+hKQydfNayPKBL?=
 =?us-ascii?Q?0x6uimoDWUopDLiHGG2vN4rrvz9IiCzQsTZ7hJzZzKUqJfxuccVsKSpqdl1k?=
 =?us-ascii?Q?yvXfjdtuvaa2u51bmlEnyOKwvACmdGoUusCf8mO7WZJ/HTprIuXZLkfYnAP8?=
 =?us-ascii?Q?IEv87cr3HvBmcwH3A2glJ9uIkqUbJvmUsHUszGIpyuLcr5jsgFU9dWIp4Cdo?=
 =?us-ascii?Q?J+a19WQ8d7ZG1oq0RXkrNh67ChILJtb1tEGc5NYPaRmTrIsUrnqxkccNVspK?=
 =?us-ascii?Q?UgyJt9daF5gTYyzCQxF/g1rlCIJqsa9W4dRBAoeiWlcoByCD4v1IJ3vhXPOu?=
 =?us-ascii?Q?j5jyMkHKoFTt0800mPUw+EKxpSW0DyTdYpdIv157ttWt547PKpu2MP/KnHfd?=
 =?us-ascii?Q?YcXzgPAdVpS7MTeNlbp6F1E0yT5mZsoBRxRRVoK4Xh9r08WtTXMtm+6rMTjs?=
 =?us-ascii?Q?gPcdIyGvbQ2l/MnLROI+SG0ARIqq3Pzxc4MdFz1RtmQK5CsizQNEgY4pl1yw?=
 =?us-ascii?Q?ARokSGEB2MjvIVlcDAIDEn/yU8zuyulAqkqdRbDte4rZiso5hphVh52FkaXD?=
 =?us-ascii?Q?TtNHh+0nR4LjFF4yvG6CGj1ct9BwagASP6bukfkE4kQ5TSlat39kE/0Ygndl?=
 =?us-ascii?Q?F0Jo1DMZaciu3a0ciHXMfclBmbonnmkRdmWH4lajRbUYRWGePVLUsHnj/q8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd475f-0c4e-42f2-0d3c-08dda7937ed3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:28.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
index fe4e2fbeb8..ed4c34dadd 100644
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

