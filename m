Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AEFD1F462
	for <e@80x24.org>; Fri,  7 Jun 2019 22:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfFGWaM (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 18:30:12 -0400
Received: from mail-eopbgr800118.outbound.protection.outlook.com ([40.107.80.118]:25246
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730442AbfFGWaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 18:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dougsite.onmicrosoft.com; s=selector1-dougsite-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCJ3HEsXXD+vLCB/A0fzDEo+aOlcXuFDpFdkeDLIi54=;
 b=TJjG2xrbPTU+bg2C44gtCBEQnuUY9uXiSU15wls+OVHt+w9m+2Ys/5c7O9omylnf7lHjQ+3wrdA07TFnH7Udv0jbZHMuVcfo7ibf0RQA/7O9wbYiRi/gYj5xHyq2BUK4Bz5pMHfuewtEwHfURBrpOuc/NmPPET4Gm+KWH0yfQNA=
Received: from DM5PR2201MB1081.namprd22.prod.outlook.com (10.174.186.24) by
 DM5PR2201MB1547.namprd22.prod.outlook.com (10.174.187.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.15; Fri, 7 Jun 2019 22:30:08 +0000
Received: from DM5PR2201MB1081.namprd22.prod.outlook.com
 ([fe80::c37:4ab1:63d6:c13b]) by DM5PR2201MB1081.namprd22.prod.outlook.com
 ([fe80::c37:4ab1:63d6:c13b%5]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 22:30:08 +0000
From:   "Douglas J. Clutter" <dougc@douglas-associates.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Possible bug with git subtree pull
Thread-Topic: Possible bug with git subtree pull
Thread-Index: AdUdfghheqDtYcJjTU+3+YoOXg6GXA==
Date:   Fri, 7 Jun 2019 22:30:07 +0000
Message-ID: <DM5PR2201MB10819C1E74000E91B09F157982100@DM5PR2201MB1081.namprd22.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dougc@douglas-associates.com; 
x-originating-ip: [72.44.107.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d85a9bd-12d6-46c1-594b-08d6eb97b21b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR2201MB1547;
x-ms-traffictypediagnostic: DM5PR2201MB1547:
x-microsoft-antispam-prvs: <DM5PR2201MB1547F2160FB3D866380B138382100@DM5PR2201MB1547.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39830400003)(136003)(396003)(189003)(199004)(305945005)(99286004)(5660300002)(2906002)(2501003)(9686003)(7736002)(76116006)(1730700003)(71190400001)(81156014)(8676002)(71200400001)(486006)(6436002)(81166006)(74316002)(52536014)(25786009)(316002)(476003)(86362001)(7696005)(33656002)(66446008)(64756008)(53936002)(508600001)(66476007)(186003)(66946007)(73956011)(14454004)(8936002)(66066001)(66556008)(26005)(55016002)(102836004)(5640700003)(6116002)(3846002)(6916009)(14444005)(68736007)(6506007)(2351001)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2201MB1547;H:DM5PR2201MB1081.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: douglas-associates.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: oLk44x38QhoDwBvG/dfcb5tZL/g3qNX4c0MIlCKocor39hLwcFu5jUW6WvJsrXKSxNx6QyPDq92ZMcAtiCQ1tK8vm0UZqNsGiEI82sOps4t4MLl37Nb0CEobtpfu5pLu1BVS7yh6BDSdou5PSNQ9M9Hhf5ggneLXFxTxgd10s/gg3G0FqTbdaUkDZmDDHGKCQ6HX9qt/y48Neu3xXoZHxvypJu82/vTUZdrjy0G+HAH9tiVeaagf3ViTJ0sEBVvIlNUYBgNPC/ED8daLmdewRFRLkGJhSgUBakjpuSeIWnjGouKmUwSUp0it2t2JB8WdC+BANRmEP4wUkZMA0UOPlXGPAZuMvGxdstenMsQwEpft6JUMQr8B6K1vBw5jIwK7sEkGJbVXd0+JkG9XIIrh1jT0dWdkPf/jebV75H27SXY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: douglas-associates.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d85a9bd-12d6-46c1-594b-08d6eb97b21b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 22:30:07.8870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8443bb9a-5426-42af-a65f-208f1f2350f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dougc@douglas-associates.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2201MB1547
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It appears the git subtree pull command may have some problems.

The script below demonstrates the problem as follows:
1) Create a repo with a lib folder
2) Create another repo that uses the lib folder via git subtree push/add - =
the initial operation works as expected
3) Update the original lib folder as follows: modify an existing file and a=
dd a new file
4) Commit the changes reports "1 file changed, 1 insertion(+)"
5) Use git subtree push/pull - seems to work: returns message "1 file chang=
ed, 1 insertion(+)"
6) The new file is there, but the changed file is not updated

The expected behavior is:
	git subtree pull - would merge both the updated file and the new file

Actual behavior is:
	git subtree pull - adds the new file but does not merge changes to the exi=
sting file

Have confirmed behavior on both Windows and Ubuntu.

git --version is 2.17.1 in Ubuntu

Here is the full Ubuntu script:
clear
echo Test git subtree

export gitTestRoot=3D"/home/dougc/git-test"
export librepo=3D"$gitTestRoot/librepo"
export uselibrepo=3D"$gitTestRoot/uselibrepo"

echo Clean-up
cd /
rm -rf $gitTestRoot

echo Initialize repos
mkdir $gitTestRoot
mkdir $librepo
cd $librepo
git init
mkdir $uselibrepo
cd $uselibrepo
git init

echo Add files to librepo
cd $librepo
echo Hi >fileInRoot.txt
mkdir lib
cd lib
echo Mom >fileInLib.txt
cd ..
git add fileInRoot.txt
git add lib/fileInLib.txt
git commit -m "Initial files in repo with lib"

echo Add files to uselibrepo
cd $uselibrepo
echo Excellent>file1.txt
git add file1.txt
git commit -m "Initial files in repo that will have lib subtree"

echo Add subtree to uselibrepo
cd $librepo
git subtree push --prefix=3Dlib $uselibrepo libBranch
cd $uselibrepo
git subtree add --prefix=3Dlib $uselibrepo libBranch
git branch -D libBranch

echo Add/change files in lib
cd $librepo/lib
echo Dad >fileInLib.txt
echo Adventure >anotherLib.txt
git add anotherLib.txt
git commit -m "Updates to lib in original location"

echo Share changes
cd $librepo
git subtree push --prefix=3Dlib $uselibrepo libBranch
cd $uselibrepo
git subtree pull --prefix=3Dlib -m "Merging" $uselibrepo libBranch
git branch -D libBranch

echo New file is found in both places
cat $librepo/lib/anotherLib.txt
cat $uselibrepo/lib/anotherLib.txt

echo Changed file is NOT the same in both places
cat $librepo/lib/fileInLib.txt
cat $uselibrepo/lib/fileInLib.txt

