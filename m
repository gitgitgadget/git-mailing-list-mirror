Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB92BFC8C
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940669; cv=fail; b=ODpfMt5WvKDSv6ED+/WQ7OWQS3WMn+nHFxhwhrhvPKDsD+53XTD09apJY52b3LU+GPdxhTYWhA6pNPRmzp/vgeFZgQuBuYJ94DB954o/d8f7Du01vfZ3E43sVmAxgiLRsc8vRY69GcqNSlr6tG2uLBMxNg9MBsRN6dFBTdtnrU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940669; c=relaxed/simple;
	bh=NkTR1gJ0C2Whqn6mUWtV3PJ8uH2VPCXHDbyom7DEk1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgvOCZwQ7EHxV90Z8BjNwhAZsWG7WEowbERmsQCmMsTJUCtm0AsTgd8VbciGqNpEmE4sI4hU4eCgPhHITCoVL9iCOAjlrUqcDgh6H9zDUd46SgS8RePajuYxasIwGuGktWKV6XzeTxQI3mOGqCAs43c9Aeq7Ud4QhPD4WNy79F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ALtNsFlq; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ALtNsFlq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKfy7suWFWeBXgxnHc1G/H1G1sDiMfakmkQFd6LMK5GEdX/g/mIn9JhVI6PqMydxjeZxGyokyu9U+NQKRbyzhXi1q9PXvMpWmIpKVXMHY6jnB0Xen61oQMR3wJ//iGkTA6LG0hZZkgg5KiszJd8SADkeuHnqg/ZwIvpXDarisBJqsv1FUTrXOjEY57+hMaLjP1rIfDAR4bKyO8OjXNg7J0KpC+yjSlE/XhC6aY8o+MiFpSmSwNOuT3L+JE52yMn3bOIETjC3MPOIpUnEfLxFp7pX4KRGVoyifZmtkfAtjIprQkD4tTpxFhdmiJcfVTarJpIx3iYRJX8a74+nLPKbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0csvs4F63W++fgjcVHmmzw6E7KftZT2och5vbXSMmQg=;
 b=JZPAz5C0jacTr57IP6nmu3zYwGVWhaEB9SlI/NYsncHj662vx0ARdjS46VhuBnAHgwaUUbuB8H4P8a1+W9Rj7CDNGY7DHu7dJNl6E6FKHWg3Vw+KDqqVxF00Y8UQ0xtTDKe5fxtkkY6qkZ9kclKZpw/PkB7xQO5dni37tKAIpI3HnZh+RAb/YYaYiJMqcAwGabOncQcKpQ20wtvtx8fUJgc1vCtUrRd1Swbzzl7rGaPngf96G395txG0tR27MC3T6COhU7VaUgjIIf9L8SJTR27gHot7mNd9TRlclXO6sfF5giAkzaVUCZTfTO7jQ3p3595uKUC9+RllWmTxCUxhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0csvs4F63W++fgjcVHmmzw6E7KftZT2och5vbXSMmQg=;
 b=ALtNsFlqhCa3WJQPRZA196kIt39D08Dt5qBmEUo5WW1cSNcqheKSiCnouurY83OrB7b2IaG4wQWn8dNqwFeYT4tHl/gIDLCFrLWqWj2MnMp9Flhcm/phcfkXKZMSAeyNm2n/DTsmxJfU0cj18cKXqMr+AJxITpgXegOZg+Ua/l2NOktIYaMmNbXSEazyK91Shx/Z8DhBghnvuB0m2laJK4DbDLtze1Yv3H8sXjhnGO49bHxDEnjaCVyoBcfG/LsfWXkXKZ9TbLQCgW92rEBnwerNxcmI5F44SxTlp3Tj7enIcnwgCw0C+xN80StR+1x25s14kaXmXnrVoV5SDe/Htg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB6867.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:bb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 19:04:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 19:04:22 +0000
Message-ID:
 <PN3PR01MB9597F896FE350C83D2A8821EB899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Fri, 23 May 2025 00:34:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
To: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, "brian m . carlson" <sandals@crustytoothpaste.net>,
 Julian Swagemakers <julian@swagemakers.org>,
 Shengyu Qu <wiagn233@outlook.com>, Zi Yao <ziyao@disroot.org>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
 <xmqqldqo5uzm.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqldqo5uzm.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0121.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <0d77a3dd-f4db-48b4-b618-78a9be132867@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PNXPR01MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: d37f1562-6e06-47db-6e55-08dd9963768f
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|15080799009|19110799006|6090799003|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkVncmEwTG83dEdxVjg1bFlKNGFQOUJhYXp5VzJlV1NOTFliWmZyMFJOc0I5?=
 =?utf-8?B?aEY3MDc2em41NlZMU3JhOGxESnp5SS9EWGZqcHpFblQwbm9tUFZQcHBuZVhG?=
 =?utf-8?B?VmthUDlCQjBaczJmNlpRQlFmbDl3NXQxMWxoWkh4eUdhTjV6OEsreS9hL2VV?=
 =?utf-8?B?SzIvckx0eXJkOTlpcW0vZ3dIY2h4WHBVa3Rwa0lBMVpIZ1JhYTBUQ2ZEdFdQ?=
 =?utf-8?B?Q0xZWUVtdnVuR3Q4Zi85MjFEV0RyWVFZVnhpd0RqYnh4bG5BRVczT2JCcXVT?=
 =?utf-8?B?VjQ5eFkwcDJmdXBpYllvWmluOE1YcDh5a1c5NVlyRUdrdjRTREo0Y2FHWmhx?=
 =?utf-8?B?RlhWaWxpOERqRHdUZmw0OGNuVzl1Slpnay84U3d0cnFaN0dHS3RvcWNnajFS?=
 =?utf-8?B?VXljQUltSEJ1TWcwNEppK0JKdm9zSHA0N0xCYTVIUENYOFVYYTJqY0tPOG44?=
 =?utf-8?B?a053VkxJcHE5eWI5Ym5IejlFZGNpMDdtZ1RIUkhoWXBNMmpBRmdDWTZQTTdD?=
 =?utf-8?B?S0JNWnZIRDVvV1N3aCtTZkNuY2VOOGhQS0N0OFpRczlUQ0VPQjlEQXJHV3dS?=
 =?utf-8?B?dkhDOUYrVEJFd2NMMzFhVDEyY3p6YVhJWG9QU25OdFFMbmUyNzZVYlgrQXJT?=
 =?utf-8?B?L1FxTXNNMk9zTi9TbzR4cFM0QmdJRTNqcGgwZ1o4SDljNkc3MGVxUmpNL01N?=
 =?utf-8?B?MnhlWCs0VWF3VEVEMytMZ0cyRVJvZW5UM2pyWGtJUTI5bDF1L2x6NE1MNHp6?=
 =?utf-8?B?L0YvcFlrTkJwRmg5RjFCRTRRQmlhRGttKzZzakZrcUZGb0dZQUdtc3hLY0Iz?=
 =?utf-8?B?dlVzUzVrV3l0enRrR1VFRXNVWlBZaVp6MjBUNHVaS3hQQmtIRlVFaWZBcGlU?=
 =?utf-8?B?SUlwQ0JwUTgxTVluaWhMQmNZN0czbU51MVhNRllpMUNzVlQzMEkvWEw1MVRX?=
 =?utf-8?B?eGttOTl3SW1ueThlWEt4aEtXNUN0akN4VE1lSDVLdHJUa1ZVemNtdmJkb21v?=
 =?utf-8?B?T2VHdUxEVFFSMG1NcnMxbHV6c3hxMFFCTEZYWVN0UFdtcTJhaExYUjdkVzE3?=
 =?utf-8?B?cFJMVkJIRUhCYkZnTDB5QnBmNE5QV244RmRHb09JcllMS24vU1pIN3pFcERs?=
 =?utf-8?B?ZkFmQXhyRzVXT1FvOTJzSVdLaTBqYzRtajdGY2VNMEg5c3NFWnhqK3JxcStn?=
 =?utf-8?B?Umc4eUxkVkxQY29xY1piY3J1UjlTblJGZmF1cVJYMjRDMjZXT3FiVjVGSGN5?=
 =?utf-8?B?dFI1Q2pudFpuQmF2NnJFem5jZ1R4NEluUTUwZmFURVl2THRFSnNZUnZZZzJ0?=
 =?utf-8?B?NHcrM1VnN0J6cTU5WUVMRk4zS01PUlhPL043OWsycGswREpLRzdYRFluQUU0?=
 =?utf-8?B?Mm5GbU1HWkZvVityaTJNcW5XbWNrMTVwb1YwVVF2RTBoRzQ1UHJUMjFmbklz?=
 =?utf-8?B?UkxDWmRQUTU0MUZOV0tabXJJU1F5OGdCbE9jTWFDZ1ZBUjNhTUdJelR0UGM0?=
 =?utf-8?B?VWFPc3VXVHkxZDZKU1ovNVZaRTB0TENoMDQzTm8rOW5BdTkyMzBwYmJpcm1D?=
 =?utf-8?B?VVF4QT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTc0c2doRm1JTHRadUVEMmVwSDhEM09COFJadHVZZmdVdk1YS2VWYXMvRTZ4?=
 =?utf-8?B?VTZkelYyamVVa1F0L3MrZmRWU1lVaXFDWEJmWEJhaWkzajNNWWwybC9xcVpT?=
 =?utf-8?B?Qnh1cDZIUXJZLzIzTTYyYTlSOGdZTnpIMjFGTUQ1ZHM4RWVQcUtsejBTWWJs?=
 =?utf-8?B?Y3JPNHFPZkJoM3BwYlBsTktqN1dRZ2VQNnZnaEtuMUt3V2pWdnlhNjMwVWZC?=
 =?utf-8?B?ZnRnOUF5dzc1UVhHWVpobTE4NEtPUENQMDNoeXZINE5BYXBacWt2UEhmUWsw?=
 =?utf-8?B?TEYxelVOQ0wrK29kK3M2VGRNV20zaGZ5dkhoZGs2KzN5alFhSGJhVXBydFdR?=
 =?utf-8?B?OWswM3pia0xnVUZ6TXFCc3FrajhIL01rNFBLWTNJSzEzUHk4TFRKaUF2dlR5?=
 =?utf-8?B?ZXdkKzhSeGZYNXc3S1VWSXkwTk1xMVlWUUdQd1dML0ZvZ3c0NEoxeFJFOUFR?=
 =?utf-8?B?eC96Y1VZbllURVlHNmVRa1R4c0k1TWdpVDFNTWZVRy9kWVZtdVBpcGt0dUF0?=
 =?utf-8?B?bHBsaHVkK0g5UnVuYnBLNXV0dGxwZGsrclVObTY4OEs1T04rT3VHUXA5V2ts?=
 =?utf-8?B?TmJxekVuaGFaOFdFWVVPUTdtV0ljMFBKalNYdEptV05OTU9OcVU2OHdJbmxk?=
 =?utf-8?B?b2dGQitRdVhnSkpDY0NYRnAveWhzMmMvdFZIK3krVlFsZTJGRExjYWMya2lr?=
 =?utf-8?B?SWtYK0RuWGhXRlYwUEw4SEJsYWRqZ0QzVS9yMm1HL3dqS3VsYXVONkU4Z0pt?=
 =?utf-8?B?L3crZGN3L3pnV2hTOEZrc2lZL0pwc085T3FTUnpTdk91SUhkZ25RNytJbmtQ?=
 =?utf-8?B?UUlpSXMyd0d5WitZdE9YV21PVHQ3b2VDSnFQSXFGSGtZZGxvVGllaWZiWnpo?=
 =?utf-8?B?eUc5WmFqb2swVnIxM0JibUlQdVdjTG5PY3NtN2Y0bVBWeXJLVE8vUFpwVUN2?=
 =?utf-8?B?VzY2TUxKMkdRSCtkRVdPZTBIdWZVYUsrU1FSdTk0UHM3V200ejE0V3kySkV0?=
 =?utf-8?B?OEp6UGtEWll0QSs3d0NSWGxJbndobVZHeWR6Q2RPZy9yYlZwMlcwNGRLRHBM?=
 =?utf-8?B?aWg2MFp1ZWVBVFY1UzFpTFpNNDBxZi9zeGFjNDN0VGdGVVk2TUlBVDVOeStO?=
 =?utf-8?B?Um4yR3BIcXpRRVRqWWoxaGMzem0xWHdoT3c3VFlRTlpjRkNHQjV5Qy9MMTdz?=
 =?utf-8?B?Mklidmh5eXhoWUVIQzZkQ3Q5Z1NKUzg1UkViNW4wL2pZazNiYytrdTd6Q2VZ?=
 =?utf-8?B?MHhhY1h3VmtaODJkbjRMRkdmdTY5c2V4N0lWQnQvWFRML0xaaWVUZkJsZTF4?=
 =?utf-8?B?d3N0Wm9jdUdsdkhOL1QzZDBRUzRnVXY2S05qSGJWK1VRbEk1c0hwVGI3elht?=
 =?utf-8?B?YU5HRVpENjQzU3Z0V3R3SzdQRytqNnVWZXZBRGNldkZZYU04cWptZkxyemNY?=
 =?utf-8?B?NUtVSFMwTms0akl0N0s3aGl1c0lJWEVIa3k0SmxKd29zOVd5SHphRm1nTVNR?=
 =?utf-8?B?cmxxTFY2Rkt6M3RBanpOOElvUEpPMGdPRzFiWTV1ZEwrcEJHNWZheEFkcGlE?=
 =?utf-8?B?TUx0SEV4YzUyL3ZVVVFaVTRaYmZHQmkvK2tQd0Zab0phdmlLQ0hva2dJMUFh?=
 =?utf-8?B?dkFJdGkzUGZpV3dMQXZta3pBT2VIVHNzL3NiRkdmYkNsdVhuY2Yyd2FoU3lN?=
 =?utf-8?B?c2x0U1c4WUN6cUloYkdiT0YwaDFudFNrS2dQMFpOYmlhdFNCdGpadzhXWVda?=
 =?utf-8?Q?oq7fA1+DA8qP5cipNQ=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d37f1562-6e06-47db-6e55-08dd9963768f
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 19:04:22.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB6867



On 23-05-2025 12:32 am, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>> Okay, makes sense. It might be worth mentioning in the commit message
>> that these copy/paste bugs were introduced by 6d1f198f34 (imap-send:
>> fix leaking memory in `imap_server_conf`, 2024-06-07).
> 
> Definitely a good thing to note in the message, together with the
> subtlety that the bug is dependenty on the order in which these
> configuration variables appear in the file.
> 
> In any case, this may indicate that the population of those who
> tried to use imap-send since mid last year, whether they used to use
> it happily before last year or they tried to use it anew, must be
> very small, or we would have heard about this obvious gotcha by now.
> 

I also just managed to use OAuth2.0 with curl, apparently curl has
dedicated API for this.

Will send a v2 with that fix as well.
