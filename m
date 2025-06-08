Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C39C3FBB3
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 13:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749388646; cv=none; b=WxCFAhnjutlvALO9ulPMUT4nUSCpZnjxveqkLNyNMwRCO1TrvENxKaPEmmB3p92IgB8sgO6KqdWM8WGxA+7/EoC5aLRkSB11XSEpBV+NbLm2YSMdBtj+0sGUyT9Ivjl/oHEDgPlaL4F1FWuS5/FDmMtkAw+QoBAKn7/hp3kV/+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749388646; c=relaxed/simple;
	bh=quWWmqta/EbxHVFcDu0IY/PHIZMW7d5ooGPogmnQSdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQgXlVjAJFaQoJkHFYwKLDGovNs9GpQswmFULyFvfyLlp049Ro5gJZxFDwgYuJ4qeQ1EbrecI4Gv61RBXWo7jddUSVPdMame8+BnL7DKkLnJaaopfk5rsIdijpj/ErUi5KQe+q2GgeQHMBzqowK5dmLUTLNwJ4iiEMz7j3qfAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=ncH0lg+w; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="ncH0lg+w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749388641; x=1749993441; i=l.s.r@web.de;
	bh=Ol63qzqf/DqaTI80zY7c6X+gr6siOe9RzygJ22W0Ggk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ncH0lg+wv8GPtV2PN2y8IUYfCjJgYCmcsw1JI+naJtexxS+8bfUIr4rSF5a0/ETB
	 odBv5KZE5ooUUf32agwuXFvC1zR03sXlRr+c/sn2gnSuMJdFryBGfBE4Q75K1PrDK
	 3s+AYPB4B02sG+0HFfbsn9ovsQqneXDsx1Bk5+N3sWk6eT3DcgntlSUaBWU/K3s81
	 DqE4aHHMPgO86RuWJbc0dNtvm1cL7ggrVl1dqEsMdWd7MAKVeVvci7r4IUa49e4st
	 debqmJgkfnpnuBpEtt8pw8/jQ9Ad10ta1jC9Jc1fa5wOcKO52uajem9BgwxEslq4v
	 EYLSqe0KkkL4SSydTw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.29.133]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MbCI8-1uzVRP2lWS-00mByy; Sun, 08
 Jun 2025 15:11:59 +0200
Message-ID: <f46443ac-eb7f-47db-8f4b-a06384e6fde5@web.de>
Date: Sun, 8 Jun 2025 15:11:58 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] stash: fix incorrect branch name in stash message
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, gitster@pobox.com
Cc: git@vger.kernel.org, smacdonald@kaimaging.com, sunshine@sunshineco.com
References: <xmqq7c2jcodj.fsf@gitster.g>
 <20250608063537.233243-1-jayatheerthkulkarni2005@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20250608063537.233243-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9bMJlaofXDAWMMA7Z1OBaiqNJR9XNdUoe0s/xyF922oP+kXbp4n
 19bzNfdSniElm6/89Gg8a570dVmgBwhLZAKC+r7JbJog/6BbIsd18ly+twomEcXzyPtJKcg
 c/tAvyeZq/xduk9CIy5k9LxiribYKn2dQL1VrlW6Q3+lgg/ytAIuIAfC1QdYEyI/njBTj3e
 DxVTDX88XIiVo1gXjn0bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G9y/B2CvnUE=;GwPh9tM2CLWg4ASzRy580LG+tAi
 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
 yT+T6tKdACgvJ7cb5pld6nSP9RvofocUGi18LQ==

Am 08.06.25 um 08:35 schrieb K Jayatheerth:
> When creating a stash, Git uses the current branch name
> of the superproject to construct the stash commit message.
> However, in repositories with submodules,
> the message may mistakenly display the submodule branch name instead.
>=20
> This is because `refs_resolve_ref_unsafe()` returns a pointer to a stati=
c buffer.
> Subsequent calls to the same function overwrite the buffer,
> corrupting the originally fetched `branch_name` used for the stash messa=
ge.
>=20
> Use `xstrdup()` to duplicate the branch name immediately after resolving=
 it,
> so that later buffer overwrites do not affect the stash message.

Makes sense.

>=20
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
> This this patch was long due, and submodules patchs had a design choices=
=20
> Refined this patch Added tests and freed the leak as intended.
>=20
>  builtin/stash.c  | 19 +++++++++++++++----
>  t/t3903-stash.sh | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin/stash.c b/builtin/stash.c
> index cfbd92852a..13606efb12 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -1372,6 +1372,7 @@ static int do_create_stash(const struct pathspec *=
ps, struct strbuf *stash_msg_b
>  	const char *head_short_sha1 =3D NULL;
>  	const char *branch_ref =3D NULL;
>  	const char *branch_name =3D "(no branch)";
> +	char *branch_name_buf =3D NULL;
>  	struct commit *head_commit =3D NULL;
>  	struct commit_list *parents =3D NULL;
>  	struct strbuf msg =3D STRBUF_INIT;
> @@ -1401,11 +1402,20 @@ static int do_create_stash(const struct pathspec=
 *ps, struct strbuf *stash_msg_b
>  		ret =3D 1;
>  		goto done;
>  	}
> -
> -	branch_ref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_reposito=
ry),
> +=09
> +	branch_ref =3D refs_resolve_ref_unsafe(get_main_ref_store(the_reposito=
ry),=20

This part just adds whitespace at the end of the lines.  Please don't.

>  					     "HEAD", 0, NULL, &flags);
> -	if (flags & REF_ISSYMREF)
> -		skip_prefix(branch_ref, "refs/heads/", &branch_name);
> +
> +	if (flags & REF_ISSYMREF) {
> +		const char *tmp =3D NULL;
> +		if (skip_prefix(branch_ref, "refs/heads/", &tmp))
> +			branch_name_buf =3D xstrdup(tmp);=20
> +	}
> +	if (branch_name_buf)
> +		branch_name =3D branch_name_buf;
> +	else
> +		branch_name =3D "(no branch)";
> +					   =20

Looks complicated.

The if/else can be avoided by assigning both variables in the same
block, or in the same statement even.  You can see this pattern in the
code base by searching for "to_free".

And I'm not sure the tmp variable is providing much benefit.

	if (flags & REF_ISSYMREF) {
		if (skip_prefix(branch_ref, "refs/heads/", &branch_name))
			branch_name =3D branch_name_buf =3D xstrdup(branch_name);
	}

>  	head_short_sha1 =3D repo_find_unique_abbrev(the_repository,
>  						  &head_commit->object.oid,
>  						  DEFAULT_ABBREV);
> @@ -1495,6 +1505,7 @@ static int do_create_stash(const struct pathspec *=
ps, struct strbuf *stash_msg_b
>  	strbuf_release(&msg);
>  	strbuf_release(&untracked_files);
>  	free_commit_list(parents);
> +	free(branch_name_buf);
>  	return ret;
>  }
> =20
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 74666ff3e4..5d5aac8b15 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1592,4 +1592,43 @@ test_expect_success 'stash apply reports a locked=
 index' '
>  	)
>  '
> =20
> +test_expect_success 'stash reflog message uses superproject branch, not=
 submodule branch' '
> +	git init main_project &&
> +	(
> +		cd main_project &&
> +		echo "Initial content in main_project" > main_file.txt &&

Documentation/CodingGuidelines recommends: "Redirection operators should
be written with space before, but no space after them.", i.e., write
'>main_file.txt' instead of '> main_file.txt'.

> +		git add main_file.txt &&
> +		git commit -q -m "Initial commit in main_project"
> +	) &&
> +
> +	git init sub_project &&
> +	(
> +		cd sub_project &&
> +		echo "Initial content in sub_project" > sub_file.txt &&

Same here.

> +		git add sub_file.txt &&
> +		git commit -q -m "Initial commit in sub_project"
> +	) &&> +
> +	(
> +		cd main_project &&
> +		git -c protocol.file.allow=3Dalways submodule add --quiet ../sub_proj=
ect sub &&
> +		git commit -q -m "Added submodule sub_project" &&
> +
> +		git checkout -q -b feature_main &&
> +		(
> +			cd sub &&
> +			git checkout -q -b feature_sub
> +		) &&
> +
> +		git checkout -q -b work_branch &&
> +
> +		echo "Important work to be stashed" > work_item.txt &&

Same.

> +		git add work_item.txt &&
> +		git stash push -q -m "custom stash for work_branch" &&
> +
> +		git stash list > ../actual_stash_list.txt &&

And here.

> +		grep "On work_branch: custom stash for work_branch" ../actual_stash_l=
ist.txt
> +	)

You could avoid spawning one subshell by building sub_project first and
then doing all the work in main_project without interruption afterwards.

> +'
> +
>  test_done

