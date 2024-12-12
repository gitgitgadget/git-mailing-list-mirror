Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022132.outbound.protection.outlook.com [40.107.168.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8920C01A
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 09:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994904; cv=fail; b=SeqOAVb/ZpK9Q7bGGdBG/Y3F0XPCZKYS/FM5ieWt3NIFGSg/fETroXl+2UZBz+jRFH382s+mH4RIRFKi8L32fK410+8QQfbC+FDr5EOjyfbBlBkna8BNqr0LKS1kOeNOVCGVyoB3j1jDQ2lkOTQm2N3aLI6u/wxyB1mn/ID1E68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994904; c=relaxed/simple;
	bh=bCHVrWjLZWVtpQB8BOnSEjLlcwfWMuQIeFtIEE3meGk=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=Kagbl4S9PbYsMrXANTiL28BA71UioUIfBE/PdaaEnPAlaetE00N1nJ2ICDkRYrL5aoPxTJSr19KSSeFfF9SKUhDMFCwZoFbn/pnzyn/Ef6VqcBPJ05aAM+h5cA4Zbdrw/b93BgW2YeScKJ/Ph02j1cfPxOhdzkfI8+Ud6WMnuYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch; spf=pass smtp.mailfrom=psi.ch; dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b=mF6PyzbZ; arc=fail smtp.client-ip=40.107.168.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=psi.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=psi.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psi.ch header.i=@psi.ch header.b="mF6PyzbZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxsmHH5iKBaC5pIfeOzlM3NSS2kjs74oTsms2MVNZjDqCDP1TTGyGg8mITIMsYI8ffE1/ndMrbaEQc7YJsOLva/8d3hLKJNnjQiFOjj7qf/dFJQjf1Hwnqa5ntjLdx8NQtDVMjfgAsEHlNrnCNTdF4PP/09Rd9+nUAyNAcUEV/zgRLHU8IEoffxDiAeTXsGdYKuM0ywv3aPx3N4ZhTJ/8w1bx4kXNptgEYVG4Dr+z6nwRTqeYMWppXV0jXVuvltKALyL486h54XRaMDBLOrVEYArGJfJH/oeRxA/P5PGZCf5jZEvWJASlDh6XQPm7S6CVgdr4+qkgSRuhuNBqTL9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7P6ZjWL2e9sEWic4UBTdgmzlrjhk6Ew3RcH0ay8/lG8=;
 b=FeKL2VEwxgZvVvc+snS+PrCJFwrfS9ysAAW7O7Fi36xtMXfJoJ5gx4tuwUhX6G3aJebAB3no6Aum/KeypXW9+PddO99NzcDQ25RW0FG48nN1B6/BqPyIr7b2u9kXNxb2DfeVBE2uoLIQPunAq0M8ZAOIsUg8uswEGUFIisJmuUX+VsNRq1jsoNQXBgjpshUbnPsLx8XoMlW5XXTBum7GINLKvcsgIjoBbIvq4/DFYjgx15Mgo4kDrntTbjugPQu3y1ygPJ/nLNV22axmWJebLCwRJ5jVbo8FYq83cwQ2+y2AHNUC+9ZrVTgFeA7NvkYNfyMYRufm9gZnoSzIx4kdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.250.76.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=psi.ch;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=psi.ch; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psi.ch; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7P6ZjWL2e9sEWic4UBTdgmzlrjhk6Ew3RcH0ay8/lG8=;
 b=mF6PyzbZ/zKBGLlI3/J3NLudyalNu8rChHIJZSkieIfbfMgV9P2jIBEpeFTOAZasPICno1KXHnX9y3ij7Ca6Hm5+SqM2HVXrC46btF4vEa0rszFuzkSgmr4aDw1JDmVsGdlnDN0cZwO82LTW7hsbgJ+5b9ZKl1AVu2Kybe3WoC7Pj1QqK/3w2S6z7BAP+RfrghoHoiQUC98j/kURtMa68W58N7HKmxYgLT2hFCM5qDXS5r6rDxuyrakjQrfHv8Ex7/ytMoM3A+ail1P2Bp01osXfzeGotcHvkHn+UFsdp5c2KqWd0LNjYF1ZD8iqNRTUKVkbIfCoTpNLirFfU6cFFQ==
Received: from ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::20)
 by GV0P278MB0832.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 09:14:55 +0000
Received: from ZR2PEPF0000012F.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16:cafe::7b) by ZR0P278CA0010.outlook.office365.com
 (2603:10a6:910:16::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 09:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.250.76.7)
 smtp.mailfrom=psi.ch; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=psi.ch;
Received-SPF: Pass (protection.outlook.com: domain of psi.ch designates
 20.250.76.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.250.76.7; helo=seppmail1.psi.ch; pr=C
Received: from seppmail1.psi.ch (20.250.76.7) by
 ZR2PEPF0000012F.mail.protection.outlook.com (10.167.241.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15
 via Frontend Transport; Thu, 12 Dec 2024 09:14:55 +0000
Received: from seppmail1 (localhost [127.0.0.1])
	by seppmail1.psi.ch (Postfix) with SMTP id 4Y86Hg0Lvxz9xG
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:14:55 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011024.outbound.protection.outlook.com [40.93.85.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by seppmail1.psi.ch (Postfix) with ESMTPS
	for <git@vger.kernel.org>; Thu, 12 Dec 2024 10:14:54 +0100 (CET)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=psi.ch;
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:3b::13)
 by ZRAP278MB0753.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:48::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 09:14:51 +0000
Received: from GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288]) by GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 ([fe80::9163:7f88:662:9288%3]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 09:14:51 +0000
Message-ID: <d26f4b93-57a3-4536-8c32-3ed5b3e98a86@psi.ch>
Date: Thu, 12 Dec 2024 10:14:50 +0100
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: "Konrad Bucheli (PSI)" <konrad.bucheli@psi.ch>
Subject: chmod failure on GVFS mounted CIFS share
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0113.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::10) To GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:3b::13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GVAP278MB0504:EE_|ZRAP278MB0753:EE_|ZR2PEPF0000012F:EE_|GV0P278MB0832:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e6c91b-3631-4468-63e0-08dd1a8d7179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?azdMK0xYVm5FaVBtZjcrWnBHTTBZZEpiYjdOaHZ1NnZXNlZBeHpIMmwrZndX?=
 =?utf-8?B?MTk5YndSeVN5UkI2QnQ1ZWZOU0U3N0t0Um1UZ0VOM0JxUlJFd3UzdWQvSzAr?=
 =?utf-8?B?d3pQVGxrNEZ2cFBocHA4eXNxT2paUVpYRHNUTzJzTmxQbWU0dUZXQ21iY2J1?=
 =?utf-8?B?Nkt5THZvVUR6MmhCaC93VlEzNkNJbkJDZlJFeVpSaHA3R0FFRFBWeGpyVGE0?=
 =?utf-8?B?Y2FnNkQxcXBwRzN4cWtsaThNWXRLTUNQNG4rbTRLNG9PL083eklrQkFlMkxa?=
 =?utf-8?B?MHh4dmVwWStKS2xmRXlBQjlZY0dvdWZqSzJDSnA3QlZybG5TWjdwcTRNc1Bt?=
 =?utf-8?B?NmdlYS94UEowa3pyd29GZ2V6MDF6c1JEanZsZ3dHNW1kREZxaXdQOHpPcmZO?=
 =?utf-8?B?ZkswempscWplT3cyNkYwYVVweDhGZ2dVbXpjTlJEQ2NYVWZrcXE1b0dsb3Jh?=
 =?utf-8?B?cHJVZ1cyUVhZYnl5SzlDc3FZdnNpajZYbHM0bi9xL2JDaUh1UkV2Q29aZmtv?=
 =?utf-8?B?dmFnN3l4czhQVnRadG1jNFc4SGcxSGYyQXM4UmVILzZ6YWRCajAzNUZYOXBQ?=
 =?utf-8?B?eTFNUWd0UWx6ekdjWk9LczRCU0RCRmZPWGV0azUxcnozbTJsMDR4QlpSSWlP?=
 =?utf-8?B?c0VEUWxmbXUwZDZiaFZRaVZrd3FKVEs3VDFhZnBYZ0Rrb0I5R090WjhSZlQ4?=
 =?utf-8?B?SG5KZjM5dFEyUHFTQ0p4MzRIekhoS3c0K3dGdHJHUGp4MzZUdlc0R2g3aU0z?=
 =?utf-8?B?TTVnNk9lTllZUjBPMG5ZcW1OeG4wN25SSHNUNUYxamJVUGZRUFoxaHZVZjg3?=
 =?utf-8?B?eUlSa05aM0hDSXhLZTFHUUlJVkhsR2QwaWl0UzczMHVBQ0RCMTBBWnMzV1Bl?=
 =?utf-8?B?UFRKbllLSE8vZmxJTHBOZWdPOFZjQ3QwbXZMMlFVNGdyZCtrWFRuWUpIbWxn?=
 =?utf-8?B?Y3RZN1ViaGJHZXBwYXFaVUhtUVBsbnIrVmRPTnk0Z3ZQeFFTTEZKQ1JRQU84?=
 =?utf-8?B?dU5XSzAvbERCemdhblhNWWJtYVlCNUVSc0RabUZQUldJdWN4MThGM2JGUkJ4?=
 =?utf-8?B?V0dxc2JoNEp1VzBsZmtTeFZ0OTZGQmJjaXg1VzhMN0EraStqVWlTL1MxY3p3?=
 =?utf-8?B?a095RjJIVGR3enQrOW9tVVdabFpzMkYrN2tqNTlrTjU2SldyaFVFanBUTThI?=
 =?utf-8?B?cFlkc3h5YzF5RkVrc2g5QnBkenV4bWZtTGJtVEZaeXFMK1FkcHRSem9LNHBR?=
 =?utf-8?B?eFhvUGtGZjh6SWJab1NLb3BsTjd1L1JXUXVGYnR3WWwyYWNOOGxXUUtVUlhu?=
 =?utf-8?B?ek85MHpFTmMwaXM1U2FWSEwrWDRHYVg1QlBXNlFEQ1FNTHNmR1Q0eVZTSExG?=
 =?utf-8?B?MjQwdHAxZjcvSVFzbTlaLzRQNytUZnl1SjZMQTFiZjlGUjQ1QUYxTEZWeWI3?=
 =?utf-8?B?eGVlMlNUYk80Z081Y1N5cDA5Y29RTGVjM0VES250RFlJVHVLUnk5NG5nTlIv?=
 =?utf-8?B?dzI5QndRbDNJbjJMWEZmb0R2MUd1OFBNaDdOME5nMWJ2MXdWc1czaHA3U1FD?=
 =?utf-8?B?M2pKdnFNYnNuam5XVndTQ2RmTlgvWHZjZkl0SHkxb1B2SkpvOVFhTDdBd2dt?=
 =?utf-8?B?QUNKQ0F1SFpsdURsYmRVUjByL1h4UEtlQjNkd1dIeU9sajF3eklpUU52Vm1W?=
 =?utf-8?B?WWp1dUtGMVhTL1Jla2FydVI3YmYyTmhVZWtDSnp5ZEcrRW5mS0RXOHg3OFdT?=
 =?utf-8?Q?P0SqvQOwaO4BDKKa4w=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0504.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0753
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 ZR2PEPF0000012F.CHEP278.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e74afd90-eb0b-4015-3e5b-08dd1a8d6f29
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700013|1800799024|14060799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NC85WVhKblRQVHF4L1R2YmZCY1F0RHJMUXczSWV4NlpiOURyVWZKUUZkNkYz?=
 =?utf-8?B?YUdMczBZbUZWamhyenBvVU9QTmFSbzFGY1pEL3J3UzhpckhPbU91akdFS1Zn?=
 =?utf-8?B?Qm43MEl4VkRuYmkvNXR2S1FadDFVUEhDWWJwRlZBcnBKenFOYy9CcEFhR282?=
 =?utf-8?B?bWdVbjV1Mmk1VmdJdStOU1Ayd3Fla3NxMEZHa3ZhUXdFQ25tSmxyNmx5YUxk?=
 =?utf-8?B?RFVaK2IxbVdZZjNBNSsxQ0Flcm4rQXRrVVFPV3krUGlnY2Y0MVB1NStZVWp1?=
 =?utf-8?B?cFZjM3VmazJPMHl6dXNlWkp4SnVieUZyNE9vcEdaMlR0b2NXRXVhYm1WeUtK?=
 =?utf-8?B?bm4xZjdaM0QyNEliQW9QNkJhZVlHdnJoWkRVN1dOQkNtWklDbTB1ajREWDE0?=
 =?utf-8?B?Yld0TnluOEx6a21BVGlOVWNEbUZKMFd3T2x3RnpQdVJhT1habVpCYnp5Vm0r?=
 =?utf-8?B?M0dzRitmQnpWR01KcGZ5elk2aTVOaVhnYXdpSG9ja3lacGM0VlNrMmh6OTlh?=
 =?utf-8?B?bjl5UzI5L1VmcnpnUmV6emJXTmo2Qy9MK0JOYVFiQStHMkhpZm5wSjdBNTNO?=
 =?utf-8?B?WXdzTkMvSnp4VUs4cVl0UmZvQVZPTnE0bXBhMzFSamNINlc3a3YvcEF2TmRw?=
 =?utf-8?B?MnBmSXJWOGIwVU5rUnYvS1prQ2VOUmNKVWJmeHR1OTdjZ1RFSjUyQ1QzNWVw?=
 =?utf-8?B?c1BWUmhpWDk5YXdsMEFKRDNYMkNhQ2lyT2I2bG14Vk1yYk1sTW9kdXM5TFBW?=
 =?utf-8?B?c1d4UDFOMXpxeFZTMUlud2FDTGQyMzJNSVNrZWdSWnIzRGtGdlpoN3V6SEtC?=
 =?utf-8?B?d1o1REhTNTdqMnNyRGUvMGcrUnp0QjZxbzhDUm8rZy83b0tTQXJaMzJNSkRR?=
 =?utf-8?B?Mkk1KzNrUzlubG0wNUd0ZWM0cEwvaGN0ZUhuS09rRGFEN2pWSWtXK3dtNXVj?=
 =?utf-8?B?NElTRDBkZzVYUEt3RFJkSHUrR0dOOTg2RTMvazVTYVdZK1l3Z3pPbWp6blhS?=
 =?utf-8?B?M21YOHhtQ2FWNEFtZ3lCSUU1dDN2L0FsTWZSSm1ydnBvUlk2Q1I5dFg1WS9R?=
 =?utf-8?B?ekpGa0NPZmkxVksyKzhxUUlzOVlqNHk4aGwrOFNXVFUrYk9mampncUZ4Yzk4?=
 =?utf-8?B?UkpuSE1uTnNVNDlyaXFMSnM3TXFrS1RiV2ZDL3RYTys1NTJqNDNzb2NCZCtz?=
 =?utf-8?B?VUdwcGFZUExHeUdsZk1VWDNWWnJzVkVHVk8ycFd0eWR1ekpCSklkZE9vNHFT?=
 =?utf-8?B?dHFwOVJuYTZudEJMYkZubXhBb2F3SUVtQWlacFQ1S0N2K3k5OWtaWGtEbXAr?=
 =?utf-8?B?blF0WlN5WmM1cmUxZ3hWNGhqS1NUQTJ2MllkOFplbWVUamxHQ2ZteXl6b1RP?=
 =?utf-8?B?SHRVVkJCMkdLaXRkU2JyZzdHYi84b1JyeDFVOXcrNmtIZk5BOSthcC9JY1Fh?=
 =?utf-8?B?WjJ5WVR2b3lSTGlUTWdrWEpyV2lGY056WXA0RExkZWczSlNPZVk1b0NZN2p4?=
 =?utf-8?B?VCswUzNMM0k1NHZYVFpEc3gyV1NwTWNoOGV1ZGZjWDh2V0duRFptRVMvNGhn?=
 =?utf-8?B?TmtVWFhwU0ZQNzFJMEVZVHJ5ZER0aWw5UkFxVmlOdGpPTllVcmJtOHlvZ2JT?=
 =?utf-8?B?cFpWTmtLY2RLYkg1aVRjYkh0NXFzamlPeVh6enBVT0hnUmc3b2dIcEQwNENV?=
 =?utf-8?B?WGIxdDJtMXR0Um5yTEhuMk05U0hyWGl3MTd0OVFwVUtpZHhWdSsxaC8rOWl2?=
 =?utf-8?B?bjZqNkJNbC9RMWpjaFBSNzhaQnFPc0xBdksybVFhRjRhbjRDd1JleW1OZWIx?=
 =?utf-8?B?T1orWmEvaWtHRXFoZ1lTK0pycHkrQkt3UlpVaEdMSDRTTDR0b09yNmNUWXNR?=
 =?utf-8?Q?uccyyjjXpzjRW?=
X-Forefront-Antispam-Report:
	CIP:20.250.76.7;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:seppmail1.psi.ch;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700013)(1800799024)(14060799003)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: psi.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 09:14:55.2188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e6c91b-3631-4468-63e0-08dd1a8d7179
X-MS-Exchange-CrossTenant-Id: 50f89ee2-f910-47c5-9913-a6ea08928f11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=50f89ee2-f910-47c5-9913-a6ea08928f11;Ip=[20.250.76.7];Helo=[seppmail1.psi.ch]
X-MS-Exchange-CrossTenant-AuthSource: ZR2PEPF0000012F.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0832

Dear git developers

Below my bug report:

What did you do before the bug happened? (Steps to reproduce your issue)

I do a `git init .` on a directory which is CIFS mounted via gio mount 
(FUSE).
On RHEL8 this needs gvfs-smb and gvfs-fuse installed.
Mount command: gio mount smb://fs01.psi.ch/my_user_name$

What did you expect to happen? (Expected behavior)

It initializes the git repo.

What happened instead? (Actual behavior)

$ git init .
error: chmod on 
/run/user/44951/gvfs/smb-share:server=fs01.psi.ch,share=my_user_name$/git/foo/.git/config.lock 
failed: Operation not supported
fatal: could not set 'core.filemode' to 'false'
$

What's different between what you expected and what actually happened?

I expect that it fully initializes the repository:

[buchel_k@lxdev07 foo]$ git status
fatal: not a git repository (or any parent up to mount point 
/run/user/44951)
Stopping at filesystem boundary (GIT_DISCOVERY_ACROSS_FILESYSTEM not set).
$ find .
.
./.git
./.git/branches
./.git/hooks
./.git/hooks/applypatch-msg.sample
./.git/hooks/commit-msg.sample
./.git/hooks/post-update.sample
./.git/hooks/pre-applypatch.sample
./.git/hooks/pre-commit.sample
./.git/hooks/pre-merge-commit.sample
./.git/hooks/pre-push.sample
./.git/hooks/pre-receive.sample
./.git/hooks/push-to-checkout.sample
./.git/hooks/sendemail-validate.sample
./.git/hooks/update.sample
./.git/hooks/fsmonitor-watchman.sample
./.git/hooks/pre-rebase.sample
./.git/hooks/prepare-commit-msg.sample
./.git/info
./.git/info/exclude
./.git/description
./.git/refs
./.git/refs/heads
./.git/refs/tags
./.git/HEAD
./.git/config
./git-bugreport-2024-12-12-0951.txt
$


Anything else you want to add:

I guess the failure happens at config.c:3339 
(https://github.com/git/git/blob/master/config.c#L3339).
What would it mean if the chmod there ignores "Operation not supported"?

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.43.5
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 4.18.0-553.30.1.el8_10.x86_64 #1 SMP Fri Nov 15 03:46:25 
EST 2024 x86_64
compiler info: gnuc: 8.5
libc info: glibc: 2.28
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show


Thank you very much for your good work.

Kind regards

Konrad

-- 
Paul Scherrer Institut
Konrad Bucheli
Linux Systems Engineer
Core Linux Research Services
Science IT Infrastructure and Services department (AWI)
OBBA/230
Forschungstrasse 111
5232 Villigen PSI
Switzerland

Phone: +41 56 310 27 24
konrad.bucheli@psi.ch
www.psi.ch

