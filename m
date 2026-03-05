Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010003.outbound.protection.outlook.com [52.103.67.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9633D9035
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772729671; cv=fail; b=KFWUpytlS0SCpL0J+lsboPjS0vb975xvfloV/2Lwh5d9vjAE0WG2e1fYw7fJ5Z2rc5DhUCa1094LTStTFn3fOnhbQDbH6jCC3zxhRVT8rz9MFNBsKi1zUFRkGe50z0jR5k74dDow14jUxfsXuMLaeJSpP1r9XTnPp6wjPOtYxJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772729671; c=relaxed/simple;
	bh=LOHst5lJSaZ/k/JG8C6eVMYjErhjDN5l4mwHNMcdj38=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TwPdB3fxh6sei1EWd7LuwH3Msd12I61FNVffp6c1caRhZ8CXvbXSvPhDP1Qu9T/ei1ZiDprLYk9pukCGTeJhIX6nm2NKjKISqaGVqS33AwMhKazlPpq3NAEMIusKhmqtA4VEA3TKUxKaTQ86sfvTOoCnzdHQS+jCbI7tZyZGTd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=iixNFvgN; arc=fail smtp.client-ip=52.103.67.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="iixNFvgN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkGrtTcWPME84NXw27BTeDiOvUwv9cp8MuRPOrLAfp3O1p6usu8DXsB6YXOBpfVq5KkSGDouorfnV1E7jaM3jNWcJz8lLCysw58Tt1dFISpyjrbNsZwlvQBytGXWjoxACfXCn75n3gFwerwbpqCfz6Mv1rnKu1QcSifx0RPCwKO84cqI5aX4ufDdOtxGJgy5bA/MTrgZo9HgYgytmWTsRptD5i8YQHxQi2uHke8HzPPKgy85td4eF09xSPVrDkPIJEamn7XnDy3C8P/AuyA/o/8vgVB34CjDtUlwuWJ4VdcxIVUqGrHlx6TW4JxaMzg+8m0WCH1eRiDW8uMSFc3EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFBYFwCMNh1rNZt+jKZTWpz/JDgAMta8kuYKaB+wtHs=;
 b=ixrABszKDbDTNKXqMCJFI6oB6VKZNpcnCw9lPfE3zAcDDVsxIHHvIBYVx00s/JFkpKKc2d780aiOgH7oeshJmjZ4xAVzFmB74Zc4NkW0reuVO1DSgrQ1FVh4vRmnYtfrkH8d0yTeb2SHeNC6JAZgPsWqMfehf/2ZtPzbf0k4Rniv1AejvtXC/D+iWNWtlQp1wI7hk/mMYp9ktoqH4FoR+GPMtu6c8ipIW4cZUdRYMxHBKTy0G6AoR6eQoue1eLvbLcdGpc961jUUBlK5wig1uNLCB9hIVLotJUBZGbKQV2aL+dTGZNNYBmX2DtF6W6WKJSFPP/qBvCjSN65tEE664w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFBYFwCMNh1rNZt+jKZTWpz/JDgAMta8kuYKaB+wtHs=;
 b=iixNFvgNz0hzLwGebe0aMhIviY+cRbOI2V8vc3XkAzU2o00QDPH6NxSqrUNhfyGq8k5Pc+CYbprLparNmzv1nRXNzDyjONGrZb8ynyQCULo7Vk4SF6BU0n8wgRh4sqce7a4wwXT0l4I3K6FDHDCac3fk4tiARpWb3GPtoQIwM0k+wr/jeprgoa6jUMRFh8iyIeRczejhquwliZqkGMBQLISbk84135Y231jaTkX3i5hmGMD+5cyUN6jcaGJ+xadXGYPsRsXUE2Xnh0TdpvUN6uROjV3zl5LSrTnYMp38eZ39g/p4JlvQUfRQldsQxxsChRO4MV46ucwiZEjbSa6mog==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MA5PR01MB12479.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ec::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:54:26 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 16:54:26 +0000
Message-ID:
 <MAUPR01MB1154638D0656DAC084F4EDC73B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 5 Mar 2026 22:24:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
References: <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <87ldg6jpy0.fsf@gitster.g>
 <MAUPR01MB115467BA486F4F9B4E6829D64B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqms0m452i.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqms0m452i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0164.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::34) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <7a7460e1-67f5-414a-af17-d416abafb53f@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MA5PR01MB12479:EE_
X-MS-Office365-Filtering-Correlation-Id: d48123c1-ecc1-48fd-a8e5-08de7ad7dbc5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|23021999003|15080799012|6090799003|5072599009|19110799012|8060799015|6072599003|461199028|25031999004|51005399006|19061999003|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTAxMjJzanp0N3JtQTl3ck5WMDNVME5pRGtLcjhadFlFN2JQbWd6NkVXMDFS?=
 =?utf-8?B?WDVhK0c3TndWZjZQenVTb0F4bGRxVnpxeGtlQ2ZpMFM3cFJJalNyS2Zoc1Fk?=
 =?utf-8?B?NWZJZ1ByTlRJYlBVN01UYjQ2c1UwQ2pDZVhCR2JKQm9aR3ZNY1hVSnBlZlp6?=
 =?utf-8?B?N3o5V2RUbEJTL2Fqdkw3OENWaDZLUThmUnRkdGlFdyt5VkhvWXNKMVVCN3BT?=
 =?utf-8?B?aUYzcGxtV1RtckNsZ1ZJS21VTGVrOFpPTndCU29aRjFjT2NqU0JNN043REV4?=
 =?utf-8?B?UWJpc2Q3MHFVaUZ4azBjUmJMWmhjYUlUSW4zWXlCWTdISkd0S3RFczREdGh5?=
 =?utf-8?B?R3RzT2lWTUdsTE9HZEloRmF0MndXME5wNjZGenRTVmg5b3ZZRHU2Z2ZaVU5y?=
 =?utf-8?B?Yy9kZnhQWjdEaENXN0UrdnVYTFk0QXdLZjI4elhPZTBHZ0dUU0dyR2luK0JY?=
 =?utf-8?B?UUZpY1d4blZrSzBYS215enkycDRReUVzR09BYm1TNVRGbmNNTloxK09uR3BS?=
 =?utf-8?B?Nm5tVTN4YkxKNXhrWkljZ1N5cG9pSVVyRm1nKzE5UitUbU1qU1pVVk1JU003?=
 =?utf-8?B?ajR5dGM4eWIxR1hQVlMzTkdzWmtHdVN2V0tOY3ZVL3JuK0IzeElBekJoTkdV?=
 =?utf-8?B?U0hCMHJOMWtocVY0QUJ3RjU5anVadlkxVFd6b1MwQzJrQjZpbVZYeXg4VUha?=
 =?utf-8?B?ZkxJd2NQRittY1Y0Zjk1LzdGWkVDREJyQ0MxUWk5elpuVmVhNVg2RnlYckZC?=
 =?utf-8?B?ZUNhVDJxL3l3UlVrV2lIL01nVVVQczhIS1B0N25IT3JGUUdOOS9PUEdKS0xM?=
 =?utf-8?B?RDRoV3VLTGR5SVFMVWVrVENEN2xjN011NGJJRXFJTGZIY2czZkZyc2RMSGZX?=
 =?utf-8?B?OU5qVDlEU29SY3pFWjBSdnd2ZjN4cWVmRzBnVU1MQ0dDRHh0amFDN0M5Q2dT?=
 =?utf-8?B?TjJpS1g2ZUdvcnNnSUduZXplbUxWQXlBaHppclB5Tzd0dUk4VTdtMVovRG1F?=
 =?utf-8?B?L1hYK0FKTWN2ayswRG9hMThYRFBVYldNNSt1NUc5QWppTG1DKysxN0w0UU5v?=
 =?utf-8?B?dmx4WUhNYlhDaFp6RUttT2psRVpjUThqMDlYMkN0T3owNStoNTdOamNtYkRW?=
 =?utf-8?B?MlpXNVNmdkl0S3FKM2hwVlgwdEdiNUdlTHE2bXcydFNUVFd6am5qd0JwbjNt?=
 =?utf-8?B?bnpqbDQyZkd5OGZWMjZiZzRFYVBzdGhWc2ZCcHlNdEZRVG9lRGU1UHhxc2M2?=
 =?utf-8?B?bHBXMHFCam1DWFhQVGRRU2R4M1Y3VU9QNzBCaEFDKzJMRUNLdnlhS0tJZitl?=
 =?utf-8?B?bXV0VjV3RTZMNnJodFRrTDZaQ0RXRFpTZGlMT1lYQjVQVVNhdnNrODNucnhi?=
 =?utf-8?B?R0t2dmpSZTF4RXc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHpNcjVFNGh1L3B0cVVGcFdzQ2xGU1NzVkRuRnJRWUdBZVoreHc0cC8za3gx?=
 =?utf-8?B?d0dUUXdHTVBoYzZBYzdEdGIvdmJ4a3BVZzJIS0lsYnB1L1NBZUI2dkd5a2FF?=
 =?utf-8?B?ZlZ4VFFVMWIyQTlyVG4wY1dad21VUmcxZlpYaE1aeVlpeGFoTXplZENlaGVB?=
 =?utf-8?B?dXlJYTN0RlFMeXNXQ3FDZmZkdmRjWTNrZEtPdlhYd3ZnSmVGdktWMlYyRU9B?=
 =?utf-8?B?RnJwdkVWRFhDL0N5SUpWUXQzQWJ3MEcxUTZDRWxvSW5Vdk9ZR1JwTUdIOHR5?=
 =?utf-8?B?NXBNaWo3YmM4UVlLSFFhZ2FTM0Zxd2JTRW9iUnhZcmZ3TzdQQnZhY0twcS9n?=
 =?utf-8?B?OXN4VElSTlk2Zk5VQjRyYWZTT3d3eDU4UWRveUU3MFdKQktKYnNVYnF1Z1JC?=
 =?utf-8?B?L1FjaE1tRE9UazZ3NVFKWVk0c3pNWXZYekhtUytsQWVyVzBhN3B5TVJROExP?=
 =?utf-8?B?bVBVd3pKVkhCNkdGOHJ4cDlPTWhSdVlZRnhNT3RlaEt1enIxTk9oOU9rRVpI?=
 =?utf-8?B?WDY1YmhnK0QvcnREaVVZUk81d2lFWVRZbGt3c1dQdUcyaitrVGZQL0M1T1lE?=
 =?utf-8?B?VzU2MGE4eStTQjhJemRPSmRZZ2ltVlBDZGJFRjVOcWhVbG0yMjBUSVpRb1ZE?=
 =?utf-8?B?dWhUanl4OWpJeVNzM3lzYVBuSTVOYmJMdUpWek5ESFR0SjF1MThIbE5zU2h4?=
 =?utf-8?B?RkJ0aklZT2tXVEg2SXMzVnRnbisrem5hUnp4K040NFVoNGNLVG1TejkxZFJq?=
 =?utf-8?B?UWN0UkJTWWV0YVJuNjJsS3FQYWVkVnNFYkVIRjJLNWtJSjVFZ3grK1B1cFNh?=
 =?utf-8?B?UHZzcDh3aHh6OFB2Q3NxOVltUGF5ek4xZ1pyMzFxb1k0TWgvQ2dmcE9qN2Ev?=
 =?utf-8?B?QTRKMHhuZFExdnBIc002aDVWbkszYWFoaGJlaCttK0FNQWN4a2NjdXVCTGZq?=
 =?utf-8?B?QTRsVjYvQkdqOWVEVzJZK0xCTWN0ZUJyem15YmE3QXBnUzVycjlLOENUWVhk?=
 =?utf-8?B?VkE3TGxFRkdremdqUWVIeEJ5QjJYWDkwNHVHLzIwWVFVTUNWbGZvUFZMR1pF?=
 =?utf-8?B?S2ptV25zbFFHMnY4OUpOY2ZYOTdpZjNlUUJVZURtcEdpeFRMT1ZtOGxYRXMr?=
 =?utf-8?B?NHNjK2Qyc3ltQzkvL21yRWRmaTY1cnZhYnpHMXVXZGNUZDJ2ZHpvaGhhN0Rs?=
 =?utf-8?B?MGF6dndGcXJhc3pDakczTndmVHJJeDh0TEVUTWc4MUIyL3NvQTdUVTRGR1Br?=
 =?utf-8?B?R0RGcGNhWkZBN1d5ZEowZUNOTTRkTFlBYkQzRDRGMEhZMWV3K2FzbFduM3gx?=
 =?utf-8?B?L0g5OFUwMjl4dmc1Mk9OcjRPL3hTN1F2VUx5YTAzOTdUWEJ3RTFKd01qL3k2?=
 =?utf-8?B?NGd2ZElWRmNxRnljZGcrQk5Idm1nekFFSzRvQmdKRVpML3BIRzM1dUpHb00r?=
 =?utf-8?B?L0lpWnRtU0JYMEZSSERzcGI1Wk5ZUDAxQ3NZUnRPTkF5aUhQL1QyWjcyeXJQ?=
 =?utf-8?B?SlNwdFRTY09LQU9icFNuTklIQ2NHNDNpREFMVmhQUmxabHFEbGduakhjNDNN?=
 =?utf-8?B?Ui9CWU5ERDI5ZzNXckhCMWpMeFlIMjFEQk5LR3NzWDZHWXZ0YnZKaUhoYnJr?=
 =?utf-8?B?UHJaN1VvYXo0VzV2anlFZUVaVmp5cUUxaytjWm5IM2hsVXRDaGhUcDhranp1?=
 =?utf-8?B?SUpSVGVqblBnVHFkNThoWHJDNzBvejUyK3VLa0lkZXd2Vm05ZkZCSnBMaE5W?=
 =?utf-8?B?N3BmWm9hR0JpWkF1OVdjN1BuWlZ3V3pjTHhURWQzdHo5Y1NZTkdpc2hFVCtj?=
 =?utf-8?B?dzNUOXpSK3RPQjJISVJYVW55Tzdyc295NEVnMHFiT1lFeEZOMGVDdzJyTWdD?=
 =?utf-8?B?V2N5eTd2MmtNUDhrT0lXejhiaThKc1dyamhaeFl6QVdocGYxemxOVWlrbDBO?=
 =?utf-8?Q?0XmgcOv2djCqHtwP5s5iQWCWF4wcczii?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d48123c1-ecc1-48fd-a8e5-08de7ad7dbc5
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:54:25.8771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5PR01MB12479



On 05/03/26 9:54 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>>> On 5 Mar 2026, at 8:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> ﻿Aditya Garg <gargaditya08@live.com> writes:
>>>
>>> [administrivia]
>>>
>>>    Please do not send patch e-mails directly at me, unless you know
>>>    that I am the area authority.  Initial submissions are better
>>>    sent to the list on To: list, with area experts on Cc: if you
>>>    know or found out who they are.
>>
>> Oh sorry. I just did whatever I did in my previous contributions. I didn't know the rules changed.
> 
> No rule changes as far as I know.

I had sent several patches for send-email and imap-send between 2.50 and 2.52, and in every submission I did email directly to the maintainers. Maybe you were just lenient with me that time. Regardless, I'll make sure that future patches are sent only to the mailing list.

> 
>>>> Starting from version 2.2000, Authen::SASL supports passing the SMTP
>>>> server hostname and port to the OAUTHBEARER string passed via SMTP AUTH.
>>>> Add support for the same in git-send-email.
>>>
>>> The proposed log message should answer these questions as well:
>>>
>>>   What happens with version before 2.2000?  Is it safe to
>>>   unconditionally add parameters like this patch does, and why?
>>
>> It's safe to add parameters unconditionally because the library
>> will simply reject them without any error. It's basically like
>> declaring a variable and not using it anywhere for older
>> versions. I have tested this with old libraries as well.
>>
>> Consider the fact that the authname variable is also not in every
>> authentication method used by Authen SASL, still its declared
>> unconditionally before.
> 
> These are good to have in the proposed log message.

Will send a v2

Cheers!
