Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294D51B4257
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 12:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713712; cv=fail; b=aLMcH3whpelHITTtqojA9RR78uYQY6esf2Joohk3uOdulPctN7d2BGct2TI+wo4EkPnr0nkLtguzQrHlE9eSaHrLOoj/TVNb0B2B7UGXny89TXk+1jiCamqZPvsyjPF/dSr80xXY/AZ+7mjkgLl3L7laeDOFu07pLyq+dB9Mc+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713712; c=relaxed/simple;
	bh=zzmcHcFeXpfnLV9wtVSAaatVPRWlPIsY6yEoGYnQWAc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XDrp2afuceddDunKiZUgDIIizBDzQzeN4A1HCAy8yrXbvfDaXuy/rERpontD1uGaiaowWOrH/ly2wTmN5QAuAngwx0XXV2fuh8+YQ6Pwk49dZ2wWpmIpXLlbwYXHx69tzBZ83rzqq6XNMJo+zD3dYiqCsTaqZmKnmEzZVoXrqlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UpebIJVh; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UpebIJVh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+WDNcmBu7OcBXq1CvtVVr4slG5aVnUIRAoiL78tmCOloFt22+iYbeMvpi1+sEDBTt6BWhcBHEC6Kf/UYdjsgy68qxbjT+7DK9aKed5o8q1au/LZLnmh8eS/NeSmBqlTN3LOqtcV2O8RJp5zA+6UTTOs8voHotj6pFla8jB9ln5NMQEx3ZggXKbV/rUUSy0pU2zqU8ua9NoqM+FbHJMg/hsW0ohj1OpzfSgOMQ8yOdfaN2xiE0+Ky393ngNhILMlwCc8zAj8FskuavrYCBWNp/LugaGf2yGsIjoINCGC0IbUWjlrSWRXI5CqtWLGvND4o9B4gJS0bpjnLeyLq+M/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eU4nlYGkUwhLGIQt25L8yQTklULVVJBE/mc6ZrtQGuI=;
 b=VBf/dGUGS+busNZroa5qrYnoH8x2tUGRS867/AamtxBwoC4FvcF9ICHkIJT9sGWDW5XfudEHIujXwDfL1ckW4dRrIRpN9bF3ZQ0XToRO2XvAJp6ktf3oIr/SXYa1QuxR9Vpc8ta8WNbmGlbNkqrPJjlzw4ajdBq9UrTiO4DnRHKUz3DGxwev+OTkDYm+Z2dTrFlmDgiv2cM1JxmJpHQa6SCYvqqBj8AZcFt8UJdaVInPbftSbiRFRF2NzaCI8t2UKND+rdLE5EH/k7wm5rrbix6iji6T2HLx7JDf7qmHiuwkpCD4ZdQekM4qbfJrrUzCrR9VjQpaQvMSuqA1PncrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eU4nlYGkUwhLGIQt25L8yQTklULVVJBE/mc6ZrtQGuI=;
 b=UpebIJVhfH4Sm4+dw+uzA/RJWH7KJXcsKhcWIcSGcH9bTLxwEzHqKRELsJoy3JNpOaJFkCH51Vdxka0lUFOxjsFTw+64FkzzwsUAc+oSYFYmqD5XSUpzfx1uRKLsBHc6aklqmgogvgfudyhk4BdB9lgx/K+p+gTa01WqlODTkqrDH+na+7h1qJVvTqd3regEInmX1pI0M0qYK4xhEzPM2ypB1yCU8JPKI/AytahYO5JhEdyS0PLGEARwFXak1SyifgY3r9VR0ylrBwEWImyZ78c3+0Y6XuQwjynAGH8w9so/M4ANPWnxFPtz92/53JZ1ahLUyHJBQYdqcES6hoVlmQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PNZPR01MB10409.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:244::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 12:28:27 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 12:28:27 +0000
Message-ID:
 <MAUPR01MB1154679A7F8FF4B926A1F41E8B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 5 Mar 2026 17:58:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add hydroxide as an option for ProtonMail users
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <MAUPR01MB115461E9C238F9952EEB1C38BB871A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <MAUPR01MB115461E9C238F9952EEB1C38BB871A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::11) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <d147283c-b70c-4208-85c5-f837fb78055d@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PNZPR01MB10409:EE_
X-MS-Office365-Filtering-Correlation-Id: 028364c8-790b-4407-35ac-08de7ab2b37d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|15080799012|19110799012|23021999003|5072599009|461199028|25031999004|51005399006|6090799003|10035399007|440099028|3412199025|12091999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bjUwTTIvOTgzcEdVeXo4WS9DMEtNWGZ1OFZiaTllOHRSRVovbmZDbzJzRXhN?=
 =?utf-8?B?YnlvSUNFb2lrMldzN0h2NkgyTjRBY3VpMTAvSmYxWWNNUS9CdFFMN0k2ajJJ?=
 =?utf-8?B?eXpXUkoxSm0xb0ljUStQZ1ZZb0plOWFvZ0VRakRvd0RNRkFXOEdBQ3FtZk9p?=
 =?utf-8?B?b0VOZVdOVVlqVFE4TGRrYjV6U1I4WFR0azRvYW1tWGNOd1o3cWpIUkgzbmpl?=
 =?utf-8?B?cEE4VWVhSm55M3MwZjJuNGVUYnN5UWt0WFNoM1J2QjdWdllkY3A4eHhKQ2I2?=
 =?utf-8?B?cVlEK09pcEtkYklBUVBZM2I4TXh0YU42aFpTZWo1ZmtGcXI1N3RoMkRGRy9N?=
 =?utf-8?B?Z2JycXZnZUlBczFleWFpYUxIRU5Ndkh6ZVFzaUtWL1BpdHcwcWVyY3BKM3BW?=
 =?utf-8?B?YWpPK0F5QkEyNjhYcThrVlYzd1IyN3BFQkxLdmtrTjZ2ek1IYXJkN0JUWmFy?=
 =?utf-8?B?VDFHUzFGZWlWN0dwakFjdmV0TDdUaXR3K1JBLzJQUzZISmlpUEMyRkkzaVNp?=
 =?utf-8?B?UDd3QU8xSmN2aWVhSkVoVVg2RDd1NkFFNDA5SE9sTUhkWmdnQzdjNzlJdk9V?=
 =?utf-8?B?YXNta1hiaVdnVGJhVVBSUjJYZ2N6UmdMaTJyeVhDRU1pdFI1QXpva3AzeEgw?=
 =?utf-8?B?bWlYaTJZa3V3YzVlL3V2Q1ViblJBRzdoTDhWUlJUVlRUbWdNb0s4VjcyNTVD?=
 =?utf-8?B?N2VWay9zTnIyS3F5eXg5M1Znd240OTI3N2hXUXNLTGJaQ0xqSlZzL1VRcm12?=
 =?utf-8?B?WjBBS2h4NUVHa2ErYXVHbGZ1b1dyeVRrQ3Y0c3ZldmFqVC9BNU5LeDVKUTJ5?=
 =?utf-8?B?TEdzNER6MVZNVVRIV1VPQkFKVFYxOHQ1TU82WmRwQUxCdnVSQVV4YzBCZGg2?=
 =?utf-8?B?dWdXbWNydlhJZ2FCM0plbnd1WUpJYzNvZHVTV2ZpMFBaMDRsMEdmUndPWmtP?=
 =?utf-8?B?T1NuQVVVeHY0RExZNUdZMldlcFoyYlNkQTNDOEFUS05uUE1CRm9DVnVONGdN?=
 =?utf-8?B?cnpKbFFzK1hGbzcyNysvMUNuSTEySWYwVEk3c0xsUjRNY0dDL3hHMUJ2YW50?=
 =?utf-8?B?TWp2TFJTakR4S3RxdGhxQXJmUFh2VTF3eTRBWVVLekVCcFBzMHNoZ2k0cFEy?=
 =?utf-8?B?UnV1VjhhcjdRbEdvOE9BTTFmWmk2bGF3Tjl3MG9IaWpKbVRJK2NVWWQzM21S?=
 =?utf-8?B?TU9ZQzFjQzlpaXJPMVdWYy9WdmgveFoyL3NPcDNXSDZuUWdmYTVWamEwMEQ1?=
 =?utf-8?B?UG5rQzE3OWtFM1ZnVTNYSU1QdkZjVlYyT0Z6eXVzSWRLTUlpVEgyYUVtZytJ?=
 =?utf-8?B?YjBlbTc5ZUhNVzBFelZJVWZlN3ZYaFFQZVlzUDhSaEEyblhEaldDMFRJQTRC?=
 =?utf-8?B?anh6cE1DN1h5TXc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlhzdWZlaFZtRFlpeXdPWkpnd1l1ZHZjWU5YajlIcFFWVlpGemQzYWZtcUNC?=
 =?utf-8?B?ajF2TjkrV01iZ01yLzZ5RDBVL3pUUFVIaG5JaVRhYlhkYS9tbHpadzJqWWM2?=
 =?utf-8?B?TzNaSnRyS20xcE5vZEJQUDB3aWZoWUhCWXJGWnBEYmVMamd4eHA3elJtVndS?=
 =?utf-8?B?Q2NlMzNybXJXaC9RbzYraXdQWndrZWMvV2lYaUNOV0Q2SHEvcGFPOVlGdEg2?=
 =?utf-8?B?QlpudTJNMzZnT0hmeXVXUUViZyttRDR5U1ZROW16UHp6WkhxMmZpT3VFTnFt?=
 =?utf-8?B?cTNtb1pmdCtjRFpxdE1QQzh6K3JRU1FsdTBSMCtRQkNHOGhkV1RXcUxUVGd1?=
 =?utf-8?B?anVyc3JzdGZxMWd4WnE3K290NE9jZm9lT3htektwMy9FSVNMMDExRmV0d0JF?=
 =?utf-8?B?RjdaczhRcXZTRkJOd0NzVVEzS1l0OFN3bFAxdU9qaEVyeDFUWFg0R3JReE5I?=
 =?utf-8?B?ZjdyR09tR0Y3dHVOWVZya2JQNlRQeURpMzlvTzkxZy9GQWZNUlZPK212QklP?=
 =?utf-8?B?bkwxOE5VWEtoTlZyZEZPSEZYTXF4TEhacmJxTTFIMEpPdGEycUtjN0JTY2wz?=
 =?utf-8?B?d3Z6c3lJeVhWamg2Z1BGdXR0b2ZURmRwQzNuV2tPdDJHN1Bjek9PRUV6Mit3?=
 =?utf-8?B?eEFNbnkrYi9OTjlrRUhPNGRhRVYybG9IMHg1eHFGazg2K0dqcnU5dWQ5aUhC?=
 =?utf-8?B?ZHljMzI3QmpxYjNyNlpLcUJsQmJQbzk4QjZQUEJ0TXJNbm1tSEVYSzlWOG9C?=
 =?utf-8?B?dUt3NnVuU0p5STJJaDB3QU1UaklUbzFnNVkyd253ZitRUXBVbTRhbnIwaDVa?=
 =?utf-8?B?dlFVSE9iaTdJZDE4aHMvTUlVK0pkSXpVdk9PaWRGaEwrODlUMXU3Z0FiOGND?=
 =?utf-8?B?SnNnL25rRHM2ZzhVZFBsZkpmbFhFenF3VjZRYW1OeG9PcHBLS0VUYk1BQVZh?=
 =?utf-8?B?MWNhaDBWNm9ZckNYWDBVK0xpaG52SlA3WUxLSEhETkE5ZjlRVDJkbkhjTXpl?=
 =?utf-8?B?dlVCZ2pJM0JGOEdjLzMwUXlDcngvdEgvVVY2UnpoRUsxNDY4R0JEREpha2Uv?=
 =?utf-8?B?VWZXSFFhOXF4VDhtWnhuSDg3NFMrRElDNTRtSzJnbnBpSmR6S3FyODRNRGZX?=
 =?utf-8?B?eDhwdXpXMGJiRUZIbEEreldmT0w1bWJnaXZVekZrZjE0QUJDK1l4UE82dFdt?=
 =?utf-8?B?blhKVlRqQ2xaWW1kSmFGN2tzeGlsa1JiZFFObE9aRk1qOURxZHd4cGthTWdu?=
 =?utf-8?B?Y3NTTmtGUnFJUVBTcWM3VndQelBPWTFpV09DL1BVWjVVQ2QveXc1ZVpqZFRY?=
 =?utf-8?B?RHAvZEplaVZGWGRYS1IvTEQ1RFp3Mk44bDFuMDJEZzNEeXU2T0hvMkl3NDJu?=
 =?utf-8?B?blIrREZNRC9iWU00cmNLTE1Dand6MklEQktyVlJ4dnJLTlg1M1kxRzdQb0Q4?=
 =?utf-8?B?NWR6N2VIUHlXSUNjK2xNL29rMjIyVUFFUUV5eVNYVzlqdWxuRm16ankySHhP?=
 =?utf-8?B?YmRKYjhDajdmaUhxMXdNdW95QitxSGIzL3V4d1JRVGMycjAwaUp2SDVNMGhq?=
 =?utf-8?B?NXV2TXVlN1FORnEvQWV1aWVySDIrRkdaNkJKVWRyRXY2Znp0R3lxRWtYZ1BX?=
 =?utf-8?B?dHhtWVRtcDUxVWZRaGdncW5OTVBIcDRrUTlVaURiUVFXN1c5b09vMjZaN1dL?=
 =?utf-8?B?QXdTVGhrNkZabU9kSUNIZ2c0bmxCdVRjVjV4YTlhQkx5U2dSVXc1NXBJc1N0?=
 =?utf-8?B?eVZpeEFRajJvR0lCR25zOW1GY0FEWVV2S0YyalJVLytSUHRqTlgvclBqKzZy?=
 =?utf-8?B?SHpnTnU1WlUyK2VNVHZCWkFRQXJQVUp5NVF2cDdJMmZoZEFNU1JSQjFNMVhQ?=
 =?utf-8?B?L1NZbjFEaHU2a1JCYzFzQmpQUjVsZTR3em1qQ2xzaEg5YSthNWttcHdIaWZZ?=
 =?utf-8?Q?hhuoj6WLOUyjqMlAwtLXaX3/nx0oE5Zs?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 028364c8-790b-4407-35ac-08de7ab2b37d
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 12:28:26.9959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB10409

I just realised the From in this email is showing "Your Name" instead of my name. It was due to a mistake in my .gitconfig. Do I have to resend this?

On 01/03/26 12:35 pm, Your Name wrote:
> From: Aditya Garg <gargaditya08@live.com>
> 
> Hydroxide is a very popular third party client for ProtonMail free
> accounts. Recently the project was resurrected and now it works
> properly. Add it as an option for using with send-email.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/git-send-email.adoc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index 741f748614..724c9d5e9b 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -646,6 +646,7 @@ customer of Proton Mail, you can use
>  https://proton.me/mail/bridge[Proton Mail Bridge]
>  officially provided by Proton Mail to create a local SMTP server for sending
>  emails. For both free and paid users, community maintained projects like
> +https://github.com/emersion/hydroxide[hydroxide] and
>  https://github.com/AdityaGarg8/git-credential-email[git-protonmail] can be
>  used.
>  

