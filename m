Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CE1CA81
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935710; cv=fail; b=EZ9xzDgfVp8E8C8PVXPR8m5BPQpC0qlnWzOZyz2cs6lfKztMKCs//QS4B50/dIebN8Wd08nPQo4APYJUokIrPaAA3hhD9yF+uAZ2WEpHFqqwjVnq+yrG6KTOAgIz8poltoDpul1GzW8bImuVaidYOe1WAcaZwuem0ncA5FSnZBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935710; c=relaxed/simple;
	bh=23QkPqmmvH4EJpZe5aSzzhtqSKNahT4lVxjJjb13h+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o2VOVI/W3Eu3DtYrqN2DubzJxehhLalqXhKgR6ze8lsjvZjVLt+f7BTkBGXr4prG1QF7u/DQFb7Ezn4WC+ksvTKyliecMi5T6qSEPvGKQmGNqzsQg0KZQ2b+q3oflJ1BwTxzWqQ2ZkRHhh3fXLq/PKzxO7AJnVieIMW+5kLG6Gc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kGtrlCFH; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kGtrlCFH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUpU0TT2925LRIsE9bMSkKzYd7Smy1DQ7eVqzjMeGm9D8wy0wR0kSuDFU+aZ4X2MO5/VBvRI+FQEl8O7Ckcqc21I+z0wgnyMaNvz4hdDTXD1If+PDeFIhFxdXeQ87xHK9d/inIaUnM/L+pb4dQBl+t+far6kNGqWqV9ovTe0e/XY7yaTQg4Ss8NwdNWDANvJQC8o3I2/ZehbcZTUn273t2ogE7LvuothMfM45quraIaPJ7RFi/rmHrmsf82U9syE3K126kb+6gyMRixFz7A2ToWzbDs64YjZ7ODtYAPWLptsK9iYvOM5aRAPHV4OeVc8QmCFEA29gxQl7RJhj2XHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23QkPqmmvH4EJpZe5aSzzhtqSKNahT4lVxjJjb13h+U=;
 b=M//Wpu5Zg+EAm0hl8Vlu+VIgmtmG67Tzn7zQLpzcaCKUsrTDvC2ToQmKrIBRDsNcgf0w3iH0ciaZyT8IGGAYSM5LuT0t6BKsmjKAdkhqhadku8WM9AJxtnIgRJdZhnLflYFh98C842RitK+x3oh9Ty9nyxhm/TGaIBpJUZGtCSTPpOMCt9ACNMFmHdg+kj1aYH+hqIcNr9OTDzE/Q5mC5qnonb9oU2I2+O0iVLl4sDKvkU/oNMgjZ/UGpakK7ZBPIDNOxZIYyPX+g+TGk5Y6v0OBtm8ct7iIUODd+EIZpyX+WISTdHg2IUHvAatQhDrfu/ghvoq4WS/rszpwn56dTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23QkPqmmvH4EJpZe5aSzzhtqSKNahT4lVxjJjb13h+U=;
 b=kGtrlCFHocxPyrBy7J9sfk8hA4dFT6YRRsNz44ldwD7Dg4ShpPKy9iZw6H6yRKLjSEANDIiF9jX03A+LAgvrOVSOLnuK6fDQ2STH6Ddr0FR3Duu6v7eYL28dU89lmbFKCB1H83JGWjKX/WsOTnKSPNfb7n9tnAQoBTn7UHzi7pY=
Received: from IA0PR12MB8227.namprd12.prod.outlook.com (2603:10b6:208:406::15)
 by DM4PR12MB7573.namprd12.prod.outlook.com (2603:10b6:8:10f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 08:21:46 +0000
Received: from IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2]) by IA0PR12MB8227.namprd12.prod.outlook.com
 ([fe80::53e9:9935:5c47:fa2%2]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 08:21:46 +0000
From: "Chen, Boyang" <Boyang.Chen@amd.com>
To: Jeff King <peff@peff.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: CR position changed in exported patch file subject section
Thread-Topic: CR position changed in exported patch file subject section
Thread-Index: AdpodqbkA4hz7K8wQAmbgWkFliNmbAAAQYMwAAKJWoAAAax3EA==
Date: Mon, 26 Feb 2024 08:21:46 +0000
Message-ID:
 <IA0PR12MB822787A4CBE319143FD81C86EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
References:
 <IA0PR12MB822711B89738EDA0E2F25150EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
 <IA0PR12MB822712F1B3E5205711493D55EF5A2@IA0PR12MB8227.namprd12.prod.outlook.com>
 <20240226070255.GA780982@coredump.intra.peff.net>
In-Reply-To: <20240226070255.GA780982@coredump.intra.peff.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f67c7363-9cc9-447d-82bf-f1a64547f0b4;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-02-26T07:50:50Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8227:EE_|DM4PR12MB7573:EE_
x-ms-office365-filtering-correlation-id: 971fdabb-897c-4589-7a32-08dc36a3f8fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PrrBJB2sIaGIq7R0LCD4/jtAAKO1qx0oJrQg+7Y47SGVc+wEeBGCHPrbI3f3X875g5khbLw+LtyPv2yVXcywKjxnN0RuuWpMTzBZiy6foiU5Zm5MXjKY3zxKO7wtR53ZstqWSaUFdoSRk8QCfDNqoGDPkpHdKMb4QZmhJGKgmWTOod/KsRUo48kin1QJmXjYtS+zKxp6vlhXMKOFHIBC/pxJTyb+/6jJXF+HkGZwgOp6EvxAB2MmTUJ4RQhdCAtiitb/4EzERii+L8DxBRMcL5A6Ux8exvIsp2j/sgFE4yLa//MVIAwFkY3kZowGjISqg6ENEoqpm8Da2t2Jmbgqk6/Bm73CS71R2+vqBjpr4pYugW/UK7GDF3E2J7TiObgrPlpbtptedT/3BV9IVvLhvptJozU8zsYe5ji2LHs14AfhQAV/bdK3a2v8CTdGGT0fUBGoitVpREifaDA9M3/Z9JA6d16e1KYscFyzO2eha/qfswWKr/yE1+FENYFK7Hr566zueTAPS4n730qEh/jrsTHWnWWNFkoas5DwYeO2UrDPRl5aw0v1ZoAuo+PjmwOoHKqXWNxTzETz6POuYS4/XA8/6FjKX55mdYF5xR2ydebQoKxBItnB9ezua/hpOTllkHWcMN8UTqimg++c2WugHl0BnQLGgEH5Ew/IRryytKyHSB5x2SqbGD07/FMz01f67EYnW+/jstKi47vUbzp9M/dtFVP17NtWCdCC0A9UTwk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8227.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c25BK3JzUGNtZkxjaW1lOUsxVkxMKzJhdlo0eVQyb2tZMXh0NXk5MkZrQzYx?=
 =?utf-8?B?ZUpxTG1oUTY4TVZrVnpTM3FuR0hydG9pOTVLdkp0SCtNOXk3YW1GY2NFTFli?=
 =?utf-8?B?eStaYXV4Q3BadU9kaEM0c1hsdHhNN0laWnZweHNEZ3Y5U2h1YVBLOGVLRmJY?=
 =?utf-8?B?azZsN2lzWVJiZ2htTlJuL2pJWjV3S09wNzBHNmd6K0tZRHZMMzNPUU8rQTFB?=
 =?utf-8?B?Mmp6Mm9xMXVEYVNvYkJCRkE1aTZZVkcyUmtxcEZCY2VtYmduaHN2TXNIbmFi?=
 =?utf-8?B?dmdPZ2lxRUhncTJKSnpPSHQreFZYRmJWdnJyc2Nlc1dCc1BEOXFscGxHb3ov?=
 =?utf-8?B?cWR4MllOSFhUYnJYbTRkNHJRWjdyb01CUUxjUmh6amdMckdlWjZGZWZuWEd5?=
 =?utf-8?B?Z2tUYTN5eWZUVmI2SmlLNzArYll5Smh0Sm45WGxORG1CREJQK04wSWsrUkpT?=
 =?utf-8?B?MWNQemcwbGhCSnlBTWZWL1BnVzdLNVhveHBmem5GalhWZHJ6VDZ2OGNXM1JL?=
 =?utf-8?B?Yjh4elR0WTQwUU9yTUNYSjFrS1lESTdJQ3pHdU9jYUNnUEtBVlZ3OFdaMEhU?=
 =?utf-8?B?Q0NSQ0RoWGdqUkg2dG1xY1IwSUw5NmdQNFQ1L25RV1FDb01SL3hOT212Wk0r?=
 =?utf-8?B?QVlZa3B5Y1BnUk1Eb0gxa2pLb2l3OUgxQjdwbytyVWJXKy82OG8zbHYyYWxO?=
 =?utf-8?B?VkpveDc2K29vNUFUVGRseGZFRGVZNUt5dE9YclhsNTVhUGdsK2R2SG40UjRS?=
 =?utf-8?B?ZS9icFdJcE5JelRLZkhKMUdnNXl1dE1WZWphdVdwVXdVQmNySURheXM3RnpF?=
 =?utf-8?B?cVR5UndyVExkYnB4d2I2N2s2anI3RDlxZWxKM2Y4REIycGs4V1Vzc1pKckRp?=
 =?utf-8?B?TkEybGtaYVRUZ2o1eGxtUkozU0NUSzN1NjR4YjdQL25qTWtmTENBazdXVWpM?=
 =?utf-8?B?V3FGZDNCWUlHTnFyemNQaGMwUHZTYXp6UFZqYnhkT1RLK3JrZE1qWWx0dEh0?=
 =?utf-8?B?ZS9vc1J3SDdJUWc1NG53MDFFZHNhaWFtZHMvNHZhQi94MEFNMTJDUnQ2M2xZ?=
 =?utf-8?B?dWVxbnorejY0WHNZWktxT2tNOEZNdU1jNHNLMHBwR01wRXhrMHVXam1TdzM5?=
 =?utf-8?B?M3ZLWXRkemVucXhWU0lUT25qV2tXLzFHRUVoUkUzSGVzSzlUTzUxbEYreG03?=
 =?utf-8?B?VWVsYmQ4eW8xUTVwWFVNdndINkNsNFFETFlobHFqMHV1ZklkSzZCR3NhMmU3?=
 =?utf-8?B?eTE4Y2ZnQkxxUjNPMURQMEEwNlNOYll1ZGVYTkoxTzAxQ2ZjOXl4VTZ1dFFw?=
 =?utf-8?B?NkxlWW1Cbm1yQUo5Kzl5SThxT0RLajlDZU5yK0hVYnJEVVZtckU4cnYwL254?=
 =?utf-8?B?TnNwTVExRG1YcHl3SmdqNjdzdWRDRUVrQzArMmcveW53d3RKZnU3THJMR1ZN?=
 =?utf-8?B?QXZOK2pqRGZDbVlZamszZWNMMnRTR0MweWxtNmNpbGxOSjBmejF2eGtvcG9k?=
 =?utf-8?B?L09JZXIrZDMyRzBDTmFDaTVJZU5GQjd5R0tXNUNDaGdabWY2L3BuVkViTTF0?=
 =?utf-8?B?Zkd1L3o0Wm5mV2xuZE1vUVd6Q3ErL1pVRWFiblMwUERmWmxsaTM5dDY2VjNs?=
 =?utf-8?B?NnlncDZOTTlkcmMvL1I1ZzZ2VkdPTGFyT29DbFNIZ2UzU1NiblE4ZnZpSkNm?=
 =?utf-8?B?dnF0bjhpNGJKWTRWM1pFbW04WTV4QUNCZUJmYkpoMjBHWG5tc3p2SkpEbzlz?=
 =?utf-8?B?cnpYejJnaytMeU9CM1grWXc2d1d0Vk5oRWhRQ0VrYlRJcGwyeW5xNVU1dFBl?=
 =?utf-8?B?V2cweFhrYlJ5SzFpZFB5U2ZjR3BpNVo2bmgwdzBlaFJZQnBXL3p5TkkvT3p0?=
 =?utf-8?B?aXVDeTRUMytwbm5uSXRuY0VlbGZ3WFNOSkJBeXE5cGlHZ1ZGcFJZYkJCZjg0?=
 =?utf-8?B?cU9kL3RJSGRxK2lmUmpwcVMvNlU4RG1iNjM4bXZwYlF4ZmZQemN6ellRN1ln?=
 =?utf-8?B?bElib0JMVktPREwxRjNFNFRLb2tZSDRBUmlyQTFnc0NTcVlNdVdJdEt2SDRM?=
 =?utf-8?B?SDZ4MkRXcmh6ZVJzb2Z5YzBLSVFJU3hzNTAvaVJabVMxMHpKZHJYOXVTaWpB?=
 =?utf-8?Q?yZEY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8227.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971fdabb-897c-4589-7a32-08dc36a3f8fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 08:21:46.4601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNAD7gST3SfpM1u0AeIPacQMwFB1GtpCy3Po7yC7A0JLRynEXZu0O8oj+iXLgToxPmw2AkZ5GjiCwuLHRvt6gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7573

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCkhpIFBlZmYsDQoNClRoYW5rcyBm
b3IgeW91ciBjbGFyaWZpY2F0aW9uLg0KVGhlIGNvbW1pdCBtZXNzYWdlIGlzIGp1c3QgYSBzaW5n
bGUgbGluZSwgYnV0IHRoZSBzdWJqZWN0IHNlY3Rpb24gaXMgc3BsaW50ZWQgaW50byB0d28gbGlu
ZXMgYXMgdGhlIGxpbmUgY2hhcmFjdGVycyBudW1iZXIgaXMgbW9yZSB0aGFuIDc4Lg0KVGhpcyBp
cyBpbiBsaW5lIHdpdGggdGhlIGRlc2lnbi4NClRoZSBjb250ZW50IHlvdSByZWFkIGRvZXNuJ3Qg
aGF2ZSB0aGlzIGNoYW5nZSwgbWF5YmUgaXQgaXMgY2F1c2VkIGJ5IHRoZSBvdXRsb29rIGNvbnRl
bnQgZm9ybWF0Lg0KDQpwZXJoYXBzIHRoZSBleGlzdGluZyAtLW5vLWVuY29kZS1lbWFpbC1oZWFk
ZXJzIHNob3VsZCBiZSB1c2VkIGFzIGEgaGludCB0aGF0IHRoZSB1c2VyIHByZWZlcnMgZWFzeS10
by1wYXJzZSBvdXRwdXQgb3ZlciBzdHJpY3QgcmZjIGNvbXBsaWFuY2UuDQo9PT4gSSBoYXZlIHRy
aWVkIHRoaXMgY29tbWFuZCwgIHRoZSBnZW5lcmF0ZWQgcGF0Y2ggc3ViamVjdCBzZWN0aW9uIGlz
IHN0aWxsIHNwbGludGVkIGludG8gdHdvIGxpbmVzLg0KDQpJIGhhdmUgd29uZGVyZWQgaWYgaXQg
d291bGQgYmUgdXNlZnVsIHRvIGhhdmUgYSAtLW5vLXdyYXAtZW1haWwgb3B0aW9uLg0KPT0+IGlm
IHdlIGFkZCB0aGlzIG5ldyBvcHRpb24gYW5kIG91dHB1dCB0aGUgY29tbWl0IG1lc3NhZ2UgYXMg
dGhlIHdheSB0aGF0IGdpdCBsb2cgY29tbWFuZCBkb2VzLCBpdCBzaG91bGQgYmUgZ29vZCB3aXRo
IHVzYWdlLg0KDQpUaGFua3MgYWdhaW4hDQoNCkJSDQpCb3lhbmcNCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmVmZiBLaW5nIDxwZWZmQHBlZmYubmV0Pg0KU2VudDogTW9u
ZGF5LCBGZWJydWFyeSAyNiwgMjAyNCAzOjAzIFBNDQpUbzogQ2hlbiwgQm95YW5nIDxCb3lhbmcu
Q2hlbkBhbWQuY29tPg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBDUiBw
b3NpdGlvbiBjaGFuZ2VkIGluIGV4cG9ydGVkIHBhdGNoIGZpbGUgc3ViamVjdCBzZWN0aW9uDQoN
CkNhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBs
aW5rcywgb3IgcmVzcG9uZGluZy4NCg0KDQpPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAwNTo1Mzox
OUFNICswMDAwLCBDaGVuLCBCb3lhbmcgd3JvdGU6DQoNCj4gRDpcU291cmNlXEN1c3RvbWVyUmVw
b1Rlc3RcUGxhdGZvcm0xPmdpdCBsb2cgLTMgY29tbWl0DQo+IDBjOWY4NTU1YzU1YzczZmQ0ZTUz
OTJjOGY4NTE2YzM4OWYzNjJkMTcgKEhFQUQgLT4gdGVzdCkNCj4gQXV0aG9yOiBCb3lhbmcgQ2hl
bg0KPiBEYXRlOiAgIE1vbiBGZWIgMjYgMTE6MTY6MDAgMjAyNCArMDgwMA0KPg0KPiAgICAgQWRk
IGEgZmlsZSB0byB0ZXN0LCBtYWtlIG1ha2Ugc3VyZSB0aGF0IHRoZSBtZXNzYWdlIGlzIGEgYml0
IGxvbmcNCj4gYnV0IGluIGEgc2luZ2xlIGxpbmUNCj4NCj4gV2UgY2FuIGNvbmZpcm0gdGhhdCB0
aGUgY29tbWl0IG1lc3NhZ2UgaXMgaW4gYSBzaW5nbGUgbGluZSBpbiB0aGUgb3V0cHV0IG9mIGdp
dCBsb2cgY29tbWFuZChwbHMgcmVmZXIgdG8gYWJvdmUgb3V0cHV0KS4NCj4NCj4gQW5kIHVzZSBi
ZWxvdyBjb21tYW5kIHRvIGdlbmVyYXRlIGEgcGF0Y2ggZmlsZS4NCj4gZ2l0IGZvcm1hdC1wYXRj
aCAtMyAtLXN0ZG91dCAgPiAgZXhwb3J0ZWRfMy5wYXRjaA0KPg0KPiBXZSBjYW4gb2JzZXJ2ZSB0
aGF0IHRoZSBjb21taXQgbWVzc2FnZSdzIENSIHBvc2l0aW9uIGlzIGNoYW5nZWQgaW4gdGhlDQo+
IGV4cG9ydGVkIHBhdGNoLCB0aGUgc3ViamVjdCBzZWN0aW9uIGlzIHNwbGl0IHRvIHR3byBsaW5l
cyhwbHMgcmVmZXIgdG8NCj4gYmVsb3cgb3V0cHV0KS4NCg0KVGhpcyBpcyBleHBlY3RlZC4gVGhl
IGZvcm1hdC1wYXRjaCBjb21tYW5kIGlzIGdlbmVyYXRpbmcgYW4gZW1haWwsIGFuZA0KcmZjMjgy
MiBzYXlzOg0KDQogICBFYWNoIGxpbmUgb2YgY2hhcmFjdGVycyBNVVNUIGJlIG5vIG1vcmUgdGhh
biA5OTggY2hhcmFjdGVycywgYW5kDQogICBTSE9VTEQgYmUgbm8gbW9yZSB0aGFuIDc4IGNoYXJh
Y3RlcnMsIGV4Y2x1ZGluZyB0aGUgQ1JMRi4NCg0KQnV0IHdlIGNhbiBtYWtlIHRoZSBzdWJqZWN0
IGFyYml0cmFyaWx5IGxvbmcgYnkgdXNpbmcgaGVhZGVyIGNvbnRpbnVhdGlvbjsgdGhlIGxpbmUg
YWZ0ZXIgdGhlICJTdWJqZWN0OiIgc2hvdWxkIHN0YXJ0IHdpdGggd2hpdGVzcGFjZSwgd2hpY2gg
aW5kaWNhdGVzIHRvIGEgcGFyc2VyIHRoYXQgaXQgaXMgYSBjb250aW51YXRpb24gb2YgdGhlIHBy
ZXZpb3VzIGhlYWRlci4NCg0KWW91IGRvbid0IHNob3cgdGhhdCBoZXJlOg0KDQo+IEZyb20gMGM5
Zjg1NTVjNTVjNzNmZDRlNTM5MmM4Zjg1MTZjMzg5ZjM2MmQxNyBNb24gU2VwIDE3IDAwOjAwOjAw
IDIwMDENCj4gRnJvbTogQm95YW5nIENoZW4NCj4gRGF0ZTogTW9uLCAyNiBGZWIgMjAyNCAxMTox
NjowMCArMDgwMA0KPiBTdWJqZWN0OiBbUEFUQ0ggMy8zXSBBZGQgYSBmaWxlIHRvIHRlc3QsIG1h
a2UgbWFrZSBzdXJlIHRoYXQgdGhlDQo+IG1lc3NhZ2UgaXMgYSBiaXQgbG9uZyBidXQgaW4gYSBz
aW5nbGUgbGluZQ0KDQpidXQgSSdtIG5vdCBzdXJlIGlmIGl0J3MgcmVhbGx5IG1pc3NpbmcsIG9y
IGlmIHRoZSB3aGl0ZXNwYWNlIGdvdCBtdW5nZWQgYXMgeW91IHNlbnQgaXQuIEFzc3VtaW5nIGl0
IGlzLCB0aGVuIGV2ZXJ5dGhpbmcgaXMgd29ya2luZyBhcyBkZXNpZ25lZC4NCg0KVGhhdCBzYWlk
LCBJIGhhdmUgc29tZXRpbWVzIGJlZW4gYW5ub3llZCBhdCB0aGlzIG15c2VsZiwgYmVjYXVzZSBJ
IHdhbnQgdG8gcHJvY2VzcyB0aGUgbWFpbHMgd2l0aCB0b29scyB0aGF0IGFyZSBxdWl0ZSBjYXBh
YmxlIG9mIGhhbmRsaW5nIGxvbmcgbGluZXMgKGUuZy4sIG11dHQpLiBBbmQgZG9pbmcgaGFja3kg
cHJvY2Vzc2luZyB3aXRoIHBlcmwsIGV0YywgYmVjb21lcyBoYXJkZXIgYmVjYXVzZSB5b3UgaGF2
ZSB0byBhY3R1YWxseSBwYXJzZSB0aGUgbWFpbCBjb3JyZWN0bHkgcmF0aGVyIHRoYW4ganVzdCBn
cmVwcGluZyBmb3IgIl5TdWJqZWN0OiIuIDspDQoNClNvIEkgaGF2ZSB3b25kZXJlZCBpZiBpdCB3
b3VsZCBiZSB1c2VmdWwgdG8gaGF2ZSBhIC0tbm8td3JhcC1lbWFpbCBvcHRpb24uIE9yIHBlcmhh
cHMgdGhlIGV4aXN0aW5nIC0tbm8tZW5jb2RlLWVtYWlsLWhlYWRlcnMgc2hvdWxkIGJlIHVzZWQg
YXMgYSBoaW50IHRoYXQgdGhlIHVzZXIgcHJlZmVycyBlYXN5LXRvLXBhcnNlIG91dHB1dCBvdmVy
IHN0cmljdCByZmMgY29tcGxpYW5jZS4NCg0KLVBlZmYNCg==
