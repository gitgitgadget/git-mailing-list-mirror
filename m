Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D634218EB1
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240542; cv=fail; b=sRlcNOwLgjTABQ7ALcZSzn8+xEU2jT8BpytP09KTRT6Jm18ZU2nNNXlrRa7xDz/2N4aisSQfmHin41HU3pq1JuYRCa7NXgM2+4i318Yi8AsumoKQ5aVW0p129Iod3AcBhOFwJG9LDtK5lhFkU8PoOkz1l5cN1+a9rlYPOPd+NpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240542; c=relaxed/simple;
	bh=HQCdytBI+3fBlFPCKSGxLPDr4j97p/71M+Qq13OOeWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i0ooYg+rsFQ0KdBu4g89IhJEpfamv9pg4tgclk+blVilTofqh7oG3yJy2algXfLJ9NxTCCs8wkIIAufe+b3vDx2wat8AKB74Cl7MrC40WAUMkuKufgNqEJIrRLdc2FjdiSKvNlZEb3rc7Bjw5iLHcNo8/GfFkh2G04Mi9fi8Ec0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=e6l2NxJU; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="e6l2NxJU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIkaneWx+a1+GcjxmnzbfJn4eO3hehuhWywRTVHQ+iBnyHoxfbLPv6ttbQJdXFR0kGxrFLhbAIt4iO3AfrcYM3hSQdtez+wQn3xpZWCkCgNDNVbR/dQAHPMOfDkUxR2E5ftbA1dDswMDDvi5j1FF9aaIBMKRhUN2ZQBMJgeIphMTmvUC05yJAldd1Ml9ebx6NnCCwWM6J7FvZiDB7gkxWbVUKq1WNH5OVastAByX0wliul9r8GZb2Dr45NEh6HsAY/TUPo0KbeqN9m3Zd0C8UpwCAXKa/gVQRFBP4e3OBCXh1qe8CULZzwwVLjd8wazlDfl7iee5ymh+MLrePz7iMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N/zT5t4Zhh7WlD619xPwF8CpIwM0gccly9j3NVzLhDQ=;
 b=adbSVZsr00ImYDWAM+OnNHx4pRnk4ZAHbwnjRGu5HG+2g6pHAPX2lRfvLDHK0Xqp9sEtVGlOuNWsYjawUKnOuNxtXhUxmLXftPXc1AS9/2JiH7tOdmfTrkjcmPEfxePgLcoe+G+MoL58vm8K/2g4JrZvxzFtQ8PhOwlZ8bC8zAGe9mU2lqsFkxhVPmcEDHTs3ZsuGlYJNOhkDp1v78DM7B7+161ebA6rScQKAoNnVSroWSmC8+crXj+ylsZN8LACujSdFLcVn59vYbwZ+dWdTPYfCFwhwX/CIsLetWjhCebcufPxS36x71+8frKDNtTIb8T6N+quWkjea6YsaI4JqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N/zT5t4Zhh7WlD619xPwF8CpIwM0gccly9j3NVzLhDQ=;
 b=e6l2NxJUep76ZsYuitQ0fPvP/pSBgTWsrFWcTv/UMTrkAb9doi3lK4cV08mkUUyG6RNLDoA3Ntb/NC1TKgfFZoihPtmdRM2ipr5ucGXUcZaajKCGdroXLeirSxwITosMOszeI4EvYugnIY6gln5Rbnr2XwLgHvQI5Hof6AD6HXGDFovC63aDkXgNAUfAUvTlNJl7bdCYJYHKk2YI2u33cm3IWC59D1l/PmP2fpcbcHJ1EiXG+nsaAG8fD13MnyZZ76x+ER0Zf7eeRwzguwlZKkQceyirD5Y8KEXbdCjzK5UXLJNqYlUeG3EV/Vy6KWKE0CfcO9OvaKJQP8tfRz8LLg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 04/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Fri,  6 Jun 2025 20:06:26 +0000
Message-ID:
 <PN3PR01MB9597997B73874E410B64EE62B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: a30a12e0-8d9f-45a4-695f-08dda535f37f
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkO2pwN5gSLB/E5LTTS0M+bUdMzRyTzamBnpPCkGKNaXdXmaBurMNiJgT8H2ui3yMb1+LQkTQd3OLOkpjDLzIRraP/4JqZcerHeDCtW4QszqV3qGpM9BQJkjJ2JYQ0QqEp9R3sDf0YX/m98TYkvrUR4ItTrvRdImKV1IRkuZ6H77aoGO2Hq2AtrzerT4NBM7wm55Jah41ZDeWvE2QXCZrhL9aJxe8LuarYtuFRIUnApJ9Z1uegJt74FK3n20riIs6ZWYJHxEmNihai/j3OQhlLey/oI4+MKNBZe01+Q4GwSTYoYFHANnqh8G+uMHCzLqfMOiIvEmTLPQ6OtMlxQsUBbCVbHkXh+n21pbmhMA2D23Q8XJOGFIHmoO5GVRVk+srzVElb4MdcXCmVGMoY7N7UH2vRBLEqzgV5DmWjPdw9PCT9slbfzwFjRihOP4UAvEF/tvrjT6ubzdzY5J+y3hW444M0EDOR6IDcOp6vJpCIUgxO2vgyhtY1JlUsrDA8b+l1AOI2Gc9biqO3qcCKrhipkyfEJ4RIu0Sf65GX+FQAHhr2SxvSvfY/3LLqAx+SmcvmL0oCLxB0vYbYozvlyUh33mnmzap4ZaJMCdQKT3BdKo6mXfKRCsuo7pgAyQOb8jKkjCFHWZk6qvwsffOLDz+mIfR0CDIBTKP6+6HqmYabwA52+IufPRXHFjVxxLwpkG+GLGQu2H5fU+GbvcHqX0qyrT3sCAgWwKGfiyH0RyIulxQE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?msJrjhhkpuqM7JuIVzg1mNw94gLmvFmFrkVGJc/XE11hfCJaIrPkMfMDNB/Q?=
 =?us-ascii?Q?k8XViT8n9VVhb25CwOeLSV6zCXRFiAg+5uAZo34fHr9hvSxCrs1qZ+Qi7pXp?=
 =?us-ascii?Q?86fYB27Wcl7mMvCY6o9mAER+K2OuvNX1f4NqT5nqV45UX7jsVJp93zgyJO8N?=
 =?us-ascii?Q?ZvVhpdR/xgef5b48Ut9OJ0Vm+8xhIpZOqp4vUaS/iqsxpVNrPDuvgHDBdWj7?=
 =?us-ascii?Q?cXKHEhML9kPruGD0MeOtmZt/Q+L/okpUNTlBa9RiTmW4p9S37wPmPq7QexJd?=
 =?us-ascii?Q?f6c+kRmloaMA/FTL4CF8zOOSBINtdN9azsooIpmzQWCGilktPZo3E2g1I385?=
 =?us-ascii?Q?ds/I96Z/qbau41tGQdLWRxGWL2r8eNrDvLNN8uSx/z0HkUntANH1ZP//zdg9?=
 =?us-ascii?Q?wYklKrzAvAxJo9p/KlM2GS5XOKR6k6zr+9eIufXo/vOK+KsWLDnCgzNeRzXt?=
 =?us-ascii?Q?pEdNcBYnBy2M2y68thJ2kAFIqZx2fVZkTfWI4RKc1WaEpuCrTNFAaxio0Jrx?=
 =?us-ascii?Q?JnbJEhxXSepI29r+i1Hed1hOJ7V9PMCGTO/wJf7kKQBeDfIRTr+rUBgB/sPB?=
 =?us-ascii?Q?tYe+AuEGPs4y7soMYIEDBHFRoqiZPgtOk+GoxNguwb2Ibd2Xiph7vpyKUFDU?=
 =?us-ascii?Q?e04RrG4H71MhNftUE9m8MBT+ithAmaRlFHPpdCeMzJfBmEj8Cv6Wwyv457OV?=
 =?us-ascii?Q?Kz26f2Z/OwhEkOK23dufZqNYBmnoh0VJy9RIBb7RK7YXuKIvefaHgL6UG5eH?=
 =?us-ascii?Q?0ULprelKBSCn8pAgUUfFRfIjw6mEF8MCoQl+iDIDwwKwxMX+N5vIwLYS6Ons?=
 =?us-ascii?Q?EtJm1lH3V1qI+dbUG76Y1I02R/2F7nayL9msBvFW4whEgnzch64oHbYj6wy3?=
 =?us-ascii?Q?0E+yNxroDhvOW2QjH7Bbx4Gzd7To4LWMbpoXk6B3P2WbZcVMsSGockSLYg5v?=
 =?us-ascii?Q?tVAaMeqIH8ARaGbLQAUAmJUxBJdWIFAhPDkXF4Ou284DvoxO11pvwvWhIYTX?=
 =?us-ascii?Q?8RdaGUVAP/G9MGTawuENtioNiOSycdoDbqxTl+5ZZuzG5MlqPZzzk7EuIwXA?=
 =?us-ascii?Q?GBsKRK42eBopdGeUjgkhY56f+xLt3Wpgcx53DmrgxuPAjD2od4HsIjQb0VTz?=
 =?us-ascii?Q?kqs697/YDoYNt5nLC57cSqkLaIEanmN9sJsytn64Y/T4BOEfmhyauBQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mCCLthmjR+5DpeGIjfCUNpNQiQeNk2EyTUj8MNxUnnO9VGJM97oZEziligH6?=
 =?us-ascii?Q?gaoMb3WLbkvR1s4fM7RL491v2A2s/QCsK2EG86gZrqiXtR+bNNtYGgc5yPkP?=
 =?us-ascii?Q?HeomX5zcDKFcVkwAsmEM1+u+tZEMxa8xJHG0K+AZvjcFxdpWFsW7IHp1DhGx?=
 =?us-ascii?Q?1SLAI4COD4OAeoft7t3SwC/p4Bm8TXOi1QfuQwoAJpdA+7+52Yr7bMYlSKbi?=
 =?us-ascii?Q?IrL0+I2uklTVAW7lHS7XzPftNRct6PSeNvmbmo8tEgNxWx8TJZzHKVgjGM1y?=
 =?us-ascii?Q?Eyv0FJh3G4kL1h600hLwyaxGvsL4FkcWXp+UAkUyyhHNCQ5IcqfRUbzNEPCE?=
 =?us-ascii?Q?00mYz4+H2zvv4Otq9RumcdUD0O5UocIrThgW7x/iEyWguEvPIFOLnhfXky7h?=
 =?us-ascii?Q?GZ3WFTTzF5W2kGHSuCpEbObHZssHHD5EV09+nHhTEEz3RXh2C7VJPRSvdFjI?=
 =?us-ascii?Q?Q/4MXIQVET5lGfn+Q/scmpSlBaFF9j3yqo0BBBEPWQqGuzLPe3xJ2lA1GvQM?=
 =?us-ascii?Q?N1hvfCRDUObJtFq9OulN4rWl5s1dBlif5zFCVeIrPe4wANua5NvJ4GkgZBFA?=
 =?us-ascii?Q?bo7sz+Kf4J5oinyrSgwr9hz2Vfq3AsuKXlNOr7OJ0x21ny4vVXh7Z00XoscO?=
 =?us-ascii?Q?7Ypr5pGk0S4jnd+WSaBzfWTQDpN9XM/b94r4LQL9uh5A2JEO6wd02RNrxicf?=
 =?us-ascii?Q?qHQBWoRtX+H4sGs6nM6YjftSgJ56Mm31kWkj/NTSpybBx/4mICmHwNDtitPh?=
 =?us-ascii?Q?KjelCRftrnkPfJB6h2EHMpWeP5EibVflCR+V3PjhMz4IwlMBK3o4WWWWld7n?=
 =?us-ascii?Q?PfCylWjVtHkt5EZWaiHtiTkLfVVu7ky/V0eKNoUJVqOlFdDtB/+CoCVxQDC1?=
 =?us-ascii?Q?YFrgvJPo0rJtvijdqc63oIyaeVYwQwEN345cqNglK4tStmwySsgFbSLBulg5?=
 =?us-ascii?Q?siZVGu6fB1F9eEKDiBJLSdCsa4rAyBd5nJcdu9fc2vjlLsgbeZHJu+jqAP1Z?=
 =?us-ascii?Q?0o3bNBaWFiZfUMLaM0j2PYEEWuo2Yk/iAgfgOzyWI0iiY4bWwZo5kNzPNgS3?=
 =?us-ascii?Q?WgzW/kPzGjv5SpZUTzEHgR9gBfiDIdO4D2/EJCBMKWxCDEQuLVLda/tSl03x?=
 =?us-ascii?Q?hgBcCm5QOmOqfPMORz+ZNR2dd81jBDNA7UxyhrPDm/oJ4LRH4hnomsgaXnPK?=
 =?us-ascii?Q?7p8vuJfalBNlGfcTvoF5eQMdhKv0ksRpmnuPhfGEA/GFCc+1YxbUP/lahCk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a30a12e0-8d9f-45a4-695f-08dda535f37f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:49.5955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index f7e59397d0..6522f80964 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1072,8 +1072,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0

