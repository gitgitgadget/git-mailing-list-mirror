Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AF4148850
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 01:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771552792; cv=none; b=thH1EwXF/5zrL6Y8eBFS0rLw/bzC/SAxGYTOfRH/C84sB1D8DG35XOo+uq18a/yoY4cmbXf1KmPDoISWO4EGQzhRz1nDf+WjcpAbutx8u8ZUVzFdoIlFK4AXIyI5vTF2rPn3sMZ6fIBQc2wuNqqRW2DNIXr08B7ws76kvo5s6Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771552792; c=relaxed/simple;
	bh=bE6hnaHj/MpzcLFrly0Ir7+E0vngVd/Yt8iDu9wxmsc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ROwhJuaDYHFVtu1LWHt4zrpJDC2fxjAMWd+stduzTpljPVvgb7PRgLwsAFzc5IcOD0py7CoYvnyJHZdzJdQCquCD5ANu+wzDD0VKCk6acHelYi1hYi0MKL7LLwJtAtK9HFZNNsOizCkLBuz+vk5ZczZTHi/KYEgwsgt3X1TOGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRz8JV0P; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRz8JV0P"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba64b5a53aso1540349eec.0
        for <git@vger.kernel.org>; Thu, 19 Feb 2026 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771552790; x=1772157590; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRCDTQWuZI7j+zJWVahkmn2BWn/6XSPiUTwVYPMCqlY=;
        b=dRz8JV0P+leUjj9X8hnlBmlRtcQQvCiOE8tsWTGKBRk3lmIEMdLj9/HUY09VDe05K7
         0RK+TLNCuNpTsi5urEwPPB4SX29azC5N0w8JbvTMOSfRSRm7JoMxfwSo7BzJsH19nxlH
         AZYvZKzmI732WsAdxyOiQX/GtBgUldhBCy0AAoEovS9rkcACeswtX7ruRMybpL0y9DPp
         Iewok2ly5jVSXDEND9jolHPSkb/5ev7Qx1f1Ny8e3u2uZ465J2OsTAmqcmg1cIAqP+Ou
         GPG/xGB42NY/BfBLD1cKeLPP3CtO4PLfPZwjQGepNNL+t0rG0jGLAmfLt3ZmfRHh+1hw
         EVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771552790; x=1772157590;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRCDTQWuZI7j+zJWVahkmn2BWn/6XSPiUTwVYPMCqlY=;
        b=I56nmPDKRZc64gcenJZvLC7RospTE4C8wVV+0129PfqDhpu9OCle7/U4k+w6ixvgZe
         ThKWNjlbfTG30vH/t7uoxFbRQCRAicCDWxdhYFd8IGB+75LKeJoWCvZOGx163ND0IJ7S
         gjJv/pIipl5RDx/rv8HtQnF7aKRel77qb0LUIzp22PofKRwT4Ibn3VkJid2SQyvNQfUi
         eyiQyCnBUtFRTd0dDw+QN4yfFfFI0Zeaz0dLZZnpLMDmnkRHTPRxXqEwj0FhwRYvlvU4
         QezYKFQCxKmbbIQfHCJcX4drKld99auYfvUM2ZB2WIkOajlTaz/ewaD8P9SikNxSJPCa
         dWVA==
X-Gm-Message-State: AOJu0YwlbffRmThDE0EkFisCJwUDCSa95lLzcn76dIf9zm3nriMT0Qxf
	1yLT/H1kY5gVRHMAytfH8jM8Ha1aJ/OQT5lC44nkqPx1CmKE7ljZrk0VAA+xLA==
X-Gm-Gg: AZuq6aISoVP8CszScb8B5RSIHMheb3f602HuTUzpXEHuCEklEeaxY9B19M/DTKFXOkn
	MLWVkrAB466ZR6h67LrfrB4Ehkzwrr0jY367GLbN6q9Eb/H3NPcj8O4808o0cMf2ERQb/QAj7Yp
	oI/xgxFkmUoPhCBuHsRvKp50KjNYc0VqeMPzPJuPZ86sfIl5grteqCTvw9IypG+LP27Ab6hYVt9
	Xz6EJc2mzhpDF3FyiyJkpc3G2ps0mcob8v7bygWEm67xCuT5IPXkz3rPOY3jolXDfBnV8dfmJMx
	4J0NpKZR/34MBuzUHWKa4+9CVQXw6US7E8/Tfj/44YsHiWQIZqDuY769FMAEAen9yMaO5G++Wgs
	rGGB/PdC1tOvKM1tE3/1fnZv03ASeYEZ1EIkcpJtgaVK/2SNpVYLsJj2BROjsyhpdId2VbPUkq+
	ebh/ScMbnc4OC1DMd66o8ZliO1mbJ0i7juwd2c
X-Received: by 2002:a05:7300:fd14:b0:2ae:5d3b:e1c6 with SMTP id 5a478bee46e88-2bac97a074fmr8743038eec.21.1771552789600;
        Thu, 19 Feb 2026 17:59:49 -0800 (PST)
Received: from [127.0.0.1] ([172.215.211.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb66c24esm21698829eec.27.2026.02.19.17.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 17:59:49 -0800 (PST)
Message-Id: <pull.2048.v2.git.1771552788.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Feb 2026 01:59:42 +0000
Subject: [PATCH v2 0/6] Avoid the_repository in merge-ort and replay
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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2048%2Fnewren%2Favoid_the_repository-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2048/newren/avoid_the_repository-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2048

Range-diff vs v1:

 -:  ---------- > 1:  7155a0da6f merge,diff: remove the_repository check before prefetching blobs
 1:  620c4ea38b = 2:  911cba991b merge-ort: pass repository to write_tree()
 2:  abba4bd762 ! 3:  68af47ed18 merge-ort: replace the_repository with opt->repo
     @@ merge-ort.c: static void prefetch_for_content_merges(struct merge_options *opt,
       	struct string_list_item *e;
       	struct oid_array to_fetch = OID_ARRAY_INIT;
       
     --	if (opt->repo != the_repository || !repo_has_promisor_remote(the_repository))
     -+	if (opt->repo != the_repository || !repo_has_promisor_remote(opt->repo))
     +-	if (!repo_has_promisor_remote(the_repository))
     ++	if (!repo_has_promisor_remote(opt->repo))
       		return;
       
       	for (e = &plist->items[plist->nr-1]; e >= plist->items; --e) {
 3:  36c2713ceb ! 4:  bfa68716af merge-ort: replace the_hash_algo with opt->repo->hash_algo
     @@ Metadata
       ## Commit message ##
          merge-ort: replace the_hash_algo with opt->repo->hash_algo
      
     +    We have a perfectly valid repository available and do not need to use
     +    the_hash_algo (a shorthand for the_repository->hash_algo), so use the
     +    known repository instead.
     +
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##
 4:  46c24e0d05 ! 5:  932d945c9b merge-ort: prevent the_repository from coming back
     @@ Metadata
       ## Commit message ##
          merge-ort: prevent the_repository from coming back
      
     -    There are two things preventing us from removing our usage of
     -    USE_THE_REPOSITORY_VARIABLE: one necessary use of the_repository in
     -    prefetch_for_content_merges(), and the use of DEFAULT_ABBREV.  We have
     -    removed all other uses of the_repository in merge-ort before (multiple
     -    times), but without removing that definition, they keep coming back.
     +    Due to the use of DEFAULT_ABBREV, we cannot get rid of our usage of
     +    USE_THE_REPOSITORY_VARIABLE.  However, we have removed all other uses of
     +    the_repository in merge-ort a few times.  But they keep coming back.
      
          Define the_repository to make it a compilation error so that they don't
     -    come back any more, with a special carve-out for
     -    prefetch_for_content_merges().
     +    come back any more.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ merge-ort.c
       #include "unpack-trees.h"
       #include "xdiff-interface.h"
       
     ++/*
     ++ * We technically need USE_THE_REPOSITORY_VARIABLE above for DEFAULT_ABBREV,
     ++ * but do not want more uses of the_repository.  Prevent them.
     ++ *
     ++ * opt->repo is available; use it instead.
     ++ */
      +#define the_repository DO_NOT_USE_THE_REPOSITORY
      +
       /*
        * We have many arrays of size 3.  Whenever we have such an array, the
        * indices refer to one of the sides of the three-way merge.  This is so
     -@@ merge-ort.c: static int process_entry(struct merge_options *opt,
     - 	return 0;
     - }
     - 
     -+#undef the_repository
     -+
     - static void prefetch_for_content_merges(struct merge_options *opt,
     - 					struct string_list *plist)
     - {
     -@@ merge-ort.c: static void prefetch_for_content_merges(struct merge_options *opt,
     - 	oid_array_clear(&to_fetch);
     - }
     - 
     -+#define the_repository DO_NOT_USE_the_repository
     -+
     - static int process_entries(struct merge_options *opt,
     - 			   struct object_id *result_oid)
     - {
 5:  d75a71aef9 ! 6:  67db46f34f replay: prevent the_repository from coming back
     @@ replay.c
       #include "strmap.h"
       #include "tree.h"
       
     ++/*
     ++ * We technically need USE_THE_REPOSITORY_VARIABLE for DEFAULT_ABBREV, but
     ++ * do not want to use the_repository.
     ++ */
      +#define the_repository DO_NOT_USE_THE_REPOSITORY
      +
       static const char *short_commit_name(struct repository *repo,

-- 
gitgitgadget
