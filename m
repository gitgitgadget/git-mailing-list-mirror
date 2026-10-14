Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D0C23645D
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961457; cv=none; b=jkGzAkGHjqlIIvrHLqFc7LYtsoRWykY5HeP1E8UybSv0/LnGXNY4TG8uba2JoYqnDhhUBp+MZ2mVSc1aweGuXLa97CzSjhZc+bE0vIxpG0JtvXHu7cD99K4Hv+HZK9DVZaJ+f3Fn7wh4dQgj9R2dF2DvCcd8Yu9dqy+3w8M+ZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961457; c=relaxed/simple;
	bh=GluVsUDYTAfAn0elpkokZywDe4CLtkya9xubhJVnNhk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QIp6M+YaG31YHj7RmT59y0TmHvTCMnTkA8wTQw/d8GZgZPUmJw7jB76JRo1Akbd/VfPCHRe78if3YIQc1JwWH8WqaCoikjiqDFWXLwFQj32sVqsY3Y5Dm3QswHFWEtmB3qgYuHylRbOxGcB61w/0agllNl5rtpi9JMHJLkF7A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TadUhtlJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TadUhtlJ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-88cfa501c5cso47663b3a.3
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961455; x=1792566255; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OAkhBh61bw/daznhqV9qu3gwna13JU0Kf8T7FVRoxS8=;
        b=TadUhtlJEnBiQTgQxDKadXtzhROulUICmvKqD9muXj8ZbBCar7xH5PG27BIVZZUn+o
         zRxHcdtyQ+YKp9yPQkFZksHJdtRUdFjv+dJJRf9D8vEks+1F+1KNgMFEcEGivcwQoZKc
         x4t2wUNBt8kXAWbeFzmnBXymzdrQ2ToR+UqRUtRNHvrAHIt44igAiDtrSvvsiQYBdYuZ
         hzrNADE1Hx37FMwcI/nMKhQpDX9UeYPOpCb7flU9qFPZNjBsjMIY4A/ywlnelOL4CuCq
         W64IiAEhOFC7v0x/O0dX1f0WtB7cql8E7EakqY74dbvJIFxA1Mb9vY1On6o723nPrbgV
         v/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961455; x=1792566255;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OAkhBh61bw/daznhqV9qu3gwna13JU0Kf8T7FVRoxS8=;
        b=nSJg+dYEidYkLqKccFAotBugvTc1tMSaDYXkHVpodfMsr0GmijHvwHAZAqSzXzZ0kL
         gh558zGVVNAha3WrflrCZ7QfhGBaTc6u2zRdCnNOnCAk4H1hiexiXOyqcOmwlvTDxtNi
         3FjyG3RtU+IFKl7Dx/99bxBnp4Zvh98UEdeHrPbqwdXN695Cr1aDE3xGnJuCEP1/1VdJ
         7JBfSCSL9UPiYmtUrSNkhPyUGBNCabONis4Olzq0zIzzqEw3uC+6Ej4fUUwGDzfuo+cx
         ag8rh0k4CCYid/GvZqS68gQt81A5wR1Y/snkW5BqNA0SSE4exBEmybMVulHNPzDsCOZt
         dKog==
X-Gm-Message-State: AFq9FYLg23Aw0Gvf3oOFS3LAnQn7XyVLc99PIoZZM8pvj3nqFppniIB5
	3L5X2F+vu8HMJ4SDy6694g/w3OwCMbiXb23t/vJuCwOmm1ozgahu8YuHyIejlw==
X-Gm-Gg: AYBFou26hAKaVpzMbglTV8Mwld42gJCveOeffCcWo4IX87z8oqjVsJ4DDlyuER8RAx/
	QLbuDVOZ8/NB+veLZVFzROYwZsCMh5fz6/PRREIxm8+t5kry59JiZA6LMYr7IFHZClAD23AAfk8
	//4oqko2sq6cpb0cvkwfkaXWqxTLL3ZGLmueWNmEHb05JnNOIJ+TeBQkM2xXJ64w0zwEkUhNCgK
	+NQzl4c58FQNpC0WFWIaeWtDGtnuW6ZBXLz32qfkE4wDeIOviVg+W4kxDRiFYFABsoKC3NMZZwq
	WIjZV2P99RzCpXLX+u30HGnMwfsxNvOoqrEUA3XCx4if7k4LpcImXR0v40/BqUvCMjJHejIuCYv
	Ai+7ctC43AQ8qo6JjUMclmRcauEmMgJELDPUOEpjxpvggg0FsZNQgOeggGfBCUlOoeyy1BLfAoy
	4vn8hJQUIOQRYYr8D4xFdtDvvKy2liinT7gUwFmNpHNDjEUi1IyXuDpgvxR8odJ1WEVLKe3pPGd
	+X7/LNIhlkjgA==
X-Received: by 2002:a05:6a21:7111:b0:3e1:d874:7c1b with SMTP id adf61e73a8af0-3e1d8747dabmr1078811637.49.1791961454801;
        Wed, 14 Oct 2026 00:04:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d803d6410sm725352b3a.33.2026.10.14.00.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:13 -0700 (PDT)
Message-Id: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:07 +0000
Subject: [PATCH v9 0/5] fetch: avoid fetching every branch of a new remote in a shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v9:

 * Moved the do_fetch() if/else-if/else split out of the preliminary
   helper-extraction commit and into the refmap-inference commit that needs
   it. Preliminary commit is now a simpler refactor.

Changes in v8:

 * Split into a preliminary collect_upstream_from_remote() helper commit
   plus a simplified refmap-inference commit.
 * Fixed a regression that could drop the current branch's @{upstream} when
   remote.<name>.fetch was narrowed.
 * Threaded struct repository * through instead of hardcoding
   the_repository.
 * Minor naming and comment cleanups.

Changes in v7:

 * Fixed fatal: --refmap option is only meaningful with command-line
   refspec(s) firing just from configuring remote.<name>.refmap alone, with
   nothing else to fetch.
 * When both remote.<name>.fetch and remote.<name>.refmap are configured, a
   refspec-less fetch follows .fetch as usual, .refmap only remaps something
   already being fetched by name. Added tests.

Changes in v6:

 * Remove leftover reference to deleted default-branch logic in commit
   message.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (5):
  fetch: add remote.<name>.refmap
  fetch: extract collect_upstream_from_remote() helper
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  84 ++++++++++++++++++----
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  51 ++++++++++++-
 remote.h                         |  19 +++++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  63 ++++++++++++++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 448 insertions(+), 23 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v9
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v8:

 1:  2a48c21bc8 = 1:  2a48c21bc8 fetch: add remote.<name>.refmap
 2:  08fea07a8b ! 2:  50382bce7e fetch: extract collect_upstream_from_remote() helper
     @@ Commit message
      
       ## builtin/fetch.c ##
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     - 
       	if (rs->nr) {
       		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     -+	} else if (transport->remote->fetch.nr) {
     -+		struct string_list tracked = STRING_LIST_INIT_DUP;
     -+		struct string_list_item *item;
     -+
     -+		refspec_ref_prefixes(&transport->remote->fetch,
     -+				     &transport_ls_refs_options.ref_prefixes);
     -+		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     -+			do_set_head = 1;
     -+
     -+		/*
     -+		 * The configured refspec may not cover the current
     -+		 * branch's upstream (e.g. a narrowed -t refspec), so
     -+		 * make sure we can still fetch it regardless.
     -+		 */
     -+		collect_upstream_from_remote(the_repository, &tracked,
     -+					      transport->remote, NULL);
     -+		for_each_string_list_item(item, &tracked)
     -+			strvec_push(&transport_ls_refs_options.ref_prefixes,
     -+				    item->string);
     -+		string_list_clear(&tracked, 0);
       	} else {
      -		struct branch *branch = branch_get(NULL);
      +		struct string_list tracked = STRING_LIST_INIT_DUP;
      +		struct string_list_item *item;
       
     --		if (transport->remote->fetch.nr) {
     --			refspec_ref_prefixes(&transport->remote->fetch,
     --					     &transport_ls_refs_options.ref_prefixes);
     --			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     --				do_set_head = 1;
     --		}
     + 		if (transport->remote->fetch.nr) {
     + 			refspec_ref_prefixes(&transport->remote->fetch,
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     + 				do_set_head = 1;
     + 		}
      -		if (branch && branch_has_merge_config(branch) &&
      -		    !strcmp(branch->remote_name, transport->remote->name)) {
      -			int i;
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      -					    branch->merge[i]->src);
      -			}
      -		}
     ++
     ++		/*
     ++		 * The configured refspec may not cover the current
     ++		 * branch's upstream (e.g. a narrowed -t refspec), so
     ++		 * make sure we can still fetch it regardless.
     ++		 */
      +		collect_upstream_from_remote(the_repository, &tracked,
      +					      transport->remote, NULL);
      +		for_each_string_list_item(item, &tracked)
 3:  a39316d233 ! 3:  9ad8ad3eb4 fetch: infer branches to fetch from a refmap-only remote
     @@ builtin/fetch.c: static struct ref *get_ref_map(struct remote *remote,
       }
       
      @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 
     + 	if (rs->nr) {
     + 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
     +-	} else {
     ++	} else if (transport->remote->fetch.nr) {
     + 		struct string_list tracked = STRING_LIST_INIT_DUP;
     + 		struct string_list_item *item;
     + 
     +-		if (transport->remote->fetch.nr) {
     +-			refspec_ref_prefixes(&transport->remote->fetch,
     +-					     &transport_ls_refs_options.ref_prefixes);
     +-			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     +-				do_set_head = 1;
     +-		}
     ++		refspec_ref_prefixes(&transport->remote->fetch,
     ++				     &transport_ls_refs_options.ref_prefixes);
     ++		if (follow_remote_head != FOLLOW_REMOTE_NEVER)
     ++			do_set_head = 1;
     + 
     + 		/*
     + 		 * The configured refspec may not cover the current
     +@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     + 			strvec_push(&transport_ls_refs_options.ref_prefixes,
       				    item->string);
       		string_list_clear(&tracked, 0);
     - 	} else {
     ++	} else {
      +		/*
      +		 * The --refmap command line option, if given, takes
      +		 * precedence over remote.<name>.refmap.
      +		 */
      +		struct refspec *effective_refmap = refmap.nr ? &refmap :
      +			&transport->remote->refmap;
     - 		struct string_list tracked = STRING_LIST_INIT_DUP;
     - 		struct string_list_item *item;
     - 
     --		collect_upstream_from_remote(the_repository, &tracked,
     --					      transport->remote, NULL);
     ++		struct string_list tracked = STRING_LIST_INIT_DUP;
     ++		struct string_list_item *item;
     ++
      +		if (effective_refmap->nr) {
      +			branches_tracking_remote(the_repository,
      +						  transport->remote, &tracked);
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      +			collect_upstream_from_remote(the_repository, &tracked,
      +						      transport->remote, NULL);
      +		}
     - 		for_each_string_list_item(item, &tracked)
     - 			strvec_push(&transport_ls_refs_options.ref_prefixes,
     - 				    item->string);
     ++		for_each_string_list_item(item, &tracked)
     ++			strvec_push(&transport_ls_refs_options.ref_prefixes,
     ++				    item->string);
     ++		string_list_clear(&tracked, 0);
     + 
     + 		/*
     + 		 * If there are no refs specified to fetch, then we just
      
       ## remote.c ##
      @@ remote.c: void collect_upstream_from_remote(struct repository *repo,
 4:  2b974bbe0a = 4:  75169f668e remote: add "git remote add --limited-fetch"
 5:  db27c29086 = 5:  9ee090d3d0 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
