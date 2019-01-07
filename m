Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9935A1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 11:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfAGLnA (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 06:43:00 -0500
Received: from mail-eopbgr1310075.outbound.protection.outlook.com ([40.107.131.75]:17102
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727022AbfAGLm7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 06:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=onedevio.onmicrosoft.com; s=selector1-onedev-io;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+rqr4tkp1RRP2S7ungrSxfzxRX42uus/wI/faPzBuk=;
 b=zkxE0lePQF97Vd88in+wBtzgq4lSAoRbumySP3DG0zGk4nhIs0lBpFkGiLF5icX2nBuvOc3cJ9+i63RL9h7qCQkDMNnSlFc3pbB2gdcIQGhRk9ucaVa69mO/UowK4hMpfOhfH1u21bMsSlEpwMs8TAANCWwK8Ro2IIvuyg5GfuE=
Received: from SG2PR04MB3205.apcprd04.prod.outlook.com (20.177.91.205) by
 SG2PR04MB1710.apcprd04.prod.outlook.com (10.167.81.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1495.8; Mon, 7 Jan 2019 11:42:54 +0000
Received: from SG2PR04MB3205.apcprd04.prod.outlook.com
 ([fe80::9513:a7f9:6e4e:bd4c]) by SG2PR04MB3205.apcprd04.prod.outlook.com
 ([fe80::9513:a7f9:6e4e:bd4c%5]) with mapi id 15.20.1495.011; Mon, 7 Jan 2019
 11:42:54 +0000
From:   Robin Shen <robin@onedev.io>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Introducing OneDev - an open source git server with interesting
 features
Thread-Topic: Introducing OneDev - an open source git server with interesting
 features
Thread-Index: AQHUpn4BzlRRgp+PvUiq+jnBHPmaiA==
Date:   Mon, 7 Jan 2019 11:42:54 +0000
Message-ID: <SG2PR04MB3205E9C83085CFF2F426FE65B9890@SG2PR04MB3205.apcprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robin@onedev.io; 
x-originating-ip: [52.76.41.21]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SG2PR04MB1710;6:WX82j7JKM4znRfkP6s4PTQTh7r9k9kwnpTknFt5x/mGGCQF1EaOi3pm+WdBQotqYR0R3amcKm1pSIWq2bIBBTzGK1As8mV1Nph8i5EOoihN2F87MakBkitqUrWXb2pHyvBi8u2MR4+dAXc8i6L9Tc7W6lBZF/UWGfvzuzY5wW9VrI/EdxsyHdFdQiYFrE4XaOoHHWelmraScFwWeTinvOMFR4C+7nfS8idYgPbL3UksurN6V+i7aiHWOAzLJLHEPFNHo0LQmiqYWI7QAgtbcerlVAquo74CeKMhx2dO/8qqAKJmeMawR/cOxPS4fCEPJ1BL49VsXlK6MgnW/9nQxSApcalKo3wCkcU3ekSmGaNb6NsnCAMmaFhmL0y/4sbbOCg5Tc6cItiH1R1FWMsX4Fkdnvzaz2nO3WG93LTcZhJWkwL3Htz35LRY9PMEgPnkWVRp5k7oubGnhHWfoQ1armw==;5:cg6Q9o6QwuLH7QENNRbDvu5LIFiy5FQ68xeH3Yyp7dYzJFOiDzFznl6+8fWaL2A7YF15Pr3nLIvTG5xY885mvMg1/OWZ7mgfbgJEE1PN6T8NYkSnNrTa4izhATzjtV3x7zdeh0jrC3nnaa47FvHySnuZJoH0HpoDELFxE0bpXbtHyTZRZ9Vk8N2PAjfQxADjPCW16Kg6bqT6fEijNgcppg==;7:jMIdDIfjPrkpLHvDPdImzc7faKVgwoyI84lOtojDIXZTQyTUZ+vlIRcKUvKl4D+KSVjSImmG97rJjBvsEm7FO9Mew4l98BmbLU/Ztf/J5HXYJj/wm4Ve/n2F7jpaWQZmDPwD550RhrhLBVie/8EsyA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e082b20-e7cc-4d20-6360-08d6749542fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(5600109)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:SG2PR04MB1710;
x-ms-traffictypediagnostic: SG2PR04MB1710:
x-microsoft-antispam-prvs: <SG2PR04MB171046EBDA53BD9A3F329723B9890@SG2PR04MB1710.apcprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(10201501046)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:SG2PR04MB1710;BCL:0;PCL:0;RULEID:;SRVR:SG2PR04MB1710;
x-forefront-prvs: 0910AAF391
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(136003)(376002)(39830400003)(199004)(189003)(8936002)(1730700003)(81156014)(66066001)(81166006)(8676002)(26005)(33656002)(7736002)(74482002)(55016002)(97736004)(5640700003)(105586002)(6506007)(106356001)(558084003)(7696005)(86362001)(2501003)(102836004)(6436002)(3846002)(9686003)(53936002)(6116002)(6306002)(6916009)(2351001)(186003)(14454004)(74316002)(5660300001)(476003)(68736007)(966005)(413944005)(508600001)(2906002)(256004)(71190400001)(71200400001)(99286004)(316002)(486006)(25786009)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR04MB1710;H:SG2PR04MB3205.apcprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: onedev.io does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tt92CFxMdOxdGYmsRyvlrzlEGyhKt6wG4aOuvSZ83H7CykxcAeKxNHgJGU2kj3M7WA4clofGhInexhGFcPYJbgDxIhqIJ11R0IPTdRFPa8J0oWxrqjOGaLL6GMeB0U3n8c38MB4JFbyjuA75wInMnRuWgD0gIcMZkywdhG7s+7AtKJPsk0Dh17IM8/RLHVQyOE1HTau/nWbJIUzaR0dkymKHPR9Ew7F22a5XHyGAl1auW+XJADEvhDh4bOVk+HmV5Yw8N5htY/7Ie3GgNlDk5BjMAju8hOcZrA/Dqh6QVVVv2qUu4ech9pal5yk7Kkrb
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: onedev.io
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e082b20-e7cc-4d20-6360-08d6749542fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2019 11:42:54.0087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4d3c83b7-53a7-44a7-952f-341c4e10ca6a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB1710
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear git users,=20

OneDev is an open source git server with interesting features such as langu=
age aware code search/navigation, issue workflow customization, free source=
/diff comment and discussion, etc. =20

It is using MIT license and hope it can be useful to someone.  Learn more a=
t https://onedev.io

Robin
