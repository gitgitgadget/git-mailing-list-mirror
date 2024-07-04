Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4084A39
	for <git@vger.kernel.org>; Thu,  4 Jul 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720053634; cv=none; b=bV72aAF5jEzdfG+gWaQXZcULwbzM/dWlLRFnRW+RrejteFrnNbTWQrwBEBSqsnMNs7rJTaAgFxX2nu1Syl8qHqSGOpGQ+0uBR9ayJS9ao+qs8Wkg3uh8fv9qW1L4p9gpMtLiU5ImI0N5Mq2UqDIgpFt97zBdX0MBYiRYkbrgAdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720053634; c=relaxed/simple;
	bh=XlOtHuNUm0f/7zoiDx9kbftESPlo7p4haRdi15IrNvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCzd2hvDDpEwJLw0jIHytJRHRpxfjww74gLeAB4kdq1dFCinLkRzFLbXbPlYC+T7TtuFyiUyJ8okgmiNk1/0qLt7/tx+5NuCVhvjqLCQCkkuBHb6Xn/iwK8iQhXaY7TfX9loms5fTbyWX7S2fV3CtRZLpkDA8tY8koiv0wT1M7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uVxvEm+Q; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uVxvEm+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1720053631;
	bh=XlOtHuNUm0f/7zoiDx9kbftESPlo7p4haRdi15IrNvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=uVxvEm+QnK7wF1qBLGu6NfPgr5c5LZRsdwug1brDe6kn8n5yXyC4lari6aUOa59v9
	 XEBcKdYLh3o+zl3ZZN/gVTRiC634Q4SYKGPCX2r+RbcY/1um1nDhQEw1TsO/mOMFWR
	 CTP9uX6cS+GcxbmNXvtiFijpcfbqrIUKGOCwUhuRVZdqWGbDHZ8FeSbShdmYxBrmh9
	 wi2LpIWdqqdXbQJeOTItBa1lb+os3hGT3Y6KGy4rkSEt2Ga80+lNEx0Srk3ezv4611
	 yB7OAEhaGDbQGngWmFZD91svg3VVx2wqlMrTuOgHGHTogz+Dne+7hl3i+XKRCO2o0u
	 0W9krDuNazuO+guO1neScl+cIHT4mY4fNuQGWQK77JiMgpF+8NJ6JXS9wE1G1gjqBp
	 UPzCUPS4Cl/v/qTQYPtsvJjK7j/aIk5c4zkHaIpY1BR75LCaJ5Su1jj229dEF1Dl8n
	 HFuI1IXKr3JKzhQeeKfApQFUWWbtxZBb5crQxA1pEZgpZYVPzgm
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E189E2099B;
	Thu,  4 Jul 2024 00:40:31 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v3 3/4] gitfaq: add entry about syncing working trees
Date: Thu,  4 Jul 2024 00:38:17 +0000
Message-ID: <20240704003818.750223-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.45.2.753.g447d99e1c3b
In-Reply-To: <20240704003818.750223-1-sandals@crustytoothpaste.net>
References: <20240704003818.750223-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users very commonly want to sync their working tree with uncommitted
changes across machines, often to carry across in-progress work or
stashes.  Despite this not being a recommended approach, users want to
do it and are not dissuaded by suggestions not to, so let's recommend a
sensible technique.

The technique that many users are using is their preferred cloud syncing
service, which is a bad idea.  Users have reported problems where they
end up with duplicate files that won't go away (with names like "file.c
2"), broken references, oddly named references that have date stamps
appended to them, missing objects, and general corruption and data loss.
That's because almost all of these tools sync file by file, which is a
great technique if your project is a single word processing document or
spreadsheet, but is utterly abysmal for Git repositories because they
don't necessarily snapshot the entire repository correctly.  They also
tend to sync the files immediately instead of when the repository is
quiescent, so writing multiple files, as occurs during a commit or a gc,
can confuse the tools and lead to corruption.

We know that the old standby, rsync, is up to the task, provided that
the repository is quiescent, so let's suggest that and dissuade people
from using cloud syncing tools.  Let's tell people about common things
they should be aware of before doing this and that this is still
potentially risky.  Additionally, let's tell people that Git's security
model does not permit sharing working trees across users in case they
planned to do that.  While we'd still prefer users didn't try to do
this, hopefully this will lead them in a safer direction.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/gitfaq.txt | 48 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index cdc5f5f4f8..0e7f1c680d 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -83,8 +83,8 @@ Windows would be the configuration `"C:\Program Files\Vim\gvim.exe" --nofork`,
 which quotes the filename with spaces and specifies the `--nofork` option to
 avoid backgrounding the process.
 
-Credentials
------------
+Credentials and Transfers
+-------------------------
 
 [[http-credentials]]
 How do I specify my credentials when pushing over HTTP?::
@@ -185,6 +185,50 @@ Then, you can adjust your push URL to use `git@example_author` or
 `git@example_committer` instead of `git@example.org` (e.g., `git remote set-url
 git@example_author:org1/project1.git`).
 
+[[sync-working-tree]]
+How do I sync a working tree across systems?::
+	First, decide whether you want to do this at all.  Git works best when you
+	push or pull your work using the typical `git push` and `git fetch` commands
+	and isn't designed to share a working tree across systems.  This is
+	potentially risky and in some cases can cause repository corruption or data
+	loss.
++
+Usually, doing so will cause `git status` to need to re-read every file in the
+working tree.  Additionally, Git's security model does not permit sharing a
+working tree across untrusted users, so it is only safe to sync a working tree
+if it will only be used by a single user across all machines.
++
+It is important not to use a cloud syncing service to sync any portion of a Git
+repository, since this can cause corruption, such as missing objects, changed
+or added files, broken refs, and a wide variety of other corruption.  These
+services tend to sync file by file on a continuous basis and don't understand
+the structure of a Git repository.  This is especially bad if they sync the
+repository in the middle of it being updated, since that is very likely to
+cause incomplete or partial updates and therefore data loss.
++
+Therefore, it's better to push your work to either the other system or a central
+server using the normal push and pull mechanism.  However, this doesn't always
+preserve important data, like stashes, so some people prefer to share a working
+tree across systems.
++
+If you do this, the recommended approach is to use `rsync -a --delete-after`
+(ideally with an encrypted connection such as with `ssh`) on the root of
+repository.  You should ensure several things when you do this:
++
+* If you have additional worktrees or a separate Git directory, they must be
+  synced at the same time as the main working tree and repository.
+* You are comfortable with the destination directory being an exact copy of the
+  source directory, _deleting any data that is already there_.
+* The repository (including all worktrees and the Git directory) is in a
+  quiescent state for the duration of the transfer (that is, no operations of
+  any sort are taking place on it, including background operations like `git
+  gc` and operations invoked by your editor).
++
+Be aware that even with these recommendations, syncing in this way has some risk
+since it bypasses Git's normal integrity checking for repositories, so having
+backups is advised.  You may also wish to do a `git fsck` to verify the
+integrity of your data on the destination system after syncing.
+
 Common Issues
 -------------
 
