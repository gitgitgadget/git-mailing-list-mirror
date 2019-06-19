Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29BAB1F609
	for <e@80x24.org>; Wed, 19 Jun 2019 23:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730752AbfFSXy0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 19:54:26 -0400
Received: from mail-eopbgr840052.outbound.protection.outlook.com ([40.107.84.52]:55652
        "EHLO GCC01-DM2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726322AbfFSXyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 19:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cityofaustin.onmicrosoft.com; s=selector2-cityofaustin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W0Uv1SIzxfhuPCAdjUI+sbwa5k+AIbU90I5UGXZKYKg=;
 b=ZgG/vY5rkLuOQa2YStnfQyP2jLImGqysOqAJuyIDnXeV4OvyTocHacUW5SNrNRoDvjC/+Ea7nSE0M/AowAB+pRy6CSKGyM6dSYYvlznv1biTWqnC7WEpWVN5iKVYWVPIQwmpvMlVK+KwiMEcPv3PNo5I4t7HkGh2J8FBXr8xbow=
Received: from SN6PR09MB3248.namprd09.prod.outlook.com (20.177.251.17) by
 SN6PR09MB2767.namprd09.prod.outlook.com (52.135.89.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Wed, 19 Jun 2019 23:54:23 +0000
Received: from SN6PR09MB3248.namprd09.prod.outlook.com
 ([fe80::b933:6b75:e283:3899]) by SN6PR09MB3248.namprd09.prod.outlook.com
 ([fe80::b933:6b75:e283:3899%4]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 23:54:22 +0000
From:   "Pugh, Logan" <Logan.Pugh@austintexas.gov>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [2.22.0] difftool no longer passes through to git diff if diff.tool
 is unset
Thread-Topic: [2.22.0] difftool no longer passes through to git diff if
 diff.tool is unset
Thread-Index: AdUm+T+1c7ctjjbIR+WEKBBEplAQZw==
Date:   Wed, 19 Jun 2019 23:54:22 +0000
Message-ID: <SN6PR09MB3248331E45EED2DD26CA55528AE50@SN6PR09MB3248.namprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Logan.Pugh@austintexas.gov; 
x-originating-ip: [162.89.0.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c63a9910-131c-4c15-06a7-08d6f5117406
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR09MB2767;
x-ms-traffictypediagnostic: SN6PR09MB2767:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR09MB2767F57BDB4D68A477096E4E8AE50@SN6PR09MB2767.namprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(136003)(376002)(199004)(189003)(52536014)(55016002)(186003)(8936002)(6116002)(256004)(5660300002)(71190400001)(14454004)(2906002)(6916009)(81166006)(3846002)(2501003)(1730700003)(9686003)(8676002)(4744005)(6436002)(71200400001)(6306002)(74316002)(2351001)(305945005)(7736002)(81156014)(73956011)(66446008)(53936002)(76116006)(64756008)(66946007)(26005)(5640700003)(7696005)(33656002)(66476007)(66066001)(99286004)(102836004)(72206003)(68736007)(66556008)(6506007)(966005)(86362001)(25786009)(478600001)(476003)(486006)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR09MB2767;H:SN6PR09MB3248.namprd09.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: austintexas.gov does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZcOtG32YK6lMqIUgEksqRBkE/xLz9E5MSAkMALu8qf19tCMbTAX2wHHA5dpdNyjsYoGF1Rdhxcs4JZmGrLm41r64rMj32jT3x0VMN2VII4d2Pe2KX9B4CqHsyXGUCFp5bkrDmOhOFqzc5z6x7Go43JZPFmXhY0nmyMF4I8BUmBCw/eMZMDfeBr9WKE06RrukfbtexgvDnfm6mlrCpvvzf9BYD0B+dhmZs9oAQPWdK/+zpQCXixTGxoBnySHuuK4hMxI2zMg+h+GD3byk/mU/LE3ZSwRIK/5wEebdTRxMEDSCJ+eF8lp6GTqw1+M+U8/0cuJNVggmCeoBHMPxx8+b0Zgzlqhdu8jvJxZdeut5pfOJm7JCBw/DTbpY57rxhCIalv02DVGYMloMuWMgj7YYq9Ra83m6QOVG9ts686NdGUk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: austintexas.gov
X-MS-Exchange-CrossTenant-Network-Message-Id: c63a9910-131c-4c15-06a7-08d6f5117406
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 23:54:22.7635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c5e19f6-a6ab-4b45-b1d0-be4608a9a67f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Logan.Pugh@austintexas.gov
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR09MB2767
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Note: This issue was originally discussed on this StackOverflow thread: htt=
ps://stackoverflow.com/q/56675863

Prior to Git version 2.22.0 I was able to use git difftool without configur=
ing diff.tool or merge.tool and it would show the diff using git diff.

E.g. with Git 2.21.0:

~/gits/src/git$ git difftool --no-index color.c color.h
diff --git a/color.c b/color.h
index ebb222ec33..98894d6a17 100644

In Git version 2.22.0 an error message about diff.tool not being configured=
 is displayed:

~/gits/src/git$ git difftool --no-index color.c color.h

This message is displayed because 'diff.tool' is not configured.
See 'git difftool --tool-help' or 'git help config' for more details.
'git difftool' will now attempt to use one of the following tools:
kompare emerge vimdiff

The following commit is thought to have caused the regression: https://gith=
ub.com/git/git/commit/05fb8726cccc74908853c166248ff9b6abdafae5

Please let me know if I can provide any more info.

Thanks,

Logan
