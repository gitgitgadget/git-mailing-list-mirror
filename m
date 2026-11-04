Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819271;
	b=DgDPo9OL2mYaCRt7MszRWIjhfvzlwyrRgvdxmfXQmRIIqn7AwzSbdnnQzns/GYQM2qZ+
	 9PBFX/4tKjMxKSc2cCMpNjhM4o6FDMtXj2xN3q77MfPzAlbVG5hEDqzW4UOP9bJlGIdbI
	 5G/n4TOdpaQiLGBtot6v1r/GzNbRMl6UgWsLx0fhleM9HXNr14uAYp+Fytu+2wkF+/Muc
	 SQXMjIBnhreoIWpg9U3sgTf8ALl/IW3M/mrMK6xchf9F+cPDWNtVwend/uIwk52P5FOJv
	 cRUJcEwHc8xsDEQ/dnPkua9v0jNXsdNL3VO/1WibROYIj/++squ6CpwIMIVBCMzsJVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=I2cN0IaGnS/X8hoVG5d41wt0T6rw4T9Ehvrg15pw6c8=;
	b=hdUxESqV5wZoiMvrfccztHP3S0PQ1Cpld/bY1Hjb4aQFP5ilITKGi9ikGvXByHPYk1vI
	 RC1X1ghDgiGkfW1EGzs3+TjGUGNYgnaAa5GQzfU0dF86fG/b1hn3Oede9O0DwCpqiSVj8
	 +eRasqUswmbxsJhmMQ/+M6ADbOUYLV/fwvEoFfcv/QwC9zc117GFITEs87ReVx6xxOSrm
	 WSBXYAfRFu6awrH/RGQyinzWeZsxlo+HWS/RGHQCCw1tjascCFZYw4iSZ9BFXHZk6LJKA
	 EbZ1R9Cja2WZZH1zdjgxsVX7K3k/LXIkCbQUabyxBUS1U6oqE2usOqq5uUONlq2RaKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+59IPbs;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD983606A31B
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 19:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD983606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p+59IPbs
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1023609c88.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 11:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793819270; x=1794424070; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=I2cN0IaGnS/X8hoVG5d41wt0T6rw4T9Ehvrg15pw6c8=;
        b=p+59IPbs5ZA6PcYC/EExO5P+QlPsolIO0bCMEn9fSI8vCf36Y0KXuXNmq7h+XgGWXJ
         XdiaQ3Uj9PDB6TSg3IwVfZU0jNkL5JupP586tx5URRsY8UJoUIS8E/wJmsLYIF3jugi6
         393qDhjQ1Feo04WL/z6TfgqgyWcgWiLV3dPhUG9UuP2Z4Czh7B2bZPYvjC8wlddAn+eG
         xkbRAejlFZWdYpHQbyGCkO1BpFsNN1tABchTOeoHSwu1rf0ucmWF9zCQyhJnOIrlvhNg
         eOzbiQxMr37PFsC/RDhEQX3Gg/S4IdkYgFBzmcJijj4/SBIRnWgLOaDLDi7zB/Ra1w3c
         +HsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793819270; x=1794424070;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=I2cN0IaGnS/X8hoVG5d41wt0T6rw4T9Ehvrg15pw6c8=;
        b=FVGkMx8zvLfI7oCLM/gZ1tlOzyXnnvf3VDtj+WQW/n77R0golzlnqIa+OuDK1NJRL8
         LNdn0LxrNNH/V/889n2YeA21C37u3qftBsUTAaAW/VWmPlZdgyLdlZ+NTCxa8xb0uoHt
         YlOLF+WH93esvpRFY1K8V50g6+g+rMd7OQXq82UkFjg/o7AsYbcg6zB78+9CLzcXrdNP
         qsr8Wb3ryPnyOGHT+E6gQEwL0AGN6KAnfgzHiKkQ4RL5nHpmztG8uOLQIF7olx8J74nM
         0vzoK78aZfGbttuALzbooXUHyFDZLQd87bYbJccG+uGpstzEa7sVQFvv4VsRJ0YO1Zl8
         4srg==
X-Gm-Message-State: APuU4Z9Aqm+2Fe0u6B55uOl8gSlOYItMFsJVpsW+6W21Q9tYe0CitP0E
	o+NpqS7DbR5BTen46LYw4ITJqz/3Wrce9aRbJ/hZBIfDLYb2eMZEsWae2UXchBB9Z/M=
X-Gm-Gg: AYBFou1FJ71EwyuVrw9jd29MG2dNZ5Pe5TAXleQWBnXyjrWtLG5Lx8Apphg0oKOUETM
	+J3heKYxLbA7x0o3gCMBTMQYVwaGK1+8Z8BdJRk4MaChCrTXQr/JeJahG8faIpkfyxHn0tv0/WY
	yfpe6RaLA8ipy2Gkq2o40DlrEyAX+9phvizqHCyQaYKXY3n5bWk5BciWGV0XnQ8ZFM33Y86HlDD
	lQ6RY4xhrr8fbEuJF9wRspOZtVlY6T9z/WjF9tUEZFvKWaxRk9cRQqfZNc1aoAaXuGP5fm3YAHv
	0f40odFni186v8YpI2l464tG4pk/tIDvWj+Te8Na564OrLwlZ8EG57LK7STKejwF0RkJi1E1sGD
	GX9AOUxCzRtADr8hkPYvNL7kMID9PRAwJYceVA0M4hRnV0HRHe+LjzZrazhqQrQBlxrP22Cg3L/
	qA7nXa2MSxE3a/9PDw6RenzLfpP409xDkRTflNyictdH+yTfH84QPwkYFXaPp6FGlw9YVn+71c6
	xYl05ZiNsbNgRh8jqaQiheBURXgr1IKa9fv7m20Bv7wXbhB7YUxWZchkWXoG9vNCgKx5XVaOFDC
	k3TH/k2XNcwLONN+eMZwLJmlrO/Zuw==
X-Received: by 2002:a05:701b:2310:b0:1b2:4e79:bfb0 with SMTP id a92af1059eb24-1b24e79cc85mr822515c88.23.1793819269786;
        Wed, 04 Nov 2026 11:07:49 -0800 (PST)
Received: from [127.0.0.1] ([57.154.4.160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm9419407c88.8.2026.11.04.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:07:49 -0800 (PST)
Message-Id: <pull.2296.git.1793819268371.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 04 Nov 2026 19:07:48 +0000
Subject: [PATCH] path-walk: allow revisiting paths from tagged trees
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ttaylorr@openai.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

When adding support for tree-depth filters, 5111520e2a1 (path-walk:
support `tree:0` filter, 2026-05-22) moved tagged root trees into a
separate batch. These trees are expanded after commit root trees and
their root-level blob batches.  If a tagged tree introduces another blob
at an already consumed path, push_to_stack() refuses to queue that path
again because path_stack_pushed remembers every previously queued path.
The final remaining-path drain makes the same check and also skips the
blob, leading to a repository with missing objects.

This regression was first released in Git 2.55.0. The torvalds/linux
repository has such tagged trees that revealed the bug.

To resolve this issue, remove a path from path_stack_pushed when
consuming its queue entry.  The set then suppresses duplicate pending
entries without preventing new objects from being visited at a
previously consumed path. This preserves the existing visit priorities
instead of reordering tagged trees relative to other batches.

Add a regression test with a commit and an annotated tree tag that
contain distinct blobs at the same path. After an initial repack to
clear loose objects, repack everything with path-walk and run an fsck
connectivity check to reveal the error without this fix.

Assisted-by: GPT-6.1 Sol
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
    path-walk: allow revisiting paths from tagged trees
    
    While exploring potential future improvements to path-walk repacks, I
    discovered this regression. It's slightly subtle in a way that the
    existing tree-tag tests didn't catch, due to needing to revisit paths.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2296%2Fderrickstolee%2Fpath-walk-tree-tags-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2296/derrickstolee/path-walk-tree-tags-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2296

 path-walk.c       |  5 ++++-
 t/t7700-repack.sh | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/path-walk.c b/path-walk.c
index 9ca3248ea8..e3a5ba201c 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -62,7 +62,8 @@ struct path_walk_context {
 	 * like a stack and performs a DFS within the trees.
 	 *
 	 * Use path_stack_pushed to indicate whether a path
-	 * was previously added to path_stack.
+	 * is currently queued in path_stack. Tagged trees can
+	 * discover new objects at an already visited path.
 	 */
 	struct prio_queue path_stack;
 	struct strset path_stack_pushed;
@@ -309,6 +310,8 @@ static int walk_path(struct path_walk_context *ctx,
 	if (!list)
 		BUG("provided path '%s' that had no associated list", path);
 
+	strset_remove(&ctx->path_stack_pushed, path);
+
 	if (!list->oids.nr)
 		return 0;
 
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index f0a390e3c6..338f622614 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,27 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success '--path-walk keeps blobs from tagged trees at already visited paths' '
+	git init --bare tagged-tree.git &&
+	(
+		cd tagged-tree.git &&
+		GIT_DIR=. &&
+		export GIT_DIR &&
+		old=$(echo old | git hash-object -w --stdin) &&
+		tree=$(printf "100644 blob %s\tfile\n" "$old" | git mktree) &&
+		git tag -a -m "historical tree" tree-tag "$tree" &&
+		new=$(echo new | git hash-object -w --stdin) &&
+		tree=$(printf "100644 blob %s\tfile\n" "$new" | git mktree) &&
+		commit=$(echo new | git commit-tree "$tree") &&
+		git update-ref HEAD "$commit" &&
+
+		# collect all loose objects into packs
+		git repack -adf --no-path-walk &&
+
+		# now confirm that --path-walk keeps all objects.
+		git repack -adf --path-walk &&
+		git fsck --connectivity-only
+	)
+'
+
 test_done

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
