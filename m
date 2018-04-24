Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A6111F424
	for <e@80x24.org>; Tue, 24 Apr 2018 17:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDXRLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 13:11:44 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:33872
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751326AbeDXRLn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 13:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TPTS6UK3rSqJ4IjMUf0N/2wmK5VNbnqWFsCkRR2nYyE=;
 b=W0M52Hqd5vtDj8u5gPHZ0s+tQJeB7f9JLqkTrRR0SuIPJnS6HQtp2w2GpxCG5L+ffKigAkTtBiLWNFWLc1fesLptqYvNM9vbuVEVdnGzhF89vWtUa67hvOErk8gj25BQNuWAarEFgovefXk8krfo0zmavNGArCQUv6jdEE8XHng=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB1112.namprd21.prod.outlook.com (52.132.133.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.735.4; Tue, 24 Apr 2018 17:11:40 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0735.005; Tue, 24 Apr 2018
 17:11:39 +0000
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
Subject: [PATCH v2 0/2] add additional config settings for merge
Thread-Topic: [PATCH v2 0/2] add additional config settings for merge
Thread-Index: AQHT2+9P+qno4GM3R0aYos39QBhY7w==
Date:   Tue, 24 Apr 2018 17:11:39 +0000
Message-ID: <20180424171124.12064-1-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
In-Reply-To: <20180420133632.17580-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR10CA0014.namprd10.prod.outlook.com (2603:10b6:403::24)
 To DM5PR2101MB1016.namprd21.prod.outlook.com (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1112;7:51Y8RC5KMLl7CExSe+V1pJHjEzq2+7R5xmte0IImJe2owTHJLHWMollgnxMcg3djsIYwHqDZEwXry766FVkh3FkOvB4Ati3CBlMgAxaBy87yljmyNw8AU9OKxqAyx0LzckchfG4KPNaM5VrqBBVORz1WLeLMjJoIW80A/n+nipxygX2qz9ZM/48lS97JkeQIzwg8PDrxvrOB4ya6TrvbIY29GQbGdHdNjdwqh32MJR4MmtU9HdOaOAxAv6Rpy0C1;20:NB1e1vgr0pbi5YQrJyZr6CsyDl/P+CAsI6ZaU66MHmygN0a5dqON4eBwEWQxFopNgOeP65I2gdWoJRuHSVAPrTI0U3Sx06AN6J+5KeNjQXpwUVDhUqAGL6TQwH4w+8ID6QtAJJcetLz5PN7dWg3i1oLX55UXp5571YJvorKryeM=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1112;
x-ms-traffictypediagnostic: DM5PR2101MB1112:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB11121301B3189EBD69177547F4880@DM5PR2101MB1112.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231232)(944501410)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1112;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1112;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(396003)(39860400002)(189003)(199004)(72206003)(10290500003)(52116002)(8656006)(8676002)(478600001)(1730700003)(3280700002)(2906002)(99286004)(3660700001)(2900100001)(2351001)(966005)(486006)(97736004)(6306002)(6512007)(2616005)(22452003)(8666007)(8936002)(5640700003)(66066001)(53936002)(39060400002)(4326008)(105586002)(6436002)(106356001)(36756003)(305945005)(81156014)(81166006)(6486002)(476003)(446003)(11346002)(54906003)(68736007)(50226002)(316002)(6506007)(386003)(59450400001)(25786009)(86612001)(186003)(5660300001)(102836004)(14454004)(2501003)(1076002)(3846002)(10090500001)(575784001)(5250100002)(6916009)(6116002)(76176011)(7736002)(26005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1112;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +N5uNaFeruEFbkevvPZUufE1VBoCkU/2M3PPMHH9tEv8qvrcKEXsHWWvzCiex9hTEjapW5xbBl4Z7BB3EMW0mpddzYZlGHJJb8XXQ9FezhgFUmiao7q8WD8reXxo22enDne8TeQkBqZbmPiReKQ+lp0jHhHt4Mn7JVMYW2+gy6OFJ4iW8WFiG4OzYy0TU0Bv
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4994f40e-26a8-4e38-54f4-08d5aa06714a
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4994f40e-26a8-4e38-54f4-08d5aa06714a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 17:11:39.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1112
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated in response to feedback.  Mostly documentation changes but the diff=
stat
at the end of the merge (if on) now honors the new merge.rename setting as =
well.

Base Ref: master
Web-Diff: https://github.com/benpeart/git/commit/653bfe6e01
Checkout: git fetch https://github.com/benpeart/git merge-options-v2 && git=
 checkout 653bfe6e01


### Interdiff (v1..v2):

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
index 5a9ab969db..38492bcb98 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -39,7 +39,8 @@ include::fmt-merge-msg-config.txt[]
 merge.renameLimit::
 	The number of files to consider when performing rename detection
 	during a merge; if not specified, defaults to the value of
-	diff.renameLimit.
+	diff.renameLimit. This setting has no effect if rename detection
+	is turned off.
=20
 merge.renames::
 	Whether and how Git detects renames.  If set to "false",
diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strat=
egies.txt
index 4a58aad4b8..1e0728aa12 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -84,12 +84,14 @@ no-renormalize;;
 	`merge.renormalize` configuration variable.
=20
 no-renames;;
-	Turn off rename detection.
+	Turn off rename detection. This overrides the `merge.renames`
+	configuration variable.
 	See also linkgit:git-diff[1] `--no-renames`.
=20
 find-renames[=3D<n>];;
 	Turn on rename detection, optionally setting the similarity
-	threshold.  This is the default.
+	threshold.  This is the default. This overrides the
+	'merge.renames' configuration variable.
 	See also linkgit:git-diff[1] `--find-renames`.
=20
 rename-threshold=3D<n>;;
diff --git a/builtin/merge.c b/builtin/merge.c
index 8746c5e3e8..3be52cd316 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -424,6 +424,7 @@ static void finish(struct commit *head_commit,
 		opts.output_format |=3D
 			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
 		opts.detect_rename =3D DIFF_DETECT_RENAME;
+		git_config_get_bool("merge.renames", &opts.detect_rename);
 		diff_setup_done(&opts);
 		diff_tree_oid(head, new_head, "", &opts);
 		diffcore_std(&opts);


### Patches

Ben Peart (2):
  merge: Add merge.renames config setting
  merge: Add merge.aggressive config setting

 Documentation/diff-config.txt      |  3 ++-
 Documentation/merge-config.txt     | 12 +++++++++++-
 Documentation/merge-strategies.txt |  6 ++++--
 builtin/merge.c                    |  1 +
 merge-recursive.c                  |  2 ++
 5 files changed, 20 insertions(+), 4 deletions(-)


base-commit: 0b0cc9f86731f894cff8dd25299a9b38c254569e
--=20
2.17.0.windows.1


