Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BC192B86
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 16:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487237; cv=none; b=k/EcKmykJ90d68J73QxiTjKtp6KAQ/Dk+cJmoE3Tsahn0qGdYV0zHVBWBarCU1Og0PIgrP5X4VFjz39pY9wyW9JArI8tbC40lzXub4hRxp6ylzQYcssPvIXgcFmwP3cSm8uRHH2NKMzyAp4JMZL1Ss+F86pIbLMyL+KTMMkcNpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487237; c=relaxed/simple;
	bh=ocChtP3kwqbnxzC19ZeMMIjwDvD/Ds02Wj1PkJ9ZzSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tssG4bI5ots7I4K6AhPGtqAKwuExsRT2viVCX8gS2kcx5BhkuwmLKvCkca0KHQ8ru1KI6M+0bULo8eVAtSYOFXd/cieryg1G5WyOYl2HTW1h4f2gBzDYbL00Ac4oAFnPxAkdqutX8hCQAmwuwbuhWS1YxFza6LsR6QXvSf3k2AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndRvRNAr; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndRvRNAr"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2a9ef75a20dso1162121fac.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742487235; x=1743092035; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u/lXYDpeZkhjU2G3Z56xZL4pqlos+H0JbpOQfxuz9DA=;
        b=ndRvRNArx+xBvtt6bJEnMS1qdaAD/f2J13GiR8ugdT9GJuKnqphX4FeOCBwG7nVONv
         tnaOIEOSODulr6lzA9tOOXbISMnl3UcU+57L6xD7OmccQY+5rimHrvp3VQ0/JQGZ5jt5
         96x+uHmhi05yrTzf7VdT1m5PLE5/AD29mS90GmlhFCleORlV1GlL/nKntdJW7NtPwdQg
         UqjAow6f4Wy+H5o0nhSgKYz6D6rtxZqXrVY5AAwM0ondUgzfIqd+nhZYl1IJjCZyNgn4
         WAHm5n3/UCNhFat+UuWAslCc+codZCsCwv6Ak/oY+Sxq+FAnr2BWcmwFPAUUBhfh/bLr
         U9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487235; x=1743092035;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u/lXYDpeZkhjU2G3Z56xZL4pqlos+H0JbpOQfxuz9DA=;
        b=wSFJPv2Sbj9Yjx+FxJnJyYz//Sf0FdK3utNCzH3sQzKxFANvOqXFQ5eGL9ZMf44OrF
         DDXnHCPZxFu8E7QboZBtSpSljGqn0Y1lAfgxwavBXoV9cQUmU1Iz1J7YY/z2vqfc5MXJ
         wb7K4OVgSIr8kSicZ4CekWV6XZ/NpivGXr9muN956YOwbURaVwrYfvLDmUiK9jaLtNTd
         Ntxn8nUcJ9U9WSd26H6Yc+J0HfZOPvEsinbbYCu8Q6Vf9Ge1VuKCLo5BHzO/OhxYb9J4
         CEm6HvRXYKwN1/uIW/00Q82FGpsIUGLFE2YUq6ZMffDCbf9gRxINXRh3oS4Mls7otQ0z
         Os8A==
X-Gm-Message-State: AOJu0YxYncrGlfR41V3BvpndBV2QWoaIzkTfrtZMsHGkFCOSCxOz4kGK
	Cm/VI50pRwyne6o6/X5JH5LxhEGYI/TJ4mq9BPsA5KsTagVETKlTRltHHg==
X-Gm-Gg: ASbGnctvngCfSa8nnGJZrJoY1ebiMab4cF3MNSQECtZFOlfDt7eoPTM5gi6cjdRoAmy
	RA/lKOCBeh/j5kUmVl3qZCHLATEZMYYlLI62TC6OBj3AY7BzJwn4TkzI5CwykqYDHumwS9107aD
	6pn/EObRlZJSGLUKxtCE6XgRekspaIVZBRPfBn29c3WueoEdlEKEB3qEjHRF99YnJY+qE3BbKVB
	b0X7x9wf7f46To93l+WPbSuFhQrUh9/+ch36DR8/4PJxTmLj7gxwOH9nAZfgQ5Z8UDICIlzSyld
	oGWlbOrTsEHR3tbqTn7gwWTo2Wh6mXwK7/eaFw==
X-Google-Smtp-Source: AGHT+IG0iVgE24Ll115AcVWxDGNwdcItq+WU5WPRZqfV9mtYJ3jHiZuJPXtsTcuAG/crGIlF+EXF0A==
X-Received: by 2002:a05:6870:b4a3:b0:2c2:5ac3:4344 with SMTP id 586e51a60fabf-2c7802d4dfdmr78728fac.15.1742487234513;
        Thu, 20 Mar 2025 09:13:54 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2c77ec51c0esm30545fac.17.2025.03.20.09.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:13:53 -0700 (PDT)
Date: Thu, 20 Mar 2025 11:10:19 -0500
From: Justin Tobler <jltobler@gmail.com>
To: =?utf-8?B?5p2O6JG1?= <likui@oschina.cn>
Cc: git <git@vger.kernel.org>, ps@pks.im
Subject: Re: `git fetch origin --prune --atomic` core dumped
Message-ID: <g4baz2kt25ysb6wcesoqxhvw2ooxkmqio3dj6b44h6gt5l6z3r@rocsjlys5nqs>
References: <37599b30-dee2-4a36-8129-04fe5f6b633e.likui@oschina.cn>
 <e8789a03-41ea-42e2-9f2d-5124b849277a.likui@oschina.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8789a03-41ea-42e2-9f2d-5124b849277a.likui@oschina.cn>

On 25/03/20 04:36PM, 李葵 wrote:
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>   ```bash
>   git clone --quiet --mirror https://github.com/git/git-merge.git git-merge.git.git
>   git clone --quiet --mirror git-merge.git.git git-merge.git
> 
>   git --git-dir=git-merge.git.git branch test main
> 
>   touch git-merge.git/refs/heads/test.lock
>   git --git-dir=git-merge.git fetch origin --prune --atomic "+refs/*:refs/*"
>   ```
> 
> What did you expect to happen? (Expected behavior)
> 
>   Without core dumped.
> 
> What happened instead? (Actual behavior)
> 
>   ```bash
>   $ git clone --quiet --mirror https://github.com/git/git-merge.git git-merge.git.git
> 
>   $ git clone --quiet --mirror git-merge.git.git git-merge.git
> 
>   $ git --git-dir=git-merge.git.git branch test main
>   branch 'test' set up to track 'origin/main'.
> 
>   $ touch git-merge.git/refs/heads/test.lock
> 
>   $ git --git-dir=git-merge.git fetch origin --prune --atomic "+refs/*:refs/*"
>   From /tmp/git/git-merge.git
>    * [new branch]      test       -> test
>   error: cannot lock ref 'refs/heads/test': Unable to create '/tmp/git/git-merge.git/refs/heads/test.lock': File exists.
>   
>   Another git process seems to be running in this repository, e.g.
>   an editor opened by 'git commit'. Please make sure all processes
>   are terminated then try again. If it still fails, a git process
>   may have crashed in this repository earlier:
>   remove the file manually to continue.
>   BUG: refs.c:2435: abort called on a closed reference transaction
>   [1]    1298748 IOT instruction (core dumped)  git --git-dir=git-merge.git fetch origin --prune --atomic "+refs/*:refs/*"
> 
>   $ ls
>   core.1298748  git-merge.git  git-merge.git.git
>   ```
> 
> What's different between what you expected and what actually happened?
> 
>   Without core dumped.
> 
> Anything else you want to add:
> 
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
> 
> 
> [System Info]
> git version:
> git version 2.49.0.rc1.120.g683c54c999
> cpu: x86_64
> built from commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 7.81.0
> OpenSSL: OpenSSL 3.0.2 15 Mar 2022
> zlib: 1.2.11
> uname: Linux 6.8.0-52-generic #53~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Wed Jan 15 19:18:46 UTC 2 x86_64
> compiler info: gnuc: 11.4
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /usr/bin/zsh
> 
> 
> [Enabled Hooks]
> not run from a git repository - no hooks to show

I was able to reproduce the reported bug with the following:

    git init foo &&
    git -C foo commit --allow-empty -m init &&
    git clone --mirror foo bar.git &&
    git -C bar.git branch test master &&
    touch bar.git/refs/heads/test.lock &&
    git -C bar.git fetch origin --prune --atomic "+refs/*:refs/*"

This bisects to c92abe71df (builtin/fetch: fix leaking transaction with
`--atomic`, 2024-08-22). cc'ing the author.

-Justin
