Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021118.outbound.protection.outlook.com [40.107.192.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADD11DB122
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 17:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676487; cv=fail; b=MXGlu87zQK1wgJMJFYImM1x6apl5s26Vb8puolUif3/w2eVv2Yv49HJXTQ2LxUlFCclQXdb+SRurvedC1DSBlOLb9VFrZKWxymf2eJb4pfcjnU+JIr+3oktz1wq2a9OmNckOXrYqLolzj7zk7Pgp/EyMTdqYW0GIVoCxYY1OU04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676487; c=relaxed/simple;
	bh=qVnvKPQ0eLq+PM3vdVZtAVRoUze1HYTRVsYWPzJw+RI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MdAazM3Y6oy0zv6wXEIsIbXHHlygzvGKxYom+OFU5A1bvSnd6zlOJPY48YCsD9PHxdJoEEwi/4sS0Yd2daE0g/akd7UjlMGKmiBaqy15ny/4SjllA/I5T3D7J/XYClJq1D4Ko3jJilhTU+sR+mkJJvhZfP5ranm60bKZCOJezqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=gD/3/FPq; arc=fail smtp.client-ip=40.107.192.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="gD/3/FPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7Rx4AoQ5F0ZsUJ6UmN+QKCgekToqTQ8Dh3UBPhyYew5CKCfKQDTOQK6tiwevbCd+el0P2aO6Xz4NrZ93ZKnY0SVRylFactrQDTtK1EQDmBXh2B08UvWlcX9g4Mub7xHbqnCXIds0bYMPKzaqmZho8dEr/ZfmmDcSV+2RrxO3WHklUQiQGAeBFyoM2+mDQK8B0Y2KsRvNIKYxFTbsrOgyQ5jnvUZbGxyswiM8SBLpWKE2CSlBmjBt0IG75YA6Q54v/YSF7uhJ7Div3GvrbvFSM40G6RVOr+O5FQNB8h6KncY5zCgr9yqWX0aHmBo8/I7l64hWKmPpGd9wLxXfcD+NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmbrjbvlHkccjn0yJO7L50+Kk46dXB+Ll3Z3WvZBqXw=;
 b=P3/2c9YkVwJhjxyfLkDMrBd/35AIG2rXx1N8szysfzD0yMUPgFKMDnU8EsSHlVlsqBM0OACDpvQv7vfrhFmGgnlZVIZxUFKgFRoHv6VJ3l7nVnZEUDLE7l7it1YmYch55iCd7ovb/MR+OrDiKSZX3ZbANC/HyIbD5yifiiKRIrZal1kwb85QBn2vywLbLgoaqyJ79lxc9LupPXVyK24kinR/nvjyACZF7qTilhoRI5hI2/5ZyT0E0U+7paXyHpGtJErG67CHtEIA+wAOyVzLlRbZGCPY1hiXjJ2uCgHJTZFSLr5R7NhEDKYTbGn1th9Q68ZG4Hmp9Fln0QptKBZ3tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmbrjbvlHkccjn0yJO7L50+Kk46dXB+Ll3Z3WvZBqXw=;
 b=gD/3/FPqA0QGtibG0qJv2fC2L2HQnsYF4maxwJqkeLpHL/2kHN37uloOmdiQeR1KloqTNYyv65vI6U71iLj9LrXbM/ZiB+zQdN2b97vbufvU1YNbdEh9JpbQGXAHyU14ZvQETh1Ai+/XPd9Ybv2WGgb1cH69u+IzvN9Lxzsd6ptq/rYB4moSsZldMIdJehFYBaicY5+by7VxObpdf/ufaSQQc4OCfmQak7na2Gx4VBkvf+YstAnpCXK6QcLUaD2PSYU3ucuA4uTdUgr0UWyK55CpA9qZhHaGngkjIaHrzBIS39OACR4KYPiUG0655M/DlXprBn4ovEt5Rqn4OjOadQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YQBPR01MB10885.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:92::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 17:14:43 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 17:14:43 +0000
Message-ID: <18ed50b3-e5a4-43b3-a543-f9a3d2c309e6@xiplink.com>
Date: Thu, 27 Feb 2025 12:14:42 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: General output formatting
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Yaakov Smith <Yaakov.Smith@wisetechglobal.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
 <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net> <xmqqplj49rul.fsf@gitster.g>
 <3a58720f-a572-4e3a-bed1-cc7e8f46e3c7@xiplink.com>
 <xmqq34fz9v1n.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqq34fz9v1n.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::7) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YQBPR01MB10885:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5bd84d-79a2-4274-d644-08dd575239f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnFvTEhoM3F5aFFCWFYyWFJjUE5mNzdYUzF0TmRiYUVMUHJuTmRUU0U3T09Q?=
 =?utf-8?B?Nnl4MlUyRFk4VDlNWS92S2VWeGRhQnpTWHo1Q3M1SW1FSUFYWm9FZjc2b1lF?=
 =?utf-8?B?SGdnaEFvek5abE5uNmZVVS80WlJoMTRaQStmcFhmdWJTYUtpb1VlZ29WY0VD?=
 =?utf-8?B?d0Q1RjNsU2c4OFZOVXJGTUtGS1VIWnRXTi9YaVFmMnlzMXJqN3V1RDVNVWZF?=
 =?utf-8?B?ZEFZckFlNEtPc0RndDlUL3AzOVZpbXF2Zmk5OGVBVHYxb0pzcHlXTENpZkJ5?=
 =?utf-8?B?TnBTUmVacWdHczN2TFZLcE1Pekk3Zy9STVdXOHdkR0ZlM2t1RU9BdTBVM1VX?=
 =?utf-8?B?QUk0T3hRNWU1M0hJTmN4MGhHVXNtaVFieUNlbXJWbU8wcnl0VC9YZENxU3Iz?=
 =?utf-8?B?c2ExM21BK1BTWC9iMklzcVU1ajVNUHZra2pRMEhzT0dUT2hRNHJxMjBqL2xG?=
 =?utf-8?B?ZTk1d05VaWlnck1kQ2JPdFJHTkkvVGNBMTdlRDBQaHB2UTh2VWJ4YUV2NHNn?=
 =?utf-8?B?N0lpcWtTTzhIS0FYVk1TVGxXQkZ6U3ZiL1pUd2dYY09ua00rTVkxNFlVaTVR?=
 =?utf-8?B?UmRFNkJ4WFcrbGNwdm9jSGZSUVhWc0VZTFBTOElBTS9PVktkb25IcStEdTFP?=
 =?utf-8?B?VUNnbmdaQXgzWDdzNHJzelV4MXM3cC8yZG9pMVhRVytsRTJFQVRyRHgxRUpY?=
 =?utf-8?B?Q3J0clUxNzRJZFlsNkZyb0NHWlR4UzZrNm90QXM1KytndWRKemxrNDZrWkdI?=
 =?utf-8?B?MXhsUzQzNHlvNC9MQWN6TU5BdG1pNzJaWHdFZlZWWG4yWTZYTUd5a2tMT0hG?=
 =?utf-8?B?L2UyQUxHVXRkUzdheS9qdTRSNUxDa1p2VHVmNnovNW1Ccit2QXo0Zk1LdjdF?=
 =?utf-8?B?TzFJUG1xNFNUNjVnNEpBSUZvMmVJY2JGbnRuczcrdDkwYTFkTnhNREtsQk1N?=
 =?utf-8?B?TVRIeG45TzRkZittcFhmN0R0WWJ6S2dkWFozYXB0VGd5UHV3U3B1VytCVmJR?=
 =?utf-8?B?eElRb0VKWGN2V2lyR2xmamE2Y3BMK2hieFNVa1RaMng3VitQR0hNaGsybE5v?=
 =?utf-8?B?OE9jb0VDcVgxdTQzbnU4VDgrdGJGVmlmaXE2Wm1XYjByZjlMSGdzR01aTFdy?=
 =?utf-8?B?OGNIdXVoZ2V2OUlCaVdKRVNJQWhQL3RhZ1Q5eDdZN1hGaWFDb1FiV0Y1ZDZI?=
 =?utf-8?B?RlZNVU00Q3ZzcEF4ZkhFRmRsdEZ1Vnp5QklZZmJjUUVRRDVRYWNnd0daQnpz?=
 =?utf-8?B?S3Jld1JVTGcxck9NZ1ZCR2k3TmxrOVlsWXlJZ2lldFI2bmF5L3pPQVAyL3JS?=
 =?utf-8?B?M2tzS3U3aitNMTNhNUlrd2hqUnc4NDdtTUxqaTRTTzIyOEJKSitmelRoRHlh?=
 =?utf-8?B?YUVOeEpJRmhHVUdZdWROZmhuNGdoNS9YRncvZmYrbVM5LytMdGJuZGxHQXdK?=
 =?utf-8?B?YjkwVlRaTGlWLy9DZlVJQ2psV3hZM0tsZjd2SlVIb0wyNFJETEpOVWVHUE5m?=
 =?utf-8?B?S1NLZ0IrcE4zbGNBdHhGbVEwT3JKZm0zcTF5NEZkcUozNlJaNGx2bkZsUmZ5?=
 =?utf-8?B?SUhjaTBKRjN0VXEyZjRZWWtJM2FBMy9FU01JcFpwVi9peTNpRlBRTklHbHl0?=
 =?utf-8?B?b2x2ai80SmRZNkRUTXYwSk5OZG5xSFdld1VaZWtWSkpwVzBKbGlDWjNhWjRk?=
 =?utf-8?B?NXZiQ1l6SlJrZXJaeHlpdkdzOU9FZ0VvMFZCSDRRcHFuU2FueVYwRjRlM1Ra?=
 =?utf-8?B?OFZNa2VwUk81bXU2MEZGUWxsQndHQ1FRSVBlbmpSdzhacXVqWVBRREZ4d0JO?=
 =?utf-8?B?Y0xway9RdkllK29qVHA3VWNINlBiZjV1bmFhVHhmaTNiZGw3eXphcElreU96?=
 =?utf-8?Q?byTHp64996dwm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE50TU1WclRHYzVyckVRcjVlclduNTQ1aFVJQTFHMGE3eTJ5VlE4MmtvYlVz?=
 =?utf-8?B?VDNtclR6TE5Xc3RRYzdjYU9Qb3k5ZWZMSDI2Z3k4d1AvWkswT2daeGlYZElm?=
 =?utf-8?B?WG1RS2c0V2NMdnd0bHM2N3Q5eUtuUStCU2JpUFV0OUFPQm1DeFM0VTVZcXMw?=
 =?utf-8?B?YU9FME42QjFuM2xndU8vZ25ZV3hCQkIyYWN0d3FORDJsSWtidjBSU1piUDdJ?=
 =?utf-8?B?aWJoM2hjY0ZlYzRWdlQ0VnB6K3QzejFmakxVNFlDeFAwa3I1ejRMa2pnVDVN?=
 =?utf-8?B?dTk2aUtBNjkxU05BVEc5NHh6WExJVjNsMTEzZGk3UHo5a0JoOS9XN0I1RU5O?=
 =?utf-8?B?WnpFcU9pd1NZRVRjOE1KaEN5ZGR5MXltSkIvUkpPVjNVSnIyS0tKL0JOU1ZG?=
 =?utf-8?B?RitWY3F3cS8yN09ydWx1cXRYTFJ0SjVLaFpVVUtTY0hteXhYTW9zUjRLK3I0?=
 =?utf-8?B?WWVNYlJURU5SVURsdzM3QytZZEV4bGpVTlBzMFdUZ2RZV21sMFFGRUsrRTdz?=
 =?utf-8?B?dmNsdHpXWWgwc0huWDc3anNJS2hiZ3lSSjk0L01LSHQyaUVRcmVLUHpLcGJi?=
 =?utf-8?B?ZThGLzVpUll1dy9RZWpKM1BKdk94R2JOcWY0SUJBaG0wdTdYeWhuQlZ6Sm1N?=
 =?utf-8?B?MEJHbVorUXpZa3hmczVhbG1UdG9HZkJjRzlxOXplWXFBVkZ0bWFNd3NLZnZI?=
 =?utf-8?B?UGEzODMxOVhvVmpzWFMrVnRjK2hpN0tIaWtEVWdsM1AwUFVpOVlncWdjblgz?=
 =?utf-8?B?OVpIaVlKNmJhVDl4L25XcHgvZTNvUmt6bXlLMEFJbzc4ejFDbWQ1NlQ5VExJ?=
 =?utf-8?B?TDhhNlJJamhpUUF4eE1XSHUwVlBhTFZnUXRpc1BkYk1vYlgxUGFaY1R3S1Rz?=
 =?utf-8?B?aCtjT1F1cmM3SWhrRUIxdFNZd29hdEZyWWtUMWtLSklzenZwbXk4NTFnTG5L?=
 =?utf-8?B?d3ROY2FCR1p5cmxFaFRKWWY0NjVaTjUzZC9CdDNXQ2JiR0QrT09GM3VNR3or?=
 =?utf-8?B?Ulc1R08wNlRkRSttQU5xc1hPQWZ0c0VETWg3aEtmRUpxcFlVK2x6QWtGNWRU?=
 =?utf-8?B?YTlQbkhPaHRXbEVxN3ExdnB5NWNsSlJDWXJwbVpTcFpqdDVpbFFWSlNBQ1F1?=
 =?utf-8?B?eTJycTd5SGwyTnFsYmZGU0FzeG4rTzhpZzlKb1JJQUJmdUlNSzFBdDFYWGJH?=
 =?utf-8?B?ZGNIYkxpQ05WeVQxSVlwR3hQSWMxU1FTZVdOS2sveGpvaDRPMTkzcUdPOFJX?=
 =?utf-8?B?NTdSbDVHM2FGdVlyM1dPdFBGeC9rOTJGQ2ttZGJQNHZ3MkxFTWNxZ3JDaGxs?=
 =?utf-8?B?VU0waG90c01VTUJxZ1R2VmJTVXNKcFhFSnoyUUVYNXRpVFBvQjgzL2hSeHVP?=
 =?utf-8?B?MUpFMWpCbVVzdTdkcUxmb1R5UkwvYXdHelFsbitDaVpyRWJyWWxxejNMVWxY?=
 =?utf-8?B?UHdLVVRVbkNTM01obytjWDlQT2dwS0c1Q20wNWFqUkxXdjBycE8zS1F1T3pG?=
 =?utf-8?B?ZzdpMzJWVUZQSmk1WVFHUkt6Q1g2OGVEaUlTamhvMWFNL2d0U0d4ZXpLM3Q3?=
 =?utf-8?B?Yk02Z2ErVEhqUnJQRWZ3RWVaOEZrMVdnVmtiNzVwekFaM3g4VW5QWTBoTGJK?=
 =?utf-8?B?a2xzOG9mRjRPU0dEdzRWdmtzTi9YNWdKS0E4SXNtM2NZalRlalM1Yzc5cG9o?=
 =?utf-8?B?cDJOQm15RXZDcmhYdHc0ZW5XZ3BxaDd1SUJvMFI1dk9IS2hrd0NtUTk5c0hR?=
 =?utf-8?B?MWRIRU9KZ2lrSUk1dXJjOUgxOUF1NXZLV0Q3bEE5N2o4dzlraXJkSWNoM2Jq?=
 =?utf-8?B?OWZITWRRdnZpMkxhajF5UWVyV3FvSzJJb3RuakVVVHV4ZldlWDdKcnV3WUFU?=
 =?utf-8?B?TG5zUkMvSUZ0QUZMWTEwMm5xaXhEeFN4SlpKNDBFVWxNWWovQTEyblFZRjFX?=
 =?utf-8?B?SjRtbEFIMnBLSzBsNlFsTHpmM2t4MWVnU0x2L1IxTEJ0RUI1akcwNzFpUXdl?=
 =?utf-8?B?Z0lJVkxQRy9icVl5d3EzdWVmR2hza2VoOHcvZmVzcHp0cmZEaWVlcWhJamNN?=
 =?utf-8?B?TFZBRnFkaFNhV1dTYkZRRy8ycWQ5SDlldEdCUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5bd84d-79a2-4274-d644-08dd575239f4
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 17:14:42.9900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QX/KTgOqfbTNtwKeLaTOnVFShbH3KYMprePH5YlO271tfON57jP7IUXOaS7sqqu1al0d8G9O5mM8ADScjAz8OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10885


On 2025-02-27 12:06, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>>> I wonder if isatty(1) is a good way to say "ah, we are not captured
>>> in 'foo=$(git blah)' and not feeding somebody in 'git blah |
>>> somebody', so we do not have to worry about being machine readable".
>>> If that is a reliable way to tell that we could butcher our output
>>> for the sake of keeping the terminal state sane, we then can always
>>> do the C-quote escaping, or even information losing '?' redaction.
>>
>> Modern practice seems to be moving towards explicit format options to
>> let code that's parsing output directly specify how it wants to see
>> the data.  Such options eliminate the need for isatty() heuristics and
>> other guesswork.
> 
> I am not opposed to an explicit "please avoid raw binary output" or
> even "please make it even more machine-processable by formatting in
> yaml" options.  What I was hinting at was what the default should be
> for interactive use when the output goes directly to the eyes of
> end-users, which is pretty much orthogonal.

Sorry, I read "if that is a reliable way to tell" as looking for 
reliability.

I have no opinion on exactly how to "butcher" the output for a terminal. 
  I guess it depends on how well Git wants to support copy/paste of its 
output.

		M.

