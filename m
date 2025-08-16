Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2067.outbound.protection.outlook.com [40.92.89.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5503242058
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 09:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755335728; cv=fail; b=lDnqJ11YQ7H/08W76Q5T0UIlMSKNRbvslhV/9LKwqnWJREl7yFPyhSZ0of7e05Pg9O5AkDbBO8EL4LVDH2uy9adRcjiczhHrQIlcDzST8ikV0qAraM9D93b4PcA3ZLR8fvTBDSH9bZQ6nBBx+Xvor7Nat6rznXJBheLuxD/bowY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755335728; c=relaxed/simple;
	bh=gBOi4dIVjoMZekAtpKWtXq8fL19CAjGINLSUF8Hy0iw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=gRY/QhuVlx0+RIZOFHqZjlPcl1nJoHITBpqLd32tXpGee3vzSSAFcIxuRn8zp53hsj10ou6yrWal1qXD6A0QxKMeTdE85TY0BfcQLzY2OcAtLO1gJONBZY9hJ7ceuZwuelvUXrEgvYkHeoO+Did5rdo+20MVtJo92vvIFyfUrSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=YECvUXOc; arc=fail smtp.client-ip=40.92.89.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="YECvUXOc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6V2e0BfBq2SQrHeFiQ+qIxhEj3L759iVTHCkHJRRjv4njLiAyuxEr1qGbT1mQBrE4+TYqao2cgt0vZT7v9qqL2/kuVzUzOx0FWi7AeLDFR49T2iYUu4+DZtCsASaH/Gw4O+E0lAl8A1MGmxoPCl9Yu7OAkrwYSl68Sn8+TVY4mbHGDB/Ol7+uckxwSrKWd7YEqjFoXXRuHr9UrOiGLqm4RfWhm+gGkDwQNgY07tHfiZmdcaYDM89aKXPjw/3gTClKvDXr/duGYRs/VbYa3EvP/S3jLXiiwqxOlVIie/74iunCk6L5tdC4L2L74vRB2Jv/SR2X7WRMyJXiVi6fHeLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjLPJWOJyy7lBriQ/TLk0tvD2EN+qdWA6+wwcugdhYM=;
 b=EGQx5FUrSEnzpH1FeS2qNtVXh0Ukqw9K1g2u9S3lEER85+vZLmwVkfJjRDuITqQqUpjMJ6BL2Lf0fMAdWpu7KfFMJGiUbiAZmmzmKgRf4FLeCC/t+1sRmUct5q8HLeZX6/7MJT7PSreCpX0GM0Rrw35Z+fIj85ZHsYA/9l0sYVeVUEu3D1tZzMU0gAyr0yUw6MFWJC6mma5hchViJiThLphILD+KyK7CelySE2f22/pGToUrfPT/jwfbXDZ8QPt7k4tlweWp1GtNZjglG4clH1XzYc/HDtHimh0gCXP037CwGV4vRqc7HIRQ0gsUtZjORH9C1g+GjPkFZjP0gMOXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjLPJWOJyy7lBriQ/TLk0tvD2EN+qdWA6+wwcugdhYM=;
 b=YECvUXOcF8G4NyfOLX8Q7tqPICwicC0xQUh8V3Wkvah31djfN8xQrf+OaFPft+7PhII5YWk1U+gSctfiM5Lf4kX6pBS/p3vD0Zx8zlVhXAsxWcrCPn926EdUyA3lKHGLf1QZg37qSCZYENdWwxImbdFoU5usjq0FgyIQoPaWwjc+aZ6ZrEfNwOiHE2epcULoBJUZ2k5weD5sb3zvMpvcSAzGNjs4BbQLnBjFqt19tCtVLRuP6AK7aixijWWw4YGIWItFfVI/z9lK0wPyCbuAgtmju1L3LMBUorBhOJMI/3QiM6UY1ndifg0FEi/2LlIaaVjxun8MoDNh6jsy8OOqag==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by DU0P250MB0552.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:34f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Sat, 16 Aug
 2025 09:15:25 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9031.012; Sat, 16 Aug 2025
 09:15:24 +0000
Date: Sat, 16 Aug 2025 11:15:17 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Christoph Anton Mitterer <calestyo@scientia.org>
cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, 
    git@vger.kernel.org
Subject: Re: why can't one alias `git stash`?
In-Reply-To: <d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
Message-ID:
 <DB9P250MB06920D87A02A7FE81F88C034A537A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <a24d0d237b9f57535c768da4c00d72bad68cf411.camel@scientia.org>  <xmqq7bz5v0mq.fsf@gitster.g>  <16220ca65f1ae9883a2fa103e842cf0ffff43236.camel@scientia.org>  <CABPp-BHt80YD9bzWeC+r5qxJ0Vp+zRsJZsKDU_GA39CXmuYe5A@mail.gmail.com>  <xmqqjz34txjg.fsf@gitster.g>
 <d8b279098a41949eef06f26d3f09c3950486380b.camel@scientia.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <69c9be52-30f9-e8eb-5fba-f50f5013a510@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|DU0P250MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e3131c9-7fc9-43b3-5324-08dddca56ede
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|8060799015|19110799012|15080799012|461199028|23021999003|5072599009|3412199025|440099028|51005399003|40105399003|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MXQ2XTAbmSJVaXd5r6zIDBTvHapTgaWDn+3wFmeEgfBFw5US91e2Hi9sckX?=
 =?us-ascii?Q?vi/RjKF81p4tjnz7BnQzblG97U0UmU/sBpeswz57zK690Qhzc+XNoWbFAAdk?=
 =?us-ascii?Q?jJTHBgpRV5rkvYeYMuLXCzhnsNsdqnbrokR9i9u6P8TB/u0RrscFYJSqzOh3?=
 =?us-ascii?Q?yYkpqrb91h191rPLHkILqxeixJv+89W1gLXiwrTUNdnv6Qk92RGe1Ab/bXjE?=
 =?us-ascii?Q?gq6nRe83W0sgs+6SOBvc1tWBUlGF+iqzfFfjsquirdDqdf9E+nnksjnrixiC?=
 =?us-ascii?Q?GRFaDrq0lFHhS53mNWTn/1sSD4JO5M/iBFOPMOYQnmzVVUbDglVxWKFI1Q+p?=
 =?us-ascii?Q?k1+wGZXeDb3t9la4JeAHs2y+WPtziAGPUf/0Zihxp5zoY8Y2HfLcm1WGQfXz?=
 =?us-ascii?Q?XS9AcQqqHGkqkApy0Q7nfDLHFr56CylBgu1j//HocZUSg62PT+DLYKHw4DA1?=
 =?us-ascii?Q?+aEXQJgdamDuqPtZ3V9ZLZBoePZrtYomSlK/ejqROlinMtkPA65ofDwAdogo?=
 =?us-ascii?Q?lJhMWaGefXbkPdMO+LaxWmhfltPLiGRjWTf42LYb7sKU3qPmzO4yL7HE9PAM?=
 =?us-ascii?Q?J1g/WaLxFwayrDquD+rLhmDYQKUsaFZ8+8VM2xVtmz4MosaAhKqq0A10IJBU?=
 =?us-ascii?Q?QKdQRfvAlXEoxgClEAv5oY+QmPBHkqdvaV0UcnBdzBkTP/yrgaO+l9pLGZ5H?=
 =?us-ascii?Q?PIVg5pGa55BJlAX4dPnEHX+qMvzFhdcQQNkmkx9c0yADBlvV3ePpIvDVdovI?=
 =?us-ascii?Q?QOyi+V2BF4ZVqroBrig/PfjmyMwR8fl7O1ze8nmcIvHvZj50UB6umpltb+7C?=
 =?us-ascii?Q?54pIY/X2ekVPqbKZylEkxHDZYmd9zkoFkbettkd+afTp+Zsab0l6SPIOO5q/?=
 =?us-ascii?Q?WAN21dlU7uEOM6lmEscvJzfTV+EBO+4BG8YyLS0E0xf9RzX/WXQwT4D0jnZA?=
 =?us-ascii?Q?/BxS3ISGzyGgxKnu3AHr/psu5qNInJVvNUGTZxxnXihoLvjSyQ39F7sA/EYy?=
 =?us-ascii?Q?JfOYkeCJp9f7Q+1QTJnzwVOhlievESHts9EqiDwzC812ZytjWO9PZEbKqSsb?=
 =?us-ascii?Q?O/8ubZ10LewJqdLK+sC19yRFFgrnD3d9ZrzU7X2MdDc/AIRElM1o5gDjUuYi?=
 =?us-ascii?Q?vL1gPNktYJZZanFrqw3WMJqOLLqCxaytTW6xw/G9w1DNfZ8x6444wtdZMnS/?=
 =?us-ascii?Q?ttIZuSbDPCFkzKsztceDHBCfp+7MqafFMAiEQobMipXbJ+B6+8z+we0yiXI?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUymrOUudWP7UpyEZTOr7UZ6EO7lvljNKsi9uoz8wwGzUBa/NBisPXJun0mr?=
 =?us-ascii?Q?UsnYYQW6gEJxeYRBzX5M/Lx9hCO+nXdRiK3MsPkRPE43WbyQFqmwjTbg8ZgR?=
 =?us-ascii?Q?50iJXlp8ToUSuSjs3Yb9aGhE13SAX3fL8IhvxwPy/DpGNGxRPcBHqv0gvL2g?=
 =?us-ascii?Q?ESopmto8RdvVVmB34xznskIGpL4oK02TnuoIPh3oI6rsiyjiZ86r6zYsIcke?=
 =?us-ascii?Q?RYigMFvqqObb4tBC/xzih3TQD23DGLf4eXA4Ylv/7JXkGdOPF7fAKFt8z2VA?=
 =?us-ascii?Q?Zxqgc7ttpvsN0QOU0uxEtrEWyUBxFFHAInlEny28jekfN2lC5tTEaGl4/MD4?=
 =?us-ascii?Q?PSqeDX2UMKnwiaNZ/Bc6XAPZBS+WIRrmuo4qz12BFwytaJlGanQePPew9/hf?=
 =?us-ascii?Q?AcULXsGJbCAYw6ZcMZQl/thk9I4nJ/NNSiWc1T7GW8Gcxl34+mL9Hf/QIe81?=
 =?us-ascii?Q?mlkfapy3dqiG4fRBqFpNNc+maaRzMOmIqOfr9pzj6vkA/xmQO2OLVFyin0gQ?=
 =?us-ascii?Q?J3OxZ2kaKa7sj3ZagBkMDd/nIK5OJ12xHnA24ZargvxZnLgeqzoic+WLKhy7?=
 =?us-ascii?Q?Ff3woqnuGK6ejmmy9gPDQkRrSbo69NEtEt5PAxtm3uXob4dmRTAjqCwRtc1p?=
 =?us-ascii?Q?GydOa+Vkvjbm8Gtz93egQr83S7xoeFPe97oo9d3oYovAXq3/aSj6aUw3qBFX?=
 =?us-ascii?Q?riguSRYkX9ka1IbO3E5vvMzb+/R17If4QIzMhHdh6Lj00DozP+p+Z1CKlfBZ?=
 =?us-ascii?Q?qXU1LxvCBypEx/jB4PBat0ps2Vg9O/Tn80swDfC456eOBPY3A6D0MojGCmEm?=
 =?us-ascii?Q?MduRAemf+pF3+lEm9slmRGb77qmM+oO5byT/tQFoZDRPAE8LaRzNbJ0eF09b?=
 =?us-ascii?Q?H9bJ90El2j6RRVc9W3m0mHvznZXclwRoEE6ZO90sHtiq42I7DpsA2KNHXd5l?=
 =?us-ascii?Q?ez9OZUTUS2WRK+LlT7P8atzmpIJODZJMiCYkh2YaD7qx0JYI6bxEuL9+RIG/?=
 =?us-ascii?Q?9ytpnjh+fVkSq97ZI7qLsUkf5dDcRGbFiyo74SecygKMYmr92kkTFSKf0fE5?=
 =?us-ascii?Q?Bi1EVCPve4qLuTxKc0MjkhUFX4kwbzturfbbQLJRyK6MP0j/QE1u8mlEF36x?=
 =?us-ascii?Q?gdztpxL4i/PdwA+60jha8kmYsMVDjyL6rWPNxWqQA6Dnb/04qWH4BdAqlmAC?=
 =?us-ascii?Q?s/BbmQkBRhBO9q9VkdH68yDSMsI4VEPoRjj24KIewrBdx6CguJ6QpkI3LKs?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e3131c9-7fc9-43b3-5324-08dddca56ede
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 09:15:24.8146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P250MB0552



On Sat, 16 Aug 2025, Christoph Anton Mitterer wrote:

> As mentioned in the other thread, IMO it sounds rather brittle if
> aliases are considered at all in scripting.

How would they not be considered? There is no --ignore-aliases option 
(because it would currently do nothing usefull), so git doesn't know if 
its called from a script. And if we where to add such an option, existing 
scripts wouldn't use it.

Best regards

Matthias
