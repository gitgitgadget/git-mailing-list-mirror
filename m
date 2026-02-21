Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB633120C
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 23:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771718397; cv=none; b=dVG2kPdAbKIxDAmYsB8LcGFCzJsT2sJyq6Bal4uQchcsvUP0pxi0zk7ECyMZ708HR6OmmLLZQtc50tmtrsDKtVnWNEb4l5TZwwL2vSe46saIWb0eQxW3YDmoFUFIBD9H1Z734HdeHO5xiqayCf6dWhNRNZETA9I6xvK6UILOZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771718397; c=relaxed/simple;
	bh=irzPFMi+e13r85I0z/kBvB93JAh1KrIUB0ROZLDBMwU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TT0qMyRTDC++HsTUomirTm68+GnKn12P/lz8BuGTnBlHdlAzKSgi/BJZHjueFM1wg9EX00WYTjc2EKAgJb7TYjoJTwLB+5P4qP07eH/e4dmTPgukvyttQft+eEBvZiwaclEjs63hODoJFeU7HvQdIGqy12DOzWhTUyJ4pow7aqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6n2ASgS; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6n2ASgS"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506aa68065eso27772371cf.1
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 15:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771718395; x=1772323195; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSBNLiARWE0EZFOyZO9bJhTBpd/htsl47WgQ57BXB/Y=;
        b=D6n2ASgSWcg6BhxpxRah4oh9OF1VWrZmucblUcOpU48+IXENLhLrb9RzCW0+BSMdih
         n1z0/xT7STGCu88H1b3jczJWgVsEftwDNUNKJ3vcpcztzgJnQ5jspMLkbhQDbSZuRntt
         UQl+4P+jhJ9dBW9bTZIu5Us7q90wwPIrwlFj9Y/4HXHY1z2V2GkpFLt6gWIYgvbAVYIt
         Jczy/cExHLbJ+k8yBr/ztg5A86WyywRqd595Gnr8zLOakX7uYhUO5LjigfEPwWqXtxrr
         8FSukEmQU5f14121ti/mEOb/86SP0yZTbJ/36hDRdvgHSa3OlWN+MzLz/9usrTqzWf+j
         engA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771718395; x=1772323195;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZSBNLiARWE0EZFOyZO9bJhTBpd/htsl47WgQ57BXB/Y=;
        b=WN4ptzGZWCOXA61Qm3HG1fzmE0kjmKOfCnW5dAlB55/5SpV3elcU2ar5uxLSMR9Uby
         0bmm6bKmMbBEGbBVohaj5woVxPnxdVYKDsxDgguQdmsaxYiKZCUUSxAezE1CLRoHJvnH
         Q+dUnTXEzccND5QAMJeP+/d0YeZL7TBkTTZAj2dbAyBNIyoogsnHYZ66mK4pGJewePQ5
         T74kwzVI7pC+7KHQ6fvmx2x815UOaoAB8OS0CZF1St7EVQlYXgJCKya02poeE7rUPTz4
         TfGLGGypZfqxDI8cSDD3EtwEp6vZnr5aa93GSv5l8leT5XusX52l1DyWMyq+E+W8FbZZ
         HfTg==
X-Gm-Message-State: AOJu0YzWFNjriiK/Eab5v49mGuMxK8xa1MmXfJumJIaFZu2e3N0M3MOY
	cHevZZg/Bp+veS19GrPTGQoMLS1HDgsN7B5elRk7xCBLZLWSvRPXpotlzOE6dQ==
X-Gm-Gg: AZuq6aK85YYL6ysgvFkFTlJjlwrth+tCDVS6qeG5knthBnL1G580ABfWowF0MI8/isg
	2yrA6mZtdcLJpK14cHO/PgbJu+4m6IXNqm/k+9uWwA4tjrfDAEmmfcOmxF3U5zCV/c0lVsmKptd
	spQuBM69RRd0F67Q3HU5fKqPEuB3Ii38vRowJC+MPK0i6qc5+ld0Tehog2r/vjemzlVnTDknFAl
	ISCTXhTdMF8oKMXZvMJcEP0CRd6UbS/k0XFSSE2F5HCUWN9bDqFurKUoty1/VgGtSCtoshzEq4H
	is2kTPfMivdWuaVGB4yUveOENju6ytPsOlcuB5OhK9UInt6IfZrkdfzwbhAzMqKtJBSzhL4yEui
	RfSghWLlmWijWfnhGJG66ywTKtJGXCTzrYaZrjfW39M11u7iHzmaMKAk1zbL/nNRcdQkzQTjMeN
	Ej+4Nw87BLVFz+kfDnZBOZB13A
X-Received: by 2002:ac8:7dc3:0:b0:501:498e:5c29 with SMTP id d75a77b69052e-5070bce0524mr59826221cf.59.1771718394632;
        Sat, 21 Feb 2026 15:59:54 -0800 (PST)
Received: from [127.0.0.1] ([20.55.213.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e243147sm27520796d6.28.2026.02.21.15.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 15:59:54 -0800 (PST)
Message-Id: <pull.2048.v3.git.1771718393.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
References: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 21 Feb 2026 23:59:47 +0000
Subject: [PATCH v3 0/6] Avoid the_repository in merge-ort and replay
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
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

Changes since v2:

 * In first patch, actually avoid the_repository when attempting to remove
   check against the_repository
 * Fix commit message of patch 3 due to the new patch 1.
 * Slight tweak to commit message of patch 6.

Changes since v1:

 * Add a preparatory patch removing the_repository check from blob
   prefetching in both merge-ort and diff*; it's no longer necessary
 * Fix casing mismatch
 * Simplify the hammer a bit based on the new first patch, but add some
   simple comments explaining it

Remove explicit uses of the_repository and the_hash_algo from merge-ort, and
since this has now been done multiple times for both merge-ort and replay,
implement a small measure to prevent them from returning to either merge-ort
or replay.

See
https://lore.kernel.org/git/CABPp-BH7E1Bh2g0vR3T4NEsv34DvFQPzMuJSsqtOAaWY-fFCxg@mail.gmail.com/
and
https://lore.kernel.org/git/CABPp-BFuwvqiCTCCpoyT6em9_1-qrgPWHWhrufQ3UuZ+Kfkb6A@mail.gmail.com/
for recent discussions on these.

As noted in the comments on v1, I actually do not know why
prefetch_for_content_merges() needs to use the_repository. When I introduced
it back in 2bff554b23e8 (merge-ort: add prefetching for content merges,
2021-06-22), I was just looking at diffcore_std() and trying to mimic how it
did the prefetch, and it has such a comparison. If anyone knows why
diffcore_std() needs to compare against the_repository, I'd love to hear...

Series overview: Patches 1-3: Mostly mechanical removal of existing uses
Patches 4-5: Simple hammer to prevent the problem from returning

Elijah Newren (6):
  merge,diff: remove the_repository check before prefetching blobs
  merge-ort: pass repository to write_tree()
  merge-ort: replace the_repository with opt->repo
  merge-ort: replace the_hash_algo with opt->repo->hash_algo
  merge-ort: prevent the_repository from coming back
  replay: prevent the_repository from coming back

 diff.c            |  2 +-
 diffcore-break.c  |  2 +-
 diffcore-rename.c |  4 +-
 merge-ort.c       | 94 +++++++++++++++++++++++++----------------------
 replay.c          |  6 +++
 5 files changed, 61 insertions(+), 47 deletions(-)


base-commit: 73fd77805fc6406f31c36212846d9e2541d19321
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2048%2Fnewren%2Favoid_the_repository-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2048/newren/avoid_the_repository-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2048

Range-diff vs v2:

 1:  7155a0da6f ! 1:  e75334a5cf merge,diff: remove the_repository check before prefetching blobs
     @@ diff.c: void diffcore_std(struct diff_options *options)
       	 * decides that it needs inexact rename detection.
       	 */
      -	if (options->repo == the_repository && repo_has_promisor_remote(the_repository) &&
     -+	if (repo_has_promisor_remote(the_repository) &&
     ++	if (repo_has_promisor_remote(options->repo) &&
       	    (options->output_format & output_formats_to_prefetch ||
       	     options->pickaxe_opts & DIFF_PICKAXE_KINDS_MASK))
       		diff_queued_diff_prefetch(options->repo);
     @@ diffcore-break.c: static int should_break(struct repository *r,
       		return 0; /* they are the same */
       
      -	if (r == the_repository && repo_has_promisor_remote(the_repository)) {
     -+	if (repo_has_promisor_remote(the_repository)) {
     ++	if (repo_has_promisor_remote(r)) {
       		options.missing_object_cb = diff_queued_diff_prefetch;
       		options.missing_object_data = r;
       	}
     @@ diffcore-rename.c: static int find_basename_matches(struct diff_options *options
       	}
       
      -	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
     -+	if (repo_has_promisor_remote(the_repository)) {
     ++	if (repo_has_promisor_remote(options->repo)) {
       		dpf_options.missing_object_cb = basename_prefetch;
       		dpf_options.missing_object_data = &prefetch_options;
       	}
     @@ diffcore-rename.c: void diffcore_rename_extended(struct diff_options *options,
       	/* Finish setting up dpf_options */
       	prefetch_options.skip_unmodified = skip_unmodified;
      -	if (options->repo == the_repository && repo_has_promisor_remote(the_repository)) {
     -+	if (repo_has_promisor_remote(the_repository)) {
     ++	if (repo_has_promisor_remote(options->repo)) {
       		dpf_options.missing_object_cb = inexact_prefetch;
       		dpf_options.missing_object_data = &prefetch_options;
       	}
     @@ merge-ort.c: static void prefetch_for_content_merges(struct merge_options *opt,
       	struct oid_array to_fetch = OID_ARRAY_INIT;
       
      -	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
     -+	if (!repo_has_promisor_remote(the_repository))
     ++	if (!repo_has_promisor_remote(opt->repo))
       		return;
       
       	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
 2:  911cba991b = 2:  a9a9d422a3 merge-ort: pass repository to write_tree()
 3:  68af47ed18 ! 3:  4ebfcb08a5 merge-ort: replace the_repository with opt->repo
     @@ Commit message
          merge-ort: replace the_repository with opt->repo
      
          We have a perfectly valid repository available and do not need to use
     -    the_repository, except for one location in
     -    prefetch_for_content_merges().
     +    the_repository.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c: static int read_oid_strbuf(struct merge_options *opt,
       	if (!buf) {
       		path_msg(opt, ERROR_OBJECT_READ_FAILED, 0,
       			 path, NULL, NULL, NULL,
     -@@ merge-ort.c: static void prefetch_for_content_merges(struct merge_options *opt,
     - 	struct string_list_item *e;
     - 	struct oid_array to_fetch = OID_ARRAY_INIT;
     - 
     --	if (!repo_has_promisor_remote(the_repository))
     -+	if (!repo_has_promisor_remote(opt->repo))
     - 		return;
     - 
     - 	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
      @@ merge-ort.c: static int checkout(struct merge_options *opt,
       	unpack_opts.verbose_update = (opt->verbosity > 2);
       	unpack_opts.fn = twoway_merge;
 4:  bfa68716af = 4:  09076d81b6 merge-ort: replace the_hash_algo with opt->repo->hash_algo
 5:  932d945c9b = 5:  42a2576878 merge-ort: prevent the_repository from coming back
 6:  67db46f34f ! 6:  0654d04584 replay: prevent the_repository from coming back
     @@ Commit message
          coming back.
      
          Define the_repository to make it a compilation error so that they don't
     -    come back any more.
     +    come back any more; the repo parameter plumbed through the various
     +    functions can be used instead.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      

-- 
gitgitgadget
