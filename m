Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06ABC211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 12:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbeLEMHa (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 07:07:30 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55911 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeLEMHa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 07:07:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so12928227wmc.5
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 04:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jJbdhr4oVY0xEgXUCqg8DxYpCgDljtRBEQ1R0J5Bj4M=;
        b=DOrpkpsTJYySuRlQ422MToTTRbVRjoRuZreFPHjqRFhwA5Ro7axl/JI4eLqBI58w9B
         lafLbJu+PoEJzfcoz+opu3yJD5PVx2dMetP0jD967fqWJZTH0a3VJjXougNeQ3Pq4WVy
         45US5w2bGf6Xf/WKFhx5s1fssgIf3h6Ztm5oiBVYdXo6yhOcsGlVSGl6eadAfR7cQmoU
         lFAp8pveV+d87U47Cz4Q3dRS+XvbyseCWIBYdk1lHcivM71OGQ/LK+ZdF7YBXouL3i23
         MAqjPRGFtoFIyUBUo8KU6TyLBzLXGIvyW0WTNus8cOVHpEv6wTziivF8rL+RmANNEtsQ
         itPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jJbdhr4oVY0xEgXUCqg8DxYpCgDljtRBEQ1R0J5Bj4M=;
        b=H6YIRYy1sLUkyTMVGCuyByMNF4+7ZVZjSREuzJulOlYD9oNQ+JgcqEsWe0N+ai7pbX
         mw1shajHkZl5FtyUFCPIw2AlvSQGu//pn8AIt5PVFJCqLFMx2+ywif7ps5eT9t7H5YwA
         amEXIfcZzMvOG5D6NNgUig8bbn7BpXwBFyX2l3IwEOGA4yI3Sy48/k7GylaQBkfbAqb1
         7MeHt11+Lfsx9/yAT6VleqivdyWahNU5gjpyQQcpYb7RiApFshNqZEeQuUubsb2yfI3b
         M50A6PW472ETCikEGszXBCWFD5MUDJFjixbRC+xXNT4Qd4EqBPPs+8tFOnIMpBhbjb/4
         QTgw==
X-Gm-Message-State: AA+aEWbRWPaK1tM+8NPg07DIjT0/vpBvC2hlxOI2eTa7jwMn+UghnUev
        0REeAm1JPLLv0bC4GiKRVTM=
X-Google-Smtp-Source: AFSGD/UJ7J+9H3UfeZsGBhB+GLb8okcJgFSBMWoPBi3TURBhAcAwF0BMtaI3NTL1O1qBbTOxN8KP9w==
X-Received: by 2002:a1c:cf0d:: with SMTP id f13mr15182045wmg.70.1544011648480;
        Wed, 05 Dec 2018 04:07:28 -0800 (PST)
Received: from szeder.dev (x4dbd715c.dyn.telefonica.de. [77.189.113.92])
        by smtp.gmail.com with ESMTPSA id n82sm12380524wma.42.2018.12.05.04.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 04:07:27 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:07:25 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 3/3] test-lib: add the '--stress' option to run a
 test repeatedly under load
Message-ID: <20181205120725.GK30222@szeder.dev>
References: <20181204163457.15717-1-szeder.dev@gmail.com>
 <20181204163457.15717-4-szeder.dev@gmail.com>
 <87muplyxfn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87muplyxfn.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 04, 2018 at 07:11:08PM +0100, Ævar Arnfjörð Bjarmason wrote:
> It's a frequent annoyance of mine in the test suite that I'm
> e.g. running t*.sh with some parallel "prove" in one screen, and then I
> run tABCD*.sh manually, and get unlucky because they use the same trash
> dir, and both tests go boom.
> 
> You can fix that with --root, which is much of what this patch does. My
> one-liner for doing --stress has been something like:
> 
>     perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh --root=trash-{} -v'
> 
> But it would be great if I didn't have to worry about that and could
> just run two concurrent:
> 
>     ./t0000-basic.sh
> 
> So I think we could just set some env variable where instead of having
> the predictable trash directory we have a $TRASHDIR.$N as this patch
> does, except we pick $N by locking some test-runs/tABCD.Nth file with
> flock() during the run.

Is 'flock' portable?  It doesn't appear so.

> Then a stress mode like this would just be:
> 
>     GIT_TEST_FLOCKED_TRASH_DIRS=1 perl -E 'say ++$_ while 1' | parallel --jobs=100% --halt-on-error soon,fail=1 './t0000-basic.sh'

This doesn't address the issue of TCP ports for various daemons.

> And sure, we could ship a --stress option too, but it wouldn't be
> magical in any way, just another "spawn N in a loop" implementation, but
> you could also e.g. use GNU parallel to drive it, and without needing to

GNU 'parallel' may or may not be available on the platform, that's why
I stuck with the barebones shell-loops-in-the-background approach.

> decide to stress test in advance, since we'd either flock() the trash
> dir, or just mktemp(1)-it.

While 'mktemp' seems to be more portable than 'flock', it doesn't seem
to be portable enough; at least it's not in POSIX.

And in general I'd prefer deterministic trash directory names.  If I
re-run a failed test after fixing the bug, then currently the trash
directory will be overwritten, and that's good.  With 'mktemp's junk
in the trash direcory's name it won't be overwritten, and if my bugfix
doesn't work, then I'll start accumulating trash directories and won't
even know which one is from the last run.

