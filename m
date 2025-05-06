Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010010.outbound.protection.outlook.com [52.103.67.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194251DE2D6
	for <git@vger.kernel.org>; Tue,  6 May 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746552237; cv=fail; b=Hr24uvwjeqVf1kI/7y4Oz96tzF+GiR2t7/1npgNMEnaMlePeMlOX3+cqLJeXjaGT793rQc/RsVqTLNxiL1/7M/NUFdiMHU/tgCSHQa5iS+3bY70s8/nRJPbhHbIWK6GXIRcthU3huk9L0oszFKqNlf48kAr/6fSnOO2ozwOH3TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746552237; c=relaxed/simple;
	bh=tX3FdkaGvSb2FwaZG8qLJBhqxeUA/fv31zQuh32k8sk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sCi4YST+MlYbvAJPsTpNpPgoN/l+HitZbxC0SexnIyNtJlDsAWoWILoVTDEv0P87c+PeRLYflR+uWhN31Fd+qOg5glSQt53UX8vFI11PHEgkN3UmFo50TjcXH77wvSeuEnZ8sPSseG2zCTeeHWyo9ip0fQ/bwzMFpd1MRC7o9PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UpZoerRK; arc=fail smtp.client-ip=52.103.67.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UpZoerRK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agbBo2z/rD2bOocMKiTofc9z1+aPajXRKy96ebzdHBcd/Id8xQjqi3mVKaXoJnHYgmZN1G1gu1Wzrp33JFgQgE7XA6693FXKqMfFy//UE8jbiAmPGBry5EiWw0RtJv6VMXz40siAtEDD9AOoyVriUhSxIaYNrM9W1NnF/aFscfNdio2iZorSlRMwRGBRlH+OjqAszB+JGTFjfuQO9RomBxZotLdaUV2WUNJZscIpR1v75NwyrX2YC84iF+P2mcX/udtcGte/CSvodBR72kzRD8JD4XHKZpprlcpRA3jGY1IWKydopnMH4YE0VHhyFUHJ7yGGt6+yx0pjHoA+wtnIUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ptl0wBcI0Btb4UaIaTXaR9NrB729MBwbFnHCgHMKMAw=;
 b=LCsh6k/bhTW9713/O3HHtjL5hwR91TJ8glOE/evGPH4Deaaoxg/pvCb2BguA++batjjy7Rr3HuuJ+6qkw11uiA9irT7Ee8OeZwdgXoH0qy/TzJQ2eNrKocYR8ZY6bLhFPCyZajQU0gEDqnVBnPW1nELhJJ7rdkwSOaNd8zqAvRnd00qAPO+ERechz72lZ+qVfYYJnWhvDsIbRXp/LY/fibyHU0/LJ0PkbzDPUoHkYr4N97+zxrk8IsZPTNxjcCblXlwEbKeOAhVm4Qk46DjXL17t3XZ57FmSwL0ND2PgNd8zgERtssaSTwOnzhskXPv1QGI5Lgn5ghLDIcnBIrarXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptl0wBcI0Btb4UaIaTXaR9NrB729MBwbFnHCgHMKMAw=;
 b=UpZoerRKYRcE5+Tx1NPS+SXc8kWiSmCI9VgY+VCjOfMVz/XCoJBdhjQWf1DiXk66IfnYdnoLsOkQb6nmCePJS9F5EPvd9CnnS1sar9gTY4zM5xqzrg3AkZ1Y33Ap5rDxawOdiymNg7Xr1HjjS+cOHdAVZy1F2z3PHiRKrPXv0mKPKKaEac4KrGIURpzMJEB/4JeFKIWbIC4FXXFkIU9xCWZf8Lbxvk8jSvKzR4CiyFWdYlN9vWhNCLcAhzzDBGmDtX+EUg3oAABXq7h4ON7fK6fZYoGU5bp+usPqT0y14/C1Lf4HdhcZDWS3T0sSyIFlp98j2tYTGsg+cc5pdeeN/g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFD47D0FE42.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::32e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 17:23:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 17:23:47 +0000
Message-ID:
 <PN3PR01MB959731081532150F5FE54875B889A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 6 May 2025 22:53:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] send-mail: improve checks for valid_fqdn
To: Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 M Hickford <mirth.hickford@gmail.com>,
 Julian Swagemakers <julian@swagemakers.org>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Steve Hay <steve.m.hay@googlemail.com>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95971B8A202ADEA412010B35B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqplgmlisy.fsf@gitster.g>
 <PN3PR01MB9597B15F81AC6DDB35546C2CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597ED4DA3E781A6EFC03B9CB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqecx1ll5e.fsf@gitster.g>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <xmqqecx1ll5e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0141.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <6f300c64-b40a-4f7b-8f2d-7ae8b7c1c1a7@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA1PPFD47D0FE42:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea4c8d1-3de6-4bc2-91cb-08dd8cc2c2ac
X-MS-Exchange-SLBlob-MailProps:
	9qw5+ftluCChZnfVvosSLIOlRyTPeh57eP4h1Hg44+t5pkSUnj8UijFII1nEj1z/vaYy4bmzwDZpUq4CyA8PcukQaHhmZ+PGtmECtlg9LzNYIfa45cJywX9Ll8ReofCPHRaLHTYFsx6RdlGyOChi4Eey5yylDAGO+Xh2Gdqv+FKJGUPlFiFPDBCJ2950NY78pa+AxIHiGN2JGFo1c2xHHneWmXpE6M4fCC3MyUX5dVGGz+NqWEfgNt7o1IMS3zCdaeLe854cDjztIySW6jAni4fgEOXwwa0OBwyW53e+nxv5rhQzgSS9wcxv3D6dCSwQw5Bs9W3VBYUqUNH7ZfjUqbY6KD8hPPX+syXhK2p0xs0wgcKB2V703TfLSvwQNZeSGLPtBwZIpL8CKBzCN4JDo2LnpbDCxRjR+NwhiTBdEGh1OJRM0OokX23Z+AsD6GS7m1R/J5TJqUh/jWSlRN7TmMly0d8MEwg/3SQYWbvoEPAOavQKd5yGKBPr9J71WMKAVwW48hqTWrFR5+T3FyNE66jG2jno/lGTgraC62NxgQBS97EdEdahZ92zyKbP4uuLs6BO3bQ5YH3aO7BfGMgKcK1JQioKxfb9PKDTB9jj5V/WTQTI+vlgH9PNsQjkvJcxYgnSKj7UnQ2rV9K9odHcWHBwzFQO/oNbzmNwtb5h8CuFWxGKW4e6NgIho2fOIGNI245mpEuTc9Q=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|5072599009|461199028|41001999006|19110799006|7092599006|8060799009|15080799009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJyTmc2REttS0VLSTBvWXpFTWd5U2VHMGxzVTJaTjNiM3lKa2R4aDVYMnVM?=
 =?utf-8?B?MHFQM25TVVlIQ3dSV1phSDBOeWNHN2pnRC80N2JSSXNhTjlFekpDVW9HOXY4?=
 =?utf-8?B?VzVJV1lzUlJaSWRwOFB0VWh1THJJaEtMWjdodlR1TGpuTEhKMWQ2bmxKNUhN?=
 =?utf-8?B?Mk5ONXZLb1pQbUJKcGp4L3M2Yk5RNFFtem1SY2cvcmJpRm9xZk0wakV5aG9H?=
 =?utf-8?B?QkRSYWhnWXBXU0VSeGZRcjZLVlNIZ2tTV0pMM21iTUFkdCtUeElYdlRHeXpD?=
 =?utf-8?B?akQwa0FIOEcrWlFvazRxaXFnUHlMS3h1S0JoVUp0R2VJcHFjcy90TlJlWElK?=
 =?utf-8?B?V2V1VjBINkVVMzBSb0dYNG52Y0hadWY5R3A0SkJrbGpVdFZUQVdHczBYMVFB?=
 =?utf-8?B?ZktPOGxTcWpxU3NJUWpLNzF0RFpDTkRyVjZvSnBNenVHVU1ubHJQYmsvMVk0?=
 =?utf-8?B?U3h4Z1pMaHNSMG95Smw2T1YweVBtK1lXRTVTNmloTTNpTnN2Q2QwSmJHK0Ix?=
 =?utf-8?B?MXdBek1JR2VhQml0UUVMZ2hSOFVLV25Zc2xCWDhDTG9Ka3NwWjc5YWdTZzFF?=
 =?utf-8?B?eUVXeC8wZmFUSzBHRXRHMWFsSzBFbDkwY05EVFV3aUFVbndUVDBiMjdSS2Yy?=
 =?utf-8?B?dnlJRjZ5Vy9ReFk0c2picndtTDloYVQySGkrNWpWTEdRMjlSRFp0czcxOXpT?=
 =?utf-8?B?WENERW9HblNIRWptU01LMFBPVEJtYjNaWE1CTXExdVMrZFB1Zzh5cjdwYmZR?=
 =?utf-8?B?ZzJqUDc0YUE3aUZqRG1wUzRERGVDR0ZTV053bElvSnZqeG5UNTJCbkNKREZW?=
 =?utf-8?B?cnBmQ0xDalNPeEloQ1dqaTMrS0VBL2ZyU3pLRkRWcEIvNkQ4ZG9JRjl4TEI2?=
 =?utf-8?B?VG1keG1QMVpZR09kVVEzOEpOU1lmcG5uUTFOYXR1OHl2MXZJWlJKRkNwWWx2?=
 =?utf-8?B?b2ZNM0NaQ2FhcDVtaXhOTkJEcW9GeUpMMHNYMFVlLzBQaklSQjRYeWR6Sjlk?=
 =?utf-8?B?d01tRVA0N2ZpclVGR1NzdUN3TnE1aFlBdGNMVXMrYlliTndrd0p3NFhzSEZ5?=
 =?utf-8?B?cGlWbmc3bEQyNENDSjFSUGFCSnVwNEE0L0l0eDF1YmtlOFBoM2ZRWm5pZTVL?=
 =?utf-8?B?ZkorNk1Rc3NYL0M1djhMelQ0bThUU1pDRG9hdzhCaUgreUh4WTNkUkozaTRC?=
 =?utf-8?B?eXVpSlByaS9XY2lWQzVtcjJlSld5RUgweUNFMXBzQnBXQ21Ja05JS0pTS0I0?=
 =?utf-8?B?S3RnVHBKMldDWWk2dWc0bSthV25ON1hmei9Ld3JnQ0xBTDEwZVhZUkhhcWJB?=
 =?utf-8?B?OVo3aTl0OEh0NTc5QTloTGlDb3h2UC8yUWVwa1hWNDV5TjlsRkdHVWxpVjls?=
 =?utf-8?B?ZVFzNUs3a2wxMStDVFRXTUZBeXI1bEwwSnArTVRHdkZVdWRyNm5TOC9ZTjl3?=
 =?utf-8?B?QVh4WGE3QTkxY09UNzZvLzE5S3JYTUFDZmY3bWMzY2p4cjJSUTYxL3NNdFQ1?=
 =?utf-8?B?UXM0dlc5UnBvcjZaY2ZDVG5jNUFSbWV2akVxU1g2NlhlRDNSbXpFd1Jldnp1?=
 =?utf-8?Q?+ZFkmwPYqTW/v8q2/ZwCcefwg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXlMeU1ZWitTWEUrTng1R3RSTld3QU82WnErS0FGM09vWUVNbkxVd2FlZkw0?=
 =?utf-8?B?VzQxTTFnSTNMQVZJeFNWaUQ2WGlTanFyZ2VkQVhiTUhCQmVIelgra3dta2wy?=
 =?utf-8?B?K1ZZdUZ1NFo4Z1NUNW1WeFBaR3huaWlCMTZoNWFrWFpZbTlIOVZiTGsrSHBG?=
 =?utf-8?B?cnZ1MUgrRmdOUjVIRWc2M08wVXF4QThobS9NMTllSWYxK3NNTUFNOEV1OWkz?=
 =?utf-8?B?WDNBaWhEUkVnNER6TTNMQlFMUDYxbjlHOEZiMWRVLzkxWkQ5cnN5Nk1ZWDI3?=
 =?utf-8?B?Y09pZlhKclBXRWhySC82VE9UWGRQTVNQWGhJTGp1dHJvakpMS2dGd05pRjFY?=
 =?utf-8?B?YVJzRy9ORkpkanlkUnZ1ZGg4aDhHdzBoellDeTZ1R3VOMzlZRDdoK2MrbzZZ?=
 =?utf-8?B?VjBhSXJpbUIyQk5XMWg1TzFzVENVUEluYmVTVnFrWVFpcWZYZ3BJMzljR0Zi?=
 =?utf-8?B?RUJnY0RzNUpkT3BaYVFKSlZmdnl4OXdRRm55OVlBR3htWXdpL2YxS0cvZk92?=
 =?utf-8?B?bE9zNURrZWZTTXJGNFdkc08wL3lKMVRMRk5rY0NENDV4Qmo0NHVrV3B1Zko5?=
 =?utf-8?B?L25ERzBUcGxjSFh6WW12RERrSDF1bE5Yb0dQekRoWUhZejJWNWk4Q3ZRSndL?=
 =?utf-8?B?U0lLd1RsOWxEOVhRdk5ibndCZDV4QnV4ajhXZDNLZnhSNzQ5YnJEckVaZndp?=
 =?utf-8?B?VmJQbUwxWmdVWFdnYUhMbnUycmdqMEl6QVEyZXpkUnFVamtsdXJsSTd0Y3Np?=
 =?utf-8?B?eDl3dFpCa3JJUnlnMEEzUVp3eHE2UDI3ajIwMEc3cVI5OHR3TVRLajlSb3ZY?=
 =?utf-8?B?Z2U0YklSakxxY0lkZ3QwVSt1a1NLemVLaGJGN1RHR04weWE5UTRKT2NnTTRu?=
 =?utf-8?B?VXEwb2x6Y2ltU2xkQzl3VEp4SE13UzJxS2VSbUJ6aVdjdlVHeWdYT05HVC8r?=
 =?utf-8?B?K3BjdWUyd1VVRjJ0MzFYcnVRemlnWGg4Zjl5SUs0b0VVdk1vTGlqSmc2NEpi?=
 =?utf-8?B?M2ppUFVxV3RpcmE5VDVmR21EYVVDNGIraWlqTW8xTTVHM01aWHhYdVZOTWxP?=
 =?utf-8?B?RW5HNmhybU1wcHE3T2pSYVI2ZEM5RXJJWk1NejJTUTRsVERTbU1BbnVhd2RW?=
 =?utf-8?B?K0oyTmh2L3UzVVNGdjJYLzBqZ3paa28yR2dBQndtNkFTM0hMYWxRYXFLak85?=
 =?utf-8?B?NDZqU3daS0lnZFZUTnFmTk5ZRjMrcmwwUFpraWpFeGw0a3pIR0lQWndmTm9U?=
 =?utf-8?B?YlJuOEE4SzVheG95RTFoZUVuOVVOZ25ySW5tUUFXS1hBOXlmUFBaUlhYYUtU?=
 =?utf-8?B?VHVpaDg0MUpqQ1Z1YnpQNUxEV2h5YXlmZ1hZTzlaNm5ycHVsQ0VQV1F1NytN?=
 =?utf-8?B?Q0R4YmFteW5odWx0eE8weVJHMTdreklmdnRSOUF0TDB0Z0IyOTFvZEhqbjdz?=
 =?utf-8?B?VlNCbVpja1krTkJXSm5TQVlwVzhnOUoraTlJZ2k4elFLWjVIWVdubDNNRWNM?=
 =?utf-8?B?bnpQditKdSs1eUZLazZsajdqTFBvMGc0QmNOdEtIUFhac3hLb2lWWkF4dE1k?=
 =?utf-8?B?VnpyRXdvaHp6RkNhdHViTFFLWXNjOG8zRnlvVmJvNStjQldvY3FTczJYK29E?=
 =?utf-8?B?K1I0WmZTNGtrTGdoSnM4MU16ODF5aTlZZ0xxRXIzQWZZZklxWDRaZTFkTjNo?=
 =?utf-8?B?NnZyWjVsQkMrNXhWRjZpVmJvZm1GY0JuZXIvMTdVMlRVcWNGRkxZWHcwdm9z?=
 =?utf-8?Q?j8QKBRCxT8CnSuWrExkKXvY+vgEpDnmu41jbwkc?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea4c8d1-3de6-4bc2-91cb-08dd8cc2c2ac
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:23:47.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFD47D0FE42



On 06/05/25 10:41 pm, Junio C Hamano wrote:
> Aditya Garg <gargaditya08@live.com> writes:
> 
>> I think we can add a minimal check to ensure that there are no two dots together.
>> Does that sound fair?
> 
> Is it a common misconfiguration in the first place that singling out
> a name ending with double dots (which indeed is very likely that
> nobody should be relying on getting accepted by sensible SMTP
> servers, hence very safe tightening) is worth doing?  If MacBooks as
> shipped would by default claim to be "MacBook.." like your example
> had (I do not know if that is the case, as I do not live in Apple
> ecosystem), it may give us a reason to special case the trailing
> double-dots, for example.

Its not an Apple thing. I am not even using macOS at the first place
when I tested this, I was on Ubuntu running on my Mac.

Its a problem with Net::Domain. In systems without a domainname, and
without a period in the hostname, Net::Domain will always output
"hostname..". You probably should check your machine with smtp-debug?
Btw, the output of `hostname -f` on these machines will be "hostname".

Now gmail does not reject this, probably the reason it is unnoticed?
Since Outlook support is new, such problems are being observed.


> 
> I personally feel that "run of at most 63 alnum or dash separated by
> a single dot in between" is easy enough to explain, so if I were
> doing this change, I would just use the regexp used in posted patch
> [*] and if nobody complains, stop right there.  If we get any
> complaint, then I'd detect and reject the case where the string ends
> with double-dots.

The regexp used in the original patch covers the double dots case as well.
Its basically following the RFC guidelines, which a sensible SMTP server
should follow, and so must a user.

> 
> [Footnote]
> 
>  * ... but I don't know if your use of negative lookaround
>    assersions is correct.  Shouldn't the "a label cannot begin or
>    end with dash" be applied not just to the first label but
>    consistently to all of the dot-separated labels?

I think you are talking about this case:

someone.-example.com

No, its not valid.a
