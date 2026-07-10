Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE0F136358
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783696726; cv=none; b=URyhLANBJtPww4mt0dmyG7GSjE8auq/dmRdc2RUnjiIRsKbmkxFRw+o1syu4ukYHQu0KKdpcwhGkUQ+ujnuch1fP2LjkApvSPO9b1GxDkkEqk75BIER8CW+azCzRb4Q4s0D+DLpuy81zxX0cyqdyIzbu+xWwnx22hITIREJXL/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783696726; c=relaxed/simple;
	bh=BoiWUKQvJW+gG/pFAB1zZFyOB9WKAPG+s88ymIHjsJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CafgGcXEiO8CePJPYF5jYVl64J5fmxUDH38TzPPg46VzOp0vCoOyqaUV4HLAlwtDmjNtdnQIF6YzQrScwAqkoDc+DDxYU6sYdvuoL0FxL8Lg34isDoEC/BsJyMDmkSjwU87/2xIpreGN3TcyxeU2DR0T2t+U3v0dLJE7V79+0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7IcTD3K; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7IcTD3K"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-698aa8d4dafso1083127a12.0
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783696723; x=1784301523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:reply-to
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TSduWjqUDnlO9oJjtglAsNd2gzUvyYScjyHvYQT5mok=;
        b=O7IcTD3KJLvJLRwZfVAC4gTKb8UV7eS214onj8bvPXJkodF3z+q5Gn/cmiMGZUAzjL
         k+QrjacQ9xqjMiRnlkKgTy0Aqxwz8xQXV3nZO6eLejacIKn4keY/OH9oWd/9rt9bganp
         isiYMLieTX7tkQ7SI6tfzxLCHRtYwz93IuCO2xAkScx+yQlGtdl/ZRb9rgKacWxww8bp
         ASIBIDcZKXcCf81Xo9m/emV1EUVIzTIfVqQ0duBwpunkvtiwzGB2oRZnl+6ycZOQh/TA
         8LiXiy7bAHGLZZWJzUfy0TFKkq1036U3IPjbT3yDGjLs7TYXHiPSn66Y8kbeOtG1ruzb
         rjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783696723; x=1784301523;
        h=content-transfer-encoding:content-type:in-reply-to:reply-to
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TSduWjqUDnlO9oJjtglAsNd2gzUvyYScjyHvYQT5mok=;
        b=POzFpXutrZm+behwNq9HGWvN7lpGqvNwrEiQPLXwMYUPAbFo2Qa08hmxz9dFz2M6Mb
         Y0vBNCtUFPoh8g4Bpw9DcrshXZ5GdBHcz+iuD+1aH5o0hsS6e0jp9FdQQAwRj4iaeeZH
         GJvYzKB+xXLsV5kqQ6TdHWxbSnbcsHYPURzN8/FuHn2M65sZyzZkGZAtlye+ossMSXpz
         13aVmQ1iijIWcTYI4+Fs3uR1AUj0DOk30/KYJFE0gQ3QcJ99iN+UQSl+rt2fvILfXOR5
         dr2JIfpvTf3oOAHviXp5TzcB7p3gmSqQF1If9+cfSMqUoIdeQkfN2k57Yg6otuUAPe4G
         Vz6w==
X-Forwarded-Encrypted: i=1; AHgh+Rr90kzjH+5f4ho5n9BzNHhhf43bkqv1KBKjFB8WvKR+YR5LVdMMGlLRdLN5lL6jND1nulA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbOYdTvdNXj+flxfRK79F3VPr1vD51Na+xzaeaRabrYxISFT4
	WkemtBP6sGXLQ+f2nLkiQBBnrTYjX30q9+vlbUQf3bq+DtO/vVfUbh5e
X-Gm-Gg: AfdE7ck5DwUDHfGTgGrPGTjhu/z4MK+/Y2Q/qCphvvQF3lGoc9eOwLwNRLr3XJBubXW
	XOGnmjUHPzfHnvYOPbv3zOOsXxMBLcXxKB3GpSlVZh3GukqBa/TEg5QDlMd/ZT4H38cJdIuyjFH
	TOnKwKCNT5nSCUaqErcQMirqUe+lgYKclB3mT5UHR06krG2b2tPSyvUCdzK7sWaw0vDxPrgeYVO
	jv5/SqwE9dvy6gwlHG764bmN0wItLt7djQ3AdEmjL7lW+1YtsL7YS18hlGNDjpU0nuLzOv6Jv/a
	cYKl3QP7DdwtusPxCbPhydrz5ges2INP189bNGInFhHGMcxTEaM2yxI3RJIO9/FkJZe+6uDfmni
	nGEEezEvApVyq5E9Dgehr6Xu6cK+8j+VDBn4+eKjTutOG00sNufCYJC470kEUnqfD8P+qyN7oKK
	cDZfObkHW6jjDzElIA9fol5HwO7YfsYfMOmFK+xYx0s5Njucc4a1obr/Vw9K6HgOka21hIyBXr6
	n+jVg==
X-Received: by 2002:a05:6402:e85:b0:698:81d7:b576 with SMTP id 4fb4d7f45d1cf-69ab4472359mr4546802a12.10.1783696722591;
        Fri, 10 Jul 2026 08:18:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c5e29b061sm82358a12.19.2026.07.10.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 08:18:42 -0700 (PDT)
Message-ID: <8ee46e33-4eb8-4e01-800a-82cc7cefa3f9@gmail.com>
Date: Fri, 10 Jul 2026 16:18:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 1/7] branch: add --forked filter for --list mode
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Johannes Sixt <j6t@kdbg.org>, Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2285.v17.git.git.1782113388.gitgitgadget@gmail.com>
 <pull.2285.v18.git.git.1782338106.gitgitgadget@gmail.com>
 <3e29ff17bd703d8333c2d65d36b15c69ddfc2ab9.1782338106.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Reply-To: phillip.wood@dunelm.org.uk
In-Reply-To: <3e29ff17bd703d8333c2d65d36b15c69ddfc2ab9.1782338106.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 24/06/2026 22:55, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> Add a --forked option to "git branch" list mode that lists only
> branches whose configured upstream matches <branch>. The argument
> can be a ref (e.g. "origin/main", "master"), a remote name like
> "origin" for the branch its origin/HEAD points at, or a shell glob
> (e.g. "origin/*"), and may be repeated to widen the filter.
> 
> It is an ordinary list filter, so it combines with the others:
> 
>      git branch --merged origin/main --forked 'origin/*'
> 
> lists branches forked from origin that are already merged into
> origin/main, and --no-merged inverts the question.
> 
> This is the building block for --delete-merged, which deletes the
> listed branches once they have landed on their upstream.

The implementation looks good, I've left a couple of small comments on 
the tests. One thought I had was whether we want a mode which recurses 
so that if the upstream of topic2 is topic1 which has an upstream of 
origin/main --forked=recurse origin/main would list topic1 and topic2. 
So long as we don't think that is a sensible default we can add it in 
the future if we want.


> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e7829c2c4b..3104c555f6 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1717,4 +1717,126 @@ test_expect_success 'errors if given a bad branch name' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success '--forked: setup' '
> +	test_create_repo forked-upstream &&
> +	(
> +		cd forked-upstream &&
> +		test_commit base &&
> +		git branch one base &&
> +		git branch two base
> +	) &&
> +
> +	test_create_repo forked-other &&
> +	(
> +		cd forked-other &&
> +		test_commit other-base &&
> +		git branch foreign other-base
> +	) &&
> +
> +	git clone forked-upstream forked &&
> +	(
> +		cd forked &&
> +		git remote add -f other ../forked-other &&
> +		git remote set-head origin one &&

This is a bit strange because it does not match HEAD in the remote 
repository but it is necessary for '--forked <remote> uses the branch 
<remote>/HEAD'. I wonder if that test could be written to use main 
instead but I guess this doesn't do any harm.

> +		git branch local-base &&
> +		git branch --track local-one origin/one &&
> +		git branch --track local-two origin/two &&
> +		git branch --track local-foreign other/foreign &&
> +		git branch --track local-onbase local-base &&
> +
> +		git checkout local-one &&
> +		test_commit --no-tag local-one-work local-one.t &&
> +		git checkout local-foreign &&
> +		test_commit --no-tag local-foreign-work local-foreign.t &&
> +		git checkout --detach

Why do we need a detached HEAD?

> [...]
> +test_expect_success '--forked composes with --no-merged' '
> +	test_when_finished "git -C forked checkout --detach" &&
> +	git -C forked checkout local-one &&
> +	test_commit -C forked local-only &&

The branch "local-one" already has a local commit so why do we need this?

> +	git -C forked branch --forked "origin/*" --no-merged origin/one \
> +		--format="%(refname:short)" >actual &&
> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked rejects unknown branch/pattern' '
> +	test_must_fail git -C forked branch --forked nope 2>err &&
> +	test_grep "not a valid branch or pattern" err
> +'
> +
> +test_expect_success '--forked requires a value' '
> +	test_must_fail git -C forked branch --forked 2>err &&
> +	test_grep "requires a value" err
> +'

It is a bit odd to have these two tests in the middle of the ones that 
check the functionality works.

> +test_expect_success '--forked <remote> uses the branch <remote>/HEAD points at' '
> +	git -C forked branch --forked origin --format="%(refname:short)" >actual &&
> +	echo local-one >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--forked narrows a <pattern> argument' '
> +	git -C forked branch --forked "origin/*" "local-*" \
> +		--format="%(refname:short)" >actual &&
> +	cat >expect <<-\EOF &&
> +	local-one
> +	local-two
> +	EOF
> +	test_cmp expect actual
> +'
This is looking good

Thanks

Phillip
