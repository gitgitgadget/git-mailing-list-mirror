Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7D6B1F406
	for <e@80x24.org>; Thu, 10 May 2018 17:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966758AbeEJReW (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 13:34:22 -0400
Received: from mail-dm3nam03on0090.outbound.protection.outlook.com ([104.47.41.90]:53659
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966721AbeEJReT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 13:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ymAw5bmm9t9h/AbXMEsG4Zmo9eJN1KtCiWT9fc7eC2k=;
 b=aWAO2zdsM4cHJTq+nVT6IaZ7UJ/qrk4tnURdaUjlGXBmcCcr0jshagRwMPwMsBb/9bLLuR97AN/W9phL1LeJzD2H3gTPZt3OIqoyPJVG1I+7haWXii71XBjqQvt17qZiSCK3ej1s86YovAergBzudN92860OhVVRYQbadGtkeXU=
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com (52.132.24.10) by
 BL0PR2101MB0962.namprd21.prod.outlook.com (52.132.20.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.776.1; Thu, 10 May 2018 17:34:17 +0000
Received: from BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8]) by BL0PR2101MB1011.namprd21.prod.outlook.com
 ([fe80::714b:5398:58e0:b4d8%3]) with mapi id 15.20.0776.004; Thu, 10 May 2018
 17:34:17 +0000
From:   Derrick Stolee <dstolee@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 12/12] commit-graph: update design document
Thread-Topic: [PATCH 12/12] commit-graph: update design document
Thread-Index: AQHT6IUenUmMf/Zj+UOsPMMKBUF4ug==
Date:   Thu, 10 May 2018 17:34:16 +0000
Message-ID: <20180510173345.40577-13-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com>
In-Reply-To: <20180510173345.40577-1-dstolee@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR14CA0004.namprd14.prod.outlook.com
 (2603:10b6:404:79::14) To BL0PR2101MB1011.namprd21.prod.outlook.com
 (2603:10b6:207:37::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2001:4898:8010:0:eb4a:5dff:fe0f:730f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0962;7:VNlF2kWhBMMNA8DbAzK06XgN3fRUvwQD7RcWff53sC11vcuzY1fXhU1zm5jfVXQpxB3zx79lmKObzFlU3Qy7EF9Wn0VibLLzf94NuXwhAp9PySzIFF9hr2GTkhCKGltro1rCXOA1Zpq+gFhTJ11HXQx+sqtVeb2bF0p9mfDRZ0saoN6lQNkucSKxMU4pwr5AUgsBy+BC/JgR93Gom3a2jkgJcle3DVH0JqN82AYpbNEP/U2nOtxzgmIUW3zHm8+F;20:DRT/AqwrbiallKfa2EbU8IHdW1G7aA4vrlBwWwzkBI9B4aWhB2iWmRAzL+2Vj91xjNTdex26C8FpgGbnEmXiUrMQqQB4tTpN1o2BagXCiudVLvzBO5uBpUqKcmOZbnGUoIUKQvoZQ50spLYikO+PHbdJ5nwIJuSYXn5IHl/aDGE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB0962;
x-ms-traffictypediagnostic: BL0PR2101MB0962:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dstolee@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB0962AF0CECC3757E5DDA66B8A1980@BL0PR2101MB0962.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(158342451672863)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL0PR2101MB0962;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0962;
x-forefront-prvs: 066898046A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(1496009)(39380400002)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(6916009)(5250100002)(107886003)(4326008)(105586002)(8676002)(36756003)(476003)(2501003)(2616005)(8936002)(14454004)(2906002)(2900100001)(86362001)(10290500003)(6512007)(478600001)(53936002)(10090500001)(86612001)(486006)(25786009)(6486002)(5640700003)(46003)(76176011)(1730700003)(386003)(305945005)(5660300001)(316002)(54906003)(39060400002)(81166006)(81156014)(3660700001)(186003)(6506007)(52116002)(7736002)(3280700002)(102836004)(2351001)(97736004)(1076002)(99286004)(6116002)(11346002)(22452003)(106356001)(446003)(68736007)(15650500001)(59450400001)(6436002)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0962;H:BL0PR2101MB1011.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g9UezSpQ5TdHMgN0kwM10ROoLBq939oWU1B+laKpxOyjQWgnCtNLskLiJpbyLGnB86pwPeV14mVTwGrViGKmeyYgD1usqrRMiInsaCVTrhq/AKu4myZT6a4xRoHV1ylMPMiR6Fan7hfa8vAzFFnU2W+/yWN6YqXnDMBYfBw7EEe6p0COc7N0cTV7GP6i2EK6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: a5679484-7a0b-461d-cadd-08d5b69c40f7
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5679484-7a0b-461d-cadd-08d5b69c40f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2018 17:34:16.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0962
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
2.16.2.329.gfb62395de6

