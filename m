Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFC081F461
	for <e@80x24.org>; Wed,  4 Sep 2019 21:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfIDVSw (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 17:18:52 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36586 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfIDVSw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 17:18:52 -0400
Received: by mail-qk1-f194.google.com with SMTP id s18so89154qkj.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=If8l9xGqpdQhj412QraQaKXkYiVnE0+A0MXYGcxikVY=;
        b=mWUP1kZiBhdthJULBlyYBYFXEp55IX+o9I5ymDqYAgBzRuD/MUXI/1th1318a44jlR
         RrdWjtRE+MSln7Tg7FRcVIcvbVWAPsR8eeEOOd65w3+/5uHWy9WPXKLWiPpsd0mr9E0s
         yUsxvVHHQ7Mu0YOWZ877yN0nnyYb/s+vCdJFZHxrzG3ydtAYUfnzXHT9MUd5g02bgNn6
         Nag7WWo1s2+4EDKKYhz4fvqnUf2DdM5bwc9HMOG/ke15gDi5ijcXankon5cnZbuGC3Hp
         BUxx6SZr3I8uoBlFqj83Ryi+DqZ3Wbm49JRc7ZEl985tpS9AIyCj0iI/hPT+SqrJGXWo
         QDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=If8l9xGqpdQhj412QraQaKXkYiVnE0+A0MXYGcxikVY=;
        b=maGfO3Cr8El3DKC4f9fmmYBcdNFSK2R6mAJFB6EZwNlaJhYELPSlYPplxvT2VF7BnV
         QuQocpIE6IRPURxEBTabK/P7Ftvd2odjtYiaWQEbJHr143usB4CM4ME+Lnqiq1PfhL7t
         mmpDEaOzEn6eECqYClSNqde4VDlsgjFw7qcNEvO72lKdlMWYjM8H58Lu35trdN3tPuMf
         wgJQg3Z2jrsX8NLvYV+xg9q9+lPleJGeBiLShBJ3YcK3I1NOOCJ/crE4T2jJJ36mNs8k
         WHmdNaq2WruYcMDJVZsAP1ZtDvMX2rpeW7L7/rbc/KZvmWkzCd7q39gezzVP88AzNJKO
         KtjA==
X-Gm-Message-State: APjAAAUq/UfJMErBzTpW/UoEo2dexznDLvAynj1MkfLbzFaSk88m1sss
        Pt6XBxqS0wgxURgUzYNTaSikb51m4GY=
X-Google-Smtp-Source: APXvYqwwhb0Rbsrcpo6pqq+yZ87kyLwQtZuABnLCcHXb5/z8z0EyooGMXfoh2lcxv5LT4WeRb4Gl+g==
X-Received: by 2002:a37:48cd:: with SMTP id v196mr14380704qka.419.1567631931552;
        Wed, 04 Sep 2019 14:18:51 -0700 (PDT)
Received: from localhost ([50.49.245.163])
        by smtp.gmail.com with ESMTPSA id s50sm56857qth.92.2019.09.04.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:18:50 -0700 (PDT)
Date:   Wed, 4 Sep 2019 17:18:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        stolee@gmail.com, git@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] commit-graph.c: die on un-parseable commits
Message-ID: <20190904211847.GA20904@syl.local>
References: <cover.1567563244.git.me@ttaylorr.com>
 <34e4ec793cb0d321d16b88777cd2db64ed7b772e.1567563244.git.me@ttaylorr.com>
 <20190904030456.GA28836@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190904030456.GA28836@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, Sep 03, 2019 at 11:04:56PM -0400, Jeff King wrote:
> On Tue, Sep 03, 2019 at 10:22:57PM -0400, Taylor Blau wrote:
>
> > When we write a commit graph chunk, we process a given list of 'struct
> > commit *'s and parse out the parent(s) and tree OID in order to write
> > out its information.
> >
> > We do this by calling 'parse_commit_no_graph', and then checking the
> > result of 'get_commit_tree_oid' to write the tree OID. This process
> > assumes that 'parse_commit_no_graph' parses the commit successfully.
> > When this isn't the case, 'get_commit_tree_oid(*list)' may return NULL,
> > in which case trying to '->hash' it causes a SIGSEGV.
> >
> > Instead, teach 'write_graph_chunk_data' to stop when a commit isn't able
> > to be parsed, at the peril of failing to write a commit-graph.
>
> Yeah, I think it makes sense for commit-graph to bail completely if it
> can't parse here. In theory it could omit the entry from the
> commit-graph file (and a reader would just fall back to trying to access
> the object contents itself), but I think we're too late in the process
> for that. And besides, this should generally only happen in a corrupt
> repository.

Yep. I sent this as an RFC PATCH because I wasn't quite sure how folks
would feel about 'die()'-ing in the middle of 'write_graph_chunk_data',
but I think that your reasoning makes sense, and it matches my own
preferences.

So, I am glad that we resolved that portion. I'll keep going below...

> However...
>
> > diff --git a/commit-graph.c b/commit-graph.c
> > index f2888c203b..6aa6998ecd 100644
> > --- a/commit-graph.c
> > +++ b/commit-graph.c
> > @@ -843,7 +843,9 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
> >  		uint32_t packedDate[2];
> >  		display_progress(ctx->progress, ++ctx->progress_cnt);
> >
> > -		parse_commit_no_graph(*list);
> > +		if (parse_commit_no_graph(*list))
> > +			die(_("unable to parse commit %s"),
> > +				oid_to_hex(&(*list)->object.oid));
> >  		hashwrite(f, get_commit_tree_oid(*list)->hash, hash_len);
>
> I don't think parse_commit_no_graph() returning 0 assures us that
> get_commit_tree() and friends will return non-NULL.
>
> This is similar to the case discussed recently where a failed parse of a
> tag may leave "tag->tagged == NULL" even though "tag->obj.parsed" is
> set.
>
> Here an earlier parsing error could cause (*list)->object.parsed to be
> true, but with (*list)->maybe_tree still NULL. Our call to
> parse_commit_no_graph() here would silently return "yep, already tried
> to parse this", and then we'd still segfault.
>
> We _could_ check:
>
>   if (parse_commit_no_graph(*list))
> 	die("unable to parse...");
>   tree = get_commit_tree_oid(*list);
>   if (!tree)
> 	die("unable to get tree for %s...");
>
> but trees are just one piece of data. In fact, the situation is much
> worse for parents: there a NULL parent pointer is valid data, so worse
> than segfaulting, we'd write invalid data to the commit graph, skipping
> one or more parents!
>
> And I think there's literally no way for this function to tell the
> difference between "no parent" and "there was an earlier error, but we
> set the parsed flag anyway and the parent flag is invalid".
>
> I think that argues against Junio's response in:
>
>   https://public-inbox.org/git/xmqqo90bhmi3.fsf@gitster-ct.c.googlers.com/
>
> about how we can use the parsed flag to look at "slightly corrupt"
> objects. I think we'd need at least an extra flag for "corrupt", though
> I think it is simpler just _not_ setting "parsed" and letting the next
> caller spend the extra cycles to rediscover the problem if they're
> interested.

All of this makes sense to me, so I'm wondering what part(s) of this you
feel are worth addressing in this first patch series. Presumably, there
is a longer series that we _could_ write which would introduce a new
'corrupt' field and then check for it here.

But, I'm hesitant to write those patches, since I only have this one
call-site in mind. If we introduce 'corrupt', I feel it would be best to
use it uniformly, instead of only checking it here, and relying on other
bespoke mechanisms to detect corruption elsewhere.

So, I'm content to write the pseudo-code you provided above (which is to
say, call and check both 'parse_commit_no_graph', _and_
'get_commit_tree_oid'), because I think that it's expedient, and fix the
issue which I'm pointing out here.

I don't know how to address the parents situation without going further,
so perhaps it's worth it to think of an alternative, or even leave it
out of these first patch(es).

Let me know what you think, and thanks for your thoughts so far.

> (All of this presupposes that you can convince another piece of code in
> the same process to parse the commit buffer and ignore the error. I have
> no idea if that's possible or not in this case, but it sure would be
> nice not to have to care).
>
> -Peff
Thanks,
Taylor
