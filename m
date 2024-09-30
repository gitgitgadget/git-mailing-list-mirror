Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012035.outbound.protection.outlook.com [52.103.32.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AAE13DDB8
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727674164; cv=fail; b=L0p6tqomIjfqyc73fhe0XuNbiLC8sDqyUMWBAY94zJ8oI8m1+GtPgm9h5+7OnweJdoQzhnfdBDW7ppWCycVs/M3TiSHm1OJYdece6n3xVtRN+QlJ8z5yvCIo/R18GnyjTJu2+14tSTw8iV0Tb+5yiRqbAh3AEyJSB5ElZ6oKsGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727674164; c=relaxed/simple;
	bh=+nYBav9qX12bdqpHEwgwoW0J3kDuMnhW++XOqSAfBjA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9my2tV8V5rqy3n3EnhRNQTTh0m/85/B5kAVoDn+9N501ujl9p4wAI3GAF3CgFmvudUL0yUFELh8oV/nWn3GNAM1hSHlJiRX0af3pvnEfwv8GZtHFO55GvnKFUBomjlXHvn9/sUYL4VYI5AkqZGacD7yepoFdVSGuks6uHJSeYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b=gl+gDJu7; arc=fail smtp.client-ip=52.103.32.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=OUTLOOK.IT header.i=@OUTLOOK.IT header.b="gl+gDJu7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kWYNrcLAMk5ZMmsxcYNjVQFLu9rLdZl9LafBnIgUGE7zygi4+ioMMxvF3YypCqfZoXScHF9UY5eCIDhUyZZdDFzXC0ugfJM6nys68bpHJR7HnwgdDGMm4CVpx3Z1hqdkDlVaegA+46vTLR6Xia3LMrGdnHzCDcIcP+wvtadjF/eGMS7Juv+4ua4Vrds0+m98uSzAlwSYo0fBWMbRxGIOZbF7kN12PDdQsK2XIioYmQj9VGihbHjGrQ6TkEestWscTHcwx2Mcdzxs30ekUqDCEwilKTcNbXUnHOd9YupP/8Fr+X6tXvD4GPyt1UrcZSbnUobdfY8PAnZmWPu56pmB3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nYBav9qX12bdqpHEwgwoW0J3kDuMnhW++XOqSAfBjA=;
 b=Krxq+vRq2cqyKxZcyVfwAK9a0Wn0ZxMqpCU6LYcGITHqD2Zs/mkaEeey4r2XXtoU785fbKxUD4SwG4lZ/5oSG75Ta2eTvkeSyMkJrzQ5NYkbxgRQTn/lawoeAlrZNtr/QjqnUPzQH6PwTVuj0LeaBHHa4WThW82S+ROPK2bGdus3MYLGIXFpNl8QgBAXVSbgPrRxyWErsSvVFt0tNbbG/K8211Wi9GwRAihcSd8S/50xopZFlCvpOHVIshlle0X3p2GIEeM6z9fzG8AwGxKN8UiFuQk2OS+DyJFnf/lI4HWHUVjsDnOCm6ES0Uw26ZiSwOVK535lifdk5jEgmqerSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=OUTLOOK.IT;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nYBav9qX12bdqpHEwgwoW0J3kDuMnhW++XOqSAfBjA=;
 b=gl+gDJu7jyOHZNj9OYiyFdaB3cT4NwneqBSdBabyzuZj4MzwuXJAUlZZqCwsYNkB1w3E4XjAyBYbJCmV5VMv+ZcvbgwZQxXrZFlgjwKZCJDKBm0RlSq6nRaVQlD4EnWBAyFzobAba77Ii0rJOqFYvZ46kIc7J01kEqlqb8IDlCnxTxc6l8tQwqu3S3VS6fkKNqQ2GppKHygFWk1msF5I69Z23Swao4+IfJzNzTuKyRSS7Yn8XWqyKsMZ1wRCz5vDVfbTfYwz/ckyLy0UFkoiP+aZHELyEpog+Aitx6tpwYfkyL3uNxBLPHgYuosawzvni0LyqICrPRbuYC4uVPFV6w==
Received: from PA4PR02MB7040.eurprd02.prod.outlook.com (2603:10a6:102:106::24)
 by GV2PR02MB8799.eurprd02.prod.outlook.com (2603:10a6:150:b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:29:18 +0000
Received: from PA4PR02MB7040.eurprd02.prod.outlook.com
 ([fe80::d593:39ef:6783:7a10]) by PA4PR02MB7040.eurprd02.prod.outlook.com
 ([fe80::d593:39ef:6783:7a10%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 05:29:18 +0000
From: "Mr. Manuel" <mr-manuel@outlook.it>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: Push to GitHub HTTP repo fails (>v2.45.2)
Thread-Topic: Push to GitHub HTTP repo fails (>v2.45.2)
Thread-Index: AdsI1dEvlCmFSLKcSLu5aHL2whWzoQJxaiaAABeAhNA=
Date: Mon, 30 Sep 2024 05:29:17 +0000
Message-ID:
 <PA4PR02MB70407ADD7FB88A87D6B965AE8C762@PA4PR02MB7040.eurprd02.prod.outlook.com>
References:
 <PA4PR02MB7040A36E17B197AB8DD7BBFC8C612@PA4PR02MB7040.eurprd02.prod.outlook.com>
 <a6dd718c-807a-c19b-b915-e6cc455256af@gmx.de>
In-Reply-To: <a6dd718c-807a-c19b-b915-e6cc455256af@gmx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR02MB7040:EE_|GV2PR02MB8799:EE_
x-ms-office365-filtering-correlation-id: 21e47f93-ed5c-47c4-2d6f-08dce110d469
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|8060799006|8062599003|8022599003|15080799006|7092599003|461199028|4302099013|10035399004|440099028|3412199025|1602099012|102099032;
x-microsoft-antispam-message-info:
 QWEo+O8iYlg1zf7STtUua/db2sgGB+SkPEI48Tb8pZySWZAHpcnIyT0mWQlcZ+pS6VmsVWx6slRY5yVESND6N55+M6pOASjisbEV8ur4/KaQXzmivBKRQga4kXJDvq+U5i9CNmf9MeKV88hEY99gwG9QHAIxUAzQSAS4kZhrZw5Q+U0cG4W8Dvr8or+NF1abKh1V2tXZzCEuiFBI/SI38deMVfpHYMugiMxtOxE8MrNPOoeSJ9hcndIAroLJaf6bcX0dTwI29d2CQOtPQZl5g++Js1y14sxKi3nWM9Xkj7mo/Ie004R2WgGsvl4TfuDMi8tYZBKtXWkgXrrcfNfw/iTZZoO6G2J80Ue6cbOV7FvpY5mCsC3fs2VzQeRD2Q9qOztAelxIi1mLDoey5Jbl8lFpGhmMhaKi8P/GyPc8y3O3aq7XSkQ1DWmMh15AExT1k+DUp4LCtciF5wypvbKoc9bXVkS8Ov0TQ0Qe0o5LD4A/0aTfuR9nSBasIvran3f9dV2Eny1set6e2rGhDPNPqT6q84Xu8I56/Ok1YixaNtagkFn+rTMB+alD0DlqgwmvqsXf4YoRxmdkQRVEvLOYsQSEFSGAnE/gmGjGHXCUUbcAItrLRwCtWLyy6QlKdiuxxiyIhSjVY1NsL7zyYl+9fUeQZv1RLri7bd8oBY9oHfu0Q5VSeNaM3uYprsji6vEnBouZvmYzoY+K0zdqytFdNiyCq+WdlQE+XCYZe0/FZlO0BFChbTkll1cgKiQMslR5ELRlviPRvL1cxgtzFpOx9V5fpLSF758l+UQrK25W/hifSEuIhIaAv3pUljg58XmkFbqzq3tS9sAserOkYxkaJxi0oLOmSUR716/5t/G+FpxZF5Zi1ZYwA8yRLdYXlR0M/J+NFFJA6H0pZpijNj1iO26/IE59TJhgTw38A0m+FuY=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T2xUalFGK3IrajEzeXlYajlXaVk5TmU5VVhhQ0RFcnVPWWp5Mm5VWGg5UFZF?=
 =?utf-8?B?eUF1LzFhYnBNbjZPb0ZteUM3Z3NScGw0Yi9zT3cxWG50UWlJMnlRRTRhRFJN?=
 =?utf-8?B?OXRyVDQ2YmRDUWp2akZSV0hwbDFVL2UxQzJZTC9EWTZYQ0JUc2ErbWpab0dt?=
 =?utf-8?B?YW1XNndtZldJWVVOWWRpREorbmdId3FHTkQ2VjNISEl1VHVyWVlkU2lGdlBI?=
 =?utf-8?B?c2tlOWRodXlybW5CRHEycXNMZXFqelRQTnk0SkxJT216TDR0MzEvRzZaa2pV?=
 =?utf-8?B?alJqZHRhR2FrMTdCRStPNFcxUVVlSytsNVVZUWR1b1pZejQ0Y2RsekRaSHc2?=
 =?utf-8?B?ZGdsTlI3eE5YZjdCbEJJYTIyZTBscGVTMnFxYjYwaXlSVEZSeUxmS2grTjdT?=
 =?utf-8?B?MWVla0kraUVyZC9La1hlREpmalJ5NFBHTUVBVCs0SGJSZTJVZThLdHVxbzBj?=
 =?utf-8?B?VDZCL1R3QUJzeEpja2JYdEV5eGtTcTl2RzRFdm5nRTZYaHBZKzUvVjMyZnJQ?=
 =?utf-8?B?QnNqSFFYZXFDcmlULzdMSSt1V3RmUGtuUUFiemtpNHdpWkdMNWVvNFo2cS94?=
 =?utf-8?B?NHp6NkNXN0hhWnZ2T2R6OGdNL1M3ZUgxS2dWQ3hNczZtdE1SdDNlcG5iYXpG?=
 =?utf-8?B?My9iajNMajhTcFZTT0lMUCtPb2ExNG1qZm9RUHBuV1NBdTBLdmFNOHlPaGVS?=
 =?utf-8?B?dGoyOG5QY1RDOCtPbEhEVVJiQXA2Qk9vZE5VS2srR3lmOTRpQzNYT01IZXFm?=
 =?utf-8?B?Z2FZTFdKUWpJK2xPd0J6Z0pKOGs0bDdGWnc3bVF2bWxwQUh3V1M2bDROaGZy?=
 =?utf-8?B?SEczZTBnTTYwcnVOSjlDWnNQbHNGaE1QVUQ5aTJuQzVWVC9YRGI1amxMMzhs?=
 =?utf-8?B?bURHaVB0SGJxMmJReTI3UTFsRTUrbkhYY1JwUmtMMWMzYUxPeG9MVko5OTcw?=
 =?utf-8?B?S2hVRHpERDk2Q2hhdEdueTdveGxvelYyekFUZ2l3eHZEa2tNUllHZE1LdUoz?=
 =?utf-8?B?dDZuV1Vldjd1RTdvS29KbmxncjdaeWozeHZZR0ZYRndWQS9ycDQwS1RMSWI1?=
 =?utf-8?B?M1JUZExKU1Y0a1B4Z083dmtpZGJwSmY0OGVFcXA1WXE2STBmZ0lLQW1NOURk?=
 =?utf-8?B?ajUyNkFWSFlObEpjMjZSdUIrV0RjZzllejl6bkFCVmRlWWpCT09HOTZaWkdh?=
 =?utf-8?B?ejNITzdlcDY3UVl6UmY0V0MvRnVLZm82Zzk2UllZbkFrVm8xdlpnQ2JEQWFx?=
 =?utf-8?B?ME5LOWhBOWxPTWl6d085MDk1ZWNtRUxqQm5SMTNrcXhuRFRqVlpIamVIK1dV?=
 =?utf-8?B?eFU5VUZHMHhpczVtbmY1RFBxc0tOV2NDVHp6dzAwekNTbkFlTjVCbVliT2wv?=
 =?utf-8?B?TDlZNTlkVFNXcWphMmFWeFNFR3E2cU9xUzFVSTJnQnhvbUZqV29CZEIzSTND?=
 =?utf-8?B?QlU5ZlpBUmpKWktiMmFqeTFDUUhyUU0xZUIzcUEzdlluM3hiSlZpUzVZRWRH?=
 =?utf-8?B?NkwrUVlKSmcxWnhuWUJxa3lQK0VQMTRXaEF4YXVyd2V1T3ZzSllNazYwVXIv?=
 =?utf-8?B?eVRwVlFzRVFsb0xyZDNWOXBlWEFCSW1hcUpsS2lINjViWkZzckM5NlRWbk9t?=
 =?utf-8?Q?ilnIfmUG/xYGG0EW3BwEq7RAGPhtCt8SkLPfx3Y8z60M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-ab7de.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR02MB7040.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 21e47f93-ed5c-47c4-2d6f-08dce110d469
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 05:29:17.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8799

SGksDQoNCnRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHlvdXIgYW5zd2VyLiBJIGluc3RhbGxlZCB2
Mi40Ny4wLXJjMC53aW5kb3dzLjEgYW5kIG5vdyBldmVyeXRoaW5nIHdvcmtzIGFzIGV4cGVjdGVk
LiBJIGhhdmUgbm8gc3BlY2lhbCBzZXR1cCwgbm8gcHJveHksIG5vIFZQTiwgZXZlcnl0aGluZyBk
ZWZhdWx0Lg0KDQpSZWdhcmRzLA0KTWFudWVsDQoNCi0tLS0tVXJzcHLDvG5nbGljaGUgTmFjaHJp
Y2h0LS0tLS0NClZvbjogSm9oYW5uZXMgU2NoaW5kZWxpbiA8Sm9oYW5uZXMuU2NoaW5kZWxpbkBn
bXguZGU+IA0KR2VzZW5kZXQ6IFNvbm50YWcsIDI5LiBTZXB0ZW1iZXIgMjAyNCAyMDoxNQ0KQW46
IE1yLiBNYW51ZWwgPG1yLW1hbnVlbEBvdXRsb29rLml0Pg0KQ2M6IGdpdEB2Z2VyLmtlcm5lbC5v
cmcNCkJldHJlZmY6IFJlOiBQdXNoIHRvIEdpdEh1YiBIVFRQIHJlcG8gZmFpbHMgKD52Mi40NS4y
KQ0KDQpIaSBNci4gTWFudWVsLA0KDQpPbiBUdWUsIDE3IFNlcCAyMDI0LCBNci4gTWFudWVsIHdy
b3RlOg0KDQo+IGFmdGVyIEdpdCB2ZXJzaW9uIDIuNDUuMiBJ4oCZbSBubyBtb3JlIGFibGUgdG8g
cHVzaCB0byBhIEdpdEh1YiBIVFRQIA0KPiByZXBvc2l0b3J5LiBUcmllZCAyLjQ1LjMsIDIuNDYu
MCBhbmQgMi40Ni4xLiBJIGNhbiByZXByb2R1Y2UgdGhpcyBvbiANCj4gbWFueSBkaWZmZXJlbnQg
c3lzdGVtcy4gRm91bmQgYWxzbyBhIGVudHJ5IG9uIHJlZGRpdDoNCj4gaHR0cHM6Ly93d3cucmVk
ZGl0LmNvbS9yL2dpdGh1Yi9jb21tZW50cy8xZjN4bW5sL2Vycm9yX3JlbW90ZWN1cmxfZXJybw0K
PiByX3JlYWRpbmdfY29tbWFuZF9zdHJlYW0vDQo+DQo+IEhlcmUgc29tZSBtb3JlIGRldGFpbHM6
DQo+DQo+IFBTIEM6XFVzZXJzXFVzZXJcbXktcHJvamVjdF8xPiBnaXQgLS12ZXJzaW9uIGdpdCB2
ZXJzaW9uIA0KPiAyLjQ2LjAud2luZG93cy4xIFBTIEM6XFVzZXJzXFVzZXJcbXktcHJvamVjdF8x
PiBnaXQgcHVzaCAtLWZvcmNlDQo+IGVycm9yOiByZW1vdGUtY3VybDogZXJyb3IgcmVhZGluZyBj
b21tYW5kIHN0cmVhbSBmcm9tIGdpdA0KPiBlcnJvcjogZmFpbGVkIHRvIHB1c2ggc29tZSByZWZz
IHRvICdodHRwczovL2dpdGh1Yi5jb20vbXktZ2l0aHViLXVzZXIvbXktcHJvamVjdF8xLmdpdCcN
Cg0KVGhpcyBsb29rcyBsaWtlIGl0IG1pZ2h0IGJlIGR1ZSB0byBhbiB1cGRhdGUgaW4gdGhlIGxp
YmN1cmwgbGlicmFyeTsgR2l0IGZvciBXaW5kb3dzIHYyLjQ2LjAgY2FtZSB3aXRoIGxpYmN1cmwg
djguOS4wIHdoaWxlIEdpdCBmb3IgV2luZG93cw0KdjIuNDUuMiBjYW1lIHdpdGggbGliY3VybCB2
OC44LjAuDQoNCkNvdWxkIHlvdSBmaXJzdCBnbyBhaGVhZCBhbmQgdHJ5IHdpdGgNCmh0dHBzOi8v
Z2l0aHViLmNvbS9naXQtZm9yLXdpbmRvd3MvZ2l0L3JlbGVhc2VzL3RhZy92Mi40Ny4wLXJjMC53
aW5kb3dzLjE/DQpPdGhlcndpc2UgSSB3b3VsZCBuZWVkIHRvIGRpcmVjdCB5b3UgdG8gYmlzZWN0
IHRocm91Z2ggdGhlIG1vcmUgZmluZS1ncmFpbmVkIHNuYXBzaG90IHZlcnNpb25zIGF0IGh0dHBz
Oi8vd2luZ2l0LmJsb2IuY29yZS53aW5kb3dzLm5ldC9maWxlcy9pbmRleC5odG1sICh3aGVyZSB2
Mi40NS4yIHdhcyBhZGRlZCBvbiBNb24sIDMgSnVuIDIwMjQgMDk6MjQ6NDcgKzAyMDAgYW5kIHYy
LjQ2LjAgb24gTW9uLCAyOSBKdWwgMjAyNA0KMTA6NTY6MTEgLTA3MDApLg0KDQpBbHNvLCBzaW5j
ZSB0aGVyZSBoYXZlbid0IGJlZW4gYW55IHJlcG9ydHMgYWJvdXQgdGhpcyBpc3N1ZSBhdCBodHRw
czovL2dpdGh1Yi5jb20vZ2l0LWZvci13aW5kb3dzL2dpdC9pc3N1ZXMsIEkgc3VzcGVjdCB0aGF0
IHlvdSBoYXZlIHNvbWV3aGF0IG9mIGEgc3BlY2lhbCBzZXR1cCwgbWF5YmUgYSBwcm94eSBvciBz
b21ldGhpbmcgc2ltaWxhcj8NCg0KQ2lhbywNCkpvaGFubmVzDQoNCj4gUFMgQzpcVXNlcnNcVXNl
clxteS1wcm9qZWN0XzE+IGdpdCAtLXZlcnNpb24gZ2l0IHZlcnNpb24gDQo+IDIuNDUuMi53aW5k
b3dzLjEgUFMgQzpcVXNlcnNcVXNlclxteS1wcm9qZWN0XzE+IGdpdCBwdXNoIC0tZm9yY2UgDQo+
IEVudW1lcmF0aW5nIG9iamVjdHM6IDI3LCBkb25lLg0KPiBDb3VudGluZyBvYmplY3RzOiAxMDAl
ICgyNy8yNyksIGRvbmUuDQo+IERlbHRhIGNvbXByZXNzaW9uIHVzaW5nIHVwIHRvIDggdGhyZWFk
cyBDb21wcmVzc2luZyBvYmplY3RzOiAxMDAlIA0KPiAoMTYvMTYpLCBkb25lLg0KPiBXcml0aW5n
IG9iamVjdHM6IDEwMCUgKDE4LzE4KSwgMTQuNTIgTWlCIHwgMi4wOCBNaUIvcywgZG9uZS4NCj4g
VG90YWwgMTggKGRlbHRhIDcpLCByZXVzZWQgMSAoZGVsdGEgMCksIHBhY2stcmV1c2VkIDAgKGZy
b20gMCkNCj4gcmVtb3RlOiBSZXNvbHZpbmcgZGVsdGFzOiAxMDAlICg3LzcpLCBjb21wbGV0ZWQg
d2l0aCA1IGxvY2FsIG9iamVjdHMuDQo+IFRvIGh0dHBzOi8vZ2l0aHViLmNvbS9teS1naXRodWIt
dXNlci9teS1wcm9qZWN0XzEuZ2l0DQo+IMKgIMKgYzdhMDI0OS4uMzc5MjQ2ZiDCoG1haW4gLT4g
bWFpbg0KPg0KPg0K
