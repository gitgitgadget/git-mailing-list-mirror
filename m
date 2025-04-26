Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011031.outbound.protection.outlook.com [52.103.68.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA6F19048A
	for <git@vger.kernel.org>; Sat, 26 Apr 2025 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745691338; cv=fail; b=V8nMQ37G0TUwkUogots5keWM54Vicc6mraFp52DOzcUzKaIEyGQIQysXeBm+hpyYxJ879ofKe1LtemTzW09UhFQIvX8NpvvQiEcKA5a62AiouxztX46buN01eD41AKihi+zuT3Jf5wdz1bt/65+K73qeAT/UpXAQBP23q5fUa6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745691338; c=relaxed/simple;
	bh=sDvKMQ2OameCV68sXBX/V7Qlo+A9Ly7JmGeo0FuCkqA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gFUl8DVHtIVAjC/vAdWcc2PEEIJ9pSQvWBqJLzl2FMWKau2Zga7Ok9sb4tz+pkal4NZbHkwPKmnqoNBGCbH5aw6XaOXuQVmC5W+Dx0+PizCG4rnVN+yHOLJ5QV7MdwQXJQoAs0L/gn20wQqn3HOb+yMA1NM8YvwTkxcYqmxPEOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kV9MpHpV; arc=fail smtp.client-ip=52.103.68.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kV9MpHpV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRTuMf1idoC80zks/giy6MxTprPYeCd9m48hPrfbpcFR/eCKHp/x0QBKnUeMlNVLiynCqpIxp+IwT4a2T8vHZ9MorjXjG1JsZ3bnCPBDjCgX/FszbQyVy5FOmXhtIjYpmqLX+fXTCBj70oetj+Xt4xFxDCwmRuOn2axCyjcZ8a+hBTPRovsiOojSI7W9X7IKBqtdIQT/fiwKjZgA9nclA0odvSvMYnA/44K4i82fSCChANHA4gt/2RASqLFLZd3mzR8Kakg1CisG+i1kuRuPSatDPhGnGiT653aCGHJF064ZTdgG/PH2fy6dFSfgDLN/Tc/DZXXj1Kw/WXgDJHGMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WxY8Z6bf4+NbzbWKpQp0IaP6uD/CBYi/w4O1DmNla8=;
 b=iD6VQZKGsopuaJwG5refMVMM2cuGNKYMyydZ2ctFqjs79W28BeNQ6haXwSvmOBHRp/4m5T5amx2VsM1J2uDfVOWDfqFROUeWG8tl/Uk1Cs61SKPnFPzAOCAiHP1PErLoNFlViA2OoyNAIbAiMb/OIv57XhmWjWOgYa3R/gEAVkyDpFH/koxbCPHcVm1cqlAK8KDFB6iqSuar2JJYBSUCLabsy5fqNL8TOJF0PJfT4lR2zxIx2GqhJYgtN/XNOz5elteSAcds8l4RSS6qIE3Z8X4PTT1qrmdcs+eQMvc6K8wwwYO+eX077U7lXZddZXgj6WqY+kXW9Cr7P8P6cx8gfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WxY8Z6bf4+NbzbWKpQp0IaP6uD/CBYi/w4O1DmNla8=;
 b=kV9MpHpViZdkD5nMBb/QZ9HWFmKN3BkFU/vhcMzTIDywIPhIR2KIhHhusVfFFZ3DW4HV/+AlhroIfzoFwK7pQN/8hGFfHzW/7+KyiEpj1meGdbnGq9NaE5pkpZ98IV3I30+sXlbo6WNwdoeblV7GotqeIZYYGQSntEAc9eqD8O1sRmXFlP6XAzXaOnN7YAo6MJeVXtH8tvoBvv5qlPpOiRXZrLXS5nGYbMyy8QCuliyp9GF+1vo6P+6zuS5RgccLCYjThjPBvPSTc42LlUaorgYOFJZqkxso0XUhHM6iYqA/8tHx3vc/bbz5s281FqKUU3TTr5kp1matQ1g2mpNNEw==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by MA0PR01MB8771.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:ca::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.28; Sat, 26 Apr
 2025 18:15:33 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%6]) with mapi id 15.20.8678.028; Sat, 26 Apr 2025
 18:15:33 +0000
From: Aditya Garg <gargaditya08@live.com>
To: git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] send-mail: improve checks for valid_fqdn
Date: Sat, 26 Apr 2025 23:45:12 +0530
Message-ID:
 <PN0PR01MB9588EBBF200EA002E558D4E0B8872@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0071.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::16) To PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:10c::9)
X-Microsoft-Original-Message-ID:
 <20250426181512.23947-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN0PR01MB9588:EE_|MA0PR01MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: e734d601-4a8f-48b4-5b56-08dd84ee556b
X-MS-Exchange-SLBlob-MailProps:
	F3kBGFPBgzZvmeFfeCGpsF3hpO96EClzpyq2WmZdQvjbGK6ZmNlqJbfcz1Yi2EZY5hxhly10izCa9iXq562LabmEIP6s4leBagg4l2O0s3SgoNIpxdk+DjBQWuBVZs3GjaqZ9UPGn5Sv//G3MGenWKE/XQ5yOzz2KSv1zSU4BB6fDIA9XyuStIuZ5NV762qvb0VU6c0jA2PtEkxMfFWbhCNyaXXXgJQhNq07RyjiuNadTICKMnqOAhGp2/v0M31e380WgL4jp/scvkYsT8O+h94YToPqsVP17a/L4gJhgLoqwONbRIdibAAon1nx8ZCY3cZ99VMXnmf3khHxm5ClE2/99idGb6Y+wgXQ145Ym86Af2bZBhsBYfyq49rqEIauaQW0gJEArtJTPQnvA8PXzjNuz0nnoIQeZsGAledW6/lrm2PCwxfNvc5xVZTVziBTaI6bJ5LCUpJhC4ysw83njke1K0ENORx4a48OOs4avXfDycqaedr+GUVvItt2Hz8/LEcLrS/YlFDAUwqjlqvs7uB6UnLvoNwY06NaHYs1y6IYTnoUld3nYdXV8xH4/bRHdZ1xL9DPmpC1HL4rgRs+Ya4Zvok7rpOybhm6OEckDZdDZG/3+2fgVUP+AcDWxJzHASh2e3o3kxElu/OZqY8GAP2flfWTPT9ZesSxs46RKm8KwisoRabg5w54L6fipsZCRIZ4QOD1UB4D48XPStVgMZ/wQNKRBCfPM4iTdcbaVl4Dq+yp9XBfnJCY5YvqrIvy2j8VeoDQ2MrOy5277kijWTd1XyhR2BAR
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|7092599003|5062599005|5072599009|19110799003|8060799006|1602099012|10035399004|3412199025|440099028|4302099013|41001999003|19111999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gqKdK2pOiK7Pl7H0CZ+49akvopENE0JzHeYDsf2GO8f3nzNFIblAOOBchpvk?=
 =?us-ascii?Q?rgeaf4mWyfWsSXS0uGW97altoh2x30zTVTPvRVHDcqimVEsAKnkthqnDjvPS?=
 =?us-ascii?Q?jayXUb6kORA9RSJ8PcGQukhK8z2DF09VzTlvJjhIkot77OAPbAoXjvlMNNFj?=
 =?us-ascii?Q?8LM4nzIQCNOuAV6UiuGJHyTvVUZ+ZH8OHpRrv6cXo6KqRB1HcRvVqIWLhmao?=
 =?us-ascii?Q?j89BPZpFNbQ3XZDyyEhjcuQzkiTCNCMPBCVxPVivPLOckb3FKzJ7NLz9w89P?=
 =?us-ascii?Q?fC9cAoXxuLMyESEigjOsnVMSU9+GGyQ9dXvu67khMWMQRpVb8tnIW6vkLwJ1?=
 =?us-ascii?Q?9IHMPk4vtrKBv+hmQaIX4Gdu2BzGzUjfiPi+sdnkJKGT+rfmxb6K8+rbjA9D?=
 =?us-ascii?Q?2cElA6DEh+AtBCzNMTcIg4Hc1cStVITpIFL5ZFeG8gHAEywLoQ18x0F176EV?=
 =?us-ascii?Q?wk+GMlqqRWCT0K06HC+nTkX7eSEETNbyJM7X/Ks0qYDBGv4SHMBKPCTCAMeI?=
 =?us-ascii?Q?xoP90wxTjBad7aCO4UwszBsAS2jYT8btbnXK17VmTh/UJ8j8GDXxN7CdKiZ9?=
 =?us-ascii?Q?RqdU/5KfQifU7fSqv3zvcb3STAtikLLXu+MAa86z+czchGoI3QG2+lidjo9j?=
 =?us-ascii?Q?YKotGOeVEHkVhJ6w7jRbQ5k7wN6VupCmKdtcqEXUETqVqZF8XT7o7vfWXXxi?=
 =?us-ascii?Q?E+6ZaaVpLPHhBOxWXgFm7b99rXBqGt7FpMDJVEL6Z6hbi+iKliSR0CNKlZXm?=
 =?us-ascii?Q?EGGVUXZ7CdvJ99hN2dTJ23+Aqj+l6clueGZf9gi6x7/wyeax9k2ow3QJOk0H?=
 =?us-ascii?Q?mMmd2SrUgCOXxOvXEkJrAbY5qkRJm/cE7/iPri6NDxMlP+GLcPhsK+SZFTBl?=
 =?us-ascii?Q?dy2RihfDoPK4nkRErQUyunYMNFUXENEMi5TldOXDQumbyCjAlETRhfooaHIR?=
 =?us-ascii?Q?gj/zHTWhbJiq1gy4bvt3i7eF7BCtJLnQRYmd6TjT2Y9Hc7qDVmpORdNisnmD?=
 =?us-ascii?Q?Ky1EJ6GGVGXO1icgjo0/yP8b9Qadg8jF1jYGFV4aKy8vgOsP7UqWAxA23QeF?=
 =?us-ascii?Q?0Gb9RUA+pOZs8KhXt4Fdsp5Ew+4rvTHdeO/L+ROin/6zjIGh6ZwM/7w/q8lR?=
 =?us-ascii?Q?6Z/5e/FQymcW019g0YzVRpPJyN7+nck6cG0YfgIi5mCbjMs7E93MxK3vmaP8?=
 =?us-ascii?Q?oytMZpEaYeXSrap/fYh+dleNB01cnmZhTRr6tsYUw8hGqhdAMaPaobz99JNe?=
 =?us-ascii?Q?eqiddOHpJ5ZcvFGq2aF/Q7kdQxmMzcfGH6/UYjgZJ5654ZPg7mK9/sv+9yBQ?=
 =?us-ascii?Q?gH3D/pHKfbPcq+XLqOaNS3GZkY/UrWZ4ZU2YuflAc/Yhp34TUFv5fpYPMXQM?=
 =?us-ascii?Q?AKW1iF+TElCiJVfsuk03XhXTia/f?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1A/eD3Q/5fwNae/l8w3wajecbB0NwNsJMxtahjzbvGSMiX4KiDEnn0NPEJdb?=
 =?us-ascii?Q?JAyMqLgjzpupViNl5+wixVA0SmIqsq/5FNV9z5FQc5IPdPbgiqnYo4ZWwfns?=
 =?us-ascii?Q?rxeSz3x1R2r5jTAhWd3c5ShM+90+IXhgT0saqn42mF22gphyAK3lDvniG8F+?=
 =?us-ascii?Q?3Ohocyo08VGpAaxYgjHODQKjZgjVQoUjbw7Xdn0/OwigRRmlU2HbeUSFIiIm?=
 =?us-ascii?Q?VL4+0VBFn2CvpeM5QcmBc1urzS85QN/u7/tUfZxTDT1j62VEJFg0ywtSrPe1?=
 =?us-ascii?Q?02mD55o+vSDFQOzDP5Or2r38c/WJ3J8+sQli1H+lIuXmG1dnxhjmJfw0KhTI?=
 =?us-ascii?Q?XB2Z4NxdwZyvJcNcB5w+QQcCyGQX9mkyBmyxvVjKPn1O9yV6JRHQOV7UOX8v?=
 =?us-ascii?Q?q1PS+/0hUZP0mk3Dl0JxM7dLnPpRtM6RDcawqNS8nqbkydnjzmxmYLI/LKEn?=
 =?us-ascii?Q?Eu9T6JoLcxMy38tYJnKBwhHp6I3nJVSmV66hTVmy6qfwS9/jofnA2RyblDyU?=
 =?us-ascii?Q?y7IhBSDnV5WDH2kbXB9oXnntIfAwbfUizXlLRc1Aw010qmrDvaHXtY8JZHAw?=
 =?us-ascii?Q?lJqf+x9dLoATz9SK7PaPPBZObZg8seyhrIKKtstrj6jRNkZMxDkliF9asqmE?=
 =?us-ascii?Q?/+e4SJ43JYXvf9LpTSqgrVwObTSDlp2XU8/FOM7bK9HSuMmNYnwOIrCjDScl?=
 =?us-ascii?Q?HiHZkUHRm8wz7kKZa935nSWiRcBPRr1TgIXeQnw7WAICZc5NhLQ1isIc6DBP?=
 =?us-ascii?Q?YLgdbac5Hgu9AZ/FUnurQnNyDbBb7GqkK/T+7HOwjO5NFGBq+zyMopRt9Thp?=
 =?us-ascii?Q?vVzJfdg9U6CIgdKXbv1puGW+nFUUgOiFuLsvQNOdBdxispmwklGvZO/TzIRH?=
 =?us-ascii?Q?PTmwaWXxrT7FAo1FYjg2Ljv3VmqrZdJPDRZ4ewGJJ/WQY45kuQms64O/mR87?=
 =?us-ascii?Q?HNNjSlBqNzQpOenIQ6Xe7J+uGohuvSiFNl0+J6CmSPW+Na6F8lPoroaDjADf?=
 =?us-ascii?Q?nPK9Dou2aEEgCTQFBX1H0zTchqHpQ8thxoG2NcaXtAoqAPRJJEH4RLPbbAFu?=
 =?us-ascii?Q?LbPNwh+LzyZCi7mavsGHzPHrM9lMCX9zN/vTBjGiJ2oqsDEC/fB3fWgckhvg?=
 =?us-ascii?Q?IE1Gpca727LzU/9dMMBODvq+iTksVJmGHX3ILiF39PitXuAa58Q1yGlGKd1Z?=
 =?us-ascii?Q?5PeskqP8k4QeCl/o4UecReH/hVRsdMfgCde7CJeBJY7T4YhiInY4DfWDOlqp?=
 =?us-ascii?Q?/JotW7WUF/9osS4zcWbiGCJpvHqc9+pbI/Poh7xOuh4JDufSeV3m/EVBUS2R?=
 =?us-ascii?Q?vv7N9a4Yw4uVIG1rjc9QG5KE?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e734d601-4a8f-48b4-5b56-08dd84ee556b
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2025 18:15:32.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8771

The current implementation of a valid Fully Qualified Domain Name
is not that strict. It just checks whether it has a dot (.) and
if using macOS, it should not end with .local. As per RFC1035[1],
from what I understood, the following checks need to be done:

- The domain must contain atleast one dot
- Each label (separated by dots) must be 1-63 characters long
- Labels must start and end with an alphanumeric character
- Labels can contain alphanumeric characters and hyphens

Here are some examples of valid and invalid labels:

'example.com',          # Valid
'sub.example.com',      # Valid
'my-domain.org',        # Valid
'localhost',            # Invalid (no dot)
'MacBook..',            # Invalid (double dots)
'-example.com',         # Invalid (starts with a hyphen)
'example-.com',         # Invalid (ends with a hyphen)
'example..com',         # Invalid (double dots)
'example',              # Invalid (no TLD)
'example.local',        # Invalid on macOS
'valid-domain.co.uk',   # Valid
'123.example.com',      # Valid
'example.com.',         # Invalid (trailing dot)
'toolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabeltoolonglabel.com', # Invalid (label > 63 chars)

Due to current implementation, I was not able to send emails from
Ubuntu. Upon debugging, I found that the SMTP domain was coming out
to be "MacBook.." and was being considered as valid. As a result
the script was failing. The debug logs with the failed script are
below:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x5db4351225f8)<<< 220 BMXPR01CA0083.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:06:30 +0000 [08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> EHLO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:35.781Z 08DD842467C8274D]
Net::SMTP=GLOB(0x5db4351225f8)>>> HELO MacBook..
Net::SMTP=GLOB(0x5db4351225f8)<<< 501 5.5.4 Invalid domain name [BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM 2025-04-26T18:06:40.828Z 08DD842467C8274D]
Unable to initialize SMTP properly. Check config and use --smtp-debug. VALUES: server=smtp.office365.com encryption=tls hello=MacBook.. port=587 at ../git-send-email.perl line 1727.

With this patch, it was fixed and was being considered as an invalid
domain. Logs after this patch:

Net::SMTP>>> Net::SMTP(3.15)
Net::SMTP>>>   Net::Cmd(3.15)
Net::SMTP>>>     Exporter(5.77)
Net::SMTP>>>   IO::Socket::IP(0.4101)
Net::SMTP>>>     IO::Socket(1.52)
Net::SMTP>>>       IO::Handle(1.52)
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 PN4P287CA0064.outlook.office365.com Microsoft ESMTP MAIL Service ready at Sat, 26 Apr 2025 18:08:13 +0000 [08DD84B323498C1A]
Net::SMTP=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP=GLOB(0x58c8af71e930)>>> STARTTLS
Net::SMTP=GLOB(0x58c8af71e930)<<< 220 2.0.0 SMTP server ready
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> EHLO localhost.localdomain
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PN4P287CA0064.outlook.office365.com Hello [2401:4900:a052:31f0:9beb:e613:56e8:f897]
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-SIZE 157286400
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-PIPELINING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-DSN
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-ENHANCEDSTATUSCODES
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-AUTH LOGIN XOAUTH2
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-8BITMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-BINARYMIME
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250-CHUNKING
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 250 SMTPUTF8
Net::SMTP::_SSL=GLOB(0x58c8af71e930)>>> AUTH XOAUTH2 (OAuth2 access token removed for security)
Net::SMTP::_SSL=GLOB(0x58c8af71e930)<<< 235 2.7.0 Authentication successful

[1]: https://datatracker.ietf.org/doc/html/rfc1035
Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 git-send-email.perl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 618474916e..f14b25d718 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1354,7 +1354,8 @@ sub process_address_list {
 
 sub valid_fqdn {
 	my $domain = shift;
-	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/) && $domain =~ /\./;
+	return defined $domain && !($^O eq 'darwin' && $domain =~ /\.local$/)
+		&& $domain  =~ /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z0-9-]{1,63})+$/;
 }
 
 sub maildomain_net {
-- 
2.43.0

