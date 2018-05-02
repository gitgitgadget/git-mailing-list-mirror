Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A914621847
	for <e@80x24.org>; Wed,  2 May 2018 16:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751817AbeEBQBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 12:01:19 -0400
Received: from mail-dm3nam03on0134.outbound.protection.outlook.com ([104.47.41.134]:37354
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751483AbeEBQBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 12:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6CGFW+0nU93lDa7OxHRqGWY29xOIP3JH83m/lhH5gp4=;
 b=Or4+DCcOQHTzHEBn9Ri1SHu+u8HVFPg3LtrnSxpoIHQovJyXIh0/21BPovUfii60hKYUuOxCXBh2oH4D5hP8ZONKRw9WdTSKl2ijasqfL+YxQW4Zif3yU7VT00Z1E575g7EgQSVpdcovzDE1AIhRM9pgB/8PuBbtSztaScheROA=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1015.namprd21.prod.outlook.com (52.132.133.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.755.1; Wed, 2 May 2018 16:01:13 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0755.002; Wed, 2 May 2018
 16:01:13 +0000
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
Subject: [PATCH v4 1/3] merge: update documentation for
 {merge,diff}.renameLimit
Thread-Topic: [PATCH v4 1/3] merge: update documentation for
 {merge,diff}.renameLimit
Thread-Index: AQHT4i7LmrKevIvz5EaPeTK/tlS1WA==
Date:   Wed, 2 May 2018 16:01:13 +0000
Message-ID: <20180502160056.5836-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180502160056.5836-1-benpeart@microsoft.com>
In-Reply-To: <20180502160056.5836-1-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:ZbmxJbh9c0M03cEbERNXE9ou+e6icLFjYaQT2WS6kn/2R9P18yYuCtc1R3kPzaxDnKt8ujonjT+0QsvxTY8tCQ73UBfpsmAz/v22WKK446nkHkyi3QB8iN7XirdkvewjQRq7LABLIID6gcBii5ezEOBTrE5jBYcaGVxfIDJYQWpdfj2xHVrwfZONR9WjcQDUdXGdKCeSll0pttOj+ZulGLZjuLbnkZl48cKv+bDEkyhJKB4uIsFavRfibvKb37ia;20:EWxelA8eKypQX8MPT+XeafRIRNXSwf6AhmGsPl4hPW1i+bZYJlJlfzfgGItMpYjS4nFZl5V0+A2ltZIKv4JS1/uIHjTx1ctj0pUQ4/NnCI7Cb3gQPDngkL0vFvkhuPamgQPfPhDs0XI3034M9+0jYbMXeDn1PXhAxb05JayorTE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
x-microsoft-antispam-prvs: <DM5PR2101MB101577C292E46ABA7B3C3DD6F4800@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 06607E485E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(36756003)(39060400002)(102836004)(6346003)(486006)(26005)(25786009)(81166006)(81156014)(1730700003)(8676002)(14454004)(5640700003)(68736007)(316002)(54906003)(22452003)(11346002)(476003)(186003)(2616005)(52116002)(6116002)(76176011)(2906002)(59450400001)(386003)(6506007)(66066001)(3846002)(1076002)(446003)(86612001)(2351001)(53936002)(6486002)(478600001)(50226002)(6436002)(3280700002)(10090500001)(7736002)(8656006)(72206003)(305945005)(10290500003)(99286004)(5250100002)(15650500001)(4326008)(8936002)(105586002)(2900100001)(106356001)(97736004)(2501003)(8666007)(5660300001)(6512007)(3660700001)(6916009)(22906009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-message-info: /Xa5ypYfDKFTMKpYRe97wi8xC+6XHt4a5ZAFuVthX6xx1+AZCv1+BU08H3G2wZAs27KALMcULUfSwbNrX/quDCFEHlKaS2VyVF8SEUBvFQ44dt8MOHrr2tVomnHtAnF1stAPLD4NREzA5kfgp+wtcKAacK8LnalAhAMmkHcHHMqBBwilqtl0WMtLSecysBP8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7476568c-9cb5-4c62-f0a5-08d5b045ed9a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7476568c-9cb5-4c62-f0a5-08d5b045ed9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2018 16:01:13.2502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update the documentation to better indicate that the renameLimit setting is
ignored if rename detection is turned off via command line options or confi=
g
settings.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/diff-config.txt  | 3 ++-
 Documentation/merge-config.txt | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 5ca942ab5e..77caa66c2f 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -112,7 +112,8 @@ diff.orderFile::
=20
 diff.renameLimit::
 	The number of files to consider when performing the copy/rename
-	detection; equivalent to the 'git diff' option `-l`.
+	detection; equivalent to the 'git diff' option `-l`. This setting
+	has no effect if rename detection is turned off.
=20
 diff.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 12b6bbf591..48ee3bce77 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -35,7 +35,8 @@ include::fmt-merge-msg-config.txt[]
 merge.renameLimit::
 	The number of files to consider when performing rename detection
 	during a merge; if not specified, defaults to the value of
-	diff.renameLimit.
+	diff.renameLimit. This setting has no effect if rename detection
+	is turned off.
=20
 merge.renormalize::
 	Tell Git that canonical representation of files in the
--=20
2.17.0.windows.1

