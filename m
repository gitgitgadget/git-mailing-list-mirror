Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 497E920248
	for <e@80x24.org>; Thu, 21 Mar 2019 22:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCUWdl (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 18:33:41 -0400
Received: from mail-eopbgr720118.outbound.protection.outlook.com ([40.107.72.118]:2850
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbfCUWdl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 18:33:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG6mGwI5K7t/lJrjTYG8/zk2pt4H62bpYTVKoEhwMto=;
 b=JPbaOxBvk1knM9kQktLnhDT/x7LpI72LB6HAqLkEBaQNtf4F888hGUVnW9J0Cy0B81P8m+TcxuTzFlX1hfefa15FFNEDc8B0yAjGmi1YcLo2ZkFv8rMyS0u/WrAxpzXQimEkdT3Sg9zMVCYvl6CJO5Er5aAzZhwFlKgVISJsqpM=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4251.namprd08.prod.outlook.com (20.176.82.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.15; Thu, 21 Mar 2019 22:33:10 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1709.015; Thu, 21 Mar 2019
 22:33:10 +0000
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
Subject: [PATCH v2 6/7] git-p4: add failing test for "git-p4: respect excluded
 paths when detecting branches"
Thread-Topic: [PATCH v2 6/7] git-p4: add failing test for "git-p4: respect
 excluded paths when detecting branches"
Thread-Index: AQHU4DYM86QPjCA0O0qhWIoiyPAfuQ==
Date:   Thu, 21 Mar 2019 22:33:05 +0000
Message-ID: <6170d45951d71171ea3ad502a3b2a5c5c55c12f8.1553207234.git.amazo@checkvideo.com>
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
x-ms-office365-filtering-correlation-id: 1e65a0e1-8196-4bd2-a0eb-08d6ae4d2f4f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4251;
x-ms-traffictypediagnostic: DM6PR08MB4251:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR08MB4251C232991A618E061DEDFBDA420@DM6PR08MB4251.namprd08.prod.outlook.com>
x-forefront-prvs: 0983EAD6B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(14444005)(6666004)(6436002)(5640700003)(53936002)(53376002)(36756003)(76176011)(386003)(486006)(446003)(6506007)(6306002)(8676002)(68736007)(2501003)(97736004)(305945005)(256004)(25786009)(186003)(478600001)(476003)(86362001)(6512007)(966005)(71200400001)(4326008)(7416002)(6916009)(2616005)(11346002)(6486002)(102836004)(118296001)(3846002)(6116002)(26005)(7736002)(66066001)(50226002)(316002)(99286004)(14454004)(54906003)(2906002)(106356001)(81156014)(5660300002)(52116002)(71190400001)(1730700003)(81166006)(2351001)(8936002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4251;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +dukweoKO5nwfDu9GwitahAGLPUXigez3gc/rSoUKxZjoHz+chjLbnqgpUlHCv8Mx2TUwxEzd3P/0NghUbvYHvoPGwsgHXn9EMwjaOELLACVu1tFHUC+Nfggii4qi2spASmGaSvbwp6FWT7qheNrNztZQSB1iHuw1WuatekGjPYnNzQT9uqDIeV4Fln5TyHFWZWkYTxlPN5OyA5aOIl44zNL9/11IkHIq6FqZvJK8gcZX/AvlwH6lyEkQgcOAZ/pFiHsMcALeuGahW4w+xycTFGcTjzdQ0fOvRD+U2/vQd5fBSwdrfWZXTTviQE98TkcmaFSS7n2XVG/RD22infQ79QBrb4/R95SEIg6Zt01jH3fwfqM/VaVZyxLS1Puz8MY4cSpIJzSJ67WFDd5/T1ANPgKYPQx7BLsca3nwYeAPMg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e65a0e1-8196-4bd2-a0eb-08d6ae4d2f4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2019 22:33:05.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4251
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preparation for a fix, add a failing test case to test that
git-p4 doesn't exclude files despite being told to
when handling multiple branches.

I.e., it should exclude //depot/branch2/file2 when run with -//depot/branch=
2/file2,
but doesn't do this right now.

The test is based on 'git p4 clone complex branches' test with the followin=
g changes:
 * account for file3 moved from branch3 to branch4 in test 'git p4 submit t=
o two branches in a single changelist';
 * account for branch6 created in test 'git p4 clone file subset branch';
 * file2 is expected to be missing from all branches due to explicit exclud=
e.

Signed-off-by: Andrey Mazo <amazo@checkvideo.com>
---
 t/t9801-git-p4-branch.sh | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index 6a86d6996b..4729f470b2 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -409,10 +409,50 @@ test_expect_failure 'git p4 clone file subset branch'=
 '
 		test_path_is_missing file2 &&
 		test_path_is_missing file3
 	)
 '
=20
+# Check that excluded files are omitted during import
+test_expect_failure 'git p4 clone complex branches with excluded files' '
+	test_when_finished cleanup_git &&
+	test_create_repo "$git" &&
+	(
+		cd "$git" &&
+		git config git-p4.branchList branch1:branch2 &&
+		git config --add git-p4.branchList branch1:branch3 &&
+		git config --add git-p4.branchList branch1:branch4 &&
+		git config --add git-p4.branchList branch1:branch5 &&
+		git config --add git-p4.branchList branch1:branch6 &&
+		git p4 clone --dest=3D. --detect-branches -//depot/branch1/file2 -//depo=
t/branch2/file2 -//depot/branch3/file2 -//depot/branch4/file2 -//depot/bran=
ch5/file2 -//depot/branch6/file2 //depot@all &&
+		git log --all --graph --decorate --stat &&
+		git reset --hard p4/depot/branch1 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch2 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3 &&
+		git reset --hard p4/depot/branch3 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3 &&
+		git reset --hard p4/depot/branch4 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch5 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_file file3 &&
+		git reset --hard p4/depot/branch6 &&
+		test_path_is_file file1 &&
+		test_path_is_missing file2 &&
+		test_path_is_missing file3
+	)
+'
+
 # From a report in http://stackoverflow.com/questions/11893688
 # where --use-client-spec caused branch prefixes not to be removed;
 # every file in git appeared into a subdirectory of the branch name.
 test_expect_success 'use-client-spec detect-branches setup' '
 	rm -rf "$cli" &&
--=20
2.19.2

