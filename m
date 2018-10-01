Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D0B1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 08:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbeJAOt1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 10:49:27 -0400
Received: from mail-oln040092069034.outbound.protection.outlook.com ([40.92.69.34]:36490
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727333AbeJAOt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 10:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3RXZy/Ql8TJspRIE4uCEF+DGU1PCnoVmORjSwY3GMg=;
 b=cFp7cMzMIiV+SMFHeZjeGZ01k3QRPkv9HNMvuF6e6mlidUIGO3rdAdNq6sCKT74yeI//gExHr1ztY1m43w6DMSDdVIGvDkKThqXJ0oLVsSRqEas1YL/CTtioK/a+P6wW+iiXPYyQxCSYzhrpakO9zxZOthXUMQv9Niw1x1wB8ZBGXFWm6r93L0F2E1nTV+9HlllRu0vB0bVVUH2xyYOKGWv9VT8POvJtblyo67jlQbpqdyA6UQewFl7fhAS3yl723sNUIcVts0IjMYoI0UgThwcrLjeP6PGJNbL5iFTZdBca4w9JYV8KO4r+TP98sm2xGYoWGDZ8PsWMzA5koIGLDA==
Received: from VE1EUR02FT020.eop-EUR02.prod.protection.outlook.com
 (10.152.12.52) by VE1EUR02HT120.eop-EUR02.prod.protection.outlook.com
 (10.152.13.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.20.1185.13; Mon, 1
 Oct 2018 08:12:49 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com (10.152.12.54) by
 VE1EUR02FT020.mail.protection.outlook.com (10.152.12.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1185.13 via Frontend Transport; Mon, 1 Oct 2018 08:12:49 +0000
Received: from VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9]) by VI1PR0902MB2223.eurprd09.prod.outlook.com
 ([fe80::1b9:1b61:c38c:8bd9%3]) with mapi id 15.20.1185.024; Mon, 1 Oct 2018
 08:12:49 +0000
From:   Jose Gisbert <jose.gisbert@live.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Topic: Using git svn rebase at quarantine environment or a feasible
 alternative to synchronize git and svn repositories
Thread-Index: AQHUWV6KIMpBHSj6s0iSXwsGXjkPyQ==
Date:   Mon, 1 Oct 2018 08:12:49 +0000
Message-ID: <VI1PR0902MB2223EA3FC0ACE7E9AFB7A6ACE2EF0@VI1PR0902MB2223.eurprd09.prod.outlook.com>
Accept-Language: es-ES, en-US
Content-Language: es-ES
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F34480C313F5201A69963D2D6076AA0170D9F9BB5C89FA4D9F6E7AD9E812C08A;UpperCasedChecksum:BE9C28918C7FC9759DEAC418E844B3D9BF643783BBD29C48B64779081F1FE2B9;SizeAsReceived:7040;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [2m+GtGFjhGAoL8IiIPDL17p3vId1vgME]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VE1EUR02HT120;6:hVTAVYZ6Fo06Xi2DPX3itpkraYfd3gOqjO/hMjvQyuzQ7w1dAZ7Dltm+VQ8XnoGLEVh5R1ubeI8Ss/zqvGa1Porey270bbfmJQnkVd8e+tINSlNydBgGvfrycwUWA/s/XmiwiUUGstn7Hxag19LTLH/VjUq4immmFQnIPpeoXy/YRqhBClgC9LnHw2PkFiMooNzWZcIin1fWSLCSj3To5KWGEIe6Y9p/SxMUFs5Ga4hfanQUa6/y1MEWA9+KTAUAP7uOWB5+W6qxfkm72AILBqlF7AFzfYdSm3NPHQnegVZzF7bayiGZ7XnPlFhmwmkXBCICFQEi83tGj0Dq0EJmS9L6Hd3Y1W8biZvKKOa1K1DY42UHqUwWE668+jS6t+G9jk/1vcb7TfX/HnUmuNalTNe7fb0c5vEq3KCHwPst2h4vu8skfyV9D4/tU9rczusFdmJC4nTVjV7ApH8xdF3/Pw==;5:bxQ68TsYUg2dwX0u6MxCg330cOXoFJ6tiihe5C1k5iVCZnTsCNI7jUIuGenLryTNWQei45App8sfXtmUchqMTfQIOj+CUpFbJXsJkqs3/5off1r5uVJtKDo79m8DPh8R2vgY0dk1QD+ox0lNki6v85fTwkwAxT46yJ2huxAy0+0=;7:5HiXWIs5NbN0TvuGqMwrcU7Yd4T6W03JEakYwAXBF/4j5Yc2BQeqi74AgMpsOY7YQnebDFpe32ZJxw+b1VADF0HzmZh2tZ5VMEpPoy2g5dEtTMGLO9lMkeT/fUc+MOTDiHF8evHDbIHNO3HsRq0ZL9hpBfm38NMiLzEa0fGzszw6/xpy7KnGuQAvvbE7wnvhW4Bxv0vFzsfc3Uvxw8GowdUD8vK1tRDlqhXt4E7wbKHmip1LEHG5yYmv9/hDRqYf
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT120;
x-ms-traffictypediagnostic: VE1EUR02HT120:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR02HT120;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT120;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(7070007)(51874003)(189003)(199004)(81156014)(6506007)(6306002)(8936002)(104016004)(1730700003)(102836004)(26005)(6346003)(5640700003)(6436002)(561944003)(68736007)(33656002)(305945005)(9686003)(105586002)(55016002)(14454004)(106356001)(8676002)(7696005)(99286004)(86362001)(966005)(476003)(74316002)(2351001)(25786009)(5250100002)(71190400001)(2501003)(34290500001)(71200400001)(2900100001)(56003)(5660300001)(14444005)(82202002)(486006)(97736004)(6916009)(53376002)(256004)(44832011);DIR:OUT;SFP:1901;SCL:1;SRVR:VE1EUR02HT120;H:VI1PR0902MB2223.eurprd09.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: live.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jose.gisbert@live.com; 
x-microsoft-antispam-message-info: /aXncMWJE7gqR0y8s+v3OD1oStyA4YNH60Y1ipmKOx+ZbF4kspi03ydRKYlvVPrkCuDegxwl8Ifm5DCtnmBsKGc/lFl2EpmA8QLhiFN3eOelpmkiZ3eGvO6jhJSRvB4RXxWwWklFvrqD++N/g8Y6iR3pRCbSVVkEW2L84KZqFIL6VpiAKmuFQImgOiPtkJ/qad2AGnXITr/+jjBUkUweDfXCEgrKfL8YuA+lRw4V4XQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aea21b9-637e-4c19-9275-08d62775ad74
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 24fd1209-d934-423e-a578-ee886993c07f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 08:12:49.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT120
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear members of the Git community,=0A=
=0A=
The enterprise I work for is planning to switch from svn to git.=0A=
=0A=
Before the complete switch to git we have decided to implement a scenario=
=0A=
where the two SCMs live together, being the svn repository the reference. W=
e=0A=
also want this scenario to be transparent for both SCM users.=0A=
=0A=
I read the articles referenced at the end of the email and I come to the=0A=
following solution.=0A=
=0A=
My proposal consists to import the svn repository to git using git svn and =
set=0A=
receive.denyCurrentBranch to updateInstead. Then install pre-receive and=0A=
post-receive hooks and set that repository as the central repository for gi=
t=0A=
users.=0A=
=0A=
The pre-receive hook does git svn rebase and, if there is an update at the =
svn=0A=
repository, rejects the push and instructs the user to do git pull. The=0A=
post-receive hook does git svn dcommit to update the state of the svn=0A=
repository, then instructs the user to do git pull too.=0A=
=0A=
Both scripts check the changes pushed are made at master before doing anyth=
ing=0A=
and exit after performing these tasks. branches.master.rebase is set to mer=
ges=0A=
at the user repository to avoid the histories of the central and the user=
=0A=
repositories diverge after doing git svn dcommit.=0A=
=0A=
However I'm stuck at this point because the pre-receive hook it's not allow=
ed=0A=
to do git svn rebase because update refs are not allowed at the quarantine=
=0A=
environment. I was sure that I tried this solution with a past version of g=
it=0A=
and it worked, but now I doubt this because the restriction to update refs =
at=0A=
quarantine environment was delivered at version 2.13, that dates from April=
=0A=
2017, if I'm not wrong.=0A=
=0A=
I don't know if this solution could be implemented or is there a better way=
 to=0A=
accomplish this kind of synchronization (I tried Tmate SubGit, but it didn'=
t=0A=
work for me and I don't know if we will be willing to purchase a license).=
=0A=
Could you help me with this question?=0A=
=0A=
I come here asking for help because I think this is the appropriate place t=
o=0A=
do so. I apologise if this is not the case. Any help is welcome. If anythin=
g=0A=
needs to be clarified, please, ask me to do so. I can share with you the=0A=
source code of the hook scripts, if necessary.=0A=
=0A=
Thanks in advance.=0A=
=0A=
Regards,=0A=
=0A=
Jose=0A=
=0A=
- https://stackoverflow.com/q/5586993=0A=
- https://stackoverflow.com/q/2014422=0A=
- http://davidsouther.com/#/posts/2012/04/13/git-svn-dcommit-hooks/=0A=
- https://gist.github.com/DavidSouther/8dfc6575f4d3a293be7c=
