Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B132980BD
	for <git@vger.kernel.org>; Thu, 15 May 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747305258; cv=fail; b=FnuXVrsKajZTBpQwlFDWNLR6f1Xy7tnGUVHOfHEvV0Tx0tbKyn91gXhQIvoOjNKtzhXLeji/xWoDY11bnkeBkF5KBs45i7pw8Ie5t80ddoul34Vtu9yUnBBy4vyqo/AJX7xuR2NnikuucVl1aH+1YVd9FiR4ZHJC3CqlJz85Jbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747305258; c=relaxed/simple;
	bh=DTHNlqJVlBt8KI9UvWrI2Z4vzU3htKfbd83Kg2srGH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hL2ga0XnVDUDPLOFVBlCKE579H3NW4DBViqFJ2EQ07TQQIPe9+U6odYS29PAv3iRV6Eie+/m4eYLr9hwG42Wm1L73pldxf5/hHsSLit5KpzD7T7Kvpx91mMUP/l6v6wd3C850FLo/rJYLIdoWLbn04A3uW83WEHPbzyh/EOoCQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=lMxpo09X; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="lMxpo09X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3R6h3He9ivK2yRqN35flD2TglEZess09tWzcBYTqrN/pGW+3amLb1wwX90HiLCnVv0oSTvsQOVFnegO/DGYcXMK9ss7AZtOl6r9dRmLztscyT339YKSF3Dx5jlprzcQVlMW0R6sYMgd1pkkzvV84kNoQRUp5dQQFGW6gDLwzQA6mo92CmPEjJJT2ZKCxy1lBgXKzT5z190+ChSrYOsNLC9eTmFZnrNGColvEteH4wRo76bn1WP+sRcV+cy4VWBo24Xmbsts6w0cqFgEyh9te3qK7PQbV/i4dYjGfwylLfUO1Pw/QxSlCFbsnAiyYSzZrt3Uv+5N9B6HyyLA1wWRPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8REULINqlTXW93CIpKaZlxyLa/prMvpCbq8wF2iC+o=;
 b=xSOqITQMc+ki6WOZzbi233BmWby0/SMPvk5/Eg584daLt6sMWAWe/W3HcA2001pNDXD6rWNezdbrbpjvHa6WP0H0FARSr+qDXnGeFFEVznHNdKyzvG8ovabcgzk6HWMShPSEs9qJ+a3JmsnRWhUdlf9kpYusL16tYjIAtHBBzq6DoOBeDppjCLChfmpTDs1T3k7m0+d5ezmaTIBCl8GZmWsPPnUwPPx2p7j1yU7Up6D2AHEejJSbgsYJJH1LwzenHKpO880qq0IXRc6Uw8vNUvSvZdSq6k4KSsFsWJhMna3A8zPaGswbZc3Z2lWgrful8xvWf7hN6YiWolsKOThGQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8REULINqlTXW93CIpKaZlxyLa/prMvpCbq8wF2iC+o=;
 b=lMxpo09X1DhW3ziIdgGXf6j57cGgKOkYF+uH6k1vYe1PI4xjdHesdRtuquA1D97+1luh6e+ILDR1y80PNoT6XVmQ67nL6xtEKEFVqlNrdkoBo4rnNJ3Q3dQKX76iHMGwCBaX97luOflOZUf5kC8b4U6Vw6NfILhQ+uWCmbyyaGXWuj9J2t20D+PsiQKQtqA1xTl8m2eAlOvTXTgox0+PllXriUJh17oSCzlhrsWlDMu0febOu/8s3yPAmwOxcEB8qrhPhp7DhQMgthQI+R/DL24scMPpRNU32kzbj/nU40VblVsRrgv4EreVTWRRwAVrwWZeZ60YKIcqvL9NkM7YhQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9257.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 10:34:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 10:34:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	sandals@crustytoothpaste.net
Subject: [PATCH v2 2/2] docs: remove credential helper links for emails from gitcredentials
Date: Thu, 15 May 2025 10:29:24 +0000
Message-ID:
 <PN3PR01MB95974833251AAE9531F8ED62B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0012.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:261::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250515103355.37250-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1ed20a-7dac-4c73-2b9f-08dd939c050a
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblC0MDwbM6L//9MIvulgIz3kAVDae55Z04qFZvPE27W3yS9WE6Q1uFIKAgbv3mx73YZehOdiC30OGj8Gmq42PX8av2+N7D09kADN96qCQu6INhsV76zDNy65wGnL3mNKjFqWFZ7FCFz83rtOwwL0bDVorhcRKvVvVmxFlZoMDtBmarekACLDF5czH6H7Qu6UetUFhRxs3wVHf77twsmoA795ftmbdwQ8zxm9pBNIbEpoSUHb91xOhrvQKB/NqwoRNRvOGNkqACUEe6Az/PR6GdTHikbyHz5YbeZZ3QPiMTnN/NJG3OwkfrPiEqMWRE2V30OT1DPbGdm97Qqj5yfNsKFqxn982Q2/PbcDJGcIzH6650SBomgIBFlmYTEg2uW+PCmwQXihsStFAxWLcYsVeIS4aWhwUzHMP0/YSCX7kpDHT1flIEFiC91upqTneTrudBzIKVxgcx0/OwSpyzMgoWIegyPEXTYQyYURc+ULe7LEXMOfMEeKeLng0poyP3mD5ll3koHDrURuAXPBuGV/2KrRIgTn4iTiM0u1i9SjCTp0yYzQBVK0nkOptwPYibrI65CPGaqRmEcayMMamw89abY9qqhsEHFqJA3O46dPhd/zPeQYuyp/mUUIeeBrXvTzqM5/hDtk2OVpHX4cSX1q2GvFHDIFeyQMgSmeJ2wuqabnonVwgHl9sIJ6ddWeYlEG1GxfUzN5GFT93iLvSMrwhIjXB7BMKeyr1HueYLNi7drNxsZf5L9WnXy6ro+5MIv4Whu
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|461199028|5072599009|1602099012|3412199025|440099028|4302099013|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7RHOcOW1e4lSFMxNln5K4113Mnvdg4WDrHt2/OvI4wOC+hijV89b8o9gEA12?=
 =?us-ascii?Q?Dld9QDFuear3UcglzIdwJYDe2FGTfkXFFDt19xC3H+DOvy3E8ujCzKnbWXMj?=
 =?us-ascii?Q?1c6ygvr4p7XRvcpabXqo9o88klFNRp7yc/er6+3cPW8EuLUbBUhFmGIZbesk?=
 =?us-ascii?Q?5ibP3BgZd4gb7tCsmd1J4K9FjWSkovbGN3hdmyTcZw9UK0SLQbCyAsgwAmsd?=
 =?us-ascii?Q?LTyVkjbNtmnTR6RHiLJa2YjAk0qf1M2MyZMl11aqQoKQkSHhEb18RZKx7XfF?=
 =?us-ascii?Q?+bvv80YABzeZ1QdVoh7/doqYS2/zs2cKjT5iYSTCJ41j4EVhy7Es922CXAau?=
 =?us-ascii?Q?t0YKQD8E6QKFN1m4iTMORNmmU30MR2L7hlPMVBqGzaO+9peHKExG49KTNUi7?=
 =?us-ascii?Q?Wh3NxceT4j8eiKA00I7ittvWu+4Xu2kjkGxKtCzgrXQzBOlaS88cG0fZle6J?=
 =?us-ascii?Q?PNAPdqN4HUg+jeUXA9RNom9rMVQt5y1xfk4Up1KI3qxvFPijou5EckPEcNP1?=
 =?us-ascii?Q?DI9T8BUmIJ2sJLkbns1IguVJziZ/hXEtWn7lwWVDeLgqRqyGfwVVJY1ZhoSw?=
 =?us-ascii?Q?YA4qUO96bbl4jnUYyM94C9X/Q2tmj3bDHuear+mQy8lbBGkUSYmy5LyYU2db?=
 =?us-ascii?Q?8XhMaKQMlRx7lDGbpcvOARQhOt16dFTXdK8MyMhHA9j9D30T+7JwGu6PCbVl?=
 =?us-ascii?Q?Y/5CbFL94IR5OcVyA7za6jQYwMYFQNQp4Xnf1Ns8KbBUT5Q9Yz+r1Q+Zns9C?=
 =?us-ascii?Q?htFFwYGFE9dhCm8szU9qRU5remm/mzYF1wRJjAiD2Wmw8ic7rWdYZBO8wacC?=
 =?us-ascii?Q?E0adRp3ypQX9gZHv9aHyZu16DgLlgVzdIB3X38pNFwVhUWBvngAxNVt7/5gQ?=
 =?us-ascii?Q?3j75TUT4HNf3M50V4YABQG91Ta1Q4yIbACY4o8YfeMr/jOAHCq9wXsExhF/6?=
 =?us-ascii?Q?nMjwTCzTve0dC9yFXOT0uHn+h8Hgc0RqqQQD0WEcr7810FZaDQVDccDauQAl?=
 =?us-ascii?Q?v1ivhoryDsLUwri2kyIshAN5iTbCHMLPBu89j8dWbDpqBT7MdutqCCB1l3+6?=
 =?us-ascii?Q?jfzr4voJo3X9iROehK4vgut/cHNzuhEoJtNhSGG/urWkw1ZPJ3myxKwyv+e8?=
 =?us-ascii?Q?QHvA+iucZMpiBOiMHBJWibWJNHI8HgO7JP1NEOXcd8CakzImOSRZpIUt/tAj?=
 =?us-ascii?Q?zantCjgLpCVyutc9KmYObOdDogPhPkyXAjy0ipMymSL3VvbeQ2JwtHoD7F/f?=
 =?us-ascii?Q?/UcoBfhBzBoO53j/ku1zLEzJayX0L08j7kDYSNl+hA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wzPBzZYQ9Satmqa7wViH3yTdJRMN6VGbgKeszOeBwECseu80f6oSgbRcyzeO?=
 =?us-ascii?Q?WWNl4vH8Z8rYFMFx4SqYjFsATKV+gUkvjgq86sT/L78IGc2J2AxxaMGzvylw?=
 =?us-ascii?Q?xKN6qnw60Ol7K8iyQvoPAzhB70+WvoT4rewF9dub1HDoWnPUbxsoMAAPecuo?=
 =?us-ascii?Q?fpu5uelMD2+D2LXzLW3bikD+hiQdwPf7mRdKCxM56NeNZXzPVVF/GLDQ5HjD?=
 =?us-ascii?Q?3ent8T8GYzSPReURDmeeYghSUwVLr0cjdo/wvIYmQB5bnvrWdGcOTsf6Cx6v?=
 =?us-ascii?Q?BXgSu2wruCRKPVqAbYBjWVh37l5x/JMVR8daIPh9p8ikvCM9VQil7jGSpvw8?=
 =?us-ascii?Q?f7lv99JWZovDXPXEPSzX+eoul8Qwpd5NPSOPhE7m9WCsNSSn3TXBQ5kLx4JT?=
 =?us-ascii?Q?zsHBRk0db/YHQPHZ1rEeoCuDp7phVwSUHrZsh/jnSv6fh6Gf50vTUHMQi3vp?=
 =?us-ascii?Q?3t7EspK/Y63qXtTn/OfqHU9/vh32VMPoWyj+T+XYM4OC7toTxw6/OvY9WFHj?=
 =?us-ascii?Q?rw8Vyz3WTEaCnGMaEwzC3Wfod8S7WtydvKDYR3Fa1BIWVn7pKnqLR28yCQE3?=
 =?us-ascii?Q?99x1ndoWdGNAaAdEogQJUfiOkykoXbeAcmXDDJrAYG4w8iAHfBDVx9TaRZRn?=
 =?us-ascii?Q?lvBimHMesA+PfLV6GIT4MJaQmK2nWtsL5PJyR9jP3tVdjEY9XX49zj61viSd?=
 =?us-ascii?Q?zsd8gTYOBiSibm5EDz1TW9HNoKf6JjlRmHvTrn7MHf9p69v7gcf3pgE/b0Gi?=
 =?us-ascii?Q?a31r3d4JHE6r3S2fQE9KiuaQzVdAENVC5Naes/M6X/LBuVN1KbEpZ/evrD+O?=
 =?us-ascii?Q?4UvHw2i+6/vy2I67W5ovlnzwp0xuKi9/rhKHwozqXeRqUg8cuk9vW/8cELXB?=
 =?us-ascii?Q?JZkTPr3zsUkt8PztJjSDQ9xC+OcRbc0EhDTfE6E/FMPhjy8QLshwLHhSbwf3?=
 =?us-ascii?Q?M4DONzc/rgz9BqiryKwCmHmcgXmUph1tgdeeyNQzMoBk+G1FFnQLdBof05NI?=
 =?us-ascii?Q?BuK4hLkrFDivSJlKLcWysCJKs/PF9RqAlSJ+Jdj1j005YU4QgLb2cDkgrFcE?=
 =?us-ascii?Q?Tl7EzTbq8RNmoskjWjxbU7l4PAkD84EUIRtSo+KTtkdRPXLdT0Y5xDR3OUv+?=
 =?us-ascii?Q?SZw390s7NXjxG2WWI8sI6rBAP4wOwcN2lVZ4NnfQg8tueyz+x8VO0BwGavUE?=
 =?us-ascii?Q?bYqqnHEVQDyqeEAn6AOwKAXhWF03Qbl8SWCTOKGYHh1mbk8nusbvD5KtSfQ?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1ed20a-7dac-4c73-2b9f-08dd939c050a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 10:34:06.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9257

In a recent attempt to add links of email helpers to git-scm.com [1], I
came to a conclusion that the links in the gitcredentials page are meant
for people needing credential helpers for cloning, fetching and pushing
repositories to remote hosts, and not sending emails. gitcredentials
docs don't even talk about send emails, thus confirming this view.

So, lets remove these links from the gitcredentials page. The links are
still available in the git-send-email documentation, which is the right
place for them.

[1]: https://github.com/git/git-scm.com/pull/2005

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index b49923db02..3337bb475d 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,10 +133,6 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
-
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
-
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

