Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B1CA20248
	for <e@80x24.org>; Tue, 26 Mar 2019 18:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbfCZSnr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 14:43:47 -0400
Received: from mail-eopbgr820118.outbound.protection.outlook.com ([40.107.82.118]:41292
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732441AbfCZSnr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 14:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJbXUDEIm3p7tP0oT8cg/s1YEIJsGwfL1L7NLlEVu6A=;
 b=MFT2qB2Zg8JIvNCDZeMULpkYHdZw5t2Ob863SjDuy9NkMeaZWnnN7kDr/FwWy0wFK9M+od4TGPVrdXtTdeCeJBJfPosCJ7ehU4L2Y/zDe23VWgbShAhC3L0u1+sGLRg0FazyCC2p6wwHI9MPdMzXGWU9x4C2pV0kNpEfKBoIl/I=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB5947.namprd08.prod.outlook.com (20.179.69.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Tue, 26 Mar 2019 18:43:43 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 18:43:43 +0000
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
Subject: Re: [RFC PATCH 1/2] git-p4: introduce alien branch mappings
Thread-Topic: [RFC PATCH 1/2] git-p4: introduce alien branch mappings
Thread-Index: AQHU4OkP5k6YadBSpkG8wakiVMZ6MKYY7keAgAVXgIA=
Date:   Tue, 26 Mar 2019 18:43:43 +0000
Message-ID: <20190326184327.28335-1-amazo@checkvideo.com>
References: <CAE5ih797T4vtuFsDhXuNGX+A89ZQ26GOae9Dt4PVaCwJ8C_GVg@mail.gmail.com>
In-Reply-To: <CAE5ih797T4vtuFsDhXuNGX+A89ZQ26GOae9Dt4PVaCwJ8C_GVg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MN2PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:160::40) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee878838-94e3-4e93-9a17-08d6b21af895
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB5947;
x-ms-traffictypediagnostic: DM6PR08MB5947:
x-microsoft-antispam-prvs: <DM6PR08MB5947EF0C40DDDC2AA3C3D91EDA5F0@DM6PR08MB5947.namprd08.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(189003)(54094003)(7416002)(6486002)(102836004)(25786009)(71190400001)(71200400001)(2351001)(186003)(99286004)(54906003)(5640700003)(105586002)(106356001)(6916009)(2906002)(36756003)(386003)(4326008)(6506007)(229853002)(256004)(486006)(81156014)(26005)(52116002)(81166006)(1730700003)(2616005)(305945005)(7736002)(6246003)(76176011)(97736004)(68736007)(14454004)(8676002)(66066001)(86362001)(6512007)(1076003)(50226002)(6116002)(3846002)(53936002)(316002)(19627235002)(446003)(11346002)(476003)(478600001)(6436002)(5660300002)(2501003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB5947;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bHTFrpL8btxauC/7f9WBk69ZaPnACtFjYlrMWPvt6UHwHoAmE7QqH0/GDUAiGucKFCi0eVhJ868SYasaNZryZueDy+fvJRo2gOHLlTxLS5xLoleQFZEup8IuVfLoa1MLruZIAmBishgu39b568UjXsW12oukmR5xyl8cGiJSOMy9vJscxqNEI4oeHKMlSM9bGpjE6ZinlFMGZzMxXV9mkzHrL2E7s125pJsFb7JdApIFxud3T631rT8ZiTCGo2d3gjc884pUqBnTVm8CYiRnO/g9t5/JjaupQYswElvxJG1IhEAyAg7QigFrtuOQFU39YcCQ6gVSleorAb90hro2jEjTHGWSxgX4hoctZ3BKp/kR8KzPgiJTLN8AsGub26PVvmxEQ/404MOedRKELxwC9pA78h4feGaJ84HGMcH8vgg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee878838-94e3-4e93-9a17-08d6b21af895
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 18:43:43.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB5947
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> Labels in Perforce are not global, but can be placed on a particular vie=
w/subdirectory.
>> This might pose difficulties when importing only parts of Perforce depot=
 into a git repository.
>> For example:
>>  1. Depot layout is as follows:
>>     //depot/metaproject/branch1/subprojectA/...
>>     //depot/metaproject/branch1/subprojectB/...
>>     //depot/metaproject/branch2/subprojectA/...
>>     //depot/metaproject/branch2/subprojectB/...
>>  2. Labels are placed as follows:
>>     * label 1A on //depot/metaproject/branch1/subprojectA/...
>>     * label 1B on //depot/metaproject/branch1/subprojectB/...
>>     * label 2A on //depot/metaproject/branch2/subprojectA/...
>>     * label 2B on //depot/metaproject/branch2/subprojectB/...
>>  3. The goal is to import
>>     subprojectA into subprojectA.git and
>>     subprojectB into subprojectB.git
>>     preserving all the branches and labels.
>>  4. Importing subprojectA.
>>     Label 1A is imported fine because it's placed on certain commit on b=
ranch1.
>>     However, label 1B is not imported because it's placed on a commit in=
 another subproject:
>>     git-p4 says: "importing label 1B: could not find git commit for chan=
gelist ..."
>>     The same is with label 2A, which is imported; and 2B, which is not.
>>
>> Currently, there is no easy way (that I'm aware of) to tell git-p4 to
>> import an empty commit into a desired branch,
>> so that a label placed on that changelist could be imported as well,
>=20
> So there is a file in subprojectA/foo.c@41.
> And label 1B is against //depot/metaproject/branch1/subprojectB/bar.c@42.
>=20
> And I suppose in Perforce you could still checkout subprojectA at
> change 42 and you would get change 41.
>=20
> But with the way git-p4 works, the label just gets discarded.

Yes, exactly.

> You want to be able to checkout the subjectA with a tag called 1B and
> get the file contents as of 42.
>=20
> I wonder if it would be easier to teach the code in importP4Labels to
> go searching harder for the next lower changelist number?
>=20
> Where it currently says "could not find git commit"... could it do
> something like "p4 changes -m1 //depot/path/...@LABEL" and use that
> instead?
>=20
> I'm not sure if that would work but it would mean you wouldn't need
> any extra configuration to maintain.

Yeah, that's a great idea!
I think, it should work pretty well in simpler cases for sure.
Initially, I was thinking, that I needed an explicit configuration option
to choose the proper branch/subproject in a more complicated case,
but let me give it a try to your idea -- hopefully it just works.

Some new option like git-p4.allowInexactLabels to enable this behavior?
Don't think it should be enabled by default unless git-p4.labelImportRegexp=
 is set, right?

> But perhaps I have misunderstood what you're trying to do here!
> Perhaps a failing test case might help explain it better?

No, I think, you got it right!
Thank you for the great suggestion!

Yeah, let me see if I can get a simple but representative test case.

>=20
> Thanks
> Luke
