Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E56220248
	for <e@80x24.org>; Fri, 15 Mar 2019 02:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfCOCXn (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 22:23:43 -0400
Received: from mail-eopbgr730134.outbound.protection.outlook.com ([40.107.73.134]:26592
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727578AbfCOCXn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 22:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XmYS5UTxyasdTxmDG9t9Wf75P/7eLzSFvkqelzBRWI=;
 b=CNeQN8wHcuBQSqxNJSwgE9awqqorh6EeRw246xUoBLUco6FoYCu3a+1SmmFQq9NGDoKU+032S4JbfzjiKvL2wJZt91GfUbR9VN0jCYx0Q4Zdvf5swVzXBqBfo08sBmVq2tdCvoMPmQKYTOfn2EEkBvDSHNjiGvYBszhmmZvlmLY=
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com (52.132.23.151) by
 BL0PR2101MB0994.namprd21.prod.outlook.com (52.132.23.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1730.2; Fri, 15 Mar 2019 02:23:39 +0000
Received: from BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::c96a:6fc9:2619:a56a]) by BL0PR2101MB0914.namprd21.prod.outlook.com
 ([fe80::c96a:6fc9:2619:a56a%7]) with mapi id 15.20.1730.003; Fri, 15 Mar 2019
 02:23:39 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
CC:     Thomas Gummerer <t.gummerer@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?utf-8?B?U1pFREVSIEfDoWJvcg==?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: RE: regression in new built-in stash + fsmonitor (was Re: [PATCH v13
 11/27] stash: convert apply to builtin)
Thread-Topic: regression in new built-in stash + fsmonitor (was Re: [PATCH v13
 11/27] stash: convert apply to builtin)
Thread-Index: AQHU2r8vO3VhCUMSh06i2PRPPdybN6YL9ksg
Date:   Fri, 15 Mar 2019 02:23:39 +0000
Message-ID: <BL0PR2101MB091483F7B267CD57A37499B6F4440@BL0PR2101MB0914.namprd21.prod.outlook.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
        <20190225231631.30507-1-t.gummerer@gmail.com>
        <20190225231631.30507-12-t.gummerer@gmail.com>
        <87ftrpbnkg.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1903141600020.41@tvgsbejvaqbjf.bet>
        <87d0mtbh1w.fsf@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.1903142058130.41@tvgsbejvaqbjf.bet>
 <878sxhauvh.fsf@evledraar.gmail.com>
In-Reply-To: <878sxhauvh.fsf@evledraar.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-15T02:23:37.4008433Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7b5b6b1f-44ac-40fc-b230-df196407aa31;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44af844a-2946-4b54-506b-08d6a8ed3c93
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:BL0PR2101MB0994;
x-ms-traffictypediagnostic: BL0PR2101MB0994:
x-ms-exchange-purlcount: 1
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BL0PR2101MB09949CB4EA929ADF046F5C23F4440@BL0PR2101MB0994.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(396003)(376002)(366004)(136003)(55674003)(189003)(199004)(66066001)(229853002)(7736002)(305945005)(6116002)(99286004)(33656002)(105586002)(97736004)(4326008)(256004)(25786009)(10090500001)(106356001)(8990500004)(71190400001)(71200400001)(6506007)(22452003)(81166006)(68736007)(86612001)(5660300002)(11346002)(81156014)(102836004)(86362001)(76176011)(2906002)(6346003)(478600001)(316002)(72206003)(446003)(74316002)(54906003)(476003)(486006)(110136005)(93886005)(186003)(3846002)(7696005)(14454004)(53936002)(9686003)(26005)(966005)(10290500003)(6246003)(6436002)(6306002)(8676002)(8936002)(55016002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0994;H:BL0PR2101MB0914.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: jBj/8K7F/CUEH0HGgCrfzfIzf07l+aUDxG1+P2stEAPvalvTWHv5ZTGPOEsSwI3EveduLXoybrQwMoGic9CG7yxjHXDLV1SsiOabpinF9//mwrF8GJMlAdAHOlftvA1sPQkNJjMVLegsyQ1qToO3sjK1w6iIdsfMgFIYb/X7as4CicO7a3PcdZFyspXjcBW+tY8O+JaPJ64+5Bbp+rDCmqeLaBDMJ0YH83tKN72caW1aKSmpWMPjthFHpNXEJqz9JmXN2kAfl+IOT7Rwv4q4/ll09ykweSYOojbQ8Rx4lZNiBZfk+AB3JkcdDgbMoiXka0EODv4MgCc5VVoEYN5QNXW0PclGsgQ81pjJMAGTWO2gUlwLRPmiDErCbmzbkGEswHIzPaS7mKW/c4tnUAYG6JbJAFOEht3+M6Lzgbzm3qU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44af844a-2946-4b54-506b-08d6a8ed3c93
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 02:23:39.5167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PiBJdCBmaXhlcyBub3QganVzdCB0aGlzIGlzc3VlLCBidXQgbm93IHRoZSB3aG9sZSB0ZXN0IHN1
aXRlIHBhc3NlcyB3aXRoDQo+IEdJVF9URVNUX0ZTTU9OSVRPUiwgaS5lLiB0aGlzIHRlc3QgdGhh
dCdzIGJlZW4gZmFpbGluZyBmb3IgfjIgeWVhcnMgYWxzbw0KPiB3b3JrcyBub3c6DQo+IGh0dHBz
Oi8vbmFtMDYuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUy
RiUyRnB1YmxpDQo+IGMtDQo+IGluYm94Lm9yZyUyRmdpdCUyRjg3azF2d245cWUuZnNmJTQwZXZs
ZWRyYWFyLmdtYWlsLmNvbSUyRiZhbXA7ZGF0YT0NCj4gMDIlN0MwMSU3Q0Jlbi5QZWFydCU0MG1p
Y3Jvc29mdC5jb20lN0M3NThmNjI3MmNiOTc0MTI5MWMwMjA4ZDZhOA0KPiBkNjUwYjQlN0M3MmY5
ODhiZjg2ZjE0MWFmOTFhYjJkN2NkMDExZGI0NyU3QzElN0MwJTdDNjM2ODgyMDM1Nw0KPiA2NzI5
MDM4MyZhbXA7c2RhdGE9SDRKN3hndUJKVnhhbk1mbjR5MEkwSHNYQk5ZY3JNUzlJcndIbjNhV3dP
DQo+IFUlM0QmYW1wO3Jlc2VydmVkPTANCj4gDQo+ID4+IEluIHRoZSBtZWFudGltZSBJIGRpZCBh
IGJ1aWxkIHdpdGggIm5leHQiIChzbyBzdGFzaC1pbi1DKSB1c2luZyB0aGUNCj4gPj4gc3RhbmRh
cmQgdGVzdCBtb2RlIGFuZCB0aGVzZToNCj4gPj4NCj4gPj4gICAgIChjZCB0ICYmIEdJVF9URVNU
X0dFVFRFWFRfUE9JU09OPXRydWUgL3Vzci9iaW4vcHJvdmUNCj4gJEJLTkdfR0lUX0hBUk5FU1Nf
T1BUSU9OUyB0WzAtOV0qLnNoKQ0KPiA+PiAgICAgKGNkIHQgJiYgR0lUX1RFU1RfRlNNT05JVE9S
PSRQV0QvdDc1MTkvZnNtb25pdG9yLWFsbA0KPiBHSVRfU0tJUF9URVNUUz0idDM0MDQuOCB0MzQy
MC4zNiIgL3Vzci9iaW4vcHJvdmUNCj4gJEJLTkdfR0lUX0hBUk5FU1NfT1BUSU9OUyB0WzAtOV0q
LnNoKQ0KPiA+PiAgICAgKGNkIHQgJiYgR0lUX1RFU1RfU1BMSVRfSU5ERVg9dHJ1ZSAvdXNyL2Jp
bi9wcm92ZQ0KPiAkQktOR19HSVRfSEFSTkVTU19PUFRJT05TIHRbMC05XSouc2gpDQo+ID4+ICAg
ICAoY2QgdCAmJiBHSVRfVEVTVF9GVUxMX0lOX1BBQ0tfQVJSQVk9dHJ1ZSBHSVRfVEVTVF9PRV9T
SVpFPTEwDQo+IC91c3IvYmluL3Byb3ZlICRCS05HX0dJVF9IQVJORVNTX09QVElPTlMgdFswLTld
Ki5zaCkNCj4gPj4gICAgIChjZCB0ICYmIEdJVF9URVNUX0NPTU1JVF9HUkFQSD10cnVlIC91c3Iv
YmluL3Byb3ZlDQo+ICRCS05HX0dJVF9IQVJORVNTX09QVElPTlMgdFswLTldKi5zaCkNCj4gPj4g
ICAgIChjZCB0ICYmIEdJVF9URVNUX01VTFRJX1BBQ0tfSU5ERVg9dHJ1ZSAvdXNyL2Jpbi9wcm92
ZQ0KPiAkQktOR19HSVRfSEFSTkVTU19PUFRJT05TIHRbMC05XSouc2gpDQo+ID4+ICAgICAoY2Qg
dCAmJiBHSVRfVEVTVF9TVEFTSF9VU0VfQlVJTFRJTj1mYWxzZSAvdXNyL2Jpbi9wcm92ZQ0KPiAk
QktOR19HSVRfSEFSTkVTU19PUFRJT05TIHRbMC05XSouc2gpDQo+ID4+ICAgICAoY2QgdCAmJiBH
SVRfVEVTVF9DSEVDS19DT0xMSVNJT05TPWZhbHNlIC91c3IvYmluL3Byb3ZlDQo+ID4+ICRCS05H
X0dJVF9IQVJORVNTX09QVElPTlMgdFswLTldKi5zaCkNCj4gPj4NCj4gPj4gT25seSB0aGlzIHNw
ZWNpZmljIHRlc3QgZmFpbGVkLg0KPiA+DQo+ID4gV2VsbCwgZ29vZCENCj4gPg0KPiA+IFRoYW5r
IHlvdSBmb3IgZ2V0dGluZyB0aGUgYmFsbCByb2xsaW5nIQ0KDQpBd2Vzb21lIGZpbmQgYW5kIGZp
eC4gIFRoYW5rcyBmb3IgY2hhc2luZyB0aGlzIGRvd24gYW5kIENDJ2luZyBtZSBzbyBJIGFtIGF3
YXJlLg0KDQo+ID4gRHNjaG8NCg==
