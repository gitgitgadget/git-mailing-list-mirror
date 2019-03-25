Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F135A20248
	for <e@80x24.org>; Mon, 25 Mar 2019 17:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfCYRqa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 13:46:30 -0400
Received: from mail-eopbgr690115.outbound.protection.outlook.com ([40.107.69.115]:60883
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729548AbfCYRqa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 13:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdPa99q9oOtLhJ0wUfWvefBLQNWSCiA0fWW1yoi0Uy8=;
 b=u5siuI/wLMRZMn2MeInpQR5kHODtymC/oqIjxbLmGAFEeaiu5JrxvFAV9z/1QTR7Gow60Muwe6aFq38DUiHOMP+gyzsPD4muQozKZ4Sf0F66e6v8nA+V7YOHEfYn8lahnpXrmTg+56uTjewV8oeYgn4SMcsAcsAAPWTZPQ/ZmQs=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4234.namprd08.prod.outlook.com (20.176.81.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 17:46:25 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 17:46:25 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "luke@diamand.org" <luke@diamand.org>
CC:     "ahippo@yandex.com" <ahippo@yandex.com>,
        "Mazo, Andrey" <amazo@checkvideo.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>
Subject: Re: [RFC PATCH 2/2] git-p4: support loading changelist descriptions
Thread-Topic: [RFC PATCH 2/2] git-p4: support loading changelist descriptions
Thread-Index: AQHU4zKqQiD0TGqNTE6MUD7Hj7LYwA==
Date:   Mon, 25 Mar 2019 17:46:25 +0000
Message-ID: <20190325174615.1231-1-amazo@checkvideo.com>
References: <CAE5ih793TVn0NJ54CJTmOZ0Gr2Y4GSYwP-DAyRpjsgJsGc-NrA@mail.gmail.com>
In-Reply-To: <CAE5ih793TVn0NJ54CJTmOZ0Gr2Y4GSYwP-DAyRpjsgJsGc-NrA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BL0PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:91::21) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a613ce62-df25-43c3-ec51-08d6b149ccfb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4234;
x-ms-traffictypediagnostic: DM6PR08MB4234:
x-microsoft-antispam-prvs: <DM6PR08MB4234B281F094027CC2AE691ADA5E0@DM6PR08MB4234.namprd08.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(39850400004)(346002)(376002)(189003)(199004)(86362001)(14454004)(2351001)(229853002)(316002)(7416002)(1076003)(4326008)(25786009)(54906003)(106356001)(6246003)(36756003)(5640700003)(256004)(53936002)(6512007)(105586002)(6486002)(2906002)(6116002)(2501003)(3846002)(5660300002)(68736007)(486006)(1730700003)(386003)(6506007)(99286004)(19627235002)(8936002)(81166006)(66066001)(81156014)(102836004)(50226002)(97736004)(6436002)(186003)(76176011)(52116002)(11346002)(446003)(476003)(26005)(6916009)(2616005)(8676002)(71200400001)(7736002)(71190400001)(305945005)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4234;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7S9UgpEi8SjYKOEId6v3WMIR3IIbSiGE+bs+IeJ9LJvG5nxYPvyP8MZKwBNkiirbBswX2cSiLsnOs+AFBvXITs3dZERoQQEZAckCS2rhhVN06OJfWtmhQWKrscITQLbxTtwcJkT2fSkj/MXOQ10cXXbJUPxgZu0S0UXzsks0qXCtnBdQE7AJm3NWwX71uuAyHwsP1Zqq1jEzsNXe1jrDKs4Hxg8qWwRYn46P3Vh0beYfLqTQZwgcy2SrUBGwcEwl68RR2epLTno7rVatgdTYFYivwr5ypuXofClnKYlUzeok3JWi7RfQ8Eu//k8MX3uU6ekyhEOJI82bmsDYvx0nk6GfJV7FWk83RPDJ6lU79Y4SvktiY+1TU5iJ6hJYDE0WDzf+nBVDTQs1wOQxME0QzxkMvI6oNkq5EYfWMHiPRXU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a613ce62-df25-43c3-ec51-08d6b149ccfb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 17:46:25.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4234
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

23.03.2019, 04:44, "Luke Diamand" <luke@diamand.org>:
> On Fri, 22 Mar 2019 at 19:54, Mazo, Andrey <amazo@checkvideo.com> wrote:
>>  Our Perforce server experienced some kind of database corruption a few =
years ago.
>>  While the file data and revision history are mostly intact,
>>  some metadata for several changesets got lost.
>
> I think it's not unheard of for P4 databases to end up being corrupt,
> as in your case.
>
> It looks like the RCS files get updated, but the database files (i.e.
> the metadata) do not, after which you have a bit of a problem.

Yeah, that's exactly what happened! :/

> So I guess this change could be quite useful, but it really needs some
> documentation and tests to support it - git-p4 is already complicated
> enough!

Great, thanks for positive feedback.
Let me start working on these.
Luckily, the actual git-p4 changes are fairly straightforward.

> Your example script should probably use the same magic that the git-p4
> script uses to pick the path to Python.
Oh, you mean "#!/usr/bin/env python"?
Sure!

Actually, I also have a smarter "example script", which reconstructs `p4 de=
scribe` output from `p4 files` and `p4 change` without manual intervention.
It's still short enough to be posted inside commit message, but would it ma=
ke sense to put it under contrib/ and reference from the docs?

> And perhaps come up with a nicer name than "damaged" - as you say, it
> could also be used for other purposes.
Does anything from the list below sound reasonable?
 1. git-p4.loadChangelistInfo
 2. git-p4.changelistInfoOverride
 3. git-p4.cachedChangelistInfo

>> For simplicity, it's one pickled file per changelist.
(talking to myself)
I realized `p4 -G describe` produces a marshalled output, not pickled one.
Don't know why I decided to use pickle instead of marshal back when I wrote=
 it.
I'll switch to marshal for serialization/deserialization in the next reroll=
.
It'll be easier for testing as well, since `p4 -G describe` output could be=
 fed directly to damagedChangelists machinery without the need to convert i=
t from marshal to pickle.

Thank you,
Andrey
