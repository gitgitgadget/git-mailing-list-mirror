Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 413F520248
	for <e@80x24.org>; Fri,  8 Mar 2019 10:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfCHKud (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 05:50:33 -0500
Received: from mail-eopbgr150102.outbound.protection.outlook.com ([40.107.15.102]:54373
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726249AbfCHKuc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 05:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1DbOMSD2i1RmD3S9OO5OrhFPkTH1R9SSg803grZuO4=;
 b=lREbuc+CxabGPpyk2fFmgOlfkAzjK4NSbdmFBDvSDyHV+bFo57YNrdCGLK4Zh3PP1uFBWtJ7N3sLauS694SChvqAwIwUQwACcXdsU5zG0Uvb7OeR605YhTCfMlaC0wlc0uiwM8LN+Esxv/ohm/7FUXuFbZ47aMfIbL6aarYEqAE=
Received: from DB6PR8303MB0069.EURPRD83.prod.outlook.com (129.75.139.20) by
 DB6PR8303MB0069.EURPRD83.prod.outlook.com (129.75.139.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.0; Fri, 8 Mar 2019 10:50:29 +0000
Received: from DB6PR8303MB0069.EURPRD83.prod.outlook.com
 ([fe80::3938:6d2d:c2fb:7b27]) by DB6PR8303MB0069.EURPRD83.prod.outlook.com
 ([fe80::3938:6d2d:c2fb:7b27%8]) with mapi id 15.20.1730.000; Fri, 8 Mar 2019
 10:50:29 +0000
From:   Norbert Nemec <Norbert.Nemec@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: fast-import on existing branches
Thread-Topic: fast-import on existing branches
Thread-Index: AdTVnL4X4Jxw2/2tSNKV4QAkAn17vA==
Date:   Fri, 8 Mar 2019 10:50:29 +0000
Message-ID: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nonemec@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-08T10:50:28.1905703Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=41a73201-3e24-499d-a983-81e97adce5f2;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2a01:110:8012:1010:f828:d50f:b3bd:df9b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 585b3819-0fa2-4117-e8c7-08d6a3b3e175
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB6PR8303MB0069;
x-ms-traffictypediagnostic: DB6PR8303MB0069:
x-microsoft-antispam-prvs: <DB6PR8303MB0069D38AA555049F10A61E8DFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
x-forefront-prvs: 0970508454
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(7696005)(316002)(33656002)(6346003)(6506007)(8936002)(10090500001)(102836004)(14454004)(8990500004)(10290500003)(68736007)(99286004)(22452003)(6116002)(6916009)(2501003)(256004)(14444005)(81156014)(1730700003)(8676002)(81166006)(97736004)(5660300002)(52536013)(486006)(71200400001)(71190400001)(2906002)(3480700005)(53936002)(9686003)(72206003)(86362001)(186003)(478600001)(25786009)(86612001)(5640700003)(55016002)(6436002)(46003)(106356001)(105586002)(305945005)(7736002)(476003)(2351001)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR8303MB0069;H:DB6PR8303MB0069.EURPRD83.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Norbert.Nemec@microsoft.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 09zK5k97+QfHpc5wcssF/XzMJNdXwMsc7qOQusSb63SU36trVFaKX4Bv3EbKMSE7EXfZVQfSag2KEpoCk3ETMw+UE7XZJAxO7pEArL0vltA8y8pBKA0Vm/6xGuYcXs35mPhPmSmAjN+C1N2d2uAO50earD1pRQHbte2dAQm9udxJvM0DND9tetPycwXJheZyhio65VeFwzGr4cMo4S0+THHb+F7YMYrJ1tobXzEzyjv3jWEHBNXaxRdMsl/gngfPNdps8kMqSdDEdSQUd+FUth9hP5ebuOGBRSqPaOODb5BqBc6Bv41Vrp4rFQ+iPz0tdSkNSAnGZh1JmK4+6adru0P9BHJxXMyJb2Fsn+4nfjG3LwqeG9DBdlAbHCU1u8VD0v3nqgnZHzu8fQNSofGKplMUznvrcxfs858i1NDRM58=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585b3819-0fa2-4117-e8c7-08d6a3b3e175
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2019 10:50:29.3856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR8303MB0069
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

I've struggled for quite some time to sort out documented, intended and act=
ual behavior of git fast-import. Unless I'm completely mistaken, it seems t=
o be a straightforward bug, but if that is the case, I am really surprised =
why nobody else has stumbled over it before:

I managed to use fast-import for a chain of commits onto a new branch into =
an empty repository.
I managed to use fast-import to create a new branch starting from an existi=
ng parent using the 'from' command as documented.

What I failed to do is to add commits on top of an existing branch in a new=
 fast-import stream. As it seems, the variant of using 'commit' without 'fr=
om' only works on branches that were created within the same fast-import st=
ream!

The different approaches I tried (each with new fast-import stream on exist=
ing repo with existing branch)
* 'commit' without 'from'
-> Error: "Not updating <branch> (new tip <hash> does not contain <hash>)
And indeed looking into the repo afterwards, a new commit exists without an=
y parent.
* 'commit' with 'from' both naming the same branch
-> Error: "Can't create a branch from itself"
The only workarounds that I could find are to either explicitly looking up =
the top commit on the target branch and hand that to fast-import or create =
a temporary branch with a different name.

Looking through the code of fast-import.c, I can indeed lookup_branch and n=
ew_branch only deal with internal data structures and the only point were r=
ead_ref is called to actually read existing branches from the repo is in up=
date_branch to check whether the parent was set correctly. What is missing =
is a call to read_ref in either lookup_branch or new_branch (probably both =
have to be reworked in some way to handle this cleanly). From all I can see=
 a fix should be fairly straightforward to implement, but I am really not s=
ure whether I have the full picture on this.

(I found all of this struggling with git-p4.py which appears to contains a =
complex and not fully correct mechanism to determine the 'initalParent' tha=
t appears to implement just such a workaround.)

I would be grateful for any input on this issue! Greetings,
Norbert

