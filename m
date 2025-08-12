Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147132D781B
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754980070; cv=fail; b=JXJ3V3fd3z0jkIW4bPQOfWTgY4K+zhTScC5lVyFajISZxEKxBucCYZEzGPEIjCR0rBke3aEYPV1MRcH98VUKLpnKWp48JN2lpsSL2vaUoyP5YIwdB3bs8akJz/yF6zr4+YXDFpLB6sLQ0SQc3RGhQ5wcwMgDDYlpH8nyQOoEmzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754980070; c=relaxed/simple;
	bh=rfqbVBVsjpm48KJ3K7EG3mza2hB9K37LtusXN/2HMBM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FBl1Yl0dUUYFRDfLNa1wdRz95YdssNSB0nyNdKjAIGp1WgrN+Q2eGyJ7tNF5wKl8I/mqhfHnR/T8ZCHkE1iPPxhcKrC5c4OAuTkGUY0RgAcNOhhTAbWkCS7IQyzwJUZzGhvdD4VwIzDAoqcgZOeCe9NtdCzgr55KR8fi/1W/UL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GfOWEne5; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GfOWEne5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQ7uJ/Lw67ZiLBgzJTwIhevotRStMoeKQOnM0aYov/TnF/M1NKtK3aQxhJLuFoA4OHGRvPe9/ugmew9lpwtL/ROGt/sVrmZIjwk+pmL5PJOhIyFzoTM1qnav9OMv6wvg1QSKX4fQ610ZsaFQdJIBmmANjbFhUHF2nRCjVsXTCR6/P/dMM7QOKgyikAxKl9T4IWRm1b6fvHLB/l49SvKTPdqrdyJKTX2xi0lnuM6C+o7QyHfB07ExIkAzGLEWHItb5l4hRSk0Wvsw/U9fEBD7o43CXXaqxKN1ztayMXiHfCDPf/oAL1iF94Gmsk6T3uiMNhZM4Jz8TeHJDWWJeOO4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfqbVBVsjpm48KJ3K7EG3mza2hB9K37LtusXN/2HMBM=;
 b=E7dWfD/hdtNAOV5o6DMDT4Yr1oRfFA43bITQjXVHfBx5PnjpbXXONfTNSASXUoMA8JTZXN5McjqrDniJUKW14N2Za8wBXx2TdHjP0zLafp60wW2vt1P7f/3Vdc0qWCnt1f+IGA0f/TiwD0j0a123Wh1w8b3Hb3ZtITezdsDoKdraBcHWYH+6UflQ9+RawPxNlUxX5GJQjCpzkfusPAdjl9zwhiYmEW9hsGn3ZglNusf6/M7H/IffIAgY9bmRsL0QfJG/GRXKtJ32zWYjdaqoH1CMtWxwvVk2r2laQSSn0GNAZNKHyX+KHK89SJRm294e6suZ6ZK3ytAYl3XBRh87WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfqbVBVsjpm48KJ3K7EG3mza2hB9K37LtusXN/2HMBM=;
 b=GfOWEne5kZmIBUxY3wKnWJxcfAih3volJzvQv/+46Opr8kv6A8mxo5JCmTem2l4QHX75/amp8/uJcrs5mtnLKlLj/5W3Qka8UVz9aXa9SsUmSI7bcV3pOm/RfdEkwTGkmcGb7TBaLk/gDYAlYYKNQvkkK2ADR9FOI36mdIEyG9VMAFszRzbzZxVGGONJDCzuFL25oqe93GxYlbtDpyh8MW/OqAoU4zjfx6nJoMZFCLhKUUT3itf/xHhXACjXVb2Ijt8/EZtmI7WbGx6zht2QWpwX4xYOlxMhm/3rB/Z2eiPD4c6Sj+Sqo+4a4rJr2cIRzYuvOZZzubwYS2++w3V+Eg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7338.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:27:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 06:27:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
Thread-Topic: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
Thread-Index: AQHb+71dCRDKXsxRhEyzxpjO1f0evLReHPHQgAB5u4CAABZDdA==
Date: Tue, 12 Aug 2025 06:27:43 +0000
Message-ID:
 <PN3PR01MB95970565CA1F554E4B440C63B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqv7mtzfuc.fsf@gitster.g>
 <PN3PR01MB95977F0C73C909929400B3EEB82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95977F0C73C909929400B3EEB82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB7338:EE_
x-ms-office365-filtering-correlation-id: 571209b0-4ea8-4d4c-9c38-08ddd9695876
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|31061999003|15080799012|8062599012|8060799015|19110799012|6072599003|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?emFvWjRJSk5NRHY0Zkk4UjVEd0tuTmQ4VmtPdUd3Mkt1MzBqYWlsYU9NTjM5?=
 =?utf-8?B?cEJmSW9MR2FybGtCU3JJd3ZoVVAxSXNwNVc2UVhjZEJBbVdwQ3VjK1ptQkVT?=
 =?utf-8?B?VmtqNFpUWnBHZW1uSU9jam9qWUY0anYwRUlKRnRVTCtBMVpEb3JoSThwZVZt?=
 =?utf-8?B?ZitqR2NSUzEvdUV2OERHVVZDSkVqaStWUkY0dUpSNmprakkydU5VUWFRZkI4?=
 =?utf-8?B?SHB2VFBER0RBYXkvSjBxVzJQU2tzR3JTVWhrVkxZUmZ1L0lDc0JWaFVPb1F3?=
 =?utf-8?B?RzFWdkpGWU9vL1llVVRTeDFiMm1UWjlEczJiWHNkYTZPVTNSc0ZaM3RGMDcy?=
 =?utf-8?B?QkcrUW9odHVOOVZIQnpyNUE0alUvcmdzaFZQOGdraVl6YkM4THFJUzRTcndI?=
 =?utf-8?B?WVB3eFhQc1ZiNmJFd1ZIUU1yMFQzSmlpbkI0NEpSQ2NEbVVuUm9tSHE0WDF0?=
 =?utf-8?B?aEt6MVYvdmVhenoxZHdxQ2dUUklmY0IvV0RFSTZqVGRVR2V6RXVmODlNSDBn?=
 =?utf-8?B?OGg1YndRZnFXZG0xNXI5a2MrakVXY2o3R1FqT2hnd3l4TFNsbGpLVEtlNVhP?=
 =?utf-8?B?dzNhOVpUNGxDNndtMXNoSExmTnpDUGFqVUNRVlR5NzQza2xtblk2QUFUUnZH?=
 =?utf-8?B?bjQvejJRSm91S1VWNy8wNzZ0cXd0RzlEL2U0K3MyZXlyazNmNm5hUlVVUGVk?=
 =?utf-8?B?TDUyaDFTWEt4NGdCK0Z3WFRINThLbnZMME1RT1pkKytuc1dWalRPWTVVNHR5?=
 =?utf-8?B?K0dGTWxaWFlQSXEzb1IvNUFHOXE0VzhjVlRjMmRWWkowQS8zQ2hBaXczbmJh?=
 =?utf-8?B?WGVMay84eTA0Zmp4Ni90QUZrVVhHaUxVQmUzRjNWNHNzenF3aklRUUpuUFJX?=
 =?utf-8?B?d1NrS0J0eU1ZejlqYmJMcTFQcnlhQUlVOElPVXFzNTNmbWZMb29rMHVPTXBO?=
 =?utf-8?B?b2pTU08xV3dVZC9WeFZOKzRBSG1KSlFsdEhYMStkTldPVmc3MUxOdjc1SkhR?=
 =?utf-8?B?UVpSaG1Qc09BcVJCekxSU0srREZoYUtxTjYrWTluVWJNY1dJUUpyWmpTRE5s?=
 =?utf-8?B?VnhmOXZYeEUreXEyUUwrRWduNWIxMnVabXlkc0RwNEliUzU1am9wRVRId3ls?=
 =?utf-8?B?RmRxT0NzOHk4ODJ4ZzM2Z0VXNEtGL0VJczVYclN6L2swbWZCVGFkWnoyT0hO?=
 =?utf-8?B?UUZHT0dxZmtCOFlSSFM3amRxdGlNRCtQS3h5S2RJWDc0bFJlZ2ROTGczTFlz?=
 =?utf-8?B?eWltN2t5S2pkQTRhWmpPOEFONXRadjNvMkdPcWdreHVFZkROTGRLVVdVSzBE?=
 =?utf-8?B?NDFIbEs0WHhWUXd6K3MwMVlQU3EydmNNNEZXd1VKTkhMbzl2VHpNbnNBcTU2?=
 =?utf-8?B?WTlEWnJ6d0gvS3FpZW9vUW9mS1U5R2lpTzd0V2lialhuSTVEckNBdDFKN3Fr?=
 =?utf-8?B?VExJYVJzbk9UcTdvVVVKWHdVbDd0N2ltWXdxQmthUjJZamFHL1RKdUhMemVo?=
 =?utf-8?B?UWM5eDZtVWN4bVFwOThHNW0yTGJ4WWNKOTVQK2NBL0tqaXZSSVdvZ05pUk01?=
 =?utf-8?Q?9gHcVQkWOBbpM9rzWd3Wc09xM=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUNsQ2gxcDI3L2pvRXdKSXBFbktSYndPS29jeEdMaTM3ZE5sbXRSVGdqci9P?=
 =?utf-8?B?elpTdHpOM0x2aUxjclNPWnpYcWZrLzRCeUpTUVJSb2RwaWhqWkhXRjFHcWty?=
 =?utf-8?B?SjhHQ0tNeklDTlB5QnJrVW5CUWlPZ05XdUtVa3pWYWM4cUVPZ2IyTHllRlhu?=
 =?utf-8?B?RVpJM0FPclRvNG11bkM2b1FvZFlEcjFIb09MNzczTlc3WGczcWxtdVBtcUhr?=
 =?utf-8?B?cnpJRzR5SDRqT1lzQzRwazhLeWFYUmhaL09SWFpZMk8zaEIzRmJaUTY4OENR?=
 =?utf-8?B?M3hqbXUrZnhYZERXU3JQbWtTRUV6eWVhNDVnWFViUVJPb2U2dW9XWjFDaXgz?=
 =?utf-8?B?Y0ZCT1FSbHpqSy90anBnRmNYb3ptamFYdkJlY3dCUWVZRnNrbGhwcklCODI5?=
 =?utf-8?B?RGpIVUZTSlhmZ3VwejVzN3pwWXlCaHNUbzExd3NxKzBVZ2JoMzFyTmJzR2pU?=
 =?utf-8?B?VzRtTGlYa1ZBYVJ0SVExd2RtVGVrYmZGc0JZSkVud2p3ZEZGZGJsTUF1MHNM?=
 =?utf-8?B?QUFhNXRMQTBsMkVDVE4waXJTS2JjSkp6VTMxWjZQN0dsUG84R2wzRkZWd0lN?=
 =?utf-8?B?Wi9XcUh3UUh2aDJwUkFBSWl6SjBTNXorNjdFTFVGeTN6UG9qWUVyOVZTa1VL?=
 =?utf-8?B?WGhSaS8rcDFSTU81MEE1TXBIZ05EOEZrbFJnVXZPMXluZks3QzBmV1hWSmRO?=
 =?utf-8?B?T0lwdVlQRXNIbmozdE44SXM5b3c2WWhzOWhxSmJQRTdVMHljT3J4QmpZV0dP?=
 =?utf-8?B?djk0QytlcUE3aUFxbVhVNmhaZDcxWFU3NXlLNUtDUFRqWDBnU0RqVUM3WFN2?=
 =?utf-8?B?N01Ya0tpaHVOOFBEL1FndzU0SEVzT09CQVdiakdWenVwdENTYXFZMmlYY2pn?=
 =?utf-8?B?T2w0em90SFBjRHM1WU1INUFoS2pUU0ZIeVQ2UEUvc24wdGxMb2RnTE51R080?=
 =?utf-8?B?SGNmZmpTL1Z1TmRocjQrb3RCcDNMYUZPb0VpNTd0VEFqTW9GRlVYRXYwWjEx?=
 =?utf-8?B?bFVrcWVKM1U1WEJqK01lMzhpNkIySURpOFpaaXFVQ2cxNUQ3ZXRmT1pheFVG?=
 =?utf-8?B?NUFuVFlMRnRGTCtUVS8yVjM0WDVTbVF0VndqazBHWFhrWXl5SHIzRkZobWYz?=
 =?utf-8?B?VEFlekdOZnhmZ0s5Vzh1Qzg1L3QyZkVCWGVWN1FNVWYyWDVnTElDMGFBcGNT?=
 =?utf-8?B?UXBzNmJTcCtncDF0eFpTYk5GRm1aMDErYXNvRldCUjZ5ZFlhWTgzcGV4a2JM?=
 =?utf-8?B?NEQxeXRhK2ZBcnpwQU55SG5uSkhURE5WRThpWkU5NmRPKzZHaXQ5RnFRSEtn?=
 =?utf-8?B?UnFMNkhiaEI0Qk5ENDFma2RXSkUybXYzMWQwWTE2OHVXMEUvakRUdm9uUU1s?=
 =?utf-8?B?SHhCWnEvWEVVSXNXUWhqMGMxdC9xT0pvODg4K2hZUGo4TlRXUlpxNzFvK05y?=
 =?utf-8?B?Kys3cnA4aEVxWGpqczdzam8rUEM3eHc0STJlSlNQRXhleUFreXZVYldqeWtR?=
 =?utf-8?B?dkNmYmZtY2pHL2J0dzdpWWFOQjR2RTk4RWZTMlJpREM4VExxVmd4M3cvWHlz?=
 =?utf-8?B?emhFRzNZdnUwcnZQWHdUd09iNnhPMGRvaVdxOXpPc0h3Ui84Yy9aak9mNitU?=
 =?utf-8?Q?AL0B0riQoLs6xuGicPBTrJqNsRlvtrx3u3J3OE/rD7Io=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 571209b0-4ea8-4d4c-9c38-08ddd9695876
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 06:27:43.5262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7338

DQoNCj4gT24gMTIgQXVnIDIwMjUsIGF0IDEwOjM44oCvQU0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IA0KPj4gT24gMTIgQXVndXN0IDIw
MjUgMzoyMjoxMeKAr2FtIElTVCwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3
cm90ZToNCj4+IEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyaXRlczoNCj4+
IA0KPj4+ICstLVtuby1ddXNlLWltYXAtb25seTo6DQo+PiANCj4+IFRoaXMgaXMgYmV0dGVyIHdy
aXR0ZW4gb24gdHdvIHNlcGFyYXRlIGxpbmVzLCBpLmUuDQo+PiANCj4+ICAgIC0tdXNlLWltYXAt
b25seTo6DQo+PiAgICAtLW5vLXVzZS1pbWFwLW9ubHk6Og0KPj4gDQo+IA0KPiBUaGVyZSBhcmUg
bWFueSBpbnN0YW5jZXMgaW4gdGhlIGRvY3Mgd2hlcmUgdGhlIGNvbW1hbmQgbGluZSBvcHRpb24g
aGFzIGJlZW4gd3JpdHRlbiBhcyAtLVtuby1dc29tZXRoaW5nLiBEbyB0aGV5IGFsc28gaGF2ZSB0
byBiZSBjaGFuZ2VkPw0KDQpOdm0sIGxvb2tzIGxpa2UgdGhleSBoYXZlIGJlZW4gY2hhbmdlZCBi
eSBhIHJlY2VudCBjb21taXQuDQo=
