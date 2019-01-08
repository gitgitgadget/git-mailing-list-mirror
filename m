Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE711F803
	for <e@80x24.org>; Tue,  8 Jan 2019 00:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfAHA4z (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 19:56:55 -0500
Received: from mail-eopbgr690114.outbound.protection.outlook.com ([40.107.69.114]:6160
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfAHA4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 19:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwP15H27WZB3Rouxo3OBFAl2lnXe7m8bhdGzaaramMA=;
 b=IAWFy2mKzqLX+0RkhzmfzdNJox+SU4+lVpe0EpP8hyZobXUEUv5dmC6r0RxHYH/voFI/z/hqzRRveBzXVDfBis/UYNGoAxVqoh9IOuYTQ1s7SavSqR+cFfrcqYokc5BZErU6eW8r2WXSonKWCHOXYNeHO+qVqBUd0xIZp8yVMaI=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5705.namprd08.prod.outlook.com (20.179.54.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.9; Tue, 8 Jan 2019 00:56:51 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b%4]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 00:56:51 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "luke@diamand.org" <luke@diamand.org>
CC:     "chenbin.sh@gmail.com" <chenbin.sh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "Mazo, Andrey" <amazo@checkvideo.com>
Subject: Re: git-p4: default behavior for handling moves?
Thread-Topic: git-p4: default behavior for handling moves?
Thread-Index: AQHUpoemtJOwyeXzlkOubEws91Z7/aWkjPAA
Date:   Tue, 8 Jan 2019 00:56:51 +0000
Message-ID: <20190108005634.1647-1-amazo@checkvideo.com>
References: <CAE5ih7987J2WXdCJvs2e3hOn3zucpE6gsr4JJtxO+XE5=K2G_Q@mail.gmail.com>
In-Reply-To: <CAE5ih7987J2WXdCJvs2e3hOn3zucpE6gsr4JJtxO+XE5=K2G_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR10CA0006.namprd10.prod.outlook.com
 (2603:10b6:405:1::16) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB5705;6:iU3g/EpmqSkLpb2eYmCpEtZxjdNIMf5IFzGA5psC+07SE0UdIUbeNtdjd5sGAEw7G0RPmyfPQDU7BBibL5KkVle4gP920KYqlRDP0uZ6SUIX4uCsaKQiAQs9XpMh6SzlDGEwY5lI/RRHiTPfd2ECyZorYPs/fJh+Y335/+FVgIQNTWkGHJRNXGjxdlrvQsPPum83kFCKt6SwgxtZl68e4GCDylG8rHLa+71niEjpCCqhuvA7TciZ0veXo1og2dnll22PBkpW08D1g8gXDYGETtLSFq1UgKTu/aY927KLNuAt84w3aUlXaZfFmABXDZIrbimLjMAE22RLG9HtYw49po7zd8oN31usbi7kGYRqM+t1wb92En7uvu9vDlg+gvRfvDG3JPvTuIB1O6YCqPiYHgkPm6DuM7sPehtc9+YoC8DiKaF0UZAV9FXk/76Eecron3pSl2a0RV5O9UOhiv5WsQ==;5:Zez1YBhc8yqdkb40z40JrwM/i/R8aESL65Z2uInmpvjXLuFo9nH4YDPv6GQDPj3//P/ZvNGZsRjwXLj8U5bqlGx5iMQ3oQlYtavu9pUAOvP7SLQqc0d5mA0M03fjDysfISRCH524Kp+1H3B89pRZI7KmX7t43FW7zKw68lI4Nomzp1C4+UkjMvwyyHOzHBqQWzVRpJTESOKbsVhxchABvQ==;7:OLGxqOIJpY+kI2+5TPNpYkgwHQheydM0VFPnqiFW437lnkwueOQUVDFVjmAGJuPmChh9HKTdsa56G0BG+2s2civR0ocMKc9VXqitvd9NopvVmiv22znPRoZu9yFmrT8Ocq58VnvcKO6DiBaWnZFz7w==
x-ms-office365-filtering-correlation-id: f0b48af1-7a10-4de4-15f1-08d675042cbe
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5705;
x-ms-traffictypediagnostic: DM6PR08MB5705:
x-microsoft-antispam-prvs: <DM6PR08MB57059431CCA01B6E06947C6BDA8A0@DM6PR08MB5705.namprd08.prod.outlook.com>
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(346002)(39860400002)(136003)(376002)(199004)(189003)(52314003)(8676002)(81166006)(81156014)(1730700003)(8936002)(446003)(7736002)(305945005)(2616005)(11346002)(476003)(2501003)(1076003)(14454004)(5640700003)(486006)(36756003)(52116002)(256004)(19627235002)(86362001)(14444005)(6512007)(478600001)(97736004)(26005)(229853002)(71200400001)(6436002)(71190400001)(6486002)(316002)(106356001)(107886003)(105586002)(2906002)(53936002)(54906003)(6246003)(2351001)(68736007)(4326008)(66066001)(25786009)(102836004)(76176011)(3846002)(6916009)(6116002)(99286004)(386003)(5660300001)(6506007)(186003)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5705;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1534D8i0fhvaYrP3e2exmh7shVb2X30X4awVZtYizkEREAgktVXCgA0R69kMZsTv/NWvNvRj9humDMl0psJmrylLjmGOH2d7J1xV+oMcCw74puk61SbJN+z1UOU1cQlf5pY3SzpyHtVR5+4aTQm8Z/Ko5leHBkR0fkWnL65FiP0i7YGOJM/ud/fLzK1RYU3FetAR/cwkGvtb2LItz/b/HKFV3yMToK1fmm5730N4tzP+8pSOR6NOtRKm/nP0vaerdeo+TPRC6HTDX/BuhcF9zV8aSw6ubbJII3e5tcEg5UZfeRbbWBnhIek3F0mV2Knl
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b48af1-7a10-4de4-15f1-08d675042cbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 00:56:51.2669
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5705
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> git-p4 can map a "git move" operation to a Perforce "move" operation.
> But by default this is disabled. You then end up with a P4 commit
> where the file is deleted, and a fresh file is created with the same
> contents at the new location at revision #1.
>=20
> Rename detection gets enabled either with the "-M" option, or with
> some config variables, git-p4.detectCopies and git-p4.detectRenames.
>=20
> I've been tripped up by this, and I actually know about it, and I know
> other people have been as well.
>=20
> Should we switch the default over so that it's enabled by default? I
> can't think of any reason why you wouldn't want it enabled.

I have it enabled in my ~/.gitconfig,
so enabling it by default makes total sense to me.

Regarding potential problems,
I occasionally get a wrong "source" file detection.
(e.g. there was `cp a b ; git add b`, but some other file "c" is selected a=
s the source instead)
Or there is a "copy/move" detected, when there was actually none.
But I've only seen this with quite small files (like a trivial one line she=
ll script) or binaries,
and mostly because I have git-p4.detectCopiesHarder set as well as a pretty=
 aggressive git-p4.detectCopies threshold.
(normally 30%, but down to 10% at times to make sure a copy/move is really =
detected)

But anyway, enabling both git-p4.detect{Copies,Renames}
with default 50% similarity index makes sense to me.

It's probably worth adding command-line options to override the new to-be d=
efaults though.


A more conservative approach like only enabling git-p4.detectRenames =3D 70=
% is an option too.

>=20
> I think the rename code was first introduced around 2011 by Vitor.
>=20
> Another option is to add a warning, but people just ignore warnings!

When such a warning would be shown?
Just before `p4 submit`?
I think, It might be hard to notice for large changesets.

Thank you,
Andrey
