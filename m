Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711561FC7FB
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 02:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022023; cv=fail; b=V44+DCs64nIftGVUL124h9vByIYKARCPePFNelpnRfMP/d3FkLQMsekjFQ0C3fXPN8vj7Zmb3a56RMiXuzOY/mGjRwXIyH8OIH+fKXw/Xn3+ho4Fw+TB7LxGlb7Rhj4cQbGViJrUvXw+HS6DKOKQPdXVtuceYaiF+IQw/Icd0mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022023; c=relaxed/simple;
	bh=he50412iYXY7LEJDCAtPA+I/Dhh7CVrei6MM57iTi5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L83A0OQEYOyV/Bgmj2vSSfY9ULz3ebAuGr4UZJbDG6eO5MGU0q5ZWiJ/VW6xsMK32N1ZDUI3+mtwew5HtsGrkND5RBoqatawbaVCUz1gJxLdMp2tClUXBWISJQs1ZrlfNIlmrCVpaCXhRs5nO2/1uUniEX7Ay/lFy/sT7uhM+FM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GzQ/vvRV; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GzQ/vvRV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C33QytyD24ktETXtgoWutK4G1TzNkJVFG1+8J+7OjxfckcQcuzAeIrzbAKCW9eNopnQuO0UmzImTZFG4O/rexq9hasPUXInepjNJhwcAfXHCkQ2ZZCRgmaZtoekFyO4++1+gnnicuOj5a8IwfdPGMrLG22iY7JefoqGAD4koRd5szzb6AE/dujILgwXkKYdvb1d+02yHoAR6TiPlmU24/mT8W7vwTQ8lw5KhmeL1y6lAqQIanLm4COFE6YbZ1bLY+RKRubKPiePEu+fKdQ9ITBUTgGtXk39D4vgwi8SbHpxi4cKP+dJCrmqLrX6yA9J2Gl5TWxDvePE1gqktx5NVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPj3WekyELEApVzplKZnCIgoezMOrLXf2QMUlzTxdAE=;
 b=WNWwCZpVXhXHhU9jYEsIJXp6DOZ2WVkLlcrahOKzFXu9qtoHPh/1ASQJ2+X4VxWHnpFrkUjD5W1LzYuZ97YDICxyqFRXvWzSiTK0NISJNjigiAJoEDJRK/HpSll0IfrzH5/o9cS3S6P9duVum6/HxqpnGgL7q7IHmp/jiEmrEbwCGVjkRLK5nH62U8tpzpnKomNc6ZZDvYp0XIZcROfGZMdvkeh7WZhaUaPtLwiU5QgzU1TmgBsjn6RvU8ZP/vgBJKSvZz5G4aJUBg0K2uxJnWfCuH8lPEKxyPZNZ1wPFWRUWQy4sr0i8l1dzSDXl+c2Vx83rKRynbujQNGpsVyfWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPj3WekyELEApVzplKZnCIgoezMOrLXf2QMUlzTxdAE=;
 b=GzQ/vvRVDBTRldpRdfhWUfWa78kcoLQpFHURwkt2xEyFMRJmkPAPqzEOiDAGm2HBpeniQMDGyEuTgzK3eVCv3VgRTj6TfZJh7czFFArQ7Zy8SNmT1ZKMY4zpgjtX5bmVo1hIf9NrjWu2bHFSRQi+TwvI+trkeyhwOGpBidIV8KfSvSmIC0UpaUJcijMMZqnsQ/Bdfzug2eg+2iLkbmQZrena0YqTAsq1gaWgvT40CmMjMhYVCH1VpwEwMih+oZ1Lg/NXHX29aNqENpCsi3bFor9Id0fp4wtlB928sxhHFyI2iQ5d3tuo4I6OFgDpRnx7KUlNgR+TDJrM6KNhzjdhAA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY9P300MB1545.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.10; Mon, 9 Mar
 2026 02:06:59 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 02:06:59 +0000
Date: Mon, 9 Mar 2026 11:06:55 +0900
From: Jiamu Sun <39@barroit.sh>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/5] help: refactor command autocorrection handling
Message-ID:
 <SY0P300MB080153161083DAA000A77035CE79A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Reply-To: Jiamu Sun <39@barroit.sh>
References: <SY0P300MB08019805A8304105FA805EB1CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080180E17B471505A4150C08CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <xmqqsea998vd.fsf@gitster.g>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsea998vd.fsf@gitster.g>
X-ClientProxiedBy: TYCP286CA0141.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <aa4rP8MDJQCLDnsu@lancer>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY9P300MB1545:EE_
X-MS-Office365-Filtering-Correlation-Id: 008c522b-52b9-404c-0aaf-08de7d808bd9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|51005399006|25031999004|5072599009|19110799012|23021999003|461199028|8060799015|15080799012|41001999006|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELLHzbyG698/2skT66LGhyJbpEFRf/+Of6tBQy4UruSZLMtGhpOUcusaC82m?=
 =?us-ascii?Q?erD/8Rxsn1jlLOa7Nl4v7Bu2b1WUeWJ4L7tB+asgPCNxFTX7Isoe4oQslUYG?=
 =?us-ascii?Q?nQCvanF6sYXqEc1gsvR9AlwActWviT8i1j8e9YZZSJY3zpPlfdzNAU9619cc?=
 =?us-ascii?Q?cDGxsr9Fx++IyLiO5JnJzEqnpjzg9dfcXVX16AEQ/jth7/cTCw4ffw7GV7is?=
 =?us-ascii?Q?C2k7wpiHSMyx0jxEjcXDYt2p13RpcSaHw+yBa4hMuj7BjD00BJrrXhuLk5sJ?=
 =?us-ascii?Q?HxmNJX6dcU+EAgPHbS+FZcFIJhjyODbiAJZ+etpmimSmiVYkyhdO1ipMMYQ4?=
 =?us-ascii?Q?LeQtbaBhYRLpBLbmyL6LpY1fBquhBf69QCEdjpQNXdccqTlKKiiPOy1BIHEH?=
 =?us-ascii?Q?Yg3H51mE4ZuARAcwtgO8TfTiaVqY9HJLPb28uCFungajsd8gaf/++EG/j9eX?=
 =?us-ascii?Q?tiuryLEAsfu59aeKKNpAUQTzBIy3QVHwlVzMonhkSckOnQfXDhw7uOSlHt3f?=
 =?us-ascii?Q?lzre/2z2dFfl5KqlWu7rz2WaIThHiklIbnfKwvXR+vqODBFp/WLzpb4udHkY?=
 =?us-ascii?Q?O4gUDa2Z/Y+nFFMHOF+aD/F6lSpzyNQEWcJSU+qwdiRttsGcH8ZA+SIeeE07?=
 =?us-ascii?Q?ibHbRPcq2NanWNqDvxAIVvfMexm+bIv1m6jrUuWbg9z716B+MwAl1MragjXN?=
 =?us-ascii?Q?cfujXaB6Yw0xgz7wdyas8IhcDk/HuqlVmMbidpx0Vnja1zHUCkhtPRG48Txd?=
 =?us-ascii?Q?vnMeTCGWWGJTzLkeFiTWwUXgtRlDfsCmXWTaPFHuXx8j/onE455ha7VoiWz+?=
 =?us-ascii?Q?34fNuwDyux2lbLFoNZH7p8W03jGif/rsyEeTqvRTNBi4YvTtTOCpz8bkkFN/?=
 =?us-ascii?Q?vx8mEsw0bn1MLnj9a/XoCh0QXFIZ8F8WIZDBs87Y8ad9jZy4893f2DVQE5v/?=
 =?us-ascii?Q?hCzkHfw/Tw4tmAZIDEFCDBr4jgQQCM29LTlRiaouzOICAj8VmmAX6A11hHDt?=
 =?us-ascii?Q?WhJG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?749ZyDxcpKTKiiuYfHu4Q22CNe1KMbRpMxA6JjJs1FFGgmJoMbMKUEBrTbhc?=
 =?us-ascii?Q?IT0tytAZ7VKDt6XxkBMdSiTucHNQ9PiLdSYRUfJVbX+3BmrIRMCTQaaD/73X?=
 =?us-ascii?Q?n4o2QJ+joyj0pJG0V0c0fOHb7om2IkaMYLddyJ4YwxJh1Kgb4ldTlyMisiOW?=
 =?us-ascii?Q?zctwwMV6rCg+9PVrzsGU2MhHhuvwfmiKFePAU1nIVLqYcJD+Uhn42ta89CKr?=
 =?us-ascii?Q?soMuw8Yz7S+/ya3Ol2kOxek1K/+M7t/w5QXoWvymvdLQDx5odGV96xbiMs7+?=
 =?us-ascii?Q?3fk2FME32D8+XjPNsp21/8TwgXcA9VBebdccnNo9o6S3OVKTLf2LaevxQt6j?=
 =?us-ascii?Q?q+Z+FfikmvfZMvvB2dovHhNsb7As2Wa5apm90d9HXiD22Q6/CGA2tHFe9EaD?=
 =?us-ascii?Q?lIaNrISRhlI4FToFu7AE5D+jsQPAfzm3Y5qjqOsionU4ib4tqbWdTWiSefo8?=
 =?us-ascii?Q?IWgJCgLU/sEJrw1mokOwkqH66CoMx5g3aU3oC4V0iv+6xhlVkhvFENO9Rkeu?=
 =?us-ascii?Q?PMbA3JmC6Gpo5AQdNkpB2yTtniDen0kNGknGNTwJFtWeU4n7++YUNM7RU4aG?=
 =?us-ascii?Q?+C3MhMgepCdfVVCMFGv4iM+ctc4inuQJhEBwuflX6UE2qzp6BH94k6jlPOiV?=
 =?us-ascii?Q?8LXVOdFcYJp6UgECX7sdVgo68caZvnYG7OT4HeYzBINzxpW10wh0lZhq+2oJ?=
 =?us-ascii?Q?XTKfRKpZ7EN1ZaiwYATeDCRMsXL6kP4WkaHiZqHuPVAtQ07MEcF6YTivBvN3?=
 =?us-ascii?Q?YdwjUnvRgarJdLO6iUSWPtpDylko2xPmfHtHrM7DuVzVh7zSNuSuttY7nalB?=
 =?us-ascii?Q?X44EbSeYTa6w8bA0pzEHkAuJQ++XTNVCx6ckgnFUTIrIX+mv8z4rMRlSdmGR?=
 =?us-ascii?Q?5VA6UNzrCPFPH8m9HhGmJoUOyX87AlRbGcBpUKQ5YylEXrIHQP3YG65JR53k?=
 =?us-ascii?Q?nC0N+35Zt2N4RYdJFGUN5ooERALuKahLQE4HmVMJmq+gX9MhAMT7N2WBFsPT?=
 =?us-ascii?Q?b5rQjshGIkSYfYfYCZVV8R76fwfb0lVDE9GV635nEGcqwM8ht+Awcghz0Cav?=
 =?us-ascii?Q?EIhz+wnQs3OBmWE2q/P2iRtRG15vAzs3W5K4+XU5/yRvt8lmUEatQ+/SHMmg?=
 =?us-ascii?Q?yrrm0LDBGj4BtAySnOCzAHkwC8agatWVE1gVLlsbUK7FkMclsEeUjJwk9uch?=
 =?us-ascii?Q?KeDy1KETgpxm6wZSO9uKSuktvvquvBJ7o9VonyBMuxiJnaaLHq5h5EUeLty6?=
 =?us-ascii?Q?72X65LjFN6fqrtEmCEK1p9bU0PYwgWBdAzVmsr5mh79R6cQVeP9KHiWysP7x?=
 =?us-ascii?Q?jDwQrLu5jaXeupe7nL1hqmW5uwrZ7bBqJORLMVD7ywEiJX7O7rrc2R0wWMZh?=
 =?us-ascii?Q?Fpns3HwhiPgVczyXTD6xpbSqLqWq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 008c522b-52b9-404c-0aaf-08de7d808bd9
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 02:06:59.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY9P300MB1545

On Sun, Mar 08, 2026 at 04:52:54PM -0700, Junio C Hamano wrote:
> You snuck in unnecessary "style fixes" to make bunch of "if()return"
> into if/else if cascade.  Also what was AUTOCORRECT_SHOW is now
> returned as AUTOCORR_HINTONLY.  There is no explanation on the
> reason behind these changes in the proposed log message, and hiding
> these small changes in a code movement patch makes reviewing the
> series harder than necessary.
> 
> The patch is doing too many things (namely, (1) code movement that
> will make it later reusable as a side effect but has no semantic
> changes in the current code, plus (2) change in style (like the one
> we see here), semantics (possibly the difference in SHOW and
> HINTONLY we see here) and features, possibly including the renaming
> of AUTOCORRECT_* into AUTOCORR_*.)  Let's have "restructure with
> code movement and nothing else", followed by "other changes
> 
> I'll stop here, and expect this step to be split into at least two
> patches to make it more readable before we can review it again.
> 
> Thanks.

Ah, I realized this patch is completely unreadable. You are right, the
code movement ended up hiding other changes entirely. Will split it to
make each change obvious.

-- 
Jiamu Sun <39@barroit.sh>
