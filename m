Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543D2701AA
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 12:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499214; cv=fail; b=KHnO06S69YFm4IssAgAn2saP466VQhFo/fJPpeu3WE3TeUju9u1UtDokEFxzNU1l2XDZfP1jJdkk2ZJO1jOr4yW959WDFjLxEti8kWiD1w3hSRfSusavfURC/okvEUTUeyyyjWcZQe3fd6bBz0YF48/S9GWZFB/A2/l2mzhBLKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499214; c=relaxed/simple;
	bh=P4CJGNYlJlyYTIqUperZXB9Zb1vnm2jJBng94qgN1WY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FNldFUq4JL0KngAhtEjVaCjUHJ+MGJguYYGxRM1BFMtWDTzfuO9CWpH8clB4NMDPGS3gAEv6Q6fS1FpBZtp9hFaIlqK7eriDqkK9cdM/OxPD44B2q0jKeIwjqapr25fqMNFZYyH/X9EKuaS1xz+EUi3v1n50oRUy2IHy7kPhluA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=j6SRCNH3; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="j6SRCNH3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPd9WsgzBGmQ7iNrGVeLbh6P1LEWAnbOxoHB2gzmcxKLUrPFzh52EQDyqTFPfwJfVmFFMmZwOjUGkZrhQHoURPYfF62HJVBrG5BKcDI7EmzebvQMCP8z+yKXNUXJqeWX29LYSL+yHkYrvX+Jo8FdadH14OZVpCdJ7HD55Se8ey6hicDcR4Rs8Yc8PJi0n6ZByWu/tVCMq9P+JDObkPJwIuNurk/uqxyt2cwPtSBSWgzT1UaI3lAhq26cODAid359x94wrcrcucvQRXfoVkYqNfAYuUnhQtZz+YX4MAvoce/JkPN+M5rGueoqu/tdugH/Coyj6Z+Lcvxisg5zTiRFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=we2MXFe/OY1HWlhLRpx+odiBdvV6WyAloF6ip8IGsKQ=;
 b=ESfi5dtevLLo4JSjjxywGMyHBBEFz3c59z6VilnC6fK0bu1LnBdLdF/Ap7F6mMSvqe6Bg7R7DRHKY60xYxnijQSrThpg8OjB9Cb7b08QB+mPiyU3hwu9S7paBx2znlIrYK2OI069PL3tiopE+kS85kBsQkqkYQTDoPYjquGl85FXMPDkNGNzk6jAggpc68sd1yViAcr2K6yv0wnLQVsHXI5YChfUxNtveU6NB0x3a9x6LWXXmcnH6rzCRfgDAkurrXaCwuvT8r6BKybANR+ohIX+ueY4+zD/UZC7bMcwwJ0LRJMBQK3bHYZcedu0ZYcgPgoBKKA1SToQNY2Gt87Lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=we2MXFe/OY1HWlhLRpx+odiBdvV6WyAloF6ip8IGsKQ=;
 b=j6SRCNH3xKCgrwm3opkYxXLIJAe0nibaMfRRttLXqQ9cRhoOtApb17VLwPcz17MexAngSc6bTe/w5IJLY/Di3mYcUzALknDWyhKwe/PbQl3Lzm9uRGPdbHFTFybNXyxxPqcWSEwcjq+HLrKzTA33qcVUWclMniGw5EdvD4sqcxpinevp2nVJa37abmpgJcTrRnzy4F4NLQO7I3H4hDwi1BgZ6Djtu9G87Byr1pBfmgzKogw1eWbejyppykdfuzislCcfINBcrCB9xTyVy1S+VzxbhZRvVjGUuO5RUyzu2c3W1bmkSeoxuFHEMk4Ci73VvWSKsnvlI3J4E9mupQkY6Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8018.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Thu, 24 Apr
 2025 12:53:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.038; Thu, 24 Apr 2025
 12:53:25 +0000
Message-ID:
 <PN3PR01MB9597932FB4B19DE2038AA26EB8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 18:23:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] send-email: add option to generate passswords like
 OAuth2 tokens
To: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Shengyu Qu <wiagn233@outlook.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB958856EC9FB1E4F73A738746B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <D9EVAF38Q1KJ.24J34ET29VPTI@swagemakers.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <bb073dc7-2bf0-4f03-b487-2eaabd2bf928@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e16509a-e061-45bd-01aa-08dd832f0073
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|8060799006|19110799003|6090799003|7092599003|461199028|440099028|3412199025|19061999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWpmQW5jeTArVHRkcDA2RFU0dG5xZVBYRmQwU2dTSmhIdVJrUmE5YmtRQWpu?=
 =?utf-8?B?MThBczVOcHd4Qk1sVkQxWkdsQ2pJVDFvbmNlYzFNTmtnQkJyN29oaVlGOThV?=
 =?utf-8?B?c2l4NVh3VFdtZG1TbDB0cllOUjVUT1huN2NCZmhyUjdFVFdScU83Y2hZQlFx?=
 =?utf-8?B?ZnIwR3ByQkJ6RXJQYWxYYnJjVUFpVlZxRmRvQXUyNWNTVmV2Y29uYzN3bC9i?=
 =?utf-8?B?b2crdUtVeXAxOGcvSVpOUkpiY1RuYk10MmZDRkd5aEIyNkN4ZGFkN1p6NjA5?=
 =?utf-8?B?U1YzSTJySURKeWNMQjgrc1ZqK24xRTZzUjM1bFgzY1FYakpqNEF2TWIxMVlB?=
 =?utf-8?B?TU4xNXljaVdHUHQrZThmWU1zOHVnRWNRZS9UV2VERVk5SFFzQ3FRUi92NXJU?=
 =?utf-8?B?a3RRVjdubDFvU3BMajNrajJ5eHpqVFJkajF5VThBd3lXQW1ISWlqRCs4dDNx?=
 =?utf-8?B?Y09iNXpTd1dXbFFzcFBDWEJjTDhBUS8yY01uZHlvcEUzUUdoM3BvOHI0aEJH?=
 =?utf-8?B?NDF0anF3RTlnUnBnRTlWRGRneDN1ZkR2NnZYQnY4RzlsY0ZVWTZSTjBhL3hr?=
 =?utf-8?B?QkhMd2ZZK1QxczVmZW50MG1pcE5VZlJGUkJFcU5xaXlYMW90c0xmY2lpWjIw?=
 =?utf-8?B?OERhajZHYUozR1krL2xRUlhnMlh6cTVuakFrZXhVSkh3SjdSUmxYT0pPd1lJ?=
 =?utf-8?B?OFkwK25BRndBdENZeXhrQzFaNUdEV0Ywb0x2UnovVUtTbHR1aVcwejl5K3h4?=
 =?utf-8?B?TEMzWExMbndEMlFSSVRsTkxKRGkrYnB3UkdvekI1bTJlY2pqNHFYVFM3dHUx?=
 =?utf-8?B?Ui9sbzFsRC9oTUs0SGVQdG8wQlh4RlNsNkdsekc5MnJTb0ZkdHlvc0MzMUN3?=
 =?utf-8?B?TlRIVU0rWEF3TC9Dc3E4S29iaWx5QnFDYmlPYk96S1dSTWxMWERnK2NDcVBl?=
 =?utf-8?B?OFpNcUhqVG1NYWdWY3QxaFFHMys0d3JjYkxXb0p1bkh5MGcrTjdId1ArSmhB?=
 =?utf-8?B?VDdMZ3hiYmhuZURFR0s5cElTY0lOeGpDSXRzOUJhMnBTLzc5QkhLaU8rVXVw?=
 =?utf-8?B?N0VSbFhXbDhEZU9abTN5OVh5Q2hBd2RwTlJuN2hYNDZJRGRWNFNYdGd5L2lB?=
 =?utf-8?B?RktQLzZrdEx4VFB4elY2dUE5WWVvSERZNkJwUzFXbUg2ZUVuMlJRVHJrQ1dB?=
 =?utf-8?B?VUM3dklrVVdGZFpDbCs5MzZXSXlGd1BCWmlMeGJhdXB4cWJpNE1MZUZNYmY2?=
 =?utf-8?B?V2xQMlZLYmVOaTJuMFd3Ym4yK3cydXh4U1V3b2Iwd2N0bjRLQ2FZRURiMjFE?=
 =?utf-8?B?ZVZOZUNaU0h0OHRMZkJBMldwTVlnWWg2N3d5cVVIdzFPcHJmQnZZejMxbk85?=
 =?utf-8?B?WjlDYXUyOW8yajZQT3F4am1HVW15SzRyRTlUZkpHRzV3UExwY3lDSytjNWRO?=
 =?utf-8?B?SXg2YlE5am5OOGdzSjVmM2lIdVFkMkZPSG1pK253bFI1MnR0SGN1SWVBWkkw?=
 =?utf-8?B?Y0J0d3JyU1E3TmtwdWxtOVkwOU9vNnBpYzkvSEM1aUpnWGJ3WGQrNmNLMWRW?=
 =?utf-8?Q?9pMdW5g/3Td4ZQMbEQOFXlkhRHieGJSKeaiJxuDrzVktNL?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZaV0JXTnBxdjB0SHRDdjlVTjlFZWFXUWlleng1SWtNNldDWFc0WVhnN1lj?=
 =?utf-8?B?empobnZQcFhxY0ZsWVNQR3FGaUVDam1KekZHZTBKNW1YK0Vkeis1QTBsTEln?=
 =?utf-8?B?cnFLekVGQVNHV2F5MEowRTNaOFRreHlhaEI4bGgzRFdreXorWjFRTTdGSEZZ?=
 =?utf-8?B?c2FpOVkvQ0laWkI2N1ZONW5DbitaM3RPZ0NPUC9pUEtrUU1ycHF6UGxuWll4?=
 =?utf-8?B?dEtLNHNUa2dvQmNuMlBSRlo4TzFJd0hZK1IyMzdYVys4ZTNCL053M1lmNzFx?=
 =?utf-8?B?aHUrdkZTVXludlNwbGJkQWVXaTNmeG1rR1phQlNKb3dyd3pyMnBpbG91dkFz?=
 =?utf-8?B?VVpmc2RLMkIxOUdWZzNRcG5WNG9HbzFkTEJ6NUNVVXAvdnRjT042cHk4YlMr?=
 =?utf-8?B?MUZnQkJPdStzcHA3eUM0bWYvM01NZVpPWG9MV0ZKeHJNTEFaRmR2dmJBMWF0?=
 =?utf-8?B?cUltNUlMTnh5WU14dHFPL0tOWUFua2ZhUzB2Lzgxd3NVQThBcm5Rck1rdEg0?=
 =?utf-8?B?d2RjNUp3WTJLRVlwMUFIeEhIQW12U2VLWmJlckFMMWRQbElLYVRtVUdVQkg2?=
 =?utf-8?B?QnZxek9McjFxclpnZk1jLzBHYTdlVkJ0Uy9FNkdKb1BaNDE2dWcvd1dLMG5B?=
 =?utf-8?B?NHIyR2lFazRFN1VVcmFpZ2xZczFoaUFyZS9QL0h5a21iUUo3WnRkVEorNnhF?=
 =?utf-8?B?c1lwdUZ4S2NIRlhjdUZ1RTlCS2tSOUkxa1J2OTQxbmowUkQxb2RHZmp6Wk9j?=
 =?utf-8?B?bDRMc09NYWRKQ0c1OWoyOE5LelRIUEF3RjBTRndBaG1tN3pEbEI3VEF4WnM0?=
 =?utf-8?B?MEhHajhRK0RwLzN6cWliSEo1eGFzOVh1VDVtWWIxejl2dzJyVS8zK21CaG5V?=
 =?utf-8?B?WWJhdkhXTVJRT0hhZ1F2SnhDWGI3NzB4M0JGanpDY1I4N1VnNTZ3a3dWV3NH?=
 =?utf-8?B?MWhVaGdIaVU1Nzd5SHR1eDF2cWxIQzlTT21UVGVDZUJtTlNzc242Vk52dE1k?=
 =?utf-8?B?OGtTUDBXUWZQckxxREhwYW1pTTMzMnJtejE1dTRNemR3VGRIQXRoUGV0K0tq?=
 =?utf-8?B?NlpOYloyM0JxeGFxSEs2eTdRaFJmaHJnSDlaTzhlY0RKSlFXRi8rcDJGZzc1?=
 =?utf-8?B?Z2RDUGlOektuVi8xT1RqZGpTRjZ6ellJYVNpL2xqM1BnZWUrVS9NcUxjL05R?=
 =?utf-8?B?SUR4TGQ3VHNEVWJqK3FQT1BnQWFlRjBja1pHclkvdHBnRGI5Z2liWEpITm5J?=
 =?utf-8?B?WTJqazJZTWxST0JUbVpQSEF6NWZ6eGMzelRvUXFuc0hXNTlWaEQ5VEhEUm1X?=
 =?utf-8?B?K1R1NklpVVJYNlMwZ0JZaHJvQ09mQXNOL3p6V05wMG9FSndkWVBZSnNkaXNq?=
 =?utf-8?B?OW9YcmFNUnV1OE5NRmVScGV3bnNXZ0RONkFCOHowL1ZwRnQ5RTZsa2ZiSlJh?=
 =?utf-8?B?TVNTREgxVzRyMGhhVUpHaUJlbVFFckJFL29UTjZwOFJEa2RGZmFJcU9MV3d3?=
 =?utf-8?B?OHJQblhJdC85VjNyYUl6MXNJQkF6cis5VVRUYWdEZytkRURHZDJENGNrTHZn?=
 =?utf-8?B?OFVxUE05Y0FmbXpPZ3JVRTlsZi9qaW9zdm9odnl4QjFQUHF2VXZiL1AvTUpz?=
 =?utf-8?B?RTFweDV6SWtpOWJkNXFKYkJoRFJJcHN4aVQrL21BWGRMdEZJdER3UjB5OGxB?=
 =?utf-8?B?dUVibjFyV0VvVlZtUTVqd0ZoZGdUOFdKay9mb0dNWXNTQnlOaGh4WFV6MjFY?=
 =?utf-8?Q?qizc1MK/UI34e2pmdByX1zMckYwPMqAYQM2sQVO?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16509a-e061-45bd-01aa-08dd832f0073
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 12:53:25.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8018

> Something like:
> 
>     [credential "smtp://smtp.office365.com:587"]
>         username = someone@outlook.com
>         helper = "!f() { test \"$1\" = get && echo \"password=$(cd /workspaces/codespaces-blank/M365-IMAP && python3 ./refresh_token.py)\"; }; f"

Interesting, and this works too!. I wasn't aware of this.

Junio, I can drop the third patch if you want.
