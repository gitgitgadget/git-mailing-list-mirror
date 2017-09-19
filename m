Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2CA2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 15:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdISPgh (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 11:36:37 -0400
Received: from mail-by2nam03on0131.outbound.protection.outlook.com ([104.47.42.131]:54812
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbdISPgg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=df0W9V5du8Y9PZTnxutCC9IbBbXURrfXn0xX0XpJiJY=;
 b=llp5YH8sq9erScid3BFiCnpTskZlx1CcIGTAOc/bUjm/RRW8hf4req9125zfd9U+8REkJvujcnaj/Ef36rFBldOwZ1SBFQT6Q4ONy/gxKOvtc0TUN9aYBFblEfbhuSI8FAABOEXIWQL13Bsx9Pckgg6s6bF3Fp2YBKnPPJG5rpU=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0847.namprd21.prod.outlook.com (10.173.51.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.98.0; Tue, 19 Sep 2017 15:36:34 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0098.001; Tue, 19 Sep 2017 15:36:34 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
CC:     Ben Peart <peartben@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "David.Turner@twosigma.com" <David.Turner@twosigma.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: RE: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Topic: [PATCH v6 08/12] fsmonitor: add a test tool to dump the index
 extension
Thread-Index: AQHTLlfX4EdaoMmwhkm8eIJw0xTKS6K4uf2ggAHwEICAACLvgIAACcWggAFwUQCAABY0QA==
Date:   Tue, 19 Sep 2017 15:36:33 +0000
Message-ID: <MWHPR21MB0478181AE0B64901DA2C07CDF4600@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170915192043.4516-1-benpeart@microsoft.com>
 <20170915192043.4516-9-benpeart@microsoft.com>
 <xmqqtw01u50j.fsf@gitster.mtv.corp.google.com>
 <5438765b-3119-ef15-8635-932b8cba08d3@gmail.com>
 <6f55efc4-96b2-7c53-7d54-ff5801697550@web.de>
 <MWHPR21MB0478E4671130AD9E19B77460F4630@MWHPR21MB0478.namprd21.prod.outlook.com>
 <20170919141626.GA28437@tor.lan>
In-Reply-To: <20170919141626.GA28437@tor.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-19T11:36:32.0462268-04:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0847;6:Xwz1P9cYzkZr/+VQN2b8Ei7wojDHejqTYcPt5lOe0KSFEQ2KXbI3TQ0qSpwAOO275DRpiyc3YIW84Kn0oT4N5Mc82GEYElE1ovH42kRBnd3g6huCOMZjOYaqzPugkCRpyPg8leYMvJx+q4OJY0uydePVZu7jGe9l4ymHG4r/d5RDP9qlmU0AXiOjRg/9ztBPoZtDXhQcU7izeAYHvNC9I22Q8B7nrsVLwdUNdPy8GQQQ8JpPu4IHpUWKFm97pBbb7woRvRDcEAVT7rbKsBHnXKqsyrkJ3sCskEtGz55xG/YPXYo/8Q0ytqbwHVhW486Fuf4lS4W00c1XMktr3L+3vA==;5:cMxjrLfHfKln8/AzSDsdNa6/gh0/p6WFvZtHw+QhH7EG/ZCiLqNyeKNmbV7tV7GdxMfUX62qa+sJzML9oyHv/8cge+5q4T6AifFRt0/KKMqguiW/XXFXaLDbV17FCuHGnFIO5WnMB8P/UGg+JrcEuQ==;24:yNR5L+VNLI6uoVfhUfvuZMUnDScIJONCydK1cgtkGPNwdD+kI41k2Rhloaz2TD7hHxppEKRhJqgWjXCl3chuVl73Webr+q7QftBCs9Ejl4g=;7:b/dvWADAsXY0otMi5NySIXWF7J4ozOrUG1JzIgP9eQI30vXS1AZufSSm6Hu9zVh+VtkUoidWwMwWRhkg1wRJRWy8mWD9hkyeaZkCyHpMfOqp53tVkpasdyVxQkFzSMfotT4kv1PCmnuvCP1KqGEWn/Xo+EB4jpPKu4v5FrFkkD1wrtncfSSo7rEj6YC2FVYfaKliFcE7DZCDVjx8LE7zPYcboHZ/m4nc9XVX0JDt+G0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e690e31-c806-45cc-27db-08d4ff743541
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:MWHPR21MB0847;
x-ms-traffictypediagnostic: MWHPR21MB0847:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(26323138287068)(89211679590171)(9452136761055)(245156298449039)(100324003535756);
x-microsoft-antispam-prvs: <MWHPR21MB0847B71B5E7E612F38608FF2F4600@MWHPR21MB0847.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(100000703101)(100105400095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123560025)(20161123562025)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0847;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0847;
x-forefront-prvs: 04359FAD81
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(47760400005)(13464003)(199003)(377454003)(189002)(7416002)(229853002)(10290500003)(189998001)(6116002)(7696004)(53546010)(8666007)(99286003)(97736004)(54906002)(6436002)(316002)(55016002)(9686003)(53936002)(6246003)(478600001)(72206003)(39060400002)(4326008)(3846002)(102836003)(86362001)(86612001)(6506006)(6916009)(77096006)(2950100002)(2906002)(105586002)(68736007)(76176999)(7736002)(10090500001)(305945005)(8656003)(8990500004)(8676002)(2900100001)(33656002)(8936002)(25786009)(50986999)(74316002)(5660300001)(66066001)(106356001)(3280700002)(3660700001)(22452003)(81166006)(81156014)(14454004)(101416001)(93886005)(54356999);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0847;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2017 15:36:33.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0847
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Torsten B=F6gershausen [mailto:tboegi@web.de]
> Sent: Tuesday, September 19, 2017 10:16 AM
> To: Ben Peart <Ben.Peart@microsoft.com>
> Cc: Ben Peart <peartben@gmail.com>; Junio C Hamano
> <gitster@pobox.com>; David.Turner@twosigma.com; avarab@gmail.com;
> christian.couder@gmail.com; git@vger.kernel.org;
> johannes.schindelin@gmx.de; pclouds@gmail.com; peff@peff.net
> Subject: Re: [PATCH v6 08/12] fsmonitor: add a test tool to dump the inde=
x
> extension
>=20
> >
> > Should I just make the variable type itself uintmax_t and then just
> > skip the cast altogether? I went with uint64_t because that is what
> > getnanotime returned.
> >
>=20
> That is a bit of taste question (or answer)
>=20
> Typically you declare the variables in the type you need, and this is uin=
t64_t.
>=20
> Let's step back a bit:
> To print e.g a variable of type uint32_t, you use  PRIu32 in the format s=
tring,
> like this:
>=20
> fprintf(stderr, "Total %"PRIu32" (delta %"PRIu32"),",....
>=20
> In theory (it is in the later specs, and it exists on many platforms), th=
ere is a
> PRIu64 as well.
>=20
> We don't seem to use it in Git, probably because uintmax_t is (more)
> portable and understood by all platforms which support Git.
> (And beside that, on most platforms uintmax_t is 64 bit).
>=20
> So my suggestion would be to keep uint64_t and cast the variable into
> uintmax_t whenever it is printed.
>=20

Great!  That is the way I have it.
