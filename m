Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4931720A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLLTFn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:05:43 -0500
Received: from mail-eopbgr750077.outbound.protection.outlook.com ([40.107.75.77]:34848
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726235AbeLLTFn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGkCBGJOdy2do1kkgyJ+59hWgkRKHmOOjbpQd6+z6Is=;
 b=z/Eht69iRWdjKKdhMZZZ+r8OMaJ703IdJB5m7p1ZtyxRtcrwAt1Yp4WIaDo7ErvmJYAD2Zaza4bZLtXnOxwysz78tUznWCPR2zjTbtFVOvR0OWch2nQc4U9pJUgZcZPc+3JPJNkgIYStmjx+1quTMl1FxzF7o10/+GUVUubnutk=
Received: from SN1PR12MB2384.namprd12.prod.outlook.com (52.132.194.153) by
 SN1PR12MB0192.namprd12.prod.outlook.com (10.162.3.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Wed, 12 Dec 2018 19:05:39 +0000
Received: from SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693]) by SN1PR12MB2384.namprd12.prod.outlook.com
 ([fe80::f9a6:2b87:1862:d693%2]) with mapi id 15.20.1425.016; Wed, 12 Dec 2018
 19:05:39 +0000
From:   "Iucha, Florin" <Florin.Iucha@amd.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: RE: High locking contention during repack?
Thread-Topic: High locking contention during repack?
Thread-Index: AQHUkcZ+f0+V0Wt6CUuFEjrDC9wzQqV69toAgABaC1CAABTh8IAABuDAgAAK5yA=
Date:   Wed, 12 Dec 2018 19:05:38 +0000
Message-ID: <SN1PR12MB23844F35A879EA185AD6B00B95A70@SN1PR12MB2384.namprd12.prod.outlook.com>
References: <SN1PR12MB23840AFE62E41D908A40D1B095A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <20181212112409.GB30673@sigill.intra.peff.net>
 <SN1PR12MB23849A5B991FB7D9213FB64595A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB2384362EE5BA4980322931B795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
 <SN1PR12MB2384587486B6D10F2784CEB795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
In-Reply-To: <SN1PR12MB2384587486B6D10F2784CEB795A70@SN1PR12MB2384.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Florin.Iucha@amd.com; 
x-originating-ip: [165.204.24.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR12MB0192;20:xMXn5jzb9kfsqogwznK86T2VGm4I2a+NjuQ7VT27xeib9GAiVEcIUD7CQoGZFxGiu+ZyCMXFkjTi0fa4kGQbtZFW0jzN6SXaz/X/PqqY+G7GtSCr77K836qjdUrEkwYc3ZUf+xni7MOzcVkEIYSbiLWFxe4uIbjKTNo/ENieRKhMxX/sJX5dvVNeLeLoR8bGgp1ubz36BktnTwzkGkbBlMoFvt0Quxcs8P9YSPV2BHJInb6+FqK3Xhyf1qQLY5fm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8c0c718d-c747-4f71-1c1b-08d66064ce21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0192;
x-ms-traffictypediagnostic: SN1PR12MB0192:
x-microsoft-antispam-prvs: <SN1PR12MB019220D2B3DA20A7C452706095A70@SN1PR12MB0192.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN1PR12MB0192;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0192;
x-forefront-prvs: 0884AAA693
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(68736007)(6246003)(26005)(5640700003)(102836004)(55016002)(7696005)(9686003)(53936002)(256004)(6506007)(76176011)(93156006)(71190400001)(6116002)(71200400001)(3846002)(5660300001)(4326008)(2906002)(478600001)(39060400002)(25786009)(33656002)(105586002)(106356001)(86362001)(2351001)(72206003)(558084003)(14454004)(486006)(11346002)(305945005)(74316002)(99286004)(7736002)(476003)(446003)(81156014)(2940100002)(8676002)(8936002)(81166006)(1730700003)(186003)(66066001)(229853002)(6916009)(97736004)(2501003)(6436002)(54906003)(316002)(93886005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0192;H:SN1PR12MB2384.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VVR95kifMcbNUgON57sTrqpOHxxaZuCObGDKK1u8+GlKTsc19Sd1NhYW4nbqn06OmBJql3LMpew61IQPzZdAFClz0iCMQF0HrSWHzUAshUVd07S+95EOn+YeI+DeqQzICDGt6xLJU3a01NtVYcEkDBLabaxr/HiizTp8wjDtJfWec7tWWFlFN60HIzUVQ1P13v22DDteWHmNd9hzd3exIJIB1qgzIiw6MUsdWUAOCgmgZEBs+hI4FlwhByO6adEqyDX6X8dFFbmJJ+s4u8vdahb9DszopRqPIl8YsTyVHXsCw333UJaggjLZ09HbOUwn
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0c718d-c747-4f71-1c1b-08d66064ce21
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2018 19:05:38.9838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0192
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SXMgdGhlcmUgYW4gZWFzeSB3YXkgdG8gZmlndXJlIG91dCB3aGF0IG9iamVjdCB3ZSdyZSBwcm9j
ZXNzaW5nIGluIGNyZWF0ZV9kZWx0YT8gSSBoYXZlIGZpbHRlcmVkIG91dCBzb21lIGxhcmdlIGRh
dGEgZmlsZXMgaW4gLmdpdGF0dHJpYnV0ZXMgYWxyZWFkeS4NCg0KZmxvcmluDQo=
