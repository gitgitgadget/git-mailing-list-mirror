Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 704E52022A
	for <e@80x24.org>; Tue, 25 Oct 2016 11:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbcJYLqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 07:46:54 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36576 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbcJYLqx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 07:46:53 -0400
Received: by mail-oi0-f46.google.com with SMTP id m72so92807127oik.3
        for <git@vger.kernel.org>; Tue, 25 Oct 2016 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=laplRqcEMuBnPYXm/JfW4yPXgeWwM5zxI8p6H3vkOcA=;
        b=aImGcuEcl2QvOkzuQqnZFrld8hDfZXMMkTbHcrbGup99mzWNJo3VBXcBWAssLkDg9S
         gW2xQvlI6HIT+rVb1+cX8pbb5g3IMTljOPqYqYd+VZYvKP77345vxsEWFcWpDEI6Xnvr
         gCaUv0hHbgMJWL39A6C0Hu7gJDXjVRVRK+7qiaEGMjbWsqyo0PcPBo6eqPNV7ZA7PEBH
         kqV2yQPlvSOOWaTPsahJd1IaeqvAiQaT27XFbp0Ge2iACsW6rYOZECYKI598dJ/547zn
         yF1d+uWD/U9S3KvtxOACPwzJsTgW5Bdd2nwd3Qmt+vI73bfXjDHbRCnKb4D1ezodMI5S
         V1uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=laplRqcEMuBnPYXm/JfW4yPXgeWwM5zxI8p6H3vkOcA=;
        b=QFKYFErVTNcSfwiMTJuUKbhJT+tOYr8Dv1dsD1h4WqEbec0O+RKZfOEelwEM5IC6Oq
         +yhsiI8L712Ty5Z3Aqni01a+QKNW3lAMhj9bG5Hj6KToAIEKVywxua4bOhpJ+koFQEa3
         TLibjitVBhQvF2Px/+yehvwBPhBMrEV4PAARKEn2eO2XNE185S1iM02uK4Y6UKlJH/bw
         1kthq8zVOygzDjwxd8T7Qt9UqjYTj825/6Qr32p1+89sRTCycgYV3Hr23XpRyvHHrk8k
         GZ3awMX7Qg8qR6lmfgD4beqL5YCJGUsmBW7K0fICIN4UkuskI7Q6P4HpUN9aSTvDHPeM
         9evg==
X-Gm-Message-State: ABUngvfT+tyNo7whsS0fGyfNyJ0DtUL6Yz3n2U6GaqfNwSHPRVgFav+xtuzGHKEGHiPjCvAuQvXILzBTQQ3Mnw==
X-Received: by 10.107.59.6 with SMTP id i6mr17135191ioa.176.1477396012105;
 Tue, 25 Oct 2016 04:46:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Tue, 25 Oct 2016 04:46:21 -0700 (PDT)
In-Reply-To: <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>
References: <20161024132932.i42rqn2vlpocqmkq@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Oct 2016 18:46:21 +0700
Message-ID: <CACsJy8DwKxz14Dow9dEKeXnBriMzN_OptnGM7nPigPcS_pHX9w@mail.gmail.com>
Subject: Re: [RFH] limiting ref advertisements
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2016 at 8:29 PM, Jeff King <peff@peff.net> wrote:
> I'm looking into the oft-discussed idea of reducing the size of ref
> advertisements by having the client say "these are the refs I'm
> interested in". Let's set aside the protocol complexities for a
> moment and imagine we magically have some way to communicate a set of
> patterns to the server.
>
> What should those patterns look like?
>
> I had hoped that we could keep most of the pattern logic on the
> client-side. Otherwise we risk incompatibilities between how the client
> and server interpret a pattern. I had also hoped we could do some kind
> of prefix-matching, which would let the server look only at the
> interesting bits of the ref tree (so if you don't care about
> refs/changes, and the server has some ref storage that is hierarchical,
> they can literally get away without opening that sub-tree).
>
> The patch at the end of this email is what I came up with in that
> direction. It obviously won't compile without the twenty other patches
> implementing transport->advertise_prefixes

Yes! git-upload-pack-2 is making a come back, one form or another.

> but it gives you a sense of what I'm talking about.
>
> Unfortunately it doesn't work in all cases, because refspec sources may
> be unqualified. If I ask for:
>
>   git fetch $remote master:foo
>
> then we have to actually dwim-resolve "master" from the complete list of
> refs we get from the remote.  It could be "refs/heads/master",
> "refs/tags/master", etc. Worse, it could be "refs/master". In that case,
> at least, I think we are OK because we avoid advertising refs directly
> below "refs/" in the first place. But if you have a slash, like:
>
>   git fetch $remote jk/foo
>
> then that _could_ be "refs/jk/foo". Likewise, we cannot even optimize
> the common case of a fully-qualified ref, like "refs/heads/foo". If it
> exists, we obviously want to use that. But if it doesn't, then it
> could be refs/something-else/refs/heads/foo. That's unlikely, but it
> _does_ work now, and optimizing the advertisement would break it.
>
> So it seems like left-anchoring the refspecs can never be fully correct.
> We can communicate "master" to the server, who can then look at every
> ref it would advertise and ask "could this be called master"? But it
> will be setting in stone the set of "could this be" patterns. Granted,
> those haven't changed much over the history of git, but it seems awfully
> fragile.

The first thought that comes to mind is, if left anchoring does not
work, let's support both left and right anchoring. I guess you
considered and discarded this.

If prefix matching does not work, and assuming "some-prefix" sent by
client to be in fact "**/some-prefix" pattern at server side will set
the "could this be" in stone, how about use wildmatch? It's flexible
enough and we have full control over the pattern matching engine so C
Git <-> C Git should be good regardless of platforms. I understand
that wildmatch is still complicated enough that a re-implementation
can easily divert in behavior. But a pattern with only '*', '/**',
'/**/' and '**/' wildcards (in other words, no [] or ?) could make the
engine a lot simpler and still fit our needs (and give some room for
client-optimization).

> In an ideal world the client and server would negotiate to come to some
> agreement on the patterns being used. But as we are bolting this onto
> the existing protocol, I was really trying to do it without introducing
> an extra capabilities phase or extra round-trips. I.e., something like
> David Turner's "stick the refspec in the HTTP query parameters" trick,
> but working everywhere[1].
-- 
Duy
