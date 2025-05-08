Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50A286D49
	for <git@vger.kernel.org>; Thu,  8 May 2025 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724704; cv=fail; b=WO+EZ9b7p4SEPNtwDCoKHOqwOz6UAieNOV20o7YtcPV4b24VE+uvWbQYsD5hr4lMaiZlx1SDd/rFUYrqNNNyfd3XvqMle/9Ohy4IdD7gwgQljWkdKMnQ+RTzKnI8CSewOsMccEq83Rk3aYNOSidiZfvjhn5WHxZtmiW25urNgXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724704; c=relaxed/simple;
	bh=xLPWcPUqkE4/EgBTepSoaukeVUglqxtaBz3eqPZsMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ICwxN75XZsU0RkKvuRzQH6iOMeOKdnM8zdMJa9h1j/b3K8qsqGTczk4ljdqPl/unIVa+HX9+daVGt9Yj8hwz39kOMYrDpaiFdwUtb37ZlUrXNZhqZnr4FQH8nLQOhTZrQUe9s2h7rxCjctX9hDqGEuIRIiYBkmH303pFc63wmEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZRO1mwGS; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZRO1mwGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8Sq5BAuzTGfNMSIjTXRTq651kmjTOYdurMIliPPkybMA0OqKeG5lNlQDpNEVbWSeKPMdKzh/OXTy7i6X8nCw4qEgpTPpKV62c/xYDEiNHy8euISZe42pyozVh7lReJ0mFy+PdNetJMyYygNelaQyDtguT0MQOIfX89rxzv7N7/nG8Yh7ELmlhXPBPao1OGUEDn20VFYx6zlMOQSw6VdZZZTiBHVChTXVEKAB3P4gplhNpjaXEwZpcJeydyQzu2dmyFfUmK8YRTdUrhlTE/9Dp7bG3em75g1nOhG514juuMJtrl+gC8eziIrdjXoUAUPHi5aCYaUWUp1Gq47wSYcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=TxDhNXD4puYgLpMmgucbAgPF4faJxoyBb4B/HFYKLs2ZgiKcbaZ3JEPC+y7GIoOCU2YZKthGD5nYx3aXA+k7q5Cr4Kve8IeCKcc46TJK9kQztwZEiYD4bGxpK7NCL2SN6Bf2TgT5NJkVljWxu3LB6C7eAZqnGPACfpN6PdZYWXjnQR5lS7LC3LrU5DLKOlXPirmB4kkaLq5Y5lZCiQ0bFNOXlIrhHMZHuStfcECmJv6kHQgxsJzjpXUGw6Z3NpAI4vcF0UYUl/FkT2bQmbRkruiVuNS28VnKYwWY8m16/ro0/bOXOnRaezrteFlaXbKJ5iA4m6UfWo+DVI9o9GwQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=ZRO1mwGS1oNLo4R53ioiTvHL50/9p5lINJ4uO7J07tQ9SDdjrDhsiyPpmhgv/IWl/AY8x6p21PGiS8ftmlkRvjX5DNpHEqyU9TXm3Rfwjp9EROje4tgBbDgmi3U9T+DV/Xz+N8b1UuiuXFJ1QQxnpel6koqAIcLlU5va78zhWXYetxATRqZdX1jno2wQJ2Hb2DS1SgUYW/S4Aj349tk9+KwjlL1kiUqhy0MruSBgv9FaL4Jhn8GucIqkvUiyjcmVfZUuLy2gDwQ4gmh2F1V4UDdKLhKQ/D22av1fL1aeWV9he2+X0zzTXpJe7/gd+iqrgkAtVziqlL+bzqdjro8zcw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7253.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:90::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:18:12 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:18:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v7 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Thu,  8 May 2025 17:14:29 +0000
Message-ID:
 <PN0PR01MB95884C84C8DCEF388CCFEEA1B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95882173451A6A7C28AD7BE7B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:265::6) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250508171758.19119-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7253:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec54515-5f59-4ff7-9753-08dd8e544ee5
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCbpJcnjg2/0w6HlyB8LkFai8w5MGS5T3gfdvkr945O8Nu27Irk2HHNPHbAROSCLmSHjhCLFg4A50jf91nzEbWk8QAVFtRJ6OOeFuhr5vYpJljkiy3yOit/PTyrMrUBAu1S23wBxDLqtTAAhl0JhHhkYmH+5GVDRex3Go2E6n0PYUjqiEMrmYwVvl2Zh6nx3KbhoF7lOFXL3T6govlPVe02lsakRXsKnH5aNWQlmaj3cZ2SHQk0eqUgtGiZDNJwHGEDYSWSl2G/QFPVhtebwXpi66ZtWC2S3iw69PZVYjoCWOnhYWgISRtj2RxXHAg18ot4LAENxpPtk2FTOlUDq4cmMOlT1NN20XzRcKMpZflFkDfYn5LxnkQ6xIuFHMgPCMPotDp1tdI67s/NS4sVwVGA43KwybUu7WwL0WzvlHPha3Pm2sjczXlfQw5udehHq/JblW9z9px0H1DjU/EicRMt9DcR9u1D13gO7JBiUICZInLHHpkvO+n4wZmkncGzAr0N/ApDBK74iWD9gyp7NTdvCrAgUlCSmHnAePTAo2GolGdL8AQh3/gz9/Yq2nB/mYESIUAw9maBAICyP8Dr5aMBuPB/gjLmo7PyVABn7a8jy2O4wIefavjjfT+1Z7KkCVaG3ggfSY+OV+XJmv70bKRTG65wIxmTYyvaFA2ba+FtDWzanHlAqye/VSCa51tHl3oPbdiuqmPth+unPhobmaVGsa+pKvrI6Kt+TVFqbJXKGriY8g8K/PmG3m8M9l0VFkX
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|5072599009|8060799009|7092599006|461199028|1602099012|4302099013|3412199025|440099028|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyBlQMH5YlyDSyqrM308sZsEJaQEkgo695+K315eLLyPy21tPIuaJdiT7GJA?=
 =?us-ascii?Q?+eleBYCxOrWVVHPJjgwnmHgHjMsrtV5xyhe2sSS0/jOE6B1fEYg7rEdDffeb?=
 =?us-ascii?Q?G3l6RiToS5ChF7+40oHpHXyJfShkfVLRQ8rfrv+OuTlWHBAHQ5AXGMtThELw?=
 =?us-ascii?Q?i2CVkTAbB7sbGZLe+rXPfW3/dYgkExt0swdKqKoVWeOWPWgeTwRad4768HYM?=
 =?us-ascii?Q?dv/XaMiddJ5vbBDFXwG3dLGGToMZTH42E3j6KBHL6ewpJjDEUeZFD8eQMKsV?=
 =?us-ascii?Q?GcyLiK7H45Zmn4ev17ERdP6nOSOWH1st/TIrLTamn1CjJhs/+0JG2+74oJHv?=
 =?us-ascii?Q?GDfLSkRTK1X21EXcXOc6JbqwUSAo260cL8vVmuMk8Gko/V3TjjozJ/Zg8+MJ?=
 =?us-ascii?Q?eCnahze/ST6atLLWZf831YZ5KeSH6j4xTtfbYTB6V2PjwwQtckhfjN7uHGqz?=
 =?us-ascii?Q?+MrniKFHemzqpRBP6aAZnSEtHhUO0GoLLKWHv4hpK7Lqy1+pf84PDbdhu0G2?=
 =?us-ascii?Q?Ci8Lyd/w+H/P02BZrckiWvdNNJF5J7rZ6IGZkbtGkPPYPCbJgLRofXdjnvCN?=
 =?us-ascii?Q?6ly0dEONN7qfvnpLJiUUQW7kL97WwdrY6wZ7focTodyMaM+eG9i06sRl7UNr?=
 =?us-ascii?Q?wxP3G/4KNM5pSsSWECIQ8ySeWCI3wixkGO4qAUo24rAcgMQsJR6kzLpyPKM1?=
 =?us-ascii?Q?DU/HKK7RmkHh5R13oKv3vrJ2QmklVKg/YOdM+Vx8OPXEXQWCRwkgOsQAj1FM?=
 =?us-ascii?Q?DDpQzxF84bXgVqgK5ui55+nYVAV9VoESAgMxp6HPZW9PTXHLAYTcLWouNN60?=
 =?us-ascii?Q?LzPAgO/i+zmKWg6NiNPgbmAh/UiWQne60vulbxixrRL7iRFTu14cZIvV+3jW?=
 =?us-ascii?Q?kk5fjynb5sWEqniB8KyjackMQbqy3hFlhrv4GgcNErXhxakSrCkBESVhDpYT?=
 =?us-ascii?Q?zo/m/0iDPCBp47YKipUeD++O9+qwuDAm4bMMMCuSbXV84RXbs+azwPLhLJvt?=
 =?us-ascii?Q?LfQZuqIB0EpKjHAnEiYCqK5MI4jKp0rvJ45B1i6uNgQPhEJiIi7s8oQHsweR?=
 =?us-ascii?Q?t9UJ3OjIlGf+ez76Sb6gAnNMnIbUywqcI+TtqsqwufxDMm9Z2qjpzU36eQBM?=
 =?us-ascii?Q?iDFiWslbhRiwC9Jv0saI6dGosv6TZcQPi8OCJB+Hf2PiyHGZvdmp3xuq2agP?=
 =?us-ascii?Q?s0gJoA5E14siRiv+kqwwVjNKmbcEhK4/LVViY2aEQIIiQzGQbvUYiaIVcnzf?=
 =?us-ascii?Q?QjDe9O/THQ0O+46gzR8jyAIG08dxNQCQRYmErH8DMg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMEFtvOySRN/KHmFO1HlU0d7swsA2N11XKSbRTcS/jKtPJPRNa/2P70S0X1s?=
 =?us-ascii?Q?NeUTs+SKnJJ3nFnetBKqHwqd9uV0N2Y3md1ctmoGkrwVTlLgWbbDD6ZEQZQr?=
 =?us-ascii?Q?0tUcUFCIy/6I0L68vnRmungZtb/LNhEt/ub1+VA06S2xnWMdbPGEsBw4er51?=
 =?us-ascii?Q?P7EcWV6vBv5R7fDzixRy306cofGkc2fx0KcHyIaq0z/yYhtt3UWljxGdNcrk?=
 =?us-ascii?Q?hhVfvosx6LaQ+gwP0hTifm6JNdPMHCBp7yOMfaD+Lw41ZyJRPC7vwIWZFdhR?=
 =?us-ascii?Q?v0bVNtlj5VrhfqBTbqXoYZNj6c5ixabClPmqWukFeTwBp4/yRf6RFX2lfPM7?=
 =?us-ascii?Q?NZAJAuSmWy7V9Ns7QuK7A8WEHU11FIYzvm72qbM21afNHTTyoz+dosGEUMmi?=
 =?us-ascii?Q?FnLwDtn2n0cYlTOA3LJ3VrNh+I/P2aHHVqJSVfmbzPaLIa9ew7TU4SxX3pLv?=
 =?us-ascii?Q?onfY6KmKAnHNIelKfzJq1gH60DOgMKDLLsUWAYRPvBNZE0KwlL89EQcsifDQ?=
 =?us-ascii?Q?YXuZT6oi6aloaSl87AahcJNJW3xCvh+LPjcZDYMH1oR5O9EwDLh42M4Y4pLT?=
 =?us-ascii?Q?bBZG6a40j4Jh0raffihi4e8R9DNGO9mTyp+DgmKLAmZIAj/9LJhYx28TqsUr?=
 =?us-ascii?Q?4eWm8N1+pYKpHtQHYKxDfnW+8N8R8vRKbpVl3IBFdwU6JirzsjNDHRKxX/Lu?=
 =?us-ascii?Q?TWPvTQE890c64o8uP/iPKxQr6wjUxYYq103geNo2fdu+kEt4XAVxrqXldUy7?=
 =?us-ascii?Q?+cp/prnp2sVTfBjqGVbg00RHkVLUOekpbwfKo/V6b4MuxL7pZwtHB+qH1v/K?=
 =?us-ascii?Q?yGfg0yBf5dIEAyF64tgNCIsugcgTG+DUqO2aj2D1MXbNZhvpIDc64ht5q6Kv?=
 =?us-ascii?Q?TJwf/ytXi7DtsO6CtCRFZ3kpB0Ka1RqqDGjI4VJdu6mvIN+S20tblGFouVK3?=
 =?us-ascii?Q?P8eDwBHRHCEqDpVEeZVVzxiEJRpoBvEHCAbLtLFyzqkCMrCc2YJKk233OmQ8?=
 =?us-ascii?Q?yloTNzNWD02lF8r2GHud+yALx11SF+/O/YmaHUF3+Ho5yzxJm/iXNyx33vav?=
 =?us-ascii?Q?RTZN9Ecrr1MVEA9R1Vbt4C4jUSVk17CqP7GNHByTZBwjyylvEniT4IMRxg+H?=
 =?us-ascii?Q?nWaw/BGP/U3Loh6XB6V3gGsez9OV6WFlvbJPQAVGbCUavcaI/ygP2FLiFF8W?=
 =?us-ascii?Q?69hxmseUbIW9xZCSICpbiuRKihjTlEs1cigMA5wsb0hiHkZT7+H8ydfELj8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec54515-5f59-4ff7-9753-08dd8e544ee5
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:18:11.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7253

This commit adds the `git-credential-outlook` and `git-credential-gmail`
helpers to the list of OAuth helpers.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..b49923db02 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,6 +133,10 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
+
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

