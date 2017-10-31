Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D34420437
	for <e@80x24.org>; Tue, 31 Oct 2017 13:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbdJaNOR (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 09:14:17 -0400
Received: from mail-sn1nam01on0133.outbound.protection.outlook.com ([104.47.32.133]:24551
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751539AbdJaNOL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 09:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=N2zl8wjdLigSgx3d0DlASPNoRBiJtrJT/Rs+t/agI94=;
 b=c2Z1RFVNmv6PuWApAKxWQAxwKsZflf9sF/pfyaR0S1aYxo8UhPrEKRiverATMT5dRd5Hv+cRUBMit7+Wy7n8XfSkrM4RXvMdzsiIgDyX2sNTlhCxPhWFx4fD7uREumbbYqF52T5ix3cPj4m7XTPx1kn8Td/P7mCwRZzQGn0Nbk0=
Received: from SN4PR2101MB0736.namprd21.prod.outlook.com (10.167.151.155) by
 SN4PR2101MB0816.namprd21.prod.outlook.com (10.167.151.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.197.1; Tue, 31 Oct 2017 13:14:10 +0000
Received: from SN4PR2101MB0736.namprd21.prod.outlook.com
 ([fe80::30b0:f7bd:f554:7b4d]) by SN4PR2101MB0736.namprd21.prod.outlook.com
 ([fe80::30b0:f7bd:f554:7b4d%13]) with mapi id 15.20.0218.002; Tue, 31 Oct
 2017 13:14:09 +0000
From:   Jeff Hostetler <Jeff.Hostetler@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <git@jeffhostetler.com>
CC:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "Jeff Hostetler" <Jeff.Hostetler@microsoft.com>
Subject: RE: What's cooking in git.git (Oct 2017, #07; Mon, 30)
Thread-Topic: What's cooking in git.git (Oct 2017, #07; Mon, 30)
Thread-Index: AQHTUUcISIzS7SsiTkyaJCRJZ7BPZqL8p2gAgAAnwwCAAHFuhIAAsDMA
Date:   Tue, 31 Oct 2017 13:14:08 +0000
Message-ID: <SN4PR2101MB07369D19A150418D5ACB858B8A5E0@SN4PR2101MB0736.namprd21.prod.outlook.com>
References: <xmqqr2tl40pl.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1710301830210.6482@virtualbox>
        <f12353b6-cfed-722b-1386-d55700f21915@jeffhostetler.com>
 <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqtvyg2g6y.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:8010::149]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN4PR2101MB0816;6:fIAxGtk1eAWiYU/od8G/cPqf5xURZMPtQZfU1ax/+vlz2O7lHGmwwClRhknFFcg4DKPkRH4GXBq/ETApZYOXqxm0QG6dqEm3D2c0TUzUBrxJpFmh7OQ/FrspduMKmcCETz/Rs3RZGeWoCRn0qIltUES85dWBSRSRGBR3jRypI8o0dAVTKBI+e30XBNLlK38nVUkxUhObI7Y+dIPqWDonTq9OQmFSQCw1qtPo19i+cfoHi4vsmw6s/hXk9I1CqL9yF3n7CIU/oaURPkIJkK3Dv3Wc8tdztmJh6xvk98Kftv7iP0KMFjMOAZvesTzO1N7T192bbHrJWrMXnxko6txqXA19QA/R44XLk/vpyrPKOgA=;5:OXpOKMs7He45M32zUPBZIml5yfqhJEoTr0+sl5t/BdhSz7FN31ruDAwTpFttfpDd6MwNXIefqB19Vp1M2fv4nVh3AxYflfLG9ICvme62bA3wCN1IZ0Cg70Iaux7rDNsw0I8KmCZAxKU7kkhII/NG+rT4yTyYtQE+PN7xFxzXr8M=;24:5RhcpXREIhwJeHEqnWFsrOAdKSdhQFh4wsc/Wc25fvHascFVITveUbmLH2LK9wE7AQEv29ARFmPv5Aj1cOC1+atmt/ZyfZaS5YFXUEqEDc4=;7:Vv9a13WNm3QA79RzVUi898i35gTCMZLZHOT1sO6TfslLC0XpwM0g93eg6DgDtDE1blVvLmyGSPjHeUswYqWOJ7mA2sTKAjsMuQBTW12Y7k90Daoa13FOjdE3zkCA5MpNVI+Anfqw4OzhGTW6vKndPGMlEedKGWGwWcoI7Q5mcAuOHOa/ZGIPqKzZ1eyKaHAly9sfsg4U7aTNasQ34/ZJLMotGNHG2nvpGxBbtjOdqrDvII0sCkR3ovJOKtnWb6ue
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(47760400005)(199003)(189002)(76176999)(68736007)(110136005)(6506006)(54356999)(81156014)(107886003)(3660700001)(25786009)(229853002)(316002)(3280700002)(93886005)(54906003)(22452003)(102836003)(53936002)(14454004)(2950100002)(189998001)(2906002)(101416001)(9686003)(6116002)(33656002)(7696004)(97736004)(6246003)(86362001)(99286003)(305945005)(5660300001)(5250100002)(74316002)(10090500001)(50986999)(8666007)(86612001)(478600001)(4326008)(8990500004)(55016002)(106356001)(81166006)(8676002)(7736002)(8656006)(105586002)(6436002)(2900100001)(10290500003)(72206003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR2101MB0816;H:SN4PR2101MB0736.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-correlation-id: cdefc89e-f037-4f33-da8f-08d520614580
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(48565401081)(2017052603238);SRVR:SN4PR2101MB0816;
x-ms-traffictypediagnostic: SN4PR2101MB0816:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jeff.Hostetler@microsoft.com; 
x-exchange-antispam-report-test: UriScan:(788757137089)(100324003535756);
x-microsoft-antispam-prvs: <SN4PR2101MB0816A8DD9CC09F3BD1DD30A98A5E0@SN4PR2101MB0816.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(93006095)(93001095)(100000703101)(100105400095)(3231020)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123555025)(20161123562025)(20161123558100)(20161123564025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN4PR2101MB0816;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN4PR2101MB0816;
x-forefront-prvs: 04772EA191
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdefc89e-f037-4f33-da8f-08d520614580
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2017 13:14:09.1532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0816
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



From: Junio C Hamano [mailto:gitster@pobox.com]=20
Subject: Re: What's cooking in git.git (Oct 2017, #07; Mon, 30)

> Jeff Hostetler <git@jeffhostetler.com> writes:
>=20
>> I've been assuming that the jt/partial-clone-lazy-fetch is a=20
>> placeholder for our next combined patch series.
>
> Yes, that, together with the expectation that I will hear from both you a=
nd JTan=20
> once the result of combined effort becomes ready to replace this placehol=
der,=20
> matches my assumption.
>=20
> Is that happening now?

Yes, I'm merging our them now and hope to have a version to
send to Jonathan and/or the list sometime this week.

Jeff

