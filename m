Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7D1A23B7
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761946; cv=fail; b=NT6IfGoPm+TFert5tLRDC28WkbCh4yUjZMXMbuvAG8ZVXUg7tX9jiehLhUZWvrm+wMd+FeIQKwq8Dzg4PoHxSSneqXiEHBmDp/qhvSzBN80ZHKgepsKR9ZmfpcjLVLiEimgjbu5usSQTxxCF88WfpEPtmqvcDs3SOFQRYNSuxJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761946; c=relaxed/simple;
	bh=jyUqj40MevNflpDW3edwf+Mk/qMzvf5c6FEV8k/kwAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+GxXCRK+N07kNX1DKyPh0Od/uRPVSc+Oe8Q2UYPRQdK4fsCqcymMNpQ/xhR7eNz2/NKsPqPwEaXpMSUa4u+8wO2IIZgPeqYW1o46pIsbOD4VUA1kVQ/+B0m9ysM4fEE68UJEwpIc01NQB8UfSndTwSCya2hZpVqtrgSSNQ9YXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=nmupru4u; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="nmupru4u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZ4lBTRzyVNTT/fkGYPWhIv+Yatv+ymP7Lx8zU9ltaSGAE0f15iBOP4vOb+UdtdDravatAT7UGZ2fJOjzixPO2zK0ypL/Wo3Nh0Q7sAv9uOPEfqAF0khnT/oLrb959OnQw0zV3E5qKUHZIcvSRf66DIiOJKACxH14URV0TAIoF1LYr9LYYG7JCzj8M59glF96x+0pRHGAHn8U7FXYMCsyI0ptrSymvJpnCGWfnpVAmQYrxTG9Px15r9giOEYpybmVbDDVTcMh7CJBt4Z4sVC++YkaSzk7A/fzf4RYO+QQSFuULLO69FDupLfRclJytfrF6o4OldY5g1eGywwZRE/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzX7xllfhcvv/5l+pb9iEsZQWR6gHJwjQr7IKrqI4Jk=;
 b=J421Z7xHaYdw4NHzszkdWJQBqZVOvwD1sPQzzomgNwHHmuZoTUQ7SeW9+VNCvdhAHucBHyyGKPsVV9o0yzY2r9X8u0Lus1pxh7vKoGmrtLldS8ollh34p8lv6oFgR8jL/lJz1nQfAffFJ57fhS/TEPnuC9l4XFNNlN1oq1DwRH2B0ooz/ZvveIpqIJBuNclmhSZiuySrXRIMcT47iCytPJuQGbkRLZ0wz7QImmdvcUolQELFQWdfzdmm9C04TIOQeaz4D4mUCQ9NPGXzeh1nCTRQw3ViR1LN0mMwmVuA9D2dvuZHW5IcvW3ID6f85kzQQ4tbvDpTFWM+I5OhpHDMJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzX7xllfhcvv/5l+pb9iEsZQWR6gHJwjQr7IKrqI4Jk=;
 b=nmupru4uwW6ujmngcZjA2EYtXmqbMLyKuHlFuM7ZSiZzzvhxBXEZ0RvPHB+yoXffp90f6Ng0wtGPJISUewijGFpe3T06XDWkh3H9Q6Qn1gDODC9oZnnPiYPSdlMAOZpBcUXXwxUijvOCPQEMEwNM3wSnoZ1Lsyo+V0OGfm00RKxOVKuaRAPo0TWg6IBUv9o5qxfFzNhLnfc8O45zpy13cPwY3XmQJTHYkR5XTQAgDD+E8ylE7pET0WqXR+X+Hu6gYeDr3YfgP4+0Y3QYOoRxlhYyr8SyjV4O3NxMuiAWlJTnUp2H7eLt3NwFvz1LjiZC0Z5Fo+cyqBp3yZVbch1+hg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:15 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:15 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 8/9] imap-send: display the destination mailbox when sending a message
Date: Sun,  1 Jun 2025 12:40:34 +0530
Message-ID:
 <PN3PR01MB95972AA75D947243D11B746AB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g67a2d115ec
In-Reply-To: <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250601071035.2412968-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: d189dc5d-8b0c-4406-c2ff-08dda0dba301
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnF5oAkD/pH/pT3EsSPbJJWQsPeBApmgdrHnbI/abMddcITZbKQHOE/QSzHvGI2FhyDsz4yv1XF1A7hPIyOcZrve7UpwpkPmBukmMVXOL6OhXDY6Lb+rDB1WZpLiGV7bYs/+fkSlWT6/veFZl6pDEwW4FaY4X5lwuM42BWdC7xLHRMPQdt5pJ27LCPVvOrGaw0+OEagwC2WDMtzd+LECdyi8RDDDXsQXTNtdptAN+Zv2hGo0ieTfvGEKGO2xa9XJf7WKcUQ1m7QpfvS5xcgVSMxWgNd8SRFhhGQgFTbt5H+HSaoNDKmWKAU/f+uH2HOoddF43c+KoKzaCav7NiSPaUX+wGxj8l7AoFjB6yrbRuTEQPDt5GOSpqqKRCNg1dskdmv+SUAsgJB1xGJMbP8k3e7pssK3koS/RuFDrf9x23Y8t5SXLphkilDaRM5r64utsN3jbLcRZwNU8wl1CgB+fzcLLZuyDnHVfBM+RBSC6DpYNfa6LmyFvWeKz2+UjU4sDg5SDTtvVb+sPWMzcILQL5ml2fGE42W9ATGpMTtc1kBVFiIYJMpT9ORxKANyxRpxRuBW4MWB5fOr9SsTSOK8GJcKofV5fjKig3QBqZTNyHcXFxCQnxYrOcWSaiEAAOP5eYqYTWiLClFEt2rWP+qZiUup94LZ4xnFP3dzL1vKkiBMuWTXHsjK110LI65n3cPttkeo/YU23YD3N5UT5g00sKISVYlEXiy9sklPB1lJ6JyMM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|19110799006|5072599009|3412199025|440099028|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?28H5e/2b+PPbqRK6Suj3I4ObOssOlxBD0XoqQjZE26b8XDvR5tAmBlJ2sUxN?=
 =?us-ascii?Q?5K5p1NZe57tQIu4JtZ5Q8ZOQz8iJ0FW7j2iLvr9biA8f4id39XdJNKkHKjSf?=
 =?us-ascii?Q?PzYuztFiBm3cbrKM9Fm/MjvZF51NsarlxK0qrn3qy6UDYVEQlP5vhl1BOZdh?=
 =?us-ascii?Q?dudP5lN+W2mJae3NhuQnaTeuvkf7DO/eEVA9heNiom4/LUM/D8ZxDLopRXrj?=
 =?us-ascii?Q?WrQdeh2umy5YC6vJ+WL9sjgwSMJb51wgoPkSm/WSIv1N6M9KMUQC7DVD8BAK?=
 =?us-ascii?Q?f8j63RC6l0LUsDIVcjuXa2pRL4ot5R1h2lBjUoCU/UNdXjvwskVu8T2tT2j1?=
 =?us-ascii?Q?vGs9CMMtk3g+i+uCZJGszciZwj9nV3A0/g1GJ/B1xP1qz7S0rMMdhVONmcHF?=
 =?us-ascii?Q?La9gnzQwsjk7Ox3mrPH++8mu3RZIAPQ9enZ9M2Ur9gQZVe2reNoMelHq7X60?=
 =?us-ascii?Q?ZcdV9Facsm7GA1F8LFNQc/tJR5yhv3Kr4ypze7OnB0HH1KL+MdA2vvQ71gXe?=
 =?us-ascii?Q?hl+TXO0emQYOvtsWuE7G4fTO3YQFEHfgPmMCFwgdw/vL314n0H5q0MFf41S3?=
 =?us-ascii?Q?ncDwtyXlIG/fHWneZGK1DkK+2qRpyozHbGWqZrNbULfzE03VEETejrfmOmGh?=
 =?us-ascii?Q?3f13aqL7hrlr3XrX4pLY8GAlx7Wd3fzcLMyr/aNVKpUM6euYihtz/B9LRnU5?=
 =?us-ascii?Q?U3Tr6OCQo+1SzG1/RZWY58BDWTac4p6HjJ+9qHkNNw4WoN4M4PWHAYAFRpmy?=
 =?us-ascii?Q?gDDVtLh/XEDhLD2eJkxJOaKl8Diqlu80S3e11DyPsMULHh4imxZXPdJI2XIw?=
 =?us-ascii?Q?9F9I1hu1AzW89rIyRLaAur8HhdVAZsKFqviS087h2qe5hOUkj8baTzxsf51K?=
 =?us-ascii?Q?iERgXR877J4vfx0cFWTM8xFoCzCunuwSzalgpqBUb6PiUn2a4RtVCjUubd1g?=
 =?us-ascii?Q?4sU3zhKd8EnVRRlze5YlPMOB+RIxtS+CFKUCGl51QlsjVf8PNFJSVxpdKBxY?=
 =?us-ascii?Q?B9ERwbLNSYQ2Qty/jnvveaIvFjC7aJLP1sr7qH0PFQnd5taoVbYyOVy2NRuf?=
 =?us-ascii?Q?8L/qC0+w6GQ4/pW+DEkmKq/WMevlH8jvGHdnzE8EhapE0U53mFM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ATLRpYW7bFR2XgJ9gTxDJsSAiQOeMgNOb7k3C8X8szI9gnul8oLeVnS+xyED?=
 =?us-ascii?Q?JJDz1cvcX1e11OmpyFmcpexZlLttxPPkM7UyEo4NsAUtV37apzRIArjRBXOd?=
 =?us-ascii?Q?5fuPZdNZHR7H4F/jiooKXcp6QwVY6Ae0zEyULRibuGBYqm52jQFtvXG/BMr+?=
 =?us-ascii?Q?OLFYjGS987woLx6CU/78TdxMrwC1bf25B0+qnD7/0buPQzhEuMh2nIO8jfLR?=
 =?us-ascii?Q?T5JX2xgisq3tnpayO+6Tw3U20RPAkOgIkl6Io6Anhv/8L7hEmb1Li1RJD2Hn?=
 =?us-ascii?Q?c1Un+TeY0hCqOWVg4Rbd35ljdZX8mhYYcaBNC94vubPqS53aGYw2skPekFqb?=
 =?us-ascii?Q?FoKxhmzViF4o+zknnHiSPSMH1AoKLc17McVSTV1AzW2UOZmzQHdhwLpxTf2k?=
 =?us-ascii?Q?VRnDvAAYZNfrOSpWH6VeUjMo3zWkZZRpydsv+nttKHoPNSD1bOy2w0mpa143?=
 =?us-ascii?Q?j3B3O/5e3iXIws4J12Mqe6lboCB946oMlW79BD12Fxu/oX6glY9Xth2taIRk?=
 =?us-ascii?Q?Ez6/CtFvmGNRQDwP8Qc9B6pGvKV5tQtLFnowlgUO31NwxBzgnRhrfxV3R5Wq?=
 =?us-ascii?Q?N/1LweVM/vQhGgYu9GGL3mxmHFTpYdeWl9NoEVQUEPrOv80paiG0OqSTwP8I?=
 =?us-ascii?Q?bPBALSslzaOdeHhoinaJcGWuSgXlgC7cl+19S6qas29sAc9HYqEuseqo91vg?=
 =?us-ascii?Q?Vu7ukPmTdvk8FJ+z805qVtg0rcb13q5AFBCYl7qzvoX3MB8e+GdkBtTfTxoB?=
 =?us-ascii?Q?fB55Ma5PR9VdPbn6yt6nlAYYYw80rH2zS1m4AB9ugO5/s+rIzgv2RbexTHSb?=
 =?us-ascii?Q?mTYRrL+NaIZYidrOVrImEtCpVZrrpPC075tEVbFQdOBSssBMtfCzOdKJXS6W?=
 =?us-ascii?Q?GSttp+nGZdF+FrtDCNYMB1UR7VoXP1F/xRbLGoWSrD9Y0NfOcATSV8J9J1Lw?=
 =?us-ascii?Q?ltqq9d4/wP2I81EEzFylRhz2mQQs7vARCLuFigyZht+VbLeXIV+xYSR/yoij?=
 =?us-ascii?Q?VH5XCogCPqkRM0Hwx7ljV2uxYxuMtKKAbXgWYLp/cX6PY87WielZc+mj5rqW?=
 =?us-ascii?Q?NgdH4R7Pmgz6hFDGPt40DmTeEqMnFP421/DHp0hYvDNs0F3v7i0q5k/MF+fS?=
 =?us-ascii?Q?fTI+WGwLmCkvtzVHrXopH8l4zYmQSyE6Hd5aEmM79nhOi/mGdXzDfCh8pYba?=
 =?us-ascii?Q?CP0FyN4O8cq8Z1rEX4SydYTE8Xn2sTzuV4TpjEWBGiFLZBH7g5sjff5uBdA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d189dc5d-8b0c-4406-c2ff-08dda0dba301
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:15.1975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    Sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 3ffe3ae5cc..86d46395de 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1599,7 +1599,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1708,7 +1709,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.638.g67a2d115ec

