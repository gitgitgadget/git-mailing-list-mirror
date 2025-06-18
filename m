Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2105.outbound.protection.outlook.com [40.107.20.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F072527BF7C
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282193; cv=fail; b=X/OYSOuhWIHTaGrwDqNloZapFWyiZxGtFFzdeybhjWCd1A3vn+fiMNXkdA/CXBzk4bociVttG4t03BCfJV3VrVRUinsSxyaRfgyMOCbG1rjz3WLNlwRRIqL3zIZB0ZD3ZExeqeObzGFetFSfD0O/jfWu9c4n522jaIDNhuDhCeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282193; c=relaxed/simple;
	bh=oRBfs1nLsKVWoB3grOdTv+GyTJ2U91NRmkXlS/HOlpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DqrXfJCfiFTAZzqDATq5oiOZRPUCfDF8Xg8v2N22RlXthyzk47y0ofMjPM7sh30Ksbo2pR9u7h/oIHPAvSRBi8fEbZlJ9+GZfXy556SHBecAMDKfjRLLSTCTt+1X95sSirCh+1xuW4YQkQQJAmMS75mI3Mm0mddMqUbalui3p54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee; spf=fail smtp.mailfrom=proekspert.ee; dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b=L9PPaebP; arc=fail smtp.client-ip=40.107.20.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=proekspert.ee
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=proekspert.ee header.i=@proekspert.ee header.b="L9PPaebP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O9cNMRD7a7n9E2MuGIuEmtTsbMLbDuibDLuGnUzv6cE4K8rbPmw1GpKSO4pxjopgz+HR3pAPIKcudtm2pwNawqxTbP9G+akLCgNQeG9mUKyFL1w6CglWnqtuXwQ/JXDHAitdK+JHwvHf8QJESAuPv8CwgnJ+yQa925V2lJ6lBm08W+nJIZUEzA5iJW/8epsZik3NxfQ+cRpelePg6GxawQ/+psbkEcD9HkXilZ1f8q7M+Z5ex7q/o/oEaJ+sg+YLSPCV/JwUM1XSGiz03IDhGOlJADbNgP4oJAd3v/57zg1BZC/iABO+GOrPjTheSyZZynGpfuaWI4z87kooEJEzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRBfs1nLsKVWoB3grOdTv+GyTJ2U91NRmkXlS/HOlpQ=;
 b=isO5jQALChrzmWXEL8NqPTx5XQkQ6/Yrh2t5deC2+goQBaffl8NDee0qeHat5eTJurYedyB/FTLRLNqAxOcN2ZWUxO/r53VAgrHSXlpLWdqbo2Vely452N0s7B8QQfWbcjlsJRXGQeA2pvoyzqZJp9/qEpwPRkKL9qg+tyD5o17PEspmn4/+xzY/yijeK9b08izluD/YOSO+5NYzlMsf3Ia33H6qcA7nBfJL0Q08/eBhIo1ZrwMQnPkSzcryGdEgoVJxYi6aeAsnshV7ij2A1wgwpLG2i2CzJKNKNj3ALiUJjEIsq7Hp3h33es+ZRlb2Qgb/hu1Ex2t0CFtPA/Uliw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=proekspert.ee; dmarc=pass action=none
 header.from=proekspert.ee; dkim=pass header.d=proekspert.ee; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proekspert.ee;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRBfs1nLsKVWoB3grOdTv+GyTJ2U91NRmkXlS/HOlpQ=;
 b=L9PPaebPLifoYwpO4uJVciYFWb8+k19YNop5EbEGZ9IagJSh775c2b2xc9TGvEVnkpW3zyhYZbGuzaZneJ/A8O1vVlmSNRjxPAhJScy0C8MsPMZWyNprptmESqX1uPoGpGToLIDjoI90a8JX4rC2YVlphLQXga3BdNr6jCGmqtU=
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:539::16)
 by GV2P191MB2381.EURP191.PROD.OUTLOOK.COM (2603:10a6:150:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 21:29:44 +0000
Received: from AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a]) by AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
 ([fe80::f543:e2b2:385d:af8a%3]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 21:29:44 +0000
From: Lauri Reilson <Lauri.Reilson@proekspert.ee>
To: Eric Sunshine <sunshine@sunshineco.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Possible git-gui bug
Thread-Topic: Possible git-gui bug
Thread-Index: AdupPkrODeM5biBoRQ6P7hGlivxuEAAR54MABqEe6uAACrviAAAAD8IwBxiH5mA=
Date: Wed, 18 Jun 2025 21:29:44 +0000
Message-ID:
 <AS8P191MB2174894CB42C62AC32F63DD5FA72A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
References:
 <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
 <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cR4Jb0w=McwobCrtySD1nH8sF6rv7MGduQ-yVsRUHHSBg@mail.gmail.com>
 <AS8P191MB2174D9A6C109202A5195CAA2FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
In-Reply-To:
 <AS8P191MB2174D9A6C109202A5195CAA2FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=proekspert.ee;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8P191MB2174:EE_|GV2P191MB2381:EE_
x-ms-office365-filtering-correlation-id: 3c92f958-97ad-432a-77cd-08ddaeaf3e6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cGNXVXZ5N000djFtaDFLeFpRelREYmptVHNDQ0JGMklpRjh1Q3hTV3haSGxI?=
 =?utf-8?B?NEpjZ3c1YXJDOWZkb0VwS2grbnZPa3RJamdHLzR1djdPOG1UanNDTUZTUUNY?=
 =?utf-8?B?T1J1eXdEN3VOcllHOU5BNlovY2YwQkNKd3ZpWGNZNzZNSkFZdGIrQlhxdldE?=
 =?utf-8?B?cTVXVnl2SzJHczAzNUtyUDlsK0tON0MyQ2dja0VuNW1ZazBwL1lFSzErbnpr?=
 =?utf-8?B?NXFQejlzaSt5NG1WWEZJZWpaYnNsekVzbTlJOSswNFZvbjBtUkhNOTZ3MDVB?=
 =?utf-8?B?WldBa0YrR1BLYTRybmtSeUExQ2ErOWYwOVBZWUFrWWlCZG1nMS9HemRYWE5K?=
 =?utf-8?B?Sy8xdHNZYVZUUlZTQWRxN0FYVjNvaEJuRmorTFBJT0t6NEMwdStDcVV3bVB0?=
 =?utf-8?B?TGJRK3BKWVZic3JTSnU5alpOVTl4ZitnTG85cm45cUg2TTdBeWlDd3VoaXZs?=
 =?utf-8?B?WXd2dzZZajNvWkl6dFF2S1dGU09ROUdYT2RrVnpWTnV4cGdQN0VIWDFYbGRI?=
 =?utf-8?B?VlZyTXFTUWFIdnorOEE1V3NNZlJkK3NVVFVpOHFpSWpDZlhEeTN3c3JRS21J?=
 =?utf-8?B?MWlNMno2NnRETnpWK0hudGdHWVk2Wi9tSkxDNE40ZFBERnp6VWR1VEtscHN3?=
 =?utf-8?B?SG5jVEt1MlEzZGtDT3k3b01lUVgyQ1JXRi9DQ21RdkZZMzdkV1A3U3VvSEU0?=
 =?utf-8?B?SDZ3YkZCbElZOE05a2NiR2QwVitCM2J0ekxlTVlDenBxaGpyVU00N3hVSUM5?=
 =?utf-8?B?UmFQNzcrTDNzTU5OaFJobFdqM2lWUWtnRHFXb1o5Q1BkZmIybnowU0N4bTRv?=
 =?utf-8?B?V0lGbWk2RXN1ODNPSlo1Q3lrT2FLb2thUElSK25LYlM2U2ZYaGFFYlR4MlJv?=
 =?utf-8?B?di9kVGlVQjNCa2FUalk3RlVLSDlFVzNsbGhKdkY3b3NmSVRxZkVOWmRvM0ho?=
 =?utf-8?B?enZzRTdKOEt1elc5MVpRRCtwUU5Vd2hnMUR5aFJhWDNLTmVESVJhNXBNako0?=
 =?utf-8?B?OXBlS1c1ZzdXNUtWYXZKVXdmc3JRZis1bDNQMU5mNkhqQ0NOdlUxbmdZdlY0?=
 =?utf-8?B?bGtVWEFrMXdFSnJ0aTdOa0x1VDVCMGZteGR4WTRBYk9EdytFU21MQ21tcVg5?=
 =?utf-8?B?OXhVS0YrV1ZSTTYrRGlSWnJoaVZuTFhaR05zMFRxOG4vbHJIWGdWaTN0RjUw?=
 =?utf-8?B?NGJGNm9LeW14YVV0T2x0bU55N1pBZm4xSGxaSFEzUTVnMUpGaGVDcnZtdDdr?=
 =?utf-8?B?RjM2blJqU0lLYzliNTZZSmVob0diVGdvdzYveFVOV1RmaUlOTDJabmxaTmFD?=
 =?utf-8?B?Z21oQitna3hSSWk5TGQ0ZjlDVXF5RFM4V1VjekwwaWtiMExyZTh2UGFjUUlS?=
 =?utf-8?B?Wm05aktvUWppYVVOMUluODh0Rmg0L3FHOThPMHNzZzIxQ0graVRoV055bGdn?=
 =?utf-8?B?a1gyTUhxQlBETCtvZUx5NU50UHNoY2wwNnVSUXhvd2NJcFUzdHp4bFJ3WDZO?=
 =?utf-8?B?UGNvQjFQbGJUMXgrS0xGRlBJTG9kZGV1NFBRck45QkwrWnJmVXEvbFJibjJh?=
 =?utf-8?B?Mk0yQktvcEJqTnBnb1RwSERSV1pSZSt4TFBNcWhORDZ1V0taYlVmWnZNL1FO?=
 =?utf-8?B?U1h4UmtwUkxhdTkyNnNFbGRqd1pxVWpRQ2pSd0dsQkFuL2phVkNLREk1Ny9O?=
 =?utf-8?B?cWNyRmkwM0NNYkxDWVEyQ3Z5dVF1VXpKcHZETU9JSFFuV0VBcVF2R3FDSFZW?=
 =?utf-8?B?SUJkb0VMemRVeXZLajEwdlNPY0JaUVc3U1pFZ3VDeWx2UWNWRk1iTE45VHA2?=
 =?utf-8?B?SXBjbDdGOW92QUREcDdvT2JRY2REUkVpNWVxQkVUWlYxUDBjTEkwVTlUNzE5?=
 =?utf-8?B?OUNLeDdzRC8wLzNDY2tKU0RBM2F2MklZV0pOVi9XZWJINGg1bjV3ZzRxcUQ5?=
 =?utf-8?B?Y3ljN21NaW5BaTltbGJqZEE0RHpFbENHZ3BCcFRUNHl6TTUyOUJVYWVXbGxR?=
 =?utf-8?Q?YnFL8BKZO3Ivm8ZhQ+1uCl6NSUpEUc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P191MB2174.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUY0YkFMcGVFdEhDZmZNQ0h2alJZcjdzbDRucG12YmdNVFloR2pjNjZ0UlhY?=
 =?utf-8?B?cVEycCtDVEMwWlVaTVJ2NkVEVDQvR2R6QWFtYUhhZ1VZU082S24wTVE4bGho?=
 =?utf-8?B?Wnp4U1lLaU9SNzFuaE5mdUNrSzZQczg5MFB0bFIrcmRMN20zdTNJM3dyaGdu?=
 =?utf-8?B?alMvWndGMi9QL2lMZ0FkWmozR2VlYVNLeWlpd29xcGZkbFNZR2JhMzdwS1Rr?=
 =?utf-8?B?dkoxSWtKUHp0NmZJV0IxQytYeG5QZjhaUWtlNnNoU3JoUVJodVRsSjhsQk9o?=
 =?utf-8?B?N3VHM1cxYUNaci9kVlVOV09CVmFZZ2FON3NPS2FiT0tEU0FHQnBCWVFRYkx3?=
 =?utf-8?B?ODB4K0I3UkZkT2pXSlg2T0VUdVpSMld3SHFUWHdGTlJ6WEM0blNqRWM1ZmJt?=
 =?utf-8?B?ZDdaeWJkMHhVQ01aYTZETVo1bGlTZ2c2aWdNN0p1dm1rSm5Kc2dHeFNaMGdX?=
 =?utf-8?B?TVoxS21MeHJNY1FYcERNa09EMWovYjV1MWFhNUs4NXhmdGNOMFlQZEh4VzVo?=
 =?utf-8?B?OXA1T1hBUzBJYU9DT050dlBaWm1IQ0FVWHVtNmFkc2p4WnBOd1VVbFVpNUc4?=
 =?utf-8?B?MmtaU1JMNXhUQzBZV2pjQmN0SEpCZ2F3Z1N6eTVxRVFFRmRXYUdhN3lBd3g5?=
 =?utf-8?B?N1p6WkcxSlE4NGVZNDJocGhFK01ER3BBZkNwY2l1WTZGUkhBMzBBUzNnbUdE?=
 =?utf-8?B?Z2JHZlMyZk1vUWVtTmk3aXdDU1E0cUJmUlBpaUtmN1k0eVBVVmRBZ1Z1bEE3?=
 =?utf-8?B?T0FnY3RRa3kxckcxSVcwT293d1pHNUw1NzhWOUNiM3VLZXJOZFVMODFGRm5n?=
 =?utf-8?B?VGtTeHBkTHJac2NtZmhyWG52ZkVXQjhPK3JHTGpvaVBNeEozZnJBbEpGWGl6?=
 =?utf-8?B?UjZiL3g3Q0JTZXcyc05EcWxVcThPWXh1SExmaURZamNDRkx2cE1OMDVuVnRy?=
 =?utf-8?B?ZXRvSW9acUdMSXh4SVNJRlZMUEMwMTc0Z1JtQk04UlY0d1NJU0F6TVBza2Yw?=
 =?utf-8?B?YlNtd0Y0Y2dVbk9ab3RldTNIaENQSCtKdUR1ZjhyMS9YMjkvN0RBTUx6TG9Q?=
 =?utf-8?B?TVRCRnU4MkVCOGplbFFsVFJqMkRWQ1BIS3hWaUk2VG9NWDUwNmhVNXZxS1hK?=
 =?utf-8?B?dE1LWjZRNE1FK2dLUTlwSzY3TE96QzNDei9xSUFEUHJkdkNIZlVIa29xZjl4?=
 =?utf-8?B?SUFrTkk1bUI0VHZIZXExSWhlTnNScmZ1enpxY2x4eGMzOG1qUWJqM05nZmZI?=
 =?utf-8?B?bDBCM00rYXBqeGtSWklxSXRGa0wwOTFVOWJiYzlxNE1FZk1JSVI4aHJZc2p1?=
 =?utf-8?B?QnE4SVJTWDgzR2tzMjNVUTNXVGRwRW9FNVFYV2VOd2prWmJvdmJMQ3BTNkxv?=
 =?utf-8?B?elpuMFJwQTRUayt3dlRxcUoyOW9jZWYxOXhteWRlUS9oanJGbHYrd1BMb3Mr?=
 =?utf-8?B?V3Ewemg3MThVMW9wYmlkRHo1WkpqMGpyRXpjZWl6REk1Q3JubE9wWUhwd2RG?=
 =?utf-8?B?OG4xVG5CWW1VbjhZMnB1b2pBYnIxL2w4bUd0VkZpd0J6SjFoSFRSS00vbEM1?=
 =?utf-8?B?Um1MZzJNamhWbkxrMzhmUnhqa1QrNEF6T05NUlI3ZFpvUkpWRTV1V2RjWUNS?=
 =?utf-8?B?VUdjRExnWGxpb2dsRXdJaEVTWE5IOFl4cDVyaDVkRzU0YVY0Y3JNMThsNk5t?=
 =?utf-8?B?MnM4bHROZ2gxRXpTWkhtZEtVRkFObC9DV1ZMQVY1S3ZYREUvN0ZyOXd2T3pq?=
 =?utf-8?B?UXp6TCtwQS9HOUZCeG9TbE93UjRnN1BRWGQ0U205M3R0eWZiQThYOUVRRjBZ?=
 =?utf-8?B?TFR3d2l1b1ozQTJzSGFKZ2QyVnRBdkRycXUyNlJlWktOMWkzODI0ZGlLdVQy?=
 =?utf-8?B?N1lxT1gxbXVzVWVKQlpYYmZBSk5pZGUvSGorN2FMZEZoQ2Z6a2gwRmR4ZVJu?=
 =?utf-8?B?eFlyZEZKUS9MeWMwWjU5M2ZWMHZ5cGhxWmtWcGJTQ1FoZlc0MkVxVUJ5UWhP?=
 =?utf-8?B?TFpYMUczT0FWZTZhSzlscGhpTXNqLzRvVEMyYm8vQ0JFckFQRTdwajk0L0JQ?=
 =?utf-8?B?aDdsNXc2dkdmTExibnNoMU5RNXZuNTFGQ1VBSGREYkdyVS94Mk5jclhEWVRr?=
 =?utf-8?Q?nmnQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: proekspert.ee
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P191MB2174.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c92f958-97ad-432a-77cd-08ddaeaf3e6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 21:29:44.5625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4fc69ca6-ce6b-4059-8ad9-2049c3c135b3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PVr7bkF5ecx5Atf0O8kbfpLPHxNatOBttxbG82YhOWQ+iXyzHCnm/6lhkvkWskpJd1soUdQ6DpQlyPsUtuEu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P191MB2381

SGksIEVyaWMhDQoNCkkga25vdyBJIHByb21pc2VkIHRvIGNoZWNrIHRoYXQgcGF0Y2ggb3V0IGFu
ZCBnZXQgYmFjayB0byB5b3UuIFRoZSBmaXJzdCBwYXJkIEkgaGFkIG5vIHRpbWUgdG8gZG8uIEhv
d2V2ZXIsIEkgaGF2ZSBpbnN0YWxsZWQgdGhlIGxhdGVzdCBHaXQgdmVyc2lvbiAoMi41MC4wKSBh
bmQgbXkgcHJvYmxlbSBpcyBmaXhlZC4gVGhhbmsgeW91IGZvciB0aGF0Lg0KDQpIYXZlIGFuIGF3
ZXNvbWUgc3VtbWVyIQ0KDQpMYXVyaSBSZWlsc29uwqDigKLCoFNvZnR3YXJlIEVuZ2luZWVyDQps
YXVyaS5yZWlsc29uQHByb2Vrc3BlcnQuZWUNClBST0VLU1BFUlTCoOKAosKgU8O1cHJ1c2UgcHN0
IDE1NywgMTM0MTcgVGFsbGlubiwgRXN0b25pYSwgRVUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IExhdXJpIFJlaWxzb24gDQpTZW50OiBUdWVzZGF5LCBNYXkgMTMsIDIwMjUg
OTozNSBQTQ0KVG86IEVyaWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPg0KQ2M6
IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJFOiBQb3NzaWJsZSBnaXQtZ3VpIGJ1Zw0K
DQpUaGFuayB5b3UsIEVyaWMhDQoNCkknbGwgdHJ5IGl0IGFuZCBnZXQgYmFjayB0byB5b3UuIEl0
IHdpbGwgdGFrZSBzb21lIHRpbWUuIFBvc3NpYmx5IG5leHQgd2Vlay4NCg0KV2FybSByZWdhcmRz
LA0KDQpMYXVyaSBSZWlsc29uwqDigKLCoFNvZnR3YXJlIEVuZ2luZWVyDQpsYXVyaS5yZWlsc29u
QHByb2Vrc3BlcnQuZWUNClBST0VLU1BFUlTCoOKAosKgU8O1cHJ1c2UgcHN0IDE1NywgMTM0MTcg
VGFsbGlubiwgRXN0b25pYSwgRVUNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IEVyaWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPg0KU2VudDogVHVlc2RheSwg
TWF5IDEzLCAyMDI1IDk6MzIgUE0NClRvOiBMYXVyaSBSZWlsc29uIDxMYXVyaS5SZWlsc29uQHBy
b2Vrc3BlcnQuZWU+DQpDYzogZ2l0QHZnZXIua2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFBvc3Np
YmxlIGdpdC1ndWkgYnVnDQoNCk9uIFR1ZSwgTWF5IDEzLCAyMDI1IGF0IDI6MDnigK9QTSBMYXVy
aSBSZWlsc29uIDxMYXVyaS5SZWlsc29uQHByb2Vrc3BlcnQuZWU+IHdyb3RlOg0KPiA+IEZyb206
IEVyaWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPiBPbiBXZWQsIEFwciA5LCAy
MDI1IGF0DQo+ID4gNzoxMeKAr0FNIExhdXJpIFJlaWxzb24gPExhdXJpLlJlaWxzb25AcHJvZWtz
cGVydC5lZT4gd3JvdGU6DQo+ID4gPiBJIGhhdmUgYSBzbWFsbCBpc3N1ZSB3aXRoIGdpdC1ndWku
IEkgYWRkZWQgdGhlIGdpdC1idWdyZXBvcnQgdG8gdGhlIGF0dGFjaGVtZW50Lg0KPiA+ID4gRXhw
ZWN0ZWQgdG8gY29tbWl0IHVzaW5nIGdpdC1ndWkuIENvbW1pdCBtZXNzYWdlIHdhcyBpbiB0aGUg
Zm9ybWF0IDwjdGFzay1pZCBtZXNzYWdlPi4gSSB1c2UgIjsiIGluc3RlYWQgb2YgY29tbWVudCBz
eW1ib2wgYXMgIiMiIGlzIHVzZWQgYXMgYSBtZWFucyB0byB0cmFjayB0YXNrIGlkLg0KPiA+ID4N
Cj4gPiA+ID4gV2hhdCBoYXBwZW5lZCBpbnN0ZWFkPyAoQWN0dWFsIGJlaGF2aW9yKQ0KPiA+ID4g
R2l0LWd1aSBnYXZlIGVycm9yIG1lc3NhZ2UsIHRoYXQgSSBuZWVkIHRvIHByb3ZpZGUgY29tbWl0
IG1lc3NhZ2UuIFRyaWVkIG9uZSBsaW5lLCBmb2xsZWQgdGhlIGVycm9yIG1lc3NhZ2UgKGZpcnN0
IGxpbmUsIGJsYW5rIGxpbmUsIHJlbWFpbmluZyBsaW5lcykuDQo+ID4NCj4gPiBUaGlzIHNvdW5k
cyBsaWtlIHRoZSBwcm9ibGVtIGFkZHJlc3NlZCBieSBbMV0uDQo+ID4NCj4gPiBbMV06IA0KPiA+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC8yMDI1MDMxNTE0MDkxMy41Nzc0MjItMS1vc3dh
bGQuYnVkZGVuaGFnDQo+ID4gZW5AZ214LmRlLw0KPg0KPiBTb3JyeSBmb3IgdGhpcyBsb25nIHJl
c3BvbnNlLiBUaGFuayB5b3UgZm9yIHRoZSBpbmZvcm1hdGlvbi4NCj4gVW5mb3J0dW5hdGVseSwg
SSBkb24ndCBmb2xsb3cgcXVpdGUgd2VsbC4gSXMgdGhpcyB0aGluZyBnb2luZyB0byBiZSANCj4g
Zml4ZWQgb3Igbm90Pw0KDQpJdCBhcHBlYXJzIHRoYXQgdGhlIG1haW50YWluZXIgb2YgZ2l0LWd1
aSwgSm9oYW5uZXMgU2l4dCwgYXBwbGllZCB0aGUgcGF0Y2ggbWVudGlvbmVkIGFib3ZlIHRvIGhp
cyBnaXQtZ3VpIHRyZWVbKl0gYW5kIHRoYXQgSnVuaW8gYWxyZWFkeSBwdWxsZWQgdGhlIGZpeCBm
cm9tIEpvaGFubmVzJ3MgdHJlZSBpbnRvIHRoZSBHaXQgdHJlZS4gQWx0aG91Z2ggdGhlIGZpeCBo
YXNuJ3QgeWV0IG1hZGUgaXQgaW50byBhIEdpdCByZWxlYXNlLCBKdW5pbyBoYXMgYWxyZWFkeSBw
cm9tb3RlZCB0aGUgZml4IHRvIGhpcyAibWFpbiIgYnJhbmNoIHdoaWNoIG1lYW5zIGl0IHdpbGwg
bGlrZWx5IGJlIHBhcnQgb2YgdGhlIG5leHQgR2l0IHJlbGVhc2UuDQoNCj4gSXQgaGFzIGJlY29t
ZSBxdWl0ZSBhbm5veWluZyB0aGF0IEkgY2Fubm90IG1ha2UgY29tbWl0cyB3aXRoIGdpdC1ndWkg
DQo+IGFuZCB0aGVyZSBoYXNuJ3QgYmVlbiBhbnkgdXBkYXRlcy4NCg0KSXQgd291bGQgYmUgaGVs
cGZ1bCBpZiB5b3UgY291bGQgdHJ5IGFwcGx5aW5nIHRoZSBwYXRjaCBtZW50aW9uZWQgYWJvdmUg
dG8geW91ciBsb2NhbCBnaXQtZ3VpIGluc3RhbGxhdGlvbiBhbmQgcmVwb3J0IGJhY2sgaGVyZSB3
aGV0aGVyIGl0IGluZGVlZCBmaXhlcyB0aGUgcHJvYmxlbSB5b3UgYXJlIGV4cGVyaWVuY2luZy4g
SWYgaXQgZG9lcyBub3QgZml4IHRoZSBwcm9ibGVtLCB0aGVuIG15IHN1cHBvc2l0aW9uIHdhcyB3
cm9uZyBhYm91dCB0aGUgbWVudGlvbmVkIHBhdGNoIGJlaW5nIHJlbGF0ZWQgdG8gdGhlIHByb2Js
ZW0geW91IHJlcG9ydGVkLiBJZiB5b3UncmUgbm90IGluIGEgcG9zaXRpb24gdG8gdHJ5IHRoZSBw
YXRjaCBsb2NhbGx5IGJlZm9yZSB0aGUgbmV4dCBHaXQgcmVsZWFzZSwgdGhlbiBwZXJoYXBzIHRo
ZSBiZXN0IHlvdSBjYW4gZG8gaXMgd2FpdCBmb3IgdGhlIG5leHQgR2l0IHJlbGVhc2UgYW5kIHJl
cG9ydCBiYWNrIHdoZXRoZXIgaXQgZml4ZXMgdGhlIHByb2JsZW0geW91J3JlIGV4cGVyaWVuY2lu
Zy4NCg0KWypdIGh0dHBzOi8vZ2l0aHViLmNvbS9qNnQvZ2l0LWd1aS9jb21taXQvNmI0M2E1N2Rm
Y2UxZTVhY2Q4NWY3YTgzNjVjMDgwYjZmYzRmODY0NQ0K
