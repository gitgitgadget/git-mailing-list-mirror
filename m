Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2032.outbound.protection.outlook.com [40.92.42.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CB14F215
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966424; cv=fail; b=GpEIpI5CaX5RqpmUU8FDyY659CRAeAum0JKYtQ8NcvTL1/6WVUxIFK7DfJ9lDDCfKgPMdyuUkcT7TkD6swR7fIBSbMHqmoEs6g2q5nZFQlBN1BlXoe1Zc9bO1J0TPIQZk6U4bCcnBMR8Pe4mYqZWh1wuxqQmd9eQf9WflIPRuh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966424; c=relaxed/simple;
	bh=Mt5L1dtACDRJZfncVTEl/YhwDVjCcwOPBXF52F9DODM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rvXzZuUbhzCJ0U3/lTX7sW/ncI8JlXIWyF8V84rnQu/VnCQ2OiE6k5JehFqFzagvPCA+uKS+vSkAe10CwUPBc623glYZaaReBSrPkzwBxyrDVman4Quckk3PGCWKVaLa+d20IYzkhjndfjDiN3JXA4e6C4CPM6LXEgzeeeBfiMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=H6UNCuhy; arc=fail smtp.client-ip=40.92.42.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="H6UNCuhy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dbcUwlOk1USSNF+/Q6bnF2Tx9xq4IihBV6j8ESto3BsamIb92jRVH+iQ2qdaMuuU75/Ceq0GlB3U3p7JKwftq7akC1/ptbojrPdgceorv7NKI38j/xX7W6IupxAZ4G2cZfYl1d37NiX2BG5xNUuiuVRNoZssXNwzLtBmgsrKVkjX9iisFy6/elf5pDqwz6tb6yap3Qfmt4vBDxerma1cWwmsjHv5tB8Je+LZY3TKq9MkcV8DdnMMvnaXhX/yA7anI7jIn+bHoDJKG9Mp//K2eNgM2uUIxIuEzuRLaCfo/+uAkGnRwd5MkIVwaWy5sF11JxwiWraPEr3/LpXoN2CAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt5L1dtACDRJZfncVTEl/YhwDVjCcwOPBXF52F9DODM=;
 b=XbNVY8UMrGcUBLxeY/2VNQzezul52yUlJTJ5/IbHideQCCL5mQyhml7cWR3Nn0Peb2WLoEbvZDiIXj9Hl66M9MgEUEYiry4dWry9ssohnEIXgl0iFuGIIW6R+xJusK7UOhWDkFKo2Sj7xq8/h7OV7YUrAQ99vSqwUCqUT4zYjn99399lIrF24w6MyjSHOQoRysIi43+JKG02FCSv9z+ZUQhAAi/npEsuqRG1A2cPP0IqEPnOlPYhEeXh3CdMCUCg6GzM6bCwDRP07DKH+lh1HqyOW+ZK9TLQIaZtED8OM3s3ztkclL2uZpXRciVHX1NvdoSRb/GXZ7uDtUmBY37s7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mt5L1dtACDRJZfncVTEl/YhwDVjCcwOPBXF52F9DODM=;
 b=H6UNCuhy6F6sGCUdQXbtOMbTZ8xMD1vJyIjEara1OArvOkx2+c+l0C9jGz0lwQ3Oubma8NgwJTnqz7kaS1+L8lg+Jud0mJLrnISkv3nCM97G8MG5pZNYy4h5D02wYdXWZfsTZfBKA7dZeil31d5wNnAf/7y4BdLN48hoS7yz2aQJrn1T3Wg2sM581UaiW2T1OS1t2eEqHe1Em3gExncP03lC4Hwt+0PjNBvb/mSV/XvQJm32/4c5KhS3QXES891iuq6l7dlTVA1a3PJHVXSqFB+cwD0lwr1CEvhvSXQ8+118Ni5l3zSZTC0xstpnTeSJeN5eRi3WXgC/jEjNmvRQ5A==
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1d9::7)
 by LV8P220MB1800.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Sat, 3 Feb
 2024 13:20:20 +0000
Received: from LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9]) by LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
 ([fe80::827f:5c25:3f99:20c9%6]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 13:20:20 +0000
From: ross nicholas Oneil thomas <rossrecovery93245@outlook.com>
To: GitHub <support@githubsupport.com>, Github email <git@vger.kernel.org>,
	GitHub Developer Support <developer@githubsupport.com>
Subject:
 =?utf-8?B?Tm8gb25lIGlzIGFsb3VkIHRvIG1ha2UgY2hhbmdlcyB0byBkZXBlbmRlbmN5?=
 =?utf-8?B?4oCZcyBiZXNpZGUgbWUtIG93bmVyIG9mIGRvbWFpbiBhbmQgc29mdHdhcmUh?=
Thread-Topic:
 =?utf-8?B?Tm8gb25lIGlzIGFsb3VkIHRvIG1ha2UgY2hhbmdlcyB0byBkZXBlbmRlbmN5?=
 =?utf-8?B?4oCZcyBiZXNpZGUgbWUtIG93bmVyIG9mIGRvbWFpbiBhbmQgc29mdHdhcmUh?=
Thread-Index: AQHaVqO8Lxbkqj3nq0uj8ghr0dYkBw==
Date: Sat, 3 Feb 2024 13:20:20 +0000
Message-ID:
 <LV3P220MB1286B89F9B2513A96A2D07EEFB412@LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [mAyxT+EQfidthp3N6jnTZUYgqf4mn38P3D+/sSgxxGM=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3P220MB1286:EE_|LV8P220MB1800:EE_
x-ms-office365-filtering-correlation-id: 9f3dbb89-0879-45a3-ced0-08dc24badee9
x-ms-exchange-slblob-mailprops:
 3tqGmd+bMX5MftkY61zPZbSQs6fd4N2QapssH46mYPUWDwD9PbYxPgaUhPz9sUGRT34pM8spT3oB6pl/7bJNIQjXTXZhPymtjvmh+ywUtFVmSaj3LlWhZe69BOXC8CgtT8Cg/4PG0qFDO7IvhUFSVWEtYJQr7vfQAD+Lt9hTYUTCRzmDEW4SCFTU7IThzjF9tPicL/fXfdUpko0YFqTM+M1gs1ENnJSLvHzcgps1WbgslCLcGHW5sdwmBLUfNPRflHB4XZmRUdnxeL+bSpIJpw5e236DwmwcTobC9+jiflqwlCrAb0bPicaAHPIzQNG0vWVJrgO64Nj5+bXV1J0yeULEDtxKSdeCv8sQ8jBb0aGtOkm4HhZlAZEaos83LuC3HQLqIBj1bkLd45jqp3A6CrcXU9mwWD+r5pA2HMwkDFsWPNoUpOkZcTjPxL5VgJG/8lptq/KMin4yuqfGSR2MmzxVHyYH8++RolPu/AUIAkKrnbtO0hIqg8XroCv39LRYz/E9n5iLS+80ePSx0MO0c5ktvWZs7EU4DYsRwvNnd4bkLfgFjisNgp/JW9GQMfrzfnItzfBcHBlrVkB7Nu86QTtoZ5rvxlTFB44EKmkAlwesVCoQFcbPeQgZsSFNafpnfhnO+nla0rvh1PwDzOXGq2Ut8IVt3IFEAamicfGRBdQcEJ51utY3wkVKKKd2FIknUOrAUPAXs0vTMTqTYkvRYTu9lRe5H/Gmly7gZLvkq7U5wtY1nZY3ip6fE4j7YDyNA9YppJOcV901TCgDkbDYOwIaKcUrtmcCr6STj2r3HRLWURqE+TRJtio+UU0nnp3f6nFawq34NbJO9IMRvoIrzZdCsH98B/3s1v3uZi3o+2RNEVBe1gdXOj1VpjbMDfLAhogvd9B3U3fyA8GJfdomC1uA2Sz074U47T380xqftxsnRb5PxfVVLCSxzyb5q/ih
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ggwj8/lb2NeURfo/rSNllMMjJ5BWDKNf0KzL8W0AbvOiJ2aRX7DfX5MmmYbi90h4mU5cezgH3xW8GWnStOlMvipSprV38kmnnUTLok/yjQjmw/0kJ49kBV4TwmS1X62ur+ZUg7SNVaOriUS/94NQzzhG2aoU9VXK9gcJ65Z8XJCjPmT/PKZNhjuFtTy1Qet/imXm3PUltt6Pgp0R7AIX/xnsv9ptCCRCFMgy6LPdMMlFbedbMae8OTzQ8JxJCo5VCLf0WGg8u5eioa97N6NxS2gaAzOPeVMBRRVi4haRk7DAAX+qh6Z1n7cT4DfcgMjpa8Fy1eZdsNIR0u/lYLNJgLmATrX0SIG72I0FyyqgBgv4rOzR69IAKP07Z32l2HJpQeSDWLM44u9QzYrIjrk2P8FLWCP+8OhKK13ci/cvJ9GJj9n71f/CxMfMi/lOJmnUy/SBWV52N1DAPqD25sI5iKyg1N0mmAQldEZPBGl5X9BKHGsrwYzpQXqpRTzM66iUTGFDElUR0GZ/vZASsM28Jga1dPpneAG+FZoJ0/WJmeiwtomvln9amamX7jMNuy3x4tgRZOQnV3G/cb0GGG3I0SwIBAa5gYkkhS+5vbP+E9Hc013JI8jrzG3B/VIiXIm0
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXRta1JlN0Qvb0xMbDFFTEFuVzFJQ1dQQmp0eFl5UFRzOTdIRGZWYWV5cytn?=
 =?utf-8?B?VUZGWG84OE9zMHRDODU2bTN4UXZqZC9XcWVDSlp3WE5naUxXa0J5UEJ1NXdT?=
 =?utf-8?B?WHRGMWYySHpTb2pLZkRJcmMyN2NZM2RLWDl1dDJaQjFPdTZEOFBIemFkbUV3?=
 =?utf-8?B?Zi9uUU9EZjJtVEJabnc5OXJQQlhkWmcraUg3WDlqTlBTQk9sa0YvVGN1RThq?=
 =?utf-8?B?UnBZMjYwSG1DWHF6c1JScXg2SUVhWnM0QjdnZkhvS1g5R1dxYnlWQ1lUV3cy?=
 =?utf-8?B?Z2t4YXlrSmlBaHVXU25UVitSRFBnYjRva0pFU0pSekVzYnJTSGl2OTdFZG9C?=
 =?utf-8?B?TjBEVE05bnl3TzJRK3RGcGJQUW94SWlJczM4anNkWEt3WnpyUGtjZitYTElW?=
 =?utf-8?B?bURvZzc0MGV0cWlLeEgyYlVOejNCbjNCMHhjQTlzNWFBdmR1bjgvTS9MNDBq?=
 =?utf-8?B?NFhGcEVoSkxqUDBTVENHVTRSNEwyOXRXTVlJMFJiR1l5dUdVbEtwU0loYmg0?=
 =?utf-8?B?bXpRcmFLOVJoZ0dza0I1K1hMTHpFQ3VISTBBdzhPR1dRK2VMTlZzeit4dmYw?=
 =?utf-8?B?ZVZzbmh0VUVXY0JEVE94WSswTmJZWlUxUHlhRjBiUnozMTlYTjZTUnVWNEMz?=
 =?utf-8?B?bS8vejQ4NFRDTlhwRW1xQWRnNWdxZGRhUjU3OTk4RnZyOStGL2JlcmdXUmh2?=
 =?utf-8?B?UElZaEt1ZVd5M1BYSHhZZ0YyTDR0azgxUUl6WmF1elRQakdGV0w4Rm9lRU0y?=
 =?utf-8?B?R2hxN2Y3S1J1dDVKWGZ4c1NPV01yTXZZV3ZDVnpmVzJ0QW1jNUpXdnYwME1j?=
 =?utf-8?B?UzFmdXFIbUs3c3dtU2ZaYU1qckNUdnJSeE1FM05Za2V2cTFDT1B6UXRBUk1F?=
 =?utf-8?B?ZUs2dUJvaVg2UG1vTHYwb1ZiOVB5bXBGTjNHRjhhZzZ5bTY5RkxQZUNxMFZN?=
 =?utf-8?B?NERxSDRRUkVpM1ZBY0V5TXA1K0tlbG9GeHdMRks1aEtqcjV6dFROQTJFNFdF?=
 =?utf-8?B?ZDJwQ1ZMR2FzbVE3cTByZ3YwRUtwcm4yTjEzNHVpWnJuamhraEFqL1hQWHFt?=
 =?utf-8?B?T1c3RE5mcGpwTFdrNG9qRDAzdzNYYnc1OTlRSEsyNGNMdE5COEQwV0lSbVpw?=
 =?utf-8?B?VkE3WnB0N2RXTzlva2grMmsveHB5T0NXOGhScHlpSU44UnBWQ2dUcXFWanNo?=
 =?utf-8?B?S1o0Z1N1bURVREV0aWpFbFdRMmlZTVd4RGR0RVV6VitPeTVaemF2MmFBUmcw?=
 =?utf-8?B?NnJjbUV5VDNsNVZwcXJyZ2RreUsvb2liUHU1dllGcmRqeUZsUCtqQTI0b2d2?=
 =?utf-8?B?cXBFckV1SSs0dWUzYlFuSEgvUWFwSWxYRnp2Y1ZWWFNJTlpSM2VNY1lvK0pj?=
 =?utf-8?B?enVUNFZKdU1qOS8vdGdZakZtWS9LVzczMFBpL3ZZMmRuL0xCOTBpZUtrWENz?=
 =?utf-8?B?RTRkalh1Y2dVZ3NEOW1SQ2o5RHlMK0ZTRnhkd2JCejRubjF3SWdzZFRodmdT?=
 =?utf-8?B?aHpDNTh4Z0JDWjBKTEhFSmpuSFJOZitUZCtGMGorZTJ2WHQ2emIxYWZVVzZk?=
 =?utf-8?B?cHJCcWxBL2wrSXJLOUE0b3c3cVFiaS8vWEV4SUZKaDBJTE5wa0JTK0V6VTg1?=
 =?utf-8?B?S2dYVFhScDlWVSt4WEVhSGhqMFRBUGltUWRzaW1XRGh3bXhGMUVKTzRRWW1W?=
 =?utf-8?Q?aFi5GbbZeDGUPPGa9rOr?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <C103AC1208DD224BB06DEB82199011C3@sct-15-20-4755-11-msonline-outlook-3458f.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1286.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3dbb89-0879-45a3-ced0-08dc24badee9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2024 13:20:20.2110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8P220MB1800

SGVsbG8NCknigJltIHRpcmVkIG9mIHRoaXMgY2hhbmdpbmcgYW5kIHRoZSBwZW9wbGUgdXNpbmcg
bGljZW5zZSBmb3IgdGhlcmUgb3duIGJlbmlmaXQgR2l0SHViIGlzIG9wZW4gc291cmNlIG9uIHRo
ZSBzaXRlIG5vIHdoZXJlIGVsc2UgYXJlIHRoZXkgYWxvdWQgdG8gZG8gdGhpcyB3aXRoIGxpY2Vu
c2Ugb3IgcGF0ZW50cyBvciB0cmFkZW1hcmtzIG9yIGNvcHlyaWdodHMuIEFyZSB0aG9zZSBldmVu
IHN0aWxsIHNlY3VyZWQ/IA0KDQpXZSBzaG91bGQgY2hhcmdlIGEgZmluIGZvciBjaGFuZ2luZyB0
aGlzIQ0KDQpodHRwczovL2dpdGh1Yi5jb20vY2hyb21hdWkvY2hyb21hdGljLWNsaS9hY3Rpb25z
L3dvcmtmbG93cy9jaGVjay1sYWJlbHMueW1sDQoNCg0KUm9zcyBOaWNob2xhcyBPbmVpbCBUaG9t
YXMNCm93bmVyc2hpcCBvZjoNCnd3dy5naXRodWIuY29tDQp3d3cuY29pbmJhc2UuY29tDQp3d3cu
anNudWxsLmNvbQ0KKDU1OS04MTYtMjk1MCkNCg0K
