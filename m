Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D731F462
	for <e@80x24.org>; Thu, 30 May 2019 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfE3SQV (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 May 2019 14:16:21 -0400
Received: from mail-eopbgr770073.outbound.protection.outlook.com ([40.107.77.73]:56327
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726280AbfE3SQV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 May 2019 14:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=voltserver.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+YVT7sxcmRTX9AryBFu1S+nLgdZhPPhLLOM0Zuc+MuM=;
 b=0leZDUtl5AgutgTfwpieQ53tK+WP3bYeYTerWlaXJeo/qSbJXJgM3fwQfIyNdAR8Y1jpahzjjd9BD40hLCgLTemUK6bg4p8VOPFo7/F9mS3X9XlyYheo3hWWvVDI4ZEaYFjdHK89r2243tmT+o6+9F4rFYgx3MwGizN3DmrVd5I=
Received: from BN8PR11MB3571.namprd11.prod.outlook.com (20.178.218.159) by
 BN8PR11MB3777.namprd11.prod.outlook.com (20.178.221.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Thu, 30 May 2019 18:16:17 +0000
Received: from BN8PR11MB3571.namprd11.prod.outlook.com
 ([fe80::41e6:5031:6141:cdb2]) by BN8PR11MB3571.namprd11.prod.outlook.com
 ([fe80::41e6:5031:6141:cdb2%5]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 18:16:17 +0000
From:   Alex Levy <alex.levy@voltserver.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: possible submodule bug?
Thread-Topic: possible submodule bug?
Thread-Index: AdUXAd5IoyZbf3DPRJyFjyiJc7NSUg==
Date:   Thu, 30 May 2019 18:16:17 +0000
Message-ID: <BN8PR11MB35711F87B0981C6897DCE3CC89180@BN8PR11MB3571.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alex.levy@voltserver.com; 
x-originating-ip: [72.87.93.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7887d9ce-c3fb-462a-eee4-08d6e52ae8e9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR11MB3777;
x-ms-traffictypediagnostic: BN8PR11MB3777:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BN8PR11MB3777760CA484C91A7096132589180@BN8PR11MB3777.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39840400004)(366004)(136003)(376002)(346002)(54504004)(189003)(199004)(99286004)(102836004)(256004)(186003)(81156014)(26005)(66446008)(14444005)(53936002)(2501003)(316002)(476003)(44832011)(5660300002)(86362001)(486006)(9686003)(33656002)(64756008)(6306002)(305945005)(55016002)(7696005)(6436002)(6116002)(76116006)(66556008)(3480700005)(68736007)(66946007)(7736002)(966005)(66066001)(7116003)(25786009)(3846002)(1730700003)(8676002)(2351001)(81166006)(8936002)(6916009)(508600001)(73956011)(71190400001)(5640700003)(52536014)(6506007)(66476007)(71200400001)(2906002)(74316002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR11MB3777;H:BN8PR11MB3571.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: voltserver.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AwA/sM/PuK9pnULGG6cpusp39bTBgy6pU8XeXpCEm09KXx6kGf7PeRpwfGo73bMj3226KbeVue7dqCTklmgrhdFf6IlVBA4YjoZRok3gkI81UBtUAeoIDyxvg+OKHnPX0bkLbEzBwYO7Nu2c08102oo8LyxKGEyf9lCon+7bkiYqzth0rVhrcDXyRZYQabil1pd9ROuXZVR9GgTjpFrUvo1hWHhtFArjeMVN6sww5bEVq/pWiAoG1RmN67yiAD7awwACE8bd5MTq6+Ddeiwr082f5fpIMdLQ/LdAEejDcioJ8XHRWzEKhuqIg+dKidrlL7kwqAR5oVXv4Gm7y7KFWYdfTPJ3c4Pd1dEXJHFgzD9f1SIPSsC2zvxfgLuWmlObxG4KMSUJvYomK0XwZyINRzcaW8wfFRXG6qZ4vPRb1dA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: voltserver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7887d9ce-c3fb-462a-eee4-08d6e52ae8e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 18:16:17.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d954406-2c01-45a3-9cc8-be64a19fb626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alex.levy@voltserver.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3777
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi. I'm running git version 2.13.2.windows.1.  My coworker has the same beh=
avior with 2.21.0.windows.1.

I recently set up a git submodule by doing "git submodule add https://githu=
b.com/VoltServer/example".  Based on our teams preference, I then tried to =
update .gitmodules to use the alternate URL "git@github.com:VoltServer/exam=
ple.git".  When I manually edited the .gitmodules file, I failed to type it=
 in correctly, instead providing "git@github.com/VoltServer/example" (I thi=
nk the same problem applies for any malformed URL).  After my coworker pull=
ed this commit and tried to init the submodule we realized my mistake.  So,=
 I fixed .gitmodules to use the correct URL, committed, and he pulled again=
.  Despite now having the correct URL, his superproject clone still failed =
to clone the submodule.  I found a workaround, but I'm not certain if the w=
orkaround was valid or not.

Here are the recreation steps:

mkdir example
cd example
mkdir a
cd a
git init
touch foo
git add foo
git commit -m "Initial commit."
git submodule add https://github.com/VoltServer/example
git commit -m "Add submodule."
vim .gitmodules // edit as described above
git add .gitmodules
git commit -m "Update to wrong URL in .gitmodules."
cd ..
git clone a b
cd b
git submodule update --init

That last command gives the following output:

Submodule 'example' (git@github.com/VoltServer/example) registered for path=
 'example'
fatal: repository 'git@github.com/VoltServer/example' does not exist
fatal: clone of 'git@github.com/VoltServer/example' into submodule path 'C:=
/projects/temp/example/b/example' failed
Failed to clone 'example'. Retry scheduled
fatal: repository 'git@github.com/VoltServer/example' does not exist
fatal: clone of 'git@github.com/VoltServer/example' into submodule path 'C:=
/projects/temp/example/b/example' failed
Failed to clone 'example' a second time, aborting

If I now edit .gitmodules to reflect the correct URL:

cd ../a
vim .gitmodules // format the URL correctly
git add .gitmodules
git commit -m "Fix .gitmodules URL."
cd ../b
git pull
git submodule update --init

This gives the same error message as before, except with the first line abo=
ut registering the submodule missing.

I've found a workaround if I manually edit .git/config in each clone to ref=
lect the correct URL.  After doing that, running "git submodule update --in=
it" works as expected.

My understanding is that I shouldn't ever have to edit anything in the .git=
 directory.  So, have I found a bug with .gitmodules being ignored after ad=
ding a given submodule?  Or is this just user error, a case of "Don't do th=
at.  Initialize the submodule with the correct URL and move on."?

Thanks,
Alex

Alex Levy
Firmware Engineer
VoltServer, Inc.
42 Ladd Street, Suite 227
East Greenwich, RI=A002818
alex.levy@VoltServer.com
888-622-8658 x413


