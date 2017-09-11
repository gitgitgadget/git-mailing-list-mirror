Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5BEB209BA
	for <e@80x24.org>; Mon, 11 Sep 2017 19:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdIKT0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Sep 2017 15:26:17 -0400
Received: from mail-cys01nam02on0109.outbound.protection.outlook.com ([104.47.37.109]:2830
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750853AbdIKT0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2017 15:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=j09qFVb5rEkhJUCDrWzXK1eQ//803iIwNz9GhC+sbBk=;
 b=FVll8+8ynx7U+eMWpH1JM1X8L1slB7nQ+jhSOqo1ekRRstiFs7rnk0m9lRad1Q8WMSUAlXHdxVRnX6v43a92wG9ds6njw0qAqPB3/IxcK9+EKizrFrjQM7fWrMmF5G51GWpXt1NmQguOY6oifubevBjzQxjoKezy9iLw0+LTTWI=
Received: from SN1PR21MB0014.namprd21.prod.outlook.com (10.161.254.12) by
 SN1PR21MB0094.namprd21.prod.outlook.com (10.161.254.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.56.6; Mon, 11 Sep 2017 19:26:14 +0000
Received: from SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) by
 SN1PR21MB0014.namprd21.prod.outlook.com ([10.161.254.12]) with mapi id
 15.20.0077.001; Mon, 11 Sep 2017 19:26:14 +0000
From:   Kevin Willford <kewillf@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: What's cooking in git.git (Sep 2017, #02; Mon, 11)
Thread-Topic: What's cooking in git.git (Sep 2017, #02; Mon, 11)
Thread-Index: AQHTKp6yJNtZIUIWP0+z0J6uXXSz7aKwEGWw
Date:   Mon, 11 Sep 2017 19:26:14 +0000
Message-ID: <SN1PR21MB0014749CFE6DE449771AF724B7680@SN1PR21MB0014.namprd21.prod.outlook.com>
References: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqqpoay3tgz.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Ref=https://api.informationprotection.azure.com/api/72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kewillf@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-09-11T13:26:08.1237670-06:00;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [174.126.250.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR21MB0094;6:Z9PN3t8ViW1+ANMB0aeN6l+fgjJVEsljrD2GSBBPPcUDAEhwnm4auHVcupuH+PbItIjKt+k/RFos5TiSojCICUmB9sDXIelk1/VJ4jCd55Nq5sL019MbRn42g3Kx+ZErOMBr9AknQxSy0lpPJFbfmvzg+eV5JVzFZ2IxlgKox4k1YQI6xRe/aeZkgQsZ50X0gYU5ESURHCUyXLsJ+JdnRuVhnm9EhGgzhUTPXlkewHiwsQGR+TX2olfPNbLYqu8+T4j/oA58Sce5d24nFm37y220+QU3CCXKn09ODmGsuy3PbRpjTnFVQfok7JrDAB6pcGIvwSfI+s28QbdKIePLJw==;5:O4Vc6W5W8pa6Jfv9JKLCXS7dOAzHf/QPfYFVfQ6OFXjaHSnk2fo64QP2uCaZy+eZGtbH3c7UJBJf1e83EFcJV8q7i/PCFhB4iqyziz5Pe1uczm5czXCin4f69XELksel0Ovd1YmfYRISLbVme3uKCQ==;24:rqWiuc8Q5cbwjmaMHxV34NWj+1xU0NNZVoAK6RGy++7gHP3gLd4k/7B3badNjN1YAvaDhEvm5JXyDDU8+I4W2lpj5+1a6qyFMa/grCTHtYw=;7:CRh7VCID6j9A7MYJq4bcypRvZRnrAE4kYRWHWL+LcTOkL0IVsBzrp51EmyrzOxGw0uVreG8PVxJUAQVdpp02W2amSwvqvq0hSmfoCKwfL0fmFKClL35qmdOtoPLWmy+V4S3baa13GcO3F4EEyT9/XWOU6k9jBa14aJDTLXMa7l03pnQ8pwJX7ztbXzk2a5Qa69npMLgdSc/3c0ZmMaA1DO0Q3wLjQqtJKZzbltCGebk=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 2e3c96c1-a97c-412e-cd47-08d4f94af7d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(300000500095)(300135000095)(300000501095)(300135300095)(22001)(300000502095)(300135100095)(2017030254152)(48565401081)(300000503095)(300135400095)(2017052603199)(201703131423075)(201703031133081)(201702281549075)(300000504095)(300135200095)(300000505095)(300135600095)(300000506095)(300135500095);SRVR:SN1PR21MB0094;
x-ms-traffictypediagnostic: SN1PR21MB0094:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kewillf@microsoft.com; 
x-exchange-antispam-report-test: UriScan:;
x-microsoft-antispam-prvs: <SN1PR21MB009449BABA74DC9B62267125B7680@SN1PR21MB0094.namprd21.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(5005006)(8121501046)(10201501046)(100000703101)(100105400095)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041248)(20161123560025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123555025)(20161123564025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:SN1PR21MB0094;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:SN1PR21MB0094;
x-forefront-prvs: 04270EF89C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(47760400005)(189002)(199003)(377424004)(33656002)(76176999)(81156014)(8676002)(8936002)(6306002)(54356999)(50986999)(105586002)(55016002)(106356001)(66066001)(81166006)(99286003)(229853002)(7736002)(9686003)(2906002)(8990500004)(74316002)(14454004)(8656003)(7696004)(478600001)(10290500003)(2900100001)(6506006)(5660300001)(25786009)(6246003)(6116002)(966005)(3846002)(53936002)(102836003)(6436002)(2950100002)(77096006)(305945005)(97736004)(101416001)(189998001)(68736007)(10090500001)(86362001)(3660700001)(86612001)(22452003)(3280700002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR21MB0094;H:SN1PR21MB0014.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2017 19:26:14.5072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR21MB0094
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>=20
> * kw/write-index-reduce-alloc (2017-09-08) 2 commits
>  - read-cache: fix index corruption with index v4
>  - Add t/helper/test-write-cache to .gitignore
>=20
>  Expecting a reroll.
>  cf. <CALgYhfNYgmCJqptNQLKaQpCs9mAgqZHUrDS3BVEqCv_f+WX-
> qg@mail.gmail.com>
>=20
I didn't submit these patches so what would you like
me to do?

The reroll for read-cache fix was submitted here
https://public-inbox.org/git/20170907192412.8085-1-t.gummerer@gmail.com/

- Kevin

