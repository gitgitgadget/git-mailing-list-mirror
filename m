Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737D827715
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938096; cv=fail; b=E8Vj2AmwV6+L7FikgWWgJFedfj93czmIrrdg5aPYWsoXF4k1GfW3LIxL+gtVVjTt52riPA9XdcZAlLNYLc48x9Bwv83+cx8vNfO5yC/gkCLrFve7Dz8ZEg3EOHYRM8ZOMM25PVDoiqfaSDSiQzGF35EZkqz++8rcoO50vTCSLRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938096; c=relaxed/simple;
	bh=TamUAglRLtBv26o6NLNVEyX/WQcJzHA7z5popesilwk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SPt+H1Sh2AaiP9QPpeu8GGd74PAmYiUo05YcOuVBxjN7gr04jQJLiBRIjUTuEmcElaDaGA6YNIDGnQshKtGeO3gHuQs9QrfsMnzFzVbC35BlgBXsKyDqhyjqiNRqeRcds6vHKduC5rNX7l6Efe63V3tywNXMHnniRBweGzufqKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=sajL67D1; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="sajL67D1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWa9fs1TcTSl7vNuW9L2kM879Z+eJjCEBA1D14qyEjf5jcQYF+YtaqGibKfX0WWODPDJWl1sITxBwkVlmdzp2smXjBOQRDUBSzyYvaY68QA4jby9vlVaQUST2R+zKVtj+fREgz2Zxmqc71DTq4MjFx3Wcs0kDg+3P1D4WUVY7jIfG9vHzPTYBwcAXbH8r+b8BRA5zyzPKDwtAkNNsy73qnaz35bMpW+snQuZY9gOHkbaZcgkx6LCcaa4ayAytkyeyUr8/FikWzHDIRP6KIdikIXIIc9JcMChEp/NXzSK0qJCSnXrOtQcUI8Mx5QQPeMVO6+L1OMNwcF7MLrO/3yKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHfs8NzLt6ZdwfMGi/BtCn8Y7tYI1ByihV4jbtSCmdo=;
 b=v3W9eFqCc0oPBM3bNAyS0z13arLuOXM/zliPXAq+3gzXQkHMfSXe37Bqgcg2knTZ2Xd5T+ofvHFtCifIBgzKboqNmxEz9lU4FIC3jw0Ipd3mNd7Ywgu2HqPBon/pw3PADmrPDgxcIVO/+853kO0TtuNtC2GrrkXFX8I/6uwniJS2tAfXrMsLfajJyYU9A3bjMDjRpl4jaduOr1rGcpO0XdMUp1udRC1zUpXdn/3SkZ5VWb/HPeBAgqiq2lw+Ie5zCvSTIKBAFDel++lkiLKjm/Bv1HCxNfBk4sXIIQsKzfzdTIA7qASuCzdOshSCqOZcX98PuG7lkDTHWvZuU//zbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHfs8NzLt6ZdwfMGi/BtCn8Y7tYI1ByihV4jbtSCmdo=;
 b=sajL67D1fPJVzfR3CKj+Amb8OGEDvJpFgZsz0OyS5XGezNTs/5cAx/WJJvL5W1u3kUz4F+1Dg1TRJ7x2OyBWCZuXOJifbVuivmEwlw+2q1J4FB9/nVCW/MeUYPhNnOEqwSA3WSHoicE2To3BKmTcGu9+c+wK+WGtzbQ5jf/+FfH+oR9FLaUYwKYAccg8EOIM3r3eSbVWuxDMO6XeTnPFtBds7sQ4ajAGJ9iVrAdLt2vMp2lVxXAsIcdjBCgMDtJEzzzYESFutRPJehnE6q9StuSBRSpbBwz/dOB6zmetAqonMEndeSYCc53WuFFdeWb1/rr4Sj0KOG+b3RYHjhznYw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7662.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 22 May
 2025 18:21:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:21:28 +0000
Message-ID:
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 23:51:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <072c7acf-06e7-4aab-92e4-00624a810217@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: a5cbaf5b-b25b-40d0-1097-08dd995d782f
X-MS-Exchange-SLBlob-MailProps:
	30ekHghIwFpWJZJ/S7H67WW7FVejyf+CLs0lVUO2YWjTAzGTs2f2MwxVXDVy8UuDEMu4vJtaB23jsK8cBIbikJzN83968SfzdY4ZgFyjaVJP38o9WLxfr0UxveE0ReLe6PFUvwYAC2MJzHAKsBFmPPPfFI9XeRz/S2AZWL+vpVlk01Httaxrvy17Nwk8zaBFANuTJU3RJI7ywJz+y9Zq7AGAE0WJNGZhBPo4qQvcCthbYWlMkr5PUK2X4qwIg273mPEia14nxOwNQQztaPLYpvbBtmpOg1npVVZHkR6vin6RyKynELxwhKoah4noEsUt7mv+7TqRLvEMiPHFyHoTZ8Tz0JmD6lQ37d/XdcBzXAPmstr3bv14pnpv7ypBMCNR9o3NZIanNOgdyT37h3t0oo3BWtBnykho4rHBtMHjoLOAfSuJjHXr92Q4Ip6ikhs4hVkAWVtViimoyP0btPhpAGLp6Uxb7PuNl0mlZbxpHixp1ogqbnc2HONNCNh8f3bqI9ZjQzPNjJ+2X0CIEnGgRxoKjENl1D0jBDsB+WCyOTtpJA5GhGqg4PdZK+Wb8+9NlrM/ag6w4W8W0WgNZebeyvZ2FAmVd77bNpDxVyknVv8ua8/ElI29VqRxgoKnSsVgABgKO6iwITPogF0e/ZHWEEF9oW81GEnmdXo5ZLlONmZ1ql+bGm1cuJ6Mnpu5KUMfeGCnFnRhaqzs6oZB3AVZQXQ2G+2mSrj2CRnXAlBIyGRbmmW8kOfaX1sm40bMArUO
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|7092599006|8060799009|15080799009|41001999006|19110799006|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S25FeHlVVkNSR0tEek9tcUhPZTBpYVgvNXJoeENhRkg0KzF4c3NTb0tXclQx?=
 =?utf-8?B?OGtZVGVMUmpIZEZ3UTJLcUdJY0F1N1hDQnZoQmFrM1Q4b1oraHdWK0JSTEJa?=
 =?utf-8?B?UVpsQzd5TnNvc3drMG5PaS81RVlBem1tSFRaZ2lQVjYxVVduRktIa3daZDc5?=
 =?utf-8?B?djJ5SHo1QVFrdzdzemdzdWVYQ2FxdEJkcDFwQjRBZUFycGxyVXZQWk9oOHpo?=
 =?utf-8?B?a2RtcGFEVnhIYnVaSnkxcjlUUFBlSjJ2NWRwNVhUMm5PTzhRbGZ5Q3JpY0tT?=
 =?utf-8?B?LzJwTEZFWXVRdGlrb281R2R4S3Nwemc4MmdDN3RqckZvRmV3cnA1MG1oQXZC?=
 =?utf-8?B?QmlCa2Q4SXU3dDMraGpINlZud0lxdjY5Tk03YVEzSmFiWThiTDU0Nm5FckpU?=
 =?utf-8?B?dU9rdUdmcFN6N05vQndEcDUwVUUrbU5rZVN6RjNTWGJXdDMvV1lqV1FkTDR0?=
 =?utf-8?B?NllUcy80L1dUMzJ3Ny8xVk9QVmlTUWxnMFNEbFFwTXl6K1FwQUVRWStRRXBt?=
 =?utf-8?B?Y04xR0podldEY09md2x2U1ROU1NoZkJ0VUNvQkJxSlErM3MxblRlUWxJVmRj?=
 =?utf-8?B?b2FoZ2djbHpvWnNINEVyOWE1aGpYemRjRldwYnlEQ2E1ZzZvVkJNNFZ6dnBw?=
 =?utf-8?B?Tlhoem03bTB4VSt5R2NTdjl1R3l2Y0xSS0svbUhhcGxQVHdpSzhtcDU1WUY5?=
 =?utf-8?B?RGJSMUIwcldITURQWE9nUEN0SFRGT0p3cU1YSGh0SHdidWlaenN3dGtXbmow?=
 =?utf-8?B?S3FSVThEUWJkaytyeWtnZkkwQmlaTXpISHluTk9VSk96ekFtM1JHa2ovNEZ2?=
 =?utf-8?B?RnlyRkJsMTUrRllhWDB6U3djemF0ZFBtN3ZTK1dhZzBSSDdHaFdRaXQ1eXFF?=
 =?utf-8?B?TzRxcmVqQ3NpeUNVbEZwaU1mVEdCdGtCdzlRVUUzMGNOb3ZZUkU0dmlDNi9n?=
 =?utf-8?B?Qy9iV05xbzFTdmorSlhIeTRmQWJJZ21tU1BlZ09zZ2w3TTBHNVA3SDhJZVB1?=
 =?utf-8?B?NEdwK2kxQmVtUnMwM2F5a0dkNy9wT0RsTk9qN0NySmVPTzV0ajJ3OWJMWFZ1?=
 =?utf-8?B?MjloREFZTWY3eUxpWDhKZWQ2VHlSN3VTV2FEeVozS2hORkFMenYrTjFXZjFJ?=
 =?utf-8?B?WEttS3NYa0FBLzcwaWpzSHZEdEdMWi93YjVnN04xaWxVRDI4VjRCVno0S2k4?=
 =?utf-8?B?NUhzNGI2UUtPK0ZPUkNaMWk5NjZwMzVpZXFUSGtaYXFXRG1iZkdyR0RTamxv?=
 =?utf-8?B?bDFCMy9kSFdMOW5valFidExzQVdmVkJSVi9XNVRLTzJaSlNLKy9SSVA5MzhT?=
 =?utf-8?B?cTNmWWVFdDRvZnhYcXlpakQ2UWdtR1Uwdi9SZVJyU28xbnkxWVBPSWtXUURD?=
 =?utf-8?B?S1JMVTRWSHU5a2dIeDRaKzdoVmI2cnhYNTBiZ2dqUUNMMkFyMzBncnZmdFZu?=
 =?utf-8?B?TFZYb09rbExrenJ0MksxQkxkSGk1TS9NNmJxVmFPd3dCTmZqMHlvRDh4OGZs?=
 =?utf-8?B?TkFhZUViRFkranFtVEtUY1NEMUpmQVEvMnRmWkZaVG5RSUZaazNLTzdOSzY0?=
 =?utf-8?B?aFMyWEVQR3Z5VWt1cW9iL3ljNlF4UFZZVnV3b2NXeFZFTUJ0VTFEdWtGSnow?=
 =?utf-8?B?Rkl4OHo2UE1POERhVGsvaHJlT1F1OFE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENud0ViT01MaXE1VGFGMmdsQUkvZGZlWnh3VTI4UHNIbDVDUnFJTUdhYWJw?=
 =?utf-8?B?THcvelhEWURwc3JsdmpYRmlNVHQ3Q2JjbVBVS2xIeTMwWVNSejRGbjJGSkNF?=
 =?utf-8?B?Zk52VWVwU3Y3cnNWNTJyZk1NQ2c5Y3V3RDFzd0RudWZudkltWEpNNG1ZY1E4?=
 =?utf-8?B?Ty9pQzJrSU45RDEzMmRHcytLRWIvNHpNclR3YTZnNWNEMmV4RU9YSll3MXpq?=
 =?utf-8?B?amRqWERiVElQRHFjUlNCMEYzOUdQSll0ZjRkYVJ4SG5PY1ljUk5ETGJDb1ZK?=
 =?utf-8?B?ZytrNlp1dDVEYm5vbmdVTVc4YnJ4eHl0dmxPRjJFZnI2MTlxYTNLTk9oYTlW?=
 =?utf-8?B?cEhzM3lnS212UmpTdVZRRkRYUm1JSFFBRjZ5OUFqRnI3OXpud0VCbEpBblNC?=
 =?utf-8?B?Y21DblpIdVBCbkd4RmsrNk9UMWxRL3BEeW9VL1JWaUdOVDFLMzlabEsxcTRy?=
 =?utf-8?B?R1l6cjhjM1BEU1V4QVZ0WDV0ZGNpcXNxdTZETXRUSm90UlpVOEQvaitrWlpo?=
 =?utf-8?B?a0FVaENZQ3EwbktINzVqc3dqc3lzQ0xta0JzRlR6VDlxL0lqeTE1Rm4vNkFr?=
 =?utf-8?B?V0pRNFVkR0RUSnpKSWN6eEZvc1NQT1dKbHZDd0hMWmo4eG9rbU9sSlVST0lC?=
 =?utf-8?B?elVvSHVZT3VROElNT1VqM2tkQ2RtdTdLLzVmU3RIRXpjMkRCQ1QyVlhXb1pN?=
 =?utf-8?B?SUEzZ1JZY0tyYlB1dVE5Qm4xNWpVVEpyeXRmWUg2OTRQL2J4YUxWZ0xzRGNX?=
 =?utf-8?B?NE1BVlNJeTRWMGxMc25UOVZBWkFaNFVGejNEUmFpUzk1VnVjUkorcURlQWJ3?=
 =?utf-8?B?SkxJWU94U3JVdVQ0RW15U25PQTdlVGh0S0NiQ3B6V1NjdGNZMjVKaGVSd0Zr?=
 =?utf-8?B?NjBrL1Z4VWtjVTVrdzZBSHlDM2Nqb0dmaGJPNERlQWtOc1RrdTl3ZWl5ZTF3?=
 =?utf-8?B?bGdwaGJVemNZUlFheG4xTzRRcUhYckZ4ak1EcU9Ra2VEQ1NVMjlmaXJ0ck51?=
 =?utf-8?B?MERVV1dWWFQ2YmZxYXVUbWRucjRxT1NyRmZDbHdZcWJvU2NXL1hobmh4SDhI?=
 =?utf-8?B?VXlFRFllZnR1Y055SS9hK0tLcTRReDFPYkpjZmRSYURqdU0xMThtb1FHamZm?=
 =?utf-8?B?bGtrYVNOUUZ3QzczL2l3bEdHL0ZKcmZQeE02L243ZmljRGN1S2NKKzZYQS83?=
 =?utf-8?B?SDQwTmwzUFpNb1NvR2k4UFFFSWVYc2VGTXlZYlJhazVzTHczYmYwaE1ZaUI2?=
 =?utf-8?B?UUJqZ1lQb0QrRkxubjdBdUhqQ3E0U1l1L0VXdmRrU1VXS0lLdW9FaEhGdVRN?=
 =?utf-8?B?NGJPU2J2cjBhamE5d2FqMUh6UnluTHNPWHpHUDZLL0tvV2ZIU1FpaEVVMTNM?=
 =?utf-8?B?ZFY0RWJjUlNUWElYaGZCNGVnWnJyV3FTS0MyYklISUluSXNjcTRsNXBiUm9V?=
 =?utf-8?B?eS96Nm9ITHFXcm14N3lGSTcxaUNjWUtwWDQvUEMzK0hKQ3lpTVRySzUvZzIr?=
 =?utf-8?B?ODRBOEdnQS9SbTI4MEJ4MVAxYjNqdlVQSHYvazFUdlJYWmRPcmNWNnVZSjln?=
 =?utf-8?B?czNqSzdQRExOZTJkd2R5VHJXa0J0ZFI0ZjVtdU5XRFlsY0txZFFONktJOE5l?=
 =?utf-8?B?alh6Y0t6L1I4cnlBQTg4Q3NEeVhEV3RDKzVmdnlIN0h4Ym9Dc0g4bjh1VjZX?=
 =?utf-8?B?a242bktZZUMzSk01NFp0Q1lKRnpZejJIYTg4c2ErV3E4Yy95RXVGOEg4bGRG?=
 =?utf-8?Q?bac1CXKnA3yEs/jCGw=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a5cbaf5b-b25b-40d0-1097-08dd995d782f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:21:28.5840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7662



On 22-05-2025 11:30 pm, Eric Sunshine wrote:
> On Thu, May 22, 2025 at 1:29 PM Aditya Garg <gargaditya08@live.com> wrote:
>> Upon setting up imap-send config file, I encountered the very first bug.
>> An error showing "no imap store specified" was being displayed on the
>> terminal. Upon investigating further, in static int git_imap_config,
>> cfg->folder was being incorrectly set to NULL in case imap.user, imap.pass,
>> imap.tunnel and imap.authmethod were defined, and the values that these configs
>> intended to set were not being set at all. Because of this, git imap-send was
>> basically not usable at all. The bug seems to be there for quite a while, and
>> has not yet been detected, likely due to better options like git send-email
>> being available.
>>
>> Signed-off-by: Aditya Garg <gargaditya08@live.com>
>> ---
>> diff --git a/imap-send.c b/imap-send.c
>> @@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
>>                 FREE_AND_NULL(cfg->folder);
>>                 return git_config_string(&cfg->folder, var, val);
>>         } else if (!strcmp("imap.user", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->user);
>>                 return git_config_string(&cfg->user, var, val);
>>         } else if (!strcmp("imap.pass", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->pass);
>>                 return git_config_string(&cfg->pass, var, val);
>>         } else if (!strcmp("imap.tunnel", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->tunnel);
>>                 return git_config_string(&cfg->tunnel, var, val);
>>         } else if (!strcmp("imap.authmethod", var)) {
>> -               FREE_AND_NULL(cfg->folder);
>> +               FREE_AND_NULL(cfg->auth_method);
>>                 return git_config_string(&cfg->auth_method, var, val);
> 
> Okay, makes sense. It might be worth mentioning in the commit message
> that these copy/paste bugs were introduced by 6d1f198f34 (imap-send:
> fix leaking memory in `imap_server_conf`, 2024-06-07).
> 
> Squinting at the code a bit more, am I correct in thinking that
> 6d1f198f34 missed a case and that the function is still leaking
> `cfg->host` in the "imap.host" conditional? I haven't traced the code
> or all the callers, but I wonder if server_fill_credential() in the
> same file may also be leaky. In any event, the `cfg->host` and the
> possible server_fill_credential() leaks are outside the scope of this
> bug-fix patch.


Not sure about server_fill_credential(), but I think this is also
a potential memory leak

static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
{
	int ret;
	char *response;

	response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);

	ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
	if (ret != strlen(response))
+		free(response); // fix for the leak
		return error("IMAP error: sending response failed");

	free(response);

	return 0;
}
