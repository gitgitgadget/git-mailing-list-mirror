Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CB91F454
	for <e@80x24.org>; Mon, 11 Nov 2019 16:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKQzy (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 11:55:54 -0500
Received: from mail-eopbgr820109.outbound.protection.outlook.com ([40.107.82.109]:33101
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726928AbfKKQzx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 11:55:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYqgtWredKUjq1GwKx6WEXXNKdjSDFsCUYDBpFBR2qTR/tApy8c+uD2fszWhXf3NGGhUR7LYK4wXpHXIlSqP0aZtmZuM77UfuDOsVF8kST2lm+LMcOFOHnAmqoB4DYjt9l0JqeXG9DG1XBZ5mX48tA/Ei4IZ9qtmMEkn8iJUpYPKpJvYPcxdRrveSneVbRJOLrhGEW1BKuPYa2jOqVpO6II2XPr0T4E/eRzoKoRue+vk3+7oN5Byx5GUpw5bQK/9RldK2BJQ35qus/ZIKrj1NpEPu11qkbXlaam+7Ntq8RrYKefHCBpn8TxCZw1hhcsFsKzvjPRMuRATB5Um5VJt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIXmLtb9TPgBcpUV/uV3RF9BuM2fGbo+fQJNlMcEzEU=;
 b=Sl0MV6tcGIfcLD9uNzx3w6YweuMyzM3KBnbR8Hkgqg/zjhCI4atMEPfn0vP9DWooJWud7j8vPYsRO6m/fqSufHHUYaxCRHVziuJ4Obj8elRDtsYqTqcrj/sJWsgWeGHbg9idfg3vJ7LSkY3DTFo39+xCZZ/s0EuydoCTBDkgyklrjyVUj3PrVwf/drfYVRZcyb5Q7fI2NG3eON3jZHeSpHdzDauQwBKFhJt8suwSoIQAK1sQVaELJbkQO9tdE8QFEPbr2r3VR49nyKkuWOdbiMaukKf21tmYNT3sjaBOFYSmEsH2xiEighHOi5l/EpnMYOmMKgn4WU2YkBWZ0HRXnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HIXmLtb9TPgBcpUV/uV3RF9BuM2fGbo+fQJNlMcEzEU=;
 b=BwXCILQ0Otac2wfLTYED/E0seLYN4hKqiGPItLg4X16Ae/yuMkDVRbD2boCse2qgAJJtA+SlyO7GTt8WMkJMNmhL7hyXnRLUPAAbCS1GLSkKNt41xQFmNFosH+ubglloLQoOQR3uxbrDNEGz3/cwU0c9bg3GiE8KaifuNpTsSGM=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0834.namprd21.prod.outlook.com (10.173.205.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.19; Mon, 11 Nov 2019 16:55:11 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::48c9:e508:91f4:78a5]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::48c9:e508:91f4:78a5%6]) with mapi id 15.20.2451.018; Mon, 11 Nov 2019
 16:55:11 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        William Baker <William.Baker@microsoft.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Utsav Shah <ukshah2@illinois.edu>
Subject: RE: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
Thread-Topic: [PATCH 0/1] fsmonitor: skip sanity check if the index is split
Thread-Index: AQHVlgN2N/HqI42iV0qrhHi8d+RSPaeFNvObgAAE2KKAAOHjoA==
Date:   Mon, 11 Nov 2019 16:55:11 +0000
Message-ID: <BN6PR21MB07869E8D1DCAF189C4E472A891740@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.458.git.1573196960.gitgitgadget@gmail.com>
        <xmqqh83bjig6.fsf@gitster-ct.c.googlers.com>
 <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa793jhne.fsf@gitster-ct.c.googlers.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 544b9678-f1be-41a5-e722-08d766c7eaa7
x-ms-traffictypediagnostic: BN6PR21MB0834:|BN6PR21MB0834:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB0834C89E5C381E1C459E373C91740@BN6PR21MB0834.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(396003)(136003)(366004)(189003)(199004)(54094003)(76116006)(66476007)(186003)(10090500001)(66946007)(9686003)(66446008)(66556008)(64756008)(8990500004)(4326008)(66066001)(1511001)(6436002)(478600001)(25786009)(256004)(14444005)(8936002)(305945005)(26005)(2906002)(7736002)(81166006)(81156014)(8676002)(486006)(74316002)(86362001)(6636002)(446003)(229853002)(11346002)(316002)(102836004)(52536014)(76176011)(33656002)(5660300002)(476003)(55016002)(7696005)(10290500003)(71200400001)(71190400001)(99286004)(6506007)(6246003)(110136005)(22452003)(54906003)(3846002)(6116002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0834;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lavTIu/ww0yiBgdw4h4dxgdp4YSTxw25hodSPH9CYygyQBMoORgoXCD+Jj7PsxJNGYpX6Vf4TpDK81sDDI2YIKgQfZALtuyR/SXCI1JmOVjDZc9dhuOkGy69jD14pCemJHlg1LH7XAoQJ/xxUrp4f+4wdR6OmTrN+ChcOyt02jFJ7Csy5Q51DNGq6HQIATnYFXQ9RbAfFfANBu8VHEWB8HehGPEWwDHEUMRu/Le8JR8PJDMpXf9/amg+ym0VnTZewbwH+LMA3X7wC5cGfUI5KE/1NgH3bIPnsCT8E+x3W10Ozo/8+FNJEJnDxZQy339Beo3bLQcd5KXDhDoYzMhYNM8SYRwZz9lOH+xHJ1yz2neC+ZH+Umwcfxhlrpc/AySD5Uw1SvHtVhEPqQ4xB49Sqy13GjkOdm9IWSywE5v6bzfiykMe3ezXxxPDRF4P4fYG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544b9678-f1be-41a5-e722-08d766c7eaa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 16:55:11.5642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVW6bUCg0AcCOrgvP+457MX48HG3Eh+VRXDRLrkpr3jgF9OYNplKuD43GUYU2b8OSFxjfjRyEECkeYK7Df8iIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0834
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: git-owner@vger.kernel.org <git-owner@vger.kernel.org> On Behalf
> Of Junio C Hamano
> Sent: Sunday, November 10, 2019 7:01 PM
>=20
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> At the very least, this patch mitigates an over-eager check for split
> >> index users while maintaining good invariants for the standard case.
> >
> > OK, it sounds more like this "it does not make any sense to compare
> > the position in the fsmonitor bitmap (which covers the entire thing)
> > with the position in just a split part of the index (which covers only
> > the delta over the base index)"?  If that is the case, it means that
> > the "check" is even worse than being "over-eager"---it simply is not
> > correct.
>=20
> Having said all that, I wonder if we are doing the right thing with or wi=
thout
> 3444ec2e ("fsmonitor: don't fill bitmap with entries to be removed", 2019=
-10-
> 11) in the split-index mode in the first place.
>=20
> The fact that your "loosen the check and allow 'pos' that identifies a tr=
acked
> path used by the fsmonitor bitmap to be larger than the size of the istat=
e-
> >cache[]" patch under discussion is needed is that 'pos' may sometimes be
> larger than isate->cache[] no?  Then what happens in this hunk, for examp=
le?
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index 231e83a94d..1f4aa1b150 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -14,8 +14,13 @@ struct trace_key trace_fsmonitor =3D
> TRACE_KEY_INIT(FSMONITOR);  static void fsmonitor_ewah_callback(size_t
> pos, void *is)  {
>  	struct index_state *istate =3D (struct index_state *)is;
> -	struct cache_entry *ce =3D istate->cache[pos];
> +	struct cache_entry *ce;
>=20
> +	if (pos >=3D istate->cache_nr)
> +		BUG("fsmonitor_dirty has more entries than the index
> (%"PRIuMAX" >=3D %u)",
> +		    (uintmax_t)pos, istate->cache_nr);
> +
> +	ce =3D istate->cache[pos];
>  	ce->ce_flags &=3D ~CE_FSMONITOR_VALID;
>=20
> The istate->cache[] is a dynamic array whose size is managed via the usua=
l
> ALLOC_GROW() using istate->cache_nr and istate->cache_alloc, whether the
> split-index feature is in use.  When your patch makes a difference, then,
> doesn't the access to istate->cache[] pick up a random garbage and then f=
lip
> the bit?
>=20
> Puzzled...  In any case, "check is worse than over-eager, it simply is wr=
ong" I
> wrote in the message I am responding to is totally incorrect, it seems.  =
It
> smells like lifting the check would just hide the underlying problem unde=
r the
> rug?

I agree.  The only 2 places that excluding the split-index make sense are i=
n
read_fsmonitor_extension and write_fsmonitor_extension because the
index_state that is being passing into those methods could be the delta ind=
ex
in which case the number of entries for the fsmonitor bitmap would almost
always be more and cause the BUG to be hit which it should not be.

The reason it is not needed and should not be in the other 2 places is they
are ran from tweak_fsmonitor which is ran at post_read_index_from which
is after the base and delta indexes have been loaded into the indes_state a=
nd
the index_state will have all the entries and if the fsmonitor bitmap is bi=
gger
than the number of entries then the BUG should be hit.=20

Kevin
