Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2105.outbound.protection.outlook.com [40.107.255.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998972AE6C
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727254156; cv=fail; b=TETxqsOa+yQ3UwUMLJvlsdSz05rAhh2GIsikLO9E1k+vqzhxJ7EsXhLxjtG7bfH87avMOYeocRBjWvavKduIZTWZHU2Pv32H9gi6kJCC38pBardSYl46of3l6nYcIMKlpSTAoy6nBtgvhydbDew6esAFfh3jPF74q8wp/YcpdGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727254156; c=relaxed/simple;
	bh=xaKP43+Bn+HEt8aqqjAm9yEWR1WgQ6jGG9HLOuRR1Ws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iIOWxMUPvzvj5aRwDIkkG0FgcxO5eRA1mRvTjkYpOSKjZhtd+YVhZDll9n4f+p85vEORdmB+xxZQCTWTcaux1kK5vmQFDJMPjImGyr55/pKjKzhCbPtsJMbdzuXSxP6qE4ewIlpk9b71Exy6NRRB1z24OMYBBU2qny+eyMq0CgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=EnoANeAK; arc=fail smtp.client-ip=40.107.255.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="EnoANeAK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnCx0my5WI/XgVXZZFx5r9kDgMFZj3bvG2Qiua0ybkYAS8/nw1DiwJ8xdefcsm8P3lyeXMAixtDrtHvuqhqNfhJG22FHQ2+k9CKdlockaHR9XuVdc7h9z5T9dTBL/2Xp5fqcUL+/7R0RMqaucGRgrZ8o1F53ZlCfp958l1gTdxl8YfO9dkZ1YNIW1FwB5cUE08LQTVgiDisM2L0zly+LijgtO58Q773e/REmTWZOjzgjXahYrwuqGIYHrNH0lxIgVIJWZCLEqgBVpzv4JUYP8ro2C6B4iokgrnwvJIFaBGNmKHUj5BszH4hLbq98cNsre+C9BJEy+/bmef9snnuFbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaKP43+Bn+HEt8aqqjAm9yEWR1WgQ6jGG9HLOuRR1Ws=;
 b=VN4gk59Excy0dhb920I6O8Yth2BrdLVJW0dUWeKUZoycasR9UuUCjV7aQp5AnBXQ1E9joghA4oFYQIWc0YToJp9ZDiud05UC+rp56DByjXyRZp0bs7FxefqkRtzP/PIn4ZAZpBggEh7XkIwvt+1VuhxckeLr83LfCqlHp3kxEnznl0oYhEX77aC7CShBtYG43JE0QxsvT4LVpRJB4UWXaX4CbStotPquD7K/4ysGaa/kpNfLQa43oYqD4Cf0WQYYZ+K4hOx0XyQANaXTkM7/eUEHybAXGJAfxjz0QZGJakgYNLwali/hYLhsKa0R/JzUwJ6BWC8efeJLL3RDHmilAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaKP43+Bn+HEt8aqqjAm9yEWR1WgQ6jGG9HLOuRR1Ws=;
 b=EnoANeAKUqXSVI+0mQr6MjwQa5l/kHiDFAyuRGJ9cAp0Q1JRwbVlCGYTOpkvhCPxEHBh6g/ML430qXUoQHdu9SXpFTV29b4957ZosyGxC+awsJ/BCxV8Vj6IZUxwKMUR9PC0YoqELZhuWVppxgfQSVGsj1soaVFGmD6TMr5zx8E=
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1ff::8) by
 TYZP153MB1050.APCP153.PROD.OUTLOOK.COM (2603:1096:405:16e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.5; Wed, 25 Sep 2024 08:49:11 +0000
Received: from SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35]) by SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
 ([fe80::a647:e1c3:31c9:e35%6]) with mapi id 15.20.8026.005; Wed, 25 Sep 2024
 08:49:11 +0000
From: Krishna Vivek Vitta <kvitta@microsoft.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Git clone failure
Thread-Topic: [EXTERNAL] Re: Git clone failure
Thread-Index: AdsNpfAbFAaj1HJpTgym8QYEmPxgqwBJSVsAAA5CWgA=
Date: Wed, 25 Sep 2024 08:49:11 +0000
Message-ID:
 <SI2P153MB07185B9AED66870BBAD3C78AD4692@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
References:
 <SI2P153MB071833367C62DD94C96CF1F7D46F2@SI2P153MB0718.APCP153.PROD.OUTLOOK.COM>
 <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
In-Reply-To: <ZvMy_gAL96v8ahfz@tapette.crustytoothpaste.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5b5624f7-2d33-46df-8734-7e2fb3d6cb64;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-09-25T04:33:51Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2P153MB0718:EE_|TYZP153MB1050:EE_
x-ms-office365-filtering-correlation-id: c7690027-3110-4f2e-d744-08dcdd3eed13
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RVN5UXhkMjFlemVMVHpMTUZiMm5VeVJNTFhndVlyNTJSSTkvbTVnS2E0bnZk?=
 =?utf-8?B?ejBaZHlaQ2w0NFJpSkt2K21hQnZhSXJ6NmpGYnd5M3hlcTdqaVU1WUZ1UWd4?=
 =?utf-8?B?MDRZZk8zTHh1alJ6UWtOVC9jNVUyblNjQ0dnbHg4cnJUblhzS2gyT09PVFVi?=
 =?utf-8?B?aFA0V2tVQyszclNoaFl0VS9tT1U0NnhwVGpxZ1RlOTkrOTJxUkRTM2JPQThx?=
 =?utf-8?B?b1NELy81elJ6b1lhRFl0VHcvTjRhSEs4Wk94czZpUUR5NXJWazdIUzZ2WWp5?=
 =?utf-8?B?YzFMUEtxTzFlWFZDT1R6TkFwR0xtNi8xZ3k5NnpqTzlqMWs4ejZUVCsycEtn?=
 =?utf-8?B?TVREVUNsazZ0ZHdoYkt6UjRMVTFtNExvaTVnUkZwL2tiK2ZZSWlRcDVqc3d2?=
 =?utf-8?B?dHRSNU1iMXJ1V3hkUWlFRnlEQTdNM1g4OGkxVXpTSml1RVpTU011SXVIcW1U?=
 =?utf-8?B?dm9EYktsTW4xdVp6cmxub3ZOeTNtWHZkUGNhSnJqTnNsTVVTUS9QRWJRVHlr?=
 =?utf-8?B?SFp6dE52RDU4ZTQ2MlNqV0NDaDJFZlFkK2hUZXN4L0l5THYxL09tVG9tWjBq?=
 =?utf-8?B?TzJTTmhYOEZzbVJ4Nm5FSlI2TzNyNTY4cE9tbzd5bHdoYzVCWHJZa0FuZUlP?=
 =?utf-8?B?ZFF0VjYxTmJJNk56Ym5IclBPR2pjV1M5VUxMc3ZjMWRva2pUaEZiV1ZzL200?=
 =?utf-8?B?T0ptM0tURk12eEpGdnVPeDkzMlZPWlJKSnBvcUZ4clVPa1l1VzdlNWtYNWZM?=
 =?utf-8?B?V1BLYS9NUmZ2dzhjTlRpblZhMlJRYm0xZHVpeTA4UkpEOTQ3MVVGVWtHS0R3?=
 =?utf-8?B?Z296SWl1OUV2djUvNDZPQjZoSkE4L1V6bFpBTWM5Tkc4c2FjSnpCT0VYZU1W?=
 =?utf-8?B?YVpKWGdqRWVmTW1PT3hucnNKLzdXOUhuV1Mwb0lENGJvTjlNalJFa092UU0y?=
 =?utf-8?B?Q3lXQUFEUFczRVJyVU9hdndWdzlxT1daWGFxa0ltZGwwSE1HcXZNdE11RVdK?=
 =?utf-8?B?ZDd3Q3AwZEJOU1c3bzczeTRkR2hBdkt4ZGZsN0d3RUtNUXdla09QNDhoVDR2?=
 =?utf-8?B?a0JKTURIMHVBYTdRNmlsaUxFck04Zk84TDY1cE51U29xSTlhVEFaVThGYjJk?=
 =?utf-8?B?SlRLWHI2amJLQ2xwT1FiMy8xcjdudHgyaVdlazNWVlZUMzBnTkxxZjNEOXBK?=
 =?utf-8?B?aDZ0bkN1bCsxWERNQ3dJZ3RhQ1Z0UmRKU3doVFNWTXV4ZEU4eEVBQnE0YUZM?=
 =?utf-8?B?b1R0cm5tM3FaMzJCUmhqOUhDQmtCOXlIbWtjQU11eWJPOVNwbGJDVnYyZzdJ?=
 =?utf-8?B?S25vYkNyUUR3SEJtUEorNWM1azc4Q0xzQUZsZ0QwZTJ3djZKcnZxdXYvcHJs?=
 =?utf-8?B?bG9OYTZ1NHQ2OHdtOXRIYTlzSDFvY2VEQVphOFlXcEJ0S2U1MmJWM1lodEpZ?=
 =?utf-8?B?TzQ0MHZ1aHdLMFN4UUd6WXp4eWVqNnArMDJmeXJ5cEMrVWRYU1Vtelo0MENn?=
 =?utf-8?B?Vnd1RHdNZmxIcHYvOFl3dUIxMGI3QS9BUXowQjdvMzErdWVHeGpldEpxd2FK?=
 =?utf-8?B?aVdDVzJKalJGTG1oQ1IxK2ZlSmo2WUVJdlR1eEJ3TTB1eTl4ZGpGZUI4amdi?=
 =?utf-8?B?K0loUUYycXpYSkltYzd1MEJYTmJMOVlDWFVsRlZSTUhJS0FEMTIxb2d0Y3dm?=
 =?utf-8?B?WTZBMVRvNXVrM2crdTBWUVJjQU1hdWtMZ2I2N3FBOXd4dzF1ZWZLWkdSL1BD?=
 =?utf-8?B?bThoT0RtZXk0dHlFeVdHbU43L0N2d1p4aTBBUGFKejVieHZHeFdlbW11RlA5?=
 =?utf-8?B?Z0lxMHRwaHI4eGpjN3hoQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2P153MB0718.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjhMZ0RQdXExRWhodGZKTDFmMlh3RzdDY0tqL3ZzY2pVNHpUc1NNMTVMb1JK?=
 =?utf-8?B?WDdTeXlKYVdTZnYrdUxXU0JRQWNYaTMxRHNOU2JrWnNhSXFEZldMbmxhTVl6?=
 =?utf-8?B?R0UvcXlXV1BlNWRUOC9USmNEOGQwN00xWlo5Sk1NQzYxb3RRNExZMTQ3b3N0?=
 =?utf-8?B?VmNuYmtzSUtpa3VxK1FvU2lLb1I2YXZVODNpZDRFVDRnUGhGSE5rVFM1YXNw?=
 =?utf-8?B?WW1zR25WL2ZISmk1dndGQXA0RCtUYzNMZUhIUFcyYVhDRmFQamp1WmZudFI5?=
 =?utf-8?B?QXVhTkpoT094NEl0end0QnA4YXNqUXMxM1dXL1h5TlRqcTRETzI0Ym1KZ3or?=
 =?utf-8?B?WlBRakNMWHJVbmhaall3dVFQUEtlV0xnWHl5M2lvQ09XczJFaGpXTmlIbCtS?=
 =?utf-8?B?ekhUNi9YeWV0VXJFbE92dTRoelRQSHEzZWc3Ti9sL0dOeHE1bmRUUkJxOFAx?=
 =?utf-8?B?aU4rcy9tdjlGbGxIUVFDbisvQ1dXY3hmbTdtSHhmSGJFaUhHZWZ3Vy9ycXRy?=
 =?utf-8?B?dzRCUjVFa3oyeDJMdFpmWUJ3enJWOVpkczIwWFRvTEhmVzFmQTRUQmdRbmph?=
 =?utf-8?B?YUIySFNJaXM5a1BSbHNlbzdqYUFidlVOYWd3ci9lUm9PRXJKMVo0dzg3R2JT?=
 =?utf-8?B?VHA5dkR3YUVlVnhHNGttSHEzaVJ6NkE4djY1WHViUFA4dnhacFlDK1B2cEo3?=
 =?utf-8?B?R1Fxa2lrR2tad3JRZjhjMUludTB4U1M2RXhaQnFOS3orWFp4bERna3lDWFUy?=
 =?utf-8?B?WkNnNUpCODVuaTlhaVNpRHBSL3Jzd0xQZHF5MW1VMHhvVElRaFJnUnk4Zk9D?=
 =?utf-8?B?TERMcFArRDk3VzMralJvVVdqQk5sMVVRSGd6eXV5ZWZodlFoaVdCMUx1NlA0?=
 =?utf-8?B?TWtWRTZ2eHp3dHNGN25wK3RLc1I0SnlneUlGK3Jra1pJRkhTalNMMGxBVXVy?=
 =?utf-8?B?TVl5WXBzVVJldG5SRXE3NW1IWk4vVDQrNDdMSHhEMnJKVVdjRWcrUEJ2MkNF?=
 =?utf-8?B?ZG5FaUpVTWlrenM3c2IzTktsNEFNL09lMUd0YXdKVnlkZ3lWNnljNVczNXov?=
 =?utf-8?B?UU1CZkplc1ZnQWhqOFZ1aElxdm94Vnpvay9UeDVOYXlKbzBOdk8ydlRRcXNn?=
 =?utf-8?B?VTFRS05vN01NRUwzd3liUzNWczBjd3l5Z2c3dHpaQ3RFWkdHRVIvbTFac1dX?=
 =?utf-8?B?cW5xQnI5eE9ITUhpbTRYZ011cllQV3hxckh6VFJCNTNpcmdMNWZNcW1xdVR4?=
 =?utf-8?B?YjdSNDdEVDFxSUxMUEZpc1Q2YzZYMnBSdmxLb0J2V2VhdlBkZWJnYi9kMXpq?=
 =?utf-8?B?cTNIZm1iRlhaR1ZGeUpSVDRtSW9GQlRwMTVyWVZmTlpjWExOdUV1L3M4UFFK?=
 =?utf-8?B?OTBtMU0vWVRvT2lQa0ROOWxWOXFFOStqQlhoTkZHcndTY043VFNIT3BUM1Ny?=
 =?utf-8?B?MkJDYXo0VkRvRzcyT0pNci8yRzBUcGVGcSttQWJzUE1RTnkvOSs5Mm11dUxL?=
 =?utf-8?B?K0RZTlphaFdJb0dPd2FkMzlTMXl1YWVwYzBHVW96MFdrTmVzcnFTc1JsNERn?=
 =?utf-8?B?WUV2azU0ZHRVdFlNdmZ5TGsxbHhPakU1bnpUa1dLY0NneU5YaDJuOFdtL1FP?=
 =?utf-8?B?SThQSFZYWnlkMWRtRFlxbCtsZlNXS1E3MHNsTVVaT3NDKzNhclBNbFZIcmhB?=
 =?utf-8?B?MXZGcXhZMmNPclorVHZxSnlWaklRNHpQVFhqVjgxN2dDSE8yMSs5QzlGNHIz?=
 =?utf-8?B?QkZpZGIySE1GM3NvRlBTcVJ5UHAvN1k0aTc2RGJsZlZwZkFWY3RlTjVJbjVw?=
 =?utf-8?B?emZlWEJLdGZLOG9jUDRTYXhhb05mL0s3UzdGRjhvMDQxTlZqbDk1ZGZCRHZB?=
 =?utf-8?B?VWN1ZUpZUnEvY2dHbFc3VTE5eTZLMHNIN09YQ29KaHp3TmdNT1dHOEdSR09O?=
 =?utf-8?B?NldHR0dvNno0b2xTYXRESXFuZ2xEOEswc1FDd09aejFySXNZQnhCWUZpS2Ez?=
 =?utf-8?Q?bz24g5hCdUQWtV+jtYAS60SSKBWkTU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2P153MB0718.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7690027-3110-4f2e-d744-08dcdd3eed13
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 08:49:11.4941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsSa3ZTXgWquxWAVQ4vIpojW/bwyttK8gWoIUar2/Fqo+LeFuaN+kfOYZB0sKzsyxOmkKSY9nVRuuOFXUzY8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZP153MB1050

DQpIaSBCcmlhbg0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZS4NCg0KSXQgaXMgYSBXU0wyIGVu
dmlyb25tZW50IHdpdGgga2VybmVsIHZlcnNpb246IDUuMTUuMTUzLiBXZSBoYXZlIHVzZWQgYSBr
ZXJuZWwgdmVyc2lvbiA2LjYuMzYuMyBhcyB3ZWxsLiBTY2VuYXJpbyBmYWlscyB0aGVyZSBhcyB3
ZWxsLg0KDQpyb290QERFU0tUT1AtT09IRDVVRzovc3lzL2tlcm5lbC9kZWJ1Zy90cmFjaW5nIyB1
bmFtZSAtYSBMaW51eCBERVNLVE9QLU9PSEQ1VUcgNS4xNS4xNTMuMS1taWNyb3NvZnQtc3RhbmRh
cmQtV1NMMiAjMSBTTVAgRnJpIE1hciAyOSAyMzoxNDoxMyBVVEMgMjAyNCB4ODZfNjQgeDg2XzY0
IHg4Nl82NCBHTlUvTGludXgNCg0KTW91bnQgcG9pbnQgaW5mb3JtYXRpb246DQpDOlwgb24gL21u
dC9jIHR5cGUgOXAgKHJ3LG5vYXRpbWUsZGlyc3luYyxhbmFtZT1kcnZmcztwYXRoPUM6XDt1aWQ9
MTAwMDtnaWQ9MTAwMDtzeW1saW5rcm9vdD0vbW50LyxtbWFwLGFjY2Vzcz1jbGllbnQsbXNpemU9
NjU1MzYsdHJhbnM9ZmQscmZkPTUsd2ZkPTUpDQoNCldlIGFyZW4ndCB1c2luZyBhbnkgc29ydCBv
ZiBmaWxlIHN5bmNpbmcgc2VydmljZS4NCg0KV2UgaGF2ZSBpbnN0YWxsZWQgYSBkZWZlbmRlciBz
b2Z0d2FyZSB3aGljaCBpcyBtYXJraW5nIG1vdW50IHBvaW50cyBmb3IgRkFOT1RJRlkgdG8gaW50
ZXJjZXB0IGZpbGVzeXN0ZW0gZXZlbnRzLiBPbiByZW1vdmluZyB0aGUgbWFya2luZywgZ2l0IGNs
b25lIHN1Y2NlZWRzLg0KDQoNCg0KVGhhbmsgeW91LA0KS3Jpc2huYSBWaXZlaw0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogYnJpYW4gbS4gY2FybHNvbiA8c2FuZGFsc0BjcnVz
dHl0b290aHBhc3RlLm5ldD4NClNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDI1LCAyMDI0IDM6
MTYgQU0NClRvOiBLcmlzaG5hIFZpdmVrIFZpdHRhIDxrdml0dGFAbWljcm9zb2Z0LmNvbT4NCkNj
OiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBbRVhURVJOQUxdIFJlOiBHaXQgY2xvbmUg
ZmFpbHVyZQ0KDQpPbiAyMDI0LTA5LTIzIGF0IDEwOjQ3OjA4LCBLcmlzaG5hIFZpdmVrIFZpdHRh
IHdyb3RlOg0KPiBIaSBleHBlcnRzDQo+IA0KPiBOZWVkIHlvdXIgaGVscCBpbiBpZGVudGlmeWlu
ZyB0aGUgcm9vdCBjYXVzZSBmb3IgaXNzdWUuDQo+IA0KPiBXZSd2ZSBzZWVuIG11bHRpcGxlIHJl
cG9ydHMgb2YgZ2l0IHJlcG9zaXRvcmllcyBmYWlsaW5nIHRvIGNsb25lIC8gDQo+IGdldHRpbmcg
Y29ycnVwdGVkIGluIHA5IGZpbGUgc3lzdGVtLiBUaGUgbW91bnQgcG9pbnRzIHVuZGVyIHRoaXMg
ZmlsZSANCj4gc3lzdGVtIGFyZSBtYXJrZWQgZm9yIEZBTk9USUZZIHRvIGludGVyY2VwdCBmaWxl
IHN5c3RlbSBldmVudHMNCj4gDQo+IFdoZW4gd2UgcmVtb3ZlIHRoZSBtYXJraW5nIG9uIHRoZXNl
IG1vdW50IHBvaW50cywgZ2l0IGNsb25lIHN1Y2NlZWRzLg0KPiANCj4gRm9sbG93aW5nIGlzIHRo
ZSBlcnJvciBtZXNzYWdlOg0KPiBrdml0dGFAREVTS1RPUC1PT0hENVVHOi9tbnQvYy9Vc2Vycy9L
cmlzaG5hIFZpdmVrJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL3psYXRrby1taWNoYWls
b3YvYWJjLmdpdCBndGVzdCBDbG9uaW5nIGludG8gJ2d0ZXN0Jy4uLg0KPiBmYXRhbDogdW5rbm93
biBlcnJvciBvY2N1cnJlZCB3aGlsZSByZWFkaW5nIHRoZSBjb25maWd1cmF0aW9uIGZpbGVzDQo+
IA0KPiBBbnkgcmVhc29uIHdoeSBpdCBpcyBmYWlsaW5nID8gQW55IGhlbHAgaW4gdGhpcyByZWdh
cmQgd291bGQgYmUgaGlnaGx5IGFwcHJlY2lhdGVkLg0KDQpDYW4geW91IHRlbGwgdXMgbW9yZSBh
Ym91dCB3aGF0IGVudmlyb25tZW50IHlvdSdyZSB1c2luZz8gIElzIHRoaXMgV2luZG93cywgbWFj
T1MsIExpbnV4LCBXU0wgKDEgb3IgMiksIG9yIHNvbWV0aGluZyBlbHNlPyAgV2hhdCB2ZXJzaW9u
IG9mIHRoZSBPUyBpcyBpdD8gV2hhdCBpcyBiYWNraW5nIHRoZSA5cCBmaWxlIHN5c3RlbSAoYW5k
IHdoYXQgZmlsZSBzeXN0ZW0gdHlwZSBpcyBpdCksIGFuZCBob3cgYXJlIHlvdSBtb3VudGluZyBp
dD8gIElzIGl0IGEgbmV0d29yayBmaWxlIHN5c3RlbT8NCkFyZSB5b3UgdXNpbmcgYW55IHNvcnQg
b2Ygbm9uLWRlZmF1bHQgYW50aXZpcnVzLCBmaXJld2FsbCwgb3IgbW9uaXRvcmluZyBzb2Z0d2Fy
ZSwgYW5kIGlmIHNvLCBoYXZlIHlvdSB0cmllZCB0byBjb21wbGV0ZWx5IHVuaW5zdGFsbCBpdCBh
bmQgcmVzdGFydCB0byBzZWUgaWYgdGhhdCBmaXhlcyB0aGUgcHJvYmxlbT8NCg0KQWxzbywgYXJl
IHlvdSB1c2luZyBhbnkgc29ydCBvZiBmaWxlIHN5bmNpbmcgc2VydmljZSBmb3IgdGhlIGRpcmVj
dG9yeSBpbiBxdWVzdGlvbiwgc3VjaCBhcyBEcm9wYm94IG9yIE9uZURyaXZlPyAgVGhvc2UgYXJl
IGtub3duIHRvIGNvcnJ1cHQgcmVwb3NpdG9yaWVzIGFuZCB0aGUgR2l0IEZBUSBpcyBjbGVhciB0
aGF0IHlvdSBtdXN0IG5vdCBzdG9yZSByZXBvc2l0b3JpZXMgd2l0aGluIHRoZW0uDQoNClRoZSBy
ZWFzb24gSSBhc2sgYWxsIHRoZXNlIHF1ZXN0aW9ucyBpcyBiZWNhdXNlIEkgaGF2ZSBhbiBvcGVu
IHNvdXJjZSB0b29sIHdoaWNoIGFsbG93cyBtb3VudGluZyA5cCBmaWxlIHN5c3RlbXMgZnJvbSBh
IHJlbW90ZSBzeXN0ZW0gYnkgdXNpbmcgdGhlIExpbnV4IGtlcm5lbCdzIDlwIHN1cHBvcnQgYW5k
IEkgZG9uJ3Qgc2VlIHRoaXMgcHJvYmxlbS4gIEkgZG9uJ3QgdGhpbmsgdGhlcmUncyBhbnl0aGlu
ZyBpbnRyaW5zaWNhbGx5IHByb2JsZW1hdGljIHdpdGggOXAgZmlsZSBzeXN0ZW1zLCBhbHRob3Vn
aCB5b3UgZGVmaW5pdGVseSBuZWVkIDlwMjAwMC51IG9yIDlwMjAwMC5MICh0aGUgVW5peCBvciBM
aW51eCB2YXJpYW50cyBvZiB0aGUgcHJvdG9jb2wpIHRvIG1ha2UgdGhlIGZpbGUgc3lzdGVtIHN1
aXRhYmx5IGZ1bmN0aW9uYWwgYW5kIFBPU0lYIGNvbXBsaWFudC4NCg0KTXkgZ3Vlc3MgaXMgdGhh
dCB0aGVyZSdzIHNvbWV0aGluZyBlbHNlIGFib3V0IHlvdXIgZW52aXJvbm1lbnQgdGhhdCdzIGNh
dXNpbmcgdGhlIHByb2JsZW0uICBJdCBsb29rcyBsaWtlIG1heWJlIHlvdSdyZSB1c2luZyBzb21l
IHZhcmlhbnQgb2YgV1NMLCBhbmQgbWF5YmUgeW91IGhhdmUgYW4gYW50aXZpcnVzIHRoYXQncyBw
cmV2ZW50aW5nIHRoZSBmaWxlcyBmcm9tIGJlaW5nIHJlYWQsIHdoaWNoIGlzIGNhdXNpbmcgdGhp
cyBlcnJvciBvbiB0aGUgTGludXggc2lkZS4gIEhvd2V2ZXIsIHdpdGhvdXQgbW9yZSBpbmZvcm1h
dGlvbiwgaXQncyBub3QgcmVhbGx5IHBvc3NpYmxlIGZvciBtZSB0byBzYXkgbW9yZSBhYm91dCB3
aGF0IG1pZ2h0IGJlIGdvaW5nIHdyb25nLg0KLS0NCmJyaWFuIG0uIGNhcmxzb24gKHRoZXkvdGhl
bSBvciBoZS9oaW0pDQpUb3JvbnRvLCBPbnRhcmlvLCBDQQ0K
