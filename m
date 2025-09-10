Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972032033A
	for <git@vger.kernel.org>; Wed, 10 Sep 2025 01:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469382; cv=none; b=vBvUztulIyjVQhwgQ8cJX8q7UyEh3dOO/x9nDFgyQeTZSPn3hlfdqh0KAC22L7fCHob/L+FwaKqQMCUwa94bQa1YR0pBgEosbuC++rrDcmLbJ6LOnEhTWeFg0wMp0JBam9bgzM7BTNB8xdJTtLCX3x829g8kRGiP3SkaeufmDvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469382; c=relaxed/simple;
	bh=O2Utw86lsg3dEDdhXQeu4oiBY7pXGy9au8uggyJ7yvI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PfCIuc+OCOur6bGWBLqYJk5eUomM5gZV+0cIaMVmuGLB1Z793Aecnhr4WdtFTK8knCJJ4VtmJYOeOR7uMJmAD+xH2aKwigN0qi3mjZ6AfQWn1ve4IRAgG5ncXZd+nAvIesIJuAExW4L0YgMbe2uiPFiH5bJ90P+VPzXGZAtrtiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=JUUxD2SY; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="JUUxD2SY"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1uwA4D-00HGQ1-1d; Wed, 10 Sep 2025 03:56:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	References:Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=t5XhHM9tO3K+cpuwHA/PS5RHBYZ5PrPmLHcIJg+Wzdc=; b=JUUxD2SYcQn7GtQpVdh6owutIL
	HEGxDHOGGtzT/9/k6syNwbGKvEhGbwnMpkWaFmcuOcgzCZ3Qr8Pop9YkiKA3INSXYOkVc2LCkqSek
	QMLaoo625ig/F9eputWKISsbdLhtfJqYc7+bwUe/zciVSzAfj5ZyKm3irrYiyIhpCqqTH9NG4TJZL
	ghYuQpXr8XNMtQTH+/ZQZRXpo8+tD7EBuFQRCxZjd5ZCXRzI/en9/GmfolIKlSSGRuuXXOFBdUOJ7
	uC4dlZs2x6kCTDiSzvh9JbcsTtWP7dDZbAkhDG6Tqe9xyuOGUgRxo8ZZ1Pb9lUNNvtC1Ito020enV
	kEoK1ddw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1uwA4C-0002mK-3S; Wed, 10 Sep 2025 03:56:12 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uwA4A-00FQ6c-Bj; Wed, 10 Sep 2025 03:56:10 +0200
Message-ID: <8d341a51-2135-4c62-9df1-5be351e73275@howdoi.land>
Date: Tue, 9 Sep 2025 20:56:07 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Colin Stagner <ask+git@howdoi.land>
Subject: Re: [PATCH v2] contrib/subtree: fix split with squashed subtrees
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: Zach FettersMoore <zach.fetters@apollographql.com>,
 Christian Couder <chriscool@tuxfamily.org>,
 Patrik Weiskircher <patrik@pspdfkit.com>
References: <20250824191048.1938340-1-ask+git@howdoi.land>
 <20250905022728.940664-1-ask+git@howdoi.land>
 <b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
Content-Language: en-US
In-Reply-To: <b78639ee-021d-49fc-8b8d-0140ed8fc010@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Phillip,

Hello again! I have adopted your recommendations everywhere except for 
`git checkout @{-1}`. Details below.

On 9/8/25 10:21, Phillip Wood wrote:
> On 05/09/2025 03:27, Colin Stagner wrote:

>> +    while read -r trailer val
>> +    do
>> +        case "$trailer" in
>> +        (git-subtree-dir:)
>> +            subtree_dir="${val%/}" ;;
>> +        (git-subtree-mainline:)
>> +            have_mainline=y ;;
>> +        esac
>> +    done
> 
> We do not use the optional '(' in case statements

Will fix in v3.

> 
>> -    if test -n "$(git log -1 --grep="git-subtree-dir:" $rev)"
>> +    if test -n "${subtree_dir:-}" &&
>> +        test -z "${have_mainline:-}" &&
>> +        test "${subtree_dir}" != "$arg_prefix"
> 
> What's the idea behind using "${var:-}" rather than "{var}"?

I write a lot of shell scripts that run "set -u" (aka "set -o nounset"), 
so I do this a lot when testing for empty vars. In this case, it's not 
actually necessary since `have_mainline` is explicitly defined above. 
And we don't run `set -u` anyway.

Will remove from v3.


>> +test_create_subtree_add () {
>> +    (
>> +        cd "$1" &&
>> +        orphan="$2" &&
>> +        prefix="$3" &&
>> +        filename="$4" &&
>> +        shift 4 &&
>> +        last="$(git branch --show-current)" &&
>> +        git checkout --orphan "$orphan" &&
>> +        git rm -rf . &&
> 
> If you use "git switch --orphan" that clears the worktree for you

Very useful. I'll start using it in v3.


>> +        test_commit "$filename" &&
>> +        git checkout "$last" &&
> 
> I think this could be "git checkout @{-1}" and then we'd avoid having to 
> run "git branch" above

I experimented with this, but I couldn't get it to work on git 2.44. 
Although the reflog shows the refs I expect, using

     git switch '@{-1}'

dies with

     fatal: invalid reference: @{-1}

checkout doesn't work either. Perhaps there is something about --orphan 
that is messing up the history.

I could make `test_create_subtree_add` take a mainline branch name, 
but... unless there's something unsound about v2, I think we should just 
keep v2. `git branch --show-current` looks like well-defined porcelain.

Any other ideas?


>> +# The test covers:
>> +# - An initial `subtree add`; and
>> +# - A follow-up `subtree merge`
>> +# both with and without `--squashed`.
>> +for is_squashed in '' 'y';
> 
> no need for ';' at the end of the line

Fixed for v3.

>> +        subtree_test_create_repo "$test_count" &&
>> +        (
>> +            cd "$test_count" &&
>> +            mkdir subA &&
>> +            test_commit subA/file1 &&
>> +            git branch -m main &&
> 
> For tests that depend on the default branch name you can add
> 
>      GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>      export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> 
> to the start of the file before it sources test-lib.sh.

GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main looks very common, so I'll go 
with that for v3.


>> +            test_create_subtree_add \
>> +                . mksubtree subA/subB file2 ${is_squashed:+--squash} &&
>> +            test -e subA/file1.t &&
> 
> We have test_path_is_file() for this which prints a useful diagnostic 
> message

Fixed all occurrences in v3.


Colin

