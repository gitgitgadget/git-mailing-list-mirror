Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_HIGH shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D17B1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeGLTeV (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:34:21 -0400
Received: from mail-eopbgr680105.outbound.protection.outlook.com ([40.107.68.105]:22896
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726583AbeGLTeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7eZ3BgIrRYenBI5t6HZsqwltdet4qyxjjgIaYl4qB8=;
 b=N9GTbVLHiQp5MQjyB2MlnRN61MHnnprYUSWZI4AHWGUBYqQS+ho+6eWDUqyTc7nJJg3NodwN/t+4l9KNW/5dJ6c7aQ9iXKn270GlJ5gzl4Ng6REuCAwpEskoWKX1VQ4KuHBtVekBZkh6om9lki7jyr6C1k+K/ZN6Y0XUmAe+xWo=
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com (52.132.24.11) by
 BL0PR2101MB0882.namprd21.prod.outlook.com (52.132.23.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.5; Thu, 12 Jul 2018 19:23:23 +0000
Received: from BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724]) by BL0PR2101MB1012.namprd21.prod.outlook.com
 ([fe80::d865:2b6c:e0c8:7724%3]) with mapi id 15.20.0952.017; Thu, 12 Jul 2018
 19:23:23 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
Subject: RE: [PATCH v3] handle lower case drive letters on Windows
Thread-Topic: [PATCH v3] handle lower case drive letters on Windows
Thread-Index: AQHUGfc8DLm8h3WDaEu2/WTYIc2wTqSL9L23gAACWYA=
Date:   Thu, 12 Jul 2018 19:23:23 +0000
Message-ID: <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <20180712154419.18100-1-benpeart@microsoft.com>
 <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-12T19:23:21.9300843Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [70.33.148.227]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0882;7:Fvxlcv8JoZ+0UtfPGYuuwLdrBMLf+11/UklRbVhw8gkuat4NyG6kWmdDS9gvW/zko9CAZ9KrXSSpg/gcVhQ9KMZk9pqn8L8PtfRxrFFyXH+MwAKStrRmBk2AFxJZS5P5u9A76Rs8Kss3h+QL9745SjcZ+jS7me5Rgl3XSolvAI7HeBYj7xXmaNtHp4OXKCzTfmUm8KksGgwfyfF0tcFVGdvZGcx/yxBu0g8H3PzTvuc0mDNYIv4caEwg2anXqiA0
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d33ccac4-bfce-44a8-f4bf-08d5e82cef85
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(5600053)(711020)(2017052603328)(7193020);SRVR:BL0PR2101MB0882;
x-ms-traffictypediagnostic: BL0PR2101MB0882:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
x-microsoft-antispam-prvs: <BL0PR2101MB08827A44B417C6884E39CE8FF4590@BL0PR2101MB0882.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(85827821059158)(788757137089)(211936372134217);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB0882;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0882;
x-forefront-prvs: 0731AA2DE6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(376002)(366004)(396003)(346002)(13464003)(189003)(199004)(53546011)(5250100002)(53936002)(4326008)(5660300001)(26005)(6916009)(86612001)(14454004)(25786009)(486006)(55016002)(86362001)(2906002)(99286004)(54906003)(102836004)(11346002)(6436002)(9686003)(22452003)(229853002)(316002)(186003)(6246003)(7696005)(476003)(6506007)(105586002)(305945005)(8936002)(10090500001)(7736002)(106356001)(8676002)(76176011)(8990500004)(446003)(81166006)(33656002)(81156014)(256004)(74316002)(3846002)(68736007)(10290500003)(6116002)(2900100001)(72206003)(66066001)(478600001)(97736004);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0882;H:BL0PR2101MB1012.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: XsNpMJbMBEttHF8U1iPnG34k8weB63MMGUcQ/S+CWGYuxT9yuH6PAdKP3ran5BvKx9DkEeuOW68jNfPbSbaXyf6YMvfC6qfDZ6UzRJT0yj3lz4BBpAtPLE67anDC8tjv5t/qDRqT0yV/bIA9D1Nz7zmxBHiZLGQbTfsT+XOXdYpP5jIyN4Is8mtVOX+sdS6De/DiNS3Jr6FW7AMViUqaDJuB1TWVNw0rnPFhprhF8OBnedGNnddhv/he+WTkX5h5URocXedZ9WdC3UozxeCvcLEIDhPwy/Ptt9F+Rb5yZi+Tf4G5nAkNA25iMYWVMq6NqM6xR/S7i3IjIyyPtdFaSpe23vzaipR5YpPZJpa02dE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33ccac4-bfce-44a8-f4bf-08d5e82cef85
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2018 19:23:23.5813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0882
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
> Sent: Thursday, July 12, 2018 3:13 PM
> To: Ben Peart <Ben.Peart@microsoft.com>
> Cc: git@vger.kernel.org; sbeller@google.com; johannes.schindelin@gmx.de
> Subject: Re: [PATCH v3] handle lower case drive letters on Windows
>=20
> Ben Peart <Ben.Peart@microsoft.com> writes:
>=20
> > On Windows, if a tool calls SetCurrentDirectory with a lower case drive
> > letter, the subsequent call to GetCurrentDirectory will return the same
> > lower case drive letter. Powershell, for example, does not normalize th=
e
> > path. If that happens, test-drop-caches will error out as it does not
> > correctly to handle lower case drive letters.
> >
> > Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
> > ---
>=20
> Thanks.  Will replace, even though showing the whole Buffer (I am
> guessing it is the equivalent of result from getcwd(3) call) and
> complaining about drive "letter" feels a bit strange ;-)
>=20

Thanks.  I thought it was strange as well until I realized you only see the
error message if there _isn't_ a valid drive letter so seeing the entire
path makes sense as it will likely be something like "\\server\volume\direc=
tory"
