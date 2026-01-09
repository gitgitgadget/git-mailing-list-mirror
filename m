Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CAE21C9EA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997432; cv=none; b=iOsQZOWoTbDslfSF8iwa5IoFuupvaT6gGnYydhLYURMxNVzzXauDHcIDhygcbvzdEa9C2vMWHeKX4ZjWLN8aloQHxF8td9IovWp3Ta+rLWRqf5ilU9Mwhd4rm03CdqhJdH1CUtqDCkhTPepu+X5ofvYBR5k46qHrlSxouoWSCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997432; c=relaxed/simple;
	bh=XLyiZYnFWamVtXcrppmor75jg46EOjW3F8CjHc1Hlc0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=hjo09gGRUZ4IixvGdhEo/zgtQ0zfAyLg8YcVQMyfgI4flci+7KpG2r81CvxFOszWT4KKrdcTzwPOL5Kpf4UR591FsDbhRELOtaWqalSBjJIzk8w8mL8fuSCL5f5tqXJnPZqT51wInqxjUfTRAduHfyRfqmIE8sKE8ykcKhVO1/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvvz6P9v; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvvz6P9v"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8bb6a27d390so302632885a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 14:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997427; x=1768602227; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5Uqmy/p06oAVnVexzoHwRn8KZSdSlMYKyJxdZ3SAy0=;
        b=Hvvz6P9vPeRlF6QHfCKxtqZEQ8ZQyj9ndXHHlyDeA3cJUDXmdr6gDseu0dZiXvh+Bk
         KZfOUjor1rVD60NahK8y/EJME7XSK59sEsZ7XtA61/iXihlHu+c/P+FsinkrMLxOoG/t
         KTBBmWgHlkzdbYnLKJZfrF6i2mNnHmzfvJDnY7Dl0VT6kDzeipzTM+jArhdeYFHUvrjl
         eUJr/YGD22+7dXBXMyKtj14I+oCqSJOblHQHwCwYthHSs8ZxbBKQhTzGKnIeMOvILmPk
         7R9cggV8ZoDWvHBLICIxd/g28Czq9+y76GZRBzrQY7bH9beGajlhIZH3FJ5qWHD+NFgd
         wMrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997427; x=1768602227;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t5Uqmy/p06oAVnVexzoHwRn8KZSdSlMYKyJxdZ3SAy0=;
        b=PdmgMsnbNycjN8EDFLubmN2CLfs56+PYsx+J86O61OIum/WKnqD9ys1dYKD5pJz5Yi
         3ew6/Wc+nn0gwTEOva08psXeoaPUNLDT0402QgFO8q12fv+WR3/5LQN3so+ZT/7TqOqV
         5UP6swznp7W9T2aM/LMcAeywgOhYHfVvUNQkV0UpRd1hipK2U3977hf3ONneuEPFPUjD
         7AKo9RCLIZx094vhatwvAbH1tQ9mYqxeb75YNHRth4ZOi3wpGBhtGZKaqsgnddTGEvC0
         5PVBLsaoa5zh9+tzM3O8oCdggAt8UgnZAUyl0F2dD04C6df8hiO605I5PaznEIBPyiY5
         TUlg==
X-Gm-Message-State: AOJu0Yw3oU6khSihrLM1AkJlw8N6GiXfomhiSXjAt5fGbf9YlDLcAJse
	qikps4iPEH3v7WwtAl6SU3VZ5c7skZcvFjuT99jsqs5Zw++xNx6SzgjfEstLSg==
X-Gm-Gg: AY/fxX458WEAb2xHrW609MldiUpeai77U/kJO1l7ntP9LA2gyl3D7Hw6vyuIlGrjjkG
	DWlhXrYBHgN/DwLd9lv0Bsti5F6pMXXHCb6vV8tC9YRe4JH6tbgUj7MXzh6wwHwQWFjxteLaZKz
	eRvccf++ONTEewqnoP4RqW4Qv+Bt1iuiuAepcvPgnnx4tR2XAju/zpC56oRmpM+XjWGNfr9H2gC
	XZO7W2KbtsA4VOR/DNOjIqSWjN6M6B0WKLSvuIodJnKxyspftHRz2iIjxMxCvIITUx5EY2FKdSX
	hhH5/Kw/NtFTPDlYZ9ilwmlpkR0s3EQsbnVWyQYe/SyYDhrNCR408k3bGz20qwz7Ck124y+pXTK
	VEtM7XUFZRqT1cI19fRnTxjFm7bpqHT2E1HpcQW1zxS1WYvzAFPPgIeMdu0X/ubXjdVJoay9rJs
	9ZJjsy53T5ie7HhQ==
X-Google-Smtp-Source: AGHT+IEeGno8g3wLOAb15PU2xnExmzOBmvFnOWf4WXHWT8Tl8BwfJKWt2zVgaD2EvIg4YVLqG81V0g==
X-Received: by 2002:a05:620a:298c:b0:8b2:ec5c:20bf with SMTP id af79cd13be357-8c38936ea1fmr1436536185a.29.1767997427281;
        Fri, 09 Jan 2026 14:23:47 -0800 (PST)
Received: from [127.0.0.1] ([135.119.237.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6b5bsm923373785a.8.2026.01.09.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:23:46 -0800 (PST)
Message-Id: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
From: "Samo =?UTF-8?Q?Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 22:23:44 +0000
Subject: [PATCH v2 0/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a merged
branch, we may endup with some shallows, that are behind the reachable ones.
Added test 'fetching deepen beyond merged branch' exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven fetches
result in all the correct shallows. That led to this proposal, which unifies
absolute and relative deepening in a way that the same get_shallow_commits()
call is used in both cases. The difference is only that depth is adapted for
relative deepening by measuring equivalent depth of current local shallow
commits in the current remote repo. Thus a new function get_shallows_depth()
has been added and the function get_reachable_list() became redundant /
removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of each
existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative deepening
anyway. That way we can allways summ 'data->deepen_relative' and 'depth'
values, because 'data->deepen_relative' is always 0 in absolute deepening.

Samo Pogačnik (2):
  shallow: free local object_array allocations
  shallow: handling fetch relative-deepen

 shallow.c             | 45 +++++++++++++++++--------
 shallow.h             |  1 +
 t/t5500-fetch-pack.sh | 23 +++++++++++++
 upload-pack.c         | 76 +++++--------------------------------------
 4 files changed, 64 insertions(+), 81 deletions(-)


base-commit: f0ef5b6d9bcc258e4cbef93839d1b7465d5212b9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2121%2Fspog%2Ffix-fetch-deepen-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2121/spog/fix-fetch-deepen-v2
Pull-Request: https://github.com/git/git/pull/2121

Range-diff vs v1:

 1:  277c8616a9 ! 1:  f8a8d077cd shallow: free local object_array allocations
     @@ Commit message
          does not free its dynamic elements before the function returns.
          As a result elements remain allocated and their reference forgotten.
      
     +    Also note, that test 'fetching deepen beyond merged branch' added by
     +    'shallow: handling fetch relative-deepen' patch fails without this
     +    correction in linux-leaks and linux-reftable-leaks test runs.
     +
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      
       ## shallow.c ##
 2:  b352a33c90 ! 2:  ba1f80105f shallow: handling fetch relative-deepen
     @@ Commit message
          shallow: handling fetch relative-deepen
      
          When a shallowed repository gets deepened beyond the beginning of a
     -    merged branch, we may endup with some shallows, that are behind the
     -    reachable ones. Added test 'fetching deepen beyond merged branch'
     -    exposes that behaviour.
     +    merged branch, we may end up with some shallows that are hidden behind
     +    the reachable shallow commits. Added test 'fetching deepen beyond
     +    merged branch' exposes that behaviour.
     +
     +    An example showing the problem based on added test:
     +    0. Whole initial git repo to be cloned from
     +    Graph:
     +    *   033585d (HEAD -> main) Merge branch 'branch'
     +    |\
     +    | * 984f8b1 (branch) five
     +    | * ecb578a four
     +    |/
     +    * 0cb5d20 three
     +    * 2b4e70d two
     +    * 61ba98b one
     +
     +    1. Initial shallow clone --depth=3 (all good)
     +    Shallows:
     +    2b4e70da2a10e1d3231a0ae2df396024735601f1
     +    ecb578a3cf37198d122ae5df7efed9abaca17144
     +    Graph:
     +    *   033585d (HEAD -> main) Merge branch 'branch'
     +    |\
     +    | * 984f8b1 five
     +    | * ecb578a (grafted) four
     +    * 0cb5d20 three
     +    * 2b4e70d (grafted) two
     +
     +    2. Deepen shallow clone with fetch --deepen=1 (NOT OK)
     +    Shallows:
     +    0cb5d204f4ef96ed241feb0f2088c9f4794ba758
     +    61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +    Graph:
     +    *   033585d (HEAD -> main) Merge branch 'branch'
     +    |\
     +    | * 984f8b1 five
     +    | * ecb578a four
     +    |/
     +    * 0cb5d20 (grafted) three
     +    ---
     +    Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +    is not reachable.
      
          On the other hand, it seems that equivalent absolute depth driven
          fetches result in all the correct shallows. That led to this proposal,
     @@ Commit message
          repo. Thus a new function get_shallows_depth() has been added and the
          function get_reachable_list() became redundant / removed.
      
     +    Same example showing the corrected second step:
     +    2. Deepen shallow clone with fetch --deepen=1 (all good)
     +    Shallow:
     +    61ba98be443fd51c542eb66585a1f6d7e15fcdae
     +    Graph:
     +    *   033585d (HEAD -> main) Merge branch 'branch'
     +    |\
     +    | * 984f8b1 five
     +    | * ecb578a four
     +    |/
     +    * 0cb5d20 three
     +    * 2b4e70d two
     +    * 61ba98b (grafted) one
     +
          The get_shallows_depth() function also shares the logic of the
          get_shallow_commits() function, but it focuses on counting depth of
          each existing shallow commit. The minimum result is stored as
     @@ Commit message
      
          Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
      
     + ## shallow.c ##
     +@@ shallow.c: static void free_depth_in_slab(int **ptr)
     + {
     + 	FREE_AND_NULL(*ptr);
     + }
     +-struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
     +-		int shallow_flag, int not_shallow_flag)
     ++struct commit_list *get_shallow_commits(struct object_array *heads,
     ++					struct object_array *shallows, int *deepen_relative,
     ++					int depth, int shallow_flag, int not_shallow_flag)
     + {
     +-	size_t i = 0;
     +-	int cur_depth = 0;
     ++	size_t i = 0, j;
     ++	int cur_depth = 0, cur_depth_shallow = 0;
     + 	struct commit_list *result = NULL;
     + 	struct object_array stack = OBJECT_ARRAY_INIT;
     + 	struct commit *commit = NULL;
     +@@ shallow.c: struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
     + 		}
     + 		parse_commit_or_die(commit);
     + 		cur_depth++;
     +-		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
     +-		    (is_repository_shallow(the_repository) && !commit->parents &&
     +-		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
     +-		     graft->nr_parent < 0)) {
     +-			commit_list_insert(commit, &result);
     +-			commit->object.flags |= shallow_flag;
     +-			commit = NULL;
     +-			continue;
     ++		if (shallows) {
     ++			for (j = 0; j < shallows->nr; j++)
     ++				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
     ++					if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
     ++						cur_depth_shallow = cur_depth;
     ++
     ++			if ((is_repository_shallow(the_repository) && !commit->parents &&
     ++			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
     ++			     graft->nr_parent < 0)) {
     ++				commit = NULL;
     ++				continue;
     ++			}
     ++		} else {
     ++			if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
     ++			    (is_repository_shallow(the_repository) && !commit->parents &&
     ++			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
     ++			     graft->nr_parent < 0)) {
     ++				commit_list_insert(commit, &result);
     ++				commit->object.flags |= shallow_flag;
     ++				commit = NULL;
     ++				continue;
     ++			}
     ++			commit->object.flags |= not_shallow_flag;
     + 		}
     +-		commit->object.flags |= not_shallow_flag;
     + 		for (p = commit->parents, commit = NULL; p; p = p->next) {
     + 			int **depth_slot = commit_depth_at(&depths, p->item);
     + 			if (!*depth_slot) {
     +@@ shallow.c: struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
     + 	}
     + 	deep_clear_commit_depth(&depths, free_depth_in_slab);
     + 	object_array_clear(&stack);
     +-
     ++	if (shallows && deepen_relative)
     ++		*deepen_relative = cur_depth_shallow;
     + 	return result;
     + }
     + 
     +
     + ## shallow.h ##
     +@@ shallow.h: int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
     + void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
     + 
     + struct commit_list *get_shallow_commits(struct object_array *heads,
     ++					struct object_array *shallows, int *deepen_relative,
     + 					int depth, int shallow_flag, int not_shallow_flag);
     + struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
     + 						    int shallow_flag, int not_shallow_flag);
     +
       ## t/t5500-fetch-pack.sh ##
      @@ t/t5500-fetch-pack.sh: test_expect_success 'fetching deepen' '
       	)
     @@ t/t5500-fetch-pack.sh: test_expect_success 'fetching deepen' '
      +		cd - &&
      +		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-merged" deepen.git &&
      +		git -C deepen.git fetch origin --deepen=1 &&
     -+		echo "Shallow:" && cat deepen.git/shallow &&
      +		git -C deepen.git rev-list --all >actual &&
     -+		echo "All rev-lis:" && cat actual &&
     -+		for commit in $(sed "/^$/d" deepen.git/shallow); do
     ++		for commit in $(sed "/^$/d" deepen.git/shallow)
     ++		do
      +			test_grep "$commit" actual || exit 1
      +		done
      +	)
     @@ t/t5500-fetch-pack.sh: test_expect_success 'fetching deepen' '
       	rm -rf server client &&
      
       ## upload-pack.c ##
     -@@
     - #include "json-writer.h"
     - #include "strmap.h"
     - #include "promisor-remote.h"
     -+#include "tag.h"
     - 
     - /* Remember to update object flag allocation in object.h */
     - #define THEY_HAVE	(1u << 11)
      @@ upload-pack.c: error:
       	return -1;
       }
       
      -static int get_reachable_list(struct upload_pack_data *data,
      -			      struct object_array *reachable)
     -+define_commit_slab(commit_depth, int *);
     -+static void free_depth_in_slab(int **ptr)
     ++static void get_shallows_depth(struct upload_pack_data *data)
       {
      -	struct child_process cmd = CHILD_PROCESS_INIT;
      -	int i;
     @@ upload-pack.c: error:
      -		o = lookup_object(the_repository, &oid);
      -		if (o && o->type == OBJ_COMMIT) {
      -			o->flags &= ~TMP_MARK;
     -+	FREE_AND_NULL(*ptr);
     -+}
     -+static void get_shallows_depth(struct upload_pack_data *data)
     -+{
     -+	size_t i = 0, j;
     -+	int cur_depth = 0, cur_depth_shallow = 0;
     -+	struct object_array stack = OBJECT_ARRAY_INIT;
     -+	struct commit *commit = NULL;
     -+	struct commit_graft *graft;
     -+	struct commit_depth depths;
     -+	struct object_array *heads = &data->want_obj;
     -+	struct object_array *shallows = &data->shallows;
     -+
     -+	init_commit_depth(&depths);
     -+	while (commit || i < heads->nr || stack.nr) {
     -+		struct commit_list *p;
     -+		if (!commit) {
     -+			if (i < heads->nr) {
     -+				int **depth_slot;
     -+				commit = (struct commit *)
     -+					deref_tag(the_repository,
     -+						  heads->objects[i++].item,
     -+						  NULL, 0);
     -+				if (!commit || commit->object.type != OBJ_COMMIT) {
     -+					commit = NULL;
     -+					continue;
     -+				}
     -+				depth_slot = commit_depth_at(&depths, commit);
     -+				if (!*depth_slot)
     -+					*depth_slot = xmalloc(sizeof(int));
     -+				**depth_slot = 0;
     -+				cur_depth = 0;
     -+			} else {
     -+				commit = (struct commit *)
     -+					object_array_pop(&stack);
     -+				cur_depth = **commit_depth_at(&depths, commit);
     -+			}
     - 		}
     +-		}
      -	}
      -	for (i = get_max_object_index(the_repository); 0 < i; i--) {
      -		o = get_indexed_object(the_repository, i - 1);
     @@ upload-pack.c: error:
      -		    (o->flags & TMP_MARK)) {
      -			add_object_array(o, NULL, reachable);
      -				o->flags &= ~TMP_MARK;
     -+		parse_commit_or_die(commit);
     -+		cur_depth++;
     -+		for (j = 0; j < shallows->nr; j++)
     -+			if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
     -+				if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
     -+					cur_depth_shallow = cur_depth;
     -+
     -+		if ((is_repository_shallow(the_repository) && !commit->parents &&
     -+		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
     -+		     graft->nr_parent < 0)) {
     -+			commit = NULL;
     -+			continue;
     -+		}
     -+		for (p = commit->parents, commit = NULL; p; p = p->next) {
     -+			int **depth_slot = commit_depth_at(&depths, p->item);
     -+			if (!*depth_slot) {
     -+				*depth_slot = xmalloc(sizeof(int));
     -+				**depth_slot = cur_depth;
     -+			} else {
     -+				if (cur_depth >= **depth_slot)
     -+					continue;
     -+				**depth_slot = cur_depth;
     -+			}
     -+			if (p->next)
     -+				add_object_array(&p->item->object,
     -+						NULL, &stack);
     -+			else {
     -+				commit = p->item;
     -+				cur_depth = **commit_depth_at(&depths, commit);
     -+			}
     - 		}
     - 	}
     +-		}
     +-	}
      -	close(cmd.out);
      -
      -	if (finish_command(&cmd)) {
     @@ upload-pack.c: error:
      -out:
      -	child_process_clear(&cmd);
      -	return ret;
     -+	deep_clear_commit_depth(&depths, free_depth_in_slab);
     -+	object_array_clear(&stack);
     -+	data->deepen_relative = cur_depth_shallow;
     ++	get_shallow_commits(&data->want_obj, &data->shallows,
     ++			    &data->deepen_relative, 0,
     ++			    SHALLOW, NOT_SHALLOW);
       }
       
       static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
     @@ upload-pack.c: static void deepen(struct upload_pack_data *data, int depth)
      +		if (data->deepen_relative)
      +			get_shallows_depth(data);
      +
     -+		result = get_shallow_commits(&data->want_obj,
     ++		result = get_shallow_commits(&data->want_obj, NULL, NULL,
      +					     data->deepen_relative + depth,
       					     SHALLOW, NOT_SHALLOW);
       		send_shallow(data, result);

-- 
gitgitgadget
