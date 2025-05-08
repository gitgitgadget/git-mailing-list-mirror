Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022114.outbound.protection.outlook.com [40.107.193.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E97122B590
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746710771; cv=fail; b=NbjYIg3nwDK/O1fjceukIaTgBGSQKlnjwFEGZ9QhlUdk4YqZ40ve+yclA+HtWOr6q1nfAva0/XkIKjmp8Iqv9lGD9E2lBdEgcQgs9EnAGHhgb3rtfQGdYj8rpqOkJQAoSJUbtRiQDJvru+uoOa9gKZC1QX0+ZXTQu+oFeGp4d+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746710771; c=relaxed/simple;
	bh=oFq63iB5vBOMnsAp4lkHqWTlKK0jrZlQE+1BzwCRzH4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=arD29BcNe7u92AhZAyesWLCt8G+I8PbNf0nEt/EDcjzIaGUI5iuaz1g1j+ORQsozsVXRyh8rZIFmE1JlmgU9LoIzlL3mPZm8jdL6ln5f+A8JoQ5P8JmzvHLfjCo8G8per8KNm3Gxr1BQFPHVIfE/Pgy+R0Toj/pBV9+/4NK9C14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=iULyYMK9; arc=fail smtp.client-ip=40.107.193.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="iULyYMK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNdLMTcmi5ZoH8XJqt/crFV/7Bcho4GBvO+Q93mmTGCPY8X141hSnUA72Nk16ZbbE7xrBScuGipLxkHrxp+2GLZTCVGIccwBgFon2EsKMs+TIoStXOkTXYTzmMUFzjve2I4xa1u9Jxm8csMW11+BOqF7bT9nQYB5SuSEE8IIZ+0SD3gg1Lxffe5iiwdBWf/HLRgI5yTPfmRlnCw3NDojl1UKTCOQa7xAvuubM1xf+aaYTSkH3pxxT85R8AhjlSRd8jz8+S0Gq8nyglSoKnScDpH+2IQ7Xb35mBrM8NWIDjWzTHSJp82VPN1s25+6ty24hd9HadYqj8gl7BgqbmFvnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMfiG2N2DX4gKGRXvfXMEKCYLQqcKf2/hyWEjsp08zw=;
 b=HCTkQooF6ciu83zv7Mac6VWUSnKdB1D5NNG0UKyR2uMEbC0Pndxu9kJFV6QBWhsxNl+sEDlgmu7HC8nn0rAy8nE4ZOyZK6FeNArR6+IULhAq5b/45PDFVeNEilw0y4SLfwsJ8s4dhSj3lLo+pZrJ0F2+8GJzHsjYQAAZh7I2aVASkaIlSB+CsQg+dBwAmSzxyDx3MjvQjZ0ZIiMiA3Omv8+qYcQk5oOfVFDd6ea7+0CuHtk7IVm6ev4ZMLJxTZGPxUY9YB9UgbN0h6aI3RhM9kz6THncprVg2x9qC/ooJ0JZM/ei0JLKoi7FfyM8OhqHYv+WdKTatXtGPbBMD0hRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMfiG2N2DX4gKGRXvfXMEKCYLQqcKf2/hyWEjsp08zw=;
 b=iULyYMK9n/fzYjamkDve0H8KKIcxZR+I8bqLqxpGRr8G8VRCUIMlnYUK+nR4CXjfCmhXGzF5tbPJQzVuKv+4M/WcmgRDgScrF1pC9Oycrm9OJA1Z5EhitwvFFccKvGLhEQ/mODdXwNrCtvWDGMn/bfHsvmgcyrrU73+nWiuhm+vHCF3BPo3xoy7l2IKSZZfnT5pyuIAHIQ/jOgsQP+F3HY/6cnqEwbGXkrMnZq5Y2cv/635yhQQFmI3UAoBX82CpIsXVfQgoqbiLpAMssZBCmdyGFPD652MaaF1GIotXvgNbgCjIY+PchsglxxH/49H8eh5vbSE7BNRvxYgxbL6zNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT2PR01MB6142.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 13:26:05 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%2]) with mapi id 15.20.8699.030; Thu, 8 May 2025
 13:26:05 +0000
Message-ID: <b162707d-0da3-4ea7-94da-5546119012c4@xiplink.com>
Date: Thu, 8 May 2025 09:26:05 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] Introduce git-blame-tree(1) command
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <69a10929-0e44-4ce9-af91-048b8404c752@xiplink.com> <87ecx0ijqt.fsf@iotcl.com>
 <323dc2c8-41bb-433a-a1c9-662609e359ea@xiplink.com>
 <9a0c98d1-4a77-4f2e-9aa9-bbab11b3e44d@app.fastmail.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <9a0c98d1-4a77-4f2e-9aa9-bbab11b3e44d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0288.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::8) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT2PR01MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d265f46-68f9-483e-4fda-08dd8e33e2af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Ykh1V2pIUFFGWkU0WDkxZ1BHVXh4MnJVSmNXQXhMeXEzOEp1MzJWTUt5Vk96?=
 =?utf-8?B?M3o4QWI2TFZ4M2lLc0ZHVmZuL3RHT0NYQ1I0NkpGVlZhMlRsZmhSRnRFWWp0?=
 =?utf-8?B?SmduTDQ2UnBYMm9STi8yZGNlUUZFY0Q2STMvL2RBa1d0UE5sZWYvamh5bHRD?=
 =?utf-8?B?ejFrWG9oRy9zcm0rTDZZRmp4S2psUFVWYkR1TmNaSHErRlZJdHRvNW1PT2pY?=
 =?utf-8?B?M3k2NWJLejh5VGt6RzZvK3R5MGh0WkpFMkFpdVh4bHBHV3VXUm53Y005U3VY?=
 =?utf-8?B?ckpwSXFrM0UxMHZ3R1lWUzFkVDBpanNHWW5XMGE3Y2E5bzJuM0haKzhQZ3BN?=
 =?utf-8?B?cE5NdHk1end3ZGZLVVdpd2RJWmtweVVJbS9IRVl0bmpLWG91TWtHc2Fhb1ls?=
 =?utf-8?B?Vjh1b01zWVh5TTRsMlNMZDAyOGF1UHBoWEZPaVl5ZEpnWTdqS0Jia0E1YU1C?=
 =?utf-8?B?N0lMbHJKT1VLMkN0ZWZwWnl1RjJLaERjdXVrUmVHKy9ma1lidlRKblpuU0Q3?=
 =?utf-8?B?NHZVOE5hVzBweFhjMnA1L25Tdmp3RElwV0VEb24xb3kwSXY5Nlgya3ZFT2pw?=
 =?utf-8?B?NXJCTmFBemc2NUtQSTVCSkdESkJEa3FvRUFDSE9Sa2dJemtXbUVFVjB5TW5Y?=
 =?utf-8?B?bXU5Ni9aWno4UUtyczhkZWhFaDZjS2FNU2JvakU5N3JxLzhlL08zbVFlLzVM?=
 =?utf-8?B?YlBIeUJOaEU5M1Q5ZmFqclc3ME05dDlURnZGMXplQUh6MnpoZ2owdkFmUUt0?=
 =?utf-8?B?TEx6MU9aR3hybGtnZXo2NzJkYUI1MVRIS3kveXJkbjJVeDkrSXlmaEN1RGkv?=
 =?utf-8?B?UWk0cjQrdXY4VFhVQ0Rhc256VUZiOThPZURVK3FaOVB3KzhIZkZlanVsWDlH?=
 =?utf-8?B?RmFzdEI3bW56a0dyRUs4eFRyODFuamJyRnlqVzRld1B1TDlmdFc0VmdNNnoz?=
 =?utf-8?B?ZFVjcy8yd0pieERpM0JOcXFGSHlpN1JCT04xQTZqN1dEOWZGMGtNa1BvM09U?=
 =?utf-8?B?dW1nNFhDWkVWTEViUmlvL0ljZUJuVkNpbnFTSTROVExrVHppYUVUZmo1ejlC?=
 =?utf-8?B?a0xFUEs3MU9Db0x5UVFENUZuZW5tc0dZNDVrWmk5NWN3UXdjM1QyZ2JMeVpB?=
 =?utf-8?B?TytoL0ZPa29FMVRpSUhjaXdTUWhhUkJEcEkxd2JIQVdKN2ZFZXJLdEIzUEo3?=
 =?utf-8?B?ZXY4aGFDb0xxejRvdnVBSXZuTjdINzZkdWExL0dRZFZ3bnpHQmJsUkNaR05l?=
 =?utf-8?B?dkdvdUlwbWEyOHJ5VkVYK2FPQkYzaXpqeUJwbVpnOUx6YWMwSjhNR2JNTXFI?=
 =?utf-8?B?UHJwOEVwdTBTa1psZldhc3dpVkJRZHBoY0ZYNERuaGZnSHFEa3EvSnVGallr?=
 =?utf-8?B?c3NMbTJINTd5cVdia29XNU9ESjdyVG5pTWowaVNEOHNhOFY3OGtiaVB2NlF3?=
 =?utf-8?B?bkl3Z3NGQTk2Q25ERjk1ZXJ3WHRnWW9FOFM2MTQ1ZUJlbU91c1dnSWhwL0JW?=
 =?utf-8?B?aEsvRWgxNisyMFVmK2JoRThNTDBPeWYvVkt6RWJSektlUEowYUgrUWVuUVVN?=
 =?utf-8?B?d0NyY1lnOGFMVHFOZk5zeDNRSHZpeEFtdkRFSDRSS3libHVRdENIQUo3d21J?=
 =?utf-8?B?OWlsSlhFL2V0WW1BTkFHcEJpVkZ0Y2t3QW9UOFZoUllvTklrbmtuZEdTam1p?=
 =?utf-8?B?V1NQY1FLWDZENVpwcHV3WTFPOFFRc09mc3YzUlE3ZHRVMCtISjRid28xWGFz?=
 =?utf-8?B?UUlOWHV0WHRZRTFtNWdIMCtvR2VxcEcrR2FYQ0lyRk4vRGlmQzEwZklaNnVX?=
 =?utf-8?B?OHVBOUtnVHZrL1BNSGw0cUdZMCtleWZ1Z09DWUI4Yk96cE9IU3g3SEtzTCtD?=
 =?utf-8?B?QkFVSVpLLzhLRzFlc3BHaVA1dVZoRUs3UWZkcXRWUkRWTytCM2M3ZCtBbjM2?=
 =?utf-8?Q?MCFaLdKIpis=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjlIYmVla3J0NWJ4RmRHdlRLVVJqOTA1TU1LdWJOR0hyVEZETmIrNzRBdmVs?=
 =?utf-8?B?cUxGMVVWOUN3S0RPWGhxQVZmbGZ6eGhhVnhzT3lFcHF3ZkNNQ2JPZTljS3dm?=
 =?utf-8?B?dmdUYzJMMExVWlg5L2hQVEJDS2VpWkgyNVNJZnUxcDUrdlRxZXBadlBibFNG?=
 =?utf-8?B?dDBDNUVvNXl0YU92LzZFd3doYmRsTWt2T3dTN1g3T0V5VFY5UnhwZFg5aDJj?=
 =?utf-8?B?ZjZwTDdtTS9XZWxVb0Z1N1Mwd0phcUtmWjRWeGREWEFUY2ZPZ2RkcnhnbjA2?=
 =?utf-8?B?cVFWR25Rc2gweXIxd2h5YVJaUnlsOCtuUU40cFNhOGswYXB5ZVI3aU9UUXcy?=
 =?utf-8?B?Uy9pbDIzU1dMYmFaR2FzandwVkdtN1FNbHNCVVA1WHlMa0I3UU9BNktBTGdm?=
 =?utf-8?B?Um5ydmNhQ2ZiZ3h2anBCNlk5dVdFT1A1T013M3E3cUNnS0FJRWQ3TTl1bHFI?=
 =?utf-8?B?dm8vNVI4U2hFMnlhQVR2N3lzMW9Jam9hYTFWZHJZREExRHZqRm5LYzZORG1q?=
 =?utf-8?B?Q2RuUU01c3lNRUowcHhPT1E2T2d6V3V5cXkvWkhLNkNDNFkxdWViY0xIZUhL?=
 =?utf-8?B?Sjk4UUgwbndzZ0Q2TVYwbTM4YXJQUFphUHpBa2NsR2lDamZDQkhuN083amdL?=
 =?utf-8?B?SnN1bEwzQ0M2a2JmTFJNRnJEVVBOSFZXdnVUQUt1a256MGVWRW9teDhvdGto?=
 =?utf-8?B?bGtELzFiSDFkUkVpYlJ6dXZRbE5vemNrc0g0T3VUUUpxRzRXN1gzdkdnM2g3?=
 =?utf-8?B?R3YzMTBpekJWVXNkaGJSTjA0b2RBMUNZeGdGNERMMklMQzBidTF3bjJtYW5V?=
 =?utf-8?B?UXlRNzZaY1B1czhIWGl2MVRCN3VEa24vekdTbnFjWjJRVXhTVVdrSWIzbG5Z?=
 =?utf-8?B?QzJQRlJGVlptMHJYTGNzRWVNNHNZR3Z6QXRDblFKem5EeFJ0OFdZQVFtNU5S?=
 =?utf-8?B?M3NOSXRadHlSdXh6OEoxY2I4ZThwcC9hbGgzdkRWeVJKbHpsMHY2TlBsSGRX?=
 =?utf-8?B?LzhvdWVnTG9iLzUyNkY1Y2dWWUw3cEhLQmpiNWdUVit1dTBma29ROGFKSHFk?=
 =?utf-8?B?bDhwREFXc3ptZVZjWnZPbmk3c0k5eEJXUEhhOUxMTmFMWmZSUnQyY2FLNCtM?=
 =?utf-8?B?NUFFdWdLaDhxQng4eHZSUGlvWXBndmVyOEtMMzlYVG1BeWVjd2ovYmVzYUFp?=
 =?utf-8?B?cDVTRmRsYzI0M2lFUlRhV2hCc1JsUzdCSnMrV2FDa2tER25zbjUzY3Uxb1Nx?=
 =?utf-8?B?MklISDdqK0Zvc0NVb0lscmdwVkUyWjNzUys1Rmg1d1RGV283RmhucWg3Mkdi?=
 =?utf-8?B?VDJIWGNUUzBBMHB4ZWUrdGs4KzFYODQyZ3pRcytYV1hEQXRqOXR5U3lwSW9q?=
 =?utf-8?B?YTN5b1psS1QzOFE3TXRCMU5IaGxNaTRyS3RiNy9sVXVzQjRoMUlFQzljV1dI?=
 =?utf-8?B?bTZNK1cwMjBVaGJERE1MejRPSk9NeWlXTUhPQmVObnZmYkZtS0RCcjVHVW1S?=
 =?utf-8?B?a0pwZFNVeWIwMlFGMWhxc3lFTHA0ZVIveFRkaUoxQ2F3RDlZZHdkZFpTaHJl?=
 =?utf-8?B?Y2F5YUR4Mmcvd2JWdURCeHZFbnFtb3ZKRjI2a3JudW1kY0pzYy9QdDFlL1d2?=
 =?utf-8?B?eis0eHA2dVRtNXM5aDM0b2FxRGZBUnpwc3UzeXZLbjU1U3R4aXpJdmROSkZr?=
 =?utf-8?B?TWZ1dFRKVDdkREk5UkN5ZTJkVnJWM3BzSS9BcUNKRVMyTlRBMlVOcFFhQ0lJ?=
 =?utf-8?B?eldQL3g4MmJPczNHT0dROEVhSHNUU0NWbUJFNkhMd3dnRGhZUUtXbERuemlX?=
 =?utf-8?B?TjUzWTROYW1MWUhqcmE0NzlCSnFPa0hIbnhvc2w2VHdDRlFIajNVbGFLUmp2?=
 =?utf-8?B?WXBvSWhzTjM4SllQTnNjc3NVL0NSOVpRWDhpODFBdFJMSFlZcnNtVlJOeWll?=
 =?utf-8?B?MWwzQzZma1FxcnkyZUVGRDc2WFVzR2NheUFTWUpPaFB1aktIdzdueGw5STln?=
 =?utf-8?B?K0dNMzBPbmJGazFlbXFQRDVDMEdJSDk0TmJsaGUvSkFyWmk3Um9GaHpBY1ly?=
 =?utf-8?B?dkZwWHV6UmNqRmQ1bUU3NTNZWnBSQlp1MUFGQT09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d265f46-68f9-483e-4fda-08dd8e33e2af
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:26:05.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV6JlPOuwdj6g54QNeX1msU4JBm/Lr8XELVhq7IOSg7o3ptkmWIDwse2j1/VkFfQueDBmv1tmzr2aHpB8tDEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB6142


On 2025-05-07 16:49, Kristoffer Haugsbakk wrote:
> On Wed, May 7, 2025, at 22:23, Marc Branchaud wrote:
>> I agree that blaming is a well-(known) concept.  I also agree that most
>> users would understand what blame-tree would do, *once they find it*.
>>
>> But I think that's beside the point I'm trying to make.  Git is
>> notorious for making users learn countless commands, and having two
>> slightly-different commands for blaming is just going to make that worse.
> 
> Use a Git user I don’t see the problem.  `git --list-cmds=builtins`
> lists 144 commands.  Six of them are `-tree` commands.

None of the -tree commands are porcelain meant for regular use, and only 
merge-tree is "ancillary".  The rest are all plumbing.  These are hardly 
the commands normal users will use.  I've been using and scripting Git 
for a great many years, and I think I've maybe used read-tree a handful 
of times.

(I see that --list-cmds is experimental and only documented deep within 
"git help git".  You seem to be a very advanced Git user!)

> It’s not been my understanding that people stumble upon niche commands
> that easily.

Yes, I agree.  That seems to support the point I've been trying to make...

> Most questions I’ve seen about git-commit-tree(1) (one of
> the `-tree` commands that seems to come up from time to time) seem to
> come from a point of idle curiosity.  That’s questions that bring it up
> (i.e. potential user confusion).
> 
> (The first impression I got of `-tree` commands was that they were less
> user-friendly commands for hardcore users.)

Of course they're less user-friendly: They're not porcelain.

> That’s just my perspective.  Do you have a case in mind where such a new
> command could lead to user confusion?

Only decades of experience writing and using software.  Bloating Git's 
command set should only be done after serious consideration of alternatives.

If I were not subscribed to this list, and Git went ahead with 
"blame-tree", I would most likely never learn about it.  Since I do know 
about "blame", if the feature were part of that command then I have a 
good chance of discovering it the next time I read blame's documentation.

		M.

