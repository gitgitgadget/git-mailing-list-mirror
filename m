Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A0820A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbdLEQPF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:15:05 -0500
Received: from smtppost.atos.net ([193.56.114.164]:20024 "EHLO
        smtppost.atos.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752579AbdLEQPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:15:03 -0500
Received: from mail2-ext.my-it-solutions.net (mail2-ext.my-it-solutions.net) by smarthost3.atos.net with smtp
        (TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
         id 45e7_39f0_2888b33e_d859_4750_b570_aabe38a77af5;
        Tue, 05 Dec 2017 17:14:57 +0100
Received: from mail3-int.my-it-solutions.net ([10.92.32.10])
        by mail2-ext.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id vB5GEvqx002628
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Dec 2017 17:14:57 +0100
Received: from DEFTHW99ETSMSX.ww931.my-it-solutions.net ([10.86.142.100])
        by mail3-int.my-it-solutions.net (8.15.2/8.15.2) with ESMTPS id vB5GEvcN022851
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Tue, 5 Dec 2017 17:14:57 +0100
Received: from DEFTHW99ETUMSX.ww931.my-it-solutions.net (10.86.142.49) by
 DEFTHW99ETSMSX.ww931.my-it-solutions.net (10.86.142.100) with Microsoft SMTP
 Server (TLS) id 14.3.361.1; Tue, 5 Dec 2017 17:14:56 +0100
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (10.86.142.137)
 by hybridsmtp.it-solutions.atos.net (10.86.142.49) with Microsoft SMTP Server
 (TLS) id 14.3.361.1; Tue, 5 Dec 2017 17:14:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atos365.onmicrosoft.com; s=selector1-atos-net;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4vl/AqbOM2IvLHIMv1ze5ZHIXNWfAJwucDcL42vUCmI=;
 b=gmlVSe0573V02pO+d/X0w6SvnMlNhrI8hoQYoH/ObltX1BFVCM5+OfrWCzieVZwgT3d0OWsyd57uiNgGCiRTh5XQT4J0ciASgUCFArGXIqdFYixXkx3W1ADCUJleLX15SF8EpvB82hXuBBxTMZXy8sIa6aPA4nsZI+f1GydDk+M=
Received: from HE1PR0201MB1993.eurprd02.prod.outlook.com (10.167.187.135) by
 HE1PR0201MB1995.eurprd02.prod.outlook.com (10.167.187.137) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.282.5; Tue, 5 Dec
 2017 16:14:54 +0000
Received: from HE1PR0201MB1993.eurprd02.prod.outlook.com
 ([fe80::85e3:d7fc:56f8:603a]) by HE1PR0201MB1993.eurprd02.prod.outlook.com
 ([fe80::85e3:d7fc:56f8:603a%13]) with mapi id 15.20.0302.007; Tue, 5 Dec 2017
 16:14:54 +0000
From:   "Kerry, Richard" <richard.kerry@atos.net>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "peff@peff.net" <peff@peff.net>, liam Beguin <liambeguin@gmail.com>
Subject: RE: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
Thread-Topic: [PATCH v2 6/9] rebase -i: update functions to use a flags
 parameter
Thread-Index: AQHTbISjjspf9HuVa0aHkPOeSXeP1KMzVSkAgADIBICAAJV/tIAAADxAgAA54pmAAAAi8A==
Date:   Tue, 5 Dec 2017 16:14:53 +0000
Message-ID: <HE1PR0201MB1993E5FBA6241CFA7EF2A1EF9C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-7-liambeguin@gmail.com>
        <alpine.DEB.2.21.1.1712041643250.98586@virtualbox>
        <22f665eb-0ed1-27d4-7184-e6063ea5b47e@gmail.com>
        <xmqqwp21jqpl.fsf@gitster.mtv.corp.google.com>
        <HE1PR0201MB19938A1581F799CB9D48AE999C3D0@HE1PR0201MB1993.eurprd02.prod.outlook.com>
 <xmqq4lp5jh2n.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4lp5jh2n.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=richard.kerry@atos.net; 
x-originating-ip: [157.203.176.168]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0201MB1995;6:6b9tyR1u6LugHXZjvFqf4I9pxmXUn8fFxnmT+YPegybI70hJ7X87L7sc26n2JuQsMTgBS5wxNLwaRxQGJ/2nqbb7RLBiPq+YbcAaYCc0zQKRNkmIN3tsYgqWwgDanmTk+c6O8SyaY3fCOSUasWNq0feLU6w34BPOWwTWwrofafAb6kXhUZO5ZH3zOQn+K2YpTdG9iKKW+sdw1hjfjiz/K+x6eCBJ4Z9HvuONQ65i15RAyp1icHkJwSRpQ0bYx99G6cSw8/TI79ilNAatmL/M7cI8vQ0u4Y5ja5zOHVR5erzMmKI1ux18pabqoFrQO5DTbKE6CEh6JGLty2secVX1fNO9d7LKc71QBFjxdQwxK2Y=;5:3Fc1fzGh06zgTwATNe4+9YPLuw0MxVtR+9TppBt6CTK7Y2Bjlmy8UWvh1QenBytKxTzsieBUysTbm+PQahApINg4PH82q9sx3+NIxti0cUZBlCf7eW2TvCDT+0wperNvqRe+FCgedCPOd/Y2sqonAbCNk/eMFK+U1bTo9x8NPsw=;24:k+TobUAkxGYCvYPFWUtEgjHeKiB9p8ZBj30ZBQh4V0tOB9r9DgPtVqi1MZhbtycp7+Aa0Hg2u4sumCmyW6tWWEuvKx2VtiiDxSm8w1qm5fA=;7:HCH//eqLVWgdLpLCcXS9tFF02W//SS47N9coO0BmxERrSeiVIJGAaCoD6U2o5wX0ue8hiwfDv3h5h/OXrEMWT9mFtBa/+Wy/cm4a1CRtu4111FdoxQeh4p83eP6yq3KHmsxv1tCgq2fz6zBypVTMmxwwd0tv6sj9xAboK6/XaZZqcbJWrSA+sUsIhS62vxhC/VIc7IklJi8eFRHshxQWtuwUHPH9fCPERuSrIV+KtyHfzjoVLfbnRxaIYDrS2CV8
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 44c7c023-7a11-469b-3c22-08d53bfb51f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603286);SRVR:HE1PR0201MB1995;
x-ms-traffictypediagnostic: HE1PR0201MB1995:
x-microsoft-antispam-prvs: <HE1PR0201MB1995BADA65D64FB01760D9C39C3D0@HE1PR0201MB1995.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(26323138287068)(164563717011359)(9452136761055)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231022)(6041248)(20161123555025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123560025)(20161123564025)(6072148)(201708071742011);SRVR:HE1PR0201MB1995;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:HE1PR0201MB1995;
x-forefront-prvs: 0512CC5201
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(366004)(376002)(346002)(189002)(199003)(13464003)(102836003)(81166006)(5660300001)(81156014)(97736004)(8676002)(478600001)(66066001)(6116002)(2900100001)(2906002)(5250100002)(8666007)(3846002)(15650500001)(316002)(25786009)(6916009)(39060400002)(76176011)(6246003)(6436002)(99286004)(53936002)(7696005)(4326008)(2950100002)(68736007)(86362001)(229853002)(305945005)(7736002)(14454004)(8656006)(6506006)(53546010)(105586002)(3660700001)(9686003)(54906003)(106356001)(189998001)(93886005)(8936002)(74316002)(3280700002)(55016002)(33656002)(101416001);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB1995;H:HE1PR0201MB1993.eurprd02.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: atos.net does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c7c023-7a11-469b-3c22-08d53bfb51f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2017 16:14:53.7589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33440fc6-b7c7-412c-bb73-0e70b0198d5a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB1995
X-OriginatorOrg: atos.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Indeed so.
In which case it is short for "selling short", or possibly "short selling".

Of course a little searching shows that "shorted" could mean some other thi=
ngs, including possibly the meaning originally suggested.
Nevertheless it seems to me that "shortened" is the most appropriate word i=
n modern English.

R.


Richard Kerry
BNCS Engineer, SI SOL Telco & Media Vertical Practice

T: +44 (0)20 3618 2669
M: +44 (0)7812 325518
Lync: +44 (0) 20 3618 0778
Room G300, Stadium House, Wood Lane, London, W12 7TA
richard.kerry@atos.net




> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, December 05, 2017 4:06 PM
> To: Kerry, Richard <richard.kerry@atos.net>
> Cc: git@vger.kernel.org; Johannes Schindelin
> <Johannes.Schindelin@gmx.de>; peff@peff.net; liam Beguin
> <liambeguin@gmail.com>
> Subject: Re: [PATCH v2 6/9] rebase -i: update functions to use a flags
> parameter
>
> "Kerry, Richard" <richard.kerry@atos.net> writes:
>
> > "Shorted" is what happens when you put a piece of wire across the
> terminals of a battery ... (bang, smoke, etc).
> > It's short for "short-circuited".
>
> Or it is what you do to something that you sell and that you yet do not o=
wn,
> expecting that you can later buy it cheaper, allowing you to pocket the
> difference ;-).
>

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
