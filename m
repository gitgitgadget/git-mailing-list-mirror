Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A3BE6C
	for <git@vger.kernel.org>; Sun, 27 Apr 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745784344; cv=fail; b=FrCKEcktviaQco5qrXJv4EYx51AuWjlsVYOU2xds2qphhFgWWYJvdo7286sb/icngY/jqeUnlSev99Ej9mwQaa5hPH7e8+qYp6zzdflmdNBF8a/+eqoalb2+zbsY3cHAlwEFVKijffhB5nNvzuxyaucPT3XqJaKqQPyidFwWOYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745784344; c=relaxed/simple;
	bh=v9Mu5v16WXNtUXk0y9EsJJJqON95/otO5pQEHrEKZvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QG431Fa59/w/2sTb4Xl0v9wKQe2W7o7nhZZZpFz0he8HoAiuxeKPSWZtXMvarI3h7//rQBbW+U74A/nTqdZakoZnArCIrdW8Y20A4DYG9c1LCOYxsWN3qagx1kCxS4U9aLdwKwfPadrEKXHG+k14Ek6Jc5Wk8U1NxFUXVeLxfsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZC18QneS; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZC18QneS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwCGvweBWlXNbHWGHo5gs1xzT/QolictxEPBj/lg9tuyDzOWT/EwFazrkRsSK+HcIJyWzyUo4UNjutua9Nb1U9pZO+5uC1zesmgpjnAL6+FTiMyMnUmS71ufIqPvBMqTOuzxY1h4j1M551CtLIFgo3JRUdmrtyMydo8EKa89pyiXvt7CAH9WwXOKXXHrHK31VoY4HtZPNc7ZhSVr9zwEz0szIKrJW+cK/fu7MU1zHRFJ3oQc5euXo3uguJrf1Pey+2coCe2x3qZ4vgrd5zjNWRjwWH8+9lqQNJ8IgWE3h5fXV7W71AGJdmBBL7hpATfp8BQ1uHEi4Egy3IzhkOEQNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4oOULn/ydxQfWO+/OVMyaUSnEF3acHikm8/utfXqMc=;
 b=igMzQ5QA2ZFG3Xfm6fiubo0yKWj6Er4SbHZxoAIqeRyofzeQ2o00hCP93nmg2u1phXuLXFvV2mhxPaPGUh3LIHPwCRJGovpKQjlCs83axaUqaCGUDautDQdLjT7wFoXRUcAKuSVXXzaK84gvMcyy8OKH+aLl/oWRVBreM95jSM/LH4NvAYsZlDJEoD2MbC/mKvqFl3R3w3is3wW+26vBUc7tV9sZV2pacNehbVNK+sKIce1gstjXeHb/St/uuUHst9Wrn9OL2/b2Ymc8nxEGvRwxSUwNTuAZu6/q81UQ/jX9SGqVi9fr2VGgcxp8KkKRY8uDqtEQQyWfmw/hjfo1gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4oOULn/ydxQfWO+/OVMyaUSnEF3acHikm8/utfXqMc=;
 b=ZC18QneS0WE6wv65XQsAkeKqgF39Kw8j4P7KuTi8Stortd+yxoyerXNk2M4KcsCG79e3zoTE0DWsuYAtUhmWkFqJCMn4SQe0YdzZiyNTWolTR57lV9ozDGMrfMkOunxTQ5bHxep2OIKqI5tBdwBsinrvwoJkKqocY5sobbB/4TOAnsSJP+zjqiy/yX9NHPVE+hjThO7zt2gac1HyE5f23WG4/eBa/IsZd+PVcufcWK5WJ5uGmBBy2MSM4aHbtby2ET/0tkDYTn7gk93TUj60RKp/LXWwD8ZNL3ELsh8fmARTCkeQegzWJTg1eHCaBDfeAKIOjnO6pq2bJ4DPKXe4eg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB7694.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Sun, 27 Apr
 2025 20:05:37 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%6]) with mapi id 15.20.8678.028; Sun, 27 Apr 2025
 20:05:37 +0000
Message-ID:
 <PN0PR01MB95888DC7CF57D9E8376B1985B8862@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 28 Apr 2025 01:35:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] send-email: retrieve Message-ID from outlook SMTP
 server
To: Yao Zi <ziyao@disroot.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Julian Swagemakers <julian@swagemakers.org>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, M Hickford <mirth.hickford@gmail.com>,
 sandals@crustytoothpaste.net, Shengyu Qu <wiagn233@outlook.com>,
 Erik Huelsmann <ehuels@gmail.com>
References: <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB95884F106749628745FDFBB7B8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <PN0PR01MB9588861EB2B9589C8BA6A8EBB8852@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <2025042437-photo-header-2d0d@gregkh> <aA0h5t0M2XZLUtvi@pie.lan>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aA0h5t0M2XZLUtvi@pie.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26d::17) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <72b1b519-6859-483f-9759-10ff0be024e0@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|PN3PR01MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb00b24-bcdb-4bad-3674-08dd85c6df56
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|7092599003|5072599009|15080799006|19110799003|8060799006|461199028|10035399004|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZitoZUxVNVJCZHlUM0gyYVdiWWRDV0FDVDlMMloxUmhxZDFzSjBaK2crdDJ6?=
 =?utf-8?B?TnZld3BkS09QVVpIRkNMVjdoTmJrQ1ZEek93b2FRQ1gyYmNwejQ1bStwVUNS?=
 =?utf-8?B?djNjdSs1cHNCdlE1dlRBMk5EWlF6Y3JoeUtYaWxUZ0ZlNFdZVGw0UG9INWY2?=
 =?utf-8?B?b2JBVVF1UUV0WUZYNUZHV0s0ZTE2cFFHTmhTbkxzaVJQRFJaWGVHN2RoUVZM?=
 =?utf-8?B?cmcwQm9VTmhKTWVpNEEvWXhkc2pkUUIrckFjcTdMekJCNWU0czcwcDBGSkl4?=
 =?utf-8?B?cjlrQnhacXdhNUR4SjBScG1zeTdYbHltMGZFVlJHMndndDFvYUxQNnZhOTlO?=
 =?utf-8?B?dzVOZnhHVEdTdkN6ZzdCdXBMcTh3S1JaNm1DaWYrQVgwN3hzcG83ZURicTE3?=
 =?utf-8?B?UHNadTB1anBUT0pIZkI4M1ZUT3cyamZiSFRoR1JZUncrd1VCTlJCYUdNbUxW?=
 =?utf-8?B?cjlidDNUN2JvOXptcSsxRTVtRndqWlgwVlZ3NEFGTGJNaDRPQ1h4ZDRUdzJZ?=
 =?utf-8?B?T0Z2bE5QSXExM3pYSTFNRTc3Nm9HeWNmTi9HRENSMldoR0U0Nlk2SmNLcGsr?=
 =?utf-8?B?Ky9GWmpqZGNaYlhsY0g5MU1WaDdERXdCR1JhV2E4dFRHaHBvcUR3bWp6WDlv?=
 =?utf-8?B?SURBQkpPenRaZFVScXlFRktlRjYrVG9PM0JGZEhNdXlROVpJNjF6aHZpbDNt?=
 =?utf-8?B?eUkrWk9qaktDbDA0QmtBRnhXOUFaYVdXU0VmODV4cGJOTU10ai9xYnlGL0ZW?=
 =?utf-8?B?M0tjSWwybjFkT1ZHckVsUkZsWjR2STRTVEpBWWVaVDJwVFBPLzhWaFBwcGZQ?=
 =?utf-8?B?dFE3MFNsa090R2ZtNVRSQUlZVzY2VGE4VE5WUUhxb3JtRWF3WHJrakZRV00x?=
 =?utf-8?B?L3NJUlB6RkRuZk9KWVltVk1zM2Y2aEV3Tm9vaVM0MjlkY00xQXRXY04yY3NF?=
 =?utf-8?B?dC9ZZWJ3b1RpRm5yREtFOUVkVmh6Rm1lZ0pjOUJkN2Ixc2xGU01GNlBKbWZZ?=
 =?utf-8?B?YzBNSkNwNjA5eDFoN1lzMEp5RlJhOG1zYlZSK3c0dTUvZ2lHVk1FOXVkYUpW?=
 =?utf-8?B?SlE1R3dQMEhrYzVKV2pxZjdyb1F1UFo2anhjRXY4WC9UL29iaWJUMlZVQkxu?=
 =?utf-8?B?NDJPNzZTU1JkRklPZkRGR01MbEZ3ZkVSbXdtUVE0anRvUnlVRHZTTDA3Rllh?=
 =?utf-8?B?cmNaQVJWY3RpdTYyMXVHamh0WUZ4dDRVM1FGWk9WcFFFcUZQMW90ZnFWTWpV?=
 =?utf-8?B?K0kxZitia0prdGU4ZllvMjNvZnFLUWFKakkxNUltWWYxTU9iMmxJNEh1MTFO?=
 =?utf-8?B?NWNlN2lhSE5mdDA2cWpMN1BMYlJKemszSnNEelJHemtmNkhrOUh2M2ozbDVD?=
 =?utf-8?B?NVRNSHpqeWN2djhkb1R2OW1VTksyVExEOTlWQjhPUXBKQmNQWlJybkkrS1U1?=
 =?utf-8?B?eEdvK25PRUpWMldVMjNKUjU5Um5rUEJ3UVZPWXVYaXVOeEZzZE10aVZMajI2?=
 =?utf-8?B?cEloOGp6VGZTUEdKYU1tbXl1d1RudXRNaGEyK285WWwzVmdiV2lRSy9rSUt5?=
 =?utf-8?Q?klLyNVxuVJwGDKUdugGi6Vh8/adkCrr/NP8uz4uufGaOOw?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjRYYjY2Q0dmeHVpQ204ckNJWU9tRWc3eUEwdE4rNUtlYlQrZ284NzIwMDFt?=
 =?utf-8?B?bUJlQnBWelVza1RYNXZqcytoYmZsdjZJSmhJU0xyZG5UTUJVeUowSWdTRjBa?=
 =?utf-8?B?eEJES0Npc1lrK3gyQ1JDTk41WHRYSG9HLytkZlkrWkxiM2RSY2dndjZTR3J4?=
 =?utf-8?B?YWN4L2dudEhXQjZmOUtqRWNGTWxaVmt2eXZzTlpZNnUvVXE1bThxdUFyVVBk?=
 =?utf-8?B?dHpMdjhDcFZ6TjUzeXdZdW9PSmdkdVpWd1N2TmNkTHRTSnhqUnRDbnFnUGRz?=
 =?utf-8?B?Qy9rWU9kVjhtVlRsbUZEYkZGSWYwTk83K0ZWSHhwZzlUZUFORlJ1Z3VSb2sx?=
 =?utf-8?B?eXphU3FCa2h5dVhUYjg1blZmUm82azF2QjdVdERBbTJvNHI4WWVkeTA0MGhD?=
 =?utf-8?B?UEJ4MnQrNlg0TEdCY2t2WUswZThGS0g2QWQvR01SNHJITUo3VHV6Z3VFMnc4?=
 =?utf-8?B?ck56Y2VnZWg5VUZITkZMbjdGUGlHQXNkM2hkSHpFTEN2Wmg1NnA0Rk9FU0hG?=
 =?utf-8?B?NGdlemZ5alBzUVlWZDlKYkg5dFVUTjFOc2I3LzRCeFQzZ3c2ZkJzOFhBc2Ru?=
 =?utf-8?B?MDNwUWdDcCtQemVkOTB2SlJHR3VPZlNnN2hRUC9OaVpYU0MzN3JYdWdpcDRj?=
 =?utf-8?B?QVBWd0dkU2M3c3NreXM2aGxqK1ArS1hxYkp5U0VUdE96ZEZpQXQ5QnIxV0dF?=
 =?utf-8?B?YWl6RFJBYVdILzVFeE5wWXVtVWVoeG5ZQThiYTZZV3lNazVMTk9JakNiNktv?=
 =?utf-8?B?U0lOZzJtVXNGSVVxcStUTXgrMU5yZW1tWkJ5bnBwWTFscStnZ0V0b3BDK2xG?=
 =?utf-8?B?NmI5V2pSYTVLajYzVkdMbFpyUURGSGExM2U5azEwYnJQSHZxNnluMkZ0U1Zz?=
 =?utf-8?B?QmNKcmgweEFBeG9ET2hnaWhoTElyNjlWS0dvOXAxbEd4RzJJSEwzMmE3M3pq?=
 =?utf-8?B?cmV6RXEzcW80QWE2ZXkvR09qZzlCR2xhTnRRWC9kbEpOdi9kUWc4bXEyOHF4?=
 =?utf-8?B?cDBhbUZRQWY0N3hpUHZXZGZDU1J3ckhXazNlbzBQZ1FqRjhKNmlJaDFBLzVv?=
 =?utf-8?B?YW9OMy9PTXJ6VDdMZFpvZ3d3anZUZGMxSk1PR20ySXpVcXNBUk5yc2ptU2xJ?=
 =?utf-8?B?TmVUV3BWM0QvMHVpRHpYNXdZbUpjSEVuUDlmL282R2NrVlJjR0NzUGV2enlX?=
 =?utf-8?B?b3AxTXVQQktnakhncFZzVUEwOXRuR0pXK0NtT2d2UmI4eS9oR0MyMFVqRktW?=
 =?utf-8?B?ZjFaay94alFHMXY4c1hkSUhNaTFzOVduUmlqUDk2WWtBSmV1TkorcjdpbUZm?=
 =?utf-8?B?bXpFSyt5REg2UG1SRlVnSWZPV0pjbTdwNDNWSk9ERGJ6aXBjTHo2eXRCQ2Fh?=
 =?utf-8?B?TjBrQ09wNERUeHlQY2pUM2I3ZFFXaFJrenR0L1NFU3l5Q3hiUGIvTjF6ZHpw?=
 =?utf-8?B?cnJ1cVYzMHJqU0hUWjdrTDhkeTg4akw4VVhKUWx1Y1orM0hsWjFoUHJ4a2Vx?=
 =?utf-8?B?RDJVRXFvRTczcGhYaTE2RFdZd3gvVEZhbjc1TjdPK3FOTG1qNnJ1Sld5RDR6?=
 =?utf-8?B?SjA0bGFnUEFnVTJwT2pvVnNzeEVNcjZjVkNSeDZCaVVaenhDWVZGdk9HUGIr?=
 =?utf-8?B?aVpWSUJ1OVlteHBhTk43YWpWL2p3b05jWUtWR1pKNUNuMFRlVnIxeXcrd2Ru?=
 =?utf-8?B?SHdlNHNMQTFDNG1iV3lRN3BFZyt6RzZ0eDlzS1BsRHF0bExDV1ppSm1DZXlL?=
 =?utf-8?Q?XmbqtMq51if2Xassgo=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb00b24-bcdb-4bad-3674-08dd85c6df56
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 20:05:35.5305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7694

> Not only Outlook comes with such quirk, AFAIK the mail service that
> Tencent provides for personal usage does as well. I don't think it's a
> good idea to hardcode the problematic providers.
> 
> Not sure whether similar ideas have been proposed earlier: since this
> quirk affects only following e-mails but not the coverletter which
> doesn't have a In-reply-to field, is it possible to detect the quirk
> with the response of sending the coverletter by comparing the desired
> Message-ID and the one in response? We could throw a warning and
> automatically fixes following mails if the bad case really happens.

From what I understand, what you want here is, that

1. Irrespective of the email provider, I use the logic I am using for each mail.
2. I extract the message-id, and compare it with the intended one.
3. Give a warning and fix it.

But, no. Outlook luckily shows the message ID in its response, and is there in
$smtp->message. In fact you can see the whole server response here:

https://github.com/marlam/msmtp/issues/190#issuecomment-2794784869

Now say I use this logic with gmail. The $smtp->message in gmail is similar to
outlook, but has 2 main differences:

1. The angular brackets <> are missing.
2. There is no message id! Rather it has a random string of numbers and letters
   that I also am not aware of what they mean.

So, different providers have different ways, to respond.

What does Tencent do? Have you tried to log the SMTP messages?

In any case I don't find any way to automatically determine this. And I certainly
don't think we can poke into receiver's email to see what message id they got.

I also don't know how corporates work. Is the SMTP server for them the same ultimately?
Or are they using some Azure server?

Tbh Microsoft does not like following standards with Outlook. It doesn't even support
OAUTHBEARER which is supposed to be the standard, rather uses Google's XOAUTH2. So why
not hardcode? Do you have any other solution?> 
> This could avoid a broken thread for newcomers and should play well with
> an option introduced together for specifying dedicated behaviour.
> 
>> thanks,
>>
>> greg k-h
> 
> Please Cc me on future updates of the series, thank you Aditya.
> 
> Best regards,
> Yao Zi

