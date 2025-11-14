Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022123.outbound.protection.outlook.com [40.107.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6FB35898
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160919; cv=fail; b=cBLrWBZpqyYd73WKhchca061Zf6F+wf6603aR7+uVB7NABbKjknuKjccU2fYLv2VCBKZ+N5Lke8eX2UTguSfdlB192lkc2lIEnryWaIdWJHE8xY5lGuH9N/s00JlnQsiRtu7ihQ0nl0b0CiWaJiJjRmeVS7XVjmwuIVGuJQa71c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160919; c=relaxed/simple;
	bh=q2S0NyNkF2yskOOJ1sLor8bFUWaCJrWcoxO5BWr3idY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sPB1oatpVSO0TKXBwPJmFKhxR1BpVi3gxmFfFW7VOEcFL5cKXZ7jL/fQDKxnwJaOQxx1FYsxD+HmpvnAAJ+8gsRrZrhWw90NcO1A9GGOMnwrfffdLrqBc4rZu/l2As/iomDmCC2T7VFZgaqaYAy2fNQkGtV3hfHoBhLS9R9YtVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=qcWdpXsY; arc=fail smtp.client-ip=40.107.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="qcWdpXsY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWszl5lIK/CRS87q1tcVrz3ZN4uxBv/kHhT0IFkEAyDq9/gDx8BRonlHE8mtGNChG6q5dRG7PfzeYkcvekVcEjF563Jk/GVBw6R3uIkHD8a26GNhd8GiGsLr20GKtz4LqoDlRsaCIV43z2X2UYLKf/b42lcoR6vvLaSWccTDBHXs/4QxDy0XbCV70BEv8Odu3Ccqfk/aDXC+wYxyFgwwyZsj2SpD6WXxB0tJUDmFv1IOp0xePkyK5tcUm96cVV4c8pGAywkBDjopvUOn7g5olyrEHj2TFRJPJJMaR2oT4eXpKRJ17azFeLd6gNQ/zQJlNsY+RmBMAJdEfuhBfA2SEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nFS15ESAConVDjLshm/eW4UjtC1lGk04xEhqE0+qUk=;
 b=P7CZyecxPoVyh3F+QwE+XY5F7HCVz7UiAI7s2E61nbcJq4PVjUkHS27/WQq1je3/DzozVI0rWsF28qrmCLmJgcSuBzQIwfqzNe/Q7ZR5cDts2wKjlirCBGgeHRBM4N5BgKab7+gdDnwd2r0wrBrtuch3vRy7GXg0t77DsI5PEnXg8XS4jZ+acfL+8g2wA0gXYJuxg+P1GO/Dsphet0dFKtWAZNDPWGKHHeEqGoP24oQZJHa7xd9M3Gbhc4f0DJ2SsgcG2w4QqqT7DnVeTUayHKEUF6fKPE8tp48qtUQ9+7lPO2y18pBS83zFqaiQihf9AUbf3WAe5zimFi/KgtdUTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nFS15ESAConVDjLshm/eW4UjtC1lGk04xEhqE0+qUk=;
 b=qcWdpXsYv110ADoh//re5lHsN0Vc0SYe0vOPMI8C5pKa+l/BMJ/bFfb7TpCejtRVH/Zuf7R587qjHwI1xRBtJWyg6v9hQU5B23KUB+5YfNEAl1jeMcL4HFaT0rQ47eyAB0Tbif6MF2Tu8XP51mGwwGaknWDP6vuf866VaImV953NZvfAcJJZnmUEfx52Gs+8RFjcbTmNzNzNWKIOoAdqwTTdI92MWz1WyLeUCkUvxOYA+ed19xeagfjdIGH1oOru2viOgqYOC8LGkJpr+ZUoUd4cwM1OubLFNHjmvp1j/VeYIdm+PwTBSRmg9lVNRdEYF7jU9DSE2sBIoonM00BuHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT1PPFE21B28B54.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b08::59c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 22:55:10 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%6]) with mapi id 15.20.9320.018; Fri, 14 Nov 2025
 22:55:10 +0000
Message-ID: <b434bcb1-bf6e-4fe7-af2d-8c33348378fa@xiplink.com>
Date: Fri, 14 Nov 2025 15:55:07 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: git fails to checkout SHA1 submodule in SHA256 repo with
 --depth=1
To: Martin Wilck <mwilck@suse.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Adrian Schroeter <adrian@suse.com>
References: <c94a929df63f79e49eeae0cd67c1f59f859e3d62.camel@suse.com>
 <xmqq7bvvtdoe.fsf@gitster.g> <aRUaR6IfH9imrF5A@fruit.crustytoothpaste.net>
 <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <a1c0440a6eef8f306f53793b2f96636945d4ced4.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT1PPFE21B28B54:EE_
X-MS-Office365-Filtering-Correlation-Id: b46ff3ff-92ee-4948-60d9-08de23d0dcc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2NUd3lYV2pLRGZuS0JrenZWbk5KRkJkOXZ4d0FkTW5oOVltalRnTENtVzRy?=
 =?utf-8?B?SGdMNXdIdlpSTXdVK3FCZGM3bVpqN1lpSTlRbEJXNVczclJRVjBUN2IvTUZO?=
 =?utf-8?B?S3NwRWlrSzU3Y1BwdEViK2hDUDB5cThOSVZ3NHRCZ2Y3K1pQVkpjRytGVWlQ?=
 =?utf-8?B?Nyt3d3loMkR4U1BCbFJpaXkwTWJrZkRYUXpidWR4aG5YbjhpTFhRM0ZaUDUw?=
 =?utf-8?B?RDUrMWJraldQN0lqb3B0TVNTRE5FdTJHeVJ1NjFqQ0xJWDRHbUZ4eHc5Vmkx?=
 =?utf-8?B?T3RsdmxpRUlSYnpSTTFPb0U1a1hqNHZlQXVJTFBFRHh2cjVCVVNvYWtnTnU4?=
 =?utf-8?B?SFV0VWM1UzdaWmdzYUdpNzRKejRZRFdVQ29XMWNNSzNxdmdpMzF1bVRGdmtv?=
 =?utf-8?B?YjJLWUU1V0NZMXlTalU0U3ZpZ25uUnhYb3hHajB6QlRsWnh1TlFZY0dCeVJG?=
 =?utf-8?B?a2Y2VHE4emxDVmRicTRtQ2VSRlhEMXlUSG54eUh0RzdiT1ZpcUEwVWtOK2ZS?=
 =?utf-8?B?Mkkyc3NUQ0NCVnlhTW90N0J1bG9KVjBMcGNjdDFFUjVrdjdiTUZMUDBvaE56?=
 =?utf-8?B?MjlJcFZhRDZYSFVBYU9EcGdyS1lFTkU2cnJQWWk0UjY4RkpBZXRuUEtqRHh6?=
 =?utf-8?B?ZFFqNkVteHdiaGJySmRDa3Q0REhudVhwdzdKRUlQcU1waFpEQXVtQndRejl6?=
 =?utf-8?B?eGxzS2lwaVlzaWV3OVZ1WXZvYVlQZW5MeFlWbHh4bnQ5RVZDa2NRa25Qb3ZF?=
 =?utf-8?B?U2dPYzZ0UkgxcEhwVTBPM1Z1ajRwUGZuOUNEdlhFTTZaWUl3TERaQ1YzUSt1?=
 =?utf-8?B?U2IwRXF3N3RVS29HcmtSd250NjJmUlQweEVQaUxycm5MNjIwRWZ6VHd4enVD?=
 =?utf-8?B?aWY2M1NqM1J0ZUp4SUdSa0dPN25KcXRybnFzUHlJdlRpRjUyckE1TFZxVzV5?=
 =?utf-8?B?UEtVbVlqRTc5aFdKYkRka3VMek5yMjlzb1NNMEUybmF4cDQvWjhFQitvTXFE?=
 =?utf-8?B?L09hYnZYczNyeDVMOTYrYWZZVGxGV3hOSjB3VTM3clM0L0NLaDZhNHZmN1Fw?=
 =?utf-8?B?M09TQXV6SXhPcHZCZzFwcDVKcGlsSEM4TTF1TTY3bWRMTG9Ec1NGdE1wemts?=
 =?utf-8?B?V1FwM0NWWTc1L1hqd2phTENmMWFqUldGT2hGNDlGcWpEWGg0dkdjUVpBUkZF?=
 =?utf-8?B?eDArWEZiVmlxUG9SWEJYT2ZiL1NjdVQwMzRCdW5XNjA0aStodXNNT3c1WG5j?=
 =?utf-8?B?NzJ4MC9yZnROWGg5VzBJaXpmNFNnRlNiQmdRcGtqUWRiRVhXRkRNOUw5bXdr?=
 =?utf-8?B?M1h0MFJIZnpTR0dYbElObnhJU1dXZGRudXloRDFGcFFNdDJOUzlXRFF0UGJr?=
 =?utf-8?B?YTQxWC8yQlpwQ0JaNHpaa0Fxc2p4Vk9zMzVmQXlrb3FGYXI3N0xwYVRPbGVD?=
 =?utf-8?B?ZzNZQUxrZ3d2ZXdmdUg2d01sYXhGQVVCcW9aZWplZkJFMHBxcm9yaVloMEhm?=
 =?utf-8?B?QmZ5U3dhTTUzUmhtSG96M20xK25yV2ZEamdpVDROKytsOFhzY3dVWmg2RmNa?=
 =?utf-8?B?eTVqZUpIOUFNc3l1VUVoalN5emN4cDZ6WjVsZnNFNjFVMS8ybHRtUklNNzE2?=
 =?utf-8?B?dnFIbTZQSk82UHM3NmpDZmQ4RTNENlZuQVMwb25WUWE1YkZETmVpU1puRDdP?=
 =?utf-8?B?c1l4TnpHWGsrc1c1MDhydTlDV2s5UWUvMjVPNzVIRHdDQmg2Y09tODFDU2JX?=
 =?utf-8?B?RE9yUFN1RFRlNEhENWhnOEFRaVd4ekxaQVl0ZGplaGVENWE0bUFnVi8rRnZS?=
 =?utf-8?B?eWczOGpIc2hYK0tSOThXTllPK3JZc3RLRGpEdHlpeUJPakVWWHFIK1QxanlT?=
 =?utf-8?B?cG5BUXhzdlY2R2M5enhHSFJ3MTFzcnBMUVlubFFUdko1Q2hvcEZjS0NnbjBU?=
 =?utf-8?B?d0FISTAveW1yc1JDZ09xY1k1VHVKSDMzMmswejNXVVFzUlBqTzJuYnRrVmZC?=
 =?utf-8?B?d0o4b1l2ZHhBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVlvSzlRSW9nZ1pTUlExUVpjbHJqYk1NdjBsaFV0Z3V3TTJPOThxR2V4TVJ0?=
 =?utf-8?B?cThCeEtHb1hQbTVFeUVWa3BHRkdqKzAyUktKWWF2Uy9NZ1IvajRTVUFXZDdD?=
 =?utf-8?B?U3crR1hPQlNUVXVKWnBVS21ENXIzOFU0cnVUWjB6d05PRmVLM0NDR0xMYXJY?=
 =?utf-8?B?R0lReGdML3ZhcDRWclh0dXdMaEJ4U1h5cDNCLzdNVUNaQnMzMEl4SUlVV2Qy?=
 =?utf-8?B?d3hmTXUwa2wyc1czcVR6TmcyRmh5dHB6ZFFjd3JWeUNaUlJRVTF6OCtIS0g4?=
 =?utf-8?B?U2lOTmpTcjdoL0dXNUZ0Y2VBMVllcFVsYzhkcW5pUDBKcGRIaHRLYVZSdjZX?=
 =?utf-8?B?TTV3WmFWUjVMem1pdTB1YThKVUVXR3JSTDIzQ0lXZmJpOXFjZEhzTmpvWi9Y?=
 =?utf-8?B?SmYxYjd0M0FzUURucWdYd1I5UURPU29FTWNHMlZrQXJmdkZPRG8rV1ZrRDZ1?=
 =?utf-8?B?eGsrYkhvTm10ekhBT2ZrcEJxODdIV2JrWExGN3ViSGk0UnQ3OXJoQmQxUEdy?=
 =?utf-8?B?Rm9TT1NtaFFtVFQzamJONWtaVEZzTjV3TEIwUmNiUXF4dHBndHZPbnBZRjFm?=
 =?utf-8?B?bDJWRHl6YnZKampva1ZhelZGMTJyeWNnWXpHclVkY1Z5Y1hsMjYwVGhwTGlT?=
 =?utf-8?B?djNwWWFwNnRXUmhxY1dRQ3o0WFBBRFovQkM2MXVaLzBCM0pqMDZ0azk5ZUh0?=
 =?utf-8?B?T1E4SFVhZWRhak4yU3RsTzlRbWNrbjh1SkRhNkFRT0h6VEJTeE5DZW13RHhV?=
 =?utf-8?B?MEVraEZrV3hwNit1aFY3SjJ0WDJzUld6ZlNETUN4bW1ZWllIWC9hRVh3T2sx?=
 =?utf-8?B?L2FZeHFsRENJQ294Y0M5N25ETWxISndkOE5ORXFnVkdiSElLTk9uR2hTYmh2?=
 =?utf-8?B?TFY3Qmd5a0pHVm9uWnZUM1RWOFk2cjZ1QjlUZzlyK3lGR0JxMThHMHpORmlz?=
 =?utf-8?B?R0ttZ0I4dEh0UUg0dm9taVdVSmlsQnVJbHVsSUkvY2NSVzR1dHBPOXhmUTFz?=
 =?utf-8?B?M1AydTZkOEpvRUdhKzlucGdIbWppQjROSW9JNU9TRVhwT3NvakxPN1djaVFF?=
 =?utf-8?B?VVhTMnlPNXdFcko1Y09oY0NvcnlmRFZXdmkvdGRFV1gwczl2MW1OYzZsMjQz?=
 =?utf-8?B?MSt0dkVJNTkzMUJFdHJ3NVNxcTU1Zm4yRXdWa3Q2MHZ4Qjh5YmNiMUJEeDRC?=
 =?utf-8?B?bm5VeWsxWkpkVlE5dUh3YmFkSS9NeUIwdWxUSFJhQlR3QndDekgwcVVWVkIy?=
 =?utf-8?B?WEJuT2VUSHhqUEd0emhmSHIxMUxpbHFnUWFaOUVRTWpuQTlGSW1CWHZBMytl?=
 =?utf-8?B?S3ZCTDE0SmJDVXBzTG1SRFdyVE93b1J4SVZveFdiY0pnRjZFeXdRaXFLbmRx?=
 =?utf-8?B?OG9IWW9sendkNk9xOW5CdTBTSUtvb092Z3JJaE5nZURLRmRJNDBUVk9uMGtY?=
 =?utf-8?B?WlJyQTE3N2tPc3pOaDd3K29MV0wzNC9OYVJFb2VoU2JrNFEwWVhTbHl3U3dK?=
 =?utf-8?B?ZVQ5eUJYNlR4RVNrQ3VsS1JkNER3QldUdCs5MnhNaVhjM1hYeFd0clBac0Nh?=
 =?utf-8?B?SEZtamg4VlYyMFdWeDllcnJIOGgrSUpNMkplaTJwbDdVMzJZVXRqd3YvOHlC?=
 =?utf-8?B?VEt3dUZBY1VSYUlpZG1hdzFVdFhhRlFUUVhRTDhpUXNLRDE5cEpUTFo3SEQx?=
 =?utf-8?B?ZHMxaVU3TTVlaG9KQ0U0KzNYR3pZNVY2anJsQ1Q2VFpyRXMwOHowU3dweldR?=
 =?utf-8?B?U1RFNUpIdnNrVzg2VG5OSTMwblQ3RHhaYkRFSDgzOWxRaVdsSmV0bVA4b041?=
 =?utf-8?B?OFJ4MUUydG10N2NQa2J1bmxyMTBubXVoMnpQekJsMERCWG42c21ZWmlXNHNL?=
 =?utf-8?B?MzFLRk96dy9hcHRhTENFRnVIbXR3RzVIdXZvS3YwaVRkWmwyc2ZCQnM2U3Fi?=
 =?utf-8?B?YVNLd255Q2hsZHlTSHRxMVV4c1h5MTJSb3R4T0hnMVJmZ0dkU1QvTVRjWmtQ?=
 =?utf-8?B?OTlKMVFGRlEwdnNZZ2tTbG83c0o3emJPS3hqUmEvaWNVekxTZE5uVWtqVXpn?=
 =?utf-8?B?NzRvc1lZY2hEbXdoODFvY3A0c1pKNWU5Y1ZTUT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46ff3ff-92ee-4948-60d9-08de23d0dcc8
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 22:55:10.0008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G4Pkf07GPH9FEITjJh7NAbasz0t36/dsXevj62r+a2Ohh0bJn/OIc/pnpXrSX4hKEIJN9npK7zaQUDrBufMdLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PPFE21B28B54


On 2025-11-13 03:15, Martin Wilck wrote:
> On Wed, 2025-11-12 at 23:37 +0000, brian m. carlson wrote:
>> On 2025-11-12 at 16:32:01, Junio C Hamano wrote:
>>> Martin Wilck <mwilck@suse.com> writes:
>>>
>>>>> Subject: Re: git fails to checkout SHA1 submodule in SHA256
>>>>> repo with --depth=1
>>>
>>> I think it is not supposed to work to mix repositories like this,
>>> regardless of any other option like --depth.  I think brian gave a
>>> response to that effect in a thread in the past few months.
>>>
>>>      ... goes and looks ...
>>>
>>> https://lore.kernel.org/git/aJ5gOPQ9oologqj-@fruit.crustytoothpaste.net/
>>> https://lore.kernel.org/git/aKPJNNWMW9gtueEK@fruit.crustytoothpaste.net/
>>
>> Yes, that isn't going to work and it never will unless we add some
>> extension mechanism for that purpose.  The repository in question is
>> corrupt.
> 
> Ok, thanks for the clarification.
> 
> Let me just explain the use case: The distribution ((open)SUSE) has
> switched to git for version control of its packages. We have chosen
> SHA256, because we'll need to support the distribution for many years
> to come, much longer than SHA1 is going to be considered good enough.
> 
> We can store the source code of the package e.g. in the form of
> tarballs (and we do). But it's convenient and efficient, and thus
> tempting for developers, to simply link to an existing repository
> hosting the sources, using a submodule. And upstream repos still use
> SHA1. This is what lead us to experiment with this sort of mixed
> repository.
> 
> I get it that the concept is flawed and unsupported. Up to now, that
> wasn't obvious to me.
> 
> So what we can do now is either keep storing tarballs, or wait until
> there's a full solution for migration between / interoperability of
> different hash algorithms, and until the source code repos we're
> interested in have been fully migrated to SHA256. In some special
> cases, where (open)SUSE owns the source repositories, we may be able to
> simply migrate to a SHA256 forge. We can also invent a "poor man's
> submodule" mechanism to link to sources on some external repository
> from ours [1].
> 
> Do you see any other approach that I'm overlooking?

Set up SHA256 mirrors of the SHA1 repos you want to track in submodules?

I'm assuming that it would be easy to keep such mirrors up to date.  I'm 
not familiar enough with Brian's work to know if a SHA256 repo can have
a SHA1 remote (which would mean that updates would just be a simple "git 
fetch origin"), but even if that's not possible I'm guessing that 
scripting some kind of regularly-run translation of new commits wouldn't 
be too hard.

(This feels similar to Git's early years, when people set up Git mirrors 
of repos that used other VCSes like subversion...)

That might also help encourage your upstreams to switch, if you can give 
them a ready-to-use SHA256 version of their repos.

		M.

