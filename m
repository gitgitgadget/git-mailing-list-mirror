Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011026.outbound.protection.outlook.com [52.103.68.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963B710A1F
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748763168; cv=fail; b=iBPxFpzrwE9mHgM5SBfyMSld2zjfVDQVCRch/OAJcX5OX8Zl7WY7d/9rS9YDYZz0QuqPwDd/fsyIruwhL9ZFpcIAs2p9ZspeUQ4LkurCqKiI1+UFwtssyrxhnwJY+T3MqOfUzJ+8SOLDe44Ikr9DsVMO/Afd5Zgf9swIYKqCBaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748763168; c=relaxed/simple;
	bh=oHpXm+MxDg1qN0gZmRpcL0ljfolpxuc1Rc2xUxHTpGM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZQl58Ysx6LZh3jwEt874N954f3n5knYb1T6rPqHAkg6wfu74u8zwh3DDhY3Ykz059MiSctjL3eJKNnt5aHu68qLfaMaFRYF6XLiSZHy4dtiAp21TxPb/jQDpNUxhjG200GcLP1ke37UoA17Yrocj2NBWILDyp6cRgkmumddE90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hTFss+6K; arc=fail smtp.client-ip=52.103.68.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hTFss+6K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JK5h1PXupEPRMV1aDCdGaktWXWAXpoKv8I6MYaece7+EM2E4VRr9Ux8fkYgjYw4F8vNlnPJuv5DGlcGQ11V4nh87O9wD4YV3lcMHt9BudlHpFytNdaGHxwOQB6Gstl12WfxbvsWqhs+eHdVFRs+TG4fYjL0Kb/8GaFlGrndSTO2VePIXXulj8jWaThq1rT6WJn//M84o2DInFLuoQJzmdynX6JzyyPGFc/TUl9WEvyMMRBpU+z7lpH1LvEIaF8bRoY4cYOuNMdiofaz4sg6N9UnN0cYY/alKLRAPMeFdX6TQC2bp2WQxwKmEs3viKr3a6e3qNeqgdKmXfDxtIV1Srg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pq0TSkiudBaqBQnAU4tH9O7x3ZXO2ZRKV/BddC1fCRk=;
 b=M7TGXsmi6TmUu6vvB/5BNbZbn/rDlK+Hq3kcWGyFLtOUDshshecnnbs/fr3v97NxMgRDL4RAEfX5l8GQKlsxE94cNWNtPQbGyornb7aqpcpxWG5q5Ukl5oXP0A6KATDyZVPB2rw/3D1grBiavTAHbYUl6v00z4yCSehkjXpmWnajQPyNq0wKdeKAzXhnoY5mMZH6rRwhZCkodFa0CAyAOUpZOxeOvkflCYIphccZAag4oP9N7AEh/F7XISEsZZxKA1inxjOD7z2SuO4Rw23xrLGPEf9C1pG4VSPDWbyPpWYMJFQZrztaLAc7IMdqikHPiS/IRxReB0UtLrjFF3B/dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pq0TSkiudBaqBQnAU4tH9O7x3ZXO2ZRKV/BddC1fCRk=;
 b=hTFss+6KzVAdzno7wJw/RQwjt58TCicrEZD5dBWo1rVyxYOuXVhb1KBCfYJ7qfAznMJ+Ldq/7JevCUcm0yUmyRJsfno1Bq2qkkhujvYlT4PWjlF/UYzHzkEckJwk4RDmBxwzlmhHAaV+KNlim2LfDYo/9S3ZAcWXPvqmFiIgYpiQq+1UGrwzAZFjAxYBhgGfCgIQ92MTIMPXhjC7vOj3kkKCOUEK798kgwRUHe3wjCizDYMJSIo/2LOlt25Gt9uw3XZEgTIlniQVYIT5NFGDnWB9Q/RP1VQizdBVgLsfqwK41OncYEyWYjB9nPX9n+4FJoxCcW7ZQueM6S5cryS5kw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF67B3DF79B.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 07:32:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:32:40 +0000
Message-ID:
 <PN3PR01MB9597894F4B4815A27E9BF7E0B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Sun, 1 Jun 2025 13:02:38 +0530
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
X-ClientProxiedBy: BMXPR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <9310c29e-06ef-450c-af94-b24de5ef1369@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF67B3DF79B:EE_
X-MS-Office365-Filtering-Correlation-Id: d5bb7191-3583-4b76-b23a-08dda0de7d6e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|41001999006|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|6090799003|440099028|3412199025|12091999003|56899033;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTBFcWxRYXNqMFFxWkk4bUE5YXJuZTNDRkVZNEtNTkNZL1R3cmxBNlBic1ZW?=
 =?utf-8?B?NWFFbHRjK1l1SU9JK09qOGlCY045aGUyVmFsb2J5QytJTEI2ZU1TT0txaisr?=
 =?utf-8?B?OW16V2NMNFBYb2IydlNTRGhMalZiSmpvS2ROQnJHallRYzlZUjJRTXVYZlhQ?=
 =?utf-8?B?dUhaOUVleFBzSlJlOGtLVlllU2RVMWVENVZHbUw3WW4zSnVZQ0RNbk9CR2kr?=
 =?utf-8?B?aGt4R0U4K3JQaHhna2JONTZzZmdzNTNaVGd6WU10Tmc0d29aY2w1UDRiZ3U0?=
 =?utf-8?B?TWVFNVZRaEkyclJPa3grRmJYOHJHTy9RZWMwajJqaWw4R2dkakRPUHVCeFBF?=
 =?utf-8?B?VWYrRWtJa1RPUXBmQWpGSVE0elRVVW5hZWsxYis2ZldNVERuS3Vvd3Vzais5?=
 =?utf-8?B?N0RwVy9URlRpQldCbTk5RU9VRzM4UTJJL0tkVTJGY3FMd2pZMkdJNStjeWdN?=
 =?utf-8?B?QXhSeEd3TDZKMGlDOG92V3F0WCtWMDB2dWxub3lrWGcxOHMxbm5wS0lKY0ZS?=
 =?utf-8?B?Wk8zVlpxTjFRNUZENDRxd1lBenRPOHBLemg3d1dmV1hqVkE2czU0UExkSkpZ?=
 =?utf-8?B?RnFZTndQeTR1cjJ6Nk1YcHF6RDJUT3I4czU3Y0JpYldFTXVuaERkODF1ekli?=
 =?utf-8?B?Vk1WaXl0bldsaCtGWFovVVpmQ1Q1TVhGNkZHd2VnN0FPdUl1SlV6QzBaU000?=
 =?utf-8?B?SUpDbzd5dUZOb3dSU09valFUOVBpTGdRdTBDSWhmZVhlV1l0WkZmNjNQTzY4?=
 =?utf-8?B?V1JobkVtNUM4elZicERtajhwclI5c1VvbGRXRG5PZHN2RnR5ZWFubDBKbHJK?=
 =?utf-8?B?QW1OVHFkMTRaK0JWWlpVUFFrNUVuU0FZVFB0UG1OWTQ4eWVCV1REeXduTUs5?=
 =?utf-8?B?SjlpZEZQNlhsZEl2UGpPbFc4V0ovaFk5NFpOdUc1enJUQUFHNnMwbnE4V3JS?=
 =?utf-8?B?VDdzdjNHdDFlUURySTJjdldaZzA1bEJ5VmFySkRyTTdud0EwektHSE1xbW01?=
 =?utf-8?B?eHp3U3RRTVd2ejBEbmF6bFZKN0NzbXkrSERnREpsR2lnV0NxUDNTV3JzUWdr?=
 =?utf-8?B?VVhMWXUvK3ZiSGlYdzFHc3FkZEN6bnlJVThvQ09TUkRBUnlNNE1KUU53MGY3?=
 =?utf-8?B?YnJhMWZOY0pSbTc2cmFyZ3czcWt6Z3F0VUJ1TU5CbmtEZU1JVURYUFVFWWM5?=
 =?utf-8?B?OU9ER29SaldxS1d3elZ4a21XQzh5Tmo0ditNSlZZRDRyTUpFdnhiMDJQM0V0?=
 =?utf-8?B?aFNhbitrTDVOR2lHUG80cmNjL09KL0ZoSFljVGxVQ0hPcncvVHZxNkV2Qmsr?=
 =?utf-8?B?TFZkdXduSVhYZG1aZ3V2cTFZc0k4VjRkZysyZW1lN3hrM2g0NjNJZWlmTmdT?=
 =?utf-8?B?Rk95Y1hITi9paUtwTzhTMlNRaFA2YWhxZEU1c1lXT1FpbHU4dDNWWDZVR3Jy?=
 =?utf-8?B?THRLR1dNYkFpQTVwV1dLSGpGUmZKcDFZSGN0WVZCT2d2NDVNSHY0SlRHWm03?=
 =?utf-8?B?bldFZkNCcmYwZnAvYUo0eXRoS2tSRHBuMHlYUUk2anYyQ0w4ZWU4bDJZanBD?=
 =?utf-8?B?eHFSMFYveUlkZzlwYnUvOUs4b2VSVGhSbU5Ea1crQUxQZHpPYnYrWkRyWmZK?=
 =?utf-8?B?OTdQUEsrZzVtT25lSzRZWDZLS3RWUVE9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1NSWUZYdDBQZml2WnJIU25FaTZLeEY1NFR6NkxyQ1hBSE13aGJOcTVyQ3cv?=
 =?utf-8?B?SmRJK0doQnVPU3FqSDV5TWxmVVZVL2owQVd6UUlMSXlRTVhoSWRySW5aZkxp?=
 =?utf-8?B?bXNreDZSSzh2Z3VsNHdRZEZKdHF2SHZSSDY0b2JGOGVPRkx6Y2loUDlBRFc4?=
 =?utf-8?B?bUhiV0xWWmVUdnRYUXlram5oZ0FNMTNjN2ZkSjdxblpjMXdtQmNkbmIvK3ZU?=
 =?utf-8?B?WUFaY1dJREx1VHRQYzdWM1B0S3dOL0w2YWtIdllyMU9yN1U5TTNBcFJzdm5y?=
 =?utf-8?B?bllLck1ESGxjZHhGSWRUN0NieTBMM0U2MHc4S0hvS0FUSVJkQ0F4T3MzSVZU?=
 =?utf-8?B?Qmwxa2QzdjlpOEI3K21DUWI0NXM1cksrT0I0N05jbDR4Q21Sdm5iaTJWRG45?=
 =?utf-8?B?U1FwN2NpSHdDaVJRalY1ZUJsNHczL1Qrd0pnZlhkTUVoT0ErYmVJa3BHS0JW?=
 =?utf-8?B?S3RsSmt6UlFmYXFaNndjdTFGcmJmQ0FwQWVwbGliMi9waUR3b2puTEZwWWJT?=
 =?utf-8?B?MHo2K1VvM1FtWG84Q3p6S20zYTVDMDZ3ZGVzQ00wazdKRG1UcnVxMStQNnZM?=
 =?utf-8?B?bUM2YUYxa3d2TkZDQ1M4cGdqSTRldEsxdnZsMUZHUWV2RVl2dVBVcVJJbkFS?=
 =?utf-8?B?b1lLVUdLZFpEZW0vR1NWRVpwNE1aQUp3cDdxUGFJczl2RGJlQkM0NlhTbHZ3?=
 =?utf-8?B?dEdiU1d1Z1EvbWRtVVJUMWNWMk5FS1EvWitKalVzU1ZnblNFbkFDOEV5S2VZ?=
 =?utf-8?B?eEZ3eEhjMktIcDNqdUZiODg0MHpUT3ZtQ1hBYnpVdEozUURhUHYzSFpqVjgv?=
 =?utf-8?B?VjRtNUowV3VxVXRGbnc2UzhZZUpYVUMvR1l0aVRza0RYNko1amVyU1MxblJn?=
 =?utf-8?B?Q1FSQmxoUkRwYm9OSHBVT1lTc2hqWW5VcTl4ODZhWXFvbmV6eGpWdVRvU3hJ?=
 =?utf-8?B?Mis0aVIwdzZtRElWUUErT2l5UVJUS3VqOTY3Y3dOWE9Qa0NBMGQwTlJKaDRm?=
 =?utf-8?B?OERrMHpzV254QjVnMllMMVVURXgxVjlxbEJuNkVrN2RpOUtMbkJ1eE1PdDNR?=
 =?utf-8?B?QUdmbGE5anMyTFFoTnN3ajJ4b2lJMFVONmU1ak43UG1ZQ2xzOGdPMjNJbWFP?=
 =?utf-8?B?b1pLVnpJaEdGTWUvcllaSWFxUy9TcGV2NVg3bmNaVEQyN1IrLytsM1JQL3ZG?=
 =?utf-8?B?MXJnNmYrWjdwckZ3SWpUMUluWDlVd3drc1hZZlIweFVUNHk3Z3NqMlhEbTRM?=
 =?utf-8?B?alpveDMxcmgyY3c2ZFB2VFFqbEdEKzIyNkZpSXI3YlhpL2pPVC9wUWNFeGZk?=
 =?utf-8?B?TWI3b0YvRVFNMVZkc2loV0ZEbjQ4VGlHQkhmY09nT0hqSWxHaFZ3WDZkY3Zj?=
 =?utf-8?B?RmFrM1p3Tlh2WGw5Wk9CSGRKd0xuOHhFV3FZQm00NVovS1VjNGNUTnhVMXVa?=
 =?utf-8?B?b3FOT214VVJObkVlZkpUSUtTWWgyUEdGNjBRam5xOXBDMlhkYmhrZGpuLys0?=
 =?utf-8?B?M3hCNWk0RVJmeCt0c2VXTUF0RGkrV0lVeVdyak43MW1XNFBhZDdvUGdXdUtU?=
 =?utf-8?B?Z3dlTVBkZXRjYVJVOUc1bGlCbmJaM1liRW5HTmpPaHZscGcwS3lHc0F3UHNF?=
 =?utf-8?B?bmFMVm5Hek9PYzVScUphcG82bG1MZWEvVWdXdG5FY2N1L1JzNHRMNXVUM3hs?=
 =?utf-8?B?cXZ0MTdMWnloanE5MW02YThUU3RxZnVFKzZGSUtJZ1lVUHQwczVpOUI3bTFj?=
 =?utf-8?Q?ZclSwqaLjzVpNgyq74qWgeTf2Z1/95ICmqblBal?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d5bb7191-3583-4b76-b23a-08dda0de7d6e
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:32:40.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF67B3DF79B



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
>   Error Messages
> 
>    - Do not end a single-sentence error message with a full stop.
> 
>    - Do not capitalize the first word, only because it is the first
>      word in the message ("unable to open '%s'", not "Unable to open
>      '%s'"). But "SHA-3 not supported" is fine, because the reason the
>      first word is capitalized is not because it is at the beginning
>      of the sentence, but because the word would be spelled in capital
>      letters even when it appeared in the middle of the sentence.
> 
>> @@ -1053,7 +1053,7 @@ static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
>>         if (ret != strlen(response)) {
>>                 free(response);
>> -               return error("IMAP error: sending response failed");
>> +               return error("IMAP error: sending CRAM-MD5 response failed");
>>         }
> 
> Providing more context in the error message, as done here, seems welcome.

Hmm, ok
