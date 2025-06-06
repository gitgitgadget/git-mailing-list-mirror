Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010001.outbound.protection.outlook.com [52.103.67.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28C23A6
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749180536; cv=fail; b=uXx/NgRAC5m5Xqcv4T/Inet1tVRDjU9x3tB6Z7oF+qNLL1DylhFi3oBlmWLdlivX9i4JBl9YVvOA1xUNVek+PYyhkXu/fI3yyyJavCAmzQmZstoVEp0wkXyqmBbwpfI3oII7KexvEzbAW+FFVFlfgT7OK24xShdw1RfaF65Xnys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749180536; c=relaxed/simple;
	bh=4rQLfmKnlLDypcGMdYQdgyeUePthwzTrFW2MxqTb8UU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=IW8Dx1cH1rpq+MVTifNVe5ZxYaFhI4wZmk5g3yC0z5yb4AeBhgLQ8QwgcDrut6l26zH94Vp512N34kLYGQaFGGaSddEdeegGDSr9ZN6Gg1rR7W4MbXRPnUKlZoaxPvwda92Z5Rrvc4RqfNnIj9Bd6pcfSBBPzuAnbubxXTTtUoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WaCn2amC; arc=fail smtp.client-ip=52.103.67.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WaCn2amC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w7L1mk9BavEZqYjAQHCROO3b4825bUqTHdKs+gpCfBoY7FOAz+4Q1H1751n57XGSwwJEjSmbLrKcy57i84ZyTA1qpuAEIYjeyj/3CgMdAmuRZtjdONV5kiuCHwFfry0eKsf103foZzBXu1vWJVPdmxRdAw5dALID+MWNgMmcB2jlHtww3nZvlD/yOyVSqz5d068zyALNqIpCQ1XyL0JMi8vePwXDIcRpMsiuD+m75wvJTk+K2EY1jhaisrbJt/f2EPZSZzjKr5o15d1rpwv2iXE0+kfu4YChgHFxro/ZYk2575Du+o8DqPWcTeX8it4ZgvDxBpWd9OBkAwuRfPafbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaJZ4wn93T4BFRUMS49qStlSHKpSmm4vWAc5nh8l9zg=;
 b=rfS5FgWjOa9SSJYZvBwy8VHvuc2yzAFWFO312iHjpr05Q0vfrVQhondvh4ysfI4T7B2WA7tL6Ie+owko1PAeZSj3iH4SwReG2EhaFPm2Bp7NlZhgzt0UJJuVXgIZWtfuerVEygYlgF6a3Gg0zwxc3Z0a5WG7gnBfdsRc3XkwLR5lKd+6w+5zOLXqH9qCyBnMa8avK97S9ULggNeu8aroPjFbtOGbgzyNC4wGLsF0lijDFIGPWtN53wVp5jrnYig7SLzU2ia1fANTmX1jaIrMu7JikSyEpf2T6QOEumQNJ5YAxJFvb3WyEhFUDZ/zFLCi4pFBLD/182AkyilgP9dPFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaJZ4wn93T4BFRUMS49qStlSHKpSmm4vWAc5nh8l9zg=;
 b=WaCn2amCZCqMKRfKGsIi/9CRp+gyVBoKkGzD8nFNFnZviRy5ik0ZVE5BD7W1Jaz84eHPkm7BM9sf2jbCPqcJDoOoxf/T3VA885NPdiI97Hb64AUepUOtqFdm7X1lDGuupMBvb+wbkAr+PNt7+B0LgDaxKGIahOa82aMwbaWGub0a66ZS8Be6zNXZKbrguwInNAqByEHtDflEs1aoh1XwNSzcx5lSg0ou5kpXxkuLLwQ7condXjMxCoJcSRF92YK2mhwESKW4FKKMeEUSZpIVJ76nFBU/w6s9tz3WsDvQJ8jYbsIboIHZiJihOkErkNbOpYlep1374yjWCL7jd3uYkw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5947.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:67::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 03:28:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 03:28:49 +0000
Date: Fri, 06 Jun 2025 08:58:11 +0530
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Jeff King <peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v13_02/10=5D_imap-send=3A_add?=
 =?US-ASCII?Q?_support_for_OAuth2=2E0_authentication?=
User-Agent: Thunderbird for Android
In-Reply-To: <xmqqy0u66n46.fsf@gitster.g>
References: <cover.1749112640.git.gargaditya08@live.com> <0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com> <xmqqy0u687ww.fsf@gitster.g> <PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <xmqqy0u66n46.fsf@gitster.g>
Message-ID:
 <PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PN4PR01CA0045.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::11) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <52BE1079-3EB5-4108-971E-BD2F58112117@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: 9110c42c-7037-4ff8-bea7-08dda4aa3fb3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|15080799009|8060799009|7092599006|8022599003|5072599009|461199028|6090799003|3412199025|440099028|19111999003|12091999003|34005399003|10035399007|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmdlYjZQUXZSRHVCSW9zRzZXNDRJTVB2a3RzSXpqanJFWE1lSC8zYy95SEYv?=
 =?utf-8?B?Zm9aWTJxR3NzMFJmcS9uOHdnUTRQUUJsK0d6dDZ3WVFxQ2Q3TVprVmxHN0pm?=
 =?utf-8?B?UXAzMlpycWVLb3V1eXFFeVp0ZUQxZmtPNlA4YkJtR04rMXNZTGJwMHNLbm9r?=
 =?utf-8?B?NjgzcE1CdnJ0bWlrSkRhK0dHa0lER2NDR25CcVd2Sm9ReDZoVkNIdDQrQUly?=
 =?utf-8?B?SWZyR2tKOXA1TTNHY3gxT2JNeSthdnNQd2I2WkJsYzJRclZFWkJoNHBDQkIx?=
 =?utf-8?B?UXhSZVpQM25URkNpWTZlY2dqSjZRRUZjZXZmbUJWWDhjek9URUFTQTREQi8w?=
 =?utf-8?B?TVdxL2UrOWJoU2hiMmxWYkgrTlh4YXFUUkN0OEdhYVNDejdUMFlvb1VtWHdD?=
 =?utf-8?B?SjUyRkNtMFkzTkN0UUduTzlIN2RRZnJla05MU25kb0lvSkp6eWt4RXpJYVBz?=
 =?utf-8?B?OEltVzNDZmh5MlMyVFQ4ZFNKZWZmSGpIZDFJejhuN0JSRy9UUkRIL05ITGZK?=
 =?utf-8?B?U21hWVpDaEM0bVRoTkg4alpuS1FlbTFJWllEODhBRUEzbDJmckszTlNUNlpM?=
 =?utf-8?B?UVRuSVJHQVVBNEhHeVU2eHVLSGhhb3Z1MnRUM0JML2d5R21iYnFJR21zQnQ4?=
 =?utf-8?B?dUdmRW5vL3VSQktmL0hXeUE2b2ZZOVUyS1d4Tk1XZlhFc2dWR2llMlBiVGpM?=
 =?utf-8?B?eUN6T2N5R3BicXJxZVRRUzBBREVaTVViSXI5NXFlL0pnOEF1d01ockZKMWc5?=
 =?utf-8?B?bEtjMEVvRHhHU0ZyMGRhYkRaeGJNa1pHcGZFK3ZURFVTQVF6YjF1YllPQk9E?=
 =?utf-8?B?OVJyQ01nYVI5aTFzeW52Qk5GK0JLUFRuMHFHWlc3UGNFRVhReWpRRTV2Tm1l?=
 =?utf-8?B?bGJVdnlRZTBFWC9EVzJ0UGxtbHBLRWVUS0tWTTdNV3FyLzV3UGlXbWE4RnFY?=
 =?utf-8?B?Z2pBY1huR0RtVkgvWEZnbXo0aTlhM2V1T0tRcm1pZE5hdXd1c0VoODQ3bUNV?=
 =?utf-8?B?VlhUek1RemE1a09uM0dNQlVTaks5TTZNZG9lZUV0R0N3bHYxNDFJeU1yUkE0?=
 =?utf-8?B?aVVLcHU4Q3BCUDhnN2FPeW05R1dTYWxmSVU0Q1JxN1BzMTJ5b0xGL2FVMytx?=
 =?utf-8?B?eGlkWVpWM1NWNlA0VWIrM2RoU2p3MzQ4cTBmZWNRQWkwMlpkS1hvL2xDZXJG?=
 =?utf-8?B?aGRnRDJENmUvTHNOS2Zzb0M3Mng3TmVmKzZDd3NlY0xLdVlqU2NaVDBSK0Yy?=
 =?utf-8?B?V3grYmhQWjJZU1g2T3Z3V0x6MGwveGpzOVRQNmlxaEp3RStaT2kxWXYvWGpx?=
 =?utf-8?B?bnB0ZGJzZUw1SkQxOS9SUWZLQ3JSSHVyWWtQWENmYmpVNXFtZVB4Q1U2NGI4?=
 =?utf-8?B?SlR5c1pBT1QvYlVOL0xwSklPa2tNNkNVUkVUL0pQRUJLLzdmTnhENHAxeHVv?=
 =?utf-8?B?Z2gwMEp5aDBLUVJzTExNVnBqNWtUZ1hPaVVicjBlcUVKOGphTkI5Q2lLZ2d1?=
 =?utf-8?B?ZE9nYWc2UWpUdjFxVWZVcTlaeEw0QzhISC8yQ3Z5S1lNVHV3RVVVa3hzam9s?=
 =?utf-8?B?Y0h3SG9OMjE0MzNuWFp0cTNEdlY4YVA1N2dVRTRPa1V0dmo3QkZiT0JvUUZx?=
 =?utf-8?B?c3B1YSs1UkdaSVhNN0ZORnludHo3UDdvcVhFcnhJTi9oNHozM083UkZyM1VF?=
 =?utf-8?B?dHVBU1EwWkIrajcvY1B5UjhDYy9nUHRkOENyenJxdE1pSUx3QUtnbTJoZk02?=
 =?utf-8?B?U3FFcmkrbUxWUVVmK1ZHQ0xJZ0RaOTdkOVlDb3dPTDJjL0hweTN4QXhWZDZE?=
 =?utf-8?B?TGlQMmFRTGFVeDZ2Mm9rZW5JcEloY2tULzBsUGkxWEhhdkZHME5yZU80UlFo?=
 =?utf-8?Q?HFU59Em0kyAAz?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mjl0Q2NvY1ZRUmdibTZYY282aDNaT2dLeDNhOUxxcTkzUkh2K1NOcHpoRFV0?=
 =?utf-8?B?SmlHUlhyOERkeDd1QTFXOWpUVU5nWE1obXVCNWE3ZTJGbmVESnQxanVxRmlB?=
 =?utf-8?B?NDZseU9kT1ltSVBxKzBrWkVJeEw3TzRIWjIydFNQcE50QWJINHBkcnNNRGE2?=
 =?utf-8?B?R0RCaXRDZ0xNSmNEelM3RzJJOTN5UU1mOHNKKzlOSlJ1b1pjK09jL3dRU3c0?=
 =?utf-8?B?VmltcGw3TzE5RlpkdEE5VkVwS3EzQ0wvYjZTa1AyTWJVZUlJZlV5eHNPWTRx?=
 =?utf-8?B?ckVBOC91ZkllNm1NNWI0S0VzZlpzeTMrUkN0cjRzbUtOYS9jbWZUblF1VHBC?=
 =?utf-8?B?V29Lalo3YUx2ZUVkSVhGaXBUd1BpZlc1MFpaamplVVpYSGJXWjZoTTQ1Rk13?=
 =?utf-8?B?S0RyNmZXMTBaZHdnR2xIOFlneG0rcDB4Y29LbjJ6NUdNZTNBL3F1TDg1S0No?=
 =?utf-8?B?dzJZcjMrOVYyYTJnWnVQRVhVUmJUelhmNDFKdlpSaytSYVJHN0VYNzZ0bHZq?=
 =?utf-8?B?NkVLM1BndStvSmM2TDVGSVZkS2R5SFFiZXB4SFdicU1YT2ZjdmcycFBTZmg0?=
 =?utf-8?B?ZWhYMWlCdEtVL3pUd0xrclk0QnNTeXJaM0xIUzVoV1B0NnBDL2c1R2R5RWFU?=
 =?utf-8?B?ZFMycGczSHB2MFFFWTRNY1FXSG1qbE9Sb0JjSTA1TlpVd09Tc242VEo3SFBz?=
 =?utf-8?B?K3ZqZ2hoRFg4c1ZDNC9pZGNGVFB3SW1BN1RGR3BiV0FkWHJqdldZYXdPRWpM?=
 =?utf-8?B?UFd1WFYvTUdBbmozZDhrbVluOWlSY2RIQkk5V2R4TTk1c0Q0cDgvR2lDbnc1?=
 =?utf-8?B?MGpWN2lXRzQ1RG5pQkVtVkEvSTd6MDZNajl4ZlEyWGQzQ0FwK2d3N1ZEVi9N?=
 =?utf-8?B?ZFVNSmh1ZkhndERGblVzb21xQTZydXZxTTFhc05yOSswUjUwNXd5alZRUDRZ?=
 =?utf-8?B?OE9vaFVBME1nNHVTRC9vZkFRV1ZwK3d0M3JYYXN4aWkwV3I5eE0yMms1Y05J?=
 =?utf-8?B?VW92ZkxsZVc0OFlTUDNBeTFmczYzWDRLc3FlbFJsZjJNNmRSaTVVRWN4aXVZ?=
 =?utf-8?B?UVhlWkdIdC9ma3pkYnc1UEJQcmI4S1IvSUJDWnMvSmFFM28wMjJ1cmplRHgr?=
 =?utf-8?B?S0ZoNnN6ekF0S084clRKcVBhdTN2MG9JU2F6NlZ6L1k0K0RQQjVhU2U2ZHlt?=
 =?utf-8?B?dURKN05VODB0eWI1R0VsT2h0eXg0OERDeTlaYW5MNFRIS3EyQVB0QzhEUHZC?=
 =?utf-8?B?ZXNSdkZEdDVpUjd1N01SKzg5eGFIdnZJdU5lS2V3Nk95VGM1OGs1andqbHkw?=
 =?utf-8?B?K3FqNlRQeGdxWEtBMUNlc0ZIcGsrdllFYkd1WVhzT2dFSmJVZFNGNVNwVlNx?=
 =?utf-8?B?ZkxQU2o5eG5mTW5mKzRDTWZJemorKy90YmhwUjVDUkd2VGRQRExoZitHK2hG?=
 =?utf-8?B?SDl3OXJWclVuTHhvcEwrU3B5bkZ4Q3ZBZGpJTXkzVkliVCtHU2wzTmhQL21U?=
 =?utf-8?B?TitlQSszV2xEZVZMZ0lkOENiM01EeVJsSDdSeFdpVUVjUGVkTlR4dEVYYWd2?=
 =?utf-8?B?eXVpV1NxNkViMVYzTTFtS0trUnJXSmRKOUNJQjBnQklWNHVLa2xmeEhiNnZN?=
 =?utf-8?B?STNnbXpNbVBzMmNJMkg1dUVwWkdieTI0NCtPLzRONVc2QVFra3hLbDd6RTJV?=
 =?utf-8?B?Wm9mV3E0eEZHRXoyTUdVcmEvTEtnUXcwdXJnbVNmWDRMMDBBQi9IWC9QelYr?=
 =?utf-8?Q?DHOD0PEz+8rQznuaPQ=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9110c42c-7037-4ff8-bea7-08dda4aa3fb3
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 03:28:49.7072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5947



On 6 June 2025 12:18:25=E2=80=AFam IST, Junio C Hamano <gitster@pobox.com> =
wrote:
>Aditya Garg <gargaditya08@live.com> writes:
>
>> Might look less ugly, but will result in a compiler warning that this wi=
ll always
>> be true if compiled with NO_OPENSSL. If you are fine with that, good. El=
se tbh
>> I am out of ideas :(.
>
>Sounds like a good place to use NOT_CONSTANT(), it seems?
>
>	if (NOT_CONSTANT(!auth_oauthbearer)) {
>		... skip the thing ...
>	}
>
>

Ok

>>>>  	server_fill_credential(srvc, cred);
>>>>  	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
>>>> -	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>>>> +
>>>> +	if (!srvc->auth_method ||
>>>> +	    (strcmp(srvc->auth_method, "XOAUTH2") &&
>>>> +	    strcmp(srvc->auth_method, "OAUTHBEARER")))
>>>> +		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>>>
>>>Can we clarify this part, possibly with an in-code comment?
>>>
>>>"Unless XOAUTH2 or OAUTHBEARER, use the password" sounds a bit
>>>strange.  What about methods other than these two that are not a
>>>plain simple password authentication?  Will we remember extending
>>>this code when we add yet another one to exclude it like XOAUTH2 and
>>>OAUTHBEARER are excluded with this patch?
>
>> Let me answer this first. CURLOPT_PASSWORD is for plain or login type
>> authentication, and if srvc->auth_method is not defined, curl's behaviou=
r
>> defaults to them.
>
>Which makes it sound like if (!srvc->auth_method) is enough?
>

No. If the user specifies PLAIN or LOGIN then it's not enough.

>> OAUTHBEARER and XOAUTH2 use CURLOPT_XOAUTH2_BEARER
>> in curl, which can use either of them based on what server says.
>
>That is what we can read from the updated code.
>
>The question is what happens when the user sets srvc->auth_method to
>something other than NULL (unused---use plain password), "XOAUTH2"
>or "OAUTHBEARER".
>
>If the answer to that question is ...
>
>> Other auth methods
>> are not supported yet in this code, and this is the reason CRAM_MD5 is s=
upported
>> by only OpenSSL.
>
>... "with srvc->auth_method set to other methods like CRAM_MD5, the
>control would never enter this codepath, as they are implemented
>elsewhere", then I think it would make more sense to write the above
>like this:
>
>	if (!srvc->auth_method)
>		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>	else if (strcmp(srvc->auth_method, "XOAUTH2") &&
>		 strcmp(srvc->auth_method, "OAUTHBEARER"))
>		BUG("we only support XOAUTH2 and OAUTHBEARER in this codepath");
>

We can implement this, but:

1. It will fail if user specifies PLAIN or LOGIN as auth method.

2. We have this in the code as well:

	if (srvc->auth_method) {
		struct strbuf auth =3D STRBUF_INIT;
		strbuf_addstr(&auth, "AUTH=3D");
		strbuf_addstr(&auth, srvc->auth_method);
		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
		strbuf_release(&auth);
	}

Which basically means that if a user specifies an auth method,
curl will try to use SMTP AUTH command with that method.
So ideally, this should have worked for OAUTHBEAER and XOAUTH2

But the problem with that would be a) we would need to format
the access token as per the specifications of these mechanisms.
and b) curl simply says these methods are not supported when
we try with that.

I filed a bug report regarding this and they were not really clear
on whether CURLOPT_LOGIN_OPTIONS is meant for PLAIN only or should work lik=
e this with other methods too.

But, the docs indicate it's for PLAIN auth only.

So, considering the fact that the original code for imap-send
was setting CURLOPT_LOGIN_OPTIONS
unconditionally and
was running the AUTH command even if auth was set to CRAM-MD5
or whatever, I just preferred to not change that behaviour since I
may cause some regression. There is a tiny possibility that CRAM-MD5
may work, but I don't really have any free SMTP server which uses
that method itself.

In short, just to be very safe here, I decided to not mingle with the
logic much and simple decided to use a seperate tested logic
for OAuth2.0 and let the same logic be used for rest cases.

Therefore, the previous logic said:

"Set CURLOPT_LOGIN_OPTIONS irrespective of whether there is
an auth method specified or not."

Now it says

"Set CURLOPT_LOGIN_OPTIONS irrespective of whether there is
an auth method specified or not, unless it's OAuth2.0, where we
use a different curl API"


The bug report I filed with curl for reference:

https://github.com/curl/curl/issues/17420


>Or the code is not protecting this code path so control can reach
>with auth_method set to CRAM_MD5 here (e.g. when built without
>OpenSSL)?  If so, replace BUG("message") with die(_("message"))
>above.
>
>On the other hand, if you are trying to fall back to plain password
>when other unhandled methods are specified, I would expect that the
>code to read more like:
>
>	if (srvc->auth_method &&
>            (!strcmp(srvc->auth_method, "XOAUTH2") ||
>             !strcmp(srvc->auth_method, "OAUTHBEARER")))
>		;
>	else {
>		if (srvc->auth_method)
>			warning("auth method %s not supported,
>			         falling back to plain password",
>                                srvc->auth_method);
>		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
>	}
>
>I cannot quite tell which one you meant, but I am guessing that the
>former is the case from your explanation.
>
>Thanks.
