Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329520E71D
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483766; cv=fail; b=i2jGe3lCpeSa147T+i5TgY+uXvmOh2sdZroYU/k7vZmhnlHAddfd7C6OsNdpGKC3rQTRhcPuWHgl1z3V7fYaybjrq3mR+uxtj2/koQhOcJvGiQ29hp4/IEpMPB9MsX3XMb6hbty5FnEO//YUzzkLP6M6J+IMnopltoFcAG3kwSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483766; c=relaxed/simple;
	bh=Gxoh5NIITKMv9eqqHW7BgGmo0jHtVwjB/+o8twCBMqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kqZPKePn5ZuYwSy9LsCe0kg3Lg6Am3dhCBvifjA/l1Dcl6xLbH9CY53Jk59wTK6CaoOSp0T455g57ge1mjCUEIRgdF9M+hAqeHp36/EyQpCZLLYJbBqGJEyg5vNCe9pUjA7bwhf5a0nirb0tyk76/DT4VZ4rSptcmGq1JrPA2d0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=QUxWug0X; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="QUxWug0X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUWuFqVl8XAmh/l4zcJoJU6Ww165O/prYTcVSqSWi0mFnAO1X8mZSiv2EejUA9fjKRwPC9CnDmQQOCqeYteHe8nihJDmm7dBSvNMduIsaUdENNgyALNkvRIx1ohMLFuTnRB2lMeGwjTnedjmKoHmaFK1MjDHqKSlscIM4TgdCZHQJzFMALbrGzKdAqut+QUNBlGMqx/ynka0O7+Fg7CBBiyVuTY52Kc5jjSEyePc4/OfQRYi6oDEL8Z6ghnRXg/TSZyCy/XOy1SzdsYkBaZKiYpmPyUZzBc3MqoLFzmWEIxo9af7nzbHciVEkOoYef/zHCPWmVLCF6BW3ziOBfMZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUCYKegCH0DI2e4aluuMEWY4L8a/qdCxea/Jc7k8PlM=;
 b=qfsdLoVWhMUoO7HmWRnNAosBP9Yy78Ns3b/NqSvZ59yH3oIJ0Bay/qxlS37zFENpNksw7m9VcktKXQa5Gkqajw+/4QidhF7Kn7bZE6SqXBKAbQ1ZSNekCpWBIypFi2+XEietUue2TfnHvX9k8aKFs+3dn/2b5mU1scx6mBgkTIe+WdbQcqvx9CQZnoA/RExlMoNWvfiOgOsPu4vfWv+azIrKJmu9G9CS1M8WANYegFK5N1rRxemzpBbXsf859Qnhhbupd8+9aOSDnO0pWP9IzYqZPRPedhx09YEBdDeAZhDktTISneYOlmljnePSBJEQf8BpP63MRx+Unn3BYtu6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUCYKegCH0DI2e4aluuMEWY4L8a/qdCxea/Jc7k8PlM=;
 b=QUxWug0XfZXkzX4EHDQbBzMmbbB4Po+Bf2RyTt8918/qfMP2NUZDtLuk6ON6ZHqvuvZie4M2WteIZCX6vBRDQrxrIBwFlgcVrSKkNhtsja7yI2lYObbyPPCDjORW5jW1/E/NJdOJpkX73p6VQiMydn+VOgdz0qG9hQE3hwUXp0mPc0oNekYUSFXiG76Q89vRRvG03Dr7Soam65ViOCUrhqosKoDKymAaayMun2Ma+eRLCVBKksKaz+FBXGtmks3WK7M7Sx/HnOopdVcEu5iOmiZT1mq8zac18V7QwvJVSSi3kHDtMrBYXCWXjG7KM0fYRoeFj9uU2ri0AH69zxAp4Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:38 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 02/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Mon,  9 Jun 2025 15:41:21 +0000
Message-ID:
 <PN3PR01MB95973CB65DC0DC3164D933BEB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f31179-bbcd-4e5d-a71d-08dda76c3f5e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|41001999006|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wgKxOezxKxUWtVWPo/QyhBAqpLDW0m4wygaK9Fn93FTikjnTa5/KxAZSb+wA?=
 =?us-ascii?Q?Yul2jEmfA/0dhi/eUaoeTlr0Z5PTQ/JJCpWxsWb8bEoc783vRlAoGYFVosw+?=
 =?us-ascii?Q?otLnaCDWWygk7VXNS+xTrzYzwAMq2DM1yqIgcRsuWn/KP3goLXoL1wjjTIRd?=
 =?us-ascii?Q?2Mwnvvy9C5bj14o4M11fkwPOpDaLQkWjkQPv56ju6TLqqY6LTq+yARM7DklV?=
 =?us-ascii?Q?f+wvbkWor7uI6ApkKMnQAKppQ9PgtsnYAI8idU253BNRsMSlqqeLyFNKZmQj?=
 =?us-ascii?Q?gyajxrGEJ7sWABtSrbdTjPgz1wd3vTxvsjmbKJ6C8KsvspTFBLYI5qP5ju4i?=
 =?us-ascii?Q?Zzq7Iq3UsSfq12rEJlCfRllYQzwpixmCgCnE+1orIb/rQydTrHZDVe7rZ3xZ?=
 =?us-ascii?Q?dQgH6IQfPsrRypzswONxWvc9rzRRXUkewoBU0e4yQN8La1N1PLDPwJJgBcvW?=
 =?us-ascii?Q?8m4SnPEPp8vyexRczUOohDGLVpVnPpHlbtCcizs+/Mij6+5eAl+Rpapq+Y3a?=
 =?us-ascii?Q?AQRu0FlRBsHSoMMDbgQiSn099cGfv78YohgvzjZhiHM9IMt3c+itWfyJ173Z?=
 =?us-ascii?Q?okgWuB6q0+j85lFSG0gZZIrvdUDCMbl3+ykAhu+TQtiJWA26Mmg4SiT7GnDb?=
 =?us-ascii?Q?ldwmHBq1OH7Ixs+fn6ojkGraxMOLslzLTFAL7N/yTm+itrsg9tcpjHUkPnl6?=
 =?us-ascii?Q?P5BZsmshvaCIrGdKkmxcV8U0LPlZu8iZBFKvjk5IntJweEM6GLlbbxKvC3dl?=
 =?us-ascii?Q?/j1A/aKOFTiJVGhFavOzhg1zKz/5L78uIqv+esGR+HbrbF8MXCXCW478X/TF?=
 =?us-ascii?Q?unq985mMsDDU/orbV8htJ09WtgrHnt2auvT509RYHDN5hKu79HaQOA3LLDZZ?=
 =?us-ascii?Q?12e2bYJHDw89rF61R86KY/CFnGpnf740kZVzVE0IwADp0rlvKNue8Q7ZgHKZ?=
 =?us-ascii?Q?Jxvo3cIBdu8hh5rDaumZHSRZJiaHmH7mCi4FlSlxbX9QwOmIzl/GbImUqmnW?=
 =?us-ascii?Q?aoKRKlGcw+pJA99JWfNFSp2Rv7gaGYAMI8KpfleEMisAc0AYJj0WeRjd3CXv?=
 =?us-ascii?Q?SoCvBjf5uIOBmjcrpGG6+LAEOah8hwkJW2EWq1PAi7lV/AEXpxs2CI8xJzAa?=
 =?us-ascii?Q?X6iupIv/NdlNv1G/fRXV+SwoNW7IkQhwY/EVLWa6xKw8iHI/dq6HuuSFQiFi?=
 =?us-ascii?Q?/4Tpfsh6sqdPVd4VoIAoK4Q4SQR+/zpZ99vNFA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AIcLPYPD9y6VwnHuR//YB09yUqcz9ahITc6VMPV4IQn1vz1E8q4/GGWTY4hi?=
 =?us-ascii?Q?1PUiyzXwUsR+iOgKHN5tnFwb1zSetb7OqKblGCKpLROiP7+QkHr+hBSKAa7/?=
 =?us-ascii?Q?UEP9MoiP7c65RpJUBMiPdxSDrhz7o1gbxGRNDT80Oz9GrxjmqPaFkmqeNFWH?=
 =?us-ascii?Q?ExgF/zEdfVtCMrxzWuexa9na+0myo1JFLmRF8Dx39caKUD7Z5LChxiXNIHWj?=
 =?us-ascii?Q?3uwpw9a/WGZkmrjSm1Yi09TS+jQouZBgOpcs3NMKz8qi6IlilmrHqYjfpiK+?=
 =?us-ascii?Q?356FA5m/wW3BmoCJbFhhvJD9tO5/m0UeB+b2uYkMkDlW0PN0rZWaBGeQ7Spu?=
 =?us-ascii?Q?H2m+uXNjzIsH7S7WBAeB81RaBX/g+iXqvAGkEpIs2KpMd8SigIw1nPyTjm1V?=
 =?us-ascii?Q?gn3JPj2ulYY5k6AMlytqGjyXAh0xdMJHBiZFaBU/IamXSXqa2V6vmlGwg70o?=
 =?us-ascii?Q?SlOm22JItfGyFdpDAF/gm0jRdxih8nfhNWl3MrIuyVZ5zXsytqRKQFm88rAl?=
 =?us-ascii?Q?PoEjMacGPI2uFQpmluq4cZFzZcvxBTHSorXEQ/05m8e1nHb5tTNCvTDjYykP?=
 =?us-ascii?Q?0d7VpwPhfwPQlev2hk32opSGEUyEeB9blBxesLTVvLTz09xjLTktwpg3OUPK?=
 =?us-ascii?Q?PsrOoTXYs0FVPb8AYz0H+QY+ZLBHE0t4r9tVG6wCJMBPX+GB4utKWhQ0Kc7d?=
 =?us-ascii?Q?4/93TIx3gdYyKUUTz/cTbbVAGn7f0EWPfxi4V3RTZCBY7SOQnRRy/fsAGNB8?=
 =?us-ascii?Q?4BDv2WMSTUDA7QMRyKCeOfN37UUB/uHL9xdXVvocrHcGOdkJEep7YuEqdPcI?=
 =?us-ascii?Q?+USAmh3SkuGT21OMv8TV6DohyVclGqPdjTq9xXdRal2EeLAQyYpTICOT8Oz4?=
 =?us-ascii?Q?uZdPIn6tGe+RQJwObFLkVeV8SfezjJO8c3kePd3K2a3ky5vqkMICsrsH/Ocs?=
 =?us-ascii?Q?YGv2427CSt4zH6yZ+OSIDgVSlKVw0Kkbe9wOldoT5laQTt5dqxa6DeK1/Rey?=
 =?us-ascii?Q?C2iZPpj0D4IePnQZ3T9V4C3AEJP9KeGnyFmWe8KzuniiE5WzaIeE4svEkBV+?=
 =?us-ascii?Q?tnLsTE+XaTLCRqudr7y91+hOqsIgAYqZG7GriT5/fNiXZwnD13W3N/RBoYg1?=
 =?us-ascii?Q?kiGtdbhNqTbIwDM7JlQpxPDEKBIYqHq/BH+H7+JAExL7PJ2cXxm5ezYs7Zxd?=
 =?us-ascii?Q?96K3VRLFmWfSxOr4NkTgefmtPJH7QCGXrG2qaTIuY1ZW0NPt3FFKRRy95oY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f31179-bbcd-4e5d-a71d-08dda76c3f5e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:32.0505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

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
2.49.0.824.geaff4db692

