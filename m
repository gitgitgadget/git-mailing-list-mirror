Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D36C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 05:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiFHF2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbiFHF1l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 01:27:41 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359117DDF5
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 19:43:03 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n144so4448115iod.4
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 19:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=A5S9VaGalBejMucq7yy27yOqV6EA4VoYN7TkaimXWcg=;
        b=T2qfTSISVwTXZk7pTSClgUKzuWJcDeqM1n7VfpPcQp6m3moXcaS8ApdaZoOZSgwFm+
         32TBbTYZAMqbTxRHLBMXlsfSsnmFZhKQnYoGSTpk/i6qArSCKIgXWik1P942voGuNavC
         ENILrrR4470y0s8LGnBNY+BGA+W8MARQ2vobPoDfIbfTFAQAwt2+leV1DDhHEhP8K8jF
         QTLP5HFJuQ9rFq5jgUgAI3jDRX2yyuTf81/6EEBPN5gumGNsN4HjBBwET6bpB1mNJ1GA
         AXBZxWLN1E4FEp4BaCQSEZzOxBTHmZrqeFP5OI2/bM5hc7zU/RYuLZhaYMFpl5lBJyD/
         9LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=A5S9VaGalBejMucq7yy27yOqV6EA4VoYN7TkaimXWcg=;
        b=Hf3jofvVV/rulOg3USKOwR2GSSTcFff/HtstsnKVSEu709y+8iBptkTkhCLnkA/r2y
         OZFfFn5F04JgAvZXMqlTJNyY09Dr/tVQMMrev25hHqdQE6KKrTxMCTsZxhLq6hB6lUe2
         P2SYopFGc10oDqq87Q5E7+xmNeFx8LwoVva7nHCbj2loxGDFaREi3YjLB2DQmkHm0u4l
         y4J+VnmdOM7AGA0y1oEVA01vd4wGDPy73RWaE2Qm2pmKlAmNa1VExRFV7su3cbFICyO4
         nChA20rhsArh3eJFjynv3NErpPht5e/n84ttdKauUgpE5WnqL+Nd1kvA420r4eyMsB0P
         bGRg==
X-Gm-Message-State: AOAM531O7aUST/Vh+WUuIRkBBV7omlKEzpGDPBPXmT/9T2A94H1P6xwm
        /MBozjvcNx3RSk1MrVoOLApD
X-Google-Smtp-Source: ABdhPJzi1E8bRKI16WZ3Gl49thrXMI9Ra+WaceVRk0e+UegHAALR+4fzn5RuYvjXlcI52kUQBRMBTw==
X-Received: by 2002:a05:6638:1495:b0:331:c58a:301 with SMTP id j21-20020a056638149500b00331c58a0301mr4702364jak.134.1654656182510;
        Tue, 07 Jun 2022 19:43:02 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3125:e4aa:20a:c5bc? ([2600:1700:e72:80a0:3125:e4aa:20a:c5bc])
        by smtp.gmail.com with ESMTPSA id d13-20020a5d964d000000b00665714766a2sm7387253ios.47.2022.06.07.19.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 19:43:02 -0700 (PDT)
Message-ID: <74d5f74b-c95f-6892-6a66-3e646b1f9e53@github.com>
Date:   Tue, 7 Jun 2022 22:43:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 2/7] branch: add branch_checked_out() helper
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <5f54766e1032ebf3a331516a6dd696b997bdfdd8.1654634569.git.gitgitgadget@gmail.com>
 <xmqqr140t9am.fsf@gitster.g>
 <e84b8f19-4fb4-77cd-7e56-087e84e59817@github.com>
In-Reply-To: <e84b8f19-4fb4-77cd-7e56-087e84e59817@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/7/2022 10:14 PM, Derrick Stolee wrote:
> On 6/7/2022 6:09 PM, Junio C Hamano wrote:
>>
>> I wonder if we rather want to rewrite find_shared_symref() *not* to
>> take the target parameter at all, and instead introduce a new
>> function that takes a worktree, and report the branch that is
>> checked out (or being operated on via rebase or bisect).  Then we
>> can
>>
>>  - create a strset out of its result, i.e. set of branches that
>>    should not be touched;
>>
>>  - iterate over refs that point into the history being rebased
>>    (using for_each_decoration()), and consult that strset to see if
>>    any of them is being rewritten.
>>
>> With the API of find_shared_symref(), we'd need to iterate over all
>> worktrees for each decoration.  With such a restructuring, we can
>> iterate over all worktrees just once, and match the result with
>> decoration, so the problem becomes O(N)+O(M) and not O(N*M) for
>> number of worktrees N and number of decorations M.
> 
> Yes, that's a good plan. I'll take a look.

Here is a fixup for this patch that should work. I'll put it in v3.

diff --git a/branch.c b/branch.c
index 2e6419cdfa5..514212f5619 100644
--- a/branch.c
+++ b/branch.c
@@ -10,6 +10,7 @@
 #include "worktree.h"
 #include "submodule-config.h"
 #include "run-command.h"
+#include "strmap.h"
 
 struct tracking {
 	struct refspec_item spec;
@@ -369,17 +370,44 @@ int validate_branchname(const char *name, struct strbuf *ref)
 	return ref_exists(ref->buf);
 }
 
-int branch_checked_out(const char *refname, char **path)
+static int initialized_checked_out_branches;
+static struct strmap current_checked_out_branches = STRMAP_INIT;
+
+static void prepare_checked_out_branches(void)
 {
-	struct worktree **worktrees = get_worktrees();
-	const struct worktree *wt = find_shared_symref(worktrees, "HEAD", refname);
-	int result = wt && !wt->is_bare;
+	int i = 0;
+	struct worktree **worktrees;
+
+	if (initialized_checked_out_branches)
+		return;
+	initialized_checked_out_branches = 1;
+
+	worktrees = get_worktrees();
+
+	while (worktrees[i]) {
+		struct worktree *wt = worktrees[i];
 
-	if (result && path)
-		*path = xstrdup(wt->path);
+		if (!wt->is_bare && wt->head_ref)
+			strmap_put(&current_checked_out_branches,
+				   wt->head_ref,
+				   wt->path);
+
+		i++;
+	}
 
 	free_worktrees(worktrees);
-	return result;
+}
+
+int branch_checked_out(const char *refname, char **path)
+{
+	const char *path_in_set;
+	prepare_checked_out_branches();
+
+	path_in_set = strmap_get(&current_checked_out_branches, refname);
+	if (path_in_set && path)
+		*path = xstrdup(path_in_set);
+
+	return !!path_in_set;
 }
 
 /*

>> There also was another topic
>>
>> https://lore.kernel.org/git/pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com/
>>
>> that was triggered by find_shared_symref() being relatively
>> heavy-weight, which suggests a more involved refactoring.

The patch there was this:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..eeee5ac8f15 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1440,6 +1440,7 @@ static void check_not_current_branch(struct ref *ref_map,
 	const struct worktree *wt;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
+		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
 		    (wt = find_shared_symref(worktrees, "HEAD",
 					     ref_map->peer_ref->name)) &&
 		    !wt->is_bare)

And there is another use of find_shared_symref() in the same file, allowing
us to do the following:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index ac29c2b1ae3..3933c482839 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -885,7 +885,7 @@ static int update_local_ref(struct ref *ref,
 			    struct worktree **worktrees)
 {
 	struct commit *current = NULL, *updated;
-	const struct worktree *wt;
+	char *path = NULL;
 	const char *pretty_ref = prettify_refname(ref->name);
 	int fast_forward = 0;
 
@@ -900,17 +900,17 @@ static int update_local_ref(struct ref *ref,
 	}
 
 	if (!update_head_ok &&
-	    (wt = find_shared_symref(worktrees, "HEAD", ref->name)) &&
-	    !wt->is_bare && !is_null_oid(&ref->old_oid)) {
+	    !is_null_oid(&ref->old_oid) &&
+	    branch_checked_out(ref->name, &path)) {
 		/*
 		 * If this is the head, and it's not okay to update
 		 * the head, and the old value of the head isn't empty...
 		 */
 		format_display(display, '!', _("[rejected]"),
-			       wt->is_current ?
-				       _("can't fetch in current branch") :
-				       _("checked out in another worktree"),
+			       path ? _("can't fetch in current branch") :
+				      _("checked out in another worktree"),
 			       remote, pretty_ref, summary_width);
+		free(path);
 		return 1;
 	}
 
@@ -1437,16 +1437,14 @@ static int prune_refs(struct refspec *rs,
 static void check_not_current_branch(struct ref *ref_map,
 				     struct worktree **worktrees)
 {
-	const struct worktree *wt;
+	char *path;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
 		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
-		    (wt = find_shared_symref(worktrees, "HEAD",
-					     ref_map->peer_ref->name)) &&
-		    !wt->is_bare)
+		    branch_checked_out(ref_map->peer_ref->name, &path))
 			die(_("refusing to fetch into branch '%s' "
 			      "checked out at '%s'"),
-			    ref_map->peer_ref->name, wt->path);
+			    ref_map->peer_ref->name, path);
 }
 
 static int truncate_fetch_head(void)

I can extract these as patches in their own series if we think
that's something we worth fast-tracking.

Thanks,
-Stolee
