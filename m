Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ACE11F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbeINVWp (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 17:22:45 -0400
Received: from mail-eopbgr80132.outbound.protection.outlook.com ([40.107.8.132]:61760
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726845AbeINVWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 17:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schneiderelectric.onmicrosoft.com; s=selector1-schneiderelectric-com02c;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnI/uP9Zm9PaMlfFS5yfuegSvSa9qFyLTKlrygHRTkg=;
 b=wYYzF6DadVzLWtQK25pwgi3YjJkk/Ds/QApNCI+400CDiwIOfYBcnWjh8pUp8uZoqIKPpzWDcGoCtcFMD2nAio3Y5EE1POB8g2QGqQOJrfSD1PnbU07VWEHhOjbEUkH9GWC2hrh+lmm041xudmwDpy36PyGFX9Via3+psnXUdaE=
Received: from AM5PR0401MB2484.eurprd04.prod.outlook.com (10.169.244.140) by
 AM5PR0401MB2516.eurprd04.prod.outlook.com (10.169.244.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.13; Fri, 14 Sep 2018 16:07:34 +0000
Received: from AM5PR0401MB2484.eurprd04.prod.outlook.com
 ([fe80::4904:1215:f2fd:df91]) by AM5PR0401MB2484.eurprd04.prod.outlook.com
 ([fe80::4904:1215:f2fd:df91%8]) with mapi id 15.20.1122.021; Fri, 14 Sep 2018
 16:07:34 +0000
From:   Michal Fita <michal.fita@schneider-electric.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Git 2.19.01 on Windows crasesh during GC
Thread-Topic: Git 2.19.01 on Windows crasesh during GC
Thread-Index: AdRMRQg+HMG3/TnAT+20RTSBP6Qqcg==
Date:   Fri, 14 Sep 2018 16:07:34 +0000
Message-ID: <AM5PR0401MB2484A080D36571F2486B9609C4190@AM5PR0401MB2484.eurprd04.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=michal.fita@schneider-electric.com; 
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0401MB2516;20:s4sWo1Wtxh8QVxT0vRZiSRi5IVe+RzPDUfjBRAW7B9Rjuit1/30Tpx2sbeMBLvobCcR48w23VwxzfY4GN97h5b+2iVN7PhHeUTukTZmtcLUc9yqgnp1MRrjIzVMr5xjPuEo+HaWCqQ5X/HdNQ56b9N/XgoeDHq5BM8sCh3lJW5A=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: a8cd9903-86aa-4215-bf49-08d61a5c2eac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0401MB2516;
x-ms-traffictypediagnostic: AM5PR0401MB2516:
x-microsoft-antispam-prvs: <AM5PR0401MB25162D35D728C2B3D4DA829FC4190@AM5PR0401MB2516.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050);SRVR:AM5PR0401MB2516;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0401MB2516;
x-forefront-prvs: 07954CC105
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(39860400002)(396003)(366004)(376002)(199004)(189003)(5660300001)(86362001)(7696005)(6916009)(2906002)(5640700003)(55016002)(6436002)(25786009)(9686003)(26005)(8676002)(476003)(305945005)(74316002)(102836004)(486006)(44832011)(186003)(53936002)(2900100001)(99286004)(6506007)(256004)(2501003)(5250100002)(81156014)(68736007)(81166006)(1730700003)(105586002)(33656002)(106356001)(478600001)(97736004)(316002)(14454004)(8936002)(2351001)(460985005);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0401MB2516;H:AM5PR0401MB2484.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: schneider-electric.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: G8rNtHjI6rRj0Jrj8GGNse9BdJ29s7QQ+7AZ/duJYhK8hB3SmpY4FCQs3W8VMh6JOF3iSME3UkU16a247psVUFv1CDOTlTzdTZcGgeyVWJiqyKUzzNikL5IffYvwNFCGXB8r2hovNy5rurwJkbwIguLeMJMMr3JNfZ+wLwVX74eIFZxMO9tA7tZ5nGgMP1SyOwKM09lzpKu20TrrMyf0U/2ksDjLQQSOplskKVz3fGxzatR+HFn42b0DLpItlo+QHTkuXU2ovXOfFwUNzuI0Q+sXxiAKDsF6HDjCQk2HlluSU1jVis+9Dd7JaVS0nE2B4nockETjLYPo3Db82R0fMA21bMGtHNuBfm/yvywL7m4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: schneider-electric.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cd9903-86aa-4215-bf49-08d61a5c2eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2018 16:07:34.0789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e51e1ad-c54b-4b39-b598-0ffe9ae68fef
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2516
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Problem signature:
  Problem Event Name:	APPCRASH
  Application Name:	git.exe
  Application Version:	2.19.0.1
  Application Timestamp:	5b980bc7
  Fault Module Name:	ntdll.dll
  Fault Module Version:	6.1.7601.24117
  Fault Module Timestamp:	5add228d
  Exception Code:	c0000005
  Exception Offset:	0000000000032964
  OS Version:	6.1.7601.2.1.0.256.48
  Locale ID:	2057
  Additional Information 1:	335e
  Additional Information 2:	335ee83054d6c615e4a7142c362e3dd4
  Additional Information 3:	5184
  Additional Information 4:	518485c5adbc52c624cc6890056919a6
