Received: from sonic303-3.consmr.mail.bf2.yahoo.com (sonic303-3.consmr.mail.bf2.yahoo.com [74.6.131.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6C433C534
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.131.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872856; cv=none; b=rgrZ3hIqUh32hQ916YokPyQbIgf+BVcSCRpjq1PNeZ07u/h1OV2sPupaGLw2Xr7LLBOvD4Gjnz2JKhNCV+hoBcSBzdVGIbbluUxU/D+2vlQNU/C1AnGQwVeiRZo9B8cfJ2IT17jaCF3/HoTtfnbe2BS4umOklFEZowHpETZc1Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872856; c=relaxed/simple;
	bh=cGvZDwvz/e7YnsGS00XlJ6M3pZiFVV43Fv5TYrHTFC8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TRl/cxAw6/Zdd5cBA7jNQ7DwpS/38uruj5VHWbyZmAQQrHi8ii42pRmA7UhMO58FrYWVaJR51zOzHrQsrSx6Ac4QOTig+9PZHr0eNrSJgsnAsp8Yo9/oLvYrf7TNTQwiUYGMZSi7XU5+YaRY5j5g0vhBDEwhNgFrJsvXu9FPxFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=oJ5fZQnY; arc=none smtp.client-ip=74.6.131.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="oJ5fZQnY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771872853; bh=cGvZDwvz/e7YnsGS00XlJ6M3pZiFVV43Fv5TYrHTFC8=; h=Date:From:To:Cc:In-Reply-To:References:Subject:From:Subject:Reply-To; b=oJ5fZQnY2bhVh27Fcs1HPKf2KcSXx5fgzpw7NrCYklIoeygZGmxyS3ConG6pEIv6mFuobKK1reLE4YVgu6pjRNqAkFhN8zb/R21RQh5Tmnd67cS1Qug04+hb2FCipqtG9LrOhr8vVco4q1Dfnl+0YRYe2/UHGhZPZMjHyQeYhlz9s7XqHHQjt72BCnkgCmUMwdLqof82PGcrV7tq+xgiygDe2TcuPFrMnTyglx3RHBKh++dmN1qPIVtRXzZ7tQEThDMNJX2CTmq7O5FZppCUtU0Y8ubBpqSXAJfLtxPF1n+X1r/zX6NEH7zGrXqmBZ56r2ajt0m3TJkrEGuRkqC2gA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1771872853; bh=GWLUbPqDNLBspkFkKozMn/cry8kU1p+CXKPo9y8LVby=; h=X-Sonic-MF:Date:From:To:Subject:From:Subject; b=JfbHjsyKMc3nla0Ov7IzLmXUJPolTfhuGnWvpEsDmdSNcr4qIFbML6vF8D+DObqBVZYwnkDfVOifQ7MoSJIlsxl52+5P78V5AhCMf0HCOkQoYcgkNQEtL2iVLvLRz6Nmh/g9HVTi0XCZmeY8D0YhCojrCiTR18luP8xNSH35D2N3+xelzqYO1dYuz+0szp85dCM2RJiFRNh1sPz80j0/EFUIflOo8bkR5EgRSvdLtAFRU81tKpDRx3BCd1COx6KfKfyz4K2DT2AHAas5LGHW2wO26HmGF/Gc5sNAq2Cfi/zDImdTLU2nqRye3baDLRJsqmGs1nHgaWFDuwDFAT+1GQ==
X-YMail-OSG: G7qHEokVM1kWD_bu_jYmF4DjqGEKgRAxXNnJfgVk66Xl8TSBct_CYdVqLojD06T
 NnEhGgL.Bq1AjWjrHm0VPbyVsmLWPmKHWVWbnsJqF_1uPLBsemxZL77RQq_5gDXNKnvzAC_jHw0o
 zNKlt6pudiC6oz9lrNwFcLg03nFe7woahsH1mNBykGpWfjnVqV0JAqJfnaL64iG0Ksg6.XWKIZ6D
 qZJ8GqLmkoHS2eC0lv4N2lYDy.l2nGK_HKcO0jjddc92Euw28E2Tx1qPHpred5hgbsdiF2ihLrTH
 0ejGdal5mld15B0r.svP4N0qxLdqQHHR0OI1DrxsQq6MuKaeGtSwmlWqloO.T8fqhqZwJPEwk.cV
 gLKFbOCtmQDK4k3dzUizvFGB0TEyUaPayI8OtaKUIlVleE3xtMY.t4FpD31XoCrXeSrCJrDpgXnO
 aGaeUKWWtUJU6qjBx8zaqqI1oZruCHTiuXklNaeFT4OGJCdYpHjIdCIy9GeOnSq7xApnptj_slxd
 JwPyUSKnkx79etXR3lZ3vdjxiqVqzgHo4e8GpmL_F1v.Vke5Z1tK91lYPRV4whPEGlkkuINJrYv7
 3yt2lzNiaC2XfWBl_Lc6mO76B.pEnj9wpcJXHxEoW1SEHziOVLvuv79h6NyAH7rfpPWCSw2pLvn7
 UHClzhJdu9r4i.auvc5Vjjtez73LC_33oaIi6P1vuU.77_sxlUQ0oGC7KcjeeNAg0KNTCp_6zXZ5
 h3orHsJDIcLIBpJkpcAGB75y3fB1j4tDVD2Ry_bH90Wl66Ko6iyyDdSM_2LXaGNoKXK3GJfUSif9
 4uSI7qiGJxoju_m1Pwl8NcyX_iJvnTxhmQXGuGyTYvUXNVJ0Q4tt.jHZKOfJlpvRpss9PkmYGSZ8
 uHQQmk3aF8qePqIamkDxQ_8r515eKNbHLFP385PmZJE8EVvSgd.gYidXc7.CmqjkvuMNhS5NwR47
 LIg2WvbUCE_sA.J1kDsGVfveuQmTbXwg8c7VbKEcv_wb5yl9KU9KOekWT.rHBlSR3L7tr1hYkqep
 HjVJ0u9j3k7rxoMxNqRYfSlbIrX9CCpRKVT30kQ11wlsmFYkgT188RbBugKDqWmeuM3T.a97Yv5n
 9TbJvGgfP4Nep2OZatmDCbmRawTOPtzSMfzpTKAY6N7fFCcV.4pFpn32FBOp03J_0CZabLX5N0Mh
 79rHQqNtEXsD23tYOvpNpbEDwXFqHMif.eMFDp6K_kQhCxiiLX3vY0PrOiXwga8skvc9KYZ81DBO
 6TCXAPjbxFMwDtiO3VEW4ZVg41fS1Rq.juZULyAxeS4zyjmQL1wHqp5WX2oDv07xbG3nkPnX20fv
 CRGjHuYj1LisjTwXq4p.QNdCLX.GifyU_VqBN2UPBfXUKizKwyZaZ_a0SeXjs_8BLrd9kheOS4Cf
 xIEebuBAGW7tQ0Tu_3VxtHuC8ZPJKJu25ICf2jbv2nJ8N269QnkN23wpHH4IPpVSCTGq46Jp8wfX
 EdcVCalBvDG.mixfgyf1GyRkwo7w.oRu1uHirunWaBhPB_3yFAylhgTM0rLJLLUioq0UgI7GelVa
 x6YZ4L9iODI1Ebt_Kwpyh5djGEu5OpD9iVTMEdVe7faE.Re8ggSEd1nH6VuSwla1z8zSxJ21fHvw
 y7XRj2FtZWajnXnR5_WPc6hRWE.xbvM1SOsiu9tLs1rgi6tA8GJKgL44lGKidRY0CxK8jnhf0GNe
 2DKzR6Ne7u4lS8L9TNfa6tP8lnZ_OCVk04a7SvQgbvzMIaIHmf2iTKpXKp0_jiaDBtXn2URCsFXk
 tKPChppcmPjXN2X2O.mKtntMnQGVnJKLH1cbZVnzXWsu2MGqjb73wPJfktvASKsjfGyGrPdtdILI
 koFLY7hQfRuU7195z0AUPlM5JOqIZVKtPDgSXcsnoOCYP6mVsnUCkGo2suVxoEsNw0A2hORdVk8A
 EjIdyzUQXugpI81Eb5xodDEPw5oIBvbJVfrqlvccErgKkUIpJpEtp59bLwfSBziF7UCT2rF_qy7g
 TwPYuRp2dW.zqinZ1lTrR49oKsJuBGzRskXPxaVGATapipQvM478E0RTUsn8I3oJhAVOKpm_dGmB
 QLKEey6L8Akt6DrwBIdMemVCUbqxMbLhlNqHts78n1MDtveO1WRzD1HhnXouzVz7mWlqOC_RP.0O
 zlbcay1hX4MhDxCVCqnl3ayjBama_d9tAHQOVQ2reGDndXpFD4eEzmsiQMjscC9cvTA--
X-Sonic-MF: <mdferdousalam1989@yahoo.com>
X-Sonic-ID: 22d585fc-9828-4de1-b9bf-3927c0cada88
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Mon, 23 Feb 2026 18:54:13 +0000
Date: Mon, 23 Feb 2026 18:54:11 +0000 (UTC)
From: Engr Md Ferdous Alam <mdferdousalam1989@yahoo.com>
To: Md Ferdous Alam via GitGitGadget <gitgitgadget@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <410509689.1055311.1771872851838@mail.yahoo.com>
In-Reply-To: <xmqqtsv7o3p1.fsf@gitster.g>
References: <pull.2052.git.1771836302101.gitgitgadget@gmail.com> <xmqqtsv7o3p1.fsf@gitster.g>
Subject: Re: [PATCH] cat-file: fix error and warning message formatting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.25198 YMailNorrin


Junio C Hamano <gitster@pobox.com> writes:


> It may be cleaner to deal with "Not a valid object name %s" that
> appear in 5 other .c files in addition to cat-file.c in a single
> patch (touching no other messages, just the "Not a valid object
> name" one), and do the rest of cat-file.c in a second patch.


Done in v2.=C2=A0 The series is now split into two patches:


=C2=A0 [1/2] die: lowercase "Not a valid object name" messages
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (cat-file.c, describe.c, ls-tree.c, merge-base.=
c,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read-tree.c, unpack-file.c and their test=
 expectations)
=C2=A0 [2/2] cat-file: fix remaining error and warning message formatting
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ("Cannot read object" and the promisor remotes =
warning)


> Have you audited third-party software that use Git plumbing commands
> like "git cat-file" to make sure that they do not expect the current
> and historical spelling to make sure this change will not break them?


I did a broad search across GitHub.=C2=A0 Here is what I found:


Several widely-used projects do case-sensitive string matching on
"fatal: Not a valid object name" in stderr output from Git commands:


=C2=A0 - Gitea (go-gitea/gitea) -- strings.Contains() in Go
=C2=A0 - Gogs (gogs/gogs) -- strings.Contains() in Go
=C2=A0 - GitLab Gitaly -- strings.HasPrefix() in Go
=C2=A0 - JetBrains IntelliJ -- startsWith() in Java
=C2=A0 - Harness CI/CD -- strings.HasPrefix() in Go (3 locations)
=C2=A0 - Review Board -- startswith() in Python
=C2=A0 - Tencent CodeAnalysis -- regex match in Python
=C2=A0 - DataLad -- "in" string check in Python
=C2=A0 - elastic/docs tooling -- .includes() in JavaScript
=C2=A0 - prettier-standard -- exact =3D=3D=3D equality in JavaScript


On the other hand, these are NOT affected:


=C2=A0 - Pure Git reimplementations (libgit2, JGit, go-git, Dulwich,
=C2=A0 =C2=A0 isomorphic-git, GitPython) generate their own messages.
=C2=A0 - GitKraken GitLens already uses case-insensitive matching (/i).
=C2=A0 - VS Code Git extension and GitHub Desktop do not match this
=C2=A0 =C2=A0 specific message.
=C2=A0 - Many CI/CD tools (Nx, BuildKit, Skaffold, Flutter) rely on
=C2=A0 =C2=A0 exit codes rather than message text.


A handful of projects already check for the lowercase form "not a
valid object name", suggesting the ecosystem is in transition, but
the majority still expect the capitalized form.


Given the risk of silently breaking error detection in projects like
Gitea, Gogs, Gitaly, and IntelliJ, I am not sure whether it is
worth proceeding with patch [1/2].=C2=A0 Patch [2/2] changes messages
that are far less likely to be parsed by external tools ("Cannot
read object" and the promisor remotes warning).


How would you like to proceed?=C2=A0 Should we:


=C2=A0 (a) keep both patches as-is and let downstream projects adapt,
=C2=A0 (b) drop patch [1/2] and only ship [2/2], or
=C2=A0 (c) take a different approach?


Thanks,
Md Ferdous Alam

=C2=A0=C2=A0







On Monday, February 23, 2026 at 09:54:52 PM GMT+6, Junio C Hamano <gitster@=
pobox.com> wrote:=20





"Md Ferdous Alam via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: mdferdousalam <mdferdousalam1989@yahoo.com>
>
> The CodingGuidelines state that error messages should not begin
> with a capital letter and should not end with a full stop.=C2=A0 Fix
> the die(), error() and warning() messages in builtin/cat-file.c
> that violate these rules, and update the corresponding test
> expectations in t1006 and t8007.
>
> Signed-off-by: mdferdousalam <mdferdousalam1989@yahoo.com>
> ---
>=C2=A0 =C2=A0 cat-file: fix error and warning message formatting
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2052%2F=
mdferdousalam%2Ffix-error-messages-cat-file-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2052/mdfer=
dousalam/fix-error-messages-cat-file-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2052

It may be cleaner to deal with "Not a valid object name %s" that
appear in 5 other .c files in addition to cat-file.c in a single
patch (touching no other messages, just the "Not a valid object
name" one), and do the rest of cat-file.c in a second patch.

Have you audited third-party software that use Git plumbing commands
like "git cat-file" to make sure that they do not expect the current
and historical spelling to make sure this change will not break them?

Other than that, looking good.=C2=A0 Thanks for working on it.


>
>=C2=A0 builtin/cat-file.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 ++++----
>=C2=A0 t/t1006-cat-file.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 6 +++---
>=C2=A0 t/t8007-cat-file-textconv.sh | 2 +-
>=C2=A0 3 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df8e87a81f..a8d564dd6a 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -121,7 +121,7 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name)
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 if (get_oid_with_context(the_repository, obj_nam=
e, get_oid_flags, &oid,
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 &obj_context))
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("Not a valid object name %s", =
obj_name);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("not a valid object name %s", =
obj_name);
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 if (!path)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 path =3D obj_context.path;
> @@ -182,7 +182,7 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name)
>=C2=A0 =C2=A0=C2=A0=C2=A0 case 'p':
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 type =3D odb_read_object_info=
(the_repository->objects, &oid, NULL);
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (type < 0)
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("Not a vali=
d object name %s", obj_name);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("not a vali=
d object name %s", obj_name);
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 /* custom pretty-print here *=
/
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (type =3D=3D OBJ_TREE) {
> @@ -200,7 +200,7 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 buf =3D odb_read_object(the_r=
epository->objects, &oid,
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 &type, &size);
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (!buf)
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("Cannot rea=
d object %s", obj_name);
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 die("cannot rea=
d object %s", obj_name);
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (use_mailmap) {
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 size_t s =
=3D size;
> @@ -910,7 +910,7 @@ static int batch_objects(struct batch_options *opt)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data.skip_=
object_info =3D 1;
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (repo_has_promisor_remote(=
the_repository))
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 warning("This r=
epository uses promisor remotes. Some objects may not be loaded.");
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 warning("this r=
epository uses promisor remotes; some objects may not be loaded");
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 disable_replace_refs();
>=C2=A0=20
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index 0eee3bb878..0283c7400d 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -705,7 +705,7 @@ do
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 then
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expec=
t <<-EOF
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 error: hea=
der for $bogus_long_oid too long, exceeds 32 bytes
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: Not a va=
lid object name $bogus_long_oid
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: not a va=
lid object name $bogus_long_oid
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 EOF
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expec=
t <<-EOF
> @@ -721,7 +721,7 @@ do
>=C2=A0=20
>=C2=A0 =C2=A0=C2=A0=C2=A0 test_expect_success "cat-file $arg1 error on mis=
sing short OID" '
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expect.err <<-EOF &&
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: Not a valid object name $(t=
est_oid deadbeef_short)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: not a valid object name $(t=
est_oid deadbeef_short)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 EOF
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 test_must_fail git cat-file $=
arg1 $(test_oid deadbeef_short) >out 2>err.actual &&
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 test_must_be_empty out &&
> @@ -732,7 +732,7 @@ do
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if test "$arg1" =3D "-p"
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 then
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expec=
t.err <<-EOF
> -=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: Not a va=
lid object name $(test_oid deadbeef)
> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 fatal: not a va=
lid object name $(test_oid deadbeef)
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 EOF
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 else
>=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expec=
t.err <<-\EOF
> diff --git a/t/t8007-cat-file-textconv.sh b/t/t8007-cat-file-textconv.sh
> index c3735fb50d..3a69b03794 100755
> --- a/t/t8007-cat-file-textconv.sh
> +++ b/t/t8007-cat-file-textconv.sh
> @@ -22,7 +22,7 @@ test_expect_success 'setup ' '
>=C2=A0=20
>=C2=A0 test_expect_success 'usage: <bad rev>' '
>=C2=A0 =C2=A0=C2=A0=C2=A0 cat >expect <<-\EOF &&
> -=C2=A0=C2=A0=C2=A0 fatal: Not a valid object name HEAD2
> +=C2=A0=C2=A0=C2=A0 fatal: not a valid object name HEAD2
>=C2=A0 =C2=A0=C2=A0=C2=A0 EOF
>=C2=A0 =C2=A0=C2=A0=C2=A0 test_must_fail git cat-file --textconv HEAD2 2>a=
ctual &&
>=C2=A0 =C2=A0=C2=A0=C2=A0 test_cmp expect actual
>
> base-commit: 7c02d39fc2ed2702223c7674f73150d9a7e61ba4
