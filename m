Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5A194137
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749411335; cv=fail; b=HVy279AnpTJ+nkEDZ9sQdVJQ+1O1VQMdH9hi6uLCJOvxV9kWRG8AKgETRQcKXaDOFbqih84DrglVL7EYUGd9ceFZMmQTd8eqvUggJYHvkTUEvFRqB/m9lVE+DFRkkiy9XD/4FyOHhOu2rl52X9uqJiIZ7ZJL2sobhUkwwGx2zfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749411335; c=relaxed/simple;
	bh=MQOU3Q9h9pRoXi6WR+kWbF/3/BisRReoFbJWC1vG2Oc=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=dme3S6yTxNoogNc57AT66igX7NCLGTCyo+kxnv7LDhOFKqLxnjNqgTpyjLV7ZqrAbzSNel6vaUAmbRFtpc8Yi8RUUP6NDcVU0/blxTZstQa8FE14l6sEdtlooGYkVXwFV7XWy6F3px5fjDfXpsXWhGzlgVpayXN0f+G4VyqIm5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=WhqOrPpd; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="WhqOrPpd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynWJlCrjA/q0/krh2hA4o1k406lrJfrDY85sD7PUFn7/oD0SQHAUkiqnMl56bfoKLaj37AE+A/pE04f/1OXQe1pLNrVAE4Esjl3YQc5kOOCQDDwP5v1NgYCzLdcDzbTX+MGPtxgSOCwaI7So9pFMg3ZqS7SZGh6Y9mUmOdbI90oogjABLdWMt9j5LQlZRk++YE8m/Albd4ZSKQhRSmH4iyGMhWfQ6nL/xm8MSoDpfCTucj2ZtK8UeBOgg712TIRDtuhX3+j1GIz4POlKTA1KAb9mQtIc194JXR8zsgMdBRDsFzMBP1edtHPWF0ZmkzsiTEcXMtzSHeXUm/i+C+n4kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzbWIvf32Vix1AsWluVfiU3UzNnBCCaA7KVmI02C07o=;
 b=TPzbBDO2wfeJ2A/RmDSzu2EPhtDcd6mBAXsfzQ+JGhtKTTzEvWfFCMfLbM9xJmnlA/LSRfct0dNyVKezS1Oi1VneJcK7aEE4oouPf7wajAdsdxfSdFLfU0QA6BpyoeePGww5nD7hGatb7qqYv80kGnsOvEg6Lc2sXvOSPhhTDNothdvHB6FuWWGHt8fUs6MBaUC1qUm+P3gRr8+dudnwpd5EOSiy4fSAMfnzyttjtCzuKaebJrt/9/9rI3BP7XGwc8I8q617fLIcH68My2G/Sx9TvI3iV+kpi5bEZlw29bEYZzg6XsD+YGgnand9vuJ1D0GsAZ/MW1FKCcnWZBEZaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzbWIvf32Vix1AsWluVfiU3UzNnBCCaA7KVmI02C07o=;
 b=WhqOrPpdfFkjLBuu08YG5EAWuEHeu/9BL83jLkQrWSphrmqldEl5BaPSpEh0aGDObxp/3iUjHI6lrBY2Ln/tzRFyRtyOJ7gsMiBXrAbW3/RpOZWsGH/AnkCdIrmCOB1v3JMFwtY/5T5Si5P+SNrEeWn1P9rEeXew/xPz+6ynIbOhOLZeUQNXXfAciIN9UO1YAmlJ11UUyUJh4uoFSQ2IKqnSS2/U6LVH8KPxOzAplPTiHrmXfUf/zLp7gIzwUdA9qt7UOfkVEA8rXYmgROTdoQi2QSO1KuLGzc1W20irpL5DQquzKaRu+Pi3CSAW+EFacTBl4z+mO3m8bOTFry/5ng==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7645.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Sun, 8 Jun
 2025 19:35:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 19:35:28 +0000
Date: Mon, 09 Jun 2025 01:05:24 +0530
From: Aditya Garg <gargaditya08@live.com>
To: phillip.wood@dunelm.org.uk, Phillip Wood <phillip.wood123@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "git@vger.kernel.org" <git@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_Question=3A_is_there_a_short_way_to_mer?=
 =?US-ASCII?Q?ge_the_last_commit_to_the_second_last_one=3F?=
User-Agent: Thunderbird for Android
In-Reply-To: <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM> <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net> <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
Message-ID:
 <PN3PR01MB9597D380178A875C6FFA90E0B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MA0PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <3B51544F-C570-4E14-A8F0-22A6029FEFDC@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PR01MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 351f54ef-500b-4449-0dcc-08dda6c39f8b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|7092599006|15080799009|8060799009|6090799003|19110799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZRUkVJUm1mOFNvQ3hHOGQ2T3JaRmxJM0lOZUMvZDhhVlkxZkNSeFVtVUJF?=
 =?utf-8?B?UFlGWkxsejRaNjJJQWovTi9KWkdaNzlGeWJ5QlBoRXl3dlh2ZVl6cXo1aUNI?=
 =?utf-8?B?NXQ1R2FDK2tRL3hJOEh0a0NGU0JSNnEwdE0xTkJtVGhHd0pGcjFFNjBtS0Vy?=
 =?utf-8?B?YUV1Q2lrU3JlVmV2K3hGQlBUbkl0aVhYblc4RjdDRzYyczFMVWZMQjBsRGQ3?=
 =?utf-8?B?dHpSMnBJMHF5THpFU01TZDZCMDdrdHVCbjdBRDRIZFB6Y2krRFlWL1daVW9Q?=
 =?utf-8?B?UGFkeGp4SUQ2c1kyQzhuQ2NxSkVrVGpmUWVCY0Z5eDdtdUhlQ0FWbzJ2ejBI?=
 =?utf-8?B?Z2ZxVHlHdkI2dHVKZDNoT1NGVFpyNDY4WkFROUVwNGVIL3BmaWZqd2cyaWRF?=
 =?utf-8?B?ZkhvWHpDcTFrQjZTSXFOTGhaQTlXaWdPdVRnSkNBWVpZTE14Zi9rc01BZU92?=
 =?utf-8?B?RjRjbmVmdTBRUXR6SHlUdzFtb2REc0xSa1JpK3RMUkR1OTNjRi9haXJnU2tT?=
 =?utf-8?B?K0d3ek0rcEtSNjBxTTM5amxUYWpOTXRFRlNSYlMxNDB4STZ5ZnlJZWd5K081?=
 =?utf-8?B?TVg2dGkyRCs5TzFTZGRIZUVUTnNuaHZ4MmgxRGdPTGJMYkEva2xKdUV4Q083?=
 =?utf-8?B?MUQrRzF6U3dOcWFCUDc0TTQwY1JpZ3NUb3VEU3VKVWFMb29WWjlmeVM1aU1s?=
 =?utf-8?B?cmV3ZlF3NERSTFR4OUR4dUNEcGtqcmFWR2dRYW1wZnhyQXM0clpVelppdFFR?=
 =?utf-8?B?cEZMS256OE1YQUEvRjhhQm92OS9pbUtBVDU2QkZFQUI5bnJBd3BhRTlMZlRy?=
 =?utf-8?B?a29uQWxVSHdmOTZpUEVQdXgzQWIrRGdDazFzaHQ2VmdOSVFZT28xbWFnenNI?=
 =?utf-8?B?QUVwbUFGRjFwZ2tUWEVSdGdWR1A5Mzg2OWZtdURNaXZVTXZNeWE3SzQwYVd5?=
 =?utf-8?B?ZmJhUXhEYkZGYmIyUnVsSWZGcGIxa3p0Q3VIb01naHk5Z3pDK1ZtNDZzUWZr?=
 =?utf-8?B?QlhseXcyaXJtLzB4dWYwZkdabmF2bnJtVVNkV00vVVpGN0xHTjFOdElRNTQ2?=
 =?utf-8?B?RjBwdTFNcWY4SzRydnZPNzlWYzBUb3oyZXBKMGZwODdrOU5iditha0Z0alFX?=
 =?utf-8?B?YnNVQTIvbHVOS0hYaU5ZUGhINkM2QzhpZmR2TW1td21uTnVieXgxeXM0WHBR?=
 =?utf-8?B?YU91QjEwTVE3TG9tUVYvdENZMk00K3RMWmN4MFFXdDJCUTNIK3pRVGpFNXdS?=
 =?utf-8?B?U3FpWjlZS3dyL3VlVmZZY2MveXRrcjBjb3o4T0dwQ2E0SHlBQ0xldldFSk1w?=
 =?utf-8?B?ZEFIRWRFUDc4TnJjVkR5TnRPc21seFFUZ2tYNmk4NzVUS1lxc3hKMWVvVURC?=
 =?utf-8?B?MDdld3VDcVhQMEVKVlZNL09pSGxGeHUvV2h2ZVkxdlZjMEw1QVZtZjhiZzJk?=
 =?utf-8?B?WUxoNUpwU0g2TktUdWlMeFYzNDJPQVo4WVFVNzJqdmlDVWt4RmdhUkl4T3V6?=
 =?utf-8?B?bG1PdjBhajdjQy8xOXBKNmRWQi9SNHd4QURMdEo3MWRVcEdIT0NXQUw3STNy?=
 =?utf-8?B?VEFMQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGh6T3lURlY0d3p4SkxLM0FtcTJTRzBwTHBkdjVzdmczZ21VNm1oWnF6OWVr?=
 =?utf-8?B?bExrT3hMdS95WFl1SEZBd3pya0xYZEErY2U2eGFaRDFGT1A1T0g2M0xUSFd2?=
 =?utf-8?B?Y3IvaTdyRkxQTVg5NllpYVo4dmZCNTVtQ0t6MnRYWUg5YUFzclFpQ0JyNThQ?=
 =?utf-8?B?eTBESThobnRFZDg2MlA5anc5RHF3MkVUamlkM3hXWDJqS1drNFIwUVZJMVcv?=
 =?utf-8?B?eGxncDNNLzB3Y1NSSEl2QWg0Z0pTRnlDeEo5VHozSUVsSWNzVmxyYnhUK0dT?=
 =?utf-8?B?QXk3QW8zVWtqUi9FZFZRb0lBV25zeW5TTzM3TVJONjBWWTRXS2dLWGRVeTZ3?=
 =?utf-8?B?czFaU2pKR1ZpOWVqRG9JWlFOaEZLc0RacWNWUGRRaHloSjl3SVNlVi9sZ244?=
 =?utf-8?B?V1NBeXpNdithcG8ySUFoQk45QXljWUpqZHcrR0dFZkRmaCs1cXkxTUN5ZUJ3?=
 =?utf-8?B?Zm5zN25DUzBUZklheEFROGt2STlkVnRTdU00TTZzRkFsVzJJa3E5REM1S0FP?=
 =?utf-8?B?Z2d3NTZ0eGtHQmlJeE92MTlJRVFiaVF6QXVXeFp3c21jWUI3a1VYZVBhd3NZ?=
 =?utf-8?B?TkZKS0xrMEw5QnMwb3NMT0FKWWc3S0ZDWE1mMU5TUkk1Q0NNTW9xV3lnejRw?=
 =?utf-8?B?aEtvQmtHRXlEQlB0MGdxMFlFeUN0a0xOeGJsRGJYMFFXdkZYRkV6Z1NTaFNq?=
 =?utf-8?B?a2pSck1TbEpoZW5EUHIxaDBvdGxncnMvSi8waDJYOHBMUjVEMGxlZGFid25l?=
 =?utf-8?B?eElqMFJoMjJmbTdjTkYzTUpkN05QYU1qL3ZzZU91S2NWVFg1TVdUdTI4dWNi?=
 =?utf-8?B?QW1CNUxEOVVKNjZwa0xaRUdmcStOZ2M3OVUyL0lHamJWZzA4ZDRLd2hNR2Qv?=
 =?utf-8?B?QVpMdTVIQTdsdytNY01sdmhxN3djNlI3eG5tcGcrWmJBelNOSHkrektYNm1C?=
 =?utf-8?B?N0VkWTAySmdMVzFyV2diN1prbHZtdXB5c3p1azR5QTlvNmlzZXR0WkJEenZ3?=
 =?utf-8?B?a1drNWF1cWRiT045WUo4RDkxTnVPR3ZIakNRSFhHWk1kYTZjTXRTbk81YUw4?=
 =?utf-8?B?dWN3ckxnd2NlbkNGNFQ5M1NreW83N3RpR1hSS3VnV3EvbDdkL0hHSjBaS3Jm?=
 =?utf-8?B?V0tLVnZsd3dNRWg5UGNCQjArSFBNTzNqam13UHhLUWtoeXNjVTQ5eTlnbTh4?=
 =?utf-8?B?cndoMkY3SllFK0lmaTRrd2dWSVlLZWZJTDRMeGo3VEdHdFJHOGlqZ3V3V1B6?=
 =?utf-8?B?Rjk1OHJXWW45d3YvRzhDM3lXUjVHYXN3N2lNS1dKbjc2eFhDMFF0R0Z1Rzg0?=
 =?utf-8?B?K0dmZ05OMWRvWnRqUllTNkpFVHpzMGpoY1k5TC80cHJDM3JBMm5DVDBQcWh6?=
 =?utf-8?B?UFVwdlpUN3ZKTHRXdDhQdktaak0vTTlXQzJ3VEhIUG1GWDMzQjFuRkU5dzFO?=
 =?utf-8?B?VkRkVDIwQUc5NlFhV2xROHVhcXhETER0cGhPZlZFdGRiWGc3UEJYdXc3ZXgz?=
 =?utf-8?B?bGRpaWNMcTEzVzU1RzJNNnhkRzJRQnUxdlhrUkVMQnkrNUtYZXQyNk1rOS9D?=
 =?utf-8?B?VSsyUkZzWkV2blZUeGNNaWFTb0dMUGdpaGprbU5jSzJXenRCQlZhUUpvYzBj?=
 =?utf-8?B?V0pSYXBMRnFrUnFNWlRhWk1DWUVtVStJQ1YwdDdqa3dMZUJkR3I2L2xZTUlI?=
 =?utf-8?B?ekkzK2NZL3NKQ3ByK0ZFUzhERzNaYTZ0NDRzQXlabHpxM0l4eTN1WWZGUW1n?=
 =?utf-8?Q?qnZEt4GXNVoW8R/PK8=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 351f54ef-500b-4449-0dcc-08dda6c39f8b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 19:35:28.4377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7645



On 9 June 2025 1:01:19=E2=80=AFam IST, Phillip Wood <phillip.wood123@gmail.=
com> wrote:
>On 08/06/2025 19:57, brian m. carlson wrote:
>>=20
>> If your goal is to just do the fixups and squash and not anything else
>> interactive, then you can do this:
>>=20
>>      GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
>
>Just a quick note to say that since git v2.44.0 you can just run
>
>	git rebase --autosquash
>

Silly question but how does it get to know what is the fixup commit?

>and it will squash any fixup commits without asking you to edit the todo l=
ist.
>
>Also "git commit --fixup=3Damend:HEAD^" allows you to edit the original co=
mmit message and this new message will be used when the commit is squashed =
by "git rebase --autosquash"
>
>Best Wishes
>
>Phillip
>
