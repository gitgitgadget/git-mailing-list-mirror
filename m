Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B48220357
	for <e@80x24.org>; Wed, 12 Jul 2017 21:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754074AbdGLV31 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:29:27 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:32879 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLV30 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:29:26 -0400
Received: by mail-pf0-f194.google.com with SMTP id e199so4623674pfh.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4CNV/hmSNmMxXreNss9vhFtPUvhpXBuSrrVHrRsdGSc=;
        b=bXiFtnFFshphcqJfvIlrPgyqAQSOL4XJK8W2XjCgX6lAdBRIJpZ1IDvsBEf0+3c64c
         kkw7r1GilC0hTcGSwO1roP+vW3fhAVr6fcnL7rJMJ/izwqfLRYdr1DhO+WgUznJFh9im
         s8nZwxSaeeN2RJ9k+eVEOOfFDElbSn8cq1IqKC+++8az3NTVgmaaC5b/CdgPZxIRJ2ZV
         ywnQQBtUH8fKAt2sl4RkFGeHn9Berga0VuEEpU7Ido+WkhTfF+nbGZg237HgVZqHDIj7
         b5cSi3TVIptrBgbraPFl/rV5mV6Ipr6SwKg116Dffi0R6XyPNYlNEZpMsPbKeQp1aCIm
         PlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4CNV/hmSNmMxXreNss9vhFtPUvhpXBuSrrVHrRsdGSc=;
        b=RHbWuKoYjA1troUrLtX7hHfhOm0yOPie0+2zr4/PZQ9AdXmYUmg/jg9YV5UrcuRbty
         yfr5hUbDuS8BlhcMx/EGIbdyrJhg2d75yge0PU1sSdgHJ90MULo2AtUpRusQG99bXKa6
         IKe1kIdxQNkwO9tAGei8sP/145P4zGE49wpepOx3/+XJAVS1Hn3+ZRgDfBnVHl7acrNM
         4ZpAZEH/1e6syFLJjyHGGtcY8XXCWgceZdUj59vqKCMhLN6jltVOt0cxAKb43hfDrc0Q
         XOZv3PMictnzh6STEwcB9OU3R9PpyQJAabFPhyOCkgfOGH4qj/UyL1WNoYgUbQ0AeSG+
         TtBw==
X-Gm-Message-State: AIVw110Oj5Bmq/f3FW4A3VL2O8VHxVVD8IVb8b72nbwtrcdkrHdNXe8c
        w7P8o8QznsQdCw==
X-Received: by 10.84.231.194 with SMTP id g2mr6424986pln.5.1499894965260;
        Wed, 12 Jul 2017 14:29:25 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:8c0d:cddc:dbb9:7a95])
        by smtp.gmail.com with ESMTPSA id x85sm7403833pff.92.2017.07.12.14.29.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 14:29:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     William Duclot <william.duclot@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for inexperienced users
References: <20170709202520.21739-1-william.duclot@gmail.com>
        <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>
        <20170710183101.GA13122@Haydn>
Date:   Wed, 12 Jul 2017 14:29:23 -0700
In-Reply-To: <20170710183101.GA13122@Haydn> (William Duclot's message of "Mon,
        10 Jul 2017 20:31:01 +0200")
Message-ID: <xmqq4luh1gzw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Duclot <william.duclot@gmail.com> writes:

>>  - The original said "When you have resolved this problem", without
>>    giving a guidance how to resolve, and without saying what the
>>    problem is.  The updated one says "conflict" to clarify the
>>    "problem", and suggests "git add" as the tool to use after a
>>    manual resolition.  
>> 
>>    Modulo that there are cases where "git rm" is the right tool, the
>>    updated one is strict improvement.
>
> I also wrote "<conflicted_file>" when there could be several. Maybe
> 'mark it as resolved with "git add/rm"' would be a better (and shorter)
> formulation?

Another potential source of confusion is if we are seeing "a"
conflict, or multiple ones.  I'd say it is OK to treat the whole
thing as "a conflict" that Git needs help with by the user editing
multiple files and using multiple "git add" or "git rm".  So "mark
it as resolved with 'git add/rm'" is fine, I would think, but
anything that I say about UI's understandability to new people needs
to be taken with a large grain of salt ;-).

> ... I feel like a lot of git messages could be improved this way
> to offer a UI more welcoming to inexperienced user (which is a
> *broad* segment of users). But I am not aware of the cost of
> translation of this kind of patch: would several patches like this
> one be welcomed?

Surely, as long as I can depend on other reviewers who are more
passionate about end-user experience than I am, I'll take such
patches with their help.

Thanks.
