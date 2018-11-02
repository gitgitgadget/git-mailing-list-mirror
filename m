Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4462C1F454
	for <e@80x24.org>; Fri,  2 Nov 2018 05:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeKBO2n (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 10:28:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33731 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeKBO2m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 10:28:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id f19-v6so479000wmb.0
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 22:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2FDRHZQo8TE0zP5W22K2E3BjGfUovz1WYwoFCK62L+8=;
        b=R3gm+6LMdssF+BVd2gTXRVXfYmgFaPXls5Ux/VdDkBiDE+RSLmcZR79pjvFjpATorY
         ROj7yX3YloqTQ1Yfen4AUD94g4GCOsj+teqghy7bALOpq+R3XWR0AxohbvRoykjlFZHt
         inTfHyWE4t3+q4oFjqg50NmfvGKOghmpR7Bv6e6TVnd9rbu7RgnIioh8KZ16s2EMT291
         Lg1T9zNA01OB0r0rF8Nn6zRCVwVEnZebOiwcENLnSGkq2cZ7uRHAig8IMlAy0eo73EGI
         W4TlDPTH9XDJIwgd+QKtLhebZ3qNXrDFS0OLk0TEV0XU8J6ZZuOE1gSOz5vfFMvEQ43k
         zwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2FDRHZQo8TE0zP5W22K2E3BjGfUovz1WYwoFCK62L+8=;
        b=jP7Bzs/cRBj2F1/Ee/D5GbqPFQWAI7znre863A8VWdOv2dD47TZ03kLkLIhiEEpC1q
         dBO9mr+kfn2pTEpL6H8ad8A11LDipANHT3p5mBCs0W6OqCj93iyIqhjySlVbUI2Mkezw
         WzJ+uSy9SgWBXNwjKecTdzeyxnJs8nSLDzVdDHBTBXF+hA0m+wKOSDZoTQV8LkhOkrpm
         KoqsrKjUqa0f8j0dW5rVB3XxyDKoT+/euulCoZMT7dPefp1cjYAP55Jn3aA9sRVb2EBF
         W3ge3LWeis+SSFE0JPWQFEpyPnheUXGqvhjQiZIxllRrQaeE92vRkTG03ObDT9LXKBQW
         HZ+Q==
X-Gm-Message-State: AGRZ1gKx1npuS5XwEIaiz+cnt0gldYTA/12Mft4QP/M249AKfvuxiRhH
        EqchPlCeMnaGy4gjU3lTq8I=
X-Google-Smtp-Source: AJdET5fLU/xP+nYxAsJ5d9Mr5SMnG9R4LXfJCq9LC/xCJiAg3sYgISCKe3X+k75zLvyOBRQV0rsYNA==
X-Received: by 2002:a1c:d4b:: with SMTP id 72-v6mr156721wmn.102.1541136167310;
        Thu, 01 Nov 2018 22:22:47 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l70-v6sm56809799wma.0.2018.11.01.22.22.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 22:22:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Slavica Djukic <slavicadj.ip2018@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        slawica92@hotmail.com
Subject: Re: [PATCH 2/3] [Outreachy] ident: introduce set_fallback_ident() function
References: <20181101115546.13516-1-slawica92@hotmail.com>
        <20181101120029.13992-1-slawica92@hotmail.com>
        <xmqqwopwqj2g.fsf@gitster-ct.c.googlers.com>
        <xmqqh8h0qefq.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 02 Nov 2018 14:22:45 +0900
In-Reply-To: <xmqqh8h0qefq.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 02 Nov 2018 13:41:13 +0900")
Message-ID: <xmqqtvl0oxy2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> As we currently have no idea when builtin/stash.c becomes ready for
> 'next', how about doing something like this instead, in order to
> help end-users without waiting in the meantime?  The fix can be
> picked up and ported when the C rewrite is updated, of course.

I think a better approach to fix the current C version, assuming
that a reroll won't change the structure of the code too much and
keeps using commit_tree() to synthesize the stash entries, would be
to teach commit_tree() -> commit_tree_extended() codepath to take
commiter identity just like it takes author identity.  Then inside
builtin/stash.c, we can choose what committer and author identity to
pass without having commit_tree_extended() ask for identity with the
STRICT option.  Right now, commit_tree() does not have a good way,
other than somehow lying to git_author/committer_info(), to record a
commit created under an arbitrary identity, which would be fixed
with such an approach and will help callers with similar needs in
the future.




