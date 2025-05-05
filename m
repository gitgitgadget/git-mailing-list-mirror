Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4890B24EAAF
	for <git@vger.kernel.org>; Mon,  5 May 2025 15:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746458781; cv=fail; b=VPerbz15w8iLWbtNBDwpFon162PYcvtjMiIHb9rkdrKWI+7vNzcRyhjqusaSokURasLHGQNNlFIDwfzbauijKhOY8HRyZsl81Ce0JrfQx/CAcka/SNsfxd5n1ik/Kgo5Yj06nqwN+rrkI+rHwMfIp2ul51LcUQouKJ+2pkzkiRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746458781; c=relaxed/simple;
	bh=xLPWcPUqkE4/EgBTepSoaukeVUglqxtaBz3eqPZsMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q/sVR64ss0LAGfIoPGDCkWX3iJz+qKz1GPmnwpQhMMuqzJ0NjpokUp18WFMdeqZddYQutrcqZjkVWeiMJ1ft3kRtImfR9ETBfuqPa859tWpIW6+2zQTMGXnzygBdSsl/QlJqqsMpr94NLa4oaDQMtdAXabeJQRZ+mdTUlFXfzU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pBKgs62o; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pBKgs62o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jf8kH49Su5pBmvTHfTGJvuOxbbqdKjDzA6smEOwCruK/C6zaFAfOM8WcWSApyfX4YAFsDs038z003W9hMRa8uCPMna7R1pVhvpT6z74NW6TDBYUImaOemM66RmeKayJZIxFSZNg3i+cLoQfE4Ia+QIEPNsy1D46X4zUvBGset0zbhik/efp3rQiTxpLTVo36na1KdpjzEzJr11RrULkVHTComBIqCUynj2lKY5hVn+DxbvLuXwu6aTfKRBURIfFO4GJrVEfjE2MvhtQLsf56BL97iD3ZoiLQYHyu05PWKByyhS0CYLJA7Tb6/mTXkcy7JhPdVJGwA7NGXsuAbxkG0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=BRWXLPGU0N+cP6x3qqJe6hvcz0Lq51g/s7EhKbNjEZbH1yuLcTXP7r8sv/B+c/N5mmYwgjMVV3IVMDGzgIQ6u5cGCx47jTDoXD81jlrzSnT7fIGpRXwH+wKGzQ34lpMc2JrWmx3/ts4bGZ1tRtWShPnNMQTtvVueV/cEwOi8pmUh+86aOBQhIt40ze4udmZ9DiLyPw5WHC2dJ+GM62jeub42zg2a133O4rhPoQfmpaeqUYa5ciQRnxupDAlBB83MizSG6SFg5MsZvfDKXB6qPnoo6T1KVTIJBaiUBPWOVnp5ZJClzkM1PM2TQwR2yD6C9eV/ChCzFyoQZo/G1RDoVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=pBKgs62ohc55bHrFavnc1hNrI78SfeGItAhiRj+I0ChhlV00JWgHmUiwA9tX+itEGF/vvYspzP+bjR8EGLKibiRtcW+Tl0KFc2t4TpMO127IgefNezS09QBrIM1u4c30cXg/EmrhRxu2DQQRd8lA6ihBNu2gFmM9IpG5BmgQUg4f/dUNE+DgcTrZWiPzlJ/u8cbVPldOwQNJ+DLUpKR00oUntVn2odSDCO5Xc5IrU+oQr2/vq3iHZJv+NyaEGKmBKS6Yrbh9dEVmYLOGA79AcIusVlO4zYkMF5HPAxWemXehAYY1m4w1o/bofPCJ1kds1SFuXRumIeWNPl1aBk7JYw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8240.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:42::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Mon, 5 May
 2025 15:26:11 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 15:26:11 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	Julian Swagemakers <julian@swagemakers.org>,
	sandals@crustytoothpaste.net,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Mon,  5 May 2025 15:23:05 +0000
Message-ID:
 <PN3PR01MB959784F880EDC6E30BF46F23B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25d::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250505152557.4937-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB8240:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d1862a8-fd5e-488f-1a9e-08dd8be929c1
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCbpJcnjg2/0y9j8lKHjbElDsEENQjtku6OLIURA3q0DZ6nW2FqsNJAz9XjVdj3WMtB8hz40dbDZtMbyC+5WkMXM7ANu8RNQ37MGcd5T1xmPKgJoG/ypNsjQi+l7bH54Z78t2KGBrgrGbz7MTuSS1C1am7i454qqn40sb5hur8/zqeQ06rZ80YmkPVEqOFRTwpr7o+nzb+uN5g4PEcEsCPP4ae9K95uMWrtsZPlJW612L6eVC3ofxt4YBdHGJE5ALZ33ycy5lU7uIC6t7gCmQyz8n/g5CxESB+Umut30CEHfBKNRuZDMFHnPYVjGsmkUd+VTi1B2PnKBhBuHYPE/g30r34M+YLBhnRciU1jLCZbGYlvC7Xs6JVzvZ48PuCLcJyfSHZCLk5ZBVvqjFAvIinMVZc/Po6x5U+gsEibD/3Vy+fQ7YJykVsmaTSidFAu7zHAdHnqLIGqjDeEWAzhcL4BUu0Xmsd7O18CC4OcBz28QCzvqXE8lPNVlPMxFCZb/XKl1Hi8wB+NAwUfgrEXo4mQyDf4bSKSFOmaMcHt14KvFR4Wc6/k2i6Af5FPVj3AUrTujalUqUPIeuhtWGVR79POHHR0OL0Gxc3jbQoA0nwj0dY0ezXhBCujgIGM/DFmxL5UusDdoUZp/50zrGTIToH2jLoyiQ36jLcppQ0Asq8XtX3M+bimdHMo7/+6XF6hmsT6MX3r4o1/TDJ+idPVa2NcckDci251HaLKupcCIMzMEjF/YzVblwAXJvtN9tS0Cgt
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599003|15080799006|5072599009|461199028|8060799006|19110799003|1602099012|10035399004|34005399003|3412199025|4302099013|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qy4A5/9oEzokYluuEzE4qOUKCCtUwPeGzY8drr7NZuxnayT86efDuD17c0Mt?=
 =?us-ascii?Q?jGOptEFbBqH6ME6bXCbtw4aAJBut/U3qclgXFNxeIgARFuJ0/6VZZCbEVUWo?=
 =?us-ascii?Q?5uLdyFJQhhNm9KfzN4PSO37cf8DIAdN16zhldRTPgv5cHHc4YfqEhg549a3x?=
 =?us-ascii?Q?9UZQ5GB33J0SYg8znHxtJeKKmZeM6DezeE3nA/oEZPjLsXTdTKDMmEctQmHY?=
 =?us-ascii?Q?Sbba2NYAZWxDx0pGYi/l/ysBtpa0l/77HwBlvSFGvntrToG2ym+2686eEkXS?=
 =?us-ascii?Q?WvJJ+JF7t81G5gVb/Gd52scPwFA+8qFODITrYF9ltzfyUGTne2OT+gM4srPC?=
 =?us-ascii?Q?Uy76vvqOCdANrpHPdBs6oMa+2a8VyJVzNM4NRWSEdbJrqF7odTWOG9HsLkEd?=
 =?us-ascii?Q?LR02zSSicIPd/rQb3zlz2sMD9HKMfBcwtLSYeCphgScg2wzlqdFL2W9HPe5u?=
 =?us-ascii?Q?h17biWnJaBFG7lQdUBq8Z0qEDCHSvvGT2kOuaIqjZFoTACTnGsTBtmMflPMT?=
 =?us-ascii?Q?BA6MWl9rQ9IwBbSIdoU//+1sddBvis88744phuJ2rdxQvxHAqg0RnKZGIVnq?=
 =?us-ascii?Q?Nx3TbHTeiD4PQ40nsEHha1FcYdZYtcvrxYZM6yAnev38vt7COxeOf4iHP6lM?=
 =?us-ascii?Q?v1s9W+lWjd455e52eAsunI3CQMewydELKM8fxLN8wYGBRPSiRGz6NavnppHr?=
 =?us-ascii?Q?YYXyrwKQwqKxciBtrF/FuUZGJp/iEzQi2+sebQl7X+vq9sytqfd2yrSGZrpX?=
 =?us-ascii?Q?nukp1RUUub+muEAy9SsGXdEUC4CxuQus4olaBTRkDGLTdQxP/ARon3jceKqX?=
 =?us-ascii?Q?DXLH5vLu6UtvyrxFiUaINQB6SeGGpTFMfZB9YQ2Y/OiuEjIlNHeaSMk4s0No?=
 =?us-ascii?Q?lldWu1LFvqGBK1IsCydmNveP+knJ5GOfV4FrzkR1mDn+p1OXU3f+dLI5e52w?=
 =?us-ascii?Q?YXs2CbYekoNJrsKgiCJ+ShnqmSo2CRkXxmDTbxSeksoIV0YUl53B8UMcoX/L?=
 =?us-ascii?Q?XY4Ck/bOLr2vMRa9DhygawhNSKQdQksCD0Uv/Y9hcDBLoIxyDUcPqaZ4PDOM?=
 =?us-ascii?Q?RE9OIKowWAfLzl4rZDZOd+40d8DbTjJKfrdelGsoyuVaFqV46EQ9omkjhkH2?=
 =?us-ascii?Q?0MeRkgsRJksLt+Q6m6Cg3YrZYOAQZDShZNjx+62yDsuvkxZ/htVjhLyN3ryT?=
 =?us-ascii?Q?KBNy84nve8v7ycKd7TeJ6wqoSkYylDae0mQAS5f5XjUalkz3ZxUMyrddqnng?=
 =?us-ascii?Q?4cMzU9RRaMXNJbNFYRURkhIzXRcmxhxCmo6uktszRg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/uX1Ow1ZHNi7cUbr107HOsNfuFl9A71YNOOhoW9Bw19gMFwQ5+4yfLbG2nQy?=
 =?us-ascii?Q?ei3QwJkAS0ElAPXt64tCz3Xw2OebnXpz7VlSekL+WuHXbLEr/kXK0ZX1zMnN?=
 =?us-ascii?Q?9xfUfYcsZk5Gkqj9DhgwJQ4dIxZUxayAeCz4/nOrc3e1Cao1T4i07RbKbkXQ?=
 =?us-ascii?Q?qYVNrF5Ui7qSPCtFWAv8c5RK0x3MnpA8Uk3hh1PPB6v5P+cp2ZT3WTLmWDE1?=
 =?us-ascii?Q?7J6uxpuJtNDBcbKheKazptuiw+MM1WBG4998/SvLbIzqVlix/fv7S5r+4Jrp?=
 =?us-ascii?Q?dm+N1I3p437zVpx3dDWVsUHCt00YcqjKYRKEvEJ3Obk+0vXRYjdIJFCmHGHl?=
 =?us-ascii?Q?UJJ26G+fggzpm3qJSEDOLSuCyucGScTfkqQzMM+SLB1r4VoCNhJAFA5xX+VE?=
 =?us-ascii?Q?Eyh+g/bf7Qra6cJxjJKUgUdexFr+DgNeGxvAH1W9icM1DRAO20MT60NFaQmP?=
 =?us-ascii?Q?U/MMmyKZwzA5R8dHw7Okc/cUQGdQzdhKNrRm3v222gbMa5NhXvAcWUM2sY6W?=
 =?us-ascii?Q?dj9d85b6wMh6m2RqQctud804BldiDxMlhpA8MeI3T4GhXRuo0JNu3d1bObSU?=
 =?us-ascii?Q?SHRDknieAX0qEf0FrkM9/zCKZAgwKEEebLZHbg2CQ9gzqzCtdBnvCskErfK4?=
 =?us-ascii?Q?3BL8ld2kcO/qqMXDF59dBNlwUDjr9YcuDKTAUXZXYw8h1L5vNLUG4PSTxiqn?=
 =?us-ascii?Q?pk0ArbsAkblPAIa+8mUw4wQvicO+FCuTXuGZ4sjFXfbuhVyTnzHyPzOb4k9a?=
 =?us-ascii?Q?pOXLqTbbPANIdclYMiQWKYtjqzSO+VxVmITKWWhWNWJsrp96kxG7Fd5lKOKb?=
 =?us-ascii?Q?hLIgenAlKiIDxV4+wFRAFp12COvIVwO9p+K6ohqzKV1OqC0oIUmgy2BzRR+j?=
 =?us-ascii?Q?GzXC0zENgIg16zisVarM5P8m3dgaYZdSdohwHHyp3mlYJAYXvWp3Cjj+IsH8?=
 =?us-ascii?Q?Lsqr5hFGU6G2EXvU0d8yE4GnUU25iGAE3cap3XXxSNbXplhGpGg0YMpBmONr?=
 =?us-ascii?Q?Ji7r8Qb4znHnsmpTMlTqM5GbqfjPq/sUccEeQKFpm4Z93YApqe488PR67P93?=
 =?us-ascii?Q?La6gaIiawLlbYSYe5lT4ivzHYarVnwld/WRfvFEFP/daT+Ukj4B+tNrwoYCI?=
 =?us-ascii?Q?PzNr1kUu5/kTE+mKDHwnrhI8MrgiOjDIMSCHW+RD8PUyoXhm0Gpz+CprRKQ6?=
 =?us-ascii?Q?4Ki7l0y3MYiRbBC/hOAhsQiGcHypTqf9lrrKDILlFnfJ5G4v9Ezq4rWks0s?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d1862a8-fd5e-488f-1a9e-08dd8be929c1
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 15:26:10.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8240

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

