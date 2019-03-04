Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0D120248
	for <e@80x24.org>; Mon,  4 Mar 2019 17:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfCDReo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 12:34:44 -0500
Received: from mail-eopbgr760120.outbound.protection.outlook.com ([40.107.76.120]:18492
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727131AbfCDReo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 12:34:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kastle.onmicrosoft.com; s=selector1-checkvideo-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k9YICPqNcOhP3eMjt9EpdWJ5qicbmAdSRvotvThQFKs=;
 b=XO9eiB1qOBbkjKDNpErZiDehJezgclrnmXmMx9gQFBi6xcAjiG3U5TFU/MZl36M2ChPI2zlq3L4QdxfWa7YkGiUW7eAve9Gat1+jBKAYX8h0C7FNcMPxAkBYoV1bZvKHiRPJky8MQDFsBTX24oiDhoAtbpVbR11Yi0xWRIvgETo=
Received: from DM6PR08MB4956.namprd08.prod.outlook.com (20.176.115.217) by
 DM6PR08MB4377.namprd08.prod.outlook.com (20.176.82.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Mon, 4 Mar 2019 17:34:38 +0000
Received: from DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244]) by DM6PR08MB4956.namprd08.prod.outlook.com
 ([fe80::75e5:faf9:290a:a244%3]) with mapi id 15.20.1665.019; Mon, 4 Mar 2019
 17:34:38 +0000
From:   "Mazo, Andrey" <amazo@checkvideo.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Mazo, Andrey" <amazo@checkvideo.com>,
        "luke@diamand.org" <luke@diamand.org>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "gvanburgh@bloomberg.net" <gvanburgh@bloomberg.net>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "miguel.torroja@gmail.com" <miguel.torroja@gmail.com>,
        "merlorom@yahoo.fr" <merlorom@yahoo.fr>,
        "vitor.hda@gmail.com" <vitor.hda@gmail.com>,
        "aoakley@roku.com" <aoakley@roku.com>,
        "szeder.dev@gmail.com" <szeder.dev@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Subject: [PATCH 0/5] git-p4: a few assorted fixes for branches, excludes
Thread-Topic: [PATCH 0/5] git-p4: a few assorted fixes for branches, excludes
Thread-Index: AQHU0rCKUnyroINqH0qMV9XfZIBqCQ==
Date:   Mon, 4 Mar 2019 17:34:38 +0000
Message-ID: <cover.1551485349.git.amazo@checkvideo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN6PR13CA0046.namprd13.prod.outlook.com
 (2603:10b6:404:13e::32) To DM6PR08MB4956.namprd08.prod.outlook.com
 (2603:10b6:5:4b::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=amazo@checkvideo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.2
x-originating-ip: [70.163.25.109]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eeec8f49-338c-4c0b-205a-08d6a0c7acf0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM6PR08MB4377;
x-ms-traffictypediagnostic: DM6PR08MB4377:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM6PR08MB4377;23:dFhvhI+dcAsWHCirqyV+o554x4IJdyla8TOghz2?=
 =?iso-8859-1?Q?pn2yLy++BFKt2499M6azmY7gyUmA+f8xQ11FCgusRMz4MaLDMKkxRebFWD?=
 =?iso-8859-1?Q?zU/gmt3ehRT0ni+0pFk79DuoYM/s+7uoG/ltSBMEnaSuKgFNED877IV44u?=
 =?iso-8859-1?Q?H9Xr+Y071z3g9KyLlVnWo1lq5G1yjo6dumg0d5JkWh/a8YZa+0DvZN51Aa?=
 =?iso-8859-1?Q?9kIu0lqdAKv5T7brHw9XIoHXe3vnu2eeboDPDyjPNORTsBX2h5euQLBQGa?=
 =?iso-8859-1?Q?fUq3YGaDoMNiYHY3k9IPddjiAVDVK0gpyLThinLg/ZejKPe9S0qS8VD8vR?=
 =?iso-8859-1?Q?yo69v4qQPJQxCOVDbOcf67Tw1sgAEBdU9pKPS6FNRrJy20ENR6uB9DnCGn?=
 =?iso-8859-1?Q?88TRkDRGSyVQDH82cOLF3iK8RJVxIYfRhreOtf0DoeYZx01dquNcnCgeVp?=
 =?iso-8859-1?Q?sGZX/1RaS9+VCI3uaEY1+Eq7gD/+qdrha3a107XWvBVXDO9bvmyJP9Snd0?=
 =?iso-8859-1?Q?5tD1MWlNOtdqY6aL9ewJPmvGiBnDYtke71Pm7JgE1LIGl3m35jiCPrVyuC?=
 =?iso-8859-1?Q?o8xJWSJ3rRzNeM9pPRp8N65bJuJvbYGQy4A0Iff44rGHko0Xy0OlYlpiTD?=
 =?iso-8859-1?Q?1gT0VjDmRawCLWNyflOso/rnHoi8KcvDjYBtTDEjLrISxwpVvmBfXxLTbf?=
 =?iso-8859-1?Q?4IoAi0Oe2QrWL5CETTKZbpfPcTvfEHc14xXYwufkuAVCfXFY3cCyfPNCpH?=
 =?iso-8859-1?Q?lfQIQyDkOG/9Oqh/f50wyA9q4t67c5rxw7Y3D2ibS8Hm4mhMin+8NpngfL?=
 =?iso-8859-1?Q?NHWzS7kRaYE/Kpv42hEl52qvqMwUpgXW0uOuzZyLos5ydcIjl0nGKq8Gxv?=
 =?iso-8859-1?Q?eD0b9sFC9bAlNpJJops8jmMiw5r7HonpIBf/wyYHEBj3HBUEoCtBRFC5Nx?=
 =?iso-8859-1?Q?bYeU6CQUS/tT5QreyPynpY2rGxtsuwtbLbJV/BDpAqtlW49Gq1ESVHhHqx?=
 =?iso-8859-1?Q?QwXspflV4saNY8kSGHLvcaP+5FjPOg+mHt+SeFtr0lfySplcOc++zG3h7g?=
 =?iso-8859-1?Q?C5Ny1A9GC5821IztopfauC34yqWjd5CRJjzdrmOxBUW2yUaCPRHub+0PNd?=
 =?iso-8859-1?Q?Phf7t8EcccRGlZNNOfgJghgR9be1rGQISXB4O0nj/h/IwKgRmedt3teF6U?=
 =?iso-8859-1?Q?CAvD4+U3B2uEoyNQzh1of21TBMHhx4yoyTvbzs9XmsI12LFwbzRM+XtNn1?=
 =?iso-8859-1?Q?JaiNnEfbcrFIlBmJjb6NgQbU6HU4uiTfDACm4vnzTs6Dcj+iZVWW4dGkTy?=
 =?iso-8859-1?Q?+EKYKJbJyOAmnctXxpPN+qg?=
x-microsoft-antispam-prvs: <DM6PR08MB437703B9400283AB55EEFFE1DA710@DM6PR08MB4377.namprd08.prod.outlook.com>
x-forefront-prvs: 09669DB681
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(366004)(39860400002)(376002)(396003)(199004)(189003)(316002)(5640700003)(86362001)(3846002)(6116002)(186003)(26005)(6512007)(4326008)(6916009)(486006)(6486002)(66066001)(53936002)(6436002)(256004)(14444005)(6506007)(52116002)(102836004)(99286004)(386003)(2906002)(478600001)(14454004)(2351001)(2501003)(81156014)(5660300002)(81166006)(1730700003)(8676002)(68736007)(2616005)(8936002)(97736004)(50226002)(54906003)(7416002)(105586002)(106356001)(4744005)(25786009)(36756003)(305945005)(7736002)(71190400001)(71200400001)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR08MB4377;H:DM6PR08MB4956.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
received-spf: None (protection.outlook.com: checkvideo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HQOYkw5CaMa/cP4nH+cYLKie3ZGMTPC37VQ8l7PDpvvAQ5xVFRI3f5cNFMHQvcA8T+X6UwHrArajS566+qhPk17gIoZ/y3K5YdajWT5U4cNJnZI45QuioZ9lc5PIRA0Wbpx0x9+j+ZYIR8ExCkVSwr4gt0lNzdGRMmsCNzDrMHh5x+gceh56MxSevgjNcFiIQHZFVfrcE6WXNUCChFDK8gCCfeM0o+OKeu532gG4/9BKyN6r0eWEgmp9ytEzjUtoIV2UoImjH/z1B3DfucGHahelxQgivQ8n41qtNTXyHipJAZBOTIm8JTqNsc/1Uz64kzL2GBnJ/IeZO5bKEpukLFlA0i0Run67BDp4PjLMfz8JZt461qj/A/iBVf4lQrRi1NsH3aq071GE5yeVNdLj3Dqfnk4cJvqwuz/JmTXUetg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: checkvideo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeec8f49-338c-4c0b-205a-08d6a0c7acf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2019 17:34:38.4040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7280061d-06ed-4a4e-a2b1-cc9ab5638c09
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB4377
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes a couple of corner cases with branch detection
and handling of excludes by git-p4.

Andrey Mazo (5):
  git-p4: detect/prevent infinite loop in gitCommitByP4Change()
  git-p4: match branches case insensitively if configured
  git-p4: don't groom exclude path list on every commit
  git-p4: add failing test for "don't exclude other files with same prefix"
  git-p4: don't exclude other files with same prefix

 git-p4.py                 | 39 +++++++++++++++++++-----------
 t/t9817-git-p4-exclude.sh | 51 +++++++++++++++++++++++++++++++++++----
 2 files changed, 71 insertions(+), 19 deletions(-)


base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
--=20
2.19.2

