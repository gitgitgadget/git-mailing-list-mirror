Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D8978F39
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 05:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750396589; cv=fail; b=B/IrX/F+EOwdbGQDSXyoNSjEIesparxEE/WaZwopo0qKYq4NPRja/MN6qw7o0tEuSMLMC5K817CBxdYubtPBfrV/HI5YT7s+f0UUM426uhBLg+vQRe06/krW1PCyqyscJsPDo7vnooy4HH6s8oebcr4JkDIXEcAG5C5aPWhbxN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750396589; c=relaxed/simple;
	bh=DjlXZrGH+Z4noSIM2JKLJGtUmqAE51e4/O1thMOS+EQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5HYYam1bIqdsGS48Pw2xxBOuURRQ0y0cb4EXsN+jzDlpaqLTFv61G5Tq8JDML6m+aGfyULq3ovMHDsI711VyGA51IX4iAr2sBZyl/JdSKDfTjE7SB8es610ck343LWdbmahGsHsmjuoGZsQSmO2rhC2CzXGxvARIkIWU6wZQh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=G0rGs5yr; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="G0rGs5yr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtQM6ji+J9SLxBjFSg/m6XHJeGsQ7rg+HA+jMa+dkZQpFDsnVihmaWZ8utPFyBpWAUr8+GBRFjLCB7LReFw35itL+9obbpMZeh/cQPUOn2SumYJSOfDN6ly1OLtkHLmBJMkxeuJteYXP7TSUkmTy47zsxtN98Kl4DCYx5wpcV3R2VZOBtlmJatG9i4vv/QAjwIL8nP7+6NdES+0x9fRg/hXd6qCs2/0OLS1Wp1+hU8Ou+CGi6azTu//v6Ij0kA4Wapu1YLqaj5fHaTqZWC7bjfR04lioXvbcAJbvxwChYNwkmZuYTirWz5R3CsAT4i0In1UGEaSGbcXG1vgB4JcagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdLj6fcxJxa2qbodmmngj5Pqfufmj9GzDP9b3quvq8M=;
 b=OpmeewEOWvL5ukc6H9uMScNq0PzHzxlvhnLAcTGiBJiiCj8L9lMQN4vEaX2uCkKo4yRTI0oFB5DzE79fTiPrpyupDBuX0euzU7/rTrDDq7VFVFAsRtQrwa4mNui7RCRb0qJAfuHv6/EOrhfOhmklWemLOftoLZ/ktpXnBfn6hL5mXeCRyIdDWjnqByASk4fzWcXiNsscnCzI4+vk5L9MiooH9Svy5IgtHSY0J+89OztIk6B2F2lDWu1TQo/xHHHrcFO5qZdYYZYg1Wz5Co+IxmvoNiLKXMX42NaTW3Xy0wtjaepy+FpytWIHjg7bqeJz/2U+xdqIwawQSfyQSouPcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdLj6fcxJxa2qbodmmngj5Pqfufmj9GzDP9b3quvq8M=;
 b=G0rGs5yr06Dewx0D+898RkiRtV28bRtKpCENNlXtRxeO915/0VStWALvkbadp1ucNZaLJ1nnRY+4+biZKjy+FMCxOL80MjU86Ry0S3rKAgmh6HZx1dGjBBZW6cPYHZgGH0WfsAy60RUhrJ+pRSBlCX74tUriUYSz8db+qn/Sv68eeZ++E00plE5YqTPMxkxUxdaNA8VPLysd6l6W78qM0UPXBZ7atL4p/VPPsN9OZ2xNuTigOxUgABDMyLLvxo5mjs7CGLRRXdYotBH4TGQlWvHDniCY2F7iydFRdQmMRt0qCgKIOroEjAsEwbtDWsIXQKc4aDSOCjOCfSWaP4gIWw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6998.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 05:16:22 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 05:16:22 +0000
Message-ID:
 <PN3PR01MB9597DB18FF5C6C2C92EBDEE8B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 20 Jun 2025 10:46:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/10] imap-send: add support for OAuth2.0
 authentication
To: Phillip Wood <phillip.wood123@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
 <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597607108917195B9690F67B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <F0A06034-99B8-4BD1-9CDE-515A3EA430DA@gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <F0A06034-99B8-4BD1-9CDE-515A3EA430DA@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0115.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b0::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <29cabfb7-b707-40f4-882d-6d34c0b48594@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fdad65-1a6b-40f0-17b0-08ddafb9986b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|461199028|19110799006|15080799009|7092599006|8060799009|5072599009|1602099012|3412199025|440099028|4302099013|40105399003|10035399007|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2JTRlZsNVljUXBBR0I0Q0ErUFJycFBZNDg1bVpheGNVcWMyUGdHTWR4NUpS?=
 =?utf-8?B?Tnl6SmxlZjBQUWlPOHVUVUNBUmlEMm5rMUoyOUhLU1BHeUJSRFdVclFjNGcz?=
 =?utf-8?B?eWZ6cW14NjU3QWhYVkpvMDBrKzBKdkNCZDJyUHhMT1gyeG0raGVtR2d5VzFI?=
 =?utf-8?B?UnpNajlpdDJVWjZLYzZLY1ZDQkhaOWxsd3prNk1XYWNMcmZ0NGJGMCthLzEv?=
 =?utf-8?B?Vkdvay9pMnJaVGcwTnU5alBMc2Fwc1JoZklvOFQ2SDhhSCszWWg1MUVVV3RY?=
 =?utf-8?B?WnRKNStJeWtoem1ERzRaejFrTTluQnVLSFRTcEVVTklyTk5PODZLWUlzcFd1?=
 =?utf-8?B?d3QvM3hPMjJwK0Yzczd1RWRFWTBiRTZQUEdWc016UHd3RVk0OW5BVVBZaVNa?=
 =?utf-8?B?K24ya2pBZzR4aGZEaW5HT2JZZGJ5aWwyL0hNQlRpVkJaV1BMREV0elBaT1JS?=
 =?utf-8?B?TnR1QVcwRllqKzZTZVRkc24vYkd0TzAzM1VwMEFHRG4xd2o5YStrSXNHbXlr?=
 =?utf-8?B?ZnV5K3JQRW9kWE1ucHl3dkJWcFFvTklOUHdwWlp2Uld3NFg2WWZkSExUWGpy?=
 =?utf-8?B?QmpzVFJQL3FQS3BtWnA5Wi9SV1BhNzQwVml5UHRuMWZRRGlQSzVxVDl2WlNY?=
 =?utf-8?B?K1liWU1pNS9iY0MrVG0zenBHQURHZmdaNmg2a0JzZ0dlQjJjZXVwcmZaUi9t?=
 =?utf-8?B?aTZuTGtpRlE3N25yT2NhUEtDVjJJWVRVWWc2SThDSG9KL3RMdjRscDJ1S0gz?=
 =?utf-8?B?Vkl2a091ZDI5Q2F1SElhV3k0U1FlL0VRazg5QmVIT0NPTTlxK2trVTg1aXNz?=
 =?utf-8?B?L1ZXOS8zM1ZERkIzaTNQQWJranZUVDd5MmI0QVA0RU1Ba0xZMTNlaDIrWlpI?=
 =?utf-8?B?SU9KeDdNMlhLSVhQNHJOU3doOVFOeE5FQ2YwNmZDanc5cFY1VUh1OEp2TlIz?=
 =?utf-8?B?a2hpRnJMaGZYa2xucjBIZEkwZ0lDWWhBckw5S1FYZkxFZkFNZlVoNGJvZDZM?=
 =?utf-8?B?cW9saDljN01nQkhFd2pDRGNwV1l5NXFUclZaME55SUlrVm53RTJIak1SZ0tH?=
 =?utf-8?B?T2NFeExNOXViVklLTWdoOUhkNkhrd1FCcjhlRm5MZWNoT3R2THJtOEdkc3pz?=
 =?utf-8?B?eWdlTjM4UFFsYzRhU2FnTkphbWo2dkRLVTAwVng1OGliY25ld05VeERpVGY4?=
 =?utf-8?B?N3o1WWFHWFZGNGVWWFNoejhMY1VHTTk1RVFOOVAyVzBTVTN1M1JTN0ozNEMx?=
 =?utf-8?B?dldkc1dET2JRNGJEWWVBYXBmbWE1Nkk5K2tEeXNneFJBc3ZYQjVCcGphZVdC?=
 =?utf-8?B?N0g4aVp0dWp6MGRTa1FTaG90ZVpIKzhDdkxWaENhMEhBdU5PaDZhQUtzT2dj?=
 =?utf-8?B?QUFPdWNiTGZqWmVmM3U0NHdRcll5dmJKQU9Fdys3SlNXSzVHSlRTREZtTmlu?=
 =?utf-8?B?SkFwRGtGeFFkUXF4ZEJlMStkQnRaZ0xRckI5MUxvbjBCcTlEL25JS1dQek9E?=
 =?utf-8?B?QmVFMlMxYlBiYTQydWcrVXdpazNoWGx2MkVFTkM3MzFiaStEZlBwVEdVUmpI?=
 =?utf-8?B?UFdEZWo1ZE9RcFluRVBJUGV0Qnh4T3pNYUdLSkFFUVI2d1I1ZTJqRnRMdHRC?=
 =?utf-8?B?emFWREdVOWNxWkNFMXRMc2R5WUhkZU5reTFvOS90QkpkREZwbk96NmY5aU9P?=
 =?utf-8?B?TnJoM2lVdzVGeVpiVUcyQUZIWmhSYUI1WDRBQ0xRd1dzMzJyemphQ05sdzJl?=
 =?utf-8?B?T0RUanJ1VnNRRFFPeHJyZEFvaDdoUkRhd2x2eWoydkVyQUN4anRCM20xRmpY?=
 =?utf-8?B?NGFRQWIvM00xcXl4Z2NyUEJ5dXU2V2l1Zm9LYjVXaExLNDdGT083Z2tZYm5p?=
 =?utf-8?Q?I/Ju2fArtCakG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGNLV1JQeFR1WUxLSWl4YXpQNEsxaGNwVFdpdklBb2plRHkwdVMzV0pnbVNU?=
 =?utf-8?B?Q1NXSVZhWHAxaFQxVk9xV3pNUXlsRHplYUh2c3JKU3B0QmJhRTFtQjgycklv?=
 =?utf-8?B?K3YzanpUS2NBc0xEek95cXg5Q0krdHhFTFpUS1dNMFc1d1lUTWovazV4NFRR?=
 =?utf-8?B?WHVObUR0QVpENTZaNm9qLzgrMnVNS3Q0bDR4Wk1veHRUeVhtUkNDWVBqd2JO?=
 =?utf-8?B?RDVrVk1MRnUzUytRMzZmbzRhNzFzNGRkNlRYeTM5TFhNaTFscUgzblFUT2Qv?=
 =?utf-8?B?V3E2N0FlMmhQZ0J4Q0UzV25BQUwrc1cycitpa1ZXdTkxbXBzaGwzZWtPSGV4?=
 =?utf-8?B?MlJKZUVaVjNSbHU2bXlCOVMxcW9ia0Nzdm10bHg3eWhGYjdSemxQelFEdGdE?=
 =?utf-8?B?R0hDTXVkWG9KZTh1OUlZQXA0clAzeCtRaFY1bzJUTXJWM2U1V3owNStOUCtj?=
 =?utf-8?B?ZDdTREowWXIrc0RzbDdmR3ZwTmljbGs1VmErbTE4WVRLQThWNGZLRkhjdWJi?=
 =?utf-8?B?clZWdk5pUmgxN21neksrcXBEY2llRGNjUVQwdFNmZHFRNGFROEFJSzAvTUIv?=
 =?utf-8?B?Y2hFTW05UUhycyt5Wkl3ZzBsanRtZEtHSkdFMXdWWmdyLys2VE5saE9yRndJ?=
 =?utf-8?B?UWRIbDdEMzl6SEpHWWtQRXBvS2xQVDFoNWNvY0VSQkd0NGZFQ3IxZHExT0tz?=
 =?utf-8?B?ZjBVSnJzR09KZEdTYjdtWjJjckR6dXltek0remcvY0dpRDRoc2hSYlh3MXRu?=
 =?utf-8?B?WVc2cFJ3OHdQaXE4bm9jWXhKZnVMKzhXMnQ4UDZKNVJqUG9CZHRoM0h3NDJU?=
 =?utf-8?B?U3NLejFYRXhKeDBweCttRFJVSDNJYmhjNUFzanJ4RkowTHM1ZUEyMFZicUVQ?=
 =?utf-8?B?dGtMT0QvSG04QWhYdTRZU1JKc3lZclphNlpBVkhoUWRMZTVsV3lvdXhkMm1P?=
 =?utf-8?B?dnJhTTl5QWZtVDJhRXdnL0l4dlNYUkVRWjhGLzJ3d3lvNjUwWG1iaVR4YXFz?=
 =?utf-8?B?cWtQL0FMV1BnRk84K2UyWHg1b01oQTRKTlNOMTFSZ0gzVDJJeVYzME9CU1I3?=
 =?utf-8?B?SUdsUlRyamVHZlJMazJTZUZCblZ5bTlYWk8xVTM5NlEvSGRBSTZnQzRJUy9G?=
 =?utf-8?B?SlNycjRIZFBIU3lpSVpKUjhweHBRd0xXYUN2UEtUWGVxQ0tLOFMwcVptQWpj?=
 =?utf-8?B?UnhCeHNMVlptb1RKZTFYYTdFTjl0ZjgySTllR1lQNWFMV2RLSWxWSUtvSE1F?=
 =?utf-8?B?Q2svQWZBWEtQcXNjQ0xWOWZWWkVSUWFiNk1NMHl5M0pWUjFRYSt1K0ViWnhh?=
 =?utf-8?B?NGF3QlFuT3o3VFAvMEsyUUlnVUFVT1EzV1ZyWVlWWXRTMERDYW14dWZ6WDBs?=
 =?utf-8?B?ekZSdE5XaU1qMVBVNmlBZUMvMTVXbUNwYWxwN3JqOC9TYkliRTZ2QkFLNmpS?=
 =?utf-8?B?MEd2all5elZJZDFhbkJ5L0dDYmZYdEsveUVIWDdTSWtuVUNaVzFoSTZNNWZK?=
 =?utf-8?B?M3l1SzZaRVprR3p2a1hPMzJIU3ozRkEvby9CdVN4RFFWcGZoZ0Q4S2pSZWhG?=
 =?utf-8?B?VDVTc1BnbUxPQXFhUDZjSzlDb2ZLdHcwQUFTQUgzRE9Ja1kwNU5aZWk3ZjhC?=
 =?utf-8?B?SHowbkw3bjl3OWVZUHpydTlaM0VnZ29tYXZESDFDVGIyUHhicm5IeXF0aDBB?=
 =?utf-8?B?WXcrN3hEYXFMVll2UWl6eTJoNjN3V0JGcUZCSGhkcDROSVM1OFJOb2tINVRr?=
 =?utf-8?Q?afyil2GFOeLRlGC2XQ=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fdad65-1a6b-40f0-17b0-08ddafb9986b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 05:16:22.0828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6998



On 17-06-2025 03:57 pm, Phillip Wood wrote:
> I'm not really on the list at the moment but I saw this was slated for next in what's cooking. Apologies if the formatting is off, I'm in my phone. 
> 
> On 9 June 2025 21:22:49 BST, Aditya Garg <gargaditya08@live.com> wrote:
>>
>> +static char *oauthbearer_base64(const char *user, const char *access_token)
>> +{
>> +	int raw_len, b64_len;
>> +	char *raw, *b64;
>> +
>> +	/*
>> +	 * Compose the OAUTHBEARER string
>> +	 *
>> +	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
>> +	 *
>> +	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
>> +	 * * gs2-cb-flag `n` -> client does not support CB
>> +	 * * gs2-authzid `a=" {User} "`
>> +	 *
>> +	 * The second part are key value pairs containing host, port and auth as
>> +	 * described in RFC7628.
>> +	 *
>> +	 * https://datatracker.ietf.org/doc/html/rfc5801
>> +	 * https://datatracker.ietf.org/doc/html/rfc7628
>> +	 */
>> +	raw_len = strlen(user) + strlen(access_token) + 20;
>> +	raw = xmallocz(raw_len + 1);
>> +	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
> 
> This looks very fragile. It would be safer to use an strbuf or if there are no embedded nul bytes xstrfmt() and strlen(). This applies to the next patch as well and any others that are building strings with snprintf() or memcpy().

Ok
 
> 
> Also the comment above mentions the host and port but I don't see them here.

Host and port are optional. See section 3.1 here:

https://datatracker.ietf.org/doc/html/rfc7628#section-3.1


Also, please add me to the Cc list. I do not read the mailing list quite often, and saw this in what's cooking.

Thanks
Aditya
