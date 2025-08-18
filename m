Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011035.outbound.protection.outlook.com [52.103.72.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D2272E53
	for <git@vger.kernel.org>; Mon, 18 Aug 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545390; cv=fail; b=GohKQbuvgxFPEuxQ4/YyfaVr+zezTOkIn8eSAuVMt2Jrz18T02gv7yR/pJgbLDqhDjLLV1eMdjBfWHgijoke2yWFX0YxAqeav2R6OfQJ9IhtMipn+MLwSd5gWIn+esBTJejRax1EOoD0NPXkFVI0zxYcItJerR0N1bncovCu9A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545390; c=relaxed/simple;
	bh=9/so1ceViHuOzQKsyf3Yg07n19F/tx1R0+gK6BXE6fk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kwImGAcW1+Yr7F7/C3yG/MpmmKg+Uf61g1ULUYDuM3PylRO8o3sYvPM9Zu4pw7kJfe1KyOCnybAffXUMLZp+3YgCuF+0InEwn0DYRfJX7JibiDShs/OwjTQy/4REnBnBLsrIV67HXoUe8uxnYUZOLfA8S5GJ5h1fbQii7xXdVvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au; spf=pass smtp.mailfrom=live.com.au; dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b=lBjRFJU6; arc=fail smtp.client-ip=52.103.72.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.COM.AU header.i=@LIVE.COM.AU header.b="lBjRFJU6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN9TtulsXD4DYO/iY6UbB0mgfWm6xnoUQullEYT2M9vT2z9GKOLfrz28W2eId5sxcfOFllzdU2YteNtSx+q7eJ0m8QQPs+GNmFQxrv8liYerXGJIblI5XBFtoTXc0jwIRbn4R/+KuVC0sqU61yGCBdJjEOE656/JW0IhTdFFti4a0r4ldmYNCoi7vZATlDf2nbpejpWL5qT17Qq9CTXuKFeH5i67H+Y9U17bcje12k5pmMOf337t7+gsHG+dht/qHtKsKDTSUZ731KIBlQnFQXhGX3FiBlmlBhwYFZ/ZDA5v9nA6OSP1pGqZ+af0zAan2GbZXSkCMLb7NWq15Elhsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/so1ceViHuOzQKsyf3Yg07n19F/tx1R0+gK6BXE6fk=;
 b=FYlAqkOPb8f91uELkuOAnkkNhwYV/0Re783/lRjXrarfP6/2Nd8JIHmZS7vd7lZdt8AZGjPb72y5wTMairnF9wKh/TetxS/HzQfVcOlE6J8EisAKq1p2EoAHWAUMmd+D7gtwde1Wvez1boH4FQPIM75qBWglbPNX+2VxA2MAGLKoVPSatg++a+i8jl8ZttnZ3zolrJW/+44tx5cNde/CkRHXIjTgvGDDZN0gVUnP3KiXRN5ik6pBYmicG7OKZglpJqsxO4gfho39IuE4hGnLMtThtJesWt2IanQWKYzUUyFVBTiWbOyAv02j3uRbpFb7erVYErNzt0NAtQg/KLn34w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.COM.AU;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/so1ceViHuOzQKsyf3Yg07n19F/tx1R0+gK6BXE6fk=;
 b=lBjRFJU6bQ+LzULGfNUBLhDcr7g0gdZF+wVOjjudxQIg6NTohH4RYZR0iXKXD9VGntmZmnmkS1ut6URPuA/XzY7rfH8abS+RRiGbOZrXobT1mVwW4i//JO4TFjmUtv+j5FjlBEmlBys4m7bAWswNYncryP86KDIXzv+13X8e/8ZaiylyGo+Ih0GryAMFPHIIBte1bB5iArDgFnThXuDL/gp6demgN5W61kCFvm5t6I+SLwbcTYuRQBs+5Hw/MsCMrYBpQ3MvMENiXkU6TTvH5zRAdScCOdMG0bQma5Wgea8g/hzz08NJmWZvFy9nqVlYMKPU+gicuAuAWKqjg209bA==
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:156::6) by
 ME0P282MB5284.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:239::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Mon, 18 Aug 2025 19:29:45 +0000
Received: from SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc]) by SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
 ([fe80::942e:8672:69d1:38dc%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 19:29:45 +0000
From: Isaac Oscar Gariano <isaacoscar@live.com.au>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [Feature request] allow git rebase while already rebasing
Thread-Topic: [Feature request] allow git rebase while already rebasing
Thread-Index: AQHcEGhGq/X2rE8Q80WKJjnBKrqDXw==
Date: Mon, 18 Aug 2025 19:29:45 +0000
Message-ID:
 <SYBP282MB29631756F18E53B16F2550848C31A@SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-GB, en-US
Content-Language: en-AU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SYBP282MB2963:EE_|ME0P282MB5284:EE_
x-ms-office365-filtering-correlation-id: 7a1e6f6e-7b71-4ebf-1c80-08ddde8d9680
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|15080799012|15030799006|19110799012|6072599003|31061999003|8060799015|8062599012|461199028|3412199025|40105399003|51005399003|39105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?emdpUXZsZFROUU0yNFkxZTM2KzNXSm5xd2hNNnJZSWk1YUJRdmpFckd4UGRM?=
 =?utf-8?B?S2twL3NSMFppWFNhVnhxUzNvSWd0aEVWWlA2aG1leWc0eGV2aWIxckQrSkRo?=
 =?utf-8?B?ditWMzFEclhDeFpxVkdqZWpYWENaT3VRT1dCMU5yUnVVTmE2SnFyajIxY2cz?=
 =?utf-8?B?d3ZoY0lFZ00yRVMyMERRcWhJck5rUTJMemh1THQxV1U1MG1JQlNaa2xHR2gw?=
 =?utf-8?B?VnM5L3U0Nm5aNlhFK1hrOEdmOEk5OS9mN2JYekdBYW5Ga1Y1V3lQQVBPTTZr?=
 =?utf-8?B?MFQ0U0xidU44c3Z4TEg0dExlZzRpbStwK1ZNOHFJeE1VRXNOUjZ2UFpVR3Y0?=
 =?utf-8?B?M0dyR3NHZXZSdzR5ZFdnWFVZbDUveDRzU2VqZXpsSVBkZDJlRDdmbXo3USto?=
 =?utf-8?B?bVBsZ3plMjkxVEdJL1ZRUWlPQi9YOHNkZFRBN3NZc2FDY1NVYjRKbGJsVDcx?=
 =?utf-8?B?YWFCTkZ3UVZYSzRCL2M4Z0dnVFdHS1pVTXdTd2NoV1VsdDU0cmt1N0RkRVo5?=
 =?utf-8?B?cXlIdWlpeldUYmdITk1IK3EwZzI3dEJJbCtSMFRYZlpXNnpoRTJ1SVdLWlBG?=
 =?utf-8?B?a1pMVm9BMHJSOCsvRkRzeFdrZy9yNWR1Ymt1Nit4SWp0Q0daYWxpOVNiNmM0?=
 =?utf-8?B?aUFaQVRRK251MHRFSEtGcE5odDVMdm8xb3FEalpVMTlMbTA5OU9aUCszKzZK?=
 =?utf-8?B?SS9MeVZGZGxKYnJmYTZReE42c242NWZFZUpCV3dVek5ydzFnbDdVOS8zelh1?=
 =?utf-8?B?akoxS2F4T0FlMzcyNmY3OVN0cHBVS2RCL1c5TEZxL3JLUDh3Y2xDVENBUnN1?=
 =?utf-8?B?Ri9ZUnlUZ0FmU01MN3N0c0N3Slhid3dDV0s1SDBOMGd2Q0FmaHptTG5UUjZS?=
 =?utf-8?B?Slp3OGg2cWx3SStYUWVKbXBGZEdKZFhvbG1vWUpYWTNtR21EUkdWWUYydm9l?=
 =?utf-8?B?UEVFdjhjZWxPTFRSQk9BTFBiOVRxUERodGNXZk1jSXlNS1MyYjQzVGlkZjBT?=
 =?utf-8?B?VytCM2Yvd21FamgwaW51RXB0QXEvRTgzdnVJbm9qNHQ0SCtSWnRidjFwZVJj?=
 =?utf-8?B?OTVPdXlnZlNxak9yMXV6cU8vMTV2NFB1YWwzdklYZEJ3U2hoWGJoQ2dqTXND?=
 =?utf-8?B?KzZZN1FZck5UOHpYQlcvd0dqR0U1VFVyL2JydVp3MTlFL3JiUUJRVXJVVE82?=
 =?utf-8?B?M3YySnhGb3QyYi9WMGxDbmowZVI5c0VLamdSWXNCWFZKOVI1U3FhYlpETGRK?=
 =?utf-8?B?ZE5OTFVYL2prSHUrdFZtUjBVdVNtb2VOSElTNE1mUTN1cjhhUU1GWFFYLy9w?=
 =?utf-8?B?MS9telI1QkN5bHh5bkxBNVBBOXpzOEpVTWJvM2VnbExzOXlPWTQwR3BXY3R2?=
 =?utf-8?B?WS9nRCtlS0t5Z0tERVJTSW1ORlpqeCtUUGcwbXNVU2h1US9wWkpkSmZ3ekNi?=
 =?utf-8?B?WlJHKzNSOWJrVnYvM0M2ZHZtY2RFVFRrOGxKMUdLNkJqWlptY3NhbzJjRy84?=
 =?utf-8?B?V1JtSFIyVzRoWGdZMjVvaVJkUkk0ZWRicnVhMDI0VG1zQmMwdUp2WDR5bWd2?=
 =?utf-8?B?cEs4RmdadlhtWVB4cEFmTzA3eElOZmttaDN2OWgzb2p2MmtDOGxmN1c2S0dr?=
 =?utf-8?B?RXJJQzErbXAvZ1pyaVFqdlZRclNNR3F6Y05VUWhhMjg2MVhVZy9wcHQzOFpa?=
 =?utf-8?B?ZW0vcTk4V2d1eG90SEJiUTZGUEt5TUFHOEhKbGowN1FTZGdGbVFrcFM1aFNy?=
 =?utf-8?Q?pPLEzSpSXgh6TwOMk/+ZTQqxmhpRKP5+Qu6GITm?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?THoybThhRUNXUzVNT2VabXF0M012WTlOTTg1cmFLSHpOZTZpNGg2RGVhYXVQ?=
 =?utf-8?B?MlFza1dwRHF4K0RENExIS2NzSnBiaE9UaHZOdTZsOU1DNW4zVGxOdVo0NWk4?=
 =?utf-8?B?cFg4S0ZESzd6ZE45cGJybHR4MGg0aW8xclBjZVlIOGtjTnJDRXMwSUltZUlx?=
 =?utf-8?B?NVBIV1pQbFVLY3l6dXp5c2hZK1J0eW54VmN5SEJib3NxSWM4U3cvQllGSTQ3?=
 =?utf-8?B?b2xmQlo3RE1aaUpNbXllNnRKWVdJMllObHF4djBUdXdkdzl0d2tiZTRjVWl5?=
 =?utf-8?B?Sk56a1BvYUNobERWZkJhRS9QTXdRaGZTblhYMDk0Q1FwN1hhQmc1R2xiWWhx?=
 =?utf-8?B?VEgrUitPaDFZa285M1VqZ2xyaCtHN0c1VG4wVElGZjhENlQxZVExdFBFQ0RO?=
 =?utf-8?B?bm1VM2MrQUh6SnMvMXpCVGhlajE4OTFYSEdDakhMQXBwT1R5UWR0MCtJTGRk?=
 =?utf-8?B?eUZNVGhKQlFWMU9DUjUrNk5UWXA2VTdCWDAwcTZ0dW9pUFFHNU1naTRPRVky?=
 =?utf-8?B?OWs2cWVMWElZb1lqZHJKc3plMG1SYmlnMmpNak1FWkNZZUFoTS9xTVluV0Jw?=
 =?utf-8?B?c0JKVTNIRUdjcDFyeE4xdi9FRnpwU0pqa2dqMTFONnVXVUQxQnZmUWk4UFc5?=
 =?utf-8?B?eVpPYmlwa2ZEZko1S2lrVzV5UFU4L2tpT2ptYzRDNE5IVFcxTjVObnZTQkJQ?=
 =?utf-8?B?OHJwUnArN3A4ekR6eHJQUzlLaWxjZDhDc1gzMnowOFNBNG1QNS9QZitkVXVs?=
 =?utf-8?B?SzNUdXVkUzhxOGV2TWhUb0dWVkxQNyt1WHJDUEl4NDJqRzJjN0Z3SWM4MUxo?=
 =?utf-8?B?aGxPZDAyUWx0NzhVVGJpRTI4dWxJQzhFelpNTGQrb2pxUFVGZmxMVG9yR21H?=
 =?utf-8?B?MEF0NGMyRlBhZUZXQmd6YkQ5K3ZaU2FyKzJ6VS9VYzZ3RU1VUVdQNFYyTHNv?=
 =?utf-8?B?R0ZrOVQrK2d4b0I4TFNVLzZjMEFoQVU4MThPaG5MSzJQNWdycXl6UWdaVDVR?=
 =?utf-8?B?cFFlSHROU2pvZDI0b0JpaEIxRnp5amxtUGo3NDNvNWN2WmtzSFA1K2FaUlht?=
 =?utf-8?B?WE9uQ0pnWndIRWVSbHZqMEsvbXF2NEUzZ0szWmdVZy9ablhPS0M5OFI0a1pY?=
 =?utf-8?B?VEo5RStNYWJKQy9yR2ZCcURvL1dJZTdvK2l1Y28wV3VyVUZQVE1reXFDWWpK?=
 =?utf-8?B?RHZvVlpHeVlhbFNJZThKUURNZjBidVU5cXBMY0krWG1WVkZ6LzNEWVNqWW02?=
 =?utf-8?B?NE40SkpBcTJibnNQNFZZRXpwZFc5WjFhLzVuMFBQTzl5YmllL2V4UGlxMTFZ?=
 =?utf-8?B?RFhmZHczMGIvSUhmUTlqMUdvMDV6b2JiRWphdndsRWlFRFFFNmZuN2lqcDFr?=
 =?utf-8?B?L3YzV3hDSXRqcUhuSWFqZmdVYXhDN1J3cEQrdnJoR0QvM0ZlVUJ0ZmFUNEo1?=
 =?utf-8?B?b1F5T0E0ZFk4cThzWkMzS0tEY256TDhCbHZhdmt5cWVVTnpteEtUeUs3cE84?=
 =?utf-8?B?dTdoZ09RVTBvTkVYMXJ1NVpFenRLdHZrUG5lMmh4OEZVRW1CYXdCN2QzOVY1?=
 =?utf-8?B?Wk1BL0QwMG9qVFgwS1ZPOWUzcm51S1d5S2sxZXRSWE5vb1JaQzZlY0QxVkZO?=
 =?utf-8?B?MG52YzJoQzdKVFhCZEJBZWhtS3VhTE1iNUp1eGJOVnhwWjFnU2Y1bjdCTFQ5?=
 =?utf-8?B?SHpnUGNIMFppUXZ4bVpBOGloa21EOWFCQ1R0MUl5NlYzSXc4dTlyTkJ2bmVB?=
 =?utf-8?Q?ByeIjp/qk6V2HzvgIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-26b36.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2963.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1e6f6e-7b71-4ebf-1c80-08ddde8d9680
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2025 19:29:45.2599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME0P282MB5284

SSd2ZSBiZWVuIGRvaW5nIGEgbG90IG9mIGludGVyYWN0aXZlIHJlYmFzZXMgbGF0ZWx5LCBhbmQg
SSBvZnRlbiBlZGl0IGEgY29tbWl0LCBjb250aW51ZSB0byB0aGUgbmV4dCBzdGVwIG9mIHRoZSBy
ZWJhc2UsIGFuZCB0aGVuIHJlYWxpc2UgdGhlcmVzJyBhIGNoYW5nZSBhIGZvcmdvdCB0byBtYWtl
LgpOb3cgdXN1YWxseSwgd2hlbiBJIGZvcmdldCB0byBkbyBzb21ldGhpbmcgaW4gYSBjb21taXQs
IEkgZG8gImdpdCByZWJhc2UgLWlyIDxiYWQtY29tbWl0PiIsIGFuZCB0aGVuIGNoYW5nZSB0aGUg
Zmlyc3QgInBpY2siIGxpbmUgdG8gImVkaXQiLiBNYWtlIGNoYW5nZXMsIHRoZW4gImdpdCBhZGQg
LXUgJiYgZ2l0IHJlYmFzZSAtLWNvbnRpbnVlIi4KVW5mb3J0dW5hdGVseSwgaWYgSSdtIGFscmVh
ZHkgaW4gdGhlIHByb2Nlc3Mgb2YgYSByZWJhc2UgaXQgZG9lc24ndCB3b3JrOiB5b3UgY2FuJ3Qg
aGF2ZSBuZXN0ZWQgcmViYXNlcy4KCkkgc3VnZ2VzdCByZW1vdmluZyB0aGlzIGxpbWl0YXRpb24s
IGJhc2ljYWxseSB0aGUgaWRlYSBpcyB0aGF0IGlmIHlvdSBkbyAiZ2l0IHJlYmFzZSIgd2hpbGUg
eW91IGFyZSBhbHJlYWR5IHJlYmFzaW5nLCBpdCBwZXJmb3JtcyB0aGUgZm9sbG93aW5nOgoqIGl0
IGNvbXB1dGVzIGEgbmV3IHRvZG8gbGlzdCBhcyBub3JtYWwsIGFuZCB0aGVuIHByZXBlbmRzIGl0
IHRvIHRoZSBjdXJyZW50IHRvZG8gbGlzdAoqIGl0IGRvZXMgYSAnZ2l0IHJlc2V0IC0taGFyZCA8
c3RhcnQgcG9pbnQ+JyBsaWtlIG5vcm1hbAoKT2J2aW91c2x5IHRoZXJlIG5lZWRzIHRvIGJlIHNv
bWUgbGltaXRhdGlvbnMgKGUuZy4gaXQgd2lsbCBwcm9iYWJseSBvbmx5IHdvcmsgb24gdGhlIG1l
cmdlIGJhY2tlbmQpLgoKSWYgYW55b25lIGtub3dzIG9mIGFueSB0b29scyB0aGF0IGxldCB5b3Ug
ZG8gdGhpcywgaXQgd291bGQgYmUgZ3JlYXQuCklmIHBlb3BsZSB0aGluayBpdCdzIGxpa2VseSB0
byBiZSBhY2NlcHRlZCwgSSBtYXkgbWFrZSB0aGUgY2hhbmdlcyB0byBnaXQgbXlzZWxmIHRvIGRv
IHRoaXMsIGJ1dCBvdGhlcndpc2UgaXQncyBsZXNzIHdvcmsgZm9yIG1lIHRvIGp1c3Qgd3JpdGUg
YSB3cmFwcGVyIHNoZWxsIHNjcmlwdCB3aXRoIHRoZSBmZWF0dXJlcyBJIGFjdHVhbGx5IG1pZ2h0
IHVzZS4KCkluIHBhcnRpY3VsYXIsIHRoZSByZXN0IG9mIHRoaXMgZW1haWwgaXMgYSBmaXNoIHNj
cmlwdCB3aGljaCBkZW1vbnN0cmF0ZXMgdGhhdCBvbmUgY2FuIGFjdHVhbGx5IGRvIHRoaXM6Cgkj
IFRoaXMgd2lsbCBsaWtlbHkgbm90IHdvcmsgcHJvcGVybHkgaW4gbWFueSBjYXNlcywgaXQncyBq
dXN0IGEgcHJvb2Ygb2YgY29uY2VwdAoJaWYgdGVzdCAoY291bnQgJGFyZ3YpIC1sdCAxCgkJZWNo
byAiVVNBR0U6IGRvdWJsZS1yZWJhc2UgPHVwc3RyZWFtPiBbPGJyYW5jaD4gWzxuZXcgYmFzZT4g
PHJlYmFzZSBvcHRpb25zPi4uLl1dIgogICAgICAgICAgICAgICAgZWNobyAid2hpY2ggaXMgbGlr
ZSBcImdpdCByZWJhc2UgPHVwc3RyZWFtPiA8YnJhbmNoPiAtLW9udG8gPG5ldyBiYXNlPiAtLWlu
dGVyYWN0aXZlIDxyZWJhc2Ugb3B0aW9ucz5cIi4iCiAgICAgICAgICAgICAgICBlY2hvICJidXQg
Zm9yIHdoZW4geW91IGFyZSBhbHJlYWR5IGluIGEgcmViYXNlIgoJCWV4aXQgMTsgZW5kCgoJIyBT
YW1lIGRlZmF1bHRzIGFzIGdpdCByZWJhc2UKCWlmIG5vdCBzZXQgLXEgYXJndlsyXQoJCXNldCBh
cmd2WzJdIEhFQUQ7IGVuZAoJaWYgbm90IHNldCAtcSBhcmd2WzNdCgkJc2V0IGFyZ3ZbM10gJGFy
Z3ZbMV07IGVuZAoKCXNldCBNQUlOIChnaXQgcmV2LXBhcnNlIC0tZ2l0LXBhdGggcmViYXNlLW1l
cmdlKQoJaWYgbm90IHRlc3QgLWUgJE1BSU4KCQllY2hvICJmYXRhbDogcmViYXNlIC0tbWVyZ2Ug
bm90IGluIHByb2dyZXNzIgoJCWV4aXQgMTsgZW5kCgoJIyBNYWtlIGEgYmFja3VwIG9mIHRoZSBj
dXJyZW50IHJlYmFzZQoJc2V0IEJBQ0tVUCAoZ2l0IHJldi1wYXJzZSAtLWdpdC1wYXRoIHJlYmFz
ZS1iYWNrdXApCglpZiB0ZXN0IC1lICRCQUNLVVAKCQllY2hvICJmYXRhbDogJEJBQ0tVUCBhbHJl
YWR5IGV4aXN0cyAoZGlkIGEgcHJldmlvdXNlIGRvdWJsZS1yZWJhc2UgY3Jhc2g/KSI7IGVuZAoJ
bXYgJE1BSU4gJEJBQ0tVUCB8fCBleGl0CgoJIyBUaGlzICdHSVRfU0VRVUVOQ0VfRURJVE9SJyBj
b21tYW5kIHdpbGwgcHJpbnQgdGhlIGZpbGUgdG8gc3Rkb3V0LCB3aXRoIAoJIyBsaW5lcyBzdGFy
dGluZyB3aXRoIGEgIyBzdHJpcGVkLCBhbmQgdGhlbiBibGFuayB0aGUgZmlsZS4KCSMgQmVjYXVz
ZSB0aGUgZmlsZSBnZXRzIGJsYW5rZWQsIGdpdCByZWJhc2Ugd29uJ3QgYWN0dWFsbHkgZG8gYW55
dGhpbmcKCSMgdG8gdGhlIHJlcG8uCglHSVRfU0VRVUVOQ0VfRURJVE9SPSJmICgpIHsgcmcgLXYg
J14jJyBcIlwkQFwiOyBlY2hvID4gXCJcJEBcIjsgfTsgZiIgXAoJCWdpdCByZWJhc2UgLWkgJGFy
Z3ZbNC4uXSAtLW9udG89JGFyZ3ZbMl0gLS0gJGFyZ3ZbMV0gJGFyZ3ZbMl0gPiAkQkFDS1VQL2Rv
dWJsZS1yZWJhc2UtdG9kbyAyPiRCQUNLVVAvZG91YmxlLXJlYmFzZS1lcnIKCgltdiAkQkFDS1VQ
ICRNQUlOIHx8IGV4aXQKCgkjIElmIHRoZSBhYm92ZSByZWJhc2UgcHJpbnQgYW55dGhpbmcgdG8g
c3RkZXJyIG90aGVyIHRoYW4gYW4gZXJyb3IgYWJvdXQgdGhlIGZpbGUsIGJlaW5nIGVtcHR5LCBz
b21ldGhpbmcgd2hlbiB3cm9uZwoJc2V0IC1sIHN0YXQgJHN0YXR1cwoJaWYgbm90IGRpZmYgLXEg
JE1BSU4vZG91YmxlLXJlYmFzZS1lcnIgKGVjaG8gImVycm9yOiBub3RoaW5nIHRvIGRvIiB8IHBz
dWIpPi9kZXYvbnVsbAoJCWNhdCAkTUFJTi9kb3VibGUtcmViYXNlLWVyciA+JjIKCQlleGl0ICRz
dGF0CgllbmQKCgkjIFN0dXBpZCBoYWNrIHRvIG1ha2UgdGhlIG5ldyBsYWJlbHMgdW5pcXVlCglz
ZXQgbmV3X2xhYmVscyAocmcgJ15ccyoobHxsYWJlbClccysoW14gXHQjXSspJyAtb3IgJyQyJyAk
TUFJTi9kb3VibGUtcmViYXNlLXRvZG8pCglzZXQgb2xkX2xhYmVscyAocmcgIl5ccyoobHxsYWJl
bClccysoW14gXHQjXSspIiAtb3IgJyQyJyAkTUFJTi9naXQtcmViYXNlLXRvZG8pCglzZXQgZnJl
c2hfbGFiZWxzICRuZXdfbGFiZWxzCgoJIyBPbmUgb2YgdGhlIG5ld19sYWJlbHMgaXMgYWxyZWFk
eSBpbiB1c2UsIG1ha2UgYSBuZXcgdmVyc2lvbgoJd2hpbGUgc3RyaW5nIG1hdGNoIC1xciAnXign
KHN0cmluZyBqb2luICd8JyAtLSAkb2xkX2xhYmVscyknKSQnIC0tICRmcmVzaF9sYWJlbHMKCQlz
ZXQgSSAobWF0aCAkSSArIDEpCgkJc2V0IGZyZXNoX2xhYmVscyAkbmV3X2xhYmVscyRJCgllbmQK
CgkjIENoYW5nZSB0byB0aGUgbmV3IGxhYmVscwoJaWYgdGVzdCAkSSAtZ3QgMAoJCXJnICdeXHMq
KGx8bGFiZWx8dHxyZXNldClccysoW14gXHQjXSspJyAtciAnJDEgJHsyfSckSSAkTUFJTi9kb3Vi
bGUtcmViYXNlLXRvZG8gfCBzcG9uZ2UgICRNQUlOL2RvdWJsZS1yZWJhc2UtdG9kbwoJZW5kCgoJ
IyBHbyB0byB0aGUgPG5ldyBiYXNlPgoJZ2l0IHJlc2V0IC0taGFyZCAkYXJndlszXSB8fCBleGl0
CgoJIyBQcmVwZW5kIHRoZSBuZXcgdG9kbyBsaXN0IHRvIHRoZSBleGlzdGluZyBvbmUKCWNhdCAk
TUFJTi9kb3VibGUtcmViYXNlLXRvZG8gJE1BSU4vZ2l0LXJlYmFzZS10b2RvIHwgc3BvbmdlICRN
QUlOL2dpdC1yZWJhc2UtdG9kbyB8fCBleGl0CgoJIyBCYXNzaWNhbGx5IGFjdCBsaWtlIGdpdCBy
ZWJhc2UgLWkgd291bGQsIGV4Y2VwdCB1c2UgdGhlIHRvZG8gbGlzdCB3ZSBqdXN0IGNvbnN0cnVj
dGVkCglnaXQgcmViYXNlIC0tZWRpdC10b2RvICYmIGdpdCBjaGVja291dCAkYXJndlsyXSAmJiBn
aXQgcmViYXNlIC0tY29udGludWUKCuKAlCBJc2FhYyBPc2NhciBHYXJpYW5v4oCLCgoK
