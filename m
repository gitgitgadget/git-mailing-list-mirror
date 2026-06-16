Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2DA416CE3
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599001; cv=none; b=afm0dx0+4RvPomtWYaGE+hME/BYakRXVdnui0hScT/jT0TL8HsU/nuRuVsl0s0si88r/dNHOc/MEwWu3qEAz768jYWbIJkXGQz8HSIvLOi0kKA4Kzi+r4QsOmAP0e6vob6YgVk2taryIJkI+SeQnY8gddwTC4ckHnK+pe8jVRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599001; c=relaxed/simple;
	bh=2AJIS2KX7dBb/FGKCwSR8qN35whLw+4S0XxzGhqYIyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sA5urXFsk5YjnGkl07UkJpQ3NOQbVBbrthuUNpdJ6CBdfxMFwEgXmCEVklQ1MyJx7lraNGIkSihHil8Cvszkc9ftjfjVLZNXIFVTofE5Xyp9zgBoUhgEHgeo+Yfp1KwvSoMCYS35UgSlHawxCto6z3XbVJmpMM9ujuihMgUZ9cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b696iXBu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b696iXBu"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bf1cdcfd6deso503285366b.3
        for <git@vger.kernel.org>; Tue, 16 Jun 2026 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781598997; x=1782203797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ezRDNQdIHkhRP8xYNucvKVbfOhd+aFnUZBA0hhT/ok=;
        b=b696iXBubdFhtlzXky9v6H67Ad/UMQL/wkDu1/yRPZbgpndVbXJ39oR7SARS2xbhIc
         QriPBKfxvWZASJVXtteAmLLlp+OwItI/0QR5SQ8mOBdECWb90mm9J+zG63Q9nLkbGseS
         NR2X+fi0AhiLXvZsnZfLcW9hlrgNPJ88/2xmMoYpAWHU+e317addstW5x6eQtcqThGHE
         30gvbgSYYx+MJAVGlAgK4DOMJfiOspXjtt0HrX50IC+oOCzeGWfIErFqiDv0vEWmlUyc
         sT8vXtTraTjDBL92ZFHTxTwsp2cwjWPbTmkNTIhanw0ArVNJIwCZtN+ere8wh9ZkBh/G
         tBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598997; x=1782203797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ezRDNQdIHkhRP8xYNucvKVbfOhd+aFnUZBA0hhT/ok=;
        b=Dqjl1AeU+9GrlVbXHvKKZNIh8uKXJ7EZOm0M4JQ7TyYJysM2WrH1BfVaCmIz15OPmY
         HUkVMfhLtL/lxvgHymNQRiK6TMfntTy+SmwoCgfR/NVoLy0d4Mo3oK0/hyCOHoQ3R7aZ
         Cy+iaJ36wXdp5GLY8C/Xu7GSQLF5I4W2znTd457btuR1+3uCWyo8HzU8ATgO4i+zOBI5
         p3N1BS7alahwCIwgD9mLREdbtnpM0CvxqnIYv7x4XQ7FUDzM/zt+QSREj3eMOzGgwztx
         VPE2xYDTV5nLDkHLat4c9lezIVOxggjL/SAFZh4/xXhyd6tKIPQH9/cJ44qm2q8QqyWX
         v4bw==
X-Forwarded-Encrypted: i=1; AFNElJ81tkdge45DlxFtX8w/Yve0Ju44huPOY4S3b7YcwG92kFOhbH0g3EVt5Tm4BabN7bBstc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWr1wg9rSmaHKSTpab6PXRRraJJtE2HzVmtelkMtRQy1Px5CfG
	ME3fs/k/go7oQE6iYyUEiTjTPm+dycgZv4R0Rd6q7qGKrDSk1RPPrcnH
X-Gm-Gg: Acq92OFz5aDzzqgA4uv+WalsQpUyr6khWzgKSZ6+o/r88+2/BsiqKEHhIbrnrd/0tch
	hKoA2kXZ5lZRtKavAq53Wci6K4SsQnLw5I69IiWpX3dXsd973/VwBiyIykAAA13ZmXvlbupBpco
	3TJrIV6v4Dbd5pyTLTTVnfqgQ6QPexvByJCD0XS8ZbuFIjClTcDcKl6ivxDSkLevhK3a6igmr8Q
	HZ88okyUdeySbhxwvXc42BNqXtIIwJC4t0IeBU6T5JCYOV/nGDsFf4/92zZExvmw3IJn/oKmhUR
	HsiXu5nOWIraFX/fCtcUJzxyUNgX2AtG1afS980Y6piiDx8cI5laMTlsMuWSgofKFCxeLrSFmj7
	mZmX06Smry+aCyePdneXQROcTNZbaaM++xAhxVHJFgrLcJ98dzjwuCPWAkcHfilKZRRfIn0mwgr
	YKNzQrTURagLhpEbEuwXHwjUFDmXpw1NTvgxaerx+enO0wbKE0gpVwJVgYHQOpEqTulWmYiWZp+
	IOvqtsyRtc=
X-Received: by 2002:a17:907:c26:b0:bd8:6ac6:d722 with SMTP id a640c23a62f3a-c043cade0ffmr132171466b.24.1781598996855;
        Tue, 16 Jun 2026 01:36:36 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:786c:b99d:5866:4e92? ([2a0a:ef40:69a:b801:786c:b99d:5866:4e92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb7b6d621sm597664066b.34.2026.06.16.01.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 01:36:36 -0700 (PDT)
Message-ID: <89d72342-5aa1-4dcf-951b-d0c791f91738@gmail.com>
Date: Tue, 16 Jun 2026 09:36:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rebase: mention --abort alongside --continue
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2330.git.git.1781551170529.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 15/06/2026 20:19, Harald Nordgren via GitGitGadget wrote:
> From: Harald Nordgren <haraldnordgren@gmail.com>
> 
> The warning shown when an "exec" step fails and the "git status"
> advice while splitting or editing a commit pointed users at "git
> rebase --continue" but not "--abort". Mention it in both, matching
> the conflict case.

I'm not sure that the "failed exec" and "conflicts" cases are equivalent 
though. If you have some nasty conflict that you don't want to resolve 
then aborting and trying another approach such is incrementally rebasing 
is the only option. If an exec command fails then it likely means that a 
test has failed or some something similar which is minor inconvenience 
which needs fixing before continuing - it seems very unlikely that the 
user would want to abort the rebase.

Thanks

Phillip

> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>      rebase: mention --abort when an exec step fails
>      
>      Mention git rebase --abort both in the warning shown when an exec step
>      fails and in the git status advice while splitting or editing a commit,
>      since rebase pointed users at --continue there without saying how to
>      bail out, unlike every comparable command.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2330%2FHaraldNordgren%2Frebase-exec-abort-hint-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2330/HaraldNordgren/rebase-exec-abort-hint-v1
> Pull-Request: https://github.com/git/git/pull/2330
> 
>   sequencer.c            |  8 ++++++--
>   t/t7512-status-help.sh | 17 +++++++++++++++++
>   wt-status.c            |  7 ++++++-
>   3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 57855b0066..c46e5b95bc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3884,7 +3884,9 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
>   			  "You can fix the problem, and then run\n"
>   			  "\n"
>   			  "  git rebase --continue\n"
> -			  "\n"),
> +			  "\n"
> +			  "To abort and get back to the state before \"git rebase\", run "
> +			  "\"git rebase --abort\".\n"),
>   			command_line,
>   			dirty ? _("and made changes to the index and/or the "
>   				"working tree.\n") : "");
> @@ -3897,7 +3899,9 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
>   			  "Commit or stash your changes, and then run\n"
>   			  "\n"
>   			  "  git rebase --continue\n"
> -			  "\n"), command_line);
> +			  "\n"
> +			  "To abort and get back to the state before \"git rebase\", run "
> +			  "\"git rebase --abort\".\n"), command_line);
>   		status = 1;
>   	}
>   
> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index 08e82f7914..ca7ef66ae3 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -206,6 +206,7 @@ No commands remaining.
>   You are currently editing a commit while rebasing branch '\''rebase_i_edit'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -240,6 +241,7 @@ Next command to do (1 remaining command):
>     (use "git rebase --edit-todo" to view and edit)
>   You are currently splitting a commit while rebasing branch '\''split_commit'\'' on '\''$ONTO'\''.
>     (Once your working directory is clean, run "git rebase --continue")
> +  (use "git rebase --abort" to check out the original branch)
>   
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
> @@ -278,6 +280,7 @@ No commands remaining.
>   You are currently editing a commit while rebasing branch '\''amend_last'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -317,6 +320,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -347,6 +351,7 @@ Next command to do (1 remaining command):
>     (use "git rebase --edit-todo" to view and edit)
>   You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (Once your working directory is clean, run "git rebase --continue")
> +  (use "git rebase --abort" to check out the original branch)
>   
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
> @@ -383,6 +388,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -414,6 +420,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -445,6 +452,7 @@ Next command to do (1 remaining command):
>     (use "git rebase --edit-todo" to view and edit)
>   You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (Once your working directory is clean, run "git rebase --continue")
> +  (use "git rebase --abort" to check out the original branch)
>   
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
> @@ -482,6 +490,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -515,6 +524,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -548,6 +558,7 @@ Next command to do (1 remaining command):
>     (use "git rebase --edit-todo" to view and edit)
>   You are currently splitting a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (Once your working directory is clean, run "git rebase --continue")
> +  (use "git rebase --abort" to check out the original branch)
>   
>   Changes not staged for commit:
>     (use "git add <file>..." to update what will be committed)
> @@ -587,6 +598,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_edits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -718,6 +730,7 @@ No commands remaining.
>   You are currently editing a commit while rebasing branch '\''bisect'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   You are currently bisecting, started from branch '\''bisect_while_rebasing'\''.
>     (use "git bisect reset" to get back to the original branch)
> @@ -987,6 +1000,7 @@ No commands remaining.
>   You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -1015,6 +1029,7 @@ Next commands to do (2 remaining commands):
>   You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -1044,6 +1059,7 @@ Next commands to do (2 remaining commands):
>   You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> @@ -1064,6 +1080,7 @@ Next command to do (1 remaining command):
>   You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
>     (use "git commit --amend" to amend the current commit)
>     (use "git rebase --continue" once you are satisfied with your changes)
> +  (use "git rebase --abort" to check out the original branch)
>   
>   nothing to commit (use -u to show untracked files)
>   EOF
> diff --git a/wt-status.c b/wt-status.c
> index b17372390c..94fd14a058 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1527,9 +1527,12 @@ static void show_rebase_in_progress(struct wt_status *s,
>   		else
>   			status_printf_ln(s, color,
>   					 _("You are currently splitting a commit during a rebase."));
> -		if (s->hints)
> +		if (s->hints) {
>   			status_printf_ln(s, color,
>   				_("  (Once your working directory is clean, run \"git rebase --continue\")"));
> +			status_printf_ln(s, color,
> +				_("  (use \"git rebase --abort\" to check out the original branch)"));
> +		}
>   	} else {
>   		if (s->state.branch)
>   			status_printf_ln(s, color,
> @@ -1544,6 +1547,8 @@ static void show_rebase_in_progress(struct wt_status *s,
>   				_("  (use \"git commit --amend\" to amend the current commit)"));
>   			status_printf_ln(s, color,
>   				_("  (use \"git rebase --continue\" once you are satisfied with your changes)"));
> +			status_printf_ln(s, color,
> +				_("  (use \"git rebase --abort\" to check out the original branch)"));
>   		}
>   	}
>   	wt_longstatus_print_trailer(s);
> 
> base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c

