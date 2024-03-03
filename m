Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3561E51E
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 22:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505786; cv=none; b=mu3T7YHp5Ek9yhSvxiS9bkFUgj45g5JdNd1eInYwdOQ99anZmlPJYrbnkWzJRxElXOS3jhWgmcw0Y0JtsX6p0CTZW7ivPRY5k7gX/DVn2oaX3qcDTYf+RGgxYOSgelmPR2TALh/aexJznWcDDA5uNGafU5OdyZRi4y9PU3+N2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505786; c=relaxed/simple;
	bh=kPYbGd1K//Y2cjh+q9qJdMOmhFeIxdXUTox2e+Aqudc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFEasM7RMF7+Y1TIpfU26t+M4wtlCy0qG+NceOzS7PF+t9qeBVvDL9fWogp/iBNC7Aux9gjKckJMKHlPFcfTjlBh4cevijQp/mIonJNXyGlBuzlqu/5kJ5/ko6oc4tTSx9XU71wzzHPyte1hlz0YLq4JKK+JV7IOG1Dg7gMase8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D54Ds6bc; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D54Ds6bc"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A2673305C8;
	Sun,  3 Mar 2024 17:43:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kPYbGd1K//Y2
	cjh+q9qJdMOmhFeIxdXUTox2e+Aqudc=; b=D54Ds6bcOMSIaFqTYeKkcny9wjQq
	BBtikFSSplepn3Q4mm8AEiQN5fdwr0QvrIb0Z63DapZuOHDxjW97vZMW/oZG7N3q
	FBmNH3keGADi8twR5RdMZhPZBsZvsfCD7bgS/wH7GbOdiSh/UHiwM3mXNFef7zrT
	D3yh5pWwKxjHl2M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87A08305C7;
	Sun,  3 Mar 2024 17:43:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 251FF305C5;
	Sun,  3 Mar 2024 17:43:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] branch: advise about ref syntax rules
In-Reply-To: <4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sun, 3 Mar 2024 19:58:21 +0100")
References: <d275d1d179b90592ddd7b5da2ae4573b3f7a37b7.1709307442.git.code@khaugsbakk.name>
	<cover.1709491818.git.code@khaugsbakk.name>
	<4ad5d4190649dcb5f26c73a6f15ab731891b9dfd.1709491818.git.code@khaugsbakk.name>
Date: Sun, 03 Mar 2024 14:42:59 -0800
Message-ID: <xmqqil23uebw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 63C8C29C-D9AF-11EE-88BD-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:


This has sufficiently been advanced since the previous one, that
range-diff would need to be prodded with a larger --creation-factor
value to avoid getting a rather useless output.

1:  5548e6fa34 < -:  ---------- branch: advise about ref syntax rules
-:  ---------- > 1:  202d4e29ef branch: advise about ref syntax rules

> git-branch(1) will error out if you give it a bad ref name. But the use=
r
> might not understand why or what part of the name is illegal.
>
> The user might know that there are some limitations based on the *loose
> ref* format (filenames), but there are also further rules for
> easier integration with shell-based tools, pathname expansion, and
> playing well with reference name expressions.
>
> The man page for git-check-ref-format(1) contains these rules. Let=E2=80=
=99s
> advise about it since that is not a command that you just happen
> upon. Also make this advise configurable since you might not want to be
> reminded every time you make a little typo.

Nicely written and easily read.  Well done.

> +	refSyntax::
> +		Point the user towards the ref syntax documentation if
> +		they give an invalid ref name.

I noticed a minor phrasing issue, but many other entries talk about
"shown when ...", even though a handful of them use "if ...".  Do we
want to make them consistent?

>  	resetNoRefresh::
>  		Advice to consider using the `--no-refresh` option to
>  		linkgit:git-reset[1] when the command takes more than 2 seconds

> diff --git a/advice.c b/advice.c
> index 6e9098ff089..550c2968908 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -68,6 +68,7 @@ static struct {
>  	[ADVICE_PUSH_UNQUALIFIED_REF_NAME]		=3D { "pushUnqualifiedRefName" },
>  	[ADVICE_PUSH_UPDATE_REJECTED]			=3D { "pushUpdateRejected" },
>  	[ADVICE_PUSH_UPDATE_REJECTED_ALIAS]		=3D { "pushNonFastForward" }, /*=
 backwards compatibility */
> +	[ADVICE_REF_SYNTAX]				=3D { "refSyntax" },
>  	[ADVICE_RESET_NO_REFRESH_WARNING]		=3D { "resetNoRefresh" },
>  	[ADVICE_RESOLVE_CONFLICT]			=3D { "resolveConflict" },
>  	[ADVICE_RM_HINTS]				=3D { "rmHints" },
> diff --git a/advice.h b/advice.h
> index 9d4f49ae38b..d15fe2351ab 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -36,6 +36,7 @@ enum advice_type {
>  	ADVICE_PUSH_UNQUALIFIED_REF_NAME,
>  	ADVICE_PUSH_UPDATE_REJECTED,
>  	ADVICE_PUSH_UPDATE_REJECTED_ALIAS,
> +	ADVICE_REF_SYNTAX,
>  	ADVICE_RESET_NO_REFRESH_WARNING,
>  	ADVICE_RESOLVE_CONFLICT,
>  	ADVICE_RM_HINTS,

Both of these are in lexicographic order, which is good.

> diff --git a/branch.c b/branch.c
> index 6719a181bd1..621019fcf4b 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -370,8 +370,12 @@ int read_branch_desc(struct strbuf *buf, const cha=
r *branch_name)
>   */
>  int validate_branchname(const char *name, struct strbuf *ref)
>  {
> -	if (strbuf_check_branch_ref(ref, name))
> -		die(_("'%s' is not a valid branch name"), name);
> +	if (strbuf_check_branch_ref(ref, name)) {
> +		int code =3D die_message(_("'%s' is not a valid branch name"), name)=
;
> +		advise_if_enabled(ADVICE_REF_SYNTAX,
> +				  _("See `man git check-ref-format`"));
> +		exit(code);
> +	}

Nice.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index cfb63cce5fb..1c122ee8a7b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -576,8 +576,12 @@ static void copy_or_rename_branch(const char *oldn=
ame, const char *newname, int
>  		 */
>  		if (ref_exists(oldref.buf))
>  			recovery =3D 1;
> -		else
> -			die(_("invalid branch name: '%s'"), oldname);
> +		else {
> +			int code =3D die_message(_("invalid branch name: '%s'"), oldname);
> +			advise_if_enabled(ADVICE_REF_SYNTAX,
> +					  _("See `man git check-ref-format`"));
> +			exit(code);
> +		}
>  	}

Good, too.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index de7d3014e4f..d21fdf09c90 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1725,4 +1725,15 @@ test_expect_success '--track overrides branch.au=
toSetupMerge' '
>  	test_cmp_config "" --default "" branch.foo5.merge
>  '
> =20
> +cat <<\EOF >expect
> +fatal: 'foo..bar' is not a valid branch name
> +hint: See `man git check-ref-format`
> +hint: Disable this message with "git config advice.refSyntax false"
> +EOF
> +
> +test_expect_success 'errors if given a bad branch name' '
> +	test_must_fail git branch foo..bar >actual 2>&1 &&
> +	test_cmp expect actual
> +'

Even though there are a few ancient style tests that have code to
set up expectations outside the test_expect_success, most of the
tests in t3200 do use a more modern style.  Let's not make it worse,
by moving it inside, perhaps like:

test_expect_success 'errors if given a bad branch name' '
        cat >expect <<-\EOF &&
        fatal: '\''foo..bar'\'' is not a valid branch name
        hint: See `man git check-ref-format`
        hint: Disable this message with "git config advice.refSyntax fals=
e"
        EOF
	test_must_fail git branch foo..bar >actual 2>&1 &&
	test_cmp expect actual
'

We could make a preliminary clean-up to the file in question before
adding the above test, if we wanted to.  Or we can do so after the
dust settles.  Such a fix may look like the attached.

Thanks.

 t/t3200-branch.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git c/t/t3200-branch.sh w/t/t3200-branch.sh
index 94b536ef51..ba1e0eace5 100755
--- c/t/t3200-branch.sh
+++ w/t/t3200-branch.sh
@@ -1112,14 +1112,14 @@ test_expect_success '--set-upstream-to notices an=
 error to set branch as own ups
 	test_cmp expect actual
 "
=20
-# Keep this test last, as it changes the current branch
-cat >expect <<EOF
-$HEAD refs/heads/g/h/i@{0}: branch: Created from main
-EOF
 test_expect_success 'git checkout -b g/h/i -l should create a branch and=
 a log' '
 	GIT_COMMITTER_DATE=3D"2005-05-26 23:30" \
 	git checkout -b g/h/i -l main &&
 	test_ref_exists refs/heads/g/h/i &&
+
+	cat >expect <<-EOF &&
+	$HEAD refs/heads/g/h/i@{0}: branch: Created from main
+	EOF
 	git reflog show --no-abbrev-commit refs/heads/g/h/i >actual &&
 	test_cmp expect actual
 '
