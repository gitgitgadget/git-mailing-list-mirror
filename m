Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326811F453
	for <e@80x24.org>; Fri, 26 Apr 2019 18:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfDZS5A (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 14:57:00 -0400
Received: from mail-eopbgr810078.outbound.protection.outlook.com ([40.107.81.78]:6588
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfDZS47 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 14:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=extremenetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTOw2j0QHeHstCrf2mVAyeGKGQMXfREbmrh/30Evfhs=;
 b=IXDapiHAkXEkUXjcgEt2/2uoyPI2UpdivsI277l2ypv3muqMru86K2Qa2/q56QefehQujcFlRBFbRx4YK60MOSEZw11ZDcPq7Ztf3Cb2TDzoTrV1rAc06etYJa7VBXmgo3+4XT1fkJTIWP/y1FI/xfj7kZYtqO3jUfzWkvFfZxw=
Received: from BN6PR04MB0962.namprd04.prod.outlook.com (10.174.95.26) by
 BN6PR04MB0884.namprd04.prod.outlook.com (10.174.232.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.17; Fri, 26 Apr 2019 18:56:56 +0000
Received: from BN6PR04MB0962.namprd04.prod.outlook.com
 ([fe80::2962:7e84:d6d2:678d]) by BN6PR04MB0962.namprd04.prod.outlook.com
 ([fe80::2962:7e84:d6d2:678d%5]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 18:56:56 +0000
From:   David Carson <DCarson@extremenetworks.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: add 'ls-remote' option to limit output records
Thread-Topic: add 'ls-remote' option to limit output records
Thread-Index: AQHU/GHRGljkv88MzkyC7TSUbc2L9w==
Date:   Fri, 26 Apr 2019 18:56:55 +0000
Message-ID: <560CCADB-511B-495E-B86B-F294486C088C@contoso.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.17.1.190326
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=DCarson@extremenetworks.com; 
x-originating-ip: [12.38.14.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8400342c-fc8d-441d-8cb5-08d6ca78f42f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BN6PR04MB0884;
x-ms-traffictypediagnostic: BN6PR04MB0884:
x-microsoft-antispam-prvs: <BN6PR04MB0884DD02B936B4FF8060A1D2A83E0@BN6PR04MB0884.namprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(366004)(39860400002)(199004)(189003)(26005)(5660300002)(66066001)(6506007)(1730700003)(81156014)(68736007)(8936002)(305945005)(81166006)(86362001)(186003)(102836004)(6436002)(8676002)(6486002)(99286004)(316002)(58126008)(7736002)(486006)(5640700003)(256004)(36756003)(82746002)(66476007)(66556008)(4744005)(66946007)(72206003)(66446008)(71200400001)(76116006)(83716004)(64756008)(476003)(71190400001)(2351001)(6916009)(97736004)(53936002)(2906002)(478600001)(2501003)(14454004)(33656002)(80792005)(25786009)(3846002)(6512007)(9686003)(6116002)(73956011);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR04MB0884;H:BN6PR04MB0962.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: extremenetworks.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Lqhw0BGuUL3BCqF1q/e92mPvatiXTmH0nBkUNhW5B2f4yzGYJDyhynP02UGOoUfo9hy9J40cEl5V7H4tjYZofD4sznSBG+9ZxXLNJgqv4FP3I6z4XckVN3s2RFISyjnWWmtZwkj3/x5326rnUceiZq6mZGtlWxDy8ZGshy9eaVB0Fm4htg6+JYocX2kzgTfESXLup1EXzIPBmBi3mlK4dZ14uH2i92FTSasPcbXa7WrLOhv8Lp/XBPX5y8L7qLay6UqmlkEVEhzozWZixycAuhbxLvPrrfvYoPQyZP1hpNtuUmxyfFcCeNMhUn3d8mwUrGjPtsZHDg1U87lc4hjQEC50BIAgx4tbhASL/nKn4INHXZXp5eFQFTi/wLtcHVGPiLp1Miav5WGVq7TYeyN2EuINW2KKe1ET24hltUya9g0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE1CD9FE94CC4841A6C8F597F859CDE0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: extremenetworks.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8400342c-fc8d-441d-8cb5-08d6ca78f42f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 18:56:56.0096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fc8c2bf6-914d-4c1f-b352-46a9adb87030
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0884
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: BN6PR04MB0962.namprd04.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-TransportTrafficSubType: 
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC: 
X-MS-Exchange-CrossPremises-originalclientipaddress: 12.38.14.10
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-transporttrafficsubtype: 
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: BN6PR04MB0884.namprd04.prod.outlook.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

R2l2ZW4gdGhhdCAnbHMtcmVtb3RlJyBjYW4gYmUgc29ydGVkLCBpdCB3b3VsZCBiZSB1c2VmdWwg
dG8gYmUgYWJsZSB0byBhc2sgZm9yIGEgc3Vic2V0IG9mIHRoZSB0b3RhbCBudW1iZXIgb2YgcmVz
dWx0IHJlY29yZHMuDQoNCkZvciBleGFtcGxlLCBpZiBJIHdhbnQgdG8gcmV0cmlldmUgb25seSB0
aGUgdGFnIHdpdGggdGhlIGhpZ2hlc3QgdmVyc2lvbiwgSSB3b3VsZCBkbyBzbyBieSBhZGRpbmcg
dGhpcyBuZXcgb3B0aW9uICgtbjEgaW4gbXkgZXhhbXBsZSk6DQoNCgkkIGdpdCBscy1yZW1vdGUg
LW4xIC0tdGFncyAtLXNvcnQ9djpyZWZuYW1lIG9yaWdpbiAidioiDQoNClRoYXQgd291bGQgc2F2
ZSBmcm9tIGhhdmluZyB0byByZWNlaXZlIGEgbGFyZ2UgbGlzdCBvZiB0YWdzIGZyb20gdGhlIHJl
bW90ZSwgb25seSBvbmUgb2Ygd2hpY2ggSSBjYXJlIGFib3V0Lg0KDQp+RGF2aWQNCg0KDQo=
