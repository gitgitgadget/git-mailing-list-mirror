Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B2D179BF
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745377868; cv=fail; b=ECr0RrSNANEv6EanKK+l3LbFom0HPCMq1v8gWJ3Aq1ZtL5lxVA5vyekdDQjUeGdiTabTJMs8PlgGuTMWYlKVxKZuFSbgUg+Zje0HW/bQd6C77ny7BeWBKZKXZWaXwwo3tTwHr0asnOtpsklS+5w8blz6C8gdvuGn3qkRcxVoB+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745377868; c=relaxed/simple;
	bh=cFiZLUpybe0RRK4uU+yX3k01tDrZSd4c9l1OQ8O4U5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qQoHPQONaL7kSB7/Mt4GR/3VYdeoiBOgpLXyxVI685c2VwukER8fxJm+c13eWF0Vgq1k2lRQjNjXZCkS8VYHUDfHXkaZirVDVseQZh6rBzjGEZwYHvx6lgkzbzT+r74HZT69gMUujomAxhwVFxhGvOyWN4Z8vIn/QpzNxe9tNao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=aZGmzXi8; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="aZGmzXi8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ptdw3yzPFFKZFMp1S2jQd+idfRRlBB/TZFoOZMDsnY0YViWa7G7q+tPlH8DUDn0lMnAajtgWG9WntZU2A5rxhvSZ2tmw6MMa6fDCovsXYeFE3l5FGCeQVBb6ISo/BkghNAuo9Mei7GBrS/davbI+Q42vyPuGWSr8+KV+EScF1sYSnIzBqGam/RdgH9QPwxXftrey2YiXPZLGCD0WG73GskT9JvozkPNPBhj32+6XC97uohhj3QxTD3T42uC1P0AUo6mDmzJPKd++2shT9zxX0phHWZJ2cPj1mRbAKIuJRiDZtklPY+awUHDL0+JtG3UbVs66+BJdOm0n+z9NV+rJNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFiZLUpybe0RRK4uU+yX3k01tDrZSd4c9l1OQ8O4U5g=;
 b=eMncLdq9iKp5yqrmUu0QU0eyc1aCS0TSZp3O/rVlgRygtSqITvid9kQvOXKlB922ZCPNvKf8bLEhiZqYsnWB76tV2ZDdLn8yCsifUbFGooHLxYGfUZCMrDk9nlS89vg5M3x0iI/3fr5tD/oSzP3x14e4juwQlEgvMtKqkgLHqdw33yBu6nde+7otcRzy+dvolfaEbhCiyW3ftu6dgzOvNZapsDUleyL35QUN3PwDnfzaGSHIzoJxUjzJ0GuZEW117VIfDEEivBPP+7zyLxO37AtIbOwpGqqB8NT3ok09BzDhm5xxWhoIPrPWiZnLseZyvcrkiFIxgsSQJhHTspP/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFiZLUpybe0RRK4uU+yX3k01tDrZSd4c9l1OQ8O4U5g=;
 b=aZGmzXi8f78S7HUC5O+9YDGgjc92YOjUPKGVnLRjfcnf1jIBnIyR87ou0ulTqAw5Fg4LjHlMack8AuP3mWct+Yz8+Ml815EBBwTB7Yj30VbXVcC27tczeAKhSa23XZmudW/ZrlHvuC1jeLE5iv9MuIQV9t2eSOm/wTmlH27Sjw7kg52/pjMu9WMxWOgJni1wOnralC+YlZTHcYGRwTxf2q/GbFVjxxAOIKb4hO8vrOBcRAgACrqyzOOsEeYhvMeyGDaM9lUPCzteMuPcF13JZL5V+FQ6oIDTANX+tLxMW3pKd5v0tvc0c7PygKP9LW+B7Sa3pnobjtCdb2IstEB21g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB10281.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:12b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Wed, 23 Apr
 2025 03:10:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Wed, 23 Apr 2025
 03:10:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, M Hickford <mirth.hickford@gmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>
Subject: Re: [PATCH v3 3/3] send-email: add option to generate passswords like
 OAuth2 tokens
Thread-Topic: [PATCH v3 3/3] send-email: add option to generate passswords
 like OAuth2 tokens
Thread-Index: AQHbs5rts6lnrA+/ukC7rPEkGmAB+bOwQmzPgABRCJU=
Date: Wed, 23 Apr 2025 03:10:58 +0000
Message-ID:
 <PN3PR01MB95972EA90559852F9F8328C3B8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95975C7925B6395DEC46F9EAB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597813722A475923ED1C036B8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqh62f3kji.fsf@gitster.g>
In-Reply-To: <xmqqh62f3kji.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB10281:EE_
x-ms-office365-filtering-correlation-id: 558a0368-4043-49c5-8f17-08dd82147884
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|7092599003|19110799003|15080799006|8060799006|461199028|8062599003|19061999003|440099028|3412199025|19111999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?V2Z2dHZCSkpoTXljRXMrM21MY0lKa0cwRWgydnpVYTJsUCtzUTBMZmpiUU0w?=
 =?utf-8?B?VzhFcDVPblFIcmVvb3NjeHE4dHF0WVYrRFY3YkswUjIzNUpwUWU4VVdCR1k4?=
 =?utf-8?B?Y0ZPWnZBYS9nNStZSDhaVHdXUGNieTl6OWhsK3gwOTJ4ckhUSzNkRXBPbStu?=
 =?utf-8?B?Zk9GNmFwQlFaU3hVbkY2ZWYyM08yNlloblE0ZXVsa3VYOFJFbStIZ2pNMzB6?=
 =?utf-8?B?U2YzN1FUYmJZSmFVNlRHOXpDcHlQQmsvU1VmY3FpQjQ5S21xV2FtL0FnZDVW?=
 =?utf-8?B?bmsvTVRhb0NSTTFpajUrelh1NkVpUkNwaURrVlEvcENXV1Z6MUFXYzZ3UURI?=
 =?utf-8?B?K09hc1czbGtoeXA0RU9keVprZkJ1c3BmZms1VW1ET0dxMWdwckYzemoxdlVL?=
 =?utf-8?B?U1NCY1Z0MzZNWjh1S2NyMkQ2OW0yejV4anh2eEFFakhhWTlxZC9XTnlhVmt6?=
 =?utf-8?B?Nk5KdEFIYkJmSHJZNlQ5Z3hFMHZhaGU4R005b0tqSzVMclc5Nm1Rdy9JeVFz?=
 =?utf-8?B?ZlNzdkpCd0hoRXU0TEJ1bXBkQXlnYXEwWWdpWjlwMExxZHQzWExRNHZlVXRr?=
 =?utf-8?B?bVdDNHJ6Zk4xRk5vMVpBU2ZCb0Nyb1dKREh1Rjl2MDZwWXpYM1dFQllFWFdL?=
 =?utf-8?B?bnFpaUVRb2cya2xmWmVCRDlac0FZa29jV0NIbXhGZ1A4REhhRkV5NVVMNWFi?=
 =?utf-8?B?VVM0eEZ5Z3NBMWRGN0pMeW9venZOMlAyOFJIYzFUMWt1aytjWndzMFo3NVBH?=
 =?utf-8?B?NmZ3SmpXdXA4bFM5aEhieCtKcUZkNXUwd3NKeW1yU1pYS1l5eUtnaktMbHBm?=
 =?utf-8?B?Q1dpU2dWTW9UVldYbU4xTkYrK3paQU9LeFJoVkJnMExWVzdDaVhZbGhWQmk4?=
 =?utf-8?B?OGkzbW51Rmg3YTJEdm1HclBTQ00zT3hLNENSYW5WNGFQRURvdDJqc243QURk?=
 =?utf-8?B?M01wOG5WYmVyWkp3djQvZ2RIU0dsalRZb0kvU3lXcW9uSWxDMEU1bWE3cE1v?=
 =?utf-8?B?OXlxN1pFR3JFQ1daL1p1RWl4YVlnUTErRFd0ajFvbVFnQlhGcXU1eHptMmxo?=
 =?utf-8?B?NmdkUEZHampoVENLQllDbGtRcnl1WGxxNnRYSmplV3IvaTdkMzlWZFNRNFFO?=
 =?utf-8?B?WDRxTkJ6YmM4ZEFtWXdTU2dTcG1meWR3SFNVMHo1SXZtU25remtKdkxNdnBU?=
 =?utf-8?B?NkhERUJndSthcktGbGpkMFk2ckFaazBVWnBFSGlWYXJjWTFaTzJSR1ZibjJC?=
 =?utf-8?B?NmtWVHBGc3oxRWM4VUlWMGpnTFJUWDBVUTM2VitFWEU1eUVNaGRnSzdyUlFi?=
 =?utf-8?B?bXhzVm5IME80TUVUVmtPVm1ubkVKK2JlQTkydjl4eFhpc3QwVG9ZdHpNMzlj?=
 =?utf-8?B?UnFqZ3gvbjNmaG45U1dNMlRjV3NQYUliWG1nMjVXYW95UEpWTEF5Q29FWWlL?=
 =?utf-8?B?QnR0djlPcXh6RStrdzRlVEZFZy9nOHhuVDFiVEZ6MVFsQzZSN3BGcW1yWldQ?=
 =?utf-8?B?OWV1bHRXc2VuYVBjQ1pES3dTV0IvdENMSWk0ZVlyOGRrVEpPc0V0QWdiNzVF?=
 =?utf-8?B?dHdxVzk4S21OTlFNS1owY2FkZE5VbzlDM1Zyb0tNVUJYT2lNUzh5a1JmTXoz?=
 =?utf-8?B?ZkZvaVBhSzFFWHBDMnN0ZXRnN2ZSSlE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2J5K1BVVVNKU0tSdmFSY2ZwQnNsQXhoc0pNK2ZvcTdLb2ZFem5PNzdLUlBG?=
 =?utf-8?B?ZUhEdW82ZkFGL2s3a1dJOGozc3NMbStlcFdTODhML3YydFhpWkhEQnU0WDdr?=
 =?utf-8?B?T0Q2K3lBYi8vd25VenV2WTZEVDczSmNZTG1FNzhJRUpiWFRWWTM2cmRyai85?=
 =?utf-8?B?eWZmNHNmbVpFTEY5VnhXQnpWa2hlQ2FuMjFqV1cvY3V0bWQ0UEVnY0hUVVBE?=
 =?utf-8?B?R25RejYrRjhzM3NXVVM3OG5UMmhNSTNaTlFaekZlNTdTQzBuaFdsbGRZRTVy?=
 =?utf-8?B?a1IxRlhFd0NxNDZZby9EcHpxRDJnTlgvZnFVV0diQkxtbXRLNHozWjY3VVUr?=
 =?utf-8?B?cm05cEsrYVo2dG9NQlRGZ1ZXRFgzNHV5YkZtMEZSZkpTdEpqeTJiT0lGS2x3?=
 =?utf-8?B?NHR2cy9kUWx0STJTNE54ZzJKc1NsUDNnMVlZR1ZaVTM3bFlyWWduc1AweVha?=
 =?utf-8?B?VjB6NFhQR1lDd1cwOWdhQVpZYVI2cDRFdEJFTWllSEhTS3BKQ0tjOVFIWFhw?=
 =?utf-8?B?clZ2Nk9wdnVSRC81SEcrZHhpRzBFbkRWRE9SeDd5cHl6ZzVrL2FZd3lOcjdJ?=
 =?utf-8?B?cHZ3bmcwaWxvRC8yWmVSOTkzRnNJSW94N3hkejVocTIwNnYxRlZUT1Z6WjdF?=
 =?utf-8?B?YXlwRmovT0VOOFMvUHJNVUFhOVh6MEN3djgxUHJvNEhmeVpERkN4bHFRZDhs?=
 =?utf-8?B?cTJzRm5EVitndlNxYkpyeGcxbUtOWXlubWhJZGxrdE40QnRGSUhsQkJwQjdm?=
 =?utf-8?B?LzNDczEwajdGdStJVUJ5MGJvR3M5cldZNC91a01pekd0WmJOellNK09zS0x6?=
 =?utf-8?B?YU9hTndCa2trMng0YWs1UkFXTEZ2SjdXNlhFUUhxN1VnUFhWclBDa25Lelc1?=
 =?utf-8?B?WTV2SFMxbDUybGxmVU85OVkwVlhnaUZUa2xPczlSVHJuT0U0UVFway9wUEFu?=
 =?utf-8?B?T3Vhc2NFZ1BhdW9CT0hkRnlHT01aUU9nMWZocXpXZ0FQamNMcEdjajh2VTJv?=
 =?utf-8?B?VXViVnhzNW1ncW1Vb0R3VXVjaGk3ZkptckVuN3VpRUhuZ0FqYjF5bng3MnBW?=
 =?utf-8?B?QmJ5b2JPeGh3Uzk2bVZBK2ZjWjRIZGI2Sk5LVE1GWndKNmtyS0RSM3dseFRR?=
 =?utf-8?B?SzBJRUZ6cHplbEpOZGRZUS9TelF3ODhQT0pzeTlydWxraDdlNTJIQzNTNmx6?=
 =?utf-8?B?bVFtc0RPeFJ3RndSWkFMZms5VjlrbGovUnN6VTM4TXRnWERiWUZ4Q3JFbjR5?=
 =?utf-8?B?ZjByNkZsQS9xM25NQmhPd2Z4Z0YvRlNtTUFycERsUi9CZnJNdVB4bE1aeXlX?=
 =?utf-8?B?M2V0T2paU3JxYW0xWEU5UUdjK3BoWTRYN283NTBjandLNjkrSTE4U2xYbVhx?=
 =?utf-8?B?WkErOVYwbVhGZFh1M25ubm8vbStsTVFFMDk2SE1ObUR5b2dxbHFJLzRDWXIy?=
 =?utf-8?B?am5MZVlLWjlZL2Uwa29RWVFJcnBHVURsa0pZNGlzbjRTMzFiSDNaUGd3ODJw?=
 =?utf-8?B?ejYvaGVOTUEyZitzZUVpQ0kwdFBMeVV3Qk9YZEZkSFN5eDZpMzdmNWhLTHZU?=
 =?utf-8?B?WHVCMkF2VURxQ2lyT09BYTE5NkdpVVNNYkF5aFc0MllFTng0SDRucWx3UUcr?=
 =?utf-8?B?MDNIa2dGOVdLSU5Ua3VKaU5SYzE4bkp4dFFaYUFTT3lqK0tvcTNBaUhWYU11?=
 =?utf-8?B?L2pVeVphT0ZyVVprRzZ0elpYSytZYUZOTFJKSXNoS3NLdEkxbElDbUJUYWFa?=
 =?utf-8?Q?7EyIPdaebOoVJ8OstA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 558a0368-4043-49c5-8f17-08dd82147884
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 03:10:58.8771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB10281

DQoNCj4gT24gMjMgQXByIDIwMjUsIGF0IDM6NTDigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiArLS1zbXRwLXBhc3NldmFsWz08Y29tbWFuZD5dOjoN
Cj4+ICsgICAgR2VuZXJhdGUgcGFzc3dvcmQgb3IgT0F1dGgyIHRva2VuIGZvciBTTVRQIEFVVEgu
IFRoZSBhcmd1bWVudCBpcw0KPj4gKyAgICBvcHRpb25hbC4gSWYgc3BlY2lmaWVkLCBpdCB3aWxs
IHVzZSB0aGUgb3V0cHV0IG9mIGFueSBwYXNzd29yZA0KPj4gKyAgICBvciBPQXV0aDIgdG9rZW4g
Z2VuZXJhdGVkIHVzaW5nIHRoZSBjb21tYW5kIHNwZWNpZmllZC4NCj4+ICsrDQo+PiArTm90ZSB0
aGF0IGl0IHdpbGwgb3ZlcnJpZGUgYW55IGV4aXN0aW5nIHBhc3N3b3JkIHNwZWNpZmllZCB1c2lu
Zw0KPj4gK2AtLXNtdHAtdXNlcmAgb3IgYSBgc2VuZGVtYWlsLnNtdHBVc2VyYC4NCj4gDQo+IElm
IHRoZSBhcmd1bWVudCBpcyBvcHRpb25hbCwgd2Ugc2hvdWxkIGV4cGxhaW4gd2hhdCB0aGUgYmVo
YXZpb3VyIGlzDQo+IHdoZW4gdGhlIG9wdGlvbmFsIGFyZ3VtZW50IGlzIG9taXR0ZWQsIGFzIHdl
bGwgYXMgaG93IHRoZSBnaXZlbg0KPiBhcmd1bWVudCBpcyB1c2VkLiAgWW91IGFyZSBkb2luZyBv
bmx5IHRoZSBsYXR0ZXIsIGJ1dCBub3QgdGhlIGZvcm1lci4NCj4gDQoNCkFyZ3VtZW50IGlzIG5v
dCBvcHRpb25hbC4gSXQncyBhIGxlZnQgb3ZlciBsaW5lIEkgaGFkIGNvcGllZCBmcm9tIGFib3Zl
IGZvciB0aGUgc2FrZSBvZiBmb3JtYXR0aW5nLiBNeSBiYWQgaGVyZS4NCg0KPiBTaG91bGRuJ3Qg
dGhlICJjb21tYW5kIiBiZSBtYW5kYXRvcnksIGlmIHRoZSBvcHRpb24gaXMgdXNlZD8gIEkgZG8N
Cj4gbm90IHF1aXRlIHNlZSBob3cgdGhlc2UgaW52b2NhdGlvbnMNCj4gDQo+ICAgIGdpdC1zZW5k
LWVtYWlsIC4uLiAtLXNtdHAtcGFzc2V2YWwgLi4uDQo+ICAgIGdpdC1zZW5kLWVtYWlsIC4uLiAt
LXNtdHAtcGFzc2V2YWw9IC4uLg0KPiANCj4gdGhhdCBkbyBub3Qgc3BlY2lmeSB0aGUgY29tbWFu
ZCB0byBiZSB1c2VkIGlzIHVzZWZ1bC4NCg==
