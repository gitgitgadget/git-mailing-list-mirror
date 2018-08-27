Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCE1A1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbeH0Wyz (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 18:54:55 -0400
Received: from mail-co1nam03on0115.outbound.protection.outlook.com ([104.47.40.115]:22144
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726823AbeH0Wyy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 18:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJC3AjRfCkk3wO7xG2S/xo2q4coYLRTmH9Y9bFKm2ag=;
 b=hehtsoQH6I/sSCMZqspet6Zbfmh2sxfnmNTd6/cWweZJB9OZ9s+CHqPVqU7whp4B3zDUhyZC8mkeOGNRlXNmElO2ohTYuNxUvAd5E6yujdEy1Niky8XERYkZCfEGD2MGZGwfBysDEzKf1pGaHcczgQdjYU1rrMYmrfKpR7FWtGA=
Received: from MWHPR21MB0701.namprd21.prod.outlook.com (10.175.142.11) by
 MWHPR21MB0832.namprd21.prod.outlook.com (10.173.51.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.1; Mon, 27 Aug 2018 19:07:00 +0000
Received: from MWHPR21MB0701.namprd21.prod.outlook.com
 ([fe80::211c:e997:6d2f:2dc2]) by MWHPR21MB0701.namprd21.prod.outlook.com
 ([fe80::211c:e997:6d2f:2dc2%7]) with mapi id 15.20.1122.000; Mon, 27 Aug 2018
 19:07:00 +0000
From:   Brennan Conroy <brecon@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git clean removing tracked files semi-regularly
Thread-Topic: Git clean removing tracked files semi-regularly
Thread-Index: AdQ+OSCvyHcGJtFFTISUdCPT9MCWRA==
Date:   Mon, 27 Aug 2018 19:06:59 +0000
Message-ID: <MWHPR21MB0701CD1D9653E82116E482ECD60B0@MWHPR21MB0701.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=brecon@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-08-27T19:06:58.4280980Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:883f:e5a3:ea29:dd51]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0832;6:SsRPUTmWnlcTi5rhSxSWWbMgn6LgEwLlXamRxGP3qiQL491+X9nHAlsHKVw6v1NE9fxg5mFfEAo4y8uMPwxlyP4RUF+HsTBf2dR2e5fF9JeP8zwHDAy01H0sncWYwY4gROB9EzHJDz07JFlyYe4gnwPCmXRumtRZWk2LULHNP0UCWK/LKxTG29M6NPEqWWUZxrt6Z1uYo/BWe/MgVzhl6MH0fIpFfV4GD0cla3xvyooKCx1xf7vvZaIAKyZBTG1buF5Dab2bTtbufVdxAKDDPIFJ/1Q5BMlfrkED7A8+rugWSnKOQXx2j8u8enyMwSycIslf2sruThS4S0SoJOmEP2EBaGdev3jpOY00VqelMvsbpY/Vw7rYxfkhWVNl0yWnJTqczFfa7tzEQj0KmGecTIoNqsGx1jX6YI7HVySrM63HUcIXQ4E/DhTOW6U7dfTtDC5dpk7TAub0rTgKwVQIMg==;5:eMxumddhtYcCxFk+1JdGi50sfzLdByiqaBZz7UYOF3j7nv4CsBn2xXEh9ghSDK+6PUXjTvzI62Vet/mTvIpaQNsmbAbdnlsyGCBUkHHpsE3hJaTGcZJe2eHebYmxEPzenNJPrK6K3H6uusG+woryBhvr+vY2XHzldLkgq5H7y80=;7:wnE5cox6/9I32dcRoJs9dkZzvCJylDUvEao0Wk9STs1d7vwecof0szdqYPGlWob/h0bGeQWdceszFAQkeI6PWtOocA0sj5qw7gkrW+YDuuPurO9UWZD3HtroHHDpc5jBYBzg5s0pHGXBsXGBDFg1JD9PErvUyXInsNeuXkQMx0usPiQY6Y8mzWbA8RqplFUMp9DnrCA8Ahu52O9asoxJWSRt70Lhhy8mLLlcI7V3xwpIBtX9ToknHp6yCdkxuLjL
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: cf096373-5125-4ed7-4cdf-08d60c504430
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:MWHPR21MB0832;
x-ms-traffictypediagnostic: MWHPR21MB0832:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brecon@microsoft.com; 
x-microsoft-antispam-prvs: <MWHPR21MB0832F4BD48877BC91C7E1A68D60B0@MWHPR21MB0832.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231336)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(201708071742011)(7699049)(76991033);SRVR:MWHPR21MB0832;BCL:0;PCL:0;RULEID:;SRVR:MWHPR21MB0832;
x-forefront-prvs: 07778E4001
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(136003)(396003)(346002)(366004)(199004)(189003)(2900100001)(53936002)(86362001)(5250100002)(86612001)(25786009)(106356001)(478600001)(10290500003)(7696005)(105586002)(97736004)(966005)(14454004)(5640700003)(102836004)(6506007)(2501003)(99286004)(55016002)(9686003)(6436002)(6306002)(486006)(6116002)(22452003)(186003)(5660300001)(68736007)(74316002)(33656002)(476003)(8936002)(2351001)(7736002)(305945005)(10090500001)(8676002)(6916009)(2906002)(81166006)(14444005)(256004)(1730700003)(46003)(316002)(81156014)(8990500004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0832;H:MWHPR21MB0701.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: kXVjftG0iuGphlOr98lGvt8D1z8JqYBSaDf1/bkGwizpr+TUc+lJ6lQqb0QCVE8wPBYEWqta+jILCmXuZRP+d2YGdvyUWfikdiD3mkXxbILfya5+uHjfo2F47Cnax5TVLofHVocGxvW6JRBN29csmejwT7lLOdRQ7uVhYyFaC8/OBGYGlmq0VCGr3ZZRL7gtmvSr5Ts0bDuzzSLrhcxo7JpI0t4RYvoIKcbxEVMtDpeIIDion9ppp1cqvJ+SIvrEQ/kQQP5C04u82qETI8BQk8C5rmEPhBrrLwbU/Evvs72ad8SqUUe0eJvWkmfEYD8m3AXUOHZM/Tm2Bv+R7E/D2J+tzxnmqg8hsR0bYTDGoxY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf096373-5125-4ed7-4cdf-08d60c504430
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2018 19:06:59.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0832
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, I work on a project that uses git. "git clean -xdf" is a common comm=
and to run to clean up the environment, however sometimes this command dele=
tes the entire contents of two of the folders and all the files it deletes =
are being tracked which according to the documentation should not be delete=
d.

The project is located at https://github.com/aspnet/SignalR and the two fol=
ders it likes to delete are https://github.com/aspnet/SignalR/tree/release/=
2.2/clients/ts/signalr-protocol-msgpack and https://github.com/aspnet/Signa=
lR/tree/release/2.2/clients/ts/signalr=20

If you need me to collect git logs etc. please don't hesitate to ask!

