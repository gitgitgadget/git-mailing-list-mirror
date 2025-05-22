Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FFA299A9B
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943516; cv=fail; b=GfMcmuFBl4R+ww6elyvm+v94/0KbnTp6Yq9svH4k++MQs/k3ASmVUVVIWkhqf6a5Udrhx3NoA0E+ErtdKJuwzufGDEVeqrs6bLpRWqVhHfIpKQlnsxUBL0kdm+0cWxMOp0DkTbbh+waPqporf3nEqCSxbwO+5d091E4ZH9UoqXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943516; c=relaxed/simple;
	bh=5LddAi2fCPNUuqyL4GyzBOTIgVRkg/cZCsSJM97hxbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0b8Wv7Ng6RD836vccw8uMNKs26ssIVujEFHVThUKaRyhxfZuvzFMfPbm6q0GKktiI8cqO4hMzvIbQXn1ub2S0cnWHGtCa5p9gclNOqj1yKaBmnpxHedXo7hfc8ckSvxFw46DGhdNiijKgBXvGefrhfYGoJk8J9LsrG94N7Nw3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Sdj3olsZ; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Sdj3olsZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HrKvzw/U7Hb9CfqXxH5QPB7MxNEpCLqMgHv5WQFgdyKiC8ERDJkzvKjGS+XXFlegQdNsM5jojRrRispDnnbjjFHlbS9mIYpVhs5tMaq1/p9Vyo0j13J+dLPVBRlBzxxs+M7UHaKxwdy/Q23m1b/eLp2A7YbbEaLkzBx1JIy3UU4MbgBSJvOpr7GSH3gwqkKrfKZ28wRNbt+r70tpR0UL0BYGy1dg1dhnRGmXXDw+PKFNwVh23YV4iFDJMpkU2sLrxKzptwHBqfOuD04XMgia9f5svesS1kQHxQa6f/4oLa7luqA4OK3mvrirNWe8VAMEbsvWPv8MBda6ya0o9eh2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP+0/tps/9lc03goH0JHyISm7ITgXKinAHj537bt2XA=;
 b=Li94yNK+ITwldhwepgr3a/JMroyrmUdJhhAKmc6LOHqPfTPHJw65PZ80gAgxY3Wxh87ZBRp+miPiPG2idhHlqvEHHUUo5/HF9Euby9oIcEwqCGS/nDZb+MphzindYH/UmkJPR8Tt/1w4lyACoWoXQQKI57VEggpZBZv/OOy5SqV5YIz0HNy5XcXs+39RzA8pHU5oTewjGiYOTKR1IGnEQ5taHDnf1ZjKPizxyRLJHPwPKmzPWbWe1ur4etpXkV3hdm4UYL5wfzKyLI5ADPIFL82yFJFomk5ElJ57CRWI2oz4BjQnkXNsuDBvZoyluVzpZ91XjLjuAQakPI5uHbggyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oP+0/tps/9lc03goH0JHyISm7ITgXKinAHj537bt2XA=;
 b=Sdj3olsZ1a7a2Aq+TqVccgOO+SYb0flLZ5jWRVWBmSbZsmKDPgrvVB62B99gA2Ejb/2y/Szba0Ka7+c+7ceJ11z4JK4d9DYZDrN53kriBW96aWEar4SJrhR4w1xjY6InY3nmf2ZYxOvhSfAbhl62qfvItarACESR/6XmSFot+4VvdMPfNqTwQL5F5JBeNa1EE/MnTkt1HA5c1T1JHoADnIoaLEhZpxy+B1Tkd4N8cBgydjcAyKQVnVtA/VNggIZJD5oZHGmmjWar22HtbnSY4+hAJMj9P2ka4jH90ZqrBymHgwc+ZZy7J2o6iA5LWwsYUZExzdgop1wO8BjVFhuyQQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:51:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:51:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 3/3] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Thu, 22 May 2025 19:49:54 +0000
Message-ID:
 <PN3PR01MB9597F878D41C6CCB10F49587B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250522195133.9170-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f5bf3c-20f8-4f8a-b9e8-08dd996a14c5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|19110799006|41001999006|8060799009|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/lzUzdjXHVv5KVCtnSEWvHWSx7XLoXjQIPx2g3VsaPXj4NCMcA0aV1RW5hMs?=
 =?us-ascii?Q?RY1EXmHAK9/pmKwChgvVEXyV8EvFTBuKA8xUPdYovpdJKFzcAtCCk9PDhIkQ?=
 =?us-ascii?Q?DnpzQNy5tsrYh1qDM1F0NoxGU2kF5yaDKyAOqPXoN5kf6yHKfbSLiDJ586Nh?=
 =?us-ascii?Q?+ju2EzRO+sps4sWxKOG8UVqWaTP8cVgxAZ4ZgiFgJs+ta1ix3HQM7OSwWi6N?=
 =?us-ascii?Q?Iujyf3TtemIosQ+xMFQH3uPNfZjXzUhWbU+C3PrfXAeqFR2mZhuN3gpdn0jX?=
 =?us-ascii?Q?quoM34miG+cq6455Svwx1BpWly68MYQjOARxKnpM8tEcy3WaONpQXEB6af2K?=
 =?us-ascii?Q?cA77bNeEgEUasedGt2jxc4Tou/TQSvkK4WCWKetaJX/26RWngio4TBqbY4Yj?=
 =?us-ascii?Q?dZfXVrk/ctATxFpxUcm0PL5iN2Fk+OEWTZ7OuCZNOW5LY+OO3aNBDISItG2h?=
 =?us-ascii?Q?RPUwFOAvommeHV3/4ysxI0LjzhOxG4nPIvuc35MLxSWIrwex9iMnw0VfXOla?=
 =?us-ascii?Q?/KQGFDREyqVZ9ZZxBWLMIKFkvUNMXfYkCcCJrXTgwKxdDk3TemVv9ulHzuve?=
 =?us-ascii?Q?AWjiiBvSz4YmM4JNGxjbQu+rzqCrifbv3TphC/MubvLNa3lU04R3aaOJZvZX?=
 =?us-ascii?Q?aj5bsMIjEWx+CwNtEfQEV1Xqw+BzbeO6fmbDErX8vkxGknsFlmwECNEdW6jR?=
 =?us-ascii?Q?X5+bM18u3oMSHWP9tfusABvP/kQzXTuZPsj9AMR/5AlaCEfArIBwJqp2GeZY?=
 =?us-ascii?Q?e2e50FhbKWsTbqJj4My8Xmjj7LmzC6AV1briLYALvLRwQvLA5gfd/3UQz+O+?=
 =?us-ascii?Q?qEOY33xuuOHPmR/QRD+GKUsIkGLxLLiwIYb3ETpuIxBm5Cih8q+XhMSMj+z3?=
 =?us-ascii?Q?jbQHk22mCq0Y3Y9uJMTIZlZjjXM8qm8VHRPZViuPRrVGNomeowIsoC2xvvAX?=
 =?us-ascii?Q?eduFyfseixKi1vLI/Kq6j/9HQU/VuYBB88soQnsb+zHHqVer/heOQ/bTDXl0?=
 =?us-ascii?Q?sWTV3kyPnMetsvvhjTxnICm+XfH+sID5DXcOqOENlSx37jAoUTFEe55BD0yu?=
 =?us-ascii?Q?/1ubn2mm2abw5BhuRGI/DUtCwLIzLbe8YJAMgbZ47gpCI8eWTyfI1N7Ru6Pi?=
 =?us-ascii?Q?QOR41KPpi32W8E3vlNp9bR8qToHFcqUtOt3Vi+qCFkHWjEOngO73MvU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+O+i4WKtalc/rq2LCauzhn/ARVe2TpbZlmMh+Jb3me5ln/K8A5k+J1BkrdE?=
 =?us-ascii?Q?ldihs6txP0cLdevNrOlnZ1PwouyrWLELnr5/B5W0ObdOYi/EtkA0Yk9djrPC?=
 =?us-ascii?Q?mjIvQUzeXpGwrMuY78nJgMgIIa0OeM4ZqC2URxTESv4hvY2sfGEt0rN6eDxb?=
 =?us-ascii?Q?ZaJ1maNAu1h7HkmwSRgN5Sqm/RQdwmkpdFsXXOnDuwig2uYuYFsClfM2P7et?=
 =?us-ascii?Q?UDwt8dZM2AFi+A34VSnl7+zrXWMWyKgwJvR0bWW8ykoFBbD3Z+LP0RSXeSV2?=
 =?us-ascii?Q?x3l5bNS3w4NGrid+HKedfP+U8TUvB+51ilPyVlfSIEHq/6R8G/B9EaiwknMz?=
 =?us-ascii?Q?kIxb2k9bWiaTTa2SRWK2R0H86KAcHYWAat6SFAxn9hjbLz0UgPsSmOs4BWdz?=
 =?us-ascii?Q?Z4GlZMgTze00F/3vsikEm9SQJ8/Q9tlHSMbWJv04TQYnIhgvLTryEby56xeU?=
 =?us-ascii?Q?f1Q/ADCWlUpr1YjQr0jtJr1v09pmzHZlq+s2+AKLr7pDM75i3fIKy725xLlR?=
 =?us-ascii?Q?u8J99KPeA9FckcHfYnesdj6UG0eOLrHXg3ey17IENqA5LQbMLupGDQzPnZIX?=
 =?us-ascii?Q?KaKVy800orBpIeSF7rJMwn8gqaaS1wWq2H0JmDqmJ2COpCOHyq6MauhhCsVx?=
 =?us-ascii?Q?pryND/z6hdaDah3rauMN3UsherSnxJjoZjhUGJRb2WIV3JxO/MUOMaxyx2W4?=
 =?us-ascii?Q?x2ldsLNqr1ZAYwUSB2PClIHb/cWX8/1NpA8mB1VftNqm/7g119uZVK+ZkH+t?=
 =?us-ascii?Q?dT/hjUueQXkj25Dz2SK3Z81iRe18gnO8EtJip2wksxcVIc8FHByXQ1GrgK5e?=
 =?us-ascii?Q?utkGzohp249pkh4ove4ilVk0Waxh7j823hBT89UB6yqKq0G+ihkuMYz+ZQBY?=
 =?us-ascii?Q?jQbjT4tT8VYAYmpO0gOiW828AtonhdwRBIaM6kyRXIHa47qwX2pUml2IbAwP?=
 =?us-ascii?Q?MED9ByK3S682wRrYhZdtfi27pQpNh/E520f2fKTCxqvD8U8ol4NM2K3zCafT?=
 =?us-ascii?Q?sIZYOjqC0jLA5tiNbYny9tQZ7a8/C9NI5bTgO64lr85NkxSWzUeWrXLgUuX6?=
 =?us-ascii?Q?AN40iMT8Db73APwHwSA4Ls/V1F+BF6c+1oNtsFERMeh+mZEuPezvUzgZLCXL?=
 =?us-ascii?Q?jSDcmxfqEfFMG04CcZer9LoLkDEIkx39RuelFTzw8lCd07JTb2UObHzSlsQc?=
 =?us-ascii?Q?UzOfXEdxb7oF+tJg8Fp+SVBJLhDapqNDICYSdKx+2DGiSgBxeUAY2UvDhYg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5bf3c-20f8-4f8a-b9e8-08dd996a14c5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:51:45.3560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6385

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 7616496cba..2afc4fb63f 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -983,8 +983,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
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

