Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D16A20248
	for <e@80x24.org>; Sat,  9 Mar 2019 10:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbfCIKrU (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 05:47:20 -0500
Received: from au-smtp-delivery-112.mimecast.com ([180.189.28.112]:52090 "EHLO
        au-smtp-delivery-112.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbfCIKrT (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Mar 2019 05:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=griffithuni.edu.au; s=mimecast20181013; t=1552128435; h=from:from:sender:reply-to:subject:subject:date:date: message-id:message-id:to:to:cc:mime-version:mime-version: content-type:content-type: content-transfer-encoding:content-transfer-encoding:in-reply-to: references; bh=gB3l4e8XBxq/MaKupW0PyEMrzkbb4NOWUcnRyvFGz5I=; b=CTHaagTq6lfduSejTZkjO9J17VZXIPjkOeMGTzWsoe+/t9kUeB7hAD+/6MIiOGIx72bJQD6S7Iw7tEFoSnruIlIadZOqMpag0+11k4dpNLG4+DSyYNGhQj8KbPNJJm3B1saQ7L49J6/2NPTX4QfAFr1No63xL/BLvVozE6zrfvA=
Received: from AUS01-ME1-obe.outbound.protection.outlook.com
 (mail-me1aus01lp2050.outbound.protection.outlook.com [104.47.116.50])
 (Using TLS) by relay.mimecast.com with ESMTP id
 au-mta-62-hkuU8rPKPw-G1fIgE9SYEg-1; Sat, 09 Mar 2019 21:46:10 +1100
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com (10.169.178.15) by
 SYXPR01MB0749.ausprd01.prod.outlook.com (10.169.176.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Sat, 9 Mar 2019 10:46:09 +0000
Received: from SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67]) by SYXPR01MB0957.ausprd01.prod.outlook.com
 ([fe80::30f5:512e:dcf1:8e67%5]) with mapi id 15.20.1686.020; Sat, 9 Mar 2019
 10:46:09 +0000
From:   Dimitri Joukoff <dimitri.joukoff@griffithuni.edu.au>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git server side "pre-receive" hook to create new repositories
Thread-Topic: Git server side "pre-receive" hook to create new repositories
Thread-Index: AQHU1mVOopyT6Ka+F0WRjDANg3ryOQ==
Date:   Sat, 9 Mar 2019 10:46:09 +0000
Message-ID: <SYXPR01MB095712C6765970605923A2FDDD4E0@SYXPR01MB0957.ausprd01.prod.outlook.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [1.132.105.217]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d947ec29-46fb-46bd-78c7-08d6a47c70d3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:SYXPR01MB0749;
x-ms-traffictypediagnostic: SYXPR01MB0749:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;SYXPR01MB0749;23:yjDzXacxIK4PDC9vyR0BEoi9hpAE3Fj94t1VCJ6oY?=
 =?us-ascii?Q?bu+waozKDqnWW2vliDc35jYuTRWstB8PxRH8R8a6Kcidx2ESVCq4pltX3bb8?=
 =?us-ascii?Q?fAkXotSy755G0G3TbQ5KndPKy3qZSZCUWV999hx2nA57iP7RH+qPSk/cJgHR?=
 =?us-ascii?Q?WXwm/giztAtTpBPiK7WWWGeDRQhd4S3Y2fxW/vriADDET9B0a/o9kUNqCGVe?=
 =?us-ascii?Q?Hfrgfz8s4I+tdVDqXStlqIfNSknUVkgeU/UxblaC3cPXh+ikQlIk3nTZarCx?=
 =?us-ascii?Q?2Txn+UwSxvtXnC2cYkj8GhNZKUBZaFtA0ZIUmwoL7m2Eczc2yzy+WnTSyXpf?=
 =?us-ascii?Q?XJW2m3uZF33ZUaCIijohRUXxluZTzODIFVRLMH2ugGMHWpiaynTDGP/lTrrJ?=
 =?us-ascii?Q?jA31xmq4nDLVHBJcNBPuxiie+kfAiFGE6r8mI82pGYRHze7vnnzWzO66n/Uo?=
 =?us-ascii?Q?tYVC2LjQ+OWcZnltD2S6prFDRzAUtZbUNA8NsxIep6P3BO9ptRy6oPbwIRGx?=
 =?us-ascii?Q?7Bvemc3GZg87nrR/fQ4QTP0QbA3hSi1B46302S7zKio3cuoyHShzgAdVg0qq?=
 =?us-ascii?Q?NM+70IkL63Qiw6AYGiIVnDl9cl9GLn5NyGiAz5qkI3mqvY1vrm97JjqdZkEw?=
 =?us-ascii?Q?YfmaOC0q4KcCZ8Qtu81TwtH981sELxKHUuRyBS4eX8smGw9x4c+j4U6gYAeB?=
 =?us-ascii?Q?QUFIFg/jhvz4fTXrvhWZLCzIBEuG6+1+g4WH8kgsvLU0bDov6jXx7nfTGXKC?=
 =?us-ascii?Q?KD+s82xwhWDuV18ca9MlGH4FFN5ncHw5pzW1Jhswp0XB7TN6is33YyLrMEH+?=
 =?us-ascii?Q?kC0cMsDDJ2ArDj+ajbb1KGssdUVRYCD/LN8SA4/0D5hP4hOSa3Y3dAt3Anv0?=
 =?us-ascii?Q?mCpTXVbUPeN3zDtVToUilLHBHU+NyJ3KMuRXS3nkhoHDT4t8fGXVjEAK0mUw?=
 =?us-ascii?Q?Mb3x8PiJuxDH9m1vAX//PwSOl84AvTXJ0B/ABeqvA3yhn9VlKmCFCO9sIMA9?=
 =?us-ascii?Q?1FLP+/dw1CuFfUgdVN96+FmISGBN5tKpstAcIITDq+O45CSNOFkUXRIHNKYg?=
 =?us-ascii?Q?T3NT6hlkyNE7GtERBqOZoE53K4/oXwk3pPQPl+GCzeeCoQ7mVPXu5lpIGTmT?=
 =?us-ascii?Q?VWCvezK7tY2YWP19QcnJcL7xCIfhy5E8urpdQ0mH0KvRvoLx67sRHsT/FGKP?=
 =?us-ascii?Q?xlIbybrW9MAotbgiqQEV5bTt/bFilWhCeP9ZbOwUrCFPPjpH/dWUbmddIb/f?=
 =?us-ascii?Q?W1k06nExu0eCDs4ovJxr/D+je4hLD9bbovux8JfIIcTNHaHqpgagW6sDzaIK?=
 =?us-ascii?Q?XZbzgFf460z/ZnUE52s2Kr+gMPqKlx5gS+pO2VaumrW?=
x-microsoft-antispam-prvs: <SYXPR01MB074903BFE4FCFADFFF44BEC5DD4E0@SYXPR01MB0749.ausprd01.prod.outlook.com>
x-forefront-prvs: 0971922F40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39850400004)(136003)(366004)(396003)(346002)(199004)(189003)(6306002)(55016002)(26005)(14444005)(71190400001)(256004)(316002)(71200400001)(2501003)(52536013)(6506007)(33656002)(102836004)(561944003)(5660300002)(97736004)(786003)(7736002)(25786009)(305945005)(2351001)(186003)(86362001)(99286004)(74316002)(106356001)(81166006)(1730700003)(88552002)(74482002)(6436002)(8936002)(2906002)(105586002)(7696005)(14454004)(8676002)(81156014)(478600001)(66574012)(966005)(6116002)(3846002)(476003)(66066001)(44832011)(68736007)(5640700003)(486006)(53936002)(6916009)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SYXPR01MB0749;H:SYXPR01MB0957.ausprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xwLBIclDhogNJOpHXYdGY9qEOgChwJjnI8VVg/G3GgyDbTrgUengfwJ93jnThIAiQO4anDTtK3NJPLWqSWZiJGCsh4rA/fx557Z6WUocNOXL1ToBH49fMyDvx0cAKDuUZu8Ye0uVCKfW6/D50LCOmcgshVNVZR6uiOkub3SBJTYjIoHBBVBxKFRymNkuHbICA1H9qQMfAAs7DS8+J55RLNI996ACBOjWojFA2zqXaXHgIoUw7+tHTi8KWa7PTujTLbOUojgj82kQKYCFUoNPb5Bj+sjsoo1hUaj6IcBUjPYEWilGwiSKa3zW1hz78yRj4I9koCWbiLlFNH7Chab3ZJM7T8pYw4FhvXTpkHPHyFlIwzb6CBTRMEapJ4x0VYn6WZYxixlL77pA2xaZvd8bfsawwdkQBjxRJ+wQoF9z1ys=
MIME-Version: 1.0
X-OriginatorOrg: griffithuni.edu.au
X-MS-Exchange-CrossTenant-Network-Message-Id: d947ec29-46fb-46bd-78c7-08d6a47c70d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2019 10:46:09.4590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5a7cc8ab-a4dc-4f9b-bf60-66714049ad62
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SYXPR01MB0749
X-MC-Unique: hkuU8rPKPw-G1fIgE9SYEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some time ago, Feb 2018, I put in a proposal at Swift.org , that would=0Aal=
low the Swift Package Manager to clone packages from the Internet to a=0Alo=
cal git server and use the local version without requiring updates to=0Athe=
 Swift package:=0Ahttps://forums.swift.org/t/proposal-to-enable-spm-to-use-=
a-local-repository-mirror/10291/5=0A.  At the time, I also raised an issue =
at=0Ahttps://github.com/github/platform-samples/issues/171 asking for the=
=0Afeature described below.  However, today I realised that that was not=0A=
the right place to make such a request, and hence I've written this email.=
=0A=0AThe above thread contains a solution to the local mirror problem whos=
e=0Aonly drawback was that new repositories had to be MANUALLY initialised=
=0Abare on the local server.  In all other respects, in my opinion, the=0As=
olution worked perfectly and saved me downloading huge amounts of data=0Aea=
ch time I performed a distribution clean on the project or switched to=0Aan=
other project that used the same package.  The solution published at=0ASwif=
t.org used a Ubuntu 16.04.2 server running Git 2.16.2, and the=0Aclient was=
 a Macbook Pro running MacOS with its default git.=0A=0AThus, this feature =
request is asking that the 'pre-receive' hook=0Atriggers when someone tries=
 to push to a repository regardless of=0Awhether the repository exists.  Th=
is would allow automatic creation of=0Anew repositories and smooth the work=
-flow described above.  If the=0Asemantics of the existing 'pre-receive' ho=
ok are such that it would not=0Abe suitable for such a purpose, then an alt=
ernative way of providing the=0Acall-back ability would be implemented.=0A=
=0ABest regards,=0ADimitri.=0A

