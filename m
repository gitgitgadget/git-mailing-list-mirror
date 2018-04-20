Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAF901F404
	for <e@80x24.org>; Fri, 20 Apr 2018 13:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755035AbeDTNgx (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 09:36:53 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:62850
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754968AbeDTNgu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 09:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8XOodSn7c/3Er+W+zJqGqwgTi9Ir+Pqw1B4tMe1yniQ=;
 b=FwCPCEco1l3U7eF+xPWf5CYO6SiUgRsk+VJS1ulKKYQbro5foBrLf/DLEhQi0wkNRHpdRUcJq0lzs4/sou0sxa7GGmSKrNUflhutnejh6c0TnaYouB7XT1pLAjr3QClWoamT6l32SA8Be5JmllnkMeMopnMGp7YNPGtnEDnqb9s=
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com (52.132.133.38) by
 DM5PR2101MB0872.namprd21.prod.outlook.com (10.167.111.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.715.4; Fri, 20 Apr 2018 13:36:48 +0000
Received: from DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83]) by DM5PR2101MB1016.namprd21.prod.outlook.com
 ([fe80::5d76:2e71:c400:8b83%4]) with mapi id 15.20.0715.010; Fri, 20 Apr 2018
 13:36:48 +0000
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
Subject: [PATCH v1 1/2] merge: Add merge.renames config setting
Thread-Topic: [PATCH v1 1/2] merge: Add merge.renames config setting
Thread-Index: AQHT2Kyhzb/NU54v/0SbtQh5K0zbxQ==
Date:   Fri, 20 Apr 2018 13:36:48 +0000
Message-ID: <20180420133632.17580-2-benpeart@microsoft.com>
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
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0872;7:/mJAqtjAw6pQyz4+L8JiDsJC5Vx9Do2ptNM17KIbXl31oh/HBAaVhrG0rxgk7IJ5VU4w28RxvD1WUBhLbevcLrdZRd6JyaYYF3C915qIcf1LHYyOdAhqjDZegBwRsuaxQw9A/EcWOJs3J35tNlbi4G+vpVziupiSihGcUHtx3Bvk+FEpPhVTVn8C0K1NXNoLI7CfQCnguK4bN5JQjxyYa+42TGQwlQhEOy/RC+MtsI31/JpY1vE2E7IpUBQEP2p4;20:DyTu/EfPNUz67C4Fn/G2KuC/NXijyUt8LfHAyUl/zZaWY+uMeAlp609+0CyiSc4yeWNBtyIdfN7ukYVge0ZNNJdafjF5/Y+u2jnphO4UiKhIbfGp+91plPN6A+JjbxvwLplgX1c03G5JCu247eYuZHi57Fj5zC/qCw9eBp0LmXE=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0872;
x-ms-traffictypediagnostic: DM5PR2101MB0872:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR2101MB087208B63331D59CEE67EC66F4B40@DM5PR2101MB0872.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501394)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0872;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0872;
x-forefront-prvs: 0648FCFFA8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(366004)(39860400002)(396003)(376002)(8936002)(6916009)(5250100002)(5640700003)(476003)(54906003)(25786009)(10290500003)(50226002)(81166006)(8676002)(4326008)(1730700003)(3280700002)(3660700001)(14454004)(72206003)(386003)(478600001)(52116002)(39060400002)(2900100001)(86612001)(6506007)(107886003)(2501003)(53936002)(59450400001)(186003)(8666007)(6512007)(6486002)(76176011)(10090500001)(2616005)(99286004)(5660300001)(102836004)(2351001)(22452003)(26005)(36756003)(6116002)(3846002)(2906002)(8656006)(1076002)(446003)(316002)(6436002)(66066001)(7736002)(11346002)(305945005)(22906009);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0872;H:DM5PR2101MB1016.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: AryMJrql9aA3jy0B+DqG58vM9hCYPOa/RzZ+/2+CSYgP24YmFpGLxdspT3xGO1eUWd/Qj/8BcneZXOTtj+uWp/olElzJKEY3IdnL1ZM1e5R6m8QWt91DSTqQu3+RtNDQyxmq71TAMP45JPgFH96Qur90abm2M1s5LGPsBTl+VOECXX196vKiIwsjmF1n7E1x
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: dababf9d-9d59-4cde-ba5a-08d5a6c3c3eb
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dababf9d-9d59-4cde-ba5a-08d5a6c3c3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2018 13:36:48.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0872
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add the ability to control rename detection for merge via a config setting.

Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/merge-config.txt | 5 +++++
 merge-recursive.c              | 1 +
 2 files changed, 6 insertions(+)

diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.tx=
t
index 12b6bbf591..656f909eb3 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -37,6 +37,11 @@ merge.renameLimit::
 	during a merge; if not specified, defaults to the value of
 	diff.renameLimit.
=20
+merge.renames::
+	Whether and how Git detects renames.  If set to "false",
+	rename detection is disabled. If set to "true", basic rename
+	detection is enabled. This is the default.
+
 merge.renormalize::
 	Tell Git that canonical representation of files in the
 	repository has changed over time (e.g. earlier commits record
diff --git a/merge-recursive.c b/merge-recursive.c
index 9c05eb7f70..cd5367e890 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3256,6 +3256,7 @@ static void merge_recursive_config(struct merge_optio=
ns *o)
 	git_config_get_int("merge.verbosity", &o->verbosity);
 	git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
 	git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
+	git_config_get_bool("merge.renames", &o->detect_rename);
 	git_config(git_xmerge_config, NULL);
 }
=20
--=20
2.17.0.windows.1

