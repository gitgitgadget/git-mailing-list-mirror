Received: from DEU01-BE0-obe.outbound.protection.outlook.com (mail-be0deu01on2077.outbound.protection.outlook.com [40.107.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E76A374D9
	for <git@vger.kernel.org>; Tue,  9 Jan 2024 13:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edag.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edag.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XPGeXWnoatoZ1CXsUXy6qRY8sBhH8Tux6CjxQz9462/TPfIaFI6Dk3mn0IX5ISwYuVYF/zrcS9qPa3kmaHDDXADL36Mv7+/Hy1X1FUnGBOM41HIvQ2NB3QieJpaS0F8PnrBhD8Csfwe4cC1MIv/9gfjp/w6/v6LafOj+PphX1rsAJ81TzihFx4O/cRBTdLbNja31tEzxyz5H41wGM0n6YFt3X8bJnnV6Wp21K/7yKDdT4nRY15nRwpL6PdyasvyblFvoSG0DPOqKpt5f/jGf17rbmpe8ZHDc6LdNTQrKvU9TCJFEufA8o795aPQWtql4/lH+UlkEB0iYLCoB5eCWdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9XFrbV3BeCl60hiy5DF1qgmMxeBSlmcDMWx23XXVLE=;
 b=K0Jso/ZzHVLwK38PyHrD+f2oUnhxa6lf254OsZQI2dFdxD2TTSCe8+RWxczjnOfPoEBAaPGPKyH2NWo6ws/DgoX26dvOchZWW8lKn2luuBV2yCmf218ONJ9zfJresjz2Ib5MGsTnu4bMXjdua9Igmx1tYECAwSfJEzYCZoM3Km+9+lQ1ZSzAmq+mNJhoGd2hqp+haxz6Pei03LR0870mYbLz8YusNZj5l16peMBTHQZ2DdInPck8msPukQCuYTTzhpKXcPsROzpl5PPjrRPNg3JkjFEQneXlvyTUfcSWidZcq2cudH9nBJcv1Mep+f1VOPFXGwp/VTTINICfI4h+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edag.com; dmarc=pass action=none header.from=edag.com;
 dkim=pass header.d=edag.com; arc=none
Received: from FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:70::14)
 by FR2P281MB2925.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:64::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 13:21:39 +0000
Received: from FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b175:97b3:9c66:43c]) by FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM
 ([fe80::b175:97b3:9c66:43c%7]) with mapi id 15.20.7159.018; Tue, 9 Jan 2024
 13:21:39 +0000
From: "Lopez Sanchez, Jose Maria" <jose.maria.lopez.sanchez@edag.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Credential error - Cache credential helper does not work properly
Thread-Topic: Credential error - Cache credential helper does not work
 properly
Thread-Index: AdpC/sEsZ6iPV8wlRxOgFupURPhagQ==
Date: Tue, 9 Jan 2024 13:21:39 +0000
Message-ID:
 <FRYP281MB329114171822EE43AF9C8C0DFD6A2@FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edag.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FRYP281MB3291:EE_|FR2P281MB2925:EE_
x-ms-office365-filtering-correlation-id: 7dc35d74-3afa-40cb-2ba7-08dc1115e9bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rZWmMErlyVL/2yBYMnPTdWsWJjnoUndzG/RHWoNrMWEFWFH/+wEmsQgGl/qYClgKAE6heGUIjIhQ+ou+GmvZHc1NdQ8Q9ICMMTQyhzjU2XwL7mKazyEybJmI0TKAqwe9TTvS7rZjC7V3rydzzchsFU6QtVt+wcgoVFrN9bWG+B17izVXf5qzXnX+ofLrTzSOy1amz9m2k38BPVBOTxrKH2NWn4ovV1gkW57Wpe7q8Wq5PPACl6Isui5/S06dYBHElxbgQlfxLYL4X+CnUY1ngKTrH2maXwpYGYmwnmiOBiDuPGD0YLQ3l2t42L1ZWMpkKJbfjLkEN098tdyAfu0ut6ILlyG/g9hAiOURHVaZzRQJhLLFrA6BOF2GKIz1lxQ1019bU+4GnuHlogfLVixL7qBPVNk9DPGtAZall7V+BJz/49WUOTSsCmDbT1ZgeATKn9q3JBoYVTBjewH/XWwUMoZ9k45bavNxAssuh12Mmb2M2RoqXxz9S9S4chvX7JMaqIXFfMO21hyfuDp/GmbXOmm252mELt9KEjMVWCBx74eN2fe0lgp4rSA20DuQSviDJzQQwczQLVHratQsmf92kcx9jo3UMatGojtkHqckxWzhPIKiW6uPX+WF3uiVFDZ7bog4jPuiu1Bi3nl/MaZjwg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(39850400004)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(2906002)(26005)(33656002)(15974865002)(86362001)(38100700002)(45080400002)(38070700009)(66574015)(83380400001)(6506007)(9686003)(71200400001)(122000001)(7696005)(316002)(8936002)(478600001)(41300700001)(8676002)(52536014)(66556008)(76116006)(66476007)(66446008)(64756008)(66946007)(6916009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ei8vcktHQWdsRjF0dkZNOElSL3QrRXJST1c2Vkk4NGYzc3J0TUlabFVGa0hs?=
 =?utf-8?B?QXhYcmhQblhkNWZsNTU4dnU2ZllhVlFWdWpIQTFZSFRTUHpXSTdMQ0VFT1hz?=
 =?utf-8?B?OVcyZ1dwU29vYSt6a2FiOXpWTVhueG5aMGxmTW1rV0tpd1JkYitaQjNtWVhi?=
 =?utf-8?B?L2NJTWUrZmgzYWhLZGgzNzZENzlsQy82ZkQzQU9SVTFGNWhYY2pCZHByWFZi?=
 =?utf-8?B?bGpJdzlKdjRwdHhvMTRSdUdWNk1XZXhsc1NXRFlSd0d3K3NBWG53eTRpTkRo?=
 =?utf-8?B?bUN6RDNoME9lSXA5aGVBeC9FSWp1M1pKMytnZnpsdHJYNFdMak5lcGw2M0FL?=
 =?utf-8?B?aW5tMCtONTM2aHBxM1F4SldOUGQ0eUtETDVKZlpJRVR6cGhIdXcyWGF3RTQ2?=
 =?utf-8?B?bmlQbWxQcXJqbTRMQnNWRU5La0FIb3hlSy9IQittYlJCd2g3K09KdzJVQnRh?=
 =?utf-8?B?bEFyaE8vMzZoOG1ObGdTUWhKNXBVRjdmRjVOdm5ZRmFXSXNEM1BWUFNXYnNV?=
 =?utf-8?B?ZXROSEhHSHlSdVlmNmYyRm94bzdwUTZFN1JvdUxmTTFjK00yQjh4SVI0c1Js?=
 =?utf-8?B?dlIyeGpmNEdWMGpMelpZOXpzUk4zem1TQWxYcnQzTjVnak1Jb3A0djVRVDdM?=
 =?utf-8?B?clBqa3hRaVZiR3c4SkxaTEZTVFc1Q1lnUkpqNFN1Y1VxZXZGNnNqWktBOEd1?=
 =?utf-8?B?cDNCeEU4K0ZaclNKT1l2NWlMdTRobHZ6OTcvL0R3eC8weEpoS05mTVhQWmdK?=
 =?utf-8?B?dkpNYkFTbmNSb3poWVdiWmMzV3FYVnFjd210UmhYNWVWT2lxSTR0QW9qMmdl?=
 =?utf-8?B?cU9MMElCbjJFK3NrRkRZQm9pdExsVGZFczFKUXJ6bVRYNHdMVXBqZ3ZtU1Fq?=
 =?utf-8?B?K1JNWDhXY0lSMyt6Vnh5UVN1b3BOa25qSG9RR3ZYdmJkR0tzYmk0MlJNQ3NS?=
 =?utf-8?B?UmZCQ0xKZlhKWFQ5YnpFc0hMMVllUGhpa2pDYW1WQ2JYSW82VlIwQUFLTG5Y?=
 =?utf-8?B?Z0pISmUzYmd3RmVaSUplSjEveXZoS2J1U1h5Y1Fmd05IQ1NHUjdsZWswbXVi?=
 =?utf-8?B?aHRJVk5IWU5oVnQzYXFYVVhvUDJUT080OE9rb1JTRmNia20yVE96My9qeUNx?=
 =?utf-8?B?MDF6MzRSZnpPbzdDMVNiTDR5QTE4R0J3NVd2OGdZa1p1aHpNODhiWFhvUUpH?=
 =?utf-8?B?VkJ3SThtRXdBS2VQNmhSck54Y1cxc1YrdnRVZTNNZ01INzcyd1pQeEhUdjRU?=
 =?utf-8?B?M0YrTHpxVWluaXBwaXNkVHl3YndEZ3poZk93TGRtYktrUG5qanVrNzZQNUR2?=
 =?utf-8?B?SUMvOCtjNUVvRW5QTnRWeTB5WWtzc0NSRkM3MVZ5blNOTHhsdFJDWVRYeS9N?=
 =?utf-8?B?TUhIWkpKTC9Pd3JodHdhRTZNTzM3ZGZNclBlYXN3ZFhHdllxYjRJeFlkR3FH?=
 =?utf-8?B?RDlGNnZXUytUR0lsL3lMTmFoajE5Nm15S3paVWZzUUU0MzFiTGlkV2NrNEp5?=
 =?utf-8?B?cDRRVnR0bFFucENmaGx2c3hSTCtTSm1BWlVDcTNwL010ZCtUT0hVMHNLWTRZ?=
 =?utf-8?B?dVdIMTJjYzQwRGUveXhsV0RqQzRTcGFzNDltVkRKTmZZdkhiOWYxdzcvOWtu?=
 =?utf-8?B?NDdPaWtlRVdHVkRWdTFIRkpRMzFEMzcrYkZFajU0bG02RDZHSU5IU0R3dEpj?=
 =?utf-8?B?U0E4bkFTa05lSkhqRGN1NFBTcmNwbFFyQVUxNzNMU05qckJ5c3ZURWVna3Q0?=
 =?utf-8?B?ZHBNRFcxcEV5MlRYS3huUzZYeXJCKzlDYWVxOXRSQVFaMW1Cc3N5S3E0WjZJ?=
 =?utf-8?B?a05KUm1GaXhHTlVxRW5saDFlRHlhL0ljRi82c0pmdlNLNWoyOG5DaG9uNUxR?=
 =?utf-8?B?VFFCWlhVMVUxcEtwZWVXczlyQkUvejNkelFIcUFYbllUQjFlNm5aYVkvbXRu?=
 =?utf-8?B?NGQ4QXFnMTV0Z0NOQXJjcWVuNFBld1VqKzVQc3NuVmxtSTVyTkVPcFh2dkIr?=
 =?utf-8?B?L0YzZktjbDgraFN5VHdZRXI0SWxYOEx0ai8wamNQcjhRR3g4Y0txamplVk1X?=
 =?utf-8?B?cFdTWVNpNzkrWnR3a1NHazZ5UXdhZ1FvT0RJUFJDTjdBOGxMSUNZVnovb0d1?=
 =?utf-8?B?RS9yRHNhdStDM3prYk9FS285ejhuNGNJc05TMWUvWWR2TDA3TWRhY3JTejh1?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: edag.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FRYP281MB3291.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc35d74-3afa-40cb-2ba7-08dc1115e9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 13:21:39.2644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4812a7f3-cbc9-4f88-b59f-87b73b966886
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5SRq7+qlg8aa1Vg//wwWN0KVPc+DSp2+svOCWtLUHxppXFsIqLpBRTRFq5JQnMuxcAscqfuwS4fDsZKUb89OVG64uWRopTJ9939GR4YSfdFBBJzdea9fJ42oTvlTOx9w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2925

RGVhciBNci4gLyBNcy4NCg0KSSBhbSBKb3PDqSBNYXLDrWEgTMOzcGV6IFPDoW5jaGV6IGEgc2Vu
aW9yIHN5c3RlbSBlbmdpbmVlciB3b3JraW5nIGZvciB0aGUgRURBRyBHcm91cCBjb21wYW55LiBX
ZSBhcmUgd2lsbGluZyB0byB1c2UgR0lUIHRvIHN0YXJ0IGNvbnRyb2xsaW5nIG91ciBwcm9qZWN0
IHZlcnNpb25zLg0KSSBoYXZlIGFuIGlzc3VlIHdoZW4gSSB3YW50IHRvIHN0b3AgaW5zZXJ0aW5n
IHJlcGVhdGVkbHkgbXkgY3JlZGVudGlhbHMuIFRoZSBjYWNoZSBmdW5jdGlvbiBpcyBub3Qgd29y
a2luZyBzb21laG93Lg0KSSBoYXZlIHR5cGVkIHRoZSBmb2xsb3dpbmc6DQoNCj4gQzpcVXNlcnNc
amw4Mzg3MFxEZXNrdG9wXDAwX3RlbXBcR0lUIEVBR0VMXGVhZ2VsLXByb2plY3Q+Z2l0IGNvbmZp
ZyBjcmVkZW50aWFsLmhlbHBlciAnY2FjaGUNCg0KVGhlbiBJIGludHJvZHVjZWQgb25jZSBteSBj
cmVkZW50aWFscyB0byBzdG9yZSB0aGVtIGluIGNhY2hlLiBJZiB0aGUgY29tbWFuZCB3b3JrZWQs
IHRoZSBzZWNvbmQgdGltZSB0aGF0IEkgYXR0ZW1wdGVkIHRvIHB1bGwgdGhlIHJlbW90ZSBzZXJ2
ZXIsIEkgc2hvdWxkIG5vdCBoYXZlIHR5cGVkIHRoZSBjcmVkZW50aWFscyBhZ2FpbiB0byBiZSBh
YmxlIHRvIHRyaWdnZXIgdGhlIGNvbW1hbmQuDQoNCj4gQzpcVXNlcnNcamw4Mzg3MFxEZXNrdG9w
XDAwX3RlbXBcR0lUIEVBR0VMXGVhZ2VsLXByb2plY3Q+Z2l0IHB1bGwgb3JpZ2luDQo+IGdpdCBj
cmVkZW50aWFsLSdjYWNoZSBnZXQ6IC1jOiBsaW5lIDA6IHVuZXhwZWN0ZWQgRU9GIHdoaWxlIGxv
b2tpbmcgZm9yIG1hdGNoaW5nIGAnJw0KPiBnaXQgY3JlZGVudGlhbC0nY2FjaGUgZ2V0OiAtYzog
bGluZSAxOiBzeW50YXggZXJyb3I6IHVuZXhwZWN0ZWQgZW5kIG9mIGZpbGUNCj4gVXNlcm5hbWUg
Zm9yICdodHRwczovL2NzcC5lZGFnLmRlJzogamw4Mzg3MA0KPiBQYXNzd29yZCBmb3IgJ2h0dHBz
Oi8vamw4Mzg3MEBjc3AuZWRhZy5kZSc6DQo+IGdpdCBjcmVkZW50aWFsLSdjYWNoZSBzdG9yZTog
LWM6IGxpbmUgMDogdW5leHBlY3RlZCBFT0Ygd2hpbGUgbG9va2luZyBmb3IgbWF0Y2hpbmcgYCcn
DQo+IGdpdCBjcmVkZW50aWFsLSdjYWNoZSBzdG9yZTogLWM6IGxpbmUgMTogc3ludGF4IGVycm9y
OiB1bmV4cGVjdGVkIGVuZCBvZiBmaWxlDQo+IEFscmVhZHkgdXAgdG8gZGF0ZS4NCg0KQXMgSSBt
ZW50aW9uZWQgYWJvdmUsIHdoZW4gSSB3YW50IHRvIHB1bGwgYWdhaW4sIGFwcGVhcnMgdGhlIHNh
bWUgcHJldmlvdXMgY29kZS4NCg0KSSBoYXZlIGFsc28gdHJpZWQgd2l0aCB0aGUgYmVsb3cgb3B0
aW9uczoNCi0gICAgICAgZ2l0IGNvbmZpZyBjcmVkZW50aWFsLmhlbHBlciBjYWNoZSAod2l0aG91
dCDigJggKQ0KLSAgICAgICBnaXQgY29uZmlnIGNyZWRlbnRpYWwgaGVscGVyIGNhY2hlIC0tdGlt
ZW91dD0xODAwDQotICAgICAgIGdpdCBjb25maWcgY3JlZGVudGlhbC5oZWxwZXIg4oCYY2FjaGUg
LS10aW1lb3V0PTE4MDDigJkNCi0gICAgICAgZ2l0IGNvbmZpZyBjcmVkZW50aWFsLmhlbHBlciDi
gJhjYWNoZSBbLS10aW1lb3V0PTE4MDBd4oCZDQoNCkFtIEkgcHJvZ3JhbW1pbmcgc29tZXRoaW5n
IHdyb25nPyBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgbWUgd2l0aCBpdD8NCg0KTWl0IGZyZXVuZGxp
Y2hlbiBHcsO8w59lbiAvIEJlc3QgcmVnYXJkcyAvIFNhbHVkb3MgY29yZGlhbGVzDQppLkEuIEpv
c8OpIE1hcsOtYSBMw7NwZXogU8OhbmNoZXoNClNlbmlvciBTeXN0ZW1pbmdlbmlldXIgQW50cmll
YnNzdHJhbmcgLyBTZW5pb3IgU3lzdGVtcyBlbmdpbmVlciBEcml2ZXRyYWluIC8gSW5nZW5pZXJv
IHNlbmlvciBkZSBzaXN0ZW1hcyBkZSB0cmVuZXMgZGUgdHJhbnNtaXNpw7NuDQpGYWhyemV1Zy1J
bnRlZ3JhdGlvbiAvIFZlaGljbGUgSW50ZWdyYXRpb24gLyBJbnRlZ3JhY2nDs24gZGUgdmVow61j
dWxvcw0KDQpFREFHIEVuZ2luZWVyaW5nIFNwYWluLCBTLkwgSSBSZWVzYmVyZ3N0cmHDn2UgMSBJ
IDM2MDM5IEZ1bGRhIEkgR2VybWFueeKAiw0KUGhvbmU6ICArNDkgNjYxIDYwMDAtODM4NzANCkUt
TWFpbDogIGpvc2UubWFyaWEubG9wZXouc2FuY2hlekBlZGFnLmNvbSBJIHd3dy5lZGFnLmNvbQ0K
DQpZT1VSIEdMT0JBTOKAr01PQklMSVRZ4oCLIEFORA0KSU5EVVNUUlkgRU5HSU5FRVJJTkfigK9F
WFBFUlRTDQpGaW5kIHVzIG9ubGluZTogTGlua2VkSW4gSSBYSU5HIEkgRmFjZWJvb2sgSSBJbnN0
YWdyYW0gSSBUd2l0dGVyIEkgWW91VHViZSBJIFRlY2hJbnNpZ2h0cw0KDQpFREFHIEVuZ2luZWVy
aW5nIFNwYWluLCBTLkwsIENhcnJldGVyYSBkZWwgUHJhdCwgNjUsIEUtMDg5NDAgQ29ybmVsbMOh
IGRlIExsb2JyZWdhdCAoQmFyY2Vsb25hKSwgU3Bhbmllbg0KRWwgY291cnQgcmVnaXN0ZXI6IFJl
Z2lzdHJvIE1lcmNhbnRpbCBkZSBCYXJjZWxvbmEsIFRvbW8gNDE1NjQsIEZvbGlvIDE1LCBIb2ph
IDkyMjE3DQoNClBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZS1tYWlsLg0KDQpUaGlzIGUtbWFpbCBtYXkgY29udGFpbiBjb25maWRlbnRpYWwgYW5k
IC8gb3IgcHJpdmlsZWdlZCBpbmZvcm1hdGlvbi4gSWYgeW91IGFyZSBub3QgdGhlIGludGVuZGVk
IHJlY2lwaWVudCAob3IgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJvcikgcGxlYXNl
IG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMgZS1tYWlsLiBB
bnkgdW5hdXRob3Jpc2VkIGNvcHlpbmcsIGRpc2Nsb3N1cmUgb3IgZGlzdHJpYnV0aW9uIG9mIHRo
ZSBtYXRlcmlhbCBpbiB0aGlzIGUtbWFpbCBpcyBzdHJpY3RseSBmb3JiaWRkZW4uDQoNCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQpEaWUgUGZsaWNodGluZm9ybWF0aW9uZW4gbmFj
aCBBcnQuIDEyIGZmLiBEU0dWTyBlcmhhbHRlbiBTaWUgaGllcjxodHRwczovL3d3dy5lZGFnLmNv
bS9kZS9yZWNodGxpY2hlcy9kYXRlbnNjaHV0ei10ZWFtcy1lLW1haWw+LiAvIE1hbmRhdG9yeSBp
bmZvcm1hdGlvbiBwdXJzdWFudCB0byBBcnRpY2xlIDEyIGV0IHNlcS4gR0RQUiBjYW4gYmUgZm91
bmQgaGVyZTxodHRwczovL3d3dy5lZGFnLmNvbS9lbi9sZWdhbC9kYXRhLXByaXZhY3ktdGVhbXMt
ZS1tYWlsPi4NCg==
