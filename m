Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1AB1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeFDQxL (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:53:11 -0400
Received: from mail-cys01nam02on0125.outbound.protection.outlook.com ([104.47.37.125]:56085
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751680AbeFDQxG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJCP73Wywm4yQNuU2PmIeZEJO/N/fjmMKyTbHj4MV1g=;
 b=WTkdDW/dopxJnZVCuLqRgmB8gLTMqm0KZ44umf2xXki1yMRGOQcj/v2Y5MURp15PJrLlQoWJ/sqybAvngLkF7JVUqeHn6C8n0308AK3e2XDt8oKYuv9EwGKJkh7rPL41XOejiFExBQRo4vNpZiuBEpfYYty0sD+R0NA22uXR8aM=
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com (52.132.148.150) by
 MW2PR2101MB1017.namprd21.prod.outlook.com (52.132.146.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.7; Mon, 4 Jun 2018 16:53:04 +0000
Received: from MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421]) by MW2PR2101MB1020.namprd21.prod.outlook.com
 ([fe80::c4b6:aa60:955b:1421%5]) with mapi id 15.20.0841.011; Mon, 4 Jun 2018
 16:53:04 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "stolee@gmail.com" <stolee@gmail.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v4 21/21] commit-graph: update design document
Thread-Topic: [PATCH v4 21/21] commit-graph: update design document
Thread-Index: AQHT/CSBPIN2zXaoS0K/33PBIxIyWg==
Date:   Mon, 4 Jun 2018 16:53:04 +0000
Message-ID: <20180604165200.29261-22-dstolee@microsoft.com>
References: <20180604165200.29261-1-dstolee@microsoft.com>
In-Reply-To: <20180604165200.29261-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR02CA0039.namprd02.prod.outlook.com
 (2603:10b6:404:5f::25) To MW2PR2101MB1020.namprd21.prod.outlook.com
 (2603:10b6:302:9::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1017;7:ltECN9o0SU6dI2FbHqPALGh6roLkvvwLohxevyqUViPWEBA4sSusqG5muI8c79vxsnlOL9uCGMZ4gOISywhWlymNy+X+yo/xRsGnCmYRW7vacJUFX20eJjt24W+MWgAnCUuKCMCoV+6ra+Qj6wXwqnQFUPoCm/N4OQV9FxxajWjXXh8bx79kR9KByf5p8EJK+7gCLhUOPhd7vXT3zip3mcBuwm2Czj6Lfv8OkMZH7fRWUG5aQoZ5bKim9GTgkBw4;20:w6Uy7YaGfjpdyCBGwUqdW/MAxpvxdkVdAqgHYUEMS99Av26GR3ot5N9BKNc3QDu7uVklFOvD+YTMurc/E+wCo961YpCpZLgsOFFm54v9V3X3aL81MdQTJP2b7BIPlOLJr39SrHH17nrlK81tp6tVY0MqF4BPWJPHJzb0rwNs1d0=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:MW2PR2101MB1017;
x-ms-traffictypediagnostic: MW2PR2101MB1017:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <MW2PR2101MB10174144BC2006133A0DBE5BA1670@MW2PR2101MB1017.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(2018427008)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:MW2PR2101MB1017;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1017;
x-forefront-prvs: 069373DFB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(39380400002)(396003)(366004)(189003)(199004)(53936002)(6512007)(2900100001)(68736007)(15650500001)(478600001)(107886003)(86362001)(3660700001)(10290500003)(3280700002)(86612001)(22452003)(54906003)(1076002)(2351001)(7736002)(6116002)(81166006)(316002)(5660300001)(8936002)(5250100002)(386003)(6506007)(76176011)(102836004)(99286004)(2906002)(305945005)(52116002)(8676002)(10090500001)(186003)(8656006)(46003)(14454004)(97736004)(2616005)(476003)(446003)(11346002)(6916009)(1730700003)(81156014)(59450400001)(105586002)(25786009)(106356001)(4326008)(5640700003)(6436002)(6486002)(2501003)(39060400002)(36756003)(486006)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1017;H:MW2PR2101MB1020.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: HiXZe382TcvKIwiGnQdtdkMfsPkLyHBBXCDcTQ2Ph3jvgQkypG8ekTkymya3nYt0qvFd9q+8neNhWbJChUSSMBbJ8ycJwVRpN9GMua3vv7jbqk+qqnT7xig8o2guDPWqKGx+P2DI7/yJ9vGIfsAv7liWmAbc8X1UN4CorYIbGCRglFMeOhtVtMZLbhGVELUm
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: b2308dfc-6b9e-475b-f61a-08d5ca3ba38e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2308dfc-6b9e-475b-f61a-08d5ca3ba38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2018 16:53:04.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph feature is now integrated with 'fsck' and 'gc',
so remove those items from the "Future Work" section of the
commit-graph design document.

Also remove the section on lazy-loading trees, as that was completed
in an earlier patch series.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/techn=
ical/commit-graph.txt
index e1a883eb46..c664acbd76 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -118,9 +118,6 @@ Future Work
 - The commit graph feature currently does not honor commit grafts. This ca=
n
   be remedied by duplicating or refactoring the current graft logic.
=20
-- The 'commit-graph' subcommand does not have a "verify" mode that is
-  necessary for integration with fsck.
-
 - After computing and storing generation numbers, we must make graph
   walks aware of generation numbers to gain the performance benefits they
   enable. This will mostly be accomplished by swapping a commit-date-order=
ed
@@ -130,25 +127,6 @@ Future Work
     - 'log --topo-order'
     - 'tag --merged'
=20
-- Currently, parse_commit_gently() requires filling in the root tree
-  object for a commit. This passes through lookup_tree() and consequently
-  lookup_object(). Also, it calls lookup_commit() when loading the parents=
.
-  These method calls check the ODB for object existence, even if the
-  consumer does not need the content. For example, we do not need the
-  tree contents when computing merge bases. Now that commit parsing is
-  removed from the computation time, these lookup operations are the
-  slowest operations keeping graph walks from being fast. Consider
-  loading these objects without verifying their existence in the ODB and
-  only loading them fully when consumers need them. Consider a method
-  such as "ensure_tree_loaded(commit)" that fully loads a tree before
-  using commit->tree.
-
-- The current design uses the 'commit-graph' subcommand to generate the gr=
aph.
-  When this feature stabilizes enough to recommend to most users, we shoul=
d
-  add automatic graph writes to common operations that create many commits=
.
-  For example, one could compute a graph on 'clone', 'fetch', or 'repack'
-  commands.
-
 - A server could provide a commit graph file as part of the network protoc=
ol
   to avoid extra calculations by clients. This feature is only of benefit =
if
   the user is willing to trust the file, because verifying the file is cor=
rect
--=20
2.18.0.rc1

