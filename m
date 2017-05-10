Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C369320188
	for <e@80x24.org>; Wed, 10 May 2017 17:02:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbdEJRCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 13:02:30 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35579 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753001AbdEJRC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 13:02:29 -0400
Received: by mail-pg0-f47.google.com with SMTP id o3so758414pgn.2
        for <git@vger.kernel.org>; Wed, 10 May 2017 10:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yn4KuTfuXsU1H61hK5PON/VB2pjjLq4PoFGEuWd8Pg4=;
        b=eP8/Pkmt8dlz2Wku9nXIcPldUisGEmNgJ5pQgTtN+AGH+DEXKa6f6sw2fmISEaFV4O
         I7XtXFu96XZvsJB7hTj0+XevPkreZa3DBAAIC+HDlez5IlMjpBRQq/vgCD7oNW2mJfbT
         pRQmHwhto7LeN2A7F58qLzgbze9KiiHX/bt/H9iDqx+LZELkbgDoq2t5wz9thqe3b431
         0rABJW953+Ns99SqRDQ2V3Y5I981GtO+bPFUKLktQq/+eNIUS32bxgxdqKl1FPeyYOmR
         TlNqhI9DTGG7nGgFkSxsYQ51YCCdC8I5GANmB9MgJGaeiFW3it85vx4D1bZycOXoBbXD
         EQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yn4KuTfuXsU1H61hK5PON/VB2pjjLq4PoFGEuWd8Pg4=;
        b=DEm5Lb+Jr0hSmlOZfirKE2HST/8OGmsqKDWe8O6ayRNnbfqsvqJn8AwXkIK/NNR5/E
         ZQUl/9UFzS8ib23IEzrn/xQ+e3zI/lamcCgElijWftCYfvOMY4rN6H/4rUTy2rS8A1w7
         Hk1ylmWlkHKHWVS5c9rmsHaeGCVghbBbN9Iydfoy11XGWC3ipsJD5ge8x3o8yOUIVmdo
         7L+gO1WVvMZ6tdKBKDrbfcVomvYyl31MPiSLdGH9Ye8d6Wfimlz+yyntStf21JV/qwz9
         sOCRMGIhQ4CwoAyyz9OK6bpRaOhKJYPOrkCPdYK/kYxerWf707EylJg3lqlG+OOEedWk
         xI/g==
X-Gm-Message-State: AODbwcDwgCrwrcq7WlBa+EdSiILXV65j4/4UrPvNcOwPDa+FCJTavzE1
        6UrjJF2GI+rHn8B+
X-Received: by 10.98.131.134 with SMTP id h128mr7411754pfe.0.1494435748975;
        Wed, 10 May 2017 10:02:28 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b127:d26b:19a3:378d])
        by smtp.gmail.com with ESMTPSA id n71sm6925065pfg.46.2017.05.10.10.02.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 10:02:27 -0700 (PDT)
Date:   Wed, 10 May 2017 10:02:26 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
Message-ID: <20170510170226.GB41649@google.com>
References: <20170509191805.176266-1-bmwill@google.com>
 <20170509191805.176266-9-bmwill@google.com>
 <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/10, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Convert 'parse_pathspec()' to take an index parameter.
> >
> > Since the index is only needed when the PATHSPEC_SUBMODULE_LEADING_PATH
> > and PATHSPEC_STRIP_SUBMODULE_SLASH flags are given, add a check
> > requiring a non-NULL index when either of these flags are given.
> > Convert callers which use these two flags to pass in an index while
> > having other callers pass in NULL.
> >
> > Now that pathspec.c does not use any cache macros and has no references
> > to 'the_index', mark it by defining NO_THE_INDEX_COMPATIBILITY_MACROS.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> 
> The same comment as 5/8 applies to this change, but it is a bit
> easier to judge, because it has so many callers, and for some
> builtins, especially manipulator commands like add, checkout, and
> commit, there may be a good reason why they want to keep the primary
> index while playing with an additional in-core index in a distant
> future.
> 
> Does a pathspec parsed using one instance of index_state expected to
> work when matching against a path in another instance of index_state?
> Otherwise, passing a non-NULL istate to parse_pathspec() would tie
> the resulting pathspec to a particular index_state in some way and
> there may need a mechanism to catch an attempt to match paths in
> another index_state with such a pathspec as an error.  Just
> speculating out loud...
> 

Currently I don't believe this links a pathspec with a particular
index_state since an index is really just used to do some pre-processing
on the paths (check if the path goes into a submodule and die, or strip
a slash if the path matches a submodule), though I can see a future where
this is true.

I did have another version of this series where I completely removed the
two flags related to submodules.  Since builtin/add is the only caller
which needs to die if a path descends into a submodule, I had a function
which did this after the parse_pathspec() call.  Also, since (ae8d08242
pathspec: pass directory indicator to match_pathspec_item()) stripping
off the slash from a submodule path really is no longer needed for the
path matching logic, this means that we could potentially just drop the
strip slash flag.  The only caveat is ls-files.

ls-files is the only command (that I know of) which does cache pruning
based on the common prefix of all pathspecs given.  If there is a
submodule named 'sub' and you provided a pathspec 'sub/', the matching
logic can handle this but the cache pruning logic would prune all
entries from the index which don't have a leading 'sub/' which is the
common prefix of all pathspecs (if you didn't strip off the slash).
Meaning you'd prune the submodule 'sub' when  you really didn't want to.
This could probably be fixed to have the cache pruning logic to prune by
ignoring the trailing slash always.

So there's another option here if you don't feel quite right about
piping through an index into parse_pathspec just yet.

-- 
Brandon Williams
