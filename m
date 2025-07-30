Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011033.outbound.protection.outlook.com [52.103.68.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32923741
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888482; cv=fail; b=ssBMHvbuXPZ+3oRsAYtNlJpNcgvIBNi3kkAX4vf00P45tc514tsnV6MhfvSpf/LmXUscOj8QRz5g5RPc55Ymp195i3IMSChgcMYQbarOubrobARl7G3iEDFjuSWKdrLyrCIU5s/DuxtjA+pZfvSDWgjSbu2NIPhNNFdIOOmckwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888482; c=relaxed/simple;
	bh=yOx0fLISSLz4kD3JNbZPRTK7Ek2Aor7bUC3irtKgxtI=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qzEcUcVE1jLSqe33+T1IWRgY13d1dJ7myS1iHRLaCdhrTyQViHfaUCeqYMyT95SggsrV242h/+t2M4D7hLjf/4QXt3eyJijxx8ncPdrVO+Y+IL/iFurJ5kQM7r29++mQimsJtTrQlIsGRRS9hf46dcdurpUuR2vFMcEuUulkaFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=HQF8XJth; arc=fail smtp.client-ip=52.103.68.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="HQF8XJth"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teyNc49rdGOZU+L9ww/b3EYbH/hyfsYLnnRDCcbImAr2zsfR+LW5a0Bm/LHQfSdxtM5pJDP8G8vEPmlNpW7UA5INWKvEFkMrrr1fslZ18R/Xl4g9RxFoezpOrhEdiQ7Y/JckHF8FYODc7M3SOvJETiKzdB7F6elvW5210nOTSigGfD4E1Ce/jm0TK2CA/HPyFA8qBWnpXhzbi8l8DJrIapuach16HIAFH2Mvd/ylsVZctzwKZ3cX4k9y3Xd1DMqwHtTUE43Qeq1+Q73lHxTBdmmg0GNL+CsDDt/RATa0y1n8MI2KgMR9zkvC73MR8/djlFq56iQw0sz2fStwWfFClg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+rFh4epaeLBkgrsDxLyz21cyVnVEgExo2wa6+b80Jo=;
 b=PYeIghGB8ToAmzxiBew8I1Fqrp8A5/Btqzo3guesfOgfVt7p1Q/1f+N+v+jAkzJAH39D9haHQFX7Q1/nt9jno4B9/jDgVcHPkk16KKO6oLeLlUSZ7C88dxIAH5OOqQWK0yL4z+mO5cW7Z4UNuCWBdN8m4LkWCvWrwlCanSxWE6mHd4J3Mt5kyIFKbzO31zvpS7qme+l+RLnjFTqUnpaU1ivxyQNIr5ZjM8rr1vdz6Kkuslv5Fg3CYScuM7K+WOMCbMhGzMAbMVZ3h/QGfeWsXOiPlkkOtteGzcKgOu0+39Kpv4x/S2ax1z7FooW+e/5bJnep4Mc4N2ry27ETNTml0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+rFh4epaeLBkgrsDxLyz21cyVnVEgExo2wa6+b80Jo=;
 b=HQF8XJthn5m4Db0ykSbA9D8s9U7c5aHSoBeN9yZw1Bjyp8Es4BCvC3Jmc/Osipmavvseobu1ZLnnrqYSbyKgy/xNXqwZ4YetWrHVGKcEQuia4SpUnGYqNaeapRqL+rCuQ91T8HOghYfucHCyluk5nSpltpel2noAfnZKZTynqvcaJPzmVviKSUbslX/FH//NCwV1XjhhJrGSYqCbyt93o/4vZ/oJwufCITPBJT2ViNzq5/1hhapMTKPHgo9PCcn3q4fPrrCyBBMMcv5vtj1YbBSBPBvG448PeQs3X8xLWSsb4E9ZhNHduKtAjHuHmhJc6wrWPycVUFUPi+x+cZ4Y0w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10216.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Wed, 30 Jul
 2025 15:14:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 15:14:36 +0000
Message-ID:
 <PN3PR01MB9597D7619BE1EA6E5630766BB824A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 30 Jul 2025 20:44:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] send-email: add --get-smtp-server option to fetch SMTP
 settings
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>
References: <PN3PR01MB9597763982F1AB6B5E5806CBB825A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597763982F1AB6B5E5806CBB825A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <abbcc639-9f27-42d4-924f-7385ff55af3b@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB10216:EE_
X-MS-Office365-Filtering-Correlation-Id: dc0cf2b6-c247-4088-96c3-08ddcf7bcba9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|15080799012|8060799015|19110799012|41001999006|40105399003|440099028|4302099013|3412199025|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3ZxSVgzUGluUy9SVzBKSWUveWVVaFJGQzNzbmJ3S28yaHVvSC9YRGxRRTlZ?=
 =?utf-8?B?dlhabjZIZVl6MUN2U2dxSGl0T05kb25YUEVYNC82S1JpU2dDaSs3dVdPMDNX?=
 =?utf-8?B?TlVMaUlRK0RFM1lKTjNONGRHdXhzMHZlc0JtWVd0U09WdUdsVHpRN2o2bEpN?=
 =?utf-8?B?ZGJxeGNMYVJqbUFDRjYyais0TWd0ZG9yc0t5Z0VJWTFoRnRFOTJNRnJEbDNx?=
 =?utf-8?B?ZE55aHdtYlloS212QmYzRTRvdUppQ3J4Rlh5VkdKTmMrK0RhVkFUU3hERHIr?=
 =?utf-8?B?b3lNa3h4MUNkUUlCZ3VMUEFzd1VyR2NXOVQ0UENpS3NyTWtZMkprbllWYWR6?=
 =?utf-8?B?MTJGU3lyQ1RRK0xnbU1mbi96OUZEZ0RlMnlKR2F0a1Jjc05UQ3dPU3FpMkJU?=
 =?utf-8?B?Tll2NDhQdXU0OE93SldkOVVGTWF2NlZPYXRFYzQzai8rVGlaWCtZOWJhU2hU?=
 =?utf-8?B?dGxiYkNOVTlyZUNiSFpaaVpuV0ZSOXZtajZXV2lHSytvRC9XTVZTSEoxcFh2?=
 =?utf-8?B?RDVDNXNEdEZXd28vL1RIVE0rVTE4MS9mZkFrNW5UMEEzdzF5Q0lLbklVamYx?=
 =?utf-8?B?R1lBMEcvMUdoRHBjTWNUQnVXdjJ5VVZkcFNRQm4vWUMwdUF3aTI1NmVSdnhx?=
 =?utf-8?B?dG1vNytyOUg5Nzh1VjZKa0JZUlZhK1VkUTc2dW55NFYwdzNqMXRGNElKNkVj?=
 =?utf-8?B?Y1k0YlpZRnFpbTUvSVBkT2RDelhUK3RtWStGZkZoQnlHVGppb2hQM2c5bUIy?=
 =?utf-8?B?Tjd3Y01yVHkwK2ZlSkFUNHVvcFZLNGZ2d2E5ZnVlOWY1cjEvWm9jMlA3bkJh?=
 =?utf-8?B?bmFwTTVSSDRFVzNmOUhCUDA2TUkwbFRMdFhaYXRnTDhucHRQRG0wYWk4NUZQ?=
 =?utf-8?B?QWVpby9IMTdxbkw0aWM5OXVVcFp0dlRVTThZMytiQndsWTFRMi82ZjFyQzBM?=
 =?utf-8?B?b2NseExPWGg4Vy91RFh5NUU1M0I5dmZOWjkwalg4V2pGb0duNXU2eklFaXFP?=
 =?utf-8?B?b3ZhNUY4VGplL2UvWG1JV0RUdnBDeVFZWW9MaGo0TmhNUGg1enR6UDlXKzJ6?=
 =?utf-8?B?MFNvTTFySHMySG9QSG1od0hJdTl0RXhzMk1kWHdIOEhmeFFJVzRzYk9MM0JE?=
 =?utf-8?B?azFDcjU1OW5rQ0dnWGlTSjN3Q29NWEF3SzNBSE9vV1N4cjVwVW1zdzZVa3ZK?=
 =?utf-8?B?dlpTbkR3b3J6cWNISmIvaWxJVHZwcGFsa0U1bk1mb2tKcWxjUWNyMVhhaCto?=
 =?utf-8?B?eWpjY3U0M2VUeHVzSEprYzRNNEp4RFdXdndaNU45b1QyTTNDWDROUWs0ZjYw?=
 =?utf-8?B?bTMxQjYreGduY2pXa2ZGeEFiUHlYVTNsVUYwdkhVZ3pocXBaWnMvMURoRmNT?=
 =?utf-8?B?NjlNc3RGaTBnc0dnem5DTjFURURVUHdyaDdkTk9tRFUxQjVKbEo1NnhXeUNV?=
 =?utf-8?B?NURFZTRNZG9oWVFtcWJyNERBaVpqM2cwUU42N1RteE4vOGt1MEp0VFZLOGR0?=
 =?utf-8?B?TTlGQ1NHc2JXZzNpK1A5M1l0ZVBxRmRHV1lOaFVjWndaSFJLTVVQR0Rramdo?=
 =?utf-8?B?VHl4YTk4VWhBdjRFQTFrT3ExWDhUc00vVmZlUEtLUzJ1QkM3Lzl0N2ViZ2x3?=
 =?utf-8?B?bkRDdlh6R0RadW81Tnh5TjRTWUkzSGp0QjlTejRocVpjaEIrYkFZQk5ENFZv?=
 =?utf-8?Q?ZavuooNkvpG3zzPHJGF1?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkZjeVVjTmVUUGVKenZqaDhHcjE3TC9ZejByVk5POEtpOXE4OVk2dmVoQWY3?=
 =?utf-8?B?RW8waCt5ZGJNRTZPWUZxZi9iSjc3RVpMYjBtZmwwSUp6clJGR0RoeXZENmNQ?=
 =?utf-8?B?WmxCVUQyTFdsY1paY0diMWNyYjI3RjVvR2taYnJQMndLQmlHN2lJTUlyaXBC?=
 =?utf-8?B?RUZSL3RVejMvODI2Z3RReVF2OFI0d3QrSVFmREIxZXVjRGpOL0ZTV1hGQ2ZJ?=
 =?utf-8?B?SmNxS2lTWEpKWG1lY050bTdsZEovUUJKRm5Wdmg4Vi93YlFkalZrRDNKK0Fl?=
 =?utf-8?B?QUkvb3Y3NnorS3hMVTVNNG8yZVJ4OGd0MUlybmlhR2xpZGVJL3NxaWJkVDNv?=
 =?utf-8?B?dVRSTUs5eXhtNEFJMHdKc2ZKanBEM01RNTJNOHU4M2pDMmVOelY1MHQwa2Ir?=
 =?utf-8?B?RFdIdEJ1Rlo5UnJwbmtuQUtPZUk3dGs4MDVjaGYxeVZxaTRveDMxc2daOGxu?=
 =?utf-8?B?WkdpcFJuTjVlWmFvd1plbW1MWDJjQVExbmFkZ3U0MmQzcW13bVhqejBlcXFy?=
 =?utf-8?B?QmFmb1NzN1FPQjJXYUIvdXR1TksyK1k0RGhocC9KVnhVMkhHZjRPNEtFMzUw?=
 =?utf-8?B?OGM5QU5Ka01tbkxZMVcrQXIrZkRCL1plRDZPMHdnaGI0VkR2cUdoVjF1dUFJ?=
 =?utf-8?B?ZmpyckhCNUYzSW9pdnNGV3ZyTmw0Wm9OMGtpT01ZOUkvWkxpQW9OWDRKcnRz?=
 =?utf-8?B?S2c4ckhkTmJ5SG9QeXhuWUFWcURTMW5lbEhab21MVmZEMzBzaXB0OGZJcTJY?=
 =?utf-8?B?My9pUWtkaEZrRXN5ZjBWdGx0Z1ZONzYvMi9SUCsyQ0RiaG9nM2Z4TUVPOC9u?=
 =?utf-8?B?L1pQS2ZvMXdiYWV0NEdzS0R2TE1mT2xpVlNiTHVnSEpOVlRwNkc5L2hjRkhR?=
 =?utf-8?B?QUo5aytESFovMGpRWjZWSHI0QWRvZzl4cjVkd0IrWjVIdE5RM1FiSGRUaU5O?=
 =?utf-8?B?RDcrTFkwVDJkYnB0akRXYm91d1podTN2WlBlQkVIZkxqZGJUY3UzeEljQWJo?=
 =?utf-8?B?WXhWVE1lQU55SktqV0JuR1ZzVkt6WHljc1IzcUhCOUJyeXpkbXIrVUY3KzQ2?=
 =?utf-8?B?T2lsY0pnQXdVZURLV3dLL0JsbHhjQ2tNaTI5WnlGRWpGYnl0aDgxVnZTNklP?=
 =?utf-8?B?UXhsY1pxbEJOVnpCSWtXaElYcXZuVWpwYXpKTWxsR2ZYYnNDeXdYek1rTnA0?=
 =?utf-8?B?aVVMY1hJb1ZDcmRlaExPREFDaDdBZFdIb1RjUUsrRVNXSjVqTVV2TFFzeC8x?=
 =?utf-8?B?NkhkNjgyWmlDTFJIejBHWTZQa0c1Yy9aSldrZ2FvUXNZL2h1a3pHT051WUNQ?=
 =?utf-8?B?WVoyWVpSb3RwQXZwMTQ4ZmdmZklGWXdvTmZGUmRjNTdRYzlzQzc3WWg0REsw?=
 =?utf-8?B?MGZ5eUw2MU9yVXBFME5nbHNVbHk0QWNqRUlBd3c2bXZONExTY2d4dmJRTlFS?=
 =?utf-8?B?eDdqNFE1MGc5N2prY3VURmtHOTZXbkdIY1BzdzJ0VFptZHVobmZFTlBOWTgx?=
 =?utf-8?B?ZGxKZkhhM3hwdURmY0orc0w5N2dYM1F1YkhzZ1JQR3FUbnU0Y3crNHpBa2lw?=
 =?utf-8?B?MmpMOWZqS3hJaTZPeHd0dno5dytPQUprSXd4dlp6cTJoc054MHQzbjlZYXUz?=
 =?utf-8?B?NC9BZ0k1bDNTUGtVdUphODdwa2p4a1NwRHpGZ3F1TjB0VExXaXZkcGI2c09u?=
 =?utf-8?B?WDBHSDRReHVKNGs1L2dZQWFwSk8vdThGYWRKSVdzN0RlVlhCTnl4R2tmRURv?=
 =?utf-8?Q?SlDjYHx6KXM3IPSyRk=3D?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0cf2b6-c247-4088-96c3-08ddcf7bcba9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 15:14:36.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10216



On 29/07/25 10:40 pm, Aditya Garg wrote:
> Autoconfiguring SMTP server settings is a common feature present in many
> email clients. In order to get the correct SMTP server settings easily,
> this commit adds a `--get-smtp-server` option to `git send-email`. This
> option attempts to fetch the SMTP server settings for a given email address
> via the following steps:
> 
> 1. It first tries to fetch the settings from Mozilla's ISPDB at
>    `https://autoconfig.thunderbird.net/v1.1/[domain]`.
> 
> 2. If that fails, it attempts to fetch the autoconfig file from the email
>    provider's autoconfig URL, which is typically in the format
>    `https://autoconfig.[domain]/mail/config-v1.1.xml?emailaddress=[email]`.
> 
> 3. If that also fails, it falls back to checking the MX records of the
>    domain used in the email address to find the SMTP server. It can be
>    useful in case of emails with custom domains. It attempts to guess
>    the correct domain for the email from the MX records, and repeats the
>    first 2 steps with the guessed domain.
> 
> This feature is heavily inpired by the autoconfig feature in Mozilla
> Thunderbird. A detailed documentation about how thunderbird fetches the
> autoconfig settings can be found at:
> 
> https://www.bucksch.org/1/projects/thunderbird/autoconfiguration/

It has a v2, which I didn't send as a reply to this by mistake:

https://lore.kernel.org/git/20250730151227.12389-1-gargaditya08@live.com/T/#u

