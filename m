Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154F9242D64
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751627898; cv=fail; b=n/CeoqTLmrUEHbyc04dJD66nOdttCfHqI5XEF2NeNhGnka+bzyL0WUA5xoHGu0Yvzn8I96OZXvcLfMZWflYH79uej4ZE7p3xMGyhMFKCPNxq1qXJ6rHZl6Bq0rUXzzmQIp7j4nrzTohXumeD7zGtCtIYixtnKsbwqCt68wwCan0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751627898; c=relaxed/simple;
	bh=RmaABkm2jfUNHz0otYRYqKswiyw4MinbeuawzZGS/w0=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=CBKuIhS/O98VFPiNKdYvvjGD4xzD+Mln6go81Muoyu2XzKoQsos44ib04gK0/L+NT4WNu2pY0zU5wNpijy/6z9Fn4eVMW1sS2VAnMBDW0YrYC1RBcU3KTQmvWvUGTE3PmHkKuMCqJ8TG51AdMZA8vZKKR8CaZxKrIKiiC7Vlh+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=uPeJwJWY; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="uPeJwJWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkRVcZ139aiCk0iqX6m+IcBT6NYOsagHX2N2QjSX1bANl0K+L67xSJeiaG6zZlaDgtzt//xPAowXths+SQtgy6ZqmVWjIvb3F5PSMcVjt61esXN/ke1LEPhQ6iI5G+t40z0W8KrRxMh6X1dj5hVRI6VVXMp237wOtOl2SA9L3Akpbuk4cZUyED4pRyo254Meqmmnjfayoe5pBxLyNNWzKYnzvabT545JfQvzXuEMh9kSjjSk6PQFnsT3m74CwrXBI7eRw9vsDYP/Q8ftU1NtVUrc/BV71AfalGbEDcmpehyLrcYaaKoZx/sEZ5no/xENvzRQx/Dx8+IketyK5C8KOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lB9dyLlhlWhSYokHUTrmlqUsX1MGEs/c3sup0kLS638=;
 b=b3H1FQtX909a4xhm/eLMhdRTomvKR0xnR+BxcXNtkKseudjk2dmX4bh3/4kVktSVjOtS/YlbOrGHXt4ndXtbMcfb+ZBjygaIJ45gvJh55sWZUewLGBvdg9el40EP0JUm6mfAlJZ7UOGxbh7kGc7r/xZh9sRKtWmn9UeV1hD+uFtlGoPeHzlwzYe7R+WOz8lXW+G6oPGuiKodoaMHVtuhiOeuqIWjsVKCjmwbMXSnhui/QOQ+dxXnz7gG6fn273Hm+Zwr5BoE6yIVQeSFfNQx5C8x+g1mpoMjlC34xJgbfzmi6zb3cfuOyTxycQHYPFxF25ng3ZwD/UoZbFRqj7hLhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lB9dyLlhlWhSYokHUTrmlqUsX1MGEs/c3sup0kLS638=;
 b=uPeJwJWYaGefyAIj7JEf+6eZ8nvStERZky6qd6sUT1yu2WD/uLida9ad4ofiNwc35IXWRxnLCBwGULjucRDlaxEOofyz7V59Lg9q+6wkC46ktFiZTl6kXUeJX9eaMQlmL4HTs+UdQdfMwAxiDMhQONa0QSfu7fhZHY2oeWlNdP3gsnKQnct96g8A5ZLqdQ7zoPH16C54ETuMLgMCkN5iz6QrMa0t1deh/QfQmyqzXJ/v9rvVykBKW9D8PA/u3OeIp/Hp0JafLCECxsyxKkuGxqdnaTIqgXsnl1mzgZ14RiHVgO5sVHL7Z9ATUIkknTQYkjxz3Na+C11315nnqL5jUw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPF23F8E8F71.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::50b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Fri, 4 Jul
 2025 11:18:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 11:18:12 +0000
Message-ID:
 <PN3PR01MB9597524FAEAA3B26B15804B9B842A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 4 Jul 2025 16:48:12 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@live.com>
Subject: Question: how will sha256sum be implemented in git
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0012.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::24) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <d8d36583-0683-4a29-a603-59ab87033201@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PPF23F8E8F71:EE_
X-MS-Office365-Filtering-Correlation-Id: 77ff170c-7b76-4d93-848d-08ddbaec7683
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|19110799006|6090799003|8060799009|5072599009|7092599006|461199028|3412199025|440099028|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3dKRkRBa3poZUZ5MW5UMEowaTRpK1MwWVF3NmM4TDgyUDJ3S2lvdk5TMzNl?=
 =?utf-8?B?WTh6citBemFVYlVIb0g0d085aXV0cnh4anJQdmxSaVJJV09sbUZpZVoya0E5?=
 =?utf-8?B?azVPYVA1UFR3Z2hFWW1JTmlBRTZmaG05Y1FTWkI1dEhLemZBUjZzbHdNc0Fz?=
 =?utf-8?B?QkJZNFBpcjJjMnNDY012QUIyQzBCNkhYSFJXZ1NUK1diYXN1RDhweGRjQUI2?=
 =?utf-8?B?ekcwZUR0L3F3V2ZHMm11Y0JGR0hnV0FBdDVUUTQ5UzdVL29MaDZ3clR3Rkxm?=
 =?utf-8?B?eVRIb1IxbFowcjBnQng0WjFzNlNoNFFpekFSQ2phbnhvZERDWDIxMUVNN0l3?=
 =?utf-8?B?c0dTMTFONnpvVmplcTNld2lxV1pMblVqL2wvajFhVEFOMStIMXpWV2pKNk9x?=
 =?utf-8?B?K3JWYURBUHhMVFZnaUhidnExOGlZa3lKOHNCNWRHUW8vZFBLa3BVcmh2ckUr?=
 =?utf-8?B?OXFTWVBta2RTN0tvREVoQ2F5WTIwT3VDbzdodDZsaXI4U1dUNDYwY0poZ2xP?=
 =?utf-8?B?cE11Ylh5QnV2dG00TFoyeWVQYkhaYmR4ditocWloRmRPbmFDUVJWM09HMnZP?=
 =?utf-8?B?enEzV0FtTUNDUEJncmgySmppTUo3b3JMME5wQmhGMjR1TkZGRk5lZGYzM2Z6?=
 =?utf-8?B?a1VpcVpFMzI5bGMySmwrdHZpMU5uRXlLWCtCeS9aTDJzL01qS0R6OEtvRHcx?=
 =?utf-8?B?R0dSd2JWUk42UG93NVR5ZGZzaWFzdVlsbVhxTDZNUy9jR3dTTFlWLzR2T29L?=
 =?utf-8?B?UmRDSUlWOVFlK0lnSENjU3BoYTAxOGlOVVROVHY5a3ZxTlN4bThqWjFXakNy?=
 =?utf-8?B?K1R1V0pqUjNYMjM5dEdaRUZMTlZtQ0Z1OUhNeno1bDdzZkJudHNQWlM2ODBF?=
 =?utf-8?B?NVA5NE90OEVySVRoQVpLYzA2d09oUGFTKzJrbEdxUHZEa2hDS2pqZkp2TzRh?=
 =?utf-8?B?WXBaN1l4Y1U1SzVESlpZNWdTYUFUREFQdEVMM2ZieVYvSGcxUlhTb01nM3kr?=
 =?utf-8?B?aEwvSEkwU2hxOXBOZW0wSzlFWGVoVnRadE5FOFJYYjloZnZCRUFyaHJDcmJv?=
 =?utf-8?B?aS9vMGV6OUpseEw1YW9DcFNGUHlTZFRJRm0zdVpxTGtJMHZKRGIrdXRuRUNL?=
 =?utf-8?B?UTdqTm1nTGZUY3FmRkFQTDY3dFF6R0dMZThWS2dVRS9jeHNib1RlYVJjNCt4?=
 =?utf-8?B?ZElHL01ZSm9XMVVrdkoyUm5aVnlvbUxHdUtOUmNGeFhCbWdOWW9yZkRCWWky?=
 =?utf-8?B?Vkd6NGRrZ2dtdWJKbEViT3licVBHc1YyZ0MvQzIyMThYbmUvMm45RThGUitq?=
 =?utf-8?B?dlNTUGQwZnpCUHZ0WE9uTnZ3TXpaeHI1Z1MwdmwrNU9ZY0c3bjVKdDFGdUdL?=
 =?utf-8?B?VlpIWmFXWTFPOUZuVDAyRExvREpuVUlHbFlPNnlsSmxZWDhDMHlGb0V0b3dG?=
 =?utf-8?B?RFVld1p4dk1mVWdnNGdlQkkvNG1oUkdOYTc1OWhnWUI5ZWsrWEkxMFVCNHYz?=
 =?utf-8?B?SUR2TndWcTNpYU9jejRLemovdmRrYWdWOXUwRWJ3U3hWTHd0K1RvUzZmZHQx?=
 =?utf-8?Q?W/ixVw07EjPPdyPkkpiCjQHVU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlNYTXlqcGd1YlQ5Nyt4ZFhzWkc1d2VNNWRJQXQyR1p5RGVxeUNBK2xobEti?=
 =?utf-8?B?VmNxaTdlcnN6dndLNE9yM3l4TUVpZmpHZnRkM0FKZC9pRm5tQzUydzRZam1L?=
 =?utf-8?B?eklLYmRGeURibzNnQ05UM2VreVR5SG5SQVp0SFZGaEk4RHJoZHlUcVBjRENE?=
 =?utf-8?B?Z1BaSFpGenZoVlB3clJXNXhIZEN1c1k4Sys1Vk9md2NLeXFCbEVKL1kydlJO?=
 =?utf-8?B?bFBDV3gvTGtIbEszRVg5cFVBZVBLOWVSbGN0dktOSEJVV0dnbDNqNkUzNXpk?=
 =?utf-8?B?dFhpMXF3MlFMMWd2WEFUdyt1TVdvckI0VUV6dHFSQmg4a1NCb1VLQmtUdmhQ?=
 =?utf-8?B?MUN3WHNCcW4wSndGdVpPcVVXeldQVU93NjVrMVVmUmp4bW93QnlLcElta3Fp?=
 =?utf-8?B?a2tkcDF4aXVGdTF6ekEyWFhVSWtNZUhxNEV2dTFRTERTQU5wNUZxNFVaaEZ2?=
 =?utf-8?B?ZlVYNElKRElKQ0hwcWN5NFFjdUpSSi85RmkwOUdsV1U3RktSTm03Z1doLzl3?=
 =?utf-8?B?aEJYTVhEeWxucC8vbVZEVXlsV0tZVjRTK3ZHSGdCRHFmdjMwVnRkdUIrcTgw?=
 =?utf-8?B?M2g0SWFrOTRPeFJtZ2lrK3c1YW4yenNLK3E1dmFXY3d2NEVVakIySm80RWJG?=
 =?utf-8?B?aUhGdm5GM0hCUWJZNjFRc1lZa2FpalZ4Uk85ekRwWGNqT2VqSmZiZFJubThs?=
 =?utf-8?B?dHd2RVhmckg4Rm94OWR4UTdEcWVJZGVTUVZXZ1lEc3ovMHlkOWxSWFphWHdO?=
 =?utf-8?B?cFNseVk2ZjhLTWdXN1Fma1JQLzE1Mm9SS0ZWNEhjOW81dVVOTmZrVGtBaERK?=
 =?utf-8?B?Z0owcFovRVhyb0dDQk5HbkIyOXU2RGRheXdUN3hyckJ6bmVLVmtkOG1vVTFs?=
 =?utf-8?B?TzU3NHNaZVpQaHNuOFM4cFVhaHRBYnl1R0x4dElqWXFoeFZyZEV4czVEcUNn?=
 =?utf-8?B?LzFWUU5IeVpQNDdqM2hUWUQ0ZlhHL0VBandPU003MmVvUkd2UHdidmwxdDM4?=
 =?utf-8?B?RGlzQ3lNR0dLTDlraWhUVDlkOWlSa2JzS05IbWNoT2lVNWV1WGQxUmFnczVn?=
 =?utf-8?B?R1czNWE3K0FzNzZVMTZDZGZjenQ0VHZDR0dPeUszNEEvSCtKWTR5VGJSWCtv?=
 =?utf-8?B?UmZuZzBXbEpiWXR3MWVXMGRMd2pLL284bElLNG5DaDlQWVhETjlwaDVMazF2?=
 =?utf-8?B?RWJHRkxBNlZUQUJia0hKZmFRWUpSZ3kzL2pKeCs4N2JiaXJrejRmWENSbHkr?=
 =?utf-8?B?cEFOL1gxNXpHcnl5VnVibW9Lb1dQb0JHZTdKYi9yQWxHYWdDajJPeFp2Vi8v?=
 =?utf-8?B?TkdGdS9TUmNXb3pycitGRC9aVHduaUx2cERVWjBtSnZNRUE0VUFxaDgvQWp4?=
 =?utf-8?B?cmljMElJU2NSUCtxcnBPb1poOVZ6QmdBd0JVaFBDNmJiOGt2VVROYkxGNlQ0?=
 =?utf-8?B?cFNtOS81VVZOK3Zja2FMTzJBOU9xSFZVdGFobmZlNlNtMkZaVlg4eW0xWHhC?=
 =?utf-8?B?RkZFbW5IaUgvb1hmK2NpSEhpWCtHZ0pnYkdiaXZkQ09FNUpBOFdBbWlmb0c0?=
 =?utf-8?B?eDhUNG5EZzdCQW5qWUxWdFpHUDA4ZHlNVW10Nk9BdDYxVnE3aXQ5VmlDMkFn?=
 =?utf-8?B?OHRXV2dDVDR2RDBsNlI5WEt5VHdZU3NGa28yOEEzYVhCN3ZFYXNobUJRWUt0?=
 =?utf-8?B?TzVnUGdTMTZoQlg0dDBzdzBRWGlucjBVd0tXNXVEMDc2ZFkvdExkcldOUjI4?=
 =?utf-8?Q?IU6x9JiXejdYbUbt9LCplNjl5l2zMrCbq2gyRj/?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ff170c-7b76-4d93-848d-08ddbaec7683
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 11:18:12.3681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPF23F8E8F71

Hi all

I just read that git aims to transition to SHA256 by default, and conversion from SHA1 to SHA256 is needed for old
repos. I was just curious how will that be achieved.

Dumb idea, but maybe we can just encode the existing SHA1 sums' string to SHA256?

Eg: 

$ echo -n 8994f255af5451b6cd1db01ee16d8cf15b9df81e | sha256sum
bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f *-

so bf8d6d915848377db81ee47e883c0a683b3d86a49ab120191ea1c3d76a30c33f will be our new commit hash.

I think we can do that since sha256sum is chosen due to negligible collisions right?
