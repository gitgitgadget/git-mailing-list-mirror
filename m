Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095D61F42D
	for <e@80x24.org>; Wed, 23 May 2018 16:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754721AbeEWQli (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 12:41:38 -0400
Received: from mail-dm3nam03on0100.outbound.protection.outlook.com ([104.47.41.100]:51470
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754661AbeEWQlh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 12:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMorxeady7U0Wdr7/FhVxRQJwv0U62UOs/CSvzdKhLA=;
 b=NP3fEKTMgEo+5OwLki9aOaYBKFdOUPX6UylMSip6IeARpWEMfdQbQ3yKwseHfkzrx7/aip3kYa2UfVM7HN0hallhhmzkNVrEcEDtrWr44nMJVI9VT3beRiAaUvBM3jGHefnGDBV9BTyL16RAuG68BCyavYXalEwKIISsx91cFdc=
Received: from BYAPR08MB3845.namprd08.prod.outlook.com (52.135.193.27) by
 BYAPR08MB4088.namprd08.prod.outlook.com (52.135.195.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.776.11; Wed, 23 May 2018 16:41:34 +0000
Received: from BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::5d83:1086:8c95:496]) by BYAPR08MB3845.namprd08.prod.outlook.com
 ([fe80::5d83:1086:8c95:496%13]) with mapi id 15.20.0776.015; Wed, 23 May 2018
 16:41:34 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
CC:     =?iso-8859-1?Q?SZEDER_G=E1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Romain Merland <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "George Vanburgh" <gvanburgh@bloomberg.net>
Subject: Re: [PATCH 1/1] git-p4: unshelve: use action==add instead of
 rev==none
Thread-Topic: [PATCH 1/1] git-p4: unshelve: use action==add instead of
 rev==none
Thread-Index: AQHT8airjeXQ5f01pkuKAZVmKCNFT6Q7iFGAgAAup4CAANq2qIAA78Jd
Date:   Wed, 23 May 2018 16:41:34 +0000
Message-ID: <BYAPR08MB38451D101964D3B4D10436EBDA6B0@BYAPR08MB3845.namprd08.prod.outlook.com>
References: <20180522084109.29787-1-luke@diamand.org>
        <20180522084109.29787-2-luke@diamand.org>
        <CAM0VKjkdGByfTtj5cunUzqeneu4Bi8Qw4vj428zV1h3ezHXyQg@mail.gmail.com>
        <CAE5ih79_Ai8F48zFpJ09e8saGrySoiyVdsgkk8ZpRrQAd15a4g@mail.gmail.com>,<xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1rvw2i1.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4088;7:aBqbD3L0VBvb3AjHRh+liPnLMNPTCqm6X1e+Tp3xMjcFXRzA+UguaG7jJlDzw/MRjC1b4Wkzy+GCBIR2tvk79QnQSV8r5tRtfqf1jSFEW9iLxAn9UhPkcIVE9JJLNYav9qkJQldqw8GMNNDbSTiudifOzlKPPKLBvqMt/AyqPA2dMkFtEwBmMWaiM5YbUtImy2Adt2pwuNHgpjec5LZdq8NcLVhTukbQahU8Xx6EMd1z4kLtSepizoBYbdHe1QG7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4088;
x-ms-traffictypediagnostic: BYAPR08MB4088:
x-microsoft-antispam-prvs: <BYAPR08MB40887E7532C58262F9E50A30DA6B0@BYAPR08MB4088.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4088;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4088;
x-forefront-prvs: 06818431B9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(39860400002)(39380400002)(396003)(55674003)(189003)(199004)(68736007)(2900100001)(93886005)(229853002)(106356001)(5660300001)(66066001)(99286004)(486006)(446003)(7696005)(8656006)(6506007)(76176011)(6436002)(476003)(11346002)(14454004)(3280700002)(6246003)(3660700001)(86362001)(186003)(575784001)(110136005)(6116002)(3846002)(25786009)(26005)(966005)(4326008)(305945005)(8676002)(81166006)(54906003)(39060400002)(316002)(102836004)(74316002)(53936002)(9686003)(8936002)(7736002)(81156014)(97736004)(33656002)(2906002)(55016002)(6306002)(478600001)(5250100002)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4088;H:BYAPR08MB3845.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fxRCLolfVld0MuCFGfgwZFNSiUwqxFXvvJHYPV8p44+ySIKmVkinyNi/gkVRzV1pi6ysWq2sI4Ml3FoSggNQxnLNGNa2J001pcIkNC34/GmcAToQJT0vt6IaZL1j8wD0zZ6W8RZpFFhuTAjouPpoTgJ/Djn4X7amDbZu2q/FHCBqQ0Qc2KpuwlC2zGprHBe+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c8bd9fd5-9731-4b0e-d04d-08d5c0cc0bf3
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8bd9fd5-9731-4b0e-d04d-08d5c0cc0bf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 16:41:34.7181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4088
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The last one (i.e. "even if it is verbose, if fileSize is not
> reported, do not write the verbose output") does not look like it is
> limited to the unshelve feature, so it might, even though it is a
> one-liner, deserve to be a separate preparatory patch if you want.
> But I do not feel strongly about either way.

This was actually discussed in a separate thread [1] some time ago with pat=
ches proposed by Thandesha and me.
I haven't yet got time to cook a final patch, which addresses both Thandesh=
a's and mine use-cases though,
so this wasn't submitted to Junio yet.
In the meantime, I guess, one of the patches [2] from that thread can be ta=
ken as is.

[1] "[BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key"
      https://public-inbox.org/git/CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq=
9YviobRpYGg@mail.gmail.com/t/#mee2ec50a40242089741f808f06214a44278055b3
[2] "[PATCH 1/1] git-p4: fix `sync --verbose` traceback due to 'fileSize'"
      https://public-inbox.org/git/2e2b2add4e4fffa4228b8ab9f6cd47fa9bf25207=
.1523981210.git.amazo@checkvideo.com/

Thank you,
Andrey Mazo=
