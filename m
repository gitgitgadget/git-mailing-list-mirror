Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F7C202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 17:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbdGMRvZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 13:51:25 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36269 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdGMRvY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 13:51:24 -0400
Received: by mail-pg0-f67.google.com with SMTP id y129so7733757pgy.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 10:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EFFtlAcD2A2DlOsXs9D+oAyPPXwyA9Y1S87lvuaYmB0=;
        b=tu3cyyKQ8mvmIctMBCpjWpIRTDvAGHvLC2EL5docJsWzzxwYs7mHj7STtIgFl0r/fM
         jy7nos/+7oAoBnRBCEWHCRp+cHxDoFB4yajdrvQ3DeI56X8ZDLq/F1jmar+pcbdpoT1y
         RODZO9M3cO3b5lJXt8gP0rX7q6uYpyvw/1FyfeZdyNOuVsPWRfBmX5+vIJ0C+aKgtB61
         I7Z/XC0Q9kmYUrA/uBkSUng6BusrDUzmDP+KpDIyFfaZRzkNVIZiyfiya7zs9nifZPH8
         SZiZpe5fLHjfAwA2VuThKy11+uC8pqOT+K33CB0xxs8U4dVn610LeZlDvdY5XxEZv2Jp
         mmBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EFFtlAcD2A2DlOsXs9D+oAyPPXwyA9Y1S87lvuaYmB0=;
        b=kpZdC/OE4dYPmWLSi/d4UFDLjGQS3iETgHE2a9dmuDI+NtsuDT6vituqYcllycmVUB
         BZXjARM1UWY+avVC6P3CwNQD3tIR1FAlO9jP2NF0vszv31WtwdBkvox+lfYsnkBEIsCz
         KgSdupWlsDSD2SSbCnXYYP2AhpflfzEAl6G9m6EHI6R8CrjVeH9dgtT6S2rdIetdTMzh
         WC0h8fD31g6XBqXhIldYgFc4XPFu1aye0r+FDsINOD+UbsxlIsF7BLurvMNnck+hqtb4
         ijo/u4EqENBd+e8xsL87Dwu9/o1lehYJSXheu6wLjw+8mjJYXXEnT9tQ+rNsTHIOAENH
         coMg==
X-Gm-Message-State: AIVw110cFdA8d+G/1AyAdgHIe90xy71o7EGJ0Nf6T3nmTcXIXbW+vNUc
        ZvEnVXDXZWPgvQ==
X-Received: by 10.84.232.198 with SMTP id x6mr11309924plm.139.1499968283131;
        Thu, 13 Jul 2017 10:51:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id t70sm14646014pfk.111.2017.07.13.10.51.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 10:51:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
        <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
        <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 10:51:21 -0700
In-Reply-To: <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 11:53:13 -0400")
Message-ID: <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do think Dscho is on to something with the "see if it was ever in our
> reflog" idea.

Yes, I found the idea was interesting when I responded with the
"thinking aloud", and I still do think it has some uses elsewhere,
even if not in "pull --rebase" workflow.

> What you really want as a default for force-with-lease is
> some way to say "I want to change that ref from X to Y, but only for
> values of X that I know Y has already considered and incorporated".

Correct.

> But imagine force-with-lease rule were more like: when pushing
> branch "foo" to remote branch "bar", allow only if the current value of
> "bar" is an ancestor of some entry in the reflog of "foo".

Would that cover the case that originally motivated the "with lease"
thing?  Let's see.

          BC            "foo"
         /
    o---A---B---C       "bar"

You are pushing back to "bar" that still has C (or it may have
acquired D) from "foo" that is now at BC.  It is likely that you
started to prepare the "A---BC" history from "A---B---C" history, in
which case your current branch "foo" that is being pushed out would
have had C at its tip some time in the past.  So seeing that the tip
of the remote is still C, which is in the reflog of "foo", we can
happily push it out.  If the tip of the remote "bar" is now D
because somebody updated it, you did not consider it while preparing
your BC, and we want to fail the push---because D does not appear in
the reflog of "foo", that is achieved.

> That degrades to the usual fast-forward rule if you just check the ref
> tip.  And when checking the reflog entries, it shows that at some point
> you had your local branch set to something that covered all of the
> destination, but then later rewound or rewrote history. We don't have to
> care what that operation was. "rebase" is a likely one, but "git reset
> --hard HEAD^ && git push" would fall out naturally from the same rule.
>
> It's not quite as safe as a true force-with-lease with a value would be.

All correct.

I wonder if this could be a replacement for the current "the user
did not even specify what the expected current value is, so we
pretend as if the tip of the remote-tracking branch was given"
kludge.  Instead, 

	git push --force-with-lease origin master
	git push --force-with-lease origin topic:master
	git push --force-with-lease origin HEAD:master

could

 (1) first learn where 'refs/heads/master' over there is at.  Call
     it X (it may be C or D in the earlier example).

 (2) locate from which ref the commit we are pushing out is taken;
     in the above examples, they are our refs/heads/master,
     refs/heads/topic, and HEAD, respectively.  Call it R.

 (3) see if the reflog of R has X.  If so do a --force push;
     otherwise fail.

With such an update, I suspect that it would become a lot safer than
relying on the stability of the remote tracking branch, which is
what the current code does.

As you said, this is not as safe as a true "the user knows and tells
what commit was considered" force-with-lease, but can be a lot safer
and can become a replacement for the current "the user does not tell
and allows us to DWIM".

A good thing is that the DWIM is advertised like so:

    ... are still experimental and their semantics may change

so we are free to change it to any better version.  And I think
Dscho's idea could be that better one.

I am still somewhat reserved because in the above, I only
illustrated a case that would work better than the current one,
without trying hard to poke a hole at the reasoning and to come up
with cases that would work worse.  But I agree that this is on to
something good ;-)





    


