Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA219CCEC
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761942; cv=fail; b=nB6+COyql6UlsmJKidOAewbGrtvHI/kdUT+nh5/g0zAt2lfHof/y0WfXmBv1iNDrJ2FdW58abo81GCDloXJGHb2ikUM1IlOogeKZ7IxfAb6kcm0RBnpUP8LbDDo0ZqZa+U70FIh/WAQlbU2TOhCOcmglCrVbNjV5C8VZLFcPYO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761942; c=relaxed/simple;
	bh=UP84Q41PJqIlpcaUZP/de/Zg+fnlXdO79xGuX3fN8LM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpDrLj+pY4G0be0froufMVrUk6+Jhznpedz/MVQT4c6uxu4BXia+3Es3VxGkIE+rHpAD49cPFIgP3m97AChbPxpkx1d2lqsRF0OADKbGhpCPf3hGaYjG5fgyMDy1zT8+RqQlg6dDVsum35eXNsrbUl3Zwc3i/2Cw/n/XkJjpIjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Hona3jak; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Hona3jak"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hknsq7axwfQOiUxdfi5hqr5nA6nI1kEjTsXloVbjtPJzYK8SQHg9cBjZIR8SWJiqkXPgWnvJIXG2HTHLPLuF8zxrB58lefpsq+L1KBeAioO2SKhgewz5V1cIW20OSko4HoOb8z3GV2/DQ39NzdYbIs3YVwm+8SmELI5KY1aWpaHCrxEljG396BURfh3r0wSIF4QShQZrAg6pK0qsP7siv54gwjD0ZWt/XveUs3+YgpC6IpmfrsvFhOOH9+oMVEIW6A7sHVno7nVf4yCpsQ0ZClzLb2KtMchxxmdYDV8Uz+xedG1XTbnUTP3K/fVPdtm9COJeMvsWAVj2kuod/C2zuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q407ORxntyVxqpRF4lM+6CE66lpe4UaOCixIcvLekio=;
 b=vumLNYKISbVb8wKq/jfd/JfaT87FrqniqlVhwuwBjJgSce76dnxwpyIzZaJ5m7d6qDwdmfYAv0oizTtxQC4HvVZOkPZxDBpPw/QrFsrQ2mk3EDgN2buxHmdShXHsAcYcyMeDZ5A94+cISCw5qoLUV+WKQxnUoSST9LngD83PaYHLKQziVmTuvqyH3Bt3dgBLeAQdbHbrYaKNA1/+aVorrOPzfPJkRzL6GhVlLcpHeYWRPrEu5NFyQYuZvLHvTnxN6IQsOYIjiDj7RX/yOYNF4u7CPX8D6HLcGSPCWxXN8lugNNWtmOpKjLNVyET/Jm9Bp7/ikcJLIVG+8aTQp1vlxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q407ORxntyVxqpRF4lM+6CE66lpe4UaOCixIcvLekio=;
 b=Hona3jak1Y00UB3Dkb/uutSo0kRGcQN94iiUbpR8+rjnXqAUBx529ZvFEKqmuhWbHo01QkGiIhw10LN8NFrNYjHCAHExtv+uqz248pqiOKsuy1njErSZHVk875Y3DNoE4lnB6ymgxZcQZa2OQAdl8/htiWGBTyAgYckssZc3dR+kAshJEazP7o6IaQkVCOaJ7cELiSSKTV5j//MoFAfuuf9pdEa1uAdfBzr37cZx8+FDA77JyQx9E6coZgx0LUdrJr/m1iZxIfjpWSgfEhtZJOeCeRgZR3CiFJdnoi4zbhA2DMIksmzsQlqakIuiyvnXcmoOVzKM9AaSZRLyE9e9Rw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 4/9] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Sun,  1 Jun 2025 12:40:30 +0530
Message-ID:
 <PN3PR01MB95971A2A81DD69A58D2506BFB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250601071035.2412968-5-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: f73a91f8-831f-4763-1a8f-08dda0dba0ca
X-MS-Exchange-SLBlob-MailProps:
	ScCmN3RHayHzgPFTkOkKHOaNyTn4nQw6otDHf//Td+gLtOD1QhqtQL/+QyfC22/kKUi5iNfS4r+NK7Pyn21N19cl1zP0RsINzmlx1Wl4ieSTNkddSqoDAZc8sAd4dnK3QDWIg06KjXe3EYoFgmccb38mPAlRAjOd3ZqzLvAPnrP9Xa3xF8uJOIysV+C/NzHFvh4qKeFLlopiOhU7y2pF8cCJvHv++swi/b36mIT7koSD6VOpvBep3ucwWtJmS/R+FVPCngdfPJFNMbQo6HQZ8OJ3PLsHw3ITQzeNVTn3JiPUecW1bzZhH8jN+BPEaRin0I/rU2t2JOLCW6yH2L0qefwBjog53cS77Vn/eZMsdXEXjIrxt6eRdMX5Y+9OqbtsNXcHLAVWLgQhcnSKiYX9IBREu7iM8PQKd3rAu6LnZ7VpPFkOR8KH6SqaR5W1tnWVRJ5Ohfy6cMRzpYGkYjRQuRjVROxU5LO25T/w/39hA/P4TyxiYSdl5szQsdpQBrMgXyzcXijOT+Bb1yCNrBzArj0arGd7hc4sHULrXzyZqoKdbr9RYTdTKMpG23g1ShFoUMtROBmCmROPMHI8QZIdIo84dEc8+WlJfhaI/2YFm4K5uldcbf3mS0K81VRy5EwnG6/jkofQDwvjYnt79uwsb72wekD0h7kYw9wgFFzTgRemXZ2n2TFFf30E/IKB5muaDrcAOLKrjwjRUl2c9kyiSazhYVC/McYHN43Vo1lur+k=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L8TCFR7I15zUFVqwANltfNiA35tdYDNtTEEAsi9InyjTNGFjpTMJ+eK1oOGE?=
 =?us-ascii?Q?4StrTK91NnmLzi9HlqNZ2wrmvCD7KxWPHsqRlPih8kfZrNWBehjOup+ez1gP?=
 =?us-ascii?Q?liC/Cz7pWKWfEIAJAP/+WmslzOJtJmesYkLhSVzOhrRqmk3I8SLjKduh20tU?=
 =?us-ascii?Q?t3WL2boxvWJzw2/BAnQbwNxMlECQtNYV5AhkpSJHWmdz7NAIu+SigA7vN5nL?=
 =?us-ascii?Q?Zb3Ct+XuFLM378+CHyTmR+z6G4oosBgL0ruqz9s6d3L00yjr27C1gHDRQuHM?=
 =?us-ascii?Q?MEMEt6ZNw93p0cIBtbXoD2humCmNYKMBG+XVDhhznJTAjQiV4dEvYm4XMOMP?=
 =?us-ascii?Q?kxCC1QjK8deH/oS1plAIuhAwFC3GqegiSxvgk3uiIOrDljvd9aAXUmP/3nlg?=
 =?us-ascii?Q?NJWzQUKBhQLAK1Bh7S7QYjnOqWwhsOvgamhT7dj8rifUotSAhgDPsKmx5hLX?=
 =?us-ascii?Q?2kgmxK96Hl9fP+r9UbxCcn2Ftx8PcaigcNDFWcBFM98GAKoIm1IEcT286kdk?=
 =?us-ascii?Q?aVbwPcYWsWJwZTlb3bUvTZcIukupMg/UohdJNj9RLI83DRWb109zWptEy9Ph?=
 =?us-ascii?Q?ml4he/OE9SsqGILUGEucb1vrGRi5gj3wXk51vAGJ2pRtxWzZuXPlcIFduvZ5?=
 =?us-ascii?Q?8985SkgNplewFEPe/FLVgM7eJCmmXxkDWVx6ojN6VDL3SN/PBNsBXupGaH3S?=
 =?us-ascii?Q?uWrts0AGzwlYkK3cY+LlzGIbjc/zDBa7xNWxk43CCbSyDmCYbzCma6DTbRVs?=
 =?us-ascii?Q?8SFroF49lqGZEcQfLuNpPXOnanKJx7fFwmbY+QKFNnNwO/lbVd+XOXf+1c9b?=
 =?us-ascii?Q?IL79OCNKn4mXDeJzNPZZR/BEra24WuGPj5gANvT5SjTJ9Afhc9lyVggkHhdV?=
 =?us-ascii?Q?l8Dh76EjUA0S7JDY9YZsfvzjqOHFQGtxheEV/aWhgM+QXYMuCSkLQTK+Plb6?=
 =?us-ascii?Q?fuSuP8CaK9y+F/DW1maHxpki5WZGSESOb2jvopSjHodpLcVQ1buzOEY8tsHc?=
 =?us-ascii?Q?iXFA65eBv6X3iSh/D39iwaOtEXU4D6wmjG6firGx8weX2NEW5Vk2TXGqNqlG?=
 =?us-ascii?Q?6QqaroHk/G/qO77m/cZXLrUKarZxM2ER+/qfinAqA/av+QlS7MMJy12NUW9Q?=
 =?us-ascii?Q?WFT7L/GqlYc4izj5Qsz8H1r/DxdcgV8hQ6x1rx+NoEUa9JWRuYuZbbY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X2zL3nvAGj1QM2TKdE2w1kR6slM736+muyEII7/sH6IVmyXCkplVHkiY47Np?=
 =?us-ascii?Q?+0kYR3jCJwJZmbU+JuvglBSVQpGmpcMj58rmFnN3BZ371zleOJy2O0HqeLo1?=
 =?us-ascii?Q?ovOTLGpx8STQlwwR5nwODucp98LJHqEDlvqmAdjMN+mnGgcWg4vanbwsYCCV?=
 =?us-ascii?Q?cfXYmZfXXsw2eEHgm/e9uYenxKaywXgPCtrzZu3nbd2U4hwcWC2FRUIZc4Lo?=
 =?us-ascii?Q?6ZT+ChXkyHeEWS2i/Qs1moMQdePHgFBgbg0ISRyMaFevjnDIb56k1EC28W/A?=
 =?us-ascii?Q?tXYUqTNpDSIKGmCorYH792GbnbkM5zcnZnBmuAAuu0FFMTW4A50RDZwTKH9N?=
 =?us-ascii?Q?o7IV4dHeNKEt1UElFadPAtmIaNIm5aUNOgBvM1nyBe7IZhYdUHvckyeMQF7Y?=
 =?us-ascii?Q?3sTifvjelhAxf/uwKfqgLQHUeCh0XbtpcC0y3lopOB+UUillk5cf4O71rEeA?=
 =?us-ascii?Q?tQpQlqjqFM3K0cLhkCn/fOCUMoCpz5shUFVX0UIVnN2TXTfxSgr+a8nq0xHi?=
 =?us-ascii?Q?z6MK0fQ4JXTsk2To6ogQQnuHOSUvJ5G1BnsH1eRENsfslvO8Ryvp/n27PINj?=
 =?us-ascii?Q?+I/q8YhxG5xNNZHP+MZ4CIKmXBXRSpTgkO6o1ITCvMwcch/uveYHzUW7AEkb?=
 =?us-ascii?Q?BuieuVp467/6IY0qusMBGOPfkxlF/IpiAQMZfLqS069APgWAXHAlNdCaObhI?=
 =?us-ascii?Q?PcvPnSlNT7SeMoHJsyhMXtbLkfPG0pAeseXrVRxwSuo8N19mLxVrLEFV3NKa?=
 =?us-ascii?Q?I3HWdjj30VJU4vuFjvnAuva7WA+W/aoK3K0SGJs20SbyiP3VIu5C+jUDOiVd?=
 =?us-ascii?Q?7VTXp5UuZNv5VC4Qz18BOn/Ilpn0z2BI4bHAHI80tVQis1s5OGBJ/1EbMrAn?=
 =?us-ascii?Q?SxEO/R88TVyvuGdITpTWIQJXpuho+cFyGWVvJ6A9kbr8+A3jiGiHCyE7OThW?=
 =?us-ascii?Q?r/bfqpUP1l4o4h+V2ZB0nwV6RChmQxJEUbxmAS9TZUcPEtOXqmdjZS+T3UM6?=
 =?us-ascii?Q?jNY4nNAyJujeyRSOkSXi/NTNKqZ9m3M2Y3pZxUxgM/6oL1Odt9O+/ht4lsKn?=
 =?us-ascii?Q?wUlHKTqpdw+3Q5kJESmUcv6AmycX13Y+p72h3qu6NBULlLVO73fBudbq73N+?=
 =?us-ascii?Q?JgwX04Jit/gcu9jvSbwdMjVucEzTraY7sgh61mxF4aSHSLI7RrVblGbITYIY?=
 =?us-ascii?Q?ujtPnmdaTzxJNZma2LJyCTdCutJ0WE44Neorz91hqexvrMLBfQVsICBOS3Q?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f73a91f8-831f-4763-1a8f-08dda0dba0ca
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:11.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index bc26abd150..e169c5e919 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1049,8 +1049,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.49.0.638.g67a2d115ec

