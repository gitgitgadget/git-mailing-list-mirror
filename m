Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7E276043
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744398819; cv=none; b=pM20htDMwWwP3/tdd2ZeysR7lQ4I/B9dW1RSM1XtqoIuErOLBnSBWssVdqRgCEN65UWPyYn76K+o3kTIArl9Q6121hkBIX/Lr39WZUWkaguaT7pxUahzmMn2oC0Kf/AyK9TbJ0PnDhqx6f++eq5xoBJxvtiaXF5FDi8KYgzgVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744398819; c=relaxed/simple;
	bh=a5f0XaHHvr+DOW3ZE7R7K9BI/AW8prysH+Ui8dgJOoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QtQLVb4WVaWIjJUfLYf8O1H+OfmamvkbRSAoIpjS5Kmw/OCO5rLsN6ZIrhziw9MIYM44/B/U3F4ACYfFzjfudydUBTJwoBpgzurAAs11UHKta5yStOcO0TTujoCdj3U7KfhatSw9AHFtSmnw5OzLNUG/avYBSteZ+KtEq6Ugh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=am31gDYP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="am31gDYP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso24684095e9.1
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 12:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744398815; x=1745003615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FGOW/Kg1UoskXNFEblcTzMaH6leh0HL+EjgXVHqHRZ0=;
        b=am31gDYPh/IkP++vRL25CjNRxDXygCnuMM/4Y8wWWLvYT2RqUm1lYnPumK4jRffBVM
         SeLqxRkHOghq6GQdahlrRhJ8BDD884B52dPBxZu9VIR9rKgAV938b2Qw11mi7BLJ8pKn
         XUSd5cW78pHgegXUE2TmPbFs3JLMCtJkYOTNrKnJ0wWsp6aerV/LfV0elH6fOJjV+daA
         VS61WpHjarH/90XViQ/YsoKSVCli/PlQOSKkdghJF3EWeX5z318Zdm3kRJnn0FkHcyIt
         fg63ib9y6hAq60+6TAtPETSmc8xr2gChkqpT1E/EAxBpqsS4Fo+g9ZH22Wan/lO5nCsT
         ewbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744398815; x=1745003615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGOW/Kg1UoskXNFEblcTzMaH6leh0HL+EjgXVHqHRZ0=;
        b=Ks1S2CMrEuDv6vSX1zAKwWaDiy2yLp7goCmSZosiUeynYQeteK6zKg0MSrCoDQepyg
         MzwA9hQ2vbh9cwa8OsL31juRKSQlynBFKX9uu+LDx3f0O6ah6fu6hmoqyDCy8/Apg7dK
         sRM6uRih6UwmrxdvueW0V5HX3HzqWMNY8xPjan9BFCWeA/U4ux4w4UMiuyp0Idyeqqdc
         XJRGnhi3VsqOJ/Cr+7UcLFok4UUhRKOFMAJcQnONHL90jdUciCIhtwa5cwlvY1WhAKL4
         F+7nSLx0J5WLnE7bE7XTIBpoPfC/XZY0OfFOqTGOMJUSDpbKrOdPTYp1bJMVz1WH71Nf
         iiVA==
X-Gm-Message-State: AOJu0Yx8+KV6jQ6A5UbgsD6InMKP/Ts0sDiU3oxvPtKDjv1EopszEl8M
	ZYIwllLrUZVhSIsRLDuYqWh3OvYeSuIqKVohY355t+ay7UonPnx9
X-Gm-Gg: ASbGncvYXNLZ8wSoasbZSWlg3nUKTYB6sB5qkRltygu523dTG0Z1CbrpqD7b+hSDFD9
	Sj/gbi0eJzcRhNfDsWFAIO9vuQiJgxvQh7w8UfLMD1ndBDw9/3pORsDRgUrBLpMpL0W5N4ZmQZc
	pCNxLzw/lmc/etkpYpygaA9ryLbckaoMHnQsDLsZLHmqA0oDvYp2bOdFGd5RHtWBAeVOZc8iYns
	7iUiM7OU5c/c5g1VyS/AHSTYWLC0Ld1cj9mPxrfrYvsdBe84pzgn616Q4f4hZxYMEjOJjSi/Bi5
	1pCWHybi3y4tM8ZkLCwTQX3IDrDA/yiN/n33aBSAcRo26d42UAvmuZnnUyJ1PoFMDiiDE3TNFlX
	P1eJTwcczJtIzeX6P
X-Google-Smtp-Source: AGHT+IF5FYKPWl/uKBG3QaqdmGjTgQSwDf2XiBAmQT6fgvAwc23twXe4ZvjAMY1Xy7vsSUQNVps+2A==
X-Received: by 2002:a05:600c:1e28:b0:43c:e481:3353 with SMTP id 5b1f17b1804b1-43f3a959b60mr40682785e9.17.1744398815214;
        Fri, 11 Apr 2025 12:13:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f2066d6e8sm100501295e9.23.2025.04.11.12.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 12:13:34 -0700 (PDT)
Message-ID: <c0075b62-34fb-41f6-bc69-e33a403d528c@gmail.com>
Date: Fri, 11 Apr 2025 20:13:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Bug: being stuck in rebase mode when accidently typing `git am`
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 Ludo Pulles <ludo.pulles@gmail.com>
Cc: git@vger.kernel.org
References: <76edd34d-3fd1-437e-b8d3-7e64e99644a2@gmail.com>
 <CALnO6CCbzqez9-BvbuV3NRRMvFLHSv57Tfwj3ibadUAMKznWrw@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CALnO6CCbzqez9-BvbuV3NRRMvFLHSv57Tfwj3ibadUAMKznWrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/04/2025 19:23, D. Ben Knoble wrote:
> On Thu, Apr 10, 2025 at 10:35 AM Ludo Pulles <ludo.pulles@gmail.com> wrote:
>>
>> Thank you for filling out a Git bug report!
>> Please answer the following questions to help us understand your issue.
>>
>> What did you do before the bug happened? (Steps to reproduce your issue)
>>
>> 1. Run `git init` in an empty directory, and commit once.
>> 2. Run `git am` and press Ctrl-C.
> 
> Doesn't `git am` print a warning about how it's reading from stdin?
> Pressing C-d at this point to send EOF just exits "normally."

Indeed

>> 3. Run `git status`. It will say: 'You are currently rebasing. (all
>> conflicts fixed: run "git rebase --continue")'.
> 
> Yes, this is odd: my shell prompt (using the contrib script) says
> "AM/REBASE", so I know better: git am --abort does the trick.
> 
> This seems like a failure of git-status more than anything; I wonder
> if there's some difference in how the prompt script checks for
> in-progress am vs. how git-status does it?

I think the issue is that "git am" does not write the 
".git/rebase-apply/applying" which "git status" uses to distinguish 
between "git am" and "git rebase" until it has read the patch files. We 
could instead check for ".git/rebase-apply/rebased-patches" which is 
written by "git rebase" but that file gets deleted when "git am" exits 
for the user to fix merge conflicts. I think the best solution is to 
move where "git am" writes ".git/rebase-apply/applying" so it gets 
created before the patch files are read - see the diff below.

Best Wishes

Phillip

[Apologies for the line wrapping the thunderbird plugin I was using to 
disable that has stopped working in recent versions]
---- >8 ----

diff --git a/builtin/am.c b/builtin/am.c
index 3b61bd4c333..e884ac39b23 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1006,6 +1006,11 @@
          refs_delete_ref(get_main_ref_store(the_repository), NULL,
                          "REBASE_HEAD", NULL, REF_NO_DEREF);

+        if (state->rebasing)
+                write_state_text(state, "rebasing", "");
+        else
+                write_state_text(state, "applying", "");
+
          if (split_mail(state, patch_format, paths, keep_cr) < 0) {
                  am_destroy(state);
                  die(_("Failed to split patches."));
@@ -1076,11 +1081,6 @@
          sq_quote_argv(&sb, state->git_apply_opts.v);
          write_state_text(state, "apply-opt", sb.buf);

-        if (state->rebasing)
-                write_state_text(state, "rebasing", "");
-        else
-                write_state_text(state, "applying", "");
-
          if (!repo_get_oid(the_repository, "HEAD", &curr_head)) {
                  write_state_text(state, "abort-safety", 
oid_to_hex(&curr_head));
                  if (!state->rebasing)

