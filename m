Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AC449B1B
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186248; cv=fail; b=D9sfJSgYfiC5tWO/NQQvKGOxY0f1SsZ+5Fr5A0G+VNZKmEQ7WafPqqWjoj8AjVUZrL5h9YAJyJaxIzwjj+zoSR1NXFpEgI6UMDX8P9d9FFTnVrQZ3O82x4t9SC5wgoLvmpOfRG2z7x9De3lMevG8saId7UL5/w5UPUxTHyDX9d4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186248; c=relaxed/simple;
	bh=3vM7jd9xukKC3G3mHIfGulKQC1M3HtHZPXt/045vuKM=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=PAGy9o8DxlPMouM778ZxNZ2tKLsFfTONg83XlfytBssd4GqCvTRF2vIhwZ8oAG7s+s0qKhkGpnCvfMHiFP7ubgYheBnQIyMBu+S0A+6+6gjFGQud/o4jzVYL59BbuJX3sHdD5btiR74U60TJ9dffyQv3NH8U2eurqw1Da/T+eko=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HyWA5onJ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HyWA5onJ; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HyWA5onJ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HyWA5onJ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O7gYuXG5tH9zcJSDvz89bn/qD88HyBnOPF9kyKSEfNaub9Ym0xDk1k6GoZCaEXdKoVzk7kRU81NRzv8HP8/j5YV/YsRE74o0z6Z6Rgl3WK7Ti8zZ7ErpiCPQPjB2CV36ZqVgticKEfG0LDt9+qVDDdt782Wmcp90kpM3pF4WC3paCF6mL0LmIfSuJEVhngdtrzgrEGFNmijEM3LIZVHuaTRrPJ242UFhQiCwYJgDAtDsGrlkveHZLIIgV55xx1yJK4bR11rJ/UFHiyki+y9YsqzgEw3npTPklTDtHgASLHuyzQ7UvfBzppLbjaKatAyxeAvD6C2nYDE72kJpnFE+9Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU7BDUVCuz/+494sv13wPuNpk1ea4wgygMiPvKUlYnA=;
 b=DwsIvvO+e3uWw5NtRA3nAeyoh6tourhar9GtAd+jClMd5gr2bDny67Ms9ALV08GnXcmLZ1pvjzCxylm9ocb2w3RJj9BfmBRx2QkSHM/2qZkJp19BHM+YbcVqjU6Tz8keN6jFqsX99GnL19JRd1tSYg5smY5Tl3g+PUw0Qv7xs88hRDk2SFeDE9P91GB2GH4NLIMK7CznJI/uXGe1G9kWwriVT8N7lfB5l6nnoWiZrQNIbtUp137JwJ8TtJMN2H0MU+2eqdW+x1KgcuPXEiEUKMjQRwUxenUUc9x+PHG5C0Gvz5yn/pIKOp7T/pIN1LKgxxxBSRnqPfHWuy9kEvSjJA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU7BDUVCuz/+494sv13wPuNpk1ea4wgygMiPvKUlYnA=;
 b=HyWA5onJzM2hpdbQKlaVOZvipy8L8QMhmWBM/FiKk3xOZNlGyXjDpVc6Xq8OjserpmU66M9dbsTRca34T4NCkTX3usFHBrHXdyxJ+I3EYymddkKsM4Cjy2f4kmtxecaX6G+ldM/AcphowRuKlbVs7xPXic4/up8IkSCKDHyS+iE=
Received: from AS4P192CA0002.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::9)
 by AMBPR08MB131521.eurprd08.prod.outlook.com (2603:10a6:20b:78a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 14:24:00 +0000
Received: from DU6PEPF0000A7DF.eurprd02.prod.outlook.com
 (2603:10a6:20b:5da:cafe::a) by AS4P192CA0002.outlook.office365.com
 (2603:10a6:20b:5da::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 14:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000A7DF.mail.protection.outlook.com (10.167.8.36) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8 via
 Frontend Transport; Mon, 31 Aug 2026 14:23:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVjdREGXQpxUXWIXl9vxPQa+EyDAwjSF1fMe8cmM87bnUHk0hWssvJp3Qa/WtaEat2qzRtA0wU3ARkX9OZFjJZL12FyL0AeuoXrfeYO+JOuu/fbHgNedzoRiOtnzIs7hkbnI4UlxXdduQ0CzRxjnPzlxtfNaeE12hkq6NZMJvDJI/e9MVs3M6rX8I0VkGoRQVmE+h3rwf5dsbSLbEQcv9YB5Onhrt5XdTOf5LogmJQVQlr4/MhwNYeB/TXxD722WgwhJDULCIFnzclJLk304TBnF+SuqLJH1US20+qKmXFf4RC+4t8KxCW85g300L/Uyo9BgCzFQEeaCGBJS0WMecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VU7BDUVCuz/+494sv13wPuNpk1ea4wgygMiPvKUlYnA=;
 b=Tff8F2Ey2chZvracD+qfrmOWWc3X6JpPj1CSrg6viqFyFT8ytdjm20PDSTQobASG+7qS2ZKOAZZ3X3fPlT6BVu2yg7vN22fAnePKn3w5MsMFwqBOHnORTaCjqWUbf1TXydRWVX5DF5g1lkh7Xzitqa/H5Iq+m43pG1Z0ogfRkMeaZlU+EzwTWP5SRj24LwuQ3F2OC7y9qDAsqOfiji5ZNK8eDDcQdmRKfFaTYp3dxrZYD80cK47k3MnxDQSiOFqisV+MBS7piUjzkiYmydgDNUBo3tuyiiRu9/5RozL5kCePN0aRvNN1qkrgUVSmx01CEqNLDtrr93nyy6mxrc+0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VU7BDUVCuz/+494sv13wPuNpk1ea4wgygMiPvKUlYnA=;
 b=HyWA5onJzM2hpdbQKlaVOZvipy8L8QMhmWBM/FiKk3xOZNlGyXjDpVc6Xq8OjserpmU66M9dbsTRca34T4NCkTX3usFHBrHXdyxJ+I3EYymddkKsM4Cjy2f4kmtxecaX6G+ldM/AcphowRuKlbVs7xPXic4/up8IkSCKDHyS+iE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10) by PAWPR08MB10240.eurprd08.prod.outlook.com
 (2603:10a6:102:366::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Mon, 31 Aug
 2026 14:22:44 +0000
Received: from GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04]) by GV1PR08MB10455.eurprd08.prod.outlook.com
 ([fe80::af66:6019:a08:d04%4]) with mapi id 15.21.0382.007; Mon, 31 Aug 2026
 14:22:44 +0000
Message-ID: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
Date: Mon, 31 Aug 2026 16:22:43 +0200
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
Content-Language: en-US
From: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <bence.csokas@arm.com>
Subject: [Bug] Porcelain allows creation of '@' branch
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO0P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::18) To GV1PR08MB10455.eurprd08.prod.outlook.com
 (2603:10a6:150:16f::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10455:EE_|PAWPR08MB10240:EE_|DU6PEPF0000A7DF:EE_|AMBPR08MB131521:EE_
X-MS-Office365-Filtering-Correlation-Id: f9086f8c-d34a-4a5c-a4a6-08df076b8000
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|56012099006|10067099003|11063799006|6133799003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 50oXKVMk73qD57lr0hpRT/IRN7Wj8FAoSBwjQZR8u2MC0i0hnjNiRHUGm8gL8rsINL14YhQdo2UJ/0KHnz4y8MSaBgdjAMSClTn94sWENu1QRWDfjcMRrb5v7OLfrUmI9i/xRbt0wBbsC2WfW6TUSpB1d2/aQqQ+E2FqxK8UqaAWII0qng6CsZzOEz9Ogpb6/Ge/09x6XyHTuojgX6wBpccqc5/LmmcFmvtZRQW/7mMoN3VcWImZR3aYuetkXSNvhpDDlrzJ3NMJeniIZHMrZDCC/E8ycAGTk1FtOi3AEy/FUM4ZucXmUXYiA4NvbSzxn1Epiu2JryezGO1GuzNz8B2hVw5EuSGk21c3vx4jeTvddEQ3pWh4OTwyAyZBHQsPNO6i6Gx70JyABnVmVo5L/VXXYLk7sQDYIdp+CW5GmWhUfZ3xwW7nQpeET3lrb7LCarXp6FDStxg7Vu6pToPHsX4cNWgDavxSDMVfDtuiUGDpNAoTTc9S8Ywi8k8DcSC8A7Ji5JdBQGE1k8Bb8v0TzcRcQ8zRymA1CInNMOTY/ay4MwfkpMmc4jQNjVb7PE6WjxZKldRPnAiVr5bi8JI0ocINuV3FMnaiPsBxudyNXowTMC4rRNOncYQX43UtJGle0pJ3hnCxLcvq5nFG6mgQ3q9H30VcP0dcI7Af4hNLL4M=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10455.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 liKDpZXWYNuPpkFgk6Dugmj1nJ/NJ/CZDYte/ewbYnB80tmAKSaYWGqs8zxwfspKtg5YXzjf70XCCux8bgbg+8vdOGRg7P7AL1uQZIlaoXg2E5SwEAkfZVAT27mfVf+fQoDt04L07Uhzy46KdFfln3bhCI8HJtPtk7qHHbUwu0mKNix9U9mO1CvlzCIKdCKKs80t6NSHhnqtnAxo9Q4Dp+g3l4lEzXfkRI4WbLi655PxOokDz+rfqRgslen2IwuoYmKJUMs1ajP7Vetc7w3/SD2/MxU/eO8IA6vyGyIZiKEshY5B4SxQ6HaAs3rGPSxaVnAwx8K8sKPLD0cAC6kh0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10240
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	55b60575-6dcb-483c-a0a1-08df076b52d1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|14060799003|35042699022|36860700016|6133799003|3023799007|10067099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	M/l5NVUBtWnWfh6WRe8ai8UfTDrZyDQousgGCC1W18gEVR8osqjNCAIicVQJhX2FLfO5YaeuzeIfixEPoaGPvTsPiYNJ+5Ud9INoANHgfMp6xGA0OiHmE25Azqc/NFt0qacV9pMOVDzeT7wVtbKzimXODcwFni3kTVCcvbJ5K9QbO//0YsyMMTyX+SEh0m87xPApdzOWx07im1jjSED6/qb8bjlNhk1dT8BfHzTB0xYnLN2DbMorgo6jvrkMbLheWSrxHq2e1GhyhwOtPJYNTH9IJ/dVItv8Av9DViP0hKI9R8ktZ2+Nah6Wf1/eqXWt0vM3I4m07N8TBUli36F0jloGry0G53WPlvmXRb0yg4k03GLRCbmNZswe67niFlwU3ibXoYJ9cwC9sWHUkacjHCBtE4FADepwn4GSX+bSeamfFhs/FZTJKBPopHPyFg1MqppJUFwsTjkN0i+uPtEVKZHDoYpDK9dVeReY8pr13973BTWEht7jg8BhzO9Hc8KAJqnukO6qYnvGfXtCpsWQAk/eHubnHTciWA3vfGRTL9stMvdpAGOWvoOYwaty0wNnURktkItARHXcY5NODrNa0O68jYNpS/51QP25godWq4QocDT4FJnd2perAfnVcJzMQHW/WRudY0ubawadi8vnlrKFUgRT7RguopvyF5NKWBLrzEOcOeWS16gsbWZAzhEWM7BeEpEhd8LnHS+SmYOFKA==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(14060799003)(35042699022)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QArPWFO+3hwaa6HJMqtrpjmX1qPX5M369qVGZ5Z+L1hrGvBJ3PrGAca9PbF/eUik4A+2yAq2zfSFJDsojX5TDxr5c1faChNwwwgsKMnjfct2lIc3U1TD2RaP6RJM4duDWfWVXPTLoiskkYQTiz9hCZx+9otQzokUYaVxJQB/+ULUp6yihzxMntXhofW5CeTnyoYbdHbt/3QWq6dv05gKvrBxKAQkbrFakidQomBYeoNevQ/MTE8HiA/tFCr2qOtDHd+oIJP+jxICHO+YZHHWYKgosFobVZWCm2tuIHoC8rCYw9NWaFq8wKltBvYV+rtWXtI972gEHxtbJgtNAoqTaLOkyXJGATydAswfVm+2PM5V/a6O8wlDSemUFxiShX6HnG1mmEgI3dw9kuxkkx1BDK9Ulra7On1YvFIW7NKr5WND/fQcDUgqtPtG3FtydshK
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 14:23:59.9955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9086f8c-d34a-4a5c-a4a6-08df076b8000
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7DF.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB131521

Hi,

I ran into this issue a few weeks ago. I'm using Git 2.55.0, which is
the latest released.

`git help check-ref-format` says this about a branch name:

   [...]
   9. They cannot be the single character @.
   [...]

And as expected, it is rejected:

   $ git check-ref-format @ && echo BUG!
   $

However, the following commands all create a branch named @ :

   $ git checkout -b @
   $ git switch -c @
   $ git branch @

I believe this to be a bug. Other invalid names are properly rejected
though:

   $ git checkout -b master@{1}
   fatal: 'master@{1}' is not a valid branch name
   hint: See 'git help check-ref-format'
   hint: Disable this message with "git config set advice.refSyntax false"
   $ git checkout -b @{1}
   fatal: '@{1}' is not a valid branch name
   hint: See 'git help check-ref-format'
   hint: Disable this message with "git config set advice.refSyntax false"
   $ git checkout -b @^
   fatal: '@^' is not a valid branch name
   hint: See 'git help check-ref-format'
   hint: Disable this message with "git config set advice.refSyntax false"

After creation, this branch cannot be checked out again, as `git
checkout @` is a no-op. Luckily though, `git branch -d @` works, so I
didn't permanently damage my Git repo :P

Bence

P.S. as I was typing this mail, I realized that I should've given
`--branch` to check-ref-format, and sure enough, there's the problem:

   $ git check-ref-format --branch @
   @
   $ git check-ref-format --branch @{1}
   fatal: '@{1}' is not a valid branch name
   $

Not sure why it thinks that would be a valid branch name...
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
