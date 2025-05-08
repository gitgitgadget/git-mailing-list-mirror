Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A252F278172
	for <git@vger.kernel.org>; Thu,  8 May 2025 15:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746717751; cv=fail; b=WylV3yQY9DAK0b71zrZ+pxIuFbV1MSTfKKV5NsxN3ZwFdLU80M1K1tGOZfZas4k/Iki2jFf0ehYUvy0Jvdk2BBavR5h7N2+305WvHA5Rsy451yJsY1Z6FcOBS3Gfc0VZqNVlu9aBWpCV/gkBm2rEePJr8w3/RhG5/l1SDYTICTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746717751; c=relaxed/simple;
	bh=xLPWcPUqkE4/EgBTepSoaukeVUglqxtaBz3eqPZsMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iEftHbGX1wfXN+kuiQeAHjg+VVYDsnh2vtmiV1JRmVkn1L56NlsQ2ZmmhdxQN2BVFasuYM4+aQWRztf3IrhvLjhi14XNdotBc9ZSe5NI4m3k8KiNA8uyMRTMfXensgdZLP+EpzRZRk5rodc/H7UkaSSYBtRgN4eM2OHnqlQTCrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KYgtYdNl; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KYgtYdNl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMJeNbr09aW5zL16tKZNvwsLioO0yQQagU384W91f9zTSUnOiV3ZdFZxf0PkVLaAHwf8IytC2j5+ZM7aEr1XjaZMxC7Ssa2IPAuuc8Rm3Ks5826A6P+xE89YCePiwvzm9VTDG6NEuA2k2k7/MX4L4fHaOGNbH7M63R5wOs7FxrtfIh1L2LMV8VFl8lcn/fT+Tg0YDtch4P5pNXPZO5ZUSiRIaeNAetPbsXxnorxhJX6yTE4uS0Ugs5RvO6AW0rs2WZ1fyMe3iCfNFEgV2+CVF+z3QwEyZndcYCILqJBIFiuLvr2g9PAW9cbjWSk8y3dR9+I5KOPuSfqQ1SSdl+Zchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=IBE07fqtHtuna+dIwhoytTON15enBQ+FsoVCsoXnHFulGHLD0VIFyKRlpf6N1+d5TmuzJA7eHXQNVnUWquJRr0b266nzI8oZZb1kr5M8/NzlGsA/4jGI8e2dh4NJ+fPPs5c3h9QJaWCdrmsnbmUf+U/Iy73ZY4cSIVrYtGCDHV/TET9/1Ww5GN3w5dhKnNNGQ2HTaOvAgqv1Wn1AEx42UNf60U/zyLV9xuriQKM7O6eOEdHDjrJORSz8mu9ktEAN5M0ylwZzc4wTVnCL8Ojt0uhjkzjdNF0YeuSxkEoh80Z5JIWDWX6Rnvj762Au3Lqit3r6khz3BQB+Xu31b9hxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=KYgtYdNlclkhagC3g+rqzlI8aibR0ROyeSad2S6G2J39Oondk9DWRlw0DbpJD92FazcP6mQqhWeHC4Sb5zqG4kkL2cbt+siJ+XWjjKfR+lNML3Bv3cB9f7lMi5VR/DxViDDflWlgVDBKMEJcldSU727t8bVIH6avbdrlUL4LWsg3LzSL6bJk9LzaeMQHgUa4QeavxCrnT/Qf8jGxqnnfX3dVaKrxW965cGUq3henvrhz3fzDkUZPT0k78S1iGiONHRDuZzAi4tiBuKmLa4GJZxyNgi1mvmlTC6iMxtfjBRmg368hWl3TupptwZismIgS3L0JUtp/pQkqz0h34OmtFA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PPFB4730D036.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::4a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 15:22:19 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 15:22:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v6 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Thu,  8 May 2025 15:18:43 +0000
Message-ID:
 <PN0PR01MB95888E9CFF5D07D26D4A4DB4B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588B04D666EBB98AE6EA378B88BA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0065.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::11) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID: <20250508152203.7173-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PPFB4730D036:EE_
X-MS-Office365-Filtering-Correlation-Id: 99fb0ad1-1e7c-4072-7a8b-08dd8e441ee2
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|8060799009|19110799006|15080799009|7092599006|3412199025|4302099013|440099028|10035399007|34005399003|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2dks+aSD85ItHLTGQ6rkJdvotopj9TlO2GVS8iICwymC010dBLuC5yj9rNhB?=
 =?us-ascii?Q?y8/XO50ALAyPEArhSqot4qeuBtcxGI6uZC9L15KwQkmsdk3JUZD26dXLO2pF?=
 =?us-ascii?Q?jHKWy1IPgh79GJKLvTzxsJW1qHd6eQHu35Kb0qQj2ru5ScDyU4ulCqh4+cM0?=
 =?us-ascii?Q?F2OiapHV2Cxil0nENMk8Ax74NmFByKwEJCypXSE0hImd9+4K5mk4adl77p5Q?=
 =?us-ascii?Q?N4VyZZ1P8KZWekszWgB1Y5yS1NHdDpu4UNnQ43TpZJ31WyR46whbAiqMsCRl?=
 =?us-ascii?Q?JwHpy/n/5flKYFR5GR/cS70SNnqcYq3+uae/ANdsqjtUOoOfaZPA6dqN82a6?=
 =?us-ascii?Q?leinmSlyojCIARTKDrGR5tx2B1aJGmBlKUZfIvq2AcRka2ghwiZP6UkgytBi?=
 =?us-ascii?Q?ZWVF5nmMPGhuFHRjk+4IMFgch8P8PB7Mjo0Fz9Rn5kF36CaL2eZnNBlIcr4Y?=
 =?us-ascii?Q?vI9lxlqc6UgsB29Y9fV3ks7D1rRBlvOI71sARFJFKyOahWH0UnOzAWSFdmFc?=
 =?us-ascii?Q?Em+ESeRLFBcdvTjweEWKvTydvlAfjW7DK8v2w7mTCT5Y0EECFcUPGLcc5jTE?=
 =?us-ascii?Q?kyan1Delc7yd6z59Gc4rnEnidlvaf1p/L1bnvJ/g4XDbPv+/1D6zU264bAEI?=
 =?us-ascii?Q?2bEQl1B5MQw/81J2ZD3KCIqkgdNyGrX7oVRlaxKrRwPtYBtL7ImWyJmSFJET?=
 =?us-ascii?Q?eReDZoBckyN9XYNg22mQlg1xVecv8pjBb2grMyCJPtdh/EVkzCsUmU5eFnJV?=
 =?us-ascii?Q?8orBrV2V06NZV0uYmNYvu/3cp6vXJWfgFKhPtDvvn5N8GAkG96h5tJoCBfym?=
 =?us-ascii?Q?7mVuMZ2qimoUtCHCoQgxRN7p+swEFUnNW/sWnRL6Gq0TgHTvDzmBJ0DjxHcL?=
 =?us-ascii?Q?C9o2yV25Akk3mIZctatrSE2AB4vQ4WSsV3Le1D0gMwpuvpfOSNkbIX5lCp0l?=
 =?us-ascii?Q?fOqsHh7g27Ht1dDzcKPmEuQfgwbcaFoX8N+PaaQ49msXIti+T3VcLO22mqmC?=
 =?us-ascii?Q?mhnqR62RgFs2T+XaWPmKk3xwutT8iFG3EYzR7M/yV1bxlpn+52ZD8tZx2dLk?=
 =?us-ascii?Q?3vcgWoomwOfPP3JbHb5J59cCTcBZcbqj9Qabv337DuxOsfktxhB5Dxb82gDs?=
 =?us-ascii?Q?5/mEjYferLuiq1FonEdaL7X2Kr/ZUJU1IFtomjhMjJSF51XfXb39FjySUHzv?=
 =?us-ascii?Q?l4HgdBJkhZ5BzQP2oEdAAFq+SjXPMl/793rTlaJ4LQ3cIiFVapcto80NokEP?=
 =?us-ascii?Q?agEvKf92Mr7JdGZk1KgQ?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eNvyQQH2vhOfqfmRap8gzkSGavz1Q5E05fKJGUXNpcynbCDjOh6xzkDn1rum?=
 =?us-ascii?Q?K5TWJ/wObEUf2T9Cya5Iz9XfQXWIQeUDCBiig42RMKggG1EacMtdGSPbiqrY?=
 =?us-ascii?Q?7eiwH307Y8g321ity//1FcDzdnWciKSA9peoMHOhVgVj5CtYGdilLNnCHwyG?=
 =?us-ascii?Q?yuau5+mLHshYSW4L0cyemxjvT/bgmqajHszFlgi+EU7Yy24sIzIplXkDdaAx?=
 =?us-ascii?Q?lHvAHpIZJxKPTRQKBCf0tQqMfp9bZwMAGKHNQjv8cm51Y8UEsXrt/IA297rl?=
 =?us-ascii?Q?hj5Wa+zmpR3+yipxuNDfOzTV39CIkwCH7ZBCd64W2/5nA/TGrnOXoyZXzqEA?=
 =?us-ascii?Q?vdtUzyn762YKgH8BlCt5BVRg5KIRVkvy7SALZYchbALasz9bJD92WUAy91oc?=
 =?us-ascii?Q?gLlnLae9W3A9qFcORs+/oDQjR0kIM/NNuDHQDm9tT0EYtqn0kL8WW+wGkcBn?=
 =?us-ascii?Q?9yMrm4b8Feo//RBgaZJK1VGiJgztLkvMVA3iENj0BdiiLvO4zbb0Qb0lWHUb?=
 =?us-ascii?Q?BNPfB4wOLW3jNsaylXMRwD0W6rSC4QEkzeAt8/CdF9WWOSaR5Ecu9w0OT5B1?=
 =?us-ascii?Q?Nj5lqT5YbFcxMaI9KGV8Pq9fIzIAoo7NSJqxRwaIeol18L6McDEavJNMw9+e?=
 =?us-ascii?Q?vJWBWlbK8GSEIVclZPi27CFp2YDHZo148Z7X0FSR8LhXi0nkzqbfMNJW7aqj?=
 =?us-ascii?Q?pBPCmVFleHjGwBnBIGtROOO2IuHGr6oksrT2fZ4i1kvOkBjNw8XWgjl04Qvt?=
 =?us-ascii?Q?BvbESFBjUZdrAYO9kaTY/ED6d5tFv2xVDvpakAo3GNufaVTUIKN33pYpH7Dw?=
 =?us-ascii?Q?9zW/yXdITUh/LHW7p15yKY5hkSGOKoZ+bu15U/FkwZNWwfSGKnfKFfic/Hpj?=
 =?us-ascii?Q?D9k51rMbUaz87s8xZnQWF86LXf8yqMCuajSuRtCEbrfosxSveJKu6r42fb6W?=
 =?us-ascii?Q?wBBpZ9g6TZoqhMw7j5I+bXjxmNkCce7am6GiO9qka8aRXy9WkwsZzaOd/oNb?=
 =?us-ascii?Q?k0xeUf7sNpyxrstlCohX1Mu6Z07+V+OvTq/yELtiqRNPHym7GDqRofLTT6Wz?=
 =?us-ascii?Q?laYEnEaJSPtao0wKcPM/MI+VGWKYnFoC/tyndHpmR0jLvG/YP5mTjiOJa0Ek?=
 =?us-ascii?Q?LrD+jvgB4SXNKzIQsLudfsBSwKuoq4UCftJLJM1i5Am6ovZcfcC5DjxL6r+k?=
 =?us-ascii?Q?m6dXBZ8sGg6el74vlyy/sY3IdQ9EGBgr6m7wo61BYsLGpmFAtWOFEf0VIGY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 99fb0ad1-1e7c-4072-7a8b-08dd8e441ee2
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 15:22:18.8792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFB4730D036

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

