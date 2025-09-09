Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11012011.outbound.protection.outlook.com [40.107.149.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48211243958
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 08:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404860; cv=fail; b=Nk652gWDgKzL5k8/tMxYc2Jorr9mhL9139o3PCK+87Jv+F1TG5aMBsvzy5btfVOcqfM1uxmcEN6hvoFkZ52kBead7TQJtWWN/YS1rIIXrBp/mi4NeQW/MOg/keMuq0cns//WKTVT2zb0r+q90O0pz5mDGr7zWEY3Ld8e4iotptM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404860; c=relaxed/simple;
	bh=oeJGOUDacGdbS4hWPKrblpQNtEv58Jo6fTlcgh1t7z4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sew+zsB7+GEjWRJLD7RQCH5P2rRc0dqCddCd36CHtLlZRH3b8Ant5DZuYnUIwXPnOzbeNcxcBf9ImbQcfkfjwOCdhbkp/DV12ug0ilH6b206xtVsIzCBHzlY19dvZJ8oSGGTr7XGMFyHofptw4enAnrx5X5m7BngkTUAuEJGwg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=innomotics.com; dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b=TKYeHVgf; arc=fail smtp.client-ip=40.107.149.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b="TKYeHVgf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI7qkjLt/pQ9eZ0+vtnWKfOb7cB8KfF2hENyboOou4zIpBTj5vjwJxzgyQscLn+R1xMmxGiv3KcFRMuR2dzzwFfkM5K4yEE4P0h8qty9z5FWH/xGPX+y9wtL3XUuDsyrz80cEV558+VK5Qo03r1ZIq52bekbwO0je940LBsoGO/E4wRn37NavqlRzzejqNHsbzsrHwSCUReSXoOGi1N+QQAWrbpEAVmLgmrw6oVS4YrnYovZLcZXDWPqZqusfzeNVKztpdldnn5Pa94aif2DWDSBLr0EDj3QzUOAg1+LKIKIuOLJc5DtAYl2ToLB/XeqUg0cL2ndiQ4c+NykjggNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVoWs1ouY1xoRp2v1u5WMpX/mxXXyHztsmKhfwkIR3c=;
 b=Y/pdgikS+NBGEmgnbwKxBCjgwUxgbziw+8trAOuaDq/3qJYiTNxQ40kSQK/QsUIwtnb5rtHI3SnrztC6hWiQXE6kD3vMOu+5uIVW6aHoZ1MPT7rWWlLFed9ySyW8+j/74w9AieOSexzyFRtG9E6O0bMzMZgJyU+etCaphulAoC2HSYOXzyJ7ysvPbpZd1ZaIsGZv6qqgqUR4hQnof4t0hvFRl5n9vX0SAzLrltG0Jj0ECM9kaVBv4D/W8lVQ0SgJMQhuICXCAoXFQvdMwPYMSQ5HJenAP45BO/qmDU83GUI+MjqjGcbQfsllzungZlqK7c5+7RzpHntFWleoYFTXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innomotics.com; dmarc=pass action=none
 header.from=innomotics.com; dkim=pass header.d=innomotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innomotics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVoWs1ouY1xoRp2v1u5WMpX/mxXXyHztsmKhfwkIR3c=;
 b=TKYeHVgfZJ2AT0xMnmpWeeetJd0Qt7fq3bXRk9pnY+eXccTLH+dIk28oW0AhocwheIZUWA9bHN3UjaPNjJuLbVBA8dPTyFLw8tMOLqOP6ExWGwQP7WKjypj3Td4JsegaVelilUbPM8r0BJFn8Z7J+LdWk3168s5jjEu3JJ+oBB2q2GFuxHSjdgRi9dlzhq9p+ZHNYlIoeYDgqY0pN/oSVRnv1rlO5JuZaMkWoUn7y6uHuOecVDsf5pTS7vEQsE9K55NQOgUAArIFcPdJSjmFVM5DWrNa79+PA+PRiUQypSCEtwLdz2EWzERwGxpZoE9fT4Tic0P7c60r/vNAveiWPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innomotics.com;
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1af)
 by FR3P281MB2781.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:00:55 +0000
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6]) by FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:00:55 +0000
Message-ID: <50da35ac-71f8-49dd-bcd8-83726f1954a9@innomotics.com>
Date: Tue, 9 Sep 2025 10:00:54 +0200
User-Agent: Thunderbird Daily
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
 <20250905213708.GB612697@coredump.intra.peff.net> <aL_bAxZubXMOGWsu@pks.im>
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <aL_bAxZubXMOGWsu@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::16) To FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::1af)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFFBD1D31FB:EE_|FR3P281MB2781:EE_
X-MS-Office365-Filtering-Correlation-Id: ede5fdc2-b9fb-4668-47f7-08ddef7700d7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TldJTDdQell3TlpXWWJxRVZhN1hjY0hIOUFlUVZKMjh0Uk5mdXdVUndXTU1w?=
 =?utf-8?B?d0c2QktJYndlcmVGNVJXR2lzT1Z0S1dqZWp6dXlKdXdtVWx6eVkrWUowMGVC?=
 =?utf-8?B?MmpTdW8vajMzRmlrQ1huWXNhMEtreFNHVjVVSlhhTy96VTBGb1FwajJZUVJu?=
 =?utf-8?B?Q1ZXa05HVS9kTWpla2k1NlRSODA3RFJ2eDNqYVlsRHRyem1aZkxkd3lmYUc4?=
 =?utf-8?B?WHV4UzhFTmdLeFI3azBwQ1hkd3J1WlNzNGxvMlFFamlQblpoUXlMdFJ6ZlpW?=
 =?utf-8?B?V3FUNDMrK1B1dFV5eTdacG5HcUdBbGZoNEFENkxTTlJWTTNYZzNhd1ZPaTMy?=
 =?utf-8?B?VFdNTjhPTS9qaTdNZzJSZXB6aWNreVQvUFV1aWpENkliVDlXZXJGYlJhUEt0?=
 =?utf-8?B?NFpCWEJNVVJ6K1hUZjZ3eDk3dS80MVRndEdtYmxPSHBtR1dzUzlOS2h3YXlW?=
 =?utf-8?B?UGhXd2NmRklpTURid29qQ0c0US9aRXcvKzR3dTVlYnM5Zk9SSXNsWmtjbGNK?=
 =?utf-8?B?U3ZOd3N3b0krbWFRK2ZFb2xhaDZDRWJhQTZQbFM1UFEzdVJYTTJuNVQ2Rkxi?=
 =?utf-8?B?ZTJIdktSSkREenZTVXVzVUFLRXRXNDlGMHNzdzZ5b1p0cU0wM2F3elpKYk5M?=
 =?utf-8?B?OCtrS014Q2UwOVJEWEdtbFpscTdRZkk2TWk1NWc5Zm9QY0g0eS8zZ2RmY0JM?=
 =?utf-8?B?Wk90RTRMQWFxRUhURjNnMVVyeFgzcmRLTkxXbE0zQVBFczF1eS92eTVVcXdW?=
 =?utf-8?B?SzIzdzA0MmFtelhmRzc2N0xXblQ3K3lGbkg5YlFNbHdqVmQxdjhFTEpweEN4?=
 =?utf-8?B?U2V5bEQ4eFJuako5VHJjZ296Zk5rMkwzcDRTMnNPRU9IUzR0Q3pQTkdWMVgx?=
 =?utf-8?B?K1ZubUhSU1Z6OEc3NDNVYXlpeVZaZ3hveTNXU0tteU50aGh5ejhiZW11QTNM?=
 =?utf-8?B?bmZGaW9IeU93dytmZWkxUEhzQ0doOWljWWs0bEZvZHVzTndOcWp1d3hzdnBF?=
 =?utf-8?B?SmFjNXBTZWFjOWN3OG43VkNRS2dyS2grOWtaRkxhSjg5WGMvYUVsMXd1VHFG?=
 =?utf-8?B?U3E4OU9GODh3MVRGV0o5WlhPMTEybzhYUGpZaHdQNFJ5R2p0UTg5K2FiRDE2?=
 =?utf-8?B?YkV2QXE3akdScHU4ZC94OVVZUVlwRlZvdmhBa1dITk5MN0IwNWk3NE14VlRN?=
 =?utf-8?B?cTVxY1ZmOERJYzc5OUN6YVlNc0lmejhQeHhZMUt6eThRVmN3dTJUODZOVEtV?=
 =?utf-8?B?ZWltNGh4Tm9YaElhWmVlOU83U2R0WnY2NlVKV0ZYZnJTOThzWmV4Z05lMHZO?=
 =?utf-8?B?RHpwWmxSVnVoK1dDdmFPQlR6Y1Rvd2ZmYnhMT25rUFJib0E2bkV1WUt4RXF6?=
 =?utf-8?B?azNIWlpMb0tWRWlPWXU0QW9EV0xoSnZYTHY1amFWZUMzZitTVTBjTkxuVjBE?=
 =?utf-8?B?OGJweVZYaXVFdldtSnhOYnZrQVFMdTR1TmZhSFAvTndyMHVwYVBkSkNWUitu?=
 =?utf-8?B?Qm85ZC9Ob1lOL1kveTA5WmVXUVlST0MrS0kzN0NqbXV3dFM2c29BeFFPeklW?=
 =?utf-8?B?dGNIeWtVS0M5WXI3WUc4VFM3TEVBY1JYYmVQeXllVkxLMFlKeG1QUFRpWVJQ?=
 =?utf-8?B?OXhpWjROV1pvUEx4SDk5ODRYaFlrRVdkc0pFaTBjSUphRGZ0Ry9IeUU3K0Z4?=
 =?utf-8?B?NzZja3FWSTlQV05wNVpjNnJYZGZmRGZ3NnNTZGh2UXJUd3FVR01QWGJXZjZY?=
 =?utf-8?B?MGNtTERRakRyV0xHYllxZzVyRUF2RTRUMVlFUzhUMFYzS0VjZlo4RnZJVDV0?=
 =?utf-8?B?WDRpRHh2ZXFlcjFjbUZWb1Rnd1R5S3FhTjBSOGgrYnIrSHA2QkdpaWM4ak1w?=
 =?utf-8?Q?DlkXJ9qludEdt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFsbUYzTktXbmhQSGFOdjlPTllTZTczeExVUE9tc3BMdm1wSGtQY0FMQWZn?=
 =?utf-8?B?Y3kvc1NTQVJYeHdlMWYxL2tGRldxblR3RXB0K2pIVXR3RFY3ajFrUXJaZkQr?=
 =?utf-8?B?aEJ5UytDYjFVN1NkMFJOU0dWTU93S010cFppOTdpOW9pV2d5cklnUVB4OXpE?=
 =?utf-8?B?QWNaVEo4SW85WStQbXpad0srS0NpVW13Q0xTMm1HVmoraXJHZDQ4SDZ4eFVC?=
 =?utf-8?B?d051dnMyQzlDS1pyWkl5N2VPUWJLdjRBTEh4aGZvZVdVVWJLdVIvRU5zcW8v?=
 =?utf-8?B?NGpDUFp2Qk1jU1U4UVNWdjFvME5yemlTMmxMTVZqV2x1dld0Nm05UTQwSmFT?=
 =?utf-8?B?KzI5WURHQ3JSbVl4RG9yNjg5SEVIbHBJWlBSZEI1R2lnYUtpTmoydGFXZm05?=
 =?utf-8?B?eW9hdzNwZE1seHJmSEdEcVBobFZyQTRnelpPQ0NSNDJZK3UwMzRrYjR2SjBo?=
 =?utf-8?B?cjArQ2hkVHVHNVdnSEFFS2lzN2g5VjJIZmduS3o0YmhocDFKOWV2REJOd1pK?=
 =?utf-8?B?dnozdVFOaUtyN3g0V2FsL2ZyYXdQYnhMcXFGNGtkNUdPa1dxUWU1VlY0NVdX?=
 =?utf-8?B?T1AyN2g4d3AzZUI0RmlpM0s2QlVRcFlSTVJBek9zeXgwZG9hVFFneG03Qmh1?=
 =?utf-8?B?SGRWc3RpMktMV1NtOU9KK0d5NjcvY0dEdHpTeUxQcHg0b0M3bi9kZ3pUSVA1?=
 =?utf-8?B?djdBNTVqdmpHMGdKeXg3aklmSjdRRkRWd09mbllPT3NFSHp0TGpQTG9pbWVU?=
 =?utf-8?B?NUlrOFhZdTBIdzlzTm1IMDRQN1FqeWxncEd0N2JPdDB0QWxEbk9ERTQ4VnU2?=
 =?utf-8?B?QWg1Z1FVaE5idW0xd1pCSjI0UitHMGV0NHRKYUJDR3ZkTGVHOEdXYmFJYlNx?=
 =?utf-8?B?SW9CMk9KYTVtRzRWRWhPS09jekFyMndTRk5aTVpid1JHUkJFOFhrSS9xNTZG?=
 =?utf-8?B?NG9DUHQ0L2VId2dFUjlmdyt0Tlk5Z3ZvaWtOU1J6eW5KbnQzZ21paDE0L0Yw?=
 =?utf-8?B?L2VYOWlyV1Z4OWlRR24wbUdlNzBicUhqZlQ0VHgvUDZXbmdTU3ZMUkRXa29q?=
 =?utf-8?B?VHA4akMrbzdkSEw2cUk4RFBuMlZCdS9CamFiOFlRVDh0UWlNaUV3L3A3UGs3?=
 =?utf-8?B?cjZyVUpyazNQbXdKOUdlL21FTUpjL2FlN0RjNWZwQkFndWhjREtRM2tXWDVV?=
 =?utf-8?B?OWNNVU1JVzllV0EwVjZUQWcxR0JTb0k1aExxVUJTQWVpQTVkejlLRXA5Q3Bw?=
 =?utf-8?B?dUFIMXdiMGpZUWo0OGhoNEdacFFLL3ZRMVZRTmFPTE5ScDF1OWh5QlZVR3lF?=
 =?utf-8?B?WEhjaFBQYW43eHp4dEVqSTNmNHJ5dVJpYTBJeGxFMGplSU8yalVyK2xKeTg3?=
 =?utf-8?B?aFR2amNmTHVERzRkS25OTFk5cE1HQ291NFIwMTlzbVd3bHlhbFhaVFJLMFNM?=
 =?utf-8?B?QnFLd0k0OVJXV0dzMkhyT1ZUVUF0QnRKeVJCUWErUDlsRnpFNHpTUHdHTVBx?=
 =?utf-8?B?V0h3WVdlZURiOUdGYW5DWHh4M25kZ2w3S0FaaWtYWE9kNXVNdnFoclI3dDFv?=
 =?utf-8?B?MTNIcEo3clNXK1JOZzlrY0JoeVA1VVFwdUI1bGFiY0djWTJuN0xXZ0I5eUUz?=
 =?utf-8?B?ZUZCL1pTbEFzMFRkK0dsVFl2c01lc1B1ekZyQkJxQ2hNWm5nc0t0eFEycWJl?=
 =?utf-8?B?STJoUmJZR1BwMVM3U2gxMDdnTk9aZTNIaVUwZHJiYnZXdnhkcWNzdHFtM3d1?=
 =?utf-8?B?MHoxYzIyMlkxSzVsZjVHcjJkaFUwT2NCRGpWQXpTNm53YWxmZkVFK1hiR1c0?=
 =?utf-8?B?L3RTSjM5U0toUWtyRUtOT21yODU0TmJURFhjMFYxdUhqcVhVRDdiVUZkS0s5?=
 =?utf-8?B?OXJLSEtBZ00ya0Vadk5yZTVGKzlFaUtJWkFVQUFja0Z5Nnp4cTYzN1R5MWJI?=
 =?utf-8?B?L1B6SDBMWU8ySDRIVmJVVDlLbHVjTDFNTEJMbXltanowYWVnSVlUQnkxSU5N?=
 =?utf-8?B?TVpkSGYzZllWd1UxK1VqdWd3a1p5QXZZTElxbk1MVXovWU9HOXNQUG5pZDgz?=
 =?utf-8?B?RVptY0loMjdXVkc2b3lIVjdHU1ZxL0QyVmttU25XU29sc1FsajM2QnRxVHA3?=
 =?utf-8?B?dS9PbjFHL0daRDY1MVZSb2JIbm1yTXIvbmpFcm9OcVZ2VG1vU3ZWbDkzenhL?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: innomotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede5fdc2-b9fb-4668-47f7-08ddef7700d7
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:00:55.2816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 698c6ffb-74e3-4a84-be68-f22d8d3201a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgQqnnqlbpyLs40IKzOSiTlpU8Z9EuUMLzd11SWGvvDUWkEHXd4Ah2dLY1yvtciBzNi/pddiyt6XviAjeBzL8+fAq+ea3V6EvwiN2QV5joc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB2781



On 2025-09-09 09:45, Patrick Steinhardt wrote:
> On Fri, Sep 05, 2025 at 05:37:08PM -0400, Jeff King wrote:
>> On Fri, Sep 05, 2025 at 03:19:50PM +0200, Osipov, Michael (IN IT IN) wrote:
>>> diff -u -ur t/unit-tests/clar/clar/sandbox.h git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
>>> --- t/unit-tests/clar/clar/sandbox.h	2025-08-18 02:35:38 +0200
>>> +++ t/unit-tests/clar/clar/sandbox.h	2025-09-05 14:10:52 +0200
>>> @@ -2,6 +2,8 @@
>>>   #include <sys/syslimits.h>
>>>   #endif
>>>   
>>> +#include "../../../../compat/posix.h"
>>> +
>>>   static char _clar_path[4096 + 1];
>>>   
>>>   static int
>>
>> ...seems like an obvious improvement. If we are compiling any C code,
>> we'd want our compatibility macros, etc. Although it does get a little
>> funny, as the contents of clar/ are imported from elsewhere, and now
>> we're modifying that.
>>
>> It looks like clar tries to handle portability on its own, so I guess
>> another route is for it to add its own mkdtemp wrapper, and we'd import
>> that fixed version. But it really feels like we're duplicating effort.
> 
> We're duplicating effort indeed, but that effort benefits other
> projects that use clar.
> 
> In any case, we already have logic to detect whether or not the platform
> should have `mkdtemp()`:
> 
>      #if defined(__MINGW32__)
>          if (_mktemp(_clar_tempdir) == NULL)
>              return -1;
> 
>          if (mkdir(_clar_tempdir, 0700) != 0)
>              return -1;
>      #elif defined(_WIN32)
>          if (_mktemp_s(_clar_tempdir, sizeof(_clar_tempdir)) != 0)
>              return -1;
> 
>          if (mkdir(_clar_tempdir, 0700) != 0)
>              return -1;
>      #elif defined(__sun) || defined(__TANDEM)
>          if (mktemp(_clar_tempdir) == NULL)
>              return -1;
> 
>          if (mkdir(_clar_tempdir, 0700) != 0)
>              return -1;
>      #else
>          if (mkdtemp(_clar_tempdir) == NULL)
>              return -1;
>      #endif
> 
> So that raises the question whether HP-UX has mktemp(3p) -- if so, we
> can probably fix the issue like this:
> 
> diff --git a/clar/sandbox.h b/clar/sandbox.h
> index ff43159..5af36f3 100644
> --- a/clar/sandbox.h
> +++ b/clar/sandbox.h
> @@ -164,7 +164,7 @@ static int build_tempdir_path(void)
>   
>   	if (mkdir(_clar_tempdir, 0700) != 0)
>   		return -1;
> -#elif defined(__sun) || defined(__TANDEM)
> +#elif defined(__sun) || defined(__TANDEM) || defined(__HPUX)
>   	if (mktemp(_clar_tempdir) == NULL)
>   		return -1;
>   
> The `__HPUX` define is pulled out of thin air, I have no idea what
> preprocessor macro that system sets. But something in that spirit may
> fix that issue. If so, I'm happy to fix this upstream and then pull
> the latest version into Git.

I can confirm that your idea works and much better than my idea:
root@deblndw002x:/var/tmp/ports/work
# diff -ur git-2.51.0 git-2.51.0.patched/ | grep -v "Only in"
diff -u -ur git-2.51.0/t/unit-tests/clar/clar/sandbox.h 
git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
--- git-2.51.0/t/unit-tests/clar/clar/sandbox.h 2025-08-18 02:35:38 +0200
+++ git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h 2025-09-09 
09:50:07 +0200
@@ -128,7 +128,7 @@

         if (mkdir(_clar_path, 0700) != 0)
                 return -1;
-#elif defined(__sun) || defined(__TANDEM)
+#elif defined(__sun) || defined(__TANDEM) || defined(__hpux)
         if (mktemp(_clar_path) == NULL)
                 return -1;

Can you make that happen upstream?

Thanks,

Michael

