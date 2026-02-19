Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021087.outbound.protection.outlook.com [40.107.192.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C536342523
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513828; cv=fail; b=AMx6jlkCouyLc3QViQPSQwKTdMMof3z/oC6G92hxD7yVnqw+2OINSlkMI45WnDaA90LcL/C24pMmt3j+uGXw4lHFRvCvYAEamB2U1a3jMNr+MiaBUp4Q3K5rDUf0YGxUerzkl7sFK5PoBbKdUMssjCB/5mQ5A+MfcwfAZ5WVFw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513828; c=relaxed/simple;
	bh=aw4mCpHmV7iFrzXS8xsRjkGNQVpRurfOIZRTLFq5Y5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tp7mfU4ordvrI6E/yVmVfVBbuQ2t2f7F4sQ/H1YHbonIAvqIyd1RPNHnzGcSQbADI7R8Xit7zxdutw2KAcWf22NLn8JBh1NKZQvRiG5m4NMQWKOYqcMpfie4haK6snaON3F+IT+5uFems0B0LansR2g7E7iJG6dNMcFnFWS5ifY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=NoGCULgO; arc=fail smtp.client-ip=40.107.192.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="NoGCULgO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6EbjzEWBpwaCNAf/EZ07WlCnkJS/bZXn2xbumnPEbiLSwIzrvp4aOAcyibwucliVuaQucE/oPDcYnNCJhVXiNhU23JE3HDBmuiZy4Sj4SlLAVsTzvUpJ3zb1Lgssz7PArt0uit9gCOW/08BMTAH9b9cdAN6coH9YEj4DbN+3BoU2wE3CkGS5n5TuUMOpf1drMFjFmCpwcm5j3C7Ujg8lHyyk3sAbnMZc9H6XqdrS811LyjYF3HXt1KA9MjtRkEzD6ctIIQjpKvSJE7cpi72CLDV7xc2BdXa56s59vZ+ziJWMyuix+9gIqmK3o58yKRZgS//nFuMKKQFzUgK5Ip/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cueaLcuzt9E2w2bL4mzPGkcXu60uZoyy4958vtxVRbc=;
 b=lFw9fXQULQSxeSDhK5/X+MsW3+dDeJgiJWJ2T98fEg27IfLvSXH6ZJKxLqdiosgAnRhfEENlNf+GkO44zGWXUyXzF/2mjXYWtzTsaUWj9G/hnWeJlaHQj3wYqFo4Z3eorb+i6g3p5a86vb1qG1lwm+EqUArKtfQhrO1hxl5kQVLAXUn8Q2mb2UN+kJLtsmVWoRKJGXnwD+TGQ+5QuV4Og1KSDwkUZcKoHCmVKSKTSYAyvdkD9jPN0UuJUQfHqAeQqx9nNLg0fzMUDU3hR91bbK5YcN8DdpUH/2ONCCZeQbqFqy1441HMaDEohFs+2AXQmtHYqCQaActIqylFEu39yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cueaLcuzt9E2w2bL4mzPGkcXu60uZoyy4958vtxVRbc=;
 b=NoGCULgOrshNEdbZcLDbhRhJuicWjydyrN22IReKXQFWHb1JkHaLMhj1JmBwyYA7C8wTwwq45omPrTmsYwTrcQCV6owPZMYuRv4P6WDOqZQwF5QiOjvUh8oyMqkRGW+3DrAxQLt0OwD/kiNQufY0hsnLCm66T7LikoNCX8TZ9qoJ6orZV6T3Z+J2xaBpOqh2sZ9BkUW4wrcjMRYiR74vtyDEbcFBfHm2Up9LA25TQGGRysYz1cqgE0xHURNXaw50rkoe3Uzh1vqGLIhSyHAhvV09HSE0LTk8sTfm1iMH1Ez4NBTOemmd7syLPjZqBbM9FWKtZN0aDQRWgcPnQLNouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:9d::13)
 by YT3PR01MB10299.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:90::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 15:10:23 +0000
Received: from YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c]) by YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::8883:cd78:f84e:9c6c%5]) with mapi id 15.20.9632.015; Thu, 19 Feb 2026
 15:10:23 +0000
Message-ID: <b40e96e3-7e22-454c-a69b-56af45795470@xiplink.com>
Date: Thu, 19 Feb 2026 08:10:19 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation
 changes
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Evan Martin <evan.martin@gmail.com>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0331.namprd04.prod.outlook.com
 (2603:10b6:303:8a::6) To YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:9d::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB8403:EE_|YT3PR01MB10299:EE_
X-MS-Office365-Filtering-Correlation-Id: 646cddd1-1258-476b-13d8-08de6fc900d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1c5dVRMbEF1TGU5cU9qNE9DT1VaV1FwYzFkd2IydzFLMFExK2lySmJuRVJ6?=
 =?utf-8?B?QXIvQWh1MFVCZHVlMU5VTUcyUitBaW03anVRS3VuZldCckY1YndsM08rbVU1?=
 =?utf-8?B?cm53QTdHNHNHdHIvczg5Mm13Z0N5SWtEVHNPWlE1Sk1CQVdEckVHUi9qdEpy?=
 =?utf-8?B?YnArRXArTmFHazBUb1k2aDNTREV2cDk4Y3NHMEovU2ttdHQxUi84N1l4cjVk?=
 =?utf-8?B?alRZOXBoUCsrdkE1Vk95R0pIbkVkc3hTc2xNZWM0c29rZEJhV2FockFlRytK?=
 =?utf-8?B?a3BOYVNuN3ZyYkIycVlhUDdaemtxMVpqRlVKTzh0VDAwU2cyVGlHS2xiV2xt?=
 =?utf-8?B?T1plMkhwbmYwaENCNXBvTHNwajV0UW9KNUg5bWNLS3RsQkRsc3RoUXQyRkNw?=
 =?utf-8?B?MHNZcG9GSm5XY0JiTEMxQWRVbWlhM2RPNGhkNS96bFZJUGZINElVNW02Uk96?=
 =?utf-8?B?L1ZWMXFyWGExYitDUjk0MDVzSk54bVNtN2pVTDJwT2lPK3VVQWdTaG1UamZN?=
 =?utf-8?B?MC9ReDBHdWtUQmIwdi9PSDN2Y1NaS0Fka2c0d2phazhUNmc0MUZva2NsNHRv?=
 =?utf-8?B?N2FTYzRWV0tQUURSL0pMZktSRkhwQjFLekZZaEgxM3VMREJtQ3Zia1htWWtL?=
 =?utf-8?B?TjJPYmJ0SjhCQjJzak5PVzdiOXl2T3Jremk5ZjFjWDlVQjQvNTJnOGJmS3ha?=
 =?utf-8?B?YnR2WVRtRllBdk4wZ3p2ajhjeFVReXhUTVBxZ2wvdXlkalhOVWcrRXh4aWNP?=
 =?utf-8?B?b0ZXc3VKVU5FdE9PSXZVUm1DWE9RcEF0SUw0MjRWbG4vSVQ4NzN1cG9MRy9l?=
 =?utf-8?B?azROVTQ1RWJxZU5jVFpjVEJyVHZ5S2E2UTNweHBzTUNaSmxzdUJkY3J6cVlN?=
 =?utf-8?B?WEMxdmd1QXFLOE9DbHBrR2V4QnFTenFWTmh3dEZTRENsYzRNYWkzNHhzK1Ir?=
 =?utf-8?B?MUhabW9YNVdYL0FjcWlWTG0yUGdjL2pEV0l4bG83dDI3ZGtjeDJ4Q1E1VjYw?=
 =?utf-8?B?M3hyM0szNlZHbS80V2cvRWswV01ucmV4SzNnN000Q2xYalRPU0hVem8wbU1r?=
 =?utf-8?B?S2MvMVpWM1YrcDVTNXR4S3Z2NUhqU0xiNzU0dGFEZE1ORXIrcVpsVVJtZ0l5?=
 =?utf-8?B?YkFrVmZzUXM2YjYrdlZ4U2EwUTQvYUdyam1saHdjSVhsZmRSeFNQT0VpcWdv?=
 =?utf-8?B?ZVdaK1JnRnBOOHBIRktGMGNWVDhsekcrSXJHaDloR2VxN0I3NTVEQVIxc2RV?=
 =?utf-8?B?VHMzMWNXOEovMGErMEJOVUUzYlFCSjRBaTdNaXRpQy9oSXJ1dFdxRTdqQUdo?=
 =?utf-8?B?WW82ZldzSVhKNlA2RXJSTmwyVFh6VG1hN3dDL2preXNGeGRLeUtqOXU2S2lY?=
 =?utf-8?B?VWlBSm51YUZzOThFSjBaeE9XaGxwcWljSTRPSVAzVUgvTUVhTzZPc2lOelcz?=
 =?utf-8?B?R2lPVTFDOE81aFBndnZDeXRBcnlldm5NTkZzSUpHM2RnWE1kczBtY3JJOTR6?=
 =?utf-8?B?RmtCYW5SUXlkZ3Z0eDJsOEwwSTdjZFEzdi9aRm5MS1ZrYm1obm9zQUpiWmw0?=
 =?utf-8?B?bzVPYUoybTU2bEMwclYxQlEyQXU1Y1lzTS9nQU9ETHRPMHpSMG11TnFmZjJm?=
 =?utf-8?B?dDdTR0ZvVWgwc3BveC9UZkNjNmpoQlFjamtRS3plSURCMmZENTNvSVh4N01T?=
 =?utf-8?B?S2hCc1h5VE5kL05CYUppY05VYjFpUHRkbm9nekw1cTR2TlM4Q3RvVTBoeUl0?=
 =?utf-8?B?bjFYK29WdCt3Y3I0dkUyZWNudy9oeHNLZmNxQ1lFVDdzb2h5M1BmMUcvT1V0?=
 =?utf-8?B?T2pIb0d0UlllcU5HU0NHME9wSmtmOFJCaWZORitlVFppV1ZxMFpaRC9uOXlu?=
 =?utf-8?B?NW1QdXVQbHBsTzRURUFzOStsMzFXYzhiKzZoT3ZnUDZTK1FIMkhHN2EySzcv?=
 =?utf-8?B?ckt1eGF5SGVCR2dZMXVmVUNLNDFnVzRRanhDbytEUnQ0dmMwSFh6QVRoMU93?=
 =?utf-8?B?emk0QTFpK1NXb0pkYWsxV3pXakpHVUVnbUdXUFIwcUFqU2U3VCtlZ1EyL0FE?=
 =?utf-8?Q?B9eRhY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGhvOUZJR0xjU004OXV3OEdFVHlTQ1g0V0xqeEpJVGFsL0FGZ3RGeU1MUUcr?=
 =?utf-8?B?emhpdnBTbVppY1NDUmdCR0ovdlZ4b3dWeE1GOG0rbTJJd2xIa2VsejYvTzFQ?=
 =?utf-8?B?MmNXRlQ0cFhtNmRqMW1aQVowYUl2eGtXMTVSNnRYekZCTWRDc0NyTmpjSGxB?=
 =?utf-8?B?ZHQxS2xXalo2K1Rpb0hwVnNSV21FdkZXU2lINTM2cFRGcG0rUUhVeUhQN2Uy?=
 =?utf-8?B?ek9sZHlOOTVZeHdJdExKdlBWbk9wdW1mbytJRVNrUzlndFErYVZyVEVvOXRu?=
 =?utf-8?B?cGMzMWo2M1Zrd1JBZWltZS81NEh6eGIzV1BsMmkwMjZlZlhKZGh5VjJqcExL?=
 =?utf-8?B?S1hyZFdlZWtNQlBWL2tqZ0VDUG9BLzNjYkdtWjJuK2lTUlRpaTlmcEU0c3ls?=
 =?utf-8?B?Q254YlJRZmJrZmE3Qk9zRVRIUTBtZ0laSm5FRG1tOHMxWHNtWUJ3VUM4d3k5?=
 =?utf-8?B?U0NKMEh4Y3NScUhxSVJhTjVETmNpQkdRaFZmZTV0bkxjT1Foc0s5V0c1OEV0?=
 =?utf-8?B?VWRvNk5XWC9Sd0xnZTBybmxJWktvd3JsVG8zS0hMSmtseHlKYVB2SWJqVm5U?=
 =?utf-8?B?eC9VUDZiNFNDM3dMMU5yNVpTWk83NG9NMk8xZ29zMk52Y0p0a0VPMHFaMHdm?=
 =?utf-8?B?aEJCdXRtbW9veWN4V1VrT0U2UnVLY2xuN0pZQ0tuN2FaQ0sxdi9FOHdhTXI1?=
 =?utf-8?B?WllwMk5CdDNBdDFjMUtwRlRnNVVQMENPTFZRRjhNYVBZenNoTmRML2RsT1d4?=
 =?utf-8?B?ZmRZd0luTS9xcDhkY0pseUxHNWMwemVab3U5WVpEbVRqM05iNHVuVTg2VWR0?=
 =?utf-8?B?aFdiQzh0MnZnRDk4SzlvaXNjdVJBZXFuRGx3eGlhT3FRbFlXZVFtS3lLcG80?=
 =?utf-8?B?UUgwa0NqQkQ0bnA5ejVTZWhrdG5NTWdMWkZHbkVEQ0FYeEh0WVFPN3JCVlU0?=
 =?utf-8?B?YkFUUllYbHlLRno0T25QL1ZXczBFMWxlRVN6ZzNtMnZ5NXZyS1BxNzBybHNK?=
 =?utf-8?B?Y0RzdldWR2tWQlpwaGp1WlhSVVZCSTUwVGFJdmkvWVhUR3c2NDdjZWdiS015?=
 =?utf-8?B?R29jNXdsQ25zbWNCM2lvTUZKaUZQTXU5ekZ2WDRBcUd3Y3NDS04vYnRtckdK?=
 =?utf-8?B?NU9jTmFmcE9jU0RMUTBjdXhDUm5vR05SZkpOK3BQS1l0a2ZTRFZGNlp1VlBx?=
 =?utf-8?B?N2czM0hpL1kweDlnbUg2Tko3eDJPamkySXZmclM5NFZZZnFwcWZGbWxadlhz?=
 =?utf-8?B?L05teUMyOWtTL3dPQ0hEa21KNkIwRHErK1FldFlXT3hxVGFSOTN4Z1JQVTFY?=
 =?utf-8?B?NFFTdGlVSzN2b3RZdHUzeEdEVTRZc0Q2NUpVL09kTkxWdkdjZXpjTEplNlVw?=
 =?utf-8?B?Y0NxeEpUUEw4VnhOZEpGL0VrVFVucnBhK2ZwelFmOHd0eTExTytoM29yT2tn?=
 =?utf-8?B?M1k0R3ZqWDY1NWh6RXJkM0VOUEdKWTgwNEY3YjhNMWg0eDNWaGtGYmY2dyt1?=
 =?utf-8?B?ZFdEcXBlQThHOW5PdnRLNmxsRHNyMm81ai94R2NmUkFzcHBueHlPNVI0T1pi?=
 =?utf-8?B?Wkc3QWRmOUJIR3ZlSXZwSHBodHBjRkd4N0lrNUUveHBwSjRtWXNjUlhKRVVG?=
 =?utf-8?B?U25BU0U2ekk3VTYrSkgwSHFUNlhZU2FUNCtlN3lXL05tZDVlT2lTLzEySVA2?=
 =?utf-8?B?MW9HeFBtSElmdVNjeVR6YytEOUQ3NEIyQU5HRVZkWFUwWUg2c2pjNTJEbllD?=
 =?utf-8?B?YzB4OTdkSzRYMXdMR0Nuek1USmJ3UzB0cHBxbEhhQzJoTDN6aGVOb3VqNm15?=
 =?utf-8?B?a2xoUVI3UFpvQUpzNUdGMTRUQTBzZGN2VW9HUHIzNi9xYWFUNmhSaUExN0RD?=
 =?utf-8?B?YjQvSGRxekxHWEZRcjEyVWJielhXNWVmeWxUMEZJWWJ3VHQ2dGw3a2ZQS1Rw?=
 =?utf-8?B?a1hlQlBDcVBiUFIyekorMVEzUURWU3hZbzNnNEVuMUx2WVBlQzkweUZNSjRM?=
 =?utf-8?B?VEFRcFQ4d0szUzF2dVlWWGY3QzRGYllVTCt3NXVRRG5wUkVSWDV4Z3NFTElK?=
 =?utf-8?B?Z3dFMVZlby93ZE1JS0dQVDRoZW8yQUM1T2JvOEhiWERyYUtjb05ra21mSmw4?=
 =?utf-8?B?MTdZb2pkLzVOTlVvcmlLQkhFTytXaHNlUmFJaHlrUllUTDlmVmdGSjZBL3Bo?=
 =?utf-8?B?SjZFdVV2c0FsQytnSXZTNzd6cVd3SWd1SjRaVjJUNStuM1k5N1c5K2x2RGV2?=
 =?utf-8?B?RWhFbzgvdGdydmtpMTVNc0w2Z2Z3PT0=?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 646cddd1-1258-476b-13d8-08de6fc900d8
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB8403.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 15:10:22.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: itZYsHCPCiEih6rHTcxUht4WkNM0hVcej2NylNXvRu96MTZcasIKniVxYJQjAffNftj/OYS/OmBlC0tF7oZCSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB10299


On 2026-02-18 07:37, D. Ben Knoble wrote:
> The Meson-based build doesn't know when to rebuild config-list.h, so the
> header is sometimes stale.
> 
> For example, an old build directory might have config-list.h from before
> 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> from sources fixes the artifact and the test.
> 
> Teach the meson build to depend on the Documentation files that
> generate-configlist.sh reads by having it an additional output as a list> of dependency files, since Meson does not have (or want) builtin support
> for globbing like Make.

That sentence doesn't parse.  Maybe this?

Since Meson does not have (or want) builtin support for globbing like 
Make, teach generate-configlist.sh to generate a dependency list of the 
Documentation files it reads, and have the Meson build incorporate that.

		M.

> We assume that if a user adds a new file under
> Documentation/config then they will also edit one of the existing files
> to include that new file, and that will trigger a rebuild. Also mark the
> generator script as a dependency.
> 
> While we're at it, teach the Makefile to use the same "the script knows
> it's dependencies" logic.
> 
> For Meson, combining the following commands helps debug dependencies:
> 
>      ninja -C <builddir> -t deps config-list.h
>      ninja -C <builddir> -t browse config-list.h
> 
> The former lists all the dependencies discovered from our output ".d"
> file (the config documentation) and the latter shows the dependency on
> the script itself, among other useful edges in the dependency graph.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
>      
>      • Include Patrick's suggested Makefile changes. Note there's no quiet
>        equivalent for mdkir that isn't for the current target's containing
>        directory…
>      • Make depfile output efficient again, thanks to Phillip.
>      
>      I've kept printf instead of echo (from Patrick/Junio) because I think it
>      is easier to reason about ("it works" vs. "did I use this in a way that
>      might cause problems").
>      
>      Junio asked about other problematic bytes: the other one I could think
>      of (since all the inputs should be paths, anyway) is newlines. I gave
>      meson's depfile.py a glance [1], and it looks like they don't handle
>      newlines in paths. Other whitespace doesn't appear to be an issue (see
>      "elif c in {' ', '\n'}"); I think _most_ characters are just added to
>      the filename.
>      
>      [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
> 
>   Makefile               |  5 +++--
>   generate-configlist.sh | 11 ++++++++++-
>   meson.build            |  5 ++++-
>   3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7f37ad8f58..6f926ffb1f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2688,9 +2688,10 @@ $(BUILT_INS): git$X
>   	cp $< $@
>   
>   config-list.h: generate-configlist.sh
> +	@mkdir -p .depend
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>   
> -config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
> -	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
> +-include .depend/config-list.h.d
>   
>   command-list.h: generate-cmdlist.sh command-list.txt
>   
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..39ac8845ab 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -2,10 +2,11 @@
>   
>   SOURCE_DIR="$1"
>   OUTPUT="$2"
> +DEPFILE="$3"
>   
>   if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
>   then
> -	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
> +	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT> [<DEPFILE>]"
>   	exit 1
>   fi
>   
> @@ -36,3 +37,11 @@ print_config_list () {
>   	echo
>   	print_config_list
>   } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"
> +then
> +	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
> +	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc |
> +		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> +fi
> diff --git a/meson.build b/meson.build
> index 762e2d0fc0..74b459b004 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>   
>   builtin_sources += custom_target(
>     output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>     command: [
>       shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>       meson.current_source_dir(),
>       '@OUTPUT@',
> +    '@DEPFILE@',
>     ],
>     env: script_environment,
>   )
> 
> Diff-intervalle contre v4 :
> 1:  e2f4e1f9ba < -:  ---------- completion: add stash import, export
> 2:  9cdcc9de04 ! 1:  611a94cd98 meson: regenerate config-list.h when Documentation changes
>      @@ Metadata
>       Author: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
>        ## Commit message ##
>      -    meson: regenerate config-list.h when Documentation changes
>      +    build: regenerate config-list.h when Documentation changes
>       
>           The Meson-based build doesn't know when to rebuild config-list.h, so the
>           header is sometimes stale.
>      @@ Commit message
>           of dependency files, since Meson does not have (or want) builtin support
>           for globbing like Make. We assume that if a user adds a new file under
>           Documentation/config then they will also edit one of the existing files
>      -    to include that new file, and that will trigger a rebuild.
>      +    to include that new file, and that will trigger a rebuild. Also mark the
>      +    generator script as a dependency.
>       
>      -    Also mark the generator script as a dependency.
>      +    While we're at it, teach the Makefile to use the same "the script knows
>      +    it's dependencies" logic.
>       
>      -    Combining the following commands helps debug dependencies:
>      +    For Meson, combining the following commands helps debug dependencies:
>       
>               ninja -C <builddir> -t deps config-list.h
>               ninja -C <builddir> -t browse config-list.h
>      @@ Commit message
>       
>       
>        ## Notes (benknoble/commits) ##
>      -    Changes from v3 (<0a344f1f3ee4a5d95c6f46df030b9936db4354a1.1770853297.git.ben.knoble+github@gmail.com>):
>      +    Changes from v4 (<9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>):
>       
>      -    • Include the script itself as a dependency via depfile
>      -    • Fix output path escaping (spaces, octothorpes; drop backslashes) for
>      -      Ninja (I've used a loop because I couldn't find a portable construct
>      -      that could escape only the remainder of the lines in the way I
>      -      wanted).
>      -    • Mention our assumptions about Documentation updates triggering
>      -      rebuilds
>      -    • Also include some debugging information in the commit message
>      +    • Include Patrick's suggested Makefile changes. Note there's no quiet
>      +      equivalent for mdkir that isn't for the current target's containing
>      +      directory…
>      +    • Make depfile output efficient again, thanks to Phillip.
>      +
>      +    I've kept printf instead of echo (from Patrick/Junio) because I think it
>      +    is easier to reason about ("it works" vs. "did I use this in a way that
>      +    might cause problems").
>      +
>      +    Junio asked about other problematic bytes: the other one I could think
>      +    of (since all the inputs should be paths, anyway) is newlines. I gave
>      +    meson's depfile.py a glance [1], and it looks like they don't handle
>      +    newlines in paths. Other whitespace doesn't appear to be an issue (see
>      +    "elif c in {' ', '\n'}"); I think _most_ characters are just added to
>      +    the filename.
>      +
>      +    [1]: https://github.com/mesonbuild/meson/blob/master/mesonbuild/depfile.py
>      +
>      + ## Makefile ##
>      +@@ Makefile: $(BUILT_INS): git$X
>      + 	cp $< $@
>      +
>      + config-list.h: generate-configlist.sh
>      ++	@mkdir -p .depend
>      ++	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@ .depend/config-list.h.d
>      +
>      +-config-list.h: Documentation/*config.adoc Documentation/config/*.adoc
>      +-	$(QUIET_GEN)$(SHELL_PATH) ./generate-configlist.sh . $@
>      ++-include .depend/config-list.h.d
>      +
>      + command-list.h: generate-cmdlist.sh command-list.txt
>      +
>       
>        ## generate-configlist.sh ##
>       @@
>      @@ generate-configlist.sh: print_config_list () {
>       +
>       +if test -n "$DEPFILE"
>       +then
>      -+	for doc in "$SOURCE_DIR"/Documentation/*config.adoc \
>      -+		"$SOURCE_DIR"/Documentation/config/*.adoc
>      -+	do
>      -+		printf "$OUTPUT: %s\n" "$(printf '%s\n' "$doc" | sed 's/[# ]/\\&/g')"
>      -+	done >"$DEPFILE"
>      ++	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
>      ++	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
>      ++		"$SOURCE_DIR"/Documentation/config/*.adoc |
>      ++		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
>       +fi
>       
>        ## meson.build ##
> 
> base-commit: f7e9f6c205466443107228e036b20acb7baa8c50

