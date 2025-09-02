Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B040D2F8BDC
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819344; cv=none; b=OItaLIjgBKlSEWnNHd7w2kR5QqjR38Ae+7eJ2jhKWaeyH3Swtl3X4uvHXpSkOLBsgmrbLfjIlsJNFxh0HtqxJUKYHF816zo0k5ciul3aYpus/1LkmkDC/dgiJNAMYQ8qm+PXXsZWkhHYZmU0RRZxFo/JRsOgrB3TndYnEKg93nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819344; c=relaxed/simple;
	bh=LWs6dMrGL+1B/QTf1lgjE2sz+TqTKJoeITs1rh7uy6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KaReasCvvTmJFCxRLX0N+/0N7oqfub7IiusIvPKCqRdlrPVEDKS/1IRvi5+ZPcDIffnhS9RnRz74q8cpWzc/bsQGL3RYD8uN/IAeDaeb7sziovM7GH5rPfZti9rAeso5Sz0XxsieR78eyO/OiuM1HByNYT5m5Bl63NFOoaxJU1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5rBOubg; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5rBOubg"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d118d8fa91so748459f8f.1
        for <git@vger.kernel.org>; Tue, 02 Sep 2025 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756819339; x=1757424139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FUXunKgmlVW8hM0OdxS76ADP3unjcFDYVTgk9IbZ6Lk=;
        b=l5rBOubg1mUGzQFJsnBPZnFCMY7Tf3LNrVI04XzGd32lCB8AJr3joTZVMrjKorxL/V
         Ym+tE+lNZ+oOVoxD8nhszS9F1W2XvS90Sol6MrsHIH/JNMXuxTFv9NrQw7MiZh4hdbQE
         g0apM5JnIRwsMzq1MlJmBARboJFZ8o/2DZapqhjqqx2pO6lE7EzkP+65mic/IghJ7JQ2
         unW8l28anWX2PODCbMf1zl7HJxFXAvkHVt/kPBblp78jYCmndaW+5LrDc7CUaavrC0k7
         wGQZioeYXaNayiVO//6h+Rx2zgiys2w2zrCNxVChUtJaHy5viV0xrObpz2iIq6rmdBye
         MkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819339; x=1757424139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FUXunKgmlVW8hM0OdxS76ADP3unjcFDYVTgk9IbZ6Lk=;
        b=SKqYm0UzmBkMJW7vhcnjrWBpi/QVXQPL/CQxbP6vPpdrZzbGlihwQI9nhET874s/Fh
         SXd37qGRaP3NHU5+QGZ7UTbo15eHoaXhjNEjA9iIHUwWP3dgthVdEyvy0ydLE3pAGGc/
         /ukjyW+GZ0iLXuELjrHiOfU9a20ajLpe0v8gyanK/JfFS5ElRDMUzQdRt9ujzk5Fh2Se
         tRLJXGQ98z2Ir2UlhBWJvN/6Wt3RGEx6yTFOwF/ixIvCOb/Alzh8iAxoOQ5ZRAc6/lYG
         tEe9lGxNBZObti0mZWRwrxaPIDQWk61WHP7w4ofrMzPEN2fkSbqsLelrSsMXlww1jKtf
         Vj/g==
X-Forwarded-Encrypted: i=1; AJvYcCUZRzR6sWbouzVpjmxEx28+LH9Ppp28lmwk9kXudAZ0LJUZAzy8Nn454b3vRHeefhWNjVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbcHHs6RvWIRMpLtPt+ZmlsMBBXymyZGNaRgIpakS07p3GR20i
	0Mh0MaK7c73VyEMM6djpifaPC90aPgkZjahUCv7zExGTLQOOA0sk09JQ
X-Gm-Gg: ASbGnctQxq+RcTnYrg5lLUNqpDVfUZMsyJrD9EczsGSB6ZWapkrd8SMchetYoR7J9fD
	Dt6xlnSGaY00eAKR1sCQczZwKNTnwD+4o+8XuMVNq0WbC0npNQnLFUjgyEe1Zh806ywJaTJadhp
	BwdI1AZMcN6+EtgQtb5L/CzCUAEDITr8pNk8rl8KlkrJodAuOCH8+R0gyv52c1dXzXSjF8qNtbd
	Yjl9kINdLc0bmYf4p5Kpq2pYn4MGazMOxXxDD+6NweXgeNM6PcExFaSwpUq4EE18ODPEyhDH6Yy
	Sx0nyjX0t67TmFxlxFeaQbHKa8Q4JwQ9CdosY7jZgMbbGFvGEAcLfnTkuer87u8vc/N0f8JbMOo
	vA4obFRg1dZOTI6CLGNTTriifnbCs4BU8a6cR7m/micWDBus92DH30KGmFVlXVxPLx2EiPnhH4d
	ivurfj4jk4cAajTII=
X-Google-Smtp-Source: AGHT+IHSqZjnet9Gf215vwFQaLlzMZLjaxWGsNSFBsn7yVDMAom8pHvCHloZKpGOBEia6xhrP9QeCA==
X-Received: by 2002:a05:6000:258a:b0:3d4:13c4:af7a with SMTP id ffacd0b85a97d-3d413c4b324mr7269087f8f.17.1756819338479;
        Tue, 02 Sep 2025 06:22:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1751:3d01:f05d:321:d745:636? ([2a0a:ef40:1751:3d01:f05d:321:d745:636])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8efb280csm39139625e9.3.2025.09.02.06.22.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:22:18 -0700 (PDT)
Message-ID: <773ed81e-34b4-4116-88de-7e4307b6c679@gmail.com>
Date: Tue, 2 Sep 2025 14:22:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/subtree: fix split with squashed subtrees
To: Colin Stagner <ask+git@howdoi.land>, git@vger.kernel.org,
 phillip.wood@dunelm.org.uk
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <00e76b7e-ce4f-44d9-acd9-466c6b14f41b@gmail.com>
 <ee480c22-0dd3-4c45-a2bd-838c238f1d55@howdoi.land>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ee480c22-0dd3-4c45-a2bd-838c238f1d55@howdoi.land>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/09/2025 21:43, Colin Stagner wrote:
> On 9/1/25 08:54, Phillip Wood wrote:
> Colin Stagner <ask+git@howdoi.land> writes:
>>> -    if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
>>> +    if test -n "$(git log -1 --grep="git-subtree-dir:" "$rev^!")"
>>
>> We could drop the "-1" as we're only considering a single commit.
> 
> Concur.
> 
>>> -        if test -z "$(git log -1 --grep="git-subtree-mainline:" 
>>> $rev)" &&
>>> -            test -z "$(git log -1 --grep="git-subtree-dir: 
>>> $arg_prefix$" $rev)"
>>> +        if test -z "$(git log -1 --grep="git-subtree-mainline:" 
>>> "$rev^!")" &&
>>> +            test -z "$(git log -1 --grep="git-subtree-dir: 
>>> $arg_prefix$" "$rev^!")"
>>
>> I'm less sure about this change. Is the second test checking
>> making sure we don't prune this commit if it has an ancestor
>> that is a subtree merge for the subtree we're interested in?
> 
> The outer loop in git-subtree.sh:983 appears to iterate from the root 
> commit forwards… and not from the HEAD backwards.
> 
>      git rev-list --topo-order --reverse --parents $rev $unrevs
>      #                         ^^^^^^^^^
> 
> Since the iteration is ancestor-first, I'm having difficulty seeing why 
> `should_ignore_subtree_split_commit()` would want to do an ancestor 
> traversal at all. It already sees the commits ancestor-first. But there 
> could be a reason that I don't know.

Ah, I was only looking at this patch, not how it was called. That begs 
the question "what's the point of these checks if we've already visited 
all the ancestors anyway". I think the answer is that it is pruning the 
recursion that happens in check_parent() and checking the commits that 
come from that rev-list command is pointless. The regression test 
introduced with this function only looks at $extracount which comes from 
the recursion. I haven't looked too closely but it would be nice if we 
could move this check so it is only run when check_parents() is recursing.

> Here is a more long-winded breakdown of these tests. From what I can 
> determine:
> 
>      test -z "$(git log -1 --grep="git-subtree-mainline:" "$rev")
> 
> excludes squashed commits created from
> 
>      git subtree merge --prefix subM --squash srcBranch
 > > The --squash creates two commits:
> 
> 1. A single-parent "Squashed 'subM/' content from", which
>     squashes the changes from srcBranch. This commit's tree
>     is like the one on srcBranch. It does not have the `subM/`
>     prefix.
Yes, and the commit message comes from squash_msg() which adds the 
"git-subtree-dir:" and "git-subtree-split:" trailers but not 
"git-subtree-mainline:".

> 2. A merge commit which rewrites the tree in (1) to add
>     the `subM/` leading directory, then merge it with the
>     current branch. The merge commit doesn't have any
>     `git-subtree:` trailers.

Indeed. Running

	git subtree split --squash --rejoin --prefix subM

will create a squash commit as above and a merge with a commit message 
created by rejoin_msg() and contains the "git-subtree-dir:", 
"git-subtree-split:" and "git-subtree-mainline:" trailers.

> We must exclude (1) since the trees aren't actually compatible with 
> HEAD. (They don't have the `subM` prefix). We must keep (2). The above 
> `test -z` appears to do this.

So we'll exclude squashed merges but not squashed splits? I think you're 
right that we don't want "git log" to walk the history here.

> I am *much* less certain about the second test:
> 
>     test -z "$(git log -1 \
>                --grep="git-subtree-dir: $arg_prefix$" $rev)"
> 
> I think this was intended to keep the mainline portion from a previous 
> `git subtree split --rejoin`. But if I remove this `test -z`, all the 
> unit tests still pass—including mine. There may not be any test coverage 
> for this line. I will probably omit this `test` from v2.

I'm not very familiar with git-subtree but I thought this was ensuring 
that we did not exclude the ancestors of a squash or split that involves 
the subtree that we're interested in. I wouldn't be surprised if the 
test coverage was lacking.
>> It would be very helpful if Zach could comment on what was intended here.
> 
> Yes, this would aid my understanding a lot.

and mine too.

>> If it turns out that all three tests only want to consider a single 
>> commit then it would be be more efficient to run a single git command 
>> and check the output with something like
>>
>>      git show -s --format='%(trailers:key=git-subtree-dir,key=git- 
>> subtree-mainline' $rev | while read trailer
>>          do
>>              # check trailers here using case "$trailer"
>>          done
> 
> This is a cleaner approach, and I'll explore it for v2. Any objection to 
> long options like `--no-patch` instead of `-s`? I find these are better 
> for scripts since there's less hunting around in man pages.

Sure, I used '-s' out of habit but '--no-patch' would be clearer 
(especially as I can't see any link between the short and long option 
names in this case)

Thanks

Phillip

