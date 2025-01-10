Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020121.outbound.protection.outlook.com [52.101.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1820B80E
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736510717; cv=fail; b=ARoI7YtWk8oOGcEtFNFrxHdv2ui1k3NL1J16U/DjK7MSvI/ddqOki4lli8/PFi1EEktxHhakXf4bnei/HoKCgh7wg99u7c3C+LqiEjL3AmTm/SCLFu/gNqAQQTdfQWQJ+ev+/I+CbGU7Q5i5WQ2M5Gw7E4OGkKoKb9adpVBh8pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736510717; c=relaxed/simple;
	bh=mjDEKsgE6E4i8zgRC2k3HKju01i2eeOkcX9NJLI9te0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B+8iBXnjOgj9bVAeXbbuZeCHSBGfBz21b0HE4h6tA3cyoYJnlRWB0PSED6mtDz/Ib5ea8HlP7MUY4QnajEwOhZx20DDDEoQNg8c04ngBrfIIwShy5c7A12A/uDmjETHSlV6wFg2ImZir6nRbvNvWyBDqs1dq4Z+5TEPbpPr2Kzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch; spf=pass smtp.mailfrom=psi.ch; dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b=aRZoAQc+; arc=fail smtp.client-ip=52.101.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psi.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b="aRZoAQc+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQL5PRJlgdWjAj6JcQ1tGd+ZCCXB2xC15vvY9AsG0D7N9DKt3175Ipu1JIr3g3C+MUbwrKPGUzvljdz2adlJDLRvvk7twWQF+yz1dJxmQtCL4rJP7VXGPf9Rnjrw6sVkMCtW6dcxzkEvyi9JkqeLb81impLW3Z9T4JylPUP6qZMHyz1iSv7TMuihJk0vj/tTHqk4e1Ipegq33KxTQJ1dYqV09jg+faSAoBjKdg5KjF4o2wY/OLcOOu4INAIZxFxgXCFlInxiCF6EDopeGFPeZgz4TbND+v45lzozYsZBl64/ADBbATmrt7B46XKvXBV4a/u4XN/bPlWM+38dfBzHIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn8TAo3tZ/JSlVHJaAUk8n53w2i/yAhHh9VcLJQ3CDs=;
 b=k3XRmx/as48TN+ZCqysXPlNEaivjIXYY6MVQpjA2JrM8GdxqNLh1qpAJ26I4Co4p3YmbsnQZSCofHuyeazVoH8HBcR5dO/pmI/cKQkHa8LRwO8AIdnihc4t/my9LDSpkKar/Au7uHhiryM5UCjegNmo7FbD+6rqjUDKWH2PMvWDe4VP4SV/u4+m+r942Gyoeui57QNbg0ESzCKEIXng+yMrDlh715v69NFMmSxQ7RL+iQQH/OnAElc5kT5vBw7HyoMKb8DKMFt0mM+NVGnBYyvdfQ7ZirGg1x+iLUp8ED4tc15xHiI0cFm5C1lW/wzEzqD4JN1QHq1TWHjzD7KAzZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.250.75.252) smtp.rcpttodomain=crustytoothpaste.net smtp.mailfrom=psi.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=psi.ch; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psi.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn8TAo3tZ/JSlVHJaAUk8n53w2i/yAhHh9VcLJQ3CDs=;
 b=aRZoAQc+ujCBzeD9aDm0/4+ef6WUzRsw64Jry4aZndrnqIuMms/7e+4XmrqwOUrsZfDwqYlfIOt9xV7zXzcrpOO6bLXkSciU+n0cecXx3jxrA1xG+akLI1imRXGC8JdeRZEaGEvuhQxUQQ+gufNI1pOrIM0OMUYRsXiVp+kO/r4p/00XhJ1RZn0clOSeLgPDGstkuJsV96qw8DzVEdrLOf5ri2xuhOiGVGnjfel5d11vjKwpLvmFCqjyvZyUjds+D1JJOw6YSIyee8hnxGx1OuKjqbMdXWa31cPeRUSZaiYchQPOHMBcK/CAvgUkEV1pC6ZwaeRobRSJl5DC1jH2yg==
Received: from ZR0P278CA0047.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1d::16)
 by ZR0P278MB1650.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 12:05:07 +0000
Received: from ZR1PEPF0000077B.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d:cafe::98) by ZR0P278CA0047.outlook.office365.com
 (2603:10a6:910:1d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Fri,
 10 Jan 2025 12:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.250.75.252)
 smtp.mailfrom=psi.ch; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=psi.ch;
Received-SPF: Pass (protection.outlook.com: domain of psi.ch designates
 20.250.75.252 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.250.75.252; helo=seppmail2.psi.ch; pr=C
Received: from seppmail2.psi.ch (20.250.75.252) by
 ZR1PEPF0000077B.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.7
 via Frontend Transport; Fri, 10 Jan 2025 12:05:07 +0000
Received: from seppmail2 (localhost [127.0.0.1])
	by seppmail2.psi.ch (Postfix) with SMTP id 4YV0hg34B6zMvT;
	Fri, 10 Jan 2025 13:05:07 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010002.outbound.protection.outlook.com [40.93.86.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by seppmail2.psi.ch (Postfix) with ESMTPS;
	Fri, 10 Jan 2025 13:05:06 +0100 (CET)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psi.ch;
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::13)
 by GV0P278MB1434.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:69::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Fri, 10 Jan
 2025 12:05:04 +0000
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288]) by GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288%6]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 12:05:04 +0000
Message-ID: <bc1a788b-0707-4cc0-8143-dd4d9c70394c@psi.ch>
Date: Fri, 10 Jan 2025 13:05:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: chmod failure on GVFS mounted CIFS share
From: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 ps@pks.im
References: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
 <Z1us2FpyObVpJlsM@tapette.crustytoothpaste.net>
 <c22a7d5e-cbfe-48a9-bdf5-e73f21ac648f@psi.ch>
 <Z19Ymnnvt9jOixPB@tapette.crustytoothpaste.net>
 <c287fbd7-eb08-45f1-953b-5afd4fe41f9f@psi.ch> <xmqq8qsafjfy.fsf@gitster.g>
 <8af7ff11-c5bb-464b-894f-f1fb30df50e0@psi.ch>
Content-Language: en-US
In-Reply-To: <8af7ff11-c5bb-464b-894f-f1fb30df50e0@psi.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZR0P278CA0125.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::22) To GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0504:EE_|GV0P278MB1434:EE_|ZR1PEPF0000077B:EE_|ZR0P278MB1650:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e263c3-d991-472c-9c2f-08dd316f0682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?Qlh0a3BiRWZqRy9RUWQ3U2lBSkVYSnpGVkw0ZmRHelU5YU5HSk9oR00vRlBQ?=
 =?utf-8?B?Y2JBV3doL05UYnFBb1Nxdk1YNjlvZ0U5NkhzeTdWZkVPUktkMnkyQXhoTDU4?=
 =?utf-8?B?b0FLOXpHU0FvWXoxS2lJOGo3VUZFZzRYUGt1MzdHS0dOUnJBRmtTU2w4cnNV?=
 =?utf-8?B?MGlCSXNzb3BibktoOCt3RytMbk1wT1RuRWU5YkNIYTJXb053NmY0UVJDbDlD?=
 =?utf-8?B?VVpGQXhLQXdwVHpvRThETVMrVGZCMDQvb0Zkdm50Vmgvam5KbldORmhYRXI0?=
 =?utf-8?B?cy9JclR0clBqRXp5YjEvazR5eWYyb0sxM0FqUW1PTElpM3N1aTZCQm16dkpR?=
 =?utf-8?B?MmlJWWlqSFlGNXRYZ1RXUS9aVUNBcHZ2MmVyOWVybEoxTFk2OEMzTEFONTAx?=
 =?utf-8?B?VVVuS0FXdG9Wekx2bUxSZDUvUGlOb2lSalY4eFpaRjBJVWV2S2FCK0xQalZT?=
 =?utf-8?B?T1hQZ044bEQ0K2VwUzhiazNGa2JZRmhRc28wdG9iQjc4eklNc29tZ0FzbDhO?=
 =?utf-8?B?Nm5uVVliUEozbGxDdGU3K3hZOURabUk4OWtjSTMzaTJDZWsxV0RRWXRDOE9t?=
 =?utf-8?B?NHovUk9kdDZGd0dVQ1B2UjI1R3ZWMDg2Ull6OTF6NzJGRlFZcS9qUXdjMU9W?=
 =?utf-8?B?NEJuQzVRV1NoaUlBd1IwSE9aNVVVNktsUmYvcnJnbUN4TkR1VnZSTmNPOE4w?=
 =?utf-8?B?UVVsMzlWdTI3TDl4c09UbVVHbmM3VnVXb2NBbUtvMUwyanE4Z0U0dm1MVHQ0?=
 =?utf-8?B?dmYxbDZhbklxSVcrVVVpblFERmxLWDNBTm54ZFJTZ2hoN2E0RU9JRFAzRUoy?=
 =?utf-8?B?QXNuSFhEYnNETXVqOStNOXhBd3dSV0cwNW5kbHdaMHVHYWlHcXZ0SUk5ekk1?=
 =?utf-8?B?bDNnam54NEQ0TmRWSzhYSVdGdzgvdGJ1RldWYndpTGtibVlaTExVc05xSmE4?=
 =?utf-8?B?NFhvRzkyT3lURXZjSjMwUUlodTNXc1hINStZa1NZN0JZbzlXTHFmbVFGRTlz?=
 =?utf-8?B?bE42RC9GV0JLRlBNV2NMUmd3ekxLLzVWaDRqNmhDZGJBazdXM050bFUvV1RG?=
 =?utf-8?B?VjUraGJna0xMN2srZzFlUVdWeTNnR1BBYmRHckQ4bFpPdmJsaHdGYUd1S2Zo?=
 =?utf-8?B?SmxIYk4rK1pncVl0TEVJQmhzbXF1MnlGL1FkUzdxZ3NQcXhBNmRqam56b1Bi?=
 =?utf-8?B?emYyajdIdUNqcWRSdzNuU0dWNFZDam5EUEswY1BoUStXYWNHVmcwQWtmMXA1?=
 =?utf-8?B?NTJJSHFMY0h0MTJRbU5uZUpjaVlkdGNTOFFRRjFtRytFeGE0YVkwV2M1WEto?=
 =?utf-8?B?Qy9RZW52Zzd4cmRRM1RTcVZ3ZWtSQ2FHVWdtekRvcVhYZVc3K1FweEdzUlor?=
 =?utf-8?B?Vi91cDZOQ2NqNGEyQjh2ZGpUTkZ6OUtvRHhveDZweHpWeHR6TkxVQzRlY0tB?=
 =?utf-8?B?VHJ2bm8rckNjbkJ1NG5OL1BhbURqTFZaMTlyU0tZeW82WnZjcDFReVNCVk5P?=
 =?utf-8?B?TFdKWWgxd3RJQ3p2Y21GS3ZoZncyRFdGcHI2VnNDRElNWnRyN0YvV3BQZVB2?=
 =?utf-8?B?R1pIVDFKa0F1QUFaQXowSlRkb3U4QWt1UjlldGpKWkduTW5BWktZSnBmRGFV?=
 =?utf-8?B?Y2ZMdkNmalRGUmswTTIzemZTZmdSUXVCMkJHdWV0T2pBUnVHem9mdFpJMUt1?=
 =?utf-8?B?WDZZdk41ZzBtNDhydzlRcVhCVENGTk8rM2R6VUY5WFN2cGsxQWpnb2ppcTdj?=
 =?utf-8?B?eC82cHBxVHBJZ2xUazhNb1BJSTlrMjlOVGJpa1RRdkRmM1FVbitkRitLRDRY?=
 =?utf-8?B?blFIMWkyVVozaVhVQVlycFgzZzFSb3hiTG96MEo4M25INThBTk04YmVHbldh?=
 =?utf-8?Q?OcQSPO4ePfcPS?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1434
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR1PEPF0000077B.CHEP278.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	696b8581-1b87-4108-2025-08dd316f0485
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|14060799003|1800799024|82310400026|35042699022|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTFOVDR2bzFZRGhWK2h4cS9aZUQ5aHZyUFFHL1h5bG1HOXhpMVRidktmZEw5?=
 =?utf-8?B?M01GYmtUbGl4UklWS0pKMVZRZ2xyTS9VY3hNZUNoejdoNnAra0l1S0RaazBL?=
 =?utf-8?B?dlMxK0RyNTZUbWtIYzBCSFh1WlZ5U1JKUmtDc1B4aFNma1hlcS80a09VSnFY?=
 =?utf-8?B?L1dCTVdaVG5OTldyaml2MnIxbTc3cEc5US91SUE2TVZ5bEM0U29sQkJDekhJ?=
 =?utf-8?B?dkZ1bVFqMDdTMVlpZDRmYVJaT2R6WFdPSXhESDJuOWVUK0NoRVVERG94T3c2?=
 =?utf-8?B?T3JkbGtxdHU3YWVSYXJhYUo1TEdVL3VKcDduS2M3RTQ4MGJ1WVdhSEVQT29X?=
 =?utf-8?B?NGRNOE5ERlhLNFg1NjZXaVkyY0phMitkRXlrQU04aWJoZ2p1cmVUbFJmUkMw?=
 =?utf-8?B?aGNwUnpsZzJZSmg4T0o4UXhHQkowb0w2WXVIQ3VXUHErUFQwZ1RHZkthNEFN?=
 =?utf-8?B?c1A3RG1ITm1ySlB1clFJc040UmVtZVJkNjFZSWlKYmMzZWh5K2Mva3lsSGdK?=
 =?utf-8?B?ZUVYNTMxUWFaYVczMVdCK0dUeTBZMGpWaG91TVJFeTlYeDl4WFdva0R0RDd5?=
 =?utf-8?B?R3hCVSt6VC9zMmpvNjZRKzM5b0NaWFV0Q204akcrNHlIYjF1aXFJMlNGZHBz?=
 =?utf-8?B?Y1FwT2plS2phNHBJb1EyQTM4eENhUm1zUGdNMEZYb1ZiSjVqam53bW8yb2dv?=
 =?utf-8?B?eTUweEpxMVFDZkxKM20rRUltYmZnbXJ1SzVKczFhYzh2Unk5dXZEbDd2QTds?=
 =?utf-8?B?Z0luS0ZMd0pUZ3d0elRXOCtFNnZwVW5tVzFJRVRhaU1mQlEvTVBibUpzdCsr?=
 =?utf-8?B?UEJRNXZyNUMvc0hVZ1VyaklIWW1nNy9iSDUzTEczUXFJdWNrQU5zOGRNSVVh?=
 =?utf-8?B?ck1reXpqUlRLUE5Qem1TRzlLZld4NFlXUzBiY2FWT3l5ZjhPWlBDeHRpcHlh?=
 =?utf-8?B?dGpTM2pVZ0RJdXNtdU5UZGNUTkVrU0RuS1grbmM3ZGorNkdRaW5NWVhwSlR3?=
 =?utf-8?B?OHNSYW92SmM0bkRXNjZqWHR4S3l0WjhMTlhzZ3I3eE03WDZMcUtvTEsvUzVw?=
 =?utf-8?B?NUppZ1Rzc2o0MCs2V3YvcVk1RE92YzJQMEh5QjlGNW5tV2VzOHFxTEJCWkxx?=
 =?utf-8?B?aFVlV1E1dStpMndXamNvQ2J6cDR0SUd4cWMzdmFPZnpZN1g3N3ZVdW1pM2M1?=
 =?utf-8?B?Um1RamN3RUo2aEFhRWtXYXdYYm9RL3FTajMzckJHZUZWRkJtSHdWMHhnYjdJ?=
 =?utf-8?B?QXJMUC9VdGVjTFNWMkJHeEdEQnVTWDV5WUpnR2RCa1g0ZHc5Tk5Lbk91OXdP?=
 =?utf-8?B?RzR3Qm1HbW1Bem1Ubm5rSDZaczBjUm5VSko2RHRNeHMyY3dSdHlIaldPWGJS?=
 =?utf-8?B?dlVYSFlQOHlsSTIyMmJxRG9yVEIwZDVuMFUzMkpjdWM5Z2I0VlFnSUx4N0Q3?=
 =?utf-8?B?Y0J5akpqVmROUVJZR3lHcjNIQ3BTOTR6M3BROXBjK1liNG4wdUVWTTM1R1RR?=
 =?utf-8?B?eUlOeUxOTHpIS0duaWdSREw3RHZKa1AvRnphbUdvSVliQjBETUh6cnhxUmFN?=
 =?utf-8?B?MFJnUHdmeHQ4Ykk2d3JBREdVeW1pMHY3UnFvd2pIakQ4THJ3aHo4MU5DbmVB?=
 =?utf-8?B?TjdUaG4rYmFxM1lRRGI1YVVDanZVRDE4aUY2MzBqYmQwVTVuWE41WHpKUlJu?=
 =?utf-8?B?QjFoR0hqbVUwS0JLTFRLNFBYSlRSaWEwRndOTTBVZWVURm8zdFlWbHcySzJQ?=
 =?utf-8?B?bVhHcWRrSzI4QXliblNEU01NMDF3UTVJcVZhenl1dGRFWUZFcGh2MjByRURv?=
 =?utf-8?B?RVZYVXdSbCtpSkErUENUa2YvYVRtVXE1MndvZ2JXVkhQNXQ2SlBCUWp1U3M0?=
 =?utf-8?B?ejl4RGtOdVlsaUlSZEIyQ01TOG5TWVFDOWRLdjh4RnpFa3h3NFY3bEtvMS85?=
 =?utf-8?B?NHlzenN5dzl3VHYzYit1Z2E3RExvYktBRm1DVVBrYy9PUkhoWGRtSjhxRGE5?=
 =?utf-8?Q?mmLTpM2YGXGaherxXvwwqnl885p0GM=3D?=
X-Forefront-Antispam-Report:
	CIP:20.250.75.252;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:seppmail2.psi.ch;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(14060799003)(1800799024)(82310400026)(35042699022)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: psi.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 12:05:07.6051
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e263c3-d991-472c-9c2f-08dd316f0682
X-MS-Exchange-CrossTenant-Id: 50f89ee2-f910-47c5-9913-a6ea08928f11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=50f89ee2-f910-47c5-9913-a6ea08928f11;Ip=[20.250.75.252];Helo=[seppmail2.psi.ch]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000077B.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1650

Hi

I investigated some more git init failures on our NetApp backed CIFS 
storage, this time not with FUSE but a real kernel mount. I found two 
different situations where a seemingly working "no-op chmod" makes git 
init fail.

a) Everyone Full Control permissions on the backend NTFS

$ touch test.txt
$ ll
total 1
-------rwx 1 buchel_k root 0 10. Jan 10:28 test.txt
$ chmod 007 test.txt
$ ll
total 1
-------rwx 1 buchel_k root 0 10. Jan 10:28 test.txt
$ echo foo > test.txt
-bash: test.txt: Permission denied
$ rm test.txt
rm: cannot remove 'test.txt': Permission denied
$ chmod 600 test.txt
$ rm test.txt
$

Investigation in the backend filesystem showed that this created a "User 
Deny" rule which is stronger that the "Everyone Full Control" rule.

b) only User Write permissions on backend NTFS

This second issue is even more wired:

$ touch test.txt
$ ll
total 1
-rwx------ 1 buchel_k root 0 10. Jan 11:00 test.txt
$ # open the file and keep it open
$ exec {fd}>test.txt
$ chmod 700 test.txt
$ # this chmod took multiple seconds
$ ll
total 0
-rwx------ 1 buchel_k root 0 10. Jan 11:01 test.txt
$ # write to file using the already open filehandle
$ echo test >&$fd
-bash: echo: write error: Permission denied
$ # close filehandle
$ exec {fd}>&-
$ # repeat without chmod
$ exec {fd}>test.txt
$ echo test >&$fd
$ exec {fd}>&-
$ cat test.txt
test
$

So if the chmod to a file happens after is has been already opened, then 
subsequent write fail. Looks like a bug to me. After reopening, all is fine.

For the records:
mount options as listed by mount:
(rw,relatime,vers=3.1.1,sec=krb5,cruid=0,cache=strict,multiuser,uid=0,noforceuid,gid=0,noforcegid,addr=<REDACTED>,file_mode=0755,dir_mode=0755,soft,nounix,serverino,mapposix,cifsacl,noperm,reparse=nfs,rsize=1048576,wsize=1048576,bsize=1048576,retrans=1,echo_interval=60,actimeo=1,closetimeo=1)
Kernel: 5.14.0-503.19.1.el9_5.x86_64 (RHEL 9.5)
Backend: NetApp FAS8700 with Release 9.13.1P6


My conclusion is that a no-op chmod is fine on a local, proper UNIX 
filesystem, but in other setups it can have unexpected side effects or 
even hit bugs. So stat before chmod will make it work in more 
circumstances and cases. And as git is nowadays a ubiquitous tool, my 
users will use git wherever they believe it would be useful. I would 
like to give them a seamless experience as possible.

My experience might be limited, but I have not seen in my career any 
attempt or use case where permission bits inside .git where adjusted 
after. And only then there would be minimal price to pay with the extra 
stat, all other save a chmod. And this price is way smaller than having 
git init/clone fail completely.


What do you think?

Kind regards

Konrad


On 20.12.24 16:50, Konrad Bucheli (PSI) wrote:
> 
> 
> On 20.12.24 16:44, Junio C Hamano wrote:
>> "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch> writes:
>>
>>> I have another idea: there is no need for a chmod if both the config
>>> file and the lock file already have he same mode. Which is the case if
>>> the filesystem has no proper chmod support.
>>
>> And for majority of people who have working chmod(), would it mean
>> one extra and unnecessary system call?
>>
> 
> I do not have stats, but I guess the chmod call would be needed very 
> rarely as most of the time both files have default permissions. I do not 
> know which call is more expensive.
> 
>> Instead, how about doing the chmod() first, like we have always done,
>> but after seeing it fail, check with lstat() to see if the modes are
>> already in the desired state and refrain from complaining if that is
>> the case?  That way, we'll incur extra overhead only in the error
>> code path, which is the usual pattern we would prefer to do things.
>>
>> So instead of removing this part, ...
>>
>>> -        if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) < 0) {
>>> -            error_errno(_("chmod on %s failed"), 
>>> get_lock_file_path(&lock));
>>
>> ... you'd do an extra lstat() on the lock file (so you can move the
>> st_lock inside this block, narrowing its scope) before calling
>> error_errno(), and only after finding out that st_lock cannot
>> somehow be obtained or the resulting mode is different, you call
>> error_errno() and arrange an error to be returned, all inside the
>> if(){} block of the original.
>>
>> Wouldn't it work even better, I wonder?
> 
> If you think that is the way to go, I will adapt the patch.
> 
>>
>> Thanks.
>>
>>> +        if (stat(get_lock_file_path(&lock), &st_lock) == -1) {
>>> +            error_errno(_("stat on %s failed"), 
>>> get_lock_file_path(&lock));
>>>               ret = CONFIG_NO_WRITE;
>>>               goto out_free;
>>>           }
>>> +        if ((st.st_mode & 07777) != (st_lock.st_mode & 07777)) {
>>> +            if (chmod(get_lock_file_path(&lock), st.st_mode & 07777) 
>>> < 0) {
>>> +                error_errno(_("chmod on %s failed"), 
>>> get_lock_file_path(&lock));
>>> +                ret = CONFIG_NO_WRITE;
>>> +                goto out_free;
>>> +            }
>>> +        }
>>> +
>>>           if (store.seen_nr == 0) {
>>>               if (!store.seen_alloc) {
>>>                   /* Did not see key nor section */
>>
> 

