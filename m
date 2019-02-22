Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E83C420248
	for <e@80x24.org>; Fri, 22 Feb 2019 17:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfBVRjI (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 12:39:08 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36777 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfBVRjH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 12:39:07 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so2721008wmj.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 09:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3LUtDZWr2yGTiPDDNqYCN6T4uCW+X6Ad0op2Ic3wDiE=;
        b=msdj1ZXXOH1vbnklyIdmIiJeXesc1sCY+loOhi8qQooq+8Ml9EMo+taI/ovtLJbTEI
         Mjn3cuS3uMZTn9VH5P25q2mNuPI7Nu0GhKL60FEcWGsQhKdHged8owvGDUhVhpmNw4om
         r+DMiqPu+30+bYfsLXPZHeoDrWPLEmb6kX+6Zprf4+v+qbV6pXVtdnZ2NjECUCkL4D65
         KLGJDvJVCiJ2rN3hKMfk6DB8Oa/XU6K3wFIr5tHtktTm+5GCB2mCcvDBabQ3CbGrmt9N
         Yx4/ra4iloZkpKgOFSSszKlY9w6IWtBeBnwAsVXFM7IjyjImw5qrtbfYvqA/wqPc2uIH
         /kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3LUtDZWr2yGTiPDDNqYCN6T4uCW+X6Ad0op2Ic3wDiE=;
        b=AY7nB6ohP1oXMPGaxPVkcEt9HW6wKZcRsDQq/K3pexXSapE10mplQpQhYoUb+NzpcV
         wV822Iy5A1w8L6YubfJ3GGKU7+o+L7O82nJQGuMq+l9W2ABhfL1POOmBo9huhCOuPTZ0
         wR3ksNORF5RYg98P6BtcETLHcAZk1ewd/wswMoqPT9gbm7MXTsNfwRkjGgVEPWZdXp6u
         50ROEjIAwmO+dozNwoQzxgRPlFI0Uy4kJMGFtZbn3UP7Dtm2xUwAUbSOccId1Xse71mG
         oMrZPUdSeqnOmEOZrFscdap5QH/AKEQElYx/5fv9PecxAHi/IEL0cAGw7nISWnENGg7M
         PG1A==
X-Gm-Message-State: AHQUAuY47WimP/ftoMmSpla/pZnIbGNq2Kw2D2a0wNsfzSjtHNSFL6Ct
        4TOb+I9nBRRpfHd2JPN7oBY=
X-Google-Smtp-Source: AHgI3Ib02ckrfrykuycc0GIH0nEKHBpGzj4CIe7hRuaDcHoyN6rIjZXSs0I7KCSLxgQVyA+XR64I8g==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr3064699wmb.48.1550857144920;
        Fri, 22 Feb 2019 09:39:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u12sm2117045wmf.44.2019.02.22.09.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:39:04 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Bartosz Baranowski <bbaranow@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] prettier bisect output
References: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
        <xmqq1s40u8gt.fsf@gitster-ct.c.googlers.com>
        <20190222061949.GA9875@sigill.intra.peff.net>
Date:   Fri, 22 Feb 2019 09:39:03 -0800
In-Reply-To: <20190222061949.GA9875@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 22 Feb 2019 01:19:49 -0500")
Message-ID: <xmqqwolrradk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I've run across this many times, too. Since it's been bugging me for a
> decade, I thought I'd finally try to address it. Here are some patches.
>
> There was some discussion about a year ago about just using "git show"
> for this output:
>
>   https://public-inbox.org/git/CAP8UFD3QhTUj+j3vBGrm0sTQ2dSOLS-m2_PwFj6DZS4VZHKRTQ@mail.gmail.com/
>
> Christian seemed generally OK with tweaking the output, but preferred
> not to move all the way to running an external "git show". I'm not sure
> I completely agree, but it was easy enough to get the results I wanted
> just by fiddling the current code a bit. ;)
>
>   [1/3]: bisect: use string arguments to feed internal diff-tree
>   [2/3]: bisect: fix internal diff-tree config loading
>   [3/3]: bisect: make diff-tree output prettier
>
>  bisect.c                    | 19 +++++--------------
>  t/t6030-bisect-porcelain.sh |  6 +++---
>  2 files changed, 8 insertions(+), 17 deletions(-)

Looks good from a quick glance.

One unrelated thing that made me curious was that the output from

	git grep 'is the first '

had these two lines:

bisect.c:		printf("%s is the first %s commit\n", oid_to_hex(bisect_rev),
git-bisect.sh:		if sane_grep "is the first $TERM_BAD commit" "$GIT_DIR/BISECT_RUN" >/dev/null

which means that we cannot localize this message without thought,
unlike the usual "hey, this is end-user facing, so wrap it in _()
out of spinal reflex."

