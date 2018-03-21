Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B9431F404
	for <e@80x24.org>; Wed, 21 Mar 2018 16:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751548AbeCUQSb (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:18:31 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:56101 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbeCUQSa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:18:30 -0400
Received: by mail-wm0-f46.google.com with SMTP id t7so10805634wmh.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MlRAdmhIYQQTWuccDK2lBg8o1g5cHG5IFLArZHjPmPY=;
        b=U8ZUgk1+9nDqztRFP58bqUKMpaw/t6UxkiKPBQ70tBGsZI/LW3t7zE8vgU35nJzKTu
         efHSnp7+9rApmI0w6VRVrSv6TRsbLFBefslzWCcVMy0n57LmwvhHF9GeaiPhf8kZKryy
         x8J5VP7fCNMbrZk4yebdBeJyGhNdx1W1206QxGhwhJVSDbMZjEQka6uq0NNUAaNMHHj2
         3fH+SyTqUir+kf1R0WaPaHWxQ8IZpzWpD9WHSDX0Yc4JOdeLXi0srJOJmIySWTrZY7eh
         EVJJa8Cnf54cXi83lUPNxLfR8ikdSctdCM9L6J4OPnDN+Vqisrc4f6dGy0CpDe8NDQhp
         VTIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MlRAdmhIYQQTWuccDK2lBg8o1g5cHG5IFLArZHjPmPY=;
        b=dYJm1C6ZT6X9DoH96yl+uL1oqkU8VAxTMH/asRhvdtUYr+yLJaDLSeanEQDOZUl38T
         wM1TCSE2IPfbr3eRyAhMmCPfHak+x5rjtGwq612LhLmmsdaoPWu6sDSJUUwg4Q5HsTT0
         TWnSCUcoFuVB9waxZjh/iRMZOjOETHe2EPjG/9LTl7xnxd/FexhpTDdb5UZFvdAtQpkG
         qFO8XOiI8pxyPkwdUTy4pm5/Q6NAa5bZhA7VGEowmcO6OZizGT2Aj9ZCvEyUnds86/gd
         RuDEeAsAcM94fhtHW+dpW2teT0RgGNl5SL788SP+wjMtDm2GZCWQG3MLSPiyeg0kKs0C
         3v3g==
X-Gm-Message-State: AElRT7Ea+tHLxVjNJlLKOtfxSr44xecvkk7hoB3Uiq31aRdzcj2RFlI4
        vhHqgcaxhS6d1pn9ABy22cQ=
X-Google-Smtp-Source: AG47ELuQxRLpZPJlrJ7jB4F0uiTR9v/khsam1NGsDxhXrbdamjdRyjS2W9Qmxz26Cgo1Ti55B1IKUA==
X-Received: by 10.28.88.195 with SMTP id m186mr3078820wmb.113.1521649108288;
        Wed, 21 Mar 2018 09:18:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f206sm5483526wmf.26.2018.03.21.09.18.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:18:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dakota Hawkins <dakota@dakotahawkins.com>
Cc:     Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
        Git <git@vger.kernel.org>
Subject: Re: .gitattributes override behavior (possible bug, or documentation bug)
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
        <20180320023423.GA10143@sigill.intra.peff.net>
        <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
        <20180320040411.GB12938@sigill.intra.peff.net>
        <CAHnyXxQMbnNam=oB_B57xDZBaMPRn_8hfKtostHPV6nBHbTBog@mail.gmail.com>
        <20180320044036.GD13302@sigill.intra.peff.net>
        <CACsJy8BP+ov0jeHp6QZoi=etPDQX5qEFqEfktyA-U-ffUE92vA@mail.gmail.com>
        <CAHnyXxRsqR3A0FpHJwnfOWo29WNx05qWSXfxvmwPv1TUdqm0aQ@mail.gmail.com>
        <20180321065212.GC16784@sigill.intra.peff.net>
        <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
Date:   Wed, 21 Mar 2018 09:18:27 -0700
In-Reply-To: <CAHnyXxTf16ukf8CFSfzjQjTEjf5yJXFqK5TnS9KiXZEeAD7dgg@mail.gmail.com>
        (Dakota Hawkins's message of "Wed, 21 Mar 2018 03:36:09 -0400")
Message-ID: <xmqqa7v1qu5o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dakota Hawkins <dakota@dakotahawkins.com> writes:

> At any rate, would it at least be a good idea to make the "trailing
> slash halts recursion, won't consider nested .gitignore files"
> explicit in the `.gitignore` doc? Unless I'm missing it, I don't think
> that behavior is called out (or at least not called out concisely/in
> one place). It looks like this is all there is:
>
>     "If the pattern ends with a slash, it is removed for the purpose
> of the following description, but it would only find a match with a
> directory. In other words, foo/ will match a directory foo and paths
> underneath it, but will not match a regular file or a symbolic link
> foo (this is consistent with the way how pathspec works in general in
> Git)."

This is not saying "trailing slash halts" (and there is no need to
say "trailing slash halts"---the rule is "directory is not recursed
into").  The mention of '/' in the above paragraph is merely saying
that we chose to use a trailing slash as a syntax to say "I want the
path to match this pattern, but only when the path is a directory".
In other words, if "D" (nothing else on the line) is on a line, it
would match a file whose path is "D", but if you write "D/", it
would not.  It only would match a directory whose path is "D".

What "removed for the purpose of the following description" wants to
say is about where in the path "D" in the above example can appear.
Another rule after the paragraph would say that a pattern with a
slash in it will match only at the current level, and a pattern with
no slash would match in any level down below.  Imagine an entry "D"
and another entry "A/B" in .gitignore at the top-level of the
project.  The former has slash in it, the latter does not.  These
patterns match paths "D", "X/D", "A/B" but not "X/A/B".  The first
two match because the pattern "D" is not anchored with any slash,
the last one does not match because the pattern "A/B" has a slash in
it.

If the top-level .gitignore had "D/" and "A/B" in the above example,
and paths "D" and "X/D" were both directories, the pattern "D/"
still matches the directory "X/D", even though it is spelled with a
slash in it.  That slash is there merely for the purpose of marking
the pattern to only match directories, and does not trigger "slash
in a pattern anchors the pattern" rule, because it is "removed for
the purpose of the following description".

> Also, I'm not sure what the "following description" is in "it is
> removed for the purpose of the following description". Is that trying
> to imply "excluded from the rest of the doc"?

See above.
