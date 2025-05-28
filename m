Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011039.outbound.protection.outlook.com [52.103.67.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728520B806
	for <git@vger.kernel.org>; Wed, 28 May 2025 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748425348; cv=fail; b=MYDMxjYcNkkttpHqZ5Tx7lsCZ35hRrluTAPLvATBxX9tmBlgGsBFs/6M83iC7K2qf86DNjnxnBQvvizPBa5LMB8hcHx4mwY6fdmKzjlwuUJP4AbISl2W7y3z1GxeqbWV4uD41uJm1B8JNXTBvwSbE0bmhB9DEW0Zds4cAICE9LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748425348; c=relaxed/simple;
	bh=WMtFcHeeqSzwAiD1G8x/7I+jH0alBccZqj9uKyDtL/0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGY0LFvv1yqIS2u89vmA+jSvdQkNh1WEIGziQltL0Z6pKM3LxHo/FjRnyOm95SJP1Kfaa0pZpeR1e4/aVhSnzPx/yf/PgHUdcBDA8nTzwk1AIE+joP6vrkyqTUUamtgkgujDaVEvUeluYX6/Vbosspj+44wwBbkUFZtxb4TxeMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ARVf2hIE; arc=fail smtp.client-ip=52.103.67.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ARVf2hIE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwhNzZXOST1tyoOnfRvRHFjC6mE8oucogj1FmAY0f5y4zXoigWowa9oHOEFYVBrTwIdI80uJNSbOZOEFAeoN+0J7Nd38hVMN4ZgcbKf2w+c8EwwIyLavjtLvWpe4jVCDil5oN3Vu5vMpm+7t+iARUBwGlc102uKGHdnXMSh2l4fAQvQWsCOZmCqVAIqNEwy9ksMxT0Q9kFj67DOOsNzWYR8uWr6xHqcID4zZD6kMHu0BrlHmF+XvUiMDG1Ky6znF4Kwk3L4iNrdshX1BxhJ7vW1DFSYuAXRF619OF/JY6AiORc/Zg2lUgl2bc+XEkNJqwfmkkbAuX30oHsDb+w+EeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM5Kj8dPCUyi/9BqCJBkxkPqg0VUCRR4O8YF5abemL8=;
 b=ml/Q5ED0WIXXq1lJwMbVZyII6aPZFR9zel/qWBkyxkb9Heno26yyl/k4uloVRNXklXqykp6HHrP5oxeg33chiuOr2tu+N33V//cLjIrXWVUdAgRBwb5KPsJMct5pP+NWtVQqFdn3lG9Vx3zADpEXlYTil0I52ZtzlxgA+HoctoB+WZn/lvdfzFzzxP6BV99cZLh9R4wpybrtZpKtiyNDGXEccqBjj4AR/qEAMg0Z18tvpGgvZVMG4BrfW8GjpYYQxlESbXCaMg91xtbS0Mv4+bMSAAchhM2pfJxSKoaq8AppLSx40MSi1HhyMMFOT0MIh9EsSrNFS0q/VpiQIEyuCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM5Kj8dPCUyi/9BqCJBkxkPqg0VUCRR4O8YF5abemL8=;
 b=ARVf2hIEWEHrLblb6+jhVS+Ljg3Vujs3qntgSuWflV42RISHmlU4r9TpOGgKTMsPcv8qvcbQQL056Edaz8fbEn0lClLgsjp/7T7CUardd2UdUrevTKG1QfTVA2GrmziAqoFpwTJ7AVNNpCT923kg4PdgaCauhG66QOdCCkK6u6pkesmV1zK2XHXP5OZcLOmyWwy5hsv2fQHEtJ9mSUoYXwUl8Lr5czmGtukJcrxy033bQMVbWUFPv7B+kR71z+rC7zoImv3arrZwMaUDA+Eg6X8IeIEn9T+8vWVRdPzc73AHdvyYcT62jRGFW+t+uBvQXQGnYo1Qx1WP4kF4ll9gBQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFEA5D5B4BA.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::4af) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 09:42:20 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 09:42:20 +0000
Message-ID:
 <PN3PR01MB95972C400AE59DAB2EB388A5B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Wed, 28 May 2025 15:12:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
From: Aditya Garg <gargaditya08@live.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 "git@vger.kernel.org" <git@vger.kernel.org>,
 Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250528070521.17379-1-gargaditya08@live.com>
 <CAPig+cTs0+AUPp1euxqKkX0iFTdw9zGuMU-Qnp+ywhcyP8gxfA@mail.gmail.com>
 <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597EBE360893FA638B17952B867A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0089.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:268::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <7ca6f36a-957a-4c45-b18a-c90020a61fb0@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PPFEA5D5B4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 9255aad6-d791-4f6e-87aa-08dd9dcbf0eb
X-MS-Exchange-SLBlob-MailProps:
	WcKQPEuhm/uvlEVs3zy/duofypRrmGdN8qBHHg+iw0bT6PDE+mEj80lWobngd1b1VkOBqigviaRbwj0iMhXM73PkFwnzQnrxxmDtLR1yzGG+q7FxHS4CJ+NkyDUr5RML03HM3CMAvHaTqUayy62Vqwo1NW0m8aO11Hw/BHbgpH73ZjoR8YxE77SAehYioyKOf4ohMCXToFLryba23vIaM7gZ86NF/40WaHszNVvZHQI5U/6iviu3FtHQLAhA0+jI4cHsWJLz5bgubXaye3y5elBeRhU2eiyj0RuC0M25yNsNwEliPJg7YEwxdf6rGdCWyUOsGo9bw0rNf4Q+205vyaHn7SOD5yNc6++5U7czlWLrCQa9heP5YoQi7UQAn3s8y25BgmizToYwu9S9e8PSVPnPixgHvogoQ+dDQtl+3y5iaRDfA+f+It6WK2PtJc+CO3gzb2zCiLNDp9L6KDCVNKMR4Ga53N6p/VALsuRLrjbtkBRBnopRCDBcik58DSGiyq+npk9pRSoc85RdUK0c7oz7nYfYaWmviR2auO4pFOTo+O5j5p70vVoMM4N9QNS8uVJwItb8L188RdoytY8SnQb/+QUlZoTDiQ9ULX8PEpe91ayq6REomkZYyXGYd4DLBZLFoOPuDV043n51iysmg6uZZyyJDr1P96CwknAgjg/jClnCCLuTCCJlI/Vd80jkCeEDVCwyX1qHF46NW7giBc3nwxoPXVi13J420rjLulxr/0gcOtLe86wQQgPWzJeRZ5FSQOxm6aGp5xdzjOMpTb780IIQJDINC4RPGDfla38gFn4IHsqyybxg0psAaWNZ5//B5pq5OMCzb8L1J/8GcjNmm+akoL4OYMgNeJm1Uxk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|6090799003|21061999006|41001999006|7092599006|8060799009|19110799006|15080799009|12121999007|5072599009|1602099012|440099028|4302099013|3412199025|10035399007|12091999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNwemNIdDRNMnJvUVlUeHVsK0hVVmFTNUN2TWdtclJwNUtORW1iTXFWQkZR?=
 =?utf-8?B?MHN2bjVRTjVMdWxwWERrSHh1cmxHVForanFPb3UybVYyUlQ3UUFxb3l5S1Fr?=
 =?utf-8?B?RDlmb3FBWjJ6OGZ0TS9YUCs2cjlwOHJvQ2RQWTBvSm5QbTAxYXg0eGhxTUJP?=
 =?utf-8?B?Z0J0YUN5YmovRWpXWjhvN1FVZiswMElEeTFVRUxMMktYY2lvcURmTFJpcWY2?=
 =?utf-8?B?N3YzUWh6eFlCU2pLTXg1Z2s4ekx5Mnd1cm1GREFqbG0yM3dscm5ZNEQxU0Zp?=
 =?utf-8?B?VVQvQU84YXlXVXdQbGdXcExnUGwxUzhHc1l5RHlGUmY4alFSVmw1bGt2OW05?=
 =?utf-8?B?Q0lHSmtJbzFLdlN6SVBTYjJxWUhIZlM4TGtRYm1kZnA2OTNBOEdGYU9QRVFq?=
 =?utf-8?B?bDhaejJ4RU0yY0F5NUsxU3I4QjVoS1FJZTFSYjF2MFNtYVF1ZmlFUUU2WFEx?=
 =?utf-8?B?SmxZV2ZNYWdyOWVGdTE1bFZWQUhzb0VMb1BiN2VxTHJXaUxUMkxZMGJFbE5T?=
 =?utf-8?B?Mm5nNE0vV3hneVRsMW40WU5tazFNUzFUSmx5WUVTNy9qNGcrOUsvalJpU0ww?=
 =?utf-8?B?WjBmTkx6d01aSXdPeThoY3hYZHFnR0lVbmsvUDF1VEQxRjN5WmdCaC9GamxZ?=
 =?utf-8?B?dWJtVkNRbHEvYkozenFkc3lJOGJZUEFsaWxvKzJ0cEUzZENhckN5U1JoNVlI?=
 =?utf-8?B?SjZadklKVWo4d1g0UjIyMjh4d1JYVkVvemt5Ky91RTZIV3RnZjZPOFh2STlM?=
 =?utf-8?B?ZzE4d2xuSUE4ekpFNU1idGl4TlFKSE9wYm9XbVNENm0xMEpqaVQyOEZVS05M?=
 =?utf-8?B?a1JXSEhBTnJtWk5weUw2RklhZitabUF3MmlENVlMMEl2K2FBK0hHN0l6YUty?=
 =?utf-8?B?d21EcVlEUjg0b2ZETGU2QW41ZEdxakhYTlhBMVIyenRWY05XeDlLU0YwOXph?=
 =?utf-8?B?eVVvQUNCVk5iU1hPcXJoK3RkQWd6LzhNTUJLT2hLMThzZFpxQ0QyeFpDZVEr?=
 =?utf-8?B?UGhDV01kdUxYcm5VZnp5ekpmK2FvZTJuSVRsVldTRHV4R2dadVBaendtVWdx?=
 =?utf-8?B?S0FTK2loK2JndTByNW1RMmtmN1FuYmkxNVlBS1JZNkdvSnNXQmtKSmhhRmYw?=
 =?utf-8?B?eG5HU1Y3enNNOW9HM29ONjFPQ0xGV0syeXRkWk5xTnVaRW5VZDJRc2Rub0ZK?=
 =?utf-8?B?cURUZU9xeHB4anZMZzB1NVF3b2RrZ0xnQlZudCtOK2lSVVovTDluR1IwTmNw?=
 =?utf-8?B?WEpTT1BEZVRscTlvYlBPdU5jQUFnaHplZHZ4dDR2bnVETURMRWNFc2tkTG1M?=
 =?utf-8?B?WHhGRnV5OU1UZUJEWWZPTFd5dGZhdllsYnVOb1BENTNITHFuNkpScGRlR3Fj?=
 =?utf-8?B?MjJrNWxhdHJsNW1NdU93Tkh5SHpOQnN4cndqaFpPQnY0TE5jejJIWEQ2azNU?=
 =?utf-8?B?T3BPTE9rd0Q5NHphdDdndjRxOVh5T0FxTXF3ZHNzYXZXT2xYVHAwVE5QVGln?=
 =?utf-8?B?TWxPeWM5V2g4cmZiUFZ0U0ZGOFdBL2Iwb1FFQm5mWkh4SHlpVjFIWFhtWS9z?=
 =?utf-8?B?dnJWQ3FNUnhrWXRJL3dyRmVJQ2ZvcSs0UkkzSS9WSUs2eGFFSVRGRk4raE1y?=
 =?utf-8?B?YWxxZEJ1OENMaHBhWTYzcWdMYk5MelNtME8vNEtXaklNQVdJbHlUWUJYRUtU?=
 =?utf-8?B?UXpzcEtINkQrUFF6S0hjZXJISmhLbzkyNVZyRWJ1Tll5bHBCam01Z0FjL1lt?=
 =?utf-8?B?UHRKQkhvZDEwMnBCUHBqSzVJRld5RXR5bXBPYTJ3U1ZkSFBCaDRGMWsveE5Q?=
 =?utf-8?B?QTlRcGkwQlZzNFhCTWwvd1dyNXJSbnZrYi9XbWgzZEYxYmxOVi92MnBrNmxo?=
 =?utf-8?B?bW5acWJ3UnVuTW55WTFEeEdiSVFRT0NmQ0cydnJWRkNxZElnb1d4bTVMWjNl?=
 =?utf-8?Q?IxKp/8tEf/E=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTAwbm55Y1BNSWw5bHNTOHZ3RmVHeXh2aCtSMGhlWW5QRFNIT1hLYzBjbnJw?=
 =?utf-8?B?eUJqR3FxTWVtL0VTc0VhdTFsaFZ6Rk1menBXTEloclh1eFJRYjFoMkovLzRz?=
 =?utf-8?B?a3VZMWtiTklWMERodFhhZEp0UGlxOVVDZXVsT3FEVm9Vdm9vODluRGNiUnlx?=
 =?utf-8?B?TTJ3ZXpVckJ4TmNGNk43UGVyakkzZzZVY3hLVUdQaEJ4L2ZMOHhJN3pzbFQr?=
 =?utf-8?B?VmR0SFZzMGx0UnZmNDJnODVITDFQR0ppT1ZIdWQvOWF5UEdDVnI1L2tzeTBE?=
 =?utf-8?B?OFcyTTRna3ppS3VOQ0FLbTJWZngyZWpiY0dzQmY4U041SUp4dENOWUxlN2Qz?=
 =?utf-8?B?TmVxQzBJSVdyR254RDZ4bkI4REh6NXRCaVhoYnRkWG5IVGNBaVE1THR4bHBN?=
 =?utf-8?B?YmIwS01ldEZmcnRJYnZDUkU2bGxiaVA5YUkxVkQ2SklpOEZabUx3SHZ1Tm9i?=
 =?utf-8?B?ZGllOU5HSUY3WVNUK2pLQ1cwa3BMSEQ4WXV6ZWtscHQ2STFkbldaOXowT1Ja?=
 =?utf-8?B?cWJWTHh2T3RmWm5DSUJtemk1b3pKc3RJVlNacHRkT0Q3aXRxUG9VdlhpMjNJ?=
 =?utf-8?B?THRlMlhrVHBja1VYbVN0Vlh5cGVrTGYyK1ZVRkw4c0RyK0w0ODRkZUp4L3l4?=
 =?utf-8?B?TXdaZytsU0l0ZzduQUs4bnhpNEx2SjM4cjNCcEUwbkM5eVJZVW9UdUJoL0U4?=
 =?utf-8?B?L0pvY3lSRkRtRXA1V0pmbUEwWmRndXFNR2hoWG9jY0NsRDU5VDJDZlJWL1Jw?=
 =?utf-8?B?RUR1SUpNUHVRNjVBQWg2NVVWcHZCdXpML1dmMlhTRnlWV1B3RC9YT0ZHK1ZU?=
 =?utf-8?B?MWFnNnJySnRURnZKWnJuNHNieFF6VXNiOUI4Q0VRZGpGRTNYUWxkcXZXeGxt?=
 =?utf-8?B?dnBKdWQ2S29lNWhVK05XSmppOFRUUDhXdGlXbUJ5enIvUlEwZDg3bVc2aEhp?=
 =?utf-8?B?OUxwbWtrMWxVaTNMVzI1SnJySVZpTFZBTzNxTGxCMk56NFFHT2ZxSnpza2Fj?=
 =?utf-8?B?TmRnVFdSaVo4aWRNZjJNdnY3L0dWajlIa0xaeWpZSXVCUjBlRkVFTTVlVUNr?=
 =?utf-8?B?dmtJVXgyTFl6Q0JXdWVNeDlYVjRsM0J2MHdHQTRPTHZJVDRRckJFOXdkdlZ1?=
 =?utf-8?B?RHEwZ08ydll2dXVsNDFsS2ZXak5xRlJRZFZyQXl0NWhvb1hVeEU1dGp0dE9Q?=
 =?utf-8?B?b3RBMHRqOEtoRjVlcTM0TXY2ZDNiWW0wZ2FkOU5MSUloYkI4VjFqb2VEK3lG?=
 =?utf-8?B?ejlpODhqVURxdlplRkVld1huVFowaUE2SHVZOCszWG5YZFJjcVVZZEU4NE9p?=
 =?utf-8?B?VXd5ZE84VmhtQjM1L3dGRWl4Qzl4QWhrZ0o4bnJXdDlheHVLbXQvbkdPbnR5?=
 =?utf-8?B?RWNOeGRXZ0MzWEcyeEVwSlQ2RGJyWlRybDBlUFVGOVZvN1NlY3cyNUxuSTdS?=
 =?utf-8?B?QWttbWJEeWNua2ZXZitSSjVsWmpPaFlLYWtsSVFtSEtoL2dLUkVoQ2FmRWRG?=
 =?utf-8?B?RTc5ZndtZW1NKzBXSnhzVXdYWnpvRHJuMTNWQ3BWVEsxa2VNd1kzZ3FFcVRZ?=
 =?utf-8?B?bTA5d1diYnh1bjREQ3psSi8xa1JQUmVHYVMwR2o4SWRKMEprZnE2Rk1IRUhR?=
 =?utf-8?B?cU1hRTY0Si9ab2htcU9PRGxRUjJOVUdYTTVQZzBWOG5qK01RY3NYdVk1MkNP?=
 =?utf-8?B?ZE94SksxQmRtSDdNaEUrREpScE5UZEx2aEdHZXNyc3pRMjZUeHI2V1Q1K3kw?=
 =?utf-8?Q?ri5VHMWmy/AvdmBveE=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9255aad6-d791-4f6e-87aa-08dd9dcbf0eb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 09:42:20.4649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFEA5D5B4BA



On 28-05-2025 03:06 pm, Aditya Garg wrote:
> 
> 
> On 28-05-2025 12:53 pm, Eric Sunshine wrote:
>> On Wed, May 28, 2025 at 3:05 AM Aditya Garg <gargaditya08@live.com> wrote:
>>> v5: Added a patch to make the purpose of using app password for Gmail
>>>     more clear in `send-email` documentation.
>>>
>>> Range-diff:
>>> -:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and link Google's sendgmail tool
>>> -:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-email documentation
>>> -:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for emails from gitcredentials
>>> -:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app password for Gmail more clear in send-email
>>
>> Strange range-diff.
> 
> I think because I used git version 2.43. When I compiled my branch with changes, git format-patch over there
> had a very different range-diff from this.

I get this range-diff with git 2.49

Range-diff:
-:  ---------- > 1:  4757d0305d imap-send: fix bug causing cfg->folder being set to NULL
1:  62edbcfc6e ! 2:  f5ad01abc5 imap-send: enable specifying the folder using the command line
    @@ Metadata
     Author: Aditya Garg <gargaditya08@live.com>
     
      ## Commit message ##
    -    imap-send: enable specifying the folder using the command line
    +    imap-send: add support for OAuth2.0 authentication
     
    -    Some users may very often want to imap-send messages to a folder
    -    other than the default set in the config. Add a command line
    -    argument for the same.
    +    OAuth2.0 is a new way of authentication supported by various email providers
    +    these days. OAUTHBEARER and XOAUTH2 are the two most common mechanisms used
    +    for OAuth2.0. OAUTHBEARER is described in RFC5801[1] and RFC7628[2], whereas
    +    XOAUTH2 is Google's proprietary mechanism (See [3]).
    +
    +    [1]: https://datatracker.ietf.org/doc/html/rfc5801
    +    [2]: https://datatracker.ietf.org/doc/html/rfc7628
    +    [3]: https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
     
         Signed-off-by: Aditya Garg <gargaditya08@live.com>
     
      ## Documentation/config/imap.adoc ##
    -@@
    - imap.folder::
    - 	The folder to drop the mails into, which is typically the Drafts
    --	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
    --	"[Gmail]/Drafts". Required.
    -+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
    -+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
    -+	set and `--folder` is also used, `--folder` will be preferred.
    - 
    - imap.tunnel::
    - 	Command used to set up a tunnel to the IMAP server through which
    +@@ Documentation/config/imap.adoc: imap.authMethod::
    + 	Specify the authentication method for authenticating with the IMAP server.
    + 	If Git was built with the NO_CURL option, or if your curl version is older
    + 	than 7.34.0, or if you're running git-imap-send with the `--no-curl`
    +-	option, the only supported method is 'CRAM-MD5'. If this is not set
    +-	then 'git imap-send' uses the basic IMAP plaintext LOGIN command.
    ++	option, the only supported methods are 'CRAM-MD5', 'OAUTHBEARER' and
    ++	'XOAUTH2'. If this is not set then `git imap-send` uses the basic IMAP
    ++	plaintext LOGIN command.
     
      ## Documentation/git-imap-send.adoc ##
    -@@ Documentation/git-imap-send.adoc: OPTIONS
    - --quiet::
    - 	Be quiet.
    - 
    -+-f <folder>::
    -+--folder <folder>::
    -+	Specify the folder in which the emails have to saved.
    -+	For example: `--folder [Gmail]/Drafts` or `-f INBOX/Drafts`.
    -+
    - --curl::
    - 	Use libcurl to communicate with the IMAP server, unless tunneling
    - 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
    +@@ Documentation/git-imap-send.adoc: Using Gmail's IMAP interface:
    + 
    + ---------
    + [imap]
    +-	folder = "[Gmail]/Drafts"
    +-	host = imaps://imap.gmail.com
    +-	user = user@gmail.com
    +-	port = 993
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    + ---------
    + 
    ++Gmail does not allow using your account password for `git imap-send`.
    ++If you have multi-factor authentication set up on your Gmail account, you can generate
    ++an app-specific password for use with `git imap-send`.
    ++Visit https://security.google.com/settings/security/apppasswords to create it.
    ++If you do not want to enable multi-factor authentication, you can use OAuth2.0
    ++authentication as described below.
    ++
    + [NOTE]
    + You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
    + that the "Folder doesn't exist".
    +@@ Documentation/git-imap-send.adoc: that the "Folder doesn't exist".
    + If your Gmail account is set to another language than English, the name of the "Drafts"
    + folder will be localized.
    + 
    ++If you want to use OAuth2.0 based authentication, you can specify `OAUTHBEARER`
    ++or `XOAUTH2` mechanism in your config. In such a case you will have to use an
    ++OAuth2.0 access token in place of your password.
    ++
    ++---------
    ++[imap]
    ++    folder = "[Gmail]/Drafts"
    ++    host = imaps://imap.gmail.com
    ++    user = user@gmail.com
    ++    port = 993
    ++    authmethod = OAUTHBEARER
    ++---------
    ++
    ++Using Outlook's IMAP interface:
    ++
    ++Unlike Gmail, Outlook only supports OAuth2.0 based authentication. Also, it
    ++supports only `XOAUTH2` as the mechanism.
    ++
    ++---------
    ++[imap]
    ++    folder = "Drafts"
    ++    host = imaps://outlook.office365.com
    ++    user = user@outlook.com
    ++    port = 993
    ++    authmethod = XOAUTH2
    ++---------
    ++
    + Once the commits are ready to be sent, run the following command:
    + 
    +   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
    +@@ Documentation/git-imap-send.adoc: Just make sure to disable line wrapping in the email client (Gmail's web
    + interface will wrap lines no matter what, so you need to use a real
    + IMAP client).
    + 
    ++In case you are using OAuth2.0 authentication, it is easier to use credential
    ++helpers to generate tokens. Credential helpers suggested in
    ++linkgit:git-send-email[1] can be used for `git imap-send` as well.
    ++
    + CAUTION
    + -------
    + It is still your responsibility to make sure that the email message
     
      ## imap-send.c ##
    -@@
    +@@ imap-send.c: enum CAPABILITY {
    + 	LITERALPLUS,
    + 	NAMESPACE,
    + 	STARTTLS,
    +-	AUTH_CRAM_MD5
    ++	AUTH_CRAM_MD5,
    ++	AUTH_OAUTHBEARER,
    ++	AUTH_XOAUTH2
    + };
      
    - static int verbosity;
    - static int use_curl = USE_CURL_DEFAULT;
    -+static char *opt_folder = NULL;
    + static const char *cap_list[] = {
    +@@ imap-send.c: static const char *cap_list[] = {
    + 	"NAMESPACE",
    + 	"STARTTLS",
    + 	"AUTH=CRAM-MD5",
    ++	"AUTH=OAUTHBEARER",
    ++	"AUTH=XOAUTH2",
    + };
      
    - static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
    + #define RESP_OK    0
    +@@ imap-send.c: static char *cram(const char *challenge_64, const char *user, const char *pass)
    + 	return (char *)response_64;
    + }
      
    - static struct option imap_send_options[] = {
    - 	OPT__VERBOSITY(&verbosity),
    - 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
    -+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
    - 	OPT_END()
    - };
    ++static char *oauthbearer_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/* Compose the OAUTHBEARER string
    ++	 *
    ++	 * "n,a=" {User} ",^Ahost=" {Host} "^Aport=" {Port} "^Aauth=Bearer " {Access Token} "^A^A
    ++	 *
    ++	 * The first part `n,a=" {User} ",` is the gs2 header described in RFC5801.
    ++	 * * gs2-cb-flag `n` -> client does not support CB
    ++	 * * gs2-authzid `a=" {User} "`
    ++	 *
    ++	 * The second part are key value pairs containing host, port and auth as
    ++	 * described in RFC7628.
    ++	 *
    ++	 * https://datatracker.ietf.org/doc/html/rfc5801
    ++	 * https://datatracker.ietf.org/doc/html/rfc7628
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "n,a=%s,\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    ++static char *xoauth2_base64(const char *user, const char *access_token)
    ++{
    ++	int raw_len, b64_len;
    ++	char *raw, *b64;
    ++
    ++	/* Compose the XOAUTH2 string
    ++	 * "user=" {User} "^Aauth=Bearer " {Access Token} "^A^A"
    ++	 * https://developers.google.com/workspace/gmail/imap/xoauth2-protocol#initial_client_response
    ++	 */
    ++	raw_len = strlen(user) + strlen(access_token) + 20;
    ++	raw = xmallocz(raw_len + 1);
    ++	snprintf(raw, raw_len + 1, "user=%s\001auth=Bearer %s\001\001", user, access_token);
    ++
    ++	/* Base64 encode */
    ++	b64 = xmallocz(ENCODED_SIZE(strlen(raw)));
    ++	b64_len = EVP_EncodeBlock((unsigned char *)b64, (unsigned char *)raw, strlen(raw));
    ++	free(raw);
    ++
    ++	if (b64_len < 0) {
    ++		free(b64);
    ++		return NULL;
    ++	}
    ++	return b64;
    ++}
    ++
    + #else
      
    -@@ imap-send.c: int cmd_main(int argc, const char **argv)
    + static char *cram(const char *challenge_64 UNUSED,
    +@@ imap-send.c: static char *cram(const char *challenge_64 UNUSED,
    + 	    "you have to build git-imap-send with OpenSSL library.");
    + }
      
    - 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
    ++static char *oauthbearer_base64(const char *user UNUSED,
    ++		  const char *access_token UNUSED)
    ++{
    ++	die("You are trying to use OAUTHBEARER authenticate method "
    ++	    "with OpenSSL library, but it's support has not been compiled in.");
    ++}
    ++
    ++static char *xoauth2_base64(const char *user UNUSED,
    ++		  const char *access_token UNUSED)
    ++{
    ++	die("You are trying to use XOAUTH2 authenticate method "
    ++	    "with OpenSSL library, but it's support has not been compiled in.");
    ++}
    ++
    + #endif
      
    -+	if (opt_folder) {
    -+		free(server.folder);
    -+		server.folder = xstrdup(opt_folder);
    + static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    +@@ imap-send.c: static int auth_cram_md5(struct imap_store *ctx, const char *prompt)
    + 	return 0;
    + }
    + 
    ++static int auth_oauthbearer(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = oauthbearer_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("OAUTHBEARER: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending OAUTHBEARER response failed");
    ++	}
    ++
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    ++static int auth_xoauth2(struct imap_store *ctx, const char *prompt UNUSED)
    ++{
    ++	int ret;
    ++	char *b64;
    ++
    ++	b64 = xoauth2_base64(ctx->cfg->user, ctx->cfg->pass);
    ++	if (!b64)
    ++		return error("XOAUTH2: base64 encoding failed");
    ++
    ++	/* Send the base64-encoded response */
    ++	ret = socket_write(&ctx->imap->buf.sock, b64, strlen(b64));
    ++	if (ret != (int)strlen(b64)) {
    ++		free(b64);
    ++		return error("IMAP error: sending XOAUTH2 response failed");
     +	}
     +
    - 	if (argc)
    - 		usage_with_options(imap_send_usage, imap_send_options);
    ++	free(b64);
    ++	return 0;
    ++}
    ++
    + static void server_fill_credential(struct imap_server_conf *srvc, struct credential *cred)
    + {
    + 	if (srvc->user && srvc->pass)
    +@@ imap-send.c: static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
    + 					fprintf(stderr, "IMAP error: AUTHENTICATE CRAM-MD5 failed\n");
    + 					goto bail;
    + 				}
    ++			} else if (!strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++				if (!CAP(AUTH_OAUTHBEARER)) {
    ++					fprintf(stderr, "You specified "
    ++						"OAUTHBEARER as authentication method, "
    ++						"but %s doesn't support it.\n", srvc->host);
    ++					goto bail;
    ++				}
    ++				/* OAUTHBEARER */
    ++
    ++				memset(&cb, 0, sizeof(cb));
    ++				cb.cont = auth_oauthbearer;
    ++				if (imap_exec(ctx, &cb, "AUTHENTICATE OAUTHBEARER") != RESP_OK) {
    ++					fprintf(stderr, "IMAP error: AUTHENTICATE OAUTHBEARER failed\n");
    ++					goto bail;
    ++				}
    ++			} else if (!strcmp(srvc->auth_method, "XOAUTH2")) {
    ++				if (!CAP(AUTH_XOAUTH2)) {
    ++					fprintf(stderr, "You specified "
    ++						"XOAUTH2 as authentication method, "
    ++						"but %s doesn't support it.\n", srvc->host);
    ++					goto bail;
    ++				}
    ++				/* XOAUTH2 */
    ++
    ++				memset(&cb, 0, sizeof(cb));
    ++				cb.cont = auth_xoauth2;
    ++				if (imap_exec(ctx, &cb, "AUTHENTICATE XOAUTH2") != RESP_OK) {
    ++					fprintf(stderr, "IMAP error: AUTHENTICATE XOAUTH2 failed\n");
    ++					goto bail;
    ++				}
    + 			} else {
    + 				fprintf(stderr, "Unknown authentication method:%s\n", srvc->host);
    + 				goto bail;
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 
    + 	server_fill_credential(srvc, cred);
    + 	curl_easy_setopt(curl, CURLOPT_USERNAME, srvc->user);
    +-	curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    ++
    ++	if (!srvc->auth_method ||
    ++	    strcmp(srvc->auth_method, "XOAUTH2") ||
    ++	    strcmp(srvc->auth_method, "OAUTHBEARER"))
    ++		curl_easy_setopt(curl, CURLOPT_PASSWORD, srvc->pass);
    + 
    + 	strbuf_addstr(&path, srvc->use_ssl ? "imaps://" : "imap://");
    + 	strbuf_addstr(&path, srvc->host);
    +@@ imap-send.c: static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
    + 	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
    + 
    + 	if (srvc->auth_method) {
    +-		struct strbuf auth = STRBUF_INIT;
    +-		strbuf_addstr(&auth, "AUTH=");
    +-		strbuf_addstr(&auth, srvc->auth_method);
    +-		curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    +-		strbuf_release(&auth);
    ++		if (!strcmp(srvc->auth_method, "XOAUTH2") ||
    ++		    !strcmp(srvc->auth_method, "OAUTHBEARER")) {
    ++
    ++			/* While CURLOPT_XOAUTH2_BEARER looks as if it only supports XOAUTH2,
    ++			 * upon debugging, it has been found that it is capable of detecting
    ++			 * the best option out of OAUTHBEARER and XOAUTH2.
    ++			 */
    ++			curl_easy_setopt(curl, CURLOPT_XOAUTH2_BEARER, srvc->pass);
    ++		} else {
    ++			struct strbuf auth = STRBUF_INIT;
    ++			strbuf_addstr(&auth, "AUTH=");
    ++			strbuf_addstr(&auth, srvc->auth_method);
    ++			curl_easy_setopt(curl, CURLOPT_LOGIN_OPTIONS, auth.buf);
    ++			strbuf_release(&auth);
    ++		}
    + 	}
      
    + 	if (!srvc->use_ssl)
-:  ---------- > 3:  e3dc19dc49 imap-send: add PLAIN authentication method to OpenSSL
-:  ---------- > 4:  11f7ac1325 imap-send: fix memory leak in case auth_cram_md5 fails
-:  ---------- > 5:  f6e7a5498e imap-send: enable specifying the folder using the command line
2:  245cc89cca = 6:  4769924781 imap-send: enable user to choose between libcurl and openssl using the config
-- 
2.49.0.windows.1


