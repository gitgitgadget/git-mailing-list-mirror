Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E59279DC2
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753261546; cv=fail; b=lZwYbzhCZ7r7NhnxyOz5bM15hx5UZs4BD8dfyjuX1G+ePjZhyJl32rwJcNgiPbTyVSenX0IrMeoF/DZ8Bo9l7Mg1RJ5IyN3Z56Y6wCNxGZ8RgUZIC+Dgc4DF2D8myn0qH+5tlE7LZO1lJZddMUWSl5N9S+EaxvGWgeq1d2PkAc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753261546; c=relaxed/simple;
	bh=wvvLMvjmUQbUC72U5qoTXk8E4HWgzs2SIgO4EqHddgA=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAYPf3kRdBzc5hXFlDTGn3i7TZpTCcEB2jcfHrrcEnwunHoakYEedaUhHOaDtMc3cIYD1qOuUs9zGYyWcSbixQU5P+Y8RlStb5+FZs8KYtbSOb9y5PNjgLOfkKQqLmzIE4JYhlZhXGLmTa4vpBBgPi4ZwBRKf2za83ya/ZZOeBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Rx5t8Hhh; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Rx5t8Hhh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtsvAy6184s0jZGBXmTion3XDPo9c0Ei4urA/JoqjmNxggLJ2plxwCLT3yezK2Rpajva5gYQzk2VGgf4PU+xBOCOljHwIb/e7UnFz/45UCEiMhWoRsPZJG84o4ZlJgt6fiPSQCeJEVH9OJzrhub2ilAPTWA1K3MqF8aXtbRi7l9ddY2o+KoqCH0AuNB0rH5P1wwps7rV+vB9uQ1Yp1CYjgu7wbCGuyRxTVufGqNOGcWpCdpmj20aP1XWoURt+Pj59z+06P3XOFfZiCMzu2vRVHuA+EDukMcj7Ar8ZaeFFPWnoZRAankVZuzp+Tq08h5JsjmEpa6IfsHVFWd2KKjztQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q58N9vXwpyy593yiulxDMn4myRXR3mllRojcHDf3oI0=;
 b=My6JvDdL64iRkf2l5Tddr+tNYqtIEt9HthNodDzkXOyysl5A1NKpMnQKMszrKR8I+KcD6VhXCixe6iqlRCii/vL4qAjYyA1ShtWNJ8uU/JOqEVQNEud97JgYVSdaQ8vlSRRavNatbqz3sidXY2r8QYqJ9+QdjZ70aaFiXEyw4PI8arthRIkUsY1xDxsGE2iRQxIhPem5ggdWFi56zOVz0GATvGNHn4n8Sf7FLYwylW6cT/8v58LfSXhvNlDYy50J6U45R7p9FFm4AeGukO2wKj5NUbIcPQ+5ZsVataTncsWOoqEK+aM83roz95wBUi7Xh9mQp/6qSkUPWg/r1dC+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q58N9vXwpyy593yiulxDMn4myRXR3mllRojcHDf3oI0=;
 b=Rx5t8Hhh4H8WaqNp4tKHKV5h6shgqiX/1BnMua370ax75uxPv+SRLayuBhzzrv6VTjWVq4n804O0P3UC0cx/1/qjLp2tFqpWfYCQWbEiD5ZXcd3zKvhV2JFgruNtii9CMISjp7XO+RaUr0D1gTZx/lHs5HFG4S9nfGDvQcGlDQUqk2VO+xO59IyOt2+1gvOKWQyZW7mMOd0sqCuiiYo3IZoaq45Br6kP9G+amoUVg+HzxGbJwwxJQB7h4xmxc9fmW2lJdFJuWzbiOlr82CwuJC2ivfnKsLPilKx7v9VBU2PJdq8I/W1IiQlA6ykKGbTc6eNvTp6p294vrwfq0yJ6Ow==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7810.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 09:05:38 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 09:05:38 +0000
Message-ID:
 <PN3PR01MB9597EAA61E0E40B027B81DF6B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 23 Jul 2025 14:35:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] send-email: add ability to send a copy of sent emails
 to an IMAP folder
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Ben Knoble <ben.knoble@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <da7cee769f25871ed3f934e3ec7f2cccf0a0420c.1753182534.git.gargaditya08@live.com>
Content-Language: en-US
In-Reply-To: <da7cee769f25871ed3f934e3ec7f2cccf0a0420c.1753182534.git.gargaditya08@live.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <f5994cd9-7db8-46b7-96b1-c8b1b13d433c@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7810:EE_
X-MS-Office365-Filtering-Correlation-Id: f6fc9937-4d43-4f59-4133-08ddc9c81765
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799015|461199028|19110799012|6090799003|15080799012|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdQc3FwL0kvMG93T1NEbmEzcDI2S1VaTUU1MEd1Z2laTml4ZXFkQnZtSUlP?=
 =?utf-8?B?N0tSOElEY05pdjFsKzY4cWd6RUltcnZ6Vm5GZnFXcU1jZjZadVJSNUtpa0h1?=
 =?utf-8?B?Wk51TXg0WWtqd3ZhTm9xVXpmQmNxSHExUlZLbWwxMTIvL0dDbHVKMnUyZElV?=
 =?utf-8?B?T255R3FGRGg4b0kxWXBFc1g2ZWUzODloOWUxMVlFc1ROckhCcUhYUER3QWhE?=
 =?utf-8?B?ZVlRTWtyS0psWUl6RVNLZmVnQTlNRkF4STk4RTlxZXh2ZkVBL0hNa1liMGpn?=
 =?utf-8?B?SERDOUdkU3p2WGpBVkV3eis2M0hBbW03M1VWU2FJRlM2d1cvenFTdnRyaGJC?=
 =?utf-8?B?Y2x5eGUxb0JyaDJLUzhhNGNXQmFMY1YwaDV6SVBZZ2wvNk9ONlAxNFNlRzhL?=
 =?utf-8?B?RjRLYjZQaVFnMGR5N0JBOWt1MEZQQnpqY1haYlZBUytCSzZreWlpaXJvakNj?=
 =?utf-8?B?NXNqY3FXWmNOTEZhQXIrYklKYy9LV1JIcFQza1oxMnZJUnZxVVVNWWJFbk1N?=
 =?utf-8?B?NkNYTEkyNU1oT3N0L0d6WU5BNTlKTzZFMUY4QjR3Uy9uN05jVTJ0Z3h0R3ZR?=
 =?utf-8?B?VG5md0xlbDI3VkpCbU45ZkJaamh5a0RONDU2a0xhdWIzanZxekpiaUF3c0Nr?=
 =?utf-8?B?cW1wNlZjM0c3a3RTRTRjVTBaVkVCay9RTFJTRnM2YXQ5SnhxMzk3RG00M3dC?=
 =?utf-8?B?dlBVTXV4dit2WFlUOFp5SW02cm5qc1NzTDg5WkRsOUtCR1NMN3Z5OTNuMGdQ?=
 =?utf-8?B?My9kNjRFL3hYVWlGaDVoajVWZkxhTE9UK0l6S1o0eVpKY0I4VkVQZFkxK0wr?=
 =?utf-8?B?dXlxcU0ySDdvSzhsNnhha3FUYzVtWnpKZWZvMGlOa3drZFk5bW43eURnemN4?=
 =?utf-8?B?TnVVZE5ROVVzaGRQa2hIUnBqRnhoczVBdzhqcnNON0tZT0RZOVVveHFGTncv?=
 =?utf-8?B?MkptajFOQS92MlB6dUZ0a2FqcFc2OFpSY3FpTk1ZUUZCTnVMejQ4a2ZjNjk2?=
 =?utf-8?B?QXM3ZzFCZnBhL24rVUpOcUFOVDQ5V2lqeFVBMVpkaHQwSTF5WGFaY0x5U25k?=
 =?utf-8?B?cHVqV2JYRUx4emo5ZkJWY3hHUzY2dElQRDBPY3I3UU9pTUdNOHBrdzJ6QjZa?=
 =?utf-8?B?Mm5aU21LL0RueHI3MUFqSTZGbFRWZW5pM0UvRDVFakR6azVPajlSUHZ4d3di?=
 =?utf-8?B?c0ZDUzVYUUZTdEVDaWxKTDB4WjF3UXMvQ241M1dzNkxqY0tjWnljRE5IbHpN?=
 =?utf-8?B?bzlEd3ZSaTRjQW5ZaWhZUElreFk3Q0JNTXV0eVdtdWJxVm4vVnZBeENoY1VK?=
 =?utf-8?B?dCt6N2p3YnRvYVVBUTc0eWpVNlhXZTYvYzJneWV0TUNHYm5GTUJOVit0bWUw?=
 =?utf-8?B?eGtRaXFXTXRkL3pld0VGdTM4clZqU1ZpM3phQ3pYQSt4NzBwSnVtamgySUVs?=
 =?utf-8?B?OVV2c2RpNWlvNkQvdDhaVEErby82WUVkNDBWSHROUCtZa2lYWFlQa3QwaDc1?=
 =?utf-8?B?cTJFVVl3cnQyK3llZmhkSlpYN01XS2Y5aDFJRWdxLytqSGxqMmFWc2ptMVVw?=
 =?utf-8?B?YzJKdz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wm5rZFRZRFgxWFhNQlFuYjBKOTIzMjU3UDd6TTRnNjU2NVVYVnFFQzJlcnJW?=
 =?utf-8?B?Y3RTUUc1K3Q1VlpQUjRkQ1gvT2R2V2YxbmdCQU81L0JGNE9LY2JweDBWU0tT?=
 =?utf-8?B?VVhod0tkRWUrdWJUNHJJazVXNkZ0b3F6R0dBN3M0ejdVRFJMTTZxS0F3RWt4?=
 =?utf-8?B?azZMSjZ0Ymw3dGEra2VVbHNiTjBOQ2FjMHB4TDl5OE9ycE0xQ2dQaUYzdjdu?=
 =?utf-8?B?SE40T0RnSXZkRzl4ZUluTHBJa0wxQmRBL3duc3BtYzN3QVN4bTlISnZyellv?=
 =?utf-8?B?cU9BUW11OFJZV3prcnlYSXorNW0xSGtJNUIyYXR3Q0c0SkpYYXZFVXlKL09j?=
 =?utf-8?B?bjZJVjQvUnNLM2hsNitWbEpPNmRoK1VpNW5QazhudVB0Y21raDVNYk9pTVg1?=
 =?utf-8?B?Q1ZRSk95S2RVWWhQNXRHV3FJakZVYjFnd2xiYms0SjRuQ0dHSExxQ05Zb1Bk?=
 =?utf-8?B?OWUwL3Y1cllScFJRSEdZcE9Uck1pdU84RDZuVmZTVWtwQkkwSlhZZkRzcWdC?=
 =?utf-8?B?ellWelN0NUxKVjF3K084SVBMSEp1QWlIMnRWeHZpdGZDdDJMT1JXUXBwSUVK?=
 =?utf-8?B?aWdTOVNFaWd4MGoyNTBUeUlZTWJEK2hDRVR2NWlFVnF3bVlVWXdEUzNid2M0?=
 =?utf-8?B?aW9oblliUmlXQVBPWG9XbnBuWkZZaTNLNXNCQjZQUWZvby9JS0NYbVRuOWlG?=
 =?utf-8?B?R2VHcjdWZm5kT2ZrRG41Z0ZwUFN5UWV3OGo5c3VsaHJWWkM5Y3B6N29XaEdT?=
 =?utf-8?B?OXorZE5vZFdEd0NYRktqYjdJSU83Uis0NkZ2cEwvWFViV013dU51SEM0VTkx?=
 =?utf-8?B?djREdm9MTnJ4YW1vMUlkUnl1aU9IeC9OTHltWDNlZmlWWS9hZ1lyK3BvWUhM?=
 =?utf-8?B?dTh1SXVjcnY1TDNUdkdzRVdNMzFYcTZzQjgrUFVSVjVCeGNVeGN6aWZMOStq?=
 =?utf-8?B?aW5nMnlMSnZSTVNBU3lUQ0tRZDhxUEdCT0p2WWZlWGc2aG5pL3JzMlo4bXZX?=
 =?utf-8?B?OU5sVkhhNllQUkVCd0JvcXo5dGNlV2g2d0tDU0JydkxjOFdnYVV1NFREVFFB?=
 =?utf-8?B?aVplU0plNE1ob1cwaUhRdWdTdGd3S2Q2QWdwL1ZxMUwyR3I5QWpYNUtlQktC?=
 =?utf-8?B?QjQvNWZZYm5rQ1ZWZENyajFMWXhsZFp5SjFOZWtJVFNYOVBPaEZIcmQwVFRN?=
 =?utf-8?B?VUhhS1NURDhCV2pTYlMrVi9qRHRHOFh2NmFvTVI0bFJZelNidzVEQzgyYU9B?=
 =?utf-8?B?SFErWlV0T1I2RDFlV2xaalllSVpsZlFTRkJORUkvM2YvS1dHYWJhanVlU1F2?=
 =?utf-8?B?d2FMZVdiRCsya01pZVhpRy93bGtGL2o0V0crZHNrMzEvczNYY0R6aEZjZEQr?=
 =?utf-8?B?QWpjdVplZFBTK0s5b00wYU9tRTdGZXdRbEp5N2ZMRDJTYWJ6RS91djg0elQw?=
 =?utf-8?B?MkR5NmJUZG5WbTFnck5vWFkxSStvQlg5NWxOL3g1Uy9hUFROeFZxY3FsYnRY?=
 =?utf-8?B?QkdnYVdLcE43UDY3SXZiUUhoR0JDM1lsTU9qdllMcG9IS2VDYkJPV2NkWjUv?=
 =?utf-8?B?T1kzcTN4Tks4SlBYY1FEMXU1clhnWnoveUVhbUFXSUJISytrT3JPalRqcVZp?=
 =?utf-8?B?LzVZaWQ4UUxFLzA0WEwyM1l2RzZWZytpdFZNUDQvTXY2N1BJRHRteDl3SW1k?=
 =?utf-8?B?NVdUeGdVM2Q4cDhqbkRzcXlXUnllSHpOVzNMbmw0dHltQ0trdnUraFZ2dE1w?=
 =?utf-8?Q?Bf46yi6/mANDPdoLmikm/2gctM3TUqEW3d55Ijp?=
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f6fc9937-4d43-4f59-4133-08ddc9c81765
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 09:05:38.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7810



On 22/07/25 4:44 pm, Aditya Garg wrote:
> Some email providers like Apple iCloud Mail do not support sending a copy
> of sent emails to the "Sent" folder if SMTP server is used. As a
> workaround, various email clients like Thunderbird which rely on SMTP,
> use IMAP to send a copy of sent emails to the "Sent" folder. Something
> similar can be done if sending emails via `git send-email`, by using
> the `git imap-send` command to send a copy of the sent email to an IMAP
> folder specified by the user.
> 
> Add this functionality to `git send-email` by introducing a new
> configuration variable `sendemail.imapfolder` and command line option
> `--imap-folder` which specifies the IMAP folder to send a copy of the
> sent emails to. If specified, a copy of the sent emails will be sent
> by piping the emails to `git imap-send` command, after the all emails are
> sent via SMTP and the SMTP server has been closed.
> 
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> 
> v2 - Fix indentation in patch for imap-send.c
>    - Minor edits to commit message
> 
> v3 - Rename imap folder to imap sent folder
>    - Make an error message shorter by removing unecessary details

I just found a tiny bug here. It is sending emails to IMAP even if --dry-run is present. Will fix in v4.
Also, this little bug has also gave me an easier way to implement --use-imap-only, which is what Junio suggested before.



