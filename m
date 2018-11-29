Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12C60211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeK3B5S (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:57:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40635 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731338AbeK3B3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so1003175pgp.7
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lZFsqcpGPLhT+WpmiwnW7J36XOVIXrRvIySwl9yH3sk=;
        b=LLtJW9WRgF28FoY7cOM6jtb04XVd8ieS5wx4Ji8QGTBsbGkA/6sdcfovbfEv+4xOoq
         KZbPQrMyv9MHy8IzeK7mOA02cAfKcKJSVXNlwRZyXtvnP6HTCuE6/ToaOnFLwBFxX1XR
         5376Rniu8P5lv96lNCSMe3PTMDFSd7krEvnuzF2tH3ZlpuG6MCA8F+/Dq0tTR3Cvz8oS
         dEdJaNksCDf8WhRLXE9mfEXlqnbLChOnMj5H5RfDzRoIX0vpS8XowxWKHKYePPAFzjPd
         Wqdj1YJOUMPfLz9JBWYp0uh3aCuOfO5tWu8NLCeLNv8HnEil+2cmk1asUd9/gATM7t8M
         ln/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lZFsqcpGPLhT+WpmiwnW7J36XOVIXrRvIySwl9yH3sk=;
        b=XMg5IS1SKtXsIeunJ8e1jsk70dqp8xZetrs2VjmR2qi1TmDZd7dtS73PkDgd6Poj8C
         LoSIMvOoq53AWO4wnUYJcb4UQq0Rk6iKOm0EU0quPmooBf09bMxrYOpdzT8oorLyk9K3
         wB0uwlCc5iMYXzO8DXxhqv/2CS2XUGsAtOvkjqz81xCCF2VxJqMdLl8EAwbyYq2DV07r
         jSjkr6KnwHFvXReqgtC8EEhHcUzd9TCOTzsAVlqy/a3zBlnPgmGcF9b754rWG0YzCeuW
         KlzRdRh4gpsEtYDlA0Ezv8M7RFlf8MgRA7U+Hk4iq/8jXLbjxL1ddUzLdM8GzXYtaV5E
         I6RQ==
X-Gm-Message-State: AA+aEWYZ2APPBrooNw4Yhgp1iIVlQBQtTBMq0CUxJxcJiae6XMjAyRM+
        vgml9LBqyZn8HN3D+9tmhKJcHPAt
X-Google-Smtp-Source: AFSGD/VCNrgJ+6AnqQGDab9pnQNVuPU0SQjyFxC+jW+3iL2nflXaj93K3ecqlTjeMsf/yE+62x/R9g==
X-Received: by 2002:a63:2109:: with SMTP id h9mr225036pgh.277.1543501441010;
        Thu, 29 Nov 2018 06:24:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id v14sm7535491pgf.3.2018.11.29.06.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:00 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:00 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:52 GMT
Message-Id: <pull.89.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/6] Add a new "sparse" tree walk algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the biggest remaining pain points for users of very large
repositories is the time it takes to run 'git push'. We inspected some slow
pushes by our developers and found that the "Enumerating Objects" phase of a
push was very slow. This is unsurprising, because this is why reachability
bitmaps exist. However, reachability bitmaps are not available to us because
of the single pack-file requirement. The bitmap approach is intended for
servers anyway, and clients have a much different behavior pattern.

Specifically, clients are normally pushing a very small number of objects
compared to the entire working directory. A typical user changes only a
small cone of the working directory, so let's use that to our benefit.

Create a new "sparse" mode for 'git pack-objects' that uses the paths that
introduce new objects to direct our search into the reachable trees. By
collecting trees at each path, we can then recurse into a path only when
there are uninteresting and interesting trees at that path. This gains a
significant performance boost for small topics while presenting a
possibility of packing extra objects.

The main algorithm change is in patch 4, but is set up a little bit in
patches 1 and 2.

As demonstrated in the included test script, we see that the existing
algorithm can send extra objects due to the way we specify the "frontier".
But we can send even more objects if a user copies objects from one folder
to another. I say "copy" because a rename would (usually) change the
original folder and trigger a walk into that path, discovering the objects.

In order to benefit from this approach, the user can opt-in using the
pack.useSparse config setting. This setting can be overridden using the
'--no-sparse' option.

Update in V2: 

 * Added GIT_TEST_PACK_SPARSE test option.
 * Fixed test breakages when GIT_TEST_PACK_SPARSE is enabled by adding null
   checks.

Derrick Stolee (6):
  revision: add mark_tree_uninteresting_sparse
  list-objects: consume sparse tree walk
  pack-objects: add --sparse option
  revision: implement sparse algorithm
  pack-objects: create pack.useSparse setting
  pack-objects: create GIT_TEST_PACK_SPARSE

 Documentation/git-pack-objects.txt |   9 +-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |  10 ++-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  55 +++++++++++-
 list-objects.h                     |   4 +-
 revision.c                         | 121 +++++++++++++++++++++++++
 revision.h                         |   2 +
 t/README                           |   4 +
 t/t5322-pack-objects-sparse.sh     | 139 +++++++++++++++++++++++++++++
 11 files changed, 340 insertions(+), 10 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-89%2Fderrickstolee%2Fpush%2Fsparse-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-89/derrickstolee/push/sparse-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/89

Range-diff vs v1:

 1:  b73b8de98c = 1:  60617681f7 revision: add mark_tree_uninteresting_sparse
 2:  9bf04c748b ! 2:  4527addacb list-objects: consume sparse tree walk
     @@ -116,6 +116,10 @@
      +	for (parents = commit->parents; parents; parents = parents->next) {
      +		struct commit *parent = parents->item;
      +		struct tree *tree = get_commit_tree(parent);
     ++
     ++		if (!tree)
     ++			continue;
     ++
      +		oidset_insert(set, &tree->object.oid);
      +
      +		if (!(parent->object.flags & UNINTERESTING))
     @@ -142,14 +146,14 @@
      +
       	for (list = revs->commits; list; list = list->next) {
       		struct commit *commit = list->item;
     -+		
     + 
     +-		if (commit->object.flags & UNINTERESTING) {
      +		if (sparse) {
      +			struct tree *tree = get_commit_tree(commit);
     -+			
     ++
      +			if (commit->object.flags & UNINTERESTING)
      +				tree->object.flags |= UNINTERESTING;
     - 
     --		if (commit->object.flags & UNINTERESTING) {
     ++
      +			oidset_insert(&set, &tree->object.oid);
      +			add_edge_parents(commit, revs, show_edge, &set);
      +		} else if (commit->object.flags & UNINTERESTING) {
     @@ -189,3 +193,17 @@
       
       struct oidset;
       struct list_objects_filter_options;
     +
     +diff --git a/revision.c b/revision.c
     +--- a/revision.c
     ++++ b/revision.c
     +@@
     + 	while ((oid = oidset_iter_next(&iter))) {
     + 		struct tree *tree = lookup_tree(r, oid);
     + 
     ++		if (!tree)
     ++			continue;
     ++
     + 		if (tree->object.flags & UNINTERESTING) {
     + 			/*
     + 			 * Remove the flag so the next call
 3:  9d6b8f6d06 = 3:  9644f6ff04 pack-objects: add --sparse option
 4:  0725aac4bb ! 4:  c99957d06f revision: implement sparse algorithm
     @@ -157,6 +157,9 @@
      +	struct tree_desc desc;
      +	struct name_entry entry;
      +
     ++	if (!tree)
     ++		return;
     ++
      +	if (parse_tree_gently(tree, 1) < 0)
      +		return;
      +
     @@ -168,13 +171,15 @@
      +
      +			if (tree->object.flags & UNINTERESTING) {
      +				struct tree *child = lookup_tree(r, entry.oid);
     -+				child->object.flags |= UNINTERESTING;
     ++				if (child)
     ++					child->object.flags |= UNINTERESTING;
      +			}
      +			break;
      +		case OBJ_BLOB:
      +			if (tree->object.flags & UNINTERESTING) {
      +				struct blob *child = lookup_blob(r, entry.oid);
     -+				child->object.flags |= UNINTERESTING;
     ++				if (child)
     ++					child->object.flags |= UNINTERESTING;
      +			}
      +			break;
      +		default:
     @@ -201,6 +206,9 @@
      +	       (oid = oidset_iter_next(&iter))) {
       		struct tree *tree = lookup_tree(r, oid);
       
     + 		if (!tree)
     + 			continue;
     + 
      -		if (tree->object.flags & UNINTERESTING) {
      -			/*
      -			 * Remove the flag so the next call
 5:  bbc3f78182 = 5:  d6912188be pack-objects: create pack.useSparse setting
 -:  ---------- > 6:  3d394a9136 pack-objects: create GIT_TEST_PACK_SPARSE

-- 
gitgitgadget
