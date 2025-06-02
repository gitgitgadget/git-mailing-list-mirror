Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8728420E309
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748862038; cv=fail; b=kluo2SIxNooewF5mNv18lDtc79lODaweCwlde61OIae5y+1QnJt5IfzRmRgvXwUFSpZgji+8jg9b7D4PaQi0PjjCtO5/N3wjVb/OAUlFH39iOp8M/AcN7lRLABsj4Y0rWaDh9IZ7pr923lvtkM7fZtC9Q4Pxvyx/HaejJlRbl+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748862038; c=relaxed/simple;
	bh=YKVjX/ztvKmUXHpIvst/3CYu9RVJUtuxQ7FK5B/oTHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WDdOXULpumCTbWcCz5C/pUtqAaZuy2/6d8lhg0DqpzyvQZ566pD9j/7gBAIlz8VgKGdH5JVvIVcInwzsM4+m+DbRJhvSsCI7J8UYxIcoaeXiCscWhBQuuoiCRH/ag+oJmCi+rH6vFfuZXnuJjCZIHo5MeURzTyKcAUEpWFWPZx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uRUDpPKV; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uRUDpPKV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyTc7njA+Zgw57TMRudVwTv0ovBQl8akD4SF1K8xUer2x+761Q+yvBwQExUXyIIPUnlaFcwU+fJYupTTvrx0dmBG7RUIvzDJgsA+6q+s6LSMrf7lfGNhruSdaA3bfTIrMpJxMNgsC+J29T6s2rEwh8odIC7kIrpPQbli+pBLoHA9+pSuLPN4JBzFoJTZvrBx0EBf0VoOanSq2jBwBGM12Fs1TvblaulILeEIHbRPOcgqD7Vfu6LlNW6KiUscDu7HHx2O1rkErUjv58sPobXFiSVQwvmZO5V1721CcJ7ZKLP7qFszUsZJftmpoWIDl0FV7SnwtL/s365AJXaESkb3Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDc1AtnLXrEYmCWKZO68ZpXsCtnpHwbfsZWyjOQyUwk=;
 b=bq5PmtMOg4IgsMTEYm/axhlfmYkkhAAnqHxFkF47mqz4E5LUV7DagtsurRN+Q/q3xyRAnb0BK/nUIk1wA4PkgRBdeIm8Vlfm4IU/H3r27YwTAKicruilxTSgBkTy0KhCDSlTEXblBLYfoU32GUGq1yaDMv//FhH5SxYA/8MIZZNUKHzM26rDUkpBxNYbO76yn46gnd3qnHU/fT6zns0+ncQ7u/XrwmIyxCtauKXtGDov1Of1gqxGN1SYiLrPTGjhkSPU96GSVp3aqER8VRZK3/HyCg2kWGcPrSk/uIOSCagjr8a3zn8uwiKNcytpaj/31M1PFO5WswV1GO8HVm3DLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDc1AtnLXrEYmCWKZO68ZpXsCtnpHwbfsZWyjOQyUwk=;
 b=uRUDpPKVY4XGbghjpT67a800wE0cu1NivVg9j9uKgSWq1gw6gFuB+Mpja2FzJbooOijwpWLVs0/xnTxRowt3u/V1/horOh1s7MHttz40BC6sHuOPbrLtMlfah1Fqw/i2rPIyChvNicme0784uQdegYKagRJsd0MxAL5Gbv8rmbvwgfRrtMl6Poct0G5imfvhycCgQR+WNzFHhwj7CJ8NmrNTBlWe7Jz3go6xnU0qU5PKqSDbVKDYI8rEv/x5PDq24HoJ6EM5kL0SvoHf5aIhC/GX0QhI6HLnisvXkaF2Him+ic+Dh++iWiFUK/GpdBQ+bB/KnENi1oC7wNKAcFfMgQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNYPR01MB8176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:4b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 11:00:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 11:00:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v12 04/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Mon,  2 Jun 2025 16:29:35 +0530
Message-ID:
 <PN3PR01MB959791DDE729A568B62BE4D8B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250602105940.75439-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNYPR01MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 92bf6742-6db9-40b7-6abe-08dda1c4ae92
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrN1Uple1Eat7kdR7nOrSpOlbFyfFeKPuQRaxOy1SudFSwX4rtUq5QKkYZ10F939MnS+sOoMP+5AEuu/7SrEdbnl/Elr53DsBQQQVG+b06hBw1UJq8fjO6vebKn9BGoyxCqEviCpmqT18j8vgUVDjC+2Vc/zS3Guy7gWeBUz3mEiddLpepmX9VrNJxAHV8rKt6Y0Ch7R5YF8WL7KLpod+zuIEgq0IQH5ITakJhfOIBfAUEp4e2uj0oZsnjARlNaSpsScGDjtnWw/2GPaHMN74zNxhUbmCLSfofHVBU6//SUkU7UvnlRaZrObWz1o6atnF8EIuOS3ZZHmaHbMgNA8o62214WJmd3AlhWVBOzPWxYlKHaVY9iZU0YYk75ozYf4LoH5WQgkkmOQQHphiV9ds/yYIq6I6HSHi8WO1WSgGZFPNs2njmn96Lm2ApWCWf4X07De6Zytuz9PoDByCfpxldG4zX4vERX7/lt5mObjS93KR2Z0di7BiLYcmQ39fyONgBOHBLZni+YJNpunwXmHStuGCdTEDX4ZyuIykAHHBIZ2tyhiFIC7p0Fe+puFvY8fHnGoi5caHX3x16LKzx1E5hos6BRJEox5nDZoDPXa7csbyZ1bCU5fv0ScnfOh8Fgl3O9sy0Zg/YbN7QYEIrkyNyz+4dRxxRb+964GEMyDuu3NFrDAr+3f7B5GAJt0QHXQ/cmnC2gmJ6YLkYfprcir5Q+Mp9pTVfCQW7zJJJ/6ZZBKuYthdbL6GIn94NjUXVpuYBM=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|15080799009|19110799006|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v1/skN2V/zSp8vDIhMztuImQT9f0brZJXlmBwQMUcPhthD4aj/GCY0VhH1ZJ?=
 =?us-ascii?Q?6q9zXFJ2hTKgur2HVaImYHMZ2Mv/Fp16z9NC/NomcMS+b7Fj57h0ScLRbY3h?=
 =?us-ascii?Q?5FaplnQ8wgkKSFtel8niRjDCDB6DRA2VZ/QoJfoAYvkeBqxm7kPH4sWOvdnD?=
 =?us-ascii?Q?y7/3/8iXBIT+vAzCW/RUChZ1AD0BT6gKYNG9/AGih7bD91c91RMQiBjIna6T?=
 =?us-ascii?Q?lEAxEGTIql26BDxsjAKzUNTkhU/cxiyOzqRizfNmipMI/lx6iEMsKokTfHN0?=
 =?us-ascii?Q?tIurrB/UCDOlL9iFvEmuAxpeiOr3CePXuKUv0QW8HfjWGuCtffdf6bu2SJl5?=
 =?us-ascii?Q?X6WBwOG35ezNfEb5kHI0UKkRoR8Mrt9MNNY1Hb5mrm0Np3h3Vhxe/mJGW+x7?=
 =?us-ascii?Q?A4sAR3KTUN2fRWDCOswgpsrVlT0WkoVmI/7/abB27nGptEKedH5uj8lKBzPK?=
 =?us-ascii?Q?cqQTFy0TOxnkcYwrMgGh1GMP1GZ+zwpoQ92TpYdGgOyNBAsGgH8B/MjFZXIq?=
 =?us-ascii?Q?eZibsqAkytneKneCsEm5bpsnRb5S8/uvkMxCRzT/hBXy5FUAuBIIL/HBvUoc?=
 =?us-ascii?Q?b0quDYjFE0qWXJuNL07CrrQXRM9qwZ9Eq5WKNRkaviIt/Y050xXMhYWUwy9v?=
 =?us-ascii?Q?3JET9jsWPGhe/vXvanuCQhwSgUGky0rLveCiN414UZAc8CrJStE4B2HZ8ypZ?=
 =?us-ascii?Q?k0+G5IkMf9uglD+R7hcjDmFQDsPzgoxCr0M4oqLY/9aNhlv2O0VMJt4OJn5S?=
 =?us-ascii?Q?1ghOVRlkMNljfpwk1uupRaMPgPdF2BC4xXrlfNP+H6xs8SUxQwMOkFrSiDmf?=
 =?us-ascii?Q?K8Mue9xd5+qqSBWGjNFp6JD24auDbH2OKAShU9dt7Kw8OLuZHr3iRlg56Uhb?=
 =?us-ascii?Q?SjwHalXkUDfX6DIRymOLyZoFj/00Fnu4nU17djJwcUM0dxH6RbLSYvwHEIIj?=
 =?us-ascii?Q?BFeB7pQpRy1kkw54VOn1bcBKU+t8WTBZyyf8zhs58unYq90QULrGSxqoWe7m?=
 =?us-ascii?Q?lYkQ3ehfVegdKRCZiVovx+m1WFfepUrvAI8cu9jL4zTxVCdMDHMTDgColu8v?=
 =?us-ascii?Q?bwoqDFSaXlxWtLJ2rcoWUfRRY3vkl+Tgw78vm0iofjCNIwTYyNmnytk85G4X?=
 =?us-ascii?Q?gsCkSGrKpmOSoKn2Aag12f3218Wacya8fQeHbp1xZ9J/uKfvBFnOKRI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QdGPhjOrdUzFzc0xHTbjg+iLAsBTf9Hgunxx35/q8nDEytDKdymddUk/deeg?=
 =?us-ascii?Q?KbCP6vTNBQs2EOsCY3upfnNP5FWgvcRSQrcyf6BxbWWfwYMPRX+rXLkUeeL3?=
 =?us-ascii?Q?n7VY1VFjzz/2OW+og9O9BZ8OQx//DRLifb+Ud5p87HFbiGfJJ0cItV/44c6z?=
 =?us-ascii?Q?C58+lLnAxf4L/2OBaf7Di9rkUy6LaIcdxAJk10h77rDNFaNp/4uQio8+vnXo?=
 =?us-ascii?Q?9dz8YDRFq+YIiUj+UitEvyAIKjLfb7xwLG1JwZrZVR9FOiyPJ9myt8mDIuZJ?=
 =?us-ascii?Q?C1Ii8YvzQCWdQxFYUBuD1SqtYjJBTQBg34Cls1lWWA+JCdoTc8cAMCkM/7dl?=
 =?us-ascii?Q?aMLurQe4zKU0tfKlWN6rA587Tp80P+hWijBSADIylHVKRIlUHV/38uCBdhFT?=
 =?us-ascii?Q?IQAtzSo94VJbL4zWsdiJvwEo1AX+TimLMEHaf0dx/hMSsCnBqZSy0ESf5nM3?=
 =?us-ascii?Q?Ymx4vfnarc+LHxe1S/a+b6mS6BlIWz+1hmk9vzHjlfVyi94VEFh5dcuwQnM5?=
 =?us-ascii?Q?TJ9JWmnlfjfDJA2SJ5iJ+gJNh3+oAiweZxrpG6e0IVCt3w+mDXZAywh1PYtT?=
 =?us-ascii?Q?DZw+7XXWPWdnNuNG8X+VhfUKj6Na/IAuX99biHcJqxBh5VgBI8c7aiVtUGL1?=
 =?us-ascii?Q?u6zGHdS7kKS+beV//Sq36a2+1BLh3YyUurAe/lhqgDAz9I0rXhkjA9Hqz2NB?=
 =?us-ascii?Q?PCoM4TYJ2mDFUotsr8VDF0jE8Gk5Ul9VRExjeGJQMLmYXpPB7liWcMnI/5ru?=
 =?us-ascii?Q?RD86ckMk0WzWHFKfy3qUUK44NPgKZ0YknRyn4cSTbMl9v5Jr+EWKGIvX297j?=
 =?us-ascii?Q?Hl6qRU6mM3QiAmaOFq81uGAV/D7XgJLpZrkY8vwOoCX+b9hTzAAAWjb94Eil?=
 =?us-ascii?Q?qALaFrA3nZUZ1gtJitwY+vSEg9xQXp+VhHeNj6IZ+vC0Ak8wi8PLtU1k222B?=
 =?us-ascii?Q?ftNrnTg2+cG+573oo2gc2Gn4dMiWy7DifGWuZVBaj8LNbj6tBqXqevLAK/o7?=
 =?us-ascii?Q?bjZU2KrVUpcb3cypPx2VQRDY0atjD5xNmaxUB5zhi4UP5E1mHu8+vDHzG3IN?=
 =?us-ascii?Q?KDP+7sVFZLMZkyB0Ylp1f9ovm6M6dpXVXEmzRTh12MCcln6YuCN0FygAYz9l?=
 =?us-ascii?Q?yS7zjo7xj62DhWzSkyC4nKKUud+eerIvKBU3Go3My6QgVoWS9OWmA/2u3zDA?=
 =?us-ascii?Q?xK35TzMwmfb7uODcE8Aa0RK64hxonZpJC5zfAxeLeEjcxmpQV5wPjEnxH1L7?=
 =?us-ascii?Q?Ma6fmIzxeI4wQVFFKUpCSLveEXRX8uIeiSwv2qN03YP7QrCXBoa6ys5nsaxA?=
 =?us-ascii?Q?thxEAc7aLyQasBAfjOEaKoBR?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bf6742-6db9-40b7-6abe-08dda1c4ae92
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 11:00:27.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNYPR01MB8176

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 67077c2bd2..5f31dad3b0 100644
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
2.49.0.639.g36d50d01f0

