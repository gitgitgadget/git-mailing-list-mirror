Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2104E1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 22:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfG2W0p (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 18:26:45 -0400
Received: from mail-eopbgr800101.outbound.protection.outlook.com ([40.107.80.101]:51284
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727215AbfG2W0o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 18:26:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SorqCg+K+kBjJkwf2plHAfql9w7ihjxg9tEKEwYez+jQhfqpeYB02gAsgwsbd8eRZumZK8pYRxSU5HO6R3+zBWQxa5mJ+jiF9Zv+O95ayf4es4toM7XWESt4M2CAyHU3anyfbF2f72Xutp7FeV50+Oxfz5r/Kb6fry5j2YYD95IZYP37kfYVQtfYHjAMFTiTWxNt8G8F8WxZrMjjrO2p3IQ25pxgPsU3ljKcD5tR5p6UIKSUIQlhiFwEY4mIpcC3xT88bSJ5R5tA3lGayxkiI2lsb/vNFfNYV4RcSNevaGGsPWKmfA98hIgno0PAcZlfpduorO0nq6gh106pHAUpCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHG7PIs36lhVz3wJqZWiaKSUsY5MKoWojBCituTg/+I=;
 b=oGCXTtdW3rR6PqHMGIMsueEYUMBfPNnzX8Bj0OmRX84xfzfuuAKPaYgKh+IxLhrH+iqgDuNRrvCvRmtehrVWUZuVGYFzCenL88ognyVGOUvIufT8lznhYISmTOW1sAT/98gtTe6nwvdecLtOOLzujdZAyaWfWd05huVtHq2uioTrOFsL0xLzzIx+gVG8tETsWvwmb7/6ty47bIezbdVqI7w8g2gN0uRTniu39rXrIS3v/r36rJY6HBqA8rtBKuQah8lOexzcg6itnZe60AEFDZYRAm3wwIVRpRco14r6kc9bff6Bi7adR4Mw6QUZoG9bJGaIyjQLqRpxXIt7wP9g4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=caretrx.com;dmarc=pass action=none
 header.from=caretrx.com;dkim=pass header.d=caretrx.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=geckocap.onmicrosoft.com; s=selector1-geckocap-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHG7PIs36lhVz3wJqZWiaKSUsY5MKoWojBCituTg/+I=;
 b=BlTCZ11hudO9H+xCtVrOea9qUxcMWNL6q/PImjK2RJzUkIe8+0w1TiUaJvnie4/u6Zcstp5Fd1/C0wyuIBPxJ2eBfQysTEbhm238iWBSNDhYecinw+jXQXFGzAytvndzGftxA0HsVb7R8tGrmldLhTvfmJeGazNIQL00fTfdLkE=
Received: from MN2PR13MB2607.namprd13.prod.outlook.com (20.178.251.13) by
 MN2PR13MB3293.namprd13.prod.outlook.com (20.179.151.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.10; Mon, 29 Jul 2019 22:26:40 +0000
Received: from MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7]) by MN2PR13MB2607.namprd13.prod.outlook.com
 ([fe80::2cd9:7a94:3ce3:4bb7%4]) with mapi id 15.20.2136.010; Mon, 29 Jul 2019
 22:26:40 +0000
From:   Ralph Maalouf <ralph.maalouf@caretrx.com>
To:     Junio C Hamano <gitster@pobox.com>
CC:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: RE: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Topic: 'git show -c' omits hunk even though file was modified from all
 parents
Thread-Index: AQHVRj+QhLnTuL6OqEGKnVTUDfFpn6biIaNQgAAJt6A=
Date:   Mon, 29 Jul 2019 22:26:39 +0000
Message-ID: <MN2PR13MB2607F98BF473C36A0C8F17ECEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
References: <MN2PR13MB2607878CB0C1E351B83F006BEADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
        <xmqqd0hsvfb9.fsf@gitster-ct.c.googlers.com>
        <MN2PR13MB2607F47AC76601FC709A67A8EADD0@MN2PR13MB2607.namprd13.prod.outlook.com>
 <xmqqsgqotsyi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsgqotsyi.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ralph.maalouf@caretrx.com; 
x-originating-ip: [173.48.235.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd43ffa1-6586-43cd-2ff7-08d71473d3f4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR13MB3293;
x-ms-traffictypediagnostic: MN2PR13MB3293:
x-microsoft-antispam-prvs: <MN2PR13MB3293F32510987E3855843356EADD0@MN2PR13MB3293.namprd13.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(346002)(396003)(39830400003)(199004)(189003)(66476007)(4744005)(305945005)(71190400001)(71200400001)(74316002)(508600001)(81156014)(2906002)(86362001)(316002)(53936002)(7696005)(8676002)(81166006)(99286004)(68736007)(8936002)(6916009)(186003)(66446008)(9686003)(102836004)(26005)(229853002)(6246003)(76116006)(76176011)(7736002)(66066001)(446003)(476003)(11346002)(6506007)(256004)(5660300002)(14454004)(55016002)(25786009)(6436002)(44832011)(52536014)(33656002)(486006)(6116002)(3846002)(4326008)(64756008)(66946007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR13MB3293;H:MN2PR13MB2607.namprd13.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: caretrx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wKPqFXdqmSQVptJXeWUhlh4M7FF9/QvcsEfujQeVFAWJ5eRebkMNWrC4/MxQj/Iz4T7kzqVdmFBlwdf1fp/338gH7llMqH06hlvqBqJhPJGL8fuq7Cv7SQQy2XXjUtlIXG4Z0Zb5NWefRPqrMHdiNVuEHU4bjLpXAnt1o2RtnenjjNbSeZwnWJ3foZCt6BzXaWNYkfBXa9O3UDwLkjs9K32RyOFPnehe405w9yci1hThV8+S+m4s9uWhqjvaeyjUhbr499X9Mda3lIXGoOPbCRhJdxJHkjj0nyAFr/mqEch715hHDFxvtH1engHl4b5h4WVsKnvfKQY1ScqRUTE6DLMsdlNL3zS/YqtGWtLvTBScZWEmiSZLsOeGcWAPmzyD89Bzjvl3OnejRAOdnIXz96qHFNfWqBD1xCZ7m5Dv2JM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: caretrx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd43ffa1-6586-43cd-2ff7-08d71473d3f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 22:26:40.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 85bc5f37-3133-4fd7-a2ab-54101a6ef85d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ralph.maalouf@geckocap.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3293
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ahh that clears it up for me. I incorrectly assumed that at minimum that ea=
ch "<<<<<<HEAD" represented a hunk..

I searched for the definition of hunk in gitglossary but couldn't find it.

Thanks for the clarification!
Ralph

-----Original Message-----
From: Junio C Hamano <gitster@pobox.com>=20
Sent: Monday, July 29, 2019 5:46 PM
To: Ralph Maalouf <ralph.maalouf@caretrx.com>
Cc: 'git@vger.kernel.org' <git@vger.kernel.org>
Subject: Re: 'git show -c' omits hunk even though file was modified from al=
l parents

Ralph Maalouf <ralph.maalouf@caretrx.com> writes:

> "We do not show hunks that match one of the parents ". But in case
> 1 the second hunk matches one of the parents yet `git show -c` still=20
> outputs it.
>
> diff --combined test1
> index 02ef2b0,ffc05f2..59d575d
> --- a/test1
> +++ b/test1
> @@@ -1,8 -1,8 +1,9 @@@
>   One
>  +Two
> + Four
>   Three
>
>
>   Seven
>  -Ten
>  +Eight
>   Nine

The above is a single hunk (whose definition is the group of lines delimite=
d by @@@...@@@ lines).
