Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658744;
	b=wnCNmRbIHiv9nodcfxNKl1oWwxugU6Tw6GNOdrRMLsMGJR644utMXh/Y/PFgv4NQOAfs
	 zRdX3utGXSJzmCrD+XXLJfBLEOUTpJbI5bwmnaQCWnnTr9iU71/9Q0SYbXZ5Vi4Ea8N4L
	 prI5D5iM8FO3SGU0cEQkTMJ5LH8jnY1MBlFJpQFe++Ui4Vo2c0hAA2TKBNfacCUqvq3Wm
	 3PJXEWlFOmhq67qZhSo2VFD4oH5aq3k3QiISv1kK8DnthVI4Bbfov2Qf2C6LdBqBeZoHK
	 RPn+w6qmkk+LWkvMBvjTaCRqh4LpFzWdFw7fcgbEK0vRdlei2DZfw127JnkV85/zXgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=qQS5/cXNdBgcAPgXcoDIsdMuZRkpfbfkunYbHgb7iwY=;
	b=ev8x4UT0xDoa1mPNiDe6ujDWzWImXiUQYzgtscrykxTnnnaFpDiEnTtaCUOS3tNI8m8n
	 HVQqvIL7SmcIcxwti/OPDsL0CvJQWbVa68ylHEQuHL3+Q++ip+o7oJElTBE8UjG5O7mll
	 7fMgbCQgnnTvqmg7dajtJNpo+2rSpX6CqJCMIry8L2DeCLQ7txdGMsRJ/zIgyx/7cLZco
	 bKvvxr6aE0NmddHlewueaRiX2eBBryrGWvyO8pbsxZVhcYTlOnCnFy9So5O20kf3sjPpH
	 qxSxdo8zDZnT6mgNv1FJtQz9JLc512rG9e1eV3/uiR4mdoJRhxxvCLYyzfUsbszbMnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bk67Xjhd;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC2606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 22:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7AC2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bk67Xjhd
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4e4a4d77e5bso76283b6e.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 14:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793658743; x=1794263543; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qQS5/cXNdBgcAPgXcoDIsdMuZRkpfbfkunYbHgb7iwY=;
        b=Bk67XjhdFTa5VEDGVU+0VhgI1yIEhm8wz72u/ZQIJ74NEGsNaDWkkbOKCUGUPMRZLt
         E7Jcm4EaLfaCtv0eHgxq9E0iZpGuPpHce7br2Oo/VKWuYMBgOua7Xv7bZftFM/lGGqfY
         WXaJ7damzgEy9CCtw61IE2NHEPuBbCADGNoBiSIkqGPnSPt18nZ74/6mCloJHraZtHd1
         1nLRiRXT8HTyjom25lkdCAcnA4V3RWG5Be7XhBZ71mS5r+qiDD5Sa1VaE1gss27nDpG4
         tfXLxIaEPxrEAzgM7EEuswGW+PCEC7BBlonThfhKjvTRCjkLvdHm03M3grTE9jw8BCfJ
         oL3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793658743; x=1794263543;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQS5/cXNdBgcAPgXcoDIsdMuZRkpfbfkunYbHgb7iwY=;
        b=pTHeRXUDbIXexUFEvLRSKg+VNLAaSJve/cBjddJwNbdlhe+SVpdNW7WMCTh+G9ef1w
         FhqQOfjnxDzX8aZzYauf7rv8mK5mf4YjFQTxckV3a3PZVDW5vgt/0Lzbus5X7dfyWwRO
         z8gUvtkb1rjO+ZqIqQra1lfzPC8cppeCmDbZ7xyzQNPz6XmuPmVQdZ+Wto0qAlOMevSC
         fBJXcyyyVWovwlatY/hAooJ4wtPgpojriz3F0ZkhaysXwRD8XFrvJmtvx5OCOjxIe9fh
         ZBL81QifhfW7qmX8rsRagB0Z4oELq1QTY1PWhEp23Zfx20FP94nueDpMUj7lGbU5tEqM
         FJ6g==
X-Gm-Message-State: AFq9FYKnmsPKdgKE/1QW+roXL5YWW9ck/KLLhQBhqVNvuFvbWHTimXnJ
	huqZ4c/KJez9ngsnXNMedG0XnzqAkz7zFAGvjSs4FOkvLZkl1CD08SYHW2phfA==
X-Gm-Gg: AYBFou0Q8mA/ccoRZ+28V1RAdHOAcwUAJnUVhoSxMgRhqBTmrD+4oIP/2fLB1oRxnUX
	6EpdZ6Olr/IEZR0M0HGPQO8x97zcdiIQ6cz81Zkaryk/txXUI0qsAhqcbJjxJ4lR0V+dwggpU1v
	7e4RdM7PQ77osRf0YmBkw2m65Ou8RnhnRAVgsOZtL2ipxABNC9TEBzW/UjlnLJs1atQpGsy1LFx
	U6UaiQe12zIHgTpjonDwMcn33FZGmimhs05wtPqht89nRzIhYp1nhCNkyFpNSNF1u1xyFlT6nTj
	nesNYwYo+SUq4GU0gP4JNIKgbdEeSkYAA6LwaEfjuKICfanbGML5RsO5+bGm1ctw5Aqrqd7opER
	RmTMzEFujSUfPGqkHE347V4rPAzihaSSrOtiFMIpAj7bpOAp3rmsbHb0vAS3DhLgeGyhg0+Btsh
	rjxSwoadNlCEto0fYK0UmBfiMtEKy8qlvubBZHRmeZGZKCX5d0tHSi66PuPXimF90hed4BsHjlj
	1TvGsUY2JfiJIqf+NfKrCjbfAB+BufrhDRlqi81IuUGvtAJsPBFcoNUzX0BXH4fCJl/APgIuXXJ
	UQYg0OxFACLoPgmg6pObEKSR/B6FOuQVJvNWnbyjhtqqg1rcopd7uz7J3TdUuuvffeLGz7KTGg=
	=
X-Received: by 2002:a05:6809:297:10b0:564:3e9e:b4b1 with SMTP id 5614622812f47-5643e9ebc20mr1805647b6e.18.1793658742569;
        Mon, 02 Nov 2026 14:32:22 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49923sm8786598b6e.1.2026.11.02.14.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 14:32:10 -0800 (PST)
Date: Mon, 2 Nov 2026 16:32:02 -0600
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, lucasseikioshiro@gmail.com, gitster@pobox.com
Subject: Re: [GSoC Patch v7 4/8] repo: add path.hooks with absolute and
 relative suffixes
Message-ID: <aukHlEd5udC1gLYZ@denethor>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-1-jayatheerthkulkarni2005@gmail.com>
 <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260927114420.59724-5-jayatheerthkulkarni2005@gmail.com>

On 26/09/27 05:14PM, K Jayatheerth wrote:
> Hooks are an integral part of a repository's configuration and are
> commonly used by tooling to automate repository-specific workflows.
> Currently, scripts typically retrieve the hooks directory by invoking
> `git rev-parse --git-path hooks`.
> 
> Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
> `git repo info`. This exposes the hooks directory as a scriptable
> config-like key using standard format rules, allowing scripts to
> retrieve it through the same interface as other repository path
> information.
> 
> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  Documentation/git-repo.adoc |  9 +++++++++
>  builtin/repo.c              | 22 ++++++++++++++++++++++
>  t/t1900-repo-info.sh        | 28 ++++++++++++++++++++++++++--
>  3 files changed, 57 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
> index e524a07f53..20836cf8f6 100644
> --- a/Documentation/git-repo.adoc
> +++ b/Documentation/git-repo.adoc
> @@ -119,6 +119,15 @@ values that they return:
>  `path.gitdir.relative`::
>  	The path to the Git repository directory relative to the current working directory.
>  
> +`path.hooks.absolute`::
> +	The canonical absolute path to the repository's hooks directory.
> +	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
> +	set to `/dev/null`, that value is returned unchanged.
> +
> +`path.hooks.relative`::
> +	The path to the repository's hooks directory relative to the current
> +	working directory. Respects the `core.hooksPath` configuration.

So if a repository has `core.hooksPath` set to "/dev/null", the relative
path output here would be something like "../../../../dev/null". I
recognize that this matches the current behavior:

  $ git -c core.hooksPath=/dev/null rev-parse --path-format=relative --git-path hooks
  ../../../../dev/null

...but I'm still not really convinced that is is a behavior we would
want to carry over as it makes it harder to users to figure out when
hooks are disabled.

I would suggest we print the "/dev/null" here even when the relative
path is requested and document the behavior.

[snip]
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index eec576a1d9..1da5db4942 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -174,7 +174,11 @@ test_repo_info_path () {
>  			cd repo/sub &&
>  			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
>  			eval "$init_command" &&
> -			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
> +			case "$expected_dir" in
> +			/*) EXPECT_ABS="$expected_dir" ;;
> +			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
> +			esac &&
> +			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
>  			git repo info "path.$field_name.absolute" >actual &&
>  			test_cmp expect actual
>  		)
> @@ -188,7 +192,11 @@ test_repo_info_path () {
>  			cd repo/sub &&
>  			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
>  			eval "$init_command" &&
> -			echo "path.$field_name.relative=../$expected_dir" >expect &&
> +			case "$expected_dir" in
> +			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
> +			*) EXPECT_REL="../$expected_dir" ;;
> +			esac &&
> +			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
>  			git repo info "path.$field_name.relative" >actual &&
>  			test_cmp expect actual
>  		)

From what I can gather, the code changes to this test helper is really
only required for the "/dev/null" test case. IMO, this helper function
has now become quite unwieldy and rather difficult to parse.

I think we would be better off writing the "/dev/null" test case by hand.

> @@ -213,6 +221,22 @@ test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>  	'.git' \
>  	'GIT_DIR="../.git" && export GIT_DIR'
>  
> +test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
> +
> +test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
> +	'custom-hooks' \
> +	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
> +
> +# /dev/null is not a real, canonicalizable filesystem path on Windows,
> +# so path resolution for core.hooksPath=/dev/null cannot be expected to
> +# produce a literal "/dev/null" the way it does on POSIX systems.
> +if ! test_have_prereq MINGW
> +then
> +	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
> +		'/dev/null' \
> +		'git config core.hooksPath /dev/null'
> +fi

I'm not quite sure I follow here. Are we saying that the git-repo-info
command won't work on windows if the hooks are set to "/dev/null"? Or is
it just some issue with how the test is written? If its the latter,
maybe this is something we can work around if the test is written
without the use of the `test_repo_info_path` helper?

-Justin
