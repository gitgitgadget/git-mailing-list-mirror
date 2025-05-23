Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62358239E9B
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003018; cv=fail; b=fjmxzz7nlsMAX/sLUi628FoWLiDTH790s4PyB+VJFOs0IjrwfSaV3agrVSgTJzaYvb/OLawfcmUIvRe2Nn61AJE3dKO0RiyHrxH/9xQwQnerzwPPQpoigTf9WRfUC4M0Ul18BS+9r7v3VERjzo+FxCPc9NtvRXd4k4glp7Uea6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003018; c=relaxed/simple;
	bh=wcIT9va/UJe7Yo3W9EzvVw+3oZEarrpZzgxUYRsGsxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jncUGAvrMaOCUSsIKy2iVRa9wmrlRRRm5rRY7C/NK+GKqRGSW8lYSrws8ni3foxnGVR5HtTuLzjrkNjIJVlfCCyqKzGNWunqL879DQIwK6HVK5DET4JWVQpg7Shh4Tvcb7q3cu45R+Y3LIdolYbFgZWAuu8gPM49LNEspSAo1Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pq0D5UzQ; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pq0D5UzQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSKqM2skFgPJKMahzrXnfnUKW9xZqR3QXodr25Vx8ZyTOpsHx00xOGxi7epQxO4a5tcQ/Gwjg/mdQUrvSc6OccTJ62ZUOg07orT5QjCr1BKJE14cB6r+65B6u62uz/TZaC0HJ97CTqTrfWvVDrzTDMDDgu3TaBv9Gn2NFhfEN0pnc/u/rK852fd5Zt5hvldHBHgDIXP17UkuPwd4pPf6L8ySaI61eJidmscewGzyi5QSzgLEdyvsz/MpzBYBck6cEGU6kklji03kXirMw8xSLkDt0SkxOAp7h48lLJJazNzU9m8Ik0iWAVRMpkk6vKWn5gn/XwZsVUFxIjDj63o1dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmohUdmYWVNwydoJWz2tzdhbN6yvrJPbb5JcisFOR68=;
 b=vo/LzLK+KbdRVg37oBY1YjFL1DwRy9Yh7BARgEoMaCFf9LIDWnLvhDSQOoPj/w6Az0Wl+04dvnQwrZJr77ml8iNPzNQYHcQqfmqvq2cNlWQWdJSmOxcwwiJR2AYhfK2/JCJfnAMEP8BMbZYqS2CYCxaVrE7vS2d1da292oWermXJ23vYS5Afo8n7fKW2OEHT6+R7hx5T5Sq1DvXMnaWKk4ozosNKZUcj3oGWz3j0kOCgUHCXZJ5bM9FVP0hgnK8l6FGvH+mAY+qi7/j9mCD+9pvpCFfVKKEuevIBchZY2D/ItCikGYa7ZtNDCiJN8u7WKPwkeH7XQcGiY7j449v2ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmohUdmYWVNwydoJWz2tzdhbN6yvrJPbb5JcisFOR68=;
 b=pq0D5UzQV1r3bpp6RBs3FRX6jrMmqfwnimaon7YfqW54s9vGRfAMAe7egP08IFMCeGN0norQMuM2kHnuHjlKw1mTonQ9OzOnGDVz9GQgS4zJ55vCxlLaJIUEs+2O3bZihqebMQJhxeg8NkGoenbUAn3tEbvcXYtFtFIXs4BhuVBzZgPJpfqVJ6Nhz1CaNfmn9nGQE94P9iTJJJIKRE4ecANYDB0RO7B8w7GmhRi5MEEIIwheJBIaI+IW/MY1p8kE82d88V3t/LfaW2ZPi7QVXZvd93v5JdBkIk3sacLITy7T54IskiJlTezKJTwILohq1ojuu9OTVVNtEFlZ85tyxA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6603.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:23:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 12:23:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 4/4] imap-send: fix memory leak in case auth_cram_md5 fails
Date: Fri, 23 May 2025 17:44:30 +0530
Message-ID:
 <PN3PR01MB95970C9374353E47060C8703B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523122236.22593-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4fb7e6-2925-4202-9c99-08dd99f49ece
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799009|7092599006|19110799006|15080799009|461199028|5072599009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AatYhXE3US+DUE5T+RIl0BrfOAOtCMxbWRa9g8Lt5b3xkhUlgGXHDKKb3zBY?=
 =?us-ascii?Q?qU6j+InxUexBrTTQUV++LUJSUHL8W4BawEGetciWBeA80EDmVefvYl2tbu+y?=
 =?us-ascii?Q?B/zg9ctgRILjPJGAhDT4x7RFHHSuVGPvmANmOUnOfcsTd46u8hlUj9QT48/H?=
 =?us-ascii?Q?qb7OtyU1rhR36Zu3TnRtU1DuXtUA3CCaFMT+1IAmNPemULPPtfq7x2kUo/lh?=
 =?us-ascii?Q?c7jDjEMihI4oY1n3PlvVQ/OqckXMyvbPd80tdn41xIjtkey2Cjc2meZ2Cm3X?=
 =?us-ascii?Q?zAms4EPjEqKkxqp+Hwb/Mv7i6swtaNUIaPzH2+M7P1vAI1DJqIGBEUKnGJT3?=
 =?us-ascii?Q?8l/rYUeQ/utbyDf/JX4BojLOfl32ma/eZZSXCKNmWSsoiph/aa7ne3mIg+aZ?=
 =?us-ascii?Q?7QM2LMAW7/lSztRoSEXw9wMnAnrS9OWJMBrkLpwfuEVmWlFIJn02ZjpLOr55?=
 =?us-ascii?Q?bl+Gag1P4Go8TBx8BrFEG7Ni3FF+Qw9f3p9Ot+yeOY+Yq6usG6Mwso8fmW3C?=
 =?us-ascii?Q?hhaD6PEt8YLDJEDPbkxyk58qnpiOqTehMNZ/ZjbptzkAo2+M8fwf6BzQFYqW?=
 =?us-ascii?Q?fK3i4VGGCRcsLnVPYN3cVOz4Y0EkwHaPu16Y67DDX3OrbR00DPPs7ZOOmDnH?=
 =?us-ascii?Q?aSaUev7VIOy3XHmP/ulh/2a2Z3/TD3K4vtK2+0nneNClUnMyD0sEzvUWDxCd?=
 =?us-ascii?Q?6nF9hhXn3KRzqwb8O5OyL1dWUmsAZGX6p3r4bATTLreSEfUYwd+sHxSHz9vz?=
 =?us-ascii?Q?h4gGQggVoyjHj+on6K8ubLYmtFByVuSsnUVInKHYHl5CtslxKRmzJF/92NxL?=
 =?us-ascii?Q?n4FhnH2Lzr6qZsPLuWQ4x/l1bqC8GrgUjS0z8pofGDblvKCPrhAdmlcMn4pM?=
 =?us-ascii?Q?De8nhrwdV7jtwDa0ug/jerWFz5cCYvCKCFrV7xEtzQI2rli1hZZkX1yrZBwc?=
 =?us-ascii?Q?fYuZiCsfr+KVC9HgcoGNDH4ml+ZqEkYi2jG3//MjJPl9DZXfLBHUUN3RfALh?=
 =?us-ascii?Q?hysSP7tZkA+LlgRHRqtr07R70nzUUvZStIdImAyLB4TaPC1KYnXeFRJ06hro?=
 =?us-ascii?Q?rtNmkYM6ILrUlRNYmuOmmvrz3aj+iVK1aY0MyEJp8e6lHsOm3UCVJmr/WYS8?=
 =?us-ascii?Q?HHjy6FGRg6TBrZWRiyVKrVySBwUZRdXcCEvzWvv9Dx1WQGFLftyugGQ=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gND0QDQAL8O80xDaFZQ49v5a8ZZAUOTO+0R0Yo4AcIIiN/JIjs0AsQNBwGjB?=
 =?us-ascii?Q?xXDWgZV+4/B+1NT9ok9y2STB6Cfg5L8Z5HD2OQRKX190JUjLY1Lf7xgPfW8n?=
 =?us-ascii?Q?trpzCk34OJifQDf8Rqe72JUvkNieYlCNVe12lWc+ba7x9IvuvJwxZfl/t4ai?=
 =?us-ascii?Q?GJLcnyaoylVvNt/U7hj5Oo/THv6FASL6/geHt9aUq8jDX/nLwymaUw6vwTjX?=
 =?us-ascii?Q?cO/IJyEZhHV1U9cCb+Br8SlypDz1T3DgpocJEVLTu9NZhvm97jnGjnNUHDFl?=
 =?us-ascii?Q?XgSEjzfZVG/BK36VUXVYMLKotCtauHGVF0NSyDKsVtRq6OEKkQ5sJfX9vnQg?=
 =?us-ascii?Q?HcsCwN3r9x/rT9bjk0+bWjCR6q+21ONlqIlA3SXXJS1ORy8pUxoVNas+GDFz?=
 =?us-ascii?Q?r+NejLye0pXgyuh1P3FqypghPSFA/T+n+5KghTpBD+6O9ppH9QgWKiDpn46Y?=
 =?us-ascii?Q?mfpOjRSbVKVRcngvcw3d8YCgqO5WqQywkDgEYsLEsgpG+jMXLY6GXfE4F+F2?=
 =?us-ascii?Q?O7IQpyxLtI0WpAmjTKmE3GdaMFUxUu7sRBSFuSDLr/qEVSGziyhfHDw8pv5C?=
 =?us-ascii?Q?YbEtBm+uXtdN9Q8yumy8Tyo9PoqFHp0froNPgO4GiC0BEnM0Fd8XvH6v9lrm?=
 =?us-ascii?Q?188FmgPuCH0U7gy3XSNnUNpo0n7szFETqUn6Ai3tWwmzGB2Bt/p/Zk/Ojlne?=
 =?us-ascii?Q?l7+1FWhMPxWPOmKWweS1M6pSRzgzOmga5z1GpxQm/SUMTtuSWbm3y/KazO8G?=
 =?us-ascii?Q?4I7D2s6/O8MubiQNRjqkXiVr9OZGfZF9/BgEyms5gPoNUJfj1GLamVjRnCuf?=
 =?us-ascii?Q?Rdy0Rd9BJ3FZ7xaGGTOYhvsTIQer0lWJRdu9EZv/+dw0yJQLBSIZR7PO6WoH?=
 =?us-ascii?Q?KrICFM71GGwsCBn98B8lVPOThpn2sVyGCkFsCzpwnKBwq4f2Jyaft7WCDhld?=
 =?us-ascii?Q?Vfyarb20ON7bp71OdZjdx19SxJg1FVvuz1qeGs7p35gtwny0sccYs3q+KjQa?=
 =?us-ascii?Q?fAXmblH6OB4e1s9ySYeugXf6xNa6W7nt4ZVyGsX+qjMl1fPrFroJZqj0I/Fk?=
 =?us-ascii?Q?0bwg10DEQIQoanPgcsWqNsHqMqVXj+wV0iF91vgWdwH4o5A0R57+fOUU9kRe?=
 =?us-ascii?Q?CNgjN2VzL/jJpf+jcBY6FD4d97f5u6GfdGoqpFazA4VNUKqOTSXVFjhKt4z3?=
 =?us-ascii?Q?OmX+87ADjjLmp4lCz0t6Fsc4wTuebLWwuv1ctGKd+Yw+4nNTxzo29Sgp8E/z?=
 =?us-ascii?Q?9ry3QhBK2aThg6NdyEwRp31pQeQ3+5xHKYARH+MFx3QInuTWh0CTAUF9XpSm?=
 =?us-ascii?Q?diI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4fb7e6-2925-4202-9c99-08dd99f49ece
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:23:27.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6603

This patch fixes a memory leak by running free(response) in case
auth_cram_md5 fails.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index ad54aceb28..87abfd15f3 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1046,8 +1046,10 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
 	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
 
 	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
-	if (ret != strlen(response))
+	if (ret != strlen(response)) {
+		free(response);
 		return error("IMAP error: sending response failed");
+	}
 
 	free(response);
 
-- 
2.43.0

