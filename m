Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA72C1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 18:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfGASur (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 14:50:47 -0400
Received: from mail-eopbgr650096.outbound.protection.outlook.com ([40.107.65.96]:16176
        "EHLO NAM06-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfGASur (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 14:50:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nhrm6XDLRJUg1W2DG5pGhnVeCtv4s3Wd2/Fh/LpU6lDxJbVetjQX3nvHqJPbOruxBOnJH2/CKlMkiZiKg8/ICGjT4/xAn/6iMMIbOqgg7AHDzdw12F1k51rh5ds6OBeN13WiB2TDnpP4dU5wNV+eHJ2gLhJAHxBhbbGucnEnLAVrcCAcHEYfp/NApOzDcqaLVpp0htW0oAI0ScdeWeGwvtu/Zl2vgBBn+aTIsHRnmf7Cx0lgYzJI+HxPY4BNNsqTN+1PkeIuBiPxN9s67nhnonGZxcoScxPXPsJzif0uPYEpW+LmSIthlhv9oqhV1Kpc72s9yZQeimf0ofiICdg/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRppni2L1/Q14f9OpR6lkrjeRcOZTVBy/c/f/iIJgtk=;
 b=WwN8cup8E6xyeYMSTwbjFvFoKIsbtFjoXQ/mVktggYpGK+FzqGr2IrsIYnPy922VM/qZ9Tk5/CRlAB+WeNgr45b+VYLoDFpxUHABuaJNhtD4I0a8oeb4c59aJ7VL1U3YXaKk+N3h1VRNWyLz94LQQcYAbSKHRBsjOB204f5Voezs1qWrdXcimu3adLReonVVG0QVePHxZHD4Ia44XUHEVMczFRj9dzbEHZhcIcwIwjq0AsWXQussFKxL6WrjQ3IKaLDAk5YbghjIzIlJt0POYUEtVbFQ1zGvQXx+amICjERfn63LjFxC+D+P3IAGZx6KxD0wCpZOjBhnHZm500Pluw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRppni2L1/Q14f9OpR6lkrjeRcOZTVBy/c/f/iIJgtk=;
 b=JqG7ZWP1XOOXemfPVSecvTbyIg4mLyxIU+3qhxrk6ACGjeyyzjb6y7CGUsfwz+5GSYHwZ9C4AFyV0cUDBiT3aEFURNRwcOCRUGYQs2b/FtkgwHN9MvvTIoJ4i8BuzKY1r86lLGQKtRJ2efTizkK+z6t9h/SpEB12rfDYILl7TGE=
Received: from DM5PR00MB0408.namprd00.prod.outlook.com (52.132.129.32) by
 DM5PR00MB0373.namprd00.prod.outlook.com (52.132.129.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2086.0; Mon, 1 Jul 2019 18:50:43 +0000
Received: from DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0]) by DM5PR00MB0408.namprd00.prod.outlook.com
 ([fe80::9923:ae05:ac1a:e3e0%5]) with mapi id 15.20.2080.000; Mon, 1 Jul 2019
 18:50:43 +0000
From:   Eric Kulcyk <Eric.kulcyk@microsoft.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Tracking parent branches in Git
Thread-Topic: Tracking parent branches in Git
Thread-Index: AQHVMD3i8/gIlx7oOE2G2ApKMwWLhA==
Date:   Mon, 1 Jul 2019 18:50:43 +0000
Message-ID: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-01T18:50:43.011Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Eric.kulcyk@microsoft.com; 
x-originating-ip: [2001:4898:80e8:b:e561:6c02:9616:a3c8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 206075cc-6edf-40c0-9804-08d6fe55052e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR00MB0373;
x-ms-traffictypediagnostic: DM5PR00MB0373:
x-microsoft-antispam-prvs: <DM5PR00MB0373DC5467B96AC8F9D8352AF1F90@DM5PR00MB0373.namprd00.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(136003)(39860400002)(396003)(376002)(189003)(199004)(74316002)(478600001)(7736002)(305945005)(25786009)(10290500003)(316002)(53936002)(22452003)(72206003)(6116002)(33656002)(8936002)(6506007)(7696005)(102836004)(186003)(1730700003)(81156014)(81166006)(68736007)(99286004)(8676002)(2351001)(10090500001)(2906002)(86362001)(8990500004)(14454004)(5640700003)(2501003)(6436002)(55016002)(9686003)(66556008)(64756008)(66446008)(6916009)(5660300002)(71200400001)(71190400001)(66946007)(476003)(66476007)(486006)(4744005)(256004)(46003)(73956011)(76116006)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR00MB0373;H:DM5PR00MB0408.namprd00.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ttJ7rMnszNps8/kCp7uRuCV5GwDSQWXXEWSDVlAGGh/XLNg8FxKLkPKrYVNuif6RtXshbHXInkCek2n0Z1VyI5alpkS4IT2cAdrMLYP+mv27K7zcldbKce3EoxYPypGq2G9luh89u/dT4GQ6xU24B39lF48CQ5gt4AV80uQkgw8tUSd5Tc7l+iN3Qpt97Teebtxx1mmTA4bpVxTI/lVYLGjotEHVcrAs3XCk3JAKr972NV1l/NgaTwn/FHZT/9mT9OTp1oACp7VYCfiHbvVwUVZpT1FHRbfrtwXt0CKjTO9iTMgP51I1GLZDG4VFjoa5kZ3/qVSOzUu23jY2AW80VZLLujtNqoGCPoUWPOh9uo3enTs3fcLqcSU+/BGcFuuqvxTIj3niUihuIoP09z0dlHHV2a3qY5naKGzp7cgsdnk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 206075cc-6edf-40c0-9804-08d6fe55052e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 18:50:43.1739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: erickul@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR00MB0373
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,=0A=
=0A=
We would like to track parent branches so that creating pull requests can a=
utomatically determine the correct branch to merge against.  I understand t=
hat this would require tracking more information than is currently availabl=
e right now in git.  Also, it seems that if some cases, it is not possible =
to determine a parent branch, in which case it would just be empty/null.  I=
f I made a change to track the parent branch for each branch, would this fe=
ature be accepted/welcomed as part of git, even if it off by default?=0A=
=0A=
Thanks,=0A=
Eric=0A=
=0A=
:(){:|:&};:=
