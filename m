Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E757E2C08BB
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763723633; cv=none; b=Hgv2aHpbouK1Tf+DBJXa5rRUqnQugxvFehORbYNSKzSNMiQ9WcAfi3+fwoWQZ4Euk4AdVOqmhg89IzgIenOoB8KQ9823tv24DRrTlxQr2f/yHHYijQteXpmEAtQQEAECdzcv+LJhP7/0nBjDlV+2adWq7/1+k2St2FZ1IZn639g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763723633; c=relaxed/simple;
	bh=yQ1ErjNBfTswZOa0kBrS1BIUoRhXmnbIzj3TaY0SEOM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HAbuOGFHo6LRFLyHtBYr4U8ZbNipC3uef9rfSINSC8q7tpzTNVgBmSNQ5Y2cLVFOwe4OkGWb1IgknDeRCRJelMZW3KaSmmyqxfNXX0A84P4phz44/EPDsxil/xbpSusMUAucpBPAb98/n2f2kWbAujotwgzqmdX2Zw1yzNXHo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKu37D6S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKu37D6S"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b725ead5800so239133966b.1
        for <git@vger.kernel.org>; Fri, 21 Nov 2025 03:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763723629; x=1764328429; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9pFar2v3X97Pth1ZGL/Y2nPI3nHD7n2cDmkE8ZSsOI=;
        b=eKu37D6S0NDdi5uS9crUqqBQifRYinFTMUibcwm+RprMvtwkT86AeRL+oVYfh6Ugfq
         A0eH8Ze0EHrtFT7n+J2Yl6c6XyMGLt8mBJxXFRyFgIvGJzLIGOibOXBwWe4GgTVT5zU7
         ORzS8kRmiij2jN/GH2YHHOlqa/nJYdETnriwK+IybGdLdi7Y4vZF6PUBQuuHc1qGr3SY
         ljjZJfuyLWGFG8tUaD42jpJdt9jbh8mVUazkm6l2RCjB3h/G869QEIJKgFAjB/VtboiY
         ez9373EtzX9OMnKYNugRJg5fIrV5mW+5ajIEDFPMKPcPsfIrJ3bu0fWM6VHaEhUKFEJF
         8cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763723629; x=1764328429;
        h=cc:to:references:in-reply-to:content-transfer-encoding:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z9pFar2v3X97Pth1ZGL/Y2nPI3nHD7n2cDmkE8ZSsOI=;
        b=AyyooJkG8Udmqr4POf6Lqc/r/wVZBDWiECnD6kRVn6hpQLg7eCXJ6r22GHSlo+aCQ/
         WKbyAqGq6WIqdkDsX0+z5bhgarlUwshyLdEqPuv4ybf44glZ+GgSgJXyVjszKjiJ9zGj
         w3IaXCWDFac6pIIwPVHU0L85HMd8hxdiK8s9s26MdVI834xJ6KO1b+7xvkd230m9Pq/T
         OGnQ8T2xEao9VqjXjdFLTiyFD02gBD7naNJidZwy671kahQlXPRFIHAvE81rB+2jJKGx
         L2gLRnCJdIvvJT1n9HzVdH+EFQCq/81X1fwVEuXdkNgwFVjddB4phgS8N5UQC1zC0Vr8
         WI3Q==
X-Gm-Message-State: AOJu0YwBnGJ6/QegNDNtwnoshVzsu40ZFZKb5fR9zolwQZajkYInYswK
	0XOAtW2I6MDdu0vahS6BEProgLyFPv3BNM3QdHrl6KpRj9pTNPEGDFdv
X-Gm-Gg: ASbGncuWDwI6lSpYaeh96QeCKDr8CYOyVdoeRLiHZq6C3llcXzL375lzJPkoxpiSu86
	LQnW7+ZIGyaVkfIv+NMAWeXR49VuIzaMlEubyFZDmI4ZhwMpPbFx7lSs6bZ3ENv5XuhayZCnmc2
	mqNn105WotK+UDdTShiYjE8PhJuqHD+Jsyt+GDmCFtbmnBwiZHXSEY9jfh+xTtKuBzM4oi9p1iN
	qshCiuzTdgyL+dcXAYR2T5HDWq97ZEDaE41C+u9fJuRBa2UZ927LsdqRpEtpoWdeCMAdk80pf5L
	Q4hU4URWil+aRGaGNNjHjZwtiIzMD9dtUQ1SCC8dpQzu9+16za9Ler1BlCDUfawga+oeLW1Qucc
	Wbfto7ZT3WPwa/TTw2RSuBT/tr/2HFEpOTPrsE9CrUVRvO+aH97WmQTwo2YUhkKnFcIxjKgorWx
	B+f5Bi2auf+rUqdFUE1JM=
X-Google-Smtp-Source: AGHT+IGaOJw3hElS/bZddOAB/AXMI/RtoxqQ+gNrupBGv5zgoGMp4twjlhj9KwK6T8stv9tqxQdijA==
X-Received: by 2002:a17:907:741:b0:b72:c1e9:5f1e with SMTP id a640c23a62f3a-b7671518370mr181558766b.3.1763723628969;
        Fri, 21 Nov 2025 03:13:48 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:be79:897c:7a92:76c0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654cf0435sm436206166b.4.2025.11.21.03.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 03:13:48 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 0/3] fetch: fix non-conflicting tags not being committed
Date: Fri, 21 Nov 2025 12:13:44 +0100
Message-Id: <20251121-fix-tags-not-fetching-v8-0-23b53a8a8334@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGhJIGkC/4XQwW7DIAwG4FepOI8JAwG6095j2sEhJkFakylE0
 aYq7z63JxQJ7fhb+LPNXRRaMxXxdrmLlfZc8jJzCC8XESecR5J54Cy00h2AMjLlH7nhWOS8bDL
 RFqc8j1IlcBrQejtYwb3fK/HDp/vxyXnKZVvW3+eYHR7V/8QdJEhyJiL1LgKY9/GG+es1LjfxE
 HddK66laFYcqNjbXpGP4ayYWgktxUglETTyJnZASmfFVgpAS7GsQOiGYBxFp/GsdLXS/JeOFeO
 B0DNiwnBWXK00L3KsaNQJuhTBeDorvlauLcWzomJI19RD0sHXynEcf6mnLZleAgAA
X-Change-ID: 20251103-fix-tags-not-fetching-0f1621a474d4
In-Reply-To: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
References: <20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, jltobler@gmail.com, ps@pks.im, 
 gitster@pobox.com, sunshine@sunshineco.com, 
 David Bohman <debohman@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5925; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=yQ1ErjNBfTswZOa0kBrS1BIUoRhXmnbIzj3TaY0SEOM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkgSWucB47OvM8I+WkdGuUQhkbrkQ5bc+lNA
 krc2Uhp3n3i14kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpIElrAAoJED7VnySO
 Rox/B+UL/2DW8CCFZcY0cXUSVWxzVWDwj0ZOIXSJOPTap1G++K7hL4hnlPDgXtp6E+vtmc2a/UR
 vubWWeM2xks2Qo+hcqPRdqziHSL63iEwx3UNLFDFVg55Dy1AJ56Iy2jXGErcAEKVk/Isl3BlELS
 iXh+ODQZvX8KUfP7b/Wsi/CVEpaiE/6uWxJRaRFPRNgupZx4Q6f7OvKzrXtaOfCOTnKWBQW7/BH
 6rtQnM5GXB6ZY08/0qS7kMtxddFKsX/ywKwNsuHP7a4wwdwWf5A8VywYZAK57Zz0D+2LGZdT01z
 xmZw+j2zL6fBbmZbN0A4mnhWodnAmV8mKoPVglXZ/W77J78P/NrwsktcRyz+dguqab4o+Dj2++p
 1rs/vwkcDFUt6H4M9L6Oi5DKcJlMyUErSXQUHuwQxkAUKL40bGmL2cgQGW+yOsaxYDycfaV52nV
 rZ5UEx0j0VK24ss76W4KQlCj353uNs/5o3wRRqHIBL4xkg4SHhBFOBTst9LXse+AnncYXYP7Ux5
 X8=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

This fixes the bug reported by David Bohman [1].

The 'git-fetch(1)' uses batched updates to perform reference updates
when not using 'atomic' transactions. One scenario which was missed
here, was fetching tags. When fetching conflicting tags, the
`fetch_and_consume_refs()` function returns '1', which skipped
committing the transaction and directly jumped to the cleanup section.
This mean that no updates were applied. This also extends to backfilling
tags.

The first commit, extracts out common code for committing a reference
transaction and handling rejected updates. The second commit ensures
any failures would also commit pending updates.

The third commit fixes another regression around failing to do
post-fetch operations when ref updates fail with batched updates.

[1]: id:CAB9xhmPcHnB2+i6WeA3doAinv7RAeGs04+n0fHLGToJq=UKUNw@mail.gmail.com

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v8:
- Change the test to delete FETCH_HEAD at the start and verify the
  contents at the end.
- Use 'test_path_is_missing()' instead of '! test -f ...'
- Link to v7: https://patch.msgid.link/20251119-fix-tags-not-fetching-v7-0-0c8f9fb1f287@gmail.com

Changes in v7:
- Don't use 'touch' to create new files.
- Drop the REFFILES requirement for the happy path test of 'git fetch
  --set-upstream'.
- Link to v6: https://patch.msgid.link/20251118-fix-tags-not-fetching-v6-0-2a2f15fc137e@gmail.com

Changes in v6:
- This version adds a new commit which handles another regression where
  if reference updates fail when using batched updates, we skip doing
  the post-fetch operations. Namely:
    - Updating 'FETCH_HEAD' via `commit_fetch_head()`
    - Adding upstream tracking information via `set_upstream()`
    - Setting remote 'HEAD' values when `do_set_head` is true
- Link to v5: https://patch.msgid.link/20251113-fix-tags-not-fetching-v5-0-371ea7ec638d@gmail.com

Changes in v5:
- In the previous version, I assumed that the `prune_refs()` function
  also triggers committing of batched updates. However this was
  incorrect as the transaction for batched updates, is only created
  after the call to `prune_refs()`. This makes sense, since we want to
  isolate deletions from the rest of the ref updates, to avoid
  conflicts. I've amended the commit message accordingly.
- I noticed I missed cleanup of the repos created in the test, which
  I've now done.
- Link to v4: https://patch.msgid.link/20251111-fix-tags-not-fetching-v4-0-185d836ec62a@gmail.com

Changes in v4:
- Cleanup the code in the first commit to make it simpler to read.
- In the second commit, we were specifically checking for `retcode > 0`
  for committing the transaction. This is a bit confusing since that
  begs the questions why not `retcode < 0`. There is no real reason
  there, so I've change the code to simple do `if (retcode && ...)`.
  I've also added more information about the flows which would commit
  the transaction in the commit message.
- Link to v3: https://patch.msgid.link/20251108-fix-tags-not-fetching-v3-0-a12ab6c4daef@gmail.com

Changes in v3:
- Split the patch into two commits. One for extracting out existing code
  into a new commit and the other to perform the fix.
- Add back error handling when commit via the normal flow.
- Instead of calling the commit function at every failure, make it part
  of the cleanup code.
- Link to v2: https://patch.msgid.link/20251106-fix-tags-not-fetching-v2-1-610cb4b0e7c8@gmail.com

Changes in v2:
- Add a comment to explain the purpose of `commit_ref_transaction()` and
  how it works.
- Also extend the same logic towards backfilling tags. While I was able
  to add a test for the happy path, I couldn't figure out how to test
  when `backfill_tags()` tags would fail.
  Tangentially, this flow seems to only be triggered when using the now
  deprecated 'branches/' remote format.
- Remove unneeded subshells from the tests.
- Link to v1: https://patch.msgid.link/20251103-fix-tags-not-fetching-v1-1-e63caeb6c113@gmail.com

---
 builtin/fetch.c  |  71 ++++++++++++++++----------
 t/t5510-fetch.sh | 150 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 195 insertions(+), 26 deletions(-)

Karthik Nayak (3):
      fetch: extract out reference committing logic
      fetch: fix non-conflicting tags not being committed
      fetch: fix failed batched updates skipping operations

Range-diff versus v7:

1:  f5d1abef41 = 1:  6553f56915 fetch: extract out reference committing logic
2:  fa2466f2bf = 2:  d525415fbb fetch: fix non-conflicting tags not being committed
3:  df59310296 ! 3:  30ddb99550 fetch: fix failed batched updates skipping operations
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
     +	git init --bare repo &&
     +	(
     +		cd repo &&
    -+		! test -f FETCH_HEAD &&
    ++		rm -f FETCH_HEAD &&
     +		git remote add origin ../base &&
     +		>refs/heads/foo.lock &&
     +		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
     +		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
    -+		test -f FETCH_HEAD
    ++		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
    ++		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
     +	)
     +'
     +
    @@ t/t5510-fetch.sh: test_expect_success "backfill tags when providing a refspec" '
     +		cd repo &&
     +		git remote add origin ../base &&
     +
    -+		! test -f refs/remotes/origin/HEAD &&
    ++		test_path_is_missing refs/remotes/origin/HEAD &&
     +		mkdir -p refs/remotes/origin &&
     +		>refs/remotes/origin/branch.lock &&
     +		test_must_fail git fetch origin &&


base-commit: a99f379adf116d53eb11957af5bab5214915f91d
change-id: 20251103-fix-tags-not-fetching-0f1621a474d4

Thanks
- Karthik

