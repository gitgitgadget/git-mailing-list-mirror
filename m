Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B610428B41A
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754476149; cv=none; b=PgLY1rBuxAtp2sC1kUry3hHoa7VUAGEHdIp0MBQHRvvMtzCf86SS6YThMriabd/zvLgTEIbs29o10vjCFi3dtEK01RB/KMTX/z5ki7SOVQrcmKPa9YaCvgg/GjH3NGnuafj7ReSDSQ6WGuMMQLc//SdVmKJGqpo4HnLm+ZU6Fmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754476149; c=relaxed/simple;
	bh=wwfCSkZOfdwxxhxsYtF6LK7uHGCXU3Dtx+E6phUCGzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FSuJcGDfB9vDQBCD6tkrBoDuLf1CbOtfssVWoCDCIRYb0ZnOLYaUCmxpe36e1XrNGMN/Ex8XNB91FAeJPe/qJUE7uJDm2egAXofKeHpNynblmFme/BbNV41k4eKFJSAleUhCnMcDqocfTkjW8o1g2wls0cnt34PFqE0OYQbnk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vwasq3QG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vwasq3QG"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459ddada9b1so27313235e9.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754476145; x=1755080945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r9XEWPRWM0CLKGkAARbuAYJAevVEnLNdO3CeXetd1qY=;
        b=Vwasq3QG2O9nFZLdHuzZBl9xfK1RDyaRS7KJh6OVJ7OWH5zxEUCOHOJPPXWzJwjMV/
         wH6+RzECVlX+CwSZlhSnDctCShVI6SkCQOEZb8X+mDORLEtCrNyoTRpQuZlLF8V89jds
         MTrQKelYZkjj8KG6gmbBb6PPeZ6j9P9uVcO8xvvBktep3lvg3XwibsKkEUyCzLfShzf0
         IeULGHF55258fdLKEVQ5kdhyjGN83a3PiNnhkhzIHoLxd/6Z+2BOtZxC5L6kVXl2gdei
         wl7aGTmTXELZdEjdbpdssWPWJrprG3p1+pJfUXWMiiOnxTi23o8EAAY1XDOiJC4a+ox4
         7nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754476145; x=1755080945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r9XEWPRWM0CLKGkAARbuAYJAevVEnLNdO3CeXetd1qY=;
        b=XgkeXSBXzJr/Gl1+8fHOeWqTK7u/eYhVN0SUS1h1G30HTqM3em8obSk+3FYZzSVya8
         K/UPrYei2+5nFgMoGrdL/MAz2lfw4FfKf5ZoBq63Zb9YJw+ByrjltmN7nSgMo+GoLUoQ
         W5xqmhWX4OcnuwKyLhwU9geSfyuBjXYEwXzZQfqg+91TTZ4J7VblxwmBaYBceLpx+zJh
         TamHXTY+pqGdBfo8h5u8hy2bgkO24hOfx2wLXl2i6iNwW59G18jouQkK5+Fbv7KDuq2S
         hAwCeWaEdOYpqD+E5ybofa/dnSBXyXHuF2exXS7STK4E0dedqJeQVnDy2J3vr/8XxyBe
         qtfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVud3lFGjFuZUIOYjKpB3ILYpLh0WB0UuzLr/MCOj5NYuNu+hHv/BNpaYH2alnjQ4CHQ+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrvUQnrqyrAAuer6dNuEssribkalyscIbd/xU4hojDWEIdtq37
	s8aOrJUYGtf3pl+ZEJl4lUpZuOQQ9NewaEVxWLq/d5VmebQYEhT/tMsW
X-Gm-Gg: ASbGncuFpSR3nU5JIEl85Xg6Z4YdgGWthNWvaJpYe5E9obKb8R+L0+zA18lFpPZDRvY
	RX6j/meG0F3evzzii7lsMXrvNRkoLCHpOEy4VISjDVnWg5zO5jgawg29rzGpmd/7KuaSTkKtZZh
	PuU6ZraB1WYkWvFIFdzEsqj08KOXpipTGdT/ZfyUTbdNl9HMY2nn2irkVsV7wV4PNO8Cj1PLLi9
	gyBdZfh1gLRX7TTZUJ1U/wm6QTyNqv/IzK453+yEOPuO2niK44/DhOBztCshPDYJtTEYsacLaX/
	t3qPjZ+lD/4msIpwhJzejuw+z60tvPdwQArQ0Zya/n1PTsX1dBOFJUTZaIGy7oZDMuQ4i2D2HNa
	U384rjDJNZHL+5NHnj5Iav3awSmkj9D7v2B3/qidrMNB+rnk3ZzNlEaGmI7kXQ49BvmLLXeqIAK
	KG
X-Google-Smtp-Source: AGHT+IHvrrLvYHPJ0yKzsVNjR1k5um5uX3zPOBmBfF8LTmISAo9PQm2djKS6lYzWbwg75mUINf0grw==
X-Received: by 2002:a05:600c:b86:b0:453:6ca:16b1 with SMTP id 5b1f17b1804b1-459e74a843bmr15928675e9.26.1754476144801;
        Wed, 06 Aug 2025 03:29:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e79ef4c8sm25165255e9.6.2025.08.06.03.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 03:29:04 -0700 (PDT)
Message-ID: <e911d897-8664-40a7-b7a9-8eb9f71a8735@gmail.com>
Date: Wed, 6 Aug 2025 11:28:58 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase: support --trailer
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20250803150059.402017-1-me@linux.beauty>
 <20250803150059.402017-3-me@linux.beauty>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250803150059.402017-3-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 03/08/2025 16:00, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
Picking up from where I left off yesterday ...

> diff --git a/t/meson.build b/t/meson.build
> index 09f3068f98..3c58f562da 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -373,6 +373,7 @@ integration_tests = [
>     't3436-rebase-more-options.sh',
>     't3437-rebase-fixup-options.sh',
>     't3438-rebase-broken-files.sh',
> +  't3440-rebase-trailer.sh',

The alignment looks off here

>     't3500-cherry.sh',
>     't3501-revert-cherry-pick.sh',
>     't3502-cherry-pick-merge.sh',
> diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
> new file mode 100755
> index 0000000000..a580449628
> --- /dev/null
> +++ b/t/t3440-rebase-trailer.sh
> @@ -0,0 +1,95 @@
> +#!/bin/sh
> +#
> +
> +test_description='git rebase --trailer integration tests
> +We verify that --trailer on the merge/interactive/exec/root backends,

There are only two backends "apply" and "merge", the other things you 
have listed are just command line options. We don't actually test --exec 
or --interactive with --trailer in this file so we should reword that 
comment. There is no need to add tests for those.

> +and that it is rejected early when the apply backend is requested.'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
> +
> +create_expect() {
> +	cat >"$1" <<-EOF
> +		$2
> +
> +		Reviewed-by: Dev <dev@example.com>
> +	EOF
> +}
> +
> +test_expect_success 'setup repo with a small history' '
> +	git commit --allow-empty -m "Initial empty commit" &&
> +	test_commit first file a &&
> +	test_commit second file &&
> +	git checkout -b conflict-branch first &&
> +	test_commit file-2 file-2 &&
> +	test_commit conflict file &&
> +	test_commit third file &&
> +	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
> +	create_expect initial-signed  "Initial empty commit" &&
> +	create_expect first-signed    "first"                 &&
> +	create_expect second-signed   "second"                &&
> +	create_expect file2-signed    "file-2"                &&
> +	create_expect third-signed    "third"                 &&
> +	create_expect conflict-signed "conflict"

Normally we create the "expect" file in the test where it is used.

> +'
> +
> +test_expect_success 'apply backend is rejected with --trailer' '

We know HEAD is at third so we don't need this

> +	git reset --hard third &&
> +	head_before=$(git rev-parse HEAD) &&
> +    test_expect_code 128 \

The indentation is off here

> +    		git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
> +    			HEAD^ 2>err &&
> +	test_grep "requires the merge backend" err &&

I think it is worth checking that the error message includes --trailer 
as well to make sure that is the option that is triggering the error.

> +	test_cmp_rev HEAD $head_before
> +'
> +
> +test_expect_success 'reject empty --trailer argument' '
> +        git reset --hard third &&

The exact commit is not important here

> +        test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
> +        test_grep "empty --trailer" err
> +'
> +
> +test_expect_success 'reject trailer with missing key before separator' '
> +        git reset --hard third &&

Same here - we're only checking the error message so the exact value of 
HEAD is not important.

> +        test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
> +        test_grep "missing key before separator" err
> +'
> +
> +test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
> +        git reset --hard third &&
> +        git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
> +        git cat-file commit HEAD | grep "^Bug: 456" &&
> +        git cat-file commit HEAD | grep -v "^Bug: 123"

Piping git into another command is discouraged as git can potentially 
fail without us noticing. Here I think it would be better to use 
test_commit_message() to check the whole message.
> +'
> +
> +test_expect_success 'multiple Signed-off-by trailers all preserved' '
> +        git reset --hard third &&

We can avoid this by passing the commit we want to checkout to rebase as 
you do in the test below.

> +        git rebase -m \
> +            --trailer "Signed-off-by: Dev A <a@ex.com>" \
> +            --trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
> +        git cat-file commit HEAD | grep -c "^Signed-off-by:" >count &&
> +        test "$(cat count)" = 2   # two new commits

Let check the actual message here as well so if it fails we can see what 
the message is.

> +'
> +
> +test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
> +	git reset --hard third &&

We don't need this as the rebase command checks out third for us, saving 
a process which is always nice.

> +	test_must_fail git rebase -m \
> +		--trailer "Reviewed-by: Dev <dev@example.com>" \
> +		second third &&
> +	git checkout --theirs file &&
> +	git add file &&
> +    git rebase --continue &&

The indentation is off here

> +	test_commit_message HEAD~2 file2-signed

It's good to see this uses test_commit_message but why are we checking 
HEAD~2 rather than HEAD?> +'
> +
> +test_expect_success 'rebase --root --trailer updates every commit' '
> +	git checkout first &&
> +	git rebase --root --keep-empty \

--keep-empty is the default these days so I think we can drop that.

> +		--trailer "Reviewed-by: Dev <dev@example.com>" &&
> +	test_commit_message HEAD   first-signed &&
> +	test_commit_message HEAD^  initial-signed

Looks good.

While there are some small issues to fix the tests look sensible and I 
think you have good coverage of the new option.

Thanks

Phillip
