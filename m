Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9543C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AAA206B6
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 23:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CISdd/aU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgKWX0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 18:26:51 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52616 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgKWX0u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 18:26:50 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77B9B10A79B;
        Mon, 23 Nov 2020 18:26:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2grFpeVibrmV0CTm1gLOhyoD5eU=; b=CISdd/
        aUnMfPaLvAsgSVMTikx6L6y1BYC0Dm1LW0WzMOUefhoKTmLoct2LJKMOYUlMjahD
        KRbV01X59OrsunI/P4Y78t0BrlqjTsYmIbDs7hq+7aa2MfRBTiyZLGUbOfxSa4rt
        17RovVnr03irtBMu6S2B3JUo7aVklA/L4/tAA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PjKxTaVNijBISZfQiQKUeWoURAqrFwMZ
        uco4MgYcX5t5mvWDdL6uzVbvqasBKZRyDznq4+zJH/t2+SyFha2GnFjN5Lf3HVL5
        dVSncsRSoa6COOy6PtCXnVY/Ygy+zw5zEdYZPyhcgcfbxfFFUe/Nz5+CDqo4gHlT
        XDB8HuZd01Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F84E10A79A;
        Mon, 23 Nov 2020 18:26:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B34D410A799;
        Mon, 23 Nov 2020 18:26:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
        <xmqq7dqbn1nl.fsf@gitster.c.googlers.com> <87im9vekzf.fsf@osv.gnss.ru>
Date:   Mon, 23 Nov 2020 15:26:43 -0800
In-Reply-To: <87im9vekzf.fsf@osv.gnss.ru> (Sergey Organov's message of "Tue,
        24 Nov 2020 02:01:24 +0300")
Message-ID: <xmqqr1ojlkng.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5A1B4EB6-2DE3-11EB-86E8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

>> But do we need to say "a separate line of development", instead of
>> just "a line of development"?  What is "a line of development" that
>> is not separate?  What extra pieces of information are we trying to
>> convey by having the word "separate" there?
>
> I think it tries to convey a notion that 2 branches represent separate
> lines of development. I.e., that the whole purpose of branching is to
> provide support for independent, or parallel, or /separate/ lines of
> development.

So in the context of talking about a branch, there is no need to say
"a separate line".  It only starts making sense to use the word
"separate" whey you say "this is a line of development.  By the way,
there is another line of development that is separate from the first
one".

> I'm not going to insist on the exact wording though, -- just wanted to
> bring attention to the issue, and "separate" was somehow the first word
> that came to mind when I edited the text.
>
> As an after-thought, I'd probably add that branch in Git is represented
> by a chain of commits, and then I'd refer to most recent commit of the
> chain, instead of most recent commit on the branch. That'd make
> definition more formal and precise. Makes sense?

It brings up a more serious issue, though.  

         o---o---o---o---x A
        /             \
    ---o---o---o---o---o---o---y B

The only thing everybody can agree on in the above history is that
commit 'x' is at the tip of the branch A, and commit 'y' is at the
tip of the branch B, and 'y^' is on the branch B.  There is no good
answer to questions like

  where does branch 'A' begin?
  where does branch 'B' begin?

Perhaps the merge to 'B' was from another branch that no longer
exists (because the whole 4-commit chain was merged at that point to
the integration branch 'B'), and 'A' was forked from that branch
whose name was forgotten.

Any commit in the history represents a line of development behind
that commit, and whether a commit is pointed at by a ref does not
change that.  And development is not even a line when you include
forking and merging.

In the mental model of Git about branches, I think the only one
thing people can agree on is that a branch points at a commit, and
checking it out and making a commit on top of it will change that
branch to point at the newly created commit.  And this view supports
the word "separate"---whether you have two branches pointing at the
same commit or a different one, building a new commit on and
advancing the tip of one branch does not affect the other branch.

Come to think of it, the original "active" may not have been so bad
a word to begin with.  It is misleading in the sense that "active"
used in the original statement does not mean "currently checked
out", but if we read it as "potentially active---can grow in its own
direction", it does convey that each branch can (although does not
have to) represent its own line of development.

So, I dunno.  I'd say just settling on the simplest "is a line of
development" would be the easiest path for now.


