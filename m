Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AFA71F462
	for <e@80x24.org>; Wed, 22 May 2019 10:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfEVKAz (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 06:00:55 -0400
Received: from mail-eopbgr60084.outbound.protection.outlook.com ([40.107.6.84]:14300
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728406AbfEVKAy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 06:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intenogroup.onmicrosoft.com; s=selector1-intenogroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWF+UKoc3O5zHdiybmBSWM6UmCwj/CVmAglOAec2DuU=;
 b=bRKgXgFySSo9DRkLjHSQlbdzi3/UmkurWOvRvAMowHmJIuQL4312Fwo6YdFcrTGQtCbnqzSP44B9cpnefQQAhxWuTj4JCSRvyIjHQT9dFK00UCQSK52CDPqKttGOE8QKOJ5XY9OK2tVdVGvSkBxdu2EwBhCG5jS1wYfX2dzRk0g=
Received: from VI1PR08MB3454.eurprd08.prod.outlook.com (20.177.59.20) by
 VI1PR08MB5534.eurprd08.prod.outlook.com (52.133.247.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.17; Wed, 22 May 2019 10:00:51 +0000
Received: from VI1PR08MB3454.eurprd08.prod.outlook.com
 ([fe80::dc78:5268:40ff:dfd5]) by VI1PR08MB3454.eurprd08.prod.outlook.com
 ([fe80::dc78:5268:40ff:dfd5%3]) with mapi id 15.20.1900.020; Wed, 22 May 2019
 10:00:51 +0000
From:   Oussama Ghorbel <oussama.ghorbel@iopsys.eu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: strange behavior of git diff-index
Thread-Topic: strange behavior of git diff-index
Thread-Index: AQHVEITFUMiusrwMTUmKw6ax3XbKfQ==
Date:   Wed, 22 May 2019 10:00:50 +0000
Message-ID: <VI1PR08MB3454100258C23CB1F2B709F5EB000@VI1PR08MB3454.eurprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oussama.ghorbel@iopsys.eu; 
x-originating-ip: [2001:9b0:1:3302:8a97:8e8e:d547:4f2c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15aee0cd-a5c1-4fef-bc46-08d6de9c5f1f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:VI1PR08MB5534;
x-ms-traffictypediagnostic: VI1PR08MB5534:
x-microsoft-antispam-prvs: <VI1PR08MB55347B1ECFA1A6EA33808393EB000@VI1PR08MB5534.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0045236D47
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39840400004)(396003)(376002)(136003)(346002)(199004)(189003)(486006)(7696005)(44832011)(99286004)(6116002)(71200400001)(71190400001)(2351001)(476003)(8936002)(14454004)(25786009)(5660300002)(53936002)(33656002)(102836004)(6506007)(2906002)(256004)(5640700003)(6436002)(55016002)(86362001)(508600001)(52536014)(68736007)(66476007)(316002)(66446008)(64756008)(6916009)(74482002)(4744005)(9686003)(46003)(7736002)(1730700003)(81166006)(81156014)(66556008)(76116006)(73956011)(66946007)(2501003)(74316002)(8676002)(305945005)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB5534;H:VI1PR08MB3454.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: iopsys.eu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yVwLpRsNLS6G4XI8CPXK6Slo2rnP4NjQOhM3xKprHmHrwTTXcnhxK9ljPXSb8EIRNEUl4pCTb6+j/pkA0Pc3nekV8ihFB4wtRH60vAiFOYosyANuVJ4oHxZKdpLtjIDQUqYdMeoAiLkSstemZbCcqTJz5nLVrHv5C7AKoI1noQTRo4XTPLWv/cvaMuKlQxI+sDtoK84+UHTdThyxMuk137uQfkZ/jwNqHHxjpQqIzC2bdJyQvxEGM/0uqLRlD5d3qZOPz6ehkV7+omfWfWgs2dCkKv/OYDQf3g9De0MOVZiWO3uBXcHX5k1ELIulgg+2rwJBkAJHbc62TSizN5Je1DhJvSPkPoceqZuhaQvs3h6NCQgZGPdzG61IhUfijzLbxJcor+Q2w7eLUI4X5fMQntSD+lCtUq4GTOOQ98aBVtM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 15aee0cd-a5c1-4fef-bc46-08d6de9c5f1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 10:00:50.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ff78d65-2de4-40f5-8675-0569e5c7a65d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5534
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,=0A=
=0A=
git diff-index is giving me incorrect information, however if I run git dif=
f, then git diff-index again it will show the correct information.=0A=
The steps are the following:=0A=
$ git diff-index --name-only HEAD=0A=
git appears to list all files in the project irrespective if they modified =
or not=0A=
$ git diff=0A=
$ git diff --cached=0A=
will show nothing. So I don't have any modification.=A0=0A=
Now strangely if I run git diff-index, it will also show nothing which is c=
orrection behavior.=0A=
=0A=
my git version is 2.7.4=0A=
Any explanation?=0A=
=0A=
Thanks,=0A=
Oussama=
