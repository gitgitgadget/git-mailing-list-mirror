Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2104.outbound.protection.outlook.com [40.107.115.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EB2EB5A2
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750255962; cv=fail; b=MC7RJb6C2zcXgPkVUpWYxEr3Mqof1Tu6KKRFh54DLl1V34TouZfdbtJt1+/KB0CjkUHSx4U7t4FwUHXsKoOAh0BNhXPnQi8YgUDU7vRXK+SVV5NQ4dL9qLr3jPk5mnGu/ZRAQKqF5aTl5OaeMh6bcTvap8Ik5aDugodnOJ9u9Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750255962; c=relaxed/simple;
	bh=9aoaEDCGq+f47dDj7/b8kUDzYHQf/Q/shflW0s7eOcY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LVQhzUMbx/THxmKA+0vUOaisRLpq/BbNnPwodximgZqHrnxgqyM1dT40GG0b0n32zA9X5mii7lCC0E5vscemwwxL9izEmsc3eiUibivg74Up8fSHmgsJZ53E3oZ+NCae19ek7KTMtU+lVQnhVlK9hmc18Xx9UlYGs71GnFvX14A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com; spf=pass smtp.mailfrom=xiplink.com; dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b=VA1FRRrM; arc=fail smtp.client-ip=40.107.115.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiplink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiplink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xiplink.com header.i=@xiplink.com header.b="VA1FRRrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vjVqIWAWUVhySiZ1NOwiJT5M/QRvQhj3kfOQwEXzHOlzQZ4Dna9uuZYFHSDlifQvFlfpPOs0YKtcaLSzjAjd92Oonk+E13bhAtfjwVFQXvmqFnN/ZLQ3Sg3AfXJOgf7ZUNKKen6LV9q75bp9M5u9Cdcssej0N8phqaKxdJyKVM3tlnjMTvV7YS1jQtA+SYDv+QP5iT0uMIVA/QkLJMlhQrB5BzwkYKt769BYzTuQvT0C5qXCCbE7nEuAbsGOUB6SpfN4PY6SmFAINIvVWD18s5OJo1rac29WM7EXTxSeujF5C7fGEHGCCWMnl7mzSE9Q13jdWwFsDE/i5uLgwJlJSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrPxoOliqJgWYYixLZv/nJT229KMPfu+EsVF8yY3zrA=;
 b=c6Br7ANzkn+MHvFxsdlgGZyI5w9/GCQ37QnIxoj35jS0Li6roaDU/jBhNexwkTNQOzHtbyaELwkJCWNIq4rQ/bRCk56H3IzZXjs8IeJ57l5ajTMXFOAyNL2ucoDs5sX5rGMljQ6WDPlWOzVckbGwGfn50Q+sSSbCngF19SxpaKMrdBBYWvA1qUK0olBxuCW0TcChib+vwl2kyBGLUP8MRQB7kon7t5iKddp/EFfaO1Xdf8rOS5LLz/fX0gWSC5CMS3pUf25N71/mT9lnl0o9TH7pCXSpBz4+/O/XRLaVnIx07T6GfPiAp0Ez95SSyIXJ2uyHPK7pcu+FmgwENVYTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xiplink.com; dmarc=pass action=none header.from=xiplink.com;
 dkim=pass header.d=xiplink.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xiplink.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrPxoOliqJgWYYixLZv/nJT229KMPfu+EsVF8yY3zrA=;
 b=VA1FRRrMbUSJ6HE/RoYafXP8yVKe1Sj1SPQvj1N3y50bZXji+JdMuaalBYaEi9TfJpiYNoRW2UQq8Kftr832J8I2HCo67O1AXdF+Go4nsgGZ+5zKP8j7z68lP8Yrssb39CgbugJdzz2peIQpzF7cBOY/f0xy022jZEGpVvQila7tLNUcgJiKrfHkWWeKrpOsDpaBwtsx8oYwc34UfRclh2INKskVvcClulU32qMf0aNz84zT348plSK+PWDQ+rkCirjcb5/XQ2tBdZAAGl8JY3Mxc+PtnWIqYlgUDK+9Ifa/WA6ZO2a6dqUpEtaq6L1lDIEsKzpYdQdCHoiqSLq2dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xiplink.com;
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:f5::10)
 by YT2PR01MB9335.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Wed, 18 Jun
 2025 14:12:36 +0000
Received: from YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3]) by YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::fb6d:100d:8309:3ce3%6]) with mapi id 15.20.8857.020; Wed, 18 Jun 2025
 14:12:35 +0000
Message-ID: <e6fc37e6-7259-4561-888f-c3e892694421@xiplink.com>
Date: Wed, 18 Jun 2025 10:12:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] portability: allow building in systems without d_type
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>
References: <20250618062331.78059-1-carenas@gmail.com>
Content-Language: en-US
From: Marc Branchaud <marcnarc@xiplink.com>
In-Reply-To: <20250618062331.78059-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::19) To YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:f5::10)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB10537:EE_|YT2PR01MB9335:EE_
X-MS-Office365-Filtering-Correlation-Id: e8086f5e-6875-4496-cb53-08ddae722c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejhpK0QrY3pYVU94dlg2NXE2d2hZWDZ4ZFZtbXR4Q3hmVzUxcG1EUGxaaXRu?=
 =?utf-8?B?RXZFNGJnZVJ6USswWGlRc3Z0NnVuU3Y0OExLZHg2dy94Qk54anpkc0ZXOGZs?=
 =?utf-8?B?cGVPZkJ0eHJDMzdPQ0tKTnNmelF2MUZNb1VBbUJXUFRrZjl0VFp4MmhQVzNX?=
 =?utf-8?B?T2RTZzJCMXFHN2xmWFA0YXc4MEtJMFMwQ0hURzNsNDY3cGF0Vlo3ck5OWGhv?=
 =?utf-8?B?QUZpT05MeCtUNjlJVGlvZ0I1SkMwTW93bmlWK200MlllSmhqWjNQOWN6UGZ1?=
 =?utf-8?B?QTVyU0RPTUpIcXIwNlVQNzAyRkQ0MC8xUHJUTExOSk9mVHFCVjdDa1NETzFo?=
 =?utf-8?B?VFgyd1JCWkhBRktXS29sWWN6ZGJ3Um8wRGM0Q29MVEJ4UE1yNjRyMW5Wb2lM?=
 =?utf-8?B?RzIrZ1Y4M0poTGxoNENKWWJQV3J2NmJZZXRUcTJZd0tEVFlkZjV4RUx1Zmlo?=
 =?utf-8?B?RWN5TGFvQ1VTWUpuNFVvd2txdWNPNW5seWlVRFlackMwUHVHT1FGUXE2U0ph?=
 =?utf-8?B?SVpRdVRxMG9yU1Y0ZTZEcEk0RFZLWXJUZ2xCeDVOcWxrS1NLVm1BU0dHZmlI?=
 =?utf-8?B?UXlscHVybzBST2MvSjZKRnJlZE5CQitiN1hhdXl5a0RPcFI1alNyZmhleXVN?=
 =?utf-8?B?QzJKbEwwUW9lMzVsc3hacHpINlZCMTZycVFTbG5ManJlQUdSazFPTklmeEh5?=
 =?utf-8?B?eSswQ09CMXQvNVQyWS9GMXovd2dCbGxXRXNzZythUWh1L1BkU0tUZU1Obkls?=
 =?utf-8?B?TmI1UCs5WDQ5ODlHenRHbE9MeUNITGdMQW1hc1JiZ1NRT2FPM1REVFF6MERh?=
 =?utf-8?B?Vjc5QmdRN09Nd0dJL1M2YWVmNFRWZmMxTHVtM2VqZmJubmkvMjcvV0RoYjNW?=
 =?utf-8?B?Nk5YUmc2dGdmb2svM0VMNkRRWjZhUFVUdjVKaHNlTjhFOXdVVTVWTUYrejlX?=
 =?utf-8?B?U0VYNGpFR0RVMCs0Uk9ZdXJTQjgwUnN5L1ZaN1Z5Rm5VR1hnQWdBN0Naa0lJ?=
 =?utf-8?B?RlppN2NhRHpBOVcxSWg0WkRmNHVVSFREQWxwMHRkZWxOVnpPQkFIUzFoVEty?=
 =?utf-8?B?TXpHRGNKZnVFcFFzamRVZWFjY3NSNjJKRmcwWW91bVUyZzl2V1pWaGdudjB3?=
 =?utf-8?B?c00wZ1JGTzNrbVdhNEV3bzEzdDJISk0ySEpuMEg4bTdjSTBndzFPNHBoVzRB?=
 =?utf-8?B?dThWQmxCbWFUSHlnQjVrQ24vVWtKcmFjdG13Y051VWR2MFlGYlRURXJaMEZv?=
 =?utf-8?B?MTJNSldMUnE0MG4zdWpNVnVoaDJqZTZndWZ5L255K1JqeGxBL0NML2hBNndo?=
 =?utf-8?B?WnBaWHdJN2hPZ1JGUXJsNUc0QWg0K2VUOEhBUTFKeEora3ZuOHFtMUViWkYw?=
 =?utf-8?B?MVF3M2hVMXZwd1FqNEw3QW1tbi9qVCtWT2c4Q2ZIOUd6dVdNVFlkTGx0MmtY?=
 =?utf-8?B?UDlJKzNjKzRDVzFQdkNIMjVxRm9VbmNsU0JlUEtvQVJ4c2h6RFNoblN4NTJ1?=
 =?utf-8?B?Q29HcWpKWHhyaSt2RzNsK281cFdRZ0xEOTNBbXRENnFUaUc4ejJ1TG04VFFB?=
 =?utf-8?B?dUQ3RWZWSTMyMVlVZEhqRjQ2a2xydkhMWUhDaGdLaTRmQnJVbjY0UkRkZnRL?=
 =?utf-8?B?NksxSUNXUkxJM1lBNklpQ3BtTkxGM09zT0ZiWWQrZlRveTlrSmlndkJMenhi?=
 =?utf-8?B?d3dVWUN0K1p2QnhCbXN2c1d3SEZzQnRHR043NW5ScVRjWFhTNURQNW1reWZl?=
 =?utf-8?B?VXord1hQZGFTY3ZuNW55bmhQQWNiOVVNNXZxb3FGR3l0NVlZUGVKbWZtQnM4?=
 =?utf-8?B?OFRZZGNvdTFJZVNjMUp6T1pMRHZLaE1VMmdYVG5Ub2FJRnp3cmtBMklzbzZv?=
 =?utf-8?B?RkFzbC9kN0Y4Z1RicUZJTEVLdkdjTzFIYzBPVU4rMEFuRjhPQm9tTm1wSU9z?=
 =?utf-8?Q?ZBKA5UvUW9U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1c4TEs5SlFNM1YzQU1Wc3JiZXArUVVaVVZuNVpMbkNlQ05qaUVrQmZLeWw5?=
 =?utf-8?B?RFpsMnl1VDh0d011Z0cxMlFkd1hacXczS09nM3dOTEJDZWUzSEs3blh4aTZI?=
 =?utf-8?B?YmdUZHlIVHhMSlNENGc3anY1NUVkMExEQ0dEN2dwbVpWMXZaQWlSZTNoVkpX?=
 =?utf-8?B?S1haUUVldWR2UVYrZGJFRzJJOWVxMTA5NWQvSmZyS2JvazZCcDVBYS9kblM5?=
 =?utf-8?B?c2kyMDh2R3FiNC80RS9lVWxSaUp0YkhjeG51WEZSYmR2eGVtTmFFWXdyOXM0?=
 =?utf-8?B?SVNkbGtKMmpEOVpRc0hBTE9oUFBsVVoydTc4cTZFZXpsUmMvQUNpNUxQVGIr?=
 =?utf-8?B?ZGd0djhXVTNuRlJycTBlQ2pGME9Hc2JYc2luWk5QZ3QrVGVtVHVEdDdrZTJk?=
 =?utf-8?B?MEh3alQyVnBOY0lnRHVnTlpUcGdDOU1WUkxSL1ZrYXZsZ0ZXcWhhMGFybTdr?=
 =?utf-8?B?QlJpRUpjeFVTSDFFYzRkaWtLM2NlRDNLZXpjamI2bU9pSkY1czd1cWk2Q1Jk?=
 =?utf-8?B?Uk02TE5Xc1BaOXdrZVgrRXR2S242UzdweUE4TkM4cml4NmJNTXNqK0RBeCtt?=
 =?utf-8?B?SE5vREVKUCtPZk9UL3kyZTlndHlQUVZBK29VcDdBR2plaUdtbWhUaHpJYzZY?=
 =?utf-8?B?L0UzbklLeXM2cEYvditNYy9zM1JYaUI0NnpPUTNzeFNKVWdsdm9xdEtSeExU?=
 =?utf-8?B?Rmt6dTRSQzYwYVp6bm4vTnU4SnRiQ2xWWW5kMTJibDRUV3ZoRkdQQXNmenNY?=
 =?utf-8?B?dUhsTHUxdXdPeGk1anQ5eWVJUmg1TTdOTUYwbkladEhMSkxJdmhXd0t0QmhU?=
 =?utf-8?B?MHpIR3V3V21ZT3UzVnYxeGkwTVNaTms2c2pwUWJVMFhQRFQ5RFlpelJaS09j?=
 =?utf-8?B?V29GaDBVWnB1Rk1TSkJBRTVxbHo3OG1CclpGT29wL1NSblc5N280VTJHcFNF?=
 =?utf-8?B?dFFhQ0lTVm9KZTRyeVdzR2JUQk44Rmc3YmdRdXdWd2haUFo5T2tSeFlHUGt6?=
 =?utf-8?B?STFyZ2xmMklGVXFFTkdZZ1NBT3ZoUTdsc3dRZEV4NzdIeldqSk05Nm8rUGNj?=
 =?utf-8?B?ZDhNcEUzakpSNmpkc3hGZU52emNqUU5jTFhyeGg2Q0Zmbm5lVm5JOWd5eGdC?=
 =?utf-8?B?OXoydnpPdnZtb0h5QkJLdnRQNVNFRkNCZmJiWmJzejFuQUl2Ti9nbkJtcW5I?=
 =?utf-8?B?U2NmSmQrWEJXZHpDUHBiTS9yQW9wb0hacGd4dnFwV1VJNHJScWU0cGIrU3M3?=
 =?utf-8?B?TFVrbFlDR0Fpd3V4WmVtUzhrMGxIVmxyOXk4OFUrUVQyMU1UbVdpTjdaTjJ6?=
 =?utf-8?B?MWdxS2pGa3lSZ2xVTnU5VGNvNi9hTXNkUjFSanBPYW8vcGlJZlNtc1BsRVdL?=
 =?utf-8?B?UndNaFRQRU5vbkRRck1mMXU2U0JjNUlPa1ZWUHZFZUJGektXT0VoS3FJMEgy?=
 =?utf-8?B?RDVGY1JKSUdzRWJ0YWFhMXNJcEJJNll5R1NCNkFXQ1RaeUU1TS9NckFYSkww?=
 =?utf-8?B?Sml6d2JFNjNraVNJQU5QTnp2V3RMVzh4WFdZOVh4cm1mYjZUZVBnMUxvMnVM?=
 =?utf-8?B?aksrdzlvTUlSVmI5VnVaR3FTL2tDMCttZStxV005KzJ5bnFXUUkyRGZpUzYr?=
 =?utf-8?B?TFdzT2Z4WDlMeWp3eWwySFgzUzI2UUFBT1lzcWJmdHdoTk1aRHh6MjFuMDNt?=
 =?utf-8?B?RjRiWnFuck9TNjd3ZWE3NGNYemcwRmpORitZT2NFVWpOTC91M1ZNTmlWWU1t?=
 =?utf-8?B?eFEvSWx1eEVMZ1V0VEdJY0xpSHNYSWRuSnZSYmJ3R0JRN245dTRvclZaRjJR?=
 =?utf-8?B?YnJWcXJFME9ndmd4L0FXV0hFVE42dENwaE4vYVJjQkMycWFGYmN2dmVvS09T?=
 =?utf-8?B?QmVqRStjaDJsN1V1MFFBdERpUHBZQVZVeW9Nbkp0MEVzNHVQeUVSaXo5WUR2?=
 =?utf-8?B?eXJ2eDhlbm5Lb1BJVWFpY0J1NnBXM2hpeGZHMGQ1WWFBRHNuVzZNR1RQMm40?=
 =?utf-8?B?TnpJbTg2MlBLUHcyVXFKS3pWVk5iTTRSTG1XY1hMOVI0dEdBZVdCVSs2NGg4?=
 =?utf-8?B?WGk0OGZRTEl2T056Ymlzc2pnTGY1N1V4UWUzdz09?=
X-OriginatorOrg: xiplink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8086f5e-6875-4496-cb53-08ddae722c2a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB10537.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:12:35.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 14f927ba-c95b-4aa6-b674-375045ee9d4d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kCScBYgsHqjc+PeP/fkzzQvMm+YkgIMSWX2CcoLGCX6m4WV24zzriZZBx7N8eiwRdSdjPm9ur+Ldy7KtQQ0AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB9335


On 2025-06-18 02:23, Carlo Marcelo Arenas Belón wrote:
> Since 09fb155f11 (diff --no-index: support limiting by pathspec,
> 2025-05-21) will fail to build in platforms that don't have a

s/will fail/git fails/

> d_type member on their struct dirent (ex: AIX, NonStop).
> 
> Use the DTYPE() macro instead of a nake reference to d_type.

s/nake/naked/

		M.


> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>   diff-no-index.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 4aeeb98cfa..7c95222ba6 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -46,7 +46,7 @@ static int read_directory_contents(const char *path, struct string_list *list,
>   
>   			if (!match_leading_pathspec(NULL, pathspec,
>   						    match.buf, match.len,
> -						    0, NULL, e->d_type == DT_DIR ? 1 : 0))
> +						    0, NULL, DTYPE(e) == DT_DIR ? 1 : 0))
>   				continue;
>   		}
>   

