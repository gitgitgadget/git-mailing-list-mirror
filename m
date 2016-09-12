Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CAE4207DF
	for <e@80x24.org>; Mon, 12 Sep 2016 18:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbcILSML (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 14:12:11 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:34769 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbcILSMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 14:12:09 -0400
Received: by mail-qk0-f169.google.com with SMTP id h8so62664935qka.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=tLYEnAf3oNnyAxNxzCO96t1XhcTgtrbbBq4xvquixmM=;
        b=WoF0sCGjlM1PE1SOC4quIKOWAYmacuTBLylhBIsCIrHMvaUDS7Ojavz3/GgDD3oOvs
         L0lvgNAL5wNq+KGAIIycLWGHJeh9h8avgVHeUyJuBAnpz1O6/pxE4XrKvC/TdPbHA4CG
         a4NTfeFVTFrr3gwsSqsIqpnYsEIHXi/SCeBTBLZx23UBgTJic09AM4FVzD8WqxcxMzNh
         C0BriwWtz9KbPx6IAoyY58WCA8DdEEZQKk81yp4avf1VkvEDRqCc2kxhhwonJ9dovzA8
         fE29GZmfltg5bBAhanWrlmLVvRcWNa61oiYYhs5z2tS647ZuJUyLYyK0hHvk+ilaJKLX
         Oyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=tLYEnAf3oNnyAxNxzCO96t1XhcTgtrbbBq4xvquixmM=;
        b=ZlobWF6nFKtLyiw5z1M4SGLIby5Y6eAdFjtAyKwZZM22gVuw5/dcKp+0D9HVkexK3U
         oIEFx/+sQ8mewYXbl5Qd8jh7brPgB+8G54dxR379QO69Epm/sIxIF8ZnjwVC4l27ocB3
         gYsOsSl/P1lbyjaN9U27QzbfD09pPjy/B3P8x+AhCutWCd6UhPMojFx3/vpr1xnhReA+
         ge7haM5jCmlvw2hFLf1PRcxzRHVcNHUo7DRvgZnUGuTStt1BCWaYrsMlja5ATn9Lf6Nc
         iexcZXEKieRFAkcm7agN7Ourb9q/1jbyEkm2Q2Al8hxG6uyClJvRMnO+AKhiSBeotHqY
         7+OA==
X-Gm-Message-State: AE9vXwPH1ND3wjGuiDbUQcIvqRC7WAuFiE4+FE9o3RH8XQMKTZlUesER+mjWaqqgJz5kFw==
X-Received: by 10.55.22.22 with SMTP id g22mr21142962qkh.267.1473703928794;
        Mon, 12 Sep 2016 11:12:08 -0700 (PDT)
Received: from BenPeartHP ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id v10sm11112506qkg.20.2016.09.12.11.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Sep 2016 11:12:07 -0700 (PDT)
From:   "Ben Peart" <peartben@gmail.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>
Cc:     <git@vger.kernel.org>, <pclouds@gmail.com>,
        "'Ben Peart'" <benpeart@microsoft.com>
References: <20160909192520.4812-1-benpeart@microsoft.com> <xmqq1t0sagcm.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq1t0sagcm.fsf@gitster.mtv.corp.google.com>
Subject: RE: [PATCH v2] checkout: eliminate unnecessary merge for trivial checkout
Date:   Mon, 12 Sep 2016 14:12:07 -0400
Message-ID: <13ef001d20d21$2d2ea840$878bf8c0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFCTziZO7Bhn9UGJz40Mb8DwNCg2wIQnMjDoYUedAA=
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, September 9, 2016 5:55 PM
> To: Ben Peart <peartben@gmail.com>
> Cc: git@vger.kernel.org; pclouds@gmail.com; Ben Peart
> <benpeart@microsoft.com>
> Subject: Re: [PATCH v2] checkout: eliminate unnecessary merge for trivial
> checkout
> 
> Ben Peart <peartben@gmail.com> writes:
> 
> > @@ -802,6 +806,87 @@ static void orphaned_commit_warning(struct
> commit *old, struct commit *new)
> >  	free(refs.objects);
> >  }
> >
> > +static int needs_working_tree_merge(const struct checkout_opts *opts,
> > +	const struct branch_info *old,
> > +	const struct branch_info *new)
> > +{
> > +	/*
> > +	 * We must do the merge if we are actually moving to a new
> > +	 * commit tree.
> > +	 */
> > +	if (!old->commit || !new->commit ||
> > +		oidcmp(&old->commit->tree->object.oid, &new->commit-
> >tree->object.oid))
> > +		return 1;
> 
> A huge helper function helps it somewhat, compared with the earlier
> unreadable mess ;-).
> 
> Are we certain that at this point the commit objects are both parsed and
> their tree->object.oid are both valid?
> 
> > +	/*
> > +	 * Honor the explicit request for a three-way merge or to throw away
> > +	 * local changes
> > +	 */
> > +	if (opts->merge || opts->force)
> > +		return 1;
> 
> Hmph, "git checkout -m HEAD" wouldn't have to do anything wrt the index
> status, no?
> 
> For that matter, neither "git checkout -f HEAD".  Unless we rely on
> unpack_trees() to write over the working tree files.
> 
>     ... me goes and looks, and finds that merge_working_tree()
>     indeed does have a logic to do quite different thing when
>     "--force" is given.
> 
> This makes me wonder if the "merge_working_tree() is expensive, so
> selectively skip calling it" approach is working at a wrong level.
> Wouldn't the merge_working_tree() function itself a better place to do
this
> kind of "we may not have to do the full two-way merge"
> optimization?  It already looks at opts and does things differently (e.g.
when
> running with "--force", it does not even call unpack).
> If you can optimize even more by looking at other fields in opts to avoid
> unpack, that would fit better with the structure of the code that we
already
> have.
> 

I completely agree that optimizing within merge_working_tree would provide 
more opportunities for optimization.  I can certainly move the test into
that 
function as a first step.  I've looked into it a little but came to the
conclusion
that it will be non-trivial to determine how to ensure the minimal work is 
done for any arbitrary set of options passed in without breaking something.


While I'd love to see that work done, I just don't have the time to pursue
further 
optimizations that may be available at this point in time.  There are other
things 
(like speeding up status on large repos) I need to work on first.

> > +	/*
> > +	 * Checking out the requested commit may require updating the
> working
> > +	 * directory and index, let the merge handle it.
> > +	 */
> > +	if (opts->force_detach)
> > +		return 1;
> 
> This does not make much sense to me.  After "git branch -f foo HEAD",
there
> is no difference in what is done to the index and the working directory
> between "git checkout --detach HEAD" and "git checkout foo", is there?
> 

I'm attempting to optimize for a single, common path where checkout is 
just creating a new branch (ie "git checkout -b foo") to minimize the 
possibility that I broke some other path I didn't fully understand.  

It is quite possible that there are cases where the index and/or working
directory do not need to be updated or where a merge won't actually 
change anything that this test is not optimized for.  Perhaps I should 
emphasize the "*may* require updating the working directory" in my 
comment.  Because it *could* happen, I let the code fall back to the
old behavior.

> > +	/*
> > +	 * opts->writeout_stage cannot be used with switching branches so is
> > +	 * not tested here
> > +	 */
> > +
> > +	 /*
> > +	  * Honor the explicit ignore requests
> > +	  */
> > +	if (!opts->overwrite_ignore || opts->ignore_skipworktree
> > +		|| opts->ignore_other_worktrees)
> > +		return 1;
> 
> Style.  I think you earlier had
> 
> 	if (a || b ||
>             c)
> 
> and here you are doing
> 
> 	if (a || b
>             || c)
> 
> Please pick one and stick to it (I'd pick the former).

Done

> 
> > +	 /*
> > +	 * If we're not creating a new branch, by definition we're changing
> > +	 * the existing one so need to do the merge
> > +	 */
> > +	if (!opts->new_branch)
> > +		return 1;
> 
> Sorry, but I fail to follow that line of thought.  Starting from a state
where
> your HEAD points at commit A,
> 
>  - switching to a detached HEAD pointing at a commit A,
>  - switching to an existing branch that already points at the same
>    commit A, and
>  - force updating an existing branch that was pointing at something
>    else to point at the same commit A,
> 
> would have the same effect as creating a new branch at commit A and
> switching to it, no?  The same comment applies to the remainder of this
> function.
> 
> More importantly, merge_working_tree() checks things other than what this
> function is checking.  For example, it prevents you from branch-switching
> (whether it is to switch to an existing branch that has the same commit as
the
> current HEAD, to switch to detached HEAD state at the same commit as the
> current HEAD, or to switch to a new branch that points at the same commit
> as the current HEAD) if your index is unmerged (i.e. you are in the middle
of
> a mergy operation).
> 
> So my gut feeling is that this:
> 
> > +	/*
> > +	 * Optimize the performance of "git checkout foo" by skipping the
call
> > +	 * to merge_working_tree where possible.
> > +	 */
> > +	if (needs_working_tree_merge(opts, &old, new)) {
> > +		ret = merge_working_tree(opts, &old, new,
> &writeout_error);
> 
> works at the wrong level.  The comment up to 'Optimize the performance of
> "git checkout foo"' may correctly state what we want to achieve, but I
think
> we should do so not with "by skipping the call to", but with "by
optimizing
> merge_working_tree()".
> 

I agree that optimizing merge_working_tree could result in even greater 
savings and could definitely optimize for more paths/options than this 
patch. While I'd love to see that done, I'm also happy to get a 10x 
improvement in the common case of creating a new branch.

I'll reroll the patch moving the current optimization into 
merge_working_tree and fixing up the style issues you pointed out.

> Thanks.
> 


