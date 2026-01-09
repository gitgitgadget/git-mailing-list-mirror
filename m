Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazolkn19013085.outbound.protection.outlook.com [52.103.35.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342D35BDC2
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.35.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964301; cv=fail; b=Zqv7hLU9HESo+1aCnWGwFe5YZg+ykGsa+phIZ2DEHBv5DjsQQavafL7YTQSurV/97ySBT/WEUZR9Prj1Qkbqkvphm62Z0bnYLqRyjQmRZNyzxeKr0x4bm/aQMcMbKIZv16OjP+mLkHP4hGre1hxcmEonCxzZVO+owl2Z8A0L/zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964301; c=relaxed/simple;
	bh=DzF49ASmm4pmeW+83QgwMk3sgs8IYn4INV7q6LOv5rE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WLKgJYUUgadcoXbclzkWKwU6k6brq6bawZuFdYVL7Wm82gh5Q7JKxytN+vAwQ3WW7JoFUg4UIWkGBNMbCyAgjvNis1AZe8rEPEm8STHNkeyMS8I7PrDG1a+9qQn6Ws+fo5uH+VlkzJWhy8pl/TQWwVHkmfr1YL4u8/p4yZWiCXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=qfyTSu26; arc=fail smtp.client-ip=52.103.35.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="qfyTSu26"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEBTOJFi/9ZrlpGUsEwOkhQAOwp2VpiLj/wUmRRkl1uGT8RdEq7/CWBF6BPyGi2zva52FrZ/Xe4L21uIA7abwbyq7EV0kRV5OdFerhPenVq9s7D/K+J/vA8z2oV4VxkLDM3GFZdDzXaJ+yz4a7VOktuTZmnSh42F/FY1oaSu5fqXgyrZsknGeRdhVUkCw0kOi5tQNEH/biCkb5vxTlcWBQR2/bs2Wch2Yv5QJNpqdR+bfs5XpT8MbbKNUAd6OMCgU1JyngaENuQcFDWbz3fuNYqHaT+KsSqMl9AVMNgmKTxpS/td9TEAv4n5mg8yHMGblOAJlLGO/uOOKSjzXDf0OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JM+NC8P3fenPmovS8heBXQQo46e82a3gjpuKh5R5ZzI=;
 b=Ni3sP8MReVlBeoaQcVY5PfPm1WSl805w1zi/PrLgK7Rj/XgaF6WzZ4AnpCHboR0gUEwWpC2U88YrazC7qvcxRip7EY9gym8dCIGOWxEmXxOSMCGT0CYiTftg/VRJwuqGM37St3LKS8zg6PLb6mHgDwF++4IivaewwcxS7W/aq5zi84wsyWZI1alvs5UiOkU0cfGtoOjhtgRn5iHjrRxPyI7nUTGKG9f8WixgvTjyEdWlm9LnWG11cFOhq25IJ7ymXV22cbmBQmhRk83A7ZZKoUNkW2uza1WAqg2/LDenzmk6HdhhAG9jkHPf4UOdSQQZkmDCLTdoy7fcwZP+OwC6pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JM+NC8P3fenPmovS8heBXQQo46e82a3gjpuKh5R5ZzI=;
 b=qfyTSu26mI6st4pfWIwyKwM9nvOWa7gcvR92H4wK9GUBpsNgRqD5zfCCP3kGEbkVcVihVH1ysGbcCfdaDruO3RTYd609Bf0SlR/NXt/Q98JnwJ83VELNd71MDdCl01g2h3iWYq6UW0Dh6DZPCtV6Glztop3CrPoR/t/wLRpKvLvYCA6UOMZuiOx4+tFtyxLMEgdQuljhzU5MKXyd4X46TDaj7I7ts8WphDZpcqx7CLwZtRKx0nXhi+7Gc2ArjXB3JRFpcJgMioE6MVJveQO4UE6fql11pwbgrWxLcG2LHEcTbYr1JAJUeiCPiIgJdbdfb8If1f+JHm5K6Qx4xIIYaQ==
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com (2603:10a6:d10:1a3::9)
 by DB3PR0302MB9258.eurprd03.prod.outlook.com (2603:10a6:10:431::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 13:11:36 +0000
Received: from FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920]) by FRWPR03MB11065.eurprd03.prod.outlook.com
 ([fe80::d94f:c0a:f839:e920%3]) with mapi id 15.20.9499.002; Fri, 9 Jan 2026
 13:11:35 +0000
Message-ID:
 <FRWPR03MB11065C48B7EDE6A172B4F07EFC082A@FRWPR03MB11065.eurprd03.prod.outlook.com>
Date: Fri, 9 Jan 2026 13:11:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsck: snapshot default refs before object walk
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2026.git.1767035549378.gitgitgadget@gmail.com>
 <xmqq344siypm.fsf@gitster.g>
 <CABPp-BGQK5cup9j1nm1fb+2iuaoQnWEzBvGnmUeoCDv0iEH6_g@mail.gmail.com>
Content-Language: en-GB
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <CABPp-BGQK5cup9j1nm1fb+2iuaoQnWEzBvGnmUeoCDv0iEH6_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::10) To FRWPR03MB11065.eurprd03.prod.outlook.com
 (2603:10a6:d10:1a3::9)
X-Microsoft-Original-Message-ID:
 <426c7a6c-d115-40d8-bb29-bd6f06290c4f@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FRWPR03MB11065:EE_|DB3PR0302MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: 9767ede2-790b-4970-dba8-08de4f809d54
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|19110799012|8060799015|15080799012|23021999003|461199028|5072599009|6090799003|19061999003|40105399003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEY0MEhibjRNVHloaThUVGtkWTc0VWJGajE5UGZFQ3RRNUlHaEMvQ0ZWMVFP?=
 =?utf-8?B?NHVtVnhSWHJGTTdUSWZWeWptaEg0RVFDYzBkZ1FJN3poQkkzcC9CZTBiS2da?=
 =?utf-8?B?MFhIL2QwNHV4T0d6NkEvWXprSU1VaGxDdjNDSlRtTWEyUmVqaFJ4RGIxN3lN?=
 =?utf-8?B?M2FJcWhIQ09vVDdiMFF0UFRHcTNKUDAvSXlCQTRmakIrcllIejlmN1BaUEhJ?=
 =?utf-8?B?WHFPeXBQSUkwWm1KNngzUTZRcE9zQVh4WEdEYThRaW5EMzd0ejRma24yejFV?=
 =?utf-8?B?ZEIrMlYvdFdrOHB3L2pHK0IrSE5ieExBODFBTHgyN0tkVEorY2twQmxxR2d3?=
 =?utf-8?B?U3QvdFRmVUkwdHY1dTdReWxNV3JTbEdBVElWZDY4cW5Zd01qdXRoK054dHll?=
 =?utf-8?B?UVRrQlYzNjc0RnJFaEcrem8wbk5aVnVITDV5NEJneFY2MFJNSVBVR2xJTE5s?=
 =?utf-8?B?RWpLWEhOL1R6QVp6YWlPQmYvNkZyMWpLZ0YvVFRYQmpyRmNCYk9DMTJDSk9C?=
 =?utf-8?B?dVhmRHBoZlZRUkxKaHVKMzY5dWQzYlJTNmdZZFFNcDI3WXBuQkVKeFhUdzYy?=
 =?utf-8?B?QlJEb0tqWi9GSWJKSFFNUXdldlVSTk5SSVh2K080THpFelQ0ZnkwVlczRkxy?=
 =?utf-8?B?WTJ6TzFGSEIxdXVKR1ladDRlTk1VVVVCbzBQa1ZNc2VKMU96MzJwRnQ5VHJy?=
 =?utf-8?B?ZXBUUWlaR2pvK3RpbXJDLys4RkNiMHVDSDFENSsxYW90TVNxcDh1WVdRRkJx?=
 =?utf-8?B?Z1dUTThZOWlDSHJIb3REQmtFWFRHNVEzZm1rUytkSmV5SW9aUmVjSjJLdmZu?=
 =?utf-8?B?OG45cU5aNmx1SS8wclBDQ21yMVZiRXJXZ3dxbWRuNVFtQkxHZGhucVdMdTdp?=
 =?utf-8?B?VG5Tc1d4Z3h1R1VSVTRSZk1EMk9GRVpjLzY3TzNXdDFTbHRxM0RqRDRzUFRo?=
 =?utf-8?B?b1pRam85NnByVy9SMTUzaVhmZTREVEExSTJqa2g0RU5xRGg1NVZOd0c4ajVN?=
 =?utf-8?B?dVZpd2pFRjZJZlRqZ1k5Z2tjUmlOUUdodVc5ckFjT2wrOFpUY2t3d2FlK2sw?=
 =?utf-8?B?VTcvQ2xwU3MvNEplTGsxelh3OTJhZW9DRllocWJwWGtuNHR1b01BckpUcHB2?=
 =?utf-8?B?YWpSQUVuMDVUcHlCN2FvVzA5aTRQcHV2OUpsM2x3R2RnOE1SM21wdjJIYVVM?=
 =?utf-8?B?TTFTSkpIb0NKeFpUS0E0VGlBMlZ6bmJ6TDFldGl3Rld2OFQrT2pWM1dFVEdT?=
 =?utf-8?B?bDk2U2lpNkhRK3ZZWU1mZ3Fhc2ZuNWV0alVER1g5MVVIVkJaN0JJMzg5dXpQ?=
 =?utf-8?B?bHBQYTc3SlN5M1ZLamY5QXZVK1hnWHRsWUVqUFcxcldERlFzZTFSWHRESDJ1?=
 =?utf-8?B?c3FIbUxjSldQenVYdVQrbXB2L0lHa1J2ZkxHSk00UVFGYmhlbWZZcGlGYXl5?=
 =?utf-8?B?cFhUNlVjTEJYQzhSaTcxTHFmZXVXK0liMmhRZ0tyTWkxRmpwS05qL2lSeTB2?=
 =?utf-8?B?eXNmbEkxWTV2UTVGZkM0c1VrMEdGZnZaTnNaRnZMSm1VNzZNa3dwa3lvb2NK?=
 =?utf-8?B?ZjFwNVRtbk1xeURla2RlNmVxWWtZdlFOdXR6MkI1cmhHM0k2dHhIbXpUa2ZD?=
 =?utf-8?Q?QmKQRpkGB8rRpfbsRLLoAEjAYzC9NhG60mjYEc2L+qE4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU1FYjgxQm1wbXpYNUQ1aXBycCtZd092bzlsa3ZYbEVRLzZPYXFZNWY0NTlK?=
 =?utf-8?B?cmg4ajFNaU5rZ0J0MUZOWUJtaUtVcjVjY2l3OG1qNHRyNWp2aFBMekdFZUZv?=
 =?utf-8?B?THF1MklERmI1bWt3Sys5YmYyRXpKTDRSSE5BZFB2T3VHUkhKNXVQWjN3dzhj?=
 =?utf-8?B?Tk12b2c3VmRsT2cyaG55QWowR0pURkUzZDFScVN4UTU4VVFtZEgxenJrWE9D?=
 =?utf-8?B?VU0rd1JodWVSc0NqWGV1T2M4aEpHek1TWTM2TWMwL3pNV3pIZmZuQ2FydklZ?=
 =?utf-8?B?OGJiNEJ4ZW9rc01ybmpOeU9CR3JXNXVFUVdYVnNFNTIreXJtVnhPNjFVRXYv?=
 =?utf-8?B?QVJPSWI0N24rN2NOUHQxUDNEc0VQQ2FEbnJGTW9oWFBVN2VKL1NlbFdtM2Fs?=
 =?utf-8?B?MlhqenRQT3dTaXE1blRaZm9LalJNTzV4NHZMdlFGSEt4YkxHMThncDUvMlRp?=
 =?utf-8?B?ZEcyWU5XdDRZQVVMRkp5a0hsZS9jUzU0aVQ1NFZnMnpsdkozT2VSN2VyQml4?=
 =?utf-8?B?K0QwcWF1Ti9CTExNSWVWV2tPMHJGRytiSmdEamN0OGVUMTg3b3NSaEdtNURm?=
 =?utf-8?B?RlJYd2hkdFBQZ2VHTHk1dUN6OHJTcDNOS3dKYUhyWVI3YmQxU3dUMWthQ1Jo?=
 =?utf-8?B?YTBnNmNWTVF6RCt2bzlOcUJWemRzVm5KYzVNMVBQL25iMUlwTmJsZ01ZbjZ5?=
 =?utf-8?B?M3JjMWFGaWJqQUliZjhDQ2U5MUUzK3IxclRhMEJGQ3MxZnVKSHBuTVIxZVpn?=
 =?utf-8?B?dFVHdGtUdUU4WC9KMTVFZXlqUkZaejRLSFFPTmtwekhEUmtrVGtVMTJwT3Rp?=
 =?utf-8?B?QWl4aFB4b21sMldweXZscklhNVJjZDhmVDlLc215aXdCUXdDdmtweHZCcFJQ?=
 =?utf-8?B?YzFhR25rWVZYS1VyRzRxRUhvUnhHS0hkeHJTUEtkbVdqaWZIM0wrNHNkZ3BX?=
 =?utf-8?B?dHh1emllK0RNN25aMVUrM1pTbG1aWTRGd0FZS1NpMWhvSlFIMmEvN3ZObTZB?=
 =?utf-8?B?Z3hTR1ViYXE4QkNBdjZHRVR0Q1ZUVE94MmJyTmFuU1J0QU1QWHVORnB0QWJa?=
 =?utf-8?B?QkFFYS9MTUdudnI1SkRVV21tTG40Z2pWVlJ5L2tYT3RTMzgwY0pvSEl3YUVr?=
 =?utf-8?B?dDdLUEI5SGVvMitxeTBMUXNWRkZnZWVHbGFyOEV0OHYxS1ZLUmRpKzVUZjBQ?=
 =?utf-8?B?NjRWaFh0Y1Z6YUVETnEyY2VXUGhaQ045Z0lOUTdXRjhQWkszeWF1WEszN3FC?=
 =?utf-8?B?Q0N4bUV6OVNRY0hpSnVMMUtvVEdHSWFyMDd4SWQ2cmE1QXdZTXZPWFhUVDM2?=
 =?utf-8?B?Vm90dUkwZTZnTWxncVdLamFSUEZHMjZuWHpYN1Q1QUEvZXZ5LzVXdTQxclBl?=
 =?utf-8?B?amdHSDRyZFFhRVVYNmwwbTlwSjFCUnkvaVdSRnQ0ZkM0NXRpby9xODZyQzA0?=
 =?utf-8?B?TjNBQzZYQ1NreXFYTEk0UUwzVk9NeWJVWnY3L1FRdXpEcUtBdkkyTnJzaTlM?=
 =?utf-8?B?dU1MWVViT0dhS09JbFY4dWl1bXBaa3BGbFhrR2FLa2ZwRjlBWVB1ZzNxV29r?=
 =?utf-8?B?Ynp3Q0dOS2o3MndwUVF3Zmhhek91bEhpZVN2SHV2d1FEQk5wK1ZrWFRjUEtZ?=
 =?utf-8?B?OGdKb0tybHg4c0NwMWV4UDF4ZGlEQmdIaGlnZmlCelFBZXhSU3NZNWNlQXhC?=
 =?utf-8?B?N3lLUlFJQnpqNlBoVG4xYmY4ZzZVTG93emVGRFByM3dYL0ltNXNmUFdrWjJW?=
 =?utf-8?B?MW1LNEEwTUtvQ1c1aVRJOTJIcE8wenkxb2tHTkFuNGxOakp1RkdkSWFNNEVH?=
 =?utf-8?B?ckdiNXJyMVlCTDFjQnNzRVlBcGtUTjY1V0haWWNaUUtRMFpGNFRVVWhTM2JE?=
 =?utf-8?Q?H8GKcDev0pkJe?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9767ede2-790b-4970-dba8-08de4f809d54
X-MS-Exchange-CrossTenant-AuthSource: FRWPR03MB11065.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:11:35.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB9258

On 2026-01-06 23:19, Elijah Newren wrote:

> Yeah, that makes sense.  It'll mean that there won't be anything left
> of Matthew's original patch that I was trying to upstream (especially
> with the further changes Peff highlighted elsewhere in this thread),
> but I can just take the authorship and note Matthew's contribution in
> a trailer.

Please don't bother including any attributions on this. It was something
I was unfortunately abrubptly tasked with when I was at GitHub, which I 
no longer am.

Thanks,
Matthew

