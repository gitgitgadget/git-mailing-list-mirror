Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010048.outbound.protection.outlook.com [52.101.193.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77022848BB
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 21:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764971813; cv=fail; b=MNeAcaUr20goBnlHb9HAM1l1U3X0COQnKi66cJ8bn7abhYd4iFaadqpwEUwvbPI5Jeljn4d7OUM3vtOR00RYD7M8O/wRR5HAqT/xekDysniegFJG3EZZlijA0ENWsHNLulKiVjdLCOGYxioQkBm7z++BQu0Ins2f6qOghf0r+4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764971813; c=relaxed/simple;
	bh=+gFhhQZBTQOm0gC1Wy6EiP72YVEkeDm7nrTTEy4YBOY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OxFMUnGJ+o0bJ71CUISvTnlY8ybT4r1Ya46dLnrb4vGkFLAWBtKmVVsPY7BW9UURiQ1DRt7RE24oUxikk8ZR9HLkxYX+oZAtqjG515g0RPGPUVA6/Ez/5RTUcvB4EM37Em968dkLpdHg2VrwT/kQ8N2SPp/6CBa8GmHc+x2NR8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kj85OeTs; arc=fail smtp.client-ip=52.101.193.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kj85OeTs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLlH7xI/MdqrxJozNFxdyl7qc3Pom4jspJsKRpFkC8CKdDE95UkPsxuiuqPePARkd1q8sJWbqVq0UpHn7M0UJ4zz46fWr7s1aejJI++cNyGsgEhOxJTfPk+VvB1nRlRHfJSdYsSQ3BtxyjJzvjiCszuDD90YbGJnChSpjKKBSM3ctkeNKImDkjc7uTbVWQWDh+0unPzOb0KD1AhOCHMYVlBSxTt9mw/1FlSDvzOINllD3OJsZZlKefjt08QFbTeUVfEPPOfV5tFJhQfFeB4r1GNu8jAPAKgSp0RkA5Ibykl1I9mkpuKZiQmFtnfeSs7DcHeG+uFWJyXMFlTteYqmGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ioUQCI+l4DfEm0z1/rKFQ8jFk40rknUpcpY2cngvWU=;
 b=KpticXHkMS9jGhYN0+InE803hNVWv7GiP8Knbw3ke/EAQAZUMA7I/PFYcR2ftLZddKC87R1yyLlfy8jYqKJKxzTHnr86F/aq/OJLE9Xucjcc65aV4ORDvyFMQ9fxwYdvgptsq7BWImj1RlylZPeYlPvghVIY5XbdhUwbOXl3fUVvgnMdrWuyLq8WDOeic85Z4cuhKSSXwFCSDl7Jgo0pFAty5XOlDFVDbD7h2GLzExWCvMEWtfPv1xBUhz4geJHEN5e+dBSezfxzO/MQB8vC7de/GYEtbm4d7FI9JBGdNuOqcTqysGV/n/sA8In3d/5R/5y3lScFe4GpaGziZ1oNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ioUQCI+l4DfEm0z1/rKFQ8jFk40rknUpcpY2cngvWU=;
 b=kj85OeTsJv5qKMe9/Y/FPqbZ7o+h40oYMm+IaDCtmox83d0lBVeY01PUHX8pnYpS+B8f8EliGmLcEF+ewxNLeExfjrcz86eLzAju/4awIC7U/W9353UJwxSVjGC2Vnmxy0ClMHJqX7ImOv3Qh450KxFNEeXb6aVoClwzC8AjpjYr32n0RSOcR4Y8tYwflPxKE5BhNAJNhiYnNOjoJcXT1WsGFZ6hbDzbU8PYPPae1+2/WVuCaqKRLeb1ch6M/fDEFvgeM6qmjEWQdH8SC4xZCTUy6hMG3SVzdfQNynXBJ42fq/ZQKejDv99kpbEtmWftC7H6rdwHvnSoTwyR7dnb6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:56:43 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 21:56:43 +0000
Message-ID: <4bd18399-26b3-44cd-93a7-8d2d32bef709@nvidia.com>
Date: Fri, 5 Dec 2025 13:56:23 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <20251205174854.GA18566@coredump.intra.peff.net>
 <20251205180106.GC18566@coredump.intra.peff.net>
 <235d80bd-2516-47f9-958f-0e5a16892758@nvidia.com>
 <20251205212839.GA35153@coredump.intra.peff.net>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <20251205212839.GA35153@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0047.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::22) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: e22ae585-96d0-4968-717d-08de34492d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTl0akt4SThvWGF5cDUxb0k1NE00WE9hMTVNVkN3c1RVTWdzK3BnK0Q4QjNJ?=
 =?utf-8?B?dDZTc0NMLzVQblVPRnplaGV3SnJSczJ5WDdma2g2MXQ4MXo3aDZ2UGszZ3Jl?=
 =?utf-8?B?OTdpN0Z0MSs3dllaZmdVdXhJbUNRbGhYUDNxa2pnRUxqcC9kTUJjZUtqTVRx?=
 =?utf-8?B?a2psamRIMW1IYW1NeU9Gb0ZxUG81a05mdEM2L0JkSmp0VG5qMTAwQi85dW16?=
 =?utf-8?B?SVF4VjdmcUdJb21uc3Y3dmh1bDRyT3BBY1lDNkp5cmtjYVdOcGZacGpNWktq?=
 =?utf-8?B?QkNHMDNqdlRieEJ0dXNQUHpYRG5oMTdSZmJjVEJrSjUxMWVXNHF0Q1Q5YTRR?=
 =?utf-8?B?UWJGVlZLRVN0R1hWaUtTajlIbzBZcDJrZWU3ZUFLMi92SE12THMzdUdacjVx?=
 =?utf-8?B?MXprWnR2UUFXK2FwTXRYVVIrS2pPVlgyM1hsQVI5NjdqUWRNTCt5RDdPem85?=
 =?utf-8?B?Vm9YVFVLcW5RTlRDQmwyR2pDUVFvRENVYS80ZUFBNHJJK2N1K0N4aTBxbzdN?=
 =?utf-8?B?STBPU3ZsaFVNMWNtdjhGYXZsRERaN3B6QWZpZCtpTUZHYmtiT2lIbG9tMGZk?=
 =?utf-8?B?V0YxY2N6MnJKc2c1d2RpZWVNbm5aOXJNRUxhK3JoOHAvQXk0L3RMTzQ2dFkx?=
 =?utf-8?B?Kzh0MUFMU09ZejN1VGtCOE9MK2ZzL2QwVkFHb0JyYzVPdEw4R3hzRG5pRHVw?=
 =?utf-8?B?VlZVcmVla3dDN0paaTlOUnpodW5TWVpMRzNFUUVqTzU1aXlOSWJucGIza2tu?=
 =?utf-8?B?TWlJL01ENTQ1R0h0cGtVaERBTXVyQmxLZTdjcytvZmlkSGZROXBkTDgzUG5D?=
 =?utf-8?B?N3AweE1iWm5MZUJ3MThNNlFpZlNhRU1lRUtUY2Y3cEdSNElmZU1sWE15NE8v?=
 =?utf-8?B?NTV1N0lmV0xFb2srMjUxU3d3QXZIYVFTeHpMVHJkY2pobExQeUl1Z0tlbFlT?=
 =?utf-8?B?Y29CWTVEMUVFbldRSk9BVXF3Skh4Y1pIa0Y3RFFBTS8xbVRDUHJqUDBGbzBS?=
 =?utf-8?B?TzZocVZTWk5HekZLN2Mrb2dhZ0FiUHdlVzFTTG8rR0VsSGoxQTV0YUZYVzNU?=
 =?utf-8?B?aDJudEJlTCtZMkpSc2tjdk1hVmgxREhETlNWcWNvRmRobHRvem8xc3hXenJV?=
 =?utf-8?B?ZHpWRUJOcGIrbDBKcWxYTnAvd1FDR3FDbEc2c2dKWWQ2VnpKYXlhL0xwTm9t?=
 =?utf-8?B?YnJPRXFhZlBId0xEUnlTVEE1eUJIZDZiUjNBWDVRZWcrdHBtcjBWbUxLenZu?=
 =?utf-8?B?WTVBek5uQzY0aU1SZE9Zbnl6MHI2d01GZHJGSVRRRWJ6UkttOXlNYktzQ2tB?=
 =?utf-8?B?cFMzLzFZZWNMOERVdEVrOXhOSkVQL1Y0N0JSWStxamxIL1k2VndkKzlMckRL?=
 =?utf-8?B?MUVNYS9YYVJvd1JjbVliZG9Ua0MrM2ZrclVoSzU5SUlZZlNPV2w5eWFBbmpE?=
 =?utf-8?B?cE00QmpOSUl5WWVvZURrT3dYc1pJL25qSVQzL1ZGTDN6c0F6QWVwSWE5cm1M?=
 =?utf-8?B?T0RDYkphS05Vb0dRTEtQejRaejFaWU9pNXpGNkJOS1VaakVIM1AvZlFiMTRY?=
 =?utf-8?B?UG5ocEpmbHFNZ3duL2c4a0NQVDBoWCszUThFN1kyZUc5YXF3ZmYyNHNqd2Ft?=
 =?utf-8?B?Rm1YMEJ2UE5CejNTTUVuZ3BRbTd2QXQrK29NQ25OeGhveEptRXJkRWowTUdh?=
 =?utf-8?B?cHZNQ2w1bU1MMWdvY2RNdTdyeEVoY3RoN1RHM2pHUSs5UTN2dTZjNkRzaStw?=
 =?utf-8?B?QUxiZ3NIK1Z3VVhvWDdkcXI2bW84ZTEzNG1OdTN5WjNnbkM4VU1oZk9BS1RC?=
 =?utf-8?B?ZERMMHdMM2NlTjhxc0x1V3VwVWN1Z296cXlEN0xqalEyREVaNTNFMllaVCts?=
 =?utf-8?B?VUE4WDI5emY2Wm9hSjdwNDdLcWdLWUhaYW4waEdXdG5zSTNnYU95VUtjNjVm?=
 =?utf-8?Q?jSsVXDFNNaWXOm7HrD6YWeN0DTEzcDD+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzVtMzk4V0ZDU282bmZjYktpSGI5VW5LU0dpcmtlR0FuT0RJNTFmTk16YVFW?=
 =?utf-8?B?MG5waEtRUVhkOHB6TXFieHVJZDB5OEhOWGpnUFZJdmkzNFBiOC9BQ3hYWlMv?=
 =?utf-8?B?V2s3V0M1WDN1dnU5V3ZQZVRqM090SGhQbmQrdTZ2R0lRZ0NUV2JRbGxrdENn?=
 =?utf-8?B?WFZibnFqS2JNWVh0cWtLaHZHaXhLZk84clhwdkhSMnN3ZFJ6V1JsekhRa2ow?=
 =?utf-8?B?Vk9SQTNQMWNIRmNWc3JjSmFVVkdxZ1JmNlZ2YlVwSGtKb1ozRDdSSGx6SEt0?=
 =?utf-8?B?TGhPd0NRTG9MRURXTXBhMENMZlZCTHZDSVRPdzhzR1ZvZ21aT3VGNHd1amFp?=
 =?utf-8?B?TUhZQlJIaC8weDdoTTN2ekJuMzdCYk83akdoME9ycnhVM1ROL2RiRXF3Vmtq?=
 =?utf-8?B?RHlIZm1KZ3NZSTc1SURURGZHekpLaDdQUytscUhlUmcxZVc2cGdjajhIL05p?=
 =?utf-8?B?N1ZCMlhpMHNOWVBPUWNKQ3QrOE9teFkzOG05aUd3cTExKzdzL2VyajdOdElr?=
 =?utf-8?B?VGl5Q3YrSXBVc0JhR1JWTktNSFFBaUxnbFpoNEZDNzhSb3hnVVpaUVpzRGJu?=
 =?utf-8?B?WlJuOTViQy9yLzJMU1RkOE83dmRBaFhJd0UwY25neWpwQ3ZOeEk2QktYdlhY?=
 =?utf-8?B?RGdJVGlCWTdrMDFLMG03UHlkSnBLY0Y4enJQWTg2N1VvN2FyM3FZc2dJNkR5?=
 =?utf-8?B?aVJ1ekZNUEhlYmcwZTBBVVNNUy9Zd09wTHUxeUU1VzgzUlJnempoejRRRXc0?=
 =?utf-8?B?RHV5UTJiSTZIbWZuUEIyWFc4bG15TEEwRXdYT0EyTmVxeTV3MXJxRW1Cdzln?=
 =?utf-8?B?QnJGZWdRSG9sZk1aQjEwK1ZKZHRXdGZsSHEzRHU4VVorM0o0alFKR2FqQ1Bh?=
 =?utf-8?B?Ty9zRjR4VU02Wnlsb3BhZG03bDNhcGdKYzU2amNVSjR6TlcxNzhwYjZjKzIr?=
 =?utf-8?B?aldoNXFuQmFVMFUxSmR6aU9XK01GRjJWTVdTMTFrRjNUYVRYU2pjVTd6RUg4?=
 =?utf-8?B?U2hQOG5HSERzLy9Oc0J6eHhiUW1McFhUb0IrMy9UK0trSTkrZEhCWXdQb2pa?=
 =?utf-8?B?QUd6MWxubnZSOFB4WjAyUXJQUDUxdm91RU0vZWFEM0RYa0h4cDRCeXFwZkdO?=
 =?utf-8?B?bklwY2Q4MDJjZHlTVWRTWXN4MzJzbXUvT1hiYXdOU3FFUzRYUG1JdFFEMmx1?=
 =?utf-8?B?NWttTDBxVWl6d3dNdlpuWWpPcUZoQlZXbks2aStvb1gwU3RmajlCWDBFVS9R?=
 =?utf-8?B?Vk1WaUw3UFBxZENtVU5lRHF5SjR4a3QwanZpT1BFVEZOQ2QyMkllZGFpeXJ1?=
 =?utf-8?B?eU9VVzJBNlg5TTlDL210K25SbWNLcXFwTURVcEFBZnlyc2xkQW1ZUzJTR0pt?=
 =?utf-8?B?QWtwUjZadUppNTgrZEpYVkJTeTdSeEtrUWRiTFRzYWJlUTZ0d2RIREtmVEVV?=
 =?utf-8?B?SWwvVXlvNkxNbEFDdjlZdnI4RHgvL3pZbHdMK3k2bmhxTEUrRHlGamxXZThT?=
 =?utf-8?B?WlNNbk9pTGdEeTZnVkN2WW5jM1lQeVc3T1BMOUc5TE5qUEsyNksvYm5WbFlK?=
 =?utf-8?B?c1JkUTJVTWhnK3pqS3FOVGdhalJxa1QvdHp2TWYvZlozNkxOLzJsanBaUFJL?=
 =?utf-8?B?a1lidHAzWVczWkcwOWNrbDZ4NjhyeVc3aVBrdVZTUmZBdmZpR2VWSzVic3B1?=
 =?utf-8?B?ekxqdk92RUgvSUJmZ3BwcTFpL3B0bEE4cTFQT2NlanpuVzhLTE9tR0ptZ0d4?=
 =?utf-8?B?U3k3TWMwdktGSlpIbVpUbjlHcmxSMUhBbHBpV3NhTDA4aGhpZUM1d2g3cnBZ?=
 =?utf-8?B?VzdnaUt3YXlmRFVpTTNwellveDcvN29zSU4yUWRscTRKckY3ekwzMkE0eFBI?=
 =?utf-8?B?dnExNkJQTy9nNUNWUWt2aEpEN0NmcVJ3YzRzM1lvMTVXdjYycTFwN09Ub3dM?=
 =?utf-8?B?NlFhMDZPTFUyVUMwbTFFcmxxcU5ZVk9tUG41TlJUZXRHNjZSRk44ampURkxG?=
 =?utf-8?B?SEJBc1YyWXQ4R3B4NFg2MlF5K2FJSVRnMFZnMHRjNWRTdWJDZ2FvZDFBY0t0?=
 =?utf-8?B?dTR3WHhHZlNacTVqRUZkOXRaMVpGSGkwN25PT0YxUjRjMFRETUNZWGRVVkdI?=
 =?utf-8?B?VkJWZHk3ZnN6MHdiTDlSRjhwVjBIRUR6RTZJN2FBYmg0MFk1WWZ2VjRlTndG?=
 =?utf-8?Q?Jo4RYJ3Cc6+Nq2FVJ+lRTQ0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22ae585-96d0-4968-717d-08de34492d76
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:56:43.5588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqlg2qtuRYBx9XtJMMmnbOyJjk70vFPzIE6nIyHCEyJsnewGVG7gKIyH+rwY4v0JqWpnUjTpVWNyNqWY3BgEXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

On 12/5/25 1:28 PM, Jeff King wrote:
> On Fri, Dec 05, 2025 at 10:50:02AM -0800, Aaron Plattner wrote:
> 
>> Unfortunately, setting that flag doesn't seem to improve performance for me
>> because in parse_object_with_flags(), lookup_object() returns an obj pointer
>> with obj->parsed == 0 and obj->type == OBJ_NONE. So it skips this block and
>> ends up inflating the object anyway:
>>
>> 	if ((!obj || obj->type == OBJ_BLOB) &&
>> 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
>> 		if (!skip_hash && stream_object_signature(r, repl) < 0) {
>> 			error(_("hash mismatch %s"), oid_to_hex(oid));
>> 			return NULL;
>> 		}
>> 		parse_blob_buffer(lookup_blob(r, oid));
>> 		return lookup_object(r, oid);
>> 	}
>>
>> I was confused about why the check was structured that way, but reading the
>> description of commit 8db2dad7a045e376b9c4f51ddd33da43c962e3a4 cleared that
>> up. Thank you for thoroughly documenting that!
>>
>> Are OBJ_NONE objects expected here? Should the check be
>>
>> 	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
>> 	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
>> 	    [...]
>> 	}
>>
>> ?
> 
> Yeah, that feels like a bug to me. The idea of that conditional is
> "could it be a blob?" and obviously OBJ_NONE does not rule that out.
> 
> I do wonder how you end up with OBJ_NONE, though. That implies somebody
> created the "struct object" but without knowing which type it was
> supposed to be, and then did not follow up by actually parsing it.

If I'm understanding correctly, this loop creates a dummy struct object 
for every object in the promisor packs:

	if (revs->exclude_promisor_objects) {
		for_each_packed_object(revs->repo, mark_uninteresting, revs,
				       FOR_EACH_OBJECT_PROMISOR_ONLY);
	}

Backtrace for one such object:

#0   create_object
#1   lookup_unknown_object
#2   mark_uninteresting
#3   for_each_object_in_pack
#4   for_each_packed_object
#5   prepare_revision_walk
#6   cmd_rev_list
#7   run_builtin
#8   handle_builtin
#9   cmd_main
#10  main

Then the is_promisor_object() loop finds these dummy objects when it 
loops over all the objects again.

> That's probably immaterial to what parse_object() should be doing, but
> it is certainly a curiosity. And I'm also not sure why I got good
> results from my rev-list invocation, but you did not. Weird.

Yeah, that's still a mystery.

> I think we could probably proceed without satisfying our curiosity here,
> but if you felt like it, it would be interesting to find such an object
> that is fed with OBJ_NONE to parse_object(), then run the command in a
> debugger trying to break on the original create_object() call that
> matches that oid. (Or if you want to be fancy use a reverse debugger
> like rr). I might play around with it and see if I can stimulate it.
> 
>> If I make that change combined with your PARSE_OBJECT_SKIP_HASH_CHECK change
>> then the time drops to 1:58, so that's great!
> 
> Cool, though I think that's about the same that you got with your patch?

It's a bit better than my patch and yours seems cleaner. I'll put this 
together as a v2 of this patch.

> I was hoping for a little bit more from skipping the hash checks and
> commits, but maybe:
> 
>    1. Your commit/tree structure is dominated much more by the blobs than
>       the linux.git I used for testing. So there's not much extra gain to
>       be had.

That's certainly possible. Let's just say this codebase has a lot of 
cruft in it. :)

>    2. You didn't have a commit-graph built.

This repository came from "scalar clone" and then I created a worktree 
and disabled sparse checkout. I didn't do anything special to enable or 
disable commit-graph.

What I do notice is that usually, a `git pull` from the server this 
repository is hosted on is fast, but occasionally it hits this 
pathological case. I was using git-rev-list as a proxy for what git-pull 
was getting stuck on. Is it possible that having a working commit-graph 
is what avoids the problem in the first place? I'll admit to not having 
a great understanding of how the commit graph is used during a normal pull.

> -Peff

