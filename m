Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466251F405
	for <e@80x24.org>; Wed, 19 Dec 2018 02:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbeLSCmt (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 21:42:49 -0500
Received: from out1103.nz.smxemail.com ([203.84.134.34]:62357 "EHLO
        out1103.nz.smxemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbeLSCmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 21:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; d=nz.smxemail.com; s=alpha; c=relaxed/relaxed;
        q=dns/txt; i=@nz.smxemail.com; t=1545187366;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc;
        bh=9GWEatulytEn3GsJk5EA0RevEiTcMdNE9p+PLV/lD1c=;
        b=iXS5ZZMa5Nkjvq7shQ/TVl/ZNC0myfHL/349u7zgU78gu5jL4R6d4owe5+L5wczK
        q14rE2qZGUQ5LGkliA9aB8QTwcRd3NMEwJYcN68oyVkFdRmKCFcJjQCXJgmDxojN
        G/ZWx3ekE/0IathkcXUabPBdCDGMJ4Wwo4lK/096SSk=;
Received: from AUS01-SY3-obe.outbound.protection.outlook.com ([104.47.117.58])
        by shared.nz.smxemail.com with ESMTP (using TLSv1.2
        with cipher AES256-SHA256 (256/256 bits))
        id 5C19B026-6A3728DC@mta1101.omr;
        Wed, 19 Dec 2018 02:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=terabytenz.onmicrosoft.com; s=selector1-terabyte-co-nz;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GWEatulytEn3GsJk5EA0RevEiTcMdNE9p+PLV/lD1c=;
 b=iJWsoOaVpsUERkmIMJyqb7PiNqz8uVqjOKu/MyVOtJW31sVpvFu4g0mXJP9lGvY0Kz/QGj76IDcV0fw8L1rb/M0Zdf8/PGUOiprF+3sZYenwmFn/ArSbeDsRY64bj3WHnwIMHZsrUq9QLRLzU+OXY2ebO2i9PtXdPe2g22XAYo0=
Received: from ME1PR01MB1121.ausprd01.prod.outlook.com (10.171.4.7) by
 ME1SPR00MB133.ausprd01.prod.outlook.com (10.171.7.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.17; Wed, 19 Dec 2018 02:42:43 +0000
Received: from ME1PR01MB1121.ausprd01.prod.outlook.com
 ([fe80::8c52:3018:4fad:2580]) by ME1PR01MB1121.ausprd01.prod.outlook.com
 ([fe80::8c52:3018:4fad:2580%2]) with mapi id 15.20.1425.023; Wed, 19 Dec 2018
 02:42:43 +0000
From:   Andrew Shearer <andrew@terabyte.co.nz>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: error: Use of uninitialized value $hash in chomp
Thread-Topic: error: Use of uninitialized value $hash in chomp
Thread-Index: AdSXRIAwQLCkx8aZREeNeTGRosl9oQ==
Date:   Wed, 19 Dec 2018 02:42:42 +0000
Message-ID: <ME1PR01MB11218735004432E3E26C66FFE1BE0@ME1PR01MB1121.ausprd01.prod.outlook.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrew@terabyte.co.nz; 
x-originating-ip: [210.48.100.210]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;ME1SPR00MB133;6:hL1Muq+pJ0PHDDIzEx7X7XUJ31g8CKguzgzVfaCVjoWBNVcBx25U4SOEwzxkdxMrHkOHZ5KF0VdDwDPHy9ox/U4kqsZxAy+jXr4NNfwdyb3zHr/q2DOInPL1DcVl+t3DAw14htDm/sN677s33WdevwPqbAJxy3NeFMi/N9BugcYTyEBLZRq0H4Sx1OLnwa1G6l+x8gFPVPENaCerfv6SkDClFKEY+sPJ7zPpP5Y8b5iXr+M6yoiYEBkP2MnyAW7U2HWfuLVbeUaAsRJsOq4jGezEcbjMV8tvDbEqTPN0GD14gXYMGempAL9LQ0C0G3Jw7HQO/Wvb3OJ5ndruE6YlV7WQ3kDdYONaPDAngN6Iz2g+VFOV9Te+9dkp6DJq2t3/eUDdIt95DZOcCcKN4E/yUf3rZWL0Hv9knKFtaAaKJcxcUle4/7hghd38B1W/jOxP5jC8hPxJBvbQlxeJcMPG4A==;5:/MouiBXz9LjdTiTUiQdaMVlZFY+NuDky8tiZpItHYVA4FuxfM1wEu71sQCufCDy+a/dZL4Nm7YCvy7ueeVYb3PmlzAVM/2WxuPQUroJ8Wq7MsEsmuHy4bs3RqgFBd41fdzXJkiL495S52kJsVB4SCAwKd9tlg1AXEgziWWaaiDk=;7:Jq1exxRyl0RfBi1kkgX5yFrKUG6N5H5nGS/o6nA9fOwA90fB/XSGtZJ2N6xF8f507rkPBTGOv5t9rcDvg5jzRTg4l4jam3iBxwgcBgKf+iY94qIKDpMD/QE7T35jc8ObSJWZzRkBVg6bu36zrro/iQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 778308ae-9a84-4c9d-3d1e-08d6655ba69e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:ME1SPR00MB133;
x-ms-traffictypediagnostic: ME1SPR00MB133:
x-microsoft-antispam-prvs: <ME1SPR00MB1331837CC48B2A9B9DBB9CDE1BE0@ME1SPR00MB133.ausprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699051)(76991095);SRVR:ME1SPR00MB133;BCL:0;PCL:0;RULEID:;SRVR:ME1SPR00MB133;
x-forefront-prvs: 0891BC3F3D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(39830400003)(346002)(366004)(396003)(189003)(199004)(6916009)(25786009)(9686003)(68736007)(14454004)(81166006)(81156014)(8676002)(2501003)(8936002)(305945005)(71190400001)(105586002)(106356001)(1730700003)(53936002)(71200400001)(74316002)(6116002)(5640700003)(86362001)(2351001)(55016002)(6436002)(3846002)(19627235002)(2906002)(316002)(102836004)(6506007)(5660300001)(66066001)(26005)(256004)(97736004)(476003)(33656002)(74482002)(99286004)(186003)(508600001)(486006)(7736002)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:ME1SPR00MB133;H:ME1PR01MB1121.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: terabyte.co.nz does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: vLX26QP4DTj1ErlTv9mv1kNPCwL6IbRxc66xiu2u+5IkeMfgpQH/P5P+tc7NOv+mBE7SJmUWFNIzPJp66y340IIi/Q6bfdFu9u9wXecSOzTH16gMhGCz7p9/muxKsk3GwoaLnv4kg+GrvEPnDkulrNd/MLh0X+WqlVfcfPqdIxxUtCV1udaB6pxZHChv3B9TpbO8clS+0DT8dOhZU4X3EdnwRjW6b9SaSJh9N/uvBk5ishzOt8s5eRj3pFhk4dzSuCUCn/7NlyHtFfgcZZcdcrLgSq4EG/y8unB59Gi/g+YYC34RezZnzqdei1IoHIst
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: terabyte.co.nz
X-MS-Exchange-CrossTenant-Network-Message-Id: 778308ae-9a84-4c9d-3d1e-08d6655ba69e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2018 02:42:43.0490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ea17f86c-29aa-405c-bbb3-b55968f53184
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME1SPR00MB133
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I am using a "git svn clone" command to extract our project history from sv=
n into git.
About 30m into the process it fails with:

r50739 =3D 2a1491de1353b1e3cce50d8f9d383407218a44f1 (refs/remotes/git-svn)
fatal: Cannot open '.git/Git_svn_delta_33316_0_UkxiJV': Permission denied
Use of uninitialized value $hash in chomp at C:/Program Files/Git/mingw64/s=
hare/perl5/Git.pm line 929, <GEN11> line 36311.
hash-object -w --stdin-paths --no-filters: command returned error: 128

error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/lib=
exec/git-core\git-svn line 0.
error closing pipe: Bad file descriptor at C:/Program Files/Git/mingw64/lib=
exec/git-core\git-svn line 0.
        (in cleanup)  at /usr/share/perl5/vendor_perl/Error.pm line 198 dur=
ing global destruction.

I tried updating to the latest build, 2.20.1.windows, but it still fails.

There is nothing particularly special about svn changeset 50739 that I can =
see compared to any other.
Anyone know why this might be failing or how I could resolve it?

Thanks
Andrew

