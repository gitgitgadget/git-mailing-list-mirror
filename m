Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	LOCALPART_IN_SUBJECT,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A7E211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 20:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbeLEUNX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 15:13:23 -0500
Received: from mail-eopbgr760055.outbound.protection.outlook.com ([40.107.76.55]:36813
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727257AbeLEUNX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 15:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1xoemAtxdnLi4CaXvgcxUNdv6Jb1FlwI0vB2EzG0sM=;
 b=0wdEvp/WJMHohhqp/iBeYptKJKAjIrQiyJxHx8r7prOUtFiJJWXvsMSpWYzdTMK/c63nG7CAjrrJJOjNqw7U7tVYD/yEi1B+bcBIr45dgFMFzx0wGIJGv9fbfCBiWuYfGd99Q7FxIxy31SZSO7W4DPaEM3v2ufxv7S6I0iSBeFI=
Received: from BLUPR12MB0609.namprd12.prod.outlook.com (10.163.217.158) by
 BLUPR12MB0482.namprd12.prod.outlook.com (10.162.92.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 20:13:16 +0000
Received: from BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc]) by BLUPR12MB0609.namprd12.prod.outlook.com
 ([fe80::44f5:c0e3:aa8d:cdc%2]) with mapi id 15.20.1404.019; Wed, 5 Dec 2018
 20:13:16 +0000
From:   "Coiner, John" <John.Coiner@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git, monorepos, and access control
Thread-Topic: git, monorepos, and access control
Thread-Index: AQHUjNb0pK4f3pgBSk2cNm8vgfXD3w==
Date:   Wed, 5 Dec 2018 20:13:16 +0000
Message-ID: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:404:10a::33) To BLUPR12MB0609.namprd12.prod.outlook.com
 (2a01:111:e400:594f::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Coiner@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.10.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR12MB0482;20:9ifZ975+Caw8+QHPOJGKSfSjpJTQpjjiami+eWFvmgl1YbW/SlgOdAN3N8EHNgouO0eFB43L875BY1kK/zqHm6FutfNz0Y1Dq+pxmfQsXOVUfJzf7nj5xLSTFQif4G7Rxr+/uJ+aQMGO5+BYWxDAxnNySz9DWruHFjMeE/lncTCsUW7TUP5Q3SSeHrwz3uHRzPuVi9R5yzPxeRZdrEklWLICF9MMiUlSZvshplN9lee8/siQJn1g3vv5AphXDRE+
x-ms-office365-filtering-correlation-id: 86c3ce1e-8083-4829-2708-08d65aee1739
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0482;
x-ms-traffictypediagnostic: BLUPR12MB0482:
x-microsoft-antispam-prvs: <BLUPR12MB048225963CE863611B4C5471ECA80@BLUPR12MB0482.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR12MB0482;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0482;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(366004)(346002)(376002)(189003)(199004)(53936002)(102836004)(6512007)(6486002)(386003)(99286004)(52116002)(81156014)(81166006)(5640700003)(26005)(186003)(6436002)(97736004)(1730700003)(8676002)(6506007)(14444005)(2906002)(66066001)(256004)(486006)(2616005)(476003)(3846002)(6116002)(68736007)(71200400001)(71190400001)(14454004)(5660300001)(7736002)(305945005)(31696002)(25786009)(36756003)(86362001)(2351001)(31686004)(6916009)(106356001)(105586002)(8936002)(2501003)(72206003)(478600001)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0482;H:BLUPR12MB0609.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: apAE4bLSi2OYQUlfCRDG99bbvcDVuuRwY1aoLwCTxddeIFlpogh6dUHSVHfuV6R2GA7ooAj8qSuM73UI3S6DIdXbDdhWR9XoIFuU7d9MrAWrK3Sp/hfeEpd/NDfxfJ8pd5rWE2V5x94crbr41a6l+hV8TC+SJbY5pYrH2Ubdwy0VtCuhhXAszojCJpIb5bI+TQ29QwWQp9G9oBxM0GYK+HUA0Bi7GPuoSlIOgfUt8V1mmJf9K/DtFoL8ggwWREbywGgD82FbhHNGgBdAZLtIb7yqq4TuGkt9FBkMAgOiN7vz4sja4YpzP9At+eaPJlXXnN+LGK/26YsQNCPrl8KPUs1EenQlWsMuj7K2/jeto9o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <67F1CBC46863F24B89508C08E8B9A9CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86c3ce1e-8083-4829-2708-08d65aee1739
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 20:13:16.2085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0482
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SGksDQoNCkknbSBhbiBlbmdpbmVlciB3aXRoIEFNRC4gSSdtIGxvb2tpbmcgYXQgd2hldGhlciB3
ZSBjb3VsZCBzd2l0Y2ggb3VyIA0KaW50ZXJuYWwgdmVyc2lvbiBjb250cm9sIHRvIGEgbW9ub3Jl
cG8sIHBvc3NpYmx5IG9uZSBiYXNlZCBvbiBnaXQgYW5kIA0KVkZTRm9yR2l0Lg0KDQpPbmUgb2Jz
dGFjbGUgdG8gbW92aW5nIEFNRCB0byBnaXQvVkZTRm9yR2l0IGlzIHRoZSBsYWNrIG9mIGFjY2Vz
cyANCmNvbnRyb2wgc3VwcG9ydCBpbiBnaXQuIEFNRCBoYXMgYSBsb3Qgb2YgZGF0YSB3aG9zZSBk
aXN0cmlidXRpb24gbXVzdCBiZSANCmxpbWl0ZWQuIFNvbWV0aW1lcyBpdCdzIGEgbGVnYWwgcmVx
dWlyZW1lbnQsIGVnLiBDUFUgY29yZSBkZXNpZ25zIGFyZSANCmNvdmVyZWQgYnkgVVMgZXhwb3J0
IGNvbnRyb2wgbGF3cyBhbmQgbm90IGFsbCBlbXBsb3llZXMgbWF5IHNlZSB0aGVtLiANClNvbWV0
aW1lcyBpdCdzIGEgY29udHJhY3R1YWwgb2JsaWdhdGlvbiwgYXMgd2hlbiBhIHRoaXJkIHBhcnR5
IHNoYXJlcyANCmRhdGEgd2l0aCB1cyBhbmQgd2UgYWdyZWUgb25seSB0byBzaGFyZSB0aGlzIGRh
dGEgd2l0aCBjZXJ0YWluIA0KZW1wbG95ZWVzLiBBbnkgaHlwb3RoZXRpY2FsIEFNRCBtb25vcmVw
byBzaG91bGQgYmUgYWJsZSB0byBzZWN1cmVseSBkZW55IA0KcmVhZCBhY2Nlc3MgaW4gY2VydGFp
biBzdWJ0cmVlcyB0byB1c2VycyB3aXRob3V0IHJlcXVpcmVkIHBlcm1pc3Npb25zLg0KDQpIYXMg
YW55b25lIGxvb2tlZCBhdCBhZGRpbmcgYWNjZXNzIGNvbnRyb2wgdG8gZ2l0LCBhdCBhIHBlci1k
aXJlY3RvcnkgDQpncmFudWxhcml0eT8gSXMgdGhpcyBhIGZlYXR1cmUgdGhhdCB0aGUgZ2l0IGNv
bW11bml0eSB3b3VsZCBwb3NzaWJseSANCndlbGNvbWU/DQoNCkhlcmUncyBteSByb3VnaCB0aGlu
a2luZyBhYm91dCBob3cgaXQgbWlnaHQgd29yazoNCiAgLSBhbiBhZG1pbmlzdHJhdG9yIGNhbiBk
ZXNpZ25hdGUgdGhhdCBhIHRyZWUgb2JqZWN0IHJlcXVpcmVzIHplcm8gb3IgDQptb3JlIG5hbWVk
IHByaXZpbGVnZXMgdG8gcmVhZA0KICAtIHdoZW4gYSBtb3J0YWwgdXNlciBhdHRlbXB0cyB0byBy
ZXRyaWV2ZSB0aGUgdHJlZSBvYmplY3QsIGEgaG9vayANCmFsbG93cyB0aGUgc2VydmVyIHRvIGNo
ZWNrIGlmIHRoZSB1c2VyIGhhcyBhIGdpdmVuIHByaXZpbGVnZS4gVGhlIGhvb2sgDQpjYW4gcXVl
cnkgYW4gYXJiaXRyYXJ5IHVzZXIvZ3JvdXAgZGF0YSBiYXNlLCBMREFQIG9yIHdoYXRldmVyLiBU
aGUgDQpkZXRhaWxzIG9mIHRoaXMgY2hlY2sgYXJlIG1vc3RseSBpbiB0aGUgaG9vazsgZ2l0IG9u
bHkga25vd3MgYWJvdXQgDQphYnN0cmFjdCBuYW1lZCBwcml2aWxlZ2VzLg0KICAtIGlmIHRoZSB1
c2VyIGhhcyBwZXJtaXNzaW9uLCBldmVyeXRoaW5nIGdvZXMgYXMgbm9ybWFsLg0KICAtIGlmIHRo
ZSB1c2VyIGxhY2tzIHBlcm1pc3Npb24sIHRoZXkgZ2V0IGEgRGVuaWVkVHJlZSBvYmplY3Qgd2hp
Y2ggDQptaWdodCBjYXJyeSBzb21lIG1ldGFkYXRhIGFib3V0IHdoYXQgcGVybWlzc2lvbnMgd291
bGQgYmUgbmVlZGVkIHRvIHNlZSANCm1vcmUuIFRoZSBEZW5pZWRUcmVlIGxhY2tzIHRoZSByZWFs
IHRyZWUncyBlbnRyaWVzLiAoVEJELCBob3cgZG8gd2UgDQpyZW5kZXIgYSBkZW5pZWQgdHJlZSBp
biB0aGUgd29ya3NwYWNlPyBBbiB1bi13cml0YWJsZSBkaXJlY3RvcnkgDQpjb250YWluaW5nIG9u
bHkgYSBHSVRERU5JRUQgZmlsZSB3aXRoIHNvbWUgdXNlciBmcmllbmRseSBlcnJvciBtZXNzYWdl
PykNCiAgLSBoYXNoZXMgYXJlIHNlY3JldC4gSWYgdGhlIGhhc2hlcyBmcm9tIGEgcHJvdGVjdGVk
IHRyZWUgbGVhaywgdGhlIA0KZGF0YSBhbHNvIGxlYWtzLiBObyBjaGVjayBvbiB0aGUgc2VydmVy
IHByZXZlbnRzIGl0IGZyb20gaGFuZGluZyBvdXQgDQpjb250ZW50cyBmb3IgY29ycmVjdGx5LWd1
ZXNzZWQgaGFzaGVzLg0KICAtIG1vcnRhbCB1c2VycyBzaG91bGRuJ3QgYmUgYWJsZSB0byBhbHRl
ciBwZXJtaXNzaW9ucy4gT2YgY291cnNlLCANCm1vcnRhbCB1c2VycyB3aWxsIG9mdGVuIG1vZGlm
eSB0cmVlIG9iamVjdHMgdGhhdCBjYXJyeSBwZXJtaXNzaW9ucy4gU28gDQp0aGUgc2VydmVyIHNo
b3VsZCBlbmZvcmNlIHRoYXQgYSB1c2VyIGlzbid0IHB1c2hpbmcgdXBkYXRlcyB0aGF0IGFsdGVy
IA0KcGVybWlzc2lvbnMgb24gdGhlIHNhbWUgbG9naWNhbCBkaXJlY3RvcnkuDQoNCkkgd291bGQg
d2VsY29tZSB5b3VyIGZlZWRiYWNrIG9uIHdoZXRoZXIgdGhpcyBpZGVhIG1ha2VzIHRlY2huaWNh
bCANCnNlbnNlLCBhbmQgd2hldGhlciB0aGUgZmVhdHVyZSBjb3VsZCBldmVyIGJlIGEgZml0IGZv
ciBnaXQuDQoNCllvdSBtaWdodCBhc2sgd2hhdCBhbHRlcm5hdGl2ZXMgd2UgYXJlIGxvb2tpbmcg
YXQuIEF0IG91ciBzY2FsZSwgd2UnZCANCnJlYWxseSB3YW50IGEgdmVyc2lvbiBjb250cm9sIHN5
c3RlbSB0aGF0IGltcGxlbWVudHMgYSB2aXJ0dWFsIA0KZmlsZXN5c3RlbS4gVGhhdCBhbHJlYWR5
IGxpbWl0cyB1cyB0byBDbGVhckNhc2UsIFZGU0ZvckdpdCwgYW5kIG1heWJlIA0KVmVzdGEgYW1v
bmcgcHVibGljIG9uZXMuICBBbSBJIG1pc3NpbmcgYW55PyBXZSB3b3VsZCBhbHNvIHdhbnQgb25l
IHRoYXQgDQpwZXJtaXRzIGJyYW5jaGluZyBlbm9ybW91cyBudW1iZXJzIG9mIGZpbGVzIHdpdGhv
dXQgY3JlYXRpbmcgZW5vcm1vdXMgDQphbW91bnRzIG9mIGRhdGEgaW4gdGhlIHJlcG8gLS0gZ2l0
IGdldHMgdGhhdCByaWdodCwgYW5kIHBlcmZvcmNlIChvdXIgDQpzdGF0dXMgcXVvKSBkb2VzIG5v
dC4gVGhhdCdzIGhvdyBJIGdvdCBvbnRvIHRoZSBpZGVhIG9mIGFkZGluZyByZWFkIA0KYXV0aG9y
aXphdGlvbiB0byBnaXQuDQoNClRoYW5rcywNCg0KSm9obg0KDQoNCg0K
