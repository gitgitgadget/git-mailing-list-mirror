Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2030.outbound.protection.outlook.com [40.92.89.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E511E25E3
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 08:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334451; cv=fail; b=BxS6mLWkqHJFXbF82itHD0s35DKATQufWkABbMF3aMYqV3f4M54a7SR7W82ttFAElhz1yLCeAtRmhQFZgMTpLK6rWlGs6kAWligk9XL0ntEiaBxsu69Lu0k5g9xJCpfTqRqGsMirju5Iuabyp1D7kFOK3Sten08xaH2XPTc3U6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334451; c=relaxed/simple;
	bh=NEiP++DH404IXJEwczctX7vU/tbEM9HBntqFfU9/lIU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=j1XeOPp9B12E2xTbDdRXeORpP3CK8dN2KaTYRDxwqaMTfLEfo6LPKA5+MavSwiklX8c4G0NqW6dUfQjL57RsY1fC61HfMHkCzO/Cp2dAbBd6z4twf4sq/wmgKogbqmLL8m/jqDZcEf7Y4ctVXJRxH3fxTvHDKuv1qJaPMoPYdck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de; spf=pass smtp.mailfrom=live.de; dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b=qSOSwpUm; arc=fail smtp.client-ip=40.92.89.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.DE header.i=@LIVE.DE header.b="qSOSwpUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sgppvF9FnU1imWGfFoONB+fn8CmRtSOugqVVd6QU+NKY4A8ltOfEKqPDxjyxJcn0ww7JJFeeep9w4RDxpKu1Kd80hDDVc0f2LgDfBAdk5flmpGqi+wL4MHjr2EcUaJrDIqDwonTCCFMnE215/NyY0wekgc+kynFuGTIzshvodqnbtQdfhQh2W8MUu5jQWWmjSox/cV6dhLAGSTy4PGOV7d6G4nHhtHiqXNbkgydX3LAGVYBufWzHdM4CMNiVfIC4V/vcfYegPTiZNrNt1ZkS+DX15+rbI6TGyYWqTKlZoImeQup8DiatZLcAt6jD+Jzfe9s6hGIErRUPwzN11uzcvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kp9RVgNnaIiKE/8bwPLaOG1gQiQOOJbLFehaCz7QkKU=;
 b=LDYCDRWgcdOK5yOZNSsddI6vqRq3wYeVM9/vx0afL6fk9UhrPJeoqld00gD91s5dx0QJ5wjlAyupz6N7DN/nsA3EYTDFn2CaXb0tV+CfouR3tid3sOoJ3278qWEqnfiJMItq5fYDNwmMkUS4Xqw9FQ/3tt2pHCh6xWvnHT6QrM4maFzxAELbmjKYiXPNubdn5PRlmBSUh/uwoZ2mI2/NPTJvaI2JbzV2sEq6vENYPIPVHgRDfJ8H7OgmoqziQ1FiymVi93/dEpFddRGnjArYwfNjUYVhNNc3c44nd7/AUuTepqXKRWj0dNf1ZoE0Nw8VEjWDLdFOCxR3eCnvHwU2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.DE; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kp9RVgNnaIiKE/8bwPLaOG1gQiQOOJbLFehaCz7QkKU=;
 b=qSOSwpUms5z7295D5yDOmYXbh6TIqQWVSgI71yPBndkhclTZ0hbhp1F7hpZaTOwnfEDOVI4S7uK/BaEUhMYf993SWRwUlnu1tTfc2vsXqWbK22bCK3BG0PU2pGM7VhT8s27jGMPz7YuYinhx04VSRr625+DLTxtcD5/xrXhp7BJmTg7/rpiSRaP1SzhTDho+GngvgsZXBcnCIx1qnh9+JVseujwMCC3bWqqXVmdQptLRkwmG+vcwubI1SGlvRorK6f2MOLcZAiHjfUq9N+WehykuTbNZuZUBxAfzZf/5U/HPyanpehsKs/q3ry7U1Ut1FGexeaY1On3KFN3lT39wpA==
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:332::19)
 by AS8P250MB0166.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:375::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Sat, 16 Aug
 2025 08:54:06 +0000
Received: from DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1]) by DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 ([fe80::af97:29c5:7cd5:4af1%7]) with mapi id 15.20.9031.012; Sat, 16 Aug 2025
 08:54:06 +0000
Date: Sat, 16 Aug 2025 10:53:59 +0200
From: =?ISO-8859-15?Q?Matthias_A=DFhauer?= <mha1993@live.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>, 
    Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
    Phillip Wood <phillip.wood123@gmail.com>, 
    Eli Schwartz <eschwartz@gentoo.org>, 
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
    Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, 
    Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
    Ben Knoble <ben.knoble@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v2 09/17] Do support Windows again after requiring Rust
In-Reply-To: <xmqq349sntms.fsf@gitster.g>
Message-ID:
 <DB9P250MB0692F39EA259A4B31845C6B2A537A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com> <96041a10d545e0e431d05b93544771c6bdfc06f1.1755220973.git.gitgitgadget@gmail.com> <DB9P250MB0692900F30A3E71E4F01DFFFA534A@DB9P250MB0692.EURP250.PROD.OUTLOOK.COM>
 <xmqq349sntms.fsf@gitster.g>
Content-Type: multipart/mixed; boundary="770480705-15427-1755334445=:17988"
X-ClientProxiedBy: FR0P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::12) To DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:332::19)
X-Microsoft-Original-Message-ID:
 <7609d93a-592d-4a92-92ff-9f767bc11fe4@live.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P250MB0692:EE_|AS8P250MB0166:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c9bcd84-93a3-49c6-1c5a-08dddca274e7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799015|5072599009|23021999003|15080799012|19110799012|461199028|40105399003|440099028|3412199025|10035399007|26104999006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3plOHpiSEZyaHg4MnlDYmltdDM5bU5NRzZOQTY1anlKWSt5YWVJTUFDbXk3?=
 =?utf-8?B?Zkowd1A2N3R5eWlSTUZEU3pGS3BEWEZZTHU4dmNRUGZYTURiQjYvSGg1Y2Fy?=
 =?utf-8?B?YnVrZ3REZUUzSUhWVVNlZUZXd2RwMllJaFpkVTE2M3FSUDloditOZU5vdG9J?=
 =?utf-8?B?Q3JQVDZwNC9jaEtNdHN5MVExakZvUjNEV3FSelVncjVRSFdzTHpNRDY4ZUxr?=
 =?utf-8?B?OHpLYkY0YkZmNXRFeXVWL3d0eENSOHZOUWljUTEwVi9FaEhPeklZckV5Yk5F?=
 =?utf-8?B?d0ZXNEJHNUlKS2F5ZHBWRmhxNC9BSjBsaCtwQnFIeUdyanNjZGxQQjhiNElF?=
 =?utf-8?B?ZXRYVmxVNE0rd044VEpJSzZQVG5CQ1FXUlJ1cGRkbDM0VDNIdUltYzMybGJY?=
 =?utf-8?B?VnlNVTVQaEtqV1BseW9WWkE2NU4xMEJSWjVaQWNuaVE2NFFZZnFSeCtmbmJa?=
 =?utf-8?B?c3QwSjVDdDRxRUpqbWFDb2NUT1BrY3FXNjF4L2hxVHplMlRrbHRRVkpXcE81?=
 =?utf-8?B?YzRneXU0QTl3Zjh4UW5TRXA5RUozUkNTb3VqcFJid05SWTdEWWxjR2dPQ3dh?=
 =?utf-8?B?MUMyT2lxUTBrNzNaSG96UldJeFVGOWdpZjdBcFFJVHB0SWlsazZJWGpjcGVG?=
 =?utf-8?B?WnNpNzg4cTF5eE5IYmhoSjcwM0h2MEdtdkJKa0FLK2dxcFAzVDVYOWlNNTQ3?=
 =?utf-8?B?bHEzajhPeTlxb1FNeWdvdUxLazF0YmM1d29DV05LazV0QkxyNUo2MlBYUldo?=
 =?utf-8?B?eXdKaTI5bkZ0QTBuSDIwWlJiMGdNaHIrLzBpSk51UG54TlhCR2Vvb05Tajc5?=
 =?utf-8?B?eVBpbmQ4REcydmR1L3VoV1FNTXZ5WjdjVDNHYktWa3d5NEh0cSsvelNvRkdE?=
 =?utf-8?B?ZUNDQTN6L3oyczN1d1pMZGY5bjJReTlkL2g5Qys0UVUxeDcwMlBWbWJxbXRS?=
 =?utf-8?B?ZUthMmNBNUg2THkwUVVkdUszTDIvOEh5WTBPeVl3NjR3dXpkdDljZzZSenB4?=
 =?utf-8?B?NzQ2bUxhOWVXaEtlL0w3UisvZ1VzZzl6N082TVcyeHdXOGNaRjJVd29TbDd4?=
 =?utf-8?B?NThEWURzcGZxNWlkMTArSmFwckpWVEZDVWV5V3JtMlBwRjY1bWpHV2krTXdq?=
 =?utf-8?B?SENncjR1WVQ0YkRueC9QUDAyemtQNjdyeURKV2lMeGc3akMxei95eFpSOGth?=
 =?utf-8?B?ZjVieXFWZHU3MG1sMWhMSjgvYzJ4aldUZVJ2MVZPc0VIcjA1a05Qem1SSmZk?=
 =?utf-8?B?UXAyUVQxRzRNczZnK3IxMmZZYkJPYjdGbmM3RVpwd0k2L25PZzRqRi94dlVn?=
 =?utf-8?B?YVZka3lSR2RvdUZtcmRvL3RVRmpCL1V2ZUhBcFRPK0ZDL3JlUDIxSXRlT3Vj?=
 =?utf-8?B?SjRzUHpJL1JhT1N6ZkhQLzJSYVFkYytEeFN1NFlHZEkwL3lMemFqT0YyVmNK?=
 =?utf-8?B?aGlwQ0hJUCs0T2ZuNUh4eUp0LzZFL0djcncxSk1zQkJ5Y3lkaXNiWVRwWmtQ?=
 =?utf-8?B?d2NOQnVKS3dhaHpta0RWUHo5VFNwRVBiV29kM0dTYU9GbDJRcW11SHp5Zlgw?=
 =?utf-8?B?YUVxTEZiWmtxRG1YODRETVRKK1o5UHFZS25TY093RHdGK0FyQ20yWmNqWTZR?=
 =?utf-8?B?ck54S1lBU1UyNm51eUtpVFZxV0ZLd1E9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUgrcGtKNXE4QXR4bXYxd29DSkVua3l1NURLRzlBUlFpd0U3SnVETHB3cGVs?=
 =?utf-8?B?L1BJZ09FVUljMHpUemxNdzVLMDhqMjRzanVmcFphcENCOGpBVkFwVGJoSEhu?=
 =?utf-8?B?Z0FmTVdSSzhhNlFIS05mQW5IUnNKTGsrMmczQTdDb1BzMUNuNks3RE1WbDN1?=
 =?utf-8?B?ekVUNHU3ODE4NzBIakprR0dudEdzYjloMFdiaWlpSkthSW1OYnJ0QWVCQ0JO?=
 =?utf-8?B?ZUdNRGViK3pwWHVjVCtFK0NsYUcxcDVQZjFqRm9yckhxOS8xK2xLYUhzY24r?=
 =?utf-8?B?NWM4ZW1kTUt4R0doT09MLy9oS3lFRmpLVHkrMS9CWU52T015aktJanhTd3lu?=
 =?utf-8?B?V2dvcFRibW9XNitMekNPOGxTWGJFQVJnUnhjYlNIYkJpZVdiRzhyV0dBbWp4?=
 =?utf-8?B?dlRXaTVLdzFlZzRxNlQ3aVBDYjhwL2x3YjNKT2RBbHluRzY1UzZFVmgvRHBU?=
 =?utf-8?B?a1RBUFBVWHdnUmg1L0pFOHFDZDFFUTEvOW1uM3Y4WW5ndU9xQUdLQUh1d2c2?=
 =?utf-8?B?SGY5UVJFL2tZTW5xY0w0bldVZE5wSVpIckVjQi92VmRsQy9QMGdCS251S1Rh?=
 =?utf-8?B?VzJ5MUJXT2pmS0lZV3BMSDg5Z3ZPNWRBc0tkbnU0cUdldXkvS0pQN3dGT2h5?=
 =?utf-8?B?OEZ0YkxNVFVpc0RhWndwa3ZYVm1icWxabmZWWXJrcytEeFZ5VTJ2NjhUY0VD?=
 =?utf-8?B?Y2lRaG1XenRLYnBrU1hud3JJalNDaHJ6NEt5U041ejRsakdNRVNORFpUbFFU?=
 =?utf-8?B?WGxWeEJ6bTFRTENEbW9ISGJSUlRxQ1BIcEs1TjBYYXlXV24zWVVmTDBVVW1t?=
 =?utf-8?B?SWQyTFNNcVBKR0hxUTM1ajc4bzJLTWQxNHI5cEJYejFlT2NGbTkvb20ySlJZ?=
 =?utf-8?B?Y0xGYjFtRWM1SzdXRnhQV0xQMkJpUzBJQXhvYVNjVC85eGtqVHlpTVJPVmZ1?=
 =?utf-8?B?eDcwT0FVVDZheCtaOHBHbHhJR3hOOFVqc3kzcDJPdHYrbThaSTk4UE0vVmRi?=
 =?utf-8?B?ZlBEUmh6OVNBRGNVclV0K1FGY3pnNVhoYUtHeG5TVVdhMy9QQVRia0U4Y3J6?=
 =?utf-8?B?MUZHdWRUTE9WaUpNTXV0Y1F2dHRmYk9CSFlpQW05VTZlNmg4c0NOSHpWSXdu?=
 =?utf-8?B?amtodEx5emEyaXhkTmZxMXNqT1M0N1VJZUVIZExxYWZ3RkpvdmkxQlJwK2RH?=
 =?utf-8?B?Y2ZRMUIvTXZjUVpXeG9UK2JyNHNlLzhQcjloUk5uTEc1MHRyNU80T1RpTXk4?=
 =?utf-8?B?ekZxckwzdDlZODM0NkxqOTRiUlNURG5rcWt5Rm5pdTMvbjhnY3FCNWFHTDBE?=
 =?utf-8?B?SE5tTlJrUEVoazdmM2g4UDY5ZTRqc2FBREJUT0F5Y1pVZkxJZzNjeWtnd050?=
 =?utf-8?B?ODdCUGUxM2QzWmo3dkdTVkhkTmRsRWpxcEFqQURCaWRjMWdaZGJCZ3ZQQVdr?=
 =?utf-8?B?R0g4RC9uVnVlOVVpbkRFWk1iM21wcVVFdE9yNU45MTM3aEgxS1l5NEFOdHlZ?=
 =?utf-8?B?ZE1rVXJsSk5MNGVHemZya0NuaXhOYTBMUWxLeVl2NzRNTFB2eVNvQzFXaXpG?=
 =?utf-8?B?ZHFPN0d0YysvSGJ3NHA1YlVjdC9SVDJkWUZWN29obHl4eXppSXVheVJzY0Jp?=
 =?utf-8?Q?H0zDbVu+m/djfFHu6Noj4R1KCxVe5z+HH2evOrUfI8Wo=3D?=
X-OriginatorOrg: sct-15-20-8534-15-msonline-outlook-5f066.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9bcd84-93a3-49c6-1c5a-08dddca274e7
X-MS-Exchange-CrossTenant-AuthSource: DB9P250MB0692.EURP250.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 08:54:06.5697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P250MB0166

--770480705-15427-1755334445=:17988
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT



On Fri, 15 Aug 2025, Junio C Hamano wrote:

> Matthias Aßhauer <mha1993@live.de> writes:
>
>>>         ifeq (MINGW64,$(MSYSTEM))
>>> 		prefix = /mingw64
>>> 		HOST_CPU = x86_64
>>> 		BASIC_LDFLAGS += -Wl,--pic-executable,-e,mainCRTStartup
>>> +		CARGO_BUILD_TARGET = x86_64-pc-windows-gnu
>>
>> I've said it when Johannes originally sent this patch[1], but it bears
>> repeating: The *-pc-windows-gnu targets will pass CI, but would mean
>> raising the required Windows version from 8.1 to 10. We'd want to use
>> the *-win7-windows-gnu targets[2] to keep Windows 8.1 supported.
>
> It seems that Dscho did not respond on the list to your initial
> objection in the discussion you cited.

He didn't, but from various interactions surrounding Git for Windows, I do 
think he's currently in favour of keeping Windows 8.1 supported in Git for 
Windows.

> I do not think we spell out which releases of various platforms are
> still supported by us (we do list requirements for platforms in the
> Platform Support Policy document, though),

We don't do that in git.git, no. Git for Windows very explicitly spells 
out which versions of Windows are supported (though usually we just 
mention the Desktop versions and imply the corresponding Windows Server 
versions). Since 2.47.0 that is Windows 8.1 and newer Desktop releases [1] 
(Windows 11 on ARM64). We even tend to announce in advance when we intend 
to drop support for a Windows version.

[1] 
https://gitforwindows.org/faq.html#which-versions-of-windows-are-supported

> but in general we should not be attempting to give extended support to
> systems that the vendor no longer supports.  As Windows 8.1 is no longer
> supported by Microsoft since Jan 2023, and Windows 10 will go out of
> support in a few month after Oct 2025, if I am reading the table correctly,

Git for Windows has historically supported Windows Versions beyond this 
date.

* XP was supported for 2 years beyond the official extended EOL. [1][2]
* Vista was supported for 5 years beyond the official extended EOL [1][3]
* 7 was supported for 4 years beyond the official extended EOL [1][4]
* 8 was supported for 8 years beyond the official extended EOL [1][5]

git.git has historically roughly followed Git for Windows in this.

You're reading the tables correctly, but there are so called LTSC releases 
of Windows 10 with support until 2026/2029. [6]

[2] https://learn.microsoft.com/en-us/lifecycle/products/windows-xp
[3] https://learn.microsoft.com/en-us/lifecycle/products/windows-vista
[4] https://learn.microsoft.com/en-us/lifecycle/products/windows-7
[5] https://learn.microsoft.com/en-us/lifecycle/products/windows-8
[6] 
https://learn.microsoft.com/en-us/windows/whats-new/ltsc/whats-new-windows-10-2021#lifecycle

> so as long as we document our intention of dropping a commercial system
> that is no longer supported by its vender clearly, I do not mind the
> above that discards 8.1 [*].

I'm not completely opposed, but I do think it should be a concious 
decision and not an unintended side effect of some change that our CI
didn't catch.

Best regards

Matthias
--770480705-15427-1755334445=:17988--
