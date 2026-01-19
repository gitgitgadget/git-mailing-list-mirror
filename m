Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E152D0C68
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842289; cv=none; b=VmH9G+HJSTuXJ81yHK54Wtg6uJt/aP+j0iYkzbo0zsncHdwJFeT3dzTzvUwsjj5NendMXQzhlwV2xMc5y43hMB09VhmHSBgsVbFyIwqTKSLGEorpiiZj0C8XSLklYELivywKDmsg5XIXpe+VPD9a+zqDtLuKSqf+EG718ZyL+Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842289; c=relaxed/simple;
	bh=Rjvl7vdNUuueDxLDSeb5/4sJQYN7SnfckeJ5uaeCerk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFdZ1f9a7UU1bGlUqPLKnpiz5UJkzBeaoH+nZl22d9FWUdVKz7oEHh3/MZ/8pYrd7kEW8yGnMOwpRbhMoKeeaywLFNlzfvn7UXruq1CHmmGUqDQoH3F98i5pE6dGODUt8Pam7qfZxENDX/Bu9C8SZYYgEKA0uldKI9RbfDdCtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHD66IDy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHD66IDy"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50146483bf9so59791621cf.3
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768842287; x=1769447087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H74jj8sP9vfGz1UQ8dIWGmPq8Q7CNvsbcwFxkbLlBmY=;
        b=RHD66IDyuqoF2obQ0dcyxEa9FC7cL5BoAESurs7i1M7UYKMM5L3k892izJz6AJal2+
         Dohv6vc/ROYjOnDf3EiSX91qWCWXTebZNjrOqTBgkEE5do/yhQtAveKNEfuEBIbA8Nl1
         0PTKtfuLEve7RA9So8bBEWGGnOu+Xj07tjFbyDmvnb2+v65qffivpj+Dgelt+qNnDAR9
         IYsEgd3H8y/N4spfTqA58GFPeLeE/GwdEIyr3JaRDbt/17m86eaWfekJu/5VJHyiCpB8
         9kkWXDDy644nnoptUtVyfp3odYPwNWmNVivXMribZUnc2s0PfsdIJ5PTEJpPmp7Usi/v
         V5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768842287; x=1769447087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H74jj8sP9vfGz1UQ8dIWGmPq8Q7CNvsbcwFxkbLlBmY=;
        b=L1af6uLNjmKcVb3b+0TbaLPmFyI5EyQpAVbd/gYiUZ6ujNoShIHaxdm0T9gIYB8pRm
         D6C53UJwgHJ0Znfs2s9NTZqVPliXBJj9t8X3vWZhPD0NXjuDGv0aVF8Ecs1d3Amf0w/6
         ZQURSOVoVrX6iDWPuRWm4K4QHBOz1S8SWSp+1ugEEFhEb2HyNGReYVTyVz3Y7L1r+B7P
         IfGxyS7w7T6pT3FgkLm9zCkwvIhXSIWxPzfgHkejmlTEzQhIhm2wwx+XpMeig7DD9Ujp
         Vp6HVbVO83WhzQiYqaw4SgX+SVPGnn1PadZf4ohvT8IHm9XXVBaLTrzZBnh00sghTQXO
         FV6A==
X-Forwarded-Encrypted: i=1; AJvYcCU7AOQXzap0/IsyjNqCxE9qLj+2o2YGY4m8zEUTZMVrorMmQKXYhN0kkQUDKz8BiTrABCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLjkE5ig0FsPlQa3UuHiHoS1CfUa7jgtjZXuPP/903k+aLRTQf
	X34smji/aAlB9SaQlo1Gft/8MC4022UlL4bkH8rhfGPix+4a12HnKBk3
X-Gm-Gg: AY/fxX4A+tGfoOjdh4AW7gSj40ri1pYfI1Mz+YoOqFRZ+ugFyfankRYGJcNcWeLiyFA
	wqu8tHnO/z+JwpeazKVvkErIzPkfofZwWCVBY9j9240dd7+IAYuy27T3tyoTldcdvivplndJc0p
	1ROabkHVF0qUjJ6NfUBfkj8+EheLg/z29rP/kYnzPG3fpNTqeUUYe/Wk/FpAz7H84J4XkMdjMSy
	wWl8bjhfLHbWWJ1xyrfF30au+SRoYWmJPipTfXrLs40umzGlHH9Ht5TBfcWGPQGJkzz7pMe/Dy7
	uiAhdH1Uo97TbcmEPZeGezGMux7JuRd+M2v1JOE2hKAEetTIV3fsV3sbIa8xcaDkXX4jEFgIlB/
	DcJLVkVG1nXYZL8sc3TXA0yIX3x4RQM6C4Ea5yTHoRIFkgIYEtR9UbbQASLJSzzG8mmmsmDVeEr
	jz8e+nLWUgU49ua6UMDBLM+HJff1g9AFdz+GHDxFp8zJLjtaid2OKKuyeOVb9uHhLeJNnl
X-Received: by 2002:ac8:5f11:0:b0:4ed:bb39:9a63 with SMTP id d75a77b69052e-502a16b3a5bmr190881041cf.39.1768842286414;
        Mon, 19 Jan 2026 09:04:46 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e6c6e87sm88854066d6.38.2026.01.19.09.04.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 09:04:45 -0800 (PST)
Message-ID: <36b50d7d-b9f4-4ff3-b00e-9c98ad690749@gmail.com>
Date: Mon, 19 Jan 2026 12:04:45 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sparse-checkout: optimize string_list construction
To: amisha <amishhhaaaa@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <20260114192803.4852-1-amishhhaaaa@gmail.com>
 <20260119123339.48435-1-amishhhaaaa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260119123339.48435-1-amishhhaaaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/19/2026 7:33 AM, amisha wrote:
> From: Amisha Chhajed <amishhhaaaa@gmail.com>
> 
> Improve O(n^2) complexity to O(n log n) while building a sorted
> 'string_list' by constructing it unsorted then sorting it
> followed by removing duplicates.
> 
> Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> ---
>  builtin/sparse-checkout.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 15d51e60a8..7dfb276bf0 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>  
>  		hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, ent) {
>  			/* pe->pattern starts with "/", skip it */
> -			string_list_insert(&sl, pe->pattern + 1);
> +			string_list_append(&sl, pe->pattern + 1);
>  		}
>  
>  		string_list_sort(&sl);
> +		string_list_remove_duplicates(&sl, 0);

Shouldn't this line be added in the other uses of string_list_append()?

>  
>  		for (i = 0; i < sl.nr; i++) {
>  			quote_c_style(sl.items[i].string, NULL, stdout, 0);
> @@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>  		if (!hashmap_contains_parent(&pl->recursive_hashmap,
>  					     pe->pattern,
>  					     &parent_pattern))
> -			string_list_insert(&sl, pe->pattern);
> +			string_list_append(&sl, pe->pattern);
>  	}
> 
>  	string_list_sort(&sl);
Actually, there is a string_list_remove_duplicates() just
outside of the context of this diff. 

> @@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
>  		if (!hashmap_contains_parent(&pl->recursive_hashmap,
>  					     pe->pattern,
>  					     &parent_pattern))
> -			string_list_insert(&sl, pe->pattern);
> +			string_list_append(&sl, pe->pattern);
>  	}
>  
>  	strbuf_release(&parent_pattern);

Same here.

This diff looks good, but I do believe it would be good to include your
duplicate test here instead of in a second patch.

Also, the way your second patch appeared as a trailer of your first patch,
so it didn't appear properly as a thread in my email client. Here it is
for review:

> From b20a99f0773bab063a31eea6fead730e18200ca7 Mon Sep 17 00:00:00 2001
> From: Amisha Chhajed <amishhhaaaa@gmail.com>
> Date: Mon, 19 Jan 2026 00:20:47 +0530
> Subject: [PATCH v5 2/2] t1091: Add tests for deduplication of cone-mode sparse
>  patterns

nit: this title is a little long and has incorrect capitalization. Take
note for later, since I expect this diff to be squashed into the previous
patch.

> +test_expect_success 'sparse-checkout deduplicates repeated cone patterns' '
> +    rm -f repo/.git/info/sparse-checkout &&
> +    git -C repo sparse-checkout init --cone &&
> +    git -C repo sparse-checkout add --stdin <<-\EOF &&
> +	/foo/
> +	/bar/
> +	/foo/
> +	EOF

This slashes are redundant for cone-mode patterns. I recommend a more
interesting case, such as

	foo/bar/baz
	a/b/c
	foo/bar/baz
	a/b

This should remove the duplicates foo/bar/baz during the run, but also it
should notice that a/b/c is contained within the recursive set defined by
a/b.

The resulting sparse-checkout file should have lines such as

	/*
	!/*/
	/a/
	!/a/*/
	/a/b
	/foo
	!/foo/*/
	/foo/bar
	!/foo/bar/*/
	/foo/bar/baz

The order might be different, but this is what I recall from how nested
directories work in cone mode.

> +    cat >expect <<-\EOF &&
> +	/*
> +	!/*/
> +	/bar/
> +	/foo/
> +	EOF
> +    test_cmp expect repo/.git/info/sparse-checkout
> +'

> +test_expect_success 'sparse-checkout list deduplicates repeated cone patterns' '
> +    rm -f repo/.git/info/sparse-checkout &&
> +    git -C repo sparse-checkout init --cone &&
> +    git -C repo sparse-checkout add --stdin <<-\EOF &&
> +	/foo/
> +	/bar/
> +	/foo/
> +	EOF
> +    git -C repo sparse-checkout list >actual &&
> +    cat >expect <<-\EOF &&
> +	bar
> +	foo
> +	EOF
> +    test_cmp expect actual
> +'

This does lead to an interesting case where the 'list' command was only
interacting with the sparse-checkout file, which wouldn't have duplicates
if it was modified by the user in cone mode.

Keep in mind that you're not actually testing the 'list' command, because
the 'add' command already deduplicated. You'll need to modify the
sparse-checkout file itself to get an interesting test of the 'list'
command.

When not in cone mode, we should not be removing duplicates because the
order of the patterns matters and we should not be reordering them. I'm
not sure if that's relevant but it's something to keep in mind while you're
testing, since the command will revert to non-cone mode if the
sparse-checkout file doesn't match the cone mode pattern expectations.

Thanks,
-Stolee
