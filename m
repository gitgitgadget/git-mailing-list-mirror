Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 041761F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbfHZPLN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:11:13 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55399 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbfHZPLN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:11:13 -0400
Received: by mail-wm1-f67.google.com with SMTP id f72so15834573wmf.5
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HyyW6dCBnkeSelueWL3p/4HOUASBpeYfDMSEPCYWpr8=;
        b=bIGpBcZAlKZwclaNCb+1JkiIK2QmzoHZ5tiyFs6gfReaG1pswsl1L+zDOYhip7rspn
         IcqYowaH4/2V5ih/hw2PUSv/54mJCBkmm4xpT8J8pZuRcVFn0LqjbV+jQPpiw6Dbjqr5
         swumt7EK5qHw5l6QZBDzyZJBjs6eZaKHUndX7U3dgEqDvm/DcBXUgIQeNKgRVODg0DON
         7RJtmslYsD5X4r4dUwvj3kWQFwwYw/pURSlzUeV9NKnodNPsGZswWyaqhXp7dyE/H1ko
         /1V7esGB99tfLB86Bh+wKOfgNSvt0FP8zMj53Bf8BqvgTSSUrX+q677RnvswJ9McOxUO
         JaZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HyyW6dCBnkeSelueWL3p/4HOUASBpeYfDMSEPCYWpr8=;
        b=L+1ZMvsvnI2InizPh1GnvQmX2cafoB+qyq9KF6H2xHTYGKmx0gWcVWdSzI3Tqk8u3w
         1v7EVbTfvrsUHrWRGr8T4Epl2HfN8GG3JXSgQKdGLczONEGX4h8UYUNCZZGVSerBVv5F
         7rPombRjuXejA4k4ECGRKGb+5anT4w5NjYrQyH7GOUdQFhosmCxZ8O7bVBmhBr4q+emY
         DHxRkdP6aTKUStym3unRIqypEETinZ/hiL+5/DwOUPLZLM2iOoXSpBu1x8NTp8U32fdt
         gT00EGkIp6Ja/8xOtu5h2h1jOWQUgN1FXRurYkoBPInb6n6X3fYTn2qY6xmJI0yV3Q1l
         S75g==
X-Gm-Message-State: APjAAAUiXmM4dT1zLnzZEOJIKSlAKK/AFosz0GXwOvMAjPHcvhVQ4r2G
        h+4U9EqUWbSO66oGXYGWE4qcg30k
X-Google-Smtp-Source: APXvYqylngCwVswueQW2Nl1jcxZ/kBc2wYKkqn+jR0HESOB4Z42fClwh5FJSeNxszK7IwsLtQjvh2Q==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr23206689wmb.116.1566832270418;
        Mon, 26 Aug 2019 08:11:10 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-2-29.as13285.net. [92.22.2.29])
        by smtp.gmail.com with ESMTPSA id e14sm9658918wma.37.2019.08.26.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2019 08:11:09 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/2] Honor .gitattributes with rebase --am
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6ad26ef8-fc94-726a-2243-4c3ff9717ad3@gmail.com>
Date:   Mon, 26 Aug 2019 16:11:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190825233340.10894-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian

On 26/08/2019 00:33, brian m. carlson wrote:
> This series makes rebase --am honor the .gitattributes file for
> subsequent patches when a patch changes it.
> 
> Note that there are two places we load attributes in ll-merge.c, but
> this code only handles the one that git am uses.  The two cannot be
> unified because the one in ll_merge_marker_size intentionally doesn't
> load the merge attribute, since it wants to always use the recursive
> strategy.  Loading it anyway causes t4017 to fail.
> 
> Changes from v4:
> * Wrap lines in apply.c.
> * Handle merge and conflict-marker-size attributes.
> * Add tests for am and am -3 in addition to rebase.

I've only had time for a quick look at these but the changes look good 
to me. Thanks for taking the time to add the tests for am and the code 
for handling the merge attributes

Best Wishes

Phillip

> Changes from v3:
> * Check for both addition and removal of .gitattributes files.
> * Switch from "test_config" to "git config".
> 
> Changes from v2:
> * Rename has_path_suffix to ends_with_path_components.
> 
> Changes from v1:
> * Add has_path_suffix in a separate commit.
> 
> brian m. carlson (2):
>    path: add a function to check for path suffix
>    am: reload .gitattributes after patching it
> 
>   apply.c           | 11 ++++++++++
>   convert.c         | 11 +++++++++-
>   convert.h         |  6 ++++++
>   ll-merge.c        | 19 +++++++++++++----
>   ll-merge.h        |  1 +
>   path.c            | 39 +++++++++++++++++++++++++++--------
>   path.h            |  3 +++
>   t/t3400-rebase.sh | 36 ++++++++++++++++++++++++++++++++
>   t/t4150-am.sh     | 52 +++++++++++++++++++++++++++++++++++++++++++++++
>   9 files changed, 164 insertions(+), 14 deletions(-)
> 
> Range-diff against v4:
> 1:  fa825e4b40 ! 1:  2077a0829e apply: reload .gitattributes after patching it
>      @@ Metadata
>       Author: brian m. carlson <sandals@crustytoothpaste.net>
>       
>        ## Commit message ##
>      -    apply: reload .gitattributes after patching it
>      +    am: reload .gitattributes after patching it
>       
>           When applying multiple patches with git am, or when rebasing using the
>           am backend, it's possible that one of our patches has updated a
>      @@ Commit message
>       
>           To ensure we write the correct data into the working tree, expire the
>           cache after each patch that touches a path ending in ".gitattributes".
>      +    Since we load these attributes in multiple separate files, we must
>      +    expire them accordingly.
>      +
>      +    Verify that both the am and rebase code paths work correctly, including
>      +    the conflict marker size with am -3.
>       
>           Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>       
>      @@ apply.c: static int apply_patch(struct apply_state *state,
>        			*listp = patch;
>        			listp = &patch->next;
>       +
>      -+			if ((patch->new_name && ends_with_path_components(patch->new_name, GITATTRIBUTES_FILE)) ||
>      -+			    (patch->old_name && ends_with_path_components(patch->old_name, GITATTRIBUTES_FILE)))
>      ++			if ((patch->new_name &&
>      ++			     ends_with_path_components(patch->new_name,
>      ++						       GITATTRIBUTES_FILE)) ||
>      ++			    (patch->old_name &&
>      ++			     ends_with_path_components(patch->old_name,
>      ++						       GITATTRIBUTES_FILE)))
>       +				flush_attributes = 1;
>        		}
>        		else {
>      @@ apply.c: static int apply_patch(struct apply_state *state,
>        	strbuf_release(&buf);
>       
>        ## convert.c ##
>      +@@
>      + #include "pkt-line.h"
>      + #include "sub-process.h"
>      + #include "utf8.h"
>      ++#include "ll-merge.h"
>      +
>      + /*
>      +  * convert.c - convert a file when checking it out and checking it in.
>       @@ convert.c: struct conv_attrs {
>        	const char *working_tree_encoding; /* Supported encoding or default encoding if NULL */
>        };
>      @@ convert.c: static void convert_attrs(const struct index_state *istate,
>       +{
>       +	attr_check_free(check);
>       +	check = NULL;
>      ++	reset_merge_attributes();
>       +}
>       +
>        int would_convert_to_git_filter_fd(const struct index_state *istate, const char *path)
>      @@ convert.h: void convert_to_git_filter_fd(const struct index_state *istate,
>         *
>         * Streaming conversion support
>       
>      + ## ll-merge.c ##
>      +@@ ll-merge.c: struct ll_merge_driver {
>      + 	char *cmdline;
>      + };
>      +
>      ++static struct attr_check *merge_attributes;
>      ++static struct attr_check *load_merge_attributes(void)
>      ++{
>      ++	if (!merge_attributes)
>      ++		merge_attributes = attr_check_initl("merge", "conflict-marker-size", NULL);
>      ++	return merge_attributes;
>      ++}
>      ++
>      ++void reset_merge_attributes(void)
>      ++{
>      ++	attr_check_free(merge_attributes);
>      ++	merge_attributes = NULL;
>      ++}
>      ++
>      + /*
>      +  * Built-in low-levels
>      +  */
>      +@@ ll-merge.c: int ll_merge(mmbuffer_t *result_buf,
>      + 	     struct index_state *istate,
>      + 	     const struct ll_merge_options *opts)
>      + {
>      +-	static struct attr_check *check;
>      ++	struct attr_check *check = load_merge_attributes();
>      + 	static const struct ll_merge_options default_opts;
>      + 	const char *ll_driver_name = NULL;
>      + 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
>      +@@ ll-merge.c: int ll_merge(mmbuffer_t *result_buf,
>      + 		normalize_file(theirs, path, istate);
>      + 	}
>      +
>      +-	if (!check)
>      +-		check = attr_check_initl("merge", "conflict-marker-size", NULL);
>      +-
>      + 	git_check_attr(istate, path, check);
>      + 	ll_driver_name = check->items[0].value;
>      + 	if (check->items[1].value) {
>      +
>      + ## ll-merge.h ##
>      +@@ ll-merge.h: int ll_merge(mmbuffer_t *result_buf,
>      + 	     const struct ll_merge_options *opts);
>      +
>      + int ll_merge_marker_size(struct index_state *istate, const char *path);
>      ++void reset_merge_attributes(void);
>      +
>      + #endif
>      +
>        ## t/t3400-rebase.sh ##
>       @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
>        	)
>      @@ t/t3400-rebase.sh: test_expect_success 'rebase --am and --show-current-patch' '
>        test_expect_success 'rebase--merge.sh and --show-current-patch' '
>        	test_create_repo conflict-merge &&
>        	(
>      +
>      + ## t/t4150-am.sh ##
>      +@@ t/t4150-am.sh: test_expect_success 'am --quit keeps HEAD where it is' '
>      + 	test_cmp expected actual
>      + '
>      +
>      ++test_expect_success 'am and .gitattibutes' '
>      ++	test_create_repo attributes &&
>      ++	(
>      ++		cd attributes &&
>      ++		test_commit init &&
>      ++		git config filter.test.clean "sed -e '\''s/smudged/clean/g'\''" &&
>      ++		git config filter.test.smudge "sed -e '\''s/clean/smudged/g'\''" &&
>      ++
>      ++		test_commit second &&
>      ++		git checkout -b test HEAD^ &&
>      ++
>      ++		echo "*.txt filter=test conflict-marker-size=10" >.gitattributes &&
>      ++		git add .gitattributes &&
>      ++		test_commit third &&
>      ++
>      ++		echo "This text is smudged." >a.txt &&
>      ++		git add a.txt &&
>      ++		test_commit fourth &&
>      ++
>      ++		git checkout -b removal HEAD^ &&
>      ++		git rm .gitattributes &&
>      ++		git add -u &&
>      ++		test_commit fifth &&
>      ++		git cherry-pick test &&
>      ++
>      ++		git checkout -b conflict third &&
>      ++		echo "This text is different." >a.txt &&
>      ++		git add a.txt &&
>      ++		test_commit sixth &&
>      ++
>      ++		git checkout test &&
>      ++		git format-patch --stdout master..HEAD >patches &&
>      ++		git reset --hard master &&
>      ++		git am patches &&
>      ++		grep "smudged" a.txt &&
>      ++
>      ++		git checkout removal &&
>      ++		git reset --hard &&
>      ++		git format-patch --stdout master..HEAD >patches &&
>      ++		git reset --hard master &&
>      ++		git am patches &&
>      ++		grep "clean" a.txt &&
>      ++
>      ++		git checkout conflict &&
>      ++		git reset --hard &&
>      ++		git format-patch --stdout master..HEAD >patches &&
>      ++		git reset --hard fourth &&
>      ++		test_must_fail git am -3 patches &&
>      ++		grep "<<<<<<<<<<" a.txt
>      ++	)
>      ++'
>      ++
>      + test_done
> 
