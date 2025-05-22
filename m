Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011034.outbound.protection.outlook.com [52.103.67.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB82BF3C6
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747943512; cv=fail; b=IdZgr5Y1UTaT847cSz26D66r1rPOrUD5LAJy3N3Fs55B5O+0quNymli+BpqSjnjn1PzQyVHfGZ/G32CKKCxbc/UDVI6ZKcshaMn5XcwHe8GMvblQdDvTqOvR3kBGoM9fAZQC4/eJpY41p6e+iYIvqbkOpL+4uwWxy3C/5KhOsAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747943512; c=relaxed/simple;
	bh=undbw3pFxYDCu9hvcPLh38XS5J4xICY87aTyabn0NKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qwxp2sVIBG/0cjZJT653tmjoO+8EnbEldhEkpZgoc18l6NOpxZCzW6wbIdrhJ29IvBf9BMbMxNpzmC1fOov/jSDS9Is0CBh3otXjU6sA2kW01jRdZbWUfFPzZsFV5MZb/LEdSgbs5KgL3/VDYCbKUgj87ak1HyXhsulFeEUucFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U9s3sMZj; arc=fail smtp.client-ip=52.103.67.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U9s3sMZj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs4Y6E4MYTrCBgv34iJLc+XAQTiJRFT/dx62gYxDM+F98PIKmdJ1Z0IXV4tHsjPDkk7rZXlpd7gzSSw8M41L4F7n5wGu5dD1J7Z0l9rLuW3S7isUyN2c6hqC8T0P7u7DVcwSishJVj9euxjfjA3sbvJj9gpbeOgkN1/+f1ozLqgoJDmvCtre2pUPhrO4k0ehb0sqo4OnEHJIm4cxF23435IxKe4UQTleEIl77J11T+uZ2EXl0kfhNaBXDJj7k6BT1nasIQGEzKU9K27hKJMcpEY3z8aAD4uGahYeQjldh+rAjBgCdRYwTw0kVMIdJiqlXO8yr0AHBtPrs9TSZOVucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZoCfbuJpEkxCxRqxUJ3BA3duviL6QXVgbfNItRYLjA=;
 b=eMMCuTtR0SsH+WMeskPSnrcnrpHwxHfNI18+yz29NCwk1nG4CQHsAu+UheOG54m1GroZPxd8qjehmp8yO2/sDp2+sdn8ZntGeyn3hMmswRWOC7w20ksGanRSVxtvo/zqBAG8QxnPSAMWsLdtdpqpzR6s4OWif3OH8fcNuiuYncxc/M2rVHQT4Lxc1J1Y8LMfgzCmOdwzCz3gL/NyTCB5Wppd2xL/yfxWkfWO/dnuCpBYG6ltQfd3ZsELn/TN6UVD+X1nagugV9Y7rrUb+nmdhisVWSBDR+SGzjg1Y6jVRYyO/TCVyukHeJCXir75FiVOaPEpinK8W2TcLB7B9cOfLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZoCfbuJpEkxCxRqxUJ3BA3duviL6QXVgbfNItRYLjA=;
 b=U9s3sMZjxdVVoAedeWtJYgxmcuBlbKqdgAXKADPIiMcvz0x1jSuF5hK5MQu0mLPAtDI/wjRbI642ZD1ao0eC601XWOjGiirRKJpqbhm59eGCmNqn8VN6ZEvlxW8w6OSudJUEM+LOzdJnjNuuqFqkfkU0T2w/4fJ+cIWpbL61DSZxEZG6JkGt0Y7UA1Rd/c0ZmSJ3U/s2rmnMjjWujmNBUWp7vPLzzETzUqZZojbAVY6W/oMEWZnU2ewl/Xb2t5GrDdgwJW2B1XLKqJTpdKK7uPZsyJ1Jy/0VnHypNkvE32vBdYu+UA2QmM9vAGXP6U7fJk7IidZbbduDXV1DhvFjqw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6385.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:51:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:51:44 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] imap-send: fix bug causing cfg->folder being set to NULL
Date: Thu, 22 May 2025 19:49:52 +0000
Message-ID:
 <PN3PR01MB9597488E63B9C1565EFD9631B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597EC279126820B74D2D6A5B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b6::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250522195133.9170-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: f23208e2-be37-4846-e3fb-08dd996a1413
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|19110799006|41001999006|8060799009|5072599009|461199028|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9W9XeUkTuVzzFDFGM3kfRP2oEvlfJFIbssNZINQFz8aQVa6FFc+cMC4gszoE?=
 =?us-ascii?Q?8EUTvUfUsJM6LRpuRd0qeT5VaBihBnBBh5WKdyuEQH3vH91f/DJ8d3sc/pXV?=
 =?us-ascii?Q?laqsJNhmNfV/AfjM897g6DLntNZK6ddpXMMOR4k31ThiWvJLyzboN2NvpAis?=
 =?us-ascii?Q?uYS4HzMeOmLOJ1DIxYwk9RdslaKO4oz0gUoKbG9EEZvlKKhuwQbFDCohweU4?=
 =?us-ascii?Q?TjecqrSe+I+ByszjM3JhXDhA51rdZ7HI+dRWrUMVMOVkZrHMDV+eat4rPo28?=
 =?us-ascii?Q?3xS4J60cIi0h4NEAqd66xt2C7WoKUMkzu5/liMXBOh3cuipPyqsf+tTVQsK4?=
 =?us-ascii?Q?+0jBkQk4GCImKqbPDClEzJhNhwQ1VuGVgt6QKj5VfW9cP5F0O28/Mq9xR0jL?=
 =?us-ascii?Q?cB2BR77aF/sAvOixtd+3NAhmeTx3jC91n7gFh34k2oY1tzxp//WJMDm69UaC?=
 =?us-ascii?Q?48hyPiA8UiMH7jIYpy3JcMEfbZDw0uSJP1bLEpHGHzuBkbV7pTY9SvO9a5PY?=
 =?us-ascii?Q?DvYNnsUUiyYa1zlPS23AlwQkY+5pn7uW2bILB50IcD9b+tAf3fFOUvCfOr71?=
 =?us-ascii?Q?zJ7PqzQlj/SibHPi8aXk43jvh0MEa8jD+sHv5x4brM1N7p6JVKXmr6rhJk3B?=
 =?us-ascii?Q?QA4phckdxFBThNr1Ydl177vJs0j2FWc+qlNJNFIXXhRLs44gcxClhcUjpMBi?=
 =?us-ascii?Q?8+qfZYaa4tg7XXhOHq62ucFKUR0UoEVQASZrJgzWwEqPhfTqXUAE5+Da9i5o?=
 =?us-ascii?Q?IbBw4SdKvg8JMF3qzf6gGMast4xkWA7Ix27czIWwLaZowYfhRZBzlnHo08j1?=
 =?us-ascii?Q?S9DHn7e2SmFMIEuFOSBEEUGaoufHHFRYMMWLobvJ1bbTYURt2eOCMcXOHjrh?=
 =?us-ascii?Q?DpUaJ+PSH0JX9hgxjJ5lzSlqdslpc7fudiKXA4e9L7cRrQOah2VKdWX8zRmz?=
 =?us-ascii?Q?9Sz7DAjzL8evjMzfXv34LyeefCiFyifq8pr/9yQvWk1ls/C8WrJSBg1xBXBJ?=
 =?us-ascii?Q?wJntHUAvUbZZsPjBf8sNtTE07KCn36DtboERMYaRXladl1UrEb8DhQjXl1Gx?=
 =?us-ascii?Q?NCxU1b5FaSbQPLGa8VFL51tQusgfEDfAsR+MWnYoHBbYfpTrzPXiscCwjk0r?=
 =?us-ascii?Q?mpvJYKw0qwWLwYbOxGy6yV0d7d824mtfz76HWRv1jg8mce5ZqLY2SIg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTDCK1LpUYKD5BtX0hnEEmcST0zJCUBIldzO1+xhCTV4jnRzP2qszGqH4Qoi?=
 =?us-ascii?Q?Vvl3kRvnlFxvac4H6IbsEYwYLk2adERtEL+c/bMaKCn1SUIy0JgdlCFQ7Sja?=
 =?us-ascii?Q?uvj3Liy2lqedc/GD0agYxXM3dWuTad6kpw03YW7syQXuvo7pdJxejRm0fxUv?=
 =?us-ascii?Q?qJPq1UVpx3kd28g51h1fqAuLb+RooDGuGaC/Wd199ESCIosE5aBYVtMci5Zr?=
 =?us-ascii?Q?0vCxe4eP9rQHfky6BbavrvS7A8JVBko2BZCWzXR6r+UyKK3W0itQNk0amOUH?=
 =?us-ascii?Q?9twq3VD6k6/CjHsrm9iJbY7Wm2C+PV8l1MgcwlV8E8Ze1sJOvXMm7rLIT6E8?=
 =?us-ascii?Q?wmqyt2XhW4RwmRNfYNrMSq+ApPBJhndMdr9gp2N8FtsBg0Dl14RDRBnCsBgq?=
 =?us-ascii?Q?QUsMnNtfBRKjzYIKdwPkfdLuwk3KNlF//GTVLLgnM6gtiZ1TSlwV4bZrRjHf?=
 =?us-ascii?Q?QSrol3cwatrhBBqxSVbttc3J/2HTE2G2RS0KGCA7xrOr83vHxG9t/VM+VP+5?=
 =?us-ascii?Q?ad6H8g0f9Zl8wHlPEkWywGl/gzAzGB1OiLLLfvpfBp9372YmQ6/BxI3Sbcu0?=
 =?us-ascii?Q?1iohjylRd/TfZ7sIdjTK3CiRvt/haRuoDES4Inuge5JIK+geaqEU/vNYp1Ph?=
 =?us-ascii?Q?p6EhsfMXsonlsMFVzkovkRwfUG8OjcjLAwAYyp2cCvisR99cv/MEXf8UMdCr?=
 =?us-ascii?Q?F/mI+YlZQN+kUsGyGscdPe5rGoPJ8wRLXe/135sVRAGd0U9fYZPslWQUIxja?=
 =?us-ascii?Q?SitEZKIH30vtooviT5eCaVuSACyu8ic90v+bhYSnhIy7HYgj844IOJtOkDiM?=
 =?us-ascii?Q?WMrk1F6NoN4OIKA8E69VnkcyixADrWk8MkzrasBmMtt/osVYihh3lja2E6PH?=
 =?us-ascii?Q?jvDN1d3O2PLXVBLWz2JzQRdZoy90HZgTUV4S6y1lPrCzp84SwENKzbaMTxK/?=
 =?us-ascii?Q?gxTiFUdQ1IMe3vZ4oYW5fJewfB36+k6MInvXNaKLbdh5ITNhQccIkrY3cyHZ?=
 =?us-ascii?Q?BcuYG9nFwSSR1DEGe4G29Xe67MzmVhjsFno+ZB7GI1ZUUkxsFzXs2tHOApcf?=
 =?us-ascii?Q?pAbp96WuPuUXITslFtQW4mUcYVJ6y9tnsJ27uaFhYxObuR/iIF/QOrS+YCua?=
 =?us-ascii?Q?KOKBsycu3tvS3eYXp5t64k3UfT6NqwsOC1vJeVyvMiiXbL+OAMFDE+r7Dufs?=
 =?us-ascii?Q?xwJ0DrzD6ljBUu0Gd8JWZMBWvfiWUkq5sGrdbfTu2zyi8nTva5BnjUNPbpI?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f23208e2-be37-4846-e3fb-08dd996a1413
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:51:44.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6385

Upon setting up imap-send config file, I encountered the very first bug.
An error showing "no imap store specified" was being displayed on the
terminal. Upon investigating further, in static int git_imap_config,
cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
imap.tunnel and imap.authmethod were defined. Because of this, git imap-send
was basically not usable at all. The bug seems to be there for quite a while,
and has not yet been detected, likely due to better options like git send-email
being available.

Fixes: 6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)

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

