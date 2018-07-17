Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D631F597
	for <e@80x24.org>; Tue, 17 Jul 2018 01:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGQBqE (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 21:46:04 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:55453 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730072AbeGQBqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 21:46:04 -0400
Received: by mail-qk0-f201.google.com with SMTP id z18-v6so10171399qki.22
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=W+VOjO/LqUQB1mz2o4WzvTSLnqydH/y/Y5ZKqtRumDM=;
        b=UFnRUeOCiDwVqEeZpOBOlmgTVAO1nqUuHJkrYO9d3V2bM4ccf6vaH8Ck0etIOIvVZj
         eMfNb7Lw63wx0OfvI2bcIS9tJjwKfWU/h6J7BPAexLSVfDr5y2UDnAVOvDWUbItNGW2d
         L4szFk2dRRzX18+PrFP+qx1dEXKcWW3knuCFQ11prmY6i9TcWocOtW4Dy0kiLVMLL9Hr
         mJy4AY+aUBZXX6E7qvinjYUQFfEkMRiZ1JO63DF3z1FlSVSbsO3pjf0xkgkIFF4ShTbX
         kqgJ3DE81I934rmzjd5MVB9vXaGAOaZMhLJdXOw4893LS6Ch55CiOxoaZEhPLonG2hGJ
         WaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=W+VOjO/LqUQB1mz2o4WzvTSLnqydH/y/Y5ZKqtRumDM=;
        b=CAo82pcWvejErT9WranfYEJs22Xjy6PXuwd7oaIq3DgjtmPDhUeWIkWF8+ozgaDPn3
         40soxqDlmctO6xFN8GMP5hlc+C7BztZ70CHLs47IPn5saKc37VcwZ2pkhz117UhRHrb+
         ayAhnLlXxbwQS5qSGnQJeujkPOvxuDZ2NYTnoltaFwwPEuuyIgqBCXd2C8QhU1gbwABA
         8qBAX6o/HGLETwvwEErakj2Uyoay9IZ+X1C3cqhO4QDQFfrofqkRNVjmILB3hxk6/C+I
         XhFwuORQIbUBMjDKppfSmUt550IUYjAxhhoY+QfYn2ip2HJBVFrnSiFW8qnuu1YREr8Y
         ul7Q==
X-Gm-Message-State: AOUpUlHOWhbYdQxbYAGDsBcF+y+9c/Rk9jPOjYYjqgf+anrYWOY7hfmd
        t4eFqUgZQ+TsKes0rkdx7EknUAx7uVhc/EussVnW
X-Google-Smtp-Source: AAOMgpd0am2mmHap8gH2Q2eKaps5JMPwFWw0EwBNxihP+OCHPHy/Lag7H47b8GDDYeemOAtuW3sYDIaZNdZenFFEaDTr
MIME-Version: 1.0
X-Received: by 2002:a0c:f70d:: with SMTP id w13-v6mr12037598qvn.20.1531790163604;
 Mon, 16 Jul 2018 18:16:03 -0700 (PDT)
Date:   Mon, 16 Jul 2018 18:16:00 -0700
In-Reply-To: <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
Message-Id: <20180717011600.22362-1-jonathantanmy@google.com>
References: <816821eec9ba476ccdfbfdf6e3cdd3619743ea2e.1531746012.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 15/16] commit-reach: make can_all_from_reach... linear
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The first step includes using a depth-first-search (DFS) from each from
> commit, sorted by ascending generation number. We do not walk beyond the
> minimum generation number or the minimum commit date. This DFS is likely
> to be faster than the existing reachable() method because we expect
> previous ref values to be along the first-parent history.
> 
> If we find a target commit, then we mark everything in the DFS stack as
> a RESULT. This expands the set of targets for the other from commits. We
> also mark the visited commits using 'assign_flag' to prevent re-walking
> the same code.

Thanks for this - it was very helpful in understanding the code.

The function itself uses a DFS stack that contains only the trail
leading up to the currently processed node, and not the one that I'm
more familiar with, which also contains the siblings of processed nodes.
I'll annotate the function with my thought process in the hope that it
will aid future reviewers. (The diff as seen in the e-mail is confusing
so I'm reproducing the function itself, not any + or -.)

> int can_all_from_reach_with_flag(struct object_array *from,
> 				 int with_flag, int assign_flag,
> 				 time_t min_commit_date,
> 				 uint32_t min_generation)
> {
> 	struct commit **list = NULL;
> 	int i;
> 	int result = 1;
> 
> 	ALLOC_ARRAY(list, from->nr);
> 	for (i = 0; i < from->nr; i++) {
> 		list[i] = (struct commit *)from->objects[i].item;
> 
> 		parse_commit(list[i]);
> 
> 		if (list[i]->generation < min_generation)
> 			return 0;
> 	}
> 
> 	QSORT(list, from->nr, compare_commits_by_gen);
> 
> 	for (i = 0; i < from->nr; i++) {
> 		/* DFS from list[i] */
> 		struct commit_list *stack = NULL;
> 
> 		list[i]->object.flags |= assign_flag;
> 		commit_list_insert(list[i], &stack);
> 
> 		while (stack) {
> 			struct commit_list *parent;
> 
> 			if (stack->item->object.flags & with_flag) {
> 				pop_commit(&stack);
> 				continue;
> 			}

I wish that the code would refrain from pushing such an object instead
of popping it at the first opportunity, but I guess that doing so would
require the equivalent of a labeled break/continue. I have no qualms
with using "goto" in this case, but I know that some people don't like
it :-P

> 			for (parent = stack->item->parents; parent; parent = parent->next) {
> 				if (parent->item->object.flags & (with_flag | RESULT))
> 					stack->item->object.flags |= RESULT;

Straightforward, and also produces the bubbling up that we want. An
object is never popped unless it has the "with_flag" flag (see above) or
all its parents have been processed. The object can encounter the "if"
statement multiple times; the last one is when all its parents have been
processed (and thus have the RESULT flag set if necessary).

> 				if (!(parent->item->object.flags & assign_flag)) {
> 					parent->item->object.flags |= assign_flag;
> 
> 					parse_commit(parent->item);
> 
> 					if (parent->item->date < min_commit_date ||
> 					    parent->item->generation < min_generation)
> 						continue;
> 
> 					commit_list_insert(parent->item, &stack);
> 					break;
> 				}

If not yet processed, push it onto the stack and break. The child commit
is still left on the stack. The next time the child commit is processed
(in an iteration of the "while" loop), the "for" loop will iterate until
the next unprocessed parent.

In the DFS that I'm used to, all parents would be pushed here, but
perhaps the fact that the iteration is postorder confuses things.
Anyway, if someone comes up with a better algorithm, replacing it
shouldn't be too difficult - the algorithm is contained within this
function, and there are tests to check the correctness of the algorithm
update.

> 			}
> 
> 			if (!parent)
> 				pop_commit(&stack);

Only when we have no parents left are we completely done with the
current object.

> 		}
> 
> 		if (!(list[i]->object.flags & (with_flag | RESULT))) {
> 			result = 0;
> 			goto cleanup;
> 		}

And after the DFS, if the original object did not have an appropriate
flag set, we do not bother with the other "want" objects.

> 	}
> 
> cleanup:
> 	for (i = 0; i < from->nr; i++) {
> 		clear_commit_marks(list[i], RESULT);
> 		clear_commit_marks(list[i], assign_flag);
> 	}
> 	return result;
> }
