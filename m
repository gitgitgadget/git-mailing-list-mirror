Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EA2B1F731
	for <e@80x24.org>; Tue,  6 Aug 2019 23:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbfHFXK5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 19:10:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34471 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfHFXK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 19:10:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so38488376plt.1
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3DYXS+aziMjgIoUjxKfhf4vygWdMswLcpciPfAT2bBM=;
        b=RwgdEDJKKy+ctY1F5FSgsl8JslRjwWgJVS3r2NHGyB0rlrUo+5Hwq/IDsdjuSqx02y
         PvvF7e+ckkoFvRm1M6IqJwa8fRmJ9POTJOLrJV9w+yXVZfHUt1+Jyu4/MaUJPo6uJ+d1
         DDHTZ2fx2sE9ABthO9JkYcnBVO5ldh94ggnLXI4ZIXSB2KNsDnLVcJIobWt/rlUok7ZE
         afqPaEeED5m41AaegsVLjoQlwENcjXkDc9qg47j4Ew4YI4HdaACEWEEnZ+6enHC68KRF
         /EOl51TVtp997j8sjrw8gQDnPMbS9eYm3mgLY2dufnlG9E6zL0mSvBK4f9duwwFGqhZY
         N7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3DYXS+aziMjgIoUjxKfhf4vygWdMswLcpciPfAT2bBM=;
        b=uHnX0O6R7t8OIaRZWuzLvMbKP1AZscw9u6QNTlA5akC4pWgfnD4PnC/ZePF1aTbrkc
         IRi72m9z3zFuf5DwwT1UXOS7XU5YDVmAG5ITYtt2BQlD9PEt6bTggRSchsnbsPa106cy
         AvLqr0wyHtaFaOuH6pb7QX1qIdLywP9xPEoPEhyzbskokhw/Q5FiWzvCf85z8dsDRnJA
         fMzKt7wIEFfjk6MuQN+b6ohwQFbub2Z3Y21PgYeG5nPnD3TIXSiQqd/eaQj7hR63t+R5
         aQRuMjG/4L8ZcnKookP/ldEeKpACK7Lditd9dX+4OKjwSZeZalHppKhfFdQEPdyuEC8j
         IkvA==
X-Gm-Message-State: APjAAAU1cSS4CvQCYj9Gf5P1RxAuLD1tkYWRMaDoYzuYIhaWAZ8txKtD
        qbhWRdjfACbwe+B5F9htYtDZAQ==
X-Google-Smtp-Source: APXvYqzSDyFvoHcAz0e2cL9LETAQgRfDV4QrXZorMIN8IOu0EDClY4+WpSrxTQRL12+Rav8cN08mXg==
X-Received: by 2002:a17:902:e30f:: with SMTP id cg15mr5507100plb.46.1565133055803;
        Tue, 06 Aug 2019 16:10:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id n28sm2272220pgd.64.2019.08.06.16.10.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 16:10:54 -0700 (PDT)
Date:   Tue, 6 Aug 2019 16:10:50 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: Re: [PATCH v3] documentation: add tutorial for revision walking
Message-ID: <20190806231050.GA130824@google.com>
References: <20190701201934.30321-1-emilyshaffer@google.com>
 <20190724233253.208318-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724233253.208318-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 24, 2019 at 04:32:53PM -0700, Jonathan Tan wrote:
> Thanks - I think this is a useful guide to what can be a complicated
> topic. It looks good overall; I just have some minor comments below.
> 
> > diff --git a/Documentation/Makefile b/Documentation/Makefile
> > index 76f2ecfc1b..91e5da67c4 100644
> > --- a/Documentation/Makefile
> > +++ b/Documentation/Makefile
> > @@ -78,6 +78,7 @@ SP_ARTICLES += $(API_DOCS)
> >  
> >  TECH_DOCS += MyFirstContribution
> >  TECH_DOCS += SubmittingPatches
> > +TECH_DOCS += MyFirstRevWalk
> 
> Any reason why this is not in alphabetical order?

No reason, will fix.

> 
> > +Also add the relevant line in `builtin.h` near `cmd_whatchanged()`:
> > +
> > +----
> > +extern int cmd_walken(int argc, const char **argv, const char *prefix);
> > +----
> 
> builtin.h no longer has "extern", so we can delete it.

Done.

> 
> > +Add it to the `Makefile` near the line for `builtin\worktree.o`:
> > +
> > +----
> > +BUILTIN_OBJS += builtin/walken.o
> > +----
> 
> In the first line, change the backslash to a slash. (The line in
> Makefile for "builtin/worktree.o" uses a forward slash as expected.)

Done, not sure how this got in there. Thanks!

> 
> > +NOTE: For a more exhaustive overview of the new command process, take a look at
> > +`Documentation/MyFirstContribution.txt`.
> > +
> > +NOTE: A reference implementation can be found at TODO LINK.
> 
> I think you have a reference implementation at
> https://github.com/nasamuffin/git/tree/revwalk?

Yep, although it's not very fresh. I was hoping to wait for a way for us
to check in the reference implementation to Git source, although that
can wait and the off-project branch is maybe OK for now.

> 
> > +We'll start by enabling all types of objects in the `struct rev_info`. Unless
> > +you cloned or fetched your repository earlier with a filter,
> > +`exclude_promisor_objects` is unlikely to make a difference, but we'll turn it
> > +on just to make sure our lives are simple. We'll also turn on
> > +`tree_blobs_in_commit_order`, which means that we will walk a commit's tree and
> > +everything it points to immediately after we find each commit, as opposed to
> > +waiting for the end and walking through all trees after the commit history has
> > +been discovered. With the appropriate settings configured, we are ready to call
> > +`prepare_revision_walk()`.
> > +
> > +----
> > +static void walken_object_walk(struct rev_info *rev)
> > +{
> > +	rev->tree_objects = 1;
> > +	rev->blob_objects = 1;
> > +	rev->tag_objects = 1;
> > +	rev->tree_blobs_in_commit_order = 1;
> > +	rev->exclude_promisor_objects = 1;
> 
> Optional: I think we should not bother with exclude_promisor_objects. If
> the user really cloned with a filter, then every object would be a
> promisor object and the revision walk should output nothing, which is
> very confusing.

Sure, that makes sense. Ok, I removed it.


Thanks for looking - and for the patience with the latency on the reply.
