Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC37D22577D
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710768; cv=fail; b=qPF9c2u54P/4HAP5KhxbBsw6KFpY3MMmsu/QPHOYdi8rx+a7wPn+sqZHmMuSWXdGNZIg4x/e26ZtfQNuZxF/VxZ4ITnO8HY3bGNFmAYcGqtoKUISKOt45TqLgRQ0/V4x4jFFSa1grWTIaKv0KOVFi7Rz8hNxW+Dm7TBLbzkSolY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710768; c=relaxed/simple;
	bh=t2w/oheh1gan5DE1gZani7l02CskH2yypCJDqwF+K08=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Yqm/3pbFlSioGbVlr1jYMNZPWFLw322EqJKNONwZlGCvqoVoWL8bIBNjV1EUsD8R4RyZGTj+dypywg8NtzPV2II5Xsy3LBPtKabdaXquH2rShUpn1fGzbDQkWDZUWuCztMwUOFNAOqnj1CmctGmQmL6UMAd4CUQpY4MPHWrom+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=HlydXXiZ; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="HlydXXiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It+WW/mtcKvnqxLf111Pqnq5kpkbBQMa8BhtFHkjn2J8BYzJow7CZ5/3YOAc1+W/fhbIKP54trwp4jdAVuh9aoNHjj57yZZapUEf1NLqpgIvbYfiN/GRPPmBTvYEpphDz2S6L4r+kUt816zt9UlnYgOmou5r2+AGG8yxfH70sHwwrj3NN2n4mQaW2veaDyJgdof79Ogwh7+Lip5WxIVdKW94uxIyHxiRVQeAFvAedBpqmUx1M5MBl2hLbHhqN4E+Er2lcU5hc93tH9tJXs+Gla4SdKGjNAMHeeWx6PCkgxbng4pHzM72XZ3+ceQeyf0lESx+JaHhT5S0Pj57/GBFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2dB4RdOMbA5ua7baAfLB7l4xffYWKlvMkHepZi+lCg=;
 b=kbdlwVttzguKXE/O3mlqVBIC6BN+XuGQEFPyp/kCGtQOky4VQ5t82rkRRXl9SsrJvNAmgLC0IyenxQC6THqq0h02NfTV2wkaNIvC9aEI7WYDyzckB5qBbb8hHbNhPoGkKh756vaJRaHzAuFBcaq9awcT6dWv9lk/9LKmdZkQP0kjKR+4WcGgIjG6Xprp1y+8QP90uvHmSfJBxUmFecaH8WzQnNmnj4qg9j4HoRgrJ0I11timurAst2lrC9mNZW3OH8OkoN8yOjb59njWB8b2l1aAKgFZVwfcESxx+myPpdq1Nkp6B/UaCnXb1Trfvp8WaE22SBXy0eDAXFVcRN1TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2dB4RdOMbA5ua7baAfLB7l4xffYWKlvMkHepZi+lCg=;
 b=HlydXXiZPZwHAq3sm35QRhLBFasE7LkdPSU/p/lzpJMrNoOrL+0NwENt3575e5n5wDfRnLQGTQY3SW/52VnxV7Yj3CbdGuxjY3r/XVB0fVBkrSWtFHK32ey7MJ9q6mkPlCRDH9Ke2i2q7ReWUercE9Tc1w4FgdPnTKOVKI0Vcy+zE0qBqP4NzuQXWMNpyTXgGTp4Wcs2twTeugJWrmp6clP7XyJEnjHlY5WkYvmFvi8jKTAWtx/m0gRzv+kuds3ZcmgiDAInpX33ltbKNM1u+61B8fAPq5L/9p/zE9xB9e+eZiByjBIti/FUhMQSJtq0NMt7UffbN2abnLZy+7EkPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT2PR01MB6142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 13:26:03 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 13:26:02 +0000
Message-ID: <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
Date: Thu, 8 May 2025 09:26:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
 Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqjz6sb15u.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT2PR01MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: fad2b04e-2bb9-400f-fe31-08dd8e33e0ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTlRM0F1M1dEUUdDbEFmSWJKNFA3algvOWZaU1pDOXRkNkIxT1lvQjA4Z0hk?=
 =?utf-8?B?MWQ0dS9TM3ZkWTc1QVlFTVpWdlJhSDZXVXplVktNSjZxL1l6aHluQ2JiMEZO?=
 =?utf-8?B?aFFzVmNadGpqQUVpazRpOFhlb0FpeUNXdW9IaHR4OWNzamFxOURTSkY3U1pN?=
 =?utf-8?B?V1VieUIwaWRpSlJJem0yanZSdFdEWDFEZDhRd2NGS2E5ZGNjRTdDamR5VW5v?=
 =?utf-8?B?R2lsaW1BOXJ1VTRoZTV6bVZRb0RHNlRKSVlxVFVwVGZuRHNqNjh6Q1NEQ0ZN?=
 =?utf-8?B?ZCtzaE0rQzNjZUFhWnY3Z3ZmWTJ6b0hTQk9EMHJTV0JVeGhvOTNjZnhaS2ps?=
 =?utf-8?B?ajIvYVE0SzY2aDhuS0xBeGRUQVNSUGZ2M3NSc0d2cVRpR1FtdkRZTDUwbzVz?=
 =?utf-8?B?dG5Ra1Vtd3laS1JTSUdGSmJMMW5ZSy9KQkJVdmRocTJrbWlqOC9ZcG5ZYzZS?=
 =?utf-8?B?MmpJZmxsaS9ld3ZrSzVMQ3NzODB3a3ZkM0R6YlNIRFNIdThHeWZ5b0cxdURt?=
 =?utf-8?B?T0hRcmR1VHpERGhBTjRaMjg4WUFRREVhQWwrQUxuTzA0TTBLNTRQNEVKZThl?=
 =?utf-8?B?VWtlTjlEQ3NRYktTdjRodTZZd2NPZ2ZQL1Nmb0Nldjg3dFdGTkJ6QmpJUTFm?=
 =?utf-8?B?L1Z4V0h5SUx2M29lN3lXYjBxL2FUU0hkSi80TTNPS1d1OGxjQXBUcXBBK0Fp?=
 =?utf-8?B?MllIRFg0MjB2ckUrZmVUOEprdTdyN29xTlZpTlBBN3llUHdpaEdTOXByL1VL?=
 =?utf-8?B?M3cwZzhiZ0dldWZIdXJQK2NxdVBpMGE1c1lNWnh1MnVGQ0pPWkpsMXJyNkh4?=
 =?utf-8?B?cWt1MXloNjdNb2xoOTZaMm9oNWNiODI1ZVNpR2xxNzhDbmNUM0hySmlTeW1w?=
 =?utf-8?B?dHA2S3owdHhoODN0QUducllVZ1BkMzFidTJBM29WQS9QcGJ5OHd2SzNnUzNO?=
 =?utf-8?B?L0d5Q0dDRWlKUCs0TWNabzdkb21INlNuZ1hmWStoR1Q5blNLVWtHV3FFSzU0?=
 =?utf-8?B?cENJOGtMN3E4THdBbDQvR2VRUnlDSDFmRy9LSUJudTkwT241bnhwR2xhb0xh?=
 =?utf-8?B?Y3dTdFZRZ1R1MHluWjh1R3pDdDdsOHlENVhmanFjdmQ4RnRHWjE1LzhnQ3lS?=
 =?utf-8?B?Vnd2cWlHRGgycm9HU0MvMjIrV3dLNlB0SUMwNnBGYTR1VHE2RVQwdGswZ0dV?=
 =?utf-8?B?MDhyc0pnbGZ0cVBCemV4SVhMVW5hOTl4RTBXKzFnNm1PbHdlVm5aUFZKL1Nh?=
 =?utf-8?B?ai92aEVCSWNSaHVQL2dCMHNLN0d2bTNIOWY1S1RqcVBrak43TjFSNGpJd2Mv?=
 =?utf-8?B?TFF2OVFXbTExZlg0MEs1Q0tpWFowandjb3R2cHBJa3Fra1NLMEl1ZG1MQ0NK?=
 =?utf-8?B?NkxjUEdhcDhYYmljb1RxRjlqdno5S0RqbTljbmVRTWxPWXJHSi9laGlmWUpa?=
 =?utf-8?B?Z1Brdm91N29HQTVYeUdZOGtDMkNzeCtFOTBwSVhTaWZGdU1LcGlnc05wYWNM?=
 =?utf-8?B?WDYycE0yelJpRTRVbmxwSmorVTZ3bWhPRS95QVQwWUp1TlJmOWlVZ1lqUk1Y?=
 =?utf-8?B?eVg0Uk8vNzhqYkdKWW0yd2FwSnV3NE5SdHBleEhGUzVCeW1BMUI2V3Bud3Vm?=
 =?utf-8?B?NktTeHpWQ21uUHVJK1crVTNCYlBWdjNTeC93OHdQSG9yMFVPU2gzZVBOeHdr?=
 =?utf-8?B?L2JVWnVDUmt3WmdXcysvOExUQnpJY3ltZnM2TllEOXV6b0NiTTZKWHdsMXlC?=
 =?utf-8?B?ZXZCc01VTjR1TFpGaDR4MUpSYnRVY2Mvem5yZ0pxUjB4ZW9HZUZqTDhURTQ5?=
 =?utf-8?B?RzdZUG00QlhuVnRYVi9sT0o3YUV5ck91ZWV6UW5SMlR6L2RFazFDOUloVWtp?=
 =?utf-8?B?dUlTTkhabndrZWZ3RjR0amk4c2xlNWZ6QWE4SlNXSlFtNm9EM3Q3eHJXZGtj?=
 =?utf-8?Q?lUSHPMlvltU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1piN3VUV0NEUGVZNC9yREhSR0tSdU5ReFZLRklsVFNuMy9nd2plVXo5cDBv?=
 =?utf-8?B?RmNxUFR3MEVyc2JsamRKeExSbVQzMGFmT1puK1BWOFJzQUo5bld0QWxscy9K?=
 =?utf-8?B?R29yTk1kU2hlaEJmaGhnTVpWN3ZWVnpabmxSRnlLQktJeXBYRVJSNThQeURH?=
 =?utf-8?B?SEt4dkg2QnZMZVFJVURQY0NGVnBFZENGR0RGQ2hUOFZuWEJrUG15bXNqUCts?=
 =?utf-8?B?UHlMMnJxNWtRTlVIc1FPNmVIcFJiS1dRN2NPTUEzWDNITXcrUVhKeUMwdVdB?=
 =?utf-8?B?eXYvdWhaU1pXS29BQUIyb1VTU1BGdmswTi9JRXcyQkJMbVJQcWxwM3NpK1pC?=
 =?utf-8?B?NnlCMjllSUVzSVJIQXVjcmtEdmZQZjVNdXorcjR6QURzaWVSdTFoeFdiNHBr?=
 =?utf-8?B?c2NReUxJQmQ2V1dGYlY5Qi9qeUNHb1lYdnVaODhpWUpETzVKS3BJYng1ei9S?=
 =?utf-8?B?MFh6TnAwaC9ISDNjUkZYdkl6djZjWld2VmpPb280eURyTHlpOUo2dDJRR0tP?=
 =?utf-8?B?UHF5dHovT05xUXU2ZGZldVVGRDgzVXRhblZCNXhGaElaQmFmMEVBUlpkVHVx?=
 =?utf-8?B?Wk1HbVlYZnpuMlUzcWdISW5hTFg5d1BsZlNKeFJZdVlnUHUxcmY1U3BaUXJj?=
 =?utf-8?B?VXdzbW41RGdUcjFQMkk2cXlQZTdlQXdOMW4zZ3p5NERkSzNjWVAxOWJtcVVi?=
 =?utf-8?B?T0hacTYzbXIvdi80NDF3WUFWN01hY0F3Vm0wVXpPTGdJbXhYRXNZM0ZqVm5w?=
 =?utf-8?B?L1V1UmgzVHdCcCs2cVkyZ2IweC8zY0Y5UE95QXZUZ1BnTlBYa0lxRFJkUjND?=
 =?utf-8?B?TGozTzJabDVwNHpHMWdHa0IyTlhaN3BPTnBrajEzWmVicUtZRlZOZXlBVkJm?=
 =?utf-8?B?RHY5NC9yRUhjTHZwdmk3cGpqc3ExRVBHZUFrTHBLSGlqcjZzakE5cXQxV01V?=
 =?utf-8?B?TFdwMGF6YXdvQ0JVVDNHTFdPbWoyMStCMXVsSU10YWFyUHlWY1BpQXozRnJZ?=
 =?utf-8?B?dVVCRFN4c3NyUFpJaFp1Vy8zeTFmQis2dndaalpPSFJqaE83M1dFTTNsZjE3?=
 =?utf-8?B?M2U0MVI3eTZiZWtMMU5NOEdFcW04cFRlbktyMW9lYmpFb2dxWG1jT2xpbWVG?=
 =?utf-8?B?N0pmaHI3c2RkRisrMk1wU3dGVWdoN2k5aHJtek93ZjhuRzAybWNCNUtIYkwy?=
 =?utf-8?B?ZWhUNkhHOE9OTGlEOUwvZWlyTzdtKzRoUVI2TmRVWHdqZllaRktELy9kMjFK?=
 =?utf-8?B?S2VyU2U3Tm1ZTTh0VmxJWTZSQW0yeDkrcVUxTUVKNGFPVHBXQXZlY2pHUXQ3?=
 =?utf-8?B?c280MlBWb3BZVHV4VHdZTnk4ZkFpY0FmV2xiWDAraEJlRDd0aVZUSDA1Y3Zq?=
 =?utf-8?B?SlQwYzg0ZWJ5TEVteC9CMXNFVElRVnRkK2REWlA4NTdDbFZoNmZ3bHRWOXNi?=
 =?utf-8?B?Slh2akJFNDlLN3hYL2EyQzBuNm0xcGFRd2R2SE4yNHVZcko3RWZWdDI5eVVP?=
 =?utf-8?B?UHl3SFpaRFFTUUh2U2tVY1duNFdUQ1lPQmphcFJOTXg1YXlpdmNPenFQWWVT?=
 =?utf-8?B?ZG0zSGtSTHp5OUo5Z0o3NjYrY2Y3U0xJSmtmSWlYRlI3SlYyUmxYdFNoU1hM?=
 =?utf-8?B?dHFnQUxOaVFtdURQUUEzQVpJcTZ4b0E4blI1S2lyNUJQRDZpOE1HdEZ5c1hV?=
 =?utf-8?B?aTRPQUkzajZHKzc5NTdsbFhZNmorbkpMMVVRaDFpbFU5M2Q2cDdpMUVtZWJ1?=
 =?utf-8?B?MytCTW04UzVwU0p3d2hSYlc1OVVkZnh4VnpwdTNTSVlUenBtVU8xY0xuOVIz?=
 =?utf-8?B?NFVYL0g0RVdIbGh4VlZ4Z2VwRnIzSU9EajcwU1d5REp5ajFyanlnbEFlUzB6?=
 =?utf-8?B?ZUNYcjhDeXhYWWdIVi9YT09kekZRVEZKeGFKZnhod1pKanEveW9RcEkzVlZF?=
 =?utf-8?B?ZVZFVUNJd3FlR1plZGVoMDVpTHpuNmcwYy8rbWc0S1NZNFRzZUs0aWljVStD?=
 =?utf-8?B?MU5tZmdCZUZJeGRzT1pBaCtnN216VHkzYThaNHJ5RUQzMWZ5di9yVmFNYS8x?=
 =?utf-8?B?YjJkcmNBZjQrTHB0WUlEaU1aYitHVHozYkZXQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad2b04e-2bb9-400f-fe31-08dd8e33e0ad
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:26:02.2995
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2vIJ3PIfD78zTx+76QI+xxD/Okn6pgUnsJI84AWo++Jel2LZc0aV+JwhiAkscXdRY435otWRwb1fjhzJ3e5AHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6142


On 2025-05-07 16:45, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>> 
>> I mean, from a usability point of view, it makes much more sense if
>> "git blame" simply understood how to handle blaming a directory
>> differently from blaming a file/blob:
> 
> I think this needs rephrasing: blaming a whole file (or a whole
> tree) differently from blaming individual lines.
> 
> As lines can move across files, and we do find such moves while
> tracing the origin of each line, "blaming a file" is not quite the
> right way to think about it.  "blaming lines in a file", perhaps.

I see what you mean.  "Blaming lines in a file" works for me.

This distinction brings up a wrinkle in my proposed DWIMery: should
	git blame path/to/file
show the annotated blamed lines of the file, or simply display the last 
commit that changed the file?

While a "whole-file blame" is really just
	git log -1 path/to/file
I can appreciate the convenience of being able to do that with "git 
blame".  I suggest adding an option for this specific case, like maybe 
"--latest" (I don't feel strongly about the option's name).

Want to see the annotated blamed lines of a file?
	git blame path/to/file

Want to see the last commit to touch a file?
	git blame --latest path/to/file
or
	git log -1 path/to/file

Want to see the last commits to touch each file under a directory?
	git blame path/to/directory
(--latest is implied because the target is a directory.)


It also occurs to me that
	git blame path/to/directory
might need a way to toggle recursion.  I suggest recursion be off by 
default.

		M.

