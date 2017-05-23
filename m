Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B68BE1FF30
	for <e@80x24.org>; Tue, 23 May 2017 10:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967357AbdEWKRZ convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 23 May 2017 06:17:25 -0400
Received: from mail-sn1nam02on0040.outbound.protection.outlook.com ([104.47.36.40]:20224
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752118AbdEWKRZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 06:17:25 -0400
Received: from BLUPR0701MB754.namprd07.prod.outlook.com (10.141.252.20) by
 BLUPR0701MB754.namprd07.prod.outlook.com (10.141.252.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1101.14; Tue, 23 May 2017 10:17:23 +0000
Received: from BLUPR0701MB754.namprd07.prod.outlook.com ([10.141.252.20]) by
 BLUPR0701MB754.namprd07.prod.outlook.com ([10.141.252.20]) with mapi id
 15.01.1101.021; Tue, 23 May 2017 10:17:18 +0000
From:   "Holst, Henrik" <henrik.holst@frostbite.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "Holst, Henrik" <henrik.holst@frostbite.com>
Subject: git --merge and option parsing
Thread-Topic: git --merge and option parsing
Thread-Index: AQHS062xrE9A5apfYUChjg44cyYifw==
Date:   Tue, 23 May 2017 10:17:18 +0000
Message-ID: <BLUPR0701MB75463EE0B8ADC559BBE02A282F90@BLUPR0701MB754.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: frostbite.com; dkim=none (message not signed)
 header.d=none;frostbite.com; dmarc=none action=none
 header.from=frostbite.com;
x-originating-ip: [2a01:111:e400:525a:cafe::82]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0701MB754;7:eKuxvzeSn+p5pZgTrwitAFr/XqHHIb6mD0U+hLRWbrxrBh9fDn4m9VwqnoA6u8/R+7ONdQBJp2Kn3aBxm0JQLUr8CV/fwr/xz0NWDi5HyT3UAeBvAdC/so9xBcoaN+ffFHRQlhnmrmkY7copM7eblQMVVub6OjQjycsfcF8NH78HgLQUwXZ1/CBbYPbLU6cV/Q+WdqBkjnnmrzAiE5EsYgCqmiAJHOph71BJ7FaxU3lZemayaUikCxtDWkYLp28B00eJ80KQbuX2XOzn7gix382CtIE9vpujTgeCcWgA1IAF1Gzs21koh6NS2XlIvqopbWBhZtg1I9HIn++MytzfxA==
x-forefront-antispam-report: SFV:SKI;SCL:-1SFV:NSPM;SFS:(10009020)(6009001)(39850400002)(39450400003)(39410400002)(39860400002)(39400400002)(39840400002)(33656002)(5640700003)(54356999)(6436002)(9686003)(6506006)(50986999)(99286003)(55016002)(122556002)(2900100001)(77096006)(2351001)(7696004)(38730400002)(110136004)(6916009)(508600001)(107886003)(305945005)(4326008)(25786009)(189998001)(5660300001)(8936002)(1730700003)(8676002)(86362001)(81166006)(7736002)(74316002)(2501003)(53936002)(3280700002)(2906002)(3660700001)(102836003)(6116002)(70820200005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0701MB754;H:BLUPR0701MB754.namprd07.prod.outlook.com;FPR:;SPF:None;MLV:ovr;PTR:InfoNoRecords;LANG:en;
x-ms-traffictypediagnostic: BLUPR0701MB754:
x-ms-office365-filtering-correlation-id: d9642905-9943-4298-1c05-08d4a1c4e464
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081)(201702281549075);SRVR:BLUPR0701MB754;
x-microsoft-antispam-prvs: <BLUPR0701MB754B297C78260234F3D573C82F90@BLUPR0701MB754.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040450)(601004)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123555025)(20161123562025)(20161123564025)(201703131423075)(201703011903075)(201702281528075)(201703061421075)(20161123558100)(20161123560025)(6072148);SRVR:BLUPR0701MB754;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0701MB754;
x-forefront-prvs: 0316567485
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: frostbite.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2017 10:17:18.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: cc74fc12-4142-400e-a653-f98bfa4b03ba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0701MB754
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am not sure if this is a bug but it was surprising to me so I thought I'd report it here.

I added `ui.column=auto` to my gitconfig and that does not work so well with pipes so I want to use `--no-column` option. I was a bit surprised that this does not work? It seems that `--merged` picks up `--no-column` as a commit reference instead it being parsed as an option.

hholst@fb-hholst3 ~/src/a3c-batch (feature/NetworkHandler) [conda:tensorflow] 
$ git branch --no-column --merged
* feature/NetworkHandler
[snip]

hholst@fb-hholst3 ~/src/a3c-batch (feature/NetworkHandler) [conda:tensorflow] 
$ git branch --merged --no-column
fatal: malformed object name --no-column

hholst@fb-hholst3 ~/src/a3c-batch (feature/NetworkHandler) [conda:tensorflow] 
$ git --version
git version 2.13.0

Best,
Henrik Holst
(Not on the list)
