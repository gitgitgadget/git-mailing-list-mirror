Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264C7202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751124AbdKTNt1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 08:49:27 -0500
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com ([104.47.32.102]:8224
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751087AbdKTNt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 08:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sgDHFh87rNXk+KAF2h1AQMVB6JqZpcp4Uu0Xug7JxBk=;
 b=Otb7panb8+CsYET7i6BV/pmMbBml5G6Zop+vjQFF9HnuNbgjVPRFiOz0g1p+BEOAltbxAIgfPrHQN9tKndabRq2kg2SpUTPfEMj1rUQ3YUXtt1tDJ9y3oSwUXWqmuxk6sAsTKYwxKkfkDWt40m3ckGQEzGmLUQt6+BQECcJ+N/k=
Received: from MWHPR21MB0478.namprd21.prod.outlook.com (10.172.102.17) by
 MWHPR21MB0800.namprd21.prod.outlook.com (10.175.142.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.3; Mon, 20 Nov 2017 13:49:24 +0000
Received: from MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) by
 MWHPR21MB0478.namprd21.prod.outlook.com ([10.172.102.17]) with mapi id
 15.20.0260.004; Mon, 20 Nov 2017 13:49:24 +0000
From:   Ben Peart <Ben.Peart@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Alex Vandiver <alexmv@dropbox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: What's cooking in git.git (Nov 2017, #05; Fri, 17)
Thread-Topic: What's cooking in git.git (Nov 2017, #05; Fri, 17)
Thread-Index: AQHTX2sDkL5MgC+HP0+fxq6RDRUSIqMYHZakgAUvxyA=
Date:   Mon, 20 Nov 2017 13:49:24 +0000
Message-ID: <MWHPR21MB047824EDFD7AE4EC39256E7FF4220@MWHPR21MB0478.namprd21.prod.outlook.com>
References: <xmqqbmk1sabs.fsf@gitster.mtv.corp.google.com>
 <xmqq375ds99m.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq375ds99m.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=benpeart@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2017-11-20T13:49:21.0670000Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [65.222.173.206]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR21MB0800;6:N3b4TATVk6EXiqwRdk5c9no2hMW/J9nrYjgXdaTjsdGbK5k4z6P+hUG01ViDkxsjXN7tu3/bj0KoXOsPQdYD7fU5bJg3QOD2RASNOtB0QnOZow1uItA6VEeRuLqK+Z/+Tk1XVnQ+1v+C9x+cum5LnfIIC4wZqGSpSG2cnb81pUGUGoF6wpZ5r+0W+R/+bOlY+oWOHLaYRlboWWUFdjCpa+fEKiDrONaWetSOq3ROGnAsJSrxM7HLcNn6nm5sq0UuXcJPGUi7OPg7eh00KDt/9GVv9UiDDu5iYGnewBOxCdxXlmVuia0wP5a71GXiyivNyjSLzyjR27uV076D5VPXPqSeJLlGz83NlIFKIRyQusc=;5:J8CluPLpSZ3YjGBxjkF8Bfnuo/6ySlpj7aUNb5ddX4FUI0hBQYGbjPOuL16SFdyGJXUKiSvzi3utyXtTyNv3Ji4K/dYfLOIi39LWpnE9IuNc9Ki35LYOszAX5SugIZEjaD6KvDZ0vag2qtvHnLgCincaMeIIRCsnU4AIhwg0f/0=;24:s1O1x57JlfNMQwqiBPl7IrFNZt9pVbLk4XRRuMqo6r5aiSm5f9+wpykasSrv4I/w1Fpkq9NOCY7C1sTCwO7Lbm1BjmIscrKuXsR8KO/Ak5I=;7:XKldUsr9Sk/pOPJ40+aIAwzPIZ5Ri4KkPPU0We8mOODA3asVNtZwg9fp3z0WM5bzFj/J4HfAB1ZmDpqgsiEu2ncuqkV4z3kcwPgiI24NLK1BFGq9P42S5K0xgcD5eyw3q5395tJhC+WsX3wtmu0yjWn0GINKoxkPMWoTcT/WeyvfSOXjVqept2a+6/AE/Q4P2JPLdh5X+OqN0bBEKQs6wJqGMZ6LYMFnlc85Y3oauMiFZo4shmWVWgpTp/DvW5sm
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 7c3ac8e7-c94a-4afa-9a43-08d5301d82c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(22001)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603258);SRVR:MWHPR21MB0800;
x-ms-traffictypediagnostic: MWHPR21MB0800:
x-microsoft-antispam-prvs: <MWHPR21MB0800487D718B387F13253346F4220@MWHPR21MB0800.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(89211679590171)(9452136761055)(60067363179207)(100324003535756);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(61425038)(6040450)(2401047)(8121501046)(5005006)(100000703101)(100105400095)(3002001)(93006095)(93001095)(10201501046)(3231022)(6055026)(61426038)(61427038)(6041248)(20161123555025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123558100)(20161123564025)(20161123562025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:MWHPR21MB0800;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:MWHPR21MB0800;
x-forefront-prvs: 04976078F0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(6009001)(39860400002)(346002)(376002)(47760400005)(189002)(199003)(377424004)(13464003)(3846002)(6116002)(102836003)(55016002)(50986999)(54356999)(5660300001)(105586002)(2950100002)(77096006)(106356001)(76176999)(7696004)(6436002)(101416001)(33656002)(6506006)(229853002)(6246003)(81156014)(8676002)(81166006)(4326008)(8936002)(53546010)(2906002)(68736007)(74316002)(10090500001)(2900100001)(86362001)(7736002)(9686003)(305945005)(86612001)(53936002)(3280700002)(3660700001)(72206003)(99286004)(25786009)(14454004)(66066001)(110136005)(189998001)(10290500003)(316002)(97736004)(478600001)(22452003)(4001150100001)(8656006)(8990500004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR21MB0800;H:MWHPR21MB0478.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ben.Peart@microsoft.com; 
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c3ac8e7-c94a-4afa-9a43-08d5301d82c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2017 13:49:24.7675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0800
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, November 17, 2017 1:35 AM
> To: Ben Peart <Ben.Peart@microsoft.com>; Alex Vandiver
> <alexmv@dropbox.com>
> Cc: git@vger.kernel.org
> Subject: Re: What's cooking in git.git (Nov 2017, #05; Fri, 17)
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > * av/fsmonitor (2017-11-13) 7 commits
> >   (merged to 'next' on 2017-11-13 at db56ad7eef)  + fsmonitor:
> > simplify determining the git worktree under Windows  ...
> >
> >  Various fixes to bp/fsmonitor topic.
> >
> >  Waiting for follow-on fixes to settle.
> >
> >
> > * bp/fsmonitor (2017-10-05) 15 commits
> >   (merged to 'next' on 2017-11-07 at b08d44ba60)  + fsmonitor:
> > preserve utf8 filenames in fsmonitor-watchman log  ...
> >
> >  Originally merged to 'next' on 2017-10-05
> >
> >  We learned to talk to watchman to speed up "git status" and other
> > operations that need to see which paths have been modified.
> >
> >  Waiting for follow-on fixes to settle.
>=20
>=20
> The two topics were waiting for updates to av/fsmonitor to quiet down,
> which seem to have happened by now, so I'll consider merging them to
> 'master' soonish.
>=20
> Please let me know if I should wait for a bit longer.
>=20
> Thanks.

As far as I can tell, the patches are good.  I'm not aware of anything else=
 that should hold it up.

I had the one question about the way the test was written but that was noth=
ing that should hold up the patch - just my own curiosity.
