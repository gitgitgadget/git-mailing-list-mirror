Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB9C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 13:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349262AbiHSNFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 09:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348922AbiHSNFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 09:05:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E174AD5E
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 06:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660914340;
        bh=ZWkgVUzVi1ilM9oc61KUX63PVqK0jvWsnFc+hH9X3Uk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SDLVt5aYusLgFEDrp6h/8nRKIt/a2DuP1LpC5VUkrwt5Wv+oI1N7vZxlwKugLVl3I
         oeti4YzSLZNDf28tsaYmGERv3u8vO29eBr2e0mv4I5WPqbB5hu8XtFwMUBZNbVT4Sm
         CVH58gtU+zUAwzXIrNfgrG4NmTFoYTzsfyn5E+0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeCtZ-1nnljQ46pr-00bNNA; Fri, 19
 Aug 2022 15:05:40 +0200
Date:   Fri, 19 Aug 2022 15:05:46 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous
 branch"
In-Reply-To: <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
Message-ID: <55n449n3-71r9-28n9-094q-6r61545r7505@tzk.qr>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com> <s7862q69-05o8-s5s8-n635-823s34q358q4@tzk.qr> <xmqqk07iu3c3.fsf@gitster.g> <5194s6qn-570s-6053-2104-9s22qo1874sn@tzk.qr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1166408642-1660914348=:241"
X-Provags-ID: V03:K1:SHTqiWarI91BLevBE5esvJ1qVL7cCUQ6oo9IzmiZc1TsD0cCMu7
 dK1Mgu5R4MYnV2ygHDYOm/4em4Y0mHobI8Dy06n/Tr45OZvxLBhY/WW/s1Mjssm4wAHPkaQ
 93g+hL/0XZI2D0TigXIMsL6agoAvjtWoWVCxg+l/SrvWX1BA5S/J3qo5zJJ9YXSED9TDdzX
 ezJ+wiIHjMKPSCL9fimXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KW8ktF96A80=:YOeF+gaX+Mhqq/y4cvm2c0
 Pn9ZOTUQUprphZq/bG8e5VPuLmajhZrGxslotz08rZfIqgFLj7c9Jmy7btwkHz7W89lio1v0S
 J6DmYiawsA4P7sEpnhNzKTZiVsSnsx1sf7fG+xEQlfN77/7pFQDJISa1x6MZSy2jbhXjifm+P
 O1dQhB9sgQjoXuwwiz3C8u8xu7KNnVzT2PFR6AQkMcguh1CPU46KVX6y/2IVNR/nG7VVl1Qtl
 A8i+Veqi4J07t7bHsBtlgs3NflBAjh6gF5HFmtHTx2vuLnWuPO7UwJn+BSM3Sm6Xe2rRuCodL
 DeK8HUNGJcd5nayYdf7779u2yuuqAKA1Rmwpoy6L6/LMGgARlHP5McNupfdKliN1ShPrGsmgy
 0pK6dOizr4grzVX1b5v5Xg68+EzfVYT60y8Spop+ieZ8Km9EMyGRsrR8J7Dr6ny6cqyXUe3n0
 g9RuuyuHBpzyxytqiZTccOgVZudbV+C1muR6//HtQkaJgZDC9ld7A4wDdxHSuZ5vNHmcHw51z
 r737kRPZIGwWimMF5ShDjeM4CiBjos9Auh0ACK9XjfNfXRCioW45LwyUYksBt+pVk4grgYDWm
 4VRhB/vtn9dW/qFHJV4Pih4NtmCb+yjpmqFsWKafh93/b9+nyORLO7qxmd1UlXgqjdEIZ+YhQ
 7GYxJvRvB/JBaCKPgF98d+wd8JLVKFonAOzVAcq4uPzS3E/RcSv6f69hulKu6lSrE4weefqlx
 /wQKnGauStmLHbvQoxJ74KcWCzNQh1Id8N31ea36PVodz1WjRVeMFsS2uw+g7bzeT5brZxS+o
 4lUby4hwTf0xgiNdaLw8KWf+zh/Y7diNhz+VQviKMNZYnOKLa00NEzuRIpYeh43L1etL0umZw
 VFNATfjRdRID3t4ttA3f5rCUe84XHIzpktaFuLSHZzIGOnUuKbFQ0q6hzeNcn1ybrlaKyumIQ
 Epd3PDflg/YExgPJLrzmlOyydfOOGk1gCW2YkIaO8E6tjRsYrraNwwGMopVedMJz2TbgGe9uu
 xOWBgfVWMVCGgOdmoWpNggMNTP79IaJwD7767tjpRqhI0IYtb0tCrP6Sup62fOzK8Dhb9E55t
 ll73A7ZeSqExlYd67F6fLqkgyamQo8IC31TnRiHPuC65m96RD5CsQM6UA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1166408642-1660914348=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & Rub=C3=A9n,

On Tue, 16 Aug 2022, Johannes Schindelin wrote:

> On Mon, 8 Aug 2022, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > @@ -1420,6 +1420,12 @@ static int interpret_nth_prior_checkout(struc=
t repository *r,
> > >  	const char *brace;
> > >  	char *num_end;
> > >
> > > +	if (namelen =3D=3D 1 && *name =3D=3D '-') {
> > > +		brace =3D name;
> > > +		nth =3D 1;
> > > +		goto find_nth_checkout;
> > > +	}
> > > +
> > >  	if (namelen < 4)
> > >  		return -1;
> > >  	if (name[0] !=3D '@' || name[1] !=3D '{' || name[2] !=3D '-')
> >
> > If a solution along this line works, it would be far cleaner design
> > than the various hacks we have done in the past, noticing "-" and
> > replacing with "@{-1}".
>
> Indeed, but it does not work as-is: `interpret_nth_prior_checkout()` is
> used on prefixes of a rev, and for the special handling of `-` we cannot
> have that.
>
> [...]
>
> One thing we could do, however, would be to patch only
> `repo_interpret_branch_name()`, i.e. only allow `-` to imply the
> previous branch name in invocations where a branch name is asked for
> _explicitly_. I.e. not any random revision, but specifically a branch
> name.

This patch does that:

=2D- snip --
diff --git a/object-name.c b/object-name.c
index 4d2746574cd..a2732be3b71 100644
=2D-- a/object-name.c
+++ b/object-name.c
@@ -1616,6 +1616,20 @@ int repo_interpret_branch_name(struct repository *r=
,
 	if (!namelen)
 		namelen =3D strlen(name);

+	if (namelen =3D=3D 1 && *name =3D=3D '-') {
+		struct grab_nth_branch_switch_cbdata cb =3D {
+			.remaining =3D 1,
+			.sb =3D buf
+		};
+
+		if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r),
+						     "HEAD",
+						     grab_nth_branch_switch,
+						     &cb) <=3D 0)
+			return -1;
+		return namelen;
+	}
+
 	if (!options->allowed || (options->allowed & INTERPRET_BRANCH_LOCAL)) {
 		len =3D interpret_nth_prior_checkout(r, name, namelen, buf);
 		if (!len) {
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-i=
nterpretation.sh
index 993a6b5eff7..5acbef95913 100755
=2D-- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -67,6 +67,22 @@ test_expect_success 'delete branch via @{-1}' '
 	expect_deleted previous-del
 '

+test_expect_success 'delete branch via -' '
+	git checkout -b previous-del &&
+	git checkout - &&
+
+	git branch -d - &&
+	expect_deleted previous-del &&
+
+	git branch previous-del2 &&
+	git checkout -b previous-del &&
+	git checkout - &&
+
+	git branch -d previous-del2 - &&
+	expect_deleted previous-del &&
+	expect_deleted previous-del2
+'
+
 test_expect_success 'delete branch via local @{upstream}' '
 	git branch local-del &&
 	git branch --set-upstream-to=3Dlocal-del &&
=2D- snap --

This adds support for things like `git branch -d -`, and it even verifies
that that works.

What does not work with this patch is `git show -`. I am not sure whether
we want to make that work, although I have to admit that I would use it.
Often. And this patch would make it work, the test suite even passes with
it:

=2D- snip --
diff --git a/revision.c b/revision.c
index f4eee11cc8b..207b554aef1 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -2802,7 +2802,7 @@ int setup_revisions(int argc, const char **argv, str=
uct rev_info *revs, struct s
 		revarg_opt |=3D REVARG_CANNOT_BE_FILENAME;
 	for (left =3D i =3D 1; i < argc; i++) {
 		const char *arg =3D argv[i];
-		if (!seen_end_of_options && *arg =3D=3D '-') {
+		if (!seen_end_of_options && *arg =3D=3D '-' && arg[1]) {
 			int opts;

 			opts =3D handle_revision_pseudo_opt(
=2D- snap --

That latter patch obviously needs at least one accompanying test case, and
the patch series would then need to drop the special-casings we already
have for "-".

Rub=C3=A9n, do you want to take this a bit further?

Ciao,
Dscho

P.S.: For convenient fetching, I opened a draft PR here:
https://github.com/gitgitgadget/git/pull/1329

--8323328-1166408642-1660914348=:241--
