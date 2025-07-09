Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2125.outbound.protection.outlook.com [40.107.115.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DD7199BC
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078835; cv=fail; b=BlrP0v5od0kJTLTH+LKau+TJEMKXhYVnsXHSROgAHUj3fmMsamnIneVYBjMeQWopVHHTRsi1eZQl4xUS2ELNOFpIEqFP4+0Xgf19uet/G7BEuxZo8a4pXHw29z71thduyZ92NXL09NwMO3775WTKwPhqFYYKp4QjUY0UdBERN2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078835; c=relaxed/simple;
	bh=84xKWXmTET/wiAEMAsGZX9XbY71MmUIdEm5aJYfe2/s=;
	h=Message-ID:Date:Subject:To:References:Cc:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uMw+WiC35pJuu1zUY2Fk4i+cdfWMSI9+RngJCL0A3IlxkbG7VP0/2XwL6RiQhITlqPMzRnUOubCDL8UJNpkllBW++8uLlmqMQimCV0cDogIbLWpabDui1O9NBCbx37ma9DTNYCnG7/GHX7ETxxu2nBw34WMiWbkOqy0rlUR7HjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=QQIYPqUC; arc=fail smtp.client-ip=40.107.115.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="QQIYPqUC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7CWe6Ms6lBaVsXpNSwBhHI64C9Y+9zv3ijwyiLEfkjHYwSGEbUZHLtZWCfxkiXicQxnhboHLHKNKs0fsDSegysNTAsI1+2EJdWvzQWW5wiVbvu2grTrofldW8rF4YBi/12G0GDn/pMtV07SgrJC6Y0yD0GeWK3RxkQmpVv11S2b4zg5Mg9DvRJuvanAiAf1G+/oHMIDi633E/XYeWY/+4kqdEYc3C0Gn6AWP6rCLL2KM5qoFO1bEMvBxjDm72lPZN3eEMmp8AX87g1ifDGO3cZPw2b+NrODPJlhQbMn1dEP28WE0upE3Nls+Lsm9sEOs/XqzVfVY6iDE2bvZfmI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+O+rtXr9bbhWbOtElizRy4xPnFUHBzv8dHpVIvl/Bo=;
 b=Olr0MBV75TVCkYpKMGN/boYIzK5Pu77+7fTFyVJYY9rrpfCRvqrvcrHVFrIwxa17y4sIpSsmNRIerWSRRrM/FkbPSW2RQoI4gi/CrzvKMHQM9m3Wq6vghEpr9A3WVPgwsLWNozGFezYNM88cC/8mp241BooM0m80/Oq+if8Pm09NGG7oihAlOHuLGUf7948KrhY6rY4ogfaAA31vlQXjSoi+he6S7E2tGxyVB2Norl+2o9jjuemYLJu2V72pY5xAz/gGlrZKr2eN13yVtJ+3DUWG0FJGXlwhkggBB//UCHHHPJsOSKHRzNgBowSHunC4Hy3851UKj9X7LWD9C5V5CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+O+rtXr9bbhWbOtElizRy4xPnFUHBzv8dHpVIvl/Bo=;
 b=QQIYPqUCz6AUv0ydjKumqZj9X5TrYv6U+Iy1kF7NTRP6eEDvJkuLsd7EPlvrxZ1fqT6pU3zr44Vpji0HrFd7/g49Ylak+2hNQNj502MQDvEZLQ/ePPwNPaLOVy00DquCO2P9E1XT0QBrt58Wd1t+vZBc/LcMt7KsJ8J0Wkqf7dbjLS3DAFF4mcyZRob5qOuDUrf1uY2gWWg82Xv/XrW1uN2TZ0JAFQgOyIq9j8yoKonQg55LSymwjgoQiY5TvxK67Lh+8x7ZtAULNfQyQHxp/zf3UC+4LIrXbr+eRV5o/iQj0G1jRpxRkoQ8XWRRhRrywV3GzmxsfmF/Ze05KWWCig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT3PR01MB10651.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:95::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 16:33:50 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%7]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 16:33:50 +0000
Message-ID: <44b6c207-b02b-401a-a621-f4023e780240@xiplink.com>
Date: Wed, 9 Jul 2025 12:33:49 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: git-subtree documentation fix request: split example causes fatal
 error
To: Alexander Krupp <obs@akr.yagii.de>, git@vger.kernel.org
References: <6907e423-324f-459f-a62e-fe6be14f4f73@akr.yagii.de>
Content-Language: en-US
Cc: "David A. Greene" <greened@obbligato.org>,
 Avery Pennarun <apenwarr@gmail.com>
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <6907e423-324f-459f-a62e-fe6be14f4f73@akr.yagii.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::29) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT3PR01MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: 82770d73-2597-44ce-8f9e-08ddbf06626e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm1jQXZrTExqR1FPdkpBL2RVSFI3RjJiQ3pzei96RU1Pc0FFbzdheEd3dWRI?=
 =?utf-8?B?TVpBcXJUZDVzcCtMYWdCVjZiVGxiYWlTZTUvZ3ZheEd0azVpZmFiTWQ2WFNC?=
 =?utf-8?B?VTIyVWsraDNuS3M4ZDVYdXk1Tyt4YWsxV1Z2ak5GSVIyWW8yM2NSWnkwOE1G?=
 =?utf-8?B?eitvUlBZTVZ2MEk4MVpEbHpTeklDRFZxZjBabS9LeGFNdmtFSHh2dTI3cW0y?=
 =?utf-8?B?RXpGc05QdjR6NkNONDV5SEZ5dGRtUlh3SWF1Z0JzSjNoeXlWZmtjdStCQUxV?=
 =?utf-8?B?U1lEQklZMFV0a1U1eGZyOFpCZW83R1JScVJDU2xTTHhPdXN0bXNSa1lYWDVh?=
 =?utf-8?B?Qm5jZDhlenI1R3FSWHVud29hd0RTWVVGQmI1RVc3VFpuamNycW1UdmZNcGhi?=
 =?utf-8?B?eFJIYTBLRlVtN0JBbWUwc1g2Rm5jelVTbENycGM5b3BCSnRwVXBUVzhxOC8v?=
 =?utf-8?B?VVk4cmJYNnh0OWZIdVcrY2VOclAwV2RMTjY0UGphRnJrME9LQ2xIc2lTZkF2?=
 =?utf-8?B?T2JCUFJ5cVFFeGZ5TzdNMlBiUHdydFduU0hsRStYc2U4YjFtOFVYTGp4dXpl?=
 =?utf-8?B?OXgwd29IeDBhOGJta3B6U2x2SkhySDhBNFp2Uk4vWFBsU0ludDJXOXVvZmtW?=
 =?utf-8?B?bzZ1RUo0a2UxL0RPWWUwbzFLb1RKcHRnaHdsaW9nU2pNellSVWZNY3RjcVcx?=
 =?utf-8?B?bFBYeFNJR25tRFJCUFhibWI5RHhvUU02bnpGNFpnOGVnNnNxQ21XQzFyVTVz?=
 =?utf-8?B?OFR1ZmNXRmRRRHdJUWN2RS9JN0YrbDY0M2pLYU5QbGRqekZ4MVluOVFra3Mz?=
 =?utf-8?B?Q0FyYmFXT0o0emRBSzFMVzAzNjVlYmkvTTVFUGc3NUZwdnIzUkM1NExCMGdS?=
 =?utf-8?B?RE5aNncweGNEbDRiZXpieXg5amhramlnM21ZbEltV2V3aFhrcHNiOGVPN29L?=
 =?utf-8?B?eW0zbVYwSDdYdVlaZEFGVS9rcy9wejBrRDFOSmkyU0IzaGVmS0NvN0RxN0RU?=
 =?utf-8?B?eURLaGFyT28rU2dzQnhkdERYanFQRHFkYkQrVHh4UVZsV2l0K0RKc2tEaXBw?=
 =?utf-8?B?VzJ0RXkrNFhDdFBFNTZoSjZYYXh0eEdLbFhHNCtBeG12R2luVHlzZDJWUnU3?=
 =?utf-8?B?M0IrS0poc0psTGpWeFNkcFZ2MnNwQUpQaEwzRHpIbVJvaGswQmN1SGRGR3Uy?=
 =?utf-8?B?VElGaFoxZkY3S25hdUVvclp0WU1nczlGMythdnpxUDl5eklrNytEZkJDbjhw?=
 =?utf-8?B?VXdlcVJ1cFo5VlZGYTNVb2FDL0ljS2N6dmMxeVM1RGxSeWFMY0tXbUtTSlNu?=
 =?utf-8?B?MElMMC8rRklSMVRJVE9pQTUzelFUOHVtTXRCenRnZzl2aXFvS09rbmcrRFNj?=
 =?utf-8?B?eng3NTVxaE04UUU0a21ZemRVYWIwQnhmY2RjVVJ5SXl1UTNGbnZ6RDkxazV5?=
 =?utf-8?B?cTltR3FUK094VlU2UUlVUlJYVjdsb3hLdEJBRlRKUllzU0pzbzg5NVNPczdN?=
 =?utf-8?B?QU56MlVjdDMxdm9EQ0NNam96UE9KSUJQdTdqeGdKZU80eWk1VUo5bVVqMWpL?=
 =?utf-8?B?aGIzTG41SkR5U2loekxUYk9qUnYrZ0I5b1pPVWExU1cwNG5MeUZML20vV005?=
 =?utf-8?B?ZUNaNmdmTElZU01SU2hHbkRwVXQ4cHc0VXQ5MUlKMkhIbVM3R203Y0JXcG5O?=
 =?utf-8?B?M3JNb1BPMkpHeExPVmJxM0dXOWlBQVVGWjh5ajQrL2gwbWo5K2g2T0JTaHpJ?=
 =?utf-8?B?dVR1eGFVWUlJZS82OXB4NU1QKzNZdC9yTHBneEF3eVFESU1rUUVMcERRei91?=
 =?utf-8?B?c2tBaHBBRGNFb3lvYWRlUFA2U0JGN1NFMGFSMjBOWXRrMEVEVVhVQXgrY2Jw?=
 =?utf-8?B?SzZMRFNTMnRaSXJTMURGYzV6cGhjYjJpNUphOUk0U1I1SmgzbWxSZG1FUmtL?=
 =?utf-8?Q?c8mIYgTQkHM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUszOTdlM0tMK2s4SFVFdGtGa1ErUkxkTUY0Qmx1VTR4UmE2dUs4bmdxSDZx?=
 =?utf-8?B?TjhNZTQ3WmkvL2NjemRQaWM4TmxiYkMxcGdtNmxwbDBWa29iU3U1LzBrQmRz?=
 =?utf-8?B?Y1pYZDFGcTZIV2ZKNXpnbkFENzFsM0pZYUlqbnMwUEVrOUlWV0tPcWhzVlQ0?=
 =?utf-8?B?YkRUWWVVNG1xQ1dpNlNUNlNIR0JjYlZGWVZSMzcxRmREYXRJcmd6UUg2b1Ew?=
 =?utf-8?B?ZkdlY0p4YmxNWjhGK2ZZTzRjQnVzWk1SVkJGMzZjeGJISkI1cDVySjFPaU5u?=
 =?utf-8?B?WmgrY2lqSFZ4dkhTRUdrV1BCeGdNM2I2Wm9HSTJGd3drZG96VmFYNW16U0dP?=
 =?utf-8?B?L0JpMUVHMGJQUGtuNlFna3FxRlFMcTkwTnZBckoxNUVnREM3cm82ems5eEhm?=
 =?utf-8?B?RlpBUklyZkMrNUIreU94eHd2NjBkcGVyS1IrYkhqN3hHbG51Z292ZmI3SFdJ?=
 =?utf-8?B?dHYwZkxaMlBjaXJlZ1FtZ3RudUdITjQ2S2grZ2FCdlZrSzczNUVvZE85a2xI?=
 =?utf-8?B?RTVmYkhsNlNYYVh0SDVIcDRUd2YwQ1p5SUhrd2NKbGMxMmhZY1JDQmJCUFRR?=
 =?utf-8?B?TkxXcEJtVzV2U1ZrcDdJN1VFQ2ZYSGhPdGhGRFNoLzJZU2llcTVhR1NhR3d3?=
 =?utf-8?B?ellXQXpPbWJHbjBMc09EbzJyOUdzTnN5Z1pQQlFoMC90amg5bVgvU0pCU1hO?=
 =?utf-8?B?OFFZVU9jMWdFazk0V0JLOStvSUprbnA4bTY2TDVtQXZuNDdtaXBkbGVYL1Ro?=
 =?utf-8?B?dlJxeElqR0I1ZHZpSW5QaytPQzFVUE92cHRMNDZYV3IySDdZK0U1cm5MWEI2?=
 =?utf-8?B?eVFYRlF2eXU0cUROS3lwL0g1bFZxbHNjdnptV0pFYnZYNUtqMmV0TTV6d2lo?=
 =?utf-8?B?UVlvbUFhWnVINGo2UmJOaFoxME10M2l0VW40dW9HOThFY2hWNW5ZcmptTGhT?=
 =?utf-8?B?Zzh5TXpRbkw2RjlpZytFd0FaN1czamZXQ1hwQ0JnckNENVNFd1BIUUtUd3BY?=
 =?utf-8?B?eW5aY2R4eVViNVhlakNEMkdWRE1JUDVhYVVJcEI3b0k4MFlSR0xJZUZ3enJt?=
 =?utf-8?B?T2pCUm9UV0JNWGxuRzRaSUxFRDRkbnJ3a3VDdExzOTlyYlJkcU5rZlpPSEVS?=
 =?utf-8?B?RFFGQTU4eDhKMXR2UU5rQ1p3VEZUellIY2pzaXJFMWZtRnZjb1o4bGw4aDBw?=
 =?utf-8?B?QUdIN1plQUZaemdqdDlrQlRPSkJtM3QwMHorSkJOSjIrdUU1eU51OElLVlBk?=
 =?utf-8?B?a29EdFgvNWRNRGROK1dnTUptT2E0V2hIY2NjQTVUcCtBbjdKVTVCeWRWZnVQ?=
 =?utf-8?B?YmkrTXdOdkRiUHZ4aDd6WEJQMmsxZEdJY1lJTS9WKzJ2MmcwU1hIM0E0aTNa?=
 =?utf-8?B?QjRMbVRlVVFFeUV6RE5TeG5lZ2RlWEd1WXB5MFhxNTVTYStCZVV4dXBVWGRm?=
 =?utf-8?B?RG9iU3BvdzloVlZQYmVjRklJN1daa0NwcGkyajRJaC9KVHpaM2lTZmxBMUFi?=
 =?utf-8?B?dmdiT0JLMDRpU0VMMkhVdzlyOHFsc1lrVk9OTmhzaFU1VWV4L2lmZkRXNXNJ?=
 =?utf-8?B?V3p0a3hBTmFuTEJZaG9IY1Q1dWVFMDhSRjJMWml1eHdtSnZzRHJPRjdVdkhW?=
 =?utf-8?B?RkhzT3JDaXhWMUx5cE1zcEM3RjBOR3lrQWVDTnVERXZQckpnN2tuZDN6dWF6?=
 =?utf-8?B?Z3ZkVmlHUU92ZnJGUlE0SFFBcnU5eGkrd2ZuNm52YitXSmdBbzI2SmJaazg0?=
 =?utf-8?B?QmdacmtPQmVQM2dpOW5LNVhxdjhmQi9hb3VsWTcycXowZHRYT0N0eFg0S3Rn?=
 =?utf-8?B?OU5ibnV1TFJaL1dhTUZEOEZZL0Z5VXV5Nmc5YjRha2VsZkFCdkI5Q09WYkRV?=
 =?utf-8?B?c3NJVGNOTXZlaXZ6YjI5NlNxTjByYm5jMExDdUFKUHpMSmpUdXY1ZGN3a2hE?=
 =?utf-8?B?cm13b1RLbGhYeXZ2aGVCTHFWYUg3OTZjaWJPN3NWOXZ3UURZaUszWmJia094?=
 =?utf-8?B?WGtSTFNGVExOWkQvbFFMNEEwVEY2NDA4Mkp2V1pvVXBuNFdia241eGt0aUtQ?=
 =?utf-8?B?OVZiUmlUZnljeHJWYkJOaHZXelBaQW94MldZZz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82770d73-2597-44ce-8f9e-08ddbf06626e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 16:33:49.9961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyh2jt+XadbrayEe9D19ZNq6xmwuuMfhkYwSzxHFqnIHR1lUE9POQMx1ku6eeh3chbT0bR2pC0jnALNXSXrqFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10651


On 2025-07-09 07:01, Alexander Krupp wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> Read the documentation on git-subtree and try it:
> 
>  > git clone git://git.kernel.org/pub/scm/git/git.git test-git
> Cloning into 'test-git'...
> remote: Enumerating objects: 392367, done.
> remote: Counting objects: 100% (7710/7710), done.
> remote: Compressing objects: 100% (1126/1126), done.
> remote: Total 392367 (delta 7015), reused 7002 (delta 6575), pack-reused 
> 384657
> Receiving objects: 100% (392367/392367), 131.92 MiB | 49.57 MiB/s, done.
> Resolving deltas: 100% (296075/296075), done.
>  > cd test-git/
>  > git subtree split --prefix=gitweb --annotate='(split) ' \
>  >                      0a8f4f0^.. --onto=1130ef3 --rejoin \
>  >                      --branch gitweb-latest
> fatal: '0a8f4f0^..' does not refer to a commit
>  >

Thanks for reporting this!  I also just ran into it when following 
subtree's documentation.

The problem stems from this:
	git rev-parse -q --verify "$1^{commit}" >/dev/null ||
		die "fatal: '$1' does not refer to a commit"

Here, $1 is the "0a8f4f0^.." part.

I then tried removing the "..", which lets the command run but then I 
ended up with an empty result.  Not sure why that happens, though.

I've CC'd subtree's author, Avery (as identified in 
contrib/subtree/README), and David, who added this check long ago 
(commit 10a49587fab).

		M.

> What did you expect to happen? (Expected behavior)
> 
> Example should work as documented.
> 
> What happened instead? (Actual behavior)
> 
> see above.
> 
> What's different between what you expected and what actually happened?
> 
> Anything else you want to add:
> 
> Recommend a fix of the documentation. Due to lack of experience with 
> subtree I cannot provide.
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.43.0
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> uname: Linux 6.4.0-150600.23.50-default #1 SMP PREEMPT_DYNAMIC Fri May 9 
> 22:09:52 UTC 2025 (dee422c) x86_64
> compiler info: gnuc: 7.5
> libc info: glibc: 2.38
> $SHELL (typically, interactive shell): /bin/bash
> 
> 
> [Enabled Hooks]

