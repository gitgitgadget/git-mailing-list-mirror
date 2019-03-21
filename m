Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEE720248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfCUWc5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:32:57 -0400
Received: from mail-eopbgr740090.outbound.protection.outlook.com ([40.107.74.90]:6221
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbfCUWc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:32:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zsXKuS0sLoF6vg9kwfz/4lj7MRt+ss9M7eELjPZ5gdM=;
 b=WeB3tEtSE7QTVQcqUUMPgn+yU7/gqeQnCXAU6LKLK3P05HsHsjDBdb5p37rTVyvwevY92sVGQxOLbBFgboGJei/x+pZvVSp3NYXb2xNXG6XwCxdkXObu1k05oCVt/DdeedOaZ+mG0wtYEiTWM2XDGbHAc7QwIIStgwPsRGgK984=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4410.namprd08.prod.outlook.com (20.176.82.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Thu, 21 Mar 2019 22:32:54 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:32:54 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "ahippo@yandex.com" <ahippo@yandex.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH v2 2/7] git-p4: match branches case insensitively if
 configured
Thread-Topic: [PATCH v2 2/7] git-p4: match branches case insensitively if
 configured
Thread-Index: AQHU4DYGwpQ0yt3xbE+SDG6OAdz4sg==
Date:   Thu, 21 Mar 2019 22:32:54 +0000
Message-ID: <e644a8ab4928349ed83ac9ab6ffdbcafc3a3a7b5.1553207234.git.amazo@checkvideo.com>
References: <cover.1553207234.git.amazo@checkvideo.com>
In-Reply-To: <cover.1553207234.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:400::33)
 To DM6PR08MB4956.namprd08.prod.outlook.com (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe3a9977-b3b7-4fec-6c8f-08d6ae4d28df
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4410;
x-ms-traffictypediagnostic: DM6PR08MB4410:
x-microsoft-antispam-prvs: <DM6PR08MB441048B6BB64034952DDBBC1DA420@DM6PR08MB4410.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(366004)(136003)(376002)(189003)(199004)(26005)(2906002)(6436002)(68736007)(14444005)(7416002)(36756003)(6486002)(316002)(256004)(106356001)(66066001)(486006)(476003)(97736004)(11346002)(446003)(2501003)(118296001)(2616005)(105586002)(2351001)(54906003)(6506007)(386003)(6916009)(25786009)(8676002)(5660300002)(99286004)(76176011)(478600001)(102836004)(81166006)(81156014)(1730700003)(3846002)(6116002)(305945005)(71190400001)(71200400001)(5640700003)(4326008)(186003)(7736002)(86362001)(8936002)(53936002)(19627235002)(52116002)(50226002)(6512007)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4410;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sHzjkL+l39S4RSB3gL3brBMIh68345MGl9QS+PhWdfJnxc6fxD9QCULrtCBMcpip4fJOqsvXwLTBeywgR5WW+BsZgXGznreojWD8ERThuMS+IaALhg35Sk9FclGneTLguVZ0dFoQa1sB7spxHYi54uCIOgX+zqRsUR3XGOkSohMpRbYT+xyrpf7u8qPYCdC94HqEUc9mfiJf8d50WCEydTa3FoyGgpbufDjyNkUid8dP5glC0YESkXws5EOe6yT1eTojBK+fgvpvcqAU7+XQQxV9MJ8YNsRWTpXAQ5T1Lx0WanWiToDaGxPz0hYujY+pdXnJ47FoGIFiyQ0BDlqBDHeCsoPeLJIN6WOoz5KQx+/ryeUfwjZir07XzaIojMTh6vMS5zUidufl0gKcEDnCzag6sgtGdpA+yi3oGtQAzXQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3a9977-b3b7-4fec-6c8f-08d6ae4d28df
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:32:54.3201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4410
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 knows how to handle case insensitivity in file paths
if core.ignorecase is set.
However, when determining a branch for a file,
it still does a case-sensitive prefix match.
This may result in some file changes to be lost on import.

For example, given the following commits
 1. add //depot/main/file1
 2. add //depot/DirA/file2
 3. add //depot/dira/file3
 4. add //depot/DirA/file4
and "branchList =3D main:DirA" branch mapping,
commit 3 will be lost.

So, do branch search case insensitively if running with core.ignorecase set=
.
Teach splitFilesIntoBranches() to use the p4PathStartsWith() function
for path prefix matches instead of always case-sensitive match.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index c0a3068b6f..91c610f960 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2721,11 +2721,11 @@ def splitFilesIntoBranches(self, commit):
                 relPath =3D self.stripRepoPath(path, self.depotPaths)
=20
             for branch in self.knownBranches.keys():
                 # add a trailing slash so that a commit into qt/4.2foo
                 # doesn't end up in qt/4.2, e.g.
-                if relPath.startswith(branch + "/"):
+                if p4PathStartsWith(relPath, branch + "/"):
                     if branch not in branches:
                         branches[branch] =3D []
                     branches[branch].append(file)
                     break
=20
--=20
2.19.2

