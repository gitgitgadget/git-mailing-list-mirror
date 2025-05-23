Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D423814A
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003011; cv=fail; b=fiCkEQrOE8/nns3R5PO7zf9xyBESlQg9MmAgDiE82V5Qfp4HifrlHkqdC0w26CbgKlLCm4ZHkGXYeqVIBtCL8eacSBnFtxRM9wxIqMyI/HQH6aHZqhODDJdohk8t8lHlgETg+enXeQ30JlmGwGyYRyUD08S4KZp5CIEWp+Ru0+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003011; c=relaxed/simple;
	bh=dLh1vtNX+N/MbZEeMjdlcD49TPfxL8QUyBwqo4iz8hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kxs80LxDPzizvjFC0eKmkOUo1SN2A+8NQZxSwOFBdtoJn7M1CUnZQMggFmPhGrzts7S81I8Of+5oqZx77e9eB/bj13uxpW9XynTu+wR5wGixX6peR403QJ+0oIef8AVB/sMsHoXWYty4AHppyzFlsPA5fCx4CptQeMOt1LNvhC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YidIxghv; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YidIxghv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVWJkCqQQ7eXjBN4ZzlKIR15wj5WiAiMVWvP2t93ACgFk6TKsWlBBP+y1btDpIKdFH6ECM8NDMJvtQt6GFdYFbdZ3VJKNWJ7E4cYGToRQ8deLoJs/V2JJ9nssnpMmICjbnfpKBcdDG8aXmIWc5EkZXnO77MHMkkyZ65KgCOD3Q8rD6iUl2KL+5iUSqasUv51qRP7QH8a0FEfADtflVstFKRwrfjhR3S1YGzBnZ3n79HEOlyWpGoqNwnqDYQfQRHsphcNG/hIRbI5WOPGT3/4qrxzCBLeBHO+fHY0ICGXTH+Sp87hDnDMYfGpusi9FUpsOApTvlPHD2yYwd86BUuxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRz/cC3XgJ2SvQ9tzsFwTGQ7q5K+r57QP+hMk9yOJ5A=;
 b=ofI1hwWuDbv8xZAFvti9+eafyKfPjBd/qAXM35jvLefWVAaXvTQiOysceL7YWYbTvkYyIHMX/g6/chLiT+nj+pIEYeQGtCCskQJJiN+zNgpILuHUzD8d4cC8R+vAxuGdNd5QjxF6ygyi7m85wLNg4f53uavYOUW8meMcLIIIwkP/8h9odFHwaYiKqvee5eJErVD1n4KFJa7AFWtEmeVuWCip/fRBJMNArdm9dl5Xld94XQfkFrvFWTWmBSUqjq8sxYEuwNcDXCDKFm+b8pqRcoVymB9IRVaLMSZXtOnkysCk55jEH03Xv06VOy8ZR4+ytCSJ5aIKwkYxpjC2ZMi3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRz/cC3XgJ2SvQ9tzsFwTGQ7q5K+r57QP+hMk9yOJ5A=;
 b=YidIxghv8ypJqOstRcdNuhCPvsNllU8V/3uD/RBgj62MoNvCKhqdLeFVu0i//nScckmwN0QfXVk6v452eGyw61o0mE5BAMu8mF5fvmtjIzmn0sTPgMT8/jmgue6eLfvV3Osh+sDTatJCtcj/5TJpIiYxVKZQ5sdpvGHVz/ZQyWcAQ4zcc1djwasnoukXgB5k6m7KesAaIdvz1IZgzry7Tq+FrfE8MPHAY52/4zAWZiSr8IA9efUu3WN7Y0Eg2Khi8wxL+Q30/0nFn1O2fJfQdNDY9/jvRV5loR4w0gLZy9tPWSCKPVqHt1LWqtRa3VdFrXnjfDLR+bpHYsBlNDfK8A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFDDCD3ABAC.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:23:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 12:23:23 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 0/4] imap-send: make it usable again and add OAuth2.0 support
Date: Fri, 23 May 2025 17:44:26 +0530
Message-ID:
 <PN3PR01MB9597EB8033F1186F62159D68B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523122236.22593-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PPFDDCD3ABAC:EE_
X-MS-Office365-Filtering-Correlation-Id: c010c41c-1194-41fc-9df4-08dd99f49c0a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|7092599006|19110799006|15080799009|8060799009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2WiGzv4wuMeAmGIa0ioIuVRZSiGNHAXYPI2Px7JcyvwyITp903v1Rhcub1bq?=
 =?us-ascii?Q?D5nJdn/J4dZmyw4sX8KwfbJj8dpQBZk3i0PjvLg2MWK4XY8dk9nGpF3Ilcjp?=
 =?us-ascii?Q?IE2J/gkJEspKavqMcGRgDxGZGngpc4/yZS/ai83kjfuNwDdx1LVv3dB8PLOW?=
 =?us-ascii?Q?mx2VtmKlxQP652t34H5hPjJtdLiQL6s4r0sLpfAmJGa2DU+l+DixN5gdse+u?=
 =?us-ascii?Q?JFAU6aFImaEgVEYTAzNsnCLe2SEQuOmSq68JFRvfrm627k5GEfjlA5pbz1zo?=
 =?us-ascii?Q?Xo+quNA52ipqRRWcQGg+ynWtCtxqYLhWfWIUJrc7hpJBfPYIdUuc87QQx959?=
 =?us-ascii?Q?68+tDcM4q1BcmXkrCNcqJYNFO1x5Npl7yJrgYOOMvBe8n2Ey0Kz9/pbrCVqN?=
 =?us-ascii?Q?I4d+SI2/EZbx8bLFR5yyFdyWzV2fTZKHtPhjNMp/wRCyIA+uVTxZ/cNJGlDx?=
 =?us-ascii?Q?LA6xxWUCO19fhRa4GLgoklvpRWdq68GHrVCArdO4t7mknrMlKsTxYeGUKK6l?=
 =?us-ascii?Q?K/rHAAkE5wxYfvxBW/N9U2YIbalJ+wDrqHjL8NwWxBeio71KQOVZOJX//R2Y?=
 =?us-ascii?Q?f+AJT1vHm7KmRaL2AD0F2OnH2O2zblkgtKvTdWNsF+f/+J+KrX3f9HpTFgd9?=
 =?us-ascii?Q?5yKONfn10X/MrHMqlyz+T5QahiR+MJxm90C8BFKEu+zXRDDlxuPkyS48/AQJ?=
 =?us-ascii?Q?8iAvods8hOJK7Abp8DiABpZeXdIsXN40o9zzGAyVA28xfSdDGecV/zi2MVtr?=
 =?us-ascii?Q?ZpMk/NsOwLtwOaqRvHa2YRwMG3cvCz0kAhBELm9X0g9ePPaI60XxPTKEm4Fr?=
 =?us-ascii?Q?eXKx3ZMbfUnbsMoC3j7OhTuQ1u/5pXgnuj2TGAZzuQrew8JMeBpACLJIwR0O?=
 =?us-ascii?Q?3n//J2hNzRpGaRevxyxmCckNgouQfXldLhkUh1wp5LHsl/J+6h38IQa4P6UR?=
 =?us-ascii?Q?e7DLVCoEGwr2f17gQ0+kxLmgF6zyhVD0KljyuGez5c5ZDN7LSgPWbd+9AFS+?=
 =?us-ascii?Q?GlcG8y7L1nnUZiaBoBQjT1n8Jtq3U/8Cer7rxCrhVcfNcmDiLg9h9Z4utIWc?=
 =?us-ascii?Q?HMKq3qUY42m+9xRUGlD7OAwmBanzdV9r4rZ4ht1Cq8DSniOjPQE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+M9gI0Wr3gVQox2nuypZ1N5nouhtAopbPKNlFFmxjHbPV4knV9SDsnj7JJk2?=
 =?us-ascii?Q?Aoq+PNTbgtgkTAvJl1/2PjW0NLQpWrfMcdR06FSYKIDnYoOGor78dR41j3ga?=
 =?us-ascii?Q?Co6jbfvDOhOKprWqC9A6c2VimTDz6agcVBmesrpPevNYb+tRtMG4XEhkHfkt?=
 =?us-ascii?Q?PjucOnsNEd1ogY6bEixAEsLE2Fz89QyIQim8BQBJX26e/ZcMEGn9t7qY4M2i?=
 =?us-ascii?Q?Gfc8SnwrpC67lnGY+ZDamBhtVyEM00PCbveOFl9mw0sNvXxxLU9vY9Y8HiOy?=
 =?us-ascii?Q?0dGVg+LApZ/t84SDmSp3EdONWMorHVotzp5J+QjA4/tglQ2vSd4bLMqqCziD?=
 =?us-ascii?Q?lvLrvpKxrwHlWyP5Oc2/Ymv6SfUfqTRhEV2eQDrEulrLaztnTXJXfvOg6knU?=
 =?us-ascii?Q?XYuIxLBOu500WbmJ5VXLxKJ3mHM06scQeXfSUFhg8Uq3p+GHEPWo2lIanRxc?=
 =?us-ascii?Q?5VMwL4VvK/fwHxX/FRqqnb1crWaUQYbGhF/eVqnaFfyGsLlSfUtO0NbXw/wg?=
 =?us-ascii?Q?Paqd7BqC/ADBpXsdamtu/yiOYhmRgFMLCrW93pcU5ERPy0Q29x9/bsrTU/l6?=
 =?us-ascii?Q?OFVRI38KcILPiUJRmFq8Q3FP4Zh/chRtZRzNXCB12/Z5gsV6s2mH4uGIcBIe?=
 =?us-ascii?Q?JtbyJDZTqRCD8Ly8+prKN7E501ZzpjpKm4yOKf7jHanbl7AdtkPA/lmFXT9a?=
 =?us-ascii?Q?2wI0xnoDfSQTktnwtgH6ZPRL2qmzb9PxUSACpsGPa1NdjzbzCVE0U+O/HlrU?=
 =?us-ascii?Q?/Hog4BNXSRgtQycr98cKnk9J+H0MgjAqfQN1Dxff3OYnFU50Phj79TnpFmtP?=
 =?us-ascii?Q?42x5wcOliiuP1GbvzLQG5Q/j740lWXsncJRAalJJDrZPnAzd4QW0iDhaYm7N?=
 =?us-ascii?Q?eVOU1Q1of9BvEA+vX/2BHiY793us29/gunxKDY6yKkv/7epI8MLV1jt9BEiG?=
 =?us-ascii?Q?kNjdtuJ+aAWmF3Co/gKsMLbnkf9ZmeKbHNWOanXtOJ2SV63Z8pTMJivOmjyz?=
 =?us-ascii?Q?3SipVE4J82pTLyJU7uyRh46WoeXLpEBSiDYBVTIhWXOEwDGncxkRG5KWLtrO?=
 =?us-ascii?Q?r9KzM22zRaYrFhtgQp4UNMu7sqaP0MWRt1rlnf/0CrbZ7dYP7STJAFgsowVG?=
 =?us-ascii?Q?+pQSOrU5O3cBGCSnnvkohx1hyRLqbOzyduHGRQ11tuw3vBNzQWkiHrLzNhoC?=
 =?us-ascii?Q?DcYvfpm0owCzcxm5Y9zmOx8Wx+SckQPdf+qnVVF6mfonSGMTI8LU+2zUeR9w?=
 =?us-ascii?Q?58QaKtQEL99ZkkDLmzhiQPKcJQdX+WOkKYIemtTpA18g0Qcv2DcfPrlOXmL3?=
 =?us-ascii?Q?v4c=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c010c41c-1194-41fc-9df4-08dd99f49c0a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:23:22.8818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFDDCD3ABAC

This patch series does 2 things. Firstly it basically makes the imap-send
command usable again since it was broken because of not being able to correctly
parse the config file. The second patch adds support for OAuth2.0 authentication
to git imap-send.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
Aditya Garg (4):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails

 Documentation/config/imap.adoc   |   5 +-
 Documentation/git-imap-send.adoc |  46 +++++-
 imap-send.c                      | 268 +++++++++++++++++++++++++++++--
 3 files changed, 300 insertions(+), 19 deletions(-)

-- 
2.43.0

