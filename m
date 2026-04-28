Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013073.outbound.protection.outlook.com [52.103.46.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032738AC97
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 14:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387103; cv=fail; b=R48Y0uBbtYUd22yPS70jzCAnUSrdIbMMaVZs6duhf3bllyFkMCvWk6etsspR/BnAWHRHS+F3hLf04E2+ZHdIrfZUaA6QLhzGVt8ggW1B/1lvGqSsCd367JfV9cqA2tn7VIKbeBCjH2x+r0ziw4Suqlr14QqGt4bHI/tW0GY1VNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387103; c=relaxed/simple;
	bh=B5oBwOhMaHgnqwLQXJOFbNCrN4iTMHUY1C1LY7wHbIU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QyaHNtSnmyWa00sLQPhrKCRT+7r5hW6aOTnMHHTsmtSNRB/QqR1NntCCp5++1gHQURXFtp/RiiZDpfoszkX20DkDqlkKo2sDzhWxnhKJSyafKwVMrPlFgUh2DenNNV1UbyuS+GKt0va4eG4T6P0QImgFvCoqia3X4yvKEytARQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WNwlzDYC; arc=fail smtp.client-ip=52.103.46.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WNwlzDYC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjW5iuhannI2ckRwGKoLLVuDkiRWne2myNvvv1RimM7EEfGSwuGBitdnK8Gj1RbkwSpHM275mS86hgkKap6Ck+CFbyp8PJC8iFKvGMnjthP4vWhw3cRB/brse2EHpbne/NYNmk6xU0jQrjdhO1srMLxkdwR3BeT3LW76RgopBQDro56ef/qge4GkeeFvqcOt4xJtHhdZAZL3FgwHlFcwZK4WLFohuSPA0FoQms7F062b660ZEavWSD+f/piJc9NWabMsbS6/3jn9U9PjJcjQ2eSJCOua+47z84H4Ia8BUnEsBV3KT5v4FXv4Hm2VRh69WY9WkvReyLlu00OKgCn2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NzVKJ6PDl4W9hU4Rl1WmzMWknnnoj+5dsuoOGlhO9dg=;
 b=gqsfAQCm+yxHsrJUH6PbddwkbHxze2FX/47/qj4CurZZWlRFik4XeEawhD15BbakDAX8JB/uCKcPqNzxhwS3Z+XULWU8IG2VIl6sQE8a/PgATj+faW5+3gcEX9LLP0KuuXiaIK3u/J4HJjlMTou6FaeIJ89K9wDOBNuQA19JgA2x40O1L96/di/ygEeYhbBjRqimybardWL4tFjTWcJGWSh3y/s/vtwYr3O5DdXU0ZNXFXfAAuCySN1urxdVJx+lmkdlyAdgO6dsle1lE9VUaLecSS9EO6xgrYTpTj8dMRpxHIMWskBy1d+HD//UF+ZKdXNSgX4vJvnPxOormTyjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NzVKJ6PDl4W9hU4Rl1WmzMWknnnoj+5dsuoOGlhO9dg=;
 b=WNwlzDYC+kfcEanKrd1ogZuNiG8/s3gFaQx5OLbbkof4BUB6xDJhFWSqFlIpwiT1z05K9DEfEZuUCeA9ieXGTU0LirKeo99pRUZ6g9+MYI3CZAGmfCCI8RiDLvHY61n/bkmdym3bT98yaRKatLJQNVkTzZ9GV7eFjYmxW3fxu1Ks5wEUMcShUN7xg651RSjrWJxCKkiCSkD1hSyVmgzCvjQZ6QumFLUxqtBL7er+A6Mg8dyDl2Od63z6XtI7xFWx0VgV29649Q9cW+PyOSk78xa2y7d3vBiq83SjcgxKvin/3XHWXWZplhgLAAUqBIg3Zd1nw+O9ru19e3IWKkvnxQ==
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21) by AS2PR03MB9672.eurprd03.prod.outlook.com
 (2603:10a6:20b:60f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 14:38:19 +0000
Received: from VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a]) by VI0PR03MB11634.eurprd03.prod.outlook.com
 ([fe80::5e26:cb8:bbb:cf7a%6]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 14:38:18 +0000
Message-ID:
 <VI0PR03MB11634FE845793CEA7D25FA2D0C0372@VI0PR03MB11634.eurprd03.prod.outlook.com>
Date: Tue, 28 Apr 2026 15:38:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] http: attempt Negotiate auth in http.emptyAuth=auto
 mode
To: Junio C Hamano <gitster@pobox.com>,
 Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.2087.git.1776331259.gitgitgadget@gmail.com>
 <f175294459c9370ed79c8338d6008b69c2028f99.1776331259.git.gitgitgadget@gmail.com>
 <xmqq7bq63lll.fsf@gitster.g>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <xmqq7bq63lll.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To VI0PR03MB11634.eurprd03.prod.outlook.com
 (2603:10a6:800:326::21)
X-Microsoft-Original-Message-ID:
 <5494b860-ebdb-4d81-85eb-3a658c777a8c@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR03MB11634:EE_|AS2PR03MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bf7cf0b-27f6-432e-0bcc-08dea533ca11
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|6090799003|19110799012|5072599009|461199028|23021999003|15080799012|24021099003|51005399006|37011999003|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWwvV294VVhBaWxlTE5ocnVkQmIvTTVuTWFONXR4OWM5RlB0ZWlpMWY5d1Bq?=
 =?utf-8?B?bmt2ZGUzaFB4ZnBsSW1tZHJwMHE1MkpBbWNwOVB3WS9lV2ZCU2paT1FzV214?=
 =?utf-8?B?aFhOS2NmbkZQZUtvcjN1U041OFZCTWY5b2x4My94eE04QTN1d2N2b1VXOUFH?=
 =?utf-8?B?SGwvVDJJRjlhVy8zbVZKVTNXU0lieWttWTFUbjhmOTJwcTJnR1o0N09JRlA5?=
 =?utf-8?B?WjFRc2xDRWluUjgvMVJTMzBtWXZZaXNwbFVqcjNuYlhYT29xNDJDbUl2SmhI?=
 =?utf-8?B?a1lvUEwzME9ESnJHRUZVS1BqT1BLMjFrNGZBVXdxTnlKZis4SnFVN25qSHRP?=
 =?utf-8?B?WUttaVVXNHFFZ2cwV3dzNnhsSzZsZEtZYTNpcVZEdlp1ZW9JSFF6anpiNlkr?=
 =?utf-8?B?UUxXY0hFb0RaVU1RemNIYlVZZ09OeC9vcnUzUVBVZmlnTmlKeG1Lam5uSzl2?=
 =?utf-8?B?L1JDRzc4aFJBVFR0TWdOK09NU251dkcvQm8yenFNN1VKdVY1LzZYOTFzZEto?=
 =?utf-8?B?ZkV0aFozVEREYTNUVThpUDBrak5xYlVTU2JxSjFyaHF1WkozU2hPVUZxQ29F?=
 =?utf-8?B?Mm9HeEtBWXFIR1ZYYmRQMjh3VWtiTHVIQkw3NElhWVhYamNwdVFURVRma2Nm?=
 =?utf-8?B?OTd3VUVqcjFXRUo0cm9DeUdpQzJTc013WkJhdVlLRXl3SGZKWmdFUjZSb1lv?=
 =?utf-8?B?Z201c3FzRWtYRVdhVXMzbkgyK2owWUlGMkR5ZGsrd3BuaGNJS0tMek9OSmYr?=
 =?utf-8?B?MUNPU01iMCsxalJHbUp2MnJPYlNLSWpWK2VCTXM5b0lydEZ6TXlHWCtIU1Jh?=
 =?utf-8?B?NWpYUDFOd2dTQmFtNlA1eHNyakxRMnpMZDBPNmRWVHl1SnNJbWJKMU5ESEhL?=
 =?utf-8?B?NFBUbVhranNEb29XbC9GTjRXNHVSSXgwZnJmWWRUaHpoL3EwR2J6bzJjQ0Fp?=
 =?utf-8?B?bFZGeEhQek01T2hNNFphYnRFY2g0bHVBSTBPN2xxQUdGZTVQTGNRbUJHUURG?=
 =?utf-8?B?Y3hSTEtRVGxGWXVHKy9rb2krUVhZWm9VRHRSdzJpaWVoK3dzdS9WYWhGRmsw?=
 =?utf-8?B?MGNTUWpUWHBUT1liWC8vTGt2WFpLaWluMnRtVkJkOVdCTWZHVjdPbVkwUVZK?=
 =?utf-8?B?Z3hVQ2d0UVptSlQxcHRCeHQ5dkswTEF0dVR4Tmp0clB1SnA0ckJiNkxBSmhk?=
 =?utf-8?B?TThTanczdGtXdXE4TjlTVGNyVGZRbjdDbHkrMUNLbzA4NlVrWnZ1N0tlQW5l?=
 =?utf-8?B?MXhjemR1NFNwRmUzaGV6UzBiS0RBNmk1VTJUdWplM3A5L1hXWUpzbEVhTXkv?=
 =?utf-8?Q?TnUuVrjNpg2HoyBVbSfTKuR7yv0/uuVXNu?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHV6TXZhbHdmZzI2MGNwV05qQW11ajJrOFNRRm1rUkNEWlFDSnhwMllhWVg4?=
 =?utf-8?B?VUtpTDFjRHVMY09yNUdzR3lSVk51NjFNMVJ5VXV3aWlmdHBZcnVpWmpHOFhm?=
 =?utf-8?B?MWVxL25LTWVrTFljMHdKcGNoYWx3VGtabFhPVnZWTXdtUC9lTWI2S0NOQXpF?=
 =?utf-8?B?OEplbVAvNzJGRkp0ZlpqYVoxTG9LU2N1RHRHMlp3S1FmMFVwMTY2NnJDbzNR?=
 =?utf-8?B?ekdBbm5FS1I4M1lEWkR4QVp0Ykp6dnJmNVFSUHlPZGN6VUdXNm1UM210bUNP?=
 =?utf-8?B?cm93OXVPeFg4bTloY3BReG9DN3JRYXFTU3ROUk42b2hjaFFsUDZodzlKYjNk?=
 =?utf-8?B?dDJpbzYyaXkzcVBlR1oyMU5UanR6T3ZXb24wcElqTHRkb0ZJNXFBT2VtNi9X?=
 =?utf-8?B?VkhWVUR3ODZ5M3MxRGVGaXcvK1VNV1QreE9LNms3VHJTeCtzWWgvZ2pWazhh?=
 =?utf-8?B?bHZQUENDNVAxY2dhbUZsMVRMaWNSZ1VhSmtqK3pZMWxaeHNZaVRzZGpQOFF2?=
 =?utf-8?B?eHRFMXJrNGEyTXBrSUJOTWpLUUtHZ1Izd0VlelVhcWQ1dmE2RXFRKzlmcFY3?=
 =?utf-8?B?MTlwSTE2S3lGU1M3Z1ZJMjFSSXpER04ydFJCZFVmTTlnQ2FCZFJXMEZlelBv?=
 =?utf-8?B?OTB4MEo2a3BHeTF1SndOYnNPdUFBL2tPNWZYbHl4VE11eFE2M1o2bDEwNE83?=
 =?utf-8?B?YVdvcjFVdDYySGV1MmVMYjNyZXp1TmlVRFdUUXlmc1BsVkxUdzZib0hBaGpl?=
 =?utf-8?B?dDdOMmFXWUFrYktybVIwbGIxNGlKYTZWajNKNEgxU0lFbG5TQnZQcndOZEY5?=
 =?utf-8?B?d2hmTWxUMkhmTFFWWnJxZ1RiOWg4V2c2Nkd1aTl0eWUwWmxydEt0QUxIb0Mw?=
 =?utf-8?B?dzAycjNSYkVqMXRFRlhJVmR5QmJHZU1Kd1Z3SmY3N0FiRVYwUWFNZ2VVNXc3?=
 =?utf-8?B?eW9neUNpMUF0a0Y5bnBLVnd4VktGVWx3K2pCWEZYZGlGOXdFNlptSEZEOGox?=
 =?utf-8?B?UDIvQUFtRUZlMGk0YXkvcVpHbVNXUHU4aUdkMHNWZUtVRDVYSWg2akMvTzNF?=
 =?utf-8?B?K1NXSEtjZ2xzMWdSNnAvNlJ1ZS9aWjdZdnBUUC9Yd0J3MkpUMkNJNGVBVUcx?=
 =?utf-8?B?N203YjVOUkc5czBUSjZveUNwUmJFekFoME1BMjV3WU5RZzlURmxmK2huYzkz?=
 =?utf-8?B?Y2lSa1VJTFF3UVhZTFdlcFVDR3BISEZEbWlYY2t0OWVmTkJ1WkIxWUllQlIw?=
 =?utf-8?B?eTBNV0RqNnJ0TGZhRms1RHJIa0w5TjVtQmZLQi9Fc3ZqdC9QWmdSOGVtVUdQ?=
 =?utf-8?B?aWpWU3l6TnI2eVJRa1BheVRCSTIxa1BmeVdsUlFhZVA5MTgrY0IvK0l0ZnRP?=
 =?utf-8?B?YlE0RlhPUit2UGZHditRNjhzNDdtYmYybVBqcUVmbis3aXRUb1p1T1RvbWo3?=
 =?utf-8?B?MmYvakdIQWhjaCtvdGwzQnFTeE1WbThrQndqOUxDclBJUFZ1Z0xZOEVGUGVS?=
 =?utf-8?B?ZytXOXd6RmlGaFIwd3FLNDNTRjlQZnl6NjNtVDBWZnZ6c0ZhajlsdlBycHNy?=
 =?utf-8?B?dzQzdVQ0UCtnRjZVMS96QlpLYURMTCtiS0diYVJlSlF5ZWwzeWVnZ0VrQVVV?=
 =?utf-8?B?VHgxL1JmcXVUNkRrcWdzMTZlNVArU3k2UzFheE01OGVodWlkcUlVWkJyTGZt?=
 =?utf-8?B?TTE3QzhCWTJaYmdZdHVnN1FFakFGZVdCdm5mQ3dvUkQ1bFRoVmZhVldFTzBj?=
 =?utf-8?B?RjZDY1RnN00yVEVXVnMvcmZzRGNsUTlGSVRmbGMzSXdBbzBIS001eWdldTQ1?=
 =?utf-8?B?QzVWeHQwN2dzeG5ZWTVkRVFOZHIvbVRRZHc2UUxaVnl4Kzg3WVlEbW5yV3JJ?=
 =?utf-8?Q?Wgl9gXEcuNb30?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bf7cf0b-27f6-432e-0bcc-08dea533ca11
X-MS-Exchange-CrossTenant-AuthSource: VI0PR03MB11634.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 14:38:18.8364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9672

On 2026-04-16 17:40, Junio C Hamano wrote:
>> The true and false modes are unchanged: true sends empty credentials
>> on the very first request (before any 401), and false never sends
>> them.
> 
> OK.  This is a tangent, but "git config --help" on "http.emptyAuth"
> is horrible.  It does not say what the allowed values are, so I had
> to first write "There are million other things in the system that
> this patch does not modify, so what's the point of singling out
> these two settings and saying that this patch does not change
> them?", before realizing that 'auto' the patch (and the explanation
> of the "empty-autho auto-detction" above) is about the third
> possiblity of the same variable and take it back.

Agreed - the existing description is pretty opaque about what values it
actually takes. Should I add another patch to this series to spell out
the three values explicitly? How about something like this:

      http.emptyAuth::
              Attempt authentication without seeking a username or
              password.  This can be used to attempt GSS-Negotiate
              authentication without specifying a username in the URL,
              as libcurl normally requires a username for
              authentication. Possible values are:
      +
      --
      * `auto` (default) - Send empty credentials only if the server's
        401 response advertises an authentication mechanism that
        requires them (such as GSS-Negotiate); otherwise fall back to
        prompting via the credential helper.
      * `true` - Always send empty credentials on the very first
        request, before receiving any 401 response from the server.
      * `false` - Never send empty credentials. Mechanisms that
        require empty credentials, such as GSS-Negotiate, will not
        work.
      --

  Does that read better?

  Thanks,
  Matthew

