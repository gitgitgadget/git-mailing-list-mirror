Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F8CE1F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 10:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404384AbfJWKPS (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 06:15:18 -0400
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:31136
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404104AbfJWKPS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 06:15:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUTWqAvURNM2Dixmb0JBFtkXwbbyZamaWLeA9ckUE7s9Ug5OwzQfqo43Q/c9oSeyYh+03kb+z2zrAHptf1mAqJfhieAyNSBOKbJvyB0iYLsvnRvTYUot6pp/GHMatRjedK8k1KeXzDP8OVa5cctSIHKVrCoU+q9uwlAk+HV/6RgPbRxTpYqJLutYd+7EgKrXlr9VTqtdgJchDyCAeLK6qoyrQC14+7CNx7VOdtdAZjUW6A6jKL5NImtFf8NfSYi9EiEbVD/0EgPJW8ohzClUwQUpkQvLe2RgR8No9rjqVaiqxf/l3HETL5Xuy02YaxJeIiAhHA6EpwLCzE7AEG0XjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUQVwus8mSk2PA/2dkA2hLq2eIMlRpR9dVG95L3M11w=;
 b=fdG0Eyk113mO3OlRn5/csgJHBt2PH55mP9A4jMlZWppBTrVKTb7V9Nni/1uCyea7lPIOy3WB+aOGHLvnryI3m59ZpY81Piwi9TsPCqQyNus0+Xsu7tHcoACkVnSoZyJ/ekcKdZmoySG9S548YUNEgwbQRcCfWiNO2Bwm4KBFVH+nMwOpm9OZvWYMnUDco8NIPIJ5/5zG5s18LhTt97Mtm85R+fbPvGjkzmH0WngqyByT547k1XHFsvzVwa/l4+yPXYuaxtkW9hOBAjngmo+BnYWe/sQppM3dqnnpi5qkc7wrdDuG0sN+GgrDx46HcaDTJKlTF4jLoBw91uxUYIN6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUQVwus8mSk2PA/2dkA2hLq2eIMlRpR9dVG95L3M11w=;
 b=N6upw8pQXSqXjoXt9J5nB0vuPqIWCdc+eR9rk0KzuizZyLwu34XdUbE3yX+4S0lOlM3gj70d7i53kULUObKi/R2ZyCdoGiu7pAOep04SFz7NaRvO7RY2PhLPqxxYAlVVAnrQQ+VA9KqBNepnCc10ddSwMAOTBrOFXAK7o1eGs0E=
Received: from MN2PR11MB4063.namprd11.prod.outlook.com (10.255.180.22) by
 MN2PR11MB3999.namprd11.prod.outlook.com (10.255.181.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Wed, 23 Oct 2019 10:15:16 +0000
Received: from MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f]) by MN2PR11MB4063.namprd11.prod.outlook.com
 ([fe80::ac8c:fc55:d1e2:465f%5]) with mapi id 15.20.2387.021; Wed, 23 Oct 2019
 10:15:15 +0000
From:   Jerome Pouiller <Jerome.Pouiller@silabs.com>
To:     Denton Liu <liu.denton@gmail.com>
CC:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Topic: [BUG] "--show-current-patch" return a mail instead of a patch
Thread-Index: AQHViMH8W7ZVg6yI2Uq8GUvXcCiKxKdngKj6gABrcACAAAGBgIAAFmgA
Date:   Wed, 23 Oct 2019 10:15:15 +0000
Message-ID: <2720546.GJdFeal64i@pc-42>
References: <2154192.LVDMpRDY2h@pc-42> <1791353.RaUiIlXgNR@pc-42>
 <20191023085503.GA652469@generichostname>
In-Reply-To: <20191023085503.GA652469@generichostname>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jerome.Pouiller@silabs.com; 
x-originating-ip: [37.71.187.125]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56276e8e-865c-4f7a-9420-08d757a1e627
x-ms-traffictypediagnostic: MN2PR11MB3999:
x-microsoft-antispam-prvs: <MN2PR11MB3999C4BF4BE44CA09CB7E65C936B0@MN2PR11MB3999.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(366004)(136003)(346002)(39850400004)(376002)(51444003)(199004)(189003)(14444005)(64756008)(91956017)(86362001)(478600001)(6506007)(6436002)(186003)(66556008)(76116006)(66446008)(66946007)(102836004)(81166006)(256004)(66066001)(66476007)(6916009)(7736002)(305945005)(4326008)(229853002)(66574012)(6246003)(81156014)(25786009)(3846002)(8936002)(6486002)(6116002)(99286004)(486006)(26005)(8676002)(33716001)(6512007)(14454004)(2906002)(11346002)(316002)(71200400001)(476003)(5660300002)(54906003)(76176011)(446003)(71190400001)(9686003)(39026011);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3999;H:MN2PR11MB4063.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silabs.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xYFb9kKyLCNwI2huyGklaRYHg2jUrgPZmVlPKrKQYonUEqkjTTKCQZOk8B/Syc/sRW9iL1dItTKIDAPnUcVMy7sW/vuQst4b/WuAXm4sttEUaRRVh3Rm7lca1achl+/2KW+bZjYyeaT/sFO5P5U0YCujQ6DJxcj9T1alzTWm6y8IvFsMCf3n7cbpfQO/17pcjfLp3Ksypu3ieZQYWVaK/eSpZgSj5qsScyiM9nrpYg+oIm/bvOpk0asDO26MCmTt4gbfyOwRgDYrW3wThvvRfldvyFvu3Dvw/+dikkju3Qv1A+pVhXW/JfFN8SO0a0f6YDYJPaf3z6sOmP2UIR0dL5x+8c7bc87n8epJ/ErsO4fo2d/NB0Nibq46BtwvZWto1CDfWwnv2wCwB+f7hxy49yzPQf6yzBmHOyI3SSf29ThkKdHFZNqd1xdpehaYY7tX
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0336614F6C209B4FB2AE8CC2894777C7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56276e8e-865c-4f7a-9420-08d757a1e627
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 10:15:15.6430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+mZHENWyX6IJ3kpZXc8EenOqOw5OPBHBWadWwh6F29ZhE+CrRrLmUlUpq14vIDup1O2Sp8p2hW06rBSxqTkaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday 23 October 2019 10:55:03 CEST Denton Liu wrote:
> On Wed, Oct 23, 2019 at 08:49:41AM +0000, Jerome Pouiller wrote:
> > On Wednesday 23 October 2019 04:24:58 CEST Junio C Hamano wrote:
> > > Jerome Pouiller <Jerome.Pouiller@silabs.com> writes:
> > > > I try to use "git am" to apply a patch sent using "git send-email".=
 This
> > > > patch does not apply properly. I try to use "git am --show-current-=
patch"
> > > > to understand the problem. However, since original mail is encoded =
in quoted-
> > > > printable, data returned by --show-current-patch is not a valid pat=
ch.
> > >
> > > I agree that --show-current-patch is a misdesigned feature.  We'd be
> > > doing a better service to our users if we documented that the patch
> > > and log message are found at .git/rebase-apply/{patch,msg} instead
> > > of trying to hide the path.
> > >
> > > Unfortunately, it is likely that those who added that feature have
> > > built their tooling around it to depend on its output being the full
> > > e-mail message "am" was fed (and split by "git mailsplit").  So I do
> > > not think we will be changing the output to the patch file only.
> > >
> > > But even then, the documentation can be fixed without any backward
> > > compatibility issues.  Perhaps like this?
> > >
> > >  Documentation/git-am.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
> > > index 6f6c34b0f4..f63b70325c 100644
> > > --- a/Documentation/git-am.txt
> > > +++ b/Documentation/git-am.txt
> > > @@ -172,7 +172,7 @@ default.   You can use `--no-utf8` to override th=
is.
> > >         untouched.
> > >
> > >  --show-current-patch::
> > > -       Show the patch being applied when "git am" is stopped because
> > > +       Show the entire e-mail message "git am" has stopped at, becau=
se
> > >         of conflicts.
> >
> > I agree with you: I think that manpage and/or output of "git am" should
> > mention ".git/rebase-apply/patch" (that is exactly what I was looking
> > for).
>=20
> I am currently have a WIP patchset that will print the location of the
> failed patch file (.git/rebase-apply/patch) in the case of a failure as
> well as the line number. Will this be sufficient for your purposes?

It would be a clear improvement (the perfection would be to be able to
use mergetool with git-am :) ).

Thank you,

--=20
J=E9r=F4me Pouiller

