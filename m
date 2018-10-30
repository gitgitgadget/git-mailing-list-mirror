Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA9C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 04:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbeJ3Mvo (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 08:51:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37300 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3Mvo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 08:51:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id g9-v6so10953223wrq.4
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 20:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nCZ2DmdmeXcFajG/+j0QYsnzR+Hg/v2cbXy9jqtFRnA=;
        b=PZXIzioAyzZXamT1rPz/HwsmG6huI7QO1qTBTDXVchF9Pp+4XyhZzcJarHHFfIS+fK
         PW5kwlzBv+8FsLUEWVRZVbYoAs35DFCMm8LLBCyW5JUGopCK+ir/GvpSw9FRRU2TvcPV
         QvfM6NIs1FeRAdzqASzTP0Wol9LF0wfjXzBe8jNDVWlIHAqKab6d5EOPDS/DQ6dhatfZ
         duuPwmSI1zjlsRYoX5O+sK7PtkdBe+VSFcjldbzGFUoxIiDVnOWZ/yDIzh3DQGX7uEtW
         yphFBaN0l9YS49s/KWrfX+05gGCnom5zU/4paE5qWqtjG7otqEVjcUyXO/iF8VYoiTwA
         Ngwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nCZ2DmdmeXcFajG/+j0QYsnzR+Hg/v2cbXy9jqtFRnA=;
        b=Xddzt0riFlYMCRY71Zw4NlGUqEjHJUhx+0C0vH/Gls24zNwmPjhH9Pm6xObF1xOmmW
         0PMc2Y4UN40ZFx7XqO+WOsXF8wm5MJFjYRU9RXRPYP4yqAOohHg7pzIYztHfQ8LYtSua
         O51KEMTHpciv2xERoV0zUshNT8ikgs4XpalBS2bqkjYCNab0xmpXOJUxPgU77j+3W+ZQ
         kHpTB6dq7QU12nbIT8Brn2vIEB/VMd10r7QNsDwmrWLfFd3HUxDzDitTfEWezuy7vat1
         lJz4sAng2zJYRmrDYJDudjwx9L3oCutyKoHKMz9kld/Q+OWg+kDtj2i5wOy/pbRajvcd
         kDsw==
X-Gm-Message-State: AGRZ1gJfZb08NaEYx1zEvFR0TE2HqBVwO/bjdx+PbpvXIPxqBE9kSku7
        P+NUHRt8RVUBNXi3wxgsY48=
X-Google-Smtp-Source: AJdET5elVjqsHjAmb6Jj6FKsQVo2Xo7wyaSHJt/4Ycnef+DmutfJ3P3mLM5sGrZ6EFLhVat3gEWvtA==
X-Received: by 2002:adf:f90f:: with SMTP id b15-v6mr10349597wrr.178.1540871997201;
        Mon, 29 Oct 2018 20:59:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z15-v6sm3669011wrp.8.2018.10.29.20.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 20:59:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Generation Number v2
References: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com>
Date:   Tue, 30 Oct 2018 12:59:55 +0900
In-Reply-To: <6367e30a-1b3a-4fe9-611b-d931f51effef@gmail.com> (Derrick
        Stolee's message of "Mon, 29 Oct 2018 12:55:33 -0400")
Message-ID: <xmqqy3ag13us.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> **V3: Corrected Commit Date.**
> For a commit C, let its _corrected commit date_ (denoted by cdate(C))
> be the maximum of the commit date of C and the commit dates of its
> parents.

"maximum of the commit date of C and the corrected commit dates of
its parents"?

We've talked about exactly this one in the past (long before any of
Microsoft folks other than Dscho came to the scene) but without an
implementation, or detailed design and analysis.  I am very happy to
see the idea among other possibilities to be considered again.  This
time around, we may finally come up with something better than the
"commit dates with SLOP" thing ;-).

> Essentially, the felineY order is selected with the goal of swapping
> positions of topologically-independent commits relative to the felinX
> ordering. The resulting reachability index is as follows:
>
>    If felineX(A) < felineY(B), then A cannot reach B.
>    If felineY(A) < felineY(B), then A cannot reach B.

I presume that the first line is a typo and you compare the same X index?

> * **Compatible?** In our test implementation, we use a previously unused
>   byte of data in the commit-graph format to indicate which reachability
>   index version we are using. Existing clients ignore this value, so we
>   will want to consider if these new indexes are _backwards compatible_.
>   That is, will they still report correct values if they ignore this byte
>   and use the generation number column from the commit-graph file assuming
>   the values are minimum generation numbers?

I personally consider that the current commit-graph with generation
numbers experimental, so I am not sure how much we care about this.

Having said that.

By the above definition, any new index that is wider than the
current generation number cannot be compatible (can we even tell the
existing clients how wide each elements in the ix array is?)

In any case, perhaps the first thing to do is to update the clients
so that they stop ignoring the version number field, and instead
work without generation number when there is no version of reach.ix
available in the file?  That way, a better reachablility index can
be chosen freely without having to worry about the compatibility.

> * **Immutable?** Git objects are _immutable_. If you change an object you
>   actually create a new object with a new object ID. Are the values we
> store
>   for these reachability indexes also immutable?

Even if we do not embed the reachability ix in commit objects,
having an immutable value is probably a must if we want to make them
incrementally computable, so this is a very good property to have.
Unless there is a clever idea to incrementally compute a mutable
reach.ix, my gut instinct says that this property is a must.

Another thing, perhaps related to "local" below, is if exactly the
same reach.ix is computed by anybody, given an identical commit
history graph (perhaps "reproducibility"?).  I think most of the
candidates you listed are reproducible without a fixed tie-breaker,
but I am not sure about felineY() thing.

> * **Local?** Are these values **locally computable**? That is, do we only
>   need to look at the parents of a commit (assuming those parents have
>   computed values) in order to determine the value at that commit?

A subset of non-local reachability ix, for example, the ones that
need to know what each commit's children are, cannot be immutable,
as adding new objects to the graph (either with locally committing,
or transferring objects from other repositories) would affect the
ix; is this true for all non-local reachability ix, I wonder?

> We focused on three types of performance tests that test the indexes
> in different ways. Each test lists the `git` command that is used,
> and the table lists which repository is used and which inputs.
>
> ### Test 1: `git log --topo-order -N`
>
> This test focuses on the number of commits that are parsed during
> a `git log --topo-order` before writing `N` commits to output.

A devil's advocate comment.  Your patches seem to be very focused on
this "unlimited" case for the past few weeks, but I am not so sure
if that is a case worth optimizing for.  If "git log --topo-order -N
HEAD~M.." (for some number M) gives us a similar result as unlimited
case but with much less effort, wouldn't it be good enough that lets
us concentrate on other use cases instead?

> Based on the performance results alone, we should remove minimum
> generation numbers, (epoch, date) pairs, and FELINE index from
> consideration. There are enough examples of these indexes performing
> poorly.

OK.

> In contrast, maximum generation numbers and corrected commit
> dates both performed quite well. They are frequently the top
> two performing indexes, and rarely significantly different.
>
> The trade-off here now seems to be: which _property_ is more important,
> locally-computable or backwards-compatible?

Nice summary.  

As I already said, I personally do not think being compatible with
currently deployed clients is important at all (primarily because I
still consider the whole thing experimental), and there is a clear
way forward once we correct the mistake of not having a version
number in the file format that tells the updated clients to ignore
the generation numbers.  For longer term viability, we should pick
something that is immutable, reproducible, computable with minimum
input---all of which would lead to being incrementally computable, I
would think.

