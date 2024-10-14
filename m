Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAF61D1E9D
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941750; cv=none; b=CIJQ5W87wuH9uq5/IJyni4edpzTnvX1Wb6lImBYXeRN8jaxyG42SzpKmSZ0jLtpCOJCfMhx9oC9TTpPwZgpyPpQ1DxtKvviU+LsZkDLQeJurrU07mJQ7KiJHiwI+pxkP3Nt2BAs67P5Am9Y1G1t5PWjzNAS9T+fz4Zx9KSAenrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941750; c=relaxed/simple;
	bh=K4NF9Fu3Pe+Y4N4iZd54ec41ZJCHJ7pNtHq01fyBD6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iW8CTTQBtGn9jf8MOdC1YO+N1aYcpGQ6sOtty7Xnr7JAtsiySOx0ig9i4E7EsJX8jcZOc7bvM8Bq6821jMfVyUaMb5+3xS+ZjES8zgUZMJcNylQtLix/iaqBqdiwwcQE/1n8Mr3HNHYrkQIc9HEmGnhXrUA/d/xvm17Xtp0JpLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=fmcnwe4b; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="fmcnwe4b"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6dbb24ee2ebso48949187b3.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728941747; x=1729546547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/3UcsrjbqXIyUxg6DaaZ16ndfequ4+r1LjXXenn7viY=;
        b=fmcnwe4blniX0FdsXcF2tYpxrXR6zPY7t4xF39/LppwE98pJeoehS2fZZWpn10ACKX
         CN8AcZsDpBfdCkGe9GOQrXaSWktrqBZDLOvTrofrUM1iTZQZl9rrKfkWt7YOcoN/M6b2
         ZpWoCq284JyntREvdkLBpPiSc9gBCD4XSjT+Fjdpg8v/1HqXCwujIl7jdkHJnRU9QdIn
         LDwXylANVr6PvZnH3AuhywDYsKuCtQoTE64M/AWLgS4SHFZI6UDu/Ma4xEh5SMAUrvNn
         N5eNBAMwpi2jcWTo7qtxEO4e1xyupZD6Oxee6k0WEuufU0CVtBKdewgncVSDxEWciqFJ
         4Xyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941747; x=1729546547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3UcsrjbqXIyUxg6DaaZ16ndfequ4+r1LjXXenn7viY=;
        b=wg5p519I5wIOjhNU20PIh5xHRSnZ5QoSZG1ty3B1x9ScmMjuERM+WALr4dzqDQIh/d
         La2T/fkqAx11+lcafxn97t+nQvfwWE5/EQefu6tQXpj6frLLMIRB8+R1vNEh73dhy3Dl
         oPlJfK5soOz0XDqTv8wKPfO9sIctYxfOxrGYkwLMET8GFkBbOJ7Z65/uTdCBN7amYsLo
         UBlcBN0afdlWJF0h58x8W78DbwQbDqGlSCmCxfso8NKyFgCMLI3OYftvhF/hlNHWK9/8
         aHhENaMjgT0e9aLRf7BDSN6KdqvWB6jFutZkM105vHeG72YWij3xqUHHRSh3sVZNzCMo
         ueVQ==
X-Gm-Message-State: AOJu0Yx4VdePxwpENTCC7u12RNiI86DtpdQVKqE6FFCqG7O5lWl3lBnv
	1dTWC5dvZ1lG55OJnv9ep2txjQYi3xWxsc0qMsR21p/HrlXy5kQ3m9AjPwsJGccaN+Js387xruB
	r
X-Google-Smtp-Source: AGHT+IG8zB5RPVUOXhyhnbvtTBxvKbZq1TFqKJbdzIF73zJJVkCsPVVdtFTxId6aWPn/Sq8ZgHuDFQ==
X-Received: by 2002:a05:690c:5085:b0:6e3:d60:d88 with SMTP id 00721157ae682-6e347c6bf97mr79816687b3.39.1728941747377;
        Mon, 14 Oct 2024 14:35:47 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e332b61285sm17211037b3.17.2024.10.14.14.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:35:47 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:35:45 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH 2/3] t3404: replace test with test_line_count()
Message-ID: <Zw2OsWorAVL4hCB9@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <e2cae7f3a510027864303fe91dcf447f63eb0873.1728774574.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e2cae7f3a510027864303fe91dcf447f63eb0873.1728774574.git.gitgitgadget@gmail.com>

On Sat, Oct 12, 2024 at 11:09:33PM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> Refactor t3404 to replace instances of `test` with `test_line_count()`
> for checking line counts. This improves readability and aligns with Git's
> current test practices.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 96a65783c47..2ab660ef30f 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -281,8 +281,9 @@ test_expect_success 'stop on conflicting pick' '
>  	test_cmp expect2 file1 &&
>  	test "$(git diff --name-status |
>  		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
> -	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
> -	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
> +	grep -v "^#" <.git/rebase-merge/done >actual &&
> +	test_line_count = 4 actual &&
> +	test 0 = $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)

You use 'test_line_count' in one instance here, but 'test 0 =' below.
You could use 'test_must_be_empty' to stick with our test_-helper
functions.

But I like that you used 'grep -c' here, so it may be better to match
the two like so:

    test 4 $(grep -c -v "^#" <.git/rebase-merge/done) &&
    test 0 = $(grep -c "^[^#]" <.git/rebase-merge/git-rebase-todo)

> @@ -416,8 +417,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
>  	git show >output &&
> -	count=$(grep NEVER output | wc -l) &&
> -	test 0 = $count &&
> +	! grep NEVER output &&
>  	git checkout @{-1} &&
>  	git branch -D multi-fixup
>  '

Hmm. Wasn't this modified by the previous step as well? Is there a
reason that these can't be combined to avoid a new intermediate state
that will be thrown away in the next step?

> @@ -436,8 +436,8 @@ test_expect_success 'commit message used after conflict' '
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
>  	git show >output &&
> -	count=$(grep ONCE output | wc -l) &&
> -	test 1 = $count &&
> +	grep ONCE output >actual &&
> +	test_line_count = 1 actual &&
>  	git checkout @{-1} &&
>  	git branch -D conflict-fixup

I am not sure what the benefit of using test_line_count here is over
bare 'test'. Can you explain why you chose to use it here?

In the body of your patch above, you appear to suggest that using
test_line_count is more in the style of Git's current test practices. I
think that's true for cases like writing:

    test_line_count = 1 actual

as opposed to:

    test 1 = $(wc -l <actual)

Since the former doesn't have the gotcha that you must remember redirect
the input of 'wc -l' to avoid having the filename appear in the output,
and the former also ensures that the file exists, has better error
messages, etc.

But in the case where we're running 'grep -c' directly, it seems cleaner
to use bare test, since we're not writing the matches to a file on disk.

Thanks,
Taylor
