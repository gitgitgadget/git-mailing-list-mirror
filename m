Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF6433C8
	for <git@vger.kernel.org>; Tue, 13 May 2025 18:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747161249; cv=fail; b=OSqSfZjyWsLlmgmQA+DliAH5le+XXuZ9Q1EHoU0WrCz3uxuOzhbRmCOxbtz11G6gPGYj2BK5qBdgOPrFchMfH04GfRW/Fn4JqhMK3gaPpP0tJRKb6A4wl+aZmYnMTsA7QGFZqvE5zqC95hcbUp6+wj6aiCZ9b/ZXbjuOUiCrP4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747161249; c=relaxed/simple;
	bh=jOd5N5e4aFqfIQRMGtuXQXfV2DmkUt4c/I02bAf0yv4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mGO4k5OujLhJ9bT10NgIU6EmtI93rsi3Zceto33VZWX7RmT/rPf1AMKRVJ20fpj61Nnt6Fd0PPSF6TUmkw57zjekDptpLVj5tteMd9eifhuAJbo/eygWtXmORraYiSTeW8ErKYc3IXBYZWRJNBpDdRfeWlO/Iw59jO7YRDrN3oY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YXtNWKKU; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YXtNWKKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEnlIt4jsKnSr6x19LCSqzt0Dqx9rRyOLZ3I7srNXK4mIlZlCFXralr90RqcsTKbAVMAI1wV8059cUylyjhvtXLoR/clqAfgm9ptE/AqAN5OTCg687lZuz7Hk29z3H6wrVzgfIo5btQSDUIjSHn+3qITd+8G1Yom+3+TfQEAb7beUs8bNjszwO+gBU39ClXP/ZHdD3gViBI7WuvR6mOqph2LPEfSgJVtqHQCFrIlHuY3APHCzjyux/xOTAqzqtVv3ot8iLoLH/8p50sAu3GYP2YoM2Rrdnxc4wummvz6NAX8jjBqdVviYYcqQsJpgsj2TgWpT1JsOLFW/zv/g75dwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVp+U1epGIaCYKwg35oq9zyNCxhw3E+pwVXx9qQF5BM=;
 b=o+C+8lOls2ipBC8ZcJ3jPKJR+jcduwxkrrz3JPPyeWavQjZfUCfXPWtdPLuWaIr5McrKMBUAEM72Q4cmI4XzAyScfvuc5hXO0Hzx3puCN6Z0ZkE2x6jlTOdVzgMMZP55GNIxrs+YmMr80xZ+M815M37oNGMwjPH3pXwQb/8EVuml77WE+nDwoNdLw8hA0pJ6fXZlJofFGNBf9uBqhnTAfVc9Q4FpjFPug6rElUmkvBaELB+DnaeuPCq+xj20m+nlenxSiBaH//w4BxjIHz7DgVZU66LeQFFrkyMUdWXmZwQ6VeKjyphi3cSz6lVOK9bnh+MZFKNmoWL+i4hzvWJbiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVp+U1epGIaCYKwg35oq9zyNCxhw3E+pwVXx9qQF5BM=;
 b=YXtNWKKUSWScCZH+XTvToou1bFfIWgBBq9OJVLz/rykMb7xwCJZRU3DIMeYhZAKwLExoTB9hHKH6CFBVRQFTQBhZ7bgm76XnmwB+6W5PWDSgQR4JnbvBv1aR9dd5dgg1B0aW7bd2m0mpmZc32ht1dIq55b2qSppH1XiA3HSRGi/jfXKdrxYwdIWx4P+mhIsOpYSylDsG7IJl9YYaSFJCvFY6g9ZfQKBNpLPWDvx0kKZZz40zEanGcfGFiihdkqGu+g8o21S1oVVW4Jhkr0O0F9klOtuq+elo3Lu87QEoKLvQMZBcqXovKWKY6i8yuYWQmZ4DCbexs2JnkY8vjKEyYg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9168.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:168::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 18:34:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 18:34:02 +0000
Message-ID:
 <PN3PR01MB9597AEC10C20F4B06C4BE254B896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 14 May 2025 00:03:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: add instructions to use Yahoo with send-mail
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 sandals@crustytoothpaste.net
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::27) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <a79e75cd-33c5-45ae-be42-b92eaab04f3f@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN0PR01MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b9f2590-902b-4e47-2da4-08dd924cbb58
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|461199028|6090799003|12121999007|5072599009|1602099012|440099028|4302099013|3412199025|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHlzZ2hoTXR5VGZBeE9OOHEySjQyL1VZRWwvUUU3MVBTYzhzWlQ5ZzFYVUV4?=
 =?utf-8?B?a1Z0d2N5ODBnRTFDN1hEY1R2b2V2UnVCRUFKNVRwNWx5Q1p2VFI4ejI5bVZw?=
 =?utf-8?B?OUo3VUVJeno0NkZoT1F1VVJUc0Y1bXdDRUY2SnRpREhiZzRMU0xhUHFIZnBs?=
 =?utf-8?B?R2QvZG9TMUd6aGpZR2Ria0VoQWs3NitRMFpINE1SQnBZbkNNaVBPaTh1QTls?=
 =?utf-8?B?SERIaG5pUU1WckxaTTBvQWFSZVRVZG8wOFhsOW9Ocm44eUg5VlVMTmVkMERQ?=
 =?utf-8?B?WE9BK2lUa0M2bjFLa2NMWnJXTS91YlREV1grb21sbk5HZmdWZklqdDZ0T3Zm?=
 =?utf-8?B?RUFuQWJrakRjMFBGWnZwbHRZR2xWKzgxdjh2SHFEaHFGY1NJRDNhbk5iQlNU?=
 =?utf-8?B?K0M3SndZYXk4azNtWXM0ajk2N0dRcUxLQjVMTVV1bU9xSlJoU0lmNUJxdjFv?=
 =?utf-8?B?TVlwL25ya0NsbFBSdzdYeWRWbGZ2RVF1bnV1OFE4UGFyYVJONWUzRW9acHJJ?=
 =?utf-8?B?RjhVbmJYNmFDR3pnNmdZc0VseWN0cWdiYVNBYVlCREt0L1lSY2tmdlNLdXVx?=
 =?utf-8?B?bCt0Y2duaURSQWVtQjZMY2hubDVrSUF6b1VwWDJnMmVhV0ZnUWxKTUIwaTN0?=
 =?utf-8?B?d0d6RE1oa0kyRUNKZU93d0RDYUc5RGZ5WnNJWjJ3aThIclA3U3pESUJFRlVX?=
 =?utf-8?B?bjM5Z2w3eWpGdkFKVHNJSjE2MkhsQ3NEZUU1RTNsZGV6Z1Rid0JKanp0aGdx?=
 =?utf-8?B?WC92enZ0bXNzdzBaa1dvTkZLcHFMYmZlZEd6T29sSHN1RlpKMUx4aWE5QW9t?=
 =?utf-8?B?S1JPSk9zUTZUcGlEcUlRR0h3YjhITmk2M1V0RXMvd1VoWGpYZm5VWXpoMWZ6?=
 =?utf-8?B?L2V2ZlJqOU5IR2IwTlRmQXBXcGJ6Ukgyb3dMSS9yd3V3MmtDSmJqV2ZlWkZ6?=
 =?utf-8?B?cGNDUHlWeHNvSEZGNzZkVnRCWElFZ0N6NTYwNW43STFrK3h4NXhLNTI3dmY4?=
 =?utf-8?B?d1FyWVF1M2lpanVRbExiYUZDSzdBZmVjQVl0TllrdWpsazBhMGxiWkNuTVZF?=
 =?utf-8?B?Zno1dHQ3cGF0RHRaYjZmbHhFbGhWeXZnMUh3VnRmQTNzVFhXdWFtTHVKOHRr?=
 =?utf-8?B?dFRJQklMcHEwNWNWZm1EejFxcm9iVkVDWFZZY3NxUXd6Z1p6OXRSZ2JPVlFM?=
 =?utf-8?B?YmVwejU3V0RuM1B3MURHWVNCOTkxSUNzbGdnUStYK01meUxtSXlTUVpLVzV5?=
 =?utf-8?B?bHNpT0l5eVZEcCtnRlpMYnJJRGQxMmw4MFVjTzJZU1VFUXljZHVDL3RhblBo?=
 =?utf-8?B?STdyNnllaVFoME1oV1VuczBESzRzTzh0TStZTHNNekpLUnpsWk12bjRFa2tS?=
 =?utf-8?B?aDhRL2xrRGdhK3dYaEphbDNUTm8wTlh0MTl6NnlUZk9naGFKdEpwenRpamx4?=
 =?utf-8?B?SndYL1ZFR21GbmVFdVJwVjBYZnUwby9UVHF4d2lEaWxqRGh6enJsazd3Q2NX?=
 =?utf-8?B?NFVGQ3JGZ0grUmxVRnpBODFDTGE5aUxUa0JzYVUwWGVDTnY3QldLZTJmaWtz?=
 =?utf-8?B?RjR5dkpLWVc2SjlxTlBoc1R2OUZjUmx5RUxwbEVqdzRaMG9yUDVTVEoweTND?=
 =?utf-8?B?OGhJQU1HMFh3cjlwTW9Rc1E2aDZSdzdGN3VSRU9CKzIyallHekdPSXowUi9a?=
 =?utf-8?B?ODU0SzQ0ZHVzSE5OMWZzRXNRQ3NwQWYvcFYwMEJGRXpnZnZ6eDA3bVpYeU0z?=
 =?utf-8?B?T01lZndoc2xrOE1XNnF3R2xoQWxJODNxZGk3NXlEUTRQSTNnaGk4U0dXclZQ?=
 =?utf-8?B?T3pjdks2VHV4UGw2Z29WQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHAyeGF4MXBJSk41M3pLd3djY2dJcXJnT0VidEZIaVppeUkvS3gzaUxwZkhu?=
 =?utf-8?B?dDA1azd0SzZvR3RoZ0NpZTU0NlJuQXFaK2ZIUHc5MExrNVlaa2gwdE85UHNO?=
 =?utf-8?B?YjdHaTVTb0VjUVNveDl6Z3llQUJCT3hPb2ppQ1FackhJL1ZHUzcweUp2SCt5?=
 =?utf-8?B?cDdpaU9sUmJxNEtKL3g3c3pScFg4eFB5MVBPNXMzNjl0LzhQN0RPeVdEdytZ?=
 =?utf-8?B?YS9ZMG94eWRaQk9Za3lobDF5RGV6VjJreng1eGRJcjIyTTd2S3UwczJzcHd4?=
 =?utf-8?B?Q09uRUFlRC9CS1VmdEgrRWE4OG5tZFB1TUFrTzhSOVFyTGJmK2dLUi9kcHF4?=
 =?utf-8?B?YnA0WXl0NVRyRE55TmVZblBoNWFzWVVEYjVETjFyWnNKMWEzSFdjYlRsMnZr?=
 =?utf-8?B?V0VOeXcxeSt6ZjhZWUI0M2QvSXUwSWZEQitOMldGOFZrS21NT0EvczN5NFNI?=
 =?utf-8?B?R1d2eUh3NHJXVHZpR3pVcHQwZE1OUTUrSEV4MnEvMWJJcWp6YXFnQkJMcWdJ?=
 =?utf-8?B?QzRNbS9mN2FqSDRmUHBMTnRWc1ZEdmhWYkNoLzlSekVmdHBBREVuZXB4d09z?=
 =?utf-8?B?czBwdVlBTXBLL1J6RTY2ZDJxaHJVM3hpYzJMZXhuVW9zZndvQWRGUDZPNm83?=
 =?utf-8?B?cFV1emppdVBsOGc2SU55MEpCMlNMWE81OFJicTdQYmltTEJ5SEcwRWs5ZW5J?=
 =?utf-8?B?QklXazVEajZWMFVJOWc4N1dVVWMxcEhoSGFleXlPeW1UUURiVnRaZ3htc3BD?=
 =?utf-8?B?SjVqUThYSjFGNlFkZEg0ZzBPd1hORzhxS2xod3Z2ZUZxanJqR0VOSjFBZkJE?=
 =?utf-8?B?M0FHMTU3WHJ5amZPc3VJOThjVUhvV3VSUlpkREsvdy9QeHpZeHJ0Y243bm9Z?=
 =?utf-8?B?Tzkrbm9DODdyNnJMTk13dk5xNHlVSVA3WEUzbm02ckNTMTNYcm5CdFY2M3l3?=
 =?utf-8?B?L3IzUXRhZUJwUUh4V0Q5V0gwMlc4SHFUQmM1am44OTFrUEZOSlljT0NzWHda?=
 =?utf-8?B?cEQybUR2NVJ5dVRzOW1vc2tCK1RLQURMQ2I3bWNmWmhBSTVESlJBZ3hRcXpp?=
 =?utf-8?B?WVlRMlA5dEIzanoyS2U5dHgzZVVnVm1OQWc2SEhqTGUvYWVPdHVmSWN0RHBa?=
 =?utf-8?B?eWpsME1pYzE5SDJ3WXJqeVlRTDRxMkh0YXArZ1VRWXRTanhDZjNLMzkzZjht?=
 =?utf-8?B?UHk0TExmclpuaFBqZ3dwRkFtZTg3YkNxYXRaTmpqLzd4aytBcjIwRXplejdK?=
 =?utf-8?B?TGtRMWZkSUM5OTd5WXhaVXFaN2dVREdmRm9UeEh0ZEpIS1czVUE3YkcwQ1ZG?=
 =?utf-8?B?M0V0Rmo4SjlLNHIzSnZ2djhTaGJrajFXMVVCRC9hN3NVNTAxK2Q4NUhvd2hm?=
 =?utf-8?B?NGdlMWhTWmFpWkcwLzBWODVOWlVhdE9vNTlQNjBlanllSkVPaGRZVDFuSWwv?=
 =?utf-8?B?NFYrdzZXZVRJZDJub2lPaU95eVhaRWF0YkdyYUNrTTh6SVFPSjVkNHRQd3dE?=
 =?utf-8?B?ZkVTRzRUWlkrTzBXaTQ3dVBxVDU1OHljUTBCMFVKTHU1Nm5DMytFeUVrWHNP?=
 =?utf-8?B?N0FMWjgxcnM1M2EyY0svcDQ2R25KRnRqc1VjVWx6ak12Q1V5S3p6Ty8rRmJN?=
 =?utf-8?B?Zjk1a095Rng0NFhTclpVaS9GN25rTXJVMW4ydVZtdms0bGZDdEdDK0R4RndD?=
 =?utf-8?B?RnFOTWhmdXBHNHhtTTdoZnkxQzZiVjFCeHVqY1E5eFI5cGxLMk9pQlliRUNO?=
 =?utf-8?Q?tCLMPMWiy2GuSCsozI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9f2590-902b-4e47-2da4-08dd924cbb58
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 18:34:01.9704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9168



On 13/05/25 11:58 pm, Aditya Garg wrote:
> Just like Gmail and Outlook, Yahoo is another popular email service
> provider. This commit adds instructions for Yahoo users to be able
> to use it with `git send-email`. It also adds instructions for
> OAauth2.0 authentication for the same, and adds a link for a
> credential helper.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
>  Documentation/git-send-email.adoc | 32 +++++++++++++++++++++++++++++++
>  Documentation/gitcredentials.adoc |  2 ++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index 26fda63c2f..61a2d03546 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -561,6 +561,35 @@ SMTP server with `git send-email`:
>  	smtpAuth = XOAUTH2
>  ----
>  
> +Use Yahoo as the SMTP Server
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Just like Gmail, you can use an app-specific password for Yahoo as well. Visit
> +https://help.yahoo.com/kb/SLN15241.html to get instructions for generating
> +them. After generating, edit `~/.gitconfig` to specify your account settings
> +for Yahoo and use its SMTP server with `git send-email`:
> +
> +----
> +[sendemail]
> +	smtpEncryption = tls
> +	smtpServer = smtp.mail.yahoo.com
> +	smtpUser = yourname@yahoo.com
> +	smtpServerPort = 587
> +----
> +
> +If you wish to use OAuth2.0 rather than an app-specific password, you can use
> +either `OAUTHBEARER` or `XOAUTH2` as the authentication method. As an example,
> +if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
> +`smtpAuth = OAUTHBEARER` to your account settings:
> +
> +----
> +[sendemail]
> +	smtpEncryption = tls
> +	smtpServer = smtp.mail.yahoo.com
> +	smtpUser = yourname@yahoo.com
> +	smtpServerPort = 587
> +	smtpAuth = OAUTHBEARER
> +----
> +
>  SENDING PATCHES
>  ---------------
>  Once your commits are ready to be sent to the mailing list, run the
> @@ -588,6 +617,9 @@ are also available:
>  	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook]
>  	  (cross platform, dedicated helper for authenticating Microsoft Outlook accounts)
>  
> +	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yahoo]
> +	  (cross platform, dedicated helper for authenticating Yahoo accounts)
> +

BTW, I could not get the source code for https://git-scm.com/doc/credential-helpers. It
seems to be a page for all credential helpers.
