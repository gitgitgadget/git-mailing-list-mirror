Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF153630BA
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615551; cv=none; b=cFcL3zyoymUX7ZX3sZdJxMewLCPbgb+2175Es6xCyHypGI5vhrNSd/OyzTuc8bUy3qfmWovtXXh9I4XwYnAra+otJwEBQjQLxCI+ImLx5zj8F/quwWT0j6UI+lR23VKZT12/pVE0sY9+6K4fGIzKgC9Q34uaM0i0/iGDs8pWyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615551; c=relaxed/simple;
	bh=e3LEQupwnKN5u7O9yvHWdBFD4zseGzOukEeYT4HyhwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gDOmAklQ+FLMiR+VtXenYlKFvixnrfuXMXaJsAbJc4/AXo/NwGjWt/UgFiR+hscKzNUV7Ef3wZl0K23seCuTwaCGBCroaBJMucvVqvARHx+52hMwOY96+t4ySDnQWan9UjX+/vhhcoZ3jx/cQS9xWMSbPy6z0Oj3PjIFn1a2Ygk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbRTeZIH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbRTeZIH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2b9bfa02so576550066b.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781615549; x=1782220349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAUy35sHhZI69ba3aNXWSdG0t3Pp8TX/0PFeNubXUMk=;
        b=KbRTeZIH6gOu6qM4D+X4bJcYfsz/iRw8hoBHeH8O07W1DWZrOzutqqqt8PdQ5eDoSk
         Cv0waJ1kd4N/F1rmxFvFlUyyxWsSsefGzVGNPRVAcJtrporyNwjL6ZbYAjXQNI0IjxiA
         ldLD9HG1F+O2x4NkeJT8mwrdhad3YZeMyxNMXKKNXMsoZzVKGanXNVQJHQdlUIzH2Sah
         PQkF7sPpVG0cNsWMaqmuPfOGYkGtAFl0uxtTlGY7ajXGxBdsd1eUhyBRYehEvFNPblVs
         vCfBm7sj9JjCWdeDF6fp17jtUp/ll/bNJS007wP7e8j3tT16ldUe/wPB26JJ1a3oa+xp
         ZJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615549; x=1782220349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MAUy35sHhZI69ba3aNXWSdG0t3Pp8TX/0PFeNubXUMk=;
        b=HmS6Df6CjAdTehJeeDdoYvEqocI/0RhYXEINIlPzoidgXFRU/mwgw29yGM5KCsh/Sv
         ae8G39KDJgc23F3X+0dcihPwC/JYKAov3y6Kq8DrnZO7c2+DYcYohmIgyW60fNKK7KUI
         S86ib7Ytkt01/bnJn7itGAUoV8JkVs7ZSpgiPQoB0eg2OOgzL+m7jPtOnhko3RESVJvw
         SQgGq7/4KrKKatoCtRcwape/vCmyyuHII4TO4D58MnF9lu5OEnE0f+ra/CxiGLjahcZU
         UTwzjACnIlvYX0gaoYtO3XRjP+MHqUKTj4IHRToHlQNQKrtz1yVHN7SL3vYNv0sZIQgj
         vA8A==
X-Forwarded-Encrypted: i=1; AFNElJ+scGicMcMclzYqdyfBzNq31hu1i72cqKuTgaMB3qo8l5H7BHXfK2McOBnNww9mfj8n8Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX9R4qZallecOzMBZnDq2MNZ/5BydRNmboL9wESY9Czhm0Qbyz
	hrNE3YwjdQdI9BIngFXEeEdZPSwta3P7+QBof7gXOaq3Oix+NK2ZuukftQcj/A==
X-Gm-Gg: Acq92OFaIhQEEcPE9HBbW0JJ+ue0VisWZG8hphYEFzQkBBfvhnb7Es6YkYiRvX9m303
	ft9hFICE4tzozBiu4Ji2DRUrXN27tilmmLVG7E62ypW07/63xl5ZHgjjpObaC0Gd2lTbupnfRg6
	XKQluxzer0mGKPSg9W5vo/QfmEbjCnHPMVx8VqkEzh0/2TuWzGrWdZwLch3XVLEM3TZhkRaPVqH
	D68wCTnGOTY0W6H43CxhjLtJMJuoX0D3gkgaOcVvbPKK/w/qdpj7KE2bDc5HNCCfv6vi+DuUekI
	ZBjz53to2kTbqAqmYyYPKDeP/KXYmtwoUoSi7vGq11FzxDwOByDMA6fHqC4Xr3U3qbgcicHzrzV
	DMazZH33qg+mAno0WhxKa6uJud9DbcWS2NlDRo1o/S1wvV/MAV1EmrLDQbvp/hUEKOJsiD+rTNl
	ZnWHh+jWNC3553vIzXDoYn9cfQIWLi4ZcCDXiRl5JRo4oopn4TTWqzDIKydHUQC8HJK/7v5rmSL
	Q8che4X8rd5weCjQ96hkA==
X-Received: by 2002:a17:907:9404:b0:bd5:405c:7964 with SMTP id a640c23a62f3a-bff4c9eab9fmr827948266b.48.1781615548663;
        Tue, 16 Jun 2026 06:12:28 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6? ([2a0a:ef40:69a:b801:537b:c4f5:ba6d:96c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb51007a9sm636910666b.21.2026.06.16.06.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 06:12:27 -0700 (PDT)
Message-ID: <27938b0e-d131-4a44-95bc-c06f4513e542@gmail.com>
Date: Tue, 16 Jun 2026 14:12:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add a test about broken notes handling on rebase
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 git@vger.kernel.org
References: <20260612143952.3281115-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260612143952.3281115-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/06/2026 15:39, Uwe Kleine-König wrote:
> When a commit disappears during rebase because the patch content is
> already there (but not by the same patch in which case the commit would
> be skipped) the notes of that disappearing commit still survives and is
> added to the (rebased) parent of the disappearing commit.
> 
> So with the commit graph
> 
>   A -- B -- C
>    `
>     `-BD
> 
> where BD includes the changes done in B, when rebasing C on top of BD,
> the note for B should disappear and not be added to BD.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
> Hello,
> 
> this is a behaviour of git that really bothers me when working on big
> patch series. I use notes to track the Message-Id of the patches when I
> send them out. Then when rebasing to a newer upstream version, the
> tracking gets confused because the Message-Id notes end up on commits
> that were not sent out yet (or I got two Message-Ids in them).
> 
> I reported that already back in 2023[1],

That thread includes a suggestion on how to fix it if anyone reading 
this is interesting in working on it.

> but obviously not in a way that
> resulted in a fix. So I'm trying again with a patch that adds a failing
> test.

I'm not sure carrying this test makes it any more likely that it will be 
fixed, though your mail might get someone interested in fixing it. Don't 
we already have some relevant tests t3400 rather than adding a whole new 
file for a single test?

Thanks

Phillip

> Best regards
> Uwe
> 
> [1] https://lore.kernel.org/git/20230530092155.3zbb5uxa7eisdzxb@pengutronix.de/
> 
>   t/meson.build           |  1 +
>   t/t3322-notes-rebase.sh | 35 +++++++++++++++++++++++++++++++++++
>   2 files changed, 36 insertions(+)
>   create mode 100644 t/t3322-notes-rebase.sh
> 
> diff --git a/t/meson.build b/t/meson.build
> index c5832fee0535..6927bd9c794f 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -358,6 +358,7 @@ integration_tests = [
>     't3311-notes-merge-fanout.sh',
>     't3320-notes-merge-worktrees.sh',
>     't3321-notes-stripspace.sh',
> +  't3322-notes-rebase.sh',
>     't3400-rebase.sh',
>     't3401-rebase-and-am-rename.sh',
>     't3402-rebase-merge.sh',
> diff --git a/t/t3322-notes-rebase.sh b/t/t3322-notes-rebase.sh
> new file mode 100644
> index 000000000000..64c40a523b50
> --- /dev/null
> +++ b/t/t3322-notes-rebase.sh
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +test_description='Test notes on rebase'
> +
> +. ./test-lib.sh
> +
> +test_expect_success setup '
> +	git init &&
> +	echo A > A &&
> +	git add A &&
> +	git commit -m A &&
> +	git branch branch &&
> +	echo B > B &&
> +	git add B &&
> +	git commit -m B &&
> +	git notes add -m "This is B" @ &&
> +	echo C > C &&
> +	git add C &&
> +	git commit -m C &&
> +	git checkout branch &&
> +	echo B > B &&
> +	echo D > D &&
> +	git add B D &&
> +	git commit -m BD
> +'
> +
> +test_expect_success 'rebase B + C on top of BD' '
> +	git rebase @ master
> +'
> +
> +test_expect_failure 'assert there is no note on BD' '
> +	git notes show branch
> +'
> +
> +test_done
> 
> base-commit: 3e65291872de10c3f0bf05ea8c24187e7a71ebf0

