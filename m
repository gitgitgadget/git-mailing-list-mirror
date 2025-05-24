Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A31DE8AF
	for <git@vger.kernel.org>; Sat, 24 May 2025 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748104214; cv=fail; b=tuSXtHFYCXVY77udYX9TTKOIo9HHzdrfU/vD9YQmZyjnLnkT7dxtfdI7/EvcH0OQbuccO+oanU7vLTovWnVQWsa2ZKI1d7fEv39qcfsfpzJDiZbQtg4vz65gGNDBFFVi3KICvvOGeOcmgkVOPsuSatOcHomFZpRpC3m/DLevZxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748104214; c=relaxed/simple;
	bh=G0z2JQwbkFHpyK9UEaIOCE0+rDa6dCCoJEJ6RtE/t+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=up53/FuHK48GafcQ5ulWg33NWOqGFDaQEh4qZmkThd7gJc86y5SMtLGTSNWGwyDU+JBVylieI6I5JyHkRCUFyHECmJzDza7Dpw3Jro/scnOIREt5O2MB0GRPHY/4Ygpr+BppQ0zKL8akogTVLopCVnrq6Rl5wyjfj9gsHgzbME8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qQSTvAtl; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qQSTvAtl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzejyLWKiJb3d3TYU1Aw7nipigaLbnyKXBZa3utrv9WgWIoModdHfsjP83rLL+wS8bVsBacVg4vkzQKBeJKIpMNIFt1cu8PiPfqOnkAHWrSpNuOroh7j4s8u1jKDBxNFxWbup5nWX/MLK2zPt633tnSVZz25ze5x/Zg8LAjmN7k90rkbQ5NrnvOoi0pqViQ5DgeqhjZxQ5sTz2Ly9DB21DNP8IrytjCgd8EwwZK66KvR/khDdeBkcPdPs8gwntuRxE1XAhyChl/rz0w+KHJ+JgiE6I4H/Pv0MQmOU62oQWzJy19Y3fOz//B43an1pIW2My3l5xIZzw61B4Wc1C+jMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2yT/jvGa+atd3lwe+oMKy+NQA2f/RnYyBDTgVkuEc8=;
 b=sZykvdTB1HOkyS/dKZLcR8r70F9oPFYPZbb0XrF6hllVePKSbhkrFq2DQS/TmbqJXNcQ0CQx5bttKOUc9TjabxSm7cbmbp1grB5BP4j3enwKjYdPUL8WyeHVrHvIjLrppq2rRELRyJbRLrxnb2m5ZYJ8ZWsje+Cgei/ZxJKo7Vw1DKKz6yWJXBnhrgKgP0YKpgSl4+mgNr6CYDpNVrc6D2a7/TNorX3OB9M+QpURcHZzxsxByuracAd3ftL1rJeNjYELvhlrw7Q+pwWQwck39mZTYu3svqrOz/4OMz6v+LswfIDjldlZUy1KJfKYNFUUySngez2DeWi+yVBNgb7Lcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2yT/jvGa+atd3lwe+oMKy+NQA2f/RnYyBDTgVkuEc8=;
 b=qQSTvAtlrfiEGQTSa4m0iLf6mtTxG4mBiGkOcqDMitXfjyT5v/vvmd9Vy4fcHMQptxxXyT6fnkGsv3v722mQ5LR5mBkqGqfmvaKts4MpEfx4yggEe1Eaddr6zUK/XhG7PprMgGOsFdhW2V5jO8DDHb6Kz2IZL3tqoWq1IiCATobETIoNREzTFmH5OuBqwd3bhJVUoU0/9+s3UcJod8hI26wxvp3FcTFMXyX8qovriGJDEanjCIBHtpXtBS8hqMdcSrMQyVfdlUnU9k2jqaqW+A7h0h7I38HPwFZnUL4yV1CyjXObeNAWDnjhSOEhlfUcG2mR98lXjbJKMBmGzabZnQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7825.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:22::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Sat, 24 May
 2025 16:30:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sat, 24 May 2025
 16:30:06 +0000
Message-ID:
 <PN3PR01MB95975A24B46FCF0829F31767B89BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sat, 24 May 2025 22:00:04 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Ben Knoble <ben.knoble@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
 <E78F34A7-359E-4049-9780-30FC290DA7E2@gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <E78F34A7-359E-4049-9780-30FC290DA7E2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0094.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <cfade63e-5eeb-425e-8211-0f61ffee0db8@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7825:EE_
X-MS-Office365-Filtering-Correlation-Id: c5adbb1f-fbf6-4338-1660-08dd9ae03e25
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|41001999006|6090799003|19110799006|8060799009|15080799009|461199028|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHowQ1o3aVpnYlMvRElqT0I5aUxtSk5pQysyWWF6WG1uRU4vOUY0eE9xOUtU?=
 =?utf-8?B?UzFFZEQrQWJiL0MrdmdtYTJ3dFROR1lxcEZZekxHSDUwMHF0Z1RzdVZMQ0E0?=
 =?utf-8?B?Qjk3V2NISGJ5bWVqckpFZWRldnJjTnJ6VzNHaExjM2tMd1p2MGlnNnRWdER3?=
 =?utf-8?B?R2hVcm1VWTBsZTVKZjZRQWlmTjFnTmh5bFpGZzU3cGxvRlZhbGVmQ1VHUG1Q?=
 =?utf-8?B?Mlh4MU84UWtuUVJ6ZlE3TVlTaDlJNzM5SStldUlHVytCSnYrbnhZNjRiNm1N?=
 =?utf-8?B?VjdLZzJRQk1SZG1KaGFQaGt4OTRzNmc5RkhiZjVQWXE5M3B1dWZBdkxudit5?=
 =?utf-8?B?Z1hyT1dpNElsVUVtUVBXczV3c2tBQmdDNlRHY2VLdFIzQUhieG1Tak5vNWNO?=
 =?utf-8?B?SFQ0L0hNSDJCanQzWmY3RTVZaFI3TlUrakk1enpmRm9iY3A0cmRqbk9NTC9S?=
 =?utf-8?B?U1VJdGN4K3VjeDN2QXhBU0NPaWc1K1o2aVYzb25qdEVMUUZqVk9vaTVReXla?=
 =?utf-8?B?K2pqa0RydlFNc0hhYlhrYVhUU3pUeGFsdmtpcGJWNjNVR0R6SjF0S2xyTDk4?=
 =?utf-8?B?RzRBdllJN0pqNUd0RGJid2Ura0pjMmgvVGtST3lKQWkyK3NBaWJBaU9HcVQ4?=
 =?utf-8?B?eXZHZHlYZFN6TlpBTEFybzhlODFmWjBpR2Zwa3hyNjVGbVJPYkd3TTZQMS9o?=
 =?utf-8?B?VDJQTHRtM3NSNm13UnV2YXBpS28waUNTajZ5bGRmUzJhWjM4ZTl6MlBqc21q?=
 =?utf-8?B?cFNRWlUrdDFJSllMeGdENGprU1E5MHBTU2xoOXdTbFgvMGNPV0tWblBsbFVp?=
 =?utf-8?B?eHJUd0ZvRFZnOWpvNXVRK2VuWmdhcklWK3hFOTNxMXJMYldZcmdWM0dHNm5J?=
 =?utf-8?B?TnNxU3UxL3hHM1dZSXNSQkdjdGJ1bnp3RGVZZkhNMlRTWnhiVzUrcktSTXRV?=
 =?utf-8?B?RHQyUGV2Nm9PNHJqNEhqMDNvQ3R2VmZiMXJxL0VwRlJ1dFEwSWp0MFFWRWxF?=
 =?utf-8?B?WUExR1NLM1VxWVZwZUdqUU9aN21QTVBZQWY2UHhBcENmTUljbmtTSml3VWFO?=
 =?utf-8?B?Tk4xT1JlMHpqSk5hejZkYnRuRmgyV2R1eU9IS1Q4V1FObGo3WlI1aWFLWUJr?=
 =?utf-8?B?dlUvMGtkejZJYVNFVVByRnZhSUEwWlVmSFUwNmVNSUpzOWdOY1RnZ0dpU2lS?=
 =?utf-8?B?VzcrUTR3cEcwZTZrK0xveEJuUmdKSy9aRTJiZzBMdUEvRktJaS92QmtGVEhK?=
 =?utf-8?B?eFlZdGlRdlRNL1U2cVd1Vys2NmlsaWU4RjZWNDVucWpIUkhRdWF2ZVRuTFds?=
 =?utf-8?B?ZDhGTmRXNmFsS2JNK0h5a2QrQjJNZ2VWWmNVN2hEN1RLbE03aHVLQmRyN2lk?=
 =?utf-8?B?VnBQTE1adzY0dTNPYkd5NWI2RW1WRndxZ3hIK0o1TytETHBNdTNVSEJXc3Jv?=
 =?utf-8?B?a1JnTFRhcWtqcnNyWjVzcmIwUWxVSUlveklIaTkwa2IyMW5WdjNxSW9HRFhx?=
 =?utf-8?B?bitpMWRnTzVwL2Vqd2I4SS9tZzdBNG1wMXZpQTJMNGN5TDh3Z3pUMkdsd1Q3?=
 =?utf-8?B?ZER3VTk2d3BxTjQ5QUVkNE8wNHJ4bVpNQ3Y4NkU4ZVdkaENSTlFHZDFPWTBa?=
 =?utf-8?B?c3g1b3hlcDdBR0IyNkx0NnZEQSsyMmc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDJHVGtXbU9BZU5iTmExZ04vQllPNVFRVVlrM2xUZjJKMSs1QW85bnM2dHEr?=
 =?utf-8?B?Y2dZZHZqemYzL0JQOS9nMEtwMExoMER2WTlxNmlZOFVGZE1nY0VhSG9GNGdj?=
 =?utf-8?B?cmNGV2JkczhPTnZYU1E0aGk3YXcramZkT3JMY3ovS3lUNHM4d2t4YUM5ZG1W?=
 =?utf-8?B?azNVYmluVmZuK2pFYXdCZTJMWGpJTmlPQUNVeWdLeElVTnhSK3RGS0VWRlgr?=
 =?utf-8?B?c0E5S2p3cWt4empwWHo1S2xWaDdGSU5xbXEwUzdLaERMSXFXOUpybWh5Mk53?=
 =?utf-8?B?bExEandnaFVPbDVJSjJuVHRUOStpdFVlb0VxME0rSUFMdUlVK1g0Q3FFeUlv?=
 =?utf-8?B?WlA3WDBWdTRGWW1od0Vmclk2VEZsZ2NVK3J4OWpiam5KS0g4Und2OStqMlpD?=
 =?utf-8?B?YW9mdUxYcGN1b09Ocm91eEU5NTNWUFdFcTUvMHZwQjhIakdoT3hvczdWNlZT?=
 =?utf-8?B?aGhHbytDelh4UUI2Q1p3dU9rbjd5cFhrdGFPQ29QaVl0Mk1jU013K3NtWjFL?=
 =?utf-8?B?VVVUbUhPREI2QllqUk1Ya0pHOVgxUWRXcTRHMnEzSDd3ZVR4YnB3SkNaemI1?=
 =?utf-8?B?V0pOSktnMlFrWm5yM0JicUVuNjNRY3VyVFJ6R0hGS1VoclJwWjVtQkJ5TmRN?=
 =?utf-8?B?d3Y3RTdUVVgzc0ZDWkxBQ2xTQTdyMzdtVERqQzNHNmdGMFZDdjFkaGtic2Uv?=
 =?utf-8?B?SCtPWE9pN1phMlQ1TzhDcVQzUFMwTjdPMUZYSmVCMVVJdGc3bkt4eDUwVjJM?=
 =?utf-8?B?S0ZJdUJYTkY3VEhRK1lXNTdrT1M3aHZhMzloSG5SaG42K0oyMHRpYm9aZnUr?=
 =?utf-8?B?ZnlnaFo4MWk1TjRBc1YxeXJZTC9jRDFTczhmRHBIUWV1NGt2TmpsaUE0RFpC?=
 =?utf-8?B?L29hczdwbW5YSytJd3VJK1pEY2p5L1RkYUx2VmRRQVBVYVdES0M2cXhKUmcr?=
 =?utf-8?B?Tk94aTYyVGpEYVVob2lQbzM5cDVyZG9Yc2JqR0ZKQVFVVjJoRmliWGRuRkJy?=
 =?utf-8?B?UTBZTU9nNVhUR3NMemwyVk45bkpHSlNuLzRYMDkwMXQrdkVyd3NMZ1Q0QnQz?=
 =?utf-8?B?RUpadWxsbFlOV2ZGUlZHWGxDMzFta0VYWHVvc2owWHZ5VWUyQWZvMDdoWmxD?=
 =?utf-8?B?UXJpZDV0NC92UE1zSmZ4K2pOMnNHQzlTQzlBWnFab3NuQVF6UXFBT3FoaVE3?=
 =?utf-8?B?cGV4SlJEb1Y3REwzQVNOM3RtVlF4a25yTGEwdjN4LzR2ay8ydTU4eFQzaHAx?=
 =?utf-8?B?YzZmOHRLZlVkZjJnUWJNUXg0Y1BwZkdUdE1OVURMd0UxVGVFNVVFL2pCMXlT?=
 =?utf-8?B?QlF5cFZEKy9QdVBheGtTZ0xwZk44c09WZjBlZGY0cjFsU2U3RUJrQVc4K1pR?=
 =?utf-8?B?RTNiV1J6VzBiek5FYnEyNlh6QlRUQW4xQkhiMzY1Vlc2Y2RXVjFWdCtPZnJu?=
 =?utf-8?B?RjNSMVl6Qmg3K2dXSWxYRXU4aHNlM1hITHhJZzZ1c0lqUDJDSzdkRVN6cFBP?=
 =?utf-8?B?cFgxMnVBVEVtMHpzVkRvMEovcm5IQ3RNRG9oa2FPdGdES1JOOGVaU29BcEw0?=
 =?utf-8?B?MmtGRXNaYjR4TTN3RHdBb0JtcUFBN3ZNREZSRk5MVmVid1pSb3h2NEUwT1h3?=
 =?utf-8?B?THMreHRCNEg3Mm1TZmJTVDB1TDhiYlhudGJKdGdhbE9VbURLYzI0U21SVU85?=
 =?utf-8?B?Wk9iQUs4SVlMNStSWk5tdW0vSWVocmI1dzRrcU1YTnlmOUhIRi92RTZlZXAw?=
 =?utf-8?Q?nOa2fx4exvMKAW3/mk=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c5adbb1f-fbf6-4338-1660-08dd9ae03e25
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2025 16:30:06.4715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7825



On 24-05-2025 09:58 pm, Ben Knoble wrote:
> 
>> Le 22 mai 2025 à 14:26, Eric Sunshine <sunshine@sunshineco.com> a écrit :
>>
>>    ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
>>    free(response);
>>    if (ret != strlen(response))
>>        return error("IMAP error: sending response failed");
>>    return 0;
> 
> Apologies if I missed something , but : strlen _after_ free?

It was a mistake, and had been acknowledged already :)

The latest version of this patch series does not have this.
