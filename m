Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazolkn19010022.outbound.protection.outlook.com [52.103.33.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0F32B12F
	for <git@vger.kernel.org>; Tue, 19 May 2026 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779209303; cv=fail; b=aMcEafYyRPQKRPNOjuuglvW20UW0CUubakHLstZKcwohitrUUfZaiy1StvVjcx8721u3eDb3mD8UPhQIlCsakaxDJtu44SYYdov905/ozT97tVyqZWUFA4ygsoR2h1FPjacXSBMbgKfaSo7K5E/7q0S7TgBb73yrnTrJwGrBie8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779209303; c=relaxed/simple;
	bh=h2lBV6tev22tJ3jIhIRgUNRoz7Dz1gEmmaPGHwR3c3I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q2X0VIyw8ftxJMoBhv0DbKNy6tH1uspIbyNRTpOrD5mQkwABqv/C6Iu4qAuPMmbfWsc4CZWwXcQFfgsCPHOjBUGehBGKdfH6Lba+Rk3F99hO10orQF9/J9fWXQ1sAgmhQ8lQyijeLuaxWtZqqz6RpxWi14l05hH4/cKvuzXNM0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lsR+E/q7; arc=fail smtp.client-ip=52.103.33.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lsR+E/q7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzHlruGXPpvrVkUf1O9oMS3bYj/7DSiTBkhqLy4gYlS8nx6X07JeNP3tXPnU7wzCPUYAXmYoUW7x3f4bOBTBJsVS2GjFS1qffNBrQLYSWA7kORypWPofiT588blQWe6AnQQwEqONYrUzyAWWum9hZFHFeBLqFrX8hBCezSAqZ6huwC5W9pYdbZK492fbJoahuf/dWWvuB9qk67EXrCtMHKLerETT7OGJ4NONJlYJMpfFCX64fb6jkpEb5Dp5pNh5poPpWBy+rIb8oFtxal9XTexJG2GR/UCYvmZOBF9peYwmTEtvpG7+k4dMLiiKBtytpf4oSzOjViJIDHJtrlqPaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qEL2NNi3VAYVvcA9DaqtFjRf4uayYx6cwH78ZtBPiY=;
 b=KNNqbWp9Nhc1UE2QhTXUd0NJR6jYCuLeafGg3hdFGJbSh0Rya+d1O4+MKgdACrxlc2qmMW5humsP0o2C/1W3+8uGvh7TtvBzU3G9Osx35HL/HyZhdTE97yqLZM60wf+W7jGVt5ohO2ymoneYANq0jbL28z69iDlpvsqkWnfhkqtFS3B9ZO1+fvP7tnfEpbpjtUm130q/J825sTJnS+MDQEKxD5HsDTCOEs/G4DZ2NL8c8VySaa8fMEhiGI8V+lO52S3JTgaxEQD72rjmMfu8xZziSH6BNzENw0URJBq0QQ+oBSIYxoS+gV/g1/7Q9ai4dXPGJ29kZj6BZTLjN+oTsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qEL2NNi3VAYVvcA9DaqtFjRf4uayYx6cwH78ZtBPiY=;
 b=lsR+E/q7qPEUl8IXuQjF8NUgmqYFn/tLlmItA4U7DIUF2HqlOPJlqJkZ7ZQ3wViNwjlFJGrveOqpAMQs2FMb1b626iku0LIonj5Y0uOqOHsHyhuGE7HpIelNHMkntY1X8l0xw2cHSZFfStXKpSwpyObrjpWCtjbQSfjLCVJNE9hgzW8TTNswa83NR3Y3VH5S9lHt2pvceOB2DnfUSJsz/Hr7WVgaWl2/ZSF5cgIRjQIu0uOsk4XpRre/DCg7qN+6VR0pzckCDQfmBrQII3dvQnSvYEITvQxSZ+1av9M+DGQjQYi7DtyQPYdOlMWdqSTCuPnifRBb+pfW+sr3QpCe5w==
Received: from MRWPR03MB11616.eurprd03.prod.outlook.com (2603:10a6:501:80::17)
 by AS8PR03MB7939.eurprd03.prod.outlook.com (2603:10a6:20b:426::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 16:48:19 +0000
Received: from MRWPR03MB11616.eurprd03.prod.outlook.com
 ([fe80::5ecd:e013:d531:1ba]) by MRWPR03MB11616.eurprd03.prod.outlook.com
 ([fe80::5ecd:e013:d531:1ba%6]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 16:48:19 +0000
Message-ID:
 <MRWPR03MB116167F956F0616EE71F527EEC0002@MRWPR03MB11616.eurprd03.prod.outlook.com>
Date: Tue, 19 May 2026 17:48:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] fetch: rework negotiation tip options
Content-Language: en-GB
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, Derrick Stolee <stolee@gmail.com>
References: <pull.2085.v5.git.1779135575.gitgitgadget@gmail.com>
 <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
From: Matthew John Cheetham <mjcheetham@outlook.com>
In-Reply-To: <pull.2085.v6.git.1779207896.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0008.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2d3::14) To MRWPR03MB11616.eurprd03.prod.outlook.com
 (2603:10a6:501:80::17)
X-Microsoft-Original-Message-ID:
 <a006da42-50c0-431a-b659-435aa404d85a@outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR03MB11616:EE_|AS8PR03MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: b14bac41-78fc-4997-19e0-08deb5c66e2b
X-MS-Exchange-SLBlob-MailProps:
	zZTkHIKWWP+kF1aCQfXUgayOGzqQmfvflN7h443RblYIhDAlObUAxlaR8lc7FSs7B2OaVnFEUrO/2U227gRRTejqUL+EkOk4zOh1LuNeqmO/ycjOZNkSHBXtkZgBNhQgFZM/44SnId8MfsP3VMaqguwE0+Lcgbv4omJLgyAJIhh+p918KqlnLTOKhi4kZthykkaoTUD1mmqNNnTsWOBBx/X42aPnjg6g90RioN7ae6I8cb1IcLZJ8SUWOl9sa4gJ+9qY+NhBubrMKEoBWZtrPBysinPdgT6Cxjxe8XFZ54rNXERsjVfgNsqo0tgLMgzxnJuXpcr2ThKG951yti9kkKogI5NdqkjIICqyg5CI/5MmjfBUkPvzALDmn8IdvJt/NatzfhaPCeQNDtEy6o6Ej38qAv/WJ6B0T+j41oFdpBJzpOEUrBP7ct124WU5qpaAh9Zi+N+1paez0lYznpS42uCJnzZBNf6KgCas4qlpEtxevm1JVx1Q0rTH9pNXCET8uUE84v6nHmQRNOzByHncuHXC5RQpYfprG9BnVmHfcGyeLvI6vqaPUSrH+1V1U8OTIoj+/BlimX4Ur71YSYCY3xs87TFFr3UCZuHFqncwR9IKG7vNCzyNfq97Qw4pFOGbGcQHbTndRdii6Dl7PClAjfFwhdtfRfkCeVm54UW6gcjgjXJiiNMnQQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|51005399006|5072599009|37011999003|6090799003|19110799012|15080799012|23021999003|8060799015|40105399003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3lwYVcwV1JrTVE2b016eWNsWGhYdTJIcDlRdkYyaE42Rkx3Uk1pNTYySWFv?=
 =?utf-8?B?dlhKdisyUm9kTnhnQTRTVzFRRkJaVkxuazFlU25OcExESUZBcEphRzl5M0ZV?=
 =?utf-8?B?aEhFMzNiUjRaNW4yR0svTEdsME05WS9pSzFGSzhiS3Z4dHh3eWo4UzFOVkJO?=
 =?utf-8?B?Qm9YbTJYbWNlYnVOT1FhNStMeVBHZHp6WFdJZDdEcEllbEVvTVdkakkwbFpK?=
 =?utf-8?B?QWlMNC9JRjRhZUFIMlVCbnRZbjQ3NS9HL0NaMXU1RVp6cTJqZzc3V1d2aEgz?=
 =?utf-8?B?RkJUbFdoeXdtV3k3elZuRlRkT3Z6RTByTGhkcXIwWXhFUHhDSzJqNTJXYUJt?=
 =?utf-8?B?RUl0RlBUbi9tMzFIMzNwam1DRkFRQlZ3UGVRZ2J2eHZZMjMrTmVsVW4veGlq?=
 =?utf-8?B?Q3IzbWs1TGljVzZ5SGQvejZ1NUpKaElIVkkrNXFvcW1OWjFEYVV1YUk3TG9w?=
 =?utf-8?B?TTdmVTBpaU80RDlYa2htOUYrK2pCWGQybjJNaFB0anV6YjJsMW05L0pNWHNM?=
 =?utf-8?B?TzJBU1VPcWoyaGpVdGwzOG1CTkNIT3pDS3RjSWNkTjNWSlk5ZUVITldTdlBM?=
 =?utf-8?B?MjRITXBBS2djZERNQUpZRUY4Ym1YQ0VFc2NTTjhJZEJhVXpETlY1ck95ajRz?=
 =?utf-8?B?SHlTVWtmbDZ1alYvRzgxSjFrSU5EMWNFWUlBa05ka0x3Uk1Vb2hmT2xHL2cw?=
 =?utf-8?B?ZE5ZY2lDYVJYRFl2OWtIdHNBdFZ6dzJqT1J0THRUQjZkakpBZTV0cTRJQ3di?=
 =?utf-8?B?STc3S3JnMXRoZWZQanBObUVrdXV0UmNpbWhoY01sdXA5OTBnOGpuaEhMbFJy?=
 =?utf-8?B?V1lqQmhmeUlNY3B0aUdwM2pjbXROTGV2cTJVNHVBc2hnSm4xMmljWXgyTVhL?=
 =?utf-8?B?ZUVJbUZqcm1xd1c5azlDUmRBUDArT0YxaHBPc0tiMGdzRHVDenVLOXFsS0Rt?=
 =?utf-8?B?UGdpbWtuL09IeDY5YTh2cmlJelR4OW5LS3FOdHpOOW0wUjJmOU5IaEZ3dnpx?=
 =?utf-8?B?eWkwNVVNYzZOYWxPVUZmeWdmcDkyTTFHcndPWFVHTkhXdWJIby9Yd1kySlk0?=
 =?utf-8?B?a1ZYSXJLODM2UitIQngxK1MrS2REZ2UxRXFkN1ZrL2F0SkNpb1R2QUl3Rkx1?=
 =?utf-8?B?SC9KTUIwcFBQOUtPZ2x4Rm9ENy9FNW5vc2dOTCtDM1NWakU2ZG94cGVzbVR3?=
 =?utf-8?B?cVdheU9rK1pnQUQ1MXp5RURKRG5CVjFsYlpPNFFhWGNIa0w0UUorTUUzNVNB?=
 =?utf-8?B?ZmEyVEpiazloVW9iMDN4MXFMeXd0T2JkTmgxVWJuMEtHcnEvYnZwTXVEdXVY?=
 =?utf-8?Q?45RWohm4182/BWnaymT51Ll4SnMu29n3Gp?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUs4TDFUcnFGTlZETGg2RkFRejZ2dUI4TitXUGR6LytBUUp0NHBOZk43VUNx?=
 =?utf-8?B?Umh5VXVPWXBLTmQxbkt5L0plaU8zSlVMNjN2aWdSdGxPeTFmUG9uSjZsazB3?=
 =?utf-8?B?NkdtVWExVCtQNGFyY0o4V0MxWUw4ZE15MTduY3p3TzhrRW9Fb1ppNWtycklI?=
 =?utf-8?B?d0tjYVlSVXpPcVpLK2tMZzhJK25HeFhEYm40VGNQRTZSWDlzbDlWdEttdWlk?=
 =?utf-8?B?ZjZGS2NFU0NuNmdtaFJQRTl4YWxiTTlzRFlUUU1FQWszUnNUMVBTbzRUYVhm?=
 =?utf-8?B?b1diMXRzZHh2d1lhWXZwdVdPazFxWU1nOTNzODk1L1RGWWpuNTRwL21tZ1NU?=
 =?utf-8?B?bGR4emRpbFNPcVRCYThrZ0R1Qnd0S2tiZ21VTDY3Y1hDaGd3c2pkRjFkQjk2?=
 =?utf-8?B?U2tIU1I1RURqd25TT0todmRXWE5KNEJ6R3ZFZlNGTmJwU2U3NlhwZjRVRU5C?=
 =?utf-8?B?SE1tc2dIakltZlBpWHloWEZjZ202Z0NXTVBKU3BzMXNTZkgwVXBpdFRlSmFm?=
 =?utf-8?B?ZmYwVEpUR1hrdk4vanlGdTdQV1NwcUVuVEhFaHFxMVdsUHAxZkZ5RllzWGkx?=
 =?utf-8?B?Z3BQRDdJZGcxSWhsZkZ6anNJcjMyOUhNcDZneC9zMlJiaHI5aE1MbHArYThH?=
 =?utf-8?B?NGpmK1pWd2VrbGZSNFVZVUxPbW5vaFNLVDlGaFZ3MzhrYUxndC9zd3IrTHBY?=
 =?utf-8?B?VjV2MnF3Q1huU0sxbTV1elJ2VFRqYUtNZG9WdlQzSDZWNGIwRDgvOVV6d000?=
 =?utf-8?B?QzR1TTVHYks1RStLN0RHZGtOSWttTTNkQ25SRWRLZDVqRXlkZVBrZWpCNW1K?=
 =?utf-8?B?YW9obmlBZ3RsMlNRWU1iM2ZJSTdTTXREWFBpVkhYdVI0dU5SYUN4cnNMaHNs?=
 =?utf-8?B?SlNoZGF0RlZhYlVZa3VLZWJxT0RvRVhOUDJDT2toVXlkbUhmTVZyc0FpVzU5?=
 =?utf-8?B?MmZpTVVoUXhLR1FrbnJYRVc0R3B1S2ZhdkhkOUR5RVdZcityMkYwMndQaWFx?=
 =?utf-8?B?a1E4RFhhdlRVR1FURitQQWZXSGZwbUpxcnkybmFMcnZRUWlnZ2NUOU9STE9i?=
 =?utf-8?B?bjJsZ2d2ZVF5aDVTZEpsNGRBbFZuNy8zTU9JY040V0RWMHdNZWxqMzMwMTZo?=
 =?utf-8?B?MXBVSXRRSXlIOXZFK1R4dU5DUWMzZUdTQm1la2ZTRTcwYUNzUTNqM3NnOUwv?=
 =?utf-8?B?dFY1L2ZCZ2hpbWFzdkZnejJGRWd0T2NGZW5xclFtTFV4Z3o0ZmdTTDVwZU83?=
 =?utf-8?B?RytVWENqS0M5MWg3UHA5Tmp4VWhiU1JDNm1TRE5reDhRQXlScXRHUjh3K1VS?=
 =?utf-8?B?aFh5UElHSm9pM05LL1JKcjN6K0l3dFpMa3VLTmVVRnBkeDFndjZyeUNxbEI1?=
 =?utf-8?B?ckRGYUU3N0VpaG9LaE8xakc4d3ZzMjcxcldHSDRNb3pjMXRqb0taOFd0Sm44?=
 =?utf-8?B?U0pGeDJVY0tZU1Zxc1JQQkh4L3JBYzFDUlNYbEpKVE5EaWFXWnlRbTVKc1cw?=
 =?utf-8?B?ZE5GbDg3VFAxODZkMlc1M2szRmxOUC82UzQydEFTM1lhMXNKU2s1WkdBN1pr?=
 =?utf-8?B?dEFEUitGMks1bjN0cmFMV3ArQWhUa0p2dHVyc2s0VTR4S3hUOE0xL2lIbUtN?=
 =?utf-8?B?cnVmcWtlMGpNU09MdDZtVDVGbWpWTG1TdExOSmVocllGc3BybnZIWVJNdThh?=
 =?utf-8?B?NDNnSXR4YXVwQVp5SzNQdkl1Yjh2UCtTbVNQTXRlWVg3VkF5TE4zTEVPckNr?=
 =?utf-8?B?UGJkYWIxWjhOMFc5Si9HS1hqUDJ3d0krMkNXR2M3UytGeE9yQmxkYXpleHVn?=
 =?utf-8?B?NHFKRjRlMWpieXo3U2NHTFlabjYrekhpTVZwRlA4enh3c0ZUSUlKUGR0NVVD?=
 =?utf-8?Q?nHbHXKtmy62mY?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14bac41-78fc-4997-19e0-08deb5c66e2b
X-MS-Exchange-CrossTenant-AuthSource: MRWPR03MB11616.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 16:48:19.4030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7939

On 2026-05-19 17:24, Derrick Stolee via GitGitGadget wrote:

> Updates in v6
> =============
> 
> Corrected reviewed-by annotations in commit messages.
> 
> Thanks, -Stolee
> 

v6 look good to me!

Thanks,
Matthew

