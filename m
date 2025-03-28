Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38BA14F9E2
	for <git@vger.kernel.org>; Fri, 28 Mar 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182113; cv=none; b=YlCNpi4O360f5fuAvaIEr85Wzp3VZAUQ2pRhN9p6OJBfpRfvs4qIMIJY9vuE5PvQRvn6RSElSi+cH+R8sk4Uo+Ey/z7+Sv6sgLKaEVAwRzeL594PHIHuz4YSZGo4qy82NX+1Z4XH7Ci7G601wGoMZ6a+uM9jaCD/3a171gy+/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182113; c=relaxed/simple;
	bh=QAKfaYcQ+hQgEWJf+YX9SIT9k8Hp3T6ZgxFjgkg0IcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1cGBrO3GAWNMNzuQpjscPPDoU0aW4cg4CUuNka1QZhlpLVBSQqycDRXeMOpxUIpmZZBj0YGW9Cr4vT+ajyle1fViZRv1nUl/2ra5xTD8feI12sEXj/L49Bzyf9tADnfJ8nJXaVjcyulj9DRGzOkCdbv7jaLWJuwbPylXCDdTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eaf348103cso3877216d6.0
        for <git@vger.kernel.org>; Fri, 28 Mar 2025 10:15:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743182108; x=1743786908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQtntyWb7rOxgum+2awYg7Hqwf38cMZPOWe2bhRrNTs=;
        b=bLh5eX2sX6SiimTxB3CqQDJLtYwuOjCJOiN0m8KjsPFDGx4aa0dtXTsQ64AeyIe9PC
         kiiom3YzLplKSRLMAYKN7IefBLwvFduJkINBQkXhjtl+jeC+67Zj3LLAzVMwVNU/OnDp
         rVkqjQpRJf5vepFzaP6wfyl4f7Re26lPdPeH2XuiNTgbmzdMOxC/ajm0jpVdnIr7oW1x
         uPXKH3i2NV4wn3OcPEeihy4i5NWGRFjXAHTaJ5lysJKwLFifL4p11/4pO1QZQFXzzO30
         dfhO1oMB/2Ex5+X0yDVDA24JdxzCasNEEcTbZy847mI1g9TTY9VDW8+GK71gQCuuMrY4
         Jlzg==
X-Gm-Message-State: AOJu0YzLxysidkMHgb+oYnCB2ZvzmQvynTHEj1ZQ+3G1hf6B4DJJMq2k
	eeSrtZGKi3K5o54kCU7e/NqFJKN86wshR+cR7wRL2mwKt7rAv7DpXmpu05aXbLCM+58XAuP/uy/
	t+QZlkA2mWC0qZZp2zlfFRHSa/qM=
X-Gm-Gg: ASbGncs1Zaga7VE8A6fA+PtSYzF+09JQhI9+OZim+sCYNinIfvYFfsqTT8OgeI4wisQ
	16ht+zJXMkiFHXlAtqQNmK2dv3pL3ynZNe+mxBprs7irN8JrO6Bg76tV7vMiIi4xyRHGk2sqzjF
	XOzJhpY5o1ye2TAxPs8zspWMX9CVIFeL/sIpsTN0cFScmE+rhOECM5etginEk=
X-Google-Smtp-Source: AGHT+IGQaEXGsEWHo9c4EMXEKV19LWp0LP/FZDxXL4+GFhs3CxggWqI8PcNwXVZodM06Z01y0WojO1yRCapkiYTBeOY=
X-Received: by 2002:a05:6214:e6c:b0:6e6:62fb:3504 with SMTP id
 6a1803df08f44-6eec9df9f5amr22591176d6.8.1743182108288; Fri, 28 Mar 2025
 10:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com> <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
In-Reply-To: <6c8f77cb71c7e0c820704b1725331f4601d8876e.1743181401.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 28 Mar 2025 13:14:57 -0400
X-Gm-Features: AQ5f1Jqm_KA5QriKnIY_tHP0Ix9x_tEYobNL7aqdoRZL8snFo4xMcve6Dvb03jo
Message-ID: <CAPig+cS92W_gYuNsaTvQxiP3xBK7Wpg0__uVkgAU1x0OFJUZgQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] rebase -r: do create merge commit after empty resolution
To: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 1:03=E2=80=AFPM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When a user runs 'git rebase --continue' to conclude a conflicted merge
> during a 'git rebase -r' invocation, we do not create a merge commit if
> the resolution was empty (i.e. if the index and HEAD are identical). We
> simply continue the rebase as if no 'merge' instruction had been given.
> This is confusing since all commits from the side branch are absent from
> the rebased history. What's more, if that 'merge' is the last
> instruction in the todo list, we fail to remove the merge state, such
> that running 'git status' shows we are still merging after the rebase
> has concluded.
> [...]
> Make sure to also remove MERGE_HEAD when a merge command fails to start.
> We already remove MERGE_MSG since e032abd5a0 (rebase: fix rewritten list
> for failed pick, 2023-09-06). Removing MERGE_HEAD ensures that in this
> situation, upon 'git rebase --continue' we still exit early in
> 'commit_staged_changes', without calling 'run_git_commit'. This is
> already covered by t5407.11, which fails without this change because we
> enter 'run_git_commit' and then fail to find 'rebase_path_message'.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> +test_expect_success '--continue creates merge commit after empty resolut=
ion' '
> +       git reset --hard main &&
> +       git checkout -b rebase_i_merge &&
> +       test_commit unrelated &&
> +       git checkout -b rebase_i_merge_side &&
> +       test_commit side2 main.txt &&
> +       git checkout rebase_i_merge &&
> +       test_commit side1 main.txt &&
> +       PICK=3D$(git rev-parse --short rebase_i_merge) &&
> +       test_must_fail git merge rebase_i_merge_side &&
> +       echo side1 >main.txt &&
> +       git add main.txt &&
> +       test_tick &&
> +       git commit --no-edit &&
> +       FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" &&
> +       export FAKE_LINES &&
> +       test_must_fail git rebase -ir main &&

I don't think you want to be setting FAKE_LINES like this since doing
so will pollute the environment for all tests following this one. You
can find existing precedent in this script which demonstrates the
correct way to handle this case. Specifically, you'd want:

    test_must_fail env FAKE_LINES=3D"1 2 3 5 6 7 8 9 10 11" \
        git rebase -ir main &&

> +       echo side1 >main.txt &&
> +       git add main.txt &&
> +       git rebase --continue &&
> +       git log --merges >out &&
> +       test_grep "Merge branch '\''rebase_i_merge_side'\''" out

You could take advantage of the SQ variable defined by t/test-lib.sh
to make this a bit easier to digest:

    test_grep "Merge branch ${SQ}rebase_i_merge_side${SQ}" out

Or, even simpler, you'll find that some test scripts just use regex
wildcard "." to make the needle even more readable:

    test_grep "Merge branch .rebase_i_merge_side." out
