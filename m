Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E23351F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbeHNARv (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:17:51 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45859 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729835AbeHNARv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:17:51 -0400
Received: by mail-wr1-f47.google.com with SMTP id f12-v6so15433285wrv.12
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=betpo/6gyRI8FfpI+4nTGTaP12OwIwRwWQjsAlWwGIc=;
        b=KXio9jgU86srtjLjFRlSWRlLJxtUWLbJRDaDim9i5FPIryZ2YZaimiDkMeBBpsQ3fX
         MsXbp6vv06mOSkJA1fFMnHELnc2RTSSozzYfnyZo0Gbwcl4JX+Q8fRox0WL8Vxc0XYIK
         N7tZ/LluHnHPLIv7wytdQxUpP6McDZhn4h52CRufIvyJn8z5Y7ywMoAyXP6/tmMgZOP/
         nmqhcGYqIB13vjHVx7hcvzT8h7VH7d6UxozL/H2dLxpZGJwGIKULJn/Au418rvbq5kam
         zxb05wfxE3kXypOw6BZS7UAnrd4zYSiMNXuL2BwCTuiTEdU/qpN2p/z/DwK28im2rITS
         S0WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=betpo/6gyRI8FfpI+4nTGTaP12OwIwRwWQjsAlWwGIc=;
        b=gx/NN0pUq2QA1nvmofMoXQGPeTJ5/k4iMKGeu+S2wMiueBcnFIPgRKrP2od9d4OMpl
         BrS40y7HVNPuf4GrSZTl4JjzW+5oWu/p6CciiC9C0RgsSkhPwgrjMYYF1sFgE46igHhi
         lRTgZegLxaI/dyPJDvm4Xebqp8QP6i+Pj+pT9BYQZaKDNPtlaTmVrkliOmF/zQIA8T+5
         P/YR9/tQkkQ3XAxpsxG8xPavnm+LU/ezWK6RoaublML7VxTkle0awa/SAZfMBtd9/EfC
         ulW2PLdcMt6LM7bR/kD1UTt2HzzYEkThi1p/OPtknqyUvFNrX/FcKGOr7L1YjkELOV3c
         t+RA==
X-Gm-Message-State: AOUpUlF7BF0ym1SP+Jpm2CW/UmgdRHSQSYQJr2iyvFvTOQIl08WUKCcA
        Ehn9MO1PBo8XcbcAi3hV7pQ=
X-Google-Smtp-Source: AA+uWPz5LXFx8aW7jC04Axio1l50vL0Xs0AhKfsAdLGsO4xW1+lZ2jrbCEifvao7B9aQaUBUoOnGQg==
X-Received: by 2002:a5d:470e:: with SMTP id y14-v6mr12032268wrq.229.1534196029452;
        Mon, 13 Aug 2018 14:33:49 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q2-v6sm7377969wmc.44.2018.08.13.14.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 14:33:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: wishlist: "--cached|--staged" to "git commit file(s)"
References: <20180813162236.GO732@hopa.kiewit.dartmouth.edu>
Date:   Mon, 13 Aug 2018 14:33:48 -0700
In-Reply-To: <20180813162236.GO732@hopa.kiewit.dartmouth.edu> (Yaroslav
        Halchenko's message of "Mon, 13 Aug 2018 12:22:36 -0400")
Message-ID: <xmqqva8e2bpf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> command.  ATM there is no non-interactive (via --patch/--interactive I
> think it is possible) way to commit selected subset of staged files not
> from the worktree (as it is done with "git commit file(s)") but from the
> index.

Hmph, so

	edit A B C
	git add A B
	edit A B C
	git commit --cached B

would create a commit that is different from the original HEAD by
the edit to file B you did in the first step, but not the edit to A
or C, or edit to B after you did "git add"?

That sounds like a useful feature.  If you do not need that "exclude
the later edit since the last 'git add'", you can do "git commit B",
but if you added crufts to B in the working tree since you added a
good copy of B to the index, that would not do what you want to do.

Sounds like a good starter project for somebody who wants to try to
get their hands dirty.  I think it is just the matter of updating
builtin/commit.c::prepare_index() where COMMIT_PARTIAL is handled,
skipping "(2) update the index with the given paths" when "--cached"
option is given, but doing everything else in that codepath.


