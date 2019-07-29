Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39ADE1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 19:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403889AbfG2T7j (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 15:59:39 -0400
Received: from mail-eopbgr760100.outbound.protection.outlook.com ([40.107.76.100]:9917
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728178AbfG2TxB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd8Ecv7HSd36iiLol+nU60WXAUYY2sWUUwl07HFlwuITuePfyGkDS65txm49orgU20A8TKTIxatf2EHWLS7mA7hvIP1qqP0GBmLAxQRlmQGJpy4GmL32LlxgMxWR5ZrKamAl5MBwDLq7CROGVLhAwggJ1PYx9iLZob/TA7UyRYRjC1n+gTRz/i8OHqqJezrNIY191UKwaUndMMC+UDRreWcKS0cBdZyRX8AqkDD34qQSn2aVvTxCT/IHcCefFPlTGNTZOjn54Xni7Tdq119lJRr38g7fbIIQQW/9w9C+MZ/D0xr6lUykWzXXc82D+kgpDij3z036jGm9KD84W9AtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGdHI/EI5OLGz7WtAUaKZWmu5MYj3NEOANBFrT8gE98=;
 b=FPveGtzzALSOdTiBtNbPh09W8KE0ZI5xAF9YKd5U7mKOrzUuLQz+Rq8rCwOfYxfMGe5isWZl4lm/4IktV1KfoOGYdS4JSkoalPNw0jllfk1hjPhoRk2bM30F4m1lYRkqhsQG3UCdWxcc5/CbAJXxRQBxvy9Br/h9C4p/jG9Atj8q1XIQXuzoL+CnQc36+zORF9+4VEOPkx8lYAJlPPASZuIm9cPbM+th/ACicf1iY655jV1CaVd7lyYa73jFLzBVsxqwicYBMgZtEk27rzVPD2zu/YEFlitRFhZaS/OgyGa4dJzQ+edsMRnKJ3JvbHTr9k8G8K2Mcg41ePvzEjx3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=caretrx.com;dmarc=pass action=none
 header.from=caretrx.com;dkim=pass header.d=caretrx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geckocap.onmicrosoft.com; s=selector1-geckocap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uGdHI/EI5OLGz7WtAUaKZWmu5MYj3NEOANBFrT8gE98=;
 b=MSw+Xu8Z2UgPagHLl1BypvI2iQah1LoAYOTIy347qow5I/GMusV0Q5z0U5zr5wJo7xWte5LChoGjSrTrh4lsHYQwpWmpkrNkM1kND50bO983nTwkvy+OH4O+IWrgKZKLzLdoT26nHBo5PLKxHLx0xPu8tkkbwmb44bI+ORPNQGM=
Received: from MN2PR13MB2607.namprd13.prod.outlook.com (20.178.251.13) by
 MN2PR13MB2925.namprd13.prod.outlook.com (10.255.180.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.10; Mon, 29 Jul 2019 19:52:55 +0000
Received: from MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7]) by MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7%4]) with mapi id 15.20.2136.010; Mon, 29 Jul 2019
 19:52:55 +0000
From:   Ralph Maalouf <ralph.maalouf@caretrx.com>
To:     'Junio C Hamano' <gitster@pobox.com>
CC:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Topic: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Index: AQHVRj+QhLnTuL6OqEGKnVTUDfFpn6bh/1yg
Date:   Mon, 29 Jul 2019 19:52:55 +0000
Message-ID: <MN2PR13MB2607F47AC76601FC709A67A8EADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
References: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
 <xmqqd0hsvfb9.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqd0hsvfb9.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ralph.maalouf@caretrx.com; 
x-originating-ip: [204.9.220.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32cee4f5-6d97-4a1e-933a-08d7145e5994
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR13MB2925;
x-ms-traffictypediagnostic: MN2PR13MB2925:
x-microsoft-antispam-prvs: <MN2PR13MB2925A791D3F67A7A7CBBB0A7EADD0@MN2PR13MB2925.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(366004)(396003)(376002)(136003)(346002)(13464003)(199004)(189003)(229853002)(9686003)(7696005)(74316002)(6436002)(6916009)(33656002)(68736007)(7736002)(316002)(71200400001)(71190400001)(508600001)(102836004)(81166006)(66066001)(53546011)(6506007)(14454004)(81156014)(76176011)(5660300002)(8676002)(6246003)(8936002)(52536014)(186003)(256004)(486006)(25786009)(76116006)(66446008)(86362001)(66556008)(66946007)(64756008)(66476007)(476003)(53936002)(11346002)(3846002)(99286004)(55016002)(305945005)(44832011)(26005)(6116002)(4326008)(2906002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR13MB2925;H:MN2PR13MB2607.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: caretrx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8T6V24bdPSOaQEHtyOddFsAey6bP7tr1Ij8AqqTtNTNio+0ftwX6+CdoOQvA96/g1JJmXqqhTa5ZVxlDm7yRop8RvLpPxqlGf9MRIQHCyJ3h35mzGU3NOKuciSDFsZGwT4almXGYCGyPaV0PcqpZ94owSEdymiomgB+qnkDo67QtnXR5mYt2e6Sg9erYx8Fx13nsqM6JZLKOrT40PRNz4XrcNvai2eaD2dBIyDXsCiwqS1dTuF3V8KMDaAVjHhmgOYJctCe/1Q6bpNqFYTzyZE0KV58XC/tOZlj9cPZX/oNS9asNG9u4p26FLvffSzXVGkkEjnhLN0A1tnz7RIyiRu3x2UoISJsaz77DV3tW40Lnw6mFnZoN+cMsc2IBYry9ncuaHOhq2lm5HqwRYMsEmKQIIkkQ05b0jW0E+/+yFlc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caretrx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32cee4f5-6d97-4a1e-933a-08d7145e5994
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 19:52:55.7845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85bc5f37-3133-4fd7-a2ab-54101a6ef85d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ralph.maalouf@geckocap.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB2925
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"We do not show hunks that match one of the parents ". But in case 1 the se=
cond hunk matches one of the parents yet `git show -c` still outputs it.

diff --combined test1
index 02ef2b0,ffc05f2..59d575d
--- a/test1
+++ b/test1
@@@ -1,8 -1,8 +1,9 @@@
  One
 +Two
+ Four
  Three


  Seven
 -Ten
 +Eight
  Nine

I guess the "Furthermore, it lists only files which were modified from all =
parents." part explains it, but I still find the behavior to be counterintu=
itive.

Thanks,
Ralph

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Monday, July 29, 2019 2:58 PM
To: Ralph Maalouf <ralph.maalouf@caretrx.com>
Cc: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: Re: 'git show -c' omits hunk even though file was modified from al=
l parents

So in short, one side has 1/2/3//7/10/9 in fileA and the other side has 1/4=
/3//7/10/9, and the result of the merge is recorded as 1/2/3//7/10/9.

> I realize that this is because fileA in the merge commit's tree is=20
> identical to what it was in branchA prior to the merge (so the output=20
> of 'git show -m' only outputs the diff for one parent). But I'm=20
> wondering if this is the intended behavior.

Yes, that is very much intended.  We do not show hunks that match one of th=
e parents, and if there is no hunk to show, the path itself is not shown.
