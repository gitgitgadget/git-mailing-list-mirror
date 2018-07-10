Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20011F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbeGJSla (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:41:30 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:55289 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388754AbeGJSl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:41:29 -0400
Received: by mail-io0-f201.google.com with SMTP id d11-v6so6133721iok.21
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yVlMMdzYxLI5N3ftRKH0W00D7G5pe3WW/agboDBp37E=;
        b=Hb2oWgIMGsd0UOWL7Pe3gcllA5iXa06H5ioX3hNSfNhhOz4j5qjxBebN8DH1UPNwDA
         YK1AeNgwecSishpZWuz4y5Ky4eOBgHDjvRdljdQ0xqWEyYtwpLTOGCRPOvuBecSWtxBA
         1CNa0KBNMqDPJiqbXMn9v7fQCyZIahIspoUA0Mh691vDTcHmKFeRDqyrA/+gqyvWqH8J
         vYEcWDNvc8P11x7Bx7A+NGmuFvZcVsJdOZsu8WOUv9zVv2G6eToMtlLHFaLvtWs+j58M
         FLO3wM0ecTBUu0IGU6NyT0ATYOw/oAa9Qu8Nfo3njtP4/YvNavHT7kTTlvt3zLbQSpUU
         /l/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yVlMMdzYxLI5N3ftRKH0W00D7G5pe3WW/agboDBp37E=;
        b=NsMLFK0/PATdbv8W67sBn2lru1dZLAkR4zBwy7XNHqhEiJUklOOMYBdNTtpAETXTLP
         QSHHQqkpVHw5emw2gJWWuKlEwsqbBCV4GMMXCMbCf+bb/fXHkLQAhjeFRC4s9g+q6nDj
         Nqi15MuFITxCev1Q0Mg1HQPkEPx1myeF5/AqRbNEq40+8x8QQOxvU8DEo/LgKJbf1kAI
         buC4SIq8G85PqO9rgjPf4vf98RWyg3OZ5KMxjekcTlGC4sRCDhS6Yjza8QRrofonVam7
         ViwgFjdQnNRY/TkSu2mskXM6mn8uZvvsZuh1iJ3cRYQCJEh0kVc+wRjn1xkfBTOzgEfd
         ooHg==
X-Gm-Message-State: APt69E0JRBqc8cpFHPo92Uxp7fm0bq3o0jY/1EIi7mWguAioU7Q99kwf
        IIfSxvx4qnIat6s4iKqu/3ukVA95SzrDfph/zH7Y
X-Google-Smtp-Source: AAOMgpebtkSU9iCpJ5KZCUpyYX59nsZDjbsFrmus2sOg+fQj/Jprlw1zdRZHvK/oBZl1yL6ZkPBl3768xPo35AeJTHSl
MIME-Version: 1.0
X-Received: by 2002:a6b:a303:: with SMTP id m3-v6mr11456783ioe.96.1531243911569;
 Tue, 10 Jul 2018 10:31:51 -0700 (PDT)
Date:   Tue, 10 Jul 2018 10:31:47 -0700
In-Reply-To: <75ef9935-342a-bbda-4ce6-e5a033f273a9@gmail.com>
Message-Id: <20180710173147.104757-1-jonathantanmy@google.com>
References: <75ef9935-342a-bbda-4ce6-e5a033f273a9@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: Re: [PATCH v2 6/6] commit-graph: add repo arg to graph readers
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > -	if (!core_commit_graph)
> > +	if (repo_config_get_bool(r, "core.commitgraph", &config_value) ||
> > +	    !config_value)
> > +		/*
> > +		 * This repository is not configured to use commit graphs, so
> > +		 * do not load one. (But report commit_graph_attempted anyway
> > +		 * so that commit graph loading is not attempted again for this
> > +		 * repository.)
> > +		 */
> 
> I reacted first to complain about this extra config lookup, but it is 
> only run once per repository, so that should be fine.

Thanks for checking. It is indeed run at most once per repository, and
only if a commit graph is requested - the same as the current code.

> The tests below form a decently-large patch on their own. Perhaps split 
> them out so it is easier to know that we have some interesting things to 
> check here.

The patch is 168+ 42-, which doesn't seem that large to me, but I'll do
this if others think that it is large too.

> It's worth spending some extra time looking at this test pattern as I 
> believe we will want to follow it with other arbitrary repository changes.

I agree - let me know if you notice anything you think should be
changed.

> > +static void test_get_commit_tree_in_graph(const char *gitdir,
> > +					  const char *worktree,
> > +					  const struct object_id *commit_oid)
> > +{
> > +	struct repository r;
> > +	struct commit *c;
> > +	struct tree *tree;
> > +
> > +	/*
> > +	 * Create a commit independent of any repository.
> > +	 */
> > +	c = lookup_commit(commit_oid);
> 
> Would this be more accurate to say we are creating a commit object 
> stored in the object cache of the_repository? How would you expect this 
> to work if/when lookup_commit() takes an arbitrary repository? You want 
> to provide &r, right (after initializing)?

Yes, you're right - Stefan too mentioned that this will need to be moved
below lookup_commit(). I'm not sure what the best way is to handle this
- maybe move this, and add a "needswork" stating that we need to pass r
to lookup_commit once it supports taking in a repository argument, as an
aid to the person who performs the merge. I'll do that if a reroll is
needed.

> Also, this will conflict with sb/object-store-lookup, won't it? I'm 
> guessing this is why you didn't touch the "git commit-graph 
> [write|verify]"code paths.

It will conflict because of the change to lookup_commit(), but the only
new code I'm writing is in t/helper/test-repository.c, so hopefully the
merge won't be too tedious. The main reason why I didn't touch the
writing/verifying part is to reduce the size of this patch set, and
because that change is not needed to update parse_commit() and others.

> > +
> > +	repo_init(&r, gitdir, worktree);
> 
> I think you want to move the lookup_commit() to after this.

Yes, that's right.

> > +int cmd__repository(int argc, const char **argv)
> > +{
> > +	if (argc < 2)
> > +		die("must have at least 2 arguments");
> 
> I think this "test-tool repository <verb>" pattern is a good way to get 
> some testing here.

Thanks.
