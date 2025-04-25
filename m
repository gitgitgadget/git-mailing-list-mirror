Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011028.outbound.protection.outlook.com [52.103.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A0258CFF
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593487; cv=fail; b=jw7RKzPC7q4O+ItCMoA1wbqrTa1fZ84TMUgtD27C7m6jB5Uj0gQb15iVBU3iuxxB5EwK7XgIeJH4grG+iUuPxaoFCVg2m6IGOj/WCckdgufqn8x/NBoUTnH0Y2qzsL66w3/EUmV3V9sdxzTRUx7SQpIvq0BL36T/bnRT9oK+dCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593487; c=relaxed/simple;
	bh=6lmm1Vzm/SdpWREk+SoSWx65p7JyXDUGfspbvWYVqn0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h/FoGWSi/tEpnzJJ1dIXqKo35zR9WsGWwI4j91djxODgu0JJ9z6ndnlLGa3cYnJymC50aS6u5EK63Z8upNc39HxUm9iZyf2ebJDAMeG9R2M4cZRCURC5Qg6ZTEOx/X2IvS+J+qR1cxIGf6fJdwqaaPrg/51y1vrUbrIGrEgEZJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KgJHAekS; arc=fail smtp.client-ip=52.103.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KgJHAekS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV+VB6ARZLxpR8cVw++SRRTUbKyWdp0X5Cke0ZlOHf5EwoefU/jFLpjrRmlABcRB5byqPkc+ebQdjVnfbEqTZYrG6WDnOxsRVgu9veyf5GBmjg+MpSxycZd7fvmSeXPnKS01m4i3DcIzOKnnI+HH+mxMHqcb+1mBXSVYax7VLjFqXaZy5X9BYV4WqdCBpvvNlL5XCtfimmB9L/8bYlo/0HNxEpiaqTHM1qfhZVypHazABN0qN7xg/Cd1TNU1OrS2kp/FPHVrsOCHkUnFZlZDaMNqk2L9hrhBja+jIT1e4ebtTllkML671vys4aHAQ9tm0F5jHlONlR6vPV2KrJl6AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tc87JWBHpk9dXa08SodYCOnCpTCnfLbYEMLW/CAJ8dg=;
 b=wbxXTugRWBPOWL4hfdSHiI7juKNxP3a2F7pWhySN5NVEasdbC86rARCC6xuz1tjIIAoxN+XxYATZMePBOuMPmDWr4fmBO0Ji3fouQxN2v91epdHKV/U9SqfVni8tshppLh2K+sy3hiQ2eN8RjVeb+vIWxt/P7Vp44RdREw/2rblNcPVJ6KH3DDc0lkMUbt9u51HzM9WaN99W7L5xnWG8fQZ6X4BjxV17jEXWu8gq1vN4Ys9LZO995hBTgqyXG++F5mdhomi1FeiK8sk9gEf1624vZ03Yo/Av+ThE6Ui40OXYSjkiLFH+0colraE/VStRdzmojwvH4QEgtZSbnY6gNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tc87JWBHpk9dXa08SodYCOnCpTCnfLbYEMLW/CAJ8dg=;
 b=KgJHAekSWHPYJlDfY5DIqlgVfsXFtVnr8ANmIew1QPBRf0mALlFbFK75HOshNcubjbpHBtY29IGWQM8cxUQRwWLx2V0ISCuVVhaV3uz2FsMiiSuGYvCwFwTbFBgGYy/p9Pbnia2jWEQZZELpyektl2v77YbJUhRPTAk3Da2zKCgZnZr3TjqbASU6cfV/zHKFBUjZRf7e55uP5x7WPgWh8xwNgzVQH0L7WiSI8ix1IFhlnM2q4i8OjYgQB8/ZGvr1Fep1ZXPmGfcLtuKYQVIuSeU/PHwq52Pjhi21O39eEGlOgJaiTZf2a+STXDnV9GYOG8zJaDG6TZftyYYkDTPXQA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8233.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 15:04:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 15:04:40 +0000
Message-ID:
 <PN3PR01MB9597D4949EF555E2A96CE745B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 25 Apr 2025 20:34:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] send-email: retrieve Message-ID from outlook SMTP
 server
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973F4B26A8CE2BF17A3AB1B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597A549B8A6752F2F828266B8842@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0208.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::16) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <b8815bd2-8d2d-4c1d-90ea-7626f5bbf112@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: c8f13db1-53e4-4b53-a3e3-08dd840a7f7d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|19110799003|7092599003|6090799003|5072599009|10035399004|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3cwUThyWE1NSUl1VXpBTFMrVkZpSGxiZ1Z0Vzh6N1FQZlZwY2hQaUQzbTV0?=
 =?utf-8?B?S0QxVjZ2YmdZbHZGUWpscHAydXF4R2dycUhJTHFFcmdQRmxsMklETE1HQ09X?=
 =?utf-8?B?cEtrMG0vazl6WHQ3THR4c1gwYTl5d2Y2YTFYNU1WMTVuUElNeEFobFVmV3VH?=
 =?utf-8?B?cjFsU0JpUGUzU0FWUzJzcEx5L3RRVmpSL2JPbHZMbjFkN1ZJc2xBblYxNU14?=
 =?utf-8?B?MjRWcTZ0Y3A0SE9hTUNhTWdwRnNnWlJnUEZyUk90RHp0eTlBYVBWQXNXMkxO?=
 =?utf-8?B?R3lKVDYxVjkvUmpLcEMvSnBtR2NVYURDN1FEWkR4NVBVVERsUjZ6ejRiUkJy?=
 =?utf-8?B?Mmw3M1VGOExIVk9hMUlDbmEyZWtRanl0em1qM2xhK1VNRHVVTGRUZ0pjcDc5?=
 =?utf-8?B?TWpxalE0L08rMUZhMjBNNzVrSXRDbUN6QTB3eEZSSkdnaTk2Q3V5NVZSSnVj?=
 =?utf-8?B?c0t1YjZ5QTlnTG5jVDNYaGl6NHFtc0tRczlmV3lzRVI5MUJCVHUrZnFDSDdj?=
 =?utf-8?B?Y0VOMThHcnlhbS9aaGNKcHF1NGs0Y2kvYTdoMng3OUU4SnJmRUFZNmhiVGN3?=
 =?utf-8?B?NldML0JNd1MwZHIxcmNMK1FDYWJZbTlEOU5EVnRQRm8waUVBYzhDQzBLdCtW?=
 =?utf-8?B?MFV6MC94Wk81Q0JCRlpwRGEzc2VWUWRQK0JvQk5QQ3RBQlF0RDJuVVdnRGtp?=
 =?utf-8?B?ZmFnQnNFdGFSekFvQ2grRkJualNQNDh1dEhWaFJQVHVMWUVYTlczaXZRbnVI?=
 =?utf-8?B?RlVpRGJiQUJidUFpN2JSSDFMRHFtL0ZrNmh5RitHQ0pSUnVVM2Fma3ZKRHo3?=
 =?utf-8?B?OU96dGQ5ZU0ydnhoQm1kQ0VHMUFXY2ZSNVJZa2VVRVpIVVFEbC83ZEcyUEtj?=
 =?utf-8?B?ZzlHK0tIQ1lIdHJNeWlzanNTRWlkK3F1VjdtQzdtL2FOUFR1ZDMzUHd5OGZx?=
 =?utf-8?B?UWJHS2JNRllHMDFTVDdrTmJiZThiYWQ5MGNhQWNPemc3dk5tbmlELzRRWCsv?=
 =?utf-8?B?YTZ2S0xCOEJjM1dqNHFURWVaclRhdWFYZnpFZWpwRytKTzdYYkd3YjBuS25i?=
 =?utf-8?B?S2l3M0dNTG03MG1hbTFjbWVzU3B4bTRLRmw5Z1BoZFAvaklpc0pONGxwbmVV?=
 =?utf-8?B?K05ZdVIxaWRPZkRSc0h3d0I0UEt6a0hveEkzL1JubmtYUlVuZ3B5MnIxQjRB?=
 =?utf-8?B?OEpBNzRvVU1xY3hzRkZCY2YzQWNDMkJZQnBTM1prMHhQQVprOXgxSW11VHFX?=
 =?utf-8?B?K1pub1pPMGZlcDRDNXdwSkZoeFR5aXZ2Zno3eGFpUFJ0U1JJTVpCeDB3ZE44?=
 =?utf-8?B?U09mdzZSMGZyeDZSczl4enBUeTJEU211Y0Y2cGpEMHkxaHowMk95V0ErT0Qv?=
 =?utf-8?B?ZjFEOE1kTWlncjk5Q2hVekltQ2Iyc3YrKzlrR0xDY1JNWFkzWkg2d056RFps?=
 =?utf-8?B?TE9ZczkvTXphMlNsU2VrQ01ZZUtVRWM5elRrWVRhdUtPU3UvQ3hTa0FWN3FT?=
 =?utf-8?B?dnlqc2x2Y2hwdmxYdkFuTjVCa1Vvd3pmd0JvSFRVTGxCMWt1YkVmUHdjNWk0?=
 =?utf-8?Q?HfQt9CvkhLowlqosaHiO/gPGoIb3kC7rg/piC3W66ez8Ct?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YUNYSm5XdmhmQ0FKd0NLUDVoV1NIQjFsOFpEUFFLd2V0ZFdudEZGUktmWkNZ?=
 =?utf-8?B?TEVHendqZG56dWhBS1JuQm5ZT3E0aEd3aExqdVJzcEx2K0xVMXlVWFQ3S1pD?=
 =?utf-8?B?TlR5eTFWY084OGpOcXJqV2E3a0R5bDhuS1lrU1hOSXc5aVphUXNSWUNTRjBQ?=
 =?utf-8?B?ZExxZXRuTGF5d1BKUnpGOU0zWjh1cytkVklzZU8yNmFFZUQ4ZGUwK29taGJZ?=
 =?utf-8?B?S0djYmlnb0hxRExSMVYxbEYwOGM2WWc2NlpPMnlFVFBTUzJ4OC9NTDl1enRK?=
 =?utf-8?B?b3lzZGlxZDljcmFaVTdGZ0plZXRON3dEOGhNYjMvdWlGclR3dmQxZzgwWktE?=
 =?utf-8?B?T3VKRlBpcHBrV3hHSzQxQXdVYnBzQUZaeDhIWDdSWVd0QmM4L2JyOVQyY045?=
 =?utf-8?B?K2cyOUZGSG1CQkhDKzAvTkMzTWJRU0pWalZXMi9DNW5QellvTm1pYTlXNDF3?=
 =?utf-8?B?QVZER2MvVy9sbWVFZks2bmVRTjZmc1dZNVYxMXVCZTFlVVczWlFpeEthV0ZZ?=
 =?utf-8?B?L1h2ZmFZVW9QaTVTT2xkWU1Mc3BiSTExTmNEeHZ0WXlDOHBaQmFML1JZVkt4?=
 =?utf-8?B?RnFiZnVrOGJHd2dNMWZpNW1xY3oxRkh4bnViWU1IQmN3OHNnMVplTlkzTlNP?=
 =?utf-8?B?Y3E0QmVEa3I3M3kwVjQ3ZnFyR0xPMzFFaDFmZ1FURGFUNy9NbjdPc0RrL3Rs?=
 =?utf-8?B?OXFlQWJQR3ZkUk02eW83cW9nMDVIMEJkc1BDRkZTa3hGcDF5OHhXZXg1K3Iy?=
 =?utf-8?B?SFBZOVZHaXdZcllDQXJzQ3hIOWRTZkxETGdLWmJvUUlwamdaRC9zVEhIeGFD?=
 =?utf-8?B?YlU3UE5taWlIUHZUTmhQNmxMQkRYdUlwSm1uczQwcGtSUHlLR053THFONnRX?=
 =?utf-8?B?d1dzV0p6b3hWai9zeFZmVlRYT292OVU1NzJHendNQ1FzZExXS2xXTHBBRXJ1?=
 =?utf-8?B?L0F5Q0NraitFRHZqME12Nk1kcUlsVUhQMXMzUW04bEdVbGVEdTYwTXBETFN4?=
 =?utf-8?B?dHdieERpRFNVTEM0SVBYTW00ZDFaR00vWmptUjNjbnhRWWFuekk5aGdQaGtN?=
 =?utf-8?B?SFhsMTloR00zZzJhbHFuNTdkRzdCRURjOTJGQlM4dHFYRFd3MHpQc2UrQW5F?=
 =?utf-8?B?U2E4Rzd1SE1YdXBucS9oeXVZNjlrVkkvZzlMVC9QZklUK0VBY2RoeEYxN2VS?=
 =?utf-8?B?SnJ0bkFJQjNyUjc2aVFhdm9WMkJOV0Nkak9uYjRDckFVUWYxNnFwYlVrMmMr?=
 =?utf-8?B?SUs4cXpPMllMR1hHcWl3U0sraFlQeVNXSFluZUpRZkdmRHZQRTNJTlJPNkJQ?=
 =?utf-8?B?bmoxc0ozRndmQXJiamxGMVAwNk9kQnVwaHRoSFpJQituUkNtY3I1TE1IcEZH?=
 =?utf-8?B?Z2RqcGV0MXp3ZEo0SDJpSVFlOWFGMFF3UmJKSWFMclFSTFA5VHFQNitnR0JT?=
 =?utf-8?B?TGdWZy9zc25obzhHb2ZkZ1pWOXRHQVQ3Ung5ejNhaWNnWFN0a1NKZzlWM1kz?=
 =?utf-8?B?c2ZLY09QM29SNXkzTktBRmVBcEhiQ0hEZ3c3MDZvUUt3U3FHT3dkd3N5d2pK?=
 =?utf-8?B?MFkvQlZkL0NpaW9JYTA0N2s3S1VRWWpqL3RoN0N1TFkzVkpFaHBEeWxlTTVr?=
 =?utf-8?B?dEZCS2dEY2Y3UzRuVTNMK3k3Ymg4anJxai9LVDhHdEh3WVFTVGtiVEROQkdw?=
 =?utf-8?B?Q1FUNC96TUk0MDhFZUZISGdEdUZCRnoxYUErb25qY1dhRzJVNUdHempMZmJF?=
 =?utf-8?Q?dgQG8jsk8h++kkODej7OkMQ3dgy6tNIhx4narMU?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f13db1-53e4-4b53-a3e3-08dd840a7f7d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 15:04:38.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8233

Hi Junio

> The script generates a Message-ID alongwith the other headers when
> gen_header is called, and is sent alongwith the email. For most email
> providers, including gmail, the Message-ID goes unchanged to the
> recipient.
> 
> But, this does not seem to be a case with Outlook. In Outlook, when we
> send our own Message-ID as a part of the headers, it discards it. Then
> it generates a new random Message-ID and that is what the recipient
> gets.
> 
> This is a problem because the Message-ID is crucial when we are sending
> multiple emails in a thread. The current implementation for threads in
> the script replies to the Message-ID it generated, but due to Outlook's
> behavior, it is not the same as the one that the recipient got, thus
> breaking threads. So a need arises to retrieve the Message-ID from the
> server response and set it in the In-Reply-To and References email
> headers instead of using the self generated one for the purpose of
> replies.
> 
> The $smtp->message variable in this script for outlook is something like
> this:
> 
> 2.0.0 OK <Message-ID> [Hostname=Some-hostname]
> 
> The Message-ID here is the one the recipient gets, rather than the one
> the script generated.
> 
> This patch uses the fact above and retrieves the Message-ID from the
> server response. It then changes the value of the $message_id variable
> to the one received from the server. This value will be used when next
> and subsequent messages are sent as replies to the message, thus
> preserving the threading of the messages.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---

Authen::SASL now finally supports XOAUTH2 and OAUTHBEARER thanks to Erik
and Julian! (Link: https://github.com/gbarr/perl-authen-sasl/commit/958a3aa165d30cf4e3cbb36dc45306de627aa13f)

Now the only really needed patch is this, i.e., the v6 with a single patch!

Thanks
Aditya
