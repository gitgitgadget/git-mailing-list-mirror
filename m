Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D5337C101
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 15:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723690; cv=fail; b=B5PnhNbIks9Ld++533QNRXVUmQvgJGs+1EdVKBkh0oGTNFfIXrz4WSYPBz93CpVFghrBPhfdLbKLPF5J/lfVzcCQ7/nB0xXUjFQKneNTzoZVKVpx7uypdka2KFMFz6qLkHXIzFu8e36MSoJ8LGZGshFpwFFIHQKXzDMHfECfwvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723690; c=relaxed/simple;
	bh=GZ+ABTQ1cZHDs7dY4/hTOdgqRA3dMi3O8lNbzctMTwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tK+mgvIMdBbkqyHT9obk4R1gChNQbKVoaHoXVHo+FIgEIqB1NM2Qu8SFwd0HTpxf+sMll6tK26xEoxRCo3oHclnbzWwW4ryG7ATdZRj5Z/4YKJCA539r5SSemxRrp9Jb6ZzbM7/+z77EO4KNaqE4GeG4D0dQT4Rfu0mSQNlii4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TMy5PGOu; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TMy5PGOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YG7ccyWXZZ2OCpEiHdGNT+qySDwtEoJmLDXv1S6DGQYltrc6sliqYw5OkLwELx5/Jhvk2FkbnEV5fiK68XDkNOo4tYFfXpPcNk5Q+fLzV7fIFXbWcJmui7qtu2H+mEYZEe/hvsIRaYdnYLHHeVvMPTCrp1Q+bF8AeT9klMlcvbNrExUFzIlrvi3iMDcU03PkMM6Wz81yOhnsZ+DU+HV1Q5RYO7xHKFD7I0RaAAtLu1h7A0to9eireAg7tDzt8jAGmZ+cD0FVX6l51RfC8K6tjQvxpbySBMns+niNYeozQ14goBQY1VWYfECrKMPQYKzttWbTfExibJAU6gNqGYmwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZ+ABTQ1cZHDs7dY4/hTOdgqRA3dMi3O8lNbzctMTwM=;
 b=dpgd6+tJW2yVbOH14KuAfQ5rmYodEVAptjwM9nUI65BP5815aYURrKv0EXsCNTunCGuODgtJB50q9cMBa0YZ5YSukqKpnuXAWEJSmb0zxukV5Wwl+UKLb+tlXS7mOExViI0JOltEbATQzdhXKANaxdmxfNm9/nQkyERIS9l4rkUoOmrBEffw7pypgyeDLLaXSiUTpz/czY3zDzmaYGJQVXKoTmVqrCIJcRFULqX68tvfEtxjnP0nSWBNlI/pA4Vu0vXQSMfSj4+GATv5SR05BVYp3Q/rVmlexE27XOJ4nXqCyp4xjZYDZjyjhyDlugB+oXG+dh6qhYeghz5/3ea0jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZ+ABTQ1cZHDs7dY4/hTOdgqRA3dMi3O8lNbzctMTwM=;
 b=TMy5PGOu5qVZgi9w30D0PwhiFI3a8g6PtVHFl3fT2xkMTt6zEr122dFt1RfBMAIs8CY+CgP0RzAuVsTit3XhcE5+Xy4SN3c7g6SdBlw4K7wG0jPvINQT1OIy5Z56r2ek1joJrR1IkWpRm7jQCM7skCm5c2EdAs8A4i9peW/AT/eQiyxUQmCGAw/k7jssKy/FwA6BsHwmKAWqWVLlmlfwWTJf9jeQc4T2DYeAqxmf5GTES72PxiP5KRAVQZOaJ3VPNsjYleMUY+NcIOKh6UPHev32tlTMHLraNNnmr7MIYLQKPrmy/1sUT11WYrpN6sqRD6omAHr6yKu5WeSf65CFuQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN3PR01MB9918.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:150::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 15:14:44 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 15:14:44 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
Thread-Topic: [PATCH] send-email: pass smtp hostname and port to Authen::SASL
Thread-Index: AQHcrJiCzueBEitpLUG7OFyvnv7pzLWgBB2rgAAISQU=
Date: Thu, 5 Mar 2026 15:14:44 +0000
Message-ID:
 <MAUPR01MB115467BA486F4F9B4E6829D64B87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
References:
 <MAUPR01MB11546AED093D8641767AACEFCB87DA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
 <87ldg6jpy0.fsf@gitster.g>
In-Reply-To: <87ldg6jpy0.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MAUPR01MB11546:EE_|PN3PR01MB9918:EE_
x-ms-office365-filtering-correlation-id: c2f369d4-cf69-424f-03d3-08de7ac9ee70
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|19110799012|31061999003|461199028|14091999006|25031999004|51005399006|6072599003|10035399007|440099028|3412199025|102099032|19061999003|40105399003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmg3d0xOdUpjdlM0eGZGTyt1SDBJb1JyY1orazdHNExTZDYzV1VpaW1rNjBs?=
 =?utf-8?B?Nld0MmgrT3Z2ZXJVZHZwZWQxejR3US9IQmNnMXcwMVZJR3M0QTd0K0VXR0VZ?=
 =?utf-8?B?WGZ1TlFlRTJkenY1Z0lMOCtTL1B0VDMwSGt6RmRER2ltck9yeUcrTnhVZG5H?=
 =?utf-8?B?SWRsSzRoSTJlaEpNU1FXbVlTWkhRazdqY1hsbDVxL1h0aHljR2t0Y0lQN2wr?=
 =?utf-8?B?NTNKczRWWmNCNDNrQkF0djUwa2FUVUs0TCtLWW1tSnNieENIUWFYMHozeFJR?=
 =?utf-8?B?SnR0czNtYmF1Q09JWS85MEJkRThJRjBQOThzQ2VjQkxXMDQxYmp4MTFXRzVx?=
 =?utf-8?B?NDJGdi9uU2RtbFlXdytkWnR4Y2p3eVcxcTlob2JaY3VZTGhZWlNWSmQvNHdw?=
 =?utf-8?B?SktGUTl4K3dNV2gzVlFWZTVkSzdGZFVIT3VIa1huckVvTGJ0bUs4eGdPQmUz?=
 =?utf-8?B?cFQ5RkJiWkhodXcxcFE0TXQ2Sk9Ua2JFY0Uwa3I0cUE3djBKRTczd2d4K3Zv?=
 =?utf-8?B?ZUZseG9XNm9WSTNvQXpSRHBiakVpVko2SzRKZVhGajc3T1RQa0x1SEhIM0g5?=
 =?utf-8?B?OC9ZZkEveVRUZGtFeEk5NWtjdXFGNmxoY1JoMEZQZVFOa2JvbFByYzI3aDNF?=
 =?utf-8?B?WlhCYUJzbTNHMS9jcER1UU56WXd4cE05cEowcGRZNU5jMm5RTGNSWURZdGZn?=
 =?utf-8?B?WTU1WFlETDhkNi9ETGNmZ0drVU1wZmxNNmJTLzdYS3lacXhJQUNZQWE0M3RU?=
 =?utf-8?B?a0k5UGtONExZbjdmL0dtUzJ0a0w5WUh5ZTMyWHNIajZ5ZDJnZFM4NDA4TmtD?=
 =?utf-8?B?Ni82TkdUZVEvWGliV2hjWkFBYmQxaUJGd3RudDM5cFRtdThrdHhIWUtzY0pZ?=
 =?utf-8?B?eWxqTUFMdXhJUEJmemtwdDhRc05UNGhpbk5TWTBsWTkrSmZZbGJmbU5RRTFl?=
 =?utf-8?B?cnZ4Vnh0YkxrUi91VkRzcjlWZVo5VmZVRlJYOEtSeTg5bEt5S2dRMUZUVHhI?=
 =?utf-8?B?TUZwYWU4eElxVWZCd29OWFd1SjlqNStrdklXbk9VdFh0VXZqS3BDQ0pGb1Ez?=
 =?utf-8?B?RnRsbU9VMVFxUlpCeDh5aThJaktOcUdLOE9mQ05XSmxvUm5NTFVWMGhveHNX?=
 =?utf-8?B?ME82MnpsMVJ3eHQ2YXFJNXh1RHRFd1piTVBOcnYra21pNURoRCtGRFM2cDdD?=
 =?utf-8?B?MVo3V3hac1cyVHhUelBuOUQ0dVB5ZWJpYW9LOXNmZG1YQTlQY0g2RWRkSVVD?=
 =?utf-8?B?U0lRRlFqVUVIcnlJMkE0RHUyLzBZUTA2Uy9zR2VNK0NYaUJQTzNVYWRBdzBl?=
 =?utf-8?B?eVlGYUhkRmpsYWJ1czl0M2NUZnh4aGc4Y3VnZGRzci9zYUFCTWF1M3lyZ3d6?=
 =?utf-8?Q?PIHtehu6cyJoRtoiY/Q8rBzqVRbllTTQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STVoR3E0TFdiTGtlNU9wUlpFY0xIRGtWcmRicGJjZXNwTXdGQ3VKTjIwQk1s?=
 =?utf-8?B?YmZXVmU2N0h3MW9aRDYxY2VtUjRNcmtBVmRobVlKYmJ1QUwveTFoSFJvY0xQ?=
 =?utf-8?B?MUV4TEVhNkYyYjdJSDMzY0dSZG5zRXJTaWwxYmQ2bVVlOUYwSmkzbVBYUGQx?=
 =?utf-8?B?R01NZjU0aVRSVk5pcjVTY0lNVHBhbDJIR3ZoRUp4NnNZZ05vRm1BaGtnaldV?=
 =?utf-8?B?ZTJNWGNoTWpSKzJIeExmMXBQWVhqNngrSkYvNGV4aWlpYTdGckxjY3FIT3l1?=
 =?utf-8?B?ZFNVZ2plVzk2VGhER1FDbWpzbGFmbktkNGRtNXczSERKdTUyOWhqS3VNSUJW?=
 =?utf-8?B?b3dya2JwajRWSk1ybjdiTEF1ZERiMnVJTVMrbGZudStBZmJjNmRVM0RTVlU5?=
 =?utf-8?B?emU5M2pjbFU5eC9tRi80VUlCRkdqYS9laHJkaHVDakRxeU8zVXZUdkdKNTFn?=
 =?utf-8?B?bTJwdGFrUGFMRjNHQ0dBcldLZEpUNk1pR2xzTUJqckFIMXl5V1Z0WHJ3SEVi?=
 =?utf-8?B?OUdiUjZ3MFBRS2Zla1lKcGRLQVp0TEphSkhldDg4dmdseEtPUi8vbEVHVWJW?=
 =?utf-8?B?R0ZGM3ZwbEcwcy9WMUlVK3dTUUlheVpKVFJnaWxjdTVQZkxvTHpmampkK3Vm?=
 =?utf-8?B?WDdBWExKRld1YUlNZUllQnJtcFFTbVN2TjlFVzJxdEwyU2J1WVkwOThLSVhr?=
 =?utf-8?B?MW5SK1NpS0hMVDdJOXlINUJ3TFRmK2J5eEtKdUtwNFBFRXBiSW8rdmU3cS9X?=
 =?utf-8?B?TDkvSkt1dXlUTis1VUlDbkR1Q1BudlpnaHZKNVlQOUMzeTBQZE1HcTdKQzdB?=
 =?utf-8?B?c2dFdElCQTNwMW52NFdFYkFIV1RMV0NOR3RKNlFSMi9pUFNDQVNDVnh4dVJV?=
 =?utf-8?B?akVzRU5CRzFQRGlMSmVab0NvTWFHdWo3T0ppdGg1NkE3OWZZNUlUbktxbnBy?=
 =?utf-8?B?MHZSb3ZIdlM5SUswMWpwcCtzR2w0YlppK3RJUU11eHlNbGJoaWY3ejdvUXlB?=
 =?utf-8?B?OE5rZmFDQmZKZC9reWpxRG1aVk9xUmdJOXBteTVWVUNOQjFIVFVVUzBGcXJq?=
 =?utf-8?B?eDZjVU1sUUI2S1M2cWhyNUdTN1B6ME9Ic2JYb2pTaHhFS0Qvc1VTcW43Skl4?=
 =?utf-8?B?RXp1SmZRK2E1V2dJRGNRUFBIUENPZDUwa2UyNTBmRVRiRmRBcVBVb21Ua0dZ?=
 =?utf-8?B?SGF5Nm1WVW1hM0FGQTRUbDdhZ1NqNzEwQmh0VXJVdCsvZksvTGdCZWlnVWdv?=
 =?utf-8?B?SjF1cE5iUDVKNkJlbHptcmRtQXZPNk5PTEpJVFZnWWtySTlYcEplZ3YrR1RH?=
 =?utf-8?B?WmdkZWN5dDdQcnFCRTZoVTNpQXhlZTFwU0hqKytlbHB3UlR4akpjLzVjWm90?=
 =?utf-8?B?ZENWZVk2Y0hOcUgzaXVpc3NlZU9Kb2VWWVVFcHJCcUtNRG0zcUZERW53YzRK?=
 =?utf-8?B?T04zc29La1ZHSGVzYUorWCs3OE5UYU5uT0Uwdmd2VW9jTXYxZGJxYlozMjRF?=
 =?utf-8?B?dkxpd09PYW5MeWh5eVk0bDNqQ3NBZ0hxeE1Ia1hRMTFmcHdwUFpkL3JwVElC?=
 =?utf-8?B?bFE5RXVJMVkrVHZ0UHB6SDhhbTJ5WHQ3d0UrY3NYanIyT1N4ZERLR1ZBODNF?=
 =?utf-8?B?Vkd0Y2dwVXMxdmdDVWxWdGE0cEgzTzQ3ZnBsUythSjRCN25oaHRWZXhwcitS?=
 =?utf-8?B?SkFHZjIwaVVKMUFrb0UyeXVYcVk1NWFQVjIyWDd4eW9QdDg2YitrVXJtTWNs?=
 =?utf-8?B?aUI3RHlKMUp5VkxENXZ5NU4wanhkUjArckhFSEZLcW5FR2t0WnpiOHN2cHRR?=
 =?utf-8?B?WjFLLzZiWENqL01CUkRVOVE0cXJVY013VDFwaFc3bkw2YS9IQlNHK1ZzeFNK?=
 =?utf-8?B?ZDc3T2FkbG8xbCtpYThXT2J0dVBMY3dTYVE5V2tQRXgySlhVUGdrbGIyUW5r?=
 =?utf-8?Q?PxOojUnlwhhDN6oyeRy/pjMixbq+OAMA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f369d4-cf69-424f-03d3-08de7ac9ee70
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 15:14:44.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB9918

DQoNCj4gT24gNSBNYXIgMjAyNiwgYXQgODoxNeKAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4gW2FkbWluaXN0cml2aWFdDQo+IA0KPiAgICBQbGVhc2Ug
ZG8gbm90IHNlbmQgcGF0Y2ggZS1tYWlscyBkaXJlY3RseSBhdCBtZSwgdW5sZXNzIHlvdSBrbm93
DQo+ICAgIHRoYXQgSSBhbSB0aGUgYXJlYSBhdXRob3JpdHkuICBJbml0aWFsIHN1Ym1pc3Npb25z
IGFyZSBiZXR0ZXINCj4gICAgc2VudCB0byB0aGUgbGlzdCBvbiBUbzogbGlzdCwgd2l0aCBhcmVh
IGV4cGVydHMgb24gQ2M6IGlmIHlvdQ0KPiAgICBrbm93IG9yIGZvdW5kIG91dCB3aG8gdGhleSBh
cmUuDQoNCk9oIHNvcnJ5LiBJIGp1c3QgZGlkIHdoYXRldmVyIEkgZGlkIGluIG15IHByZXZpb3Vz
IGNvbnRyaWJ1dGlvbnMuIEkgZGlkbid0IGtub3cgdGhlIHJ1bGVzIGNoYW5nZWQuDQoNCldpbGwg
bWFpbCBqdXN0IHRoZSBtYWlsaW5nIGxpc3QgbmV4dCB0aW1lLg0KDQo+IA0KPj4gU3RhcnRpbmcg
ZnJvbSB2ZXJzaW9uIDIuMjAwMCwgQXV0aGVuOjpTQVNMIHN1cHBvcnRzIHBhc3NpbmcgdGhlIFNN
VFANCj4+IHNlcnZlciBob3N0bmFtZSBhbmQgcG9ydCB0byB0aGUgT0FVVEhCRUFSRVIgc3RyaW5n
IHBhc3NlZCB2aWEgU01UUCBBVVRILg0KPj4gQWRkIHN1cHBvcnQgZm9yIHRoZSBzYW1lIGluIGdp
dC1zZW5kLWVtYWlsLg0KPiANCj4gVGhlIHByb3Bvc2VkIGxvZyBtZXNzYWdlIHNob3VsZCBhbnN3
ZXIgdGhlc2UgcXVlc3Rpb25zIGFzIHdlbGw6DQo+IA0KPiAgIFdoYXQgaGFwcGVucyB3aXRoIHZl
cnNpb24gYmVmb3JlIDIuMjAwMD8gIElzIGl0IHNhZmUgdG8NCj4gICB1bmNvbmRpdGlvbmFsbHkg
YWRkIHBhcmFtZXRlcnMgbGlrZSB0aGlzIHBhdGNoIGRvZXMsIGFuZCB3aHk/DQoNCkl0J3Mgc2Fm
ZSB0byBhZGQgcGFyYW1ldGVycyB1bmNvbmRpdGlvbmFsbHkgYmVjYXVzZSB0aGUgbGlicmFyeSB3
aWxsIHNpbXBseSByZWplY3QgdGhlbSB3aXRob3V0IGFueSBlcnJvci4gSXQncyBiYXNpY2FsbHkg
bGlrZSBkZWNsYXJpbmcgYSB2YXJpYWJsZSBhbmQgbm90IHVzaW5nIGl0IGFueXdoZXJlIGZvciBv
bGRlciB2ZXJzaW9ucy4gSSBoYXZlIHRlc3RlZCB0aGlzIHdpdGggb2xkIGxpYnJhcmllcyBhcyB3
ZWxsLg0KDQpDb25zaWRlciB0aGUgZmFjdCB0aGF0IHRoZSBhdXRobmFtZSB2YXJpYWJsZSBpcyBh
bHNvIG5vdCBpbiBldmVyeSBhdXRoZW50aWNhdGlvbiBtZXRob2QgdXNlZCBieSBBdXRoZW4gU0FT
TCwgc3RpbGwgaXRzIGRlY2xhcmVkIHVuY29uZGl0aW9uYWxseSBiZWZvcmUuDQoNCj4gDQo+PiBM
aW5rOiBodHRwczovL21ldGFjcGFuLm9yZy9wb2QvQXV0aGVuOjpTQVNMOjpQZXJsOjpPQVVUSEJF
QVJFUg0KPj4gDQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4QGxp
dmUuY29tPg0KPj4gLS0tDQo+PiBnaXQtc2VuZC1lbWFpbC5wZXJsIHwgMiArKw0KPj4gMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZ2l0LXNlbmQt
ZW1haWwucGVybCBiL2dpdC1zZW5kLWVtYWlsLnBlcmwNCj4+IGluZGV4IGVlZDU0MjA4ODIuLjBh
YzRkNjM0ZTggMTAwNzU1DQo+PiAtLS0gYS9naXQtc2VuZC1lbWFpbC5wZXJsDQo+PiArKysgYi9n
aXQtc2VuZC1lbWFpbC5wZXJsDQo+PiBAQCAtMTQ3NCw2ICsxNDc0LDggQEAgc3ViIHNtdHBfYXV0
aF9tYXliZSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHVzZXIgICAgID0+ICRjcmVkLT57
J3VzZXJuYW1lJ30sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIHBhc3MgICAgID0+ICRjcmVk
LT57J3Bhc3N3b3JkJ30sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgIGF1dGhuYW1lID0+ICRj
cmVkLT57J3VzZXJuYW1lJ30sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgaG9zdCAgICAg
PT4gJHNtdHBfc2VydmVyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgIChkZWZpbmVkICRz
bXRwX3NlcnZlcl9wb3J0ID8gKHBvcnQgPT4gJHNtdHBfc2VydmVyX3BvcnQpIDogKCkpLA0KPj4g
ICAgICAgICAgICAgICAgICAgIH0NCj4+ICAgICAgICAgICAgICAgICk7DQo+PiAgICAgICAgICAg
ICAgICAkcmVzdWx0ID0gJHNtdHAtPmF1dGgoJHNhc2wpOw0KPiANCj4gVGhhbmtzLg0K
