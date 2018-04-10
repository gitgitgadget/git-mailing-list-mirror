Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56D061F404
	for <e@80x24.org>; Tue, 10 Apr 2018 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDJVEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 17:04:31 -0400
Received: from mail-sn1nam01on0128.outbound.protection.outlook.com ([104.47.32.128]:58880
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752238AbeDJVE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 17:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kbubiYND6g2iKvg2BTg9vAHywmZdRssZSfSIR0tN2r8=;
 b=SvkJ8VmwAMo8Uc034pz2V4xGZwoS5bK4W81G3QxJccZEwsXeZfMTJbwtjEPTVpN291L2NLaoDhoTF8xVEfg7WcZ1dm42v4vmyBSQQoLsKGAs5tJlTm5D9HXZ15rSY7N9IPhXEqM0Gg256L1oGs+541lsJYvKLLvnTrCLQBAMzsU=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0982.namprd21.prod.outlook.com (52.132.133.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.696.0; Tue, 10 Apr 2018 21:04:23 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0696.003; Tue, 10 Apr 2018
 21:04:23 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "pclouds@gmail.com" <pclouds@gmail.com>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "blees@dcon.de" <blees@dcon.de>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Topic: [PATCH v1 0/2] fsexcludes: Add programmatic way to exclude files
Thread-Index: AQHT0Q+AP0wkUQvwVEOsm0Go/19PYg==
Date:   Tue, 10 Apr 2018 21:04:23 +0000
Message-ID: <20180410210408.13788-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.16.2.windows.1
x-clientproxiedby: BN3PR03CA0082.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::42) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0982;7:ycbXNP7K7nWGWrPdQ5zsM7zH2G+STvol+W2/DRsEQYmrnNPVE7zPdbCnoawCqf3SF2U/wJ6z3xOwiDYflRlNYyNLuOJ2/K7/aPNXs3EfQjkCtsk6R/uyGr34PishSFnRUOyVyX2uuT/gnaMMOhmLYZkdix/HyxfKUkHrcSDjG/8/aq64ybGTqnI/y1AZXIIiqIcl995iAUA6mvvHZdoUSczz7GqujvPdzOJ+Sb5wqf/3iSJs5p3k+yg1MV2mKuoH;20:wG4DSIlvaZvDQFt788DOr1eRJ0IyFzIWGv36rLenB/RpiPo47xXMm2lyTde7FDOUcS+BSFhP2fhm6YTlQDW6Ra5XC6xWCRwzuBzT+qe52RmdE3Bkob4S/K4P//HW+ahWdK9Excu+c7M/UciK8q81VwYFYXu9sYam0vdEwkBHxBc=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(3008032)(2017052603328)(7193020);SRVR:DM5PR2101MB0982;
x-ms-traffictypediagnostic: DM5PR2101MB0982:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0982CCDD946881697049527BF4BE0@DM5PR2101MB0982.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(15185016700835);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0982;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0982;
x-forefront-prvs: 0638FD5066
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(81166006)(8936002)(105586002)(106356001)(59450400001)(81156014)(8676002)(1076002)(1730700003)(99286004)(3280700002)(8656006)(52116002)(2906002)(50226002)(86612001)(2501003)(6916009)(5250100002)(6116002)(107886003)(3846002)(97736004)(54906003)(26005)(5660300001)(22452003)(316002)(39060400002)(4326008)(186003)(966005)(68736007)(66066001)(102836004)(6506007)(386003)(478600001)(486006)(476003)(72206003)(25786009)(10290500003)(8666007)(6306002)(3660700001)(6512007)(2351001)(6436002)(10090500001)(5640700003)(53936002)(2616005)(36756003)(575784001)(2900100001)(14454004)(305945005)(6486002)(7736002)(22906009)(43043002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0982;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: oCoNqrjvVGSKHzoq3GkBA53qvOk+L5u+AfdD3KSYwYuQNjisZcWvFcvkS3O/K8qWNWIIMn1bhNAqjSR0NPc5gCrBAHhJH27C9oL8HZUxv3SMPrnfSvqkU2vXeziNp9ITM9N2ccoRmlIGTxLjVvhm5gfedJLdC4Pqo5MusrzdsvMkAyrFsHuIj01YCHLwFObmJ0Qskn/Cur46Z0OMTs9v90erEvVICzsaXq/3clmM7lReWpqcZKkWIC8/Osioa8kvLc+EdUMIsZ+LlDpKSI49Yg/tF/PYDs3ZBgKx/Fm5UabniRzDscTHSNTN4kELk6oyh0j+AuwcwC1QHYqRhLFO90OQJlRM2oRrLaS5t3l5woeEIepoiezNzJG6j0WK7yfNhsLW2Tap++ATOzj0P0nMkDP9Y+qkXUE5w9VE2L5bngI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <95E030758D4E134491EDC7D4D6E5D65B@namprd21.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c5e53580-1f1f-47e5-1b5a-08d59f26a279
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5e53580-1f1f-47e5-1b5a-08d59f26a279
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2018 21:04:23.3097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0982
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SW4gZ2l0IHJlcG9zIHdpdGggbGFyZ2Ugd29ya2luZyBkaXJlY3RvcmllcyBhbiBleHRlcm5hbCBm
aWxlIHN5c3RlbSBtb25pdG9yDQoobGlrZSBmc21vbml0b3Igb3IgZ3ZmcykgY2FuIHRyYWNrIHdo
YXQgZmlsZXMgaW4gdGhlIHdvcmtpbmcgZGlyZWN0b3J5IGhhdmUgYmVlbg0KbW9kaWZpZWQuICBU
aGlzIGluZm9ybWF0aW9uIGNhbiBiZSB1c2VkIHRvIHNwZWVkIHVwIGdpdCBvcGVyYXRpb25zIHRo
YXQgc2NhbGUNCmJhc2VkIG9uIHRoZSBzaXplIG9mIHRoZSB3b3JraW5nIGRpcmVjdG9yeSBzbyB0
aGF0IHRoZXkgYmVjb21lIE8oIyBvZiBtb2RpZmllZA0KZmlsZXMpIHZzIE8oIyBvZiBmaWxlcyBp
biB0aGUgd29ya2luZyBkaXJlY3RvcnkpLg0KDQpUaGUgZnNtb25pdG9yIHBhdGNoIHNlcmllcyBh
ZGRlZCBsb2dpYyB0byBsaW1pdCB3aGF0IGZpbGVzIGdpdCBoYWQgdG8gc3RhdCgpIHRvDQp0aGUg
c2V0IG9mIG1vZGlmaWVkIGZpbGVzIHByb3ZpZGVkIGJ5IHRoZSBmc21vbml0b3IgaG9vayBwcm9j
LiAgSXQgYWxzbyB1c2VkIHRoZQ0KdW50cmFja2VkIGNhY2hlIChpZiBlbmFibGVkKSB0byBsaW1p
dCB0aGUgZmlsZXMvZm9sZGVycyBnaXQgaGFkIHRvIHNjYW4gbG9va2luZw0KZm9yIG5ldy91bnRy
YWNrZWQgZmlsZXMuICBHVkZTIGlzIGFub3RoZXIgZXh0ZXJuYWwgZmlsZSBzeXN0ZW0gbW9kZWwg
dGhhdCBhbHNvDQpzcGVlZHMgdXAgZ2l0IHdvcmtpbmcgZGlyZWN0b3J5IGJhc2VkIG9wZXJhdGlv
bnMgdGhhdCBoYXMgYmVlbiB1c2luZyBhIGRpZmZlcmVudA0KbWVjaGFuaXNtIChwcm9ncmFtbWF0
aWNhbGx5IGdlbmVyYXRpbmcgYW4gZXhjbHVkZXMgZmlsZSkgdG8gZW5hYmxlIGdpdCB0byBiZQ0K
TygjIG9mIG1vZGlmaWVkIGZpbGVzKS4NCg0KVGhpcyBwYXRjaCBzZXJpZXMgd2lsbCBpbnRyb2R1
Y2UgYSBuZXcgd2F5IHRvIGxpbWl0IGdpdO+/vXMgdHJhdmVyc2FsIG9mIHRoZQ0Kd29ya2luZyBk
aXJlY3RvcnkgdGhhdCBkb2VzIG5vdCByZXF1aXJlIHRoZSB1bnRyYWNrZWQgY2FjaGUgKGZzbW9u
aXRvcikgb3IgdXNpbmcNCnRoZSBleGNsdWRlcyBmZWF0dXJlIChHVkZTKS4gIEl0IGRvZXMgdGhp
cyBieSBlbmhhbmNpbmcgdGhlIGV4aXN0aW5nIGV4Y2x1ZGVzDQpsb2dpYyBpbiBkaXIuYyB0byBz
dXBwb3J0IGEgbmV3IO+/vUZpbGUgU3lzdGVtIEV4Y2x1ZGVz77+9IG9yIGZzZXhjbHVkZXMgQVBJ
IHRoYXQgaXMNCmJldHRlciB0dW5lZCB0byB0aGVzZSBwcm9ncmFtbWF0aWMgYXBwbGljYXRpb25z
Lg0KDQpCYXNlIFJlZjogbWFzdGVyDQpXZWItRGlmZjogaHR0cHM6Ly9naXRodWIuY29tL2JlbnBl
YXJ0L2dpdC9jb21taXQvMmNjYmNkNjM2MA0KQ2hlY2tvdXQ6IGdpdCBmZXRjaCBodHRwczovL2dp
dGh1Yi5jb20vYmVucGVhcnQvZ2l0IGZzZXhjbHVkZXMtdjEgJiYgZ2l0IGNoZWNrb3V0IDJjY2Jj
ZDYzNjANCg0KQmVuIFBlYXJ0ICgyKToNCiAgZnNleGNsdWRlczogYWRkIGEgcHJvZ3JhbW1hdGlj
IHdheSB0byBleGNsdWRlIGZpbGVzIGZyb20gZ2l0J3Mgd29ya2luZw0KICAgIGRpcmVjdG9yeSB0
cmF2ZXJzYWwgbG9naWMNCiAgZnNtb25pdG9yOiBzd2l0Y2ggdG8gdXNlIG5ldyBmc2V4Y2x1ZGVz
IGxvZ2ljIGFuZCByZW1vdmUgdW51c2VkDQogICAgdW50cmFja2VkIGNhY2hlIGJhc2VkIGxvZ2lj
DQoNCiBNYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRpci5jICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzMyArKysrLS0NCiBkaXIuaCAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDIgLQ0KIGZzZXhjbHVkZXMuYyAgICAgICAgICAgICAgICB8IDIxMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCiBmc2V4Y2x1ZGVzLmggICAgICAgICAgICAgICAgfCAg
MjcgKysrKysNCiBmc21vbml0b3IuYyAgICAgICAgICAgICAgICAgfCAgMjEgKy0tLQ0KIGZzbW9u
aXRvci5oICAgICAgICAgICAgICAgICB8ICAxMCArLQ0KIHQvdDc1MTktc3RhdHVzLWZzbW9uaXRv
ci5zaCB8ICAxNCArLS0NCiA4IGZpbGVzIGNoYW5nZWQsIDI3MCBpbnNlcnRpb25zKCspLCA0OCBk
ZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZnNleGNsdWRlcy5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGZzZXhjbHVkZXMuaA0KDQoNCmJhc2UtY29tbWl0OiAwYjBjYzlmODY3MzFmODk0
Y2ZmOGRkMjUyOTlhOWIzOGMyNTQ1NjllDQotLSANCjIuMTcuMC53aW5kb3dzLjENCg0KDQo=
