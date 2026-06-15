Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A0630CDA2
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547459; cv=none; b=Ri2aNdAf/8dUum+VsdEuKce4yMkttE/zLAzfIem8hP89jSj+Hkci9WnQRrH7XfAHgTYCECB/EE9iw8fEXqHB4WvRQvFiMhEnrZI2PyoCcIr9r6SMbb+xd/d9ERgbeJELRkc8cLixlaYUHzQWmzj5ybi4gbap6NM3srHCo5BvKRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547459; c=relaxed/simple;
	bh=2Fu06kylPdTs5Ja8ECvQbFuZ+8mGY7hslwQ89Rd2fIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONxU69kc6ZrqqWnuNazgMtWajJh01+moBfBqzukbH/B+ECLOjXmCsuaP3yr+RDXuOx8jULxqRAV/p/+HAFsnBZLY4VR3OVKATDe++QMakSaTmgqysfI+EhhuEnpVM5Jfy61RTiOJezbjTqY6FaAQye9GWXTdfxpz7XZiJLXKawo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTtxr8LU; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTtxr8LU"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-69e8aa31e9fso1696194eaf.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781547457; x=1782152257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tg79I+eDMuiCz9MTqJG6oHB/zH6pZAuqO5T6OdaSbFg=;
        b=kTtxr8LUhYikMtnhYDnrkYzQbu7piBA/QIkVa8gAQc9ykh07NXgy/I7C2LKIzgr5BX
         wddFmG+cPFQ2f/8fkjsuXyAmomBni7bnbXKajgugDZ5XMeyyxNPOumV6oUU+UHrnpg2C
         n8BWFWT9rCmoQhmnuk9BTZVvx1alRW3rz5ZegpzQY3cpMX/cITS85oLjGOniJauM7IK3
         oK/r8kq5TJdAWCPUtZLGEvjGwnQs8C1iy4eA6r1HWyz2dPBbh6AXcM9y82w51WR+k1sW
         95tpP3509pq+Jf7owMPIDrXgTJozXk/bZBZNR9A70VVN8Z8j6PQd4QofQvVrKxZpjr+d
         fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781547457; x=1782152257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg79I+eDMuiCz9MTqJG6oHB/zH6pZAuqO5T6OdaSbFg=;
        b=G0gqIk8/yU8hfNb9TgEP2E5CF7TptTqtedI9bbaJCVxz/c/QcWjOE9xZ3DU1OEvoww
         YvjHIZ/PV8PawWV+aF68maBVec0LNptGN5hFQJeAV1tVxLpoKKX1JJ+NAmHDv923if/O
         R8QwpUrRL/T6O9dyzMzeFEl6Bf+yGxkNnXZm8zlBQCVkzRrpKQL4q2HOVM45KdgIOGQl
         muyIU9ma0CWLVFM7RQD6AG/QtZtiQkddIpjvcNYMjQXagtxsnAoimfqRz5vWvL9AWvDu
         awYek8kJZFqF5CsSBVTkAfslt0zEMlX4GK4gO4JoOuOHyNwuqSy941WShgMBMOCu1Suy
         A7GQ==
X-Gm-Message-State: AOJu0YzM9H/+xkF7YnJtmkeqIej2JA6GijNaa7yr5PzfgFcNfIqcZMbk
	2ZtOCjAc9iP30dqtt1kOvnr6nvk2vqdf3hhNZDo6d6vMauRQP7xECMsK
X-Gm-Gg: Acq92OHBY8po9laDckJgaKgaUk0FR4Cif5HGz/8OsBHc8Cp9/bpvI4TZknw2vOf5ztN
	fiaqhiboHbNdH1bcoDvybwWysI4pywO0EnqlmvBA0I/Y5jDyngtZIvsiG7MnP2RKLsIQBT94Tir
	vDwzrSVTsTp4T3xVVdGvvagsczXosvncOWHN81OLBq9KcN0IZGgUmq4O+PPlmSsj2RhICK00LGj
	lJ7hZR0kvoJ7ALaI49A4Vr3wlie04lP/7Nm7XLPP49pOvjAI538CcZ0pFR7ENcVnk00sUzbJ03Y
	I9TAAIhiY8xWp75XWa4/gF6QWRY+bNXUiDI+DD3fbvISXh44Sq3lZ+9UdjM218rhmb/HaXcCBkR
	mzLYyro7F5FstxIJ1x/Czlta7Kpx2MnQkau8/y5K56rnBo0C/gJ6CjS/sfLNs5MKxrDkc2mOOZl
	JoNxdl1SV/G6serYNY
X-Received: by 2002:a05:6820:f033:b0:69d:9547:c961 with SMTP id 006d021491bc7-69edc637545mr9078916eaf.22.1781547457113;
        Mon, 15 Jun 2026 11:17:37 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69f00d232e1sm3466478eaf.6.2026.06.15.11.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 11:17:36 -0700 (PDT)
Date: Mon, 15 Jun 2026 13:17:33 -0500
From: Justin Tobler <jltobler@gmail.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, a3205153416@gmail.com, gitster@pobox.com, 
	kumarayushjha123@gmail.com, lucasseikioshiro@gmail.com, phillip.wood@dunelm.org.uk, 
	sandals@crustytoothpaste.net, kristofferhaugsbakk@fastmail.com
Subject: Re: [GSoC Patch v4 3/4] repo: add path.commondir with absolute and
 relative suffix formatting
Message-ID: <ajAz5izOU1FSVrKW@denethor>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-1-jayatheerthkulkarni2005@gmail.com>
 <20260615045112.50686-4-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615045112.50686-4-jayatheerthkulkarni2005@gmail.com>

On 26/06/15 10:21AM, K Jayatheerth wrote:
> Scripts working with worktree setups need a reliable way to discover
> the common directory, which diverges from the git directory when
> multiple worktrees are in use. There is no way to retrieve this path
> from git repo info today.
> 
> Introduce path.commondir.absolute and path.commondir.relative keys.
> Exposing explicit format variants rather than a single key with a
> default avoids ambiguity for scripts that require predictable output.
> 
> Add a test helper test_repo_info_path that creates isolated
> repositories per test case to prevent state leaks, captures the repo
> root before changing directories to avoid eval, and accepts an optional
> init_command to cover environment variable overrides such as
> GIT_COMMON_DIR and GIT_DIR.

I'm not sure this last paragraph in the log message provides much value.
To me it's a bit verbose and focuses mostly on what the test helper is
doing. Maybe we can just omit this section? If we want to have a note
though maybe we could say something like:

  Each path key is expected to have an absolute and relative form. To
  reduce duplication, a test_repo_info_path helper function is
  introduced to configure and exercise both cases.

> Mentored-by: Justin Tobler <jltobler@gmail.com>
> Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
[snip]
> diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
> index 39bb77dda0..0c0228687f 100755
> --- a/t/t1900-repo-info.sh
> +++ b/t/t1900-repo-info.sh
> @@ -155,4 +155,65 @@ test_expect_success 'git repo info -h shows only repo info usage' '
>  	test_grep ! "git repo structure" actual
>  '
>  
> +# Helper function to test path keys in both absolute and relative formats.
> +# $1: label for the test
> +# $2: field_name (e.g., commondir)
> +# $3: unique repo name for isolation
> +# $4: expect_absolute (suffix appended to repo root)
> +# $5: expect_relative (the relative path string expected)
> +# $6: init_command (extra setup like exporting env vars)
> +test_repo_info_path () {
> +	label=$1
> +	field_name=$2
> +	repo_name=$3
> +	expect_absolute_suffix=$4
> +	expect_relative=$5
> +	init_command=$6

I may be overthinking it, but I can't help but feel this test helper is
overly complicated. I wonder if we can simlify and reduce the number of
arguments. For example, could we programatically construct the label
from the field name and init_command instead of explicitly passing it?

> +	absolute_root="$repo_name-absolute"
> +	relative_root="$repo_name-relative"
> +
> +	test_expect_success "setup: $label" '
> +		git init "$absolute_root" &&
> +		git init "$relative_root" &&
> +		mkdir -p "$absolute_root/sub" "$relative_root/sub"
> +	'

Do really need this setup test case? Could we instead embed the setup in
both test cases below? Something like:

	test_when_finished rm -rf repo &&
	git init repo &&
	(
	  mkdir repo/sub &&
	  cd repo/sub &&
	  ...
	)

With something like this, each test case is responsible to creating its
own repo and cleaning it up when finished. Then we could avoid have to
provide a separate repo name for each set of test cases and remove the
repo_name argument.

> +	test_expect_success "absolute: $label" '
> +		(
> +			cd "$absolute_root/sub" &&
> +			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
> +			eval "$init_command" &&
> +			expect_path="$ROOT${expect_absolute_suffix:+/$expect_absolute_suffix}" &&
> +			echo "path.$field_name.absolute=$expect_path" >expect &&
> +			git repo info "path.$field_name.absolute" >actual &&
> +			test_cmp expect actual
> +		)
> +	'
> +
> +	test_expect_success "relative: $label" '
> +		(
> +			cd "$relative_root/sub" &&
> +			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
> +			eval "$init_command" &&
> +			echo "path.$field_name.relative=$expect_relative" >expect &&
> +			git repo info "path.$field_name.relative" >actual &&
> +			test_cmp expect actual
> +		)
> +	'
> +}
> +
> +test_repo_info_path 'commondir standard' 'commondir' 'commondir-std' \
> +	'.git' '../.git'
> +
> +test_repo_info_path 'commondir with GIT_COMMON_DIR and GIT_DIR' 'commondir' \
> +	'commondir-envs' 'custom-common' '../custom-common' \
> +	'GIT_COMMON_DIR="$ROOT/custom-common" && export GIT_COMMON_DIR &&
> +	 GIT_DIR="../.git" && export GIT_DIR &&
> +	 git init --bare "$ROOT/custom-common"'
> +
> +test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
> +	'commondir-only-gitdir' '.git' '../.git' \

For each of these test cases, the `expect_absolute_suffix` and
`expect_relative` and exactly the same. This also appears to be the case
for the test cases in the next patch. Do these really need to be
configurable at all? Can we just embed them directly in each test case
assertion? Or maybe future keys will need this to be configurable?

> +	'GIT_DIR="../.git" && export GIT_DIR'
> +
>  test_done

Overall the rest of the patch looks good to me.

-Justin
