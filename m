Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC27920756
	for <e@80x24.org>; Fri, 20 Jan 2017 23:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752447AbdATXWe (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 18:22:34 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:38205 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752276AbdATXWd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 18:22:33 -0500
Received: by mail-it0-f52.google.com with SMTP id c7so31407251itd.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 15:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FwUI0T0gbjfLqnPQ/rG5QdCYe06H1PHj+o5RSYZCZXU=;
        b=Pxs42RgcSN9/qESHqBad/XCAsCDPKyw7bCyFlgZ79pVYawC8ceIL3nfWZ5PevrpL+v
         vOFAC5g5BFxO/eZndS6hbnJhIuL8mweWDP/inTsF8srCY+YQnriJV5wlzR15F+2GbDd5
         enux0craDkX95Z0LY/TAgEIDzXkXGH+xGvEboIGFpzMnTVTYXz7rLnM9uFQL3i6IOoAB
         eSWeT0SjqmPG2OyAKaFOvRpvwC7fBWLgAXC2nKUWkVxT2tNPvPJ4sjk+9xeb14urWYow
         DyCfN6/t3xGbWG4VN0WGtH/ZslJxxGSiudmM3ZQnGvTSUK58pDOX4iCi+jDi0aV17YhJ
         oU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FwUI0T0gbjfLqnPQ/rG5QdCYe06H1PHj+o5RSYZCZXU=;
        b=o1lZuUf1z1SJIh6ltCZHW4jF05cbFk2bLEh7s0SvkvqqOfSEEFF4/M+kTJdLbTFXf9
         ItkazvNw81/oBTpXXwdYDisikViWQqRfVcBWGZ/kpBAS8u1eJ5+CeuNxb3nSEzVD154L
         0dLt520U62ikUXF5ZOTxStGhSplT5+SwdOkfQ25mvb4J59md1NKbMeue/jxhwoSAkViX
         X2N5kxNXD8rLL/qRwUivWumOiRoJKyyARFPJXVH30K/Sf7wX7Jr1/lDjJpdTwetRS27Q
         Woe/mDX1rjUwddSEGc0Y0UhaWCSIb4kims0FfaJp4zEB5HANSAc10F/0qEFpyI/tYw54
         yLUA==
X-Gm-Message-State: AIkVDXKf2GejO1zCC9N7oT318RQhyMVuKTyDW6ZInx/8ijykMMsQNzoEhy4rsl5XP50X8QwOlW5Klb0y1IiZpW0I
X-Received: by 10.36.65.4 with SMTP id x4mr5931357ita.69.1484954552508; Fri,
 20 Jan 2017 15:22:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 20 Jan 2017 15:22:31 -0800 (PST)
In-Reply-To: <xmqqy3y5wg0l.fsf@gitster.mtv.corp.google.com>
References: <20170119193023.26837-1-sbeller@google.com> <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com>
 <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net> <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
 <20170120200041.hefg44stddqe344z@sigill.intra.peff.net> <xmqq37gdxvbx.fsf@gitster.mtv.corp.google.com>
 <xmqqy3y5wg0l.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jan 2017 15:22:31 -0800
Message-ID: <CAGZ79kYW1zS3-9AYPaiUfBGTFygyg1ZVd3YyOctp3gihfEpHeg@mail.gmail.com>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
To:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jeff King <peff@peff.net> writes:
>>
>>>> And in my current understanding of submodules the check in
>>>> .gitmodules ought to be enough, too.
>>>
>>> Yeah, that probably makes sense. You can have a gitlink without a
>>> .gitmodules file, but I don't quite know what that would mean in terms
>>> of submodules (I guess it's not a submodule but "something else").
>>
>> That may be a lot better than reading the index unconditionally, but
>> I'd rather not to see "git rev-parse" read ".gitmodules" at all.  It
>> would discourage scripted use of Git for no good reason.
>
> Thinking about this more, I suspect that
>
>         cd sub && git anything
>
> when the index of the top-level thinks "sub" must be a submodule and
> the user is not interested in "sub" (hence it hasn't gone through
> "git submodule init" or "update") should get the same error as you
> would get if you did
>
>         cd /var/tmp/ && git anything
>
> when none of /, /var, /var/tmp/ is controlled by any Git repository.
> I.e. "fatal: Not a git repository".

I agree. The idea with a tombstone sounds great from a
performance perspective as you do not need to do extra work
in the superproject at all, because any gitlink is detected early
in the discovery.

The big BUT is however the following:
How do current users know if a submodule is e.g. populated?
(From say a third party script). Most likely they use something like

    test -e ${sub}/.git

as that just worked. So if we go with the tombstone idea, we
may break things. (i.e. the fictional third party script confirms any
submodule to be there, but it is not)

I do really like the idea though, so maybe we also need to provide
some submodule plumbing that we opine to be the "correct" way
to see the submodules state[1] to make the transition easier for the
script writers?

[1] c.f. submodule states in
https://github.com/gitster/git/commit/e2b51b9df618ceeff7c4ec044e20f5ce9a87241e

>
> Perhaps we can update two things and make it cheap.
>
>  - checking out the top-level working tree without populating the
>    working tree of a submodule learns to do a bit more than just
>    creating an empty directory.  Instead, it creates the third kind
>    of ".git" (we currently support two kinds of ".git", one that is
>    a repository itself, and another that is points at a repository),
>    that tells us that there is not (yet) a repository there.
>
>  - the "discovering the root of the working tree" logic learns to
>    notice the third kind of ".git" and stop with "Not a git
>    repository".
