Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA4C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4B6206D7
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V11w5srK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgG2VZX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:25:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61083 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgG2VZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:25:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B589FF540A;
        Wed, 29 Jul 2020 17:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gxPHw1bBz1hw3iFJw4Ezwg2aKUw=; b=V11w5s
        rK8ySmK8qTgr1me+hoh7YULfR2xUc/jTJDcCO6b2/birlPKvmuoXzZmChJdOa7Th
        Mc94xZg6f6wRIi6SvcMM+rWYMc65+QjaHyMWazZ1IaWyheHHSHXDzl7KOYmbOmS1
        DYelRht0O/byBcjdwFrPFPKiXEt+WdsKyI8NE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PLUaU3LFUFO9baULwQUBUOEQIJr1JGGh
        CEg4yvPrAR4B7jD7ouHxolZNVCFGdzTYwhWeqgxNFfd2eNPR4eBmmUxLsXHSDvUM
        pZNPaOG1WQYfidvf7Nxyb7cdWT3sSH21tSHBCSgm6XJAgirZFZ1bYnIy8/GRMULJ
        yibfAx+J4p0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A782CF5409;
        Wed, 29 Jul 2020 17:25:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EBAB5F5408;
        Wed, 29 Jul 2020 17:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
        <xmqqime69jfc.fsf@gitster.c.googlers.com>
        <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
        <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
        <20200729205846.GA2992025@coredump.intra.peff.net>
Date:   Wed, 29 Jul 2020 14:25:17 -0700
In-Reply-To: <20200729205846.GA2992025@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 29 Jul 2020 16:58:46 -0400")
Message-ID: <xmqqv9i6814y.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0085BC72-D1E2-11EA-9106-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If I set init.defaultBranch, then that only sets the default branch name
> for new repositories I create with "git init". But I may still interact
> with many repositories that use a different name (either "master", or
> other names chosen by individual projects).

Yup, in a very early iteration, we had two such configuration.  The
name 'git init' uses when not told what branch name to use from the
command line, which became init.defaultBranchName, which does not
make sense in per-repo configuration.  The other is to specify which
branch to treat specifically in the repository for a very small
number of operations (namely, fmt-merge-msg and anonymization for
fast-export).  What we ended up was with a single configuration, not
treating just one single branch as special in an existing repository.

The fast-export side lifted the "single branch is special"; we
didn't do something similar for "fmt-merge-msg".

> So I think a path forward is more like:
>
>   1. Add a new config option to shorten fmt-merge-msg's output when the
>      destination branch matches it (and this should perhaps not even be
>      a single name, but a set of globs, which supports more workflows).
>      Call it merge.suppressDest or something.
>
>   2. Optionally a repository created with "git init" could copy its
>      init.defaultBranch into merge.suppressDest. And likewise a clone
>      might copy the remote HEAD into that variable. I'm not sure if that
>      is worth doing or not, but it would restore the original behavior
>      for the most part.

Yeah, that sounds like a good plan.
