Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD0D21018F
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380239; cv=fail; b=ZnSVBD7LImGgwNTZwlj1SledZcB6IPMKAuolFvKq/oPQ99X8ftfbQSeaZTg7SMpLjlfcI5qDIevhqxRpk0p9l++YqQflIZT5CB6gVjnpdnv84wgTt5kecMYU6x7lL1yBpLBLbDgskbHJ/OUaDk5Q7fKWn5t5gpENsBthL5k4LoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380239; c=relaxed/simple;
	bh=n/I/8vaE/HggaZTjPRfQO02DaJQRpN0PycRIyKZxq3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dc2hNmGH8NztVlagofDBj6hkkZbkOHJCKbOUn7wgDIXguxHGDqtKiBHoHYU92zePqg748YnSZ/tMxvQ7zLeG156ADXmZfwxCYVUznzOdYvZW3CU7Y5nAXYhrqs0eWJ+wNCv0IIW/Mia/Vq56tZU2uyJ8GpeirpWVR7DC9xwlGdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fJ2nSQsQ; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fJ2nSQsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKNBjE8D6geIUN6vH6DOoYVKKJDdylvOTSwVqRDvLQKCVP+HbcYYEYWCcOpCdNZ/qX7CjoD4Iw2s8Kf3Y6cZrqjavACJktEWFrgE+Kk3p5IiFMpWMNKVWzTH9v9pud3R7pyD9ex2MX+9ZaOxVhEOZ9bA6KzPQM6tJ5+P2sRhl5nVUlpTFrpeYFInQWrmZwdse0dNhmOouH7HbiUsdXzVhZOi9neHJ5EcoK/ZRQapNObnP5v03RWN7GiTusUfLsx9LL2JKUHrx4kMglzw3eRnfSS1P3SwDkMZ09hZiL0noSXFTuO+LJ1HgysZv5YT80hlU/Bi+xYXuEYLlhhGo9fKWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au705HHGRrpSlgtXxZqgZndsdDQmSEJ0oJzWkWDgdyw=;
 b=Qly4WyIqiI1TyiWwchbWoubB7WCm452T7nb7gUXhLTIOBjsGCGx+XVdvA62MS5EnDR7MxfT7puuV9aK/D2Sah21ucZmyp0RRGEX/fRP2UjZAW2YGzCMlv9Y0LcfdF53y4SO63JLTb8vIWITmic/HV2ZSzBWs7rfsfVHxqKNrNaEzdfpR1zp598u5BZcOyLOji8L0tIRHRklDn4pYmR4JD2zd+Oljcu8b/RQ+PaVGhD9g+VT97OtdQRn1JdcVp0yx5a0jvxD3I/+WdOL5I/pETJXDf46TMpuPhLni42UK3WvPvS7p9pb13PbJlpdoCgAI4/pl7ZxSL7mGgDJlJn0v+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au705HHGRrpSlgtXxZqgZndsdDQmSEJ0oJzWkWDgdyw=;
 b=fJ2nSQsQfRvp57Gfo5DVE+qhvWPaJzKdZi73Z0aDPyCUXNa8dkQc4RsE5cV5dIp4malhinuDXA7mXwYdCwy93pWPsztMoeibg8DBjI8yVqY7EH52N6/9ROzjGVLl8dxfGib7M4bke+ci5tzb8LXRqmQzjDJpIG/hEz8tTXOPsf4nnBQBora29wsrVK9ysEL/lP4A1cZdCDYODdYc6R6qGKd5K8BvaZucgqa4jXS7VWCjLFYSMZgbuFH6czmi6XevB4yg0BkI80EY5PqzLZ4RV+dEevamxkD2usFStBPAGUALBXxmrtQVe9puOHWgyUYiEGJWaUPZgK+ZK2z+u9VCww==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:57:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:09 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 02/10] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Sun,  8 Jun 2025 10:55:11 +0000
Message-ID:
 <PN3PR01MB9597F3C8B35EE5FCAC5DDCF4B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250608105520.18264-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: ea025e0e-e204-481e-6b4f-08dda67b36a0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|41001999006|7092599006|8060799009|5072599009|461199028|15080799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2V1l8ymtMcpZm1bRUUf0gYmWZcqY5Y32SsSM5gU3DzvmvquLUPcfmiGDLtuQ?=
 =?us-ascii?Q?nT05JzxkfAjrjeYcSSsls0jcP+kUGOO8GHT6SZWyDFe+A73b1FjWJZSjQ4et?=
 =?us-ascii?Q?/GNS0YD+LfIfwvkQHPlWSEufevfFLtzlv3j/hhgziTdtrB6eFtwHYcLinhCw?=
 =?us-ascii?Q?qAXvDt1K1WWLLVxpyd8/64i6TRjyRlng6vhMDoeUGOuTvrfc4jFVeVrA9EO6?=
 =?us-ascii?Q?igOZIR3LNBio92p4Kn7ryoXOeTyTThln0XNJZUBRtDqdwaneuMXet49+HPGC?=
 =?us-ascii?Q?gEEW1g52Krf2RxIz6yvMk5w2l1wCalEengHTeG1TWYFKXdAZ9wMI/fYy3coL?=
 =?us-ascii?Q?mKQqLZq0qYsl4WyKJFkyTEspfwGhThqVrqxLxyjdVk0uF8sQ9DJHGD9G24ca?=
 =?us-ascii?Q?2Kv40MBQT9ak/w/ljhWKlM42+VFyaH+DESEif5FWqo85Wf+4lZFhPKFwJuMA?=
 =?us-ascii?Q?YsmT53CCRU3uGjmWkx8JJUxv42hYThWuSLJre/pooJiBsHbADG8K+ID4L3lx?=
 =?us-ascii?Q?t2AlrH7FpfwBqqsyY3icgY5sJ0ajrIi4ioI71GkuKyNGwl6BOUJqTHH6ts3M?=
 =?us-ascii?Q?bhcqGnCweSjmgZxMrzjYd3lF5VXvK510xK/Wxl6K803bDal6jGrj23eL5PV2?=
 =?us-ascii?Q?rpE3WSZJueVx5lC34MLmlnMkvMv7+EwkPAEmGs/6ZpZQOXMMnzM+VU8s886n?=
 =?us-ascii?Q?uaMSiTs8WWs7cidGHzdv5H6VsRDrXi26mikScmVyGsU+Vz29oeziHkXlcET4?=
 =?us-ascii?Q?e4mKWZHMwrPJuQTuhlEPlW6oqeBdHu/lhSrvx1E3+++O0KiWLYEqa2+dz8pX?=
 =?us-ascii?Q?2Uj2zjcPYnO38nFtJjAKScPI+V+OwwIojtJoXuBiFXx4vTlbDutNGm0EeskP?=
 =?us-ascii?Q?cduyEw63smxASd1n3JdT+BLc9YGTQ5i7xuwxgeWM49/mxXMUbHz/oGqVAHbV?=
 =?us-ascii?Q?Bp/xpTKkwlJoUzpeoA5VTdq6n9hmA9b75zGdKVvYAMxdEmRAdHOB19jMM66C?=
 =?us-ascii?Q?mYmrh88yMbKYSge17UdQIFwjxFD+6KuRSWF3GNp86/l0lTLrMFdSDB3quKby?=
 =?us-ascii?Q?dcb5NvB9cMotqsfRL7PdMcMs8tD1ktSAkQxyBEWd+YnkToU5lVkLsfgzm0B+?=
 =?us-ascii?Q?UetcmnIm3ZraJg8pD9AzEzl+CN+Zvst39PYK1alrdP9lcQaU0r0gxLo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0ol5IoRU3za9s0RNyEA2EWrMjYBBj6xE+78nQUX3SjwsSIL6GC+wdy9j18s?=
 =?us-ascii?Q?HvosOW4CwlHjQTM2pAu/WqKEpMmRGWgRo/A8IZk/g4OpP77adrxFJdcOQ2+u?=
 =?us-ascii?Q?7ajPFYSFS0wW7yvhgNIDYz5u79Brmfhn3bLQHaVMMlFpqgPyddkLApMpadjL?=
 =?us-ascii?Q?q6vSm4YRmdcvwUMWG4KT+tkl3rKlvAkQd2ISYYFvQqDkjwydULBsbrXKnDSv?=
 =?us-ascii?Q?SWHkeTo8juttu6baRPicLUjZd7KhGgQGXgehMndnHyqYLEJyXgnG9aIOFbxQ?=
 =?us-ascii?Q?NKf2vX+ULOGQvuR0+XdlivRCE/91s4lJnmnNp9QfK1uGkWFpsmSIe6XdIiQ4?=
 =?us-ascii?Q?ds0lQwjM22jPlMVT8KaFxvapC6Ftp1pK+CqFE/rDVXbTpKjJFMv+gjSMQuoa?=
 =?us-ascii?Q?DV5HUDGVrBH6/CWzPcn1+kEAEaKuMcgcaqD9hKQUvAWZbq1fcSGA9RLJyEIA?=
 =?us-ascii?Q?GiHJDiUo/LkyOg4ZAY+jmg1s6CmpXzADmRjKmzFy4Dj9cN1NI/NgxGo4SmlE?=
 =?us-ascii?Q?aFmbaMhX38xcHqF7/4pzxG9+WGToFuzULuWO9xoiyzx1r8BkiUdsJUYzMLvw?=
 =?us-ascii?Q?076/bIrqlWTwvBvqfRxfUntX6xLa29UopAKun/0mxR7pDRYs2c9zeYJCuLaZ?=
 =?us-ascii?Q?ggBtebB8RD07mn50jQh6/PBlrnILSuCOMfuYOtoMRKDhfoR/cyABc5+xotod?=
 =?us-ascii?Q?v6DLj1IRD//a/NusGjRz7XAOuhOVz+xhzPCgRVHYvpehRlN8BdegbO9x85h9?=
 =?us-ascii?Q?Q/7UQctPLqleJqZe+D0WIPN6S21x/FNGEC7Skxdu1AavA7Ft/cm0yasfAhtp?=
 =?us-ascii?Q?ruKZ5gMpmlYcmwMKUy2BqcvdAUHaJ5IHsxIX0ARt2Dh3qSOxk3+cQl2k+vP+?=
 =?us-ascii?Q?HeRQYvqb6oSLo+CfRfuh8ZGPEABqvCIPDP6hxJKsM6WOu+CzEIVHdr1hcbfx?=
 =?us-ascii?Q?OpGv7cUH0fvHS+5+cBxYbJgg/lydhbA6/ogR5qQEmeiw96mEPytRrBohu4B1?=
 =?us-ascii?Q?PbWSsa9BR7ccijvWxPDVyy1wOrAdceoY8TSUbvumz5tMAMsuuCq/FU4e1rNH?=
 =?us-ascii?Q?za7MBug8wrx1rcKdfAIMj6ZOYssKx8HtQRZEtPbAXAHBFTg1U+T6KmSVvrCr?=
 =?us-ascii?Q?Jqj02k45NuVecnmBY6d57Szz0Q0tjhbRKAw/jk3EHqEYNQ6i1nMeu9B+g9RA?=
 =?us-ascii?Q?gD1v19YreUz27c1Yw9L35sxsTQ3YHn/QBnrraf7jjfQ4EYKS0RyJfTMQbW0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ea025e0e-e204-481e-6b4f-08dda67b36a0
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:08.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 37f94a37e8..1a582c8443 100644
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
2.49.0

