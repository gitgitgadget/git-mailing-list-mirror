Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 204811F731
	for <e@80x24.org>; Thu,  8 Aug 2019 16:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404190AbfHHQ6b (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 12:58:31 -0400
Received: from mail-eopbgr50117.outbound.protection.outlook.com ([40.107.5.117]:4476
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732775AbfHHQ6a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 12:58:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4+xmt6Mh/ZeQKIa7bmptfO1vLAJqB8PGIDSZYmVhDqDi0Z8hz1ZIuknt88sNRJtyqUQWGTf6G0ED+2UUqQ9AqrwhFx9G1VRBdV6D08AgJorSvBT1rYzyJcHd3mHYnxmMmAbjoc8at2RKBhMwst24R20ob7nVNTspBhBscwmRH/Q6qm2WZoSppFKBXL12zEkmwOLRMfFjPCsZSIoHbg11vB9NNyeCtvT13LeFZh2vVVaJwinUXq7nXezx/FuNeXCepghNYA0yPZUivAIoZqNxuoSWkJ/7TVLRKbYHRpeeWtqd2LiJl7KdMhKMil768Y8WfYc12zw9a7fW9Cq65r58w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN06VpogDk56EKqQXzUMazetb6Ds8dzf7wR24txSp3c=;
 b=kq7qFgbNkIxdzStvIskttvBSRgK4amkXF2dhnKidy94ZE1PTU7TLeQn70lbL4ULzBh0doO7WJFDADxntdKQXxByX5807iWfx9GkG96c9nwjf9zQ5GbzmFoUF5VZMcB87ezLR4DfGA40V6tQFPGkYiEC6DRYP5anzpdT9MICO8kh7CBZZs+TXaBZF3W1SMwNnQHc8/Z/Tx2Lg832cT39lbGZnDEWn2Ekx+k0oo2s8xVaLtdNZN2znEN8pJTvfg/LiN7V8+noeDCLCHOD+hF80EGtyZf4HXcYwEPIrak+76FfENcFYRFykFxEV5nWieOmeA9UPwpADJmvk0e0I0NKMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VN06VpogDk56EKqQXzUMazetb6Ds8dzf7wR24txSp3c=;
 b=kAennr+qwGxtRasLqPpq2cqM/yGdxcHbeQSIpq4QhhZC1xayLfHpFLT8ZA0NCCzXHpriHWYHVHoQ/+SqYawBTfo4XkUc+zfSlrJV0HEUP8oI+QiuuCUYxUtHfJewrKmeB/pHoK81Xmi40t1rhtQO9YiO8N2gTU8K6mg06Ihrir0=
Received: from DB7PR83MB0268.EURPRD83.prod.outlook.com (20.176.229.151) by
 DB7PR83MB0235.EURPRD83.prod.outlook.com (20.176.228.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Thu, 8 Aug 2019 16:58:27 +0000
Received: from DB7PR83MB0268.EURPRD83.prod.outlook.com
 ([fe80::59bd:6fb0:f5b5:8660]) by DB7PR83MB0268.EURPRD83.prod.outlook.com
 ([fe80::59bd:6fb0:f5b5:8660%11]) with mapi id 15.20.2178.006; Thu, 8 Aug 2019
 16:58:27 +0000
From:   Christopher Ertl <Christopher.Ertl@microsoft.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: Windows absolute drive path detection incomplete
Thread-Topic: Windows absolute drive path detection incomplete
Thread-Index: AdVOCE3sFLO7Bl4STuW8/kok91nF0AAARZEAAAA7sdA=
Date:   Thu, 8 Aug 2019 16:58:27 +0000
Message-ID: <DB7PR83MB02682420A7444A60F8C9453997D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
References: <DB7PR83MB0268816EF2F435EF791272C197D70@DB7PR83MB0268.EURPRD83.prod.outlook.com>
 <CAPig+cSuj6xWjYuQtuiuNQwroqO8sEh4iAGgLqQVOLQr8CMpDQ@mail.gmail.com>
In-Reply-To: <CAPig+cSuj6xWjYuQtuiuNQwroqO8sEh4iAGgLqQVOLQr8CMpDQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=chertl@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-08T16:58:25.7299502Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0844da02-7949-468b-b7cb-c8b023ca40f0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Christopher.Ertl@microsoft.com; 
x-originating-ip: [2a01:110:8012:1010:c81d:3559:42d3:548a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89e9e87d-a426-4c17-0efc-08d71c21a1ee
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR83MB0235;
x-ms-traffictypediagnostic: DB7PR83MB0235:
x-microsoft-antispam-prvs: <DB7PR83MB023550B54A012D623C5D789397D70@DB7PR83MB0235.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(346002)(366004)(39860400002)(13464003)(199004)(189003)(186003)(14454004)(4744005)(6916009)(86362001)(11346002)(46003)(446003)(229853002)(7696005)(76176011)(76116006)(316002)(476003)(486006)(99286004)(25786009)(6436002)(52536014)(81166006)(2906002)(10090500001)(8936002)(10290500003)(81156014)(9686003)(6116002)(71200400001)(71190400001)(53546011)(8676002)(4326008)(74316002)(7736002)(6246003)(256004)(33656002)(478600001)(66476007)(14444005)(6506007)(66946007)(66556008)(8990500004)(55016002)(64756008)(53936002)(102836004)(66446008)(5660300002)(305945005)(22452003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR83MB0235;H:DB7PR83MB0268.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4Hsl5PDX7u+uZghUwT0GiHLJQXV2mlWBRuLQfCL+BaNmDWbGtgEdbMuRazcMMDXGotXGp5h/D4Nil4xME1mv4VoW0avUk1GJ74Dni4mt469pmoMvw0HxbAf1JBl/rAAdIM8EMwdr4YyxN94U0OTKjBI2Z0hSWPVPlIs5heIwLDLQNL/itc/JfJLlm+dwgKB2yzlguKTzgsTshau2mV5WjWqnIcuie6hDJX4iD7HFiUGzDLLcMGDWmucHmFzy98UfnIhbu4Ysr2xWaLz67b+CIJYZSeg5PkRwiL3h7njduhzWM1CqHzVD07sGjIIUPd9p/X0lQC32EYBS0NpfuPsGaPISXjzuJ/SCNYWgrPfhyW+4b+QxJaKO9w1QFm7U/gmzo49N9BBUvj38xX/bxJ6ionRD/e8t4/nbWjrSm9RxBWw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e9e87d-a426-4c17-0efc-08d71c21a1ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 16:58:27.0666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d96yoaRG6pLshs1Bxi5UnN/itd8dGPevzy7mmbNKld/9a0umALWkXnnyUa1erZpYpKN/SOVJtxJSdy4IxGWo9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR83MB0235
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

VGhhbmtzLCBFcmljLCB5b3UncmUgYWJzb2x1dGVseSByaWdodDsgZ29vZCBzcG90IQ0KDQpDaHJp
c3RvcGhlciBFcnRsIHwgTVNSQyBWdWxuZXJhYmlsaXRpZXMgJiBNaXRpZ2F0aW9ucyB8IE1pY3Jv
c29mdCBMaW1pdGVkwqANCk1pY3Jvc29mdCBMaW1pdGVkIChjb21wYW55IG51bWJlciAwMTYyNDI5
NykgaXMgYSBjb21wYW55IHJlZ2lzdGVyZWQgaW4gRW5nbGFuZCBhbmQgV2FsZXMgd2hvc2UgcmVn
aXN0ZXJlZCBvZmZpY2UgaXMgYXQgTWljcm9zb2Z0IENhbXB1cywgVGhhbWVzIFZhbGxleSBQYXJr
LCBSZWFkaW5nLiBSRzYgMVdHDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBF
cmljIFN1bnNoaW5lIDxzdW5zaGluZUBzdW5zaGluZWNvLmNvbT4gDQpTZW50OiBUaHVyc2RheSwg
QXVndXN0IDgsIDIwMTkgNTo1MSBQTQ0KVG86IENocmlzdG9waGVyIEVydGwgPENocmlzdG9waGVy
LkVydGxAbWljcm9zb2Z0LmNvbT4NCkNjOiBnaXRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBS
ZTogV2luZG93cyBhYnNvbHV0ZSBkcml2ZSBwYXRoIGRldGVjdGlvbiBpbmNvbXBsZXRlDQoNCk9u
IFRodSwgQXVnIDgsIDIwMTkgYXQgMTI6NDUgUE0gQ2hyaXN0b3BoZXIgRXJ0bCA8Q2hyaXN0b3Bo
ZXIuRXJ0bEBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gU28gSSdtIHByb3Bvc2luZyB0byByZW1v
dmUgdGhlIGNoZWNrIGZvciB0aGUgZHJpdmUgbGV0dGVyIGJlaW5nIGFscGhhIGluIGBoYXNfZG9z
X2RyaXZlX3ByZWZpeGAgbWFjcm86DQo+DQo+ICNkZWZpbmUgaGFzX2Rvc19kcml2ZV9wcmVmaXgo
cGF0aCkgXA0KPiAgICAgICAgICggKHBhdGgpWzFdID09ICc6JyA/IDIgOiAwKQ0KDQpOaXQ6IFRo
aXMgaXNuJ3Qgc2FmZSBhbmQgd2lsbCBhY2Nlc3MgbWVtb3J5IGJleW9uZCBlbmQtb2Ytc3RyaW5n
IGlmIHBhdGggaXMgemVyby1sZW5ndGguIFBlcmhhcHMgc29tZXRoaW5nIGxpa2UgdGhpcyB3b3Vs
ZCBiZSBiZXR0ZXI6DQoNCiAgICAjZGVmaW5lIGhhc19kb3NfZHJpdmVfcHJlZml4KHBhdGgpIFwN
CiAgICAgICAgKCoocGF0aCkgJiYgKHBhdGgpWzFdID09ICc6JyA/IDIgOiAwKQ0K
