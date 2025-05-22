Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58905770FE
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938677; cv=fail; b=Vpn9i91jSbqa3ObgJGpmro7kFfOgkdsJnuKySDyWHQKPOHohZph8rrlVrzcD97o2X6uGCJ9SLx1fYJwVscilzhQejF6Ru+PCCXK7oUHDiTjUzg3i8J3ezfJmT/gR2x4K38z5qHirdIo50S6ezEOXTtD17i+gg7F7fMy440evKkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938677; c=relaxed/simple;
	bh=Ch+Vu8zLcn/D1UoeA1SDme544BxEj4XZMSANmhFlUCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jq79o5I66vvqm3d/HKfrrvW5lisiTFVpeQauHOsYa4FgVkZV059xJa3t6+R14+xXu6NMehZI0JCa8Z7ogxnAEjbKI5YnVvvrfqI1zLcwC9MwAJMkclzEhTDrU/YtiBfZS8G1GSRsobU280WKmQSME7SWkUHYfNMazFogfEmEzc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kKMbiigp; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kKMbiigp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmnV6U73Ni2Kgth+Z37CazyLt/b2j8IQkkA04GtUhutoSQVl9Gpv8TBeT4ruEX9w5mlm6EYRj6rqypYIs5SJxqGW6ZQ7KQTVPSuHbLNw6lOsDBxYlbmz9Fg2N76IvgFPyTo+SiuBh7q1SxJZN5g5613EnPI4JC3GAbPHPJhtQG9aZ2S8Pg0N2JFxn8b/2VOoo2qeXiczv8JDTzA3ACkG/ocMyCDwjfkHiVCSalj4aHyRJ7M678Hj97cBhkXlbjSdWzyJtbHmFJJ0rAuZF6VVXtzmz11Y7kLl+bsgan4u16OiM/MrgO+SFjK81TPZVfQaic4AC57/w6e2VLuPPty7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNiM0uKxzO0Y8/6CH8+scK8dcW+PilMvas1n3aCguuU=;
 b=jah6ILVdpaAQcAVkActcg3M+AiZ27yn4QbonsiOeSN44CTLtoAdikT0kJoUWdyagSvX0/wSke+ByGfi6MO6r2fXlyQZxra+NwicxTjCLJph+nn1bu8U3XrG/wB+WA6f0AwVN/cMM/JViOr3U8gMtXaOrImXcp0BzAs3cXTPlZXZaJLWL9+f+c1tKiVoY64Xu8WHjXDx1tCT1kTjBrgiH1w0CBG30ZjsNH3PczxRNQ2q3cqUABpccqf3o0HWppBaICunCy2pIIRsnKgXn2LhW/lcLHqLD/zVr4SrXBarsWuVHiWBBYTR+V1oGyBrRV/CB6MmRRTQaW0XEm6+Cb6FFiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNiM0uKxzO0Y8/6CH8+scK8dcW+PilMvas1n3aCguuU=;
 b=kKMbiigpQMx6TjuXUuzG3kZY5JOg4/u/IZQ3xU/ioSDYFTrlqcxWMxCbQfuedXJx/SYt1BK7iI/rgU/UZ/WsDYmkePHlQ4X8drKGgLtZdITeqL4kNbCFNziiAIpPmw7/1Bt1h+7qiZ+nnuIirl1lA/SRuN303UAoXuqM0uO/lghzafYBfVtUZq0QjTScSppl1IgPaDnT/AtNcHWRnq9laMq8Qq5Ee+sbvi+dmlo64QYwjH8G2lSZwDxbaaSY7uCeU0RWLH6+QX/aog+qi7VFBzZnMYMGoYhy5zWi73skjOnZoh5vwysHiuChfe69ODSYNdFVjFieTloURPBfZUPN7A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6189.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:78::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Thu, 22 May
 2025 18:31:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:31:09 +0000
Message-ID:
 <PN3PR01MB9597DB297B1F23E65443B2F7B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 23 May 2025 00:01:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Eric Sunshine <sunshine@sunshineco.com>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250522182924.GA14871@coredump.intra.peff.net>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <20250522182924.GA14871@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0153.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <5804cc52-9a86-4dca-b8bb-83743881502f@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: c04ba80c-2b0a-4a78-7eda-08dd995ed275
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|8060799009|19110799006|15080799009|7092599006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGt5NVd0Z2FHOXpMQnpqcmQ1UWQ4enR5dVozbVppcVlIcTQxeGhJTC9mb2tV?=
 =?utf-8?B?RjdjQURQZ25tWCsxWlhiSXZla2JDT0owMXlDWUcwTUhQZlozQytuWU5taDcz?=
 =?utf-8?B?WDZOSnlwTEhYTURtMkxYOFJYZ0Z1alhiZHJFNDNWMnBTSjZieFN0MDdta1JD?=
 =?utf-8?B?ZktDNzhRb2JwRDBPQ21XbVFWY2pmMkwyQnlaQ3VqRUQvcFVDN0JYaG1nNVFH?=
 =?utf-8?B?MXdEUjJxTzc1M1lXSjZjMUdzd0NJSU8yb09abmphbytaQVRpbmtSOStseGV1?=
 =?utf-8?B?UXQwdFo1QlJrVVJzeTF3Q1F4bnNHTThnZ3JFcGw2bTZZeW0wc01WbkpQSW5Y?=
 =?utf-8?B?eC9SNUdIUmJJYThXY0NRS3BqM1doak4zODVxaytKdTgxWDB5Nll1NXZsZTcw?=
 =?utf-8?B?c0gwakJYRzRFMFdmTXZzR2NBcTJ2QktNYlBaN2tFQVBWcmVXNVl3eW01ckRB?=
 =?utf-8?B?ck1qVTFYRkNpRjBMVFVWT3huMnBXejJlL3lzVzY2SkZwK2VQZnFhbkdoRUNo?=
 =?utf-8?B?ZVNYWmZOVThyK2wwdUpnMkZiQlV4dDljRUErUlU1Z2ZUWWZjTlZuc2ZJbkpZ?=
 =?utf-8?B?a0ovNDVveDdIaXpjaDVLOVEwY25MZ2I0YjlZT0lnSzN4bFpqci9HNllmUTQx?=
 =?utf-8?B?TEd5dVViRU1EcWFOeFZJWDdOY3hLVndxN1V3NmlXcGpWSk50QitZL2xqY3lY?=
 =?utf-8?B?WURKS3V5aERxVGk3VndXKzBWbktXWk5QZXZiV05ERkN3U0Y4VmF3ZGx3N3ZI?=
 =?utf-8?B?QklnQUp5T3BGdFVtKy8ranJEZ2g1ZTRxekl4akpBTHUyL0VkcEFNQTZYZHFZ?=
 =?utf-8?B?U0trZnJIK2U5VWJLcGZJczVvTjZuL3d1cUg2YnI1RmZnM1JRSzNoMWpzNkFY?=
 =?utf-8?B?UUFoNzIvRVZDcDB0V2QvTURPeHdhbGZSWXZwSmk1U21Fd2xzME5uOXdSUnNZ?=
 =?utf-8?B?RTZDTHBmMnBZbVdOa2dBQWJveloyVENtdkI3Zyt2UFo5cWdWL1FQVTN0UE41?=
 =?utf-8?B?czVJeG96ZUludGVzZTBqMVJaM1pnNUN2cU1ZbDc3cVRXY3JITnVNcnp6TW1L?=
 =?utf-8?B?UDNzVG5mTE5EdXVjdzg3UVdqMmxINnpDdUJla3pGK05zY1lZZjJkdnFjUDc0?=
 =?utf-8?B?WTJmcmt6bGIwYzg4WUp2aUs5SUl1ekl5UzhvL1FFK2hrby9hU1p6U2UwK001?=
 =?utf-8?B?VGFCNHp1bVlURFVTZWNYdDFqbEZwZFNNd0tucHBMbHEyQjdQOE92a0xWWGI2?=
 =?utf-8?B?Y1ZDckRHcXhWWXViZ2hqbWduUS9CVkVxTHJtMjFsbDFQWVRUTjVxZjRRU3Vl?=
 =?utf-8?B?ZDAzaUhOUFRUZzR2WDlGS1l4OEpGK09zeHU1NGpaSC9NUHV6bXRjcUdJTjBt?=
 =?utf-8?B?Q3pxb3h6ZzlmTCtCUFZ6azNQMGJDelgrQWpSbWUyQW8yQ0F3NEQyWkVicGNx?=
 =?utf-8?B?eU4zWmEzL21GTFc1aURicFpRMklrb2NvYzhpNExEbHBaQytYQkg0YTJwLzJu?=
 =?utf-8?B?TGFmQ25lZmxZV0Q2dkVzQlg5TFZCbDBMeGRHVE55OWlrbnViSlczNm9sRFg2?=
 =?utf-8?B?L0hjZz09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmpXUkFRME1xZ21XUEZQMjNmUks3QWdvRzcvTktBY21SOTNOaUJ2QmVZQkxq?=
 =?utf-8?B?aEZ5Q2Z5TWF6dW9tU0EzY08xNG10UkZXSTBUTFlUREp2Sm1sWUdad290c2xM?=
 =?utf-8?B?aXU5akIwVGVPdVoxWURzaWpvUmhUV01uUDJPdDBKZFJCalJCZHhoMUk1Z3hx?=
 =?utf-8?B?L2V1NG01MUVxWC9GTXYrSXQ2K1QyWHlSdlVuTXNHTFNsOHkrTXVqZnBBdlZQ?=
 =?utf-8?B?R1c4Zy92eVhVNUJNdExtU0J4U3ZGZGRtWjZvdDZ5RFFJbXgrYmMxUkw4SVlE?=
 =?utf-8?B?RmhjZWV3NjZHMUdqZ2dHejhLOW9oVkFUd2JCUUtickZsZ1VGRHJPYU5lb1dS?=
 =?utf-8?B?ellWdlJlVlU3bFpha1ovU2dGaCt5RFlPMmpHQ0lNTGZxK3lhUXp4V2RKUWpW?=
 =?utf-8?B?MjQ0ZFlEMVQycE1pNXEvQUU0U3gwZFkwMjdyRHd3K3FQNUk5aWM2RFF3RFFw?=
 =?utf-8?B?S3BQSFh3KzYvaUpIWTJXak5wTExJckQ5dDh5b0d4T0haOFBKOU9idWVVWGRH?=
 =?utf-8?B?NVcwNXN1MXhnKzluQVRqUEdNQUZEbnJJZFV0WUZjd1ZJaE14cnA2ODhtUHN6?=
 =?utf-8?B?Yk9BS2pXS0Y0WVRBT3B3THlkOUhFTkx1ZjdkNGlBWjFYU1lCWm5lV1pjZTBM?=
 =?utf-8?B?V0FYTlFFay9yUTQ1OVFna3ZsVDA1c2NaMDNmUTRMOFMzZkIzY0FZbkFpMHVN?=
 =?utf-8?B?WU1LL3B6Q3NzYWZwMFE1K1pmam9SaENPVHZRZm4vcll1KysvSmp1a25sY0Mr?=
 =?utf-8?B?VXNpOTdkNFNVejFvaHhYSUFLdU4vclNnQVh1U1h1NExUZTI5MTlYenlUNEJX?=
 =?utf-8?B?bUs2ZmcwMGZlU3ZyS045YXNGcGRqZGZ6TUNyNGpFSUFWVnY1UXNEMUYyU0tQ?=
 =?utf-8?B?WTNkemg1OC9wR2cxVUNxUE5aK0dNTWs0WVFlUGFJYUhlNTNJT2pCb2ZuN0RB?=
 =?utf-8?B?SGluYk1tM20yakdjTEVFZlIxUHp4bEdxRFNHQ0FqQ1Qxc0N5VDlqdngrVy94?=
 =?utf-8?B?c09WWFZraGRJQldLUlFWUzY5S2YyYUdEcENvVGVtTzFtM2hVZkphb01CMjlO?=
 =?utf-8?B?cUtuNTZnZzh2MExTdjcrMS82TDZTK24zTEF3dmVkVXdPblpmMHkxbW1VaUtB?=
 =?utf-8?B?T2N3dEdpWmgvdzVHd25yOGkvTnY1ZlpicUh1MW1Nb2tCSm9TWVp2MzI5VTFG?=
 =?utf-8?B?R0hBaWZvR3hrbDJHTlhPZERxZU5Kc1Jka283RUpMUENBT2JqWDVOY0lXYitW?=
 =?utf-8?B?alBUcjBzaVN0OVp3TFM0Z1hnQmI3Z01DR3Z5TGpVZnpyeUh4YmIrYi84WGp3?=
 =?utf-8?B?ZTBwYzJGS2VFWWdGekdldmhpejRsQW5FQlkwT3VwZmJKVUpFVUNqalNkQUwv?=
 =?utf-8?B?WlBVbkl6WmNSaWRhNldxcFJrdURiUDVLWGhQWVVZdEVmdmU3OUsyOHZ5UXl5?=
 =?utf-8?B?c0Nva3MxZzB2ZzZJejdNVDlsUnFnVnFMKzJRT3BVOUlZNzY0YmJUeXEwZ1pG?=
 =?utf-8?B?eGVidkg4NGhybkt2T084T1pHZXB3enZGU1duWnpqQStrVFpBVUtkaFRlaGJu?=
 =?utf-8?B?TG53b2ZhVDRHQ3lBSjVaMUxoUTJFNkhUczZOR2p6ZVViNm53NGR4Q1RpY2RI?=
 =?utf-8?B?dzBGWis2Skd3QVJCc1FLelUwRjQ4b0NkYlV1L3dVRDFrN2pFQjduV1cvMDNW?=
 =?utf-8?B?Uy9rTDZad2pUVnpLcHRqdWhWRFRrOFhPS3VTNlhvbm5scFFqNFp0d0l1SU1O?=
 =?utf-8?Q?aPfAnYfA0WgDPj6q5k=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c04ba80c-2b0a-4a78-7eda-08dd995ed275
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:31:09.5615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6189



On 22-05-2025 11:59 pm, Jeff King wrote:
> On Thu, May 22, 2025 at 05:27:15PM +0000, Aditya Garg wrote:
> 
>> Upon setting up imap-send config file, I encountered the very first bug.
>> An error showing "no imap store specified" was being displayed on the
>> terminal. Upon investigating further, in static int git_imap_config,
>> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
>> imap.tunnel and imap.authmethod were defined, and the values that these configs
>> intended to set were not being set at all.
> 
> I read "these configs[...]were not being set at all" as imap.user, etc.
> But I think the only thing affected was imap.folder, which was
> incorrectly being reset when we saw the other fields (and of course the
> leak-fix for those fields was not kicking in correctly).
> 
> So:
> 
>   [imap]
>   host = example.com
>   user = foo
>   folder = INBOX
> 
> was fine, but:
> 
>   [imap]
>   host = example.com
>   folder = INBOX
>   user = foo
> 
> was not (we end up with a NULL folder variable).
> 
>> Because of this, git imap-send was basically not usable at all. The
>> bug seems to be there for quite a while, and has not yet been
>> detected, likely due to better options like git send-email being
>> available.
> 
> I think that probably explains why it was not detected (by users or the
> tests). It was dependent on the usage and ordering of particular config
> options.
> 
> (The patch is still doing the right thing, of course; I'm just trying to
> add more context to the commit message).

mhm, looks like I need to read the code again.
