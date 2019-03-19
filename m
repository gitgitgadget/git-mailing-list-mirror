Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0FA2202BB
	for <e@80x24.org>; Tue, 19 Mar 2019 09:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfCSJGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 05:06:00 -0400
Received: from smtppost.atos.net ([193.56.114.166]:15841 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSJF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 05:05:59 -0400
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost6.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 354c_5d1b_f3fcafdd_6524_4ffb_ab7c_566e2da4e4c7;
        Tue, 19 Mar 2019 10:05:56 +0100
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x2J95qGv009992
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 10:05:52 +0100
Received: from DEFTHW99ETZMSX.ww931.my-it-solutions.net (defthw99etzmsx.ww931.my-it-solutions.net [10.86.142.54])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id x2J95ptV015388
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 10:05:52 +0100
Received: from DEERLM99ETUMSX.ww931.my-it-solutions.net (10.86.142.96) by
 DEFTHW99ETZMSX.ww931.my-it-solutions.net (10.86.142.54) with Microsoft SMTP
 Server (TLS) id 14.3.439.0; Tue, 19 Mar 2019 10:05:50 +0100
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.96) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 19 Mar 2019 10:05:50 +0100
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (20.177.122.208) by
 DB7PR02MB3722.eurprd02.prod.outlook.com (52.134.97.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 19 Mar 2019 09:05:49 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::4cb8:82d9:101c:bead]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::4cb8:82d9:101c:bead%5]) with mapi id 15.20.1709.015; Tue, 19 Mar 2019
 09:05:49 +0000
From:   "REIX, Tony" <tony.reix@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: git on AIX: daemon.c & t5570-git-daemon.sh
Thread-Topic: git on AIX: daemon.c & t5570-git-daemon.sh
Thread-Index: AQHU3aqwxxAYeNkk1k++4Tm5hcAzmaYSqer4
Date:   Tue, 19 Mar 2019 09:05:49 +0000
Message-ID: <DB7PR02MB46634F68900E0F81B0110AF586400@DB7PR02MB4663.eurprd02.prod.outlook.com>
References: <DB7PR02MB466360C2CBC44AE5FEC22CC586470@DB7PR02MB4663.eurprd02.prod.outlook.com>
In-Reply-To: <DB7PR02MB466360C2CBC44AE5FEC22CC586470@DB7PR02MB4663.eurprd02.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tony.reix@atos.net; 
x-originating-ip: [193.56.241.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5698fe02-8905-4536-29fb-08d6ac4a14a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(49563074)(7193020);SRVR:DB7PR02MB3722;
x-ms-traffictypediagnostic: DB7PR02MB3722:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <DB7PR02MB3722218BE000E5A4A991361E86400@DB7PR02MB3722.eurprd02.prod.outlook.com>
x-forefront-prvs: 0981815F2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(366004)(376002)(39860400002)(199004)(189003)(186003)(14454004)(5024004)(478600001)(76176011)(105586002)(256004)(8936002)(26005)(53936002)(2501003)(6116002)(6916009)(55016002)(106356001)(52536014)(71200400001)(6506007)(71190400001)(86362001)(9686003)(6306002)(2351001)(8676002)(7696005)(99286004)(81166006)(3846002)(81156014)(1730700003)(99936001)(7736002)(25786009)(66066001)(305945005)(486006)(5660300002)(5640700003)(33656002)(316002)(476003)(68736007)(74316002)(446003)(2906002)(6436002)(15974865002)(97736004)(966005)(102836004)(11346002)(18886075002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB3722;H:DB7PR02MB4663.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tDOP1wVqpb58YNy5nA8kvq8AyNrHJNoG5u1O5vJFVMWzCpOwQCPTqqv/+3fHq1nQ5WFvH28b4pCaF72ggbI3l4alVqSS/dHvh3qdrrHmUcEmQQcm3E9Yhl/tto2x5NxiwzAZr6eUFIjnQ1oTm9OxU6W1rbVreHEnWiCvoresrowclyxViH0Beetixl6KqdZ9gKQ5JD1WjAvQW8hEl8ho/EdoNyWNIGOaiEQnthI/Kw0LGPwxL6bcRyCQNwP1vH07H2xox6h2F59Zfd18Fbv+8ILuPiaI6Iret+8svgZZlqAACmpVCcUfYNSiZMRJLSlllZFgICSKGd7b15CJ63lzP2BS7WV7R/fLCc7YXJBsSdch7iNUH5fbi6SQYxlaCE9DehHD7nTVG5x+NxMLy+4sAKyw1nxVfLWlmufLbPr3LpM=
Content-Type: multipart/mixed;
        boundary="_002_DB7PR02MB46634F68900E0F81B0110AF586400DB7PR02MB4663eurp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5698fe02-8905-4536-29fb-08d6ac4a14a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2019 09:05:49.1726
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB3722
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--_002_DB7PR02MB46634F68900E0F81B0110AF586400DB7PR02MB4663eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

When testing version 2.21.0 of git on AIX (6.1 & 7.2), I have found an issu=
e with daemon.c and test t5570-git-daemon.sh : within test 4, the child_han=
dler() code gets crazy and calls itself recursively till the process crashe=
s. We do not have a clear idea why this issue occurs. Maybe that this issue=
 also appears on other operating  systems.

This code:

static void child_handler(int signo)
{
=A0=A0=A0=A0=A0=A0=A0 signal(SIGCHLD, child_handler);
}
is the root cause and it appeared in 2008, for SysV :
=A0=A0  https://git.kernel.org/pub/scm/git/git.git/commit/daemon.c?id=3Dbd7=
b371e9c2aeb0aaf228dc1655e8d04fca6f797

I suggest to use the attached patch  git-2.21.0-SIGCHLD-handler-v3.patch, s=
o that this issue on AIX disappears.
Moreover, this code may also be useful for other operating systems. Someone=
 should tests it on Solaris.

I have checked that this patch is OK (build & test t5570-git-daemon.sh) on =
Linux/Power (Fedora 28) with GCC (v8.1).

I've also checked on Linux/Power that the 21 tests of t5570-git-daemon.sh a=
re OK when one replaces the existing code using:
=A0=A0=A0 signal(SIGCHLD, child_handler);
by the code dedicated to AIX.
I mean to say that this sigaction(SIGCHLD, &sa, NULL) code could also repla=
ce on Linux the current potentially-dangerous code based on signal(SIGCHLD,=
 child_handler).

Regards,

Tony
=20


tony.reix@atos.net

ATOS / Bull SAS
ATOS Expert
IBM Coop Architect & Technical Leader

Office=A0: +33 (0) 4 76 29 72 67
1 rue de Provence - 38432 =C9chirolles - France
www.atos.net            =

--_002_DB7PR02MB46634F68900E0F81B0110AF586400DB7PR02MB4663eurp_
Content-Type: text/x-patch; name="git-2.21.0-SIGCHLD-handler-v3.patch"
Content-Description: git-2.21.0-SIGCHLD-handler-v3.patch
Content-Disposition: attachment;
	filename="git-2.21.0-SIGCHLD-handler-v3.patch"; size=827;
	creation-date="Tue, 19 Mar 2019 09:04:17 GMT";
	modification-date="Tue, 19 Mar 2019 09:04:17 GMT"
Content-Transfer-Encoding: base64

LS0tIC4vZGFlbW9uLmMuT1JJR0lOCTIwMTktMDMtMTggMTc6NTM6NTEgKzAxMDAKKysrIC4vZGFl
bW9uLmMJMjAxOS0wMy0xOCAxODowMDoxNiArMDEwMApAQCAtOTQzLDggKzk0MywxMSBAQAogCSAq
IE90aGVyd2lzZSBlbXB0eSBoYW5kbGVyIGJlY2F1c2Ugc3lzdGVtY2FsbHMgd2lsbCBnZXQgaW50
ZXJydXB0ZWQKIAkgKiB1cG9uIHNpZ25hbCByZWNlaXB0CiAJICogU3lzViBuZWVkcyB0aGUgaGFu
ZGxlciB0byBiZSByZWFybWVkCisJICogQUlYIGRvZXMgTk9UIGxpa2Ugc29tZXRpbWVzICh0NTU3
MC1naXQtZGFlbW9uIHRlc3QgNCkgdG8gcmVhcm0gaXQuCiAJICovCisjaWZuZGVmIF9BSVgKIAlz
aWduYWwoU0lHQ0hMRCwgY2hpbGRfaGFuZGxlcik7CisjZW5kaWYKIH0KIAogc3RhdGljIGludCBz
ZXRfcmV1c2VfYWRkcihpbnQgc29ja2ZkKQpAQCAtMTE1NSw3ICsxMTU4LDE5IEBACiAJCXBmZFtp
XS5ldmVudHMgPSBQT0xMSU47CiAJfQogCisjaWZkZWYgX0FJWAorCS8qIEFJWCBkb2VzIE5PVCBs
aWtlIHNvbWV0aW1lcyAodDU1NzAtZ2l0LWRhZW1vbiB0ZXN0IDQpIHRvIHJlYXJtIHRoZSBTSUdD
SExEIGhhbmRsZXIgKi8KKwlzdHJ1Y3Qgc2lnYWN0aW9uIHNhOworCisJYnplcm8oJnNhLCBzaXpl
b2Yoc2EpKTsKKwlzYS5zYV9oYW5kbGVyID0gY2hpbGRfaGFuZGxlcjsKKwlzYS5zYV9mbGFncyAg
ID0gMDsKKwlzaWdlbXB0eXNldCgmc2Euc2FfbWFzayk7CisKKwlzaWdhY3Rpb24oU0lHQ0hMRCwg
JnNhLCBOVUxMKTsKKyNlbHNlCiAJc2lnbmFsKFNJR0NITEQsIGNoaWxkX2hhbmRsZXIpOworI2Vu
ZGlmCiAKIAlmb3IgKDs7KSB7CiAJCWludCBpOwo=

--_002_DB7PR02MB46634F68900E0F81B0110AF586400DB7PR02MB4663eurp_--
