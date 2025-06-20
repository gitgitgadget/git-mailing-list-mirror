Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39925224AFB
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401671; cv=fail; b=d/p1gcAyzaXyoDMgYrb+iy+CCr5MpvAIAJqtGQdTTdBrk80GCQk8mWWWUKXxG4BMQdT18BwxrG+zMXhpFH6wJ/HXU9uWEH9kuHrt7BOC+yksIr8EVUlZulNoTBhsgaI2cZrhpNgIiT1BVQtYnzrZx1f11wnMX054VQ6TpYPz0RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401671; c=relaxed/simple;
	bh=m0kwimgkQ1wTVkK7kGZShKEpW+MBH14ByaRx44sf0QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IhvJh76lzrzAjlUpsLDvM/hxUv5ciKjl9inIU/M6vD7R0/cbbvxgf2XfugAoT0ZSmnIP51K2KlVSCUwvGSt5ogC3xIVevnPuG/prBOqveKNH0QpmQ7ghNC27NevsFjR3j781+KIpEXh8FBQVPSzP+MzPdOgq0wfSqKlDYv2B4VA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Tg35kgV0; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Tg35kgV0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BugNujCsjPT4dL3S31ZLiIoWbhxVOV+9esRpmYp1zkTyrTN2DgcVgLzlgiUfUTjjSf3jSy+GOl00Tau5LtQrvAXjNBa+ovyD8gVN8DRdal7FMQ2vpzo3s/QeAS+xcPpD8+DF4MH/vmekXAM21ZCZQyLK7L/FP7pHCkkfTi9vMVu9d8YGu9/189txghdLULgU1t8zzZ9/F/3pSED/8Ji/h3VB8k3lPMY7cAFJRDoZovETtrDr3F3Vn0P3QUbf47zvBfhHDIWsJjdKmZQ9Z8cF71kJZYeabIHIIBqQ0LnGVMX8jQuCjuCjYHLtyd/RZm0YoiWWe+xe8mvp3FpuljgpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9QaCmxovoN8kHSqn7tTitZEF23Xn8utP60rsSwIJ7g=;
 b=WSmFw+DyVkuoMSxUo75LEkavrCgMWkzqtQf9GapHW4itY8edPrHJc1xe39YVnCBF+bJTud+m1ZMmPWl7BSFoEwDqAOl9azU3Yox/uwv4lKj/c6JkV6XjtWuEkR5mKtQYEgN14miPIWS9wdpKnTxJGbsE1eZ3KCP4jA8jAy8bzHapOO5BzZiQsZIIVneqTxFTM9nHRqm+ZPOuqHlrGKeavUfs/xn5/fRaKaYoueMv/KN2qSVa/HImwcdIu1T/oDXKZgUTdBz40QCaig+Af8LSvZ5dg8Aw9ITHPXbZ2UeKTvp1lVjoUMukZT4I90mtGSyvEy1t7hvVaI2PRq9a0bVaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9QaCmxovoN8kHSqn7tTitZEF23Xn8utP60rsSwIJ7g=;
 b=Tg35kgV0iktzXjsAJBKk4YunSsz6tVVUHGbVlSnWDYgSF5GEcwEbHhIRln6ZtpuNL0MPc8j3LuADGVnk+J9B9u6gjIu0Ge1SfNV56ejjJ86NjcJazqHsmMyYXn35r+uUi7eE5hy3edfBhFaaZv/6RaLiqNz7JrKj6PhC8MzH8/gPU0jjp1V22DnQn73EFfrmYUaxRNS921anFL8MXZKkATk+92COkNfvhk7Xetip1Af2e/TMtwVUL8tdlVk4JkZGv8dcrqEuivAdS7qSljFlreDHhX5cr5pBdn788FoaK9g2IelIAfUu1YN3vDCJXEpZaOMXOZiJ5Tz9Tq8PNeJPBA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8150.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:58 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:58 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 09/10] imap-send: display the destination mailbox when sending a message
Date: Fri, 20 Jun 2025 12:10:32 +0530
Message-ID:
 <PN3PR01MB9597478042C9DBACE0323796B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250620064033.15814-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: 67196666-be6c-4913-06bd-08ddafc56850
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|5072599009|8060799009|7092599006|15080799009|461199028|40105399003|440099028|3412199025|56899033;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iWK419OJc3W6mTJpDfEaDR4XNZqS23DEJKg6/v1t4B4MuVPoXlhc02irvW2P?=
 =?us-ascii?Q?2OBMh7P0SIoOha8XzSiN2nCNM2vZ6hJuwegNPvXupmFC1TAR2INKpjElPr8o?=
 =?us-ascii?Q?q1wNPRtOzgLeWE4Ro3iGxPhkLeHdRaGSFvulI1nRadfFo65R+VhwEIghhrmB?=
 =?us-ascii?Q?fjTWptS36dAMcTLNl72Abis2x/voj5m+Gi3LzUTUgExxaWWeifw7RSKi3Tts?=
 =?us-ascii?Q?xCfv95Or/GoOIub/4vH9AM2h3fnxpeTo/9J2btUGe2Pl6a+GIkhpz/jL+j/O?=
 =?us-ascii?Q?M+3sRq/SCkJYFwdbzytt2ibYvV40OQb6R2nQmioIul5yK0iFLEZzKx2qx1cw?=
 =?us-ascii?Q?XbpwvwFKMEioDmuzsLVTq7mt9QYmFRPlGve5lbcYgWJLj+JLlE2EM8bPx/sg?=
 =?us-ascii?Q?oLD/Cdb3jcm/+v8PRv7XP2tV6+mhb2N6JusM5cWPfK9b3n113KTeFwQWHaAO?=
 =?us-ascii?Q?ixwBnzVkJfoPcOnkZp/iLX63lsMgjxN7Kg9Sbo4+sgkQhA4KxHLmMR+uvpb2?=
 =?us-ascii?Q?KHN4/g9NQRfs2Ov8WQAjaBPsIoTMM5L0crdGR1mDW3uDftOK1C1vwwDRwBEK?=
 =?us-ascii?Q?4iPdamu1bI+WNM2j79Kolo/JQCQc+vLKu4US3k/zVPdCRPfZxem5nD+I3FIw?=
 =?us-ascii?Q?dBhTgZ610Oc/+2lvXgwXdrVPNfeuMKtLTJAs2MxIVwJXbrQoATV3H1pgKJ6E?=
 =?us-ascii?Q?fLXto4ylX5m++HTD0oiscJO1mPtnXsCLwtkdSVTqn3OuUZzmOAV0c/AjEL49?=
 =?us-ascii?Q?5s0q8vQNlrdk2joNcoXg7PbarzC2QbIVkzaR92egqk/r686TEuDeI9R0pgm4?=
 =?us-ascii?Q?k3ZQ+3nuWiX6kvt9TJKehlvfrjtkN9TTXzIAya9KuQLgu1q67cWIXNesjlLM?=
 =?us-ascii?Q?MCm3CLiRymdZLYXzqaTnWuaOokGPJtHgRDXQLc/sb3X4kS6B45Ib2qf4QyCI?=
 =?us-ascii?Q?1fff34NEZ6MBpxkp33fwzS6b7WFxksTOR7mhiBjzWHB8Q8TnlDizcik7zL8b?=
 =?us-ascii?Q?SR0q2WohzQE0E3pav0Zyhb2+XHvmK+LsOzIiaSxTu6x8/UTADD6R80fo3302?=
 =?us-ascii?Q?L5fFxBgNb812FuKhOXrMsYpyIm0PxcjvpYjrbvrExPYy+BS5Z7zCqC4ZYCmq?=
 =?us-ascii?Q?rJkn4+f/wrp/UNMgrpvgNIw3y0HaNAJDYA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?61pLGgyzjJpoPWNiMUPKAvnFRmcZcKrKg3eUmM5sRPteRmJTeJOVfCx7uvGG?=
 =?us-ascii?Q?+U7QjgakyDPXMPfqBObGxhsQJ6Q0ekN49sExX4diEK0s0l5fuC72H/kH+RnE?=
 =?us-ascii?Q?9kqwHNkHvbxFp1acerA8O0aMN5meHawecyucRV0rTAPmXg2KMBQpn+AJ7ahh?=
 =?us-ascii?Q?bR4AQ5ZPqLPS64A6KgL9xmdNTXQqkIoCrPg5CMMNQUSPu4Q8dCIe22NYBGK7?=
 =?us-ascii?Q?A8Tul5sBH/m0OhqKePYEQZ1acuY3JRBwXL753JQ1DGm/VCs4HmZgYwKIorJv?=
 =?us-ascii?Q?ID1nGA+p/C5EP/YEtj+OVaQt5Uzu9qcuS9Tlv9UvGeLG+nph7XHThdqrgUIq?=
 =?us-ascii?Q?gXyW93E8rzUE+HgbrSIa1CUwK0vcG9llL9xT4ufN/1FMfziK9FtxwPR1MwvC?=
 =?us-ascii?Q?wWWi44oiJrGiVnRcE/d2BhYOayUhuJ8ajT9C5BVS54BAICPTRYFQPps2yIeA?=
 =?us-ascii?Q?LJTu8qW/0OvPOqaLOg8s7yA0lz/5zh1a9Lf/HPiNizR3lrf2puqotgh39vbs?=
 =?us-ascii?Q?kS3DbmheeRaVI6CZuKFuvBXDDACy1yEA4aQTVtOrd0xDi6ADTmErlWvD/pRR?=
 =?us-ascii?Q?lHx7qcwWcxEt8kfRSfIlqM4YLnG5/U3TD86ag8jD8PwhlkgpO1/79zNR8aMl?=
 =?us-ascii?Q?+L4ki5B/TOXrqPkgmxR8yIT7ugSJ824Eiw1LUEUHbdRSnDHKf5qyazgrVY09?=
 =?us-ascii?Q?6gBX4y++BH285x1RzCHsRuI9SHM58iYwbdnPp473h0hmqm1fNIEw2g4y4ONg?=
 =?us-ascii?Q?IqoAhQWJrum5GgbUO2jjRZR5hbo0/+TItMNOyg4/I5RYw8fUr1qJhhMTbJLB?=
 =?us-ascii?Q?ywPiej1mzhmVKgAUZD+VhvD2/fEHqd/3iRq5bHl7J7hngBo3Race7JQCGOPM?=
 =?us-ascii?Q?Ggr/sTPvuQx4H4+mqfHTPVqaTVZP3BMMEz5pMC3WZy65FaDlI1MtSOCht+3k?=
 =?us-ascii?Q?ZTAnyDpXWMtfBF7whwvihLVfLFsKOT23QORR/+T0mcXVTFwFEjctK3Gvj/Uw?=
 =?us-ascii?Q?r2129jv3gS8GRzETd+dl9MJUO6gpeIoY6iZpHQ8E8VkP/SEqSAlOt77XXCSh?=
 =?us-ascii?Q?PYgepiDbx/wkiwdBYNzP27UCT9EDtzhTb43ZLa/ejzijbbhc7EJRjAxiGWKG?=
 =?us-ascii?Q?w741OsyHH8wf4qxqYrhzXYyMaGczQiPzpg4QEO/P+gHaVZqL8dXIJ4rODpGL?=
 =?us-ascii?Q?6LmGt5grofauGpx+ZfzOxzVwcDwsRNGxtDpwhiThn2YiK2I3t1wRBFFfNMBT?=
 =?us-ascii?Q?HAXrcIuXTYoahN6WmnhYM21tFFprZW7Hxavteqr+3dG2uCYTtOhN7ZDIvWaz?=
 =?us-ascii?Q?gAE=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 67196666-be6c-4913-06bd-08ddafc56850
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:55.2955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8150

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    sending 1 message
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
index ef5cf0a395..11a19ffeec 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1556,7 +1556,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1692,7 +1693,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.824.gcc76007b2f

