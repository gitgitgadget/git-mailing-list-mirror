Received: from FR4P281CU032.outbound.protection.outlook.com (mail-germanywestcentralazon11012022.outbound.protection.outlook.com [40.107.149.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91D3314A83
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757419662; cv=fail; b=krbqJfvtqpVHFKQqf9bTM+usERPIB8nr+DUWG6a8vCg7d3DzIrZp+qAO705ZoswsQGrDE/G/kt+wJEF89aAQazjwRKM87x01by4bBxqRuGqMkSF18O/vgxsMV8yx6KutaWjMCZMjyLko7iZMyFstGXtoRgcP9a8VzfjUVGzaBSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757419662; c=relaxed/simple;
	bh=Ci/vUwl9K/ba4twyBaI5r7VuSG5I+3IEmLw29XoK/GE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jmn8znUrXalggMBh85hjBfjCN1owi8fq2aljlGReOdzUZL3OnEZvNGfIlBf3UVgdkhhb69vusxMEE1YBcGcAOCIpwAbOAn16RuLTT/ZPbiNOFQXF76seAYET5niWE87+c74woipJZFfPaA9lRJR0O1xy2q7/e+ag8KJYlXGkRnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com; spf=pass smtp.mailfrom=innomotics.com; dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b=6TgIRph+; arc=fail smtp.client-ip=40.107.149.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=innomotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=innomotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=innomotics.com header.i=@innomotics.com header.b="6TgIRph+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/uJ4Tq1KoIS2Q7q59DfpQXJHiOYsjMNpMB5nqZrGgLHJKUTVGBuJ6ADfaEG09+ti3bOQLoEFWQJ/zKWmVgkZcbs3575Bo2U9ns61bf9Ofbh2rjKFKZopRnSGw5LpAhXA7mpEW6B68k7drMB/ao+lLPmzAd2o2Hy31iPAnyGd54M21QTyRdjUMAFUhQoK/1mRgzwNGa+8Qwbt/66kTL+V5jczWcehr6Eq3ynuldET67q6G0fpBjNpgkX77acN2SXXFZSe6pIPPPLOyIp+ldlo55LW0ZB3Lp38rXXTCane64FDYZsBobpVhAiF8rNyu9E7uUYg2dg9eKUHx6TvAqkTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnhOOci0mnuyinmI+g9Y3k751woOguE2zE/BCmVn9ZU=;
 b=aSvNvtCo47D2yzrhCz2O9IY7N0pgInGskDGPXpAOEFC/JK73xO81Gxl+Tm9pRqMqguSlXjhDIcXhacTEX0V+hqIHtDOLHnIGGXqyHMg7DpOfz7Dz+ITCylJxJKf1sXiNmspGMGx8zBW8oyEKByHphVZCzJldl0nOTGfb3SJ/tAGVJuua9RMlQlmjjmh/CN6T9w5SmoBx6Xxbx1TwAdcxZkWkY+RnyVLu7CmyddCyPtSA2F0/OqtuepBHZbDoE1CAOSTrHKm6RWGtxau2YWkNmAo/p5EMgnJAQ/WeNqjPz1gN/mk5k3e0RMcDIzBQM23wE+8HF/V608V8oUUYAM5nsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=innomotics.com; dmarc=pass action=none
 header.from=innomotics.com; dkim=pass header.d=innomotics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innomotics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnhOOci0mnuyinmI+g9Y3k751woOguE2zE/BCmVn9ZU=;
 b=6TgIRph+NepvBO53Dalr7GSHgHExxSut71vxQkkixwt97tuAsLs6kRI38cYo3Mq8TtXNTzgpTIPMOa89dtEf+SZ+ahCwoUYu0WGonIODV5UPn8EbEN9LCa6RH4itfVKfrfw82hYsdFDO21puP0KQgFTXLl0u/ktWq21xzwUituVhEuj8wb2HsXBYuD2SF+tQ8pEwOlV6vAoiDyqVN5QjOjDWAaPaqZdLpScBxFU1zgx3OB8jYQIjJSZstg0ppWmPMC2zFIxE41MtKm4Jm7TxutME97LrRTK0ZodPck/TBxEa8QdiAH3T7cR1JW1Kr21d5lelsOhdCaH3aCOjLCAM0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=innomotics.com;
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::1af)
 by BEZP281MB3160.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:24::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:07:35 +0000
Received: from FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6]) by FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4db0:74ab:67b3:b6%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 12:07:35 +0000
Message-ID: <d65be6d8-3aca-40e6-9b7c-bc6102c950a1@innomotics.com>
Date: Tue, 9 Sep 2025 14:07:34 +0200
User-Agent: Thunderbird Daily
Subject: Re: [Bug] Compat objects not added to CLAR_TEST_PROG
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
References: <d8d4266e-838c-488e-9aaf-4a1be0169795@innomotics.com>
 <20250905213708.GB612697@coredump.intra.peff.net> <aL_bAxZubXMOGWsu@pks.im>
 <50da35ac-71f8-49dd-bcd8-83726f1954a9@innomotics.com>
 <aL_-My5lxRQiOPmh@pks.im>
From: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>
In-Reply-To: <aL_-My5lxRQiOPmh@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::12) To FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d18:2::1af)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: FR3PPFFBD1D31FB:EE_|BEZP281MB3160:EE_
X-MS-Office365-Filtering-Correlation-Id: 532cdeb7-deab-4712-40a2-08ddef99762c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NkhZWTVGSE1VS01nRTRxdXlmeFRWRlZZbU80TXZYZFFhQmd3T2VqZWZvSFhQ?=
 =?utf-8?B?NFZyZGVkSnZHaUtSVFdIcXlWZ2VvOS9VYmVzcTA3VVIyajNpTlJ4c3VtZnV0?=
 =?utf-8?B?TmhVWWFmTkJJQ1hzV2VLam1HcHJPMFJTRGZIZ053K3NwRWpKSFR1dTdJSXE2?=
 =?utf-8?B?Znlma0lCRlJSUFJqbXR4TWpnVGRwOERZMXd6aSt5d3Q4SjUxRTZBUkxKNmVK?=
 =?utf-8?B?SzdUVzQyYnBnRHhzNldjWTBhdFNVaUJtUjFzT3lacXBkNENIS0k1Wm9NN0NE?=
 =?utf-8?B?RjRwN0tPTUxYenkxZXNuL0h4NXR1bGd5TE9jODJFUUtKTDVEazRSSDd5Z1lk?=
 =?utf-8?B?TWVjN3ZSZWduaC9HWmdqUTRkQ0pnaVJxc0FPcUVuV1c4QWJESlVVeDVyM1NL?=
 =?utf-8?B?YW9paUsvTStCZ0J2dEtYUDdyVG94TnA3Q3FaY1dtbC9HeG5DbkxndUcrcG12?=
 =?utf-8?B?MXJYM1ppdnBhcm9EbFY2MXFGQS9uSldoRDJmcTErNHc0T2pqYW5QdWloRkFm?=
 =?utf-8?B?Z0FXUEYva3AyQVhMbHdtSjdaV1pCWE5tRWVwQXpmbi9pLzQ2MW1JWUVHRjl4?=
 =?utf-8?B?b1BJVG1zRW9qMGRkMm9XL29VaEhuZ1VjQ0JIK0lwSEl0KzkxSUpIYVRIblh0?=
 =?utf-8?B?aHNMNm1YWGxvc2tPK3FCL0lVTmx0N0VaQVM5Z3B3NlY1emhBTmt0bm1QYzFU?=
 =?utf-8?B?cjIrN3NtaEluOTdVSVZ0U2owajRnTHEwRmFIZVpuRlFXNFB4QXBZRWtsUjZB?=
 =?utf-8?B?ai9pdXF5RlBFeGxBZkNBUWI2T0E4WkhKL3VBalBsY2orYTdVd1V2ZFUzNmp2?=
 =?utf-8?B?WXUzTGMvVEI4MFhIVkNqbTJxZkI0WUNTaEh4UGhsbDRtcExOanJrVVhQb2tE?=
 =?utf-8?B?WktTdnJpMWltUjR1VjlUcTFnVFVNOGhXQTZsckhEVWcrWDlzZ1dhSy8yQ0FQ?=
 =?utf-8?B?b293Qm4vQ3BRd2lzd1c1RlYwMzB3eU1VU0xyd2pubWVKam1jc3ZGU2FXbWRa?=
 =?utf-8?B?bW9ZdVFDQXJvL1p2a2YxT0N4UzFTOHFXYzhlVmNKVlNZWjdLNDdZRHFBQ0NQ?=
 =?utf-8?B?anZ4UFVKWkczM1FuNkZHSXBqdlFCb1R2MG5zNjdtSk5Kc2lLKy9INWpTaXAv?=
 =?utf-8?B?TG5UdTdZaU16cU8vbk5xNXFEVDZRZzNYL1ZERzlLd0xleUlMQk4zSUtaOGt0?=
 =?utf-8?B?cjMxNnQ3QTRlenZ4UEh6bmdLeWVYaVZsVGVpRTEyb0lyNGh0bUdVV3ZoMi9J?=
 =?utf-8?B?Y1FiTHdsQ3lOVjBTejN0UnJIbmN4VXBJZ1poR0NtWkhJaTZocVlsZ0Rsdm5u?=
 =?utf-8?B?ZjJGOUpsN0M3cUU3NFFWTERwVWk4WUFuNXh0b1EwWm9RMTBqQ1I2UzBJb1Ni?=
 =?utf-8?B?VXY1NzljcVJoMEFnZHBlWmVzektUbGVMTTVLNlNvVUh0TnRtbHNOQlh3UU9x?=
 =?utf-8?B?UWdLd1lna0FVdVFaNldoTFViWUQxZE0wSktRK3ppWTQ0ZWNGWldSZFVqQ2Mx?=
 =?utf-8?B?NzNIUUtFVzZZWVE4dS9pajliZEJVSTQyZGZEM05kaDB0MG1CTldLZGlnaUN0?=
 =?utf-8?B?ZWdyOHR5clBIV2pqSk1CK3N0dzdrem5BdVZzeVNHb3dPZXM3NEpBUTNaMGRR?=
 =?utf-8?B?cjVVeGk3cjNYbktLb28xOUdPWVl3OHcyWkloZjNvM2xHaXFmellRZ1pwVWhZ?=
 =?utf-8?B?RFFnUUNBZ2lYaU4rc2MvZk5sZW1NUW1HbVVLQjZKSk12Yi9STS92Q1BWWVps?=
 =?utf-8?B?SnRKZHB1MlpWemdCakR2S05VRmdzbG0yeldnWWpOeUdIVEQ0NHhJa3lXVlBX?=
 =?utf-8?B?MmpPbGtMMlk3Z2Vna1liSTEvRVU1djRaeFpLS0JwQlhuVEFqWjE5TXI1NjNS?=
 =?utf-8?Q?ZCqCv8ideHZZt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzNNQjVVNEl4eXBOMDAyUk5IQncyeFF2ZDhlNGExWXhzL2d1QUNFeElPYStK?=
 =?utf-8?B?b2MwUEpkeUl2K3VWaVk5U1RzODYwdmtYcG9VSDBlRFR6T0Q4c3VsTTA3YzE1?=
 =?utf-8?B?ckM5Yys0MEhjVFNOdTdGNEc4V1B1YVRyWDZVck5BWHlDWXo5Z01QZ0xGVkYw?=
 =?utf-8?B?MEtyNnlPanRpMStFYUJpMnJXbFAwVWI2SVlPa3FBQzFKWTgydU9vcERvZVJD?=
 =?utf-8?B?QUhqN3lzZ3I2VUpPMGZXV1ZsS1Z2bGtRVWM3cDViWTl5bHpvVFFpOUI0U2w3?=
 =?utf-8?B?NW9Od093dUZPS3lab21qM3pXRHRjaWlCWGk3UG1YUm5wRFdBNUxHaTI2QnNX?=
 =?utf-8?B?ZEEvOVY4eWZ3RExmWElnUnJIOUh1M2dBS0o4Y1FueWU0ekZqVHc5ekRhSDdI?=
 =?utf-8?B?VFQza01URDdic1orTjNFNzhEVnMrSFpPK2VXb0NNb2VPdGlxNXZheVlRWjFi?=
 =?utf-8?B?QkdjR0Y5VU04NDFqYzBJOU84L3Z5NTZnSms4dDZQbGhnVmt2bnlRanJ5WVdZ?=
 =?utf-8?B?eGlwMnQ1MTJXeVh5aUJVSXJFWDdTOTNjWGtyajEvMCtSU1N1Sk1YSWZsSUx4?=
 =?utf-8?B?VDk5emd0ZFRrT0ZBNDBCRy9WL0dwREpLRW0yUFpaQmxTaXZiVFpiN1RxRzV0?=
 =?utf-8?B?VjdjUm5qVk5uVGZ2eHZyQzBBWC9LWDZEdVpKUFh6RzB2WTNkNUZTdzBMWENR?=
 =?utf-8?B?UVdWZkZGNzA3UFR5NGhIVjhjN3M3S0EvakNkMTFJSVUxWHpvdFVoekNacEp4?=
 =?utf-8?B?VGZGcUt0YktTQzVjOUNSYmMwQkthajMrSW1pZnV0b3RJblFsZzFqalZKV2U3?=
 =?utf-8?B?UXVFWEg4Y2M3UTR4WENyZ0hhWHhNend4NU5XUTRIRnBYMkdzK1hGTHNmRm1P?=
 =?utf-8?B?eDB1WTN4YWw1c1phWFhESzJEeFF4V05XcXhuR1V6czl4RUpXZFpabnR2K1Ex?=
 =?utf-8?B?MVpCV0h6dGY2eFI1N29hNW0xNEh4ZE5uSnA1TjdTNFBvb3MrQmxwT2dqZ0w1?=
 =?utf-8?B?SG9PdE8yNWxxbmNXQnduMTY2MkFzWitMNm1qNkJzZnljT3BzbTlsZjBZMzFV?=
 =?utf-8?B?cDF1QmtTM3FaRDJQNjJpdHhnWklXUnN0eUpXdlZnYmkrMkdFbm91WHorRUd2?=
 =?utf-8?B?UGFBWW80eXFoL1Z0U0pRajZnd1VIckxPWEJWOFRmb1pkTTRlK2ljVTlJaHJX?=
 =?utf-8?B?V2lNQmlLdnF6Rm16a24xUUszblNueTNQeVZuMHlzWExyeGtJTjY5ZFhPcjgx?=
 =?utf-8?B?d296WCtLTmdLU3pVNC91OWprVTRIemFOQy8xZG4xQlducVljVDNrKyt0L2RL?=
 =?utf-8?B?TE1PUCtyK2owanhyaWhwSnMvdTF6WmlUdGtibnlUcTZXSnQ4ZUtsQS9MVnNQ?=
 =?utf-8?B?ajdrYk15VXJQdHRRc3V4Mm1ub2xUTC9LQzlqanFRcTVRdXE2QU00TnRYaHhX?=
 =?utf-8?B?bURwc1ZxSlh0L1ltQXE0Q2ZJdTJ6VzJ1QnkyZjMwVS94Q3l3YmUxN0JvZ3Qy?=
 =?utf-8?B?NEIxendReVlaT09XVStCMHRNYXdKNitnQ1ZxVnZrUHcyUUZlNVM1YVB3bVlT?=
 =?utf-8?B?NCthZGZ0NWl3dk5CVzJBQVAzQldWNFdVWDBWVVltemRDK0NKUUliWHZGNDhw?=
 =?utf-8?B?TUdoSmVLR3Rlb2xobTFhRHlYb3NmYS84ZnVTSWlpeUFUTVVyMmRFbG5CN21S?=
 =?utf-8?B?L3B2WFBTM1JqSEQ0TE4yQ1R0bi9nNzFBUUpXNFdiQ2VKNldzUndWNWNpTVFC?=
 =?utf-8?B?dkxvb0IrMkdiYUg1aGJsVEU0MEFsUjBuSG9wcU84UEE4NXMvaDhCd0VNZ0Qy?=
 =?utf-8?B?bWpNSVowd1RKa1N0VzIrZjBUQXFtMDlrNHkweXBkWVFvYk05TG5NSDIyN2o3?=
 =?utf-8?B?aFd5a1ZnSUR5MkxCb014YjhiQzV5emhKRVd1S0Y3THJHb1hlTUMrNnAyMC94?=
 =?utf-8?B?WjJBLzdjSlJ2QjlrZ3d3TXNZakhSRk92L2JQZkplc1M4SVVtSFZzSU52TDFh?=
 =?utf-8?B?UGNQQmVPazBxNWJ3MjEwSzlHNzZOYytFZ0hKRmdwMW8vM3pjQWZ2STVlSndu?=
 =?utf-8?B?SFNNcy9UeDNhOVY4Y0lZUGtpZ1NXZWxqYlBFdmdLbUIxczBOZ3AzMU1Vcm5k?=
 =?utf-8?B?UkJFRjBKcVJiNEJmK2lrUzViako4V2daanVLdkxiS1BWaW80eVdHaTcrUGVi?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: innomotics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532cdeb7-deab-4712-40a2-08ddef99762c
X-MS-Exchange-CrossTenant-AuthSource: FR3PPFFBD1D31FB.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:07:34.9988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 698c6ffb-74e3-4a84-be68-f22d8d3201a3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +OjYCXhDAaD/tJIvF/qhlVIfyNfG7QEl9cl0blyRPmMEoOUrOdu5wdtd1xiYFoseZKqOQ85+NzBLzc0CmA/56wcRONvYf9+DiHh2zn+TXyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB3160



On 2025-09-09 12:15, Patrick Steinhardt wrote:
> On Tue, Sep 09, 2025 at 10:00:54AM +0200, Osipov, Michael (IN IT IN) wrote:
>> On 2025-09-09 09:45, Patrick Steinhardt wrote:
>>> diff --git a/clar/sandbox.h b/clar/sandbox.h
>>> index ff43159..5af36f3 100644
>>> --- a/clar/sandbox.h
>>> +++ b/clar/sandbox.h
>>> @@ -164,7 +164,7 @@ static int build_tempdir_path(void)
>>>    	if (mkdir(_clar_tempdir, 0700) != 0)
>>>    		return -1;
>>> -#elif defined(__sun) || defined(__TANDEM)
>>> +#elif defined(__sun) || defined(__TANDEM) || defined(__HPUX)
>>>    	if (mktemp(_clar_tempdir) == NULL)
>>>    		return -1;
>>> The `__HPUX` define is pulled out of thin air, I have no idea what
>>> preprocessor macro that system sets. But something in that spirit may
>>> fix that issue. If so, I'm happy to fix this upstream and then pull
>>> the latest version into Git.
>>
>> I can confirm that your idea works and much better than my idea:
>> root@deblndw002x:/var/tmp/ports/work
>> # diff -ur git-2.51.0 git-2.51.0.patched/ | grep -v "Only in"
>> diff -u -ur git-2.51.0/t/unit-tests/clar/clar/sandbox.h
>> git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h
>> --- git-2.51.0/t/unit-tests/clar/clar/sandbox.h 2025-08-18 02:35:38 +0200
>> +++ git-2.51.0.patched/t/unit-tests/clar/clar/sandbox.h 2025-09-09 09:50:07
>> +0200
>> @@ -128,7 +128,7 @@
>>
>>          if (mkdir(_clar_path, 0700) != 0)
>>                  return -1;
>> -#elif defined(__sun) || defined(__TANDEM)
>> +#elif defined(__sun) || defined(__TANDEM) || defined(__hpux)
>>          if (mktemp(_clar_path) == NULL)
>>                  return -1;
>>
>> Can you make that happen upstream?
> 
> Merged upstream now via [1]. I'll send a patch to the mailing list later
> today to bring us to the latest version.

Thank you, appreciated! Didn't even know what clar was external.


Michael
