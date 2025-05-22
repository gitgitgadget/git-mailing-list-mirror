Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080D51B4254
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938531; cv=fail; b=BbHa22e4wrx7is4jk7C0/LqnH+bnWeGDoz937gDHKEHz5UlL5ZKggoqAk6Md5V4oDG9eh5H+UuQtrcmCTj5VyT1jRThUhkqk46e8yjI0HnwfcJwg00bOvF6UGLUJbKvKB0oFycf6aFtf1CoomJKwr5RRVo3q1u9PCSODLCDUSGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938531; c=relaxed/simple;
	bh=QVoOaC1JHOUhkt8bv39talFYcTFnc81REYF31BR2RWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hfe0LJaVjRiCQxwJtdSgwUanjEMHYNp2UrnSg8suTt2TOCcFG7SN+otoW6aIq+/OIr5pohLBlia1ucHDcFgngrEoo+lQhOhSyO9FKs1LQn7HJJjJjcYDlkjpD8qGTJo7uHvpe0cfMQnkdQTK/QmPnUsBsE429eo/Tl6NrGBPw2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YiKfVGLI; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YiKfVGLI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P5aWRJxs13rHWuc6TG1zu2hvTxHhdZ4A30/3347RDVNIvvx/vER10pj9PhGQ+Y7hNPsM0bzdwpQObR8PvG8JsaOmv+Di1UU1QqUWZkZtJBDqU4ZlZbfnG7tyfAgyFmjV0xjKR0k8zVHvfttzhA2zxi8c0viI2tRKDbiHGF1wLa4FCuVIiLNNb6neAB5tbO3RgxNbcwrnBhHS4lGs7Q/pM2FXVi5fylQvUt3h1EVCeD8/4L6EQ1CqhrQ0Cbdn+yRRYPG0b+O5mkazUzRNGPr0zOo4BUAah1FETjzVL/GYjGXZkVeYrc3YY7RJHD6Tj9pcsF1BZjo+EAGQ2n2l933+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3Ftknr1giLiYqgdPGy7f6XsH54XeDWjJmFkc+xu1eU=;
 b=oWtpss1Jq5LMBwDMT5ovDa0c+qaeNe92kJZDsEB9BtDDy62lS5Tm9QbWRbtatUeIllBVYIq7O5IX0HPg9jADqe76+JWhV0yGWIZHXln4BpxsV8X+6k1cztePSVzv1Lo5xxrF42mR84e9yGxf3LpTgHqSU1uqIkTe6GJM/xQYeFp5S9mzJ52/xwlIL+1yFqpENcMoF1YZ6cKStQmx6v3Rmy9hLr8NY4K6T621nOD5PmM9GJT3aL1Fgt7/c04Srqqts84mCCn6i0gXQ2ZjGOkwE8/OM5D/B7Yti7ZDBxTqojEbG1vEqVFPRgsecorYGInptQxPf3BJeHdczoad16z+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3Ftknr1giLiYqgdPGy7f6XsH54XeDWjJmFkc+xu1eU=;
 b=YiKfVGLIHXtMFkQIZKLIOakwCw2FG2IqMcR5L4HqrB9ELedJKhxshMYxaCBDtVPunA9kPzFyIKPUI60jsVCXhnMtMAG1sY2Ml4yryODOqbLIMuD/bGxicgVUA07jdxpB3YXOVmO58ax6afXIlOS0XItJUFqlHqtw6HjZW5v3fkFLK2KEFstAyPyXbSfGujP9VYlPUbdvt9qbtye+XGD0JDaGcqUdJbAUSEfpAqBlY59SFApwFaDx1aWhe6x8jDawOkOATAx3XNW6mjIKp8B0lZSJhFg/9aPpqJWWTAuRvh9NLhguJbsIdZ4UMWDMU8KLsz86q7QwP0s0XNgPcuEGsQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB10938.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:292::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 18:28:45 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 18:28:45 +0000
Message-ID:
 <PN3PR01MB9597F1026B3ED4A0953FC9DFB899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Thu, 22 May 2025 23:58:42 +0530
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
 <PN3PR01MB95971AADEF1C768E58187419B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <CAPig+cTJmeczzUcGrn98svMfK7aODYS-Ha8FxJHuKU2c2+R-FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <fc8c8934-3df4-4342-8114-41dcbfc7477d@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNZPR01MB10938:EE_
X-MS-Office365-Filtering-Correlation-Id: b7588df0-5fcf-4ba5-d7b7-08dd995e7c46
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|461199028|15080799009|7092599006|8060799009|41001999006|19110799006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U3laem5WcXk0UlZ5aDJUdFBpV0k5VkM1enMwUXNUS2JBVGhOelpGRCtaZ1dV?=
 =?utf-8?B?S3BWMG9uNDlJYTFScHNQbXZ3MENVZTA2NER1dEpxUkprSXN4OGpFV3p6NUpB?=
 =?utf-8?B?Ym52cHlIcDNLV0wrMlcyRlFMSTRNNlZNRGRsTHJYdnpNWUlpOWNvbnphUE02?=
 =?utf-8?B?Tm9BSkVEVlYyVnR5NUw3ZTR5YXplRDVaNnVSck96MkFQYnJnWmppK1BRdVpY?=
 =?utf-8?B?R1JETHlQRGI5RVJWU1pFbXY0VXNkTXJFTGhjZzdzVitCdXdid0FtVHcvTnZR?=
 =?utf-8?B?aGN1YTVUQlJienFMNmhMZE1HMXp5QzJQb1pYVXZaaXhGL3g5MENLeFVOSEkz?=
 =?utf-8?B?QW9kSnFQRUhJTXNGL0lvc1RZWFV0VEM1ZU83UWE2YnNSRHIrTmdndGZkTnFQ?=
 =?utf-8?B?dDZyQmxXYnoxZ0NpOGxpRk5ETERRUkEzUGhNM1FoekVPRDgxTTZGZTNnVXhV?=
 =?utf-8?B?d3lrbzIxZ08xWU95UTFjblg5eUd3dEt0eUhvbnBkbTVCWGtYdysxUTFtVWh4?=
 =?utf-8?B?a2VyUnQ0S1B3d0dPMmxUcDlmdldyYW5WVWc2bXNpQXo5ekpkU1lROE9sMlhm?=
 =?utf-8?B?VjBGSkduQjM0Vi80c3JmVDhXVTVrdXFRNlJtZldtdC9EK2RUeUpKdEdnb1Jn?=
 =?utf-8?B?Snk4UVNWdU90cU5vSHNUY3lVSkNFMTZiYlB0b084OW5zaXFFYkdUcmswYXJ0?=
 =?utf-8?B?eG9LQkt2bWUvcUlhcjlvT2VocjU3TkNSRk93U3lkYm5qNzBzV3R5UUdoK04r?=
 =?utf-8?B?bU1yZlVMa2lIRFJ0YjNGV1dnQTNKZ1g5T3QrYjJneTMwbkxUS0ZXTWs0YVZn?=
 =?utf-8?B?TEZGZXEvTy9qdzhnVWJDNkh4d3RNWGx4Yml1clVGVGg5N1lCMURmMTdaTE54?=
 =?utf-8?B?NzFkQjVGN1U3ZW9XWC92Zk1lNVRhUFNRUG10Q1FraW5VU0FCQjdjNGk4eWRB?=
 =?utf-8?B?RkUyTWQ2YVdmQnpkLzdsbXJucmpRQkdxK0toQy9BS2xmem1obC9KZyt6T0Yz?=
 =?utf-8?B?RzRnTGUraHk3VTNTOHBXQnVDd2FxYlBNNGtTOVpCSllKYi9sMlhUSGFuTFRj?=
 =?utf-8?B?Z28vSzVOUFRhbjd1MU04cGpQLzBTd0N6dCtUbjZCaTlCTnZhcE5qaE5NZkpv?=
 =?utf-8?B?eFRuVEZFZTJsN0x4Wm10L28zWE5CT3lEWW5vVDR4aklXSFArRlhZMW52VXRW?=
 =?utf-8?B?ZGw2NW8ydGtJS1A0bWdkZ0w5N0tIeVJyYlg5VTRMSWJ3WERLa1U4NTdmRTNx?=
 =?utf-8?B?d2hhWVZxeHdVZW9NeE5DRWFLS0pHTERNMnFxb2s2WlJKTUQ5RWhKWllZb0hG?=
 =?utf-8?B?TDkwd1E5TFdUenErVjFobmlOUEoxUE0rYSsyMnBVZnROYWhrV2w2d2hiQUFG?=
 =?utf-8?B?QU9vdWRZY3Z3ZW9XMGt0ZVhlb1phRXJ0TWNLSVFoNlkrS01vL0xVZjlQUlBX?=
 =?utf-8?B?WHZFQ2EybGRQcXVNWlFLUXpnc3c5NFZZNG5TejcvVGFEemJ3bEl6TUxxdGxR?=
 =?utf-8?B?YldyR1A3ZmlmVlo0eG1RazVRRlpLdjJwVXdoeElZODl0bGNJQS9UYzloL25J?=
 =?utf-8?B?K3dkUWprZTd6WThrcGo4bHdkQkVHNFBBSWllN2llUmNNa05vV1ZxSlVZWVpE?=
 =?utf-8?B?RkxCbFdnVDZ3UHlIaHYxNHkvRDhNMVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVRSUQ3RVorZHo4dXEzZG9RN2pmSG9VTXByb3FSVHl4YVk4WnlrUExRODM0?=
 =?utf-8?B?cjh6VEltWGRUbW80UHB2UzJ3THdJVHBKMys0MlhGTnVBTE83VE1WaEdkbkhQ?=
 =?utf-8?B?cm1LWk02cjY3RUVpa1FxeUNDTnJIOVhTR2puUHFzbTVabmh0ZW1BRi9WWmlX?=
 =?utf-8?B?RFZFd1p1VnhsMExBY3R6d3B5L0FIb1F0Q0ZtdXhCVkltY3NCeUszUDdtektI?=
 =?utf-8?B?NE43OVF6bzdkWmY0Y0xYQUxtNEwyWlpHOGZWejNlM3l2VWhJMXNCUEFWZWVP?=
 =?utf-8?B?ZDZ4UVRwbzFRV2hMOUlzMUVITkdjMVZtY2ZXckVHaUUrL3lqR2IrdU05bVhl?=
 =?utf-8?B?V2VIZG5OR1V0dTU4NUloR2QvcGJMTEVtSHo5MEErekNsMGJPQ1BRM0RjQytF?=
 =?utf-8?B?WnJQU1lLMjFyblRRd09wQm9yZUtVTmdENzA1emRmbVdjdE9hRW9MUmN2UVdp?=
 =?utf-8?B?SWMxV1AwbjB0WWd5czJpU0o3NkFScWZOdGtCdGpWMDdmLy92K3luc2JnTThE?=
 =?utf-8?B?dEkveU1XWXFQR3lNYUxPQnpPZUN1QkoxSUh4RGZuaGxyMFRQTUV6ZHVhWmdw?=
 =?utf-8?B?NU9UWnlWOWJxTTJmWXZuM3V5TXQzZFREL3FiUDJSditleEcxWmlDR3Z5UzJw?=
 =?utf-8?B?bzQzeGlVamVCOHpBbUhGQmx6bHNJQUJ2T1d0Z2gzeEdjeHJnbHVtck02YS95?=
 =?utf-8?B?SzNVV29JTWVEcWt0VjMwMnhyMjRKaTNSdmxKcFQ1TEd1cXdzek96WnByeE01?=
 =?utf-8?B?QzNvczhXT1dNbFNRNnJEZ2tNNEwxZ0NMTU5mM1I2RzJuaDdrVUZza2pZcnU0?=
 =?utf-8?B?bTczeEIzUm5BTnVmSmt3NFlXOGpWZnRpT0o0VmZYQTFOQjE0Q1EyWm1pb3l4?=
 =?utf-8?B?YjIxbVRpcmJhbkMvak02NThMVys5Y28rd0JlR2ViQVRxckhveThzVW9zS0Jy?=
 =?utf-8?B?cVR5M3g2eGtUbHh3YjdJQVZwMktLeWpXcHRvMlV0ZFQ5VmlrdmlhS2Q3UGh3?=
 =?utf-8?B?WXJBS0xrTnlzblNpQmwvdUk0eXdrc1Q4cG1KZGFOWTNpZkV5eTh1eUlpQkpW?=
 =?utf-8?B?MXJ6N05OY3pRRll0QVZiL1B1TzJlb0pXNWtZbzJySUlxWFVRZ2dqRFdVYVcr?=
 =?utf-8?B?TFpTeXlZZ2JsQVRVQmN6OHRDeGlUbWhqZzFpamwvOTRaMG9pekhPWEJWTEhv?=
 =?utf-8?B?ZHZ0Z1VZT0JMd2NaSjdjQzFVNDhCUm4zcTNxVGYxNGljNnBBeDRmcjlDMTM3?=
 =?utf-8?B?SjF0Y1ZtajlsUXUvYlBiUkZiRjVHb0RoSUx1UDB5UWJOaVZFSU5TZ2NhSEZz?=
 =?utf-8?B?c1pwN1NMWEF5ZGJjQ2UrMEVmNFFQUXQrMjBFdFFtaGhZbExWVk5xc3MreEJ5?=
 =?utf-8?B?OVJMdTZWcGUrN2ZiWUNjMmVPOEMweTI5MkcwaGphY3IvSVZTRFBzY2JtRTNF?=
 =?utf-8?B?SlhqRk4yU0paMFRTR2h0bGRZb2Y5eldzMGdPTHlsc3J6bFhrazgzKzdEa3A2?=
 =?utf-8?B?VjRIa2FNUlJBWjIxWG9xT3RtU2tPalhkMjBiMUZrc0NuNEFUdUFqZmpHcHRt?=
 =?utf-8?B?dVE4dlRCNy9WNWtCY0h4Y1hpSHZnVUtKNVUrTUFrK2RYZHFnODJEMmFBWk1M?=
 =?utf-8?B?bFhvblNPUVFWaklaYmN3UWRkZStzVmJLRU4rNjluQVo4UVFzR1JUTGJXR2dV?=
 =?utf-8?B?QVJJdmdLaERPS1hYTmNZeU5EOXRiVjlxS1g5UFEyMDR3UFlwSXVub0V0enpo?=
 =?utf-8?Q?XU2aG3tnkf+4twyDcI=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b7588df0-5fcf-4ba5-d7b7-08dd995e7c46
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 18:28:44.9656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB10938



On 22-05-2025 11:55 pm, Eric Sunshine wrote:
> On Thu, May 22, 2025 at 2:21 PM Aditya Garg <gargaditya08@live.com> wrote:
>> On 22-05-2025 11:30 pm, Eric Sunshine wrote:
>>> Squinting at the code a bit more, am I correct in thinking that
>>> 6d1f198f34 missed a case and that the function is still leaking
>>> `cfg->host` in the "imap.host" conditional? I haven't traced the code
>>> or all the callers, but I wonder if server_fill_credential() in the
>>> same file may also be leaky. In any event, the `cfg->host` and the
>>> possible server_fill_credential() leaks are outside the scope of this
>>> bug-fix patch.
>>
>> Not sure about server_fill_credential(), but I think this is also
>> a potential memory leak
> 
> Agreed.
> 
>> static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
>> {
>>         int ret;
>>         char *response;
>>
>>         response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
>>
>>         ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
>>         if (ret != strlen(response))
>> +               free(response); // fix for the leak
>>                 return error("IMAP error: sending response failed");
>>
>>         free(response);
>>
>>         return 0;
>> }
> 
> It's subjective, but I would probably fix this a little bit
> differently and (to my mind) more simply:
> 
>     response = cram(prompt, ctx->cfg->user, ctx->cfg->pass);
> 
>     ret = socket_write(&ctx->imap->buf.sock, response, strlen(response));
>     free(response);
>     if (ret != strlen(response))
>         return error("IMAP error: sending response failed");
>     return 0;

Looks equally good. Such minor fixes can be included in this series.

