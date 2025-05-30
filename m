Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2FD17A2F5
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611941; cv=fail; b=i87fKQDONNWOiHydJcFpkQV9zCDu2/+UUsszRC8vizKGsRE2KyAJLZf2sePh63k2RN7o+r/FsTPpiXpxvCPUX1iScZOs8wM0rvTVCEkR8LM6KLf05flsNlm9VBPkBxutDIiqCT2nj+iUj+1spn39pSi2NET7QoIA5aJHaEsTHwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611941; c=relaxed/simple;
	bh=0uhuyx7QNDKId3bHErEeHC/zHfiuBUGFvJgNy9co4NE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N7utvtmdx/SaQgxuAwnXJxXrGkV6YwVZlUoCS/deRrucZsz5VVlpPQ5rcakSSuBEPK+Na0njMLJsOQCivKo4kFgmDPVD40IzwtT8XxkCo9bOTWTNk9+AmJdkH+po1bYKq3rtxq7QS2mrucER7jG/6vJirmtw7Z4Tb8SwXEE8MoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=RsQ5Ssl3; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="RsQ5Ssl3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GE9L+TpgW2rgi2ArMGNK+/jdHXxA3delOO3VGJMoujjcoAz+ApUZSBYAUdsC1ZCQAW7jIEAcECVZVLqRAXicOi1RMn2jWQTHGY80c9rnvPzeJjwk+Su/hJ1t1ouTVypCdaVzaMMLnkvU6CGwLQdskq3NiUHS7wKM7x8QeF9TDE010ADRZM5IU6D51CKHFHS9vQqNy2iD7fvhuIPMw7XOpg2y8MQ0mPcyDaBZxuTPGABjkTi4Smpsbp0Vycygd2r+IU/GHOTmvQEfRKnnLx0Wm2zcAYHYzbnIGNEG3neFi55nY6JoJUPySXheJG3MlK41vsy91vhOe+dwbCRnpV0hjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uhuyx7QNDKId3bHErEeHC/zHfiuBUGFvJgNy9co4NE=;
 b=fY2YFFmAEpue2w6qKndwA3lJ3OFYN07LC7nDjUjOPfXKyrGoKUBADOs1n0Wq20MReSNha4JYmsBsck16ORw2PMwCEtR/jaes8udJJOSIdAOKwXexStKISctlqUoGRBbB01RLKKqG+wtazhhuA/D/ohB6MnCA28ToNigDrgbiVODD3ROH7YarHh9DUHphcV85rg71yJvaxDMBNr5K7QPqNlMhLy4qLJ58UqpbB2VYjKNCZ1kKR4xypnAHkOXIl9Ixt0BGwsEtVEUUnKPbqKczWXo8F3MyJcKmzET1oCLyOjoCB/0bunMlSNzoUSYbLP+rocspT3vfJ6MxhUbb3CZKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uhuyx7QNDKId3bHErEeHC/zHfiuBUGFvJgNy9co4NE=;
 b=RsQ5Ssl3DQTY/mqkPRsgHPc/11ExQ+bPzmAJLhLlnL1KW2Y/VkL2eCWX5ZBKUEQzBYEp/AkMhYiQXVMe2EPoHUZwTbuvJCGqD+FgR9St0obvVx+IoWTFG30Na5sGJaVsnwXJtpXJxV55BmbcIPXLWjIfCUJ+dop5MgC0OEP/4RA8sqNRv8ekkSPMJbBuxiAXeyJjdKsVvLDQX/p1ddANgIrfUAApxDyGVMAGyGZHuzeDi/YaDj5BF6Zr2fUyfz2UI3FLBuSnIhEmuewKjR8m+CtM4Y3Ee2ZNmo5FRYxbrMylWh9cVpdRvFRefr4y3YPR/0AceBYoiN/76epjmoDi9A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB8874.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 13:32:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 13:32:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Julian Swagemakers
	<julian@swagemakers.org>, Eric Sunshine <sunshine@sunshineco.com>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Topic: [PATCH v5 2/4] docs: improve formatting in git-send-email
 documentation
Thread-Index: AQHbz57oJD/WCXZ7hECPdkjcTXR6SbPp7EDLgAANoD2AATRLa4AAARmA
Date: Fri, 30 May 2025 13:32:14 +0000
Message-ID:
 <PN3PR01MB9597DEE8C41CB1599B9A97CEB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250528070521.17379-1-gargaditya08@live.com>
	<20250528070521.17379-3-gargaditya08@live.com>	<xmqqa56vl1uq.fsf@gitster.g>
	<PN3PR01MB9597008B30AB91C9539E7C8CB866A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <877c1yb53w.fsf@gitster.g>
In-Reply-To: <877c1yb53w.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB8874:EE_
x-ms-office365-filtering-correlation-id: 6fd2fa63-c5e2-43c9-19eb-08dd9f7e63ca
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnwmZzwIq5gaHG+sgfX+OHB4UK71xPnLCIHOssBDvr11IX1iClt6bkVW+dGnhZTC6W9P2WyC8tO+IHB+xykCMoJXQ/eOG/R/0dUCppS4nxWhfLN5Xyla20+O5R9pKW2bFquuE2clrd0ZN5J0VGwJqdO3P94ZGrrXvcaxOYwXPmo7k1hLVOi2afBIJsn384HzOkQI4fXshZkBRv1iyZQKnq5N6zBUo6sO3F5gF9p9Gj/rhFd2hM/+Lft24JY+Cr++4B84Rp/WQfJDKPH9G1x4W9FUtIqlzm354fmF/qUQsT1aFM8lvSvf0H5SX2bqiAxPj62zyt0VQWHquozmlOTqunkCRWJZB1GyjLIGg2+ZM2GGwcThuqcaMFzwqeEf9vOa4BJHvF0wfJCJ7Pon1gHFlcuEKkegdxJaVxLO2dFhfJnhwuEsiHS/OmF0VWFW+w0LJvsLHETQBrG49GwUqDQKDkprwHrrjabiQ460ijWJKHzHneGFNP29xTuW8Siu+vgSshFJfeY005LacpBaZZHCS7I9HnNPuk9DsmsH4ijTNTFGHUOrznaJmWaNu1DjQtHEpTQAAwsc9EdS3VWJddVg0g++K6YRRBmXuGSHXOaYloCe8mHU0LNaZATYL1FOtl5iXsNiYImsYksX66EJ+/U1IxvWDtg+B4fFuV4eL/0apr4zne4e4rdAcEqCx0Uh2eyh0JUmADPwoeBRFOJJ71QVzcbsxKgGBOoGgNYXgPPQ/Dz/A=
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|461199028|19110799006|15080799009|7092599006|8060799009|8062599006|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3VuVkxKakdoa1k2YlIvM0h0bDB5Wm5IVEV3c3Yya3YyVC84NkNHWkVrdHA0?=
 =?utf-8?B?ak1Uam9hT0h2M05KMEVWblNKZHN0ODEwUU4wYXhjcFFvejJxUnVZcHZIbTRC?=
 =?utf-8?B?bWZ5b3plTFgramZ2UVlQc0pWRHE5VncwejlrazhIQ0lvRlhTV3ZFZXZJT3VO?=
 =?utf-8?B?R2RZQzFCRG9ZVHdreVI5L0w1NUdMRGhrcEZ6ZGZMSXdyMCtjTHRHY0V1aUk4?=
 =?utf-8?B?d3VITEgzUHlnNnVxS1FhQUFrM2pqZUpsdnQ5SHpabDBUVmRDTVd0NWlkcU44?=
 =?utf-8?B?QU1DR1FvUkwyanV1Mk5aM25BbFhzV0pReFJ6S0dzblZWdXRySGl4aUJTeXM5?=
 =?utf-8?B?eHc3WnBXQVBBVjFSc24vSmtiR1pCY2dpVGN5aVhLUjZHTlp1cysrY282UWVS?=
 =?utf-8?B?ZWVoSElqdkY1L0xNZ25hSHFBOUhLQkNZUkpsWDA3dTE1bU9hMGlzZEtqak1Z?=
 =?utf-8?B?OFFjM0k5eHIwc1JDZVBadGdITWcwOE5rcHF2RCsrcHc3KzM0Z09JQm13aHZ5?=
 =?utf-8?B?TzRoeEwrekY5dlRxYkt1Y2dGNnZNUzBZNzc0QzZ6RUFtS3VJcE52TTBDcEhT?=
 =?utf-8?B?SFluTktDYjF2aHN5S00rYnFGTmh3RmhVZ2lnaFRlcHk1aFBURmZ2NG5lY01T?=
 =?utf-8?B?ZWl0ajdqdUU3U1dRWFlMTThsVHJjVHV3ZmZvM053UTlIZy9ISkY0cFA5ZVJ5?=
 =?utf-8?B?blh0VnBTM3ZzUGVkVDFXUzg4MityWGQ3aXZBTEZzWkFzS3ZKYXRWNEh5c3Zu?=
 =?utf-8?B?TW5rYzdDUjBTME5VWkR4cnNFR1ZQUHk2ZmxwRFEwM2xxNElsc2dZRmlXTDBM?=
 =?utf-8?B?a1hYazB1bFNRdXBwTjRYZlV4MkNqNkJteGMzais1MGZqWUtDc3dxdXZueTk0?=
 =?utf-8?B?aitBKzFEL3dUR09SL1RoQTFGZm5sL0srUW5tRy9KbEh2cktoTnVpYjQ5cDNK?=
 =?utf-8?B?aTJ4dDVpdkRzYTBOUkJuc2F6aUloaG1BYnBrdkZlaWVYQVFJY2JKZldKdkhI?=
 =?utf-8?B?ZHdTazU1dWpTVVN3aEx5ZlF2cmxNSkpQanJnbVFsR2FaN0JSaWVSK0dIK0pw?=
 =?utf-8?B?dTFxM2x5K1JqVzhCK2lsTFYvSnBhdW9QSUxYMEdGWFpkOE4vdDlscFFUbDVL?=
 =?utf-8?B?THJHY1ZoVEVMMkNocU1VRWRyOEhWMHlwK3EySUNXSGhuM2RkdE1LaVFhRGpl?=
 =?utf-8?B?WGMrLzdIUkJMWUgzRUp5UEZzMkxqOXNKRjNocFM2WFgrY25SSDRwQ1pZTS9y?=
 =?utf-8?B?QjM0MDEwSXVPUHFqTTY2S1RhblE2UVkzbW42aDlZSCtiUXlKOVViRFU5M2VE?=
 =?utf-8?B?Ums0RndRSm85dHMzN1dWbWhNb2w4ZXlFS1IwU2xTeUFWYzRLZ2NMZ1pCZHRK?=
 =?utf-8?B?QkZ3Vk9qek02WURNRUFoWFY0UHlIN3k0cWlUeHBkTVBVY0Z5VHFlb3pwVTk3?=
 =?utf-8?B?YU5jTXhqSVJjMEZKQWl4ZzNqQlQ3KzYzWW1KRnd0cm1Jb0RrRTlyT3luN2FO?=
 =?utf-8?B?R0srVHVuNjNpSHZ0Z2xmVUxCQS80eXlvVHRFUk9Cb2diVVBSdDZEVzAvWDd3?=
 =?utf-8?B?OENMQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c00yVG1lT0JCNTRUdUU2MUJzeXpOMUV0R1lLVk91YkwxWE04dzB2TlpRUjk0?=
 =?utf-8?B?d1hwWDNJdFpUQ0MxUDhFWDhBTExDQWYwaTUwL0VRanM5VUJaK1d1SUFwL2FQ?=
 =?utf-8?B?UWNaNE9DQXFwS255VG9yaHdRaVkzM0x2VVhFSWFKanFqRlo5N1ZGUmVFU3c3?=
 =?utf-8?B?S3RCbWR1NWYxdVZ5Wm5EbjB6Z25OSysxYm1aems2MDZLbklpdi9lUjhrVWts?=
 =?utf-8?B?T2NIdFcxQ1h5VWxmQmtMZGN6V2lYdHhvS29LMjErT2toWkZkQmpBcHpRMCtz?=
 =?utf-8?B?aXpoK0JkYXJpV0N0bUpiYWtmWjJxQy9pSVltNkhlZFVBQ0JtV0UyTzBlZG1J?=
 =?utf-8?B?aEpsMHZieTNGTGRydEp3UzQyNjlUQmhJY0l4N2NUTkU5QTdPZnRmUHdBd1cx?=
 =?utf-8?B?TEVzcHVKc2cwQktkYy9lY3RJdi8wQ0xmT05DeGlwS3NOTnFXVWcrYUlNTkNz?=
 =?utf-8?B?MXBVZVlHVDNSdWxOWGdxRjhpNHcrVWsvdzk0VUtHNnhudDFEUlBrWllpYzF0?=
 =?utf-8?B?T3NqaVNBTlZLdGgvb1NxRDBCTkxhL1JlV0pqaVYwMDlrRkNqRDBNYWFlSk04?=
 =?utf-8?B?d0twQ0NyZ3dmVnVhMU14YnlNenBUOTEvNkxsZXFsUzE5dGZlcGl5ZC9CWWlz?=
 =?utf-8?B?S21EYU9COGszdTl0Z3ovd3JTRnc5M1dETFJlV1BDU1ZqSFNDNDVsN2FiUFFx?=
 =?utf-8?B?NlRNcXUxakpQUHlGaGlid3B1MVAyUjF1OGdBZHA4WThySFBFV3dQeGxkZnJN?=
 =?utf-8?B?Tkh3SXR6OERtNHN2TGxCd1NnVW5FMWhtR1RmeVhSMXBNU2VzemhhczhkbnlY?=
 =?utf-8?B?WG1JdURiMXJSTUoyWTdnUHJsY1NvVjFMOWNsdEhWUzBOZTNia05ydytVaXlj?=
 =?utf-8?B?TTRQcmJGZjBkblo2UUt3MUQrbVhlaDRJSTFoY0hXcjVKS3Vndktud2lYekdL?=
 =?utf-8?B?RnpzZ0Z3dkY5MjRTcWNhd0xhSVhLQTlXenBPVWZiOVFRTVdMSjJ2bWtrY3pn?=
 =?utf-8?B?alZzQ2Q5VDJtT1JwcCt0Q3JFRkk1QjcwYjNqdnhsV1h1b3hUZytxeVNTZ3FR?=
 =?utf-8?B?VmJJdDVGZEhNNlZKeU9LQnB5Zkd6VEUrZlVNb2h0RzJCZC80bGU5Tm11MVhl?=
 =?utf-8?B?ZTZjVVloak8wcjJmTGxWYWZGNXIva2thQzBiNWFqc2x6dTZPWVN4SnFZS0xK?=
 =?utf-8?B?bWFwZVR6NkNkSzM4aGhCa1JpdERRRWZVNzF2MEZmT2VYVkJlM0JKcThlTzJB?=
 =?utf-8?B?UXpqb3JzamdkS1h4RDBxU3NvZjQwMjREL0VxK29YaGMzNjJJU2R2VDExUHpH?=
 =?utf-8?B?dFJKTDFFNHd4QnNyZldXcEZrcitJOXY3Y1NsdUxFb1drWVNNZzJncWI1RFJl?=
 =?utf-8?B?cEE4SDdVNVdlZzRBZEZiZGpGSlhYV1hzSVRoaTlZOVpCTjhIeHhuN01YcWxU?=
 =?utf-8?B?NEdkc3FzcFNCSkxQeDd4S1pISGhOc09GMExTWG9TMWhWb21EbVRsVG1Qalkw?=
 =?utf-8?B?U2FlUEtXbzQ4eUQ5Yy9SWjRBUkdzNmdmd0dudExOSGtrT2lpN3hUNldTVlY1?=
 =?utf-8?B?eWs5WDc1eUxYdjVTVzEwV015ZTFiYkNZM2hvRTRqNnd6eTMzUDhLM3VvNXhk?=
 =?utf-8?Q?7N4BdbH86mxQPBZXiTO+Yy0KiJ8Ds942gaEFlm02rUnI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fd2fa63-c5e2-43c9-19eb-08dd9f7e63ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 13:32:14.4901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB8874

DQoNCj4gT24gMzAgTWF5IDIwMjUsIGF0IDY6NTjigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+Pj4+IC1XaGVuIGAtLWNvbXBvc2VgIGlzIHVzZWQsIGdp
dCBzZW5kLWVtYWlsIHdpbGwgdXNlIHRoZSBGcm9tLCBUbywgQ2MsIEJjYywNCj4+Pj4gLVN1Ympl
Y3QsIFJlcGx5LVRvLCBhbmQgSW4tUmVwbHktVG8gaGVhZGVycyBzcGVjaWZpZWQgaW4gdGhlIG1l
c3NhZ2UuIElmDQo+Pj4+IC10aGUgYm9keSBvZiB0aGUgbWVzc2FnZSAod2hhdCB5b3UgdHlwZSBh
ZnRlciB0aGUgaGVhZGVycyBhbmQgYSBibGFuaw0KPj4+PiAtbGluZSkgb25seSBjb250YWlucyBi
bGFuayAob3IgR2l0OiBwcmVmaXhlZCkgbGluZXMsIHRoZSBzdW1tYXJ5IHdvbid0IGJlDQo+Pj4+
ICtXaGVuIGAtLWNvbXBvc2VgIGlzIHVzZWQsIGBnaXQgc2VuZC1lbWFpbGAgd2lsbCB1c2UgdGhl
ICdGcm9tJywgJ1RvJywgJ0NjJywNCj4+Pj4gKydCY2MnLCAnU3ViamVjdCcsICdSZXBseS1Ubycs
IGFuZCAnSW4tUmVwbHktVG8nIGhlYWRlcnMgc3BlY2lmaWVkIGluIHRoZQ0KPj4+PiArbWVzc2Fn
ZS4gSWYgdGhlIGJvZHkgb2YgdGhlIG1lc3NhZ2UgKHdoYXQgeW91IHR5cGUgYWZ0ZXIgdGhlIGhl
YWRlcnMgYW5kIGENCj4+Pj4gK2JsYW5rIGxpbmUpIG9ubHkgY29udGFpbnMgYmxhbmsgKG9yIEdp
dDogcHJlZml4ZWQpIGxpbmVzLCB0aGUgc3VtbWFyeSB3b24ndCBiZQ0KPj4+IA0KPj4+IFNob3Vs
ZG4ndCAnR2l0OicgaW4gIm9yIEdpdDogcHJlZml4ZWQiIGJlIG1hcmtlZC11cCBzb21laG93IGFz
IHdlbGw/DQo+Pj4gDQo+Pj4gQXMgdGhlc2UgbWFpbCBoZWFkZXIgbmFtZXMgYXJlIGFsbCBsaXRl
cmFsIHBhcnRzLCBzaG91bGRuJ3QgZWh5IGJlDQo+Pj4gbWFya2VkIHVwIGxpa2UgYFRvYCwgYENj
YCwgZXRjLj8NCj4+IA0KPj4gSSB0aGluayBpdHMgb2sgdG8gbGV0IHRoZXNlIHJlbWFpbiBpbiAn
JywgYW5kIGRldmlhdGUgZnJvbSB0aGUgcnVsZXMgYSBiaXQuDQo+PiBJZiBiYWNrdGlja3MgYXJl
IHVzZWQsIGl0IHdpbGwgYmUgYSBtZXNzIHdoZW4gcmVuZGVyZWQgb24gdGhlIHdlYnNpdGUuDQo+
IA0KPiBJIGRvIG5vdCB0aGluayBJIGFncmVlOyBiZW5kaW5nIHRoZSBydWxlIG9ubHkgYmVjYXVz
ZSB0aGUgZGVuc2l0eSBvZg0KPiBsaXRlcmFscyBpbiBhIHNpbmdsZSBwYXJhZ3JhcGggaXMgdG9v
IGhlYXZ5IGRvZXMgbm90IHNvdW5kIGxpa2UgYQ0KPiBnb29kIGFwcGxpY2F0aW9uIG9mIGEgcnVs
ZS0tLWl0IGlzIGhhcmQgdG8ganVzdGlmeSBzdWNoIGFuDQo+IGV4Y2VwdGlvbi4NCj4gDQo+Pj4+
IC0gICAgYnkgJ2NfcmVoYXNoJywgb3IgYSBzaW5nbGUgZmlsZSBjb250YWluaW5nIG9uZSBvciBt
b3JlIFBFTSBmb3JtYXQNCj4+Pj4gLSAgICBjZXJ0aWZpY2F0ZXMgY29uY2F0ZW5hdGVkIHRvZ2V0
aGVyOiBzZWUgdmVyaWZ5KDEpIC1DQWZpbGUgYW5kDQo+Pj4+IC0gICAgLUNBcGF0aCBmb3IgbW9y
ZSBpbmZvcm1hdGlvbiBvbiB0aGVzZSkuIFNldCBpdCB0byBhbiBlbXB0eSBzdHJpbmcNCj4+Pj4g
KyAgICBieSBgY19yZWhhc2hgLCBvciBhIHNpbmdsZSBmaWxlIGNvbnRhaW5pbmcgb25lIG9yIG1v
cmUgUEVNIGZvcm1hdA0KPj4+PiArICAgIGNlcnRpZmljYXRlcyBjb25jYXRlbmF0ZWQgdG9nZXRo
ZXIpLiBTZXQgaXQgdG8gYW4gZW1wdHkgc3RyaW5nDQo+Pj4gDQo+Pj4gV2hhdCBpcyB0aGlzIGNo
YW5nZSBhYm91dD8gIGdyYW1tYXRpY2FsIGVycm9ycz8gIG5vbiBleGlzdGVudCBsaW5rcz8NCj4+
PiBjcGFuIGxpbmtzPyAgSXQgZG9lcyBub3QgbG9vayBhbnkgb2YgdGhlc2UuDQo+PiANCj4+IE5v
biBleGlzdGluZyBsaW5rcy4gQ2hlY2tvdXQgdGhlIHdlYnNpdGUuDQo+IA0KPiBCdXQgSSBkbyBu
b3Qgc2VlIGFueSBsaW5rIGluIC4uLg0KPiANCj4+Pj4gLSAgICBieSAnY19yZWhhc2gnLCBvciBh
IHNpbmdsZSBmaWxlIGNvbnRhaW5pbmcgb25lIG9yIG1vcmUgUEVNIGZvcm1hdA0KPj4+PiAtICAg
IGNlcnRpZmljYXRlcyBjb25jYXRlbmF0ZWQgdG9nZXRoZXI6IHNlZSB2ZXJpZnkoMSkgLUNBZmls
ZSBhbmQNCj4+Pj4gLSAgICAtQ0FwYXRoIGZvciBtb3JlIGluZm9ybWF0aW9uIG9uIHRoZXNlKS4g
U2V0IGl0IHRvIGFuIGVtcHR5IHN0cmluZw0KPiANCj4gLi4uIHRoZSB0ZXh0IHRoYXQgd2FzIHJl
bW92ZWQuICBUaGUgcmVmZXJlbmNlIHRvIHZlcmlmeSgxKSBpcyBhDQo+IGNvbW1hbmQgaW4gdGhl
IE9wZW5TU0wgc3VpdGUsIHJpZ2h0Pw0KDQpJZiB0aGlzIGlzIGEgY29tbWFuZCwgaXRzIG5vdCBw
aHJhc2VkIG5pY2VseSBpbW8uIEknbGwganVzdCBsZWF2ZSBpdCBhcyBpcy4=
