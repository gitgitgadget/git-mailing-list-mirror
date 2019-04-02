Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09F2320248
	for <e@80x24.org>; Tue,  2 Apr 2019 04:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDBEoX (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 00:44:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35840 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDBEoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 00:44:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so5892379pgc.3
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 21:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MFfPgOETvY4ezNzASJ7VpKmsgwxLY9n+8dof2cYSsvQ=;
        b=ZHin04nIdAwR7+A6w/3e/hhAu7e9IrIM5DcCV4bID+Ogq7M0Sj89mbxMRy2cj7ICK1
         tlGwt7EeYNUZvBCQkvBNdK2nmy+zGvlimZuQg53YRYtm8TX61RA7b0bigC6DK8/RM5ul
         8w4Dmfqg1l5FpsNWL40j0OQDoiQgCXZBf0/xbrkjtcpEHMYJ0HW0srMF9mna8xYeQ2my
         4VJ5xa4kXCjxQGlW0XzrX93KmnMMxnby5wvoleG8pfVJ7sgsDnSZd74UTba4mRdmczAi
         SnkgKSEVS3KPk3y0E7Ri9fbfluw8rxiIqAgYjjUgStGsODDJ3yqfgdBZXCs/3I0erlp/
         VC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MFfPgOETvY4ezNzASJ7VpKmsgwxLY9n+8dof2cYSsvQ=;
        b=e34c9I+3GasDDO1FN5v4dD0drI/OGky7Xd5f1nc4lotL5wnhfILfXQ6O8qgi+zNM5V
         vVR2zlnivaZlzIYAjR5Gy7FQETFfxJOLdCDpRBuAWDkFpT+1r1MtivgulVglKEMu9R2Q
         oRjtjRl1cKA9zZjX5tDovodlV85CkkRIGc6wJrKHHsAGabqCdDivbVm6ot0GwRqpbMf5
         L1S+SaH9XcXXm5Jscu6glgLsm+llemN2aZ+vHvE20gnyRWfhM/h1LcPW8r/i41cX0S9V
         ct2u+hldywXchOggOPRRlPw5ymsPsDUg8GyTL/ZDtCn9aAoguByru9ktRrwDLfkX3gmc
         /cqA==
X-Gm-Message-State: APjAAAVll5B9II4FoE7eDbLWeDe2typOUMptIOdPY3KOviRU0V8fqOtA
        xf5uzZ9aNVBBbevVEEeNUTw=
X-Google-Smtp-Source: APXvYqyZCWBGLjQvj42VzDsgFX68fyqFSm/1juilrmdKTN4o1gyXZmBaBZ7fr8UqHPv/qPORbW/HAw==
X-Received: by 2002:a63:4620:: with SMTP id t32mr61913862pga.363.1554180262216;
        Mon, 01 Apr 2019 21:44:22 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id t64sm25742158pfa.86.2019.04.01.21.44.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 21:44:21 -0700 (PDT)
Date:   Mon, 1 Apr 2019 21:44:19 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/4] rebase: fast-forward --onto in more cases
Message-ID: <20190402044419.GA7106@archbookpro.localdomain>
References: <20190328221745.GA3941@dev-l>
 <cover.1554151449.git.liu.denton@gmail.com>
 <281443b2ae2dcf6a5a4d5766d4c006a4d0e22c91.1554151449.git.liu.denton@gmail.com>
 <xmqqsgv1tcyi.fsf@gitster-ct.c.googlers.com>
 <xmqqo95ptbxj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo95ptbxj.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 02, 2019 at 10:48:08AM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Denton Liu <liu.denton@gmail.com> writes:
> >
> >> Before, when we had the following graph,
> >>
> >> 	A---B---C (master)
> >> 	    \
> >> 	     D (side)
> >>
> >> running 'git rebase --onto master... master side' would result in D
> >> being always rebased, no matter what. However, the desired behavior is
> >> that rebase should notice that this is fast-forwardable and do that
> >> instead.
> >>
> >> Add detection to `can_fast_forward` so that this case can be detected
> >> and a fast-forward will be performed.
> >
> > OK.  As long as the 'onto' commit is a strict ancestor of the side
> > branch being rebased, the 'upstream' that is used only to determine
> > which commits are on the side branch (essentially those that are not
> > reachable from upstream but that are from the side branch) should
> > not count in the equation to decide if we fast-forward or not.  That
> > makes sense.
> >
> >> ---
> >>  builtin/rebase.c               | 40 +++++++++++++++++++++++-----------
> >>  t/t3400-rebase.sh              |  2 +-
> >>  t/t3404-rebase-interactive.sh  |  2 +-
> >>  t/t3432-rebase-fast-forward.sh |  2 +-
> >>  4 files changed, 30 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/builtin/rebase.c b/builtin/rebase.c
> >> index 77deebc65c..7aa6a090d4 100644
> >> --- a/builtin/rebase.c
> >> +++ b/builtin/rebase.c
> >> @@ -895,12 +895,12 @@ static int is_linear_history(struct commit *from, struct commit *to)
> >>  	return 1;
> >>  }
> >>  
> >> -static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
> >> -			    struct object_id *merge_base)
> >> +static int can_fast_forward(struct commit *onto, struct commit *upstream,
> >> +			    struct object_id *head_oid, struct object_id *merge_base)
> >>  {
> >>  	struct commit *head = lookup_commit(the_repository, head_oid);
> >> -	struct commit_list *merge_bases;
> >> -	int res;
> >> +	struct commit_list *merge_bases = NULL;
> >> +	int res = 0;
> >>  
> >>  	if (!head)
> >>  		return 0;
> >> @@ -908,12 +908,29 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
> >>  	merge_bases = get_merge_bases(onto, head);
> >>  	if (merge_bases && !merge_bases->next) {
> >>  		oidcpy(merge_base, &merge_bases->item->object.oid);
> >> -		res = oideq(merge_base, &onto->object.oid);
> >> +		if (!oideq(merge_base, &onto->object.oid))
> >> +			goto done;
> >>  	} else {
> >>  		oidcpy(merge_base, &null_oid);
> >> -		res = 0;
> >> +		goto done;
> >>  	}
> >
> > The above does not change any existing logic, but purely simplifies
> > the code.  In your picture in the log message
> >
> >     A---B---C (master)
> >          \
> >           D (side)
> >
> > where "rebase --onto master... master side" is run, "onto" in this
> > function is B, and "head" is D.  There is a single merge base B
> > (i.e. merge_bases->next == NULL), so we jump to the label "done:"
> > with res==0.

I don't think this is correct. There is a single merge base so we
compare 'merge_base' and 'onto'. They are the same so we don't jump to
'done', instead we keep going.

> >
> > So why does the remainder of the function need to be changed?
> >
> >> +	if (!upstream)
> >> +		goto done;
> >> +
> >>  	free_commit_list(merge_bases);
> >> +	merge_bases = get_merge_bases(upstream, head);
> >> +	if (merge_bases && !merge_bases->next) {
> >> +		if (!oideq(&onto->object.oid, &merge_bases->item->object.oid))
> >> +			goto done;
> >> +	} else
> >> +		goto done;
> >
> > This computes the same between C and D (instead of B and D).  Why is
> > this needed?

Without this logic, t3416 would fail case 2 and 3. It would only see the
'head' and the 'onto' and therefore, it would incorrectly return 1,
indicating that it is fast-forwardable.

The graph for t3416 is as follows:

		    F---G topic
		   /
	  A---B---C---D---E master
	       \   \ /
		\   x
		 \ / \
		  H---I---J---K side

And the command that fails is

    git rebase --onto master...topic F # called from topic

Without the additional logic, merge base is C and there is only one
merge base. Also, head is G. Finally, onto is also C. We enter the outer
if becase there is one merge base then we see that onto == merge_base.
Thus, the function would falsely conclude that this is fast-forwardable.
This gives us ABCFG when we're expecting ABCG.

The additional logic detects if we're not rebasing the entire branch but
only part of the branch. In this case, it detects that F is excluded and
as a result, we can't fast-forward.

> >
> > Stepping back a bit, I understand that your argument we saw in the
> > log message was that we only need to know if the commit we are
> > transplanting the history on (i.e. "onto") already is an ancestor of
> > the history being transplanted (i.e. "onto..head"), and it does not
> > matter what upstream is.  Am I mistaken?  Why does this function now
> > need to know what 'upstream' is?

As stated above, the function needs to know what upstream is because it
uses it to determine if the set of commits being rebased is equal to
master..topic. If it's not that set, then it's not fast-forwardable.

> >
> > Puzzled....

...I guess this is a sign that I need to clarify my commit message. I'll
put what I said above into the commit message in my next reroll.

Thanks,

Denton

> 
> So I replaced the part for builtin/rebase.c from your patch with the
> above suggestion (attached) and the result seems to pass the three
> tests you touched.  I am still puzzled.
> 
> Thanks.
> 
>  builtin/rebase.c               | 7 ++-----
>  t/t3400-rebase.sh              | 2 +-
>  t/t3404-rebase-interactive.sh  | 2 +-
>  t/t3432-rebase-fast-forward.sh | 2 +-
>  4 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 77deebc65c..fe61c2a899 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1682,13 +1682,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  
>  	/*
>  	 * Check if we are already based on onto with linear history,
> -	 * but this should be done only when upstream and onto are the same
> -	 * and if this is not an interactive rebase.
> +	 * but this should be done if this is not an interactive rebase.
>  	 */
>  	if (can_fast_forward(options.onto, &options.orig_head, &merge_base) &&
> -	    !is_interactive(&options) && !options.restrict_revision &&
> -	    options.upstream &&
> -	    !oidcmp(&options.upstream->object.oid, &options.onto->object.oid)) {
> +	    !is_interactive(&options) && !options.restrict_revision) {
>  		int flag;
>  
>  		if (!(options.flags & REBASE_FORCE)) {
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 460d0523be..604d624ff8 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -295,7 +295,7 @@ test_expect_success 'rebase--am.sh and --show-current-patch' '
>  		echo two >>init.t &&
>  		git commit -a -m two &&
>  		git tag two &&
> -		test_must_fail git rebase --onto init HEAD^ &&
> +		test_must_fail git rebase -f --onto init HEAD^ &&
>  		GIT_TRACE=1 git rebase --show-current-patch >/dev/null 2>stderr &&
>  		grep "show.*$(git rev-parse two)" stderr
>  	)
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index b60b11f9f2..f054186cc7 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1066,7 +1066,7 @@ test_expect_success C_LOCALE_OUTPUT 'rebase --edit-todo does not work on non-int
>  	git reset --hard &&
>  	git checkout conflict-branch &&
>  	set_fake_editor &&
> -	test_must_fail git rebase --onto HEAD~2 HEAD~ &&
> +	test_must_fail git rebase -f --onto HEAD~2 HEAD~ &&
>  	test_must_fail git rebase --edit-todo &&
>  	git rebase --abort
>  '
> diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
> index 3e6362dd9c..414b4216d6 100755
> --- a/t/t3432-rebase-fast-forward.sh
> +++ b/t/t3432-rebase-fast-forward.sh
> @@ -54,6 +54,6 @@ test_expect_success 'add work to upstream' '
>  changes='our and their changes'
>  test_rebase_same_head success '--onto B B'
>  test_rebase_same_head success '--onto B... B'
> -test_rebase_same_head failure '--onto master... master'
> +test_rebase_same_head success '--onto master... master'
>  
>  test_done
