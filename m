Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2133.outbound.protection.outlook.com [40.107.105.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5892EB14
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468387; cv=fail; b=XliCT0uZfHojvdz4fOU+WPam6Yb+VWf8O72fsApUGbh35549Kfw/zN3FAvPG7p19XLP1t0vb2gmmU8wLeIUzrpqP8U+wwjIL65wsfAzs5C7oedangjCev6vBXL78ZBiZUH6HoVK6MTAXyIXy8tZ2NzRO+K6r0ex4ih1QKULnGaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468387; c=relaxed/simple;
	bh=jGhcsDDDo3gK8VyYZ3C2550ak/4sJVJNvxeLU1ff6Q8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UnC3OT/tqCcKBjZ6p+KG0KNhSfxXlvR+tLYYPWS5+U4Tsyffss39sg9KrCpyIDur7tulENOlU4I1MqNavw0lDyGAa8kBafQvNgNJaVnzPf7HxoBWAysj+huioOxfxKX87eqdyZPn5vb1Xbn/IVu6SyxjSY8fFFIt4grJnEWOdf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io; spf=pass smtp.mailfrom=qt.io; dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b=UxhUp7vT; arc=fail smtp.client-ip=40.107.105.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qt.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b="UxhUp7vT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMdqPk3l8oNJYcbVUTkVjXSIenowB0WcqmmAGQoAJo4HWKbP+72ARyXFKuOiCYnXJgiCqUo3hgdgOsig2H6uQYZFoxn0VaQlgVppMggqb6dFf40Dtpwpsdc1E8+HDBQOe87r0VIWz0/NrxzSKS+AfQ8EIwGt/Iuh5oZgfLL/SgxbgRImnMjo22RW/l/TWcPPQDW3AYq8MkEtEL91M9UiVKhDjPBiDsnF9qP7jzA/SqBrJcI8AD9Eu/DmR1bRUh7DirAJn9GWbCuTTx9W6ATrih4Ili91TNZQgpO96ToCbMDSXPUKekTfk3c36qqS62HG5klJAQVmZJ9AzSA9rB4a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGhcsDDDo3gK8VyYZ3C2550ak/4sJVJNvxeLU1ff6Q8=;
 b=SovXyQb4uAje6PfjTLnyKFgBzW2bJv3P5iMqp7Qw+5adO0y3+w6jlEZwL9aebjYTqZdMa4A6itsQx/ZrwyMSM0/6xq9cmU+RXgpzgnX1SCfSsVqV6IPnoc1CdE26nyq67R80iSmZOvcIjP+XGIqbDFPSKZmUIB8NumPanW9A0SlMCRKuEVLan8VKmp/u8/kjskEdoHBB8B9EzR+bkKTzO9TU4MDmxKf+sj4vE7p9LNmBWtXFfgWLSfHElLvGzjiZpYs7sgkcdkxe0fvaiCFq/lhKD0DJwMfhiqo9DRQELjJY3mEPz0foHwhgyBngbALedFKxmfKYXBtGlzptwRQ+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qt.io; dmarc=pass action=none header.from=qt.io; dkim=pass
 header.d=qt.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGhcsDDDo3gK8VyYZ3C2550ak/4sJVJNvxeLU1ff6Q8=;
 b=UxhUp7vT3eOEU2je2zra0A6p0qNqgEVFaTSubUrlbI55lbfX5eUGUNfHBdg8T0Xkab1EpSx6Vw/cjf4RS08RWniAe9aj3FXXMGU6r1vsLWuODWX8eX60JQVsxgYggMkNR4N1A25xZbgr6lEFXGZ7AW7fJYenLl769Stmm8peGoM=
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com (2603:10a6:102:302::20)
 by DB9PR02MB7323.eurprd02.prod.outlook.com (2603:10a6:10:248::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 08:46:21 +0000
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1]) by PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 08:46:21 +0000
From: Marcus Tillmanns <Marcus.Tillmanns@qt.io>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Phillip Wood
	<phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though
 --author is used
Thread-Topic: Bug: Commit fails when no global email address is set even
 though --author is used
Thread-Index: AQHaWqMf1aEsN7y+JEu1IkWahU84VrEAl8SAgAEKIICAAA8wAIAAAoKA
Date: Fri, 9 Feb 2024 08:46:21 +0000
Message-ID: <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
 <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
In-Reply-To: <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qt.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9617:EE_|DB9PR02MB7323:EE_
x-ms-office365-filtering-correlation-id: cb9cbc67-14b3-4abf-f459-08dc294b9714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0LQXKGXnPKAuugdEGBv9HrzVjvJNzgEzTR7BG/dAEGJObcI/nD5osWEmdHx4E+IgXw184QKuauFtj00e9/RYMQGCYT7SZRBdcc8fSGJRvIPXCNSBwybY7FSqUcl+2oC3ArefW4UD6fcMHw5avDyqN5wHJveUy8qooCZv9FnKEaFrTbLDtmJadiCPUgw7N0j+UtjyXmoROOnPnsRnQsAJM6vpBr6vNvNuP+jQ16cgwqx6pmlWSsjqtzEi+HntVT7Uoors9Kms7359UVXCh5LBZ4o82uBRKCIMVVgO2tpp2391IIR+JmKIqRKGthaAoeaLVd5oDYxHHmKDrXa9aJE3yaz9CGboTISNLR/NGU7hDXREiX469N5OMuS/PDk2X87MbF8l0QpQHe6BD5R6IBWIBhGEtIrGeIlu6mLL/wzD2mbasLSr386l8nRCYug1K/SOUT8cEliYPXVrFSJjH0h2Kq2c/vOd9AKFRbtV5tkW17VK6YuoR8eMIRY8NG260EGC8gnUhEegxiUOj1yT5V0FRFXiuxffM2ohCMsPKckaHsfhVh/PqEE6gZ0pB84SJWEjkH+jzl3D9yQt9JuQv5Q6rYccXFLf/QWDn4+rYlcVnxYXj9032VXmhCzB2a7itwB7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9617.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(396003)(346002)(376002)(366004)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(86362001)(41300700001)(38100700002)(122000001)(5660300002)(4744005)(64756008)(66446008)(66476007)(2906002)(6486002)(71200400001)(478600001)(66899024)(6512007)(6506007)(54906003)(26005)(2616005)(83380400001)(38070700009)(36756003)(76116006)(4326008)(66556008)(66946007)(316002)(6916009)(8936002)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFJvU2FkbmZHcm9mdUd0c1h3blhaMDZJODFPdGRBL29ITWhkOFE2UmxDZlk5?=
 =?utf-8?B?SEtOLzA3ZFJMUHU5ZGw4ZEs4dDZZbDFJdVhxYWNNeU54M3BnOTRBM3hPQzNt?=
 =?utf-8?B?RDNjZnlXODdyZDkydE9hMU1aVFh1bXJLNXJJVjI0cFZQOTRmM3lQUDMycjdt?=
 =?utf-8?B?V3JNNEo0Q3ovUHgxdVlaME1EcW5JQjRKZ0pqTmVqSUVTUFZzVDlGcTUzaVR1?=
 =?utf-8?B?cDh0azdEOVRXbDFKaWVHSHhscDB6T0xsbGx3NkVNOU1halV1WXpzNWliVWdz?=
 =?utf-8?B?OFRGWnB0WDF4Q1U0RkdXTy9rWURkOTBZR3VvRzVkN1ZWODNuZW5UM3RYdzZW?=
 =?utf-8?B?eXZDMlRvQnFnd0dvd09oNXBzL2pCWDEwK25BTnRwRWd3aVowZGFGcVpvcWRj?=
 =?utf-8?B?ZlI0ZC94VllPbmdlNU9uS0M4Ukw4U3BxNVpIR1hkY0dqdjFHT3UrM2ZtS2Jx?=
 =?utf-8?B?R0RyMUNNbjFOamV0bWlCRWV5dFNyZ0tFK1RUVlAxUjZENXNFNitNZ0lkTE9F?=
 =?utf-8?B?UTlscEVBcURNNzExemt6VSs3dzc2L0hhZE5LQ1NKTEtHZFRxR1lxSVE3L21j?=
 =?utf-8?B?cEMyS3dDdjRYRUt4M1FvN1ZEbzRWVXcwZ0l2c2s3cUJsaGhpKzd0dytHWnV5?=
 =?utf-8?B?ZXBwOCtIQlpXa2F4cE9KMXZwcHkyQzlUV25KMmxzT1Z4VVMrVmtqWHVXUW1Q?=
 =?utf-8?B?R1RyWEZVeGNBNGl2STFOQm54VzJ2eXJQdXVhclRlVWFST2VrSzErK0VNaUJo?=
 =?utf-8?B?Vnl3SVpaeVB1YnVrR1o4ZEJQMTdhM0xDTGUydWsvVUZObnhvdmoyNFI5VFdv?=
 =?utf-8?B?eDhZTlpkNkdnWWtuU1lnaXc3MGdscThHSDhzVjIzNWE5eTNCZkpqRVRPUmZO?=
 =?utf-8?B?UndpOW0wSS8rVjlXaVN6WjhnK0JwODlHTmJxRnhpb3NwcGFxcG1rb0JNNWtJ?=
 =?utf-8?B?UG1FWDhqYnVWdnRvQ0FHekdkdUpzOTkzZ2xGZzhFc0JiOUhhMm5jNUZVWGNy?=
 =?utf-8?B?OUpzT2tGOWduYjhtZ3EySGp6cTlGb1hJdXBJNm9hWUVIWVByaU15UnJZVW1M?=
 =?utf-8?B?K3VMQXh5SGRvNGZjK0xraHJwQi9UVllnQW1xR3BmSlRnNnNZQ3YweXdIWXEy?=
 =?utf-8?B?aHU2MDg4bXl2SVZKalo2Zi9kdlVWSnFUZUtjMHphNUdUOFhKdHhweXgvcC9Z?=
 =?utf-8?B?aHc0QWplc3NVdTY0aWJmY2xmY1ZGRGw2UFA5dmpaQjU1ZW5tREVyMmdGcUF5?=
 =?utf-8?B?M2k1bk1qYWV1cDJKOTZ6cDFpSXVzSDRYaUl2MXZON3FaUGJWMDMzRFBpL3Rz?=
 =?utf-8?B?cnhVazArTnFjeGlFekJVd3JQdVQ5Q2pxWk9jTFpUWTRhQ1o1Lyt6bGl6NW9m?=
 =?utf-8?B?VXNFVWRtcmpYRjJOVmRnVjhtLzV4c1JxTm53elVlNmQ3TmcrWkluYVBhaHNk?=
 =?utf-8?B?cWVhaDhCeU9RME14a3Vtd2E1c1BKTzV2ZVJMeDd2d0plNjJlK0VMN2FFWnl5?=
 =?utf-8?B?bGl5SEZkbFJ5ekVpRlR5M01BdTdPQlFwekp3OFZmcGo0TzVGZ1M0U283OVpq?=
 =?utf-8?B?Y0lCR1IrcjBnYk54M2FvM1dLZXppWlcxSjZlaU96VDU1YVpGeFFvZkdTKzFa?=
 =?utf-8?B?Wm9jT01tMHhlQ0JKZVNldG16NVlOQlhOU0JUYm1yeUtsUGxlQWtyWEZYMDBB?=
 =?utf-8?B?bXhjYlMwMzlDZ09FM3kyQzd0TG0rQkNVaGNZNnhSeWVwSEEyU1VzT285U2Rt?=
 =?utf-8?B?SWFRMmE5YW0vbVBEK1cwaGJIdDJwWkpNOGxpMElIUFUwRitvdEFZTmdSZHZr?=
 =?utf-8?B?MUdrNDlyMEFLRmxRR2o1N2pKR2V3UGxUWTREMnIwNjhDenNnMkthVkV0bzBP?=
 =?utf-8?B?ckpBOEJDb2tSbmo2YzdnNnRpK0EwelJqRmtkTUtmRVEvM3lhMU0xUWRuU1V5?=
 =?utf-8?B?cTJPN3JxanFCOS9keC8wS3pyV3JOR2VVOFN5Y05hT2VWRlA3Q3o5SkhQZFQ2?=
 =?utf-8?B?TjJFdGtRYUZad21EeWZtY2Flbi9zZXR4WDAvTnNkbldSdjVXQzRsdVhZV0lC?=
 =?utf-8?B?ZWJOVlFjZnp5N1Z5NjlKODVQdW40YUlSMHR3bzZzeXBZM0JtT1hzOUljR3Bu?=
 =?utf-8?B?MjhTczdaNFdlUkJFM1FpMDFzY2x2eDlSOGdUcVJsenRHcHViRFdoZWJHYml5?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E508028CCE2AA46A52B832359A7EDEF@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9cbc67-14b3-4abf-f459-08dc294b9714
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 08:46:21.3480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sr/Krv9qvaf9tUHUTa+P0NyGcq/r4Quf3ZU0enLB6Gk//ZH9WfT/eVl9JXeG3m2DcnFqznzqUDCI9snevCzQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7323

RXZlcnl0aGluZyB5b3Ugc2FpZCBpcyB0cnVlLiBCdXQgaXQgbWlzc2VzIHRoZSBwb2ludC4NCg0K
SWYgSSB0cnkgdG8gY29tbWl0IGZvciB0aGUgZmlyc3QgdGltZSwgZG9u4oCZdCB3YW50IHRvIHNl
dCB0aGUgZ2xvYmFsIGNvbmZpZywgbG9vayBhdCBtYW4gZ2l0LWNvbW1pdCBhbmQgc2VhcmNoIGZv
ciDigJxhdXRob3IiLCBpdCBzYXlzIOKAnOKAlGF1dGhvcuKAnSB0byBzcGVjaWZ5IHRoZSBhdXRo
b3IuDQpTaW5jZSDigJxjb21pdHRlcuKAnSBpcyBzdWNoIGEgaGlkZGVuIGZlYXR1cmUgdGhhdCBl
dmVuIGxvbmcgdGltZSB1c2VycyBvZiBnaXQgZG9u4oCZdCBuZWNlc3NhcmlseSBrbm93IGFib3V0
IGl0LCB3aGVuIEkgdGhlbiBzcGVjaWZ5IOKAnOKAlGF1dGhvcuKAnSBhbmQgZ2V0IHRoZSDigJxz
YW1l4oCdIGVycm9yIG1lc3NhZ2UgYWdhaW4sIEkgaGF2ZSBubyBjbHVlIHdoYXTigJlzIGdvaW5n
IG9uLCBzaW5jZSBJIGp1c3Qgc3BlY2lmaWVkIG15IHVzZXIgbmFtZSBhbmQgZW1haWwsIGFuZCBz
dGlsbCBJ4oCZbSB0b2xkIGl0IGNhbm5vdCBiZSBkZXRlcm1pbmVkLg0KDQoNCg0KPiBPbiA5LiBG
ZWIgMjAyNCwgYXQgMDk6MzcsIEtyaXN0b2ZmZXIgSGF1Z3NiYWtrIDxjb2RlQGtoYXVnc2Jha2su
bmFtZT4gd3JvdGU6DQo+IA0KPiBPbiBGcmksIEZlYiA5LCAyMDI0LCBhdCAwODo0MywgTWFyY3Vz
IFRpbGxtYW5ucyB3cm90ZToNCj4+IFVmZiwgdGhhdOKAmXMgYSBtZWFuIHRyYXAuIEVzcGVjaWFs
bHkgc2luY2UgdGhlcmUgaXMgbm8g4oCc4oCUY29tbWl0dGVy4oCdDQo+PiBvcHRpb24gYXMgZmFy
IGFzIEkgY2FuIHNlZS4NCj4gDQo+IFlvdXIgcmVwb3J0IHdvdWxkIGhhdmUgYmVlbiBtb3JlIGNs
ZWFyIGlmIHlvdSBpbmNsdWRlZCB0aGUgZXJyb3I6DQoNCkhhZCBJIGhhZCBhbnkgaWRlYSB0aGF0
IHRoZSByZXBvcnQgd2FzIGRpZmZlcmVudCBiZXR3ZWVuIHdpdGggLyB3aXRob3V0IOKAlGF1dGhv
ciBJIHByb2JhYmx5IHdvdWxkIGhhdmUgYWRkZWQgaXQsIG9yIGZvdW5kIG91dCB3aGF0IHRoZSBp
c3N1ZSB3YXMuDQoNCkNoZWVycywNCk1hcmN1cw0KDQo=
