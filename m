Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021134.outbound.protection.outlook.com [40.107.167.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BF18A6D4
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085957; cv=fail; b=oPAapkQ5pPC51Vs9a713B0Wyv/iWVMv1X8M71tqpHXC7dBc62Erg+JnO6IHtgjVuUJnCnrzCYiI09HA+ngNOhwMUPAsorRI/c0XH+Cj5slo+7bmEyscu0JbyYoN+TIzvj6Vz5IfbgRHNhHhAenAmXhA0t9BRCoQdfFK3KJPkpq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085957; c=relaxed/simple;
	bh=GUBOkyOITAHt1vFoVEqHmHTl/x3xObB8kBmzZNOKZT4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y9J/RR2GKqe8eFcOE/T7q2ESk66TCr1+rDKI38R+oqROh7U8GNigZ2klUTdlsXqLFVOKJ3dPCV0gaJpzBFYZ2PGoN4AfsnY9mVO4PFl+TT2VFuz7Ve7lYi9ml4mDBJA8EFJiCpyjoz/UKZKZN/wEaJ5kJDNZIwWslKNUZafPl/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch; spf=pass smtp.mailfrom=psi.ch; dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b=CJrjArcj; arc=fail smtp.client-ip=40.107.167.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psi.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b="CJrjArcj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1dZzM5FZL2zwH4C+0Ncbp0dV0LBXo4rqN832W+8qCXmbWlm+RQcUpzExPE+4Vls/tPDyg+DhK7P3QbTl13bbCV61qIH2iPiZ5KGffyeSAJDkAOdb8awX1XSr9csxjEAEj6yUkERA0VOJa9pjQaznBXVZ1ypll44dsUpWdaG/Z+RdIzRbBW8u7B+U4ZsV04Z0S9dbRCy3P+idEUZUtMMmvuIIT+dKSHmB7AzLK3SyVlMrs2Zs+klq/Emyri79Uqx15cE4NtMVNFDBfsTqvCzuv97FrAZVPc/uhUPCUWm4NHRUTeXsAl4n84cPho8Kq8+3r8uf1H7JDuODzFFejk4uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yUgjdnVqJA2dATVPOUZynkwRg9XyURqnhwwOT2zsEi4=;
 b=soYAKekInI6MAudSEz/0AxFT6OAEwUGFtwOtrYe5drkdDHSm6QjM8y+DO0XInWYhsxQ+aptHezL3IltfKGuc9pOGxRBKFdp76rdYn5xsBHqeJsDRFmHf4cy+4RibqcaN4BuWnjt7Wz59bCZymBZb3Ootgir4n/ONUxoCZDZRAjNlnaBu4norgIt4Zz65KpG8oXrSdzqixV2ClTHNuZt0jaEB+lFpsnWBRLp/iWGyO1VFTEUkirdOdrCtjRTzRzneb+5qikmfUx89K5OTw1gK+QDJo/M/h2kjmWtlm6PNulKas+2wDgcozYQ9RV5SQIpvn50ArPenFnz5ZkOjMSk2Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.250.75.252) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=psi.ch;
 dmarc=bestguesspass action=none header.from=psi.ch; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psi.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yUgjdnVqJA2dATVPOUZynkwRg9XyURqnhwwOT2zsEi4=;
 b=CJrjArcj6tWaN/kGryQO/aMn41U4ib813dURafjwzZEXKrm2DJUsl6AfKLMZnSPCO/493zvx1qP7kB7i/zkdgqJNTQyhftshj5qUKdMyJ46dGyydtvPCKz8Z4OPdojPCYF2XMjgIbKs17+A3GTQCqAYLTN4nwOpSQ63vi6biLI1xAtv5x5Es8GgYRUZALesEhsD67ijNpnT3JA5SUw1Yee5I7uWzFDg4vqwdGPokvQSLM4rpf2+qnlDOaQ6pXIybXsyzNWZmufgR6/6M0XrNfXqh2/b2BTPZGgktsNYhXsZ1Vq2bnSoP5N5lroarTKv7ZDf3lI3WqViiTpPipWwRjQ==
Received: from ZR0P278CA0063.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::14)
 by ZR0P278MB1651.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Fri, 13 Dec
 2024 10:32:27 +0000
Received: from GV1PEPF000006F8.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21:cafe::33) by ZR0P278CA0063.outlook.office365.com
 (2603:10a6:910:21::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.17 via Frontend Transport; Fri,
 13 Dec 2024 10:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.250.75.252)
 smtp.mailfrom=psi.ch; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=psi.ch;
Received-SPF: Pass (protection.outlook.com: domain of psi.ch designates
 20.250.75.252 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.250.75.252; helo=seppmail2.psi.ch; pr=C
Received: from seppmail2.psi.ch (20.250.75.252) by
 GV1PEPF000006F8.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 13 Dec 2024 10:32:25 +0000
Received: from seppmail2 (localhost [127.0.0.1])
	by seppmail2.psi.ch (Postfix) with SMTP id 4Y8lyd19VJzMvT;
	Fri, 13 Dec 2024 11:32:25 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010001.outbound.protection.outlook.com [40.93.85.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by seppmail2.psi.ch (Postfix) with ESMTPS;
	Fri, 13 Dec 2024 11:32:24 +0100 (CET)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psi.ch;
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::13)
 by GVAP278MB0970.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.18; Fri, 13 Dec
 2024 10:32:23 +0000
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288]) by GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288%3]) with mapi id 15.20.8251.015; Fri, 13 Dec 2024
 10:32:23 +0000
Message-ID: <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
Date: Fri, 13 Dec 2024 11:32:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: chmod failure on GVFS mounted CIFS share
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
 <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
Content-Language: en-US
From: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
In-Reply-To: <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::20) To GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0504:EE_|GVAP278MB0970:EE_|GV1PEPF000006F8:EE_|ZR0P278MB1651:EE_
X-MS-Office365-Filtering-Correlation-Id: 36da9ef1-4229-4ac5-6340-08dd1b616fbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?djBLeERxQmFaQTNZckRPRmd5UzhLMUF6YVZmeVpZdUZhNEdEcDNmc2c2RVNG?=
 =?utf-8?B?QXU5NDc0dnJ5Y3NzeGFFdk9sOFY2Q01IVENCUjB2eEFuMmZ2MXRrOUpEK2VQ?=
 =?utf-8?B?TFRndVRxeHBFbGMzeHcwd3lvaXdHeTRiY0oyNmdjSEZGWXhCVXNKUzBsajhK?=
 =?utf-8?B?VThTTkN2ZTdRQWR1dEhJckhVNG0wV093aGIvdGJRdVp5V09namZuYmhLblB4?=
 =?utf-8?B?bXFxZ1BXNmRCMWR2a25FbTV3djdQVzF6U1lKZ3ZhRnJiZXM3a0RvMFJKNWhJ?=
 =?utf-8?B?UjFoNVdyTHhaWFNkV1FVM09SR2RTcStQdENKVTgrOHR3a3JqWVY3L2NFcTNx?=
 =?utf-8?B?NWRVNUlGQjE2MWlGQjBtN0pxdDVpTmJLWDlvckFBUnFNN0c3R3NNRWF4a2xT?=
 =?utf-8?B?ci90cTVmZndsRGtoYitneGk1VnFBUVhLYzNMU2JzZnVFb3V1ZzBDZUNpemN4?=
 =?utf-8?B?ZzB1N0tjeDdOMnpIbzdmT0JETW1IQUZuY3U3bHlVbkpwSitXWWJIRWFwWEtm?=
 =?utf-8?B?NFZQZWFDaHI0ay9paGFPc0l2aUltaXpuWG1mNTBZbDNvaVl4ZzZvZVZnL2tK?=
 =?utf-8?B?Zko0MGpBWEduSGtZUjl2ZFJQZ3pPWEpxb04zOVFTREE3cER2eXk5OFVGTWZs?=
 =?utf-8?B?U1g2SXFGdWJNN2dGMnAxdXoxTEZZR3pRcDRnWXBiSzNOVGpiMUpTYWlrQ2x4?=
 =?utf-8?B?TDBEaFNRRTlLZkt1aWtDN0ZCYWhXVG1nMUJOMWdFeUsrMDYwaVduZlRmRCtK?=
 =?utf-8?B?em1qdC9DOUpwVnhub3pOclQzK3Bqb21XUFZPTE83TjRMVDZpZ1ZDbExWR0p1?=
 =?utf-8?B?Mk0xenN0SkFRV3UveU5PYmZKWmw3UXdYdEdlOVRUNTVjbWNCUk1ybEJVQlhi?=
 =?utf-8?B?bG1lbm5oblFUU1d4Mjd5d1JCVkFUbDJUQi9FQWlYRW1aZ0NGTE51bm1kbG16?=
 =?utf-8?B?VjlvMU93RzUzSmRIcCs4Ti95YWlXOWJ6TnhWTXU2YkNLZklXTXZmL0hiLzcr?=
 =?utf-8?B?eHkzclNKaUJueStPYkl1aDhxUlhqSEFlT2xnTzhTWUUrY2EyekRweWtCQUxX?=
 =?utf-8?B?WHY4YUt2Z0NaSmxpbDlVV2ZwYVpqYzRDdFBrd1ltWnVHOFhiam5qMjd4QXF6?=
 =?utf-8?B?djZlSjJYaHZCMUhQVjY3S2VFOWJveWxWZk5SMkpPSjdLTmdMNzlmNUl2YmhE?=
 =?utf-8?B?SzZNZTFBWVN1NERwK3FkcFZhaXRwaFMreEpsT24rcXNkT1Vhc1pMQ0xqcmwy?=
 =?utf-8?B?VW9SN25RbXVHRUlNNjFBazVPWU5LeXZURTFBVVFCMXpHQ1YxNGU0Qy9uOGtW?=
 =?utf-8?B?UDlkY3JITEorc0RDR2RMaDlTY3JFUVE3VHMwaEh3VkZlNGxvMkxtVjZpSThJ?=
 =?utf-8?B?SkFKa2t0Q2lBZnEwRWJ1d0xQLzJES29MdFRhZ1k3b2dxaFV5U1lENTl0MWht?=
 =?utf-8?B?RUtqQXhyOS9TOGVNY01IWTNJcWZOS1pTR0Vqc3hjS1JRMFUwUFhoS2pXa090?=
 =?utf-8?B?WTA4eWlDeHE4ZWl0UXRuV1p2TlNMTEN0RDJDSkhUUmJQUnhQaldpREpyNlpx?=
 =?utf-8?B?bFNWWW9LMTRQMmRLQ1J5b1RwOUlLTXJzWjFoRkpJMHVWL0JoaEpnNk1adEY2?=
 =?utf-8?B?WnhLQ0RWdmFOeGVGaFEzQ3VncHV2d2NaR3dXdkdwOWl1T0I1MzFOZTdqeWc4?=
 =?utf-8?B?eFIwWTZiL0w2WktrN1NtamNybGJQeTF5enZsbjJwS1ZreEFjd1lyMVEweGYy?=
 =?utf-8?B?VjhQakgydGxsai9KYlUzZExobTB3UkNrNk9CaG1DYVVpQ0pJb1hFdk0rTHpG?=
 =?utf-8?B?dUVOSE5rL3ZzNDZqbHYzQT09?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0970
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 GV1PEPF000006F8.CHEP278.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	99181996-edd3-41bd-87af-08dd1b616e46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHdOUS9NOGRiNjZuOFRVYkZwTUU2ck9JOEp5YU4reDk4Y0NIVzRvQVZ0cnpw?=
 =?utf-8?B?MVJCT0xVU0dJNEIxdUVWSVFjTTA0YUFFaEFUL2xaM2wrRk1HeUo3WVk5OS83?=
 =?utf-8?B?UXp3dDNEUjI5L3BRVjlCdkdGWi9ILy9RbVI0S1NjT1dkNGJPRnJoU0lQTkx5?=
 =?utf-8?B?SFBNa2FHOWtWRUlrcWpoQ21EUElVK0N1MnJFYlBYWklyaXc3M051QUgxTEVI?=
 =?utf-8?B?KzZzOU05VFh0NXQ0WjlGYUZocVV0eWhocFhHMEtVOHdaeGlDWm1YL3BPVERF?=
 =?utf-8?B?eXlFMHRqVnJJa1hkN0hUK28xR1U3Y2JRVUw1Z3d1SUxGR0QxYlNpcSsweGQv?=
 =?utf-8?B?ZTJkWFpPVUdMY1VyMzVrelhqS244b1VMZm1yTXo2MElhbFVGVmRmNkRhNGJH?=
 =?utf-8?B?OXZ4ZGpjNmlCbmRrTFVIS1VqYjVlZGt2cFhvSzhqWjVkRE5SUytRMkxrWjdi?=
 =?utf-8?B?eDFmVGlyS2VrOUVpT1hnVVJJd2FnVENXYk9aekQ4SXM3RFZrNmNUYXJYK3Rm?=
 =?utf-8?B?ZklkQkVUZk5RZDlzWS8wRjNNRGNKYU8rVnV1c0o1dWc4a3o4TmhZb1FnWXZG?=
 =?utf-8?B?YW5zZVV6TEpaZkVDNW5sOE10Zi9ucWpSSmtWNUVqRzNBeFlEaHd4c2d5WGU2?=
 =?utf-8?B?VW1NRHExYmN2NGU5VjVxTEVpYXQ5b0pob2F1c2tMRFBFVXFCZjMycCthRWo0?=
 =?utf-8?B?aGpKcEJ2WlZzVXRRM3BJdEpDYXFjalF3OUh0WWtlb2lzMzhjQ2phV2ZwK0Rs?=
 =?utf-8?B?MThrL2xVa0l4NGIwZURGQjJqdlVuMGg3TDZLK2RLQU5zbzNGUHJmSS8xTEZz?=
 =?utf-8?B?SVdQRTJVeVN6eVVrdFdCQjRtZjBzaEVxTVB1dkRNRnJCUlB3Q25YdjZyRkF0?=
 =?utf-8?B?U1FpcmNod2c2eFlLSjlVc1hwa08rZVEwUGdGWlJXK01jbEZVd1ZwdnN3OFBF?=
 =?utf-8?B?M3FWMmw5bVdza0NDVGJscGQxL25oZm1BK3NXOGgwdzJ4bGxMenEzUUxpejEv?=
 =?utf-8?B?VlhSb2xWMkNHNDBvN0dMWGlsOWE3R2pTUHZjWjg3ekNqWGd2MmtaSWJyM25B?=
 =?utf-8?B?RWI2ZnRjaW84ZlByKytsSTBKT2dVd3JGR1RZSExFaUdnL2pRMXlXcFZ2SnU1?=
 =?utf-8?B?SmxnZm1qVzZ4eUlQWGF3SXFTSHhIZEV2WGVyN1RBSTArdnhSKy9ER2dJSkhQ?=
 =?utf-8?B?NkYzZkUvTEJqRVJtOCtMZG5SZzlDemIrNHZRTTVMN2pwekNlNW1YTzBwRzRD?=
 =?utf-8?B?bWFkdm5nQ3c3ZExDWE1vRkpSQUFjZ28rd1NrcjNheW80Z0ZTd3hHelVGRXpR?=
 =?utf-8?B?dUwxK3pIcExQakNZUVl5ZEg2aW9HRXFVMnk4em4rQjJhamloaUJla0ZnUWgx?=
 =?utf-8?B?Q2NWa0VjS0JHTS9oTS9FQWQwcjZpRnhnZlllV2dWODJGaWVObndIRmlmQzAz?=
 =?utf-8?B?WmFuUmkvdXNjS0dBY29tc3cweS81alNXM3lQV2pjdFQ1NE40ditDYUk5Uk1z?=
 =?utf-8?B?ZkFrYnd0ejd1REpHWWt5cE0wZjB5S2hOUGNubHBFMVZtM3B6UnNCMHFUdTQ5?=
 =?utf-8?B?SXNlY0tXSXM1NmZOWmE5dW0rNWUzOER4Nm0yOVRxZ1FiNGN1bVdGM3Z2ZHkr?=
 =?utf-8?B?RUFoNVNqVzljMWMzbkVqeVJvY1EySmZOQTN1WFZPWHRCVWVoMDY5U1BVWFgx?=
 =?utf-8?B?bFhFUE1MWkh6SVBpTlRGNXpxenlrckg5cHRCU1NDbnJ0dWtRck92MFArUEhB?=
 =?utf-8?B?S2NXZGs1UWd1R3Q5TDlsRVhiUkU5Y2lBMVZDQ1dCcEluM2E5MFB2cCtoM0RK?=
 =?utf-8?B?UUwza01ncDdqZVR3eUluTGxVbEtDNWluSU8rMFdaUTl5LzUrVGUyaC9ScHIw?=
 =?utf-8?B?cnl1V0dPS0E5UEEvLzBobFJhZmt4UXJFeFlzUmVXMHBCa1o4MlFLNTBzb0lS?=
 =?utf-8?Q?B4KTcY1Ibw4QqhsSuSzLZfOuKOFBwPIP?=
X-Forefront-Antispam-Report:
	CIP:20.250.75.252;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:seppmail2.psi.ch;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(14060799003)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: psi.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 10:32:25.6223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36da9ef1-4229-4ac5-6340-08dd1b616fbe
X-MS-Exchange-CrossTenant-Id: 50f89ee2-f910-47c5-9913-a6ea08928f11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=50f89ee2-f910-47c5-9913-a6ea08928f11;Ip=[20.250.75.252];Helo=[seppmail2.psi.ch]
X-MS-Exchange-CrossTenant-AuthSource: GV1PEPF000006F8.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1651

On 13.12.24 04:41, brian m. carlson wrote:
> On 2024-12-12 at 09:14:50, Konrad Bucheli (PSI) wrote:
>> Dear git developers
>>
>> Below my bug report:
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> I do a `git init .` on a directory which is CIFS mounted via gio mount
>> (FUSE).
>> On RHEL8 this needs gvfs-smb and gvfs-fuse installed.
>> Mount command: gio mount smb://fs01.psi.ch/my_user_name$
> 
> In general, gvfs's FUSE driver isn't a good way to interact with files.
> My experience with its SFTP driver is that it has a bunch of weird,
> non-Unixy behaviour that's due to limitations in the gio interface.  So
> it probably doesn't provide the functionality most Unix programs will
> expect from a file system, which will cause you a world of problems down
> the line, as you've seen here.
> 
True, but it has a big advantage: you can mount it without being root.
>> What did you expect to happen? (Expected behavior)
>>
>> It initializes the git repo.
>>
>> What happened instead? (Actual behavior)
>>
>> $ git init .
>> error: chmod on /run/user/44951/gvfs/smb-share:server=fs01.psi.ch,share=my_user_name$/git/foo/.git/config.lock
>> failed: Operation not supported
>> fatal: could not set 'core.filemode' to 'false'
>> $
> 
> This is indeed the case, since the chmod on the config file fails.  We
> always rewrite the config file as a separate lock file, and then rename
> into place.  (This prevents concurrent modification correctly even on
> network file systems.)  The user generally wants the permissions to be
> preserved, so this is the safe default.
> 
> This also happens when using a Linux Git on a WSL Windows mount.
> 
> Note that even Windows honours the read-only/read-write difference for
> files, so in theory chmod is useful even on CIFS and other Windows file
> systems.
> 
> If I remember correctly, the consensus last time this came up was that
> someone is welcome to add a config option that ignores the chmod
> failure, but that in general, we don't want to just silently ignore it.
> Unfortunately, nobody has added such a configuration option yet.
My suggestion is not to silently ignore all chmod errors, only ENOTSUP 
for config.lock which basically tells that it is not a suitable location 
for that operation and thus also not required.
Would that be acceptable?




