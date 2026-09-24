Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEDD445ADB
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242939; cv=none; b=N+vRZy+j7yxZ9s9WcrxBD6Ichy4amj+Qj0+S2Nr8NAeeBKs1355oKVPK93R3gFL343mFf0reb6r4LhhgBV8LRJS6wd5eizpEkR7JaxpD7qmpu/IjNm8rjzdkzbysOvaoJ3shCv6jM6EmkBBR+3FOe1ZemxnUVTewiDLZN8G8+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242939; c=relaxed/simple;
	bh=qQHhpEw8ohzofKsQvGJERAl2jPlSIhfmhIh3LzExWPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdLow3X7PD7SEfRBnfFwB48ZGawTbsPxRYMff863Jkpzo/1LnAoixPnBtnUpfU7K9+8TWHCGq0uD/2+fFtzK9HZCP1cp15l3VjY0o7qXEuqu9GDEKm9TLCyf6Rq3oox8xjd2enw8SG89cJwjtCmQJcpJ7uw+e3m943lC9rkhE60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaWUH8jZ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaWUH8jZ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f5603a0so268096466b.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 02:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242933; x=1790847733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pU1YNckz6aK+QIYa0G5Tcw1CD9q+eauaeG0UzgHNIac=;
        b=LaWUH8jZhGGTOvz6I5y0O3qLdj3nYSnuGjH3u3aYiyESowlzKRxbKfcJ+aFfOdTLuH
         MlUkegMpWqoIx4gjwVdvPwWaGW1Q4r5IYftfU7OXmBhLVoCvOVx41/MKN2QGVJq3UIz9
         02/dUYZk6yi/nGb1OAzwsHKUl+7YSjEB+csDhOzenLZy7ct9LJh1STtESzCBvFoBERv8
         ez4YYI6g6F5FvhZKzNCN9W0ymnPb5XaM0JUTMX+YiT2UFMHiWBzJoVa5cuRweRbIlRM0
         y45yrgUxYPMPrqc0BD8DZe9NQJpTfdzT0OjfpHYSP71l62rWBc8wPeb7HYrJkWnL7VDW
         HNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242933; x=1790847733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pU1YNckz6aK+QIYa0G5Tcw1CD9q+eauaeG0UzgHNIac=;
        b=qTtk2DRWXU7/TirOhmd5sSTk1fSDvTKRwXaBoZGkpDWLyz0RRx4fDlmMC4aziqxXPJ
         cb3GwmxuTsLmzdC/D91TAeGrKRg7ZcG6A5uSFKNxXBipwD6PaGlKTa5iqwk7tW0UYcG8
         ayHkkXQuYaYCDraSNHJbqy7vrDeV/XAHjVBxmuOzNLmKZKEidxDS4SuAvxI+FfzFeF4R
         CF1gBtGr4XwK++eRwxl/6ArKQ498D9p/bRgN1EUuOXUIF7ahch050gJr+xViAgALiqAI
         mW+v1Jp7St9numWmvFJLcAQbAY0exEETl1+1Gn2j3k1Y6NRBziUSNCvFU23yiD5ya5nQ
         YNDA==
X-Forwarded-Encrypted: i=1; AKwUvBy9vCGUbUxmx/fa77ula66EphgCcaDNccjsZp54Be8Zo9paaSjmBGazYYNrAJ3XA89PkpI=@vger.kernel.org
X-Gm-Message-State: AFuF++kJNKKC3C7llx73OO83mOP0bWlAY3IdawynS78XtrDMD7GIhh9r
	C9Cm6lQTyFFDV+XP/cHkdCypCkkeYaxrl7lRq0oVWG8UuQv4m04TGDafxu1aSIS1
X-Gm-Gg: AYBFou0eCWLvCvCOLaGYIe+dR5jQkrOFCDvellK6fh68MkGtkdkLoc8TCybRCReIQly
	YoQ1MywNfMjk/jkypyGUfZ9HZS9Y2dHub+D+o9chCc6nrgEyUcIpLd8AWgCZMZRs1DAUBJZ52uj
	paEm4YR47IfwfOupL/3UsDp2onVS+ZLmOPTkLSOxq5zoEeZ7X2o8NtYxQOzK+r8nyyB7qHNX2IL
	5VBBH8RailV7PmrKr1zddDN8zcdJqprV6e+7RwgP9joTBUj43o8jzB4iWmetO7ClUsQUmQ2Q2AC
	nB2vh/nMnOWSpvsQqtJZ+Efz0dvZwx6WsPebBtyQBod2lxD6CV9W2lUq/3EdvMzF+IAjX+eM/pX
	X10FQ4YEpgDDirhOBNBb7JoROMsgLt9UM0KYEI1aPiMbfYdXs6jhSxEs/kRc1+T8fE07ziuDGyV
	e5R6CX/7yXtJ06YEKXBMj9EWs6PHei+vNVz3O5zaKGF+3a2sPIAeTNdzNKagdU1dzGGYGc+yKwI
	xqar/kn8+UCExbdIPG2ZVF7FLDDzgGDdxiuygz5sp6e2m7uLs0H9Zk=
X-Received: by 2002:a17:907:1c84:b0:c26:2f09:f2d8 with SMTP id a640c23a62f3a-c2ac2601042mr156935666b.36.1790242932903;
        Thu, 24 Sep 2026 02:42:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6ecd17sm271523566b.63.2026.09.24.02.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:42:12 -0700 (PDT)
Message-ID: <68e83baa-6ccb-4ca8-a1df-f09d51749c67@gmail.com>
Date: Thu, 24 Sep 2026 10:42:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Cc: Eli Barzilay <eli@barzilay.org>, Phillip Wood
 <phillip.wood@dunelm.org.uk>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Adam Johnson <me@adamj.eu>,
 Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>,
 Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?=
 =?UTF-8?Q?mason?= <avarab@gmail.com>
References: <cover.1789853192.git.ben.knoble@gmail.com>
 <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

I've spotted a memory leak that I missed last time, apart from that this 
looks good.

On 23/09/2026 13:58, D. Ben Knoble wrote:
> @@ -671,29 +627,27 @@ static enum stash_apply_result do_apply_stash(const char *prefix,
>   		    oideq(&c_tree, &info->i_tree)) {
>   			has_index = 0;
>   		} else {
> -			struct strbuf out = STRBUF_INIT;
> +			struct merge_result result = { 0 };
>   
> -			if (diff_tree_binary(&out, &info->w_commit)) {
> -				strbuf_release(&out);
> -				return error(_("could not generate diff %s^!."),
> -					     oid_to_hex(&info->w_commit));
> -			}
> +			o.branch1 = "Upstream index";

This is the current index, calling it "upstream" is a bit confusing to 
me but that's not worth a re-roll on its own.

> +			o.branch2 = "Stashed index changes";
> +			o.ancestor = "Stash base";
>   
> -			ret = apply_cached(&out);
> -			strbuf_release(&out);
> -			if (ret)
> +			o.verbosity = 0;
> +
> +			head = lookup_tree(o.repo, &c_tree);
> +			merge = lookup_tree(o.repo, &info->i_tree);
> +			merge_base = lookup_tree(o.repo, &info->b_tree);
> +
> +			merge_incore_nonrecursive(&o, head, merge, merge_base,
> +						  &result);
> +
> +			if (!result.clean)
>   				return error(_("conflicts in index. "
>   					       "Try without --index."));

Sorry, I missed this last time, but we should finalize the merge before 
returning to ensure the allocations in result are freed.
Everything else looks fine.

Thanks

Phillip

> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
> -			if (write_index_as_tree(&index_tree, the_repository->index,
> -						repo_get_index_file(the_repository), 0, NULL))
> -				return error(_("could not save index tree"));
> -
> -			reset_head();
> -			discard_index(the_repository->index);
> -			repo_read_index(the_repository);
> +			oidcpy(&index_tree, &result.tree->object.oid);
> +			merge_finalize(&o, &result);
>   		}
>   	}
>   
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> index 64fe21717d..8f6109fb91 100755
> --- a/t/t7600-merge.sh
> +++ b/t/t7600-merge.sh
> @@ -801,6 +801,15 @@ verify_no_mergehead () {
>   	test_cmp result.1-5 file
>   '
>   
> +test_expect_success 'fast-forward merge with --autostash, stash.index' '
> +	git reset --hard c0 &&
> +	git stash clear &&
> +	echo staged >>z && git add z &&
> +	git -c stash.index=true merge --autostash c1 2>err &&
> +	test_grep "Applied autostash." err &&
> +	test_stdout_line_count = 0 git stash list
> +'
> +
>   test_expect_success 'failed fast-forward merge with --autostash' '
>   	git reset --hard c0 &&
>   	git merge-file file file.orig file.5 &&

