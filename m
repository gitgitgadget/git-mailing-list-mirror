Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020114.outbound.protection.outlook.com [52.101.191.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F1221F0E
	for <git@vger.kernel.org>; Wed, 14 May 2025 21:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747257342; cv=fail; b=hSnk7WhH+m85M2RI4aq5T8MsCjdEkv+RYpftyuWaPu0Ly90oV3oRzTO2TTFdJ/nb2Z8WALbu/jOkJ3tZc/Yua+ojnJZAlZp5RKtLUuEkdszhTYY50kzE55sYLSf0r25VMXcesMatYJ98ZG/GAsyu0VARaf8/nkHsam2dRtxmrq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747257342; c=relaxed/simple;
	bh=MmMprUs9pxhReROalhMkyyAcgPFAfqS3NFAwulmb4HI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M5KR4JhAWd9IvB+Fj9YkKAZblYI4hzWXf0IdRQ+MVy/3IJ/3n/kmzzz2dqIx7q3Q7QErseGdkwT1RN4b3+pK1CzhHrdu4GsvxKK1VFPUF+EN2VbeHAJ4BN5b5UetmikiWihcbJBunApjhSP0ScOGQRYl+dJ2E1DDEd83r9GsMOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=iGPL74gM; arc=fail smtp.client-ip=52.101.191.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="iGPL74gM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OiUQ9PZbF9HLak3t1zbBfTI6cp9wTBZ3jc6LgyiBhvhptvgdlO2CAHLdJnmUX2fammop/VVQrev+cikufjp+OerbosRCN4TzJ+EN/jGTtqqW89iHXOne9Nv9cZGJGwM5nw+XstnLayaDv8v+5TKze1/sIv6RbaHNPXej/7beZ0byKwmZ7wzIJLbsuRpedXmyCnewFgpXBPJO0Nr2qjSIK1ZGbjXUt/98rXoxRbIgDhjUHNyRA7eD/DsEkp/m7A4NXnjoTiDmw9vpS4JhJDVgmEEn/2KjPLwZXUPUeZF/mHTJkhF3n5iZzfNgX31w/Pd7BR/6kWcw6CTyaC11hIAM7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxSn9gmqZKirTZ2xrUJNdcL3zH5Dq5DD9zSsnsy3Twc=;
 b=elljoWMrvIw7aZJ1vYTh7YooAIzsytKqoOPYiH4eaKloXUZPCn0SnhcW8yYKPSu7sfbpgKSY/QKNGyVzM5we089HifYPEPbF7ss/A/wKl3sW36JS5WEcozfP9u77LZ81z/yDQtPCpo6M6l2RHFKlMTV46XXrk9PelR7nzZsxv+GQpvnlyZFJxZAzL1Z5kAOMzhNGiIaf9W8Gz4NNkcoSobjQv1D9DbZwyBSMmRJk/e4siRKDZgF9qRaPB1FjNHaNSlKR1VF7oAnzmenGoCT31/XGJHDKyCb/UDo0+DAvkOpI6SvvwMDahr3981gQcesRzK+91z80pDfRbY1tfg5W+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxSn9gmqZKirTZ2xrUJNdcL3zH5Dq5DD9zSsnsy3Twc=;
 b=iGPL74gMuCFbAMo6vXBLOfKLPFgYhr8eEnnExi5LAfP0xOFDKbb4fXovcTB+VCCjZk0+A3MHIoYHQAz84xS20pLrtxYO86SlseYuYqiAsMkc5btYc47kpBpwpWRhUtb4XAYOPQWBtwG1JaYn8iHjBqDzkZ/4mDtcrvjVsWp0/h7plG6eaxNfQY5BZwOjh5ATCFapxIbokzsgoVLumM7Lrx0nOiB5jN+/wJjGFYMRxT5NlmSOe/QfdAZlxmEKdLkCiyyXd/O+T7ayCo+EjPdeYD2hYwT1eB3YoLrQZJAYJDW2CBJqz16vhNh4Bt4klr2KcGlt0RPLSAav6uabiZFQJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YQBPR0101MB6304.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:39::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 14 May
 2025 21:15:35 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8722.031; Wed, 14 May 2025
 21:15:34 +0000
Message-ID: <6b034b50-4661-4887-8a6e-86bc42c3a935@xiplink.com>
Date: Wed, 14 May 2025 17:15:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <xmqqjz6sb15u.fsf@gitster.g>
 <7a6afafc-6dee-4a09-8779-83748a4d3fc4@xiplink.com>
 <xmqqldr789gr.fsf@gitster.g>
 <9109a8ab-d4b2-4ada-8969-bc72edac5ecd@xiplink.com> <874ixnjltf.fsf@iotcl.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <874ixnjltf.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::20) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YQBPR0101MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 5774faa7-630b-4266-2266-08dd932c7727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2JKaWJqK1lpQWYxZWRoVkIzd245aStIOTJ3V0dDbWs2N1JNNytZNXRtY3hx?=
 =?utf-8?B?ak1nYndmZG42Qk5SZGUvY2tuT2pWUzdVcXBPY05RODZCSnFxVlVCSXI1RnZZ?=
 =?utf-8?B?ZHo2MVZySGpxVjlFVGpiOWZZZ2JBOHdISnJXUGoxbnR6YmVGZ1lySWJ4cHBC?=
 =?utf-8?B?Z2hIcHRDU3A0WGdwRE13ejQ5V2lXQ0p5eTJ3Ulpra1FheGJhdVJRNFRjL3RM?=
 =?utf-8?B?T2RwSUxTY1ZQMmZJekV5YXN6UVhLOWI4OS9MZVdpTW1lTjNOWFh2UGR5R3V3?=
 =?utf-8?B?UjlQTXNrWHQ4Mm1FT21xS09HVGRzZWJ0UWRhUklNVWpXZUw3WGNjNTNCR2cz?=
 =?utf-8?B?Vnp3dVFnTHQwUndQYnBmSW1TL1ZkQVpLb1hwQTRPSlB6STIyWEdTYlErK0R5?=
 =?utf-8?B?VFZvRHhxejhyV2F3VndLdThIcHR6MGVFcCtNT0lVaXBmbWUzUUIzNjBabnVq?=
 =?utf-8?B?aFVJbXhLSGp3SVpNN005MStKT2RibVpQSVRXS0xGNUZLR2FMZHRQZ2xHeDlz?=
 =?utf-8?B?SGxzU3ZtSTRhYkV5L2EvaDVuNkcwT050eXRCdE5VNytWcjNNdHVDcjdmaEtF?=
 =?utf-8?B?eHRxT0c1Y1RIZEh5TlB6UUJPdGhMZ3VxZXpSdTU4RStjeWswbUVEcGZ5MklK?=
 =?utf-8?B?QS9wSGtCN2NMeHFBbE81WVJLbTc0b3pDNTZ1YlRGTXBoNmVYSURxSlNFN2p5?=
 =?utf-8?B?ZnJXVUd2REtTNlZBSmtvUk5xTEs3V2VmMXU0QUE3VzBQeGVqRlMrTlRnUVNl?=
 =?utf-8?B?aUZMdDVrMVJrUmEvTGVzUUZJTEZLZ3JaMWtjRW1BcmFZT2tUQU5hUFp1emdJ?=
 =?utf-8?B?YzlMaEZhdkVTQldRUm50a1VuemNMa2wvNmpvVG1qWjhmSjJHNm1GNzRxbjdT?=
 =?utf-8?B?bkpGcit4WUNzK2xEUWZsTUUzcVVDRHdUZDYySG5DdW91dGJKYnA2TlpnOUtP?=
 =?utf-8?B?eU5HMVNDZWwrc3QwT29DS1F1QUJYSjQ4dVE0OXZvS1RLWGZoeGRCZXl6Vk9E?=
 =?utf-8?B?SFIxU09CMWNUOHYxNkNUdzdXbHV5cWExajA3azh1QzJVTDgvNDI0RTR3R2ZH?=
 =?utf-8?B?LzdxbUlIQ0NkWjVnWDRPbXFUNzQ2OG9CWjBVWTcvenZaOUdBcEhYR2NNQmpv?=
 =?utf-8?B?TzRWRVdSdjFPT0ZYZTg4VHpYODhiaW9VeUVvMHRTZmRIRldxVUFnbTFJV1ov?=
 =?utf-8?B?emVsNnhJeGFYcTdxb2c1KzQzbHNaVkpnWlQ2a3ZtT1hGWTVUVUV6UElYUE8w?=
 =?utf-8?B?UGxZbnRMQ1hqd2xQS3FneGlNNVNLcG5WNWRYZUo4Tko0cUYzS2Q4RmhaUmZk?=
 =?utf-8?B?UGVzQjlJbWdkWFNsbFo1SlJ6b1I1UXlMd0I1V1lwSDc3OHV1amUzUU1uVU9I?=
 =?utf-8?B?TWVGUVdUWXVuS09VMDgrL3czMmpKd21ka3BIcFpzTlNKb1dlejZsNkVVUUNn?=
 =?utf-8?B?MVpsNlNXd1ljM2MvUVJXQ3FWQ2VvV3dMNURYSUNIT1JIMFdrK3poRGlXV1FV?=
 =?utf-8?B?NGNqck1xTUxvLzNqRUtpbWNKTWJGZlhzeVNXMExrQ1JJMGhPZGtWVHBXeEh5?=
 =?utf-8?B?bFpGcXhBWVhKK0p4OFh5TnNzR1l1R1U5eWxLeXlSMlNEOVIzdmFUTUhZa2dr?=
 =?utf-8?B?UDczeHAxalFvdkNvbGdNYWdGeVkwVHNCWStyZkhBcXRLREk0MVdUVTlOQ1V2?=
 =?utf-8?B?TzMrcnBXdFV4cm5DNmloRTdMNVlpSEVBbmlJaFZWNG54dlNPWU1Ia1ZYNG5j?=
 =?utf-8?B?ZDUzdnhwU01wS2FLR3QrYTJtL3JRVE9iMHVEQWVRdXp4UFArSGJoV1BMZ1pB?=
 =?utf-8?B?TVU2Qlo5YmJISnljS3FWTDNRdGsvYkxRa2xwOUJiYVRDZHpZbVFjY1NNT1dD?=
 =?utf-8?B?MnRIUlZtVndLS3BmSXEvNDkvZTNIbHFmSURRNVdnRlN2YVF6VmN0cjl4cWc4?=
 =?utf-8?Q?SZg2VBXmjeQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXQrUnM1Z2c3V2NJbWtlYUZ4emNiQ3o4dXVvdnZUaHYxNDV6c2Y2ZVk1S0Fv?=
 =?utf-8?B?VUtKZjgwbm5LT3hoTHpkWk1YS3c2S2pkell6TWdhbVF0WVFyVzF0WUpzWUNo?=
 =?utf-8?B?M3NzTzI3cUN4UERWYSsrUExJa01Rd0cyYzZacTJ5d2Y2YndxNnVXNkJzR20y?=
 =?utf-8?B?NFBvNXJkaWJBL0lTcTBJS2c4Sk5TeFF3TlN6MmF5U1FWMGZDV0hES3YzQ3pp?=
 =?utf-8?B?SVBYVEtjdU9oNzZHcnNhTGhUMnFaWFBsc3dTSjNiZzZzQm5JZnp3NW8vZWNX?=
 =?utf-8?B?YlZqNWRON0xHOHNkS25ZWE83bWY2QXZ6RlA1bzd3VEthNUVPR3JFSitHNGFO?=
 =?utf-8?B?blBheG0xNkNpVW0zc0pMMUMyb1VtajdzbGR4VEtNY1V2V0djQ1k5YUc4V2oz?=
 =?utf-8?B?bnF6ZWFvVWY1R3dYLy8wK0tsVFFrdXBZdjRFQmRJaVRMd2FicG5MR3BzQlNt?=
 =?utf-8?B?dUlHQmZOTDloUGRrNTJnSWR2SE1XSFZVR1NBWDVEei9VTFJSN0VGREpIbnFo?=
 =?utf-8?B?c2t4bkhJaUlHeTRFeko3MGhIUUVPOTRIaURSbmJ0Z2lVTXhpR1JEYUlMdkJT?=
 =?utf-8?B?TXkvQjd6cDJRN29XUTQ5ZUpOZDNIVE84U3M0b3VLMFJ0MEpQN1I1WTJ6ZjlT?=
 =?utf-8?B?TDd0cjdra0ViNzRLcmpadDhvTFhlWlYrSjRtSm1sMDZHSE1VVS9lL2U4Rm9E?=
 =?utf-8?B?SU5UMGk1MngvY1FLb3o1Ym8yM1FpSFl5MlFSd0RPcWY5aTVyNU93NXZ4VStt?=
 =?utf-8?B?MHNnaEQ1UklxY2ZCblFBdE55NG5oYTQ3ZnNNaTNhS3dyN1Q2b2ErV0hBS1FU?=
 =?utf-8?B?YVZEdDYwR3loVnRsMVNmUTM0T0tYd2ROeFc4WnFaWDZIVE1kVFpJT3ZZTEJP?=
 =?utf-8?B?bExOQ1dqTXU2TVJoSmhvNCt2dGlHMGNyVExnZklwclN1MWl6UFFuQ1VWdEN4?=
 =?utf-8?B?Vk9JNC9lbUhxL3dlSTk3cytWR05zZHQ3anhSZWFFYkVJMFJqUDFVV0hLck1j?=
 =?utf-8?B?bjJBb3JXRnVoTkFhMjR4cmNMZ3pHRVhCcWh5L2c3eFVkNjhnbG1EVENmZGgw?=
 =?utf-8?B?WnYxZ2VlWUJTL2xPcUxhOElCdThmN0IrenNnRVU4WkthU1JHOUIzYU9rVHV4?=
 =?utf-8?B?NzNva2dGMVZUWVVKbk0reGhvME0zRDJVd3lZZ3ZFeWdSWVcraWVzZXduWXBy?=
 =?utf-8?B?OGxGVW5mclZtT1JCRk8ra00zN1RGcWtNbCsrWW1zVm5SdC8ycUlqK3pKcnBI?=
 =?utf-8?B?M2dBUEJselZzbG5LbmJzMmpsUGtEY1NiQzZqNVR0cXdua1lYR2x0RENaakc4?=
 =?utf-8?B?VjFXQVVlMDMwcWxkSVBJSVhGZWN2Y3VRK2RkY0NaRkpqRlYwZ3kzU2RDRVV2?=
 =?utf-8?B?VUFBUGQzaENqMmxPMnJ4Tlk1czkzME5MaXNNczB6U2YydXQ0YlVPV3N1UVRP?=
 =?utf-8?B?T1FWb3paZnA5UXF1bC9IME9veFUzK0JIaGdiazNPNTFyeGZkZjdQMldXN3BE?=
 =?utf-8?B?a0ZGQUxyS1JCYjZuY3ZJTFNpZ1ZxWXdyNmpzWWlMblU0RWZ0cHRTZmZHUFp2?=
 =?utf-8?B?aFJTWldlK202dGhJRXZrZHl2SlllbXVpZlhDeFYvZTlHaC85NmkvbzA3VWVE?=
 =?utf-8?B?MHY0QzBsbE9DdEluZEs2cnBzL0JWN2h3V3ZqYlMzcGM4T29XMWVHNlJlUGFX?=
 =?utf-8?B?NTRLaW51bUloVEVVeFpRMG82QUNCMzNUaXZVMDNJN3B2V0lyektXS2VsQmEv?=
 =?utf-8?B?aGVOMVE1OW1RZzNlNGl0RGhhZ3ZMZUdQS0UzUXJKUG5mVGlWR1RadS9tNE1r?=
 =?utf-8?B?K2R4aThoSWZuSVRZZlloRkJCR29RV0R5eVowRHRMQ3BpblQxd2plUXB3V2h4?=
 =?utf-8?B?VmUwL3dWQXBHYTJ3MjVFSzNwMkZ4T0ltUWc5b0QxUXBhQWpqcXFmVkdZRVpz?=
 =?utf-8?B?M0FmTHEzbXl0dEdoMGFWVFAzY3BLbUlyOU9rQnJiM2F5QjFDUkIvTFlyZ1li?=
 =?utf-8?B?RVpIVWQwOXhQZE5SZnRqWkxKRkhsYjkyMnhwWkxYTGJjT1ZUcWdhYldnSlpz?=
 =?utf-8?B?T0ljbkQxRzhpOVhDRnNRZk9GMEc0R1dYU0p5QT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5774faa7-630b-4266-2266-08dd932c7727
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 21:15:34.4515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ftyQ0RivJlm0p+t0THwFJzHzr7i0iLZLfsxJkeNM+PDPY4BNkTEfwQhCqwcZ8Pec6SpUGH+tjioS/SWYldgYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6304


(I agree with Junio's reply to your message, so here I'm just going to 
address the things that Junio didn't.)

I'll preface all this by restating my original point: If you really want 
to implement this feature as a new command, please don't use "blame" in 
that new command's name.

On 2025-05-14 10:42, Toon Claes wrote:
> 
> Personally I don't like the idea of the DWIM approach. I rather keep
> following the UNIX philosophy and having each command do one thing well.
> I think it weird to change behavior based on context.
> 
> You said earlier in this thread:
> 
>> This distinction brings up a wrinkle in my proposed DWIMery: should
>>          git blame path/to/file
>> show the annotated blamed lines of the file, or simply display the last
>> commit that changed the file?
> 
> For me this gives good motivation to not mix behavior of file-level and
> line-level blames into a single command. If behavior in ambiguous, we
> should avoid it.

The behavior is not ambiguous at all, it's simply context-dependent.

Like with "git add":  We don't have "git add-tree" to add a directory of 
files.  Adding is adding, and so we make the "add" command handle all 
types of adding.

Similarly, we don't need "blame-tree" to annotate a directory.  Just 
because annotating a single file has different output from annotating a 
tree of files doesn't mean that we need two different verbs to annotate 
either kind of object.

>> I can appreciate the convenience of being able to do that with "git
>> blame".  I suggest adding an option for this specific case, like maybe
>> "--latest" (I don't feel strongly about the option's name).
> 
> What makes `git blame --latest` better than `git blame-tree`?

If a user wants to blame/annotate something -- a tree or a file -- it's 
much easier for them to just use one command to blame whatever they 
want.  No need to discover a different command and read a whole new man 
page to figure it out.

And all the people who already know about "git blame" get new and useful 
behavior from their familiar command.  They are much more likely to 
discover that when it's built into "git blame" than if the new feature 
is hiding under a different command.

Also, people who tab-complete commands will appreciate that
	git bl<tab>
continues to complete to "git blame " instead of "git blame".  (You 
could argue that this is one way people might discover blame-tree, but I 
think messing with completionists' muscle-memory is going to annoy them 
more than help them.)

>> I agree that blaming is a well-(known) concept.  I also agree that most
>> users would understand what blame-tree would do, *once they find it*.
> 
> I'm also not convinced why a option argument to an existing command
> would be easier to discover than a new command. I think it's more an
> issue of us advertising features, than commands being discoverable on
> it's own.

Extending an existing command is an incremental way of making things 
better for all the people who are already using that command.  They are 
more likely to discover the new behavior, either by spotting it when 
they're checking the man page or, in this case, by accidentally passing 
a directory to "git blame".

Hiding this in a new command makes it much less likely to be discovered 
by current Git users.

Yes, it is an advertising issue.  I don't consider Git to be a gold 
standard for feature discoverability.  So I don't think that simply 
saying it's more of an advertising problem gets us anywhere, because so 
far Git has failed miserably at advertising its commands.

>> Also, I think sacrificing usability because it makes the coding hard is
>> unfortunate.
> 
> Agreed, that was not a good motivation from my side to make.
> 
> I wrote:
>>> Forgive me, but I think folding into git-blame(1) will also solidify
>>> Git's reputation of obscurity.
>>
>> Please elaborate.
> 
> As I mentioned above, I think having behavior of git-blame(1) depend on
> the type of the argument (is it a dir or a file) is rather obscure.

I don't buy that.  Many Unix commands give different outputs when run 
against a file vs. a directory (try diff, for example).  Even simple 
things like "ls" will show a single line of output for a file but 
multiple lines for a directory.  You can argue that one line vs. many 
isn't a drastic difference, but it *is* a difference.  And there's a 
reason why it's "ls -R" instead of "ls-tree":  Listing is listing, so 
"ls" fulfills all your listing needs.

> The format of the output returned will be drastically different in both
> cases, and having to machine-parse this might be tricky.

Machine-parsing output is a strawman.

First of all, even though "blame" is considered an ancillary command and 
not officially listed as porcelain, it's also not plumbing and so it has 
no obligation to make machines' lives easier.

Second, why do you think a script needs to parse both output formats? 
Even if there are reasons to write such a script, how does having two 
commands for the different formats help?  Either way such a script's 
author needs to deal with both formats.  Furthermore, if I was 
maintaining a script that already understands how to parse single-file 
annotation:
	git blame path/to/file | my-script
I would be quite happy for it to die horribly if someone ran it on the 
output of a tree annotation.

As you say, in that pipe example teaching my-script how to tell what 
kind of output it's receiving could be tricky.  But I doubt that many 
existing scripts that parse blame output are implemented as 
pipe-readers.  Rather, I think (yes, without any evidence) that most 
script authors run the blame command directly as part of their script 
and so they'll know what kind of output the command they're running will 
generate (since they'll know what kind of arguments they're passing to 
the commmand).

Folks who really need to write a pipe-reader can just teach their script 
an argument identifying the kind of output to expect.  Much easier, and 
more robust, than making the code figure it out.  Pipe-reading scripts 
will need figure out something like this regardless of how we resolve 
this discussion.

		M.

