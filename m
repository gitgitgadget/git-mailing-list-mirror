Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EFDC20966
	for <e@80x24.org>; Thu, 30 Mar 2017 16:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934169AbdC3QB6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 12:01:58 -0400
Received: from mail-co1nam03on0108.outbound.protection.outlook.com ([104.47.40.108]:23865
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933806AbdC3QB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 12:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=etFdTpS26vVImJz3Ua2GU1Bkj03IhqVyK5GfuLYrFzY=;
 b=ZZQaaBper1q5YGcKuoUNKJzxSU77njBsysZsMA4mgPleNsjVptf6R8DM40KhVTh300tvyqLEgerr/tEKFaX9CJdkWNsrSRlx402Vu7pkTIW8eXd23Rn+i4YyM6SGL18JU/NVPUH0qyQCyuFPi00AmqDGxJ7MwjbBZbQx1uxzyvY=
Received: from BL2PR03MB323.namprd03.prod.outlook.com (10.141.68.22) by
 BL2PR03MB324.namprd03.prod.outlook.com (10.141.68.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.991.14; Thu, 30 Mar 2017 16:01:52 +0000
Received: from BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) by
 BL2PR03MB323.namprd03.prod.outlook.com ([10.141.68.22]) with mapi id
 15.01.0991.021; Thu, 30 Mar 2017 16:01:52 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
        Ben Peart <peartben@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     "christian.couder@gmail.com" <christian.couder@gmail.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>
Subject: RE: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
Thread-Topic: [PATCH v2 1/2] pkt-line: add packet_writel() and
 packet_read_line_gently()
Thread-Index: AQHSpLMw2WN94lefeEWS0KPJi8Zk+6GlDRWAgAQ2/gCABC+HgIAAHw5Q
Date:   Thu, 30 Mar 2017 16:01:51 +0000
Message-ID: <BL2PR03MB3237F4B369C0E00168D7291F4340@BL2PR03MB323.namprd03.prod.outlook.com>
References: <20170324152726.14632-1-benpeart@microsoft.com>
 <20170324152726.14632-2-benpeart@microsoft.com>
 <7a2c73c8-bb09-12ec-dd8d-99c5363f9bb4@web.de>
 <BL2PR03MB3233616BE57BB7D911B1AAEF4330@BL2PR03MB323.namprd03.prod.outlook.com>
 <a5e259bd-d994-6ddb-9dae-43531ee2e875@web.de>
In-Reply-To: <a5e259bd-d994-6ddb-9dae-43531ee2e875@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: web.de; dkim=none (message not signed)
 header.d=none;web.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [65.222.173.206]
x-microsoft-exchange-diagnostics: 1;BL2PR03MB324;7:RXLAJiOlc5iGvC54T6QOm4m3gE3rICJkTBKCcJ+AYpRo2dIYAVEbBNMsBTwrf/fdMda9ChwFjgKOv9lOR96DOaHwvnMXzOEn9DjERbozJXgndOBw+P3iZbaUmDhuQ4UiWe8OddhJ33/xJXH2zgu9hOCkmYZkQB8tsDNFO8rOj31VWJnMH+/FWgfWLxFVuBfVcJyXagMY7qQAC6mrFpbYDN2YUCPh0Le4brT1QmqQbNyoE8+23y0vltTBLjYL6C1XZHQPZHSlmNPnyFw5/SWOcH1WVOH4vh1IqaA8qXK/zfvdWpdj7AUXJLCJ2CC5v0EBlBO+Y/G0y4c9hRZjml6TIaHf7AvLXCaRewtfTpGVnUE=
x-ms-office365-filtering-correlation-id: f33b2d58-eccd-4ddc-c181-08d4778614c4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(2017030254075)(48565401081)(201703131423075)(201703031133081);SRVR:BL2PR03MB324;
x-microsoft-antispam-prvs: <BL2PR03MB324F99F7A1F3C6494B14FE4F4340@BL2PR03MB324.namprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(245156298449039);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040450)(601004)(2401047)(8121501046)(5005006)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041248)(201703131423075)(201702281528075)(201703061421075)(20161123564025)(20161123560025)(20161123562025)(20161123555025)(6072148);SRVR:BL2PR03MB324;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB324;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39450400003)(39410400002)(39860400002)(39400400002)(39850400002)(39840400002)(57704003)(6506006)(77096006)(33656002)(86362001)(122556002)(5660300001)(86612001)(561944003)(9686003)(3660700001)(55016002)(54906002)(3280700002)(53936002)(2906002)(6436002)(25786009)(38730400002)(76176999)(50986999)(54356999)(2900100001)(7736002)(97736004)(102836003)(6116002)(3846002)(99286003)(305945005)(6246003)(2950100002)(229853002)(10090500001)(7696004)(5005710100001)(8990500004)(10290500002)(74316002)(8936002)(93886004)(4326008)(81166006)(8676002)(189998001)(2501003)(66066001)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR03MB324;H:BL2PR03MB323.namprd03.prod.outlook.com;FPR:;SPF:None;MLV:ovrnspm;PTR:InfoNoRecords;LANG:en;
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2017 16:01:52.1112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB324
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Torsten B=F6gershausen [mailto:tboegi@web.de]
>=20
>=20
> Does this work ?
> I would have expected
> packet_writel(fd, "line one", "line two", "line n"), NULL;
>=20

No, that's actually not valid C syntax.

> >
> > which requires the use of variable number of arguments.  With your
> proposal that convenience is lost as you have to create an array of strin=
gs
> and pass that instead.  The usage just isn't as simple as the current mod=
el.
> >
> What is wrong with
>=20
> int packet_write_fmt_gently(int fd, const char *fmt, ...) and we use it l=
ike
> this:
> if packet_write_fmt_gently(fd, "%s%s%s", "line one", "line two", "line n"=
)
>=20

Packets are not just strings; see pkt-line.h for more details but basically=
 they are a length packet, followed by the data (in this particular case a =
string).  The packet_writel function is a convenience function to write out=
 a variable number of packetized strings followed by a flush packet.  You'r=
e sample above would simply concatenate the three strings and then write a =
single packet.  A very different outcome. :)

>=20
>=20
> (Or do we need another one like)
> int packet_write_fmt_gently_flush(int fd, const char *fmt, ...)
>=20
> Sorry if I am lost here
