Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F81FDE01
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453714; cv=fail; b=FXF0stkbQutjYiTPdjuSTqQMeBr8Q08sxBLnRSm2qu8Cc2cd/BrvmJuKX9S9cZZvBIuCqDowOZ0nlIkrPMF8/5P30513Q0lV0fMS9ddxxacGY5A8Tj/giGoS99qzzfh2CDCuPSIWbJ+gTMAX7SPy2KZp7ddK+GnSHeJANxp1tNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453714; c=relaxed/simple;
	bh=n/I/8vaE/HggaZTjPRfQO02DaJQRpN0PycRIyKZxq3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rUF4uVd063VoTkQjPOfmbjhHdGlre4e933MDQNfFPzhkhTb6cTu48nCBUXsSiOi+/oOySt4xlRfY7HZi+vX5UzzLzzfju1C+KCETfPWZpDYvDBLbQGP+omsWhxkcDnuqLXoXr2Ow0OAGXj8B7tE9Tw9VFAASDdhYd01ZkN4y30w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=o2i2HiZy; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="o2i2HiZy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0yOdUydKdbK9nFuFirGVdO1FG9p1vw5vABmcagye8SaE5uuWdmkotJVzO9+Henr0lz6Bs98n/mn3E4I3slLjQeqSzw0B9UwJyDKex0s/DFkbQ7xhmhay59trDuCnV7zxAem+eL/L4f+jjxlEqB/XKJQocbJF5werMPKs8XtIUXgGUrtr9vaZnRLTxKBwdoXRf+WL8wmVkYRrvUKbGM1v9mMyy1KM+YXAxxekdxg8WBnj3XypVPzf0jOh4jYo4/JzzLg437kou7pRmOiLtKU7xPTJA8Wu00twUorpHaGj1QzRkhE8Mrp5Vklb2+gGsmE8YbY4xfioobz4iV9dKL44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au705HHGRrpSlgtXxZqgZndsdDQmSEJ0oJzWkWDgdyw=;
 b=Ev1OCGp9tukLBcLKpqNIp5T0it1YCwvAnzRADfVlTacjfmwz55v5jH2fb0+m+jVunerlWV8AI7ayxzc48gCsKw4ZGUd/a0Gh/Wn9Z6ukhBeNmApjHseeFJiHtPbFHNYUyWaFrNevH+hzvqcAinQTM9JcIQzt8HdbBya0LmL31cgzFgucYrZnAyfMm1SG+VwWfsx+0bQevL0AenxZrbGw8zcDyMBV29GYq3NO7xpB/ryCstV63MyAqhgr8b1ugZTpgl5fCs4qDOHtZMipp/HfaSuebGf2d/radRam6N+A3rhqx/2O0VZMYw9UkmRKbjs7pa9fxBUNYO/wsutTnimzyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au705HHGRrpSlgtXxZqgZndsdDQmSEJ0oJzWkWDgdyw=;
 b=o2i2HiZy3XBvnQAFmOtmn5m1DoL/lInBlW9Gnzug1PNHw4e+gHd3jqVgkwFQZAXSDC5utHafkNWRkmBSZJ1gctusJTdXjFZPhJj4WaVI4j/cr4vlNm1wlQ/umWkFg97D7jPke67pFruXZ7Z06P7TQCYP59GgpH/zELL/BEHj49ro0CnspVyv8Ln9q8qobqAf0sEDp+S1DcehHQ59JAAghfKo2OIxgnOSFSQjutDSmt3z8MluBvBdEeMexBRmGpalhl3c/wdNUZgkwapKh1RUwHqQdCp4aSIORyWMWNKhlV23crGSn8N1GXhLxOg9D5zgdY2OiOtrgGpk/x92b9gktA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:42 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:41 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 02/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Mon,  9 Jun 2025 07:20:33 +0000
Message-ID:
 <PN3PR01MB95976D757945B4984A73E406B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609072041.12114-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 3804b7c1-8a0f-45ed-ec8b-08dda7264733
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|41001999006|7092599006|8060799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?34TuttDNH/GVWBEGcNkaUrBGCQkXNAztY/0dxKkXlQV2uT/HJjxlw9SPjlKZ?=
 =?us-ascii?Q?6SAvbcXGNmFKtL0rpzsrF3MTyXzbTG2g19eKTGuuCq/PpH5UBTLuLTfqNtw8?=
 =?us-ascii?Q?S1yfbNKWcur/4oWP8uFGNGHes97hhlS0vzHUFQfGI9zGJDTlKEMCab2ERMiB?=
 =?us-ascii?Q?6yitHB2Xj4gp1woowuEka1HrboUrQJjPRWZTDsEB2tiXxirU+uFaMaG5sDHW?=
 =?us-ascii?Q?fsnBZwdXI9gB+lOvs/1KQ8cGrl4L4ebcpH5HLjwIQyOzXZzd3oA4nMyzfwR5?=
 =?us-ascii?Q?L+fKLrOrDrk5gdvEsRotQS8sTRC48A/25+K0TyiH9skUG2MNdKdgA56Qwv/u?=
 =?us-ascii?Q?TVPph7LTa+ljmGeDSY8tDK9Zx3VU2x00MYFd+QXQkvGYSRi/n9RsFPGLn0de?=
 =?us-ascii?Q?mFj5Qbzt0uHHbrn+h5ZdkINHoMGN0Wlm+/9j63iCcrl8M8ueZ26p+ZDpgNFn?=
 =?us-ascii?Q?40+c3iS7MEgJRhSl2W5zkGh4ntZONXFies9EV8bjsfovAIxfPfdPieed8Usg?=
 =?us-ascii?Q?ylxPVlOvXpUAK4ulsF14SntwoBl7UHgWURW1Tf5d3n6WMXXTzi68eazsOq0+?=
 =?us-ascii?Q?5GaB5q7zQGPOStKFk0UlVfdE3EMWtss51BUvmPzLu4vCd8P4eI2Pgu3dNJ9W?=
 =?us-ascii?Q?fUnZ73YCOEtzQxpTindgrGqSw1JDSd+hJtyru9xmiGCWH3BhvDpgpJ1UNEvc?=
 =?us-ascii?Q?RvZt1uY8UmM8P1Hk7rORHc+rQI2xT5CC4G7bL041AjBvAtSEEkuyhXqzAEN2?=
 =?us-ascii?Q?5twSIhA5xEchGnkbDY4CzHdH6qfSepLUFYGbnsYpRmSKZEK2xDzhal+xTVP7?=
 =?us-ascii?Q?lgTbH96tgCnWCPTGV5v6a4ito4rugtyjdJzdGD8gCBhwRc8wjqSGI5SPmdak?=
 =?us-ascii?Q?e2mIRCcrj/rBYYqO+NTISbJVnmXeOjKmSEm9nx8YqrhUQiAooIaDQKeQY4dV?=
 =?us-ascii?Q?EsnK6tr16gU5swh3yxJLTEQXOu7S0kbx/H5Qv3djvc5RPXP7NPAZ9+eT5ROE?=
 =?us-ascii?Q?zx2vM1cq4eXdyBgSR2utPKVrTCGa9fEqunDEl0Cv1Us0ZUumPQu9y8E3yBXv?=
 =?us-ascii?Q?duIwDIMtlAtbcwm16S3VpZgv/eovlzi7ACg/qQpn2dP1m6nXWG2DR2VOeICC?=
 =?us-ascii?Q?0ZMrrdbJjUqAGugQgSocyb+pzBO5lHXXn817d1LkfcLAqLAO0slw8dI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxkTh5GXj03HSFCyMuBm0+qiaTu7CvIadr6FCUvOM3zxTkwFtdfep4Eayz8o?=
 =?us-ascii?Q?cZLA1SHCNezfY36BCN+QZWqmXDkY8GyGGusSTqZ4JQ7s/cQqLylXTpW+dctO?=
 =?us-ascii?Q?+c90r8K3n1/eTb5zc6sxoYtnVy7i1Thv5yzFRhIebu93H4kEaH3JLXNd6WJG?=
 =?us-ascii?Q?pOygT7xm+/8Wok7/tCMEcXZoUKB+bGXm0FxwKCxT0qyJwkvK3Tfzdf4HcmFQ?=
 =?us-ascii?Q?jyLhQglYMZeitUZQatbfxi7KMtffLOn3LYTjuh7mt/bMGbQY+ai/KoKFmABD?=
 =?us-ascii?Q?ZHSw+o7m2FiSCxRHX6KHExmGoI3dW0WMxhRNPxOmBE3CZttzL4PnWWvd8LCc?=
 =?us-ascii?Q?Q5APIjgmvQG/i7mLihmZ5UojsXBokCGm//LECGKa2lwcYJ5L3gwbeC/mqtmE?=
 =?us-ascii?Q?6llAA+v+yqhp4iECxuDrXI1EKfZSmsaP7nKnevfetNwBEksRuFX0Awfy0zTe?=
 =?us-ascii?Q?K6xlyjEAwEde4ElenCFnNyR0p+nYoxVTX9Fd68brDHugyQ8WvaX9DpVY5nZa?=
 =?us-ascii?Q?9tf/JzpmvZr9thxA4BmB3nT5fQSdYJcMB4z7uptu2WMVHXJl+/Hdc/Q28CfK?=
 =?us-ascii?Q?mopWhUzQkCoagKX6iPnZ4cERVNRAxH95Xy9ISHBBrbsyNNL48eYN+25aDsc5?=
 =?us-ascii?Q?vgxCSY+MlpWcsL2QO+SZUkGnvMkW1M2xc1RhCcxs5wjTLwkRk5VZBGKFQ4hF?=
 =?us-ascii?Q?5rcw9oqQ8cdsfh/rTP7a1+LEN1a6a72zsgyejbC7HTgZVO/yxjtzFSSsBfy4?=
 =?us-ascii?Q?eCX7/ZnSfn1FrP7rUKBsMEMW9/p7wk2NxlzzGYEkAffYDspax0jSYbv7tri2?=
 =?us-ascii?Q?m2TdpQFhOUH5zTH8cPxYcPaP5fKZa1epaSJbrv4Ty9Amffb9pPO8lq3Rw/oi?=
 =?us-ascii?Q?IJWaVvnQ2Bs/x/U213+afYyO0FfXVXhhKqjOvTe7CSrUZixgHtokhHQ5NorR?=
 =?us-ascii?Q?ElxCrobCCwmYxx71ZrUV7N0GEKk5OPlWYrZUTZqF9FFOg4hu/TLETx0k2NC2?=
 =?us-ascii?Q?X+1LzRDkGiDsD1UWn7a0az8zVcNB3qqdYj/n/5vDeHGX/yGoSW7QfCXlygRG?=
 =?us-ascii?Q?mo6AUPnR1RVBXng55IzB14dqG6ANkvrmAG3ICPTDEmGrA0cUv/grcFN4jqng?=
 =?us-ascii?Q?V2c+tAHLPV6CMxQU6yU7DOclXSCrV8Y8qKCGOnvWR5lLxys9ykePAIwJVtzB?=
 =?us-ascii?Q?Avfcav3aY7Vnt2+vzfhqnPSjuL5aYEuFUt3xqlomHeYbi9b/3pq5focjtwc?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3804b7c1-8a0f-45ed-ec8b-08dda7264733
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:40.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..1a582c8443 100644
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
2.49.0

