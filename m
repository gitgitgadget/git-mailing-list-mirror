Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020138.outbound.protection.outlook.com [52.101.191.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2989A270047
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740665218; cv=fail; b=sXvK1TTaM/Acol9ShgfxJA8t7t+sWVKw592v6eL3Q7IBXZMErJbv47+HLPv6MAxCDDYKx3PslnekaBe6v9kCjTLJn41W3731SmaDn7uPD1DQ60uX4ztUnWxLcH8h6KLRCgq+9Bw2xmD/4EWGiLtlngCqV6BJ10XZsU7nooYzfCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740665218; c=relaxed/simple;
	bh=uWMiI1leEciFmBP2FO8exQZ1snlMvDCx0Fq4PVzJ0mc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zha9SSAbzKuPqrG/QUOyEee6A0ioVGjJ0kLDPgnOD8E7XOLMiMVu1Z7ld++LXcnj6WcujJCrhRKMnWuEpM9+4FEV+yxft7tf95l84e78jFaQOOWEjOE63e4RqqN5bPgwNdaGsHXiYqeG+jvXmGfAtQTgroXYwqOoVFbloPNYyGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=QB0cj2za; arc=fail smtp.client-ip=52.101.191.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="QB0cj2za"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAuQhNjwyOfVWx1tSX5LKeVf7RCJpUCJZiPIGmsDH5fIcDS+QD7aZAGGYM8WsI3mi0Y5WuSFQx2NkWG+xhLOFZPQm255wgCMMhrBc1sw7DvUml1BigEDNpYkbEV1duJ9GN9WuDM2Bcu9Ts7pcHRcfTSAMQ46fUv58ctbPK2qpbdm0B11H6ilmipb3Z44OU0GjPw6f/BUijkZ5rU5QdRXPsHhaTi07354q09YipqFd6JsG1R6wE95cY1POxyDXl+eK9tsFbk75tBG4Y4T/m7tr17vbylsCPQJg9RQGREgxvf2bh/Fnu5F+HABnFWbGgd3HzldmIrrb/kV0sR0rGU3yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q79yJ+RdYT2gp0nDsuVDxDdOMA+0WDVaoUW33RKqvuI=;
 b=ZG6kefc5WKmH5F1spBgZR35vFq2SU8qSjCEN90wXwxuuDAyfeXcwotMIWwEvo4DLJZq3yxX2t+LB4LWDnK52BYNdI8xJI9/kTmdDQX9/TV69xs7ao3wNLrXUWrM/tGAljGIs3ewRbLlukARl/+M6W3RJ0W/CAKert1jXs2xj0TglKbntURNjWfDK7CAEby2ouPkwlGFP47DRf1OF9meOrN5/cIzP4tUNg5Pd23YYLDMjKd5EJ3iTQlaK3nUKOlc4Ua8wZp69SHfUd2+IC/pCIFVqKIK4Fcqdw58PUY7T7jX7eW1jYWZJNYiOfudj9YY25qCCam1v2iv6tTdkYToWkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q79yJ+RdYT2gp0nDsuVDxDdOMA+0WDVaoUW33RKqvuI=;
 b=QB0cj2za1DCaebDpnH8NuH8cigWJqxSBAM5bHMGJDo5ItGG0snCkk83xOgK8SNq/7cFwJgFxVReeoa3e5jih7ePf56gv1vFpgfBBuZcnrM8h9NVNUi7oFkhbbxaBLnnW7xV2cl6iczEzxpbzP0u0l3vExBozB1GcydKxPfo9iURJXxUyi0n5WodrJoB8J84gyuw4RN96DM8OAbWUHda9lnwTmqItkxdY+T6ocxwYVETE54U58GXBmk3x16DjpNbNpjIemZ0bOh1jNHenLcg+EcwzPW4V436LJ4D23NdhCsk9pg9EQW2URWC4M/zJ1TUDpEu0Fck5XF5muo27vQ1z7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT2PR01MB10604.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 14:06:54 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 14:06:54 +0000
Message-ID: <3a58720f-a572-4e3a-bed1-cc7e8f46e3c7@xiplink.com>
Date: Thu, 27 Feb 2025 09:06:52 -0500
User-Agent: Mozilla Thunderbird
Subject: General output formatting (was: Re: \b character escapes in CLI
 usage)
To: Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Jeff King <peff@peff.net>, Yaakov Smith
 <Yaakov.Smith@wisetechglobal.com>, "git@vger.kernel.org"
 <git@vger.kernel.org>
References: <SYBPR01MB579278DD5EC6E13CA9A213FDE2C32@SYBPR01MB5792.ausprd01.prod.outlook.com>
 <20250226073822.GA21138@coredump.intra.peff.net>
 <Z7-lbGnlzGbhrHZN@tapette.crustytoothpaste.net> <xmqqplj49rul.fsf@gitster.g>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <xmqqplj49rul.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0346.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6b::16) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT2PR01MB10604:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c2b318-1b7f-4ba7-33de-08dd5737fd2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mmo5L21BcFF3cHJuNGV4NGptdVlyVUdNVk5LbVJ4S2NwUlpITUpOeGJBM3ZD?=
 =?utf-8?B?c3dmK01UMU1mM0RORjQ1NDZCT2N4UXUvRzBGOENPMkdoYTJzMWNxRUt3MmEy?=
 =?utf-8?B?Z0Fqc2tCM050V1pJQ1pONFU3dE51VXc0alNhZGdocWx4b043WVRwZUVEczY2?=
 =?utf-8?B?NjlGM1pEbVI5NEpYNTN0c2NJVW1lUXdERU1RYnlJSTQ2Wk9kR1FVMkwycDN6?=
 =?utf-8?B?bHhkZHdmNUdnc2dnY3VxRG9sWDlnS3Z3dnR4MkhmcU1XL3pWNExNZlRxdzh0?=
 =?utf-8?B?UjBMWmtwejV4dUlVaERBRGtFSVduVVM0VXM3VlBWRVU4bnJVMi8vMzdYS0p6?=
 =?utf-8?B?R05uY3AwbFJBYXpQcUk2ZHl0UWtQZnQ4YWtidUZDNTNkNzRpbVI3UUJQZmpC?=
 =?utf-8?B?Y3R0aWhqMEcwcStsYjY0RTBUbHZFVGJqVHB6QlNEYWlwdUt0TmNuSDk3TEh4?=
 =?utf-8?B?TlpLbTAya2c5dVg5MnRTK0ttYkNMd1hzT2hkS0Q3MnBLQWFETmR5cDFvVUFJ?=
 =?utf-8?B?emZpSmJPOWFVcUdJcjBJdHNoVHMvWHp5VSs0dU0reDVRS0dOK3lDbE9MeTZZ?=
 =?utf-8?B?OXZWTUF6VHdIVlJyOXpyLzdUOGZVS3laejJ6Y1M5R2JKc25HMGlkQ3VkMlFU?=
 =?utf-8?B?eTR3MW4vVFlFaUNxWFRwenFnajRTYVFvUDl4c3NhYnFNVGZsd0VJbk1qNjdk?=
 =?utf-8?B?ZGhzZDhyNXRyaGNCTGxmNE5hbVE2ZS9mSkFpZVFGL2dxcDg2WWJhU1FyRW12?=
 =?utf-8?B?aG5MVlY4cWZRZkkxVk1ITkQ3b1ZHalEralVvQktDeTFOc1h6MFlDRU9VTGx4?=
 =?utf-8?B?LzNBc293K2dJTW9oS0tvT2JCNDJuandIK0NzbmQwd1Z5UUxRTHFXSWU1ckhu?=
 =?utf-8?B?YzhQeDNTeHViS2MzNXAzYi9oNGFTcjZYMm9wS29JVC9zUUdTZVluQVJ5ekd1?=
 =?utf-8?B?QUJRRHBpSkt3Z0hwNkt3R21VeVhXYXB4TUw0NERwbGVEczFrVm0xaThVaDdZ?=
 =?utf-8?B?UmZSdWszTWgxay9vdmd6NFg5S3AyT3YybDMxQWJtblRma01ZODZZbmJYT1VS?=
 =?utf-8?B?aG9RTS9lVTJ0MW9pb0FWL1c0T1BmZFF2eWYwVXFoaXJ6czlpekpqcGorbzBT?=
 =?utf-8?B?RlIrTUxNcHJBWWwyNzVQMDBpMTdJN3dxeW55VHpnMW51RTd5V3ZTM0R0UDBC?=
 =?utf-8?B?SmZOb05oQlY2cm92U2lPMG9xUnl3SHlXem1MNFhMQjNPY080Q2VHUmxkWUFz?=
 =?utf-8?B?dDhNUHNubHRLUkpYK3JvbnBvTmIrWWZoeXhJYjBieFJKekhMRnN5QUVKNVBa?=
 =?utf-8?B?OCtmbkJ6ODlNenhFZnRVdWQ4cHVWZCs4MVJCNjFuRFY1OXFobEpiMVQybFlW?=
 =?utf-8?B?NEU2Vk14QjZNT2FVNWtzdTJIVTc0RS9wbldROVFQVkt4ZTVLTnZDQmMwZnBr?=
 =?utf-8?B?TWRzRUExRzVFOFQ2cXVaeEhWd2xSaXk2dERvOW9wWmhzTnhSd1ROUjBQZ3Z4?=
 =?utf-8?B?NXBnTUx1TUZ2cEs5N202d0pQSFR2SHFzdEU1dmNNdkRpOFRLMjdyRnZSZDJp?=
 =?utf-8?B?Ym0zZkk0UUJPSnFDcjF0L0U4aDVWQ1lJMDBxbmtzOGxwbFRKYlVnRytRdENw?=
 =?utf-8?B?a3lCQzU3QmVTQnIwS1VZdmhwOTBrY05JVzlsVHlFeDE0L2VMdXpFb1lDVERU?=
 =?utf-8?B?LzBWZ3Arc203VnJpMkRYQ3J4VkpuYUdCNXFaek1wdVRibnVjLzdpYmkraXlR?=
 =?utf-8?B?M2UvaHJDWkR6NTdaWVZiTUdhZDd1cGw2TE8yVWhycWRDc2dTS01qVTk4NVVZ?=
 =?utf-8?B?MVNYNzJuYnErOTVoQVV3Qm04RzFOcHEzUldKQXYxNGp0dVhpOTJxeTF5emF2?=
 =?utf-8?Q?p5NGoZvG5qwcO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1A2aXdVS1dzRUgzV1hUUWVhUWdDNFhxcVVmbWJjRWFLa3orOE9KRnF5WE04?=
 =?utf-8?B?UUt3UWFkOHNBMFB0RWx4bWRvVTR4SEoxcVRtZzNMZEo0NHFWQ1RYUU5aSzBB?=
 =?utf-8?B?SENucFF0Zm1VTjNmVEpOMFFkaytXRTN4Zmg4ZmRyU1NGbkVQMGpCOTkremhL?=
 =?utf-8?B?TURnRXdZeUNyRFVMNWFRL3YyMEVuSzRCTUtOSDl3VGxOQ0NLelVWUGwzVi93?=
 =?utf-8?B?YUZ1QXdiZjRQelliam43QVBqWEFNaURQWTY2elBMV2plTWVMb2s2MU1uamlP?=
 =?utf-8?B?NE9nZkt0UG8xOG9zb3RuTlRrMHdteFdLYkdneTZiUExZUTFHWDJIV3YvdFZa?=
 =?utf-8?B?UVFEZ0RlMlJSR3A5UDdETTdNWGFVZDVFRWQzK25iWnA3TzhnUVBoSnNQYVQv?=
 =?utf-8?B?OVJGSjR0bFplTDZvNFhSc0ZFUWh4cUVIalRWZFZYZEZxY1NuWisxekhKNjRm?=
 =?utf-8?B?Rk5LcHRRODRlTU13TXhQLzNKT0RWV25DeS9CYW9vWUExUW5zZ21BN2U1MjY5?=
 =?utf-8?B?UzJaOU5SVkVodzlIa3Z2Qm5uczd3UGdtZWVOUzJnZHBIK3hCWXRPTHJHK3Qx?=
 =?utf-8?B?TmIwZ0tHRWNxUWdSZVhiU2ZvRnJuRm81TS9KajhEOXlnYzFaemxTelRTM3E4?=
 =?utf-8?B?U1RvNVN6VU1wK2JtcmxoTk8wY1Vya2dPTVF6bzdPYXhleUFmRGU4MHhhb0cw?=
 =?utf-8?B?amVjRWNjTlRYdEFHaUUrNkRVVEQ5QnllOS9MaEt6NFZuZ1B0OWNPZTlNSElB?=
 =?utf-8?B?eTBZY2RhbVZOSGIxbnRvNVpFeWNZcFR3cWJZUUdKb01TV0pocnZTQkpzQUhv?=
 =?utf-8?B?ckVDdStFYk03bnZMNlBBQ3pUcmtmMi82YmFvMlJQZkNENnNTajhyK1YzY1Z2?=
 =?utf-8?B?RWNWTEtDQkhvVVNFQklYZjQ3YVRRQWp1Y3lvNi9LTStLcTg1eU42eGdxUmxR?=
 =?utf-8?B?TFp2NkdZeGZWSGg3YVNid0IxTTdVUUNDSHBEdVJtU3F1U1NHbkNXMVhzRE5W?=
 =?utf-8?B?ZEJCblV2OVNPNVpEVHJRaERiOEVESkdzRFpIejdnK1RXd0xYWURYeTNwdGNm?=
 =?utf-8?B?bytHQ2w0L01JUUlkZWliR0RFRngwcWFvUm44R25BNE5hYkJVU25WQ015V0NL?=
 =?utf-8?B?RGxhMEN4TGhMRkxHcUk1Vk5yQ1UxM0NrWjNHU1oxdHdUcEtKVFNZdXVFYTdX?=
 =?utf-8?B?dW5LTVZTc1dWNDFlYXR0SWpkRTEwNTBKNm0yaGxybEkzTVZibENiaHQrTnQy?=
 =?utf-8?B?OTNkMHhQcHpjcksxZkV6R0xnTldIRVBPOUFlMmJOVm4vTWpzQ1pLcHd3REd6?=
 =?utf-8?B?NHhFR2s5MkU0VjhleFJobFE0TlI3WHF6WDJFeHI3eE1weHlQK0g0MzNFS0lX?=
 =?utf-8?B?cU56VXhhME1VRCtBMzg1NjNRNWJIdmQvMVFWRVJxQzYyZzV5T3pHQU1EUkFQ?=
 =?utf-8?B?NDRWNDEwWHZFL0svRWJQckZMZFpIVitqTEJ6ZVlUYjNlU0xrUzhwdGMrdXFR?=
 =?utf-8?B?MjFCZW95aUVSYTVtU0o5LzRtREpGZ3N1ZFpzNG1CeitlNFNuVVNXT2xrcm5v?=
 =?utf-8?B?N2YxTjlBY2sxajMrOEhqdER5KzMvOCtYRk5QY3RyNTZSNHVoV1FCWWVVbUh5?=
 =?utf-8?B?bzc0ZzkzcEJwTFp4TThUTE1GRHlOQ0JwSFU4RU82MmhQd1hhTFR1d3BiOEVI?=
 =?utf-8?B?YXNtVTJkcG5PZ015aSsxOW9mc2NLZWRyeTZLVlZhUWdCRDhlcXRuOFNsUFRy?=
 =?utf-8?B?d0cyL3BVeGRFTDdVNFBNSnZKUHBKV0x4TVF6VzhwZVFqY1FuV0hRNjZUc1U3?=
 =?utf-8?B?RHFGWWRUM2hEL2xqUFZMckZpbm53cVAzdVVyNTlPZ3QzSDlKSFdyeEdtdGNQ?=
 =?utf-8?B?OHViMTFPUlNQTUF2Yk91OERhVURTS2NYcXFkRm9JSW40cnRkTm1mUHdQYkpN?=
 =?utf-8?B?RkxQVE1MNHZTUjVadzVFUEkxb3M4T2hOSG81T3RUMFROSEx6bk9TK0hITFVk?=
 =?utf-8?B?cDc3U0REZ1FrWjJ3Wk80TDZBcUdNakpFM1ZnWGhFeStLaXgxNkF1eHdrcGNw?=
 =?utf-8?B?UkdQSE1SQWxWNStsdWxPUElNNFhiak1JM3poZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c2b318-1b7f-4ba7-33de-08dd5737fd2f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:06:54.0706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YO7m+f43d5oBRgheIJfacWuiCJGh283To9Andm6W3+0O01Rb12W3hDpGt5wud277T3XZQ8EE3ZWz+P/G/9GHJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB10604


On 2025-02-26 19:03, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
>> I agree this is the right choice in general.  I wonder if we might want
>> some sort of human-readable output option that might escape these that
>> users could use.
>> The output might still be machine-readable, ...
> 
> I wonder if isatty(1) is a good way to say "ah, we are not captured
> in 'foo=$(git blah)' and not feeding somebody in 'git blah |
> somebody', so we do not have to worry about being machine readable".
> If that is a reliable way to tell that we could butcher our output
> for the sake of keeping the terminal state sane, we then can always
> do the C-quote escaping, or even information losing '?' redaction.

Modern practice seems to be moving towards explicit format options to 
let code that's parsing output directly specify how it wants to see the 
data.  Such options eliminate the need for isatty() heuristics and other 
guesswork.

For example, the ip command (at least in Ubuntu) accepts -j to format 
output as JSON.  I've found this to be immensely helpful for my scripts.

I'm sure Git scripters would appreciate something similar, perhaps as a 
global "--format=X" option to "git" itself.  isatty() heuristics could 
still be used when no formatting option is specified (though I suspect 
in the long run the default will end up being terminal-friendly output).

This would certainly be a large effort, but once the basic pattern is 
worked out it could be incrementally implemented one command at a time.

		M.

