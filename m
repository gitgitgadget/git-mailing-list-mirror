Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2A6F20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 03:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbeLMDB2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 22:01:28 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46445 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMDB2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 22:01:28 -0500
Received: by mail-wr1-f53.google.com with SMTP id l9so405749wrt.13
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 19:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uRqGJ9+vK6ucQMPlcCI8cqLwCnNDd7CmVHK0pJuF5j4=;
        b=h2LFQ8xQMfja7LOsb7oExlgLq7+jOxtRcjVIGD01JwShUFE4tVyvJlugxEVIIiFY6D
         iBLHi7ehYrQPtmc/nyjRpfz9rHW3WHE8MwXlBYDcaEZ9aq1teIsx4xlhxTz2bImS6xqA
         gjvPO4RWHLXa/ajxzJU4/o7f8vT5VUV/+Um8iVsiwhzbVU7lfpPjT1Zbq5+907MUUkYG
         8l/UF3Fma0BJc0zZrZ7wUff+URRiW4HLqq24oIimSVxKZY+WhNabWnuj595ouftSTKYu
         mtxiNLpnXoDP1UknN7Mz07u3KNCglm5KX1I/cQbNKqCxO3UEw6o/c2U2aEzUPJO8+D+H
         9ZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uRqGJ9+vK6ucQMPlcCI8cqLwCnNDd7CmVHK0pJuF5j4=;
        b=Xd+rD22P4Uctn4fZqoGEjAh7oR/jdmblqB0+Kgqr7cwpfkol5REwQRpPwJN30sjXfF
         IUZ1JGNEb9eBvGRQsxdKfXwYLtX2dap2csZy1EgIIHC0oxLTVtSJZ+ggoTeMzi1lpidk
         I7uzE342u1PpZqcciytGlw5F1WtHLc8mBYCpvvKCWfJQn4Myu4K9FfxRYDyoCz1vm+6K
         2pRggPbnNxya1Dm0/jNsLXWJmqrRpWr2DxBvfSRLfdpcuCa2EwcWzfN6eubStDa+mBoB
         tp4+IIlrNR+QNQMLCY/2PO/sXKC1s/M46dd2wF3yM48kKIamIc7OWFojj+YvsO4UzOIR
         aoFw==
X-Gm-Message-State: AA+aEWbeu3p/RNmJLhoJ7hdOc7hITBu2txiA6jzgznwy10KbrZjn1Sm1
        xSyvcpOlvfBe3aQ5c3fKPPU=
X-Google-Smtp-Source: AFSGD/Wlp4Ee1fR1fGJFzXxwTV6DFjSAWsyO4yNcTDPU4qMoqE/oRs2bo3ykIigDO5XozqTpjPTCfA==
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr20972463wrp.59.1544670086307;
        Wed, 12 Dec 2018 19:01:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a12sm541899wro.18.2018.12.12.19.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 19:01:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>, kernel-team@fb.com,
        Stefan Xenos <sxenos@google.com>
Subject: Re: [PATCHSET] git-reverse-trailer-xrefs: Reverse map cherry-picks and other cross-references
References: <20181211234909.2855638-1-tj@kernel.org>
        <xmqqo99rjjcu.fsf@gitster-ct.c.googlers.com>
        <20181212145456.GQ2509588@devbig004.ftw2.facebook.com>
Date:   Thu, 13 Dec 2018 12:01:25 +0900
In-Reply-To: <20181212145456.GQ2509588@devbig004.ftw2.facebook.com> (Tejun
        Heo's message of "Wed, 12 Dec 2018 06:54:56 -0800")
Message-ID: <xmqqefamgmey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tejun Heo <tj@kernel.org> writes:

>> allowed to be a bit stale and be completed immediately before it
>> gets used?  A totally different approach could be to record list of
>> commits, all commits behind which have been scanned for reverse
>> mapping, in the tip of the notes history, perhaps in the commit log
>> message (which is machine generated anyway).  Then, before you need
>> the up-to-date-to-the-last-second reverse mapping, you could run
>> 
>> 	git rev-list --all --not $these_tips_recorded
>
> Wouldn't it be more useful to have repo-updated-with-these-commits
> hook instead rather than putting more logic on note handling?
>
>> and scan the commits, just like you scan what you fetched.  And when
>> you update the reverse mapping notes tree, the commit to record that
>> notes update can record the tip of the above traversal.

I do not consider what you do in notes/xref-* "more logic on note
handling" in the sense that the logic is part of "notes" API.

The moment you decided to reserve one hierarchy in refs/notes/ and
designed what the mapping recorded there means, you designed a new
trailer-xrefs API.  It is a part of that API how blobs stored in
your refs/notes/xref-cherry-picks are formatted and what they mean.
It's the same thing---it is also part of your API how the log
message for recording commits in that hierarchy is formatted and
what it means.

> As long as we can keep the reverse rference notes consistent, wouldn't
> amend propagation just consume them?

Yes.  Would that mean you do not need the notes/xref-* series we are
seeing here, and instead (re)use what Stefan's series, which already
needs to have access to and record the information anyway, records?
