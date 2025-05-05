Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6FF1BD01F
	for <git@vger.kernel.org>; Mon,  5 May 2025 06:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746425956; cv=fail; b=apOdtvRTvT3wuV/VyXF5/GOFplijeEqWW8ejbnzCtqMiaKIOKaSrhMVSVMIj3LVqpiraXeQC94kftMiu5OOF9nuVWNXHcGqopi1n7DJyXp/5FcT+iuBSen39HxzfkCPmS5YbEtNLxXTaT7pjoO5bDyqs46Jaf8ItxIS6XJb8q+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746425956; c=relaxed/simple;
	bh=MmBwvOqaM8pbYr49lFDYJzD09Y+OgdclN6RHmKn5FC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fz7dB6O/1zWhy+IqLsmYBzoQxQzzMqHt/PdTSYxE45vyS7nXwF/Bs4E/pyU9TrgD5oPqQ8Iim39+MRGXpqInhihvuKHy0EbZ38nvY5YcZr5YTLoQSSvYcBQh/k4hAWwcvrdF6gHc/HpcZfeTW2FYKHXriGIAxByXnMwLTopmtdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kZhK7eKd; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kZhK7eKd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUh03VJ8bV05xKt6eBJdo72NFcDn2SqOMTl+gTiuvmUYyJhM0Abn0cHRDpCFyqIoJLrHGSci9QlW2gvmHHaTL8g6+wVWBrvCkpkpWY1phpWjnI7+Uqsf7HXBUnDEFKL4/zD7a7SoF6/rPDaLcTS1/U+p4LKAqo2PTd/ILi10beBBqbHl+zYjvThpaZRUfrTZ2TDhCzy2Akc7PC+8JD6tm/PXVlx0zs5Fh9T8WNV8JO54hqQOefLO/KzEpGQcmS9E+qinKCjR7SRZ8jA5BTZ0k6EBtq5ftkzMAUtfLiNSgqtqDqypqi5LRzw0MzWjmf7lIqUnnE7fxnrKq//KsbshFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seODZuS2uyxb+X3QcE9vCk3VDEUUcT2OwHKodky+lJ0=;
 b=V5/PaQShRrq34YkCN/1fDaBK1a2Q8iEKdgCvPbOuFGMLBABOiYqJehCMK5Vl1ogmLtp5XQiwmUz96YbR7ZnUaougoYZsk/qvZCJKR6k9ZNGfFruBXUWi0PnLNTI+r8pSfnb74m+z5yTD+PRpRJtgH71QgmYbY7zARt4VKtkeFhdpq/tdBEiMUuVlbchqkP7rbiAByBDkKC5Oa4sBXyoHg/Q1dPGHnJvIgriY98DucxZoLQ9BJ/nFZZucTdc6rYNgUyRzwB0t2cEJub0RVY0gAwWPZTnRCpZ1jOiBorE4MnZbS8MfSaKPDs0xsxpoOXX68yl6YChKxROAQM7coerPGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seODZuS2uyxb+X3QcE9vCk3VDEUUcT2OwHKodky+lJ0=;
 b=kZhK7eKd49IZ3gn6Ne7xSs1Pwvjh+yaErQxutS9wkkGlnf9MgLDSAdi8K8doisLpe7oJRuHjbbxVcOOKBVVJFVn3aQ3yltRAYSqK5HWCWxm9Pb07ocaaRlYIUZR90QkHH7+IkT/j0xhbXLGIBCNFh1q3qaeh8yqp+WnyL4AZWa2qnLHT3NRqVP2CtlXvW7l6Xirl+LzL4zxQote8BYBEdSkJLrhtMSogGSLLN/wuM5CHJtOaojzcmOETJ+Uq4165+y7VVh/5xf76yhIufIzneipqi/pnNr4CI8sltEP7EKkAZ2ckVO8exmustysm4xDsMfeioQcXWWSSC+aOXxHbeA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6047.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 06:19:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 06:19:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Mon,  5 May 2025 06:16:24 +0000
Message-ID:
 <PN3PR01MB95972F543FFF12319D17BB94B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN1PEPF000067EC.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250505061846.11170-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6047:EE_
X-MS-Office365-Filtering-Correlation-Id: 8828fbaa-8007-4b54-8b52-08dd8b9cba50
X-MS-Exchange-SLBlob-MailProps:
	laRBL560oLR0Ybdxcp7KTbjbpYD2CblCbpJcnjg2/0y6peAiGUGze3EEJ84mv9QxrAc5tv6wOtqkp2s9rZpRgvw9RuYx+Fj88A7rasr7MBsucijokG/kqh9IK7Xv606s0Iu+/4NbgPIbzF8ocR31E25wbX6jeU2z248aXD8Ymw98vrdR78Wtjw4LxdOcvQ57Lgvr1AmHIytEYfa+wHmlLh22IZmxy4l9b8GwOsvcJd1xMNkcnTtL5rVF9A53wf7/ylPKUDf65JUgVa122Q1TsF44uyPP9dN48gTe26Rl+klbAfw9n78br7r5uD5W6Yf4kVC27uHY/SHSPlNAKYU+r5DC/8Nh1potlBLMY+l/Sfio1VXYDXhKKQHhOU7INjIAe5V9T1fWdjIFroS9hCMADwDaMrngxyLSpVQD6Z+xtczAgd3Plv8WTf3M0bO3UlfFLCD7DRwh5xh6HEWldCzRTGH1Ou1DplpM7fmDKBMr3t7HXk/TPqBCxrxAIsrk83WJ2tJYqgE+WehYwzMSgnZaeVo7728oyp9XjEEG096kKazSizNZEpv+opvm+bmAv7GJYyfYIrHlpSWqZMYnBpwJEOqFZLT2jIypsKUXrcaeTglHGBvzWVt//gNtIx1tafNWtHgMVrHZd5+a9FOiMDtAU3fA8tLkJZK9rzvjqJKGNm/02TtQthcIeQVWDTY//PPKwKO4xowqA6b00PyJx9ojWqq32wta91ofonik+ny2PClhjFSpQ7KJ+r8sHWqdPEFmyeiVjAaU+8OgJuzwz3jrZ5niLw6SXQF0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|8060799006|5072599009|15080799006|7092599003|1602099012|10035399004|3412199025|4302099013|440099028|34005399003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JPWDRbIlbfehsmpF5oepEcQ9lrVvy5ZvZ/cxmkv2ntwSQAiSniVUTpSivHa?=
 =?us-ascii?Q?3DcqomHSTQ+rd5d4bV2oBG3Eeabtp0JsHocqshrBcuqbPVvUR9DOmoOqrbIm?=
 =?us-ascii?Q?sOgaBj0m/x2P1atRHF1v8pg43G1LSeRVTa9jSM429urttMVdYdgyi/VliBkh?=
 =?us-ascii?Q?F6IQ4HVmuNBahrZrua/95/1CalE/XQw6jMxaQ7a6E6my/HZ91hLr25Sd9JOd?=
 =?us-ascii?Q?R+At469O9HEAy36Lw87UBoAPty7JUn3KP9i2TzHK0Jm09heHgLfF7CbQllVG?=
 =?us-ascii?Q?1W9gvmLjTna1qovzOQdY6p7mrBFBk5TM3/rAdUxsYKxiTPtFTkk93QuCIJHw?=
 =?us-ascii?Q?z6xFbUNqeVY8qxDhNhVksZ/B2ZCkpcImOfhPSguhoiyjkzrZ4VyMQdEE9l7Y?=
 =?us-ascii?Q?ifjnHYtq27YPtlztZ3GbAr79nij4wCrga+ct4jfD7mR6ammAvsi4B07N6MrA?=
 =?us-ascii?Q?c0DqXfxUB5UULu75FTBvbCAqT6U6Q359F6AKCSaFZzz3MC8Nhz2LW4VseW8/?=
 =?us-ascii?Q?aeLjYhJZWHm9oZCb0168FCXYy465vrKBYm3EdOiMKiYCpunOXbgN8XPskLux?=
 =?us-ascii?Q?5+qN2xHEQsBEPlIivC6T80jsXIHoR0Z4hjyi42mceso/xbQix8YwKhwSpe4G?=
 =?us-ascii?Q?J9I8p2Uq5mTLf9pXUH89jQSGCZf+q9hjMR24GM8QWCkzI7/0f64EJpiYoy0Z?=
 =?us-ascii?Q?XLPAe/mD4sEQSgEcfw7SkE0Q7/h9pPDdpMOiFeKxddmV++VsWGtwSriMW8+j?=
 =?us-ascii?Q?w8IDoTlGwtPHPCg2wuW+41nnUiypCsd7F9so1c48yek5IoiPhavg75N+RewD?=
 =?us-ascii?Q?GJDC4XoCbiOQ++bT/dniL89+EHMUXFw8Qc2uYRxvgGjsy753kmQ0xyy04NMZ?=
 =?us-ascii?Q?w6LBDwpHkCtS5Qz1rAvQkhDSnJ4QLdVQRwxe8m4Fk5PpdT9ifYcJdOyJRyij?=
 =?us-ascii?Q?iVtxtkmurqpc7AJelZnBtPe00j2gMYXMY/0E7NqEk/QCh7uds7iyR0B2kR3I?=
 =?us-ascii?Q?BExbboAtK2g1GAtYrPjKgjGNoooIqLe2S3s4x+dDldYgVTNQPTG6/iWagI4/?=
 =?us-ascii?Q?UrxSuh0Q8o+hVzoSxclFPPExoFmuRR3pFjl0VzknrDDvnCpjj8iwk5dx26/z?=
 =?us-ascii?Q?GeU9x0L8D+9Ag8KU1hg3sn0EopT401/+TYIo8tRBSCr3YsNdPbE6W7XFb7NF?=
 =?us-ascii?Q?wh1yAdkWO2P7OKtCEDvI+FA/9IG5XysgQhmRZmfOSdnMJj5wSa4lcbC7VAxi?=
 =?us-ascii?Q?wTF/yxhTF3pKYiEO55cRuQOqW805jfZtQegLEyKsqQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BHxAjvgokcA9ODgLVu5lgChwphrdMWoC/upnjGEXxoIvaIiBSclN/vROqlEa?=
 =?us-ascii?Q?YzUes5ensfkvgg1WfXGpC5XhZXtL1RmFhDRRrbQnQ5Gg+XNrwgch/N8h02Mi?=
 =?us-ascii?Q?zsYupond96H5+a5h86nGPO7BfdVUYoJzpBgZsNMN9Np0QRGaMnZjxkVgnxZC?=
 =?us-ascii?Q?uNTbMApX8vZFRerFUcUJWkiMVulPCbPWkeiu57zj6kSn6rsSEPjKU4KViTcL?=
 =?us-ascii?Q?cVoUALKKcHzIxflGzHCKnuNBct5mL4ErPtGXnULv7fkge44aQBIPQ+6q3+TA?=
 =?us-ascii?Q?/uySkn3yKDiAzPzudXMOMS+BUPnw4AWjbEGhD8WE3reHvVvYWigoCxh0PM5d?=
 =?us-ascii?Q?LGrZgORVs7uT+SHL48h9CajRxnLJy9AjI+nRGaTbNO42dLiCP4fsgxcGmDAf?=
 =?us-ascii?Q?So1Cvr4ksPW4qKw6Vnl+ObhMBs1UknQJy2PxjgGr3c8SNqI/v8vyISEBnISr?=
 =?us-ascii?Q?7E6CJ1jEoWm4thSi9Moew3542sager7WqkZIAe4v0jOFH77UehSWgXxFZnDk?=
 =?us-ascii?Q?pCHFIktgo2eHg6aU2br+5CjF0DqXBtdfgVw8KWOC2i3Ya9gN32HncHg+26+N?=
 =?us-ascii?Q?9nUdUD/EeyqC8kRRSbgFkn4xI65t3VbrY1XW5ru1Nn4D9wWw4mtHraJk/kl7?=
 =?us-ascii?Q?cbveS3ZxPXAu2jlaJPSu5upeZccGM6tobAC/fHX2tQZkQhjy6QEF3HfuqnKX?=
 =?us-ascii?Q?sSbyeAed35sjjC6957s4zqIEiw5XlrdQBu6D0qPO+RZBuFTMPI6XfFjLjvCj?=
 =?us-ascii?Q?6OA7Cjzx1HHuNjgEFudcjKsj6er+LawKjaSutXQObzweuWSDeHxCFYfLskPk?=
 =?us-ascii?Q?Ca+qqfgytkFgSblkKc8uEMENDNauC1GfxQ/FP/APSJHYJyDtqsCLDGpmsZAP?=
 =?us-ascii?Q?3Tsl6eeqEgJV8RTKHAlRPxA4U5V6FQonsmgjMB2PfPsMXs6JWh9NsUSfMtNj?=
 =?us-ascii?Q?xkAKq3CTv4BzsNnw2c3ZN5ZwnhYaM5NPh+hYi2yHLd8nderqlal7ejvFgih+?=
 =?us-ascii?Q?3DZXBqkzUtalX4WfUT5NFlNSDPBMcLy2GMdK70bnTx6VU2E84s08MjwJ+RmZ?=
 =?us-ascii?Q?0/zb+/Tn0L+rDYw8Y+UqV4Silvd05+QNT4eNV4xwH/ts/vyInGUsPaY2MoOd?=
 =?us-ascii?Q?QZ+XdBIlD4vxCSHMXmRzQ8nWc/kkc/SaW27gd3DmBdIjp/JQK84+3g2T2aiG?=
 =?us-ascii?Q?SWzqiX5NJcI3mrkJI/NKX++WBooU6WaHi8tr5x7ShkTlsQNQbwq3HtW9In4?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8828fbaa-8007-4b54-8b52-08dd8b9cba50
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 06:19:01.8005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6047

This commit adds the `git-credential-outlook` and `git-credential-gmail`
helpers to the list of OAuth helpers.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..62718a0422 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,6 +133,10 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
+    - https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
+
+    - https://github.com/AdityaGarg8/git-credential-outlook-and-gmail[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

