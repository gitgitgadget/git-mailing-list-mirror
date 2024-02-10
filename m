Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2101.outbound.protection.outlook.com [40.107.14.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9AA2EAF9
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707558152; cv=fail; b=qL5ICzQq9xHMSZ6+TsktjrmeyWXA/RB//F1QL6lUYi9vz9a0Ce7JbJKFSZ+M/XHYZZEdFzRKO3kdzjC+EFKiVimkQz40hDWF14KPXz8lM6AFpuiwHn+uAwP+VhmAMfqRMwUUNMKXzbUCIbF2EQKS6OL3OT1Cf9qrabtMZwwK4/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707558152; c=relaxed/simple;
	bh=SRqjU870ELmylvavhipvBR8+au5dZd71iU0fJ8AZDDA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqu4Sw1VY8gAPX6HBBXJjqKyT/XS9lSfbrvP5tHzAQlNBvMd8t5hkcNzP/clDY+iNKB39QKkmg7QvEYAdF/zGuXeb3oIcm/dpaBn1jrNa/Oj3sM/StY7i+2HcMqWfj6RpZJomLphmVW/kK8LjBJZZip9tJ3ebBWwC8nsEURxsaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io; spf=pass smtp.mailfrom=qt.io; dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b=hwCnrgN5; arc=fail smtp.client-ip=40.107.14.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qt.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b="hwCnrgN5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oejHCxgxbmxs13hYmrXeSggoByc4Iq9oTaRudQI7/VoD0mRl7MTP6C4qvDP3fzk0CH+VMc8wGtETvYow1UOG7clSg/szFMMWaYUEZnZQY6VVfc0ZenjmfIp0171Elb2OE+aHamlO5IsImaTDFEsZjFisUPr+/uf42v2BcyXNly4dNhd3tDgi6iSF8jimtFyFK3GhbkdeR4kB9tLrx9DeZ+RUrcm+okYSypjJaCsQNLMIrJ4+8MG9pteziH5q1My7MgeisJjZBO6CZNEOrQLRkI9pRSUliMg7znqR1S4RI8T8ZJ9i0VjA+r34jaxy6Hw2WrqgRwEmvUpEF2n4XKs7Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRqjU870ELmylvavhipvBR8+au5dZd71iU0fJ8AZDDA=;
 b=Uy1GhVmOg0V+l5QQmMo4b0qtkGKBcbwMxkCxSye8cP8vk/9BiPdOAMMbkQgBEdKxZOEnmjmSzPhUTzMRfhK6mrPr/Rz+GGsZNdJhYqOxEwrF+LVvqiM8prVZdEk/FDq6uPUlAwp7jI4BDDJnREDmw/x+oJ5FZeosBx4Gmec0d5OUaQIUbkTYES9qsm+q8Jeo73QsC89Owy1FsIS4iEOBsie4y/5mInLJTpalcQONhruI31k5d1VaFy5mGjx9/ZIldP6YYOFtuPG/HWETyzv4KLJ49WJ4uYO9B0RfbrbN5k8i76ekSWaR7UovFVt841q4rpBu3ZwKfzcQNwz6KmsZDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qt.io; dmarc=pass action=none header.from=qt.io; dkim=pass
 header.d=qt.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRqjU870ELmylvavhipvBR8+au5dZd71iU0fJ8AZDDA=;
 b=hwCnrgN51wjbiR89sRExod5Rw7zMjaoq7Xy9zJGPxPaermzvPXvtpnGxHORsN5/CA2gwiSISoJclhnjvi9QEjlVDyJtyYAYc6mWd8YTaq+MhvK6qFz6TZNcsYXb0X120SQOsyG8EKcBqht0GqcopGZ8occquxIQ2+olUhNXUudc=
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com (2603:10a6:102:302::20)
 by AM7PR02MB6371.eurprd02.prod.outlook.com (2603:10a6:20b:1be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Sat, 10 Feb
 2024 09:42:25 +0000
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::165:5314:754c:74f]) by PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::165:5314:754c:74f%5]) with mapi id 15.20.7270.033; Sat, 10 Feb 2024
 09:42:25 +0000
From: Marcus Tillmanns <Marcus.Tillmanns@qt.io>
To: Junio C Hamano <gitster@pobox.com>
CC: Kristoffer Haugsbakk <code@khaugsbakk.name>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though
 --author is used
Thread-Topic: Bug: Commit fails when no global email address is set even
 though --author is used
Thread-Index:
 AQHaWqMf1aEsN7y+JEu1IkWahU84VrEAl8SAgAEKIICAAA8wAIAAAoKAgAAmJoCAAGx0DoAAAimAgAAmry+AAOaNgA==
Date: Sat, 10 Feb 2024 09:42:25 +0000
Message-ID: <8DDFD548-1540-4E41-8AA3-84E273372F01@qt.io>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
 <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
 <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
 <5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
 <xmqqfry1h7ej.fsf@gitster.g>
 <d59a0e25-81c4-4ecd-826e-ef4b23423575@app.fastmail.com>
 <xmqqfry1fm2e.fsf@gitster.g>
In-Reply-To: <xmqqfry1fm2e.fsf@gitster.g>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qt.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9617:EE_|AM7PR02MB6371:EE_
x-ms-office365-filtering-correlation-id: ca2631fa-e4a0-4142-57d3-08dc2a1c96ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MwmCq0lIM6qDx2IUINrySE3m+UahMgN+DD5idcPsTM2ce5lEnWdiy5Nbp5GEgJ8JRn7Nw8m8c5kIbvizvkCrkGWWNo2C3Hq//gzFgN262MnwRP52TcYV5H3mFNAKc9yo47Jh471yQWICNTorQLk6QA/+aGnfVbJzGncfx2QS3lhjaOIKwN1R8GFenVEPi7s3ZfIKK+S+I5VoVflvcQuHpfvKRhtzuMo885nx1q29U1ZevKdHnx0OOc/jgfrLfJAAKbrACbUvJr9tawIod9jOql6LLP+KscP4jAUDvfmj73junkU8ER4A6kmXirB7+AfUGQ4vjIaGMZTp6/9UwEmXjw8doei5km5RphhnDZpObzDbrCUhuQC6N3n78x2tWhf2coI7+HIAD5AtsPQLwYImyeh0OQpEyCoMEVXkbwFRDVG1VRujzj7oZSkou8J+Ug2ehNu2rnrWQwqjWeTk0GrB+5hEaHDDHYGyKBVoEt5dhuTvTGsvjUeHtGH5DM1QXapxvCC0/fuyQdp/2TWOgdpQUdHO1LN1O+cX9krzYkDTaG0gHiBLPMXfC+hZgdxaYJarQCq16ggb5OO1JJ5bBKOve8atiW92edi115D8xcWiwIdI3jPRfNDuWb+OhBndPEgo
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9617.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(346002)(376002)(366004)(396003)(230473577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8936002)(2906002)(8676002)(4326008)(5660300002)(66899024)(66556008)(83380400001)(2616005)(26005)(33656002)(38100700002)(36756003)(122000001)(86362001)(38070700009)(76116006)(6506007)(6916009)(316002)(66946007)(66476007)(66446008)(64756008)(54906003)(71200400001)(966005)(6512007)(478600001)(6486002)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2owcEdra1A3NTVjS3pqN3VMZ2RHRGJmaEVqQTVXMVNpS0xCNnZCNzVROXd2?=
 =?utf-8?B?MnBPb05tWk41NlVuYklWekJEUXk1cHBKQWdEdTdGVk1yU1hycTZsTjVvRlJE?=
 =?utf-8?B?WGZnaitDYURDTUJJclVJMFViTVJSWXlZdjI2SVdnTXJvUVdpZ2RJdlFVOFBr?=
 =?utf-8?B?eTM1MHB6djRqdTgvVnl4YUZ5MHBNb0QrRG9KVFBWVDNaZ3hQZUZwOVhPYVZo?=
 =?utf-8?B?OWtRYVdocnpuSFFtbkRrdUZqckh2ajFhUWVZZzdkYUtjQTVwTFZ0b21hRWVk?=
 =?utf-8?B?aXJLVlhkT1pBWVVFa1NYandiMWV3bEQ5WEhQLy9PbE9WQjlNV1lQVHZoL3Jv?=
 =?utf-8?B?OTVoQkRUeGJnajEyYncxZTFPL2dGcnBpUEtGUFJkaGRBMUVPL0F3eUowVVVS?=
 =?utf-8?B?MkhUZGQ5RERnTEN1UDJET25UU0pRNnBUZDBnUCtnaFV1K0x4aWNOSFlvajNj?=
 =?utf-8?B?aFdGcm1YWkpIV3J6OFlTZ0RVRldJOG5ISVZnQWwzUWlpNlNhUHZyZytmbG8v?=
 =?utf-8?B?dEdaVzBYaVNEQ3VlNHBDVFY1MGRDZVVFZ1JabXZGZWxEaXJkSituYzJsc1Nw?=
 =?utf-8?B?SnZLbFR0dUQvWGFCZDFqN3BQOWtocFY1c3Bld3lNajM3d1NRU3JFM3FGVDVw?=
 =?utf-8?B?dWhXQy9KZjlLbU5ESHNWdytwVk1tT1JRZUhlNmdRamorbkpLVlBuMVlZaHB3?=
 =?utf-8?B?RnBxZjQxUmdkQ3hOd0drQVJOVkYrcGV5T0pQK0xGNUtyeXFXRTRzN2VoNlIz?=
 =?utf-8?B?blFqNldKU2pCbncyYnJVSFpoRUFqMkNJZHdwTnhEWWl5SlZnWFlNYnhjNWg5?=
 =?utf-8?B?UmlqY1FobmRTT0t6OWVxaUNOZjAwS0pLRm92Qml4b2NoUEdNRElxWmJQU1Vn?=
 =?utf-8?B?MGhqNmhYSm5YZ1JnTjdvUlVpaUsvWFFjMnVuM0lWa3c3WXdQbUtVaVlHMHlL?=
 =?utf-8?B?YWlWMmFNcEhGV09wSnN5aCtORFR3c3RwYzdZbHk1OHJhbHRtTGdBWFh3bzI3?=
 =?utf-8?B?MzBGOWphdXdreGZGRW9MVEsvVjFvbW54eUE4cTFDMWZzb1Z4a1R6R1Z4Tmgz?=
 =?utf-8?B?ZHhjMGpITU5pQ1ZBMDVtQWtBZkxwZjNLa25XdmVYL2llWTNsaE9mdFVSV0ZG?=
 =?utf-8?B?WitBZE91WUNNcTIzY0NXRjVOeDlnS0JzWENvQkRWb3NQckdta2ZEZEl5aFBI?=
 =?utf-8?B?NjVVRFRnZEUzV0FSNTc4MGMwMzRwRW53VzFRckhBaHFkZzAxak1FVUxDRGNx?=
 =?utf-8?B?RXBZWUNEWnpPN1ZBeTl3aEszWUY1UUthMmJGWjFuMjhDdDVqbTJJZU5GTmYx?=
 =?utf-8?B?bkNTZkRpMm1WY1lpSGZuZk1ueGNDRS9tdlJ0L29CMVYrUHN3bjFKTmtRNmFJ?=
 =?utf-8?B?dTl4MHV0b1pNMXJSd1NGRTVLck1PUUdXNmg4RWRqb1ZVSEZsRVBZSE91UU9u?=
 =?utf-8?B?bk1PbXl6THNJNEdLcmFqbDBrREtuS2M0bDlZVUhFU205NTdjeU5PN20wUTBK?=
 =?utf-8?B?QzVHR1RiVW5DNTQrRVg1ZDBkK0V6UGpNZmNtaE82NktYaHBtWUpYOHZzbHRW?=
 =?utf-8?B?c0JORitzT1d2RXBWM0hTYUk5cDBvWFNTVzVVamc1cFJjYVkzbUtOTy9zajR1?=
 =?utf-8?B?UXpCRkMwbzZRVUpYeFJ2dGFIc2ZUYnQwb0hqUWZsZXBzYkhtakdzUU1kMnFk?=
 =?utf-8?B?dVFtY1JlSzZGbTJuVkF1ZGt4WXdrMHhoSzJRTFpHRGxURW9Xb2tyY3dEMnBL?=
 =?utf-8?B?dDdlY3lKRGhIcU4xc2JzZ1pTVTVaQXprL2hpcCtoa1hoQXNIc2VvZUZnM25D?=
 =?utf-8?B?RXZ6am8yUlBOV1RmdWZiM2hhaEtlT2E1RzdBTk80bjhmZlk1SStPOExpR0l0?=
 =?utf-8?B?Ni9EWDVST3pETUR6Kzd6Nld3MXIrb2d0T2RsN3R0NWZDRjQybFJxOHZWWWM2?=
 =?utf-8?B?UzE3b3ljY1BGUXkrSnZvTEJsQ2Uya1o1V2dQWVlPWWZQSWJTZWEzdlFzcWJ1?=
 =?utf-8?B?Q2k3dTVvK0lMdHZEaEhNQXVYN1RXRVliWlRYblVqbWtzNE54M0VtRVpBY2hv?=
 =?utf-8?B?dzM5K3BwOTduNXVqWVg5SjVlRkFrSFhHeDFzRnRibzJ0ekNlQjRwNUpidVp1?=
 =?utf-8?B?ajZuUTFXQ01mMTJWRlRubUlrbHMyNDNyUG1DS1BzSzczZkdpblh0T1lMZWZK?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5487A887DBBE0443A16987FF18DFB459@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR02MB9617.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca2631fa-e4a0-4142-57d3-08dc2a1c96ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2024 09:42:25.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JiWnNq1v/EKMgSSisAXRJa4/Jh4WWasimvwtSoWB41bjJ84jT9wqozSM/j4DgUWhZwV0srTxE/dsx3WUABVCTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6371

Rm9yIG1lIHRoZSBpc3N1ZSB3YXMgdGhhdCBJIGtuZXcgYWxyZWFkeSBhYm91dCB0aGUgZ2xvYmFs
IGNvbmZpZyBzZXR0aW5nLCBidXQgaW4gbXkgY2FzZSBJIHNwZWNpZmljYWxseSBkaWQgbm90IHdh
bnQgdG8gc2V0IHRoYXQuDQoNCldoYXQgcHVsbGVkIG15IGF0dGVudGlvbiBhd2F5IGZyb20gdGhl
IGltcG9ydGFudCBwYXJ0IHdhcyB0aGUgaHVnZSB3YWxsIG9mIHRleHQgYWJvdXQgaG93IHRvIHNl
dHVwIGdsb2JhbCBzdHVmZiBldGMsIG1ha2luZyB0aGUgc2luZ2xlIHdvcmQgaW4gdGhlIHRvcCBs
ZWZ0IGJhc2ljYWxseSBpbnZpc2libGUgdG8gbXkgZXllLiBJIHdhcyB0aGlua2luZyAiSSBhbHJl
YWR5IGtuZXcgYWxsIHRoYXQsIEnigJl2ZSBzZXQgdGhlIGF1dGhvciwgc28geW91IGNvbXBsYWlu
aW5nIHN0aWxsIHdpdGggdGhlIHNhbWUgZXJyb3IgbWVzc2FnZSBtdXN0IGJlIGEgYnVn4oCdLg0K
DQpJIHRoaW5rLCBpZiBhIHVzZXIgdHJpZXMgdG8gY29tbWl0IHdpdGgg4oCc4oCUYXV0aG9y4oCd
LCBhbmQgZ2l0IGZhaWxzIHRvIGZpZ3VyZSBvdXQgdGhlIGNvbWl0dGVyLCBpdCBzaG91bGQgaGF2
ZSBhIHNwZWNpZmljIGVycm9yIG1lc3NhZ2UgYWJvdXQg4oCcaGV5LCB5b3XigJl2ZSBzZXQgdGhl
IGF1dGhvciwgYnV0IHdlIHN0aWxsIGhhdmUgdG8gZmlndXJlIG91dCB3aG9tIHRvIHNldCBhcyB0
aGUgY29tbWl0dGVyLCBvciB5b3UgY2FuIHVzZSDigJzigJRhdXRob3JBbmRDb21pdHRlcuKAnSBp
ZiB0aGV5IHNob3VsZCBiZSB0aGUgc2FtZeKAnS4NCg0KVGhhdCB3b3VsZCBtYWtlIGl0IG9idmlv
dXMgdG8gdGhlIHVzZXIgd2hhdOKAmXMgZ29pbmcgb24uDQoNCkNoZWVycywNCk1hcmN1cw0KDQoN
Cj4gT24gOS4gRmViIDIwMjQsIGF0IDIwOjU2LCBKdW5pbyBDIEhhbWFubyA8Z2l0c3RlckBwb2Jv
eC5jb20+IHdyb3RlOg0KPiANCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBnaXRz
dGVyQHBvYm94LmNvbS4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWth
Lm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+IA0KPiAiS3Jpc3RvZmZlciBI
YXVnc2Jha2siIDxjb2RlQGtoYXVnc2Jha2submFtZT4gd3JpdGVzOg0KPiANCj4+IE9uIEZyaSwg
RmViIDksIDIwMjQsIGF0IDE4OjMwLCBKdW5pbyBDIEhhbWFubyB3cm90ZToNCj4+PiBTbywgbm93
LCBsZXQncyBiZSBwcm9kdWN0aXZlLiAgV2hlbiBzb21lYm9keSB3aG8gZG9lcyBub3Qga25vdyBt
dWNoDQo+Pj4gYWJvdXQgR2l0IHRyaWVzIHRvIGNvbW1pdCB3aXRob3V0IGNvbmZpZ3VyaW5nIGFu
eXRoaW5nIGFuZCBoaXRzIHRoZQ0KPj4+IGVycm9yLCB3aGF0IGlzIGEgbW9yZSBhcHByb3ByaWF0
ZSBtZXNzYWdlIHRvIGd1aWRlIHdobyBkb2VzIG5vdCBrbm93DQo+Pj4gd2hhdCBoZSBvciBzaGUg
ZG9lcyBub3Qga25vdz8NCj4+PiANCj4+PiBUaGUgdXNlciBjbGFpbXMgdGhhdCAiY29tbWl0dGVy
IGlkZW50aXR5IHVua25vd24sIHBsZWFzZSB0ZWxsIG1lIHdobw0KPj4+IHlvdSBhcmUiIHdlcmUg
bm90IGhlbHBmdWwgZW5vdWdoLiAgV291bGQgaXQgbWFrZSBpdCBtb3JlIGhlbHBmdWwgaWYNCj4+
PiB3ZSBhcHBlbmQgaG93IHRvICJ0ZWxsIHdobyB0aGV5IGFyZSIgYWZ0ZXIgdGhhdCBtZXNzYWdl
LCBwZXJoYXBzDQo+Pj4gd2l0aCAiZ2l0IGNvbmZpZyIgb24gdXNlci5lbWFpbCBhbmQgdXNlci5u
YW1lIHZhcmlhYmxlcywgb3INCj4+PiBzb21ldGhpbmc/DQo+Pj4gDQo+Pj4gT3IgZG8gd2UgbmVl
ZCB0aHJlZS13YXkgc3dpdGNoIHRoYXQgZG9lcw0KPj4+IA0KPj4+ICAgICBpZiAobmVpdGhlciBp
cyBrbm93bikgew0KPj4+ICAgICAgICAgICAgIHByaW50ZigibmVpdGhlciBhdXRob3Igb3IgY29t
bWl0dGVyIGlzIGtub3duIik7DQo+Pj4gICAgIH0gZWxzZSBpZiAoYXV0aG9yIGlzIGtub3duIGJ1
dCBjb21taXR0ZXIgaXMgbm90IGtub3duKSB7DQo+Pj4gICAgICAgICAgICAgcHJpbnRmKCJhdXRo
b3IgaXMga25vd24gYnV0IGNvbW1pdHRlciBpcyBub3QiKToNCj4+PiAgICAgfSBlbHNlIGlmIChh
dXRob3IgaXMgbm90IGtub3duIGJ1dCBjb21taXR0ZXIgaXMga25vd24pIHsNCj4+PiAgICAgICAg
ICAgICBwcmludGYoImNvbW1pdHRlciBpcyBrbm93biBidXQgYXV0aG9yIGlzIG5vdCIpOg0KPj4+
ICAgICB9IGVsc2Ugew0KPj4+ICAgICAgICAgICAgIHJldHVybiBoYXBweTsNCj4+PiAgICAgfQ0K
Pj4+IA0KPj4+ICAgICBwcmludGYoInBsZWFzZSB0ZWxsIHVzIHdobyB5b3UgYXJlLi4uIik7DQo+
Pj4gDQo+Pj4gcGVyaGFwcz8NCj4+IA0KPj4gSSB0aGluayBhIHRocmVlLXdheSBzd2l0Y2ggbG9v
a3MgZ29vZC4gV2l0aCB0aGUgYW1lbmRtZW50IHRoYXQgaXQgc3RlZXJzDQo+PiB5b3UgdG93YXJk
cyBgdXNlci4qYCBpbnN0ZWFkIG9mIHNldHRpbmcgYm90aCBgYXV0aG9yLipgIGFuZA0KPj4gYGNv
bW1pdHRlci4qYC4NCj4+IA0KPj4gU29tZXRoaW5nIGxpa2UNCj4+IA0KPj4g4oCiIEF1dGhvciBp
cyBzZXQsIG5vdCBjb21taXR0ZXINCj4+ICDigKIgTWVzc2FnZTogYXV0aG9yIGlzIHNldCBidXQg
bm90IGNvbW1pdHRlcjogeW91IG1pZ2h0IHdhbnQgdG8gc2V0DQo+PiAgICAqdXNlciogaW5zdGVh
ZCAocHJpbnRzIHN1Z2dlc3RlZCBjb25maWcpDQo+PiANCj4+IEkgY2FuIHRyeSB0byBtYWtlIGEg
cGF0Y2ggbGF0ZXIuDQo+IA0KPiBXYWl0LiBJIGRpZG4ndCByZWFsaXplIHRoaXMgd2hlbiBJIHdy
b3RlIHRoZSBtZXNzYWdlIHlvdSBhcmUNCj4gcmVzcG9uZGluZyB0bywgYnV0IHdlICpkbyogYWxy
ZWFkeSBzdWdnZXN0IHNldHRpZyB1c2VyLiogdmFyaWFibGVzLg0KPiANCj4gSWYgdGhlIHVzZXIg
Y2hvc2UgdG8gaWdub3JlIHRoYXQsIHRoZW4gdGhlcmUgaXNuJ3QgbXVjaCB3ZSBjYW4gZG8gdG8N
Cj4gaGVscCwgaXMgdGhlcmU/DQo+IA0KPiBQdXp6bGVkLCBidXQgSSdsbCBzdG9wIGhlcmUuDQo+
IA0KDQo=
