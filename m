Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292030F922
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807335; cv=none; b=pqmpu9FjcAIKo/U028WlbzS+3uc/WUW1Gmcp3lH1ZlqJL67j5n6aKe5Ub0puHeEtdgUfMJf+WjcujXNbG9ZwrDKyjQqsoxQP0Fy2WTwfRnVxZsgWon6Qw0s0Dvq6aN49bpGLpgM+UiL6lCzPtgjpJ/7C0NtcRrW8ftXCkn8yf+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807335; c=relaxed/simple;
	bh=Te5iWPfzki1yGsKn11nWqMPrMwj4rZwbIYS978mcw+8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MutliYWzY/vAX0bZPXLSeNV2jLMqiDkn/4RE4XElGV0+dhvRGeNmrU6n2AJFhwqjVtcrUPhW69hjYnk6ZboLTR+S/tihXK3oJycPnXet43MYlhOFmz9FLm97aoNsR7Sx8kaY8ullY+qNqR+6aVZXyi/zww9NrGA4h9ygBwXzy8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YICEx1EP; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YICEx1EP"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-598f81d090cso3815732e87.2
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765807332; x=1766412132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xm9s6gpHKe6VYgosg36YETQ672zDCoThPhsw/Z1dNGU=;
        b=YICEx1EP8H+ldrd9A500iVsUZVD4OdVeBRZh6jCGPHgL7fPzHaA8c/i0XiWgpeaKbq
         kNNdNKwvRf3T/RuRbFC3H7lTXYTB+8sVMXXXU7y6RToWA0rQ6CdtFQkK16r1eVomXDBh
         N1pDl1UEl6sTyO+CjBXs+/ZcrF5wMmJteBLRkG4PUqtPRyW8SUz6sPbRuozlOF+nd0hb
         Klj1OlNRLSi/hMTCe2oxtPhujsdOj+Bb1jhFhtTvX9rZd9ZjS0qAqyX+DFJ2oxCcpqWh
         vZLP4Im98dcS72xjJrAbAoRQS3T0OKE8ZW4eIaGUX/aCbHU52BODuZScLLZ/g6+3BSSq
         s9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765807332; x=1766412132;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xm9s6gpHKe6VYgosg36YETQ672zDCoThPhsw/Z1dNGU=;
        b=WuF2LqhCtQ3RggPTjnfrDCtZDJQ3pihrNc4E0d8oXDE5TaP9K4OYSusqxQ5wa4UYkI
         nn0F7Lf88W/HaZ6MTvbMVUyTrHpeWPmZC8jhhFcDqZW5wPCICBLs1msqKyy9Qoc8SmKn
         eJ7MrDx+nj0G6dNkp17ax66oGeSKCdrhA9QXykFZ8ab5xtKWOUAGiUAOhxhYFHU2MA7d
         38M8Lnr0fydvjvCo7bwzgEzNLKpGWVe3eKVG4DzqvJTLi6dvowxNDGjlV/5geOBM2b8z
         O9y6hPjgQ6WHjyY8BXp6I54VEXF32eB2XQqou4LvO2X9iKl/LlnJoiTaPEN/l9Qa8EeE
         +GJg==
X-Gm-Message-State: AOJu0YyaDpXurAVcIcJO1hfSSobOIJxAvO1Jk73vaV7bFuhOpaGjO5Bw
	2jTGvJqQFvNvkQM9CkK6c4ngElgNElOXRzlbF+tPrEHyjAHGrkzMq9lJmqiXqg==
X-Gm-Gg: AY/fxX4yW8XAN90Av44u/76YVkS4XVoI4/g8APiAfBbLKGZS64gnm5N70MjnYNC6Er5
	DXe6kgwP/iCSnm4OZ+DWoxuM7gm5ECkQlGxS9u9cdkY9Dp9jrXS5xEk8RHOsLZttkYbQsbu1j4j
	MIksbJ/dyoZSoyekt6cTidLQ08lJDTH13Y46F0NUNkSpBncugwLenrs3tUUQHth8ANbAKywBI9n
	qGNavKThymmSQEXq8gCk5aRcg/ygbvVdxu0iMvsFYtF74H6nrSVFJGDW3kLvaigsLNh92VBJmZy
	OFCNOZr8ayyrD6IsIcDI05BjU1iQDUzqqwaeOC0f/k8Tq0t0lJvZgU3jxfQVd+GlTFR+ugUby5f
	i2jD9foWNWUFuOK6l9i6IvwuWJnzAbApsXUTs7qUeZjp3tAi5WUuwwl7zPHKI0AFlUFOFBTv3DX
	n2xsj9BEppQo5deGsr9xj552s=
X-Google-Smtp-Source: AGHT+IG2BgzqmiIJs+XGbpnHkIsRPIwrZVo/78e2TKJ1+qU6RKvU2+Dq7Fi7nIjygL6QRo74OX8C8g==
X-Received: by 2002:a05:6512:3d87:b0:594:4b7f:f946 with SMTP id 2adb3069b0e04-598faa71163mr3637107e87.33.1765807331637;
        Mon, 15 Dec 2025 06:02:11 -0800 (PST)
Received: from [10.29.112.243] ([193.204.167.189])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2f3efdasm5539648e87.32.2025.12.15.06.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Dec 2025 06:02:11 -0800 (PST)
Message-ID: <d7135cd2-e577-4f96-8142-cd9c7cd6995d@gmail.com>
Date: Mon, 15 Dec 2025 15:02:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Luca Balsanelli <lucabalsanelli@gmail.com>
Subject: Re: Different behaviour for --find-renames between git diff and git
 merge?
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org
References: <3742e7de-7d88-4e77-b711-9fed867a8c23@gmail.com>
 <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BH80R4LJDRKQnPmh5Am_HAcCgxWiA8vRoN8LgLRUMz+JQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/12/25 02:57, Elijah Newren wrote:
> On Fri, Dec 12, 2025 at 10:06 AM Luca Balsanelli
> <lucabalsanelli@gmail.com> wrote:
>> Hi,
>>
>> I'm scratching my head to understand why on the following case `git
>> diff` and `git merge` give a different interpretation about a rename.
> I don't see any difference...

Sorry, my email was not clear. There is still something that is not 
convincing me though. I will reformulate my question at the end, after I 
reply 'inline' to all the (true) considerations. I consider myself 
decently educated on git, but probably I still miss some understanding 
of the merge procedure.

>> git switch master
>> touch aaa
>> git add aaa
>> git commit -m 'aaa'
>>
>> git switch -c branch
>> echo -en 'A\nB\nC\n' > aaa
>> git add aaa
>> git commit -m 'A\nB\nC\n > aaa'
>>
>> git switch master
>> echo -en 'A\nB\n' > aaa
>> mkdir dir
>> mv aaa dir/
>> git add aaa dir/
>> git commit -m 'A\nB\n > aaa -> dir/'
>>
>> The `|merge.renames` config variable is true. Changing `git diff
>> --find-renames=50%` (the default) or `git merge -s ort -X
>> find-renames=50%` ||to something lower does not change the following.
>> |
>>
>> `git diff` prints
> Actually, it doesn't; more on that below...

I forgot to specify that I was intending to diff the two heads, that is 
`master` and `branch`. So it was

git switch master

git diff branch

>> diff --git a/aaa b/dir/aaa
>> similarity index 71%
> Did you not follow your own recipe? Maybe you inserted an extra space
> or left off the 'n' in 'echo -en' when you ran this? The number
> should have been 66%.

I don't know what I did but there were additional newlines. So, yes, the 
similarity index is 66% (which is still above to the default 50% to 
detect renames for both `git diff` and `git merge`).

>> rename from aaa
>> rename to dir/aaa
>> index bbd2b90..986ad36 100644
>> --- a/aaa
>> +++ b/dir/aaa
>> @@ -1,4 +1,3 @@
>> A
>> B
>> -C
>>
>> that is the similarity index is 71% and it detects the rename.
> At this point, if you actually run `git diff` you see the following:
>
> $ git diff
> $
>
> i.e. nothing. I suspect you gave `git diff` additional arguments but
> didn't tell us. Let's look at a few options:
>
> $ git diff master~1 master
> diff --git a/aaa b/aaa
> deleted file mode 100644
> index e69de29..0000000
> diff --git a/dir/aaa b/dir/aaa
> new file mode 100644
> index 0000000..35d242b
> --- /dev/null
> +++ b/dir/aaa
> @@ -0,0 +1,2 @@
> +A
> +B
> $
>
> So, on master, aaa was deleted, and dir/aaa was added.
>
> $ git diff master~1 branch
> diff --git a/aaa b/aaa
> index e69de29..b1e6722 100644
> --- a/aaa
> +++ b/aaa
> @@ -0,0 +1,3 @@
> +A
> +B
> +C
> $
>
> On branch, aaa was modified.
>
> $ git diff branch master
> diff --git a/aaa b/dir/aaa
> similarity index 66%
> rename from aaa
> rename to dir/aaa
> index b1e6722..35d242b 100644
> --- a/aaa
> +++ b/dir/aaa
> @@ -1,3 +1,2 @@
> A
> B
> -C
> $
>
> So, only if you diff the endpoints of the two branches do you see a
> rename; if you look from the merge base to either branch, there isn't
> one.

Yes, the above is all true. As I said above, I forgot to specify the 
argument: `git switch master; git diff branch`.

>> `git merge branch`, instead, gives
>>
>> CONFLICT (modify/delete): aaa deleted in HEAD and modified in
>> branch. Version branch of aaa left in tree.
>> Automatic merge failed; fix conflicts and then commit the result
> Yes, this exactly matches what diff showed above -- on HEAD (master),
> 'aaa' was deleted, and on branch, 'aaa' was modified.
>
>> Why it is that? I always supposed that the rename detection was the same
>> for `git diff`, `git merge`. Reading the documentation I do not find any
>> hint why `git diff` and `git merge` are behaving differently.
> Hope that helps...

I would expect that `git merge branch` would detect a rename and the 
conflict resolved automatically. The 'ort' strategy (the default one), 
"can detect and handle merges involving renames." and the default 
similarity threshold is the same for `git diff` and `git merge`. I 
understand that the merge procedure involves finding a merge base, but 
still the rename should be detected between the two heads.

I was reading commit `90d43b07687fdc51d1f2fc14948df538dc45584b` of the 
git source code (which I found using `git log --grep '--rename-empty'`). 
It says (among other things)

This patch lets callers specify whether or not they interested in
using empty files as rename sources and destinations. The default is
"yes", keeping the original behavior. It works by detecting the
empty-blob sha1 for rename sources and destinations.

It is related, but I don't think it is relevant to this specific case. 
Even though the `git diff master~1 master` doesn't detect the rename 
(the content changed too much compared to the empty file or one was 
empty (although it says it defaults to include empty files as rename 
source or destinarion)), the rename should be detected between the two 
heads, even when merging. I tried to read at 'git/diffcore-rename.c' but 
I'm not very good at C and it would require me a great effort to fully 
understand it.

So, why `git merge branch` is not detecting the rename and not resolving 
the conflict automatically? Does it use a different diff machinery 
compared to `git diff`?

