Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FC6F1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 23:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfAGX4y (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 18:56:54 -0500
Received: from mail-eopbgr800098.outbound.protection.outlook.com ([40.107.80.98]:51776
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbfAGX4y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 18:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5R25T0UyjyXEzmbT4UXItDwkcCcyxSrxhI2X3zy67Es=;
 b=dWVgIuZ0VoeO80AeMFDep5iAITLhSca5TR3thCXj5NybSM1eXGvBSPcgXAhpFPP5z3iXgkXvhYfOUhtNgO+zqWQgI05LBY545j/9Hu3sD0HhtIquWYr3SPN66j6zKVnvP13QbaDid8i/YtQ43MnAwKtNoMQ58cKjCDY8Dd+WTBk=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5787.namprd08.prod.outlook.com (20.179.55.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.6; Mon, 7 Jan 2019 23:56:49 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::a907:18b6:6650:573b%4]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 23:56:49 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "peterosterlund2@gmail.com" <peterosterlund2@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>,
        "Mazo, Andrey" <amazo@checkvideo.com>
Subject: Re: "git p4" fails when perforce login not needed
Thread-Topic: "git p4" fails when perforce login not needed
Thread-Index: AQHUphH6KfNQy3V9lE2hwnV23yrbdKWkfR8A
Date:   Mon, 7 Jan 2019 23:56:49 +0000
Message-ID: <20190107235640.32067-1-amazo@checkvideo.com>
References: <alpine.LFD.2.21.1901062337420.5908@fractal.localdomain>
In-Reply-To: <alpine.LFD.2.21.1901062337420.5908@fractal.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR04CA0041.namprd04.prod.outlook.com
 (2603:10b6:405:3b::30) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR08MB5787;6:cb3pGt8p3R4hDdEJJJeuX5fE4w8GMP+v217idQVnkiew2n2TGz7+IBiLgDky08Ef+QBA+fytjVoWo4MNfM6Sl4J+DcAh4cBkiKkrHJ7YMb3xRFGI9t7q5SNUseZpNYfAXVzZCxCDtU6l+N1x+5238wPjxRTtYPO/8z6/FK+Qr12F0uh9DC9T8HAxF8yUaVSvWaKlxtGhk6ngAXzyRUAjARlsgcMvpqkTrFV8JjcbcRQx3ATFRvPwVCD4IkxWHOF8kGSNCI4dxK9zejGBS3tfJ6Wyi7J9hEq6+9HTPo3mmXxmecHkqbrpXsRd9+VmruzBN30KMAreGoTjNPJeRTmhMjvhzFa7SunNVOs7rrfmiwn2BU6ixS8ndmcayZF9dfxFAbOuB3nYdAzmx7ZXEVOfiwcZ0kUNyZI8KYibo7lfSz8CkmCWMBeA2c9/uisOgidjCPEw4gdsnpd7UPaF9gxr9Q==;5:wZmGuZSmlKDAfFIWu10ogIiRp9Q9VdEHPnikXwo1/bEXmUJaybGnasPVp+wP/+/ctk6mZNsXjN6h4dcJsJhUvKeMIRXT33nGgXLp3DUbdo5Bj71C4TlMGD+viZl3laM+wAivTg+QR7ty+ANqzQZSgZ+WpNJpOKeoqoDx7Ns/Uj0rejWfeJ6G1yYtcMEQ/Snks0V8D6njYq3XZRMJIOoeng==;7:O31HjSjFrCCKYa8ib5KksG4x6yxVJ7dpYmOEiI+rxXe4bHgmXZa+ZEwzOZ9HdJJllsAuJbcswvznsgnicSf+PY7DhpxszvME2raAJ6WlIHsyhykPEczPo8pkzjkhz8+gPTc7oHll+RGzKiwiVwFpGQ==
x-ms-office365-filtering-correlation-id: da8932f6-74b6-451e-afdd-08d674fbc9bd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5787;
x-ms-traffictypediagnostic: DM6PR08MB5787:
x-microsoft-antispam-prvs: <DM6PR08MB57874BFC60ADD79A7B50A8F3DA890@DM6PR08MB5787.namprd08.prod.outlook.com>
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(376002)(39860400002)(396003)(366004)(199004)(189003)(99286004)(5660300001)(6506007)(36756003)(6916009)(3846002)(71190400001)(446003)(6246003)(39060400002)(107886003)(486006)(102836004)(26005)(186003)(68736007)(386003)(97736004)(86362001)(53936002)(4326008)(6436002)(71200400001)(2501003)(2906002)(5640700003)(229853002)(6486002)(76176011)(4001150100001)(25786009)(105586002)(7736002)(305945005)(8676002)(106356001)(1411001)(476003)(66066001)(2616005)(52116002)(2351001)(11346002)(14454004)(478600001)(551544002)(81166006)(1076003)(8936002)(1361003)(54906003)(316002)(6512007)(14444005)(6116002)(256004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5787;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pjSqeHOhgq2rc0P/CxvKW5q/ChU/mh1+yLbkSTSXAX0pS8uPkYPEhX1gdq78VefDhqfb0cwjrsdRxV92hghIxW4cxT9Vysnm3whpSXEDmUhwGNQuYaOOtnc5s63utD/RrZCn+wBHvj5l3xFOdpbbxdNQsKaGeAHlusbCgYqwBgbALh+K8EtjSiPEzy4WMd5uWat6n6LTGiaPflPk572gabIDdRs97cuN9SudipgJEbypqccEQfyuZD/zHlXP7EhrS8yL0kwldnDh2AxvQ3/5mII2kjgVKYpGz2vhGNqSrZ87nzfB08GEqIIMAgfXGuzJ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8932f6-74b6-451e-afdd-08d674fbc9bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 23:56:49.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5787
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 6 Jan 2019 at 22:48, Peter Osterlund <peterosterlund2@gmail.com> wr=
ote:
> Hi,
>=20
> When I use "git p4 sync" to update a git repository from a perforce depot=
,=20
> the operation fails with error message:
>=20
>      failure accessing depot: unknown error code info
>

I guess, this got broken in
commit 0ef67acdd78 ("git-p4: better error reporting when p4 fails", 2018-06=
-08)

> When I run "p4 login -s" from a shell it reports:
>=20
>      'login' not necessary, no password set for this user.

In my case, I was getting (this is pretty printed `p4 -G` output):
    {b'code': b'info', b'level': 0, b'data': b'User <username> was authenti=
cated by password not ticket.'}

I guess, that's because I have P4PASSWD variable exported and/or git-p4.pas=
sword set.


> The following patch fixes the problem for me:
>=20
> --- /usr/libexec/git-core/git-p4~        2018-12-15 14:51:07.000000000 +0=
100
> +++ /usr/libexec/git-core/git-p4      2019-01-06 23:23:06.934176387 +0100
> @@ -332,6 +332,8 @@
>               die_bad_access("p4 error: {0}".format(data))
>           else:
>               die_bad_access("unknown error")
> +    elif code =3D=3D "info":
> +        return
>       else:
>           die_bad_access("unknown error code {0}".format(code))

This fixes the problem for me too.

>=20
> Not sure if this helps, but running "p4 -G login -s | hexdump" gives:
>=20
> 00000000  7b 73 04 00 00 00 63 6f  64 65 73 04 00 00 00 69  |{s....codes.=
...i|
> 00000010  6e 66 6f 73 05 00 00 00  6c 65 76 65 6c 69 00 00  |nfos....leve=
li..|
> 00000020  00 00 73 04 00 00 00 64  61 74 61 73 35 00 00 00  |..s....datas=
5...|
> 00000030  27 6c 6f 67 69 6e 27 20  6e 6f 74 20 6e 65 63 65  |'login' not =
nece|
> 00000040  73 73 61 72 79 2c 20 6e  6f 20 70 61 73 73 77 6f  |ssary, no pa=
sswo|
> 00000050  72 64 20 73 65 74 20 66  6f 72 20 74 68 69 73 20  |rd set for t=
his |
> 00000060  75 73 65 72 2e 30                                 |user.0|
> 00000066
>=20
> Best regards,
