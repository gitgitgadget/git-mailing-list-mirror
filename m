Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AB227182D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 04:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739334123; cv=none; b=n1TYBxB7wL7NIWPQhPrOQEYH68xj7w/LmZUv5WJIse8KZ0NnNUFgEaVLYg/SwshULZwKq6P/NR/AZdbrsPsqsqkrK4mJiMmSLd3f6VH7w3Q4wrzm8JqxEHFHkjCW8IUDtcDQrproMLEmZGgtWwjpx/SKHwhZgIDqmvjqTsUf3r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739334123; c=relaxed/simple;
	bh=ZQtKpx40FAMQ15TxWYr2kcNoM481nsGbHaZVGN5wkvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUBHBRmdOS5ZzsZyqbFlnAnd1tSgdKrdLNX/QfKSMI28n5HpE4ezvOTM/wuzgRykb39QCKYVXaFIuSmayYFMBuKeZhVUjzK/OICw/1EreTa2tMIwq2PGGEIhw6nR1zhkAtt3TscnjLMl2EwItCAKylCswCN7RbCMkqmbF/Z/sc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwpYawxb; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwpYawxb"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fca61c7e4aso32044eaf.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 20:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739334120; x=1739938920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iF3bIo5V+fB7QgW7rXcGGI9NPOQWUmlh2Ql0sF2kLp0=;
        b=PwpYawxbppb7shUgfZ++vZKNpezz8jKUWnYE/SBz4tRPYgW1BffQX/OTfEeV35Ttaf
         0Up746UNkeI0Zd+tn6fQ5cN2C8OSsp7wnd2X7sjalvXosjpZj8TmVDZqCyo6xSgwbIar
         t/39tBDW/2q3LaGELOCBDC6gJHYPFX6hlCpQBVXM7ecM/oA0jNprapH8D8LogOwaYKgO
         wj0ZxES4q5Fd3xeXnwjBHisr+Pf78jzGiNM+wekqa/wvaGi4KtxAuWmhgJKl9jDqgYJQ
         ByKghqXd/Gk6Ydl6v3rqccSEiMSe/mIZKOrpnAkDpa506eB32we9rj13r6xKYaHunlB6
         fdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739334120; x=1739938920;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF3bIo5V+fB7QgW7rXcGGI9NPOQWUmlh2Ql0sF2kLp0=;
        b=fg1fEFDMr3pKTMbWxyjTlhfXdD2KgSQ4GlpiJDqb2f+5mGKH/yF7RN8Dv0IhYxi5fE
         7znjJTw6oaVB2PIb3dkO0sw7pspsQw6MohN6LRRUDMip2rwZQCctqdnkr6uCeOopcyvE
         Dc9q7s7Dpl2swpX8CV55SPxdZvexpdHl95oMSquxw/9ib3OKxQ9n+ltkasGQiS9cTfso
         gFwPg3lsruuw7VoAVwDZlp4OzCmi5lulSBe+fjOpPC7UoKrrO+LXQDUF7QRbWlvzDg00
         +6SNDMiZUgtCMMijU1Jmb0PVPT3uiciUs2/pQEdI7I5yiuOwEzGPeZJ6Pm6/2Obkrybj
         xIfg==
X-Gm-Message-State: AOJu0Yz0jzFP2E1GBNtFSGSWkVk7RpKvlIW3A6MW+TUq19U6vf7KH5zB
	1ZIHdFnztuZlNW/QZCvNbCKngO/4jgd8GveN05H10TVMp2HWo/z/1RFYxA==
X-Gm-Gg: ASbGncuRWbkYJpYpN91xlsLpdZ5GGtBi5PZtGeLj3jKeaNU6r8Us82vxpL3Obdol/Ha
	YeMVJuAnP+pJGhVSpjn6CQ0Q/2UTwIx1+qVjIeNqxlctK92ef4kWwDCRHp1vALYrdkodc7dGTY5
	jZ1YQNXq8eMVYCnoGYSqPdF2dflr4mJEkv8aF7iO3dJUo26L40AkSxAGYGd9BiP2/QzLJ2+Z1i0
	H+6ncrt8lFRs5c+rABGkzlyB3PprTDarL0LDv75ibdIw5A0kpv99JTuukJleQh6v1c6BOh4o2r5
	R4EqUOUS8eqJm2SeFa4Dbr0=
X-Google-Smtp-Source: AGHT+IFJKwvT2YURmJyJDgsHEfeXwt+uiu/9LXIFdzE3KDs2+g1k65tFiVQsXd/Y9wLjJ5AY3iHWtA==
X-Received: by 2002:a05:6871:c3c5:b0:29e:5a89:8ed8 with SMTP id 586e51a60fabf-2b8d6514892mr1073052fac.11.1739334120268;
        Tue, 11 Feb 2025 20:22:00 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8a0bb67fesm2293392fac.39.2025.02.11.20.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 20:21:59 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 0/3] batch blob diff generation
Date: Tue, 11 Feb 2025 22:18:22 -0600
Message-ID: <20250212041825.2455031-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20241213042312.2890841-1-jltobler@gmail.com>
References: <20241213042312.2890841-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Through git-diff(1) it is possible to generate a diff directly between
two blobs. This is particularly useful when the pre-image and post-image
blobs are known and we only care about the diff between them.
Unfortunately, if a user has a batch of known blob pairs to compute
diffs for, there is currently not a way to do so via a single Git
process.

To enable support for batch diffs of multiple blob pairs, this
series introduces a new diff plumbing command git-diff-pairs(1) based on
a previous patch series submitted by Peff[1]. This command uses null
delimited raw diffs as its source of input to control exactly which
filepairs are diffed. The advantage of using the raw diff format is that
it already has diff status type and object context information embedded
in each line making it more efficient to generate diffs with as we can
avoid having to peel revisions to get some the same info.

For example:

    git diff-tree -r -z -M $old $new |
    git diff-pairs -p

Here the output of git-diff-tree(1) is fed to git-diff-pairs(1) to
generate the same output that would be expected from `git diff-tree -p
-M`. While by itself not particularly useful, this means it is possible
to split git-diff-tree(1) output across multiple git-diff-pairs(1)
processes. Such a feature is useful on the server-side where diffs
bewteen a large set of changes may not be feasible all at once due to
timeout concerns.

This series is structured as follows:

    - Patch 1 adds some new helper functions to get access to the queued
      `diff_filepair` after `diff_queue()` is invoked.

    - Patch 2 introduces the new git-diff-pairs(1) plumbing command.

    - Patch 3 teaches git-diff-pairs(1) a way to perform explicit diff
      queue flushes instead of waiting until stdin EOF to flush.

In 1f010d6bdf (doc: use .adoc extension for AsciiDoc files, 2025-01-20),
the extension for documentation was change from .txt to .adoc. This
series builds on top of that change as to avoid conflicts in next.

Changes since V1:

    - Changed from git-diff-blob(1) to git-diff-pairs(1) based on a
      previously submitted series.

    - Instead of each line containing a pair of blob revisions, the raw
      diff format is used as input which already has diff status and
      object context embedded.

-Justin

[1]: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>

Justin Tobler (3):
  diff: return diff_filepair from diff queue helpers
  builtin: introduce diff-pairs command
  builtin/diff-pairs: allow explicit diff queue flush

 .gitignore                        |   1 +
 Documentation/git-diff-pairs.adoc |  66 +++++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/diff-pairs.c              | 189 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 diff.c                            |  66 ++++++++---
 diff.h                            |  15 +++
 git.c                             |   1 +
 meson.build                       |   1 +
 t/meson.build                     |   1 +
 t/t4070-diff-pairs.sh             | 102 ++++++++++++++++
 13 files changed, 427 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/git-diff-pairs.adoc
 create mode 100644 builtin/diff-pairs.c
 create mode 100755 t/t4070-diff-pairs.sh

-- 
2.48.1

