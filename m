Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C95D41F454
	for <e@80x24.org>; Tue,  5 Nov 2019 18:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390790AbfKESx0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 13:53:26 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:53679 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390664AbfKESx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 13:53:26 -0500
Received: by mail-pg1-f201.google.com with SMTP id u11so15786401pgm.20
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qciHXbJ3lL6zb4w54MM3ki1oXQHP6v9QyUlIE/Cajf0=;
        b=tgDDTjOU6MHvH81Zf06vEF1XSvPkyREtmQDsF3XO58axlCIuPSgeobPbflqkumcytI
         yX9gwRPzCl4lrCdZ0qDzEBvlsTVJ0aBC08YFGz2JVTzVv6kw6NMNwm/TXnHWfO1R8sa+
         seLIlpjHq1mCZAA8YnaSZG4Udke30U6iLD/Boe4vgK3FFfx+1DHzeBJXWq6M1EiEwjha
         jn2MI1KMrUlkFqSSEUMWKVkzVyb0sAP8xmri4psm0Q4i1c+QzN4Vp1Q35YuTF/G4bhHx
         +pq1SKgcneEzd3JYKn3h+fY+xHMvvBDYWWPYvhrN/6uanyak++S1mk5JgP/MqH7Qm4SC
         HKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qciHXbJ3lL6zb4w54MM3ki1oXQHP6v9QyUlIE/Cajf0=;
        b=l3YJp4Tk4rEat1rY5b/6+URqZy0xBGMelS38aMxyEM5kww+Qb/ku04E5DWho0N/ycH
         VPJkhPriBZvFeWhNgecMz/C94H39P3tFhO3aiT3Kp4rN8NGjPfiwZkZTH+VF7Yzb8jPK
         nxFrDj6wJCVQ8d/xFcGd4ht4Iw0BE1zFQwPYW3fs7SKeMbRHjf/mJ5JCf5EhX2wi4oFa
         o0RM5js/xbrh8cUOo5N7fKotKcS7eypT6//P0RpV7oqZKzguyS/2MRtgbZQYw0oTG4O4
         8eRHQ35opZSgaPwXtj5xJ0E0lblTd0kVgkf3X9O73Ae1Dnt9cDVeLi+9sMmbhdgI0ZhH
         4jnQ==
X-Gm-Message-State: APjAAAXhR8ZsnXqcFOw5Pgxxs6qFXq6aIlvGsiRF6Q4WRNCKaRY3AbKW
        +9qnEKL+y/LXXVCRbzN3vx1o0Akr7yQBXM3x6COF
X-Google-Smtp-Source: APXvYqyhyB1RK8mVcNFI3xgPUcdOI1TqeHwGOHwKBHk577NAs6UcvDk7lvIVc99a+/XMXp75ZEWZRZhA7ie/xe35+186
X-Received: by 2002:a63:234c:: with SMTP id u12mr36922540pgm.384.1572980005062;
 Tue, 05 Nov 2019 10:53:25 -0800 (PST)
Date:   Tue,  5 Nov 2019 10:53:22 -0800
In-Reply-To: <20191101220537.GA249573@google.com>
Message-Id: <20191105185322.205317-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191101220537.GA249573@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your review.

> > Note that commits and tags may still be lazy-fetched. I limited myself
> > to objects that could be trees or blobs here because Git does not
> > support creating such commit- and tag-excluding clones yet, and even if
> > such a clone were manually created, Git does not have good support for
> > fetching a single commit (when fetching a commit, it and all its
> > ancestors would be sent).
> 
> Is there a place we could put a NEEDSWORK comment to avoid confusion
> when debugging if this gets introduced later?
> 
> Even if not, this seems like a sensible choice.

Done in the test.

> > I've verified that this also solves the bug explained in:
> > https://public-inbox.org/git/20191007181825.13463-1-jonathantanmy@google.com/
> 
> Might be worth mentioning the example from there in the commit message
> as well, to help explain the context behind the change.
> 
> I would still be in favor of applying that more conservative change to
> "master", even this late in the -rc cycle.

If we're applying that change first, then this no longer fixes any bug,
but is just a code cleanup. (If we don't apply that change, then I'll
include that example in the commit message.)

> Should we make OBJECT_INFO_QUICK always imply
> OBJECT_INFO_SKIP_FETCH_OBJECT?  I would suspect that if we are willing to
> avoid checking thoroughly locally, checking remotely would be even more
> undesirable.

As I wrote in [1], the implication does not really go both ways. I think
it's better to keep them separate. (Or, at least, we don't need to make
the decision in this patch.)

[1] https://public-inbox.org/git/20191011220822.154063-1-jonathantanmy@google.com/

> > +test_expect_success 'fetch lazy-fetches only to resolve deltas' '
> > +	setup_triangle &&
> > +
> > +	# Exercise to make sure it works. Git will not fetch anything from the
> > +	# promisor remote other than for the big blob (because it needs to
> > +	# resolve the delta).
> > +	GIT_TRACE_PACKET="$(pwd)/trace" git -C client \
> > +		fetch "file://$(pwd)/server" master &&
> > +
> > +	# Verify the assumption that the client needed to fetch the delta base
> > +	# to resolve the delta.
> > +	git hash-object big-blob.txt >hash &&
> > +	grep "want $(cat hash)" trace
> 
> nit: can avoid using cat:
> 
> 	hash=$(git hash-object big-blob.txt) &&
> 	grep "want $hash" trace

I think it's less error-prone if we always have a "git" command on its
own on a line, to avoid losing its error code. When piped into another
invocation, or when command-substituted into an argument (e.g. "echo
$(git hash-object foo)"), we lose its error code.
