Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010011.outbound.protection.outlook.com [52.103.68.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30A52F50
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748763066; cv=fail; b=bHyr/RiNFD1KD+3pC6pscLy5MQkUNkFsmQ0EM6PEot3uANI3VdkUaQwkYgu5Isesxqf8MxF8iB14SMb6WUz7XucVyc+NWod4miLLOo7DOhQjc3HsXHpHOiVwf8+vKiXQ+4duaJc4keI/gbIsbJsJ7t2A44S1kbnWfrxe7fAJ7k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748763066; c=relaxed/simple;
	bh=++KiQV51chjqfKpuxeQLDZ/dTsQvJvo/krufiE6uK8w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OoyOodcS+BXK7kxSi1N6dqLCOXiKf5dbBZTgStDC70wkGzZweoUZObZRNwo/A4Ro9d/jg1b8imewPESMp7ANDKb08qBq1gC3wKsPTou1HnQrnKBXQJ8MSUd0KhT/thTl5dqRY8zZJQbLVAN7qYrVAGef7F8FaoH4jtp1wGnHji8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ceEBGYIT; arc=fail smtp.client-ip=52.103.68.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ceEBGYIT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cx1kRNQADO/oDEVG9KV+vHlqswbiV5Mm3CGgACMlO0SJYY5BS+HIy1zT//F2xLrQkNO7rdQbU7inxw8crAcAmIiUW3tXzWdf8+zDDGhIeYSUkD6ToC/t0srpMoujIFATI1mu5R3kJ+LzLqCw9G3T/0jdmnWQVEHUpUoYpR3r21WMkdeSTvGmZM4reXZv5FPbcFRx2ODXOkzKwN/8qU9el08UYUcqqWGG+2c2r3L41WU5F1DhXhpRfZ/e1JlmNMjphMU/SrAUYcN2avgYQsGKNgxz5XRLif04IEOTsOn7zk/L2hcNxqhkpmetLJqmTpxc8LZw21XIZsrxEP/sWzkC4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+9M+E0LZvU1ALsaN44zsNYKB38t5IHzuaAGFrlqtfE=;
 b=R/QFUJYM8wjn0eBSez8iKcrU8vJOavtvG6POGAcptSuMywgWwrX+sO8EJiJOoadUpfVCeZrEE6z2jIYGMhULla1JbVMooleE5qgJBbHK6GKDPbtH901pJPbampYGO/MSDAmwQG83pBEorKXzFCYHFIsfcRoUgxTTC7jwBwe/MTG4DnY4e9SwQqyILAER+DC9hmK5Z46RZfFC+2liN5WlMTA3eTzjfnmHdzK7nsO7pT92LKlu+ddRJ4X+K4zvv49vyiz0Ykrq2Pr6hwOJ3ADT4PMEHKGh1yVcJPMYqVuVwFzd+GBK4gUD6VWIqT/IG8sV4+fxdOUuFzmsKV0sWQp1Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+9M+E0LZvU1ALsaN44zsNYKB38t5IHzuaAGFrlqtfE=;
 b=ceEBGYITp1Q9vjk4ON1/wSxHVOCQGfbVfgo3MdsLvZO9hWxti3+z+agU7h4mMLhCcKDjYD8f8+cyPgsuSXVyHEBTOR63O1+kETl+Gm5hoysD2A6/b4bFCfsVm75AOcdM2L9XX4H0o0SvbZxs25nQkuOluhEuvVAKueQvjANEhZeakY44YRLR7waCrpdtmQwlKlM4Dm2Gew/i9X53GsznlNxrO+9mnLui24JUJ6DMkRDcUEtoO5YDBD+g3z34S1Febkc7ZzZKuUMqqLUK7YKJSdNjxEi7KDXQ8t1iAB1v+IcGPxk2VTSibGnLYvsglDiODKHJ4Vc69fiifZepKUFc8w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:30:55 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:30:55 +0000
Message-ID:
 <PN3PR01MB95971E7CD9AE473139CBE0F7B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 1 Jun 2025 13:00:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/9] imap-send: fix numerous spelling and grammar
 mistakes in logs
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Zi Yao <ziyao@disroot.org>, "brian m . carlson"
 <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>,
 Ben Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597A33B17E07B461A5C276EB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cTUFAFYx7SLtSbgmxuZUbbwRG3011fH8s_jFkWbwO=uig@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cTUFAFYx7SLtSbgmxuZUbbwRG3011fH8s_jFkWbwO=uig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <583581c5-9faf-4a93-8f4a-e270ef842ee1@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 65a0ff22-2499-4618-54da-08dda0de3eb4
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CWYKCeiL+Z5jJp6lvhKXVh0Tutr8+DkpwyOe+XBnCWbmMht5p/Shk1PeokL4YeBpl819RjZIDoTrA0RdGEmEWoPnW2N3UKzSegSzCYEI2XhdK3QhGFXbRlAp9NPHG4oycHNt9OjnC92tTCuzcj9PgkAGgaAeZxe94VRKSgN8NavTFKQp/eaBzgYZIEKnwwagoU6SM4d982M8Q/uEPF6sjDDxK88X9WXvEwjC6N+NSqBBDH9QKXzE9oGyknK3WEV2UwUrpFb42BMk4MRHbvDdjGF+qe1F+uuVyLVRBUzrBNETHTxOlvVgDDTX0lJwcOBAA4jbBJzjDbQMn9UOCdKFpZjN1hPOJT1ioDCmO+iJLTGobeQpJeeiydGujVFZEfspUmNvydHYk+FJImGU6sQ34a/K+l+sz/hkB1We+OmWQaKygP1HhOPBJbzuIabGkWMf2HAgoXiS+/WRECipw/cdNa5dNyEdjr/JHzhm3ez1dq0s0LMsMYzxCoiC6yd38ggF+mqAw/+EkgK4nvdtTgQR4ZR8e5Ht58KbKQMMenV0B79GyEoQK3XG7UUom75nzwUw1g6hFGw9DnVPWO3cV+Eo5LunNtoKy/k9JEtEFP7/fcwwa5Z30wDHendcgz4G2mD+3CGoAL6SfnPMVl6Ejt69wvBWXil30Y+TUDF7d9nX8pNYq6LqF744k9WM5HVVrHkiiUAWl9KtQ8dAMgUcvV9vfGrxoJCsCyyNK
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|8060799009|7092599006|19110799006|15080799009|5072599009|6090799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJEUkU4WG9CSXFORVRpSktHRE1ZTjRKTEtndDVrUEpnM2gyc1ZObk9mdEl2?=
 =?utf-8?B?dVdCQ1IzbEJxcktDOU5wSjNtWDJsLzBISitsNUVkRTIrc3lHUzBjbU5PZVBE?=
 =?utf-8?B?YlEwZHp5ZWFVbFhOZHBZZk1ZMUpLcWc3VlExNmtERUpPRTNGN2w0MUEvaEJH?=
 =?utf-8?B?YzREUmRTa0FqOE9JUnZHeElRYUplS1BsTUwzY0tETVp1SnZzUWViYW1MVFFq?=
 =?utf-8?B?K3ZWUVZrRjg1U0EzcFBxSE5hcm9uekJiSnliblBWQ1JrWlZUSUJEaXh3M2Q2?=
 =?utf-8?B?SFAzRmRqdTZDdzloRWVkeGZoOEl6M0dDWWhLMjYwbzZRR202Q2JKWWROYnNu?=
 =?utf-8?B?NlRDVVdJTXF5Zjc0amVtZjRSakhUNm41Q3pSWnJNcVErbmZGNHAwSWpVOThC?=
 =?utf-8?B?eTl4d3pUczZySW93M01uVmhlNm1oTDkxcnJhQnF4SzNnWUpFK0crQThwYitG?=
 =?utf-8?B?cnBZdnVCRG8yVjJKUm1EMUtMbWg5alZIWGVyZUdIUlBaQ1JmMGV2SG5qVlR5?=
 =?utf-8?B?QlkyUGR0WitLNHFKWVlzY1dLOGZQa0xSMkpoajE1OGYzeGNYZDB3T2lDTkla?=
 =?utf-8?B?TkhQSGcyOVE4S25YakYvdmpPYjFIekZIZ3NrUzUyMkZlelp6Y3d4Y3E5L00w?=
 =?utf-8?B?VE8rRGdvcHpVN2tEd2N0SWE5UW1ZVHIxbmtyYktGSzZNcW1FOXFPM0FmdFk2?=
 =?utf-8?B?QU9vUUNCNTZwTHMrUFVaTTdVSStWdXFVRTlZWjFNM084UWh5cVpXUFdzc3ZQ?=
 =?utf-8?B?dVFkczhBcFJkdCtUZmEzZUwzdFY2TlZMVG03N3loKzFQVjZJdDRXb2VGMUZR?=
 =?utf-8?B?aW5zNjlSdENENmQ2dG00Vmp2MWVwT2NjeklFUnRtSERES1F0Zzk3VEZpWjUy?=
 =?utf-8?B?Uy8yUjJoRE5YSDY0SWlkdjZQd1FSSkpTYmR5TXVrMWQxSm5JTmtLYkpHUzVM?=
 =?utf-8?B?RkQweWpOMm5IYmo5VEZlN1BaWXBDTUVPZ09LUjltS2x3cVF0OXFHTVJDMi9k?=
 =?utf-8?B?cmFyRGl6MG9NYTdHZ2d1UTc2RUxwd3pDSG5rbFdZcTRZRTFIV0wyUkV0MXBT?=
 =?utf-8?B?NlUrS3YvOEtPWlJ0MmV1YVRFK1hpQ291MGhpNTlibENXbW1IRm5xZ2dvQldX?=
 =?utf-8?B?R2ZkdlRYL2RnVlNqa3FQckg5cnMyUHFKYmdtQzZNeE5lMXZLY1V3U3dxVE92?=
 =?utf-8?B?ejNMN200T1ZtdWJsMGU2NlJ6TzF3U0xBd1BXSDB0S0JDYm5OS0NPcmE1TlIr?=
 =?utf-8?B?eStISEJ3VERxZ1JCYTZlMkVwTTYwM1FLOWZKUVFFN2MvNjJtNHdLZGUvMWR0?=
 =?utf-8?B?aFVzdG52RGVySmU3aHlDMkppdnVLcmhBRElRdGwydjV4YVFmVk1kMDN0SDVp?=
 =?utf-8?B?MzBVZjg1NjJMeGFTd1FtelR5VzlBU0I2MG0vWnZWVmNOM3JuQlliTVlPR2lY?=
 =?utf-8?B?cjJRY0JIbEplMDRzeDZBcVJQWlloTU9oVVJoayt2eXZobEk5eTQ3UFc2M3F2?=
 =?utf-8?B?cEhzUE5LR0hTc3NEYzg3MkhOMmh3R2RMNFlSVysvUU05UTVpekM0SWYvS1ZO?=
 =?utf-8?Q?gC3FQycY6vZGxPDQSvEF+s/uU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2pUVDlKbWxzYzFKZE93QU55VkEzQVViV1ZmSVRJTFYya0g5eFhENjVLRmFa?=
 =?utf-8?B?Z2lJRE9PUjVCcUd2dXdxT2J6V3p2amJHbmd6SlVIaXgrbTZYZEFmdXlSWEsz?=
 =?utf-8?B?ZW02cjZ3SGFrZzRWZDBsMjdzRmlqRkFHMVFhRGJyUENXa2tNOCswZmtvOXlB?=
 =?utf-8?B?eG9XWVo5cXFyTGxXeGl6eXFzOGhhN0xZbkEvK1VkRFBHY3B1TFo3U1BFS2lL?=
 =?utf-8?B?a3pTM3FXWnpZNmFSb041SzExYlpLcE1rb2cySHZFQnFhZ2VtaG41RENxZFo0?=
 =?utf-8?B?eVR3K3IwZkUxZnlWLzkvWU1FdERLeTdrUExDSDFEaXdzZVFlenM5NjlibzQw?=
 =?utf-8?B?bmlWM1lHSk9pbE9VbXZpdWxYQUZXazIvQTJORU8ranJ4bWNXWklvdWtRN0dw?=
 =?utf-8?B?UkVIMllONG94V2RSYnhadnlISDE3Yy8ra2JPc09jT05VTFVHTk0wOFA1OHMx?=
 =?utf-8?B?V0xKMVYyd3JIN0NPc3MxMVF6K2RqSnI1Wmo1SjZVOUpTQmpZRm5UNEFTQWo2?=
 =?utf-8?B?ZUZmZmIwK3Z1SFdQN0t6WFVKVXFDQnd1SUw4c1R5SVM4d1VzQ3B2emViQi9h?=
 =?utf-8?B?SHkySjZCbEF0MW5UWm40R2daaVhPc2xnTlVyZ2dBY2ZQbkxtQnY1WGhsckNU?=
 =?utf-8?B?NVZ4TDNwdkpsNjl6aVpUaFh6RXNmczlJcFRjdEtKT2JNWCsxQUVOUE8yRjl2?=
 =?utf-8?B?c1FQUGpUc1BvdzlCKzg3T2Z0anIyL0RsL21vd05ZSy9INlBLNGlsbklpS2hj?=
 =?utf-8?B?M0lpQnZTRHJDVDNtSU41cDVzV0k4WHdsNFVPdEZPUHJaWFZPWVJKdTZxeXRi?=
 =?utf-8?B?N0JVY1JlWHltL2NrOWFHelV1Zjc4dlNTbW52RHNZUnFhZ1dtRnVsaWFyUFQz?=
 =?utf-8?B?Y2hleW02Q3E2Qk04UjhEeTJWcC9qYUY1Q1N1d3U4U0xkMmMrVzFzTkhtb0dE?=
 =?utf-8?B?MEpBaDM0WTNaMXBHck9QRVVibGZCOGVENDZMU2RldVNxRXViM2F4TVJDVUlE?=
 =?utf-8?B?d2YzM002NUlnazlKektEbFQvaDcxRXI5Nlk1dzMwejh2YWxtenhQbCtTdU1T?=
 =?utf-8?B?MXZZQUo3d0dPb1FldjFYRlZ6YjlmbTdzR1c4ZzlMdlFsMzdHYkxhclZaTFlt?=
 =?utf-8?B?WkJNaE4vNGhjQmx1NXJzVGdHQkxBTG1VcEx5eHhPcXdadTVtbml5T3RoVFhU?=
 =?utf-8?B?RHo0ckVBbWorbEh2YkNkdVlYZm1XRDU1ZklWSm0xRnM5Z29iYXR1V3NXS1ho?=
 =?utf-8?B?T0JvbVMzMEhBM1pDWnBJVGdPemVYWCtOWitqS1JXSEdML1JsS2JPZXY1YUh1?=
 =?utf-8?B?MTJJbURraUJTTFpRWHY2TGpKUWp6UVV0U3FMbHh6cGpuY1NuODY1bFZRc2hD?=
 =?utf-8?B?RWY4bWw5ZEdDbVhKZ3NubVBOSUNKc1lzdFpTUXFTR1k2Vkpocmk1M2lBZE9j?=
 =?utf-8?B?b2c0cmd4cjN0S0FvZGoxKzFHdENmQ1BTbWdIR2ZLU2xtVHN6WGZXNGNEb0xX?=
 =?utf-8?B?Qng1d252T1hqY0dmK3JFT3NoWDN3NzFJa2UrT2RVVmJONndhR0xYQ1JTdDBz?=
 =?utf-8?B?Yi80WlVvNkd0Y1lrb2sweU4vVTJpbDVVK01zVTFnVEt6blpLenoxTkhQZGEy?=
 =?utf-8?B?cWFYWVFWbHMzV2FSV0g5cjdxR3B3L3VOdHFMajhYU2dSUWJkOEdxekdzSkJl?=
 =?utf-8?B?L0tDQmkyaUVTQUFtMWpCVTNwTk5qS2FUS1VEQlc5QU9OUlJyWFBJQzloRUlx?=
 =?utf-8?Q?p/4At5LDUJg7Hc312IEUXjbS/6tDzYAcLIgJj2P?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a0ff22-2499-4618-54da-08dda0de3eb4
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:30:55.4727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380



On 01/06/25 12:58 pm, Eric Sunshine wrote:
> On Sun, Jun 1, 2025 at 3:12 AM Aditya Garg <gargaditya08@live.com> wrote:
>> A lot of spelling and grammar mistakes were found in the logs shown to
>> the user while using imap-send. Most of them are lack of a full stop at
>> the end of a sentence and first word of a sentence not being capitalized.
>>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> diff --git a/imap-send.c b/imap-send.c
>> @@ -249,9 +249,9 @@ static int verify_hostname(X509 *cert, const char *hostname)
>>         if (!(subj = X509_get_subject_name(cert)))
>> -               return error("cannot get certificate subject");
>> +               return error("Cannot get certificate subject");
>>         if ((len = X509_NAME_get_text_by_NID(subj, NID_commonName, cname, sizeof(cname))) < 0)
>> -               return error("cannot get certificate common name");
>> +               return error("Cannot get certificate common name");
> 
> This patch generally seems to be taking the code in a direction
> opposite the rest of the project. Quoting from
> Documentation/CodingGuidelines:
> 

Lets drop this patch itself
