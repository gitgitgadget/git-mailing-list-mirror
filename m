Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD871FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753538AbcK3V0v (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:26:51 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58571 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752609AbcK3V0t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:26:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29D2351807;
        Wed, 30 Nov 2016 16:21:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ei7UJ5kFImdG
        QyIeM+CDMwBm1kc=; b=RwpFkeh3TOtEA9Sl6YD7pI/KYoRQX6vhMzJQUaA0bpUr
        u0SWbwXsSiowbipcATu8deSHlQLEZ8Ch6gOBUiB3B90c592RhfXd40if9aN9rWEt
        KzpantlH/shR/hkY+UIugQriH0moguJ09su71tnNDk5bxCIKf/SsRbk43CAvDUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=W+iOWq
        jfHloHtNwhlqmcCThrcg1GrGqe7w1ly1GYahbl1Z9r5Ss3m4cm7pQrZ05joDRlTt
        8/9c8064+vdDtbDkXEGxUJOuG7E6ncLXILfKc2XaYajk3GmN7Aqg2Zbac6W6eXnO
        5A0/ee5zr/6PmKHyMM21Gv+WcFepvX/ckZujw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2145051805;
        Wed, 30 Nov 2016 16:21:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 80C9151802;
        Wed, 30 Nov 2016 16:21:10 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2] tag, branch, for-each-ref: add --ignore-case for sorting and filtering
References: <20161117102114.16649-1-pclouds@gmail.com>
        <20161130123502.12973-1-pclouds@gmail.com>
Date:   Wed, 30 Nov 2016 13:21:09 -0800
In-Reply-To: <20161130123502.12973-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 30 Nov 2016 19:35:02 +0700")
Message-ID: <xmqqk2bkd5q2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EA25671A-B742-11E6-A5BB-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This option makes sorting ignore case, which is great when you have
> branches named bug-12-do-something, Bug-12-do-some-more and
> BUG-12-do-what and want to group them together. Sorting externally may
> not be an option because we lose coloring and column layout from
> git-branch and git-tag.
>
> The same could be said for filtering, but it's probably less important
> because you can always go with the ugly pattern [bB][uU][gG]-* if you'r=
e
> desperate.

But of course --ignore-case is of course much easier.

> You can't have case-sensitive filtering and case-insensitive sorting (o=
r
> the other way around) with this though. But who would want that?

I do not feel uncomfortable declaring that the answer to that
question is "nobody" ;-)

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  v2 has a different approach, and I think it's a better one even with
>  that unanswered question above.

Yeah, I think this would be easier to use.

> @@ -512,15 +512,6 @@ static void print_ref_list(struct ref_filter *filt=
er, struct ref_sorting *sortin
>  	if (filter->verbose)
>  		maxwidth =3D calc_maxwidth(&array, strlen(remote_prefix));
> =20
> -	/*
> -	 * If no sorting parameter is given then we default to sorting
> -	 * by 'refname'. This would give us an alphabetically sorted
> -	 * array with the 'HEAD' ref at the beginning followed by
> -	 * local branches 'refs/heads/...' and finally remote-tacking
> -	 * branches 'refs/remotes/...'.
> -	 */
> -	if (!sorting)
> -		sorting =3D ref_default_sorting();

So it is now a BUG() to give sorting=3D=3DNULL to this function, which
is OK and I do not think we even need an assert() for it (i.e. the
code with the patch looks good).

> @@ -744,6 +739,16 @@ int cmd_branch(int argc, const char **argv, const =
char *prefix)
>  		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
>  			filter.kind |=3D FILTER_REFS_DETACHED_HEAD;
>  		filter.name_patterns =3D argv;
> +		/*
> +		 * If no sorting parameter is given then we default to sorting
> +		 * by 'refname'. This would give us an alphabetically sorted
> +		 * array with the 'HEAD' ref at the beginning followed by
> +		 * local branches 'refs/heads/...' and finally remote-tacking
> +		 * branches 'refs/remotes/...'.
> +		 */
> +		if (!sorting)
> +			sorting =3D ref_default_sorting();
> +		sorting->ignore_case =3D icase;
>  		print_ref_list(&filter, sorting);
>  		print_columns(&output, colopts, NULL);
>  		string_list_clear(&output, 0);

... and the fallback is moved to the caller, which makes sense.

> diff --git a/ref-filter.c b/ref-filter.c
> index f5f7a70..bd98010 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1231,8 +1231,14 @@ static int commit_contains(struct ref_filter *fi=
lter, struct commit *commit)
>   * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same re=
f
>   * matches "refs/heads/mas*", too).
>   */
> -static int match_pattern(const char **patterns, const char *refname)
> +static int match_pattern(const struct ref_filter *filter, const char *=
refname)
>  {
> +	const char **patterns =3D filter->name_patterns;
> +	unsigned flags =3D 0;
> +
> +	if (filter->ignore_case)
> +		flags |=3D WM_CASEFOLD;
> +

Ahh, OK.  My reading stuttered when seeing "sorting and filtering"
in the option description for "git tag", but this makes perfect
sense.  Good job.

> @@ -1255,9 +1261,15 @@ static int match_pattern(const char **patterns, =
const char *refname)
>   * matches a pattern "refs/heads/" but not "refs/heads/m") or a
>   * wildcard (e.g. the same ref matches "refs/heads/m*", too).
>   */
> -static int match_name_as_path(const char **pattern, const char *refnam=
e)
> +static int match_name_as_path(const struct ref_filter *filter, const c=
har *refname)
>  {
> +	const char **pattern =3D filter->name_patterns;
>  	int namelen =3D strlen(refname);
> +	unsigned flags =3D WM_PATHNAME;
> +
> +	if (filter->ignore_case)
> +		flags |=3D WM_CASEFOLD;
> +

Likewise.  Very simple and nicely done.

> @@ -1536,18 +1548,20 @@ static int cmp_ref_sorting(struct ref_sorting *=
s, struct ref_array_item *a, stru
>  	struct atom_value *va, *vb;
>  	int cmp;
>  	cmp_type cmp_type =3D used_atom[s->atom].type;
> +	int (*cmp_fn)(const char *, const char *);
> =20
>  	get_ref_atom_value(a, s->atom, &va);
>  	get_ref_atom_value(b, s->atom, &vb);
> +	cmp_fn =3D s->ignore_case ? strcasecmp : strcmp;
>  	if (s->version)
>  		cmp =3D versioncmp(va->s, vb->s);
>  	else if (cmp_type =3D=3D FIELD_STR)
> -		cmp =3D strcmp(va->s, vb->s);
> +		cmp =3D cmp_fn(va->s, vb->s);
>  	else {
>  		if (va->ul < vb->ul)
>  			cmp =3D -1;
>  		else if (va->ul =3D=3D vb->ul)
> -			cmp =3D strcmp(a->refname, b->refname);
> +			cmp =3D cmp_fn(a->refname, b->refname);
>  		else
>  			cmp =3D 1;
>  	}

OK.

> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index c6a3ccb..fad79e8 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -89,6 +89,11 @@ test_expect_success 'git branch --list -v pattern sh=
ows branch summaries' '
>  	awk "{print \$NF}" <tmp >actual &&
>  	test_cmp expect actual
>  '
> +test_expect_success 'git branch --ignore-case --list -v pattern shows =
branch summaries' '
> +	git branch --list --ignore-case -v BRANCH* >tmp &&
> +	awk "{print \$NF}" <tmp >actual &&
> +	test_cmp expect actual
> +'

The way the test ensures it found only branch-one and branch-two
looks very sloppy, but that was inherited from the existing one
before this new one, so I'll let it pass.

> @@ -196,4 +201,21 @@ test_expect_success 'local-branch symrefs shortene=
d properly' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'sort branches, ignore case' '
> +	(
> +		git init sort-icase &&
> +		cd sort-icase &&
> +		test_commit initial &&
> +		git branch branch-one &&
> +		git branch BRANCH-two &&
> +		git branch --list -i | awk "{print \$NF}" >actual &&
> +		cat >expected <<-\EOF &&
> +		branch-one
> +		BRANCH-two
> +		master
> +		EOF
> +		test_cmp expected actual
> +	)
> +'

Is there an existing test that uses refs with mixed cases, i.e. the
result of listing sorts differently with and without the -i option?
If not, this one should test output from both cases to ensure that
the command run without -i stays case sensitive.

>  test_done
> diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
> index 8b0f71a..2d9cae3 100755
> --- a/t/t7004-tag.sh
> +++ b/t/t7004-tag.sh
> @@ -27,6 +27,23 @@ test_expect_success 'listing all tags in an empty tr=
ee should output nothing' '
>  	test $(git tag | wc -l) -eq 0
>  '
> =20
> +test_expect_success 'sort tags, ignore case' '
> +	(
> +		git init sort &&
> +		cd sort &&
> +		test_commit initial &&
> +		git tag tag-one &&
> +		git tag TAG-two &&
> +		git tag -l -i >actual &&
> +		cat >expected <<-\EOF &&
> +		initial
> +		tag-one
> +		TAG-two
> +		EOF
> +		test_cmp expected actual
> +	)
> +'

Ditto.


>  test_expect_success 'looking for a tag in an empty tree should fail' \
>  	'! (tag_exists mytag)'
> =20
> @@ -81,6 +98,9 @@ test_expect_success 'listing all tags if one exists s=
hould output that tag' '
>  test_expect_success 'listing a tag using a matching pattern should suc=
ceed' \
>  	'git tag -l mytag'
> =20
> +test_expect_success 'listing a tag using a matching pattern should suc=
ceed' \
> +	'git tag -l --ignore-case MYTAG'

The existing one before this one merely says that "git tag -l" must
exit with 0 status code, no?

IOW, even "git tag -l no-such-tag-anywhere && echo OK" yields OK.

So there is not much point replicating it with "-i", unless you want
to say that "git tag -i -l" also must exit with 0 status code.

>  test_expect_success \
>  	'listing a tag using a matching pattern should output that tag' \
>  	'test $(git tag -l mytag) =3D mytag'

I think the new one would want to mimic this one instead.  Look for
MYTAG with the -i option and see it output mytag (in lowercase).

