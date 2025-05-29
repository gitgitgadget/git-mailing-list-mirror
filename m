Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010003.outbound.protection.outlook.com [52.103.68.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6F9C147
	for <git@vger.kernel.org>; Thu, 29 May 2025 14:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748527802; cv=fail; b=PF0Ww6V5/0haFVFgA0mBiGqEUg9Pz+kKOrKsDhIYPC3QgQ6qqLCouxHusN70I6udv6K1k6KtexAliZpvOEgHD1b1cJXAYrjKlK+lL8rpncucFoclXLxiWXZVQTkPELHqQypBXOt+JdFHmTrmtYP0xPZJZGir5hYdB0OtudEh5VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748527802; c=relaxed/simple;
	bh=eMsKBl7FpiEom6PXdk4Sdcrb6s36XWTdKAABSgBmWRo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OodcxokD82iEhHHQyCzpYtRQiHjU9NMfRxu70b9kP9CnzE0fQD4jHy8tYg5ImgAHojoXZ9MVwJ4Pw3lKCBRGnPgax+izwYzhKhD7Usdn/v94t1msQyzfec3zdK9HMjFYYf+fq9GIIurjtwsEj1yR05Z38ncJf8AJvgN7BsGGDxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kpMgutmN; arc=fail smtp.client-ip=52.103.68.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kpMgutmN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jog1L/aqSu2xlP8AtzmzlCKR2yP5uyAIEFPxPz4ctpavqhw90TAQb6oT6/rxG8g/BJnSOdVj191f4m0EP5rf2YfJTlaG97/YXfxtjSfuft0hvEFNjAhbAZ+jU02EhCOPFRgQK9PqkQ4ul1BQte/KEjKyHRzUhdS2dFFSwCeERvUibGf/sAiTWVA1fQ4dEtX7xpRugf/ugv+gx2gg9LvgNiPSrDtqSKtcP+nJchsTGhjtzbSw9qC0ArKs/qS1OAbppCD8J05g9MdAvRjjdFu+oBpNa2x7qsTcGB87qyV+e5Ot5aduXraG332QULiEo8bIQLE0PahQd1bNHqeFBCyMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gz0cJcVFUUJi0wrwZFvt+M+0f22DzdDZXaOAcTeRopA=;
 b=q5KcDtWQnEgj/Lyrg4nzh/C8hF90eNDt4m7dfv59e0l6IGLDz/uB+RttTkJxcnHnpPESuebVyooeZikKTpnsfd0CQFtrupcrXaC9C5J9z7GDOSKV3am40qzDKzDjJpL3rnYYVSRw0OB0GoDPy/gy3WMXb3OPvjGlrfhYTYu2pszopAiGRaO0ktXn7FEJ3yKhhzuZboSfLv7BZta4Pyr1i/jMu99j/wuUMqRVGCUDQl0W/2jsxje6X8C6alE6AS9z3z11bxqmN5wEdwJYPNBPLkjDA9z3sOumlpjWGCqEFkPXmww0vIW6dxaR/bU/pQwxOcLwlTQholB5I1av6PSefQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gz0cJcVFUUJi0wrwZFvt+M+0f22DzdDZXaOAcTeRopA=;
 b=kpMgutmN7f8SHL87u3kHqiQhly7/UYhOfwWRYeYFO9eSbvHEjSGlVAJqTmeXoXehZ6t8REVdTTB9lS8ccDswMD4RgOISO0PT5MgM6IbTyAjM76g5bkngr7xRmBKrgZ0TRooern7/V3uleNRHtk1WqeuRa4Fim8x3lQAlkpEM9eWkm+AhlPaHYTGrVUoTPtMdXq9BPeXTbsaTnHS88JDc5KuCDhKL7F3Go9q6A6yFV+jEy4U6zL7jKe9ZI0vlRuZx9QX53bHj4X1ZSimdP0JhQ73uvL8FSyKZ58LPf+hGvDVbOBZkdlqQlmUbJvpTB9yhfi+lGtSeltkDXo+WltVv6g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAYPR01MB10585.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:152::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 14:09:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Thu, 29 May 2025
 14:09:54 +0000
Message-ID:
 <PN3PR01MB959721C6731825B259E5C8D0B866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 29 May 2025 19:39:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 6/9] imap-send: enable user to choose between libcurl
 and openssl using the config
To: phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, sandals@crustytoothpaste.net,
 Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>,
 Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979EAD9EEEB3385693EBE7B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B56233DA6815FC7CA96EB867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <42e07f4d-9888-4a1e-826a-b53b7d84fef6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::6) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <f01d5c28-f820-4ea7-b5b4-6e659b020d64@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAYPR01MB10585:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fa79e40-52ad-4b7f-c28e-08dd9eba7bdf
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnTsIneCeLMabZSXvknuFjxehl0T9NflfG1rGkwpjDmcbzDxrpuYN59LZycAbNqbncJrv2omYkwWRuDxH4cSl/kBqrkWKbYNG4IqYaJYkjw+TwbzSyWVwaw8l7uDFEBRFqjl6FTV+4lfzThCQfaT0+lCnN3Ahiozdt5V1g6UsApQyid8gOJi1GrpnU21CBnD0ahizQSH+75lQqNHKdkPhNx3e8twPUQCOcev9MhpCHnohSbnyJp7t+kCgmPBSQ97kevgnsZDGNPsvtezzO6+wp7sDsP6CcaR+N89Rk0B7mKxM1B+rI2wp5hFe60aUxQZlYAem0FawDo9ZUDJJ+ft8eW7sSbKcoLipMYItDPJA9RkIbOweD3wKgR/R9SuY/WAY+PYmSqACl+WQEQv6RIgi1NQ/bu2KxuAaquXgBrcXbfDVIO3zZltZi84D8ysGXD6lSl5jTuoJbfWU5o2pLCnvY77TM7sPYKix8rSfrsWQJoYJSUZujZxWlGz7YXT7m55UIoy5OONwJ07he5KQWZVo6/mADeCH5RPr6ngjw0V+0zk6n1q52DQC5oSzFolsBL7EY5SWiN3ylWRAnyqQ+spc+432CDa1Clz6ZjT8obQUOf7xPT6PuODW50aAagFjNPKryzrJmSLw898j/0weNi0TV6RUBoC09sDIHpn6LGJrjKIOZI2sG2U5nuskv3uK0h06yjLkYITFYale8JU8s0NWRHjUH1hRJnRe8XYQpredi6+Q=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|19110799006|7092599006|8060799009|15080799009|6090799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUZZaEJMSTUvVkoreHIwM0JZejZXZGxUUTBLbkdZOFNNRVE0bmdCNWVneXRJ?=
 =?utf-8?B?VktuTzVQZHdSNDBsUFd3RG9sWkFNanJYbFNHUGpNMU94MlcybEowZ0JSVFp6?=
 =?utf-8?B?TTlYbUJFcWs0OWdTRU1hQjZnYkJnWENLWGhLOTUyUjNFbXFJUmFSdS9UNlpX?=
 =?utf-8?B?ZWZwY2ptUGlIV1RvZ0pjaHpLcVZUQ2JTUk54MHp4LzU2c3dUSHVqbTNYMENy?=
 =?utf-8?B?UTVoTmdNM1pWS05xNDRITk4vUUdzZ2NPdlp6K2ZNRFBQQWVMR2xnajBWdlBC?=
 =?utf-8?B?eXA2KzVyNHZNQ3JuU1YzL2NyS3E2bU00VHBXaWx1WDB3cEZHTUVMSmVlcHNL?=
 =?utf-8?B?d0I4Ump1YjV1c0hNUmJ6bXc4bVRGMjlBZUZiUkFOMmtYVVJ2VnpkTjN4YmIw?=
 =?utf-8?B?U09WQUQ4dHkyUXJ5UE12bTRkTXRFeTl4ZFJ6TXBtWWMwRmpiaVBVZ0JzdlFY?=
 =?utf-8?B?M0diOFV2ZnFQQTNzb01haXQrcmxLZDB5c1dNTWE2cnVaZFIyeUlqVmFqK0J5?=
 =?utf-8?B?SGhRaUU5YTNlWDNoTm1PL3BnUWRDRktOb21qd1ZVdVNUS0JUYlNhd0FGRVlp?=
 =?utf-8?B?U2l4eHE0aHdPTVhkWWpucWxmY1g2cG10dUZvekxROVF0OFZyaERNTnZuYm9n?=
 =?utf-8?B?R2hUQXpjWmptRlN1QUhkTmFEdU5jK2w3bGFMQ2xWeEl2TXl1c2M0QlJCUTZy?=
 =?utf-8?B?M0l2a21VcDJ6cERoYjA5UDF1RmxkZ2pwQTQ4QkMyV1V2NHVyRHNaYXYreHU2?=
 =?utf-8?B?TkRQaTQrVkVCZVV5NXU2N3FrRVgvdVpMZGVJVy8xU2lJVHRnaURkWlIrZW16?=
 =?utf-8?B?dUVxclNJNSs2UjcvMFZIeVV1ZzZqc1JjRHZVNmRSUDMvTHZNNFpDQmFIeGRJ?=
 =?utf-8?B?aDVFanFYNlF2SGc1M1prTEVrS2NPSkwza1pZUjdDUXpUVUlUa252NTViVUM4?=
 =?utf-8?B?OW54cnZJdUZlTDhsaXdjU0RLNXFmNThjdlFJeGJuTVdCUE1aQi84TzZTUDRW?=
 =?utf-8?B?K0UyanBBcC9jK2Fhd1NYZ0owQjJIQlFKMWpDNTQ0VUxmWFJpTWE2K0dMYnUr?=
 =?utf-8?B?Mkdja09hcytrSnl2Zm9QM0pjaDdOQXRSaVNHQ3BrMzFtWEtwSkFiRkFjaWN1?=
 =?utf-8?B?RFo5a2ZOOEpKTmlydytjRjFBU2M1bUJ3T29YdlRYbDVyVlNPWW9YVExURDQ3?=
 =?utf-8?B?bm1CMXlKRUZlR0Z4YWpLMTdYR05yendiQTFJR3I5NmlsZUNuekllVittSGNL?=
 =?utf-8?B?OGpSckRHUjg2clRnR2xhejFObW5WK3c3b28wdEljaUgwOE01bldQU3F3cUlO?=
 =?utf-8?B?M1U5NDVqUm1OMGR3K05YV1JtUExhbSs3T0thWHhyTVM1Rm41MGR5bE1HbWls?=
 =?utf-8?B?T1J2c1NVY3hiY1hLNzczU0U4c1RhUUU5aUl1cnN4cFRiSWs5OVAxQkJiSW9Q?=
 =?utf-8?B?bEdJTHBxUDBIOGRpeU1jaW9IUkpPaFBlZ2FEWGRJUmlqQXNkbEw1bGtpSWw4?=
 =?utf-8?B?akR4V1B5ZWtXQjZUWXB4TzJnKzRYcTgrTlVYd0tVUEFDNmtqR2JmNjQ2Vk9v?=
 =?utf-8?B?RnVxUT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NUU2M0k4OXVGVXB2dm9BNGlQemxySTR1ZEJaYVZyOG9sVWxJV2dRdlBQT2hh?=
 =?utf-8?B?VGxJNFZzcXFOc3RUb1MvbXlqQXBhdFkvWXRjMHRzNjlmc2NUbGFJSENMZnpY?=
 =?utf-8?B?anBuOGM1YlVWOHJ6S2NGQndJa2N6czVVL3gyOEY5dTNHSlQ3dHFpM2QxZHZr?=
 =?utf-8?B?THVCVGd2N242dTl5VmlVOVQ1VzVYT2dFdUg5azEvNkNGUEwrRFVKNmltNkNt?=
 =?utf-8?B?VDViZno0eFA3MWhsOWNpcVZtQ0lsZEcydzloM21Ja0JDY3U4WEhLQ2czS3NJ?=
 =?utf-8?B?S3V1L09oZGxxZjdGd1FicHIxWUNoYWpMdHpjcmNqSFJ4MnkybDVGbkMxZnRj?=
 =?utf-8?B?MWZhTzBDaE9yTlRKZXpmNE10VWdPTTU3TXVIQXc0TkRreVNMNnIreUUzSUQw?=
 =?utf-8?B?SHdRbExWWGEvSUYzUU9SVENYRkNJRU5Nd29nQmVLTzdpaGxoZktNQWRPTFh6?=
 =?utf-8?B?Z1dsQVFmS3lnbEpKMFZxVENWSlZoUU9LUUQvMStWZTFBVk9oSFErT0kza0NT?=
 =?utf-8?B?TnhOZks0ajVXVHlqTk16bjFSN29oNGRqWlpHUVg5dmZXR1c5K2VCMHQ0K0lW?=
 =?utf-8?B?bWFOQnNMNTViT2U5WFBicFRrenowUlVoU1hYd0dNSGFEalJZaEJWaUllNCs1?=
 =?utf-8?B?ekZuMnhZTzIvVzNJSXYxWmIvcGtWQUlRVkVXdUxtd0NKbEg4ZSt5K2d0a0NB?=
 =?utf-8?B?QnVKdXd2Q2FiVkhWd2R2cXNha2dLSGFSVTU4Vm12SDE2Z3NISHhMZHlTbWRq?=
 =?utf-8?B?YVh1YnNVUVZPUXBzOFp1STdkZzVCMTJjRTJJL2gzUFRBaXZKcXlYMTQrNVVU?=
 =?utf-8?B?VVFDdXJrTHlhYlpTNHJRZE1pampOSGhrSjhXbXlueWpIRjdkV2Y1UUEzVlFq?=
 =?utf-8?B?OG9za2l0UTV3akdzREtXSkMxcWF1ZDZYMmlWQ2VDTG5nZ0pCQ3lpaWduQjhm?=
 =?utf-8?B?aEZxSXJZT0RWcmduSFRxeUQyQjlCbFc4eXJlRTdRK2NOWW1sbWY3SVdpVTMy?=
 =?utf-8?B?aUtwYkl2OXhnVVNMNFlQd005TjhyQ2dza1dkcXpEdUh1QWEwNzUzaUUweTBs?=
 =?utf-8?B?N2d5dmZ5MFRpNFhBZzhJMFg2S2F4Ykx1dUI1MEl1dkpNOTlkRm1aNmRVSEhN?=
 =?utf-8?B?NUZOZW9YdThJQy9tRnZieDI3UXBFenR0OTQwWW9DWkVGWGNja3dEUUZqUTlJ?=
 =?utf-8?B?Z2ZkblNCZUhVTUdRdjl4RHJaRW8za28xeUl3RmRPN0ZBakYvTVNHWTZwSkR0?=
 =?utf-8?B?WWhMWGZidUpOV0V3NkNRMEc1WURpdU1zc2FjYWh3YSt0Mll5WnhnaUhXT09i?=
 =?utf-8?B?UkMyNWlkSEhqaE9IcUdlY1p2elVTMWx5azFJejdDOG1MR0ZlZ3RrUmx2NW5r?=
 =?utf-8?B?UHBlcnM1WHpFTFI4N0dLZXVOVTdPd1dJRThqZHA0cjB0VUFzSWNDekcrNklM?=
 =?utf-8?B?ZC9pK3RweWF6QzRDSjdYQW9nN2cxZmxENGtDLy9YRzdGNkFWUGh4N1RBQ3ov?=
 =?utf-8?B?aTlqWGNUbTZxeDRsUVhZMUw0aWljRDdqWUFTY3c2eWZ1YUNoZVFhdklQMmM2?=
 =?utf-8?B?ai9HaVEyajRDVWo3MjZQbE9KZUMyUzA1ZlV4OW1BS0tRVnBnRXFuZ2ZiSFk4?=
 =?utf-8?B?b3haT0lnclhCOUN4QXpTMVo5WDF5Z0haa21xeXBJZDBPY3hYL3JQWDgrTHlo?=
 =?utf-8?B?MGs2OU9XMzdBaEdQc2dOY25OVFBHYmpESnNCZEVQSmd3QkdveEJKczlIZGRq?=
 =?utf-8?Q?HHlyyIbNTvLBv3iyHsx18dRej0qXLPovuZs+2cD?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fa79e40-52ad-4b7f-c28e-08dd9eba7bdf
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 14:09:53.9503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10585



On 29/05/25 7:28 pm, Phillip Wood wrote:
> Hi Aditya
> 
> On 28/05/2025 18:17, Aditya Garg wrote:
>> Currently, imap-send allows the user to choose between libcurl and
>> openssl in case Git is compiled with both libraries only using the
>> command line, and no option to set a default using the config is
>> available. Add support for the same.
> 
> I'm wondering why anyone would want to switch the backend at run-time? There has been talk in the past about removing the openssl code [1] and just relying on the curl backend. I think that is a worthwhile goal as it simplifies the code and means we would avoid having to worry about whether we're using openssl correctly [2]. That would be harder to do if we add this config setting. If we don't already do so, perhaps we could start using libcurl even when openssl is also available though that does not need to be part of this patch series.

OpenSSL is still needed for CRAM-MD5, something which curl does not support at all.
I agree CRAM-MD5 is not popular today, but I have seen servers that still use it
even today (For example rediffmail).

Also, implementing more features is simply more easy and feasible with OpenSSL,
curl has limitations.

Lastly, in my tests, OpenSSL did perform much better in terms of sending mails
than curl, and thus having that implementation does not harm if someone is ready
to compile git themselves.
