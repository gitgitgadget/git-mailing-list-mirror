Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F422A1F454
	for <e@80x24.org>; Tue,  5 Nov 2019 21:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfKEVke (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 16:40:34 -0500
Received: from mail-eopbgr820095.outbound.protection.outlook.com ([40.107.82.95]:19508
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729680AbfKEVkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 16:40:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJmw3Ol+Jp/2juoKHp16TK1pn59isPSoS5BKlpWb2yyS1dKf0QRJUvqvc7g2/k/bZZpsKS8fZwA35EABjvl8YygD7rYnWDt3i5UJnd6bys1AZfi1JFpNl/RvT0djRGy2D21miZmnTQDsYcZxU1w411ri4lPg7PO54cPnWzDs7KK+PggXjtHFRzRHDmgJX5EXSoTenuN+r70U1odC/Tv/GC57YHjGerx7s1HjDTubHHukYG0vQiDpW+oIZbS/zSpIp5Ig6lMSgj3uIEudt0A4Kb4+ZPvjloCwHx0PSHXeQAJpaBtrCPsugv6Ee17Sit+MaKpi5eqpVsUAufcNMEdWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAsh5dtDLvtEy4QKzLtzCaROQSq5XIuJo8hYqXhj8k4=;
 b=kSLgT3mHkHbcUyZGXZUQzfypAMlDfYhavsVfMYBz9xCPXHGuBVu5lv7YgPE2G3F8lmgD+tLcN59D4c9kwMU3FJAWkmv/idnfNvDFSOQOJBZTJ85topN93EbWd+XRXUxujgmlcgQbdcmbbf/tBMNHYPZKbk/1nAYujRnSCkJlnEnCFUdgr88cnstIk5MDmNM2xQkSqKPU5UzC2FNU5CaVALVDswU19J1aquHFaKaVis3tyhPA+8rdGCubkIZTVagv8M2gnwo+aI0xOFHYDM4Yo7PA9wZoHY6Z5M6/3y1HhpXimiBpuyC/UAmX6rr1zUFmZ5p/UqlUqRus0qVElH0CRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAsh5dtDLvtEy4QKzLtzCaROQSq5XIuJo8hYqXhj8k4=;
 b=DDNRV4C3ZFMAM1hjE1BgJBoe463l61gM1rmYM2sQC1EmwKM6j/Qra723MEGzzevZU/MHJpug+dANOsXaoU3KURz0O71+mMbHIeluErdju8bak33WRh0Gvz3wVXExPXoDj1CwbwKbR+sCs1pIyrYmk6KoUdzCSEDA/TVv4quMXj0=
Received: from BN6PR21MB0786.namprd21.prod.outlook.com (10.175.132.14) by
 BN6PR21MB0145.namprd21.prod.outlook.com (10.173.199.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.18; Tue, 5 Nov 2019 21:40:30 +0000
Received: from BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e]) by BN6PR21MB0786.namprd21.prod.outlook.com
 ([fe80::69cd:d7ac:4626:542e%9]) with mapi id 15.20.2430.011; Tue, 5 Nov 2019
 21:40:29 +0000
From:   Kevin Willford <Kevin.Willford@microsoft.com>
To:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
CC:     Utsav Shah <ukshah2@illinois.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Utsav Shah <utsav@dropbox.com>
Subject: RE: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
Thread-Topic: [PATCH v2 1/1] unpack-trees: skip stat on fsmonitor-valid files
Thread-Index: AQHVk+2bruW1MfyQ40WaJtUPjf9M4ad8uw2w
Date:   Tue, 5 Nov 2019 21:40:29 +0000
Message-ID: <BN6PR21MB07869D880E1D0111F1A80E42917E0@BN6PR21MB0786.namprd21.prod.outlook.com>
References: <pull.424.git.1572017008.gitgitgadget@gmail.com>
        <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
 <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572967644.git.gitgitgadget@gmail.com>
In-Reply-To: <f76ba554ed25fb9877a223ef6481834f1831c8ca.1572967644.git.gitgitgadget@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Kevin.Willford@microsoft.com; 
x-originating-ip: [174.126.253.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c8fe612-8ab1-484d-b9fc-08d76238c76e
x-ms-traffictypediagnostic: BN6PR21MB0145:
x-microsoft-antispam-prvs: <BN6PR21MB01451E58767FCC6A0D8E3999917E0@BN6PR21MB0145.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39860400002)(396003)(136003)(199004)(189003)(54094003)(6436002)(8990500004)(66946007)(33656002)(66556008)(66066001)(99286004)(8676002)(64756008)(9686003)(81156014)(66476007)(14454004)(55016002)(8936002)(2501003)(2906002)(10290500003)(6116002)(3846002)(6246003)(76116006)(52536014)(4326008)(229853002)(5660300002)(26005)(102836004)(256004)(14444005)(25786009)(6506007)(81166006)(11346002)(446003)(66446008)(10090500001)(478600001)(7696005)(76176011)(186003)(476003)(74316002)(7736002)(54906003)(86362001)(305945005)(22452003)(316002)(110136005)(71190400001)(71200400001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0145;H:BN6PR21MB0786.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4vvlsFYeiz1G9g083Yvq9TMlwzFkiWewHV+YUkPf2jEwhtqNHHIMw+quuhQDXwE2mK/NT3K/cux4xcqzkTTuijtju6BU1BXtUo1X65oYo8RFu+gAAc8+dgx6R70+UKyh70DAMRyekQEVoBKK0Dko5Ko0Rr1EBe26rnmOOh3FStqqDCuFLwmBU0fLEQ5xvhkgNuRQL8/XIj6cXd5E6kA9xGznli+EcD9Gh+uASxNiAj4jcVarX8vNC8FBrqA825v6OjdEGfQkC67sC5nh3uHrTOmaigSR6lPoSv/9j82gZtovw64J+pkAhXhPzGsezUQh0eXM5WXeN+96oZnyvOiewfAINJJw4nb+zIW/dHukSO4qI76V9/WJfxkDgQs0oLehk0jBQQHdjMiC0IpAmi91brP1TYdAZ2g6n0tP855TsalI0j0ArjJaAJ7IIrnvXkaH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8fe612-8ab1-484d-b9fc-08d76238c76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:40:29.8328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLzkPDZhPXvhJcA3GeTnoO9pAnzaR/ojNgC2D4Y9lR2E2/Xlr6CNS6leACLh2yEasTvJaWa6WtlzNdw1fqT/1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0145
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Sent: Tuesday, November 5, 2019 8:27 AM
> From: Utsav Shah <utsav@dropbox.com>
>=20
> diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-chang=
e-
> hook.sh
> index f011ad7eec..5ca2279d0d 100755
> --- a/t/t7113-post-index-change-hook.sh
> +++ b/t/t7113-post-index-change-hook.sh
> @@ -50,9 +50,6 @@ test_expect_success 'test status, add, commit, others
> trigger hook without flags
>  	git checkout -- dir1/file1.txt &&
>  	test_path_is_file testsuccess && rm -f testsuccess &&
>  	test_path_is_missing testfailure &&
> -	git update-index &&
> -	test_path_is_missing testsuccess &&
> -	test_path_is_missing testfailure &&
>  	git reset --soft &&
>  	test_path_is_missing testsuccess &&
>  	test_path_is_missing testfailure

Looking into this change and I wonder if instead we should be updating
refresh_fsmonitor to only update istate->cache_changed if there was an
entry where CE_FSMONITOR_VALID was turned off.

The reason I bring this up is because with this change, the post-index-chan=
ge
hook will behave differently depending on fsmonitor.  It will pass if
GIT_TEST_FSMONITOR is unset or set to fsmonitor-watchman. But when set
to fsmonitor-all it will fail because it is going down the code path that
invalidates all the entries and sets istate->cache_changed.

> diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh in=
dex
> d8df990972..9cac3d3d8e 100755
> --- a/t/t7519-status-fsmonitor.sh
> +++ b/t/t7519-status-fsmonitor.sh
> @@ -106,6 +106,8 @@ EOF
>=20
>  # test that "update-index --fsmonitor-valid" sets the fsmonitor valid bi=
t
> test_expect_success 'update-index --fsmonitor-valid" sets the fsmonitor
> valid bit' '
> +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	EOF
>  	git update-index --fsmonitor &&
>  	git update-index --fsmonitor-valid dir1/modified &&
>  	git update-index --fsmonitor-valid dir2/modified && @@ -164,6
> +166,8 @@ EOF
>=20
>  # test that newly added files are marked valid  test_expect_success 'new=
ly
> added files are marked valid' '
> +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	EOF
>  	git add new &&
>  	git add dir1/new &&
>  	git add dir2/new &&
> @@ -218,11 +222,12 @@ test_expect_success '*only* files returned by the
> integration script get flagged  # Ensure commands that call refresh_index=
() to
> move the index back in time  # properly invalidate the fsmonitor cache
> test_expect_success 'refresh_index() invalidates fsmonitor cache' '
> -	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> -	EOF
>  	clean_repo &&
> +	write_integration_script &&
>  	dirty_repo &&
>  	git add . &&
> +	write_script .git/hooks/fsmonitor-test<<-\EOF &&
> +	EOF
>  	git commit -m "to reset" &&
>  	git reset HEAD~1 &&
>  	git status >actual &&

We need to take a close look at all the tests in
t7519-status-fsmonitor.sh and see if we are doing the right thing with
these changes because before most commands that read the
index would only apply the bits from the fsmonitor bitmap to
the cache entries.  Whereas now, it does that but also applies what the
fsmonitor hooks returns so the content of .git/hooks/fsmonitor-test is
now affecting tests and commands where it was not before.

So if .git/hooks/fsmonitor-test has paths even git ls-files gets those
paths marked dirty and that command is being used to validate the state of
the CE_FSMONITOR_VALID.  So I think in most cases for these tests we
want the .git/hooks/fsmonitor-test to be empty before calling git ls-files
so that doesn't change the index state.

>=20
>  	if (old && same(old, a)) {
>  		int update =3D 0;
> -		if (o->reset && o->update && !ce_uptodate(old) &&
> !ce_skip_worktree(old)) {
> +		if (o->reset && o->update && !ce_uptodate(old) &&
> !ce_skip_worktree(old) &&
> +			!(old->ce_flags & CE_FSMONITOR_VALID)) {
>  			struct stat st;
>  			if (lstat(old->name, &st) ||
>  			    ie_match_stat(o->src_index, old, &st,
> CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))

FYI I have been testing with the ce_uptodate macro checking the
CE_FSMONITOR_VALID flag instead and only have failures when using
the fsmonitor-watchman script which I'm not sure if all the tests were
ever passing using it.

