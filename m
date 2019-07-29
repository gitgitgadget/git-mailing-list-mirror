Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A8781F462
	for <e@80x24.org>; Mon, 29 Jul 2019 18:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbfG2SUu (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 14:20:50 -0400
Received: from mail-eopbgr710117.outbound.protection.outlook.com ([40.107.71.117]:6174
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727136AbfG2SUu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 14:20:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReErCBIYRVlHjNcfgy1Ejtbv6ceiBwKfWAFNZvduOiIrc4FD5fdxNvGZi7Qc5/hvZY+Y4B/kqy7CPDOznXO0GtAEglweDPGbRG54aglLYBfofsryh8Vg9lLE9p0KKWU3ZuhQ0KAone/qzeJ9jB8KfPJGsDkSgj4sowCgegcmC9uunYVtE/JDcQQLjDwf6PtYOqDbjpETq5pFxHxZwOtMX/7IBvqEAZVkex+5vvp4Aster6FxUG+AhIJc50dxN+SK4wxPqLuuzZ+f6bRUGhA6pZ8O/Gpwbhm+LZj2VX8koz8trP/R1iDLUPRj+NHBfPqHpI4ITGmzson79sAFYOaM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4W8vFcZQLNmGrsqQJT7k6KIVu10k67EcXovfpulq3o=;
 b=V+wGHfC+j4p8Q7+eV8OInyhD7o7vlaNIs34aSqd/o+Cd4r7hNC7eW5GLqln3Jjkjr+Tg3ftx5o917ONZLgpSn5RZQqcU0XIRfduhA9aPuRWN2WFDTgi3lkxwtJ7/Fd/jUBrHDeGNlR8OTrcOMDeO//mA3CBhZTSY8lpAHWIAYm3HxSHqBh9h9tjOYK+NV/1umRL6faK1J6tcpgyx1L1mG6UeK6Fbf0tMIeCERiS4kRXHnr/HuLxvSQy9MdRnHXS6RznRgNXHQOl2i6bxPSyWaipB5+VcbPdbwqbsQuKm1knW21bWywRtrise/ALvrOZAtFyVyPjl0Z2Ieooa5Z+pSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=caretrx.com;dmarc=pass action=none
 header.from=caretrx.com;dkim=pass header.d=caretrx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geckocap.onmicrosoft.com; s=selector1-geckocap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4W8vFcZQLNmGrsqQJT7k6KIVu10k67EcXovfpulq3o=;
 b=C2l5Ncv6LwqmDZtoD0NId7nlJMzhuIbEyszHuDV0p8uXo/6dIQFaZ0F7Xr4Tc/JSqtlYx39LkaLczlPBXRu8gjYCO8hWFFg81oWypagso/3592KQwcuRwKq6gf0yRtylJ7XskkOrWY+TF4zJSxFgfe2i1GvjKVZPHjBGCL+WT8g=
Received: from MN2PR13MB2607.namprd13.prod.outlook.com (20.178.251.13) by
 MN2PR13MB3726.namprd13.prod.outlook.com (10.186.146.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.9; Mon, 29 Jul 2019 18:20:45 +0000
Received: from MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7]) by MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7%4]) with mapi id 15.20.2136.010; Mon, 29 Jul 2019
 18:20:45 +0000
From:   Ralph Maalouf <ralph.maalouf@caretrx.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Topic: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Index: AdVFlNLOGrWarPH8T2y8AnkzQSePvQ==
Date:   Mon, 29 Jul 2019 18:20:44 +0000
Message-ID: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ralph.maalouf@caretrx.com; 
x-originating-ip: [204.9.220.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b6691ce-2b5a-470f-2ffb-08d7145178fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR13MB3726;
x-ms-traffictypediagnostic: MN2PR13MB3726:
x-microsoft-antispam-prvs: <MN2PR13MB3726950B73B6B0D05B1C9417EADD0@MN2PR13MB3726.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39830400003)(346002)(376002)(136003)(396003)(189003)(199004)(55016002)(6436002)(76116006)(66946007)(6916009)(9686003)(25786009)(64756008)(66556008)(66476007)(66446008)(53936002)(8936002)(81166006)(81156014)(8676002)(33656002)(316002)(102836004)(186003)(26005)(508600001)(14454004)(6116002)(3846002)(71200400001)(2906002)(68736007)(5660300002)(305945005)(99286004)(74316002)(86362001)(52536014)(7736002)(66066001)(44832011)(486006)(256004)(71190400001)(476003)(7696005)(6506007)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR13MB3726;H:MN2PR13MB2607.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: caretrx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 4NlxgkZfVX8yT9+E5w4pCC41N3Wry+lBRxVVYSx1MfPwAVf14gLCeGew7Vl4ERgz8BdXUVNSrssRI6woAMmO2KG+sJfT8rOGGhyHw4mv9joQRV3GpboXVJ1Ai7WdQyNW6pW5E/8xS4tBJIlhgaE9PzMBzgs+OhQba8Gx4G9zeF5mGOxdYEpDkAtTdAIGQOjisdaBxJv4Fu/AySWkfKSGJh/DNN3NR8g6UvT+nOoVtFwcmc/7uHYLVE5PAm3j4CBUmbzCTu7fU2ZdSm68RT9MP2mPIlb0GLimrRFFrASj+m75KN8ssb/VSwy40/Lk58bDQiFhrgh3RFp7o7GbZnM5b8GpjMskqjx18HqV88FOkRSTHrktfiOdmC4XlDC3de6Jyk76Tvd3QQuMaXmAbiGNvtRM0Uz8eV2f19QNvU3mQUo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caretrx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b6691ce-2b5a-470f-2ffb-08d7145178fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 18:20:44.6006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85bc5f37-3133-4fd7-a2ab-54101a6ef85d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ralph.maalouf@geckocap.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3726
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git version 2.17.1

Commit C0 contains FileA which is empty.
Both branchA and branchB point to C0.

From branchA I add the following contents to FileA (and then commit):
---
One
Two
Three


Seven
Eight
Nine
---

From branchB I add the following contents to FileA (and then commit):
---
One
Four
Three


Seven
Ten
Nine
---

Note: I use two newlines so that git merge sees two hunks.

Case1:=20

From branchA I merge branchB and resolve the conflict as follows:
---
One
Two
Four
Three


Seven
Eight
Nine
---

As expected, 'git show -c' outputs the combined diff for both hunks, wherea=
s 'git show -cc' only shows hunk1 and omits "uninteresting" hunk2.

Case2:

First I amend branchA so that the second hunk is the same as in branchB (no=
te that the first hunk is still different between the 2 branches):
---
One
Two
Three


Seven
Ten
Nine
---

Then from branchA I merge branchB and resolve the conflict as follows (keep=
ing only the changes from branchA):
---
One
Two
Three


Seven
Ten
Nine
---

I was expecting `git show -c` to output the combined diff for "uninterestin=
g" hunk1, just as it did for hunk2 in case1. But it doesn't.
I realize that this is because fileA in the merge commit's tree is identica=
l to what it was in branchA prior to the merge (so the output of 'git show =
-m' only outputs the diff for one parent). But I'm wondering if this is the=
 intended behavior.

If it's not, then the '-c' section in 'man git log' that says "it lists onl=
y files which were modified from all parents" may be a bit confusing since =
this requirement seems to be met.

Thanks,
Ralph


