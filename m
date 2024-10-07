Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E918BC2F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728291164; cv=none; b=IRY9LM7QiLjxk0gMz9Y00TUPw1n/O2YteKCxz9ANcPh4UFjzfhFpkF115G9RuYh40OJB64GdViwNJGYAK0LTeqUTXcXBy5nlBrxQLI8Pd2Yaa5X4shvfe+bFAXMOdHPjdpoXP5NRzrRH5cCghqDB7Ic5LxN5HqlRsN9u9YnMstc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728291164; c=relaxed/simple;
	bh=mtgkdDcq+yqAZJGflzsVHmGhi48OZFEQyfAZRcb4Al0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jAkhlur3FHGjt3yCFYoasgWtsxIanjF6WS1kVsuHywqhYrFzw8IgAoz2o9W81bv96TPDHuZ57NRTT9VBxhrIptRM5M8I6whS7JPir92zduusH35HJEuE2eGvTcJSkn3UslG8DemfSDykV7tCZws0QegZ8TSJPJbZPB4P8YWMWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9ZQQIfY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9ZQQIfY"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9932aa108cso308870166b.2
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 01:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728291161; x=1728895961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=feBCCl0vhk2udJoLc2jNX2UIYsKzqA7w5GogMfSWQFU=;
        b=C9ZQQIfYF+lHZSXUVlSMErzs7AHl04sfq91iQMl6QiOv7tnFctUXGfIcLXmdaMweSX
         OG79sqrxm3E0gdCLu0DaG61PqfEKBLVruFS2GkyzWhn61Op8T3R95057pWcaHRKe4bpG
         0BoQEBd1np4cp9cCrKjy76hX7AWclLTvM6CE+Wl3tlehzIzVhdtD0sUXE6QXOqK3OoLJ
         jcJmPVOIOCCOPgonLEiVXkOy0r50jvLClPX3QwGoi3q0JkjR7Y27dxQG7Yrbio8BguIf
         puSOpC51TrxZIrQ8toGQBRr1+GMQ47D+annb7JQwIZIOeujvfh5K4hCw00B64CY7ePlD
         99vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728291161; x=1728895961;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feBCCl0vhk2udJoLc2jNX2UIYsKzqA7w5GogMfSWQFU=;
        b=F57QCPVZZUWEIGMyYbIYm1Xgk9Qp1KND74KAQVa4eJ0pXndcGJIpa4zVOO9F0/okr+
         71d71aGOzrJTtc17WCS+uyixZx1axn5GhH2BBx4SYyN2gGM1XOJ5+lIIBJFj6mDHxFMk
         t75c4vxoEXiv/R7+kEYfgEQW/xqvh+HdWN9AWnel+dEkaAK1xaoETjsWGezB9cuc1uF/
         azjba987pqrYJD9UjF3nhiPSou/fi9xQE5Xn0smXMfSEXXC2nrE2S0CzN5qkQ3zX5AAr
         1yPWkJkrqN7lrIvffXqYFRrp7oUlzqwqzdnAMDMSow0DQyOFpGh6Xi51gbxBl7rcDotj
         29wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqifl9LpFfmitRyI6NcwhpjwXbIC1eKI3lv3KfL2cK8/ZBZPIvOcGGYNJy87prIw7NinY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAycc17+0xoMQ0dX/Kyfzy93EOd9A1s9+qZE702Fsn1ZJXeffU
	eQJSAOoBSfjpSkvnSzLbT2++MKpUHgrY25/GNFj7JliV84qoB3h6
X-Google-Smtp-Source: AGHT+IEscA5i5u06M/J0pBTnPGltV+pJ8oKajY2o9+Pl+b7MtrvmRNOZDzKawD1s+/+A8vJUQVTHLQ==
X-Received: by 2002:a17:907:25c5:b0:a77:f2c5:84b3 with SMTP id a640c23a62f3a-a991bd20afamr1098759166b.22.1728291160416;
        Mon, 07 Oct 2024 01:52:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:61a:f001:1402:4f50:9447:3e15? ([2a0a:ef40:61a:f001:1402:4f50:9447:3e15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99347bfdddsm332436466b.70.2024.10.07.01.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 01:52:39 -0700 (PDT)
Message-ID: <b4a725aa-eb90-4640-8e45-b24b9f89eab6@gmail.com>
Date: Mon, 7 Oct 2024 09:52:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/2] t3404: avoid losing exit status with focus on `git
 show` and `git cat-files`
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>,
 Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
 Eric Sunshine <sunshine@sunshineco.com>, shejialuo <shejialuo@gmail.com>,
 Usman Akinyemi <usmanakinyemi202@gmail.com>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Usman

On 06/10/2024 17:06, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> The exit code of the preceding command in a pipe is disregarded. So
> if that preceding command is a Git command that fails, the test would
> not fail. Instead, by saving the output of that Git command to a file,
> and removing the pipe, we make sure the test will fail if that Git
> command fails.

This is a good description of the reason for making this change.

> This particular patch focuses on some of the instances
> which include `git show` and `git cat-files`.

This patch seems to fix all of the instances of "git show" rather than 
some. It also fixes a few instances of "git cat-file" (note there is no 
trailing "s" in the command name). It is not immediately clear to me why 
those instances of "git cat-file" were selected for conversion but not 
others. However they are a worthwhile improvement and converting them 
all in this patch would make it bit too big to comfortably review so I'm 
happy with the changes as they are.

The patch itself looks good.

Thanks

Phillip

> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>   t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
>   1 file changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index f171af3061d..96a65783c47 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -319,7 +319,8 @@ test_expect_success 'retain authorship' '
>   	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
>   	git tag twerp &&
>   	git rebase -i --onto primary HEAD^ &&
> -	git show HEAD | grep "^Author: Twerp Snog"
> +	git show HEAD >actual &&
> +	grep "^Author: Twerp Snog" actual
>   '
>   
>   test_expect_success 'retain authorship w/ conflicts' '
> @@ -360,7 +361,8 @@ test_expect_success 'squash' '
>   '
>   
>   test_expect_success 'retain authorship when squashing' '
> -	git show HEAD | grep "^Author: Twerp Snog"
> +	git show HEAD >actual &&
> +	grep "^Author: Twerp Snog" actual
>   '
>   
>   test_expect_success '--continue tries to commit' '
> @@ -374,7 +376,8 @@ test_expect_success '--continue tries to commit' '
>   		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
>   	) &&
>   	test_cmp_rev HEAD^ new-branch1 &&
> -	git show HEAD | grep chouette
> +	git show HEAD >actual &&
> +	grep chouette actual
>   '
>   
>   test_expect_success 'verbose flag is heeded, even after --continue' '
> @@ -397,7 +400,9 @@ test_expect_success 'multi-squash only fires up editor once' '
>   			git rebase -i $base
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l)
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count
>   '
>   
>   test_expect_success 'multi-fixup does not fire up editor' '
> @@ -410,7 +415,9 @@ test_expect_success 'multi-fixup does not fire up editor' '
>   			git rebase -i $base
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 0 = $(git show | grep NEVER | wc -l) &&
> +	git show >output &&
> +	count=$(grep NEVER output | wc -l) &&
> +	test 0 = $count &&
>   	git checkout @{-1} &&
>   	git branch -D multi-fixup
>   '
> @@ -428,7 +435,9 @@ test_expect_success 'commit message used after conflict' '
>   			git rebase --continue
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l) &&
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count &&
>   	git checkout @{-1} &&
>   	git branch -D conflict-fixup
>   '
> @@ -446,7 +455,9 @@ test_expect_success 'commit message retained after conflict' '
>   			git rebase --continue
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 2 = $(git show | grep TWICE | wc -l) &&
> +	git show >output &&
> +	count=$(grep TWICE output | wc -l) &&
> +	test 2 = $count &&
>   	git checkout @{-1} &&
>   	git branch -D conflict-squash
>   '
> @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate correct log messages' '
>   	) &&
>   	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
>   	test_cmp expect-squash-fixup actual-squash-fixup &&
> -	git cat-file commit HEAD@{2} |
> -		grep "^# This is a combination of 3 commits\."  &&
> -	git cat-file commit HEAD@{3} |
> -		grep "^# This is a combination of 2 commits\."  &&
> +	git cat-file commit HEAD@{2} >actual &&
> +	grep "^# This is a combination of 3 commits\." actual &&
> +	git cat-file commit HEAD@{3} >actual &&
> +	grep "^# This is a combination of 2 commits\." actual  &&
>   	git checkout @{-1} &&
>   	git branch -D squash-fixup
>   '
> @@ -489,7 +500,9 @@ test_expect_success 'squash ignores comments' '
>   			git rebase -i $base
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l) &&
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count &&
>   	git checkout @{-1} &&
>   	git branch -D skip-comments
>   '
> @@ -505,7 +518,9 @@ test_expect_success 'squash ignores blank lines' '
>   			git rebase -i $base
>   	) &&
>   	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l) &&
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count &&
>   	git checkout @{-1} &&
>   	git branch -D skip-blank-lines
>   '
> @@ -572,7 +587,8 @@ test_expect_success '--continue tries to commit, even for "edit"' '
>   		FAKE_COMMIT_MESSAGE="chouette!" git rebase --continue
>   	) &&
>   	test edited = $(git show HEAD:file7) &&
> -	git show HEAD | grep chouette &&
> +	git show HEAD >actual &&
> +	grep chouette actual &&
>   	test $parent = $(git rev-parse HEAD^)
>   '
>   
> @@ -757,19 +773,23 @@ test_expect_success 'reword' '
>   		set_fake_editor &&
>   		FAKE_LINES="1 2 3 reword 4" FAKE_COMMIT_MESSAGE="E changed" \
>   			git rebase -i A &&
> -		git show HEAD | grep "E changed" &&
> +		git show HEAD >actual &&
> +		grep "E changed" actual &&
>   		test $(git rev-parse primary) != $(git rev-parse HEAD) &&
>   		test_cmp_rev primary^ HEAD^ &&
>   		FAKE_LINES="1 2 reword 3 4" FAKE_COMMIT_MESSAGE="D changed" \
>   			git rebase -i A &&
> -		git show HEAD^ | grep "D changed" &&
> +		git show HEAD^ >actual &&
> +		grep "D changed" actual &&
>   		FAKE_LINES="reword 1 2 3 4" FAKE_COMMIT_MESSAGE="B changed" \
>   			git rebase -i A &&
> -		git show HEAD~3 | grep "B changed" &&
> +		git show HEAD~3 >actual &&
> +		grep "B changed" actual &&
>   		FAKE_LINES="1 r 2 pick 3 p 4" FAKE_COMMIT_MESSAGE="C changed" \
>   			git rebase -i A
>   	) &&
> -	git show HEAD~2 | grep "C changed"
> +	git show HEAD~2 >actual &&
> +	grep "C changed" actual
>   '
>   
>   test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
> @@ -1003,8 +1023,10 @@ test_expect_success 'rebase -i --root retain root commit author and message' '
>   		set_fake_editor &&
>   		FAKE_LINES="2" git rebase -i --root
>   	) &&
> -	git cat-file commit HEAD | grep -q "^author Twerp Snog" &&
> -	git cat-file commit HEAD | grep -q "^different author$"
> +	git cat-file commit HEAD >output &&
> +	grep -q "^author Twerp Snog" output &&
> +	git cat-file commit HEAD >actual &&
> +	grep -q "^different author$" actual
>   '
>   
>   test_expect_success 'rebase -i --root temporary sentinel commit' '
> @@ -1013,7 +1035,8 @@ test_expect_success 'rebase -i --root temporary sentinel commit' '
>   		set_fake_editor &&
>   		test_must_fail env FAKE_LINES="2" git rebase -i --root
>   	) &&
> -	git cat-file commit HEAD | grep "^tree $EMPTY_TREE" &&
> +	git cat-file commit HEAD >actual &&
> +	grep "^tree $EMPTY_TREE" actual &&
>   	git rebase --abort
>   '
>   
> @@ -1036,7 +1059,8 @@ test_expect_success 'rebase -i --root reword original root commit' '
>   		FAKE_LINES="reword 1 2" FAKE_COMMIT_MESSAGE="A changed" \
>   			git rebase -i --root
>   	) &&
> -	git show HEAD^ | grep "A changed" &&
> +	git show HEAD^ >actual &&
> +	grep "A changed" actual &&
>   	test -z "$(git show -s --format=%p HEAD^)"
>   '
>   
> @@ -1048,7 +1072,8 @@ test_expect_success 'rebase -i --root reword new root commit' '
>   		FAKE_LINES="reword 3 1" FAKE_COMMIT_MESSAGE="C changed" \
>   		git rebase -i --root
>   	) &&
> -	git show HEAD^ | grep "C changed" &&
> +	git show HEAD^ >actual &&
> +	grep "C changed" actual &&
>   	test -z "$(git show -s --format=%p HEAD^)"
>   '
>   

