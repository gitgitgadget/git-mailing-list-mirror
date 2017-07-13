Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21B6F202AC
	for <e@80x24.org>; Thu, 13 Jul 2017 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752983AbdGMTjc (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 15:39:32 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33327 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752587AbdGMTjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 15:39:31 -0400
Received: by mail-pf0-f172.google.com with SMTP id e7so34167476pfk.0
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0gPdrd2T6J+z/o461OIR0CIXIZ1pe6f0VDm4GK38iq8=;
        b=WgHy8CiWceZipT/JO9a3cChBGpvG664JHE8Uc00hQNq45QZmF+BRaRJqjyyPtWYWzF
         74Iz1aPShl/vHPe/Kl7Xhj6c8u6hlkQiu9Aq35iMXOxzmq1CBu9pD4tR9im/Z1aiqBBc
         Hv9TszkHUF0Qu7abHoRviWPtulp3aG89MqKkkrXPnlpBqM8GsJZqRvBmQrD7foaC/88t
         1SkU11VRqu0wtjPAmj+obr1JdbXMXTlvGqmLuhJUd17nTCoAffW2HzrZbdsKHmmFlPok
         jXWrfzBmZ06aCa0EJ8W28f518OVt6/kUXMHK8c2T/5+lHIblm3ZJU2VDQ+I9XE6DghGy
         EbDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0gPdrd2T6J+z/o461OIR0CIXIZ1pe6f0VDm4GK38iq8=;
        b=LR51IBb/jtwRfXimmttNbRgVqOA69M2IuqNtewwUIj7/4bEUZiWnnlQwEPTzbKPzUk
         RTeFvoAEK7FdcukEzYa6jE1qZhlfdvz3EpABhBu1pDz6XAy0zGqymApeJEVDvzojZybR
         FyCHXWEuk5qVi9rv6D1vx2dbe0DbQboVBGblrtTukPN4RVqYbaIVRY5kgsJ0JX86xY9Z
         GYtVYHiwGwc0GmF3ubU6a1EFf+TGprIU6H78TXQ7NBPTBGEVagRVqz/BczRCoou/rZix
         Ig2NrpGqfw99SZyUTYJ/AmbPFbu83X8x2+0oY6q0y6W4HFx/AePrnC/8c05f8pBIpz9Z
         siXg==
X-Gm-Message-State: AIVw113ayE5Pw944R9m9XdyNvYTnHZ79Mekc5fgMVEPn6oaaJQ28W5Ld
        vPIEWkfRiAOf4g==
X-Received: by 10.98.60.157 with SMTP id b29mr1236142pfk.170.1499974770997;
        Thu, 13 Jul 2017 12:39:30 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id 75sm12364777pfk.84.2017.07.13.12.39.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 12:39:30 -0700 (PDT)
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
        <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 13 Jul 2017 12:39:29 -0700
In-Reply-To: <xmqqvamww3tc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 13 Jul 2017 12:10:39 -0700")
Message-ID: <xmqq1spkw2ha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> [1] Another sticking point is that this really does need to be in the
>>     reflog of the ref we are pushing (and not, e.g., HEAD). But one does
>>     not always push from a ref. I suspect that's OK in practice, though.
>>     If you are doing "git push --force-with-lease HEAD~2:master", it is
>>     probably OK for us to error out with "uh, lease from what?".
>
> I actually expect this to bite me personally, as I often do not
> rewind the actual "topic" ref that is my target of rewriting,
> because I am a chicken---I detach the HEAD and build a history there
> to see if I can come up with a better history, compare the result
> with what is on the "topic" (which is not touched at all during the
> rewriting), and after all is done, do a "checkout -B topic".  The
> "remote tip must appear in the local reflog" rule will never be
> satisfied.

Well "bite" is not quite accurate, as I do not push to a repository
racing with others, and there is no reason for me to use --force
with lease.  I always push '+pu', and push '+next" once after each
release, and there is no need for any lease when I push things out.

But if I were collaborating with others in another project that uses
a shared central repository workflow, and if I were in the mood to
see how well/better this "improved safer DWIM" mode behaves, then it
would bite me.

