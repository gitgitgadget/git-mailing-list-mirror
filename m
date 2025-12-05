Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0DE362A9A
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764960638; cv=fail; b=Xb/WgouwH5fGybDt953s12ol6jO60hLIPKGzZViRrAOn8knS52zIthXtRDv9gQcw47YvxJRIJ7pFscGGO7pK4iVMiZTPrCC69AU381M0aSgG6yivosVuhkC0QY/QLTQY7afzJWLjf/WRos1MeqTEGY+n6avl7sYl3RnB3P1Xh8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764960638; c=relaxed/simple;
	bh=kJzIO416GEUJkCr14qyLzGfjJlVn+RxB/1q3WEEHSu8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nsbdKPHZY5Xij8uKNOo5Ina5pCmSr/EawZI/t6Ee/Eg0uCeRwPEvBIhJnJL2x0XmZd7cwOF9cGfsEZKilQKhPESTbs3POXhmhgZTf3w24pS9SnLGs/ybk/Z7CCEQiQWDI1HxffpHKvrYPZFBybLsJ2xc6NPDMqnw9tiRnmc1e3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HIaCBEOu; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HIaCBEOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVXPKZxTvW4LkVUqHyueeiLkZv87xnLyPWz3Nx82J1VYWS61okmcTIPK0y5Lm5M9j8OsrY3CUapxzbnMRXlD9TbKBxaQkAUvdUIAZtIE1ElCm7/ZltA4pdJ4I1TFqj2LOq2AM6hMoeV0Q7m8Fs2wS048FI/deqLKE0c/fGwM6l0JSRTbYbkfDcaoij9P+qr+yEwV/3AlPwVfhVuj54tmhpRxia4klXdPr8ZCizfzZ5xdmvCHGl75EMLB8NwK+LTKGhfosJQSXf9YbHEV6stWM7oOTtNEpKcXLQvPWgy16IvZlYyoCev9OKXL+m8E9sKGdvB5KCH4uWmAyk3/cIpjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xji3/8YZ8fF16AWVVuI60mb7k1TIFkc2TzJ4UXMIqFw=;
 b=yA1BkFRXLcYJ6FLT/Gm8eSqIXeavEPsAuFDIFnmaTrj0+3+T6k40tzDzFtL3zXzprRwXIHqVxyYAuAch/61OmOYJtguy7WS+nmYqDP8AZk0jy7g4DPY7uvPDkqN0DuwPP9VkYjGHpsPF5NLal+TYJ7j4+PgseUiFHmAbJQvf1BKu8u5/TWh5R9DeTY1yN3tC2HUdXSra0JQ+ecwBf6Qgui9y/psW4qwKjpHJjOdm9Qv46DCGeQoPzjSh9Qg0mzQLSzZZXLF+P+hGBeVGic1l6SVlSSXRWaLuDv0fyFN4vcj6hGwSjYVy0TfAn3x/heR1KNkF8QFt8p00fVJqaUfmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xji3/8YZ8fF16AWVVuI60mb7k1TIFkc2TzJ4UXMIqFw=;
 b=HIaCBEOu9QwbBscLLbyuO4pABmJR36ngwXpER4KiV7irWfR8BzJeh7OSUep0sKybaNux2wgsBAomZFl/EQ2hMwSRls0RMYUOAiEhJORrsN6V0aZtDIrCit3stxx9UV6KdevpPiSfqYMh7ufqnGm9+GNa+gKW3DFq7cDLF1sunpTPv9sNA9pRwYpDl4uXhHUaHmvEM1CnMRgjJwuZ1PjR+H7k4MnVsuHUk46AgVHBvyjOtEIAn9BYH4dvRZkpuo3KLRgCe25ZNr4i9i2th0lwWCdNeMMqD1PfiG/rGLXdo6+0uUoiiZS3EtauolIflV2KaivGQ1g5/jaZ0g7RS/4zrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 18:50:32 +0000
Received: from BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f]) by BN9PR12MB5305.namprd12.prod.outlook.com
 ([fe80::e7a3:9531:f0c9:bd7f%7]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 18:50:32 +0000
Message-ID: <235d80bd-2516-47f9-958f-0e5a16892758@nvidia.com>
Date: Fri, 5 Dec 2025 10:50:02 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] packfile: skip decompressing and hashing blobs in
 add_promisor_object()
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <20251204172132.319360-1-aplattner@nvidia.com>
 <20251205174854.GA18566@coredump.intra.peff.net>
 <20251205180106.GC18566@coredump.intra.peff.net>
Content-Language: en-US
From: Aaron Plattner <aplattner@nvidia.com>
In-Reply-To: <20251205180106.GC18566@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0040.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::15) To BN9PR12MB5305.namprd12.prod.outlook.com
 (2603:10b6:408:102::5)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5305:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb5bbbf-a422-4191-9c71-08de342f2ad1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z2FNR3F2WklZbjFRVmZDOG1uYmEweThubHdQVWVQdm93OTlmdi9yU1pkZDZF?=
 =?utf-8?B?M1BSR3VxMmVDUW9rN0xWbWJEWXJuSExaNStEM0ZFRUk5WnRGMGJEVFhWY3Zz?=
 =?utf-8?B?K2VXV2tnbGU5WXVaZXhxZ1BmaGRrZ2VNbDJlY2cxeFFXOWVWT09sbVFmQVg3?=
 =?utf-8?B?bkllSEFhNURYdE1tRTI3TDZITWFvdjhSclBXbHlIWjg2Qzc4SjBXbVBPRnBT?=
 =?utf-8?B?UEN4aDRJL2hSbDMvcWVQTFkxeW03VWh2ZUJhUEF2R2JxS1Q4OUN2Z1M4RzRB?=
 =?utf-8?B?dUwzNkgxaEY5Mm1hbnVQS0RCRHpmaitTcTJxWUxoNCs5MmxiMStPenVaQko1?=
 =?utf-8?B?NUFpcHd4REVETXVYZHphOW5oMTZ4aFBHT2hBZmRLRXUvNW02K1NDY2tFbnBo?=
 =?utf-8?B?WmZHRDFSOFdYcWNwUTV0WGJBZzQycEtxNjNIQ3ZpSHM5RTR5UzFUK3Nwc1Az?=
 =?utf-8?B?TXQ0eW5pOS83dzYvNGNSNXplakdnTmVFalZxVVpJaHdCc25WZEcrZlp1aHgx?=
 =?utf-8?B?TkMxSDhyK0w2eHJ3NWtWR0lja3BYS1kvY1h6SnVOZlYzeTlmZmdXL3FZbTVB?=
 =?utf-8?B?bEt4QzcwSnkreVJCaWpUWCtyWTZWbjNoTkZ6MGcydFZZWXcvcHJIYS9ZOFRQ?=
 =?utf-8?B?OXA4NVBqLytRcEpEVXZEaXBLQmk1Yk5NakZ2aFFDaTlNRnhVclFwcVd1cW9t?=
 =?utf-8?B?ZlFLOFVCZVNtUnY5QUdUSDRMR3UwQzVJVitLdTNFNGNiMXJ0VzhZM0VTQ1By?=
 =?utf-8?B?WnhjRURWZlZlUFpGMlJBbS8zQ29kY2NtVG5MK0NLSnJBWTRvcVdHbitHWHM3?=
 =?utf-8?B?RndPRVhNcyttR1F0NE5hVlNPRUlYOHl4eGN4dHRZVVJIeDdzVDAyUnBSc1Y0?=
 =?utf-8?B?RTNySS9RTE85eFNtMHl5dTYzSlJvQTMrM3JTcFZIcXNlSFRuV2VpVHdKbW5k?=
 =?utf-8?B?TXJ6bThuOVA3TVB0UlpTcDJscXl0czh3cjZFT3FuRmlHc2VDQzBpaGZuRUc0?=
 =?utf-8?B?K1AyZ0hQa0lpZFRHK1lSaUlUZ2ZqeXNmcFI2UHRXYlA4dWQyOUJJRVJaN0Y4?=
 =?utf-8?B?akxSSzh6cFRMdXg1Nk1JZjUyaEU1TGhFZ0hkUGNXRDZZUDYrbWRXTktRSFZF?=
 =?utf-8?B?ZUhsTTM2dkRnaFB2VFh2aE9nN01xb3RQTTAwZ1UxQVRENFV5NUEzMGU0MkM5?=
 =?utf-8?B?MU1ueVZMVFZxbFMzMTlKdm5GY240VjZKdU5qZ1pCNkpnK0dGQjhiK1g5eXFp?=
 =?utf-8?B?UzZrdStGOSsvUTRUc29Jd0VseGRjUGRvbFhHYVR6ek9mNEFGMDFIN2NIT3JJ?=
 =?utf-8?B?MXh3Uk45TGxWelRtV3NISy9jNjh3NlNza0VTZnorb3RnbmhvYW4rQ0xCT0RW?=
 =?utf-8?B?MkYvSW04RmEwaXdkUXJiZGxnQVc4LzVmdmozT0p4MlM3WDYvRitPME1jU09M?=
 =?utf-8?B?cWFyY1drUUlyZUtzQ01PbHJURnFaRVVxQmEwVmpxandQZWtxK0hYYnAwUHY0?=
 =?utf-8?B?alhha1NFOXV0ektPcmo0bU0wZm8zOEc2RWtQNHNUSWkxQWFaOGlxUkFjNUhs?=
 =?utf-8?B?YW0rbTVLcFdSczlYUTVycXpBc2E2bllXajJXNE8zOE1CN1FOeDZCQTB3TkZa?=
 =?utf-8?B?MDBwS2hibktHVktxSHNMVC8ySzlUNjFZYUJ4Ty91ZTcrbERBQ3BNdmdYYytv?=
 =?utf-8?B?OG5vbC9kL0oyVEs0RFNqQ3FXS3BJZHRFK0xmUjQ2Q3ExTTJvS0kyNkdEQmRo?=
 =?utf-8?B?dGlHNzhkRUhPZ1J0L05uUjR2VDI5NFBRVU9sUDVWUkNlcHZGWGNlaU1rR3cx?=
 =?utf-8?B?bG8wNFovakVKSm1mWSs2aFl5eVJlZi8xKzB2OFVOTElkWkZnVFJxcHlKak1L?=
 =?utf-8?B?WWxkRUF3VWNLd1RiRG1aWlJ2ckJiZ21uM2sySXVXajJXQ1B2YTY4YmJRY3dy?=
 =?utf-8?Q?auAUZ4lDJmxTr1RMbLN/GAKI5E723ysK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5305.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RE5qeHNTbStKN0RaaDRBQjlnc280c0NGRG1CdUVxUzFXb25vS3krTzJpNVk2?=
 =?utf-8?B?TzZKQzRmZmRGbXZ6Z1cxVjJrcFUyMVRQaUNwZUo2ZTlIa2tDM1pRZWVzWWRK?=
 =?utf-8?B?MVd5bGdhdk1RY01CNnIwUlNwTTM5V3p3bmt0bzFxcWltWDVtWmxwOTdqeDFL?=
 =?utf-8?B?VmpLNy9vNlVhQzB0aFVRQnh3c1dsTzJiRFhoYjVLUTA2cUVnNXJtRmNRWExz?=
 =?utf-8?B?YUJLdE9hbmsyM2o3MVV6RU1FYktCZm9sOHlOcWlxb1RjTGFkcysxMUZPZVJY?=
 =?utf-8?B?bGJlUU4wSEthMFFBRk04QXJHYVZ2OUxUM1d5QTV1a0xCQTF2T2RyMVlXWlRr?=
 =?utf-8?B?TnU1OXovSjdLWXg2ODBUVkhHQVJQcDhUaDZrS25JWnpYK1Jxb09KWmI4VUR6?=
 =?utf-8?B?QUZVYTV3Q0d5NE5GSzhCbGwyMkcwSEFZR05LUFpvSlVKTk9kcmN1bmtkZ3Nk?=
 =?utf-8?B?WXIxTjVDUHM3TEh0Ui9XTWhUdlh0WXhzSHVlQlNVODB5dUcxYmxIaWRRMHVR?=
 =?utf-8?B?WUNyWVpHR2hkMVdMMzJYV0NmUDBDNnRUakpsaXNldm1ZaEF2QkpzRWV0dWd0?=
 =?utf-8?B?VkM2MDVKUUVlaEV0a3g4YlUzeWVtMUNuWmtzbDVIMW1ibUdUb3pVMHl6TDZr?=
 =?utf-8?B?NVNHWXlOSTVlSmlzRnUreGQ3YWFyR1d2V0hPTm9tRWRWMmpjYXJMWm1VNVNR?=
 =?utf-8?B?c1N5WVpUeVFhSWRiZ2ZnMVI4T09PTnVINzBVS2pILzJWODZvaXdYeTh3VXdt?=
 =?utf-8?B?cjUvcTMrZWxrR2hyREpGVmlUQmRtWDg2Y1FvK3Z6UFp6clVkamZmTUNWNVdj?=
 =?utf-8?B?S3dYbkVnQVZIQ0VqTzVhQnVNUmRZMVVxK3JxUGgyaE1oWXBWTjlPVjdXYzBi?=
 =?utf-8?B?bFBiRDQrT01jcHJIZExseC9xSldTc2FlREJzUm1mVDRONWJESER1RFFZVWNx?=
 =?utf-8?B?dGFPT2M2VGU0WmFLeDNMOVI2ZXZJSGl1U1R1a3hVVU9Jc2x6NGo1NzJQQ2p5?=
 =?utf-8?B?V255ZkN6dHkwRXVvWURUcnhJV2pBSDVxUVFvYk90WFBXSER5VEcyMWNvT0Fz?=
 =?utf-8?B?SmlGTkgxbGp5bTkrZHhCbnByQ0lLQThLNGdTSkhtWHVVQ1c2aEVQVzFETnF0?=
 =?utf-8?B?VHZKc0ZPbXJ6c09uTXZ0SXVOSElYbjZoVGhBUXllVzcrOVFQZEdmekFkSXdy?=
 =?utf-8?B?KzdXdjZseS9TZUNsczJvaVRUSC9acTBGU1k5VSt2WmNkWHZEZWZtQy9wUlhx?=
 =?utf-8?B?TTF4R2tzdzRvanV5TnQySW92U2JuQVVEMG1BZlQwZFNlU1crc2tNZWR2TEoy?=
 =?utf-8?B?NDVDMTNZUGsyZFVybjVYWUREaVpQRHNnS0VpNUtFYTJkWTVJUStiMWhvUVJ5?=
 =?utf-8?B?WS8vTHkyczBtZHpSQ04xOEI2d1lzRVozbG1lcjk0ejY5dUs2NHVBS0RHNzBC?=
 =?utf-8?B?V0g3UUhEQlo4V3BEOGR1QTg0RkJuY3lXdXkwT0l3Zm5tc0dlekZ3c2RCK0pk?=
 =?utf-8?B?SE9wMzJ5akZxWjB5cE1RbHBWSXRFMnBWOVVhdWt0Mk44ZzNqRmtjRmQvREJC?=
 =?utf-8?B?dm1rWm5Bc0lXTnh2OURkcFlNdGRoUUtQR3FZd3U0c2srcTdFRmJnSW45NkEr?=
 =?utf-8?B?OTRucjFjOVFvSmJIYmlDSHdKdE9XTEZzYW0reFhBZHJmWG1zUVBKOU5EdU42?=
 =?utf-8?B?TXM4ckU1VmhRUmtOenc4NGJ6bEJqS3VzU3dKSzQ4QWo2VlUvOE9QaEdOL09z?=
 =?utf-8?B?REtYMEg0QXJLL05RQ29vN0Zma01wMnFIMGZoelNpYkRBdUQ5SUFkVmg0QkVE?=
 =?utf-8?B?RldRcjdsR3NJU1MxSktMTFp4NW1aM3Y5dWc1OSsrbUp6NUVjYVVaM1k4WVRZ?=
 =?utf-8?B?K0Fxc1V4UmVwKzlvVG1kRUIrSHNuUmJFSFlUYTVtb1lna2xTYmp2WE5NR29w?=
 =?utf-8?B?TTU0RjBFdllpUDZjdGN3ZzlDK3ZycHlnV2dkdEF3UkVGVGpEWnEzRlhKc2R0?=
 =?utf-8?B?czhHMmE1b0ZtUWl5RHRFQmhiTHZsZFpKVEc3TzZGQ2cwUmVMSU5ZaVFXd3B0?=
 =?utf-8?B?aCtSUkdUNFN3TmpJUUpXK1M0M2MrSEtITWdwWkg0SXBSS3BManAxaGY3SW9t?=
 =?utf-8?B?aTgrOXRNTVlGTk82N3A0THBzYlNjWEw2R3VOSmFvR1YwWE1TRWR6aUJpSFJp?=
 =?utf-8?Q?PdW3uVm/NQJSh7B+KzDnScg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb5bbbf-a422-4191-9c71-08de342f2ad1
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5305.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 18:50:32.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruj0h+/3VtFjnWa8ID1B6JSwm5iXyqdASHfUJa/IrInKluNU1U3et8d1C+2bnYxMndY09n38KWjVsmR1XA96Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

On 12/5/25 10:01 AM, Jeff King wrote:
> On Fri, Dec 05, 2025 at 12:48:54PM -0500, Jeff King wrote:
> 
>> OK, so we are checking the type up front and then skipping
>> parse_object() if we can. But there is already some logic inside
>> parse_object() for these kinds of optimizations. If we tell it we are
>> not interested in checking the hash of the objects, then it knows it can
>> skip loading the blob entirely.
>>
>> But it can _also_ use that flag for other things, like using the
>> commit-graph rather than loading individual commit objects. So doing
>> this:
>>    
>> diff --git a/packfile.c b/packfile.c
>> index 9cc11b6dc5..01b992a4e1 100644
>> --- a/packfile.c
>> +++ b/packfile.c
>> @@ -2310,7 +2310,8 @@ static int add_promisor_object(const struct object_id *oid,
>>   		we_parsed_object = 0;
>>   	} else {
>>   		we_parsed_object = 1;
>> -		obj = parse_object(pack->repo, oid);
>> +		obj = parse_object_with_flags(pack->repo, oid,
>> +					      PARSE_OBJECT_SKIP_HASH_CHECK);
>>   	}
>>   
>>   	if (!obj)
>>
>> drops my linux.git case down to 49s. It's skipping the blobs (with no
>> need for your patch) and loading the commits out of the graph file. Note
>> that you may need to "git commit-graph write --reachable" to see the
>> effect (I think we do generate graphs by default in git-gc these days,
>> but I'm not sure if we do so right after cloning).
> 
> Oh, and obviously it is skipping the hash computation on the objects,
> too. That's probably not as important as avoiding the object loads in
> the first place, but it may also be making a measurable difference on
> the ones we do load (notably trees here).

Thanks! I had looked at PARSE_OBJECT_SKIP_HASH_CHECK but it wasn't 
obvious to me whether it could be used here or not.

Unfortunately, setting that flag doesn't seem to improve performance for 
me because in parse_object_with_flags(), lookup_object() returns an obj 
pointer with obj->parsed == 0 and obj->type == OBJ_NONE. So it skips 
this block and ends up inflating the object anyway:

	if ((!obj || obj->type == OBJ_BLOB) &&
	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
		if (!skip_hash && stream_object_signature(r, repl) < 0) {
			error(_("hash mismatch %s"), oid_to_hex(oid));
			return NULL;
		}
		parse_blob_buffer(lookup_blob(r, oid));
		return lookup_object(r, oid);
	}

I was confused about why the check was structured that way, but reading 
the description of commit 8db2dad7a045e376b9c4f51ddd33da43c962e3a4 
cleared that up. Thank you for thoroughly documenting that!

Are OBJ_NONE objects expected here? Should the check be

	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
	    [...]
	}

?

If I make that change combined with your PARSE_OBJECT_SKIP_HASH_CHECK 
change then the time drops to 1:58, so that's great!

> -Peff

