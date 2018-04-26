Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1F761F424
	for <e@80x24.org>; Thu, 26 Apr 2018 20:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756338AbeDZUwX (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 16:52:23 -0400
Received: from mail-dm3nam03on0110.outbound.protection.outlook.com ([104.47.41.110]:50816
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754559AbeDZUwV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 16:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6CGFW+0nU93lDa7OxHRqGWY29xOIP3JH83m/lhH5gp4=;
 b=MnMVNyARGl9A6Lx4UWp4T8O6KZI3gronsgeUJfrcpBqswJzPw9HsXuW8EtJEGtB6kk+ZE3fwgre98s8rxGJa9UC6nm7JnUotwdB1hh89eav8atx4P6k8fjeQ0BkjUgLcoZS+SfUZOVJACXylz6Sp9F7XDoQLb4z+FIiTs3BlxJ4=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0997.namprd21.prod.outlook.com (52.132.133.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.715.5; Thu, 26 Apr 2018 20:52:19 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.006; Thu, 26 Apr 2018
 20:52:19 +0000
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
Subject: [PATCH v3 1/3] merge: update documentation for
 {merge,diff}.renameLimit
Thread-Topic: [PATCH v3 1/3] merge: update documentation for
 {merge,diff}.renameLimit
Thread-Index: AQHT3aB3SwTkjZ2TKEa58LgGa4bazA==
Date:   Thu, 26 Apr 2018 20:52:19 +0000
Message-ID: <20180426205202.23056-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180426205202.23056-1-benpeart@microsoft.com>
In-Reply-To: <20180426205202.23056-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN3PR03CA0084.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::44) To DM5PR2101MB1016.namprd21.prod.outlook.com
 (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:I2L2DR+XMXE+bIcuMwuuLB6pAeBrr5Qf0fsSiGSWzbCqcjtz1YannB5PCGpzEi4xI6szvxuj4q3oko/mumd2txOnfBpk2oT5plNMM5w1Ua42vqkOQoBmgiWY5r02tztorY6NUBZ33xBdxwfHbR2IHyfAcHxtxhD0sg9sApKZPvnsau+fLafBse0TatZmCGZXMFBvhRYBlIWJX8d2D3VEDHWhw6ZalAu0RHHmEGdVGmei3iU8O+YLHhkEHt+qTWn1;20:RpGRFLoJ0MB0M7e0FiLrosGM0LjNiDkrOfBOt8dNdwemhSntLoZ1HZYaUtj8x2YBqeayxxnBXBmH6B+MAI6bE1kZGgr/w07Ud8Lv6B7GgivSQD3SRnaBF5FZPEHuvK23GEYgxO1aAqx9Ar5V8skFjso6I4IhDb48+VnwRomssH8=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB0997AA1F79C7A582EB32E074F48E0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(346002)(366004)(376002)(396003)(39380400002)(199004)(189003)(3846002)(39060400002)(106356001)(6116002)(97736004)(6916009)(81166006)(66066001)(2616005)(14454004)(53936002)(50226002)(6486002)(1730700003)(5640700003)(8676002)(6512007)(5250100002)(81156014)(15650500001)(1076002)(26005)(10090500001)(305945005)(8936002)(10290500003)(105586002)(25786009)(4326008)(68736007)(54906003)(2906002)(52116002)(7736002)(86612001)(22452003)(5660300001)(478600001)(102836004)(186003)(72206003)(6436002)(446003)(2351001)(11346002)(386003)(8666007)(8656006)(76176011)(99286004)(486006)(316002)(6506007)(3280700002)(36756003)(3660700001)(59450400001)(2501003)(2900100001)(476003)(22906009)(142933001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5yFuB+CnF8sbD1xhgL5Lh7Hma8m13U9BQzKpdWCzMtsovO50ueo2JL5yLYwHF7NRdtB4xu0tq3pjiwmpGLTz6TudX9u84aRqn0gB8Xgv4vqKTPwN8CmDuL/Cg0xXMvBM3xgTEDrn6XloLtmay4/xnvpSVUdD7khAj9rprwOomSANoXNOaDNiA2MAY2zzTgiR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: f098a26a-017c-48db-f159-08d5abb799a2
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f098a26a-017c-48db-f159-08d5abb799a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 20:52:19.7157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
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

