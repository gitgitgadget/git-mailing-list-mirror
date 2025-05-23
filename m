Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7E7367
	for <git@vger.kernel.org>; Fri, 23 May 2025 04:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747973052; cv=fail; b=k+SI51MP3h2ogPrZRVYTdJD+XRPXxvuu11gm68Yw0GVxs3anISPQzwuEvHJlV1BEL4ZDpXrbmMIVG1RH/Y9hem96WfGW4wVgwklNeF07LrZ62Y7ChFphlFWzvG2xacD+LT+fbpHCVkmnj8gKCENxlP0UHYdU9ZRUXwaq6NqRZGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747973052; c=relaxed/simple;
	bh=WNao24M5v2PImHF7jx4D5U78vqnG6h4UhkzDoU3pRAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ThKF558R6CuD8YuhwbAeQ2TU70MEuuAEsQqQmsuO01nowOI2EPEhKkxjdgVMdfX0Ts3zW/1F6xzFulSy+Pspi+C5sy8HRj3sWN5xE9V+VX8KLpG+gVfQjXEuGx9wh4HVUJumcjcxfyeGHDoKrE1P4EJzJTyVCaHiK36eOdYW6Ko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jto8JBji; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jto8JBji"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgm1otUe/KbHKcrBV8Ca5JNNcDVE+KP8ARE3mOkDE9XaDcOwTAim/QwsjtOEXOzs87rEzLGM1Jm1BA6iAdsO3zomu9ruBpbE2G6VGfvnXueHZ99NbJ6k/eJ68U/kiTHmOWze34u0xM8wkPuqeNzwdH7cMgQCyAp7j0WvBNkXIiuIV6aqqMtytCu2gLb5zv6WSTE3Fa0tzgQiSXfiCjkuDtKjZHtS4wfsXaIB0LWAvJnAU7ElBoDE3X9uWIl15YPLUtOiDIgdM1QLE4a2CUPMVucKCeEck9B8EbQfYNX52r2YnjomYw4OpxXOuQStiysjDmI/Gc/UYovnubJpLf0z+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omkPCXmLmGf6VjGVQGkp+7BktBfxJXegY+Nzm5M0G9Q=;
 b=DpHkLXrQBs+UICXUdu9S9sAL1VXg4vt7TxX14YJ9kQ75N9YDnVYWluNNL2VGtWHyLOFkqCk76hSmX0io6AXiMf29O0Yb44os3BJImVO4lKKm/Qz/fSPQw/CHHxejslLCVO4uqfs7eV96QzbiGg/rXtWh6Uo6ZG2Lvz9Dz8th0OszvYK1lPjeUEqOXE44FQ+lw5Uh5OIeldkbFAYU7pizvat7TOaHDvg73duf8HALBqrIsmQoew3fkshnTIrxyebnv3T5X8q+GoryXmj6RcFlw+BtXSs+MgHEYxb3ZMRZyl/yJFfFAaKubdp05AXZNQ67i5d7uuKaQDqGDEwxC/Jh8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omkPCXmLmGf6VjGVQGkp+7BktBfxJXegY+Nzm5M0G9Q=;
 b=jto8JBjiLclfvnrYfx7VDCZINywiUaICFlwijKxt3nqNhcRLEcMQzBEUBnLcE/J0SPUrNcWtz4ERL1ykdPd+fcA9sYr/+KJ1gAR7JC/v4lwf4smxgdbRvPS0lr5FZaJcTRt+YedSvt62Q7Zkyhaxx7c/rQm8qrmp3uWfL2HIImdj+wfEM+V/ehA4K5p3olZbK5PauCWtx2piWkt4WLttmBTei23lX6+eKVD1ZpH+19Fv6BSLA/BXMltT1BjpTzzt1Iri/Aq7JRttfxaIKEjUhH144kwTTPMYfINMwu92PFwZ5DQ6kZcaYmZlDBA6CxoteKpn2bkgXdErVgXYZoMd9g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10178.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 04:04:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 04:04:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] imap-send: make it usable again and add OAuth2.0 support
Date: Fri, 23 May 2025 03:58:31 +0000
Message-ID:
 <PN3PR01MB9597F89DF32B700ABB8AEE11B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0033.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:263::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523040347.25483-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: f40fd0e9-2e19-43a0-a56f-08dd99aedabe
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|19110799006|15080799009|7092599006|8022599003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwoV5zrU+qAz6+qFzYNepnjvE0qVDr7pbKEg/2+vvTslUJFcepXY9Lc5BaF7?=
 =?us-ascii?Q?R06ZJ7+3HY0QEn3CXJszWiSWE4s57Rn/8TL92pE8XWGEQ/67+VpyuztxvYkU?=
 =?us-ascii?Q?tld7A85JCzn7Ltt6d13/iqtG73ir/G3HmK2sCJXKqt1nFkpEufcAuHV1uiTh?=
 =?us-ascii?Q?BH6Op4YZj0GdVWnXnpVIPJJ+iQF5ToxaUv6gMvBEGvOnJFYBPT1cJIO2qfgD?=
 =?us-ascii?Q?4maJCXgtX6NEmqnCB191pepHapHKWaVpNvvQdEpPUk5yILnhZKNHkmkd4b1R?=
 =?us-ascii?Q?qTaAJQRo6A5wsRPCqwzQtir3E2fjdkr6xie2Y++a81bvoE7WGZF1R76G86aF?=
 =?us-ascii?Q?U2o2bj66Hcvc5VxBDBLa7dOGlUbKdw+zf5sdUpa8NNBCsI1LkpEPJML6chQg?=
 =?us-ascii?Q?h0IxU19mM5Ytn9cZRr0MO0/t8cba8SkG+R5opy0oyh6IbA7SAoQwm5KnoGKc?=
 =?us-ascii?Q?f2J883Tq/+/7f73FQnetvfkT3+8PDhEGdfiBuS4uL9WYPmRjQrYf8y8JYiQ0?=
 =?us-ascii?Q?cW2+h4lORKX6mQ/BGZ8D1ETOb3VtH25T04bigHYuhnpOcQnhXPsGB04BYCCI?=
 =?us-ascii?Q?FDjmfATw0o6RTfz3UOO7NrizUF4nklfTNA1rj+E/PwUfwKRrwQuTZKtTKUsR?=
 =?us-ascii?Q?6XXm+A1chdeZHhLkD5W/R3RFAbOZSTuLIe+yUMDdFtfwGg7VoSxaeP0QY2m+?=
 =?us-ascii?Q?LqPKNhz7Qnkz845HoSUM4zrrGGmhbddirR3e9u/tpBuGc7fRfzLyzCM9rSP7?=
 =?us-ascii?Q?GPgPa4YwKEqVH1m2LyxtIgTYOTVo0nW/ycu6Fcf1zlfbxcS56A4tEWndlIK9?=
 =?us-ascii?Q?/CmGuSxSxyadA7ctq7NeI6dHd9Tz4eaX6am6daLSzVTQe5TLWnfpqPsyzNWs?=
 =?us-ascii?Q?DEhBQjxSH2o7Ecxtp7YN9r4UXNOmzGcyMdbdtsb8dDOZ4kytB3K7TxCbPiDG?=
 =?us-ascii?Q?ULLAPB7fra0khsrZZt768AfLyoqq+oxshabWmreT5JTfGCVzrHZkieBcyce9?=
 =?us-ascii?Q?pT18Tg6B5z4ZIEGIH0id6XRpXYdCyosHL+JZFaF68rDAvMH/3r/Trft54Z57?=
 =?us-ascii?Q?1I7Hz77clPmY19PATDItd1t2DuRDyEFkc2hbARWzxRYk4AEyqoHpK6L4KJab?=
 =?us-ascii?Q?xbY50k5wCEPr8+CycU+cB7xfcNGc51z45A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8m8QwBxuZsBwXxe7LUxiUZDv+FY/CMK4/vcQkIVzXw0075ZzwkszFfBPod3f?=
 =?us-ascii?Q?u7hghBcNVL737o5MLbRd+HDuYI2fYUWACBZIIUKEbQShzuAqOgGtBkCXZMW+?=
 =?us-ascii?Q?cIdk/C929ALf3QZNXmIP6r6pH3FsEcAG0dXdfpkC7dwE7mEisLxykBJ5tBrr?=
 =?us-ascii?Q?RubCzEL5ejZh9Ez65NUTwTjE8uyk2jxRy2aTedQbwOqbQRHx5j9em8a6we1a?=
 =?us-ascii?Q?w05XHHLrUSx2TpJHYeLL6wIKC/2sMih0s9DYyNeynOVzBAr/pM6kVQgC5hTL?=
 =?us-ascii?Q?tv1Ui//PNp18lsydyIzhKToYHxL+vcF6tGJxxZy/ECxs/6ElmA6FJhYpvqU9?=
 =?us-ascii?Q?2f+/H6BQgojXB7S3Ucu4YfVF6BC5SOwHl9iVYr7dmKc7LKFXMk0/a/yjoF8q?=
 =?us-ascii?Q?HK2SWH+XItxT72MQ5+pjpRSCO7Ludps0LYxAY+x5PbBl2D8wFX9CNCSuNdjb?=
 =?us-ascii?Q?OisrKIKo6iSj0W9KsQftxmNPKWtikG23cDyWIbrYDp+R94izqjy+dSPRhNjv?=
 =?us-ascii?Q?QOGrGEGmFQaTHSbUt/m1AKYIOdOhVqeWZO9N0PwPxAFdPC02+WUhw4RAWO8o?=
 =?us-ascii?Q?9+TEWkFfz6NU8ubGN1c1mogXy+hl4eP6viodBWO9tIju62mirz5nx/ZdisCu?=
 =?us-ascii?Q?d16k08BvndK6N/UflYzXv3sho704cX195Rt5GUjBr1hsdCbcNFRHFwbTkinv?=
 =?us-ascii?Q?HPyEXbRcxFy+jIWrRcaxScDOACBlpRM8fqoaGrPF0jquAKoPcnDTBThUlWPn?=
 =?us-ascii?Q?GHyF+7cNHIFt3d5SZMKEF8mc7lrnqbjp/MAzjCM4Ykcj43dPDCKa5gkBg6Bm?=
 =?us-ascii?Q?PLr93lud8XOTB8NG+NmChz/HIXR2WlCfxpB2ijWVzOgR+7chE6TQmqNpvmRt?=
 =?us-ascii?Q?2qiRP675KT9qICBPLRFMiTzfh+fcUdeHssU1NaoGDNO1wyd5wstgWTIV1RYi?=
 =?us-ascii?Q?iT+rqFiJSl4ZfdQqfNxUCfGXL7PMBF7XFmVyeasjvC8J0P8F7sIz8A0TIuXV?=
 =?us-ascii?Q?WGfxTLMrGEJXRUzgxI/jtrOC7qosVK3qFRAbujo+nomVjOQpL9Rce9VEDs8U?=
 =?us-ascii?Q?x5Ehy26wknhyyByhPRq3ldonjnTQYaJeNvOwGq0aGxafOsFIH4Rq+LSzGblq?=
 =?us-ascii?Q?QEjs6ogDXhZ7zntnuCUx6hvg8MEuz/zCzejFPk97keCCv//N5+jOvmzqLTWK?=
 =?us-ascii?Q?vA5C+rnYJ3+/3ravYg3HlG3/SvFs0+pL+2cyzWr/r6y7qsMPg5ikh602npA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f40fd0e9-2e19-43a0-a56f-08dd99aedabe
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 04:04:05.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10178

This patch series does 2 things. Firstly it basically makes the imap-send
command usable again since it was broken because of not being able to correctly
parse the config file. The second patch adds support for OAuth2.0 authentication
to git imap-send.

P.S.: I am surprised this thing even exists xD.

v2: Added support for OAuth2.0 with curl.
    Fixed the memory leak in case auth_cram_md5 fails.
v3: Improve wording in first patch
    Change misleading message if OAuth2.0 is used without OpenSSL

Aditya Garg (3):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: fix memory leak in case auth_cram_md5 fails

 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  46 +++++++-
 imap-send.c                      | 188 +++++++++++++++++++++++++++++--
 3 files changed, 221 insertions(+), 18 deletions(-)

-- 
2.49.0

