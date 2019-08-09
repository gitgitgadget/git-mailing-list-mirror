Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E729A1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 20:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHIULh (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 16:11:37 -0400
Received: from mail-eopbgr720107.outbound.protection.outlook.com ([40.107.72.107]:37956
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfHIULg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 16:11:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVhAe3A3gdBC6ls9+KxzEB05stmCMT/TqOl1aBgAWsmYVo71i4S6CJ4CmsPL1/Fxf+F6CAPQS8whHN7VDbIiUQhFIFcLoZVBVzYf4JKEtkmom93wJYGPfgWz5UlDC0HUADmkpWvxMGgVy2loanOI5MxYtnhzkFFN0HGW03lbRtox+QYub5m+462m66u2dPrAYiqSPPa1hRzbQRKwWoP+Q6/U9Q7Q8SQqdzGT3w8XJKXFAcfWmkq1hlfpe/xufaPgUZzH+u0XrQekb87oL50NspydNr4Mw5eIc3DFWc1Xs62orqqv8oTuxJ+R2EMIyMeNi3DRD2c47UFRwjogqB9Bzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvZM15PRD+OQ4/Y7O7NuV75DmnjBWIVnI1U5LNKADGw=;
 b=NZgxK22tLtYqJHNGAACVdGqos99usnOWlHdrQ1X5EDTclSLfF9nQ52WprpfgIIlADJL2imigMgIkRbeQir3Ad9jfp0eLJ2mB5zscfTKW06Xpe9MIZJT9csBlY4dpuVFxS9DTMTnQbvoHeFBFyh5GFAxFLx/bqLcFX31pvIaZy8F3YPUW4sGEeLcfomnqXEM8Q49PTnNtOcNO2P5OKQO/RPJdkzQE28Z3TJCfg3A247f7NQq5UvsrW6hG4jFusA7MG5amtGD7NI5bODjyKf+bbJIhQBH/hzyscQ6KuS1wtqbAdeqiPMOrMRWjfAuWy+ChCM9OJWRSSbCvYy5DdGlV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jvZM15PRD+OQ4/Y7O7NuV75DmnjBWIVnI1U5LNKADGw=;
 b=nYwHLzN30Bp9iIGlr4rk34OkQLiXGGmGekkRvo1ESMd3VlwzuchvSupvEj3bNcxYIxIrxn1qCZCh5wlITCAfOK3455lLjeyXOtagphGOSaqg+30rf3Hzv//nkegU3zvNLKv8oA+JnXByaVslpWGhevR3E++Lu5c/ipcRphz0Fr8=
Received: from BN8PR21MB1156.namprd21.prod.outlook.com (20.179.72.203) by
 BN8PR21MB1204.namprd21.prod.outlook.com (20.179.73.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.11; Fri, 9 Aug 2019 20:11:34 +0000
Received: from BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4]) by BN8PR21MB1156.namprd21.prod.outlook.com
 ([fe80::b896:fe09:31ae:e9a4%9]) with mapi id 15.20.2157.001; Fri, 9 Aug 2019
 20:11:33 +0000
From:   Cliff Schomburg <clisc@microsoft.com>
To:     =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: "git log" does not display refs info when executed via C# Process
 class on Windows
Thread-Topic: "git log" does not display refs info when executed via C#
 Process class on Windows
Thread-Index: AdVO6XCnSWdcLXyxQQWtA59IuPRg6AAAkKqAAAC6MJA=
Date:   Fri, 9 Aug 2019 20:11:33 +0000
Message-ID: <BN8PR21MB11565C3CD2522EA8BB887AA9B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
References: <BN8PR21MB11569DAA8A677BF00113F683B7D60@BN8PR21MB1156.namprd21.prod.outlook.com>
 <20190809195031.GK20404@szeder.dev>
In-Reply-To: <20190809195031.GK20404@szeder.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=clisc@microsoft.com; 
x-originating-ip: [24.182.67.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05b4770f-b2d0-499c-cec0-08d71d05c695
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600158)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR21MB1204;
x-ms-traffictypediagnostic: BN8PR21MB1204:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR21MB1204A25A3BEB7B84E050DA65B7D60@BN8PR21MB1204.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(199004)(189003)(40764003)(13464003)(10090500001)(229853002)(6916009)(76176011)(71200400001)(6506007)(25786009)(71190400001)(53546011)(9686003)(55016002)(81166006)(81156014)(8676002)(66556008)(7736002)(66476007)(66946007)(7696005)(76116006)(6306002)(6436002)(64756008)(14454004)(66446008)(52536014)(4326008)(53936002)(256004)(26005)(186003)(102836004)(6246003)(5660300002)(316002)(3846002)(476003)(10290500003)(99286004)(486006)(6116002)(86362001)(22452003)(478600001)(966005)(8936002)(305945005)(74316002)(2906002)(446003)(8990500004)(66066001)(33656002)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1204;H:BN8PR21MB1156.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9f5saK+qt5qbIeL6F89N/F2qlZMPSizCQkEhdXLLowMT9sMNMO76KjFSobtQjbr0/QED3vLLpmOj+IZ2seuxVtgvz+e10Cak/HAlPpAZqC8R+Q0ErNV5FICVAu5e0/e/N9i3x5MkCTRBL4gKT+UZulzyS1FBbdCx3E8yWLyzlz1ONEJj5HISzRy5Dm6HrZtGqdhVxY2Iu6AXC4ijDeNLfN9EPiBuIZObdYm5JULVpcJe+TYZyxvKfUhaw1FQVEmm9Zu7P+fYT1shQJcU4xJSRTpsSyLdN7nGcTgwnsIFjeGADM3zGFz6XPmZrDv3ubddUVXYBJGxt49u79ORsZgrdllhtAwULjmqd48E1+P51nsj+LDdhOZ0jnWyShPNMEgVDrmDhotSulDQN59qwskAFCCOs+g0UOjO3U6hK4wcVPc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b4770f-b2d0-499c-cec0-08d71d05c695
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 20:11:33.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: II5XlkNjKoykj8s2HFYOmyijQEn1MfTgpeULF3JGQE/wstU1YfAwyAgEcWUP9kCd9gF/lXSvAKEjecfkWc4xtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1204
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

QWRkaW5nIC0tZGVjb3JhdGUgZ2F2ZSBtZSB0aGUgZGVzaXJlZCByZXN1bHQuDQoNClRoYW5rcyBm
b3IgeW91ciBoZWxwIQ0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogU1pFREVS
IEfDoWJvciA8c3plZGVyLmRldkBnbWFpbC5jb20+IA0KU2VudDogRnJpZGF5LCBBdWd1c3QgOSwg
MjAxOSAzOjUxIFBNDQpUbzogQ2xpZmYgU2Nob21idXJnIDxjbGlzY0BtaWNyb3NvZnQuY29tPg0K
Q2M6IGdpdEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiAiZ2l0IGxvZyIgZG9lcyBub3Qg
ZGlzcGxheSByZWZzIGluZm8gd2hlbiBleGVjdXRlZCB2aWEgQyMgUHJvY2VzcyBjbGFzcyBvbiBX
aW5kb3dzDQoNCk9uIEZyaSwgQXVnIDA5LCAyMDE5IGF0IDA3OjM2OjE5UE0gKzAwMDAsIENsaWZm
IFNjaG9tYnVyZyB3cm90ZToNCj4gSSBoYXZlIGFuIG9wZW4gR2l0IGZvciBXaW5kb3dzIGlzc3Vl
IGhlcmU6DQo+IGh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20v
P3VybD1odHRwcyUzQSUyRiUyRmdpdGgNCj4gdWIuY29tJTJGZ2l0LWZvci13aW5kb3dzJTJGZ2l0
JTJGaXNzdWVzJTJGMjI4NSZhbXA7ZGF0YT0wMiU3QzAxJTdDY2xpcw0KPiBjJTQwbWljcm9zb2Z0
LmNvbSU3QzE3Njg5ZWU4ZDMyZDQ4NTI4YzMyMDhkNzFkMDJkOGQ1JTdDNzJmOTg4YmY4NmYxNDFh
DQo+IGY5MWFiMmQ3Y2QwMTFkYjQ3JTdDMSU3QzAlN0M2MzcwMDk3NzEwMTM2NTg3MzgmYW1wO3Nk
YXRhPVBLUGRSSTBtQzY1THgNCj4gMko1ZXRZbnAwZnl6c2slMkJYU0d6R0JXYTEyQkxLRUUlM0Qm
YW1wO3Jlc2VydmVkPTANCj4gDQo+ICJnaXQgbG9nIiB3b3JrcyBhcyBleHBlY3RlZCBmcm9tIHRo
ZSBjb21tYW5kIHByb21wdC4gIEJ1dCB3aGVuIEkgZXhlY3V0ZSBpdCB2aWEgQyMgUHJvY2VzcyBj
bGFzcyBhbmQgcmVhZCBmcm9tIFN0YW5kYXJkIE91dHB1dCwgdGhlIHJlZnMgYXJlIG1pc3Npbmcu
DQo+IA0KPiBJcyBhbnlvbmUgZmFtaWxpYXIgd2l0aCB0aGlzIGlzc3VlPyAgQW55IGlkZWEgd2h5
IHRoZSBvdXRwdXQgdG8gQ01EIGFuZCBTVERPVVQgd291bGQgYmUgZGlmZmVyZW50Pw0KDQpEZWNv
cmF0aW9ucywgbGlrZSBjb2xvciBhbmQgcmVmcyBwb2ludGluZyB0byBhIGNvbW1pdCwgYXJlIGZv
ciBodW1hbnMsIGFuZCBodW1hbnMgcmVhZCB0aGUgdGVybWluYWwuICBJZiB0aGUgY29tbWFuZCdz
IG91dHB1dCBkb2Vzbid0IGdvIHRvIGEgdGVybWluYWwsIHRoZW4gbm8gc3VjaCBkZWNvcmF0aW9u
cyBhcmUgc2hvd24gYnkgZGVmYXVsdC4NCg0KVHJ5IGludm9raW5nICdnaXQgbG9nIC0tZGVjb3Jh
dGUnOyBvciwgYmV0dGVyIHlldCwgdXNlIHlvdXIgY3VzdG9tICctLWZvcm1hdD0nLCBlc3BlY2lh
bGx5IGlmIHlvdSBpbnRlbmQgdG8gcGFyc2UgdGhlIG91dHB1dCwgDQoNCg==
