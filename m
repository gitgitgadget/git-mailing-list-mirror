Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45621FF58
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401659; cv=fail; b=df9SIEAmH9MhFsYhvYqPwz4txuLwBpjOpdqSe72iB7ZASWtAI/0JrmNk1ke9tW4e7aS1u90A8M4DgNq0jFWexywOsy/HnFR5Da/AvOulCXT7vsvQPw/ywB6zDKzmKNTlrSvToQlBY4qOytkpTA8D/vYe9mNA/PF6UypYlkClw9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401659; c=relaxed/simple;
	bh=8BiYHUbmaBnCNKGP8rtuACApylSHOKg3fzkJEBqlJTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yj1irh1ZNzCnczvEaabliKKgHeBA9OTHudtDgq89Nj30efB8MZ7XgMn8E/0t6Va1MdbKC+jGOBTRiozhuVpCtAAfgbDB6OqvJb2wWypWgkqMUafDDMwJH2tBF9P03ZzZefqkFEtxqoqXTe8Da3yiLz2nh91tvsSTwCN9xdirYpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RAO/Zl6K; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RAO/Zl6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0U5X6vW8xZIo3RngINdyGzB9g7gYVVZGqOvuirmpjKBUmiAilAVfVEL5GRkj6NQM0xiVZIpWEkfw/SPJG30U4wJm2Y4oWkmliNLH9VdUDiE/4cniETtNWTO7vdj2i889zvlLkJR1cvVe+QsaiXkgLM0+XSJ+MZP1TtkttXuDrdTdStSpKoDZtq5wEv8XLQwJjlmzXR0r6n9GPtBIOi6JxK7wZDl4kNkeHP5crj2RESq0JnDCq+Z2n2XEyIhfdFQaX62HsJqA5G4G9bYvFT0q8sTq6qN7txar+/S8nwsbJ4sVuhKRRLB5T3gR87akymFc73Ap/vyzosoYPJskn6JHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWwATPaoV/dQ0oDDtajO2xcGBTPg2OoF+1fRnoa7FEc=;
 b=JvQCIDu5sNLLQcFoSZHuXIDD+u+FvUQ9ymsjm3+SESs831mdn8lahI4pr0R/rr285vH+VTfx8ggA4hXI/5UzKzMyYQvR9J5Q6J+U2TF/xO6a+BG2DEAjpQ0mK7m0fxGK6+dXrEgRw7l0D4AmP5jqVEGKmA3ti0seqnCC/dt9mvBLw4psEvQZrIUHdnIdNHRSBgjOwZiKq/eML9eoeU4y5DVP5OQP8Mq60Xxx8iGOdm0GuzosZhhnh87SMxxXLvMO9/2KpleJKpI0SZ/WlvgkJclWlhyAdt2B7QltAKtbTbneBU8JrPaX8buWOeL5jt0Cgkw3xZ2lVbF4vmYuMBu93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWwATPaoV/dQ0oDDtajO2xcGBTPg2OoF+1fRnoa7FEc=;
 b=RAO/Zl6K6uXljpbGa4NW+4pzioFz3JRxNOPEJ1YOAbOwf7aQrrvdX5bEKIEooWlGeoYjb7LSppfdX9dXG6fOIO4YY2C5/ow/wJvk6MUtezebYaxRWxejTi+4h9ihWACAGtP6EqMGnepID8wjdHv9sUVgUrjJjH3EjTO5UrtN8iBsV9vnTPClLCc22Emnauja6QJcchR1dnuj87NcpXu0w/8r1EqnkmJd0CBuOQdacGfR1FXmY1Xd9M+tRFp70AD+amZESbS0b09GAuNhwGpzQDgP8OJ18u9Ns0kagagFKrcS8w5HLtTkRwN2iITCFK9JBztSryM6BlVLVMzv4odADQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:50 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:50 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 02/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Fri, 20 Jun 2025 12:10:25 +0530
Message-ID:
 <PN3PR01MB95972F977380A5125B0DAC8FB87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250620064033.15814-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 704c8692-c44d-43e8-3d7b-08ddafc564b0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|15080799009|8060799009|461199028|41001999006|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KxzFpfF71nF0NGgaODR4n/SE3eES4RwY+qfp9amYP76ooEkG3X7f9MKMEO1n?=
 =?us-ascii?Q?gsKN4QA0gblR45B5rFlijWfWfeI1NCIrfCYz0FjBIku3BfUHvP9PzIBYJlkx?=
 =?us-ascii?Q?y2o4/X6HqVgDrrPKmwz4Q8FT3CQiAmYHIAvodK49XbVUYFLWfQYQPWvxGGYk?=
 =?us-ascii?Q?Kk28jdfrc/qaTH+OKriZZu9ek45boCF4LdtC5p5CFtJVXnh4J5ZKoS7MeZhL?=
 =?us-ascii?Q?Aa1Lsbofc/kLDCDeB4I1Wz7Xi+rs8MN9p8mrsTbI5On+e0iIsq9XV9n6IneO?=
 =?us-ascii?Q?sDyUIsea824RYXdLln1wVt5OulL9akdhP79aoj9KGz4Wal2Er108WfbI3xRb?=
 =?us-ascii?Q?TBiCu7aW1int4xwMYhH8eNsX9F9fbq5THj7FEy+Y7c3xd6RxkdmwyBujX7HV?=
 =?us-ascii?Q?U1uCnr+dJmcjdOpsyQOyKCLoDxPKzZwYFm75WKoaEaUhba8JrhZduwP3fv/u?=
 =?us-ascii?Q?ISfehSyI+8mmw0yGrAqmXVQAasLs0qpeCtATb/3174ygXODEPuSCtmRRjXw+?=
 =?us-ascii?Q?StkBjpI3PvTnDC8icjGxRm+m6gHuWGPGa2ouzW3r6PnFWMvcXMkGpn1oWLD1?=
 =?us-ascii?Q?iAslLAsxbUR6sNyBkXNIqiMdVaKbCeHCo4zQjEr3jrm8sIG1K2BOOxFLap43?=
 =?us-ascii?Q?zOP0xkWXFapdxWcCHZgrk2xDUJgOl2d0EHWv60aY5Bh9dGXNSJkOtrrFtFGW?=
 =?us-ascii?Q?bT+IiwwohmNb01gI0DhBQvFSIPdGtAVVNXRqpye6npAl/cc6fonkdMnrWKPC?=
 =?us-ascii?Q?rwVZetGzcw6xl0U94Ea8WeCGO+i1i6/rCNRDmQn9z56+uwD4KL+eoHbjg1ZI?=
 =?us-ascii?Q?JGhYkMEw2JlcDKqekudzJ1HhlMGnglhs97OKpug+jxeGVpiO0D0MB3fPNawL?=
 =?us-ascii?Q?FgATWpTJi7U7RvC7qy5t5Il+ljJALWQA3HKzwtklObufx8D7RNHJ+8x1X56h?=
 =?us-ascii?Q?HYCo/QMOjwlx2uW0tbeGGD0urvr9F5bzXhzIQFZHW6g2vG6YXG5+1kp/0mUl?=
 =?us-ascii?Q?QOdI2JDTDeDZNRQb0wAdtsGA7RGHUvjaNyw4g33SZFPmlDpfK/PV1YNFdpK6?=
 =?us-ascii?Q?5iRwnTpC6laff0DiLZBajdanWQnUMqT9A14X/gwwDp35210u423RdJPm5QuI?=
 =?us-ascii?Q?RbMhpB5bF+kOkWeJ1HRio23B04Z4ki+gSQ2TN0uf2xh1cGRcpq1M3o3hH+zE?=
 =?us-ascii?Q?4nv9i5/GdbUIt0q/zczqi9QGPuGIxFmzseIqWg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V8JDK5fl57jK4pMxOx1iM/gP3pAIojt8g5EsiGuQ1Z2z8NshrHyQ4xZd1ycJ?=
 =?us-ascii?Q?utL4wBVY1DtWlbLe1eWJx6cbJCX43EhHP8/0Lax0qJqNB2lZOkWuSbkOzBA4?=
 =?us-ascii?Q?1szP1zs2zo+XnBhbzJcNPtev2/OzgCqaCIYliFzVGUedB9qcJGQizB+CwSTS?=
 =?us-ascii?Q?u4AgwI/2/fFIt06jZz/RaGODv2FcO42w6MZcrjj4oVhul2GJG757/3V7f+Mr?=
 =?us-ascii?Q?oCn/mB/7+AvGWUCnmA/bssO3mHoDPwID6rq6TJQH01a3bkfL37J2+EFnpATY?=
 =?us-ascii?Q?HiB2nOJTSxueFTBWWncBOGOheIKAXaFxJiaEftVN7HJIymm/xeQLDiiXGihy?=
 =?us-ascii?Q?Qrz2sShh/HadOkei5gfwqbpsnDkZ1ugwDXlzwmuSes+36S199oORol7iNTgx?=
 =?us-ascii?Q?u0ftD+kx3R+eZ0D5rG1q6xA5L+2LFHyZnshVgrg1BPNGXDTeJucv8hoI5x7k?=
 =?us-ascii?Q?m1hVOuLayrya/1UTOxdW7g4Yn1QpPW6lnfvO+wiTumF0ZiZ8f3EZZ8bEpMz7?=
 =?us-ascii?Q?ltc23ZSgGUv9F2gRhVtPv2cTX1b91RynFMQN6xx9UC0k9g1DXyRwvoUiFogT?=
 =?us-ascii?Q?BLbA0Fy4aomIKAql7rI170gzwSqS5U+46UO8SaPGXW0jCxSDLJDJw/WOZl6C?=
 =?us-ascii?Q?r8G6WFZlVMEuh7R9SlYorwZ9k/jiIyeKKJ2t5VDWWPVaPJejWx2KacJ4J1nX?=
 =?us-ascii?Q?c1+1qfus3QAvd6qu9CHgY71CEArlZd70O1KHNls0I0aDoHfMAdAftASH0Vlg?=
 =?us-ascii?Q?P+OoG4iWRL5wcGuMOFHIzUu4/MxFjye7jIsMfTKqdiRRfle7oJqk5NYkwp41?=
 =?us-ascii?Q?MFEEj72rXVWgvelcNu7hSmRrJ+rJ0EW5B9yugjd/cbhb7rHOAtsS88HKbDUI?=
 =?us-ascii?Q?6kEej9wKEffWpj9mQiV0bDu80RS5H41nV9Ay9lp6wgmHoRJySUklPllHMPL7?=
 =?us-ascii?Q?LiHhS63TN40FL4bSERL2PbALt+xq5SSrYt9eZc4Od5M6NRXEdhyc7RHuB8lH?=
 =?us-ascii?Q?j/PbLv4COL54zL/gUDx9xRu3FzmOLpjdEYuAx3QRDQo2JFXnKy0hq8MiMtdU?=
 =?us-ascii?Q?1592Ftmjm+HWrvSCyyYgn4rAN0dhm0MksQUxGlnl4Pbk1JlwW2N/r7n2fU9i?=
 =?us-ascii?Q?isU/kTS9NzTmLVVApExRaapMhhirhq0y2FlwiaaKoG2OyLWxGqpoLUL+P5aG?=
 =?us-ascii?Q?FtLZ+jMbpmdBGkG6SuQoJneSDvGzJiq/9/2Ia7erfSXO8nGTsNLPDP6Zao2V?=
 =?us-ascii?Q?wNl0I5XJPUtnoMvc3CqgR2G4zFOkRFg5aKQoxVrguMDABQQ56fMa4p9MtCtV?=
 =?us-ascii?Q?+I0=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 704c8692-c44d-43e8-3d7b-08ddafc564b0
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:49.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 3eed2360fd..cee8f5690d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -905,8 +905,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0.824.gcc76007b2f

