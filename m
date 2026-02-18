Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE1332916
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424335; cv=none; b=NQ7DcqAxqVzw7x1iSvJhbc8jM0DgpEF+dsfPo4evGjzsjcN6t7H+yB9I3YBzeGMnc7oZbPDQ3/Jqm44I6bAEhFa7e+t5ieaN6q3NmCIIhmpQJJ27lVVsf906kcmHToQttyAINH5btu4YUFg3yHHh33d6MHartnEpNYKU9D8IETY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424335; c=relaxed/simple;
	bh=rrCh4Ka5CmxdEGvf42ObL1/2rf76gbva0P0cL7PBGbA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fRt/AyqaPTxNjANsqAY38MUvHEaA8th4YVAlHJPblZ3MGsiB2sOSNXQmUIcIz+/ajAZQOkv7XPiq599kKuEylliPWQvdCWEkjnS7MCgMdDby2zhbE45H+n6U0/co4DampL7JNGnfUJWR2Unv6NFCaiBOgR6o/JBd8TfmQtLn9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EExp/spn; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EExp/spn"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso62768065e9.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 06:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771424332; x=1772029132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m/aaSslU8FylyxLS/LeM4Oc79564f767f0enGH3ku+k=;
        b=EExp/spncHraAw/0eePMqJJrZ8/xRfj0DRv2tv6Ocix7aoj0MBcWKgUjay8y8xQ3Vs
         /nESGVUf2WI+zr9rb7BagaLG4Oajlco+bX2Qlgb+jqkvCZpgU0vcP8b951mzCZ7A+5WM
         TZbeickSE/lDMFT4/zu0ydMwfy3l8JL1OMIBnR0k/olciB/NqOiaJXKpbqi1YhOW6c5n
         k7WS9kzaBW2sREHNj8ZoGMAaUo6GQekbitCzn5TBwnZltIEOp9DehHLPhZsaFBXJx+Q7
         kzEIikRxwvESv2Zxm0jbbTdKBZYokh00TcQ2zwGToLtwk/O720ZdaiNhCUAq9v00HlSW
         DYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771424332; x=1772029132;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/aaSslU8FylyxLS/LeM4Oc79564f767f0enGH3ku+k=;
        b=GC5yEQE+RUSusmPI2MXDK0+UVYJsfOost3ekXJ5q5tKPOeZ3AjHdTIPLloFpa3Sm+e
         MMS59wlcexK7EH4KpLfHXYnewWSO+/GpUF5pNUmLSXVWRm0wNZSvBYd1srJn3n/kCR6i
         +SPafnQ9+LV+p6pkp2qBvJ0SH5rr44iaRZpoaSy0tdN8/oFOmSUI0SXm6+0kJ8HUErTc
         +Sox0OylzmMVY9J6Y705y1D1NCfZY8GAs+RU227vu3aT59J7KLR4Z+Ob4PljqS6Rb9jc
         zYxNC3NqoceIveqBc2tRJuR4tlJCBQrsCz0+IGZHChwZN3+sw4hJ35NW0T0r50M9y9V/
         oMAw==
X-Gm-Message-State: AOJu0Yx3Ho7Vi3FfLk51QVbz+J5l1rDaLMsy1mm4Qgxp2TrN4zHli9E/
	ZR0nBtbax/jOg2rW6gIOgrnCVO0IIFm5c6wx+F22OJuPfOvvQs7bJf/N
X-Gm-Gg: AZuq6aJdu22hDVRWZDanhfPmFE3sRsow5wCZXUpGSRlurk/YSXpgG61W9bSb/Ty9Swq
	sfQpnbImvlTpVKzKGdd8V0VUXIZp23li3AVDsx9zHUEkXpkP1pxAkNbEIxQmlfQSQhYA6OPgzIZ
	f08xSqQfatlpE8h5KsFFKO9Kjft95ylYczAbh3ncqPfx2RdevzbqWOhTxLervgncNXpcJdVh0rh
	Q44NNdopn9K+ETgH/UX/Ghfm0Qb//GYnsGau0vPV3IdId+qZoAhq7h1FMeI9Q07SxqV6yfNShB8
	e5N6xJpp2A6qjyUg8ZEI82CU89L/H5YV+1D3Smqc3F30RjePmCHL333sgkFvHcMEo1ivT2vPTEV
	oO+cci9eZwRIrxxg1vxZUOu0CKAUJhBGmaluPiFtxz4GKeCPNHdOA26/xAwov+stemZJzzmo+W3
	F4Ifs7/H5VUn+/ETckqeXQUe7uFg3Sq4VsOii01ctPTTVsNr2xErvvRvPUeule4tJkHnblbpN6D
	+GnrA==
X-Received: by 2002:a05:600c:820d:b0:47d:403e:4eaf with SMTP id 5b1f17b1804b1-48379b9f278mr270215865e9.10.1771424331441;
        Wed, 18 Feb 2026 06:18:51 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5d78cfsm853757885e9.1.2026.02.18.06.18.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 06:18:51 -0800 (PST)
Message-ID: <f03fa5a8-b408-4b4e-a254-b0a39b87e636@gmail.com>
Date: Wed, 18 Feb 2026 14:18:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
 <xmqqa4x7cile.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa4x7cile.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/02/2026 18:47, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> In preparation for removing the repository argument from
>> worktree_git_path() add a function to construct a "struct worktree"
>> from a "struct repository" and use that to avoid passing a NULL
>> worktree to wt_status_check_bisect() and wt_status_check_rebase().
> 
> Hmph, I am afraid that
> 
>      "Construct a struct worktree from a struct repository"
> 
> is not quite sufficient.  A repository can have more than one
> worktrees, so if you give a repository as a parameter, there needs a
> way for the implementation of this helper function to identify which
> one of them to construct a struct worktree for, and more importantly
> for you as the caller to be able to expect which one the implementation
> would pick, and what that particular worktree among many _means_ to you.
> 
> I know that the implementation uses repo->worktree but what does
> that path mean in the world-view of the worktree API set?

While a repository can have multiple worktrees, a "struct repository" 
points to a particular worktree within that repository via the gitdir 
and worktree members. I'll try and make it clearer that the function 
returns a struct worktree corresponding to those members.

> I am guessing that it is what the worktree API calls "current", but
> if so, perhaps the function should be explained with that word in
> it, and the function name should also contain that word, no?

That's what I thought initially. However is_current_worktree() is 
defined in terms of "the_repository" rather than "wt->repo". That means 
all the struct worktrees within a single process agree on the "current" 
worktree but it is suprising that if "wt->path" matches 
"wt->repo->worktree" it is not necessarily the "current" worktree. I'm 
not sure if we want to change the definition of is_current_worktree() to 
use "wt->repo" rather than "the_repository", but if we do I think we can 
do that separately.

>> +struct worktree *get_worktree_from_repository(struct repository *repo)
>> +{
>> +	struct worktree *wt = xcalloc(1, sizeof(*wt));
>> +	char *gitdir = absolute_pathdup(repo->gitdir);
>> +	char *commondir = absolute_pathdup(repo->commondir);
>> +
>> +	wt->repo = repo;
>> +	if (repo->worktree)
>> +		wt->path = absolute_pathdup(repo->worktree);
> 
> So, if the repository instance knows where the worktree is, we use
> that to wt->path.  Otherwise wt->path is left NULL.

That's actually a bug, we should be using repo->gitdir when the 
repository is bare.

>> +	wt->is_bare = !!repo->worktree;
> 
> I may be confused but don't we have one ! too many?  If we have a
> worktree directory, "git checkout" would check the files there, and
> that is not quite a "bare" repository, no?

Yes, it should be "wt->is_bare = !repo->worktree;"

>> +	if (fspathcmp(gitdir, commondir))
>> +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);
> 
> OK.  So gitdir and commondir would be the same for the primary and
> for everybody else we'd have "id" as the last directory component of
> the commondir.
> 
>> +	wt->is_current = is_current_worktree(wt);
> 
> Oh, so I guessed wrong and this is not about "current" worktree?
> What does the directory pointed at by repo->worktree mean to the
> callers of this function?  I somehow thought that is_current would
> be always 1 here,.

As explained above "repo->worktree" means nothing to 
is_current_worktree() because it uses "the_repository" instead of 
"wt->repo".

I'll re-roll with the fixes above and a bit more detail in the commit 
message about is_current_worktree() and the that the "struct worktree" 
instance corresponds to worktree that uses repo->gitdir

Thanks

Phillip

