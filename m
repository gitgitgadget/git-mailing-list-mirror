Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963290;
	b=UVu8KdZ42vvnj9UehwPamYaOh2kKDbpWMyhq51+mJRVT1VQBSAEXTrUmdW8UDgJrofu/
	 qo9JyKq5DPdmZjo1TA2QHvxIL0cEePoLqqwwqCMTGFDR9WDjeA3m5JlDGahsGXOgqrZQ8
	 LahRMTdNOqwYb/XbpsWYl3XhKE3T2n9I1xyaMqKsWg8akvYZ7bsrX+PjZAJ6dzbEOmPz4
	 vyluBMbFULZ80KXNIJLMEeW1YRMHPNaFldFCu/01+oCwsw4ldrqlLDY2+mvRbHZe9/Fm5
	 evn8E2jck4vIG85eTOaSKcw3ZPBzVO1kb3SNc0TJqcZ3SVSOgzj1JN69ZC8wic9wdAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Subject:Reply-To:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=JhRwWGKQenl0Q47HgKGmeepxG2B637uYyStzHObsjFs=;
	b=VLUuJWapjy6QYETSqtdYP1Tl5m+aPUv0R59k1bNBfrhPYlFfRLqmaRK/rO8MMw5A3wBU
	 ofkXOcl1ekcxgW6aU/VyjQOopKdhAQo+0XD6NAjbI4EJL9DsTKzFsNxlBA2WiHiXwicIW
	 lyyk7eZBzYgoH/M5qYflHXUeak6fuQMTMU7qnVewDMfb3TUsRFUEyiwQb9q0HSg3Q4Sy0
	 XiztLMVE2jh5X70DCxTPuTGezDkUiWskRApRxUY/STduj89iQnkydK6m23PBq3OGWb7KC
	 kO1ybz7rE/a2wZWBCrt6i+uwnH5VYVnuRGEvV6xdhrd7mJm0e4ealSfF0tPyGrcXpNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rv2TTOeO;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0137606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0137606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rv2TTOeO
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso3968845e9.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 03:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793963288; x=1794568088; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhRwWGKQenl0Q47HgKGmeepxG2B637uYyStzHObsjFs=;
        b=Rv2TTOeOBRipClSAzZETWYt/xX/F9qaM8Q99SDfS69CrfUH+QRnYado3rYJ6hNVktp
         088DhgqFhmZxJzDwbSRmowaEvkAc8KnbsycXl7z+VpOa36Ny8sfRj3SdsR7SdX43ox4H
         kctXMTlkicHJG9Y+vbwiwQjiuqNawa/jfBvenwPNxLeo2Lf3GXvkP8uNc8tRbwSqJ0ER
         2Oq2IJkIpQGFRsU7bN0ZREd4IUqmLIHtEn48SgGK5H9FUF4l7+UNGRCTuscQe6hrWqG+
         ExD9Yq6mpy6Wk9W2GQGH3jP0nhRcwW/CWUl7NC7Bl6mzrffo67ZzqTxGJzp074ZB/wvZ
         Bc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963288; x=1794568088;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:reply-to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhRwWGKQenl0Q47HgKGmeepxG2B637uYyStzHObsjFs=;
        b=vFMaCHOTSfj6JAEdvDXVF5xdDnDEhvELrNRw8nI/C4dBz4FmDpE7vYXCKaepgRmMKS
         R3zZstO/BnOu2NlwALMGrL+NKI6UznFdEmfsHpZ+2SU6YyVf9/vxLVN5nKdGypKJgEIP
         +XHTN6EXqma8OC8MKHpdf34ezkPPXDwbMAdluBjBZhedKwm2/ZCajovOrwVCSy5PX0Ii
         6QMjFPwqcQGqf7ohHRYEGrPUepbcI+goephKLvoFkxnZhkDOVMDz2+3QysPsyGemltQK
         GQlEKG1EMP2qZzw+8wQKN96aWd2uh+AwAMp24WlWNfB4KiTFg5VkMEgmb2FykUNXT129
         pVrQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJ7hcapQszJ9dcFRsEW46TpQYANxyFsnSQSKtYocU+e3PNVe4Fku1EC5uALFt6rF4LWPE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/XztTtsVM9b0HtoGZ3GAVk3TpOJ7QjDCage7Bfi+15Fz9B+blw
	NXxWIVXZ+bANi/7ToPs4OOZU1l4lqqOe4EuopuvlfASUGZtbxWqj2h87
X-Gm-Gg: AYBFou0pqxwHtsQfQe65xBHAnF7JzuHbflskpnK6tqqaXFjqdLDxSihCJx7aroHPF2x
	63uvGcaUAf6vFN/QV4v/B/Z7B3e2nCaz3A14t3tOteogUsYWK/I9t8gH1VH+p1mYranxLJO4tMY
	85qFqZHxk3fFIZPPWbkj4DqE5UUwDCXSTtvOgadAaK152soijz6WKEE4NWkzqfhVXZzSAREeSAo
	R6B3znIOSaeOjev68wANph3CSoihEGS62YqXaotsNjgmuIbWXjrhu9L4hAi4XrhySjQ3tFPXWYq
	VrRlvgQFtdKgjF6ayh2YMi0Kx0BDZP8MipcR+SbyYhFTx7AyD8b9/AKv/EPmEcj9rKBpnhMynJl
	acCDdvZwULIKwT9e+Dr6t28yV0JDonncPZ4h5Q6AgVFNcVi4tuLjEJJ+k6epAy93Bjm+32+F1Qb
	6ccZwUY8pi1SWpyudVpuY5JYAbErXZrLaMTBdGjrK09qenhS/Oli8Ze/3W+jdnoKSaDPro0vWlS
	3Q8Wgw7rsnedlOV65oNtP5VoAOKP+ZZWV6qObQNm5tTbLhspzdh+bV+ck52knkphNoBXDpq91bk
	NUiusupdb60M+9P/VaO5jnxRnK3N3Ioy3D3wROLppTV2yfNWuzMh5kg4eR9FnO3iEleASu8vWPi
	air29D03IX2U=
X-Received: by 2002:a05:600c:a06:b0:4a1:811c:8078 with SMTP id 5b1f17b1804b1-4b6e035ed75mr35657695e9.26.1793963287126;
        Fri, 06 Nov 2026 03:08:07 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:6ce5:fd8b:2061:d7f5? ([2a0a:ef40:724:6601:6ce5:fd8b:2061:d7f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b5725061e1sm143325945e9.7.2026.11.06.03.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 03:08:06 -0800 (PST)
Message-ID: <edd1c36a-bd2a-4bcf-a6b1-3e08dfcda344@gmail.com>
Date: Fri, 6 Nov 2026 11:08:05 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 0/2] reflog: add format %gb
Reply-To: phillip.wood@dunelm.org.uk
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2448.git.git.1792070038.gitgitgadget@gmail.com>
 <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2448.v4.git.git.1793826938.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 04/11/2026 21:15, Harald Nordgren via GitGitGadget wrote:
> 
> It follows branch switches, branch renames and rebases, including "git
> rebase ", rebases of a detached HEAD and rebases of a branch that was
> already up to date. When HEAD was detached, the entry shows "detached at ".

The "detached at " labels show the commit before we switch away from a
detached HEAD, not the commit where HEAD was detached. The parsing of
"rebase: checkout <revision>" is still not quite right - it treats
"origin/main" as a branch name and is confused by commits where the
subject starts with "checkout " (I think the way to avoid that is to
check that the reflog message does not match the commit subject [1]).
Here is a failing test for those issues which also checks we handle
':' in a url in $GIT_REFLOG_ACTION correctly.

test_expect_success '%gb labels branches and detached HEADs' '
	test_create_repo origin &&
	(
		cd origin &&
		test_commit O1 &&
		test_commit O2
	) &&
	git clone origin downstream &&
	(
		cd origin &&
		test_commit O3
	) &&
	(
		cd downstream &&
		test_commit L1 &&
		git branch side &&
		test_commit L2 &&
		git pull -r "file://$TRASH_DIRECTORY/origin" &&
		test_commit L3 &&
		GIT_REFLOG_ACTION="sync switch" git rebase -i FETCH_HEAD side^0 &&
		H1=$(git rev-parse --short HEAD) &&
		test_commit "checkout main" L4.t L4 L4 &&
		git rebase FETCH_HEAD side &&
		test_commit L5 &&
		git rebase origin/main origin/main &&
		H2=$(git rev-parse --short HEAD) &&
		test_commit L6 &&
		git rebase main refs/heads/main &&
		H3=$(git rev-parse --short HEAD) &&
		test_commit L7 &&
		git switch side &&
		test_commit L8 &&
		git checkout origin/main &&
		H4=$(git rev-parse --short HEAD) &&
		test_commit L9 &&

		cat >expect <<-EOF &&
		commit: l9 (detached at $H4) &&
		checkout: moving from side to origin/main (detached at $H4)
		commit: L8 (side)
		checkout: moving from $(git rev-parse L7) to side (side)
		commit: L7 (detached at $H3)
		rebase: checkout refs/heads/main (detached at $H3)
		commit: L6 (detached at $H2)
		rebase: checkout origin/main (detached at $H2)
		commit: L5 (side)
		rebase (finish): returning to refs/heads/side (side)
		rebase (pick): L1 (side)
		rebase (start): checkout FETCH_HEAD (side)
		commit: checkout main (detached at $H1)
		sync switch (pick): L1 (detached at $H1)
		sync switch (start): checkout FETCH_HEAD (detached at $H1)
		commit: L3 (main)
		pull -r file://$TRASH_DIRECTORY/origin (finish): returning to refs/heads/main (main)
		pull -r file://$TRASH_DIRECTORY/origin (pick): L2 (main)
		pull -r file://$TRASH_DIRECTORY/origin (pick): L1 (main)
		pull -r file://$TRASH_DIRECTORY/origin (start): checkout $(git rev-parse FETCH_HEAD) (main)
		commit: L2 (main)
		commit: L1 (main)
		clone: from $TRASH_DIRECTORY/origin (main)
		EOF

		git log -g --format="%gs (%gb)" >actual &&
		test_cmp expect actual
	)
'

Thanks

Phillip

[1] https://github.com/phillipwood/git/blob/c11b0dcb38d4dbe26c41053569d4fae27fdf0de6/object-name.c#L1301

> 
> Changes in v4:
> 
>   * %gb now names the right branch when git rebase <upstream> <branch> runs
>     with GIT_REFLOG_ACTION set.
>   * Reworded the %gb commit message.
> 
> Changes in v3:
> 
>   * Dropped --operations.
>   * Replaced --historical-branch with a %gb placeholder for --format, e.g.
>     git log -g --format='%h %gd: (%gb) %gs'.
>   * %gb names the right branch after git rebase <upstream> <branch>, a rebase
>     of a detached HEAD and an up-to-date rebase.
>   * Named the returning to and checkout reflog strings in reflog.h too.
> 
> Changes in v2:
> 
>   * Move the "historical branch" rightward in the display for cleaner
>     alignment.
>   * Improve commit messages.
> 
> Harald Nordgren (2):
>    reflog: name the strings that mark switches, renames and rebase steps
>    pretty: add %gb to name the branch of each reflog entry
> 
>   Documentation/pretty-formats.adoc |   3 +
>   builtin/branch.c                  |   3 +-
>   builtin/checkout.c                |   3 +-
>   builtin/rebase.c                  |  19 ++--
>   object-name.c                     |   3 +-
>   pretty.c                          |   4 +
>   reflog-walk.c                     | 167 ++++++++++++++++++++++++++++--
>   reflog-walk.h                     |   2 +
>   reflog.h                          |   8 ++
>   sequencer.c                       |  13 +--
>   t/t1414-reflog-walk.sh            | 137 ++++++++++++++++++++++++
>   wt-status.c                       |   3 +-
>   12 files changed, 340 insertions(+), 25 deletions(-)
> 
> 
> base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2448%2FHaraldNordgren%2Freflog-operations-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2448/HaraldNordgren/reflog-operations-v4
> Pull-Request: https://github.com/git/git/pull/2448
> 
> Range-diff vs v3:
> 
>   1:  4d779e8da3 = 1:  f960a24b8b reflog: name the strings that mark switches, renames and rebase steps
>   2:  dee548f9b1 ! 2:  99a1047702 pretty: add %gb to name the branch of each reflog entry
>       @@ Commit message
>                1a2b3c4 HEAD@{3}: (main) commit: fix typo
>                5d6e7f8 HEAD@{4}: (main) checkout: moving from topic to main
>        
>       -    The branch is read from the entries that branch switches, branch
>       -    renames and rebases leave behind. The entries of a rebase are named
>       -    after the branch being rebased. When HEAD was detached, the entry
>       -    shows "detached at <commit>" with the commit HEAD was at when it
>       -    moved on. When nothing older in the reflog says which branch a rebase
>       -    started on, the rebase is taken to have started on the branch it
>       -    rebased. For the reflog of any other ref, "%gb" is the name of that
>       -    ref.
>       +    The branch is read from the entries created by branch switches,
>       +    branch renames and rebases. The entries of a rebase are labeled with
>       +    the branch being rebased. When HEAD was detached, the entry shows
>       +    "detached at <commit>" with the commit HEAD was at when it moved on.
>       +    When nothing older in the reflog says which branch a rebase started
>       +    on, the rebase is taken to have started on the branch it rebased. For
>       +    the reflog of any other ref, "%gb" is the name of that ref.
>        
>            Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
>        
>       @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
>        +	return p;
>        +}
>        +
>       ++static const char *skip_rebase_checkout(const char *message)
>       ++{
>       ++	const char *p = strstr(message, " (");
>       ++	const char *colon = strstr(message, ": ");
>       ++
>       ++	if (!colon || (p && p < colon) ||
>       ++	    !skip_prefix(colon + 2, REFLOG_CHECKOUT, &p))
>       ++		return NULL;
>       ++	return p;
>       ++}
>       ++
>        +struct branch_move {
>        +	const char *from, *to;
>        +	size_t from_len, to_len;
>       @@ reflog-walk.c: static void complete_reflogs_clear(void *util, const char *str UN
>        +		   skip_prefix(to, REFLOG_RETURNING_TO, &to)) {
>        +		move->from = move->to = to;
>        +		move->from_len = strcspn(to, "\n");
>       -+	} else if (skip_prefix(message, "rebase: " REFLOG_CHECKOUT, &to)) {
>       ++	} else if ((to = skip_rebase_checkout(message))) {
>        +		move->to = to;
>        +	} else if (!skip_rebase_step(message, REFLOG_STEP_START)) {
>        +		return false;
>       @@ t/t1414-reflog-walk.sh: test_expect_success 'walk prefers reflog to ref tip' '
>        +	)
>        +'
>        +
>       ++test_expect_success '%gb follows "git rebase <upstream> <branch>" with GIT_REFLOG_ACTION' '
>       ++	(
>       ++		cd branches &&
>       ++		git switch main &&
>       ++		GIT_REFLOG_ACTION="sync switch" git rebase main topic &&
>       ++
>       ++		cat >expect <<-\EOF &&
>       ++		(topic) sync switch: checkout topic
>       ++		(main) checkout: moving from topic to main
>       ++		EOF
>       ++		git log -g -2 --format="(%gb) %gs" >actual &&
>       ++		test_cmp expect actual
>       ++	)
>       ++'
>       ++
>        +test_expect_success '%gb names a detached HEAD by the commit it was left at' '
>        +	(
>        +		cd branches &&
> 

