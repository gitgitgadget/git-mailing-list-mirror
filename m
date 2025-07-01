Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30B2737EE
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384961; cv=fail; b=hizwpNMcZKiOmzCqVRJUtHOmdp3E9c9foEA3jgO6WmbRCqpmtJWK9k8xHA7S1HgKrtR24wm8pF9Dvyr19FRU/QNojxpvoqIlHGjh1yJC1d7NGPwE8rRan+ixvL0UebjHpjLOaUzcmfjZSO0sAvhzT9zgxFGGDDun2Srcy801nU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384961; c=relaxed/simple;
	bh=5ZhDLYFBMNAi58i8cWqu43jHjamk4mirdH2Xfq1zP4g=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=n6AAQSeTaLhKwcfV0FJjnfUFZ5z54GgJwkV+DAFX3j9RuSHk9VDs9Ywn4FALt1H6IqHozOzUd5c+lJRtdki2X0cSw02aST4y3GkpgZozfxz+jN6JDPiQm7cqcHIVUXVi9CavbgFrAfjc1yqjiCdY0V1L1JCB5OyIcisHWZWkv10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=tugPPH7h; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="tugPPH7h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uyAOsL6cYClBA2sQyPyApudHnAeKgz1yTQA9OvS7rfHKXhHK1sZllxgnynYISdUbObY9y/1vk34CwW7mFrArcIYutkAhdSkHNjjMcXIJbdHGIldv6iFCrOwE/pVa/kNncPf+nn66xQ9wUqjRPak6WSSPB7KT0Nzu4FqFlTVjIn+lHz4QFldMF8k0Rc8Bm65bfwnmyoiXcqqknC5qHlTf39FcDwbcrqdVKFvx8EoSSpX63JHDSo351sT9dhZF/SZ1lLBhykGg5HYv9kzAVnF1AnjUolGMYXuxK4YpG0CURFf5as8UBJmTsYAOMw+BtYWlxLjLf2QArSAMUDN0mtpiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZhDLYFBMNAi58i8cWqu43jHjamk4mirdH2Xfq1zP4g=;
 b=k/uuvCSNdQ6/9FmSwl5XCvyF7dXPZmlsuyWdmUp6hgJAZioMF21xhQFJz7fRj+ahyOTqh8lPyr9ZHco55kKqd0YT3uuBgl0T8TYVjXoKFfBFfYtBKiNbQUjhcVsyxFrGaMVfG4uev872H36WBR6itEukWr2wBG37ZrqZ5DWxC5WjU8+iKAN8UlzimtTOK9QzYNaaxXcFhGTpS17WtSYQ/2L9oXlVpKpReVUpcuwk++QzLvh0VfdAGk7jDtRAq0HWG+/kNZKG/aoermT60Ys6LdH58/T6mPhzV3YMN/Y/TVLcFjKrBwfvM7DaYk/a1Dj6jYuuHoOtZZ5sTkoP+Hpv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZhDLYFBMNAi58i8cWqu43jHjamk4mirdH2Xfq1zP4g=;
 b=tugPPH7hwghHZ2VSeuZZKs9MzLHWZOJHcdf8nx/yA1It/gSflSj9ZGS9VdTX59vM6m/paL1VK+rI+DSH5Y4mYS3mz763cxUQZssMlBFBzLfluMdA+MQtUPQssKq1GHTtBUOJwtZRwAtIc/XIJXSA9v/3mzNqGQ9kI9Xr6NPrKnqLTWKG35uD6X9eqR3lhGmU67a7972HoX7m4rDSVc6iV7OBYeQICDqq/Ou3ON0or52oSWy9EA6ivBlEB+wiXo6ivuSY/GpncnNVRNnI8GpUotnPD5hQoB1zheX/Vto16ysGpO35tYWOHftXw2KdaCUqGMkduyqDAUR5uOUvLFMVRQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB10064.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 15:49:13 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%3]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 15:49:13 +0000
Message-ID:
 <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 1 Jul 2025 21:19:10 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
From: Aditya Garg <gargaditya08@live.com>
Subject: Why git on windows pops up Git Credential Manager inspite of having
 set a credential helper in .gitconfig
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0019.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::30) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <af78fa3d-fcde-4c0f-963b-329ec52c6d80@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e4e0e2-2efe-44ff-d665-08ddb8b6d39d
X-MS-Exchange-SLBlob-MailProps:
	ZLYX9kf+sFbS0QTIQvO75BpO1flUkO2jHEJleJU/LEfCia88CNBckfIhAmFVx2KLSa1DWH1zRKBY2GYH7GDqb2ex0jVJo1cQfcY+l+c0sFXjBAMrbfVbef7OMmtNrVnHxo+NRcBe8I0+AgedTwS3d25U7HzRPm+dHcO7SKLl5znDt92B46vYV27aNJVGVDQmPfkVHEd3O+30mvc41kUNunrr1DwqQdVVhIYmY2+BJHShyfCdQ3C/vYEPbNR8UKpMtp4QlAfWFp1qE3oxzofRYVwH3iIlMLfZGF4OjHoQCKDK1SQlUjhVU8BYcaMc4KtOgpbhd3sbavRkO/FP2LWKA/62o9E8uN3Cb2u5FDulimRPE1iJG1cvuqhfwlAt1uKUEeOra7P6fCY5MsO4L9ghieeCIAU0Nora52/QVJuEQUIA8jn6VzPvw2UU3Qhrl8cyNgZaAr869J5cOtuPdF5p0HdSBtoV7lpEgrT8NFJlkSHOoCgBtZ7Q01KvYKlHM2GkudWFyhanj1KTodNVIOdX9hq2GClrITBlc+gDtzn0FJvReAMumpW0k4bfYdfEprGspRrGvXT19loAVvZtZqEJiujbDjTNwAwSgsrMxlemKkay/Q6Rsd51LBH/w68pi0gEg/OQ1/4a5Tivvx6wUNQi+tzcVATnweRww9WQLHWvOkVRdez+cPl0yVwTXmqG7wH/7bLDeznyRC2XSbSFrP1EJVZfddvw4dWjT1ED3BnYWbaGEFdybsTvshDvjbdYnFqKKk1WCO+Gj2Yh8ZEJp8IoarIrOWtWrTWOYSznJRrM1FgY6isvE9Xt5Q==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|5072599009|8060799009|7092599006|19110799006|15080799009|3412199025|40105399003|440099028|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFRoSis4QXVUL3hsRHZMNGk3WVR0WXc2cnNMVm5xM2FEMVowaFBPOTg4Wmkx?=
 =?utf-8?B?WnE2MUhHcTVOUzdGeXEranNwVEh0RmlaM1BrZU5VSHEwcE9tVWkvMHhiaGFz?=
 =?utf-8?B?c2hDaGxQL3NRYm5RdHNXMTFURkFRRnkwL1FJZHEwKzJ4RnpDV3hha1VDdGRW?=
 =?utf-8?B?azBUckgvRU9zL1cvZHB4KzdIZnFVNHI4ZDBDQXBXaWdtTHpjZGNNVHpxNk4z?=
 =?utf-8?B?eUdvVzFlUzlPc1p3elVIRng4OWJNbFpKVUMrK042VFpuRkJ2MU9vT3crSnBo?=
 =?utf-8?B?bDlJUkFRNnpXeGJMRVZ1V1BjSUgvVkd1c1ZZSm9idEY4NEJHMnRYSm9YYkhY?=
 =?utf-8?B?c05ybnVHU2NTS21PSHh3b3RWdXk2QlRaZ0czWS9RU3UzZytJQmxWMU1NSXdG?=
 =?utf-8?B?bVNIeW1kVjh4TWFhc00xS2xZWWR3TngySjRvV2ZLRFp0ZEFXcUxObEhNdUFC?=
 =?utf-8?B?UWFMeDgwSllNOUk3RXFLZFRuK0VvV0UyekZEUFhOcnBUWjhpYklBd2dUVU12?=
 =?utf-8?B?RS9WR2ZOS2grV1ZpL2tLdlZtRG92VU5ybFJUV3h0ZTFMRjNMY0JtaUErMXU4?=
 =?utf-8?B?YmNDZEM0TWtuN2xnRFVsTmNtMkJ0OElFRUdwMFBzU3pBVDlmU2w3dDJKdGlU?=
 =?utf-8?B?c3lDUis3L3MyWGhxSEVVZlFUTTE3bXU1dnJSTTNGV3JQTmJBNUNzMnFLRDlV?=
 =?utf-8?B?LzdyVEtScng2aWhnYW0yL2ROWXRjOHNXbUZNWWlvU2NmVk1OUzhEaUxCM0NG?=
 =?utf-8?B?NVhMTnJYNllXN2NpK0g4NEtNMWw0ZEh3N1ZweEhyRDdmbUp4YVhKNDVKR25z?=
 =?utf-8?B?ZXJudkZjK0ZiZ3FBMFJTVlVqOUYrak9yamtxeDhvL1VWTFYzdUJUc2VOR0pU?=
 =?utf-8?B?ZFFiTGlORDRiUXlSUUk4SHZqNUxmQ29yR0ovTnZPS3MvRnRqamVZNFRBSmJm?=
 =?utf-8?B?Y1lKZGFGTXIyZ1RMa0Z0NUFDSWdWTkl3emhuN3l2NmtiMFpIS2dOdDF4UkMz?=
 =?utf-8?B?ZG9xMUdmNlkxQ2lTVDE0QnUvSnB1WmxwREJqVVlaRmV0U1I0NExuNnhMbGlB?=
 =?utf-8?B?OEZKeHpOYVRSNUdzZ1ByalZ2cldmaXBXSW1ISTNrM21PVjFpMkZmQ1ZWMExS?=
 =?utf-8?B?SUYraWRxMTN3eTFTbEtwTiszajNGZkpocDZNV3d3cy9iekR2TG9oS2RpR0or?=
 =?utf-8?B?OWZuQnNOZXNZNEwxVzlXTnNRb2czSVMzZm9mdEFrTndPRFlsejZ2YUltakw2?=
 =?utf-8?B?Yld1UkNPK0QwWlllQmZxWWFpWExVSXNIT0gydm43YzZhQmFEQXhrd0IvTXI4?=
 =?utf-8?B?amRnb0NpQ1R5SDN3SEs1S2gxS1QvZmpHM3ZqV21oSGZ5b2tFWDVYRm15V1Fq?=
 =?utf-8?B?N1cxc0pmakVJT1JaaWI0WVFCU3VRcFZrOHBseHhwR2M5UHVpdHhCVWI5RVVN?=
 =?utf-8?B?ZnZIMWdxQ3Vlc0thZmpGWDhwUGpSYkQ4ZHlyTFV5TDBsaW5mVlpKNVpaL3Jw?=
 =?utf-8?B?TFRtRnhzdmxxcVJNRjNNWGRucTlVb2lFMnlBVDNGcTM4ZS9jYy8rNjdPZDBi?=
 =?utf-8?B?WS9Yci9wUm9vMXNvOEhFS0JTQktOT1IxeUE2dGs5MzdBeExlYkJFTmIrRnNV?=
 =?utf-8?B?L3RZUnBTVzFPZS9lb1F4ZWhPd1RKbkQrak0wVUd1N3JKbUdXSnI4dkJmSUZY?=
 =?utf-8?Q?eDJBmEkResBKWBvof51l?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmRQcUVGZ24zc0ozU0haUTJodklGUjY4OUFDdG1KUVBaYzMyTGtNcVJLNDR0?=
 =?utf-8?B?NXk0M21SdjhkM3NKN24vdnByVnN1NndjbnlUSmFTaG5PcmpzcUhoeU9uNVpl?=
 =?utf-8?B?ZlpML2ZPeGRFZU8zUHZMU2hITU56YXRsQWx6MTZvRzdhalpRNG5Od3RnVEwx?=
 =?utf-8?B?dkp3TW5Vd01HeTZZU24veUp4RkUvNlozbWFtSElvT2ZSUldCT0JWUTE3R3Fm?=
 =?utf-8?B?U1Bja3NSbDJWQzU1ZXR0YjN1N2d1akl4dFE1VUUrS3JQeldyMTU4QVJ5aTNa?=
 =?utf-8?B?VmJnRmQwNmRPd3pPSCs2K1dwMHVPVlJTOGIwTFFJMG51UzZqZyt6OVRrNWRm?=
 =?utf-8?B?bWxVa1RNaWMrMk9iRWx1a3VpYVV1VDg5OTJER28xeXovNXNiZHV6Yi9TSERy?=
 =?utf-8?B?STF4VUJNQlVzOXRHN3B1TUVKdnZ2U055NnhtWlVQZUxNNU1hTTdGcWVvV1Nu?=
 =?utf-8?B?dUxqbGJZOTZpa0sxekFXMkJtZ3VqbWpnelJRSUdaa0wzK3dLSXJVTndsNERl?=
 =?utf-8?B?UzZ3NVVnMkZ3YXl1UmtoVGJJMjdJbk1lZmMzRDZDcnE5WGRwN2g3eUZqbmxS?=
 =?utf-8?B?MlloUllvVmd4OWh6S0NFRFMyVEdNSyt5TTROYU5iRlRic29hVTVVcnVFY3RN?=
 =?utf-8?B?TTJHb2FkSElSLzcxSXhEenVNNnZTS2dmVXBVcHlFQnV5eUVoaGJ5T3lNSUtD?=
 =?utf-8?B?RHBqTk8vd2V2NnRFUUFIVnZ1T1JleWhVV3hXeTRINDk1MEpiWjh3ejZIMDJn?=
 =?utf-8?B?QmsrSEgxSFNWdXNxSWd6VmhzcGtSZDFoUWUvSDJTZnZUUkkzek8yQUg2NEF1?=
 =?utf-8?B?MTBjRFd6Zk81L2J5eE5McGpsMlg1Q1g2bFBnUHFLWG4xSXNPeitJRUx0Mk5C?=
 =?utf-8?B?RjIvNXM0RlNkZnF4b0dsYlpGTmlKMFFMTytVWEg4aTlJVDc3bVZRZXNlMmxG?=
 =?utf-8?B?VTVPamJ6eTVTeERrN3VrbUJoZGRhU0VnZTBSZUQ5Y0VVanNmR25mbjBvODVC?=
 =?utf-8?B?dzBUVGtxVHNtZFE3UnFib251RmZ3QTdWVXFpYkd4NVZzY1hUeTVCUlFVRjNH?=
 =?utf-8?B?WkNQMnZnakJtN0pnM3FyYnZ4bTNSQnN2UnJjOEVjdmluZm9FcjRQc1ZzOHdT?=
 =?utf-8?B?OUc3NXQ0OVdmbVVWakZ0ZFMxSC9NaTNGMGhaaGs4NlVWR1pXVHROS0F6cUNN?=
 =?utf-8?B?akNNelRZR0JwK0VtTHBCQnNKMU9Ib0RKZmVSNXEySG9sL1hnNVh5empGZVdC?=
 =?utf-8?B?Q1hkb2pCWkhVYnkrMW9pN2YvZWd4T2V0MjBjSmFKZTVLVkwzVkloWXFJSURy?=
 =?utf-8?B?TFdkWDZ6MTg0d3A5ZVRIMDg5Nlp4RVVPS2U5SWliOUJWN0pvUExJdGZHVVB1?=
 =?utf-8?B?MDRCTHV4SU5OV3lPNXc0Vm44TVFwL2tjTmJWa2tWUnJCOFhyaWVlY3V2cklp?=
 =?utf-8?B?d3RDRTZDSWdTN2kvaGE4NU5zNUlnTVFUWkZTUWlMakltQnUvUFVQQS9HRDJW?=
 =?utf-8?B?TDQ1S1o4cUt6ZmZEbTZqSExyUTdud0xxbFkzZ1RRdzRVMHFRZytjd3ZrVTlU?=
 =?utf-8?B?WUtKZDdrYWRkRGlEd09IMElkN2ljVytMWEZ5K1dKc1kydlR1Zmc0dUxVdC8y?=
 =?utf-8?B?QjJ4T2JLdkR3NFdodExtN0dGOUFGK2xHZ1FYNmhQblFoTU9NUkFKczEwMUNv?=
 =?utf-8?B?bUNOYXZsNWl1Rm5tTStCUGhHT2pIUDdxVXhXaDVnMGc2eXhVU0dCd3F5STdZ?=
 =?utf-8?Q?zmS3NYczE9Dw/lC/u9MmBqRUXNzlk2FVQ4FwqMm?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e4e0e2-2efe-44ff-d665-08ddb8b6d39d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 15:49:13.3144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB10064

Hi

I am having this issue with Git for Windows that in case I configure a credential helper by following the git
credentials documentation (https://git-scm.com/docs/gitcredentials), the Git Credential Manager still pops up.
I simply close the pop up window, and then it seems to be getting the password from my credential manager.

I removed it using git config --edit --system, but after every update, it pops out again.

I wonder if some proper fix is there for this.
