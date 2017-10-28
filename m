Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846432055E
	for <e@80x24.org>; Sat, 28 Oct 2017 20:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbdJ1Umc (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 16:42:32 -0400
Received: from mcgraw.st-andrews.ac.uk ([138.251.8.95]:35379 "EHLO
        mcgraw.st-andrews.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdJ1UlI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 16:41:08 -0400
X-Greylist: delayed 13135 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Oct 2017 16:41:07 EDT
X-StAndrews-MailScanner-From: caj21@st-andrews.ac.uk
X-StAndrews-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-1.891, required 5, autolearn=not spam, BAYES_00 -1.90,
        RP_MATCHES_RCVD -0.00, T_DKIM_INVALID 0.01)
X-StAndrews-MailScanner: No virus detected
X-StAndrews-MailScanner-ID: v9SH23OE009289
X-StAndrews-MailScanner-Information: Please contact the ISP for more information
Received: from unimail.st-andrews.ac.uk (exch13-srv01.st-andrews.ac.uk [138.251.8.22])
        by mcgraw.st-andrews.ac.uk (8.14.9/8.14.9/Debian-4~bpo0+uos) with ESMTP id v9SH23OE009289
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 17:02:04 GMT
Received: from exch13-srv02.st-andrews.ac.uk (138.251.8.23) by
 exch13-srv01.st-andrews.ac.uk (138.251.8.22) with Microsoft SMTP Server (TLS)
 id 15.0.1210.3; Sat, 28 Oct 2017 18:02:03 +0100
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (213.199.154.240)
 by exch13-srv02.st-andrews.ac.uk (138.251.8.23) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3 via Frontend Transport; Sat, 28 Oct 2017 18:02:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=UniversityofStAndrews907.onmicrosoft.com; s=selector1-standrews-ac-uk0e;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EkOWSp7YgTqgzEBoDhHORiqRp5wYPLx9uHNY0//hyTg=;
 b=EF3PLGWVepAQOw/1zBH08yqa8Ko8uEEazwo7N0QQgdpBdU8fQzD9J9KZ3zVF294vS/BhyP+JgO6FA0h9w+P0OekZSQ7dtBMjN0QKmdzrjxbP+cKZHTQBQxAGB5X6HScTgJx7MnqqKE21iJYwmrli7n9wfykYYbpm65Kb+Q8JHUg=
Received: from DB6PR0602MB2870.eurprd06.prod.outlook.com (10.172.249.15) by
 DB6PR0602MB2870.eurprd06.prod.outlook.com (10.172.249.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.178.6; Sat, 28 Oct 2017 17:02:02 +0000
Received: from DB6PR0602MB2870.eurprd06.prod.outlook.com
 ([fe80::4ff:96cb:1880:a992]) by DB6PR0602MB2870.eurprd06.prod.outlook.com
 ([fe80::4ff:96cb:1880:a992%17]) with mapi id 15.20.0178.007; Sat, 28 Oct 2017
 17:02:02 +0000
From:   Christopher Jefferson <caj21@st-andrews.ac.uk>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git rm VERY slow for directories with many files.
Thread-Topic: git rm VERY slow for directories with many files.
Thread-Index: AQHTUA55y5sY19EcTUu8Rkk3YE52cA==
Date:   Sat, 28 Oct 2017 17:02:02 +0000
Message-ID: <BEEA4A16-5433-4E6C-A7D7-956C85F27DF3@st-andrews.ac.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=caj21@st-andrews.ac.uk; 
x-originating-ip: [2.126.28.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0602MB2870;6:168hp70NA5+8/auvwtT5t1mz5us8KYiWzH2SHZXha3TmVT60bQnFlUub/93aoHCcjI3lxVxfuNsvznOVPhptMYPdzQfOl4f8tw1wb2efZAky0U3rDTLh5eVCZtC/EtWe7S3oIblGs9UTRVLb74wvQw3V146y/BNYef1jw3FkmD45vlbtHLOQhUPwUiDe2/6PGCnoBz34EKVU/vFsXjm6ho0mA8y1nlK4Bk/F5pmI36LZ519yrCRFHnztOBS96T3czKPr+BwU3Mbbc4LQdXTPnpmkMVkRMVUS1dQa4ouDCUBo0S5r7KacqeZDN7sVc60V7GIhxKj2ri6zzpGfXinslb4Si10AmEC1wWjeUpsDgd0=;5:JSD5/OyL6FaJccPWvG1mH9qrEjlFqFqRyYOIq+rKjMn7NEyg85jyuZu6/SZrfDXhxQcuPsf+wzyuTZoVpz8Q3jd3Eu3EFskRtHMjzeEIxGy92/GQU3LDvkujMIIb/RL3ZthcG7vG0z8W92swXijwrBa+nx8wYhSqgahFeWe+riw=;24:CLoi97UsP9gXYrdcU6mNxuLNuxg4HPPzepkn4DHgijIL2ilGt4NU4wm7VnixenCiffPi44e5DbbFL47h3EBwptFdBBdXL7FS/+4JwHmtGzk=;7:dX63h1lG1RN6C/KqzH0fKObNQ5c+mLrDLVFqZGbHl5dOmWq1jsuXdrcDBqLQt//jK3QfwFRKNKQzrphprQ0LYS8XprYiZ2LXdW4qTfegKuswCgbnwzdNq9dIvT35u34UHa0JG6ADChiav8PxDnzfhoGExexJ+7n7IuLXvUM9iOSi1iHfp03X6Pv0VHPSdx1RSbI7P6OktxXKb1XfmgoY/KW2NMMWdKMCJSmPLCa6x/uzoDNUVjxD1iFX55kNKH96
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 8f058440-5059-455b-7288-08d51e259c25
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(2017052603199);SRVR:DB6PR0602MB2870;
x-ms-traffictypediagnostic: DB6PR0602MB2870:
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <DB6PR0602MB2870BB2C00CD1E9B1DA6E3EDDF5B0@DB6PR0602MB2870.eurprd06.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(100000703101)(100105400095)(10201501046)(3231020)(3002001)(6041248)(20161123555025)(20161123560025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281529075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:DB6PR0602MB2870;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:DB6PR0602MB2870;
x-forefront-prvs: 04740D25F1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(346002)(199003)(189002)(478600001)(36756003)(97736004)(2501003)(1730700003)(2351001)(105586002)(5250100002)(33656002)(106356001)(189998001)(8936002)(5640700003)(54356999)(86362001)(50986999)(25786009)(6512007)(786003)(6506006)(6116002)(3280700002)(6436002)(3660700001)(3846002)(99286003)(2906002)(102836003)(101416001)(68736007)(2900100001)(316002)(83716003)(8676002)(81166006)(81156014)(6916009)(42882006)(74482002)(6486002)(305945005)(5660300001)(53936002)(14454004)(82746002)(7736002)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0602MB2870;H:DB6PR0602MB2870.eurprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: st-andrews.ac.uk does not
 designate permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <0689E515CCEF6F4D88D4F28172F7E4FB@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f058440-5059-455b-7288-08d51e259c25
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2017 17:02:02.3866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f85626cb-0da8-49d3-aa58-64ef678ef01a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0602MB2870
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SSBzdHVwaWRseSBhZGRlZCBhIGRpcmVjdG9yeSB3aXRoIG1hbnkgZmlsZXMgKCB+NDUwLDAwMCAp
IHRvIGdpdCwgYW5kIHdhbnQgdG8gZGVsZXRlIHRoZW0g4oCUIGxhdGVyIEkgcGxhbiB0byByZWJh
c2Uvc3F1YXNoIHZhcmlvdXMgY29tbWl0cyB0byByZW1vdmUgdGhlIGZpbGVzIGZyb20gdGhlIGhp
c3RvcnkgYWx0b2dldGhlci4NCg0KSG93ZXZlciwg4oCYZ2l0IHJt4oCZIGlzIFZFUlkgc2xvdy4g
Rm9yIGV4YW1wbGUsIGluIGEgZGlyZWN0b3J5IHdpdGggMTAsMDAwIGZpbGVzIChvbiBhIE1hYyks
IGdpdCB2Mi4xNC4yDQoNCkdpdCBhZGQgLiA6IDUuOTUgc2Vjcw0KR2l0IGNvbW1pdCA6IDEuMjkg
c2Vjcw0KR2l0IHJtIC1yIDogMjIgc2Vjcw0KDQo1MCwwMDAgZmlsZXMNCg0KR2l0IGFkZCAuIDog
MjUgc2Vjcw0KR2l0IGNvbW1pdCA6IDExIHNlY3MNCkdpdCBybSA6IEFmdGVyIDIwIG1pbnV0ZXMs
IEkga2lsbGVkIGl0Lg0KDQpMb29raW5nIGF0IGFuIG9wdGltaXplZCBwcm9maWxlLCBhbGwgdGhl
IHRpbWUgc2VlbXMgdG8gYmUgc3BlbnQgaW4g4oCcZ2V0X3RyZWVfZW50cnnigJ0g4oCUIEkgYXNz
dW1lIHRoZXJlIGlzIHNvbWUgaHVnZSBvYmplY3QgcmVwcmVzZW50aW5nIHRoZSBkaXJlY3Rvcnkg
d2hpY2ggaXMgYmVpbmcgcmUtZXhwYW5kZWQgZm9yIGVhY2ggZmlsZT8NCg0KSXMgdGhlcmUgYW55
IHdheSBJIGNhbiBzcGVlZCB1cCByZW1vdmluZyB0aGlzIGRpcmVjdG9yeT8NCg0KQ2hyaXM=
