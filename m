Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010000.outbound.protection.outlook.com [52.103.68.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151B2798FD
	for <git@vger.kernel.org>; Wed, 14 May 2025 13:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747227970; cv=fail; b=d5t2vA4zr15ewe/3Z9XQdjSR/gQTaojuwouh3KeTK1v172Rn1m3CnuxC/sqyGl7w+12p8NzDtyR00tzNihCfI7dzwdIBT8NMqZmllTRoaFt3r7ejgqzLktg/tH0qB/pFVGwngg0UZRO3U/thzWH+v1O4HFOYWydpCjkAMt6a0sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747227970; c=relaxed/simple;
	bh=MYWGL+nlujr50G/PqUPswmUvhPCvEkGv4K4Z0JEk0js=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W+C1TYplJt0Xftw++g9DUM3XuvIk4ZlfoBe1/kqww/2MCkB1WqI1qZ3sZ/a1Z6r7OCBM23ejgTVd9+lsRfCdtM5GnzKa9y3OcR+iRpHM2fCoSsfWwLo4MmzVtsOFIou4lPHv0LQQMEBUKU8BihGjPVVmQoBVC3tpw2ZHWiROzL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sdzgHwcF; arc=fail smtp.client-ip=52.103.68.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sdzgHwcF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnsEwCu8YTbGnby6vQdw6tWcHLGGcADIM6Y7vHGhSdUgPhh7qI8aKgq9zOriuwPUoEqNPGWCvwHNDEzoMiOf2yFiBAX5YKKQLOL8hcCooEkMbDs6HAzSQa05xV1zPxMsPthqpgGEWtYYkVN/9+NqJcfhBIdmGVCcq7IDgR54QfdJQagPb0GYmdu87fvV0OiN15VyKJ8RdYyjUAJCja3J1BKAP8ctUXqOPum7zFOYpl1GL4BO1pegnmmhg3oevLajN3Pq0V6dnavBV16Z7iFMQJQlXMcygT1iZDsKbGGCmbT3hXPVmu0+jgdZEPoCsAJR7cX8geSIVnHvD1DNa2mG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ha7RSRQcS+w3SmD+PmqtwtP2J6gm7SCewAqWJT65n8=;
 b=NSqr17Pxj8FX3ZGDPNkr8TWjh2+EQ7NXhgOWsB4Cu3/w2KdLUn7wEXn3WW3nJssK+QVGdQbiFCW1j57t9D3nY/m2YYYH0UCREbZwAdSarsC0Bveuz9PQdblo98P6ZxUdiATFMCFvPwlPeT1dTDRGaL1z9A98TFp211iZCyDEYqKQPiqY3l2UJG/kzen1Qd1rO3Ny0jfoNUBUI+e0fHtFCk6LxCbNxzgL0uPl9pT7Qzdsr/HcRAY9Eifw81rDQ7cu0H2SMrw1yMPJJr6op5+CsrSoxfcxoba4gf4WYJ1Umg8l48YmQFyCiI8mg3W4HJmVi1QPaE2jkstQCeXuZ0f5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ha7RSRQcS+w3SmD+PmqtwtP2J6gm7SCewAqWJT65n8=;
 b=sdzgHwcF2uCr9dkTvM32VHs9p18TGiN305MFM2zLDnv4EXgu/LJOZRV6fI/V9ts4seBE75nkWg+bAQaDgDcTi3q8CfmrTbF145mni5A5KsJUnCbXAyeDzTN4EkvcL25mKF8qSBpnH8WSggCn7b2uU9xG06WDuYQthxpnhVU+lqW1d+w6+RENeAvUL4Fn2N3mG35sOn1h0QOiIZfxS7lWedAgd1/fP+sSjYILivVe/amDZ5y248tnBQ2dWyj0XjmhKt2ZoK8kfKrhakGl8saUrFDTr7ZLJEAJqPfwTVOn5iOoApsJr4oLZ/nyPH0SHFN2dtaHXEaHUacgPAFzBpEkcg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAXPR01MB4438.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:06:01 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 13:06:01 +0000
Message-ID:
 <PN3PR01MB959774B05496F9BC3167162AB891A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 14 May 2025 18:35:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 sandals@crustytoothpaste.net
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqo6vvcprj.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqo6vvcprj.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0231.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <7981895e-1781-47f1-9506-8f1e03cce3c8@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAXPR01MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: b69610e2-7a84-4914-2938-08dd92e81318
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|41001999006|6090799003|15080799009|5072599009|19110799006|12121999007|7092599006|8060799009|1602099012|440099028|4302099013|3412199025|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU1GakFzTTVLK1dlOStoT0RLOUsyVmtLdjNoLy96bldJaElVSXZQb2E1TUxQ?=
 =?utf-8?B?dlNzVWMvRTUzUStGbUhIK2ljRlMwT0Y4aFM5d0I1c0RFcHc0ZkVWREpVMEky?=
 =?utf-8?B?K1ZieWNSWTQrL29IK3l0Vy91dmZ4Z0dTRHl1aFJxelBZL3laQ2dqTFE0ZVBs?=
 =?utf-8?B?WndrUDdac2FmdnZpd2x6cnloR0Uybmc3R3Fyb0U0UXdoZ0RndWZna1B5S1dC?=
 =?utf-8?B?aDlENXNQRGxscVJFOWhBUTk0ZG5jWDVreWU4L0puTXpmbFdOTlR4QkZoanRh?=
 =?utf-8?B?elVsYmlqZE1NYmJlM0taNlRuV2RXMDVxU2lHWWRCN2ZmaEhxbnA2enplTXZX?=
 =?utf-8?B?aldiWkhtcXZnVzhjdm9zR0c3cmwyQWZBQkRlWHdTZ3hMUjdmNmNvUG9iaUN5?=
 =?utf-8?B?b3h0N0ZRdmMybExuUjlGOUdKSEVVNjc1aVlTcklTN3NpUXZHMnQvN2hPZXJj?=
 =?utf-8?B?ckF4M0o2ZnFEMEdqVW12Y0xwTnlmVEZjNXZqdEpQWmk3SjhUQ3ZsWTdYUVJL?=
 =?utf-8?B?QzdwM1V4U0dEckZKcG41bWJwRGtKM2czYmJTWE1yY3BuOXl2dStKanR6SjJZ?=
 =?utf-8?B?V0JTNldHU3M5WVN5OU9PaU9NSmhNbWd0U2VDR2JMamd1S05zSWhoaDlTblhP?=
 =?utf-8?B?QnM1RFdHN2NGMW1BZG1DNTZoYXZaVW1kTG9YY25lN2RZVURwWEE2alR5WVI4?=
 =?utf-8?B?TGFBOThFaks4bytVVmZZVkV0M1U1aDBRQkpsWHVWSDJabHF5aDRTRnpRV2Jr?=
 =?utf-8?B?NXpPWlpRelNWWXlCRkIyK3h6dTRwZVZUdWFGYndxRTkvTzFtb0x5dlR6amx2?=
 =?utf-8?B?WGY2cFRHSXRwcjBjdEllR3JoM3VTaW45RmlPazJiRlV5NmsrcXBoM0pidFNP?=
 =?utf-8?B?WnZrN0lYQWIwZEVzNmxCQzMyc0lpK1VTNFFIZW5kZTdkOTR6c0gyWjgrV3Ba?=
 =?utf-8?B?WDVVa1VDd29reVhySnNMWUQ5NW5YdlRSNk1tbW5QZ0I4dnVOcU4zYitBODYr?=
 =?utf-8?B?VmpGek5mTXFaM2M4WERDeEpDR09wL2VzVlh1NnVDek8xQXZwQU5ZY1JOSHRC?=
 =?utf-8?B?dXprT2pKa0o5TkdJVVZxaWkyMGdTVy9QOFR5RFFsU2pNWnQ4aVQ2YVFab2I2?=
 =?utf-8?B?TUJhclVKY3oybWdwQnhEVWZ0elJ6WklOamFWZER4cnprSHhlMEtsVy94QnRE?=
 =?utf-8?B?eWRyeW9jK0JTVUZjN0JQN0R6YXN1MnlRNjM4UDAwYnM0Rk00Tmhaa00xKzdO?=
 =?utf-8?B?VGpFamJMRlNvekRXNkVZaDNsWjl3T1RZRWNlNzFNM1huVVdYRUlSek1EWUlR?=
 =?utf-8?B?ZklHaHJVZXpOL1dDZTZGYWFyRTRlZG1xMVNDekZvNlVQMTJLM3ExUWU0Z0s4?=
 =?utf-8?B?dHBlSTNwc2JGNnRMc01udGlERkkvWDJxd1lJSXBOUWJDaXljdG5makZWclYw?=
 =?utf-8?B?ZVZkOFNSeTlVMGxXRTFTUzJ0aVAxRGx0YUw4WnJoQXNFMTNFZjErNGdCR3M2?=
 =?utf-8?B?Y3hRNU9wWVA0SkNBb0V6NGJ5L3ZLN1IzRlBja09vZ2lBQjUxOTJYbjdnaHAy?=
 =?utf-8?B?dlI0OTR5cWZBMVhVcUFDNU5NWnlVcUhSam1OVWJoRUZ2U1NOa2d6am5sL3U4?=
 =?utf-8?B?Nmp3UnIxNEltaVVWdExsbG0yNVAxTnAyRElpVkd5dGZxMHJkOWpwdDZxU1hl?=
 =?utf-8?B?Y1U3QUY2UE1BZGVWYmNLY1BPOERIKyt0aXhFWG1ZUHNrWTZOQ0VIYjdIUlVw?=
 =?utf-8?B?K2dJU0JEcHEvM0pnTVB5d2VKSGVQQzZhRE1UMWRXY0laZWQ4K1dVMldsTEJB?=
 =?utf-8?Q?HjGCmgNIrUcTau9yXSQmYGULbFW/mkQ3alL5U=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjNxem94QjR6bTNYNzVXMHplUDFWTmVmY3piZTVUa0U2VE5iWWFoejhHVXlB?=
 =?utf-8?B?YjdmczczRmJDdHhmcjI3eGF6U012aUZ2UnN2cHJ2dVNjVzZDaU83bldoejNu?=
 =?utf-8?B?ZS9MSHI1bkZFbCtlaWZ3VTcxMFNxQnl1OXl3RVBMWFNHUUNSS1k5N3FXOGZ2?=
 =?utf-8?B?VEtkMWNEZ3MwUCtQOEhFMFo2MEdjYW45T3ErZFpuTnVWM1h1Q0JXWVFMd2NS?=
 =?utf-8?B?RTRZWHJkYXVwMS9tV2Q1amg5SmhYRFU0TzdOeTlja2ZYVDJrUnU0V2x3eGZh?=
 =?utf-8?B?YnhBWkp6V3R6L1VOUlRmdlFHdUpDNHJaK3lGaDlEUzBLQTZ0enlmRjNMNFVu?=
 =?utf-8?B?VCs3OVllNkJWaVZkQmUxaTNVS2lkc01tUm83R2VLM0ZhV2cxUFRHYVJvTWpM?=
 =?utf-8?B?WkxSTXgvMFNJMWpBKzBnV2lWa0cwRlNjV0tXWjA0ZC9VcW5VZi83emFxRU1P?=
 =?utf-8?B?R0c4Y25JMFRmdEVwN25pTEtKWW1oejJyenJzMnZCdWR5K2wrVVBaenFpSGhx?=
 =?utf-8?B?aGp1cFlLcXcxVUU5dXo0UUE2dU95S09uWlE4aXlQUElJOTZKYzdBK0Y4RXMx?=
 =?utf-8?B?WVd3dVI3NXIyanRINXIySEV6ZVFUVTlscEZpSjhQUkF0cjVYcjltWlJuWHI0?=
 =?utf-8?B?SU1lWWY3bkRyVnEzQnJBMFZtVmpVUkZxUUxLRExjYXh1dGdraXRRQXVzcE16?=
 =?utf-8?B?Z2kyWU5YdlIrVm1SNGRtL2wwNllCbHh5WnNZRTRhS1BzREQ3citITDNkOEFs?=
 =?utf-8?B?TEtuTE5McUg4QitQc05oM3Z0d3J1OWFzQXhoZnNpK2RNYVh4VHlJSVdyenV5?=
 =?utf-8?B?RzdlZE1ZaHk4MkZGbWpJM2ZOdmRYY0kzTHJoRzdURHJ1aEx4TDBCdEpkMXJk?=
 =?utf-8?B?Sm9UemRndGZQdm93ZmtlbUovUEEydGFNWGxpUWdrOGFNRFpKUHJkSGJUYk0v?=
 =?utf-8?B?UzZmdnBBSGk3K0QxQ1B0MFA4V3BDVEFmSEt6c29MZmJuL1NYREZsNXJGdTZN?=
 =?utf-8?B?NVdlSmJFS3BlMDBuRlJkVW9ZclFjTlZiTFJ1LzVCVDd6bExRUDI3anl3NlZs?=
 =?utf-8?B?N0t1c0FReVV2UUVRY3FjSzg4d1VhMm1yVVNvOG1yVjczUDVlQXMyODNMbnBv?=
 =?utf-8?B?QVR4QzBGU2VhRzlzQ2FvSGVDYW1kVGMwbHZENitaTWtUTk1KZEFXMDFadDlp?=
 =?utf-8?B?NXdOY3JWU1M0VWVEUFpIYXVMYnNNTjU0TFZqQk9VSHgxQmxSM2orQ0hhOXZS?=
 =?utf-8?B?OGNhRElheW94VmpBWStyQzRiNDNTMTVOWUdjSElpSEVLeEozc25SWm9BV1Zj?=
 =?utf-8?B?TDNvU0YzRnJReFgvS1ZPU3ZzQ1g4UXpKSnE4VmNhTkFMOWxQRkNJZmduamEy?=
 =?utf-8?B?OGFIT00rOGJXY3NXSzNHOSthcUZra0JlV1g3WVBiZVZjRzVMNTNwaDloUTQv?=
 =?utf-8?B?elV5a241ZlNFRUFDSlpqWjhUVHloemtWaFprRFUyNEFtcHJMZ3lWK1lydXpP?=
 =?utf-8?B?OWhINXoxUjYxVENwcWhrMnNXenJLb1NGOUJPbktJbE1nUk9TaVlCbi9FWEN6?=
 =?utf-8?B?Nkd4aU9LR3I1dVQ0QTRVZXk3c0NPTEV2YzdUNTkrMFF2c0Q4S1hBbm5TM2Jz?=
 =?utf-8?B?bUFxSHk4S3dsRmVhWDVIZGZVdmcxZ09ZUlAwdGk4Z2ZldWNnYklGRzhZZ2N1?=
 =?utf-8?B?LzVkTWxlRHAydlE4OEw2TjRxeWUyQXZsRnl5bnE1b2tyelF1ZDhWWTdkSk1O?=
 =?utf-8?Q?+MTX1DxwY7NNk6Qruc7psn0QLxIlrerovI6Uk3R?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b69610e2-7a84-4914-2938-08dd92e81318
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:06:00.9962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB4438



On 14/05/25 6:28 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> Just like Gmail and Outlook, Yahoo is another popular email service
>> provider. This commit adds instructions for Yahoo users to be able
>> to use it with `git send-email`. It also adds instructions for
>> OAauth2.0 authentication for the same, and adds a link for a
>> credential helper.
> 
> Heh, I didn't know they are still around ;-)
> 
>     $ git checkout master
>     $ for p in yahoo.com outlook.com gmail.com

You may want to check for hotmail.com and live.com as well :)

>       do
>         echo "@$p"
>         git log --oneline --since=5.years --no-merges --author=@$p |
>         wc -l
>       done
>     @yahoo.com
>     12
>     @outlook.com
>     16
>     @gmail.com
>     4765
> 
>> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
>> index 26fda63c2f..61a2d03546 100644
>> --- a/Documentation/git-send-email.adoc
>> +++ b/Documentation/git-send-email.adoc
>> @@ -561,6 +561,35 @@ SMTP server with `git send-email`:
>>  	smtpAuth = XOAUTH2
>>  ----
>>  
>> +Use Yahoo as the SMTP Server
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +Just like Gmail, you can use an app-specific password for Yahoo as well. Visit
>> +https://help.yahoo.com/kb/SLN15241.html to get instructions for generating
>> +them. After generating, edit `~/.gitconfig` to specify your account settings
>> +for Yahoo and use its SMTP server with `git send-email`:
> 
> I am starting to doubt the wisdom of giving one section per
> provider, especially since the delta between the section is so small
> (essentially, the server address, the smtpAuth supported, and their
> official documentation URL).  Would it make more sense to just have
> a template example with placeholders, and a table of placeholder
> values that has one row per provider?

Umm, not sure how to get that done. Don't have much experience in these docs yk.

Also, I don't intend to support more email providers.

You also might want to hold off this for a while since I opened a PR here:

https://github.com/git/git-scm.com/pull/2005#issuecomment-2880140423

And as per this, we might have to remove the email helper links, from
gitcredentials, or move them to a separate section.

> 
>> +
>> +----
>> +[sendemail]
>> +	smtpEncryption = tls
>> +	smtpServer = smtp.mail.yahoo.com
>> +	smtpUser = yourname@yahoo.com
>> +	smtpServerPort = 587
>> +----
>> +
>> +If you wish to use OAuth2.0 rather than an app-specific password, you can use
>> +either `OAUTHBEARER` or `XOAUTH2` as the authentication method. As an example,
>> +if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
>> +`smtpAuth = OAUTHBEARER` to your account settings:

