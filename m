Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020110.outbound.protection.outlook.com [52.101.188.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC5219A86
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734709851; cv=fail; b=Wmmam5CfcevOaLmtgGQ521fhR8nSNFGakZNzLrwVQdph7FEQfWZV1gn3phErg1PbPvcH1PfcoZsIcvtB6I+MsrArWIgLTzGTOaAqxf71LOjT3pUXeqEhljJ6tw09py9F1VdqyHxMvC/b/jiRuo8IVKGp909FpDm8P5quWhuMOyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734709851; c=relaxed/simple;
	bh=hJ29pdL4e8bJRbmJeG/94MzwnG/XUrQH2d8YEseLOTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFUSvrLQ3xEOJXyh7xZAB8I9iWtt7HDA33SCkSD3xnSZ9SmhIw6lA2i1lBlEUlDXIiiBLMPaQf4OOacot6SAMpHJYNyKJOyErLSLMKhrf++G2BNVY3ezFJFqm/go/simeF3rC5HXEyeEr4zZiPkmy53WZahDu0R+NGRqRvJFoVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch; spf=pass smtp.mailfrom=psi.ch; dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b=zgdHaDKl; arc=fail smtp.client-ip=52.101.188.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psi.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b="zgdHaDKl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+izCBnJoLHpxmoj/zjz9s9kVIHq1mwJOHe4pYWOOsVnt3p9TydFAsRhVduW58zBqi1VBGurnfDeJFGiFEIH1MM//tKddMTAJlEsjvKLFLdd6r+K7MI76fvBgLk+p1h5TLwRdG1mow9MXEye/1XgdQsQ81beKdjjvsjIbRcsOmigVq83cG8+rEJHVfshZxIGCP5p87mClRLZ0B3nQebHQdiwX8qI+6hF/+BpHyZoXwEGFKLLrFrrdMVYWDv8JRZpxeCgugqd9RJYGqc7VIruntWHjq3tR37r0TPxsrsNXNd1Iy6QXDrXp6e9tiYg0LtsKaV/zWml45ZonPYfzs6Ihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI0OTpexgfnBtdrAVQC0iuDYWgNlZnKVuSg8rA92AOI=;
 b=eOlwIvPXW8EE8b7u62Eum3KQ+RvQpv+2wtSzSWdFtqMmXElQg8XUSQsQ8U4Xly/xxd0q13JdL6ot/sXLnu/gVj5IMg4+2cMiTBNsFL5BLpvPZDRqveXoi33u1vcFxciNu+ICxbkWDLTNY/pOiqzAtgB1+0BDmDW22Q4OqAhATdygbI4NcdgFEGwXYVuIrNVTUvCy+HgyOlVmdfWQrDhlIm34A8txq7bQqU7NhrZwy/LS+y/6wDHpZr8uiE3KfLiHrKuFpiWM1QuV2e45Y1LkphWafrfR7YwZ0cjFtTyBnx+YDcie+Yk5k5DcdVYEg5PakwAPkbg/ts1iNJ2r/T94Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.250.75.252) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=psi.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=psi.ch; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psi.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI0OTpexgfnBtdrAVQC0iuDYWgNlZnKVuSg8rA92AOI=;
 b=zgdHaDKlYrg6OLQZxgXigvVWqLwjzU7SkWs+GAWhQleui8SkNypxyDX2Pv+mDug+VisyYofK6qEuXTesja+WpzfYzpAg05r5ioki2nYzzuiUwwrxLbJ8b84RIez/5o1Mf2QzJArqjDdx3E2hIi2/X0ipnNeEntAQ/lIVBXgoMRDq/EoswhXpseB5O8h1d55fZNj5SmzHfpFR5wF2NJ8WigWbVRDu4BwI0CiIDS2k052BVwFuOMbbZZiwU9vqUMaCpKm67JreTT112Xluia9ApZKhEklEiYM3B1WLEtP4WZYnd3pHrKce5uL/Y0bX6X81hcPGZoRHSiCa9seQHTODBA==
Received: from ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:20::10)
 by GV0P278MB1159.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 15:50:41 +0000
Received: from ZRH2EPF0000014F.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20:cafe::94) by ZR0P278CA0113.outlook.office365.com
 (2603:10a6:910:20::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.16 via Frontend Transport; Fri,
 20 Dec 2024 15:50:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.250.75.252)
 smtp.mailfrom=psi.ch; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=psi.ch;
Received-SPF: Pass (protection.outlook.com: domain of psi.ch designates
 20.250.75.252 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.250.75.252; helo=seppmail2.psi.ch; pr=C
Received: from seppmail2.psi.ch (20.250.75.252) by
 ZRH2EPF0000014F.mail.protection.outlook.com (10.167.241.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Fri, 20 Dec 2024 15:50:40 +0000
Received: from seppmail2 (localhost [127.0.0.1])
	by seppmail2.psi.ch (Postfix) with SMTP id 4YFBhZ6t7LzMvY;
	Fri, 20 Dec 2024 16:50:38 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010004.outbound.protection.outlook.com [40.93.86.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by seppmail2.psi.ch (Postfix) with ESMTPS;
	Fri, 20 Dec 2024 16:50:38 +0100 (CET)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psi.ch;
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::13)
 by ZR3P278MB1401.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:9f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 15:50:37 +0000
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288]) by GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 15:50:36 +0000
Message-ID: <8af7ff11-c5bb-464b-894f-f1fb30df50e0@psi.ch>
Date: Fri, 20 Dec 2024 16:50:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: chmod failure on GVFS mounted CIFS share
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 ps@pks.im
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
 <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
 <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
 <Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
 <c287fbd7-eb08-45f1-953b-5afd4fe41f9f@psi.ch> <xmqq8qsafjfy.fsf@gitster.g>
Content-Language: en-US
From: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
In-Reply-To: <xmqq8qsafjfy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0097.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::12) To GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0504:EE_|ZR3P278MB1401:EE_|ZRH2EPF0000014F:EE_|GV0P278MB1159:EE_
X-MS-Office365-Filtering-Correlation-Id: 881c9fa1-b64f-4c46-54c3-08dd210e0ddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?M21Oc0drNTBJR3VUY0xISEhhcmo5cy9kOUZxbVMxa1R0MlMyMUUzT3FBZU9a?=
 =?utf-8?B?N1NFbnlUbjFOWk9uYkZYNk1hSHNhK0VCTmJ6ZTVwN1Z6NVB4NWk3d0s1U0dF?=
 =?utf-8?B?RVAzb0xXcmQ2OXJUeG4zdFB2STRBL3o1SVpqUlkyM0FaSkt3enRjcWdENjMz?=
 =?utf-8?B?MnhwSytsckZwZU4vT1c1Rlcya3Q0MnRRUWhNR2cvVHNYU3YwT3kyUGprRTk4?=
 =?utf-8?B?OUpkWmcxQVZFMG1EUGY2RjFqWDFhb25zU1cxeFF1WGp6bFVRK2ticXRQY0xF?=
 =?utf-8?B?bXRqRkQzSDc0OTFQa0NuNUM2ME80TGt3blZ1ZnFpeDNMV1dMT0hYK092b0Nu?=
 =?utf-8?B?UndsK3ZmaXJ3a2FqampHalUxSXRHM09ZdEx5RFFKV0lKYjA5MEpaTGw3RVVF?=
 =?utf-8?B?clU4QVhwM2JsMWZjdnltREoyWmxaYjNFNnBTcjFod0MySjBMTXp4ckdOYU1Y?=
 =?utf-8?B?NHp4amRsd1o5TzFaZjR1cVdITHBJR3pRUndyZkk4STVwcG5MNGZGWlJaZEY5?=
 =?utf-8?B?NzhnSzEva1pEb2lBaUIwUkxpQ2lsK0lHeCtZeVMwTUdodnNncE1Ldit4K1hS?=
 =?utf-8?B?Ukx0R2pYVkI3YjVrYXlYYVFvTE54eTZ5VUJUT2Y0YS9rTlc0dE4vUktKanM4?=
 =?utf-8?B?cEdwalZrL3Y3dWtEdkZlS2ZtVDVPM1hna3lySURsbUYycWttT3QxbzlqS2Nk?=
 =?utf-8?B?L0hMZ0ROU254clU3ZWtvQ09CUFp2Z3E2UkRKdFN1MWI4R0ZQTHpCWThMblZJ?=
 =?utf-8?B?SWVGdHJMaTJ0cWdYMGhsckh6dys3LzZ3eStUSElSQ3hZZ3ppY2hEeHpEaks3?=
 =?utf-8?B?VnRzVnhnZ3JsVEZUOVd4S2dEMEMva0lsaUwwU0QrWHJQR3J6M3pCY0F5RWJ5?=
 =?utf-8?B?ZlZYYXRQQm9kN3V4ak5mZmhVMU1oZldiZHRBWS9GTFVPTkNpV3RXdy92dXJN?=
 =?utf-8?B?aHZMd2NmRTg1QnJ5bllGZHJwWGx4NXJyZUtHTlQ5MWZzY25vNlBTUmVUY0dJ?=
 =?utf-8?B?Q0VSeU4zTVFFc0Q2WklIUDJNRGdxelRsTVREcjhZZ2xESktSZFI3aG5GSkRh?=
 =?utf-8?B?NlFhTU9zaVhBL3NWdy9YTWt4T1lvekNFeVYyY01nTnphVzJVbmlEK2JRRVNy?=
 =?utf-8?B?VlNiT0VTa2VYTDl5cVpnZW9FNjVWTjBZeTczdXJwNDUvSzVGWGhXYVdhY25p?=
 =?utf-8?B?K1lpa25xNGJvdFZUeEM0czN6M2dIMTd4UStaNllUcFhXa2F3KzdTRVVIcmJh?=
 =?utf-8?B?eGR6TFNScXM1dHFTcENLS0d5RkJaaU1tM3RSTWZoOGUrd216ME5tckEyOW5K?=
 =?utf-8?B?c1MvWXYvUCt4ZE5nNUVMZzUwdHBKR0NhT2FjMkhSdjEwdThhMVJUUGVOVlRv?=
 =?utf-8?B?QjBNZXRtSVRtcmM2VkVnNE04VGlOZ3Y0aFE4RmZsUmYyTmZNdk1hMWtXSUJL?=
 =?utf-8?B?QzdOWFVRejJVZ1dGWFkrdzV4Ui85c3pvTVF5L0FaSEo5SDVyNU8yY2p2Wk96?=
 =?utf-8?B?ODk1Qkw4U284SHpkWG9DY3B6b05WbncwSGxhcktlL01qOGtiSnF3ZjlvaWR4?=
 =?utf-8?B?eEJOZmIrWlJJSVVFN3N3RWdjNGJ4SkR0WVY0TGVxeFUxcVU3UW8renhNZlRj?=
 =?utf-8?B?TnZ3WWJ5ei8xOXNxQlo2d245NC9RYUNFbS9aZ2R5d1B1Nkt0K1FjbVc3QlYr?=
 =?utf-8?B?R0haVTFXbG1KdVFpTmREOURSWTVocnNoUk9oL3BBeXc5Tk5Sa2pJUHAzWVlv?=
 =?utf-8?B?SE5KYnRnckZFRzhNN2hWWHdCSUEvamJuUng4RkFyRXRqZ2EvZXlJTU5ZS1Nk?=
 =?utf-8?B?RW1CWlBjSHZ3VW5GTVdzR0g0a3lrZG84K0tlZGNQdDh5U0E1S2dtVjBTSmRS?=
 =?utf-8?Q?RLRQSek2qPP7y?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR3P278MB1401
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZRH2EPF0000014F.CHEP278.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	fd4ddcd3-6acb-4a20-c44a-08dd210e0b8f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|14060799003|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmtwaXpnYU53RmMxc21HQlZGNXlHNnRxYTBPQms3UEx3SnJncnJ6NFhmMzNw?=
 =?utf-8?B?MWtHLzlBM3l1MHlIWWxKTWJzMWRVV0E4VDNpSm5xdGtiU01CRGlXLzlXcXF6?=
 =?utf-8?B?U2xuRmp0aUFyWEdXNE9jUmc1QzZpZWtZckxwdHZZOWFTR204SzVXcTl4V29I?=
 =?utf-8?B?OStlb2U2K3h4K0Q0VkRhbEhwcFAxOVg3VnI1T1Y3NWpIcWVxMGZmK1ZwWGo2?=
 =?utf-8?B?bkVnSW1FR3dpREg1ZCtWb2ZOWDNndHFhS1Y1R0pqVGp3RFVhUndrcTNySVc5?=
 =?utf-8?B?LzlNc1IxcFppTkw4RExQcThCckFweXQrNFNGcDIzdHExWU9WMWlwZCswNVNB?=
 =?utf-8?B?MDd5cTFtZFJKTnpYc0x6Qy8wUVRCaFlJT2xuVm1QWTRzaEVrdXc3S3FyNStL?=
 =?utf-8?B?TDhIaW9XRmpRK2NUazMwQWloS2V0L0lpcU9XUHhGaXlrUHM0OThydThuNjRt?=
 =?utf-8?B?dkR1cHQyNXo1dnd6c0J0NXk3cElIbFBPWU5KUkhITkhldDFLenRhWTJ5K0FZ?=
 =?utf-8?B?a2VpRnZManlKZUt4TjliaFJrak9saHg4TUV3WHBVeGZ5d0VjSkovdzh0a2l2?=
 =?utf-8?B?VW9uR3pGN05QVzRxL2lGT215ZXhtV3VaQ0NhYk9VZUw0cEl5YXVTbHpaMVlV?=
 =?utf-8?B?UThSVU5IZVhtSUs1LzRMYjBueTdFTEhoZk12dnV5ODM1cytOYnV3SUY3TnMy?=
 =?utf-8?B?ZXZ6ZXdIdGc3YkNMcHp5R2VESmlMOWpDYSt6MmppbmJIeGJVTWtpaTNvbkxw?=
 =?utf-8?B?UGtzOE9jcWsrWGF6UXdKTWhycnZGTHdCQzNJeFlmcFVZQ1VEMVFYZFJOUkk2?=
 =?utf-8?B?Zm14Q1FYT1lNaFRZa1pTbG12MllpVHAzTkttY01jbGEreVViU05zTnhPZ3po?=
 =?utf-8?B?QjR1TEVwVytGaWVGNkJpcnVGeWNLRDR6V1J5d2E5eEhTYURiOUsvY3BVYklS?=
 =?utf-8?B?bU1iR2liVmozUGtrNXhUQmt0OWVZS2xJNitlWEpsZXNmM0VHTkhsM0JyS0hM?=
 =?utf-8?B?dyt2cmFsanlPb3ZDMU1DOWFBeGVLeHNsaFdiV3RZME1ld3d5T3pCa2Y1Q1hv?=
 =?utf-8?B?UUFoVUkwSFp3cXBWa1lCMWNMSnl5RW53VGtLVWVTajBqendVbUFrYXdEN1A4?=
 =?utf-8?B?VVhXVTVYZG4zYU45bXdqdmw1cVB1dk12TG9IdXViekxSVllHRmN1Z3JjTjJU?=
 =?utf-8?B?TzhCVzFqM1JVWGIwenJDSTc2UUtqcHB0OXp0R2NjODUvOXlJeTVhL1Fwakto?=
 =?utf-8?B?bkcvaGN3cVVNVzVyRHE0MERDeENTVDdQVnBTNWw5MWNCcVkvU202YjBpZGZO?=
 =?utf-8?B?blQwRE1HWlVuUTJ5VTNIa1Z0QVI3aXhQWW1TMUwyN3FNeGp1dks3bmg0clhP?=
 =?utf-8?B?MVFaR3RKS3hmTU1BQnZIY205TUZzUkd3dFpuSnR3aU1lZnkxUjR3Q0xiRjZP?=
 =?utf-8?B?QjlkaVJkQkhnZjJWcU0rdGtoWjc4dGxtMWRXNGd1RW9vS01UVFRwTVZUZlFy?=
 =?utf-8?B?dFBBVENiUjBjSTFtVmJMYXpJZHNHWitPU0VTKzRIdDE5NnY4QnFiRzhveHJL?=
 =?utf-8?B?MFl5cWRuVmxCTWdYZ2dvUmhxYlZCRDgzZnE3bFNTalFOT0ovTW1GVUJwbURv?=
 =?utf-8?B?R3c5bFBNM1dEakI5elJrTkkwTHZFanlvQUx4eEszNkEvRzFvNmVQK1lkY052?=
 =?utf-8?B?YXVHMUNFWWNxTjJnM1lLRDlod3EzRC9UYUdQMUFsV1RtRm4wY1IvanQ0L2Y2?=
 =?utf-8?B?VWNzc1ErMStUT1JhNXlxSUMwdFdvSndyRElmZ1R5Nk82azlEOGhJdEEzUjI2?=
 =?utf-8?B?KzNpUWlscVBtT0hvczVSRFg0SVd2M1d6cUcrWmM2RDUxVnByVUdjdU52NHox?=
 =?utf-8?B?R0VxQ3djL2VXWXdZWjRzUlhHNVcyTXNhYTFreURXVVdJQ01ndDVwelptY2dx?=
 =?utf-8?B?VUV6b2NJdFlaQk1YbktYU1FDYzNQRTJvakk5VGpyMitMMU96VS9kUmRBWW9C?=
 =?utf-8?Q?3ZEykdOzKHrB7qWAWVTyx4zQXu4y3s=3D?=
X-Forefront-Antispam-Report:
	CIP:20.250.75.252;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:seppmail2.psi.ch;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(14060799003)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: psi.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 15:50:40.1564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881c9fa1-b64f-4c46-54c3-08dd210e0ddd
X-MS-Exchange-CrossTenant-Id: 50f89ee2-f910-47c5-9913-a6ea08928f11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=50f89ee2-f910-47c5-9913-a6ea08928f11;Ip=[20.250.75.252];Helo=[seppmail2.psi.ch]
X-MS-Exchange-CrossTenant-AuthSource: ZRH2EPF0000014F.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1159



On 20.12.24 16:44, Junio C Hamano wrote:
> "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch> writes:
> 
>> I have another idea: there is no need for a chmod if both the config
>> file and the lock file already have he same mode. Which is the case if
>> the filesystem has no proper chmod support.
> 
> And for majority of people who have working chmod(), would it mean
> one extra and unnecessary system call?
> 

I do not have stats, but I guess the chmod call would be needed very 
rarely as most of the time both files have default permissions. I do not 
know which call is more expensive.

> Instead, how about doing the chmod() first, like we have always done,
> but after seeing it fail, check with lstat() to see if the modes are
> already in the desired state and refrain from complaining if that is
> the case?  That way, we'll incur extra overhead only in the error
> code path, which is the usual pattern we would prefer to do things.
> 
> So instead of removing this part, ...
> 
>> -		if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
>> -			error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
> 
> ... you'd do an extra lstat() on the lock file (so you can move the
> st_lock inside this block, narrowing its scope) before calling
> error_errno(), and only after finding out that st_lock cannot
> somehow be obtained or the resulting mode is different, you call
> error_errno() and arrange an error to be returned, all inside the
> if(){} block of the original.
> 
> Wouldn't it work even better, I wonder?

If you think that is the way to go, I will adapt the patch.

> 
> Thanks.
> 
>> +		if (stat(get_lock_file_path(&lock), &st_lock) == -1) {
>> +			error_errno(_("stat on %s failed"), get_lock_file_path(&lock));
>>   			ret = CONFIG_NO_WRITE;
>>   			goto out_free;
>>   		}
>>   
>> +		if ((st.st_mode & 07777) != (st_lock.st_mode & 07777)) {
>> +			if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
>> +				error_errno(_("chmod on %s failed"), get_lock_file_path(&lock));
>> +				ret = CONFIG_NO_WRITE;
>> +				goto out_free;
>> +			}
>> +		}
>> +
>>   		if (store.seen_nr == 0) {
>>   			if (!store.seen_alloc) {
>>   				/* Did not see key nor section */
> 

