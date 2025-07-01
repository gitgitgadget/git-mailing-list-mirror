Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010004.outbound.protection.outlook.com [52.103.68.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE7327F72D
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751389330; cv=fail; b=q69+DVYA6/+9SOaT3OlQD69IJb2BY1G6EqqkVB86Bl92z7wqJKpqoOUy202jl3dY3AfbYWNV5AX0/km8Jkjb1rhAyP+ye6UU/8f1FH+YaVLlMoz0EAIK04CYwmkV0GbTJnQoRHGubj6ZCtyH01/jsDnboEX/axu6uGdcD2xFpT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751389330; c=relaxed/simple;
	bh=xmxe+jaOaChqxwPoXCWBpDZg8vTgIAe/cPRjmqOptYI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kRstLcBR+0rhOLXnwbmCB+/0uO6lAfk23FymMmLwdUlbTN2kPG9UjfsgW6LzLIkUCOI5Ru8xvfepY/mvrKTw2oj0S7uOn0nvsnDelFV+P8ol8sWOfMNDd6r2qlQTYUunvkZZx57Y3xT7RL63yApX9zDyFI1LMuLK4pHL7qt61Zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=f9sP84OT; arc=fail smtp.client-ip=52.103.68.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="f9sP84OT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmi2FgiBwTFS/fZ1uQb2hw0r2GlaUG71hVN0Q2ld0UytNVvxIqmf2DpYe3Zy+oXZ7ANCwAxTh6Ah0sParXPUiJblU4yfpu6zYuJLwbHPxAAYnRZ5PZ9oMIzoucRuVozyZh5MtxgB/tZrWSGH788flk3hvwR1Lkp1TDxhPZadnmeNs2K4hPWkBrZ5nftzJTBJEbncZ12JmOKxPG+yS0XFtN0ydN5rcKNsbTGf2+Vo0H+WdsF0ECYyNXnihVOxwfmnOOa4XeRY1KaaXC8Q141UV0RQysVfxpQvVxP2lR55CVIEDRh+OeZe9CS0rLOsw7aaq4oOMGL048KEvePsoEx6LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV4Xip10Z5pKyE56D7DQKy/Dsr3ydncuhqdkyFXj4qs=;
 b=dI7sTSTs7QId6UrbESbH7UxFj95YVairI297PKmBWlVofT+Ffgytsjq6f5Fsk/ea4DTe2lrxbH/mwFWOJn/CvLAGI8A2FeTypm+ef2xzPU98d/sgUmQbK+53tAJsyuSUZpl03Mngz5cp6f8kgpQ5pAhiLtskXidqNUqWwdjEewOfhHMef7A4Mmn3Wt5BBnXScjEsWqpanM9Tlf3N3viwVtNur//x0IKb4Erf+MIQ6+t1av43qgEkdpHboBVhkDvj4O7rVePvbyXTSBBNT0yPHdqZ52s5S+Wwhs46w5Lqzo9/tO+7y59B4qPlxPTckIcl4rU8s9zjJg3In3rPSiHnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV4Xip10Z5pKyE56D7DQKy/Dsr3ydncuhqdkyFXj4qs=;
 b=f9sP84OTcA6udk36lHT0HpNrhNCKJ2Bq34ye58/s2Upuuv4QL+/qoi3tB/pLJ9P4oM+ODZKBD9Or0M9DlsgNbKaBg59amqxkND0ioloQHIQH4MVnB2eOt1y9WswDnnAmxmyi/oG3Ufin5Rr+gNM65p1/8i8a9zqhYPTOowMvSZr74uFFNR8WSIVDEn4sSnAJWFKnGeVw1vA5GwDMZUkI+RuT6ePZdA/YnAmoPGCUK1l0BaG7i4diOKYEfmpQGwxU0SjPd3Q7fwws606fHhhncl5jiQGQ560z17eYER1BMH68Z+Ji6SmGdS4FCTNHRSRCw/x+n/BZ+5k1OOHmah9+7Q==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB7035.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:1f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 17:02:04 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%3]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 17:02:04 +0000
Message-ID:
 <PN3PR01MB9597212E1B2DA1CDE5A57909B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 1 Jul 2025 22:32:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Why git on windows pops up Git Credential Manager inspite of
 having set a credential helper in .gitconfig
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 "git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959737CFDDC39898364CBE34B841A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aGQT-svTIIgXdb6X@fruit.crustytoothpaste.net>
Content-Language: en-US
From: Aditya Garg <gargaditya08@live.com>
In-Reply-To: <aGQT-svTIIgXdb6X@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::14) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <8f9304f5-3df7-4a92-b2db-0f2382bcca84@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 80296c7e-594c-418c-7a7d-08ddb8c100eb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|461199028|6090799003|15080799009|19110799006|7092599006|440099028|3412199025|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG9ac05XYS8vd3dxTEVBSmhjWUdXNWtUd2wzS3Eyd25pVWRmaW9CRGdGem90?=
 =?utf-8?B?Q2Nqdkx5TGpMKys4WWFrZG9FTDUrOWpQYjM3NzF2ckN4Mm8yZnRwTjErKzQr?=
 =?utf-8?B?TzFtelBGb3QraVAwSk9CK0VsVlR4SjdXSW44aDFybnJndDFKcEhVUDgySTEy?=
 =?utf-8?B?dlZ2aFVBY2pSblJKb1MzRXRuTXNJdjFDMWFPOC9JQjlCMkpEZm41SHovY2hi?=
 =?utf-8?B?NmtiMzB5bCs2d3ZTUzZzYjNGaHVPU091OWJ2V2JjM0JkNlRZQjE3OFFtSmc1?=
 =?utf-8?B?S3VrbTllY0Vlb2lrNzhDdzRORi9JRTNRVUkwUnNPaFlBN050T0VOaXVjbjZF?=
 =?utf-8?B?UDVzL1hwSnBLdjhxWTBzUXNTVVVscDJCbWswYlY3VGlwVFBaaGRPZ2R0bGRR?=
 =?utf-8?B?SWdwdFBNWHZjTEtENHVncU1WdllLN1MwNEMvWjFteW1Td25VU2ZsdnVHWTRN?=
 =?utf-8?B?YjI0YktObmZXc1NaMDNHZ28vVStoQjZNaVl5V25yMEJXa0NyKzdxTjFmVnBF?=
 =?utf-8?B?MWtjS3JVRGV5dEVWTnhmeEIyeFM4dmVvUXFLOEVKQUJ6Z2hjVlM1TGZTUFRG?=
 =?utf-8?B?emVseU9xV3gvVE1KcE1TYkVibXJJWjg0WDFtY1ZMVEVRWlhWeHphTXdTNmhU?=
 =?utf-8?B?SHQ5MnJZMUhrRWd3aCtvL2NZaCtnRzNWQUI5U2o5b0huRk1ZdCtVWHVYdEVE?=
 =?utf-8?B?Mnl2b1Z6Z0tMMHFZK3FaMW80REFoYmN2RkxjdTZFSjNrTGJRWjYzUU0zK2pW?=
 =?utf-8?B?R1pOTHc2TDNwb1QrcVlDaEhMQkZYNjhmditIWlBNOVFnZG5TeWZEZ3QvbmhB?=
 =?utf-8?B?N1RVTzk5ZEhkaW9GejN4VUgrbXVQODNPNE80VnhuZnFOZnYwbnJjTGxpUElN?=
 =?utf-8?B?TU1Vdkk0Z3ZRWEQ2Vjl6QXhYdkw3aGxmdHRJR21rQW9mZHpVYWgvT1MzdW9O?=
 =?utf-8?B?YXZjNHJuR1VOVE44NGxtZFlQMEdyV2hzQ1pNR3RYQWZpczZXTS96RjhrM21M?=
 =?utf-8?B?VndBbmt5N3BWT2tjM2IwZU54ZVZlWldmM1F5SVpSeU1QTDZIWWJJeGVLL04w?=
 =?utf-8?B?Q1BCc2lRbEJGMWYvaUErMHh5V2dGdUJiNXN4R2w2U1c0MHg4NnMxbHdyVzEv?=
 =?utf-8?B?WUszcXhXbExuQ01MbXo1aHh2NmlMZ0ZCY0pSc2JnK2tpSklvSVhKV0VMQzFn?=
 =?utf-8?B?Y3FUK2htQm9TMzh0cnYrZEEzS1pTcVBWSkJtcGxhOG1TbXZhNnZDaEZ3Z0Yy?=
 =?utf-8?B?Znh4aXF5TDlDK2owSTNWbERZRExWSFdDMlVMSUVEV2p0R0lRbUxnTU5jVCtY?=
 =?utf-8?B?RldISlJvVFhnandzOUl1ME43V3FDYzE1ZDZicVNjTFRvU2h2NFRhUFV6dTJ5?=
 =?utf-8?B?UjQzUjZmK1c5WGpWZHdtV3FiUnVBNnlVTGtyUkVYemV1LzJiUXBKcVBHakpH?=
 =?utf-8?B?aitnVjNJa25EL2Y2WXNoaTZmbEFvZEdCdjRrR0NxUjA0dk82a05mZEE5RXZE?=
 =?utf-8?B?c0tOcEI5eW1mbWVnMzVjZTVuWWxDZkdHUkFoTWE3TGt3bFFPLzBjeXlhSDF5?=
 =?utf-8?Q?RQhV8I5SfgsiQW8+26rKw9cZ8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXRiKzFrVU1iTmhEa1h3L2YzRHVNTHFzeTdWMjBwdEx5NjRTeW0yU3BSZlda?=
 =?utf-8?B?ZG05YVptSS9waEpCem1NQy9iZ082S1Z3SWoxWWZ3NUlrOXZkb1d6aTc5UnZ3?=
 =?utf-8?B?Mm5sSlkrZWJkOUJ5OXpQU1VXeFJSZlBqQ1p6V1ZQUTdOQUgrdmRWczcrNHd5?=
 =?utf-8?B?VzNQY3luTlhtOGZaVXJtSzZhRU5Gd1d3WnUraUo0WDNQRTZnREJtRXNibDRk?=
 =?utf-8?B?M2taRGtUZHZoRlp1STVFWkhhd0VmY3AvM3FtSCs5UGw5cktrK0MvenNpMlJw?=
 =?utf-8?B?ZVk4Q3k3U1Rsc0hlUXY4OFJhdmE1VmRzc1AvaldUeTFXZHJQejJhc01pNnky?=
 =?utf-8?B?eFdaY0M3TnlEQzdpWXFrSHUvSENCNzk2eGRFNjhuRmhoUW1hZzZDejUrSzR2?=
 =?utf-8?B?UExyWHB4M0lIcW5iN3YrZkN5cHl2NWdiR0ZsYnBQbGgzTTVLSWF2S1JEcEZC?=
 =?utf-8?B?SVJCUTFEeWN6Nmx1WU5pZ0tzSFloQUlVdGxkNE5xaEVlVnpPdEE1Rmc3cjYw?=
 =?utf-8?B?eXo3Um9QZC96Rm5JTEF0M1p5b01jUmtoNk5QelljOHBvbVE2cDMvNUIyaGRv?=
 =?utf-8?B?RDBsaG03bDJJck1CNlE5bk9SVjVjZjJOcWtOeVc4RFcxNjgwZVh1WHd1U2pk?=
 =?utf-8?B?TmNoeE0rMlcza094TTVnSjFyMlhxSVhQRGFwRHZFN0h5YXNZTnBLbEY2K201?=
 =?utf-8?B?Ni90WDhqYlpVZHRvWDAreVRBdjVqSzJtY25mWnZ5eHk4dzRZejJjckxlYTdN?=
 =?utf-8?B?U0RLVEQrU2VqUi9QQTN5bGlaTjkwUkhSNGtNakR2WFk4bzBKWS9lNkFrL1Qr?=
 =?utf-8?B?YWxkV1QyOHpJUXRlanY0NitmRFpRb05mMVVuNnRJTVc5MmhDbWVxNFZxdDd0?=
 =?utf-8?B?K2dVUGhTcldza0wxWm16WUVhb29ObGJ2NERVVlBVbmJjYUhiOFJoajQzUFBR?=
 =?utf-8?B?UVMrUUt3MGJSUFI5ZEl5MkFsUzZ1dEZKVGdESDlYNXRqRmRrYWVLUWh5MlJv?=
 =?utf-8?B?QmVlNnhzK3NTTXU5WFRaQWZ2Y3AyK2pGM20yOXp5SDFpVUxBY203M1ZES2RJ?=
 =?utf-8?B?WDRlaXc4YlJpWmJDNjJHUWFjb2xLMUhkV09PbjJwcG5Db25scFNQd0Z2ZVV5?=
 =?utf-8?B?Vi9GbldtUjBlMXlrUHVTbzU5SXpyNWhPOVZvMlJSSmxoM1N2Kzk5aFY4Qmhq?=
 =?utf-8?B?ZHVsRjMxUXJWcHdiZzkrbkp2U21aVkdPemViQ1cyc3ZTRnVlVE1CeS9CRnlK?=
 =?utf-8?B?ME5LZVYwaEhuRkRyYVYyR1NRREZyRFd6eW8xeXo1QXVvdXM0Mi9iNzc4ZXY2?=
 =?utf-8?B?RTFFbGlZdnZsWmlweUlDN2I4cjkxREtqOVRpblJBSlh4aGxQZG9iL0poY2lk?=
 =?utf-8?B?SEx3elRLV09QUmVHVVg1SWwzSEZzV1hZaFZUYk1HbjdYWnJiN2FXa3NnNVly?=
 =?utf-8?B?ZGQ2UVpwcy9iZ1VJL2RFZnFUYStwdjZaZWdqY2F2ZjRGNEZoWEMwZytOd3R3?=
 =?utf-8?B?RC9YOXp0dG96dGY5bzllOFN1ckgvZ3d6RDd2VUlNdXlKL1hkODVQUWw1SFl0?=
 =?utf-8?B?VkJMOVc4emU3SDVHYThYUmFDbGhSeXVPN09tNEl2ZVJ1T1c0L1FPZmQvYzVM?=
 =?utf-8?B?Q3I4a0p0ZWQ1VjhWQitjQnhnZk54TllpVE5kQ1hBRk15VENVa1poQ25FZnhq?=
 =?utf-8?B?T21aTjI5N0NvVXhFQmhWTFdVdzcwQVZhN2ZXWGRUczUwRkpWZU4zUWNPRzJk?=
 =?utf-8?Q?BsMdXZxpRRRhYV3kpS/XbM0w+kP0Jki0pUX4MwP?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 80296c7e-594c-418c-7a7d-08ddb8c100eb
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 17:02:04.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB7035


 
> If you can't or don't want to reinstall Git for Windows to reconfigure
> it, you could try setting the `credential.helper` option to an empty
> string and then configuring the helper you want.  For instance, it might
> look like this (not valid for Windows, just an example):
> 
>     [credential]
>         helper =
>         helper = libsecret
> 

That's exactly what I did, and it fixed my issue. Thanks!

> The empty string resets the list to remove any existing helpers and then
> you can append whatever values you want (in my case, libsecret, but
> again, that almost certainly does not work on Windows).

