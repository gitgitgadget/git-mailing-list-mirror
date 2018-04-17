Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 349641F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753084AbeDQQAS (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 12:00:18 -0400
Received: from mail-sn1nam01on0124.outbound.protection.outlook.com ([104.47.32.124]:18720
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753058AbeDQQAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 12:00:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=qqS1qecFnhyjczlZyo7tB9T86JbEIAbxCQu/74KZ0SQ=;
 b=zE9VblpX22OJ5WnajWTTJAGQhfbnAZTNH0eGm48C4qZtbbbok7fR4Gu/6fcTQYtA8iRyhlf4Ye7B1f9fxnNd3KUqjk8cvi68GSEwfDZBKM+CLJ0iRsyED8pCuXHGH7vk5jhOxVJpzCbjROxW8u02zwsnX/t10wwwpbQVBcs7ncI=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB4327.namprd08.prod.outlook.com (52.135.205.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.675.11; Tue, 17 Apr 2018 16:00:12 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::496c:14e1:20ef:ca62%13]) with mapi id 15.20.0675.015; Tue, 17 Apr
 2018 16:00:12 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Thandesha VK <thanvk@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize'
 key
Thread-Topic: [BUG] git p4 clone fails when p4 sizes does not return
 'fileSize' key
Thread-Index: AQHT1du7X51QcloYSUG+Lp9Mls7MJ6QFHToC
Date:   Tue, 17 Apr 2018 16:00:12 +0000
Message-ID: <BYAPR08MB3845A1B2FF344CCA8D14A2F7DAB70@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
In-Reply-To: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4327;7:hOfrOUYaew5wVyaWBjYqq96GDNMPqOqrAUIO1meQm0wdkES2F2JczrmIOyDVhHwvkDvWxI1VvaXLsRWa3BvHZTKHGYa1Xn3AaGV6L876efuK8jCU1apX9lovnDKwlOmjvcEHC0jrHqAmpNYu7A7DmTuJDBlwyk8Hny0855sI4yCviwew+iwEORPHJhiVGYp5TXtUzNTa5BSS/9sVNvTL6ptCGvVpz6ikled3aPZOYoEwElrIOpzUS/qEVCOj80Xs
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4327;
x-ms-traffictypediagnostic: BYAPR08MB4327:
x-microsoft-antispam-prvs: <BYAPR08MB43273CC9692890BD4676254BDAB70@BYAPR08MB4327.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231232)(944501327)(52105095)(10201501046)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BYAPR08MB4327;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4327;
x-forefront-prvs: 0645BEB7AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(39860400002)(366004)(396003)(346002)(199004)(189003)(7696005)(446003)(74316002)(11346002)(99286004)(2906002)(3280700002)(5250100002)(97736004)(8936002)(486006)(476003)(26005)(102836004)(186003)(6506007)(76176011)(229853002)(7736002)(66066001)(3660700001)(86362001)(6436002)(9686003)(110136005)(55016002)(33656002)(3846002)(53936002)(14454004)(6246003)(2900100001)(106356001)(68736007)(8676002)(25786009)(305945005)(316002)(81156014)(6116002)(478600001)(81166006)(105586002)(5660300001)(39060400002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4327;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +3WKxIKy54RQAbNzuTuG0jWYtTSYIi0RWSd98pOHyY2gQu/cGjA4m4YvFQaHhfDTr6vHwXLm+02g3GsU8AavXK0yAYS5XsKg6e69ZxCAFVP4YJ0Dt88wJLhO4umG3FvSRH89ynXTz6KInNAow9YeT61qqZZZvYNsQNIwXNWSMujJKwlL98g1tQC1UJMEg7N4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d9da871a-ecaa-48d2-68ca-08d5a47c4d7f
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9da871a-ecaa-48d2-68ca-08d5a47c4d7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2018 16:00:12.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4327
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Huh, I actually have a slightly different fix for the same issue.
It doesn't suppress the corresponding verbose output completely, but just r=
emoves the size information from it.
I'll (try to) post it as a reply to this email.

Also, I'd mention that the workaround is trivial -- simply omit the "--verb=
ose" option.

Thank you,
Andrey=
