Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2096.outbound.protection.outlook.com [40.107.247.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C8A65BA7
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707464587; cv=fail; b=jnmxj0wWH5pla3tNEi0Nov7NJ9zUQiGDma1e667p1kEdh0aG1zR2A6fFef2fE5sP0n7sP018U3IdXAYxxH81burx2w7YzHnkAAHN+Qg7G8PPCamlsHkDDNwGLQfI8Umz1Vn6ICo8OvMiq+JSfvh85ZJ21+tpMYq4D+zkylzs4m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707464587; c=relaxed/simple;
	bh=IlQIq/eVWC4fwvE/IiRhqqMEqVzCy9/Y+uG8MEI5J4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1CcKjiKG+of6BBazPN0eXi+aa0OBQFH86GPzEF+74RadBgsSxA+h65ibDOIDK7F7pVQwtFxjuLD4cXBFMSDVfHuvYOF2B1piDCs/3PC4Vl84G72V4WDPdEKXLSeHRnu8CmuR1Ud9SED3Y94fahB+aYObp3Ni9W+cF8LBJ+QD1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io; spf=pass smtp.mailfrom=qt.io; dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b=Dxv5JrAB; arc=fail smtp.client-ip=40.107.247.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qt.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qt.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qt.io header.i=@qt.io header.b="Dxv5JrAB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy07B5Q2+CZOBM1bZhek0ZGpfoZYqmuFZ1FYpgrjMmMVeLD1OuHED6jAP0gIxsSbWfRrwJPW+bkG4verYf6kPtT5IMbU7M7E6TMUf70CndUMsNjMPkYnKoNWB4sRzSMlZCZ9LgpSrEGrRb8RieUQTXyoJDDWCvC+2MB3f84/PXGOjrfrXGgduuVMKjAXXpe/sT6GpZEEOgaX/UjNW0FIKg5x8VQmNFl7Gc2OC+5sIF8/HT0KP9Tdt4o6yCO1enSld9acK41erho0Uro8QdpH7FkKtKiCTmDhn82ZiRLmGbgYKqJZmNEbCahXMlyHHOXyW2UxSXmrJ4IHQ9hZvKLGpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlQIq/eVWC4fwvE/IiRhqqMEqVzCy9/Y+uG8MEI5J4I=;
 b=Mpc/V1hJSf7Us0qTSAJUUCAbzOyJZWcCHyL8mrlNFW5nIWdi5XHe35R5eIZlB2RhojAB7rquHGRAxlyKcxBS8dpnXccqyBfmHlQuyxMnF3OEDG4KWR3le4foYuGfohCYZbQPfZONxvL75zPUZBnL66qu2AsA44SrgSzOoI/jz3eBhoCTf7+nkmnA2X9bGOyVE5YW4xQo31SqCxubPPkSs6ktvkbKSBSIY/54dUgfJuvzGPmLs2ixUz85O8t9b3bM/JZsK23QKU5M3UNjqm/ig5vhzTL+FCvteptPg21VI0YxiLItYt5+A7XPRa1S4VZXAAdEAm2aMzKUysUsG8Xb9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qt.io; dmarc=pass action=none header.from=qt.io; dkim=pass
 header.d=qt.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlQIq/eVWC4fwvE/IiRhqqMEqVzCy9/Y+uG8MEI5J4I=;
 b=Dxv5JrAB2zp1UM/LjK0L54tCbUr6TqpD4kV/OAdytxquf7qlZTeHEciQrZJRg43DALpmu65BdxepSZiAZHb27DZ7MYkYeIHNKPvYy97CreYGJZTwnJgANV5OB1Ui+SvcdLn0iTZ955Jj55b7tdwbFv+aEppxG8iohxwpkY0ASuw=
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com (2603:10a6:102:302::20)
 by AM7PR02MB5782.eurprd02.prod.outlook.com (2603:10a6:20b:104::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 07:43:01 +0000
Received: from PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1]) by PAVPR02MB9617.eurprd02.prod.outlook.com
 ([fe80::abe4:ff1b:74bd:48a1%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 07:43:01 +0000
From: Marcus Tillmanns <Marcus.Tillmanns@qt.io>
To: "phillip.wood@dunelm.org.uk" <phillip.wood@dunelm.org.uk>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug: Commit fails when no global email address is set even though
 --author is used
Thread-Topic: Bug: Commit fails when no global email address is set even
 though --author is used
Thread-Index: AQHaWqMf1aEsN7y+JEu1IkWahU84VrEAl8SAgAEKIIA=
Date: Fri, 9 Feb 2024 07:43:01 +0000
Message-ID: <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
In-Reply-To: <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qt.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR02MB9617:EE_|AM7PR02MB5782:EE_
x-ms-office365-filtering-correlation-id: 47b8aee8-96cb-48b7-4260-08dc2942be51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KcGps4UdonbXNWzvKO/70X7rE7ZCthl+Cf4/DHTAWk+MqdDaarV0Z6wVgyZO4RmLJCbBiE0/9y1qhSOTfrQNnJbZya2RCNV3gkGUsLQ3jsQFsC259pHAf0TCyBYF7wOtVjdnfkmmHjSsAp1gYOsynB3JWw06ug5Arqb5j945MGn1J/aISrqDzVxV3x+CedYf9ob4wBZb/OPUfXnwhF3nkiZNNHbXLuM//nRe/x/Go5TzwR1vORTX2qnXdwqd2lIHLycXtq6O5LaOw6PE4pMmwgxBJ1OS+e4linnc65rT/jQ8U5dkaEg8yq3vyI/Q/PVUAvI3L3q4n7Hsld8ZOi9pKpgjJ1m8WXu/vZeYlPILGDqGfZyBbjUwXRASWosw9LwTpz2c7RIjPtmeRa1xnoYGh0GclEyqZBEQUC4fORrfRcbYn8+hmGjCHG7hxqBd2zrpTsEfIOPfqDgdmE4YjyL1J34+UJa0pj/NZKzuIB/clAVGlShCVoEZ2ktvq6LpUCb/s9PShDGl/rL97B/vWZcqLU+raC6jUUovdWHLHAEAeBDvhbKtxjG/GEPrxwt7kEccpDCMukGU2v6j3Pp3fdGRwMWR/J1Itjy2IpgjvaU3P5Fc81YT4hlvtj259BbS5XOc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAVPR02MB9617.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(366004)(136003)(376002)(230922051799003)(230473577357003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(53546011)(2616005)(41300700001)(6506007)(6512007)(6486002)(966005)(478600001)(2906002)(5660300002)(64756008)(66446008)(66556008)(4326008)(6916009)(66946007)(8676002)(8936002)(66476007)(76116006)(316002)(71200400001)(38070700009)(26005)(83380400001)(36756003)(38100700002)(86362001)(122000001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tkt0bUNtblNqWTdSZHRWZkVyWVh3ZGMrMzM3b3lsWU9ES0lGNm83bFIyQkU0?=
 =?utf-8?B?OWRYajZlVEVCMllJY3dDbFNHUmxXMjhhak1wQi9TdG9Ub2xlc2JrdUNzbGx5?=
 =?utf-8?B?TXBYK2NwZmpXQXZZRmJ6Tm5UYjhWdDd5Y3VzSVpydG9PS1o2NjJCQlVGQy9i?=
 =?utf-8?B?QW5WbEhEcmFQZkRxKytQL0VCb3AxdjZOcHdBVFpJRkF0M1BhRTdybVJleG1R?=
 =?utf-8?B?Y3FZNjlWL2lPTHl6SEIrQTlrUU93UHloR3NBWktCQk8ySzVmSmk3eGltWFRQ?=
 =?utf-8?B?U0hFb3BpbTgzM0RDbk9UdnJoTzg2WmExcGVCSU1TcUE1aEY0ZDJNb3Y0VVM2?=
 =?utf-8?B?azZnWW5Ic2VzdXBzTDRZaEY1TC96bXQ3UEdSb0RBZ1dkNnJHbEhHTVM1bFFM?=
 =?utf-8?B?VUcwVGR5b1A5WFhrZU9TOThjWFdVVFh3RWdBRXVvcTRiUndMVE13YUpleXM4?=
 =?utf-8?B?VndtTWFLR2Q1N3JiSWJJSTM1ZTVuNWpoS2pxb1NQU1dxckdLdjN0MlBoMW5x?=
 =?utf-8?B?amlvYVk3M3p5Z1BrUWhCWURoWktialJiWUZ0cTNtaTJoNDJ0WUJuUzdrWmcr?=
 =?utf-8?B?Z1JwVW8xOWJQT3lTMG1ndDA4aVB2ZC96dHJBdmh6eGZHNWd0WXVuZnluWm1M?=
 =?utf-8?B?bVJjOG5kSGxTNjVOS2x6MjRqdFpobTByTXhLWTJERWVuSVZsSUhmTzRXL3dt?=
 =?utf-8?B?Mlh6Q3RZTHNxVExWdG04Z1U5RnF5cXRiOXRSd3pUVE05UFNIS1JoZ0ZmQ3ZC?=
 =?utf-8?B?RU5kbzJhUXAwbUc3WUdZM2lhanJmZU9YbTB0VFgvSGFDYzIyT2F1aHY2akhj?=
 =?utf-8?B?Y0NOQ281eEZ1b3lwMUpFekllZEg0MlE3SUpkMDhPNEtBYmxsdldCNm9PTUFR?=
 =?utf-8?B?UVN2SVRiWVByOUJZbmpRT2Z6S0VBeURzbzY5SXBucjV6NEpsR2FPL3hlNFFS?=
 =?utf-8?B?MS9FaVY0Wlp0N1dFbnJFdjFsQjV1UjJmRFdEYjAzcHJkK1ZQSEV3dEpxQkJT?=
 =?utf-8?B?NytHSkM3dFNvYUQ4RTE2MEV1RTc1ODFDMXdUYXBVazdyVHpwdkJPa0gzdzlR?=
 =?utf-8?B?RCtxemdsa2VGQW93c0RSOWQvcDdNQUNHRVdJamcvSnUrbjFJcklDSG9FdVBp?=
 =?utf-8?B?Wk1Qd3JCSk9DZlM4YjFnZFQyUXdiQlJsZmUwMDhSM2FTbTFXdThLVDIvQ1RR?=
 =?utf-8?B?NTNUVHd0bmlNTUZEMnpGaUdjdlNDc3ozbHFCSmVRUnpZQmcvTGxDZmNreUVp?=
 =?utf-8?B?aDNWTGw2TWdYY2ppMENIczZxRExxUmpGeDRud2crWmJPMU9OSDZXeURLVHJM?=
 =?utf-8?B?VW9MRmwzNEl4WE1ROEg3MncwOVYwY1h6T25BOUgzaGg3MG9xZTk3T1p6bStJ?=
 =?utf-8?B?TDZVTWluWVlIWkRTeEtxeHBGWXlkREtYUzQ0a2tnSHZHeXlzemU4NkZnODh2?=
 =?utf-8?B?ZVYzckdFbStYWS95Z2RyS2t6cDVCNU4xZS9zY3NMOE44VElHbjVaZmtRQzUy?=
 =?utf-8?B?TnJKTHd3VTNDeVlzanhPMldpRjJFd216aWxNY3JqNWxYRzdtdGJtZzdiQ01W?=
 =?utf-8?B?K0xlWnJVM1V3MGMvNW1SSVlZRERXYk9YbHRkdkdVQ1VKNExIUGYrVkorbDVo?=
 =?utf-8?B?a0dPNTRVTUtPT083ZFQ2UHlKSW5kN2ZsWlFmeGYwWUhWTVB0QW5JNGtNOFBP?=
 =?utf-8?B?SytUWUN5OFpycFBia0pCWDB1dFhYcEl5OVZhZFdESEhXeldnaTdIMVFuTEpL?=
 =?utf-8?B?RFRGZVlhQlorcG1SaGhoT0k0Q2oxUDJiL0VYNFo3NE9lVTM4akwvZXlXTHc0?=
 =?utf-8?B?Tm1zcXRubFVHOHZLdW54S3lNbTU0ZEJBeWN5L2ZJUExWMW44eG5JYVp0bkdW?=
 =?utf-8?B?L08xV2JjMWg0bXpBYkcvT2poWVNoejNMQTRUMVBsMVpFUEJQTG1WaTREZGhZ?=
 =?utf-8?B?ZFhRTU9JVEl3NlhhUUp5RVA0VVNjYmlnbzlsY1c4TFNBbHZuV2VtRDNYSUtO?=
 =?utf-8?B?UzY3TFk5RnZwWjk1NGc4MGVKdjNYRkQyUGFpdFNkcmoycGtvZnNyWlFvcnE1?=
 =?utf-8?B?cm1yd0EybDZVdnJOR21FWlBlUU9CaGF6SWdSTHM5bHNncnV1Nmo3V2dZa3dy?=
 =?utf-8?B?Vm4wdnJKUEpyU0pLWC92MXBVNk9WZ3dSQnBRdDUxeFkxeHowbWZNcnBTbjlB?=
 =?utf-8?B?Qmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39E2E2C240662745B3B4E88181712803@eurprd02.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b8aee8-96cb-48b7-4260-08dc2942be51
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 07:43:01.7264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMx5eNZIWQWBx5QjSRIDJL2iYVp2SWLqU4M3xJh/b2+JL4yLudAH6Q28z/bQkva1vBr4X216/BbiyD7vcqqF5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB5782

VWZmLCB0aGF04oCZcyBhIG1lYW4gdHJhcC4gRXNwZWNpYWxseSBzaW5jZSB0aGVyZSBpcyBubyDi
gJzigJRjb21taXR0ZXLigJ0gb3B0aW9uIGFzIGZhciBhcyBJIGNhbiBzZWUuDQpBbHNvIHRoZSBk
aWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBlcnJvciBtZXNzYWdlcyBpcyBqdXN0IG9uZSAodGhl
IGZpcnN0KSB3b3JkLg0KDQpNYXliZSB0aGF0IGNvdWxkIGJlIG1hZGUgbW9yZSBvYnZpb3VzLCBl
c3BlY2lhbGx5IGlmIHRoZSB1c2VyIHNwZWNpZmllcyDigJzigJRhdXRob3LigJ0gYWxyZWFkeS4N
Cg0KVGhhbmtzIGZvciB0aGUgaW5mbyENCg0KLSBNYXJjdXMgDQoNCj4gT24gOC4gRmViIDIwMjQs
IGF0IDE2OjUwLCBQaGlsbGlwIFdvb2QgPHBoaWxsaXAud29vZDEyM0BnbWFpbC5jb20+IHdyb3Rl
Og0KPiANCj4gW1lvdSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBwaGlsbGlwLndvb2QxMjNA
Z21haWwuY29tLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IEhpIE1hcmN1cw0KPiANCj4g
T24gMDgvMDIvMjAyNCAxNToyNiwgTWFyY3VzIFRpbGxtYW5ucyB3cm90ZToNCj4+IFdoYXQgZGlk
IHlvdSBkbyBiZWZvcmUgdGhlIGJ1ZyBoYXBwZW5lZD8gKFN0ZXBzIHRvIHJlcHJvZHVjZSB5b3Vy
IGlzc3VlKQ0KPj4gDQo+PiAqIFNldCB5b3VyIG1hY2hpbmVzIGhvc3RuYW1lIHRvIGEgbmFtZSB0
aGF0IGRvZXMgbm90IGNvbnRhaW4gIi4iIChlLmcuICJpaGF2ZW5vZG90aW5teWhvc3RuYW1lIikN
Cj4+ICogTWFrZSBzdXJlIHlvdSBoYXZlIG5vIG5hbWUgb3IgZW1haWwgY29uZmlndXJlZCBpbiB5
b3VyIGdsb2JhbCBnaXQgY29uZmlnDQo+PiAqIENyZWF0ZSBhIG5ldyByZXBvc2l0b3J5IGFuZCAi
Z2l0IGFkZCIgYSBmaWxlDQo+PiAqIFJ1bjogZ2l0IGNvbW1pdCAtbSAiVGVzdCIgLS1hdXRob3Ig
Ik15IE5hbWUgPG15QGVtYWlsLmNvbT4iDQo+PiANCj4+IFdoYXQgZGlkIHlvdSBleHBlY3QgdG8g
aGFwcGVuPyAoRXhwZWN0ZWQgYmVoYXZpb3IpDQo+PiANCj4+IEEgY29tbWl0IHNob3VsZCBiZSBj
cmVhdGVkIHdpdGggYXV0aG9yIG5hbWUgIk15IE5hbWUiLCBhbmQgYXV0aG9yIGVtYWlsICJteUBl
bWFpbC5jb20iDQo+PiANCj4+IFdoYXQgaGFwcGVuZWQgaW5zdGVhZD8gKEFjdHVhbCBiZWhhdmlv
cikNCj4+IA0KPj4gQW4gZXJyb3IgaXMgdGhyb3duLCBjb21wbGFpbmluZyBhYm91dCBub3QgYmVp
bmcgYWJsZSB0byBkZXRlcm1pbmUgdGhlIGVtYWlsIGFkZHJlc3MNCj4gDQo+IFRoaXMgaXMgZXhw
ZWN0ZWQgYXMgImdpdCBjb21taXQiIG5lZWRzIGFuIGlkZW50aXR5IHRvIHVzZSBmb3IgdGhlDQo+
IGNvbW1pdHRlciBhcyB3ZWxsIGFzIGZvciB0aGUgYXV0aG9yLiBUbyBzZXQgdGhlIGNvbW1pdHRl
ciB5b3UgY2FuIHVzZQ0KPiB0aGUgR0lUX0NPTU1JVFRFUl9OQU1FIGFuZCBHSVRfQ09NTUlUVEVS
X0VNQUlMIGVudmlyb25tZW50IHZhcmlhYmxlcyBpZg0KPiB5b3UgZG9uJ3QgaGF2ZSB0aGUgcmVs
ZXZhbnQgY29uZmlnIHNldCBhbmQgZ2l0IGNhbm5vdCBleHRyYWN0IGEgZG9tYWluDQo+IGZyb20g
eW91ciBob3N0bmFtZS4NCj4gDQo+IEJlc3QgV2lzaGVzDQo+IA0KPiBQaGlsbGlwDQoNCg0K
