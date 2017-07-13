Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AB42202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752760AbdGMTKn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:10:43 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35068 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdGMTKm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:10:42 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so33845116pfk.2
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=goqOwd1OJYX9KauF7i13Shp6qWmtJYnKkFSvHkX+/ck=;
        b=j5v48fFQNGv5XvgAHfgMB+/y5fDUSIOuwaoR2h7szCTotOgE1q9WIfCnTTPoS+bhTD
         ftNOsM7rTlNU5ip+BIPkSipzhKlSC+UGrYhAdhtXEjozwVCKyi0lSpaXzmmrBB44COBD
         Tnx62zk7J1BNkCDe2nqeNmCl/An0jMz/uvxywJQGcQheK9nrFpwmnxmhWoTkXOrntLMi
         yIZITUb01/b9OOIUdGCBTTmnWJfhRJ0wfFczXgPysxL5Zkt6b8jpsje5LVD1tiPlpX4M
         UhhfP9kfYOjN3AKdzJeqLCBCm5ow50RtZVHbJI+U005g6y5I8f1M68IVDZOfEN3+V1FY
         ksHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=goqOwd1OJYX9KauF7i13Shp6qWmtJYnKkFSvHkX+/ck=;
        b=F8x2zN5BWAjGpjOKP5cPCHcMAi1O5puOohO6ebAb15QplejIn2va0XhkuXohAsl+lg
         A7FsH84J9EEoN3vZvROH+4dDazoswNMNE0wc/enGsf8rWcChEesdy2oAXLBS6JFMu+eK
         7n4AYlF0RIPCSGkoI51yv71bNUZD/DgVVL6J7nupckt5sKW5HVPxtnDMRXS1ODQaf21J
         5vJnrQpxrIn38EItmUlHiuMMY6/9V2GI1U77DqdXFz8do7owlMUzqqlj5e3ZJdOorHfm
         KMZ1+CdY3sqjzsbvLUPFLGQUb1NlZPxMXh+ZER85awaF8E91Zgl8Z+n6cZPokL9rDh0P
         NlCA==
X-Gm-Message-State: AIVw112k10rHtLSkXNXhIfhetowkR6KySrAQHSJ/7FN1zwdIYTGBu6kH
        eUw2qBsxDbjvLA==
X-Received: by 10.99.104.74 with SMTP id d71mr10509439pgc.7.1499973041237;
        Thu, 13 Jul 2017 12:10:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id q19sm15627207pfd.24.2017.07.13.12.10.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:10:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2017, #03; Mon, 10)
References: <xmqqlgnv52oq.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1707131435220.4193@virtualbox>
        <xmqqzic8xsxd.fsf@gitster.mtv.corp.google.com>
        <20170713155313.whucxkoita6nvmhz@sigill.intra.peff.net>
        <xmqqvamwxm1y.fsf@gitster.mtv.corp.google.com>
        <20170713181350.tb6gndxc66ewpggj@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 12:10:39 -0700
In-Reply-To: <20170713181350.tb6gndxc66ewpggj@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 14:13:50 -0400")
Message-ID: <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> [1] Another sticking point is that this really does need to be in the
>     reflog of the ref we are pushing (and not, e.g., HEAD). But one does
>     not always push from a ref. I suspect that's OK in practice, though.
>     If you are doing "git push --force-with-lease HEAD~2:master", it is
>     probably OK for us to error out with "uh, lease from what?".

I actually expect this to bite me personally, as I often do not
rewind the actual "topic" ref that is my target of rewriting,
because I am a chicken---I detach the HEAD and build a history there
to see if I can come up with a better history, compare the result
with what is on the "topic" (which is not touched at all during the
rewriting), and after all is done, do a "checkout -B topic".  The
"remote tip must appear in the local reflog" rule will never be
satisfied.

>> I wonder if this could be a replacement for the current "the user
>> did not even specify what the expected current value is, so we
>> pretend as if the tip of the remote-tracking branch was given"
>> kludge.
>
> Yes, that is exactly what I was thinking of (and why I said that even
> though this really isn't force-with-lease in a strict sense, it slots
> into the same level of safety, so it might be worth using the name).
>
>> Instead,
>> 
>> 	git push --force-with-lease origin master
>> 	git push --force-with-lease origin topic:master
>> 	git push --force-with-lease origin HEAD:master
>> 
>> could
>> 
>>  (1) first learn where 'refs/heads/master' over there is at.  Call
>>      it X (it may be C or D in the earlier example).
>> 
>>  (2) locate from which ref the commit we are pushing out is taken;
>>      in the above examples, they are our refs/heads/master,
>>      refs/heads/topic, and HEAD, respectively.  Call it R.
>> 
>>  (3) see if the reflog of R has X.  If so do a --force push;
>>      otherwise fail.
>
> Yes, more or less. A few thoughts:
>
>   - that step 2 is where the "wait, that isn't even a ref" error above
>     would come in
>
>   - I suspect in the third example we probably ought to be using the
>     reflog of the branch that HEAD points to. You would not want:
>
>        $ git checkout advanced-branch $ git checkout older-branch $ git
>        push --force-with-lease origin HEAD:older-branch
>
>     to consider that commits in advanced-branch are part of the lease.

The third one was meant to be rewriting on detached HEAD, not having
any underlying branch.

>   - For step 3, I'm not sure if we you mean to look for exactly X, or
>     if it would be OK to have any commit whose ancestor is X. I think
>     you'd need the latter to accommodate a non-fast-forward "git pull"
>     (or fetch+merge) where the local ref is never set precisely to the
>     upstream commit.

But the result in that case is a descendant of upstream you just
merged, so you do not even want to use any form of forcing---you
would rather want to rely on the usual "push must fast-forward"
mechanism, no?
