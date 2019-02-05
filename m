Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E1871F453
	for <e@80x24.org>; Tue,  5 Feb 2019 18:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfBESpl (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Feb 2019 13:45:41 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37724 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBESpl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Feb 2019 13:45:41 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so719wmd.2
        for <git@vger.kernel.org>; Tue, 05 Feb 2019 10:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dB41H+e4Q/KINjj1Qm+Y9n4A9GmAri+/z6Yq5pUFuCI=;
        b=hp6HgLz8BZlFS5CVvmXCUBtqKyHVDw6t0Jae4CAPYrBeLQlpXolXw/leIbm2pcVgTI
         R5by+Ip80rR46bHguKdh+vbvUW2xBDkqYMXycAS95ELHkFavAorn++rodjVBXc5Kc+Ib
         KxuTu4QDkR8T/o73nMqVPXWEyzZu1FvpDob04WAGHJalzUYN5PIDtRTTHlxkgXb4rGzn
         QKXwlI021jDqMhpoqhO1oujmrEuGZyH7u8mn0IbuMxCd4I5vlxkOTof/TqSscL79aBzO
         Q8BbGVuqtuNvWLpb8V82h2r+vZeTszqz0fRfTgjRq+QHPlFpz8bqK/ZdKI6iLC5L8wXS
         jbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dB41H+e4Q/KINjj1Qm+Y9n4A9GmAri+/z6Yq5pUFuCI=;
        b=PvZk4PQCfg7TQUjI3RtWY4bvm77aZv/Um7X6N/lSfs+tGkuOe361a5Kg7m6EXeA03d
         bcEdM5HcgPfqM8xwaTvFI/rPTkVjaUnz6T/pCliLPfK0dHD8dgoJWhFV9F4ifE8VaPl7
         VJP9RZjKMaal/GSGWWi2WE5mNkCljbMol3q2PidZKjhjAPEErVdhxVub5byZ5QO85IsY
         wpjCUB4AKxAkZUDxVj4kCwcTOwIfAJ8kT64l2udySELVkLwRAkJFbdTtG1otmywNKzFH
         /RAd6XbSF24U6DbgkNL/MIxP3q41k63/71JaFWzlxMM0qYSiq3/q1u4mB1v4AmTCy+0R
         8ueA==
X-Gm-Message-State: AHQUAubnR909oNwt3iotoSh7ox8zeZvAe4lZgLdjYcEByd7ptQhgKhX0
        oFBuFbr1TxcXLq0EGmcvka8=
X-Google-Smtp-Source: AHgI3IahUemH0Scm1XBXnCvfZaVSmiYYhcOnlAA/n/I6BwPO5IR7q/ZaGrPB3n2mMjZ1aSDlEKY74Q==
X-Received: by 2002:a1c:d00d:: with SMTP id h13mr88833wmg.13.1549392337996;
        Tue, 05 Feb 2019 10:45:37 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c18sm13803367wre.32.2019.02.05.10.45.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 10:45:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] doc-diff: don't `cd_to_toplevel`
References: <20190203230152.GA25608@sigill.intra.peff.net>
        <20190204205037.32143-1-martin.agren@gmail.com>
        <20190204233444.GC2366@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet>
Date:   Tue, 05 Feb 2019 10:45:35 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902051050090.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 5 Feb 2019 11:34:54 +0100 (STD)")
Message-ID: <xmqqimxyrs4w.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> In particular, the tests t2024 and t5552 are broken for
> ma/doc-diff-usage-fix on Windows. The reason seems to be that those are
> already broken for the base commit that Junio picked:
> jk/diff-rendered-docs (actually, not the tip of it, but the commit fixed
> by Martin's patch).
>
> Of course, I understand why Junio picks base commits that are far, far in
> the past (and have regressions that current `master` does not have), it
> makes sense from the point of view where the fixes should be as close to
> the commits they fix.  The downside is that we cannot automate regression
> testing more than we do now, with e.g. myself acting as curator of test
> failures.

I think by "regressions that current master does not have", you
actually meant "unrelated known breakages we have fixed since then".

If you use topic-branch workflow, it is unavoidable and expected, as
each topic has its focus and the topic to fix doc-diff are not about
making checkout test or fetch negotiator test to pass on all
platforms.

I am wondering if the automated testing can be made more useful by
limiting the scope of testing if it is run on individual topic.  For
four primary integration branches, we do want to ensure all tests
keep passing (or at least no tests that passed in the previous round
start failing), but it would match the topic-branch workflow better
if the automated testing allowed an individual topic to rely on
unrelated known breakages to be dealt with by other topics and newer
integration branches.

For a topic like doc-diff that is primarily meant for developers and
documenters, it does not matter much, but for an old but important
bug, forking the topic to fix it at a point close to the origin is
crucial---that is what would allow people to merge the fix to an
older maintenance track, without cherry-picking.  It is especially
true when the bug being fixed is more severe than unrelated
breakages that have been fixed since then.

Possible approaches I considered and rejected are:

 - Perhaps find updated tests in the topic and run only those?  We
   can complain a topic that is meant as a "fix" to something if it
   does not have test while trying to find such tests ;-)  But this
   does not work if a "fix" has unintended consequences and breaks
   existing tests that do not have apparent relation known to the
   author of the patch.

 - Perhaps find the fork point, run tests to find known breakages
   and exclude them?  This would simply be not practical, as it
   doubles the number of tests run, for individual topic branches
   because there are an order of magnitude more of them than the
   primary integration branches.

Possibly, if we limit the fork point to tagged releases, the latter
approach might turn out to be doable.  For ma/doc-diff-usage-fix,
the base commit ad51743007 was v2.20.0-rc0~232, so we could round up
and pick v2.20.0 as the base instead (the purpose of picking an older
point is to allow merging to older maintenance track, and it is
unlikely that people would keep using v2.20.0-rc0 as the base of
their forked distribution).  Then if the automated testing keeps
record of known breakages (whether they are later fixed or still
broken) for these tagged releases, testing a new topic forked from
one of them and deciding not to worry about breakages of tests that
are known to be broken (or perhaps deciding to skip these tests in
the first place) may become feasible.

I dunno.  Limiting fork points to tagged releases for topics that
are meant for the maintenance tracks may have other benefits by
restricting the shape of the resulting dag, so I am willing to try
it as an experiment, whether it would help your workflow or not.


