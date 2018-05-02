Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1EE21847
	for <e@80x24.org>; Wed,  2 May 2018 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbeEBQBP (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 12:01:15 -0400
Received: from mail-dm3nam03on0114.outbound.protection.outlook.com ([104.47.41.114]:36299
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbeEBQBO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 12:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UtTj5BHWSZcvcgM2EryaMDc5Xm30wVtDsyUyoQ0X/hU=;
 b=CioQ/Fbu5Ad8kO1DP3jLdJH4jv5mHbJ7saeNHBaHGuROv6JsQWLmPJD7r2dEEOvlf4u8yLkIutZTMK3Fd8vcQKflc8EnsX8+7ArM6zSpKY6x00VPADaf1L18l68onMlOHAsECu9QBMlVAvmnViA718/MT68hzhfE8GIAPoVmiBU=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 16:01:12 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Wed, 2 May 2018
 16:01:12 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ben Peart <Ben.Peart@microsoft.com>,
        "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: [PATCH v4 0/3] add additional config settings for merge
Thread-Topic: [PATCH v4 0/3] add additional config settings for merge
Thread-Index: AQHT4i7KbwGnnv4EbU60ZFLpy/8JOA==
Date:   Wed, 2 May 2018 16:01:11 +0000
Message-ID: <20180502160056.5836-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
In-Reply-To: <20180420133632.17580-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:403:2::26) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:hSbN+OF+nUb8vYHEmyq0OUmGfl3y/GKPlb4WoA7uOyHaEJEsCg+GUsGKORcp3BUNr+d9xWg+L1/0dcRzioyqYnvqzEn9+Lo7aWsVRTyl6zp+xQ/EImIcNT4oQiUc7FEuVl1qwOMfa4KagdH++wOfBI4dNxaPCYcUYrbPKLGNW6FVfQixqGpC8Z3cffpndOVkmdV5pwgRa9fFaPyqyrG31CdGHLfirlxennUIi9BRpZGTOKxxOnicWcrKiRHP0rYs;20:88+gtCwTdDii16Zn3nGHkW6iDHJj6NeOAqE4Gqm4Ah5k+9RrmBK4mZkE6n/XWbc5YpTBOqsbfDVQH0SNLw930Zwp15IOv4t7THqlytbVqYhRxUroSIafXpyLtGIS0DxvzzE6bggE+7NLL1tE0eeycN3BIQ167x5izmIVnUkRaUU=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-microsoft-antispam-prvs: <DM5PR2101MB10158619B37CAC2A932DF743F4800@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(36756003)(39060400002)(102836004)(6346003)(486006)(26005)(25786009)(81166006)(81156014)(1730700003)(8676002)(14454004)(5640700003)(68736007)(316002)(54906003)(22452003)(11346002)(476003)(186003)(2616005)(52116002)(6116002)(76176011)(2906002)(59450400001)(386003)(6506007)(66066001)(3846002)(1076002)(446003)(86612001)(2351001)(575784001)(53936002)(6486002)(478600001)(50226002)(6436002)(3280700002)(10090500001)(7736002)(8656006)(72206003)(305945005)(10290500003)(966005)(99286004)(5250100002)(4326008)(8936002)(105586002)(2900100001)(106356001)(97736004)(2501003)(8666007)(6306002)(5660300001)(6512007)(3660700001)(6916009)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: KIEuEk3adhr1BnK3jmxfmoWByGDV7tEFFNZXj8PDmkZsd0Vbnlg79NqiXgg1H4EXRlIkc8/ba77znrghkiCG0f5JaJ4iKNKgSOdGxSJJA75vizuiXfJHrtE42CUVTwmGJwChDpwJWhHRG8tf+cVHTz/F04PUQiHkGGn82YrjsBIX3XOhd2gAjXW8oazxM/a/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cdfcb864-a2f3-4c63-6e5f-08d5b045ecac
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfcb864-a2f3-4c63-6e5f-08d5b045ecac
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 16:01:11.9243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version incorporates Elijah's fixup patch and is now based on
en/rename-directory-detection in next.

Base Ref: en/rename-directory-detection
Web-Diff: https://github.com/benpeart/git/commit/16b175c25f
Checkout: git fetch https://github.com/benpeart/git merge-renames-v4 && git=
 checkout 16b175c25f

### Patches

Ben Peart (3):
  merge: update documentation for {merge,diff}.renameLimit
  merge: Add merge.renames config setting
  merge: pass aggressive when rename detection is turned off

 Documentation/diff-config.txt             |  3 ++-
 Documentation/merge-config.txt            |  8 +++++-
 Documentation/merge-strategies.txt        | 11 +++++---
 diff.c                                    |  2 +-
 diff.h                                    |  1 +
 merge-recursive.c                         | 31 ++++++++++++++++++-----
 merge-recursive.h                         |  8 +++++-
 t/t3034-merge-recursive-rename-options.sh | 18 +++++++++++++
 8 files changed, 68 insertions(+), 14 deletions(-)


base-commit: c5b761fb2711542073cf1906c0e86a34616b79ae
--=20
2.17.0.windows.1


