Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010002.outbound.protection.outlook.com [52.103.67.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB40153BE8
	for <git@vger.kernel.org>; Mon,  5 May 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746473434; cv=fail; b=pGmnJ+FBgMbbhDX9uOU8HJ095giE0QLATuNt/GI3xVT6/IowBRDs7oyQx+S1CYPask0WgNNDnt+BjnSRbZ8ie2UQEdebCLtArPffdkk2emUlfTSMc07l3O9bY0D1MV/oTInRcai1D1e/yu2hG/qz6A/4cSW3L2jwEzSa/AEWZq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746473434; c=relaxed/simple;
	bh=AQviVuF6p1qHfZbZwdUM4NrQQDHp6D3rKvoLVGhIX2I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rf22LB9pTlm/vG2zX1foliU1spPYWUds71GT+KLk3cs/YNiRoS+H7ChWnMXKYNoOjPZVPCcBJmqygHcI+TDHaVWQoXdR2x6d+rNhJ8zXyeSn9/DbZ7V5tiGokIWFQbkPwHlvh4LhqU98bL2yYQLoQAqrFuD59xGTQBdgLBbsEYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aYoxN+Mb; arc=fail smtp.client-ip=52.103.67.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aYoxN+Mb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AURgoOM/Cq6VjeZ10LD7R8yIuiTfDqhpqORKrMADuv+KCRIC5WwH+npLcKTtNopNiylETEIyzc14EqyHuDFSBm9CQcvc3PIj0gp36pFnQGDT3v4WjFZ6DVc7EPF0LWfsDxMUOPQRxM6qeIm5KyOq+dq18iv/Q1eGAhlcc7mcpPrpdkJ8MUDo4r7VPjIHhN3bKudZkkItBYYTllQjgIF+aZL57x4qf3N03qOJQZgOqK6TXjbqP0OevB743ts8R80H1cDH/Sesjt8UkaeilnXsx2AVY8G8JUfy+KaC2op45awADsKItfGWs//hAuSBA3LFduKVxHYCUzZU6jrpHKdDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQviVuF6p1qHfZbZwdUM4NrQQDHp6D3rKvoLVGhIX2I=;
 b=kr67OI2K3ea0YdYZiONItSTbL4o+lbWyuASlE++Qr64w19kmCEDYH5plOCAK4UwJDJKtIBspBh+CiiByPotnY9LDOMvGbpU8L0cC5koPQuwxk0WKnTWsAIpBFyBPsMddCSSyh+MQGFrrh5RjoW7YTaThRiTeS3K0OCL58v620U3R0Y50vYSW4aGgElwzN4qLtlgcpRCp1MDtlTInnvF4Aqkfr8RlAJeiUhVQZGIvHlUJvAVNcfUELj/GeTaaAJNy0WDBzJ88nJZzu3mKF19hZBp+4En9q8VfTPFYL+ZP+J818tFFkIOYKj/8Fr3XjBRE3C2FEPRbEouiHE41sl8W6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQviVuF6p1qHfZbZwdUM4NrQQDHp6D3rKvoLVGhIX2I=;
 b=aYoxN+Mb7UN0Tdm/aCXbfphDLoRfty1QR+Gr/QZsAhQn+rpTKGGBquvPNUX2nW9obZoAgjC6BNvIm6mqwE+Nabd6aT9v6Aum8ftLbz9JSJkmZZW0M6jjdETeZwhVjvNyKXDIQb63WyzE/IGBbiMLcGZgZSWDYAjvr/5CXlcPTnvANlVnPfOcE1eQLsFfy1fkqMuh6IumdUPVojyUi0WHJSYq9J7UmdGa+WKr+aI9hxTcoGfXijGOPq86xwINY4fyWQTDRNRFjoNzA/MlPoXy3IDEJyrmKP+sx21kVVofVDCjvV4VnAaCN/hg+AVYKS0LJXkcalLT7hHimmm7uTHlMg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9539.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 19:30:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.019; Mon, 5 May 2025
 19:30:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v2 2/3] docs: improve send-email documentation
Thread-Index: AQHbvYWXpMr/8gBr8EGUfxqNi4IWdbPEaoGSgAACwK0=
Date: Mon, 5 May 2025 19:30:26 +0000
Message-ID:
 <PN3PR01MB95972A228D52741453DE824AB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597827866A582654661102CB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597E545331A9BBF088329EBB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqv7qeooed.fsf@gitster.g>
In-Reply-To: <xmqqv7qeooed.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9539:EE_
x-ms-office365-filtering-correlation-id: 550309c6-6a3a-4718-edb2-08dd8c0b49c2
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|6072599003|7092599003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?TWcxcXpzbHBkTG8wOXJrc1BtZkIxZDZVcjRxRFhzSTU3anROUDNBTnpTOUZ3?=
 =?utf-8?B?dU40Wk5VUjZDWWwyT3Z2T1JSU0dtK1IvdGswVUZrZFlodUZTNE5hdzJyWElE?=
 =?utf-8?B?dERiODRsWFhITTBpWkxvZWhJRGFyYSsxSGtiS2Q3cGE2TzZPWUFSbkpnUFFu?=
 =?utf-8?B?d25EeUx0ZkdpRHQ4TUZLWUhyRS9QQVdZZzhDU2ttYWFNZEpVMTdXTHVhR3k5?=
 =?utf-8?B?dFdVek5XL2lUL3JjVnpXUDk0TFByNnJndmlTS0xnMU1scTJzbkR0Yjg1VUNz?=
 =?utf-8?B?OU5neElKUXkzRXlrUFVNMEtaZnJhOUkzdDlSQXdCQllaTU5OR1NUY2dHQUx4?=
 =?utf-8?B?QU81Z3l4cXkyWEhKaG5abG1TeHFjcERXdkpIQ3BCSllnQnc2OTBYQzNWR3NH?=
 =?utf-8?B?aUdRTm5XYUlkQVFIMy8vQ3ZPNUdHR1RDVCtyTDZ5VndCcEVpSzJnN0d1YXBF?=
 =?utf-8?B?MVJuL0ovVkk2bllpS1lRSURBUStDYVU2ZDk4VWJmWGNyTnVFRDZuNjR1Q2h1?=
 =?utf-8?B?cStQYURDUkJYUDAvL05GVmU4dHF2T25aNWRqREZXdG9jYVhDU2VPVlN1aDI5?=
 =?utf-8?B?TkJaVkhkZThXN2dXOVhHQThQNW9yUkpFNzEvYkxaaEhGc3ZUc3ZYdjNYQURF?=
 =?utf-8?B?Wk0xUGpXNENlYmpYaXFZbnE2WnkvdWZRK2l1USsrL0dCY1Nncks1RmhtZ0l4?=
 =?utf-8?B?N0xRcWc4SStFYlhpWERYbHVmVkdVbzZxQWZsbWkxRzhTbUsySTRjKy9nZnlp?=
 =?utf-8?B?ZUxqbHNrNDY3MUhaS3AzRWQwTFBWMHVUQmoyN1FOaDhvVUZVU2tNbUFGYS9U?=
 =?utf-8?B?RUdRdWtTek9FYVQxMjVWZFBwYWV5TUwvNThEZ0orWlJMV0s5TFA5VmZUNXE2?=
 =?utf-8?B?V29DbW0vOXZJNjVlSWpRaURxaDZuL3RnZmwvTmNCZjlrN2JLZ29Ob2JQWSto?=
 =?utf-8?B?QmM3dUVNSHA3NTFUbFJvMXlseUVNMUova2NzSFlwOWJBeDJPYjlOa3dLWXBE?=
 =?utf-8?B?RHE0RSsyN3RjNjlRV0F5WTBKZmtqUFVZSDA1WFZGWkU3bklmeFhqNVloaGFo?=
 =?utf-8?B?MTJ5WnZZQ3pJVjg1WUhlMFJ4dGFwTzBkVTFobnNwS01CT1dMOWgyV3d3Mkpr?=
 =?utf-8?B?UHRkR3hFV2JXblJrKytFR1BEbEtkbmM4dVlBcTV5bXhHWW44TGJBQW0zdkpB?=
 =?utf-8?B?Wk1qVll3U09YUHQ4QndhK1lpOGloakZRZlAvTHk4ZGt0WU9VY2lNcUNmbFdR?=
 =?utf-8?B?b1h0ai9PM0lYOXIvQVJwOGlQNmk0YkMreDV1MzRrb1BWMGlTR0R2SWxZL0E2?=
 =?utf-8?B?dVZJK3NpRTd2VWZxeGJMcktrVEVBSElOWW1KZm1HZTh1M2FVaVJraEJQcG1I?=
 =?utf-8?B?ZU53OVpTajFuSVR1WVowbW1mRU9vQzdOaWpjZjhxcjdENndSQUhVLzZxSHQw?=
 =?utf-8?B?Q1ZCZG9iaVJKd24wYnhMcUMrL2xUb0lPQXAxdE9Xc2dLUCtROTFOc1gyUTJR?=
 =?utf-8?B?YWdVU243RUxlRERPZFpZcGJoOGJ0b0U5RlhjbkNMZm1GMzBjK095YndYdWVN?=
 =?utf-8?B?b0ViUT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VnZlR003U0RKZmdZMzB3OXlCS2tWSWFSK0FHSUQrY0dPanh6c2lUNmZveXFv?=
 =?utf-8?B?bEhqNEpHNnZHdVRldG9VdG5VMi9GNml2QkNkYmFoWWV2YUJzTWFoTEM5NE8z?=
 =?utf-8?B?UzU0TkJQWkFNclVpYXprKzRHM081N1JJR1pSODJGQ2VzcTg1cmErMmt2Njd3?=
 =?utf-8?B?RkVCQk94d3VzV2hQTzRwYlE1MjRyWHJHWG9lK2VwMllDNFJibWREZ0JiY2Y4?=
 =?utf-8?B?Y1I3T1pQaGQ3ZEwvRHk3ZFdVMmlCWHBlZkpaZnB6NGpHWW43WlpBcllRaERa?=
 =?utf-8?B?MnJyTlZSVFB4RTJuV3lBbWJtNjZ5LzYrUnpybXJYRFpCb202V2cxOGs4N1dC?=
 =?utf-8?B?MlFmU3BSOC80dVZWbnIvL2JhT2x2ZzBQSmZNTzNXKzJwQ250NWZvRUJmdFZE?=
 =?utf-8?B?ajcxVFY1UVBQdGxTck1RVHZuTkpRQkU1cnpCTW4wb2VMWEFQTDF4NjIwMFV6?=
 =?utf-8?B?UmZQbzJoMk1aYnBLSjRoMmxRcjZ5Z2xDditjSmhRbmtpNi9YUEJkbHV2RnVm?=
 =?utf-8?B?RjB4ZTcxSXFhYmFZeWt0RDlYdmVSMDVSMDJ2MzVQSXZGamdxOFJNd250dkxr?=
 =?utf-8?B?VFR3ZWlZT2lKbG85c3R5WVZETC9oZzhvME9qbVJlRGpKQzgwSlNPY0ZHNFpv?=
 =?utf-8?B?UkdwWVZ0b3pTUFRnRjVJTDlDYWd0T2Z4b0FRbnhidXVCZ2tBT00rbU1iZTVn?=
 =?utf-8?B?N20vZHppL2dtOHBFenRSZmpaT0paRmJxV1FuRVBickRJallkaG9OU0FzK2Jy?=
 =?utf-8?B?Z3JLUFNjNzZXOVRydTBSa2ZJRVBVSkpsQ2lya2RFQmRKL0pLTEtibXh6TzNj?=
 =?utf-8?B?TCtOZVYwOHdLMGpidkJVbUhBNW1sR090V3NuL0NsUzlLVFVCRHU0b1BORGl4?=
 =?utf-8?B?M09KYU5SYlNYQ3BDOGI1a3ppQ1lPbmtXczZDOW5DaHVtSjZMdTZvZ1JQbndB?=
 =?utf-8?B?ZFJwblJqOG9qb01GUTN5M3Z1QzBESzN4TkNOTEIvcll5dFdzeENIbjl1Qm9M?=
 =?utf-8?B?N1ZJOXVOQzloUks5TStiQmtzQkk3R3dWMjY1U1hBaFNqSlJ4blVRcDlMNlpM?=
 =?utf-8?B?R2tjdldscVJFdVhDOHYrdjRxZEduQlpFTXNqZmhKWWFTYTltQjJrL1JKL0cz?=
 =?utf-8?B?YVY1bzNSd1ZJYjZ0NTU0cE1WYzFIeTR5MDVSTWxtS25rRC9xd3JDQ0tnQmFI?=
 =?utf-8?B?V0JocnZMTjBpRktlMkJOL05Vdk16SkdkQUlOV1ovM3NYOFNlT1p1ZDN4TnZY?=
 =?utf-8?B?WDdEOU9BTjFZMnBsSHh3Tk5xdlZlTHozNjF3UDlNdzhkdnFFZndZQWFuTVBv?=
 =?utf-8?B?NUdTL3lCWnJsaG5DYnVjNGFHY1ZtU3JvM1N2SlFoc2lkOGRFZjM3L2RhbnVE?=
 =?utf-8?B?d0NlWjZGSjNLSmpXY2dmYmFRVmZxcnByZ3JOU1hsTFhWbXRpSTR5OUUvY1Vw?=
 =?utf-8?B?eEQwbENUMk1wUW9JZ1VUSlVPQ3JKWUxhckluT1BKbytLOFRNZkdoVUVOcllx?=
 =?utf-8?B?dnEvcDJMQXVwRUJEUU9JbUxmU3dGbmF1b1g1RHh6NFN3Tkp4TFdIUisyWDcx?=
 =?utf-8?B?NUZncDd5SFRaNEZGL3dOcGh0a1lCSUFQYnczV0tacTZrR2hNTUJ3cDgzaHdx?=
 =?utf-8?B?K2pJQ0JNUGkyR1NVL3lWNG0ya21QUDhBWlkyZXlUSTZXSzlNWCtCWUpwV2l4?=
 =?utf-8?B?bWxnd29GaUVuVFJrWGRpdjZaMWxNUEdFVHJxUVJXenY5eENGSFFUeWg3VVlO?=
 =?utf-8?Q?v+VncXRWYhJeZZkss8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 550309c6-6a3a-4718-edb2-08dd8c0b49c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 19:30:26.6320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9539

DQoNCj4gT24gNiBNYXkgMjAyNSwgYXQgMTI6NTDigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBUaGlzIGNvbW1pdCBkb2VzIHRoZSBmb2xsb3dpbmcg
Y2hhbmdlcyB0byB0aGUgc2VuZCBlbWFpbCBkb2M6DQo+PiANCj4+IDEuIEFkZGVkIGV4YW1wbGVz
IHRvIHVzZSBPQXV0aDIuMCB3aXRoIEdtYWlsIGFuZCBPdXRsb29rLg0KPj4gMi4gSW1wcm92ZWQg
ZXhhbXBsZXMgdG8gc2VuZCBwYXRjaGVzIHVzaW5nIGdpdCBzZW5kLWVtYWlsDQo+PiAzLiBBZGRl
ZCBsaW5rcyBvZiBjcmVkZW50aWFsIGhlbHBlcnMgZm9yIEdtYWlsIGFuZCBPdXRsb29rDQo+IA0K
PiBUaGUgdXN1YWwgd2F5IHRvIGNvbXBvc2UgYSBsb2cgbWVzc2FnZSBvZiB0aGlzIHByb2plY3Qg
aXMgdG8NCj4gDQo+IC0gR2l2ZSBhbiBvYnNlcnZhdGlvbiBvbiBob3cgdGhlIGN1cnJlbnQgc3lz
dGVtIHdvcmtzIGluIHRoZSBwcmVzZW50DQo+ICAgdGVuc2UgKHNvIG5vIG5lZWQgdG8gc2F5ICJD
dXJyZW50bHkgWCBpcyBZIiwganVzdCAiWCBpcyBZIiksIGFuZA0KPiAgIGRpc2N1c3Mgd2hhdCB5
b3UgcGVyY2VpdmUgYXMgYSBwcm9ibGVtIGluIGl0Lg0KPiANCj4gLSBQcm9wb3NlIGEgc29sdXRp
b24gKG9wdGlvbmFsLS0tb2Z0ZW4sIHByb2JsZW0gZGVzY3JpcHRpb24NCj4gICB0cml2aWFsbHkg
bGVhZHMgdG8gYW4gb2J2aW91cyBzb2x1dGlvbiBpbiByZWFkZXIncyBtaW5kcykuDQo+IA0KPiAt
IEdpdmUgY29tbWFuZHMgdG8gdGhlIGNvZGViYXNlIHRvICJiZWNvbWUgbGlrZSBzbyIuDQo+IA0K
PiBpbiB0aGlzIG9yZGVyLiAgRG9uJ3QgdGhyb3cgYSBidWxsZXRlZCBsaXN0IGF0IHJlYWRlcnMg
d2l0aG91dA0KPiBwcmVwYXJpbmcgdGhlbSBieSBleHBsYWluaW5nIHdoYXQgcHJvYmxlbSB5b3Ug
YXJlIHNvbHZpbmcgYW5kIHdoeQ0KPiBzdWNoIGEgc29sdXRpb24gaXMgbmVlZGVkLg0KPiANCj4+
ICtTRU5ESU5HIFBBVENIRVMNCj4+ICstLS0tLS0tLS0tLS0tLS0NCj4+ICtUaGUgZm9sbG93aW5n
IGV4YW1wbGVzIGNhbiBiZSB1c2VkIHRvIGhhdmUgYSBiYXNpYyBpZGVhIG9uIGhvdyB0byBzZW5k
IHBhdGNoZXMNCj4+ICt0byBhIG1haWxpbmcgbGlzdDoNCj4+ICsNCj4+ICtJZiB5b3Ugd2FudCB0
byBzZW5kIGEgc2luZ2xlIHBhdGNoLCBydW46DQo+PiArDQo+PiArICAgICQgZ2l0IHNlbmQtZW1h
aWwgLS10bz0ibWFpbGluZ2xpc3RAZXhhbXBsZS5vcmciIEhFQUR+MQ0KPj4gLi4uDQo+PiAtICAg
ICQgZ2l0IGZvcm1hdC1wYXRjaCAtLWNvdmVyLWxldHRlciAtTSBvcmlnaW4vbWFzdGVyIC1vIG91
dGdvaW5nLw0KPj4gLSAgICAkIGVkaXQgb3V0Z29pbmcvMDAwMC0qDQo+PiAtICAgICQgZ2l0IHNl
bmQtZW1haWwgb3V0Z29pbmcvKg0KPiANCj4gQWxsIGdvb2QgaW50ZW50aW9ucyB0byBpbXByb3Zl
IHRoZSBkb2N1bWVudGF0aW9uLCBidXQgbG9zcyBvZiB0aGVzZQ0KPiBsaW5lcyBpcyB2ZXJ5IG11
Y2ggbGFtZW50YWJsZSwgZXNwZWNpYWxseSB0aGUgZmFjdCB0aGF0IHRoZXNlDQo+IG9yaWdpbmFs
IGluc3RydWN0aW9ucyB3ZXJlIHdyaXR0ZW4gdG8gZW5jb3VyYWdlIHRvIHJ1biBmb3JtYXQtcGF0
Y2gNCj4gYW5kIHNlbmQtZW1haWwgYXMgc2VwYXJhdGUgc3RlcHMsIHdpdGggcHJvb2ZyZWFkaW5n
IGFuZCBmaW5hbA0KPiBjb3B5LWVkaXRpbmcgc3RlcCBpbiBiZXR3ZWVuLg0KPiANCj4gSXQgbWVh
bnMgdGhlIGF1dGhvciBoYXMgYSBjaGFuY2UgdG8gc3BlbmQgbW9yZSB0aW1lIGFuZCBjYXJlIHRv
IGhlbHANCj4gcmVjaXBpZW50cyByZWFkIHRoZWlyIHBhdGNoZXMgbW9yZSBzbW9vdGhseSB3aXRo
IGZld2VyIHR5cG9lcyBhbmQNCj4gaW1wcm92ZWQgZXhwbGFuYXRpb25zLg0KPiANCj4gUnVubmlu
ZyAiZ2l0IHNlbmQtZW1haWwiIHdpdGggdGhlIHJldmlzaW9uIHJhbmdlIHRvIHJ1biB0aGUgImdp
dA0KPiBmb3JtYXQtcGF0Y2giIGNvbW1hbmQgaXMgb2Z0ZW4gYW4gYW50aS1wYXR0ZXJuLCBlc3Bl
Y2lhbGx5IGZvcg0KPiB1bmV4cGVyaWVuY2VkIHBlb3BsZSB3aG8gYXJlIHN0aWxsIGxlYXJuaW5n
IGZyb20gdGhlIGV4YW1wbGVzIGluIHRoZQ0KPiBkb2N1bWVudGF0aW9uLiAgUGxlYXNlIGRvIG5v
dCB1bm5lY2Vzc2FyaWx5IHByb21vdGUgdGhlIHVzZSBvZiBpdC4NCg0KRmFpci4gSSdsbCByZXZl
cnQgdGhhdCBzZWN0aW9uLiBZb3Ugd2FudCBtZSB0byByZXZlcnQgdGhlIE9BdXRoMi4wIGV4YW1w
bGVzDQphcyB3ZWxsPw==
