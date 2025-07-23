Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010009.outbound.protection.outlook.com [52.103.68.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DAE153BE9
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264134; cv=fail; b=bY0wI8Mc83DeEdlr1YT50j7AfrYx3ju0ebKK0ut5NNf1ZnZQQ7IkR4yrqo+99YlMigooYVjzFfgaIFPdZ9r1lY7hwa3Msd4nfyCPUUSmhUyv1d9SQ7pUXQjvMZHgmBGp2BaBfILMdbyjfGUavsM2A4ws4huz9ZuPjKtA8tgvXlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264134; c=relaxed/simple;
	bh=Yfr9oYahzu6+Nbg4ZklZVMpsHb7+rtlM3v5fGAUKY1s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A2hRsC78DEuXBiLpcs+sC7Ont22CDK/u/5iQLMiLSWtmTqOHYmF9cJnATo5bRl6gqhdAE4Qtf0F7KydxTpeI0G/VslZ07nokKO7kliVUiDJ1MEeT02G8u5jfExvW6H1wuy+PTtdNhHBNvF6u+RW+qdBAHzapvKr5R9a0wndhq9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bXUtAfzR; arc=fail smtp.client-ip=52.103.68.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bXUtAfzR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt4uF+ZfdAXyMRTAgLX7wBiJykRCHBFbMmBIQ/bhyi7ktWDrRIjp7xMQeIou9unhmBzSKLi6IUw8U/arYzywWEz+hAwZgvIjGwm5rPfiLRjOtv2wrMWAEh3K0S4srKckdimL5KWC4LnKlETkUYuX8hVS8KpuCsgcO9Axro6Tp5irn/y/6ljE3ew+vRxSD5LAJzRDFFhoPxUmUkLHG0SMzkx3zgzAdarm4WEGImo/q3831YMYDV0HOqPHLDWoWVZpmOaNq1A/riftelOprJbp8q7Kk2wpAL/O4xmDrdZpRF63uIMKcgzNucr6PijPMV3jk/sTRLWqjeKlVtggdKLtyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iijbOfouklKOemSWnj70Q5Eco690mbJTZsPk2vGw4ls=;
 b=lW2oXILNK2YXAd3jU0W6FKsOh9dfzXncvkWCgNAIH5esk8eWISan8u5JHzTlMdpEgVHo9PjFKL1qhmRKIT5fQppD34vknQkH7ye9hkJlRVznvxE3KN/j5Yd2gzUrYfY40xIR23+Bx2AgiQ1Fy9GHwwytykeQa/069UX0iaRImUEWijX9iZRZefqNyjzc3WRzme37ov4tq5e1ebgjlh2CudAK9LMFudPB6Fqly/mPbIdPMNYk8uXLM9Bpp2c8Qe4cWGWPVB8+7G+ZpskjC1zU0d1uufaY+46y8Wf//dV320Yj6iDkW3wSo9AdrmUq4/cwbQrjTiZV5lg9jrikNGC1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iijbOfouklKOemSWnj70Q5Eco690mbJTZsPk2vGw4ls=;
 b=bXUtAfzRPIUqB2cqdqqxZEa2wbCXRHPB5E5YAnkHzXDVUgtQ094sHr2drqPBwH2sUEqBYNXbPcHNO+oY0buAUzYbCWsf1dis/t2ml4Lm8gDuUU1FedE9WTlJKyzdoI9VekmVRPpWMNXHXOxQPZ+g6U0jwQ/sVtI2UqBMqedATCMeO25IbBgkDndzsL446V/PtsiG6maQBgxqxH2HxNdZ6iBQKaYCuLuBI1jkJB8dRJ/MDDjnAG8BaROeJDNq22yPCa5ZdHF0efmsfb9EC8XOfiGyC16bSYL0plr8xYtOJVRrjIroSAUoHjRx92vFMZuurEeFVZsjCjZVQMb+5X2V7A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7357.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 09:48:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:48:47 +0000
Message-ID:
 <PN3PR01MB95971D1F070EDFA2562AB2D1B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Jul 2025 15:18:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
 <CAPig+cQGhy57YWLpyxZyMEUb5jc=9wHWYOOhjzEaj1yHf6MC6Q@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cQGhy57YWLpyxZyMEUb5jc=9wHWYOOhjzEaj1yHf6MC6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <fffcb470-b17e-44b2-a2a6-ab293d9f5f8b@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b20fb08-583f-4061-c27e-08ddc9ce1ec5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799012|5072599009|15080799012|461199028|8060799015|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEF1V3gxM1BubWM1N1A5OHZ4YlZ5M1VEUWRhbSs3LzdoMlE1a212WVIxaXQw?=
 =?utf-8?B?VXRFZEU5L0s2Z2orNXVWME1NR1dXa3dpZ2RKY2tFa0hFSGt6MkJGUXZlWE9i?=
 =?utf-8?B?UTVGWGxYcVhoeDFSSlc1Y1UrOEluVGFNSURpRks1c1dPSW1naHlRMVpjMW5I?=
 =?utf-8?B?ZWdpbks2b2VoTjFTa01KdnZ5dHpsTndUQVd6Y0VxWnBJekFwUmZMVVQwMXpI?=
 =?utf-8?B?M1Y4Y1BndmE3SkthVWZtbTl6dmJFWEtKa016M3pDVjl1S3RvY2pFZDlCbURx?=
 =?utf-8?B?dE9xYkR3ZWY3azNFRVMwZGN3L3JseW9rWHdvNk9UZWcxS3JsckR3blVaekJT?=
 =?utf-8?B?cXlhL2Zac0UvS2FLSk8yWDFoMEZuTnhUSFhFMHliWUtiYXVCa0hIZDhtV2hu?=
 =?utf-8?B?TTdESlRKMVlEZkZNd0hybmF6VllQTWJ5UklJSTdKOCthWjk4cGpqaEVITytw?=
 =?utf-8?B?Q29sSFc1OTFOak5QNGhNU3hqWW1RRG9RNDNWbUx0TndkUDZueHNFdW9pTGZr?=
 =?utf-8?B?SHU2ZzE1RXdUajRrZHJsU2dURTM1Z0ZWbm5NMlNPTEh2Q3RQT3pXMU5QRGNa?=
 =?utf-8?B?TE0vL3FXeWJhWHMydGtxR0NSSXJhRmJuZlZ0Z2tLaHIzR1Q5UG5kS2xBUEtX?=
 =?utf-8?B?YUYyRXNpbGlkVlorQ1hPY1JIUWhacitUTmRZNjQzMGd3aGZIV0p0YUx5Rkhq?=
 =?utf-8?B?ZzVlWTJZNWkxQXo2cXRESUVNT2NqR0xMMmxrK1NkK2hCU2hHMnd5SjBMNVAy?=
 =?utf-8?B?cDlUd2FkUlVRVWRETVpyWndjcDZubWhKS25tRjZOWUNud2JJRGZMZUtNKzhG?=
 =?utf-8?B?UmdmTzZETWJhZU1nWmlKUmQwVXNHVEE4ZTRuOEJDK2U3VWxTNFA0QmFKWlpI?=
 =?utf-8?B?cVRBRUtUeEsyUkRNWWJiUkNBTS9CdWdkRkZLSHZhN0JMQjJyd2pPcEZ5ODhZ?=
 =?utf-8?B?RTVsUnlsVTZJUkUvenY1ZExWUTNQMTFFNVFWMk5iRmEwZ1VSL3Z1RUZySVo2?=
 =?utf-8?B?Qi9nM3pUZ3ppZG4xMTNIYzQvcXcwaXFnWTU0YzFOMnA3TC9SYkhVZklyTVZz?=
 =?utf-8?B?RzRUa2hWcEVCZmVQWXl5aEpwaFA0S1VDMVZSQ2RIVmNldTdScTN3SUhXQlFG?=
 =?utf-8?B?QXBacFhvMWgybStNTk1tNzlDMFpFejVGTHJZeEZJWUNmSnkxWmdUMmlIZjlw?=
 =?utf-8?B?OXluTUdYYndxa0JnejZUWEZVNzNpalFTQlB3NVpWenBEL2RJRDFMM0lwN2h2?=
 =?utf-8?B?Zmx2bjJJK0hTZ3lOeUhGcE5HOVFhbmtHaWwzYkRvRE5HWnEwamR0RFhvY2s1?=
 =?utf-8?B?ejc3UWJyTTB4bVZpQVpJZ0pVbklJUFBUbFU0STlsOTExWGpwcHVjNTJWd2Fw?=
 =?utf-8?B?dmovQUFuZ0NiR3NuMFgwMXZHaHpJaHozSm9YUUlzYkRNM0x2V2JSdG14dSs4?=
 =?utf-8?B?OVVka05CU1pwaEM1UCsxSmp3elczQ0pXWDM5VUo4djdUT0o3UXVYTkJ0VUlK?=
 =?utf-8?B?ZERKNXpRcDJLZjB0WHJNMXRTWi9TN285OUNMWVFsU2hNR2ZEQWJGL2xnbENF?=
 =?utf-8?B?Y0xoQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUVwcHRWVUVEMGxGUWlzdXFkTEpmdXVMM0dqV3V4MDhablVPVW5jZHJTaXVN?=
 =?utf-8?B?VjZQNUh5NFljb3ZaUDhGTlhXUzRWT0Y1MUlNaWZQS1RyamVUc1BBN1JpNUps?=
 =?utf-8?B?MkQySERrNUVQU3QxaW54aW1mL3VNdUFQR3RRelM3dkRsc29jR0EwWlRPaHJY?=
 =?utf-8?B?TXpUTU5zSm5NcnVuanZUOUJLYTFqeCttNnd3amdVZ3hVeDhzY2tjRnYvS1V1?=
 =?utf-8?B?WkFQQkNMa1pzNHl2WVppQWdIdW1BTUVwdWVvc2pFQUQ3bTBMcEtqUVZDejZn?=
 =?utf-8?B?WktPVkZ3Rmt0Q2NMVWoxMFl2L0ZWd0t4TkgxNVFpVzNxV3NjWVYyV0xQbXo5?=
 =?utf-8?B?SDdNNW5wUExJTFVSTWxXa1NwdHpTdDZWUFVzVmovM3lGQ0F5Rk5oSnFrS1JE?=
 =?utf-8?B?cm0zMzcySnFjaWhTb2RuRVZrUTZ5andMNU90V2RCWmdFYmRNL2YwQ2F1ZWNy?=
 =?utf-8?B?SDVVMUpPVXZEWGJOcDJ5YVdTRzFCYjRwTzJNbndleGlKdnNBQ3pFakNYT0po?=
 =?utf-8?B?bytKbHZ3NXhUMGJHTXdzMnVDMjhvS3I4VGlsTW44SENIRDZEeTM1d0ZZUkN5?=
 =?utf-8?B?WTVrREdCRmZXS0svSkYwN2tTSWJiZ0Q1UmJCNmNFRkg1L0FsUTlQeDRLK1Jh?=
 =?utf-8?B?SFl4YnlvRThPTml4RzlFbVlKZXVBWVhJWEx4am01RmpVZFdqNjExMHhEekxN?=
 =?utf-8?B?WHFqNTRBNUx4NFZQbW9GSW1haXYrMWZaQjU5aHNEOU4vMGVoNGFpMnRVdTJY?=
 =?utf-8?B?MVAwYjRML0IwN2d4TUtoRVBtVThWcEZDdjJ2NDBaNDV6TGlLaHUyRmorbnBx?=
 =?utf-8?B?Q0twTFZ4YXZJQVJIOHZTRDVBQVQzT095TzZ4SkE3ZVpzSTh6UytYQm53Vjc0?=
 =?utf-8?B?QXplNmhOeTFGdElCekxhTnpCZy8wQWhrM0J0ZlF0K3NBTFJCYkNGZ3dPM1hq?=
 =?utf-8?B?Yms1LzBGdjJoL2Z4UGc0N3NtVjlXQ3NhR1E0TWppSTU4VTQxTUhwTkQ4ck5i?=
 =?utf-8?B?aTVBQjJoUjQvYVJ6ajgyV1VoUXVTVStlNmIwekdJTzlhUmYwcmFSRVBHWVll?=
 =?utf-8?B?VDVhYy9xZVFHb2JuK0VIZEpyYnkvMndLWnJNdlJNaG9ycmF4dUkxV1ZVdkR2?=
 =?utf-8?B?LzBRckkxM1JIMzJpa1FLN1lhRXcvQ05TOWN1cWpFRWdIZFcrZFlKSGVlZDBt?=
 =?utf-8?B?NzNmZExWNnlVNnBtTDRZVlhsNE4wSU0zSVlyWnZGZTRMS2VHdlhTUzRRalhx?=
 =?utf-8?B?NzlvaWU2ZDIxK2M1T2NnUDE3U1kreHRRYXJTam1sb0piZXFsV1J0NEVrWGhn?=
 =?utf-8?B?bTd0Qm81eUFZOHBUSURGd2FGOHJQdm5LbklqWWF4akpvV0lmblBmdlErM0c0?=
 =?utf-8?B?OFF3RzU2TVA5enNPdWFpNXpsMTF1SEZ4eGtlMm9TRlMxbE1iYXNldk1EQmcx?=
 =?utf-8?B?OFJ0alp1Z0tzWUEwK0xXeXRmRWFDalpGSnVUcjZibGlQY21tQVYxeDZKWmtT?=
 =?utf-8?B?N0xkaDZIVEZiN0J6a2k1VEhTNE9VUWNwenpPWHlGdk1VMmxDSk8zOW9od0o3?=
 =?utf-8?B?S3B5U1BJUWZWWXE4OWFmUjNIWW1GV1hYSUVkdFNCWSsyZ3Rqc3NUOWhzaDI3?=
 =?utf-8?B?ejdUZjkvUDN4QzZNZHhhOE5FT1RLOHI0bTdiSGJwb2pDZzk1WGdDWUd3VEN6?=
 =?utf-8?B?dzhtOWlzZ29KLzVEN0lHZFYvcm9SRXQrOUQ2MzZBb3Foc2p6THgxUmZoaVNR?=
 =?utf-8?Q?7ioo1+eMKAGrR6xrYOSoGtYF6MKzYAPtBHXT56R?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b20fb08-583f-4061-c27e-08ddc9ce1ec5
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:48:47.6827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7357



On 21/07/25 10:04 pm, Eric Sunshine wrote:
> On Mon, Jul 21, 2025 at 6:05 AM Aditya Garg <gargaditya08@live.com> wrote:
>> Some email providers like Apple iCloud Mail do not support sending a copy
>> of sent emails to the "Sent" folder if SMTP server is used. As a
>> workaround, various email clients like Thunderbird which rely on SMTP,
>> use IMAP to send a copy of sent emails to the "Sent" folder. Something
>> similar can be done if sending emails via `git send-email`, by using
>> the `git imap-send` command to send a copy of the sent email to an IMAP
>> folder specified by the user.
>>
>> Add this functionality to `git send-email` by introducing a new
>> configuration variable `sendemail.imapfolder` and command line option
>> `--imap-folder` which specifies the IMAP folder to send a copy of the
>> sent emails to. If specified, a copy of the sent emails will be sent
>> by piping the emails to `git imap-send` command, after the all emails are
>> sent via SMTP and the SMTP server has been closed.
> 
> s/the all/all/
> 
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> @@ -299,6 +299,18 @@ must be used for each option.
>> +This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
>> +to get instructions for the same.
> 
> Perhaps:
> 
>   This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
>   for instructions.
> 
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> @@ -73,6 +73,8 @@ sub usage {
>> +    --imap-folder           <str>  * IMAP folder where a copy of the emails should be sent.
>> +                                     Make sure `git imap-send` is setup to use this feature.
> 
> s/setup/set up/

Will apply these suggestions in v4. BTW Eric, is it the issue with Outlook marking your emails as spam everytime inspite of adding you to safe senders list, or something is wrong with your domain config?
