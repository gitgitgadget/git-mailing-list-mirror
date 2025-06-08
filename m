Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C032066F7
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380237; cv=fail; b=Qu2eGeZYgynqTYyNkAoZJUGmlMmKVi+Uvx4h99S2/abFERYpa/Yp8pIe/3K3dd5L8giiRL8q/mgZX6ECzIFwdIkYWgNKNg+RsZp8oafIndIfGCm/JI+IX4vukNr2CalTxSnhq8nTLXJNdXaTEY6KmVk7VzYGtzmL6Tu4mfrPKDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380237; c=relaxed/simple;
	bh=C2Ea0fZ/1fbZp7wXFXYheErtV4NTDUaAB+ZPCRCqPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mBTjjaMPVMdcIzKTDNTVQT3ZpkHU4VlVqKdmdayZeaToo3HUP5sXDhs4QwbqmF5ybyB7e+cT1WV0U3jUgGcRnpsnIpgVdy8bQijSTskQpFzdt5/F2gBTDxeBzkQy9csNorDuq/eLvA/Zje4W0dFB34sysPH9u1G3P9d6W7PSQ+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GGapkVjl; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GGapkVjl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+Tg+/3ZUyUmE/GgbFW5OK9k4CTcm6zm1Fdtr8o3cPM12hVHc6HHXH78GoamZmEd/UnmQSBw/2K5+5eha8bFyrHorRIWvIA6Zpy84Qc4zvJug05bPyJM9hZJbZcNJpL67bTDn44YHxClkZwy1GodPK0nr5PXKAf0BC73OetJ20Hbm6PnFo6C48IrXVPcKShSI7EKCmZCyiNXfM06k0R+eufTVB4OFRFffEKYq+ri2Ted0LxJltcASepAtZhAtzmlUGcQ1nmUIoe99IGoFnzXRGUCVDHjlB4n6D5wxSQOoFOTdOJJtW/mSQ3MZmdAhEqrm3xfuelOhKL5Brun/dCqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=cUlgKoNCTZ+pu5MBO3JY3Tg2+yAFeqDCjw8cAML/Dj0q6TbIFPQDdkaEzogI0Kvpq+UZX1Oerm66u5rVGbK5lsLPpQexZqoRJX0/nxu63rjtFuLyCf6EO6M2VZDXAH+BQMW6jvNNSB9k3TK/WEh0jbDxqxAIw439zijR96xliRrYOU0rv4f/9udMQj5IuLb49ofW/em7lf5d4FRrfG0mbmo98gA2qVORpnK2lMsH/tjoHsbjOnWi2RgjbkTrjFstCWWxk9GtLjMAzlPo+BDgTdW15nWIeVVs1wBibLWoQmkUBUxY72j0/ZdDqSVp0ZAoRSgMeeW1oD8kr2x+COLkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=GGapkVjlDiJIoiq7FomMe/v2PR4BYacSOyxedz+MNk08Kbjj7Ie+zKQc9wOa1zbA7uekvb1IvQlkELT18Pn1dpRDSj2WiD/RYZ16YrjhY5Wj4eyjsFrELc3mBwIU3A07zwq0xLpsGDpzdpnqapmdINqG8OghgrrS/9EnnlwvLGLm06sJ3ym2NI+DJgdZHvwNxYENGRbkCp3QfRKPGWwWd2wYlakl2A6SfcFChx00rhBdpqfIyED2N33jNwASrYv/lc04Q4Z6Vk4RdndqDQS/Yy734p326sBRLkwz1pkUuHR2T387N9I92BbR97lFx9UlRrLEadxCXAI4rrCJlEY5Mg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:57:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Sun,  8 Jun 2025 10:55:10 +0000
Message-ID:
 <PN3PR01MB959745C097CFF0A50FA4A05EB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: cc62d4ef-ffe6-42d2-c862-08dda67b3677
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|5072599009|461199028|15080799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/MV7iKFAcEYAG14DBx2mIHvFKtyxsGfJ//cmHWcE3UjmN+bfMF4YTvWD4eMC?=
 =?us-ascii?Q?glDd04Q67xenvnu04K3RJWNNK1EtTYklAQMf4CyhsRbY4t8n+V67JgbHkpyE?=
 =?us-ascii?Q?oZs4ZnQ8hXy7QCDIIo72/5omn7rlamVZwKaHiu+kogtvxUpndK7DmxxC24WA?=
 =?us-ascii?Q?e8lg+rzDdZsiqIADA6z/4t8wv69+fSIfBTvnANZh1MgPITwb0kQTku4D9ugp?=
 =?us-ascii?Q?++MFoyEdWUgsOVYnBrDSYz28QsydFTd9U40A411ULZQAKbXuZ64dPgqrd+Dx?=
 =?us-ascii?Q?eYI8Fu/t5BBy2hXjDAcTscmip+HBnwahN17x/KsXw0CzLZDHIRulfPrK5o+j?=
 =?us-ascii?Q?19TSzQsbVXO0tkTkQZCIVmV5UQlkp2uXKuAsHq04rIsgOU96xWEzSdUVNhmb?=
 =?us-ascii?Q?ZtE3IRj+UayOQC8IAjoaZFSjRhU/tdnoXPBVjkPnsDy4Uzt0FGkj+i1YYOA2?=
 =?us-ascii?Q?WnEYUHSe5ao+oL3inwxMavfE9Y4iC37oivaqAt+oLUHYWWW0YVBd1pGqtI6o?=
 =?us-ascii?Q?2OFOX2Z7Ua3SQmM1R09h2aP9ST0bx2PJjhcGZEj72oUqZB6MOByzNkbLGo1a?=
 =?us-ascii?Q?VKP5lB+qmj8SjzLxfATid4ZHFnQIAYdlrv5gmUcuCEYIvuKumkmZOPt6mwiW?=
 =?us-ascii?Q?w02bk0zOseaomr+HP+PPqCUY7z/rbwQCGQFXSQeHp7/LlOCTDr0WFXzWuRxw?=
 =?us-ascii?Q?x9EcYc6NII7MpKbGVydNewOYFDZ92FnoLxFzcftXD+NBPRhWBeLs5KlpG/vw?=
 =?us-ascii?Q?kzxptqbyl47dImdAhG9i/Amfm3tuU0PVwSB+UP2XfxdwlnU59RaaiU7YDOSQ?=
 =?us-ascii?Q?rT7SwpTgRoBKiSuMWXs+u9QrsWW/mMxaqoNQUkxYcz/Ngwq2bdvXyys04eHs?=
 =?us-ascii?Q?8AbxSgPLMkjNivJuwlhkgdmDP0yEnvGuXW3Z5ah983oISo5W/nM0MyMvl576?=
 =?us-ascii?Q?UDP6vv2Na28XSFZY/ACVSq1X5VQXGzHt76PBPSu77lb1J6x8ubGwW0Sd7tA2?=
 =?us-ascii?Q?2hQtmBvHv407piJZxWhy1V062hl1LuvWKED0BJhwl+bAD2+eF53m+OVua7xC?=
 =?us-ascii?Q?B41UoSdtQWCIJd347NmjihrYs+HN8V049XdYcCwcIg74fR+Jb2Ba7PYWYEQL?=
 =?us-ascii?Q?No4lLpJhlJRHx/2BLBMCHxOBeKNeK0lLkVBid2I3mK5mTXZbzVfC/+0=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B6fKmSylXbjj31bzxp5Xp/6f72i+3i9ipudd/eadbsrdDvjWAto8/yC/TmV1?=
 =?us-ascii?Q?WdKNCWfQwL7dUSOQOqgp9ydf2mZkQmKK+PwyuS4vE7JHSIgkgD8aVhgDJZmb?=
 =?us-ascii?Q?QxjtA/tdJ67+eUj57MqmmP8oRFMaGbZIaugJv6vlxunhnWivo0DmrDPyz6oR?=
 =?us-ascii?Q?2PwOXRxZfCXHcNn0kUIbdIkupr3n5VND5nvJFZQw8+V6fqnpeARE+NrdC+Tz?=
 =?us-ascii?Q?qsagN68ch7wQNpDLXS+SdwnFFmms1QSFZQ6sLyTndFHeBlDe3XWEXsjufnfI?=
 =?us-ascii?Q?E83LuEPBavT1hwBUmzkUtWT8Scgs8oeuhAnzr4L5CUFTYkZlcHiG7Ja4Txxp?=
 =?us-ascii?Q?/Z2G6RIznaM9PndxFXjNujUwCdeS0v5odhgAOjntlBcJNczZ8nWUX8/i+QZF?=
 =?us-ascii?Q?ZGXxoG0dZBml60/6jkShrJxjOgrmKJ1TLXLUcE9ks7yXFj3KQTeWqP8xn+YQ?=
 =?us-ascii?Q?yvNnUGzct/KorR9gO1l/fdkyP50cZ0uYiXcozPxnDCyKRCL93GQgetR8NBVh?=
 =?us-ascii?Q?bLVqpCfpmhIp3qjns2tb/IwrIyReKbq3hKnSzIMdpDQwX0QWB7IiGue4achc?=
 =?us-ascii?Q?bWI+Ie4GCjyTTWoZ7m5j9+xClW8UqUmFU0mv0uxn0oEaRzpvmYqRhWwyX4aa?=
 =?us-ascii?Q?XLNWodaTFYR6QjCM6/Xrf/R5f43ONQOjSX0IHuLtnldn95+wtTW/w9R4LTrs?=
 =?us-ascii?Q?2y+Ky4ZN/0THBK68Ht+6d75mNPnvZODPtyeHqs8jXQ23eDoychp5F6YmIP+l?=
 =?us-ascii?Q?U8iTz6pNuIjMTTWDKyE/GAJk5RW1NvVu687x+OFbPJmn+TLFVFNU2bu9uRdb?=
 =?us-ascii?Q?o3mYIJpfM3cJVpUTTWqAYRsNhAOdv7mbqCm/3LEMM8yTnUnVLPmPoujEj1u8?=
 =?us-ascii?Q?kbXXvwBVVmB8I8weWRcfOuYA5TC0szkc1PoLHBpoyk4wDNmISgd75pV4Sysx?=
 =?us-ascii?Q?VYaoJS6+im6UjeRgJSZxPeuxKWtYpPTY05sP237bb+soFklpPQWZeOYI9WES?=
 =?us-ascii?Q?ZVF7aWvgg8kqHoIOYtIsE23QqCOV5NjHXUEEfeZvfkwFhTeXhKDtvojI5k1D?=
 =?us-ascii?Q?RJETkuzurW9CoD5kOj0L9DJBBj2XdtQVOHZp0w9waBheEcQOxDTBuOoSXyD+?=
 =?us-ascii?Q?BaCoHVkBJ3EL41KMKgDqvG+AIobsMEY5GWiijPS1Z/MczXVAphKJv7kj4DDv?=
 =?us-ascii?Q?0/xBjzeij4bUYe0DmgNcGd8jwoSyMxFYumo2zw1+fsY8l+tzimXZnRcO4fY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cc62d4ef-ffe6-42d2-c862-08dda67b3677
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:08.3546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)
resulted a change in static int git_imap_config which resulted in cfg->folder
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed for
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
-- 
2.49.0

