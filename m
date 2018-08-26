Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3CE41F428
	for <e@80x24.org>; Sun, 26 Aug 2018 11:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeHZPV4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 11:21:56 -0400
Received: from mail-co1nam03on0055.outbound.protection.outlook.com ([104.47.40.55]:39395
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726542AbeHZPV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 11:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=firemon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuOieryJPugimzpuEgNX6OYMPSwW57kAi8xCWU+Q0NI=;
 b=JsAGMyWosa8TuadeRwX7lyUW1dGxZld6JSft4b2++wRYqeqCMX2U14h/ZruO6W6oYwGGyxgOMH7RaR1FhKIICQosOrUly0hvLk7o49VOuxzJYYlBrDC39Dr4A6SwqU9rNPsnHPkTWJpZIYT6He7JVGf7e00HbzUREthmBVVccrs=
Received: from MWHPR10MB1517.namprd10.prod.outlook.com (10.169.233.150) by
 MWHPR10MB1486.namprd10.prod.outlook.com (10.169.233.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Sun, 26 Aug 2018 11:37:52 +0000
Received: from MWHPR10MB1517.namprd10.prod.outlook.com
 ([fe80::6142:aa0f:d578:65f]) by MWHPR10MB1517.namprd10.prod.outlook.com
 ([fe80::6142:aa0f:d578:65f%9]) with mapi id 15.20.1080.015; Sun, 26 Aug 2018
 11:37:52 +0000
From:   Bentzy Sagiv <bentzy.sagiv@firemon.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Get "Your branch is ahead of 'origin/master'" message when explicitly
 passing origin url at push command
Thread-Topic: Get "Your branch is ahead of 'origin/master'" message when
 explicitly passing origin url at push command
Thread-Index: AQHUPTBFQMkaI6MdA0+jaK8pPNuw1Q==
Date:   Sun, 26 Aug 2018 11:37:52 +0000
Message-ID: <MWHPR10MB1517982C582BEFB7D9171EFD9B340@MWHPR10MB1517.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bentzy.sagiv@firemon.com; 
x-originating-ip: [207.232.46.170]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR10MB1486;6:vihuiZQQBcWmvk5vAxLvRs4DhTkLuod7RUq75hvbCf5fr7DTJe21Vnm7yOu5KOJJLHSRzKbBXeZMsEYWptq1KgSJrZguscc1DsHXv7IURBQWYuhXoEuSSZXekmWY2zxlUI1mkmdHT5HIPapDcgfDhEKcPPT5PtOvOPSEcLaoovnVBRH/MoEzXMvTtgm9QXR0kOLhy7PqdEkDZ9xaqxWeMDrlk7WFDPhgSmqPR+udC7T9L7GdJa7lqNGiDtFyNM6xkW3ymODr7s3aUxnFfOc7teXn9v+ggJtJhqrzyST6sQ2EofeMfVwJ7zcS65EkT87hsTQ1odEzOhye39k7FgwsFD2m4kw/B3qLC2SoaUbl4fa0XPxBHOeKoT1r955EhGWvjhCeQPRGi9E6CRkSdhxMcEOBkdvCp7xNRV+EffNuX+gjgB9DdivhIsoPFM9ieTdnmoXP0lPY+qiwf0aInsH8Ag==;5:vWtWyurw5txwI4w0fDsQsKHwAklOCOreXmr+wBLUno/huzEtWGe9gEIs7CofTJWh73Lt63Eik6t6ZrBpBtw/sWIiTH+ZAEsFj1VjxAFYiauMWs/fvfDzsDPhDuHnVE2f89Y50Uym6Yr2KALiwEJg3ABAwW0BFZbd0BW3CnVri94=;7:1YAe9Vp+xPWZ88k8AH4o7RKdJ4EK3VaURVw846PK+VV7C/ub7MNBBZTU0Fwt+R5dIyCSW0Nc2aPRmrIx1ZidgrrVlGSEumSl0OH8E3aDip2NzNnNkkOxC1trlGHMXKKPk70qEQWOU9hy5Bc6LcNXuUqzuMuoHdx9qMN+OTLPfVIdEA2hHuRYwiQgPnJVhHOswracyO5MxRjLHTNRynArqGu8qwAL+EsqY/EWYumw0TU85pkV/9BkYtT01gmaZzQW
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bcc3d65e-1572-4d75-4d58-08d60b485be5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR10MB1486;
x-ms-traffictypediagnostic: MWHPR10MB1486:
x-microsoft-antispam-prvs: <MWHPR10MB14867D1EB2B3D1FFCDE3F9A69B340@MWHPR10MB1486.namprd10.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(63843785518722);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:MWHPR10MB1486;BCL:0;PCL:0;RULEID:;SRVR:MWHPR10MB1486;
x-forefront-prvs: 0776C39A48
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(39840400004)(346002)(366004)(189003)(199004)(6506007)(7736002)(305945005)(256004)(5660300001)(2501003)(186003)(478600001)(97736004)(966005)(14454004)(86362001)(5250100002)(6436002)(5640700003)(55016002)(66066001)(14444005)(8936002)(2906002)(6916009)(81156014)(6306002)(486006)(81166006)(316002)(25786009)(105586002)(106356001)(44832011)(33656002)(2351001)(2900100001)(53936002)(6116002)(3846002)(9686003)(68736007)(102836004)(26005)(99286004)(74316002)(1730700003)(476003)(551544002)(7696005)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR10MB1486;H:MWHPR10MB1517.namprd10.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: firemon.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bdgU+GZQRvQCHH/80t8XhxGGLZaQqAHtCFsXl1TvUSAcnxpElOH1l2FB9VTOwcCFJMvsS19KnJ5VnU7kh9EGfTFNkBrfNM5gt2d4uFKovnkIYtXUhMkg0aqC9FlPJvdOgCh1YgnPSBTJmCd4+VODj0GY1sqlNeQvWK0pJ+P5eYjCozo6Mjafkq0Y0smEYjZ/VZTw896vVDH1IBAeLa2iR2rnL6S+FOgZZv+cndDyrwj9XF9vSpgqN9r/qtygJxlHlZzeeVkgKpXAEjwAHrinSkSIP05WkOGC6er0svZKW2ReVFppCY/VHiHq8uMkxsgNe3UaOd40KZ9F4JGE9StqJNCT+ViG+k3rnZ6TITZuBQg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: firemon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcc3d65e-1572-4d75-4d58-08d60b485be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2018 11:37:52.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: acd234ad-0e86-43b0-a357-9dce4d20f5c4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1486
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git version 2.7.4
___________________________________________________________________________=
___________________________

First try: NOT passing origin url explicitly

ubuntu@ci-bentzy:/var/lib/jenkins$ git remote -v
origin  https://USER @ bitbucket.org/OWNER/jenkinsconf-repo.git (fetch)
origin  https://USER @ bitbucket.org/OWNER/jenkinsconf-repo.git (push)

ubuntu@ci-bentzy:/var/lib/jenkins$ sudo vim jobs/bentzytest1/config.xml
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git add .
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git commit -m'First try' -a
[master b8549c3] First try
 1 file changed, 2 insertions(+), 2 deletions(-)
=20
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push
Password for 'https://USER @ bitbucket.org':
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 399 bytes | 0 bytes/s, done.
Total 5 (delta 3), reused 0 (delta 0)
To https://USER @ bitbucket.org/OWNER/jenkinsconf-repo.git
   d2cc229..b8549c3  master -> master
 =20
ubuntu@ci-bentzy:/var/lib/jenkins$ git status
On branch master
Your branch is up-to-date with 'origin/master'.
nothing to commit, working directory clean
ubuntu@ci-bentzy:/var/lib/jenkins$

___________________________________________________________________________=
___________________________

Second try: passing origin url explicitily

ubuntu@ci-bentzy:/var/lib/jenkins$ git remote -v                      =20
origin  https://USER @ bitbucket.org/OWNER/jenkinsconf-repo.git (fetch)
origin  https://USER @ bitbucket.org/OWNER/jenkinsconf-repo.git (push)

ubuntu@ci-bentzy:/var/lib/jenkins$ sudo vim jobs/bentzytest1/config.xml
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git add .
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git commit -m'Second try' -a
[master 331ac84] Second try
 1 file changed, 1 insertion(+), 1 deletion(-)
=20
ubuntu@ci-bentzy:/var/lib/jenkins$ sudo git push https://bitbucket.org/OWNE=
R/jenkinsconf-repo.git
Username for 'https://bitbucket.org': USER
Password for 'https://USER @ bitbucket.org':
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 403 bytes | 0 bytes/s, done.
Total 5 (delta 3), reused 0 (delta 0)
To https://bitbucket.org/OWNER/jenkinsconf-repo.git
   7383066..331ac84  master -> master
 =20
ubuntu@ci-bentzy:/var/lib/jenkins$ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
nothing to commit, working directory clean

___________________________________________________________________________=
___________________________
     =20
An additional " sudo git push" (without explicit origin) solves the issue



Bentzy Sagiv
=20

=A0 =20
   =20
=20
    =
