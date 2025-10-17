Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24BB2638BC
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760731565; cv=none; b=h+2bpycBJFk6ZOdJ6HwC6oJ6TcjYbmkL+QtrrYRxDO3mgqj6xDOalVrzk+TpNJqz51pdr3wgn112M8yGxb+gr2NFzVqQ2PXgz/cKVFUXL3VLJnzAv8AfWk/4op1arhjWU0rNK/j63/m7tG4kCx/4JXbXcIK0Kiq6twolEDR2t1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760731565; c=relaxed/simple;
	bh=nPgkMszXIDVXhPFQkNF/Vf8TcqA9rfU4SAZbBd13njE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GuxpK/3Xnt/Q2pxsSfB7KoAuXpjqYb7RfvIAaBcZWwOvODeBcIFpFRfU6Fm9FLoiK2GutrYGM4Akbos8ioPP9nkW5bTr4qxdCPIMYeYeCABmr5dkXJik6xPAeTdjy0VHtgJJQDzRNk+RkZm+CI3oAWgmVEc4+009lyYGb1QsHuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfk+N2mm; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfk+N2mm"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7a226a0798cso831494b3a.2
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 13:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760731562; x=1761336362; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mokZEQah3tfdFeN8MFSsA2cdHfndaDSK/BZSs1tMOLg=;
        b=lfk+N2mmgtxMSAFWJ3kuxbWcS9SaxieatVWl9gBH4yx2akrmVXaq0SC1mJoFJXa7hg
         nfOTCq6BOwVlIrUNYXtjtB6mBtxwwiLhJB+HqYG79Jlpi5wJgUgzOzGTZEStydY+7k8j
         OA3qkuqiWcT80FYXBNtjHgitHFLgN5H3Xc8x9TEclY1mSd6vzqH96eE7Yf1DEdjib8fo
         37Cek7K8NtIPWTD68vEiQxn9Yy3nseVDFQIrHqm0nMed8xAlNaTtJ9ZBU1jClhSEqQ9A
         WgpVvq4HEmUPuOvIxkB/3oBg6wFWAEw2Dq9PErXXE4+mcJFh3l2rcfz5ELyaQg+8ATo5
         fHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760731562; x=1761336362;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mokZEQah3tfdFeN8MFSsA2cdHfndaDSK/BZSs1tMOLg=;
        b=pzy1zrxw2FpSfCCN9dKvfeX45nIXcI7W69fdVWzm+hz0oPuGj+IbiLE5jZL/mJ/0AQ
         wnhJYe9g2+cNvDRie2rU1LOhG+SHZTvCAdCOO/3K/Lepz4yR/86PhViP02pQeQmFzAPQ
         6VVpP1saTNEFC1M2yi9wK6Z4EfyOBlJxxAjVczdYv0GNX9GEd1+PlVJkPeXvealsYTZq
         KlUtk70dd9ECxTEww/IheHTZCZzZeeDveETLn7KbNNQWrxeB+zVP/9LaiIGkyvnWWW5O
         teoy/JM9YM9N3LURdcmas0uHrQbUNQXvE4tiz7msHdEpv7i6U3a7Ec0WVTAfSUA2bP2F
         Je3w==
X-Gm-Message-State: AOJu0YxZY5J7HykX1rISW0p45PSF+5ebE0hg3b/7u/JIuCaprSQi2k+F
	b06b0Mhwk1UgpLdcXOvS32eedllnQTy8G4Vb1LEZWry+y9zsYdCDxDzd2E9OxA==
X-Gm-Gg: ASbGnculWDth6eHKln9udeSnj3Dm41Y7QmI84oq3LkqYSD6Plv67W8qssVW4K0IJxMe
	HsZpkow4vbrQHd33Yd0GkSZggHXBKtNRpUJmursPcP7VIIDNZZIuhjstFKuFpvzpNratXWONRgE
	EFmsFRJy6vSO5OwcfghPsSP/e86hqJjg5iZeKvSf1jdQlVNidYNDsUx4B1TyKG8sSICBDJdZK3s
	ppbRLM+bouwvLXeCDJ9zwuGGTP0MtZ89AR4U4zSyuAyhfuCK8XAUxxiGNJzmjxzsFlgyCX6OnZ3
	UwLqIpYKWn8GNR5ZxEXx8lL7vj+IJQGOUY8eVIXDFZ6unLVUb0zpSFrTwE62WgiObe99Ergzw8r
	ndMpYtPNdl4ATe7M5X+u8r5CqxaJAAs09UHGkG6pAz8LUgfKncImjuFI+xd4icTSCtXN59pI6lu
	vxLQ==
X-Google-Smtp-Source: AGHT+IFi627i5VrI4rJkiQQw52sED7e+14VmhFf9so4nGa5GdHm5DmlMbgJCwS8TtJx/zHRbPUM+wQ==
X-Received: by 2002:a05:6a00:2301:b0:78c:99a8:b748 with SMTP id d2e1a72fcca58-7a220144d3cmr5657800b3a.0.1760731562449;
        Fri, 17 Oct 2025 13:06:02 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.129.51])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010e24fsm414439b3a.57.2025.10.17.13.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:06:01 -0700 (PDT)
Message-Id: <6b5459b7ab478de33d17f9518906396f8a01e0d6.1760731558.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
References: <pull.1991.git.1760731558.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Oct 2025 20:05:56 +0000
Subject: [PATCH 2/4] doc: git-reset: clarify intro
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
Cc: Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback, there were several points of confusion:

- What "tree-ish", "entries", "working tree", "HEAD", and "index" mean
  ("I have no clue what the index is", "I've been using git for 20 years
  and still don't know what a tree-ish is"). Avoid using these terms
  where it makes sense.
- What "optionally modifying index and working tree to match" means
  ("to match what?" "optionally based on what?")
  Remove this from the intro, we can say it later when giving more
  details.
- One user suggested that "The <tree-ish>/<commit> defaults to HEAD
  in all forms." should be repeated later on, since it's easy to miss.
  Instead say that HEAD is the default in each case later.

Another issue is that `git reset` consistently describes the action
it does as "Reset ...", commands should not use their name to describe
themselves, and that the word "mode" is used to mean several different
things on this page.

Address these by being more clear about two use cases for `git reset`
("to undo operations" and "to update staged files"), and explaining what
the conditions are for each case instead of forcing the user to figure
out the pattern is in first form vs the other 3 forms.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-reset.adoc | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 9843682e81..876187dc83 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -3,7 +3,7 @@ git-reset(1)
 
 NAME
 ----
-git-reset - Reset current HEAD to the specified state
+git-reset - Set HEAD to point at the specified commit
 
 SYNOPSIS
 --------
@@ -15,10 +15,13 @@ git reset (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
-In the first form, set the current branch head (`HEAD`) to _<commit>_,
-optionally modifying index and working tree to match.
-The _<tree-ish>_/_<commit>_ defaults to `HEAD` in all forms.
-In the last three forms, copy entries from _<tree-ish>_ to the index.
+`git reset [<mode>] <commit>` changes which commit HEAD points to.
+This makes it possible to undo various Git operations, for example
+commit, merge, rebase, and pull.
+
+However, when you specify files or directories or pass `--patch`,
+`git reset` will instead update the staged version of the specified
+files without updating HEAD.
 
 `git reset [<mode>] [<commit>]`::
 	This form resets the current branch head to _<commit>_ and
-- 
gitgitgadget

