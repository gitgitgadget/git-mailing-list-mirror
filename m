Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D345E20A40
	for <e@80x24.org>; Tue,  5 Dec 2017 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbdLEMrj (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 07:47:39 -0500
Received: from smtppost.atos.net ([193.56.114.164]:4645 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdLEMri (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 07:47:38 -0500
X-Greylist: delayed 389 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Dec 2017 07:47:37 EST
Received: from mail3-ext.my-it-solutions.net (mail3-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 223d_b5c8_e367a098_33eb_4869_bdec_ac8f8b630a0f;
        Tue, 05 Dec 2017 13:41:06 +0100
Received: from mail2-int.my-it-solutions.net ([10.92.32.13])
        by mail3-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id vB5Cf5Ep027869
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2017 13:41:05 +0100
Received: from DEERLM99ETSMSX.ww931.my-it-solutions.net ([10.86.142.104])
        by mail2-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id vB5Cf5FL020496
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 5 Dec 2017 13:41:05 +0100
Received: from DEFTHW99ETUMSX.ww931.my-it-solutions.net (10.86.142.49) by
 DEERLM99ETSMSX.ww931.my-it-solutions.net (10.86.142.104) with Microsoft SMTP
 Server (TLS) id 14.3.361.1; Tue, 5 Dec 2017 13:41:04 +0100
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.49) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 5 Dec 2017 13:41:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atos365.onmicrosoft.com; s=selector1-atos-net;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=nSsuFzCV8SXKt/LvC/53Hw0EZsTPSU8vKJzWifZlFt8=;
 b=x/TN9Hx8NUvIHmJIuJyAbMYKYgchEGGHaREznu1oFTpiFMXGrMJB2Gm5z0u2KhgUPgkn5nUc5qp3UkDA1gdZlkqrqJUThqZ+fFdEWhFuorx7fNQMBzHtoGMuBcdrvOTE9srlpb7xwqWhfe2+pUkhtRvmMMfY31rG062qYBQirJU=
Received: from HE1PR0201MB1993.eurprd02.prod.outlook.com (10.167.187.135) by
 HE1PR0201MB1996.eurprd02.prod.outlook.com (10.167.187.138) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.282.5; Tue, 5 Dec
 2017 12:41:03 +0000
Received: from HE1PR0201MB1993.eurprd02.prod.outlook.com
 ([fe80::85e3:d7fc:56f8:603a]) by HE1PR0201MB1993.eurprd02.prod.outlook.com
 ([fe80::85e3:d7fc:56f8:603a%13]) with mapi id 15.20.0302.007; Tue, 5 Dec 2017
 12:41:03 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        liam Beguin <liambeguin@gmail.com>
Subject: RE: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
Thread-Topic: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
Thread-Index: AQHTbISjjspf9HuVa0aHkPOeSXeP1KMzVSkAgADIBICAAJV/tIAAADxA
Date:   Tue, 5 Dec 2017 12:41:03 +0000
Message-ID: <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-7-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
        <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
 <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [157.203.176.168]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0201MB1996;6:JZSinP7P2h2vOUmDrvmw6WT1hOgizzHLsVKKWFDlV2Z/gIVIboLdN4ImVobw6X+DNGkscly73teLoQ46AC5X1BINjskxfLnf0aVKF+dWi6zs1VasktujP3ZpgrPumLrN/dUoURmjkoD29G9e/Cc3hW2MOAvYDQHAcFhSrqtiJaJjYDACz1kXtCw97ppe2IcV49gOp7mcfyfooWv1xVMrlDpoqhecZLOgzg0xz//frluGvQcQQP8gklfWMumW0HgvdjggQ9lyoOlpIdt7XCNjmXfMv4x9kwEenWaXJm6CkmmPzEvD/947LNJ5Adq5xg01AHeu1/SqMoUMgn8eKgBn1vyTE+MejBUQSy9artanmyo=;5:laysoGclKpSH9yR0vkclEKPsQsihwwB8X7TNBrfaS6f5ZE0ptH+jniIhXYsN50P5js21fv51Zx4MsPD46ID31seqW3dcGtmFNz1XinhrrmKQowYeBze+QIQtMHma995XUF833C7REYfpeKL/kOdVeGH3R+xZxIQsd+RH+1OuRYY=;24:ZFJj6fnNanDmUPZJvY+8BOqxMzL8J7vztXvexfJH3hqxbFJCRV3l8ts8MuKOPr+KXbL7KLPkXI6AR8Lkp2hhbE0RbKH5r3vwI6BwCF21Zf4=;7:cwHVQdgHiePnyvBp00Uw09l174HvVyTbgxkiZWEcY1eIG2zSWxa5K6dez9k/X3TmZT6GBIlWkj8E5XY432uErn8+4o4nhZrwdJEu2PZmzs44kRJDHfZvGW3PFjjq/KJRgmN5gKbxFQCCTeKkPebMpBI0a7LykWVJ9oIHYA93uTMARinpS9/hoB1u9Vu1KhsJoz/q8qhGwTtCC/FGszTyZzjwKqcitrN7P3446bdwqkADYA07F3GxQFr7J6J3jHw3
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: a8b272e7-dfd6-4d67-13fd-08d53bdd7289
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:HE1PR0201MB1996;
x-ms-traffictypediagnostic: HE1PR0201MB1996:
x-microsoft-antispam-prvs: <HE1PR0201MB1996F7EF41E39EA275015A639C3D0@HE1PR0201MB1996.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(164563717011359)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231022)(6041248)(20161123555025)(20161123562025)(20161123564025)(20161123558100)(20161123560025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HE1PR0201MB1996;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:HE1PR0201MB1996;
x-forefront-prvs: 0512CC5201
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(366004)(346002)(376002)(199003)(13464003)(189002)(7696005)(5250100002)(9686003)(1730700003)(66066001)(81156014)(54906003)(189998001)(3846002)(102836003)(97736004)(6116002)(8676002)(316002)(53936002)(4326008)(3660700001)(33656002)(81166006)(39060400002)(14454004)(15650500001)(76176011)(2501003)(54356011)(6246003)(25786009)(101416001)(2900100001)(5640700003)(8666007)(93886005)(6506006)(105586002)(68736007)(6436002)(3280700002)(7736002)(55016002)(5660300001)(6916009)(53546010)(8656006)(8936002)(86362001)(229853002)(99286004)(74316002)(478600001)(305945005)(2351001)(106356001)(2950100002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB1996;H:HE1PR0201MB1993.eurprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8b272e7-dfd6-4d67-13fd-08d53bdd7289
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2017 12:41:03.6784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB1996
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"Shorted" is what happens when you put a piece of wire across the terminals=
 of a battery ... (bang, smoke, etc).
It's short for "short-circuited".
Yes, I think you mean "shortened" in this case.

Regards,
Richard.



Richard Kerry
BNCS Engineer, SI SOL Telco & Media Vertical Practice

T: +44 (0)20 3618 2669
M: +44 (0)7812 325518
Lync: +44 (0) 20 3618 0778
Room G300, Stadium House, Wood Lane, London, W12 7TA
richard.kerry@atos.net




> -----Original Message-----
> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> Behalf Of Junio C Hamano
> Sent: Tuesday, December 05, 2017 12:37 PM
> To: liam Beguin <liambeguin@gmail.com>
> Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>;
> git@vger.kernel.org; peff@peff.net
> Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
> parameter
>
> liam Beguin <liambeguin@gmail.com> writes:
>
> > I'll change it to TODO_LIST_SHORTED_IDs. TODO_LIST_SHORTED_INSNS
> would
> > suggest the flag changes both parts of the todo.
>
> I am not a native speaker, but SHORTED does not sound like a right phrase=
.
> When you make something shorter, that thing is "shortened", not "shorted"=
.

Atos, Atos Consulting, Worldline and Canopy The Open Cloud Company are trad=
ing names used by the Atos group. The following trading entities are regist=
ered in England and Wales: Atos IT Services UK Limited (registered number 0=
1245534), Atos Consulting Limited (registered number 04312380), Atos Worldl=
ine UK Limited (registered number 08514184) and Canopy The Open Cloud Compa=
ny Limited (registration number 08011902). The registered office for each i=
s at 4 Triton Square, Regent=E2=80=99s Place, London, NW1 3HG.The VAT No. f=
or each is: GB232327983.

This e-mail and the documents attached are confidential and intended solely=
 for the addressee, and may contain confidential or privileged information.=
 If you receive this e-mail in error, you are not authorised to copy, discl=
ose, use or retain it. Please notify the sender immediately and delete this=
 email from your systems. As emails may be intercepted, amended or lost, th=
ey are not secure. Atos therefore can accept no liability for any errors or=
 their content. Although Atos endeavours to maintain a virus-free network, =
we do not warrant that this transmission is virus-free and can accept no li=
ability for any damages resulting from any virus transmitted. The risks are=
 deemed to be accepted by everyone who communicates with Atos by email.
