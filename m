Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265A86359
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 18:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651055; cv=none; b=im9o6dbD9M+9Uo95nAeUinhI7fQSvugVdLkL1+/4svdgFGsK1SRPp0/x3w9KTYviYoi8g1SvPgVDxfmRMI45ZrMxqjhGNr2nLuvaMAtgompGBMarvcVl96qeabPXP6SU2ghH+MckJEdazendfJNo43yOPFT9zw6fZEqFSGM8CzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651055; c=relaxed/simple;
	bh=vgyhS4ZyjFP2gWUk+Rl3QGo7vRQgHnvJC9wRERVjOdw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=X+MiV7D+Cp5ui7tsrnUGxHvtAgJWz4U5iBwCXEuyyTeyMsg+yEBqQ003AYLQ3u/8SJNlhQFkTl+Bj2aAmWXqPdk2MvAsLohIMAKcfkdjv6l6+VTq8YwrbD11Cq83/7Jofu12Z2KeoFvKAMIutP5Qkec1bDpwQzN2l3yARdOc/As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nr6pBTba; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nr6pBTba"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-889b846c314so145440539f.2
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758651053; x=1759255853; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efyWWCjevaYmR+Um/+X7wq0eIGC3x6Ubs8ygsaxqfjA=;
        b=Nr6pBTbaCq95zshY2KliTEdy4fvb0As+Mn2y4DBl9fyfgSlRQ7t96bCGdTGp3ZYZeF
         gn55mrtUgbUfs6T286/GptbCSfOlr4oArJihY/Qviu2CSdQ9xSi5/cWC6lWAnHbfuAu2
         70imJY6jGflwfF5RIVJuyX90YFgmYPucqlJBIR8h7vN+hxw9o9nhf+zBC+pr2kotF3Kk
         sUtso65UaawFjbVRUIeMNcio57MFLOhV19Pxf1XfI7dfCm6HbKR8RhKMYjtxbF2WPjdc
         Li3DoW7sXUMx7VZFn8R1fpTTCAJ5So3ZWSX0vJH34eWkU51yflDKiO+Va7Mb4YvjfuJh
         gVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758651053; x=1759255853;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efyWWCjevaYmR+Um/+X7wq0eIGC3x6Ubs8ygsaxqfjA=;
        b=WmsnMhc2worzlmPum50bq9gYEBjD66RPQkEmWTxJruCMLEyeIYYT//EziGZF+/lLQh
         KulmkjOAGDZDTUlF/FU5cfRA452MeUWYeYYqWpKUvxv93yR7QWNdQuyuPIhkqI+luBxP
         Alg8yJrf8c5qGK3ndoTjTDt5hwMGOOAlzyIfBa3ONeJX0Zep4Q0yNnyNmSAua5987DMX
         WD9sc6JAJpNVCk7Ue5UkERj0ofZaF0Rb3dzR6KH0GWQPRVSPfqZSKSkOlYNoTC1X/CGs
         IW5eToPPxu/r+ACcUc/VNTeBaY/GIYOqo5wZhzX96XWhZwXjlTdkkojP7hv+F3KmsyRm
         KgSA==
X-Gm-Message-State: AOJu0YxEY77kJiwqjkDHsujP6tbjbPk3lW//56b9qE6LwNz5cWuAG0Pu
	+L50+4/k42Y4ST3gfn7a0O0PC/mMbza9IIlVsTPoqvzw2h4HW3nJd80HXiq+qA==
X-Gm-Gg: ASbGncvIGQYR/TwGiW3b1v338182fbr6Wpnotqnl/z4yWI3rIVF8QmqZQmOGVhRjHOw
	En02ebzQSgb/SQlPznxfU/JoFTpnZJWAbYXlbu3HORdZVlYJqt2Jm27mTHyQpqJJcqcXaZyiAaO
	Tbz//78YrlrI0PLVRRlxoW59VTYJpuOoB4dWVWa+DDEXsILcF6Ns586+r66eY6H5YCsC+ZvOe+L
	ko7U/rMcQKl2dkTvnBIr1N3i9OPQ5T8MClznOoRo5gyBMJI/pQeRXWXglaikjIBDZDLjhXVHtEJ
	OC9l1mQA6iqRd5LIgq1QpbpwF51Ccas3pw0M/OUC5ZgslWp0henqeAMMImn6XzZUNSGN4cB5ZF2
	1dRr+KLRHwDb8296YLOsqfp89YQ==
X-Google-Smtp-Source: AGHT+IGTiZLkE5vpTRFBp51R07/4ebnwtpuGYfPaX0rRsrTyo08lUjnkWqqwnl//xnX27Za72oiLUA==
X-Received: by 2002:a05:6602:6d06:b0:89a:8809:1767 with SMTP id ca18e2360f4ac-8e1e1629855mr638043339f.2.1758651052566;
        Tue, 23 Sep 2025 11:10:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.121])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8a4804376a0sm559215039f.19.2025.09.23.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:10:51 -0700 (PDT)
Message-Id: <pull.1973.v2.git.1758651049.gitgitgadget@gmail.com>
In-Reply-To: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
References: <pull.1973.git.1758144815.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 18:10:47 +0000
Subject: [PATCH v2 0/2] doc: git-push: clarify section
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jeff King <peff@peff.net>,
    Julia Evans <julia@jvns.ca>

This is a continuation of the changes to git push, from
https://lore.kernel.org/git/pull.1964.git.1756240823.gitgitgadget@gmail.com/
. These changes to the refspec section got kind of big so I'm moving them
into a separate topic.

I don't love the nested list in PUSH RULES but the sentence starting with
"If the source is a tag or commit object..." is really a tough one to read,
it's not going to be relevant to the vast majority of people, and I think
keeping it contained inside a bullet point will make it much easier to skip
over to get to later information which is more likely to be relevant to
folks.

Changes since the original thread:

 * The main change is to move the rules for pushing out of the section and
   into their own section ("PUSH RULES") so that it can be easily referenced
   from other places in the man page.
 * removed "+:<dst> is optional.", from Junio's review
 * kept "+ is optional and does the same thing as --force", since now the
   push rules are in their own section.
 * fixed the fully expanded refspec form (main:refs/heads/main =>
   refs/heads/main:refs/heads/main)
 * switched from a numbered list to an unordered list, from Junio's review.
   I think the numbered list looks a lot nicer in the terminal output, but
   it's true that there isn't any order. I briefly attempted to understand
   how AsciiDoc's nroff (?) generation works to see if it's possible to make
   unordered lists indent with fewer spaces (2 instead of 4) but I was left
   feeling that nroff/troff/etc are not for mere mortals like me to
   understand.
 * made it clear that "tag v1.0" is not really a refspec, from Junio's
   review

Changes in v2:

 * Say just "The source can be any object." and don't try to educate folks
   further about tags, from Junio's review
 * Mention both exceptions to --force working, from Junio's review
 * Change "local branch or commit being pushed" => "commit being pushed" to
   make it clear that it's just 1 condition, from Junio's review
 * Remove an awkward double colon, from Junio's review
 * Be explicit that creations are always allowed, from Junio's revew

Julia Evans (2):
  doc: git-push: create PUSH RULES section
  doc: git-push: rewrite refspec specification

 Documentation/git-push.adoc | 199 +++++++++++++++++++-----------------
 1 file changed, 103 insertions(+), 96 deletions(-)


base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1973%2Fjvns%2Fclarify-refspec-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1973/jvns/clarify-refspec-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1973

Range-diff vs v1:

 1:  2f2dc22c47 ! 1:  8be0554d02 doc: git-push: create PUSH RULES section
     @@ Documentation/git-push.adoc: allowing a forced update.
      -	to update a remote ref whose current value does not match
      -	what is expected.
      +	Usually, `git push` will refuse to update a branch that is not an
     -+	ancestor of the local branch or commit being pushed.
     ++	ancestor of the commit being pushed.
       +
      -This flag disables these checks, and can cause the remote repository
      -to lose commits; use it with care.
     @@ Documentation/git-push.adoc: reason::
      +Because branches and tags are intended to be used differently, the
      +safety rules for pushing to a branch are different from the rules
      +for pushing to a tag. In the following rules "update" means any
     -+modifications except deletes. Deletions are always allowed, except when
     -+forbidden by configuration or hooks.
     ++modifications except deletions and creations. Deletions and creations
     ++are always allowed, except when forbidden by configuration or hooks.
      +
      +1. If the push destination is a **branch** (`refs/heads/*`): only
     -+   fast-forward updates are allowed: the destination must be an ancestor
     -+   of the source commit. The source must be a commit.
     ++   fast-forward updates are allowed, which means the destination must be
     ++   an ancestor of the source commit. The source must be a commit.
      +2. If the push destination is a **tag** (`refs/tags/*`): all updates will
     -+   be rejected. The source can be any object
     -+   (since commits, trees and blobs can be tagged).
     ++   be rejected. The source can be any object.
      +3. If the push destination is not a branch or tag:
      +   * If the source is a tree or blob object, any updates will be rejected
      +   * If the source is a tag or commit object, any fast-forward update
     @@ Documentation/git-push.adoc: reason::
      +     new tag object which an existing commit points to.
      +
      +You can override these rules by passing `--force` or by adding the
     -+optional leading `+` to a refspec. The only exception to this is that no
     -+amount of forcing will make a branch accept a non-commit object.
     ++optional leading `+` to a refspec. The only exceptions are that no
     ++amount of forcing will make a branch accept a non-commit object,
     ++and forcing won't make the remote repository accept a push that it's
     ++configured to deny.
      +
      +Hooks and configuration can also override or amend these rules,
      +see e.g. `receive.denyNonFastForwards` and `receive.denyDeletes`
 2:  e1b667f645 = 2:  11ad190c3e doc: git-push: rewrite refspec specification

-- 
gitgitgadget
