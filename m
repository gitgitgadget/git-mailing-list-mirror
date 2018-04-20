Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90CC51F404
	for <e@80x24.org>; Fri, 20 Apr 2018 13:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755047AbeDTNhA (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 09:37:00 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:62850
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755020AbeDTNgv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 09:36:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eQDtdJ4/VhkZRPudKwDcQRCKUWPawqPUkJh7N3xh9Sc=;
 b=KwU0ycQv1rtwq+TLIXJxUvQWdXzbPn/J63MnEQOXFOggPwLFP6/tmQ/tf9skYgliSGafx/zdZoib9dHR6NeVDd9ZH4/BYMXWLxQTY5r+fWgnXGpBClEfTMCgkGvUP1sTjQdDmvcQpMtXI4rqjoQciyH9fjaHulf9cw6yZPyhZaU=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0872.namprd21.prod.outlook.com (10.167.111.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Fri, 20 Apr 2018 13:36:49 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0715.010; Fri, 20 Apr 2018
 13:36:49 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "newren@gmail.com" <newren@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: [PATCH v1 2/2] merge: Add merge.aggressive config setting
Thread-Topic: [PATCH v1 2/2] merge: Add merge.aggressive config setting
Thread-Index: AQHT2KyipvHX1bILNEux9HgkvVbs6g==
Date:   Fri, 20 Apr 2018 13:36:49 +0000
Message-ID: <20180420133632.17580-3-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
In-Reply-To: <20180420133632.17580-1-benpeart@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [70.33.148.227]
x-mailer: git-send-email 2.17.0.windows.1
x-clientproxiedby: BN4PR10CA0019.namprd10.prod.outlook.com (2603:10b6:403::29)
 To DM5PR2101MB1016.namprd21.prod.outlook.com (2603:10b6:4:a8::38)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:sBb1Y0sN2pCqbL4AVYxOWCTj3k1uDAq0E+BUGCSXI2yE52Bj7nbtrzQxO2tSAZ2ckAJZjDBBrxTjXw5+yGjIWBd8p54oD6nyJlo5fldYvNM858adMug6WgI50EXsuevJxhEYRa3ingxKSE6Ei9fsNNz2S16hPbtYSgQi5+V4egP64EwxOgP6yVvvfTVpjdK/tjN7WYXmSXcZJHI+mG0zL5tBs8hSL9j9pizMBeoheYJDHqFtLQ7t1/kl+2ffJHPk;20:Wtoejnth4QK4ltam1UZWn1lA7/BN4g1eMrMUBSL14wQ96hA4rLJzfe8/Y+ba94XNDi9iEwcBejC/Y+KWRbvoooZwdRP2r0yDDFc6Xk97v4UBQ+XZurSucMjHn4tTwTQ9T5LlFi59L2gnOXA00x3UI9dhVqZzmWI9OmTYx0kCXjw=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB08725C55047B2A9C6C55E9BAF4B40@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501394)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(39860400002)(396003)(376002)(8936002)(6916009)(5250100002)(5640700003)(476003)(54906003)(25786009)(10290500003)(50226002)(81166006)(8676002)(4326008)(1730700003)(3280700002)(3660700001)(14454004)(72206003)(386003)(478600001)(52116002)(39060400002)(2900100001)(86612001)(6506007)(107886003)(2501003)(53936002)(186003)(8666007)(6512007)(6486002)(76176011)(10090500001)(2616005)(99286004)(5660300001)(102836004)(2351001)(22452003)(26005)(36756003)(6116002)(3846002)(2906002)(8656006)(1076002)(446003)(316002)(6436002)(66066001)(7736002)(11346002)(305945005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tf/Mm8blqpLbwvpxvBn3GMq8CQ8aSnVNp6d01v9Q86I63lkqo7NWnknUsySSvWqE6JHAYinFhmjUq71xTc+W8g7N2xV4bHEhmxRzIf2kFl+tXL+vS4ZRITpPOlag7+3aJcUlEVcU/Mzd3l8FFsUATLsnn7uak8HXt3Rfv1v2nd6buW2VrX/qJ9+eVPI+EMuq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 9ec1313e-a884-4c9c-510b-08d5a6c3c492
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec1313e-a884-4c9c-510b-08d5a6c3c492
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 13:36:49.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control the aggressive flag passed to read-tree via a co=
nfig setting.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/merge-config.txt | 4 ++++
 merge-recursive.c              | 1 +
 2 files changed, 5 insertions(+)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 656f909eb3..5a9ab969db 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -1,3 +1,7 @@
+merge.aggressive::
+	Passes "aggressive" to read-tree which makes the command resolve
+	a few more cases internally. See "--aggressive" in linkgit:git-read-tree[=
1].
+
 merge.conflictStyle::
 	Specify the style in which conflicted hunks are written out to
 	working tree files upon merge.  The default is "merge", which
diff --git a/merge-recursive.c b/merge-recursive.c
index cd5367e890..0ca84e4b82 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -355,6 +355,7 @@ static int git_merge_trees(struct merge_options *o,
 	o->unpack_opts.fn =3D threeway_merge;
 	o->unpack_opts.src_index =3D &the_index;
 	o->unpack_opts.dst_index =3D &the_index;
+	git_config_get_bool("merge.aggressive", (int *)&o->unpack_opts.aggressive=
);
 	setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
=20
 	init_tree_desc_from_tree(t+0, common);
--=20
2.17.0.windows.1

