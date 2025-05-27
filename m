Received: from de-smtp-delivery-110.mimecast.com (de-smtp-delivery-110.mimecast.com [194.104.111.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647172614
	for <git@vger.kernel.org>; Tue, 27 May 2025 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.104.111.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329685; cv=none; b=iKh27SwNn7rNAkWOmmZe1cE2wkPp341bHnf3RMDDvC8B4p5hbvyqvCWFOIsp5r2Zf92j7xCRYUkbEj7dQnF4Fw1qwfLIor1uGIQHkDCabx+OqP0GzHfahKiM8g5iVKCdnzxa3nB8AouaGmsz6JZ+vOaApZbaYRFNFnUpUeP7kUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329685; c=relaxed/simple;
	bh=NCE5ATuxJL5DfqAkdOfEdTyKAzUdye3R/R+y1Rng9S4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t5rGj7m7Kn79aeCI6lQUG15rUc8KsIWoURWBf1LByCLex7KvlMb+F10tiKy8wd8cOasgTNcCX/LzhF+ZGRW61F1gxbH7UtvFPuQ7Ft4W1vhErBgXoLywtGKvJsYyahTY0JFCwFPDZvodyWIncniHlppze0TPzLIuy6hAeNli0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kisters.de; spf=pass smtp.mailfrom=kisters.de; dkim=pass (2048-bit key) header.d=kisters.de header.i=@kisters.de header.b=iAOLrRGz; arc=none smtp.client-ip=194.104.111.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kisters.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kisters.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kisters.de header.i=@kisters.de header.b="iAOLrRGz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kisters.de;
	s=mimecast20230419; t=1748329680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NCE5ATuxJL5DfqAkdOfEdTyKAzUdye3R/R+y1Rng9S4=;
	b=iAOLrRGzIkkM1cSznbcSLsPfx7yM9YN5IVnDtfAP6XGC2wo80TbwgFYTaxJPvFlsAQ8OPB
	eTjuvdYPG6pwH6oEd6rqY5/nL7OpS1ZqytPZMU1VMsLvSdicX4ovFfsJ5oZXBakP1EwqfW
	ElFZqx1YeCi3RsgxzZrv0kcaXPx8qBVHkr/LKyn04v+Mp32/aidaqyrPj51GQ6D00pxgRr
	esU7ud9YzIPL9AfjkcvBMlfyyt5X8Jmex95D4IEkmzilM1UzU3GCBMFu+fLKip6dDdr+wi
	CcHIgxGhhtJHP2pUsH03DohCT2WHVgZ+9basmwddHNdKokwv3g/XFX8fLMMAPw==
Received: from KIS-NSP-GW03 (51.116.141.177 [51.116.141.177]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-63-lsvH7pE_Ph25p8asaMNBYw-1; Tue, 27 May 2025 09:00:46 +0200
X-MC-Unique: lsvH7pE_Ph25p8asaMNBYw-1
X-Mimecast-MFC-AGG-ID: lsvH7pE_Ph25p8asaMNBYw_1748329246
Received: from 194.104.110.241 by KIS-NSP-GW03 (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 27 May 2025 07:00:46 GMT
X-MC-Unique: EFKFGMpXNaeu1c4G4a1Obw-1
X-Mimecast-MFC-AGG-ID: EFKFGMpXNaeu1c4G4a1Obw_1748329242
From: Ulrich Wittenberg <ulrich.wittenberg@kisters.de>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Bug in git branch --show-current
Thread-Topic: Bug in git branch --show-current
Thread-Index: AdvO1LjeRgAv04nBQxGEZno694i9CA==
Date: Tue, 27 May 2025 07:00:37 +0000
Message-ID: <FR0P281MB28795FB4A108A6044273B39C9464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2879:EE_|FRYP281MB2304:EE_
x-ms-office365-filtering-correlation-id: e5fc2369-968a-4a49-21c8-08dd9cec2efa
kis-sig: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|38070700018
x-microsoft-antispam-message-info: =?utf-8?B?WWdRQlRoWE1uRk81czA1Z3pVcnFVRjR3eXQ2YVJxbWlLbG1ET3FQUy96c25s?=
 =?utf-8?B?NDMwaG16RWptZ1QwNzdZeWJkdWRUOGRpUlc1blV0UUg0MnJ2akVqbVZaSlNj?=
 =?utf-8?B?WTBycnl1ek5QV1lmcVFaMHlvQ1VPNmVMdkdQdSt1dUxKYWpwak9LaUtPVWdq?=
 =?utf-8?B?eUV5YzVaYTVncHExSnRpUFJFRFpvRUFRTlc1ZUExb2RTSW9xbkIxM0RaWW5W?=
 =?utf-8?B?TmlKa2FZWUJQTUZEeGFSZmtPWXRoVmJzYVR5QWVpZ3M2MG40VHdjcFN4R3dx?=
 =?utf-8?B?NzUxajNtMlFVZ1pRRjAzQlhVN25YSS9URmZEMENpT3R0RFlhMjQ3WGpMd284?=
 =?utf-8?B?eTg5S2Y5VzlCbmNmUFhGTit0cThuQVREMUZuTzBNRkQrazJxWGxTcTJBejdj?=
 =?utf-8?B?SzJ6WjFKVkc0UWlmaVFEU3A0QXFhUVpMNjdtV0U3SXBxSFRFaUEvMEpUNmFo?=
 =?utf-8?B?ZUJ4UmdoUTNGQ0hacWx3bURWS01tZk1Pa2ZINVpjdGphcldzeW16NG85dDJJ?=
 =?utf-8?B?TGx4Z2VHRGtpZWsyLzlObDRKakFTUGJ6WE16MFZ1UytpNkJKbU43NkRjZ1Y5?=
 =?utf-8?B?Q0xEL1k2dERUR25Wb1dneGNQZngrS3RaU0VMY2k4OVMveFJVbVZBd2daZ1o1?=
 =?utf-8?B?VFlSWVlvWDRGNEhkS3hJT3NPV2gxU1FkZXY3UkQ0M1Q4Q1k1RkYyeW9HM0E3?=
 =?utf-8?B?YUlHRmtreGlHQWtUN0ZFNnVOSzBBWmR1VmJWbHYxWmNpNEtiL3ZkQ24xVmlG?=
 =?utf-8?B?Qlg1REw2czhyRmloT1Z5SDAxVFR0QmsvOEtTV3FBeGlmNFR5Q0JxS0xXUUoy?=
 =?utf-8?B?dXdKUDNKOHUyTmFmTGtLVWFYZ3ZFWmF0c0k2dENtNE12OFY0RUdvZlU3YTJW?=
 =?utf-8?B?T05OTTFvMTNzeUNsaFdaaytSWkdLaXJPTnFqWDIxZ1pjZm4rZzRUTmJPQ0xx?=
 =?utf-8?B?MFR2OW5FZkRGV1I0SlhWWHNvRVVHczdUWlFLU0xMdktic3dFaGhHdDhVM01M?=
 =?utf-8?B?MW1GMGJ3cjBKRHIzMGJYRTFWSXEzMXNQdEgzVWtJZDZBWnJwTmRYbURiY1c0?=
 =?utf-8?B?RGJrL2ZyM0E2aFN3QWtyVVA0ckpxU2JRVzNDUXMxTkNwMHdidGdsNUYxbERR?=
 =?utf-8?B?WHFOT1IxMmFDbW1NdXpLSGFoclVQcnlUMGxoUkFxMzErS3VLY0JOZDU1WEw1?=
 =?utf-8?B?OWxUWThRUis1ZHlYdXZJbnF2bFpaQTIvOGFJTURQNVk3d09XZ1A1Mm9RMkhE?=
 =?utf-8?B?MzJUVHpsN3RHRHM0cWhMYkVZcm1aYkN0TE1qUDJla1NOL0w3NWFoT1ZoRk5i?=
 =?utf-8?B?WkdsdkIzSE11RDFZN3VxYytneTF3Y1Nwd1hBYlE2R3RwZ2w2RXFmUlF3OERz?=
 =?utf-8?B?SUFtNmx6ZmZiQXNDTzlyQmd0WlYvYTFScmFPR2NnUysxTjdhRlVHRnVvVXhw?=
 =?utf-8?B?S2R4S3dXdlRYcVhFdVBSRFZ3QTNGaTE2UlJ4NUxnQmxXM1hPOTAxTlNGMzhI?=
 =?utf-8?B?WUFEOGtRTHRPMlJ6NzNPNW5CSkh0ZjRXb0lRM1grNEhnbkxzOXErTzVZV2xa?=
 =?utf-8?B?Vjh0ZXBjTm5ianpkVU9YRktNRFJXNXlDU1dRQ2JvTkk3Mm9IQlRDQWJKSGxx?=
 =?utf-8?B?TElUeEZpS2xUN3d6cmtWODB6dGh0dGoxcXUrZVVNRGZaajdGcXRxOTh5cFFz?=
 =?utf-8?B?a1hud1FRR29jRnROekRVclVLSGZNNzZLbU9DWlBvZWxkTnhrOFQ5Zmk0Snp6?=
 =?utf-8?B?ZHQ0ZmsvbkUxZzY2djdOZXNLY2l5U0JlMFY2NThtYkpub2YvbXVIU3dhd2Nj?=
 =?utf-8?B?UmhlMnk3dUx4a0thdEozMjFIVkwwdjNYYlBTRU5iNnJnMmVvKzVBKzNpVSta?=
 =?utf-8?B?a0ZXUGJhY1dJbzJyc011OC9VTkZkTEdDZC9ydzRSNzNFdFBEZjRORXBTaEJ2?=
 =?utf-8?Q?3uO1pVN8kks=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFphclQwOVJZaDVwZ1Y2Zms1WVN5bXJzMkRGbmdyeWt2eXcxclZIYitoSGVU?=
 =?utf-8?B?UjN3aTVoL2d6RE9lRHhUV2Z4ZVY2UFl5QTIzVXF2ckpXT21CdzhPVmYzRFY2?=
 =?utf-8?B?TWJ4bHlvUWhRWW1wcnVzVXlaTVEwYlU1VGl4LzEvbWdLSUEyR0NzMW5WcDJu?=
 =?utf-8?B?S0puL0ltaXExUURkaHBFam9iMlhrOE1EM3oza1paVGY0eTIyczRKTjF1WjA2?=
 =?utf-8?B?NnVLUHd2T0dWQlZ2bWtVQVdrcFBlcmZXRmxOY0NhTmQ4ZjdzVS82SFpwK2Zj?=
 =?utf-8?B?bGpqcnZ5QTAyMjA4eVNRcVVaT0theUF0dDdicjRXb0U0V0cyOFUxa3NjTnVD?=
 =?utf-8?B?OTgwMm5rUndRVUJVRWFDRHMveldMVmRWT0xMemRuK0I4T2JKUSttM29LY004?=
 =?utf-8?B?YUF6VktmQ0FTMmROS0FnUyswcVo4dSt3Q0Mxd2NFcU9TaWs0UlovdDA5VEs3?=
 =?utf-8?B?SGZMeUQzNklBaUU1TGsvZ3hndy9sOXk4NkhURUgyaW8vbERsZmFKdXMydGY5?=
 =?utf-8?B?L1NHaUUxSWZuWURBbDdtL0tCa0NCb3I0cHkzanFrTkZTdnJhMWRIdkxYbnpx?=
 =?utf-8?B?emhKekJhSVNWWVhndXpJZXl1dUJnQkVLdldNL0JzK01rTkVmdkQzb2tOUGcx?=
 =?utf-8?B?cWQ0WmRmQTRYeXlGalNqczJNRDdBdXlWVUVQVEduS21BMWJBUDRKamV4Z2ZY?=
 =?utf-8?B?Wmc3a3h3K20yVjNvamk0c3VVeTllNVZnVFBDd1RpOTlycjE4MXVzTC9tQ2d2?=
 =?utf-8?B?TE1qLzZWMS9Vc1ducWhDaStmR2M2NTNxQW9JMVdza0hhSUJXaHlRK3pzYXRw?=
 =?utf-8?B?SDc0bHFJZW1wRDNwWjR3OHBIMWxHLzNZZnFZQ0VlQ1QzVVN1WDlGNThLMFNo?=
 =?utf-8?B?SXIzdDNIcXU0ZlJ2WjBlRWdPQlkzOUprcGZzSDJXa1BQZ3huY3hwYTRLSDBz?=
 =?utf-8?B?QldLOVNZdk1wMk1uTWxNazFuQjBUSVNHenNpWHkxZklMb2VRbTljS2craGhq?=
 =?utf-8?B?QW52VHFFczJnVFk1MTl2bm15SFUvRVJBUGJEd2tJSEk0QVZZSlFKMXhCMWlp?=
 =?utf-8?B?bythQ2xRdzZPTW0xQ1hVbktFTkI2V0x1Zk5PUTJKeHcrcDhkRkUwcjFKUzNi?=
 =?utf-8?B?RHdNaHF0bzBJYXcrRHErLy9LVGJYSDFNV1A1Ylc2L2JIV0czcVkwM0tRRFhq?=
 =?utf-8?B?cmhuekpnbnpTQ1pFbXA3bmNpcWg3S1cxZTZjYmR1aTNjbXlQc0t3OFNIM3lT?=
 =?utf-8?B?anpidlVmOUtTUEt1RUl6RjNMQWcvQzhlMmxRSjA3VGV3ZkJPR2JnV0RzTFRN?=
 =?utf-8?B?TWhiN1FQWXp0eG40d3o2Q29FR0ZMcVYwYW1ldmI5QzJCdytSZ1ZFRzFVaUQr?=
 =?utf-8?B?ZTl1WFkyOEh6Rm1odUo0eXZSc0RLV0wreWRhQjlZYUU4Y1RsVW1NcE54S3Iv?=
 =?utf-8?B?N2VpTnpPdjlTZE05ZUliVm93ZFhxLzY0bFdZVWpKVzhXYTlzZmRLRnc0eUZj?=
 =?utf-8?B?K2ZaYnF3YkRtRzRMMFlsdWRwQXRHdXlXL05PQzgzWTB6ZVVnUFlqZnpSNGo4?=
 =?utf-8?B?dFJnRkVCa2RwcFFpemk0ZVhmQXBMMGROVk94bzc5dGxWc0NLeVQzRFRmY2lj?=
 =?utf-8?B?Ujh3bFRqSTc2cUtYNTdVaW1uTVBuOFFZTEJQMG5WS2NFek5NUmVraUN1ak9O?=
 =?utf-8?B?a3NYQURuZEVJOWhHbUdhektYRXdJZWRPd01OU0k4cUFyQXFTb3dOSGlQNjlK?=
 =?utf-8?B?TmpHVWkwTHA0Q2YvTkFQeWVLQzFUSjliQlNCazFUSGE3bVdXNlRxb29FU0Fs?=
 =?utf-8?B?ZUQvUFhhbUdaUVdJZ2FKNzNoQjFHUy9PaUdSUG1NbHR3SnIrQTBKRkN6MlVz?=
 =?utf-8?B?Q1FsWXNWUjRRV0RXNVR5K0ZKM2UyQ3hrbXRIODFLb3Fxb1lNVmxYc1RyNHpH?=
 =?utf-8?B?cGJqUVFSc2k4NWduOUdXR2l6V3BoMWZhb2t2cFh5czRrQThCcG82SUhDSExx?=
 =?utf-8?B?cFVrdjJ1MDBqQWZRc3R5L1ZGcmZNTngxM0JockQyNUdlU0dTUy9YN0EvU3BQ?=
 =?utf-8?B?cTh0LzUyTjdad2lidDIvcVIwNGZTVVU3MnpVMUwxQmhyUVVvbHRvUC9tYzlS?=
 =?utf-8?B?UkJCakpVVDY3VndsUjB5NjQ0TFQvOWFXM2xtOUNEc205Sm8zNzBqQVlYOWht?=
 =?utf-8?Q?wF3bXVYG5WTr5HvU1QquG9KzxWGXwfbDzJ1RklpG5PmX?=
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kisters.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e5fc2369-968a-4a49-21c8-08dd9cec2efa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 07:00:37.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6edce190-533b-4274-8213-bdd14c9bd42e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trmigi/btWIpf0ljdP2iKL0xqV6OnsUXn7ryqDZUQy1BJCeEpuIuPUd36j4SvtfOzIp7neo4KDVeJUAGVA0xADN09snVH1Qj6KjUtNxugDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRYP281MB2304
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: x13nSgj3Nz_Hcx-4IrAwC02xP0Y0ytHw5wYqL4LdMlo_1748329242
X-Mimecast-Originator: kisters.de
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

VGhhbmsgeW91IGZvciBmaWxsaW5nIG91dCBhIEdpdCBidWcgcmVwb3J0IQ0KUGxlYXNlIGFuc3dl
ciB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucyB0byBoZWxwIHVzIHVuZGVyc3RhbmQgeW91ciBpc3N1
ZS4NCg0KV2hhdCBkaWQgeW91IGRvIGJlZm9yZSB0aGUgYnVnIGhhcHBlbmVkPyAoU3RlcHMgdG8g
cmVwcm9kdWNlIHlvdXIgaXNzdWUpDQpUaGlzIGlzIHBhcnQgb2YgYSBKZW5raW5zIGpvYiwgc28g
Zm9yIHNvbWUgcmVhc29uIHdlIGFyZSB3b3JraW5nIG9uIGEgZGV0YWNoZWQgaGVhZA0KDQpXaGF0
IGRpZCB5b3UgZXhwZWN0IHRvIGhhcHBlbj8gKEV4cGVjdGVkIGJlaGF2aW9yKQ0KSSBuZWVkIHRv
IGZpbmQgb3V04paSd2hpY2ggYnJhbmNoIHRoZSBzY3JpcHQgaXMgd29ya2luZyBvbiwNCnNvIEkg
dXNlZCAiZ2l0IGJyYW5jaCAtLXNob3ctY3VycmVudCIgdG8gZ2V0IHRoaXMgaW5mby4NCg0KV2hh
dCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KVGhlIGNvbW1hbmQgcmV0dXJu
cyBhYnNvbHV0ZWx5IG5vdGhpbmcuDQoNCldoYXQncyBkaWZmZXJlbnQgYmV0d2VlbiB3aGF0IHlv
dSBleHBlY3RlZCBhbmQgd2hhdCBhY3R1YWxseSBoYXBwZW5lZD8NCldlbGwsIGV2ZXJ5dGhpbmch
DQoNCkFueXRoaW5nIGVsc2UgeW91IHdhbnQgdG8gYWRkOg0KSSB0cmllZCBzb21lIG90aGVyIGdp
dCBjb21tYW5kcyB0aGF0IHVzdWFsbHkgYWxzbyBzaG93IGluZm9ybWF0aW9uDQphYm91dCB0aGUg
Y3VycmVudCBicmFuY2gsIGJ1dCAqbm9uZSogb2YgdGhlbSB3b3JrIG9yIGV2ZW4gc2hvdyBhIGZh
dGFsIGVycm9yLg0KDQoNCltTeXN0ZW0gSW5mb10NCmdpdCB2ZXJzaW9uOg0KZ2l0IHZlcnNpb24g
Mi4zOS41DQpjcHU6IHg4Nl82NA0Kbm8gY29tbWl0IGFzc29jaWF0ZWQgd2l0aCB0aGlzIGJ1aWxk
DQpzaXplb2YtbG9uZzogOA0Kc2l6ZW9mLXNpemVfdDogOA0Kc2hlbGwtcGF0aDogL2Jpbi9zaA0K
dW5hbWU6IExpbnV4IDYuMS4wLTM0LWFtZDY0ICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgRGViaWFu
IDYuMS4xMzUtMSAoMjAyNS0wNC0yNSkgeDg2XzY0DQpjb21waWxlciBpbmZvOiBnbnVjOiAxMi4y
DQpsaWJjIGluZm86IGdsaWJjOiAyLjM2DQokU0hFTEwgKHR5cGljYWxseSwgaW50ZXJhY3RpdmUg
c2hlbGwpOiAvYmluL3pzaA0KDQoNCltFbmFibGVkIEhvb2tzXQ0KDQpVbHJpY2ggV2l0dGVuYmVy
Zw0KU2VuaW9yIFNvZnR3YXJlIERldmVsb3BlciB8IEtJU1RFUlMgT2xkZW5idXJnDQpHZXJtYW55
DQoNCnVscmljaC53aXR0ZW5iZXJnQGtpc3RlcnMuZGUNCnd3dy5raXN0ZXJzLmRlDQoNCg0KDQpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KVWxyaWNoIFdpdHRlbmJlcmcgLSBFbmVy
Z3kgLSBLSVNURVJTIEFHIC0gSGFzZWxyaWVnZSAxMyAtIDI2MTI1IE9sZGVuYnVyZyAtIERFIHwg
KzQ5IDQ0MSA5MzYwMiAtMTU2IHwgdWxyaWNoLndpdHRlbmJlcmdAa2lzdGVycy5kZSB8IHd3dy5r
aXN0ZXJzLmRlIHwgSGFuZGVsc3JlZ2lzdGVyIEFhY2hlbiwgSFJCLU5yLiA3ODM4IHwgVm9yc3Rh
bmQ6IEtsYXVzIEtpc3RlcnMsIEhhbm5zIEtpc3RlcnMgfCBBdWZzaWNodHNyYXRzdm9yc2l0emVu
ZGVyOiBEci4gVGhvbWFzIEtsZXZlcnMNClRoaXMgZS1tYWlsIG1heSBjb250YWluIGNvbmZpZGVu
dGlhbCBhbmQvb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbi4gSWYgeW91IGFyZSBub3QgdGhlIGlu
dGVuZGVkIHJlY2lwaWVudCAob3IgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvcikg
cGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMgZS1t
YWlsLiBBbnkgdW5hdXRob3Jpc2VkIGNvcHlpbmcsIGRpc2Nsb3N1cmUgb3IgZGlzdHJpYnV0aW9u
IG9mIHRoZSBtYXRlcmlhbCBpbiB0aGlzIGUtbWFpbCBpcyBzdHJpY3RseSBmb3JiaWRkZW4uDQpE
aWVzZSBFLU1haWwgZW50aMOkbHQgdmVydHJhdWxpY2hlIHVuZC9vZGVyIHJlY2h0bGljaCBnZXNj
aMO8dHp0ZSBJbmZvcm1hdGlvbmVuLiBXZW5uIFNpZSBuaWNodCBkZXIgcmljaHRpZ2UgQWRyZXNz
YXQgc2luZCBvZGVyIGRpZXNlIEUtTWFpbCBpcnJ0w7xtbGljaCBlcmhhbHRlbiBoYWJlbiwgaW5m
b3JtaWVyZW4gU2llIGJpdHRlIHNvZm9ydCBkZW4gQWJzZW5kZXIgdW5kIHZlcm5pY2h0ZW4gU2ll
IGRpZXNlIE1haWwuIERhcyB1bmVybGF1YnRlIEtvcGllcmVuIHNvd2llIGRpZSB1bmJlZnVndGUg
V2VpdGVyZ2FiZSBkaWVzZXIgTWFpbCBpc3QgbmljaHQgZ2VzdGF0dGV0Lg0K


