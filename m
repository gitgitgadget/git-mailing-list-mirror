Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7D558AC4
	for <git@vger.kernel.org>; Tue, 14 May 2024 10:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715681225; cv=none; b=TrLGXjU6s1kSMqJ26ZP1foKbxW3M4X829gxSs0rZL/6ZME0eO7XksqbkMUb+xZC9TqjeXh82joToOHnhHaM3L8A1DWyVvpDgdyihsJ7w4N0NLLpBSD2CpgDOMknpBUGdTd4gtqNQUJLAcCmLbpE2odswts+Opx3jB2wBENwsTAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715681225; c=relaxed/simple;
	bh=R1yxXJZujeikTkqjjKlSJlKuNyFvzoWHYwmUoY4J+NQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NhLWjObDbH6MP6nSTEVkbpT13tNy4ZL8HDdtNIz//Eq2Vfe6ft7xGgnn6ZP23hr5nI7hUtknyQlKYp0m4dcb8I6fEb66QBTU8YhEOCs40myzbtO1wa50wQPGfuClrndkuyfh/GYc6k1+uOeJ4n0RaOw330B+gSNtzR6t/naM8dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IB9PrSt5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB9PrSt5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41fd5dc04f0so34189975e9.0
        for <git@vger.kernel.org>; Tue, 14 May 2024 03:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715681222; x=1716286022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h3r6w4x114VtFq2xVOR3CpetfuRlqIdxKA2t01piPH4=;
        b=IB9PrSt5jh+MEFKsBEEKJgptI+JetnGnBxmfc1eCZAjI+81e0SNuKcwxdR3r87Ldgm
         3n/QjWTaGnGfHwslGpoSsF20GV/tP+1Da6dC1G2nXbu6bHbVqUzQL1jqm1ObW4U4PmVt
         JPwXIwksG4jrPb0HeWZKS1GniLMp6sv0+clPUNlsZakJxpMtFZqxUi0agTVdlRrl/T76
         RZaM19K34UjnSpmfWPjGyhJ9DeFn5kjc1TN58unrCbeXEIPUjzPA6be8Jcuyy8OZkDdq
         8MZOvcpD1ep76pHIis0j44YrNivtEy69sNbbTrlBfYiO2cXTdyBRMqvgZD5kZBt8bWes
         NBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715681222; x=1716286022;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3r6w4x114VtFq2xVOR3CpetfuRlqIdxKA2t01piPH4=;
        b=tvwFxJ6T3FFoWWoiWxBghDIazgJ5bTUn/b6hFw2HYX6MmvxG+8yFqR83Nyl8/6YhNa
         szh/om54/Mf57Q0+Tlf5SPYJiCaoLb9W2xwW06OEv+sCNE6kNAhQIEzZSpxDs0WbZ9F/
         qnQTi5svkFxHy6Dmz7EJqOwXalHmh2coYwn8UdQn1EMdJQDcoWM046Hc4JqUzH6ZlsPZ
         4BWM3HwIX7FGQzYb4S3P+ukFQKmC/ShiIbkJ9HtGU0UMxO8VDyL7Wmitd/eYAx5d71B9
         E4ltSwaQEgb366TLinrx6MQPbBzvIjzfx01NbyXOPtHHpS7yi3b6Z7B7HUqt1Pu2ZypB
         ET/w==
X-Gm-Message-State: AOJu0Yz37+zOALC5ECJ9rGJlaqf/n7nZAUPvjrRumuQj9BUpHRrE+DKE
	ixXJvquG6VFH91PgcylKi/WYOIbvTyWuFhvAmFfCl6EZZbGFotq8
X-Google-Smtp-Source: AGHT+IHCi3MiROhJEZDs0Zb3XDcrq1U7e4ZGyQ3S0mkAgji7kehUB592CQ+lLlJioVovfAE2LiWW8w==
X-Received: by 2002:a05:600c:4f93:b0:416:7b2c:df0f with SMTP id 5b1f17b1804b1-41fea931f13mr112866325e9.7.1715681221814;
        Tue, 14 May 2024 03:07:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm193750415e9.34.2024.05.14.03.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 03:07:01 -0700 (PDT)
Message-ID: <89b83e3d-dd38-4b3b-8f87-6ac739e4e12f@gmail.com>
Date: Tue, 14 May 2024 11:07:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Checkout to different directory at certain commit without
 changing index
To: Ondra Medek <xmedeko@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
References: <CAJsoDaEJn1Y0CgtxpkGqVRsTiDnMxjNFrtbTuUVOvT87N23JNg@mail.gmail.com>
 <13fa579b-8987-4430-967c-42b9de8acb6d@gmail.com>
 <CAJsoDaFhTcm0fEw3+Ba4PvTjPYxscALeLN2kBgs4YYz8Bg-R7g@mail.gmail.com>
 <CAJsoDaHu1xgfwXHqOGgctQoi5Qb5D1aESeMvaVHaQV0zjyzRRg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJsoDaHu1xgfwXHqOGgctQoi5Qb5D1aESeMvaVHaQV0zjyzRRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ondra

On 14/05/2024 07:29, Ondra Medek wrote:
> Hi Phillip,
> 
> your trick with different index file works with git checkout, too, e.g.
> 
> GIT_INDEX_FILE="$destdir"/.git git --work-tree="$destdir" checkout -f
> -q "$commit" -- ./
> rm -f "$destdir"/.git

I'd not thought of that, presumably "git restore" would work as well. 
Using "./" means it will only work from the repository root, you can use 
the pathmagic ":/" instead to checkout everything when it is run from a 
subdirectory  but you need to make sure GIT_INDEX_FILE is an absolute path.

Best Wishes

Phillip

> Sincerely
> Ondra
> 
> On Mon, 13 May 2024 at 19:23, Ondra Medek <xmedeko@gmail.com> wrote:
>>
>> Hi Phillip,
>>
>> besides dependency on tar, I do not want to use git-archive because
>> it's influenced by export-ignore and export-subst attributes, too (as
>> I have mentioned).
>>
>> Thanks for git read-tree, seems it's exactly what I need. Just git
>> read-tree has complained that -u switch needs -m or --reset switches.
>> And I have simplified it to
>>
>> git --work-tree="$destdir" read-tree --index-output="$destdir".git -u
>> --reset "$commit"
>> rm -f "$destdir"/.git
>>
>> May I post this solution to the SO thread I have mentioned?
>>
>> Thanks very much
>>
>> Ondra
>>
>> On Mon, 13 May 2024 at 17:28, Phillip Wood <phillip.wood123@gmail.com> wrote:
>>>
>>> Hi Ondra
>>>
>>> On 13/05/2024 08:26, Ondra Medek wrote:
>>>> Hello,
>>>> I need a simple script for unskilled users to do a fast checkout (LFS
>>>> friendly) of the current local Git clone at a certain commit to a
>>>> different directory I.e. something like "copy at a point in history".
>>>
>>> I think using
>>>
>>>       git archive "$commit" --format=tar |
>>>          { cd "$output_directory" && tar -xf -; }
>>>
>>> is probably the simplest solution. If you don't want to rely on tar then
>>> something like
>>>
>>>       GIT_DIR="$(git rev-parse --path-format=absolute --git-dir)" &&
>>>       GIT_COMMON_DIR="$(git rev-parse --path-format=absolute
>>> --git-common-dir)" || exit
>>>       GIT_INDEX_FILE="$GIT_DIR/tmp-index-$$"
>>>       export GIT_DIR GIT_COMMON_DIR GIT_INDEX_FILE
>>>       unset GIT_WORK_TREE
>>>       mkdir "$output_directory" && cd "$output_directory" &&
>>>       git read-tree -u "$commit"
>>>       status=$?
>>>       rm "$GIT_INDEX_FILE"
>>>       exit $status
>>>
>>> Which uses a temporary index file should work (note I haven't tested
>>> it). You may want to add "--recurse-submodules" and/or
>>> "--no-sparse-checkout" to the "git read-tree" commandline.
>>>
>>> Best Wishes
>>>
>>> Phillip
>>>
>>>> IMO all possible solutions are summarized in this thread
>>>> https://stackoverflow.com/questions/160608/do-a-git-export-like-svn-export
>>>> I describe some of them with my remarks:
>>>>
>>>> - git checkout-index : works with HEAD only.
>>>> - git archive: influenced by export-ignore and export-subst
>>>> attributes, so may not produce exact copy of sources. (And needs tar).
>>>> - git worktree add -d : needs cleanup: git prune or git remove.
>>>> - git clone: Unfortunately, -b param cannot work with commit hash and
>>>> does not respect local worktree settings (e.g. autocrlf). So, a
>>>> solution may be a bit complicated: git clone -s -n . dest/path ; cp
>>>> .git/config dest/path/.git ; cd dest/path ; git co -q <commit-ish> ;
>>>> rm -rf .git
>>>> - git checkout: Unfortunately, modifies Git index, so some action to
>>>> revert index is necessary after: git --work-tree=/path/to/checkout/
>>>> checkout -f -q <tree-ish> -- ./
>>>>
>>>> For me, the best solution is with git clone, because it does not
>>>> modify Git index nor any source working tree settings, so no cleanup
>>>> is necessary. But it's a bit complicated, though. It seems to me that
>>>> "git checkout" could do this better and simpler if it would have some
>>>> param to not modify the Git index. Is it possible to enhance git
>>>> checkout? Or is there any other simple solution not mentioned in the
>>>> SO thread?
>>>>
>>>> Thank you
>>>> Ondra Medek
>>>>
