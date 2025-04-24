Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA0433B1
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483030; cv=fail; b=Frz6vg+/tW+S07HySSb0sllP/c5NoRASpK1nfhav0Uqohvhc9oZIPkH5p1nlejTmy7qyGKTTSNUuN4Gj6dUtIzL06InBWi7/iMdXJz7OkunFvfwzd+7MXP1YOMC14niZDETo/cXEftLSVsut8SzQSI3zdlZIpRK0HB48PsTbKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483030; c=relaxed/simple;
	bh=OUpqFfavjAahgTQVkyUyD5UgStkbDLm5Tvph6w9e58c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aEb9oSYLQxq31NtyGrd/+2Cwc+ENAIJ5eh3rCucqv6PPG+NczPp9gZlQJ4KXEGsMVaOs7xwS+gPG7Uohd2GcYTgDOdhOCKSVxTgyCo3JaLD90oo2vFR2WYp1GrrYUWZMu8jc6r3FLLnsvnr9c7AAMsh4FaBJ8TwmQq7SpHQGP/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KmvE+1jN; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KmvE+1jN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P7BR1I6zivw2nLj19yXZh16eG8Mps5kFSJi8sB1rC+qxwyRvOC0nsyHhU5DUnlP13/tsGumTcGL3P7x7ZqREzq+h/PtW6dGS3S/mZpRr8IUxnAktQ9tolWNw8RsQduXt38pzn+qfu0pgtlRtTXZyMiUav0IxxqfECf0I29V+4GWxDIhRKkhhu8LvqsLHpx47haZDZSZQVtIXLVTibbdIyqS6s6gJH2wslPbpmrBCVdJU4GmcHdIBLE/ptTfJIZRUgFjF5Pqu9GZYE1YidHCg9BZBsHIaD/1ND5cePoYUM+zV7YiRMfsDEozMSzdxO6OpZPNL4HSNv9+fzqpAKGLh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc0/lr/ODh9QRdro3kCxH0VS9S43q8sdMjwlhZ7431k=;
 b=gEDgEJUtqKJe7wc1GTCSTpESb5ADlMt91RvpXFwA9YxwSseOio3tIgzrVgbdwl7V6MwOp0lufU3CfvYE2Sdw6nAHbsR5sfnby007egnkJjdejunLqxp5gPjf8M9B0HeF8ybQG1KJ3hSCvzMvF7X7rYA4oQHDtOZK+ioQgBgZOqiVo3Fdykd8x0AYJ9qRu/3zDT+bV7MQWu49vXCa7F9xL67ICzA3Vsoel3v3G5ANjknSn2ynVGLFLOZ8tc/1EgPymNzZuSdnu3S9wp93z7fK9l8eseSABmY22iFZYMo84r9nkgNzhU6ZqxRiNGXaM5BLTlSjORnd2ewdmKyA7h2RMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc0/lr/ODh9QRdro3kCxH0VS9S43q8sdMjwlhZ7431k=;
 b=KmvE+1jN7Vg3LkIdvwqNCmWNz0k4QD3bYr8dDPec68C8KKhFOEbWV9KuEfv+/zBcQdMYrlQlz2gLFiVzqktBVh4pShjTw+BueNAIFkewBJ5ZdDivMuwogqfD+krwpLd6ghpzfTCoLrgXVPDoegnh56wwiLCoIjQ/fSlXgzhFSaM+0S8/GUMazTHCviyiJlFqn6dF1Dwnu1/6DdT4CM80IX1Jvz2R+broDQB4TnZ0sTPeiGgIrhpq8f2T+fwt/WmxbcQRQR3q6cGBiHnFDMWRbFnzMvJHtvg05pD4CPneL2XbCxOUqA7alLgpNAs5J1esRbwveFzhiDJqK4i6O7wfjA==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PNXPR01MB7307.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 08:23:43 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 08:23:43 +0000
Message-ID:
 <PN0PR01MB9588BE6B21A9D7889701D478B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 24 Apr 2025 13:53:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] send-email: implement SMTP bearer authentication
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Junio C Hamano <gitster@pobox.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 M Hickford <mirth.hickford@gmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Shengyu Qu <wiagn233@outlook.com>, Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597776CB37BE7B05A7ADD80B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqjz7azrdk.fsf@gitster.g>
 <PN3PR01MB95970394B0E4E84DA244BD36B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <2025042437-agreed-resubmit-a63f@gregkh>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <2025042437-agreed-resubmit-a63f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0058.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:270::15) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <26afcbe1-aee1-4a21-aaa8-ac53190fbe94@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PNXPR01MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f0b86a-be1b-4b80-5052-08dd8309533c
X-MS-Exchange-SLBlob-MailProps:
	UDhyqGRoB4b889fVhRJ2YOt0YVQIRbgUuWX0Ade2HtXuhUA3shcmp4BOduoc2EFnHqWx/ZaFFklpMXlPJXn6/Wh351oyTdxfA0aFmwxWicketlY/+hxk+CfXwxJXTO44UD2i22WKY+iI8Wc8lOEowINZutGq7I2EelaDdSXgk/YLgYqfT73grnGPqDtbU+EqhtYZhz0EgNuKHeoRWp4ZW7Ci6QZGbJ7/51ek80J7BmkHxaW63d/DneniLrBsaWa1enEGePz8xWAtY+sprk+7zVLjrRJNITWat/6oUw/Y9b4Ag9C3c9yM+DPfFCbjrfudWCeWIWnW3MHRHbufjXkjrsckhaLxVdNJUWi8dP7CjLWGlwK1FLSP6DHcoeLePCs15AV5uBqSOIR6i0V27oovkLeyNtBOs4ojF+IWYNHyON7Ys/aXlcbCymp30KckNHYN2aWeryrV1qt1nYwljO4Ug+0Mb8ih8NJMFlU/TD4ROIrMw48vEDJiKB97XnD/CAdktKpeQUfU4A/IL6aXOg/bSWy3OMzZokA/QSZcOvhFb8Ve/+7j7dhLmpUdLyFzctm6+xYDlNNzZVBEM6oYaVlWPqi3RS5oh4ezI1UuUP1oKSz0Z0tK9vPPkwJxCEieTaeJRgEYWoin9Ue8TmJkysm6CMJ2TcftQRlnxQQP0YuR64vdJMxu2WiXZg==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|19110799003|6090799003|15080799006|5072599009|7092599003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWJ0NmZWQklVdG0vUFc1Y1EybUxZSkRURzFObFB4N2FrLzhRcTVML21YdGdt?=
 =?utf-8?B?aTh0S1RLVDZkckxhL0dwdGc3eW9tcHQ3UmhVRGd4S2tvSUNLMUVaRDdvdU1r?=
 =?utf-8?B?SkR2RjJ3Ykdod2NYc3dKczhObWFzeHFRdnNhclBvNUkzdlJpdVMrT0lLOU1q?=
 =?utf-8?B?VXo1TzgxZ0Q1MzJkRzByb1kweCtjMUw0cTVxSGxBUDJEOC95d05JaXBKVkI1?=
 =?utf-8?B?ZnErNzZIMlYway82QTZaUU9PaU9tSFRGSXowSTh2c0xxb1h2RlhLUk9FY0hJ?=
 =?utf-8?B?WkFQdEI5RXIvK3RaNndNSEQyYXdRNklMZXJNSmxwcU1CeHZrNHQzVHJNSDYz?=
 =?utf-8?B?QnZGMnptNzJxeWg4VjhhUEdIVVo4aFBCc055ZmNQOVVRREZKZWZaTVRIekE0?=
 =?utf-8?B?NWlFdEdxcVQrM0F3RE5vRWlaeCtEVnF5RFVkOVZWOXR0Smh3YVZ0QjZkL1BC?=
 =?utf-8?B?aFR1SGZqL1E3VkdhVDA0RXh2Y2taOE9yUFhTQ1Z3aTBMb2pUYVkvNWtUNHYr?=
 =?utf-8?B?Q3A5dlF6Q0p3WmI3Y0p2TU1lekZqY3lMUWs4aFRkZm5TdDg5ZVcwb0Nhdk1y?=
 =?utf-8?B?WVJwa2dtV2lkblpSeENJV3FxbWZzSThlalBWNktsTHRuT0lCL3lSOU8zM2x0?=
 =?utf-8?B?Uy9FaWcvaEw2aVZqdDVzRjRLQ2JMemJyR3NJRGQ5eEpBSUhHSU93K1FHMEM3?=
 =?utf-8?B?eWIvQzVPZzh4QXVlbEJ2MU5Id0I1cmt5azZuWlUyV0FKUC9DV0RQdW1HZWo4?=
 =?utf-8?B?NXdadTIrYzJJZHJneHcxRG1BOUZIQmVicXhSR1ltRjQzamx3a3Vud3NIQys3?=
 =?utf-8?B?bGpzdVc5QTlDeEhHUUJFeU8rZjVEU081dFppVUtiNVVTcmpUS3YvMzV1NTZW?=
 =?utf-8?B?cUJiZS9CNGZRRHlQVVVadURMaW93bDJnS3U1U2diRUp3NmVheEY4RHArcUZC?=
 =?utf-8?B?RUp2VHNRSVhVSkU2eFM1QWNmSURqRVNwOFNFeXN1NWxEVUs3RHg4R0dmeDVX?=
 =?utf-8?B?Uk1CZnFBTUQ2QmZ2WVpaQm9iRXRPZDM1bEw1NklNeXRYQkZ5TDZvS2hOT3BE?=
 =?utf-8?B?NFVmMnloTVl0WjNGL2sraGMwOHkxeVpPZjNlcng1ZU0rNkc0dk5LbC9sL1RV?=
 =?utf-8?B?dmZhcjZUOHFuYkkwQjFkUVVGaG5jNmNId0pqV2IyR2hMK1dkVUIxYUl4S3pF?=
 =?utf-8?B?aisxdkNicjRQM2VmWW10NWhGY1hDd3JUaFRVTHUzZHM2SUZxazB2SC9kdDJX?=
 =?utf-8?B?aXhKV1pUbm1Eb3d6WTM3cFpiL1VKZVNBTG5wZ1dNTS9sUUIwNmpjRFViaGdE?=
 =?utf-8?B?am5OVjI5SkxYT3JkMEhNUHZ2SkpsVlorclVqdHhmR2FadHoweDhxWmZqYWtv?=
 =?utf-8?B?N3N5ck1wWWZlK0grMkVIc3JaSHJPdnFFdm80NzlIQzBOajlGQzdsTytTRSs2?=
 =?utf-8?B?MGZHT2dCc3gwWDhNRVBlRVd2MTFoZ25YQVpiN0JPNG1SY1djWkxGbDlhMDZr?=
 =?utf-8?B?ZkhMWWU3U2kvWXEyd2Q2L0JuQTNpUlBXS1JEUXl3VmUyMHNvcEwwWXN2SStL?=
 =?utf-8?Q?tvSOBanfz1Vdv9+1WcAe5rLS8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFycHMvclhmbm1ZOXBUR3pJRlh4MXNPaEF4VFhWeE50Ly9VWEkzVUlKcWho?=
 =?utf-8?B?ZFRGV3IzdVJMYSt5azFHTDRnSEdLbi9YT1ZYU1lkVUR5aGJqdEpyRkJkOUpD?=
 =?utf-8?B?Ulp6WFd2TFU5aWpYamJTMmxBRHJNSHJ0cVdGbFowcHhrY0xVQnJVdEk4dUdI?=
 =?utf-8?B?eVM4VU5tM1BDT0VnTk1GUFE4dEVlQnFqeDJQS3NIV2NzdmFRZUxNY21yUEdr?=
 =?utf-8?B?S3VjVmxmdXpldkJ6NVhHRDhXNWp6WUxCaW4vU2FzaXZiOEJpMVE3Wnl1dTU2?=
 =?utf-8?B?N2h3cTJVWktldElQNXVJcDNHb1ZteFdpZ0JFWURRNHh3R1NJdDZ1dFVIWkNM?=
 =?utf-8?B?TlRtMUg5c1NCMmZRTXlxaXNZYXE5VXVESnpqS3owL1RDaFAwMkxpZTVyYkZO?=
 =?utf-8?B?TEx4K2NoWmF0MHVTYklUUUNUcHJSc294NXZLeGd3Y3F1dXgyNk9ReUZJa2RW?=
 =?utf-8?B?RUltOGhVejNuTWtzVWptYlAzcmoyazFKNGhGNnB0ZFl5SUxlbFZpRTl1TmNM?=
 =?utf-8?B?UlhFeStzVkRlZERZazQxOUNJWUNJcXpjdExGM010Z2x4dlFhZjNjTXJZYXZS?=
 =?utf-8?B?QnVHUDl2SEhQRXVqVWZ4OVhwcXJEc1dLakdLcmRaQ1YwZ2FlcUtTa282cld5?=
 =?utf-8?B?UlZrTTlEWGYvT3VqOGRDYzZjaE9PeE4ydENsekF6SUJOUnEwNm13UnVlSlBp?=
 =?utf-8?B?U0NSVEx2T0pya3BkVXgySForSnZEVjVkcWdpTTZKVTFZYk1xQ1VQdGh6RmlF?=
 =?utf-8?B?NjRJT0lkcmVrcWcrbXNzQmhpUEQva3ozR1Q3SVpwM0FudUFacFh0c0FBWWpx?=
 =?utf-8?B?bkpVRncySHdBeDNhUnd3OFpNWkpsSXFmTTdiWllyV0wrN1lsQ2w2eFhLdVpr?=
 =?utf-8?B?U2JNcENGcXM2TkhqVDBJZGZ4dGN2TWtjdm9icWU2NnBLRUluTzYzbzQycWpq?=
 =?utf-8?B?dFUrZnY1RmZIbEhCYWhHUDBzZ0VqVGZhVnh5eFR5a2VsM205UGZLdURRdUZv?=
 =?utf-8?B?OXlCMTQ1L3pBMXdaSGZ0Ui9ncXlNTHJnaHBUTTA5bHMvQjk1S08zM2grRU1B?=
 =?utf-8?B?YXFhbU8yRG5KR201Vk4vNGlaWityZ0RYYWw1aytuNTYySnE5cVpjazdnbUdZ?=
 =?utf-8?B?aUtZVm4yUE9pU01WdjgvcnBkNnlPTHEzSzN1aElvMFdieHJSSU53TG1QS0VS?=
 =?utf-8?B?UDk0d0VxbkpUL2ZPZGRlK1Q2TVl3cXM4ZlFBMm91VXo4TVlFaVJUd1pIREJh?=
 =?utf-8?B?R09WOHcvYnl6TXRad2VhVlBmdHlXS0JFUjc4a0syRXg2WFpUbGxZZURkOWtQ?=
 =?utf-8?B?S0NTVVVMQjI0OUV2dmpjeVoyWjVPb3JHbk9STno4THFwbmZxRVR2NUxXR0Vu?=
 =?utf-8?B?aXlmdHkwNG1SOU9jQ01wZFpqWG1BL09vK1ptVmxsSEhVMWVQa3dBdjdIWnN4?=
 =?utf-8?B?S01PNFZJK0praUJJSmRudzkyMFBJU2h3bWJwYnVUUXJYSzBHNHhsSTBnT0Mw?=
 =?utf-8?B?eEdyOC9XcnB3Z0FHMXEwaDdtZmladEdSSDZOWkJlMmNyMC83c21PRFZmOVY1?=
 =?utf-8?B?V1BSaHdpTXpXOTk2ZlRyTTBrSEpvcHRIUWZZbnV6a3JLck9hV2hEYVBSUkhr?=
 =?utf-8?B?RURNVmlWbG9XbUh5ZEdLNDBVbEUrZnBaWGVPOWtFcndId3BpaFRXdFA5Y21T?=
 =?utf-8?B?QWxlSGhIK0VtN0JJai8zalAveGcrV01XVFR5WjBVSWZYT0lDQUFDb2IycWdJ?=
 =?utf-8?Q?yQ4D0reM6ICBBRVIN2K3OifajD8CHizm4iw1OV6?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f0b86a-be1b-4b80-5052-08dd8309533c
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 08:23:43.3718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7307

Hi Greg

> 
> Please when you resend the series, feel free to cc: me.  Dragging me in
> like this doesn't help much without any context.
> 

I've Cced you in the v5 of this series.

For the context:

Junio is not familiar with Authen::SASL and thus, I added you in Cc for
your review regarding implementation of SMTP bearer authentication done
in the first patch.

Thanks
Aditya
