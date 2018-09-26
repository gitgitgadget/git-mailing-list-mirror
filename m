Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8311F453
	for <e@80x24.org>; Wed, 26 Sep 2018 22:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbeI0E5m (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 00:57:42 -0400
Received: from relays-agent08.techservices.illinois.edu ([204.93.2.8]:32926
        "EHLO illinois.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbeI0E5m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 00:57:42 -0400
X-Greylist: delayed 1156 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Sep 2018 00:57:41 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=illinois.edu; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=campusrelays;
 bh=5PpKx5vgkgKYGOdMcUPJKNk0l5cFnt9xogMeFVMscqU=;
 b=k/tnrYPROnv7FXWocvoB3pAnMAJ7RO5V77TdSCZ3CyKVaPK7aIbwaEvHk4H+llcC+Emm
 PUXwOl8zBEpkmoR36XolrlbAPk8T61EMgiQaSCC79BU7yi/DJC7wTenOMka6dGsKm2aJ
 p/O1c0F0WO6dWZa87O/yguwDJdimcfCiLnAEs7VMuhl58G8lQfksD93jczDQV7YRgis4
 P7MkrVtd+wVOLWXLMaGu5OfkWrPs/INwiOmKtSn4wzejk8Yw1PVV8AlqpTqmT+48zXWJ
 VX/oEEFAvQdYZ0LB7+1aVr4A2mPRN5238N0UmDA751hk4Ro3YjEE0Y9yxVhEkbjEwUvn YA== 
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (mail-co1nam03lp0022.outbound.protection.outlook.com [216.32.181.22])
        by relays-agent08.techservices.illinois.edu (8.16.0.22/8.16.0.22) with ESMTPS id w8QMNDd7018649
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 26 Sep 2018 17:23:15 -0500
Received: from BN6PR11MB1283.namprd11.prod.outlook.com (10.173.32.18) by
 BN6PR11MB1890.namprd11.prod.outlook.com (10.175.100.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Wed, 26 Sep 2018 22:23:12 +0000
Received: from BN6PR11MB1283.namprd11.prod.outlook.com
 ([fe80::b578:3815:c758:c98d]) by BN6PR11MB1283.namprd11.prod.outlook.com
 ([fe80::b578:3815:c758:c98d%2]) with mapi id 15.20.1143.022; Wed, 26 Sep 2018
 22:23:12 +0000
From:   "Zych, David M" <dmrz@illinois.edu>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Jeff King <peff@peff.net>, "Zych, David M" <dmrz@illinois.edu>
Subject: [PATCH] doc: clarify gitcredentials path component matching
Thread-Topic: [PATCH] doc: clarify gitcredentials path component matching
Thread-Index: AQHUVeeCDaVKuDazx0KXt53tluAF0w==
Date:   Wed, 26 Sep 2018 22:23:11 +0000
Message-ID: <1538000558-25523-1-git-send-email-dmrz@illinois.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [130.126.255.35]
x-mailer: git-send-email 2.7.4
x-clientproxiedby: BN6PR11CA0057.namprd11.prod.outlook.com
 (2603:10b6:404:f7::19) To BN6PR11MB1283.namprd11.prod.outlook.com
 (2603:10b6:404:48::18)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1890;6:ckZKBR7to0zWfSOf0CxTMT2UPwemHInSn+Onojz6WaT/Ug0tJ1ioVnfELIzLENOxio08drmmP9UM3ALPs5hFojisVfSc/cGi6d1di+dle9M1qjRIBRdJrIFveXWQ5K6+SiawEjtDc1UU79t2METR5XMOB+zSF1+nh+qHwo6HZqTbugwAXmvQWC/MfHD28W3vRwmpLoTDxHVE0jNQJJwbKiZGoEEQ8IFVM4dCyWRyIwm97ZLqRzUK0r6AoEyamN7wuoRmJy0ecKj4x5iE+2GOfMq16QSLUaHDwNE8wTa6Zwh+n+665lfmSsI8MUZpb4IE1AvwxSkkgSvNystUrji1F/iz3bgGqbLZPOKpTZCP54Y/jJfBeV9NYKW8fO18PW6ps320jZkH0tpuAJEUPzjplmC5dJkaKcS5OXKvzg3xHl4+dLkB7W6mJXM1HlI+HtAVluGkgY3oStZa35KMK0T0dw==;5:wmNhEmC8ph9oAE2rv3kPiVAIkRYo6qoPxkVX9yINQMzWTVrmCFoDUf53HkTtmg1vAw1BHvqfghfebPsoERlLb0Vp5kE0cLa/CKnd9vLmtcKviA2RMTjghfqhaG2TQ19WZHO+Eed915Plsmu56dbEyrMWHGnFXk2Cz5jfAQPgALc=;7:vPyM6aZMphVSnJg2XTsDuT0ba4+Wem7+oCPaNEOKelaKRdAIS/1u8yXI4YQ5zVbE2TcM7xCW3bG9ELP1/eTJuzYN2GIHwgE9I3FoWfMk74D8pAwt7gxeyg0VNSKrSXlMrIFh+gEfctQwMpSHRtdcsZIx47aaweJ7KFD3a4DOiLX7s3GzvYi1kzsoZiqMF6fCphTF4fdTN84Ogpo+TmkjSMQ4kMbUG5tgS1CPyJAZqL8AmhNDjZszFAVyevqE55rT
x-ms-office365-filtering-correlation-id: e8a9951f-04bd-44e4-bcfb-08d623fea4e6
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1890;
x-ms-traffictypediagnostic: BN6PR11MB1890:
x-microsoft-antispam-prvs: <BN6PR11MB189028F9FA7D80266F066940BA150@BN6PR11MB1890.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(29773736570271);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(201708071742011)(7699051);SRVR:BN6PR11MB1890;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1890;
x-forefront-prvs: 08076ABC99
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(39860400002)(136003)(346002)(199004)(189003)(6916009)(105586002)(52116002)(6116002)(99286004)(3846002)(5660300001)(81166006)(81156014)(1730700003)(86362001)(2501003)(107886003)(8676002)(4326008)(66066001)(2351001)(305945005)(7736002)(68736007)(5250100002)(50226002)(71200400001)(25786009)(8936002)(2906002)(71190400001)(106356001)(75432002)(88552002)(6486002)(14454004)(102836004)(26005)(786003)(476003)(316002)(36756003)(6512007)(6306002)(6436002)(97736004)(6506007)(53936002)(5640700003)(2616005)(256004)(2900100001)(486006)(34290500001)(186003)(1857600001)(478600001)(54906003)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1890;H:BN6PR11MB1283.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: illinois.edu does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: LAes4gLKv6xrj9g32CIMc9/rjn6m4oxjYVGtz2E/+zH9x5ALhkSajTNdcg3AqFVyHrvu/qwrkl/OnxQIxNVEIw/MUaghk8h1F0dkIVlkNr4hQ5fu/TIFMID+D7xa39ZkKg5gEqTXO2FfIV+vyNM3NEPZsYxUxuFfELB9hk1Yysxz5n491dIT195UB5g/IC+e/+VBc4ucLPxM5JbXs0G10vqPnDdXekmTxIqB8UpymH5TQd0ySU8bjmle3w6iPBtOJl8U3fh1FX8DmFdgPffxYuwuXhkffiWaxSqpSgcuQkDbnKjtbaKTS/TP0nqP5IYetrdMF/WbmJiBBdrG1BO4jcGii7x4ZeNxEhKcsS9dOjE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: illinois.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a9951f-04bd-44e4-bcfb-08d623fea4e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2018 22:23:12.0138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 44467e6f-462c-4ea2-823f-7800de5434e3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1890
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The gitcredentials documentation implied that the config file's
"pattern" URL might include a path component, but did not explain that
it must match exactly (potentially leaving readers with the false hope
that it would support a more flexible prefix match).

Signed-off-by: David Zych <dmrz@illinois.edu>
---
 Documentation/gitcredentials.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredential=
s.txt
index f970196..adc7596 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -133,6 +133,12 @@ compares hostnames exactly, without considering whethe=
r two hosts are part of
 the same domain. Likewise, a config entry for `http://example.com` would n=
ot
 match: Git compares the protocols exactly.
=20
+If the "pattern" URL does include a path component, then this too must mat=
ch
+exactly: the context `https://example.com/bar/baz.git` will match a config
+entry for `https://example.com/bar/baz.git` (in addition to matching the c=
onfig
+entry for `https://example.com`) but will not match a config entry for
+`https://example.com/bar`.
+
=20
 CONFIGURATION OPTIONS
 ---------------------
--=20
2.7.4

