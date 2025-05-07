Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011038.outbound.protection.outlook.com [52.103.68.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A638384
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622093; cv=fail; b=O0iUEU3QrDwYyl4/fXia9V2i6gL6lgx4bNtZ3vE1yRMB9TTlQgUflMUMnjG3Feg3fw1/MQEwz6ueFu+6f5fCqwPOcFPuZEBkGHhMzX3bXzHXT1IlizY/J+WvYz1P5iqykAh9Rc050vjYGvMCWyWsd+/hBYAEcGlFcw7njYScpnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622093; c=relaxed/simple;
	bh=7VGPfmISq/75qkP4uD0s0wucB+QOtHfHVaUHc4s5o1A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jaoRWjkshQrs8C9D3TCJevT4W6Kwu1GluLTTCYm16qP9ISEUBpulDobet0xP9PyTEiuvWYSumy/4rZU1vaxJGAyow2nAa9DTBh7UAhK+8rSWjviKsBu5nsGubBv7JjkVZWES/ZYqppq7aVjza1qWHGPoVWDK1sruDMZY9Aa7mAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=AG13zpfM; arc=fail smtp.client-ip=52.103.68.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="AG13zpfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cH9pe3ii0HudwOwjHrRx8VPR2zF3xulP8bx5QDEGJzk76oR9d7LI2p+XjLDg50W06pu3xtQlepp7XjNN7uoN/br1yVb6UWtSrzG/XxANIBTLf9wuSvC396esAr+kUBYpOPZRDm1WPC1qWHkLorp9gaAd9CPTGxCSXPgWK/WFEw3lLsAY3HwBNBPNp42KSyFcMzQMqY08YxWHmFtB8K1BjtmkSnzoJpB47fZFzo/qdGn/bJZpN3jPtwJRSVXC4CB8nZMH9uzScF8WlB7FPZo8DtD597j/iSNovrN6j2Av06veE6ieAWzmsMudJ3t6nRLjntUWoh1oa5k9h+ydwhyIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Oj4uet2ToZQFB8SCOuEtpGlmXGK9tdGAXLkrYcmuOE=;
 b=AHJIICiif0VdVg1SxdRbiXoDhgjrSv8bTDGEf62Eo5gSJTDf4xJ0ySqVXcozgHojstcY1WM2PsdgHm+41R8w+vwDXOI+f7emwNlniCry3+zyKooc/xB6+SaUtkfrSwcY82z42SRUm/6FwBB0EaxTclqPAnBZXUKrJefZWbWT1XHX6sR5VWV0/iXRR6UUVQX5gSJ/gLz5ZKafL2riHr5Q4wYXkCM9Ze7gmRTSHHX234rH9Uyo/L5X/MXwWx8tH4kNVqwHeUicC02RkiCjCvE1q9qo02B4DxOmOURIpfCQsGHe6wNwgFTORRA3xV4pWwhQqL66/vnufXyIRLqHPqZQYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Oj4uet2ToZQFB8SCOuEtpGlmXGK9tdGAXLkrYcmuOE=;
 b=AG13zpfMMtb9E0TiwbQgwdNOcPdRXnkw2PdT//xLJrI7F/6ZJMVLbPOZJDDFGbihbQzbOzpGjBmD0jq8khtXFtEMoX8HZSl9aZA1lm/Mx99XkUBk2CuN5oUkxMlDVb7V+aUna/S8HG5MDYM3e1wz2gYTvSz3gRN+yGJzANil3edCTvWWAJyagxtqNXlWTvs4W6Pck9/cj2Lc9yoOmGc9uBsUAeLoHX6Y5QxSFW5WK5rCAZqv5LJ2toNtxepIodj4YlGMhaTqBWHLA1jOhOq2fiHGYqGTHfUi+dnFedsHl/FUlIAcY85sjXat5+fU5Xv3Xljdcs6VsJnKxEUpUSqxdQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7232.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Wed, 7 May
 2025 12:48:06 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 12:48:06 +0000
Message-ID:
 <PN3PR01MB9597715ABF9B773D4E5BE649B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 7 May 2025 18:18:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] send-mail: improve checks for valid_fqdn
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>, sandals@crustytoothpaste.net,
 Julian Swagemakers <julian@swagemakers.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB95970B9EA9BCAFA8A4140F70B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0092.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::32) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <31471e58-1ecb-4db4-9189-e8364442a18f@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: ac99dead-1252-4563-2e50-08dd8d656980
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|8060799009|7092599006|15080799009|41001999006|19110799006|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?alhHUFVrNEJERHd2cFFsZzd2TXEwMGpiKzVXSUM0ZEJoZjVYZGJXdWFKVFRi?=
 =?utf-8?B?ZW56YXBIekxIZWJacXdmbDlCd3o4bk9zTlYwRUtzQUVxeXhQOEF6S2FPRkNk?=
 =?utf-8?B?aXZMMFdXTGpoWVZJYWRFMHBlVWZ4WHZjcmR4STJyaW5wL2d5cUNvMzR1SVdv?=
 =?utf-8?B?UnZqL3Mwb3JQWFRTSlJrRHlCR1RjbzljQmZNUm1JcHFUZnRRODRGa1VNSks0?=
 =?utf-8?B?bnNHZE5pWDQyVkJ1UVpQU0pvcStxMlFtNWN1TUxGWWFzL2lrM1VMTExiemRB?=
 =?utf-8?B?akFaTWhwUmRRN1dZa2hTMk9zZHdrSG80QjVjakxES2FkVktCb3pTQUh1R0hS?=
 =?utf-8?B?YURnNm54UFJiMmZkM0k3bWV4RkNhNStnTjBndVAya3luMmdaRWhCZlVBWFhE?=
 =?utf-8?B?Rms3eE5QdVFJa1RWKzJkbmtOQlkvMzZKRmJmdWFtTGVYbEl0RnZQY0h5UDRi?=
 =?utf-8?B?b1p2MUs0cUV3TDlxcXFhT3B0WGFNczF1dDhNWHI4NEptcWdZSkdielVKMXky?=
 =?utf-8?B?UGJwa3IxN0RPK0taVGN0STNtQVI1RHUybS9VN3R5eHZJa0FiK1luTmVVTWk3?=
 =?utf-8?B?QzBiUzFnSDc5Ymp4c0E0blZOZ1FXWEtFdUQ4Ym04MVFvZjdCcDNUN2RhMmxK?=
 =?utf-8?B?NGZxLzVmeVJNaFBSSmx3WjNMLzdLU0pnNlJBa04vTHRJcG5Ca1E3endEQ05y?=
 =?utf-8?B?OXdtcC9YUkRmWis5ay8wMGN6Z0NNd1pvSmk5dU5RNFJOc3N0QzdQRVViSVlr?=
 =?utf-8?B?bkJYb3FUZ3c3cnUrVGEzRVdobXVVVkR5SXo1MSt4T0FsaDNBV2g4NG80Tm5a?=
 =?utf-8?B?TDRTZlVzeWF2d2N3cncwTW9sQjhRVjU0eW9YRWFVYm5ka0YyQzQ5WjFobzlO?=
 =?utf-8?B?RjFveHlPNC9YK3lPSWtsM0MyYU9xVG0vUEo2YWE2eTdSWS9rYUlIQW1xQUQx?=
 =?utf-8?B?ellzYnZEelhDcXE2UG9TQm5OUHlvQjZHNWI2NC9YaTErLzFoM0RvVjBqUEpz?=
 =?utf-8?B?ZXZEaERqZ2RaWUlEY1V2Kyt1bk5TTDJpWFkxU1JrLzM1MGxVN2ZKd09BL0U2?=
 =?utf-8?B?VHBuSUJ5S08wY3ZLQlU0a216Y0J4WkZSYjFKdk91UVAyYkE1NkhOTHhWZStV?=
 =?utf-8?B?T2tmaTFQS0Q0Tlp5UWF1TUJLQ1JmUUNuUGJSN3hyWDh5YnNTdENHNjkyTGlU?=
 =?utf-8?B?ZThQWm85ZTdvOENvY1pKajRqUVlzN1FENTN1NlJJRmhBc0x2UUh0OWhPdVNT?=
 =?utf-8?B?Rnk2OXpYVlpUOE5oODM1WWxLZUUxSU10L0JlSmxjK01VNytoQVJIRkRBVzgy?=
 =?utf-8?B?dzVxS1pIMWtzQ3F6b0dmK0hxL0lNWDdqcWRFRHBDa0Jsbk1hUi83d1dLcTND?=
 =?utf-8?B?TVNsTzdSREpFQnlrZDgwL1NtM0JiTkdMQzZ1emozY3JybXhjOHJLSnA3TEQz?=
 =?utf-8?B?ZkFDaUVuMUdvbDJuTndEeC85WkhPcFRKMURCRm9rNTBrWGZlZzN5eEZPMkw1?=
 =?utf-8?B?TS9Ic3Z3dHN2ZUljWmJLYXJUSlIzOFF2K0dvVXowODR1VXFQbkZmTUVIQ1Nj?=
 =?utf-8?Q?JHEOkdjx11s5VwSe+A2J+WHrw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzVNeWxnbWlCYlNsc2dhQVBUMVI1VFAyWkZsWmd0R3RoUmE0WGh5TVNZNEhG?=
 =?utf-8?B?SDZhQnZYNGozQkVkR1Fjd2JtL0F2WnVzbnNKalBxbmkycXJsSW1RcU5wZkVE?=
 =?utf-8?B?NDJaSld2d3JEY1UvOSt3YkJqVURmWGxOTjkyRk5EcTArODV1Y2NrZUhsRndm?=
 =?utf-8?B?d1Qyb2FlaEtVK05jSVdoWUI3TFpRVEYrK3BKd1UyTlFOQ0NWN3ROM2k4RVpK?=
 =?utf-8?B?UVZ0MXJ0SDBUbk9pNWJndlVyeDZCVVZlZnJCTXNFSGNkQzJZdFhCQk1wa2t5?=
 =?utf-8?B?ZFZIRlo0SnRERCtudUtJYWVuSnVidk5aZGdpZnFVTUJjOXY3VlVRTlhwaXB3?=
 =?utf-8?B?bjdUN0JGMTRDS0Q1VUFUbGxGbmR0aU5XSDNLVjFwUkdURXp5L1RPU3BvTlBm?=
 =?utf-8?B?VjRFZStNaFhWYzhkckJ6MXhKTXRISlFLMXZMdksyMFNyNkNyYTFWSDd1ejZt?=
 =?utf-8?B?RFhPQjErY3JVc2ZuT0lzZWFjMVQzVlZtRWF5akp6ZlVKOVVyMHpic2JLaTh2?=
 =?utf-8?B?WHd1aDZBVzAwR0R1MEszaFJXN3ZjeDQwTUM4YyttWUU3Z1RrVzJ5ZGxFU1RV?=
 =?utf-8?B?Y2c5ZXNMME9DM1dYd2JFKzZ4RUpaSGdOcnVwSWIwc1ZDV3paMkNSa0d4aE84?=
 =?utf-8?B?UWVIUkloSlltNkRhcFBaU05BTGtLR21GM1JLc1k0bzE0M3AreTJjRmdlLzNS?=
 =?utf-8?B?VlNOR1NLMmZSQzBkS3lnblRubW40RnVQczgxdHpLQXo1U01idURmbUhvbkQ3?=
 =?utf-8?B?VytGand2Y3hyMUVLandrT2tOTWpvaWtjZCtIYlE5UUd1eGp0eDlRbU5Hc3hk?=
 =?utf-8?B?WWdpR2NUUnhXeTZKTHNzMHVhQmlDancyN01Mcy9mK1NBVWZyOTAySHpqa3hR?=
 =?utf-8?B?WWwwRWhLWDZaSE9FTnphZS9LUFg3dGJqNDBqaEtzSDJaeng2RXpaeDFjZTFo?=
 =?utf-8?B?N3dUY1JtcU00ZUtST241NzYvSHUzNTVueEdkT0xEdEZRYlI2ejhBWXlzeDR2?=
 =?utf-8?B?ZFpsK1BrbGpRbmRRbU1SN0krZXkwSlhTRGthQThGMmhQVnhEaGloUGJRaldi?=
 =?utf-8?B?MFlvdzRtSndzU2xNY2JoUzdUbXlPWG1DRmh3YmdFSDZNckFJdnRLeERVQ0kx?=
 =?utf-8?B?a2FGbHJBbE12aVVYV1NXMVNOVkRMVkNYRXRXL1NZUGNjdXA0YkVRb1dHKyta?=
 =?utf-8?B?NXR3dFF0ZmJVSDByT2x4RDgvMU5DUk9Pa1VST2lZbndmWTA1dTdKdWxzbTdW?=
 =?utf-8?B?blZqRjJLNzJiK1FvMGJpNjg3Znk0WHR5OEhteUhQTjBjWFA2ZGtyM2NPVUk1?=
 =?utf-8?B?dzM2Y3ZJVTczVFU1a0dRRkkwT0t4MGNSNDdMUzk3TkVUWE9jWGxjTkhTZmZ6?=
 =?utf-8?B?QlhVZWdmNW9SaXRWWEFsLzQvMmZMbzl2Wnl6dUFPQnI1bzBtbms1RjloYXYr?=
 =?utf-8?B?ZWZLWE4xRzNEZjdkNE5acEZwMVljRlB3eENnQ2VsNzEwVmtKeXlUcHJjWlJ0?=
 =?utf-8?B?UGxKc3RrVnkwRUJ2MXRXTXVaS0pkYzlMSmJBdE13VGx5Y0QwM2d5VmY2MUVZ?=
 =?utf-8?B?cW1ORndCTmY3c0h5T09MYzhhOUhuRTMwZkJxQkVoZXg5SGhqbUlPUVN3VHRu?=
 =?utf-8?B?cXFTR1hUZHEweWpEcjRWZmM3Y0Q3SXZtYXM2Uk9iby9mczJBZ05BV28rdFJC?=
 =?utf-8?B?RDhPZ25GSXM4aUdhd2hzbXdLL0FZcHJ0eWZrNHVKTzk3dEFscm43Yzgwaitl?=
 =?utf-8?Q?38oIBCtTUjTQXvfkUp7+F1wWS59XMAmDmq7yZ4n?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: ac99dead-1252-4563-2e50-08dd8d656980
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:48:05.9791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7232

> ---
>  git-send-email.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 4215f8f7e9..17d26dffde 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1359,7 +1359,8 @@ sub process_address_list {
>  
>  sub valid_fqdn {
>  	my $domain = shift;
> -	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
> +	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
> +		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.(?!-)[A-Za-z0-9-]{1,63}(?<!-))*$/;
>  }
>  
>  sub maildomain_net {

FWIW, if you wanna test this regexp, this simple perl script could help:

---->8----
#!/usr/bin/perl

my @domains = ("macbook",
               "example.com",
               "-bad.com",
               "too..many.dots",
               "good-domain.org",
               "someone.-example.com",
               "some.hdhd-.com");

foreach my $d (@domains) {
    if ($d =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.(?!-)[A-Za-z0-9-]{1,63}(?<!-))*$/) {
        print "$d => Valid\n";
    } else {
        print "$d => Invalid\n";
    }
}
----------

Also I am thinking of using `hostname -f` as a method to be used on Linux and macOS before
using the Net::Domain library.

