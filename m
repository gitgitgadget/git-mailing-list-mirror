Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CCF14B965
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941392; cv=none; b=Xu1yUc/dNxDYvvkrosOW3BRhn85AzNOFg2UBQWS5iVQ2rMZlphFA0/nDTA43Z5D3v0KTRgZZ1M3OYj3BJnfxo9yooBzLOkQvBjoTba6rFzMq0z3qa3LJHUZS4MD8504E41LXYUVnd3fFNLr2L4xwWweu54Uxki3DLc8l8c7z4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941392; c=relaxed/simple;
	bh=+KQjUO6ov6w6pQmyB+DhblmKkOC/GDrGdUvd3GVBdeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwQCYEBxipyHAlOkVEyXyDY1qDEFxwh5qnoOT97etZXlxjDab+2ynLqbVC1QUY7R3WK4B62cFiUcvWH/9v0NleJB6wNw9kfmzQg6P8U4brMa0ngzo0onra4gEPPqtsk426KVAZAVqlgOyjfy1z7WZDcx+GtVde1hRdF2k018sRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jaqI+AzG; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jaqI+AzG"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e28fea0f5b8so4177970276.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 14:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728941390; x=1729546190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9nVIMyCqeAxEUFDR18xP1EI1AsqLrUzF+iyQVxZ045Y=;
        b=jaqI+AzG6RPFgRj+/Wal4Rp2N/PVsBhPVog7OFOG7DQin5s6bsgOcH8MbReFpRofuk
         pcaqhwux0xVKuUZLYWtamlQzpEOnNBtF6nQla20qPgtH4E5kBk783mvZ4cMy65QB70O9
         clKqqDDJ/XjN4dyoGtrkTwCLuzL3MkvBGhBzrFnI6L6fvIopz1otD6V8JfW289AWf3JH
         0FNyp7ZVl0seoVW1lm4zggDCPxzoELhNFwMfM2yF9ej33zW5Lk53YfMreuRoMPBqI0qS
         2qkm3gDFCfiCFvCDhAqZlCiApPVWGihIDFiMrdB6bTTnOdtB/Ystq2axoaqLmTLk0rlY
         ZreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728941390; x=1729546190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nVIMyCqeAxEUFDR18xP1EI1AsqLrUzF+iyQVxZ045Y=;
        b=aLW4kmdPTaPyoLJJMSgJNdxz7HZuPl11NQhbgVedtBH+lDelsyJX+Nap6NQgMays98
         ASrHs/6JrZJyyFRT3qs+WVSwku39g7Q92wtoJnCFjFjsu3AodN/TWwOHlsWlk01cbleg
         e8he7+ztoGDLhpm6CmpZHjz1aAhcK0A1eZyZGuYlP8V+9kCpuN+EiLLakL/a/hchjySP
         PrQE/+RUvjEaZCeGgg3GcjojYO6yLa2UJzPd4FNYvWOEAAwCdDQtfrl3p7mcp68JwY37
         29FwWX1d+d2pgvVIixF2CcQBENp2w6alfdm86cyL9B3NXx686qVoS1R7+5RuhYRxAwVf
         GBqg==
X-Gm-Message-State: AOJu0Yxx2bJkOPbERzze8z47LEf4D8uk09RqhAnkeuCAxdbf6ETr3I+j
	rg7IST7IeowxWVBLiUZAC6ABiKdWNzFMQUkxAjCgvz8kYO4fK+E4YHCjuH9Yu7Q=
X-Google-Smtp-Source: AGHT+IHI8mf5Mgku3IeypRc5OEmYIv7BnaOaTh4MaAkquKm6SK2Nd0M0OHppPLTBLOXCSru4VzkV4Q==
X-Received: by 2002:a05:6902:1502:b0:e29:2f00:804f with SMTP id 3f1490d57ef6-e292f00c878mr7800376276.24.1728941389977;
        Mon, 14 Oct 2024 14:29:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e290ef5c451sm2531647276.49.2024.10.14.14.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 14:29:49 -0700 (PDT)
Date: Mon, 14 Oct 2024 17:29:48 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH 1/3] t3404: avoid losing exit status with focus on `git
 show` and `git cat-file`
Message-ID: <Zw2NTPk+YwEqcydf@nand.local>
References: <pull.1810.git.git.1728774574.gitgitgadget@gmail.com>
 <bfff7937cd20737bb5a8791dc7492700b1d7881f.1728774574.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfff7937cd20737bb5a8791dc7492700b1d7881f.1728774574.git.gitgitgadget@gmail.com>

On Sat, Oct 12, 2024 at 11:09:32PM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
>
> The exit code of the preceding command in a pipe is disregarded. So
> if that preceding command is a Git command that fails, the test would
> not fail. Instead, by saving the output of that Git command to a file,
> and removing the pipe, we make sure the test will fail if that Git
> command fails. This particular patch focuses on all `git show` and
> some instances of `git cat-file`.
>
> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 23 deletions(-)
>
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index f171af3061d..96a65783c47 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -319,7 +319,8 @@ test_expect_success 'retain authorship' '
>  	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
>  	git tag twerp &&
>  	git rebase -i --onto primary HEAD^ &&
> -	git show HEAD | grep "^Author: Twerp Snog"
> +	git show HEAD >actual &&
> +	grep "^Author: Twerp Snog" actual
>  '

Good.

> @@ -397,7 +400,9 @@ test_expect_success 'multi-squash only fires up editor once' '
>  			git rebase -i $base
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l)
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count
>  '

I think moving 'git show' out of the pipeline is a good step here, but I
don't think we need to store $count in a separate variable. It would be
fine to write:

    git show >output &&
    test 1 = $(grep ONCE output | wc -l)

or even to replace the subshell with 'grep -c' instead of piping 'grep'
to 'wc -l'.

>  test_expect_success 'multi-fixup does not fire up editor' '
> @@ -410,7 +415,9 @@ test_expect_success 'multi-fixup does not fire up editor' '
>  			git rebase -i $base
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
> -	test 0 = $(git show | grep NEVER | wc -l) &&
> +	git show >output &&
> +	count=$(grep NEVER output | wc -l) &&
> +	test 0 = $count &&
>  	git checkout @{-1} &&
>  	git branch -D multi-fixup
>  '

Same notes from above here and the next two tests (elided from my
response) below.

> @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate correct log messages' '
>  	) &&
>  	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
>  	test_cmp expect-squash-fixup actual-squash-fixup &&
> -	git cat-file commit HEAD@{2} |
> -		grep "^# This is a combination of 3 commits\."  &&
> -	git cat-file commit HEAD@{3} |
> -		grep "^# This is a combination of 2 commits\."  &&
> +	git cat-file commit HEAD@{2} >actual &&
> +	grep "^# This is a combination of 3 commits\." actual &&

Is there a more descriptive name for the output here than just 'actual'?

Thanks,
Taylor
