Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D355F1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 10:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfAVKLG (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 05:11:06 -0500
Received: from mail-eopbgr60046.outbound.protection.outlook.com ([40.107.6.46]:17952
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbfAVKLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 05:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cardiff.ac.uk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsGS0O7zQWB4z1aswLUan/L+U+v6TDzrXD3KeeNTS8I=;
 b=I0CZCsVU0969zYjMSyImC9HwmkunET85CsAiuwx9CXkphuaPuO43+i7RQ2nw2I/xnpDg3L8Ah9btuQNpf7LUwoHx4VkEmHl8Y8IubLchegt6AdNmCzPsThViDxlvgjbYHYjGoEYbg8k03YN6gXN5mQZQJUiMnTIazzWurVT0iu4=
Received: from AM6PR02MB3781.eurprd02.prod.outlook.com (52.134.113.138) by
 AM6PR02MB4834.eurprd02.prod.outlook.com (20.177.117.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 10:11:03 +0000
Received: from AM6PR02MB3781.eurprd02.prod.outlook.com
 ([fe80::d541:e7e8:96f1:bc17]) by AM6PR02MB3781.eurprd02.prod.outlook.com
 ([fe80::d541:e7e8:96f1:bc17%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 10:11:03 +0000
From:   Ralph Martin <MartinRR@cardiff.ac.uk>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Ralph Martin <MartinRR@cardiff.ac.uk>
Subject: Improved Error Message
Thread-Topic: Improved Error Message
Thread-Index: AQHUsjrHjWSe0SNma0Wxbx5ZysJP9A==
Date:   Tue, 22 Jan 2019 10:11:03 +0000
Message-ID: <EE441A47-48F0-46F3-BF28-C22FDC20169B@cardiff.ac.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.102.3)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MartinRR@cardiff.ac.uk; 
x-originating-ip: [37.205.56.231]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB4834;6:PbXg7Y2wtBrSh3bOy2erlYUXf0IdUxnK+tdRa2XwGA4waLxOakJuhPvD6L+09n/GEgLnlwzMRZb07KDzYbgbIuz9gH9b/Fxyx1ZCqSDMTPa7DGVXta1h0mOUzvS346dm6QqHl75hpFxVEbmdOup9fD8iWDCxv3MQGKN3aU6sCzuTHBZjJWwLR30W4Jta/CXDn7Qq2oyIdZA/uwfXORgES9LgiXoti4D1HNdiJkw9EbFtQsQzAVkUsizTN1dlmd8P/dz84o7cC+VOsHGvzLpuc1Lfc08UkWv/ZEyTAxP+jyU9XDpSYHQkhjiH41GTjzLYyKnyP4NZNfckezEaMGUVCJJy+I0wxA/ji6LfC2KKVH7D5LMUezhtziBQChfZw96NoxBQoefQQO0DryPXksR/gBuwwG1Csx+/r3crtI6MHRjv/4x4DGXCoABWmU0dYEgJC1+7qXx8hITZ/fN4NYlUtg==;5:7dEIzltsSLy+jR/ZKl6bmsRKkkao39NZHdfrnhfJEpv+hrrqqf7TfaewpZJ00vM3WRvSeuLIuCWBnzerXj7rwmCOq7T00Pt0Q7lS0Ni45o+tY4g95sjSIh290Sw4EcDWRd5mHeyaO4OD2oH0+CIf79Hzng/9BwaEpwN57CJ9GhY/cIpOssAmvLV0T1fEJNbkvY7zTDUE85mkn9u5k0Al9g==;7:55ezoc40a+FKTzlYb8TLon5nZfQIcaIQi2ugwHimk2E1XY4x6QDzuJh7uWOovjmJALMnUb1Q0KxkctZX5B+Y2CJDlhmB2DBpUkVCQyWTlrmX9HN/8o+6yRlIF1Z8+n7wYwHcPZwJ6B24YK5ZldH3Pw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 874591b2-0095-40b9-76f2-08d68051ea64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB4834;
x-ms-traffictypediagnostic: AM6PR02MB4834:
x-microsoft-antispam-prvs: <AM6PR02MB483485E168D3A5571B53E43996980@AM6PR02MB4834.eurprd02.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(366004)(189003)(199004)(3846002)(3480700005)(71190400001)(86362001)(83716004)(71200400001)(6116002)(2351001)(80792005)(82746002)(4744005)(74482002)(99286004)(25786009)(97736004)(8676002)(1730700003)(81166006)(486006)(81156014)(5640700003)(66066001)(26005)(15650500001)(476003)(6486002)(4326008)(2616005)(186003)(316002)(68736007)(786003)(6916009)(6436002)(6512007)(2501003)(305945005)(102836004)(7736002)(57306001)(14454004)(36756003)(6506007)(33656002)(107886003)(106356001)(8936002)(105586002)(72206003)(256004)(7116003)(478600001)(2906002)(53936002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR02MB4834;H:AM6PR02MB3781.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: cardiff.ac.uk does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ujTgMrzozp6MWbPt6UhJ6kEga0n34RKoyLiGYNQ0bGPRisbPo/bujyM7PVzoFAyGAiyc4RdUSgyk8alZvglJWj5g3VkiSrqteuH2gcnunJc2RIML2Wij6YsG/WKpTmjN6HMugsBt1jo5XSgXIuZj+3yzlkOs+c/5/wlTfinF7jX35rNKMxRHIzTD4qJiVuYmqi70O8vFWxanpjgiSgvASBJZWakmY+wjmny/rZnA/QaBxeehOzxtCF1FgfY1njjGiYkCthIoUEmjeargJz9q/R2mFtawgfWJAB4u6b8lNijV6sY20jy3NoHKxh4Kd7uZF0x19e1Dmdj7yC8gabKUSzh6j7E+1k0tgF+vWoM7s22pC+1oZ4nL3v4vdKkcCJRzkrHpooNFZBsvCNPGtvaVHrq5yzDCgg0WOBhafNFZSzQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <627CEB62D87EBE43AB05859650BC7C1A@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cardiff.ac.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 874591b2-0095-40b9-76f2-08d68051ea64
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 10:11:03.1832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bdb74b30-9568-4856-bdbf-06759778fcbc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB4834
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While using cask-repair -d from homebrew, I got multiple messages of the fo=
rm

ERROR: Repository not found.
fatal: Could not read from remote repository.


The author of that command tells me these were issued by git.
Unfortunately, they are rather unhelpful, as they do not tell the user whic=
h repository has not been found.
Could they please be improved to include the name of the repository which c=
ould not be found?=
