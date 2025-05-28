Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011034.outbound.protection.outlook.com [52.103.68.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443924501C
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417934; cv=fail; b=Xvfk7b6cms679wNn4g8TNR7V512Hzdcn4DdwjuEDHsVcG17AYe+SEXeUXqpksu/3O/CLHWz0/794S+V/UCK43mkWlyvomOBCE1KgZYONQXRRLP/ubcLSOUGwr0FQd2VMHvrJtd98WDdEo94tDWm2atTuRZm/GwmWYH4v2hMzX88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417934; c=relaxed/simple;
	bh=wcIT9va/UJe7Yo3W9EzvVw+3oZEarrpZzgxUYRsGsxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MFT0Wn1NLw/6Trsr24A9i4XD4oW4Cv0RKa549cCjS2rPKn4L4QMAcpSy9DVhrncgM0loDxzo0SkQkLrF3+zw+MV9K9k+5Y+WErTjnS8zAloHzCNhE08SacA9qvOCQgfjyumWYhF14fCMKcxaAWR47wJGSICytsCoA8OSa15j8Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YQd4qT8h; arc=fail smtp.client-ip=52.103.68.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YQd4qT8h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICljtcO+0i0tv16Rx3nPLuGjB54Lhb1ejw/5e3Tq/86ZC2d2zESX5eh28h3bVurYups1b5tMRlnRF7jUGB+R+GmIsf4z+DQJOGBi8FpWDWRp+kC/+ipr7+abKN0HiepqBCtPlSNaiUjltd9E1OeukYF0XsTvY0GtypRWTH0i+uREaAazY+HB4a85zqMCkNP5QalyFXkkyv2kBo09ai02O3pTCAk6S4P5OyTs3osmvbciiqxQ0LE6ti9KtIlIl/TjpFl+nwYWLciUuiMap/LOKFmOUAAaMw8yxZ7bcyIDZ+AuM/rkYV3JOKzsQqJZRJpyL1GLS9bNKmfKWKYdxifQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmohUdmYWVNwydoJWz2tzdhbN6yvrJPbb5JcisFOR68=;
 b=jq2b1xZdvaLRDOGxPvGx5uVh5nbXPwUQNftPxvd195GU3jmX4vZVRq6mDxUmVAygee8hOoL2dke5OgBDcpe9MXNO8acvfYd6QA8IFOfjkesj1n+f+rNavYFD1XFAsrZ5cK2spu6QAy+ja8Pz6zh9f5NKbfyi/riKfbd4o2deFd45gcmwQcXZ7vbGXQqpTASv9aPoTUVhYJJgPoqcfXOmoCs0aJP8IrKaV7E54wpjHs+Sga2hyceRSLCiiY8N7PMlV/+7M91isR6mCBBSCM8i0zZdbo5X+Y++XP00fnXF79UAXUeTK+A4rp5ehV0S4kIt+nGy0J00K1M1ntr2WDuqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmohUdmYWVNwydoJWz2tzdhbN6yvrJPbb5JcisFOR68=;
 b=YQd4qT8hcknjff1g9D6WtHJFbvLQ1bhbMTWqCVVGMvyt3COrWgNZv172BlmYYGhoFnjZLT3ktb5WzK/rNIsB8gZv6pGqa2VfMeByE5IU3VUZH+GyVhpxRS99AzGxQIOeI+RlYMSwfU7TXYmn7CMsNg5V57YwLuIhWyTbyuXhlMRQPXQrXzcvyqMcGk0c5GvSIkrPIUsmmMR8ZMOy6N4xDNc4SufnU9R4n6yKD0AvOA3Df2bmwdwMXbJwrLlWUxY4wEsMWLmg5ReKvfs1hShSfuS31GDug/zk1zXGiiYYtVWG5+WpyzDY4MgjFJa/WJ7U7JRoW+QIFRYN0GRsrqYRgw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB6577.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:72::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:38:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:38:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v6 4/6] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Wed, 28 May 2025 13:08:12 +0530
Message-ID:
 <PN3PR01MB95978B5D144D282BE48F9CFDB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g4769924781
In-Reply-To: <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BA4D1168C87920EDE6A9B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250528073814.29138-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b83ba6-cad6-4bde-08e6-08dd9dbaade9
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6otDHf//Td+gLtOD1QhqtQL/+QyfC22/kKUi5iNfS4r+NK7Pyn21N1wXoucvks3gN8g00z3IYr+yvlMu6c8BdeYeNl27JURs3z01itQrNJtkf7MmFJyLZ2K+PXjrUQ6VIm8Mi68PGRXqFO+FIE+foOjxR67Q1bvb1YcxGL0AAoLv/rT7uDgTSxZUcLQ5R7pErD44Dfj5603xmT6OKbmKqBkR9EDmRx7Yhz//Y+esfgltG7x84xowgs6Qnn5fSn8pkz8xA7h+nFn4iKZRQKQxVYECx0mzH5QeRb01KyJA7m0zWIlEVMdP7BLo4GIyBhf6YzQuC6YfMUT2XUnDiqlWNi6YVyW2ZJAIS4fI0nfDRRBUZdVGQtjdxOp85QcUFfrkRUKr4KlLRY0uN8Fz/DIMIuWfAAUD4+x8ZLkHaO1X22rYp18tWbo7f99Pis3lyVJixlV/73aJFCgGNGpmFxpXXXzbTHQkFsfwacqvdBy8As81KHaPEXt9dcxgB/v0FvfcSN3O7paKmzOA701IxsxkcI+RrndohA4G1DXENfppsLvCb9Ii3lL80loQpCq/lL/PoAAe6kNKMLx8KwU6C1iAlPNgXPelhPPCUptEZYOfvVb2Mou1MMDkp7JUCXnbBix7w5nicsa5ULk7ngxXB2XG74lNYeuhdRii34VHxDnCC6be7d/ve9SHW33tgk50jv+bvyEpSH+9jZWc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|41001999006|461199028|7092599006|8060799009|19110799006|15080799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NJ3/ydxp+QRARPwEIDBLLtHxqXPQGuxlzM4dZNex1zK+5zxznQIxpQJdtiRJ?=
 =?us-ascii?Q?aGksDFX30lnXtd+BWFmfuvgC7ElOd5VWywLyr0AEyfqJ8l2XO7DZG+MFp9oz?=
 =?us-ascii?Q?nKfHb1xjfPnhs6Qv5F2d7m1xzhCT0X7gZWRyvnQ8riEIPQwstYzcSTOuTLzH?=
 =?us-ascii?Q?gZVOXeFS1Ro4YVlalpzVoitk2CWJAlfitP7qIAoqCRdBrHyJUGqat25ykuNs?=
 =?us-ascii?Q?kPpM52Nh3Qjr3USz9AcaCgqS6GYgIaLpc3DATbWDBxkDjE4lCdbwa5i3fem5?=
 =?us-ascii?Q?LE4rf7tIP+nIERjNp81E0VVPQdJ9KAmmEqWzqaPuMHykLaz+9y9rkIEkq7YT?=
 =?us-ascii?Q?/+vM5GoO839Z8lB0rmYLo++WB+YqOLhOiwQykXMEcwTaP+TvuSmmJlfQoeef?=
 =?us-ascii?Q?lhKGhKsB9clVl/bujVvpbdqbRnOA8L0akbJnxfqTqxEzeqczKJKf7c0UnwDH?=
 =?us-ascii?Q?LJVSALkhzMRaBW/2qbfD93miuNpKyztRyTNvO1QAEBa/eLjtlFX65+fbTOIh?=
 =?us-ascii?Q?W1wh6SsvZN0SX4rV21FAbnuCcJthuQsqlpbpIQu4WcaF2aqAOGeTjlR9JKyq?=
 =?us-ascii?Q?NCm8B1JgiU7WDCp2PJVSPwZNww8RZGKB/0UCuCOzrcIu9GjwVOonKO1XeLvL?=
 =?us-ascii?Q?Us5NjPw/j3boSWprVLY8lZKABM/iFeJRlwfAiUghDN7HallQz88WDGT5YhRV?=
 =?us-ascii?Q?pK4AksioNuWXcszrJYkpYIGLyIzxqECD7a0WQbz2O2U8hU9SIZFw6r0Feeq0?=
 =?us-ascii?Q?3cNZntgqnecRsX68GjWvpyaslUImuXlfXO612dsAD/ZSpQjHyDSxuLodGFmw?=
 =?us-ascii?Q?lVONPrn9zRxp0YHkAojqJTishWgr+gaLPtK+vG6gSZ4A1efLyy3aDY2fBKCw?=
 =?us-ascii?Q?0+8kgVOHydNI+DRK7LvqZnv4nZbQr83ofnZYE1X4T0hM61WpKbgOA3ZUk+uz?=
 =?us-ascii?Q?trfRefXQtacHWxVCXO014FPxKvYFMJ0oDAPa3E9sRcCCulprUV+vqo6ylDnk?=
 =?us-ascii?Q?rj9FaDN2lPTRtFoixkH49QT/9TSVX1mgsu3blld7gQxJj4MPmJoCFKOYuj2j?=
 =?us-ascii?Q?YxqMVo2fDgwg31iG2PqJUE/fYKUgyv5WuLToqOWUMVoruNZMWE2a7AKNr9RH?=
 =?us-ascii?Q?w0C/lWEebiFDebM4vnkOMqg7YRdC1kFdLYeCELB2VwglPX8u4MCktJc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9cNdqKk74tEu3050RwFKqVooJzplzRe9Wh4haXxHd5Rr1ipsSPKfwCqKmJRm?=
 =?us-ascii?Q?CH1dcr729sEQZ1/Bd+4zi/0dI2r0Z4BAAoLDaVd6CMuCKkEy79U33DrPKzDL?=
 =?us-ascii?Q?DOtQyEZAwtqq1Nt4rgo8g+pUAA/roOYMqbdISQZJVSvXBD4BEyJYmfoZevT/?=
 =?us-ascii?Q?lHy97o0s6UVowIMlu5chcph0klx2W86XojXNnXGeuinallL+sMNKrRloVOFW?=
 =?us-ascii?Q?VxssS8tr1D2DXZbawjHuxOWYm4vT6r0WYyxpb38vxPbZi+HZxwYXyJeAadp7?=
 =?us-ascii?Q?t2Nu2qRZPYr19qXckGAf344M5vJmQUDertfP3fgklLg7FIIvA9QthP9Smwn4?=
 =?us-ascii?Q?UT8elHxP2HmQIPWkggSANo0NnC4VgNzaTwP0UIvRYatEf/DdmejdQbwH1No5?=
 =?us-ascii?Q?pVHG4Mir5q3afl8pKg94kcOYZ2jna3S6kcp03Q9Hc2VkCxHMfTYsLy0jHvfa?=
 =?us-ascii?Q?0KP12LRfKIUXQ94NaM2tO8IP9G0YkpG7bDGUmlMUOikw2ZfgsEBPZZ5+TjsC?=
 =?us-ascii?Q?5gWWrPKu5708UZmjFmiIuFrPljLfKCZeEUt1GHHhZBg9/HIVUKv9sZYj8aI+?=
 =?us-ascii?Q?VXrdISr+A4+9uX+qkb+bvG8ZpHlEV2d1nuTYg0F4wrfUWc2eNqimw+ZtfUBD?=
 =?us-ascii?Q?4OHzTYF3ccyPMVzjIrydXpYso0lZHUCN7zjt5NMQ7Pl5hGXoLwd7XwA83KjH?=
 =?us-ascii?Q?Lz/Lq4cQNIcFv1wgnIwob0kFIOSyiS//2Oovk10qc5Y5RQnTIVo3cfc6Azu+?=
 =?us-ascii?Q?/jX1+eah87ej+q/2BOHzjQ4zHgEwT0ykf5MEYU52xCPqjUwq0K+rBqqxDY/G?=
 =?us-ascii?Q?wCjRWmjRbTHxcqvcGP/19osGyDUr1SQka/f9+5KB4JAdeHd+GQSAWzMSBrC+?=
 =?us-ascii?Q?MUUBDvOLo5zd9ndKJZXmAcLgVuXrUhm63bWvrCiOT7spL/Wr4sKJk1nhkgn0?=
 =?us-ascii?Q?ROGblifHVeKXY4Gbm+q0GeupITGFfeqVKKeafdE/zOdIQX82a9KPiduwLws1?=
 =?us-ascii?Q?LPH+2YWQy09BkLiVSbfYZVVfTdD3XaGYsqtG5Nx8OasUl3wdGU79UBoVPSWp?=
 =?us-ascii?Q?ZJSNESfaeVG4TWmm1IqiJWtNTTlDkRCVaXSGAdlPuFWfI/J41UPTSK/gNQvr?=
 =?us-ascii?Q?TztPIrA0NsmbKJANJPRhKDbauXumb3TrgPKczBtpj9S+7r6/pz2N0LDJ/oUb?=
 =?us-ascii?Q?ddEPjbeIL18531Izv8fwQ4We9j5b6V1zBlZvJoR+zsbmlI1HeSp/qXph8Rxb?=
 =?us-ascii?Q?3P5T7qEho6JXx7doldI1PUoAlnt4Boq8CiktaGuElBR/GjEvT2WGENFjTdca?=
 =?us-ascii?Q?bqY=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b83ba6-cad6-4bde-08e6-08dd9dbaade9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:38:46.6503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB6577

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index ad54aceb28..87abfd15f3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1046,8 +1046,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.43.0

