Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011037.outbound.protection.outlook.com [52.103.67.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671C57482
	for <git@vger.kernel.org>; Thu, 22 May 2025 03:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747884054; cv=fail; b=MLDE8V1nccoBunjvNFkaZ3Oms169fiOzR4iefIyqfrdyjXPhQnCj81LfwcqSvrnmC7fPQILopH8U2PT3mLPkGR1l7X4z+zXi1SuUkJeAQgaanxDDjlFqguube42wYUK75KbL7lJT37GLfJw4wy9ewAIyoJI3vdQDkCyJmxX6cwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747884054; c=relaxed/simple;
	bh=aeIxXHlIjAmfELjR2gfD1Kd3R4B84End36npJ7r7HLs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KGPJwbyxWUwjQpF46DpkzlEHQ6HGmggQDB2WnBoLbETikoqlTM7RHsHS+8qJcI9pjgB1yVcgw8HUd1+IH7srdbqNsD7+Q7rK+Y8wJFHl0SFB8xM6ZtxpkWbGEL5Q0lVFKvjKvsCkktmx5kbbyFHgJnO6NwECcwDKZya/Jm4FTQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZLY8lLm6; arc=fail smtp.client-ip=52.103.67.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZLY8lLm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJoUeuDoPv5xHgn1cyf32GVroKZay+S/otSjWMVj/470HJrOMZrwb4whCxSzqpyhFRXZuM6NzenoGrdaJPrxuWfpTTSXjhz/pypGPNiJ1JqGUssrvENJuGgdZ13yPUZGR86ioD39P2lbFhVGBm92OtvsJgg9QThDTMeC2jzFVpMfzseLOIdK+P1mCtKeDCnuhLDHmlVnGqvLb7sZfnp7Gj0aPC+4L46L4RLsssBEKb/YrIK3CqPSjvTuXVwOnKIGQwWxYBp4xtiOcroyI13opb0GRn292629Ym6Sf2A2UoS7OuypWVKaR28/N0dMdp4k6W2vZdqP2KHj6vNSixDB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aeIxXHlIjAmfELjR2gfD1Kd3R4B84End36npJ7r7HLs=;
 b=fp1NxQByOnP78RgOYm+pn4HssB2gobbYYA9IcnUEsd/wozjqg6dzWaGPfP+X9xFusNDIpzC2Tep3mXsgqoeIfQCZV1Tji6aPIlcOLN5C4PuVKXdbGrcsXtMW+JNb/e0A/sUt1B0HyH0N4jzjVIq5lgWosuQoqpL5uj1dlK6/N2087XaZB0CPUGNOdNrSEfX561EiBslDq0OtyIubp1pl8+WuF4DO8zxoR55WeknQ4o9PNhH29pJcQTj9cgFCRI1bBs+ZezXcUZNPPHKvhIWNFmEB+y3Fp4XfaGWpwDI7bfHQAgR8p1FAGZFIBQLm3N7vIMHBrmJRElWmXUhAUxGutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeIxXHlIjAmfELjR2gfD1Kd3R4B84End36npJ7r7HLs=;
 b=ZLY8lLm6yzh1U3HuxQwwJN09woqphGpUo0Bn/eik2feIeSwtDqMxGPxnRW6YERTIHedYomEqOrSY/SvsyK9zejYHUp64NzgQVks0ZysS+R8qhxzK5InCthxj/WyrErAMi2cHF6a7ZHtM9HdqJfE6Jmus3dg28fqfoRbxxXmSVrFeGhMfoVA11OkrMFZPECj0+PwN4+u3yT2QW6QOOuVHYJ53CgTYSQd+UJJ+UP/yeecYhcwiG9jetkPSx1KbhgA9rDu2S0C1shdKM18sqVzrBTVe2kqwIjdI/Eap4KLz2RBTGyjkGhnXDOoshcwQHsxFzrU34OjmWECl4I/K19astQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB9390.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:104::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 03:20:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 03:20:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Add git imap-get-recipients command
Thread-Topic: Add git imap-get-recipients command
Thread-Index: AQHbyoXnDvtZ2Of53EqGfuieygkMp7PdfsdqgAB9M4w=
Date: Thu, 22 May 2025 03:20:48 +0000
Message-ID:
 <PN3PR01MB9597F61508C56A33136B3844B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597D5EBF0A8D91737E4FE52B89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqikltaghp.fsf@gitster.g>
In-Reply-To: <xmqqikltaghp.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB9390:EE_
x-ms-office365-filtering-correlation-id: 784379e4-0cc2-4791-08f4-08dd98dfa60d
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|6072599003|15080799009|7092599006|8062599006|8060799009|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?KzJhTXF5U3Rkc1YvRUkvaUdtU2pzZVdzeC8xYnVnZ3hwWm1zTVVGWjFVK3Bz?=
 =?utf-8?B?TkFERE5DLzZmZUVMbkFLY3lhZzdEcDVxMjc3QWFkRERHdmM2Wmc0YmVhNlNh?=
 =?utf-8?B?dDR4R1IxRHduZmkvd0pVa2xPa2tZTnlVUmZiK3dxQ1VDWlFTN2llRkRsa2Yw?=
 =?utf-8?B?TEkyeGR3dXdacGdROWJDU09EZ2JXOWVJNE56UW1LTllWbitxcElCc0hPM09Z?=
 =?utf-8?B?SEVNU1ZTQU9EZXlPYk56OWgrSEx2eXdoWmZkUzhmNG1EZGY4YVpJK1ZKVDFv?=
 =?utf-8?B?UnhraEM3S1ZRalhGZEcrKzdhb0l3RzVLejVyOFlwVzlIWkxPNWI2d0lrT2du?=
 =?utf-8?B?NXhvVGVkcWUyWDdCcis3TnlNaHg4NTBjL0FBN0NWSkEzdGhCT1MvOG50Z2x6?=
 =?utf-8?B?L05sRllPOFFBdEM4Ny8yeGlqZjZHLzNTNzFzMEhMTngreEhWVk5OY1I2d2s1?=
 =?utf-8?B?YzlVVnM1TzZJZjcrYkpxS1J0b3llNlFWL0wxMHhGL1AvMGFXUmJBb01zTFVL?=
 =?utf-8?B?SHlMcWRydGFCbXVZV0lzRVIyeXQxTHlFT0NVUCtweHM1Z2RTTms4NUVhbjBB?=
 =?utf-8?B?a1IvdFd1QXdjMEw0WmxwSFFUb05XQ2pYQk9vTHJsUXd3V1IyaTI2YkVqMFZx?=
 =?utf-8?B?U2VEeWVyU1NEWjJ5YldZaDZVazZ1SXNzT3hickd4a0YvcjJIN2oxc3phV0dv?=
 =?utf-8?B?R2VEYW54VzJEODFCb3Y4NGlYQlFBc3lsSTBBVGVkYThFTks0dkdjbXQrVXlI?=
 =?utf-8?B?Q3d3d09aMWNqWDZjWjhVN05GakpzN1FMOEdzSWNiQUJleXFreURacTdPZW9l?=
 =?utf-8?B?UDhmTkVDVFMwNEhiUlRiS0dtTUZQaUR3S3REZkR4ams3dW1iT0hiU2ZLYkF3?=
 =?utf-8?B?OTFhRVN3elRVQmZYVkdiZ2cwMWdDcUFRWFhRV2l2c1dwa2dqOGhwbnFydTM4?=
 =?utf-8?B?dGNaNGQwMHZrQkxzanhVWnVhTzdUMytwZWViU29PL0g3NjNNS2ZhdHI3T05M?=
 =?utf-8?B?M05XMnZ0SUdhRVZrVllLNFNON1J6QlhuODUxMlV2cWtFUGFsOE1EclJnbTB1?=
 =?utf-8?B?cGdUaGtVSjhJUmw0R01qaXNZQWxHKytub1NDWUhHUzFIOVZWdm56dFdRdE1v?=
 =?utf-8?B?a0Y2U0R1YnozWnRyYjgvODhkOTZTMUFmaC8yek1EWitpcmlUY2tBTVdiQy9M?=
 =?utf-8?B?enExbWV2bzBNSFBhNHFtdFNuMzVpWjZ5VkhydkpiVlVwNTM3dUFvbXRvd04y?=
 =?utf-8?B?NE9HN1ZUY1VNVUhzUzJ5N29GMmwxTXhUVkp2NmZuTmF0Y0UxU2FiUVZuaE1J?=
 =?utf-8?B?NGFJVWVhaVErb2dRZHFydVZlZ1R1Y2dTTXZ3VDFhWTBpZW92QmxWcXZMQndN?=
 =?utf-8?B?YVptbEZIOWRIQXl2T3lWVkZFY1VvV2x2THJPdkt3SFlwVk9Wd0pucTROTElJ?=
 =?utf-8?B?czE3SFBKR0NxbHg3aGdLWHF4TmFMY3Q4Z3psOUJLbHJSNGpCV0ZQK0MxUnll?=
 =?utf-8?B?OG9naWdnSkt0TEdETjZENy9nSXBCQnhBTHRGS2l6TWZINkZyZnlqUDdndk5I?=
 =?utf-8?B?THBBZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U2JTVDlnN09ScEovcC9OWXErVVlQYk1PWnVwUkVrM1hDNlZ5WmJiQjI0WEpz?=
 =?utf-8?B?NHdJeXBjUUFPVEhiQjBQZVdLVVVxTzBtWmQrMTlvTEpoSGx0Zy9EVVY0WEZY?=
 =?utf-8?B?U1BidHk3OStLYTMwcS9qY0Mrdm03TkhncWROT2pnUVVPQkQ0cHR5endaS3M1?=
 =?utf-8?B?SGxhNEJpU0xCMTVhSDkyRnVnMVA4ekZMWWJqRllQN3FHcTIrYW9YNGFrVDVF?=
 =?utf-8?B?MzhHSEM2SHBuTHdhbEV5b2tyWEVnT0Zhd3ZwVEZGdjRaT3JqNk83OE5Pa3RK?=
 =?utf-8?B?RUE2ck9Sc2gvV2FpZndnOTIzd0hwOVFCNDFYWGxQZGpTbXdFWlAwbGZNdlha?=
 =?utf-8?B?Z0l6RFZjUWR2bHNUSHlCbHBXc05CaGZKbUdIMFZpRm5HVnVkcXhCZklDQjM1?=
 =?utf-8?B?TnNHWEljU1RMbVdUbmZnaHdFV04zdUVMdDJVUWQydVk2cXFIL094bFUxYkp1?=
 =?utf-8?B?WU5KNTlJUzFwUStXVGhHRVpBYnhET0UyeTZKaFBxOWhRWFVGRFhYdUs0TzY3?=
 =?utf-8?B?R3FzQ0tCMWthOUV0Rjg0cFVjN0pRcnI2OWRlUkJiWDNiYlBpeWI1bTY0aUhP?=
 =?utf-8?B?b3Y1bndCMTBId2hxZWdOZDhyR055Ky9TK0hSby96Nno4UHNwajMxQUxTVnE0?=
 =?utf-8?B?SFFOQ2NQS25TUTZ4QTNSalcrNWIyazVHS0MxMDJBK1A1Tlhtb2pjWnRxV1Np?=
 =?utf-8?B?OVZiQkF4d2RMd3lFZzRiWUFNUW1hNlZhRzNiN1NwK1d0Wjh2NityNVNqa29I?=
 =?utf-8?B?MHdtWlZUUHVXM0hqTFRpaWhPME5xL2o4eXQ5KzAwOVBEUElkcUNzRXRHaEYx?=
 =?utf-8?B?NGhzUGN2MGd3ZmM4b3c2Y2tiL0lmUE1HSE1FajU3eFRYdW1zTzJweUc0SDR1?=
 =?utf-8?B?Zkh5UXVDM21nTW8wMGh5dFFjMndJdWM1cCtpRkhQWkFkZE1KZnIvTWlMNG9R?=
 =?utf-8?B?elpCYTVqaTY3YWUxSDc0ZlZqbkFmVHc2b05tdDVDRmJGUXZpTEtOWXQ3NUh2?=
 =?utf-8?B?eFNzNUJ4M3NUckhIcUk3bTdkMFJ1WW9ZN3JHcHc5SDRvcDl1a29Yemx6dURi?=
 =?utf-8?B?b0ZsaytrRDA4Vk00L0htSzdtcllaZUtBcUU4NVRhaUgvdDJvdDVFaDBJUVFO?=
 =?utf-8?B?cUhOcHF1QW5qNnYrNmJkUXhZOUpYdXUwSG11cWdldzJzMHh2ZE1PT0hvem1o?=
 =?utf-8?B?TXc1UVdFcXoreVVxRGg0QUFvcGtNTzBEdEh0YlpmbzNZY2M2L1p1MFZpaHN5?=
 =?utf-8?B?N0hpR3ZCODNBZFdnUnJuY000cXg0WXVIWmRzdHVUVzE4bEUwNVVBVWY1MFc3?=
 =?utf-8?B?cFZoc3FwYmpuRUVCWnpqa0ZXeHB0dUE4dVk0NWpiUHV1RnkwbXlXNWJKTGxj?=
 =?utf-8?B?bk14UlB4WE8rQzAwK2I4TmVFWEp2bnl5U3J4SFZ2VVhCMHpNcVFHWTZ5RFBN?=
 =?utf-8?B?MlVyNW1ydnlZbnhaNThsZmNQY3ZicjhBUXJNZFc3djBHSjg0dlYwemRpbUxs?=
 =?utf-8?B?Sm1tUVIvYkxpaWRaT013c0p6ZXFiZmVmN0xaT2FCeWJoNWJnYURzRlJNMTVp?=
 =?utf-8?B?ZElOK01pQmFyQ3dmajFud0FKc3hrWnN1YlV3c0ZwTHdCQzZRcUN6WFZ2aFZo?=
 =?utf-8?B?RFpSSXRNQ1NsQVpuOFJZQy9hT1YrV3o3YjdqcFVBcmxsMkRVUFh1ang4Sytx?=
 =?utf-8?B?SW1CVmFaZHY0OXVHbDhmOVlrMy8rSFpQdnY3dUtwc0xLVndNZ25XL1FjYmh6?=
 =?utf-8?Q?bh0B5iFZy+feH/dvM8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 784379e4-0cc2-4791-08f4-08dd98dfa60d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 03:20:48.7392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9390

DQoNCj4gT24gMjIgTWF5IDIwMjUsIGF0IDE6MjLigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBJIHdhcyB3b25kZXJpbmcgaWYgaXQgd291bGQgYmUg
YWNjZXB0YWJsZSBmb3IgdGhlIG1haW50YWluZXJzIHRvIGFkZCBhIGdpdCBpbWFwLWdldC1yZWNp
cGllbnRzDQo+PiBjb21tYW5kLg0KPj4gDQo+PiBJIGN1cnJlbnRseSBhbSB3b3JraW5nIG9uIGl0
LCBhbmQgaXQgd291bGQgYmUgYSBwZXJsIHNjcmlwdC4gSXQgd291bGQgZG8gYSB2ZXJ5IHNpbXBs
ZSB0aGluZywNCj4+IHRha2UgdGhlIG1lc3NhZ2UgaWQgYXMgYW4gaW5wdXQsIGFuZCBvdXRwdXQg
dGhlIFRvOiBhbmQgQ2M6IHJlY2lwaWVudHMgb2YgdGhhdCBtZXNzYWdlIElELg0KPiANCj4gSWYg
eW91IGFyZSBzZWxsaW5nIHRoaXMgdG9vbCwgeW91IHNob3VsZCBjbGFyaWZ5IHdoYXQgdGhlIHNv
dXJjZXMNCj4gYXJlIGZvciB0aGUgaW5mb3JtYXRpb24uICBUaGVyZSBoYXMgdG8gYmUgYSBkYXRh
YmFzZSBvZiBzb21lIHNvcnQNCj4gdGhhdCB5b3UgY2FuIHF1ZXJ5IHdpdGggYSBtZXNzYWdlLUlE
IGFuZCBnZXQgYWRkcmVzc2VzIGluIHRoYXQNCj4gbWVzc2FnZS4gIFdoYXQgYXJlIHlvdSB1c2lu
ZyBhcyB0aGF0IGRhdGFiYXNlIChlLmcuLCB5b3VyIHBlcnNvbmFsDQo+IG1haWxib3g/ICBsb3Jl
IGFyY2hpdmU/ICBhbiBpbWFwIG1haWxib3ggYXQgeW91ciBwcm92aWRlcj8pIGFuZCBob3cNCj4g
ZXh0ZW5zaXZlIGFuZCBjb25maWd1cmFibGUgaXMgdGhlIGRhdGEgc291cmNlPyAgV2hhdCBkYXRh
IGFyZSB5b3UNCj4gcGlja2luZyB1cCBmcm9tIHRoYXQgZGF0YWJhc2UgdG8gY29tZSB1cCB3aXRo
IFRvL0NjIGFkZHJlc3Nlcz8NCg0KTXkgcGxhbiB3YXMgdG8gc2VsZWN0IHRoZSBNYWlsYm94IHNw
ZWNpZmllZCBieSB0aGUgdXNlciBhbmQgdXNlIHRoZSBJTUFQDQpjb21tYW5kcyB0byBzZWFyY2gg
YnkgbWVzc2FnZSBpZA0KPiANCj4+IFRoaXMgY2FuIGJlIHVzZWZ1bCB0byBiZSB1c2VkIGFsb25n
d2l0aCBnaXQtc2VuZC1lbWFpbCwgd2hlbiB5b3Ugc2VuZCBhIHYyIGFuZCB5b3UgZG9uJ3QgaGF2
ZSB0bw0KPj4gdHlwZSBhbGwgdGhlIHNlbmRlciBtYWlscyBhZ2Fpbi4NCj4gDQo+IEZXSVcsIGlm
IHlvdSdyZSBvbmx5IGR1cGxpY2F0aW5nIHRoZSBUby9DYyBsaXN0IG9mIHRoZSBwcmV2aW91cw0K
PiByb3VuZCwgdGhlbiBJIGRvIG5vdCBuZWVkIGl0LCBhbmQgSSBkbyBub3Qgd2FudCB0byBzZWUg
YW55Ym9keSwNCj4gaW5jbHVkaW5nIHlvdSwgdG8gYmUgdXNpbmcgaXQuICBUbyBjb21lIHVwIHdp
dGggYSBsaXN0IG9mIFRvL0NjDQo+IGFkZHJlc3NlcyB0byB1c2UgaW4gdjIsIHlvdSBzaG91bGQg
c3RhcnQgZnJvbSB0aG9zZSB3aG8gY29tbWVudGVkIG9uDQo+IHYxLCBpbiBhZGRpdGlvbiB0byBU
by9DYyB1c2VkIGluIHYxLCBhbmQgdGhlbiB3aGl0dGxlIGl0IGRvd24uDQoNCkZhaXINCj4gDQo+
IEFnYWluLCB0aGUgZGVzY3JpcHRpb24gb2YgdGhlICJ0b29sIiBpbiB0aGUgZmlyc3QgcGFyYWdy
YXBoIHdhcyBzbw0KPiBza2V0Y2h5IHRoYXQgSSBjYW5ub3QgdGVsbCB3aGVyZSB5b3UgYXJlIGdh
dGhlcmluZyB0aGUgVG8vQ2MNCj4gYWRkcmVzc2VzIGZyb20gb3IgaWYgdGhlIHRvb2wgaXMgdXNp
bmcgb25seSB0aGUgbmFtZWQgbWVzc2FnZSwgb3INCj4gY29uc2lkZXJzIG1lc3NhZ2VzIHNlbnQg
YXMgcmVzcG9uc2UgdG8gdGhhdCBuYW1lZCBtZXNzYWdlLCBzbyBpdCBpcw0KPiBpbXBvc3NpYmxl
IHRvIGdpdmUgYSBtZWFuaW5nZnVsIHJlc3BvbnNlLiAgV2UgY2Fubm90IHRlbGwgaWYgdGhlDQo+
IHRvb2wgd2lsbCBiZSB1c2VmdWwgd2l0aCBnaXZlbiBpbmZvcm1hdGlvbi4NCj4gDQo+IEEgbW9y
ZSBnZW5lcmljIHZlcnNpb24gb2YgdGhlIHJlc3BvbnNlIGZvbGxvd3MgdG8gb3V0bGluZSB0aGUN
Cj4gZ2VuZXJhbCBwcmluY2lwbGUgZm9yIHRob3NlIHdobyBhcmUgd2F0Y2hpbmcgZnJvbSBzaWRl
bGluZXMuDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFttYWtlIHVzIGNvbWUgdG8geW91LCBiZWdnaW5nXQ0K
DQpObyBpbnRlbnRpb25zIHRvIG1ha2UgY29tZSB0byBtZSBiZWdnaW5nIDooLiBCdXQgSSBkbyBn
ZXQgdGhlIHBvaW50Lg0KSXQncyBiZXN0IHRvIGtlZXAgaXQgdG8gbXlzZWxmLg0KPiANCj4gSSd2
ZSBzZWVuIGZyb20gdGltZSB0byB0aW1lIHBlb3BsZSBhc2sgIkkgYW0gdGhpbmtpbmcgb2YgZG9p
bmcgdGhpczsNCj4gd2lsbCBhIHBhdGNoIGJlIGFjY2VwdGVkPyAgSWYgc28sIEknbGwgd29yayBv
biBpdC4iIGJlZm9yZSBzaG93aW5nDQo+IGFueSB3b3JrLCBhbmQgbXkgcmVzcG9uc2UgYWx3YXlz
IGhhcyBiZWVuOg0KPiANCj4gKDEpIFdlIGRvbid0IGtub3cgaG93IHVzZWZ1bCBhbmQgaW50ZXJl
c3RpbmcgeW91ciBjb250cmlidXRpb24gd291bGQNCj4gICAgIGJlIGZvciBvdXIgYXVkaWVuY2Us
IHVudGlsIHdlIHNlZSBpdDsgYW5kDQo+IA0KPiAoMikgSWYgeW91IHRydWx5IGJlbGlldmUgaW4g
eW91ciB3b3JrIChmaW5kIGl0IHVzZWZ1bCwgZmluZCB3cml0aW5nDQo+ICAgICBpdCBmdW4sIGV0
Yy4pLCB0aGF0IHdvdWxkIGJlIGluY2VudGl2ZSBlbm91Z2ggZm9yIHlvdSB0byB3b3JrDQo+ICAg
ICBvbiBpdCwgd2hldGhlciBvciBub3QgdGhlIHJlc3VsdCB3aWxsIGxhbmQgaW4gbXkgdHJlZS4g
IFlvdQ0KPiAgICAgc2hvdWxkIGluc3RlYWQgYWltIGZvciBzb21ldGhpbmcgc28gYnJpbGxpYW50
IHRoYXQgd2Ugd291bGQNCj4gICAgIGNvbWUgdG8geW91IGJlZ2dpbmcgZm9yIHlvdXIgcGVybWlz
c2lvbiB0byBpbmNsdWRlIGl0IGluIG91cg0KPiAgICAgcHJvamVjdC4NCj4gDQo=
