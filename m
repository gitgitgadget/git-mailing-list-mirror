Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F761F612
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2l5dZ9D"
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D753B1A5
	for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:58:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40790b0a224so42324545e9.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2023 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698224282; x=1698829082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=be8kIywj2UTUsmO91nbUBbelr4pOMsJjKKv4cBW0CTk=;
        b=S2l5dZ9DyJ098AJKL4ns/tqHZMwzEde0JlrxTPyyoolWLpcZUmyNGPQ9wqA+fdZq4W
         Um+ZVkpynE/9ApPXyip2z5OAlM9WQrDhb9Fk4Kv4x/3gN8aHRF9YbCsDY5SBUWtmRkxf
         vwIrDnthqs/d/eRACHrqhQtnROgLEKEOy44+p9Lx+mVDFM7vwpyd9QthwbuJRxv2kXF8
         nknIIPPDK3TcScVsKTFfOsRqqaCwWk9/Zel1XAMyugXtMiIctTDwgm+e4tttB5Ubg2yz
         HZyDSJx/CXLH66M+b5VDn5HU8IrCZoLx38DgzZajzsBm3VlqxAiyw0NA0pdmIcknz7p3
         2EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698224282; x=1698829082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=be8kIywj2UTUsmO91nbUBbelr4pOMsJjKKv4cBW0CTk=;
        b=R1qNkyxCXzhuEzuceWsA9ZtUCvrMyXgFteSsmqJmy28iRm197E7C60IAdvjYnQb6NC
         8TNE3zpJ972WRvz+YfzOAtfFj9fDeqnG5p013q4BzcQxPpHdPtNT7DI6FaXTRhYzJIgm
         Wg9xcpy970qpEWh/KDGkZSZ4Bv2LnUx2sld0aWamOQMJavClrJ92yWM22XCHDBSDpMqL
         9pwqI1SpquX3g6POCYVjW9g8fu6Eake7jC9hQBv4DpoHK2kdugOyZ9sl3U8mABInc+f1
         C4icgnNCdJJvoesEKM/yKo3Hx3EO7NzKTBXvp34n+ovkJtxFf0lritzLK7XgpvYtkxft
         hRbA==
X-Gm-Message-State: AOJu0YzQn18e9ZVWCkBhfx5pZquiPfPSlPDcfprZeX2ArFdyKG2WhqQo
	tv9fs+1vdDwPB64fp8nJRtMTbxBcOp0=
X-Google-Smtp-Source: AGHT+IGXdNq42LQZkkruaK+UopdR50roOruPQFiRdDI/0+RZ3nPVvhfT319i1uxaB2+j+R9G9yTgnA==
X-Received: by 2002:a05:600c:4f01:b0:408:3c8f:afd9 with SMTP id l1-20020a05600c4f0100b004083c8fafd9mr11170369wmq.3.1698224281702;
        Wed, 25 Oct 2023 01:58:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c4f5500b0040841e79715sm14244963wmq.27.2023.10.25.01.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 01:58:01 -0700 (PDT)
Message-ID: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
From: "Ruslan Yakauleu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Oct 2023 08:58:00 +0000
Subject: [PATCH] merge: --ff-one-only to apply FF if commit is one
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
Cc: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>,
    Ruslan Yakauleu <ruslan.yakauleu@gmail.com>

From: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>

A new option --ff-one-only to control the merging strategy.
For one commit option works like -ff to avoid extra merge commit.
In other cases the option works like --no-ff to create merge commit for
complex features.

Signed-off-by: Ruslan Yakauleu <ruslan.yakauleu@gmail.com>
---
    merge: --ff-one-only to apply FF if commit is one
    
    A new option --ff-one-only to control the merging strategy. For one
    commit option works like -ff to avoid extra merge commit. In other cases
    the option works like --no-ff to create merge commit for complex
    features.
    
    Plenty of developers want to simplify merge history. We have two main
    merging strategies:
    
     * Fast-forward (--ff) - There we can lose merge commits for complex
       features and if we need to roll back some feature we can't revert
       just one commit.
     * Merge (--no-ff) - There we have extra merges for extra simple
       changes.
    
    Before, the user had to choose between --ff/--no-ff every time to have
    history without extra merges for simple changes and to use merges for
    complex features.
    
    Ways to use the new option: git merge --ff-one-only git config merge.ff
    one-only git config branch.master.mergeoptions --ff-one-only

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1599%2FQuAzI%2Fmerge%2Fff-one-only-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1599/QuAzI/merge/ff-one-only-v1
Pull-Request: https://github.com/git/git/pull/1599

 Documentation/config/merge.txt |  3 +++
 builtin/merge.c                | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/merge.txt b/Documentation/config/merge.txt
index 8851b6cedef..6cd5daa4d64 100644
--- a/Documentation/config/merge.txt
+++ b/Documentation/config/merge.txt
@@ -31,6 +31,9 @@ merge.ff::
 	a case (equivalent to giving the `--no-ff` option from the command
 	line). When set to `only`, only such fast-forward merges are
 	allowed (equivalent to giving the `--ff-only` option from the
+	command line). When set to `one-only`, fast-forward merge allowed
+	only for one commit, in other way extra merge commit should be
+	created (equivalent to giving the `--ff-one-only` option from the
 	command line).
 
 merge.verifySignatures::
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e135..100f0021e56 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -110,7 +110,8 @@ static const char *pull_twohead, *pull_octopus;
 enum ff_type {
 	FF_NO,
 	FF_ALLOW,
-	FF_ONLY
+	FF_ONLY,
+	FF_ONE_ONLY
 };
 
 static enum ff_type fast_forward = FF_ALLOW;
@@ -258,6 +259,7 @@ static struct option builtin_merge_options[] = {
 		N_("edit message before committing")),
 	OPT_CLEANUP(&cleanup_arg),
 	OPT_SET_INT(0, "ff", &fast_forward, N_("allow fast-forward (default)"), FF_ALLOW),
+	OPT_SET_INT(0, "ff-one-only", &fast_forward, N_("allow fast-forward if only one commit"), FF_ONE_ONLY),
 	OPT_SET_INT_F(0, "ff-only", &fast_forward,
 		      N_("abort if fast-forward is not possible"),
 		      FF_ONLY, PARSE_OPT_NONEG),
@@ -631,6 +633,8 @@ static int git_merge_config(const char *k, const char *v,
 			fast_forward = boolval ? FF_ALLOW : FF_NO;
 		} else if (v && !strcmp(v, "only")) {
 			fast_forward = FF_ONLY;
+		} else if (v && !strcmp(v, "one-only")) {
+			fast_forward = FF_ONE_ONLY;
 		} /* do not barf on values from future versions of git */
 		return 0;
 	} else if (!strcmp(k, "merge.defaulttoupstream")) {
@@ -1527,6 +1531,18 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		free(list);
 	}
 
+	if (fast_forward == FF_ONE_ONLY) {
+		fast_forward = FF_NO;
+
+		/* check that we have one and only one commit to merge */
+		if (squash || ((!remoteheads->next &&
+				!common->next &&
+				oideq(&common->item->object.oid, &head_commit->object.oid)) &&
+				oideq(&remoteheads->item->parents->item->object.oid, &head_commit->object.oid))) {
+			fast_forward = FF_ALLOW;
+		}
+	}
+
 	update_ref("updating ORIG_HEAD", "ORIG_HEAD",
 		   &head_commit->object.oid, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
 

base-commit: 2e8e77cbac8ac17f94eee2087187fa1718e38b14
-- 
gitgitgadget
