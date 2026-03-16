Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F43A1E69
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675417; cv=fail; b=a/junx6u9xA73ViPVRF5aYf+rabdz7KP7C9g747f2X/TF890th1nGTp7G1kwCfJ0QHP0oWmweYQoMNGFh0CDOE/EG4g5iICaQnKZPMtca6Hypp6GHUgVm9mJPmskslEB0CUdwe7W+Bb4H2B7OraHiENaxsxWdGjiNwmF+Ya/UK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675417; c=relaxed/simple;
	bh=zVrMOw+e+OJT4Bt4ylmuGZnT1mKro+fIPlOyuHB0lKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kwZpq5dPhus0cdPZCqNFiGSU6r/7O7yTB9JIBF6bmQ1ayKHY0PUqXEeFtGjzM+jLMyOYkwKW08D2iuLaDIy+qWo5AenAjBjvpYfg/XmJsQNE6qbrThD6LEgHquclnFCNwp2vPiUGbnZmIrrMO58F0NktPNBKkZUSteVWQTSeObM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=KpVcNHn6; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="KpVcNHn6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8EsWSRpAZi3psQknl5yJyKtN+rZCmrZWLKl+A7SyTuSz6E2nzz2OdY1na5DnwUbpciLu4kd8wXT3KKoRrHk021KrCXTJ4RoCI1nVoNh09C/n68uAFVfnuQmV4Jg6gP+Ftn7WE6LmjYeLf8Q1s1RjOe1LzEoDNvNl2k68BMKc/yiYQJBvz2ZwLGAFeVf5SO/+J8G2qd0pmPU2Bv//JJvgwuKvsGnr4stfzZizq+UQjW//zkYK1/NUpvHqJWWIT0OruTJg33vrNG6GG80eaMHp7I7IQYB+Ow3VsK2U4lUMN01O8fvdJRNnX8lU4hi8kjz/auNGUnE8IGO7zoyR+edOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDXp454UjfwuO8FfC/hgHpBhy3zFkBNlIEPum0FweO8=;
 b=Rt6RFoIh09q0YpGotJ/IHtzfuqVn+AQ+YHEEtQjSVK27fxIwZfrxqJUIJMm98i5/2cPAK7GhGawxSXmElD45VONWYWMp5xpRR/MKUF3TBgB6Ete44Pn35CzLuJt4iGSLCyHkpTWfVIiTWBvQWX2dXHzCphq9xwoPslX9NVhmuXyrjjTBZf2vfx7argCvluxst4GMWvg2pIvT+uq09MH1f693zpEpiB8kFTqDxBLGlxdgafBRdq1NuDufh0UJPBJua831l52xeoyzPvc7NbbAc7bQAG8ijxVsTCRwhyx2b/SzYPr+kSm4xqJ+Fnn3a2pvRb9PMypupzHu7cSgA1gSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDXp454UjfwuO8FfC/hgHpBhy3zFkBNlIEPum0FweO8=;
 b=KpVcNHn6FgJAnx1WK5ne/Cl2NJ1HzgXnEG4Q6xqrZI9DTZW4iDzmaruXIvYTdxjqfbpG/XCuhQ+K4bE0sQ9uPNKprwrNuPlfrQSwxsgn2GmPbLreOvFr4R+VVZLseAR4mm/u7SabFk/cuyrCNjkeZuofg1cGeBpM/kwpxLJgkg/HLUCq7xkHc2x/KMP8eefHYAq8OGUWoUWk7lP2wpbS/HgsXnkfo3Soe8xNP57GO9WhMVJf/+vtCB/IJZKvJ1CrhxYUSdVY0GlZ2iaXuVDvvkVz8BoQj5LSVJg3k+hDe6aDlCsegMSyG7PNn1lps2ohmCQpa3OOuMa+EOc98UMqCw==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:46 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:46 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 10/10] doc: document autocorrect API
Date: Tue, 17 Mar 2026 00:36:23 +0900
Message-ID:
 <SY0P300MB0801D52DC6F8E7F37E3A85A7CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-11-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: 979dce0e-dc8e-441c-f500-08de8371d4ed
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dg0BCbWAI2lWNIbPpvdng4z6hqRHOSmg+pNLH63Y72RnqMCA6RVfyHHU7bmM?=
 =?us-ascii?Q?9jJgJzJF9+amMvdXF5JW7IVRGlTnHmEBF9iUcb9aNdW2JdcAla2kUyRjfbzu?=
 =?us-ascii?Q?yjRPBPdHaFZRCrYOozwjsp3nWwOOvkkQLs2NeJl8bFeWwuV5ZTCL2U6yyQO2?=
 =?us-ascii?Q?S6EWixTwFKBHn9U963li/MG03MKP2RANADUu/iEYDdcADRXQ7gAFFH7WsPxq?=
 =?us-ascii?Q?aDiA2GwlfSIyR/vEKsh1Pg05E/yESl5b0qUsyePuL2v8gU/3n2dk8YOuXuLS?=
 =?us-ascii?Q?iqGKwvRQ/JcZ7+WJDqj/CTEtjW9C+FNvY/IdAmKXyyrNT2ht2cHlOnfoJzXg?=
 =?us-ascii?Q?3NXOAA3DzFhV1ymuVM+0QSg0Htbfn7Savr/XxelyCE8770N68n32VOiOr7gJ?=
 =?us-ascii?Q?3XHbR6zzvvkZdPcdw6ea2A/GgueWBzXapFCcLr4ZZJRPZDSI92ze8EpxjeFM?=
 =?us-ascii?Q?2t0aN2d5DYXCBLw8QLXkPW2HJBW568SjE5UBGmFbaGBQ2f+N4gS8+mjWot0R?=
 =?us-ascii?Q?+PQ6OhM/GHMIPc4XXn3nexFenPV4jcyqArR8WGZUEW/yPBLo1K7EnELkH03y?=
 =?us-ascii?Q?Y1ISYemL2O8sDvkpj6gcAyyWiQRVJMO28uJFyH/kh2ecgW2yedSMlMOwEhti?=
 =?us-ascii?Q?IzwWynGv+VASkf8oxnmYoIW13HcpPnKUvb1Nw7wZmy2neSfTS6+3rtQy385M?=
 =?us-ascii?Q?Ok5KXZgznJJA+OWKN3O+HTnWWM/zfpzQCmp8Y/JF5ZnVx/hqmZHUBSOiBmW7?=
 =?us-ascii?Q?9pgDmQgzpEUhSkZg/gnvaGh1IsvtHuN6oQd+6JweXzjHepLkL3PAZpzk2Zta?=
 =?us-ascii?Q?lBbrhn8X30wEo4/JYokLfHtW4vPTDMxriDUY6+i+v4OorMTqO2Oo2bcpsZQG?=
 =?us-ascii?Q?nn74xrFl9YVTre/SN//GCo3MIgOIL/fq0rZAPJtjfvxOLdPINoDZasOFNTJ8?=
 =?us-ascii?Q?J9C2im1BXLrwdVVh94WysQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ovx++SQsU74e1bmKaHJ2U3f+trMc3RFkojAxMcC43CT/r/zFcv3By5CS1hj?=
 =?us-ascii?Q?25399E51SbKh1xFsGl7ZIJehz7zuh7zWUJ9ARDHXD+tFT6SAfo4aSZ2DNjCd?=
 =?us-ascii?Q?m9Mr7GPbcyX+X3ho6SidiX/T3UriA9xRqVeKV6KqCTiSPBt0k7la7ChdzMwr?=
 =?us-ascii?Q?im0oaMMoDhh/bgjCrvv5rHRS6tbtcOydvKg5/eOq7QCelbcPvbcaBmgGwW7A?=
 =?us-ascii?Q?1aZLNJPOgNnJLdhFhOuHtvERSnFe3ckKnq0g/fklOY+6K7HE6ktak6++uyWo?=
 =?us-ascii?Q?XeaJssGjto8x/6pl++Gni5wP8Z42R8Io34GGQfE+vClitfDnnKyK/y7UK8F+?=
 =?us-ascii?Q?2YOTzk53kdSfp0RKwQej2zI3w5jxW/p7V6b9LmEEJdPlPMMw9g63BDZyk3FA?=
 =?us-ascii?Q?Dini1FxQrcrvMRQuUFR/lt5vWS37h2iSom35GwZku+c6ZmXKMKFTeBvKS2hs?=
 =?us-ascii?Q?T36Hjm6s5MfjhzYwKqvw6YgMhJZCb3/9Y4q9hbCVl1mvfK6R9Qxnu86umgXz?=
 =?us-ascii?Q?qfT0t0h3xBMv3Uo/fWqdc823bOSSDG9BW7Vv7j6JoDyHiN6bKx3FLYVymCmZ?=
 =?us-ascii?Q?kG8K9077OeYn3z0XGMEnW4AgaMNrBQ7HICWW0ZvKqn3AokozfP8qepf0nrWa?=
 =?us-ascii?Q?LpffEn3U2sgc3A3n871qwOXj5jkvudUQSPTx2F3NybiQOvjHGVpPRO9xKHYR?=
 =?us-ascii?Q?w585X/cpSBIcGHEKOkHu4LI+r5BUyXwWFiHGFPWNMv3kRSEEq35TxUTYj5xK?=
 =?us-ascii?Q?tK01CZ5+HsTTg8v9M9gJVh55EDkMNblCBGv+cwIayxnkhOOtKruuf4u/S8PS?=
 =?us-ascii?Q?hTsywBaIlT87xly0ishktCsI01ozsGcEhuBafTJKMcUNWV+EnlEgcRcjQRd7?=
 =?us-ascii?Q?QC4qgYmQFuhziTr4FqFEkKhS/NwM1vWdSUHVdBU8QrvmlVUrQh+Rnzupxf+s?=
 =?us-ascii?Q?kyVs5YUkDsF5Ooh2NIUunHfQjsxpsnHAtGp+DVE7KSV1Xv/ll9JVChUcSv8+?=
 =?us-ascii?Q?2lZkiqt1EGaxZBlTOt7H1hvb1SHh12HMi2ruMHGNho/5hN+6vFkISC/QR/Hf?=
 =?us-ascii?Q?G8Apu0oFX96y421qtavH3SB0CnH+JLu3P7Flvo9yjV9nwTLtlX+Rsqzx7bx8?=
 =?us-ascii?Q?1bxm7PqHs9ZbGSUXjBOSVHe0jelmoOh6ofIRq8wQVlNCha2FfzfFOczRFpoI?=
 =?us-ascii?Q?p3cPF4sxEiwuIxmdN5794P984huEqLmwhQfNzPIhMgfU5SOosSaRXJ/ui1xz?=
 =?us-ascii?Q?18SVoQOQLrY1a5mL3BJSmi89RgmnSysCGquAdQ1tMn+LY2uK+B6JAPoiI3Nt?=
 =?us-ascii?Q?rIF9PGqSfRA/s392POcFRIl1gZMhmD6yrGKfyxGIQ5jRx2ANRjaHxAw+BVJe?=
 =?us-ascii?Q?P9tJLbBJ/I8RdnZzdkZc8mF3z7DK?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979dce0e-dc8e-441c-f500-08de8371d4ed
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:46.2993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

Explain behaviors for autocorrect_resolve(), autocorrect_confirm(), and
struct autocorrect.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/autocorrect.h b/autocorrect.h
index 0d3e819262ed..bfa3ba20a4fb 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -9,13 +9,24 @@ enum autocorrect_mode {
 	AUTOCORRECT_DELAY,
 };
 
+/**
+ * `mode` indicates which action will be performed by autocorrect_confirm().
+ * `delay` is the timeout before autocorrect_confirm() returns, in tenths of a
+ * second. Use it only with AUTOCORRECT_DELAY.
+ */
 struct autocorrect {
 	enum autocorrect_mode mode;
 	int delay;
 };
 
+/**
+ * Resolve the autocorrect configuration into `conf`.
+ */
 void autocorrect_resolve(struct autocorrect *conf);
 
+/**
+ * Interact with the user in different ways depending on `conf->mode`.
+ */
 void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
-- 
2.53.0

