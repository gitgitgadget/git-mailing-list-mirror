Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011035.outbound.protection.outlook.com [52.103.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386B6280311
	for <git@vger.kernel.org>; Wed, 21 May 2025 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747855445; cv=fail; b=trtfcNa8cEt3aIafwp2p3dbJvOwPObD0OSXOmpaWcw5npL5TKj+yWJXi/itXaoq2PCCqJiUYqfeMNYxBkDY0JLgITUXxpPLK8vfO5mJVtVrQ5ouf8dgRRfz063GeFMUCBqQ0UWb50A/OVEo+BcxHgJJD/yGj4SEr2RlWzSWcFaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747855445; c=relaxed/simple;
	bh=cieNvqWqlVnv33vWIRg5STmphF7udWpSUbxFP5TKay4=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=mF55MGJwQa7NQXxfLjI+kIfk6s9ZhpwnXWQDMbs0kZ+ASomWnpxZGljF5neLAmo+6to7fqrmi0zGutNxB1LaAjO2abxsbtPjra+Ihi/2LZn3KvtZlDjxeCrqmdudN7MK+IkxgwvxgtXV1rGK9dxDcZBIgsPBaB7li8Pwg7vYO94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TbfPbQTF; arc=fail smtp.client-ip=52.103.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TbfPbQTF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITihpBOG5wSnN/wAh2qdb4707wnBr9PH1wM9Hd/Pv3QufWCg37BNppJHwbB7kpzToZlSTbNUgleIroCq6WIHW/EWw1BtlBVtz1mUO5f/6vaU3WcwBTZrCsQ62Vxk1ogFw+Ynks7lBK6/2yxnqP+SL2uL8KyVff5aihO03v68sGqHOi+TcYRwlMFr5F63RCNsy8MvZ60gAONsL1mfBfKT8mo/M1QpOE74nER4w5wRd9qU2Q+CdfA/7rbi7Eea9wuqjr7OXqu72Zr+M+gz3ZFHPnE6M0Xerwxg1Ryz5ZGUtF2kh8b17/8FlbZ2dB3DkaAOo8s0U3wzgXlP6wCT5e22Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cieNvqWqlVnv33vWIRg5STmphF7udWpSUbxFP5TKay4=;
 b=JiRM1OuWfkDz9vy2F2QULt16W2CXMd87DMLcyCDChZfqKGWYiTQj3KAVuT4isrYntWJ6kXG2mfAU0U8dK/ven22HYT2tSMSF4K6gUWap1khn9kkhDTMVayGZ73CxQt0biSHudkkqSbh/RsiADYYj/UzOc3LKDux0v7j5hQRsU8OsoNDbcdfNz/DEfXHdn3bxVyBRBiP4xOnTaw3A0jl20tmfBg0nDG5s2Tfke1qGshy6qHJ24xpuLghmvrkR7t23PeY0W8p1Tegn28NoIS14bDyKI028DIUgz5XG8ZtaleXVRIJa0Dc0BM6aMu45MwYwp4VKqDVCxHZFa3W1PE/G4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cieNvqWqlVnv33vWIRg5STmphF7udWpSUbxFP5TKay4=;
 b=TbfPbQTF7e2g/X0jv7FycMkuabONi5p6R8vYH8rHi+vQG1v0Eg0dKko7zMz7rfSVmhcuRvIOQmcp4qdKiy3Po05BSPHl3tbiqnJD/GRYBfP+B25j7aolld0mR8grCK0kBdw3JXecEJKarm42Jjr8yuS/VN3QriRLjdaKuJKdcpD0Vw6u9/rMCRib4reHfRtiQnRRW05dTnkzl70kqJISILsNiDwb+709qPKzfEMy9p5HyqX9BvgzXeH/9WVLZrwWM/b8OIqUM99gSUubDgGSFjS7vxBJfPpQDGzE2QFYmdsyUTncsrdrEcIZQtMFHiETf8SPwKiVkB5vUYzIZ2gSRw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9069.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:167::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Wed, 21 May
 2025 19:23:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 19:23:59 +0000
Message-ID:
 <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 00:53:57 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@live.com>
Subject: Add git imap-get-recipients command
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0005.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::18) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <bd40f2a0-0fbe-47b0-bcae-74aff4f3b095@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1986d121-155f-4ff2-9b6f-08dd989d0954
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799006|15080799009|7092599006|8060799009|6090799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bytrTlpjVUNCMlJYMklDcWtBQklJZm1McjZvRzFNdkZjdWlzbFBTSzFQQzAw?=
 =?utf-8?B?TWNZMWVxektEeTJKUDBXTHdPSVpiWGxMWDRyMmlWd0g3azRKK1hEeGcwNUpt?=
 =?utf-8?B?NnFCQVZwbXZhWU9sSmd4OWphNzNtcjR5SDdXS01penRER1JtNDluYXJZRk1t?=
 =?utf-8?B?ZHpHOGNPQ2pNdFlZWGZCYVM4ZnM1MFo1eUxGYm54MnF0OVl0bXY3ZFNqbFVs?=
 =?utf-8?B?SDFjREtoUHNwTC82VE44NUQ4SXNMSW5qdWFpQmZINUh1NXdDTmJYdTdUaVdk?=
 =?utf-8?B?M00zZ25QVG1hNTJIeVN0a01BcVRrWXFvRFdxTDk4a0l2VGVPdWN4V3dmK2hm?=
 =?utf-8?B?OWMrQlhQNms3Tmp4YUVkQ0NUYXNtSUF5TDA5MVhyQmUzKy9XeE5mZnNjY1Nz?=
 =?utf-8?B?SUpwZzVCaFFxalNxQ2RyTHFXR1ZZdG9aeGFhcDBmbkxiakpJeHNPTGtOK1Ay?=
 =?utf-8?B?OWZYSi9QUW5pM1E3NWZyZU0rVWl6OFBzSnJIeXErd3NBaFJGalE1R3pkcDZ5?=
 =?utf-8?B?by9vTHMyNnpSOGMvSzFka1MrODM5U3UzMW1NUXNHckxjZmN1djNxeWJqLzlD?=
 =?utf-8?B?YTQrSFlTUm0rSUZ0ZDJWRENaa0hxaVZUR1pFWmkwL1R2azFqQlJuQi9OamVx?=
 =?utf-8?B?dHpDbFZjMWZpVDBzSGxIV1QybERKZFdMa01KWUQrOXVjZXhWcXVwK3B1Z1k5?=
 =?utf-8?B?aUdYQ0o1bGZFRG9vYU5RbWFJMUNyZUIwdURQVHZpR05uWlY3OTBBNFRzQlBD?=
 =?utf-8?B?RElYdlYvUVNKSjdLejdxTGNwSkQ3a0FyYjJUWWVBcDc5TGgyWGZ4ZHYraFNO?=
 =?utf-8?B?azZoaWZmWjhlYWk1bE91TWU0Z3ZpbG9PcTRjL05heHU1UEJMV21NNTRxY2VD?=
 =?utf-8?B?d01qUHhTQmRYRWtPU0NuRDZseGtPM0VnNlBpcVp1ZmFUbTBYcDJxNDhBWkt6?=
 =?utf-8?B?dFZITmZsNGNiTXlCYjBXYVFCWlBObTZ4bVVNNVp5YjhoT3NMRVdWUlc2b0U1?=
 =?utf-8?B?RzFrTUdOUS9LclFpTUZkamo4cmJUZDExM2ZMbnBhMFg5d0tpbXVYRnUxNnRX?=
 =?utf-8?B?OXE1ZUNYVk4xeFNnS1d2cmJtZ2lhUkc0Z1cxaXZFUUI4b0RXU2VteDNUdTZF?=
 =?utf-8?B?cThpUCtabm9aVERqK3Z2aU1uTW9lWlZCYmdqL1pKM1R1Zko3TGE5U1NBR1RJ?=
 =?utf-8?B?QkdNdlI3SGo3eWJiak1DdnhYeTBrRjNnWC8zNDF1WTJURk9UNlIwSVNHT1Z5?=
 =?utf-8?B?dzE3RWRHMkFBWXRtWVNFNTdKMlYzOGJmYlZJVHRwVHAra29PQU1CSkloWnVR?=
 =?utf-8?B?Z2IxUTNxa1FDLy9yVnBIMzFQWWUyaThmcXhrVjFuN0cyNDl3bmlDL2MraWU4?=
 =?utf-8?B?aEJTK3drRWNBQjBvc2EweU96aWd0ekMvNUZkdUJGb2RwdTg0NEVYUmVLMmRW?=
 =?utf-8?B?eHgxRVNBdVJjVW51YmU1aFI4bVhkQUhtZlhCV0NvRk9PM1JrV3Q1V2JCL084?=
 =?utf-8?B?d2c3d2FBRFVlakhQSUxDSzR6YlNpYUhldzFZN0w2Q1VJWVcyZ0ZJVElvTmJK?=
 =?utf-8?B?ZmhIUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm1hWnVaajNqaHBWdEdNUUpTcjNweW1pUFhUZVd3VTFhRXI3Z25CbStQR3JV?=
 =?utf-8?B?OFZoTGR2bHRBcnJPaUtsU3QrVmdXNmNEUS85UDJoVTU3eEVFNkRrZ24zVE1W?=
 =?utf-8?B?cU0xZzZzRWxCamF1RzJMUFpXaDBtNEo4amN6Rmx0NndpbnFTdDVCb3l4MHZ2?=
 =?utf-8?B?T0hBZDZUWG1ZOWFwOThQUUpaT3FydmQxN3pzQnV1VEN5bXlnRDNXUyszSndl?=
 =?utf-8?B?ZVRTa2hLVCtvQ0RQWmUxb3lBQTRGWWRpcDUzYXY4WFdpSXd1WDNJSzRTN2Q1?=
 =?utf-8?B?bUNIWDc1dWRQeUNMNDZ3SXlONVRIUnptN25HV3dJcXlmYUwzYUFBVEpKTnY0?=
 =?utf-8?B?ZVFNRXZIZUN4UGdibzQrcUl2RTdCenRoU3A2WGk1YmUxVTNjY1NjNmZodGRR?=
 =?utf-8?B?TnYvY0JsRkxwRU9UL2V2K0V1VmNFU2I2Sk92MTMzVWF3Q1oxL0YrZFhBMi9O?=
 =?utf-8?B?ckovT1FiWERoTXVENUxyZnhrdCtvTFhsaXJzemRKSGxEb1c1amY3L0dSWWdQ?=
 =?utf-8?B?RUxhODJLWURTS25nN2xRTkkxYzFGaStwbkNBd3orUjZYZ0xUcVhHTkxreHBW?=
 =?utf-8?B?b3cwQmJzVldlUFlGK255Rm44OWxlVVJ4ck1HaVVLc1c2cXdNaVFBeEtOYkti?=
 =?utf-8?B?Unh5OWxNazV0S2NDb052c1VxSkU1RjFiTU4xeWVOT2V4My9YTHZZSGVrTkIw?=
 =?utf-8?B?ZXZNY1VwaGM2c21uT2l4akU4S0FiK1dPdktXNHRJYzBtVWFabXExMnl4TnFF?=
 =?utf-8?B?MFAxQWJ1bEVhdFNoYWZTOHZvdVdycElqM3czR1A0LzZvVGlkL0luY3dJY0VB?=
 =?utf-8?B?T2xLY2dDbzB1aWtEVXNTaVlGYUV4Vit0UlgrQ2EwWEEwMEVsY2RrOFlnaGlI?=
 =?utf-8?B?Q3FqY2tmVWpyaVVFYjlOUkZyaXArTTk5ZEM2djYzdlltOGQ2WElVRk5WWWtC?=
 =?utf-8?B?Y2dJWDBldjJadGdWUDNjNTl4L2psSVAwb0hVSktrOVd3SFF3RXQzdzVabndS?=
 =?utf-8?B?Q281KzhCOTYwOVdYa28zSk52UnVMKytHeVZKby9yTGs3V2lRSndxOWdQelRV?=
 =?utf-8?B?b3Brc3h3Uk9kUm9GV29PeHpDTXVKaTk5QVVrUW1ma3ZwRHlrK2ZlaUhRcWJx?=
 =?utf-8?B?MUh0cHY2eE1OMTloYjdYeHhSenFNN1BYRE1yT2JNRkVQSExaQXJnbzdBNTI0?=
 =?utf-8?B?T21wcFNKcnVsWitFdm44OUZ0eTJFb3ZaR1BKMU5OYkFCN2hSY09mUUJiakRS?=
 =?utf-8?B?aXR6d3lxMDdSRXEzeDZLdFpYQkpQUVFtVDZhd3dnblFFLzhSa0JvS3NFTlVR?=
 =?utf-8?B?TVNNRXRXdVB3R0YrR1NtSk9qWHlhU2doQWxVdGNYNFh5TXJ1WjB1Uit3M3JC?=
 =?utf-8?B?bVpGY3dMMDhGUG9WNWs3MkNsRU00WkhQM2dvZG03bFBRZnY5RXFqZVlwOHR2?=
 =?utf-8?B?aFgwOVppcVp4U3pVejdZVUUxYmpla0lYQ1ZQVVJsZVFDU3k4UUVmKytPWTJl?=
 =?utf-8?B?L1ZnTC9rWlN6cWttT3UvUzVuekk2Z1FLQzI2RXlFNlQyKzlGUDdNWmozM01M?=
 =?utf-8?B?UlRSVGdpNXZUNS9jNjlsSnBaN0FSdjZweURwOVV4QmtoK1lPSUNwU2tQUGZl?=
 =?utf-8?B?SFQrNFRvOFlTZUVhQ0lGczcvZHpKUnlUczVPemNoS081NDd6Q3F5bUtnM2pK?=
 =?utf-8?B?QldnWlI4Wm94b2wvdkYxcW9OZTZza21vUkxlT3krZld4Skg1Rkg5VzE3dFpp?=
 =?utf-8?Q?DrKunboKY5hAELomxU=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986d121-155f-4ff2-9b6f-08dd989d0954
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 19:23:59.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9069

Hi all

I was wondering if it would be acceptable for the maintainers to add a git imap-get-recipients
command.

I currently am working on it, and it would be a perl script. It would do a very simple thing,
take the message id as an input, and output the To: and Cc: recipients of that message ID.

This can be useful to be used alongwith git-send-email, when you send a v2 and you don't have to
type all the sender mails again.

I got inspired to make this when I saw that replying to a v1 in a GUI client was so easy since
all the recipients got filled automatically.

I currently am using a basic version of this with the --to-cmd command of git-send-email,
but can polish it for git.
