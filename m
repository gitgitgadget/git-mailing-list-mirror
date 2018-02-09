Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F192B1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 19:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752468AbeBITnm (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 14:43:42 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35081 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbeBITnl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 14:43:41 -0500
Received: by mail-wm0-f50.google.com with SMTP id r78so18336089wme.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 11:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=e5+20GQREv+P9rpdI/9Ow0VVkC99e916dzksshY/DbU=;
        b=B+S6pulmeGy/eP1BHzuSeyZ+GRfmDvrxf7sqhZyVlEG4J2jJ4HT97ME2JmcOdQ561s
         jOBNxUFrGtrJ1LzeKkOPOtnhtuDShmzXf6lnCOJh6/cs/6MxfrEkNWJFzjLd1V62jO54
         O5dTq7Yu9eS9scO75eq5dQ1HmuIss+CQNMuVs1kR9I4UTAN+uOD6I2n8kGIa1lFHq5kP
         /fVc7hEuOygU6NvxS1SH0H89uL9HRNgwMq7PEpDJqWtWuDIFziRoMqw58ss74jrJ7t7s
         TzaFf+kkJfXiSOrRhKpoT9kd2pk4NDJoRn5R1lDdWmNg4epN7w27lsbhrKTfr82xM6Qe
         GB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=e5+20GQREv+P9rpdI/9Ow0VVkC99e916dzksshY/DbU=;
        b=OXqND1zTSUpiYm7RSjtywUNjoLFSk4xZ1oFaYGzqDTZkGIfLMZ7vsnglJLfhj74ud0
         kHaD6QZ+2xcd1N6JiS0KqkxydQjZvgPkAFKwz1odyWa5MiN1Hjrv3gjlXjlRdNE9C3ho
         Hm5SbrPFpBRrQ+HGoLEjHdEJJVJsPJkCy5E8Ki4k/Hq0WfI3vl41O3J6Sb33ndQwi3Mi
         dD61iVmIbRbXu5nrRkUaFh4+Gh/iKBZoDNrBokRaCR6EWAw8LbtHaYEejmbGnM8oA/Ia
         C32JfZCcDEzQuTTfKnT7EgK8lirANsdpjkIqk3q35fwmS7sK6kdx9EBy1TzSGKLkKOld
         kIOQ==
X-Gm-Message-State: APf1xPBClSom7k+6ChbZLJLOdlVAiiU9Br/msauh7Ut2EoBH1myXwYgT
        +hk/v0/Pq6MRr+9OnDUxTvRvF6iS
X-Google-Smtp-Source: AH8x226Ybc5D1d5dspVOwGoZwoGtVrvdDtNjk86k+RHKWqxLddhTPP9z9SqwekDmJfq7LXMdwpefbw==
X-Received: by 10.28.71.77 with SMTP id u74mr2911006wma.150.1518205420178;
        Fri, 09 Feb 2018 11:43:40 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c5sm53413wrb.63.2018.02.09.11.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 11:43:39 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: totally confused as to what "git bisect skip" is supposed to do
References: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain>
Date:   Fri, 09 Feb 2018 11:43:38 -0800
In-Reply-To: <alpine.LFD.2.21.1802091431360.10982@localhost.localdomain>
        (Robert P. J. Day's message of "Fri, 9 Feb 2018 14:36:28 -0500 (EST)")
Message-ID: <xmqqo9kyvthx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   i'm confused ... why, after skipping a good chunk in the interval
> [v4.13,v4.14], do i still have exactly 7300 revisions to bisect? what
> am i so hopelessly misunderstanding here?

Are you really "skipping" a chunk in the interval?

I thought that "git bisect skip" is a way for you to respond, when
"git bisect" gave you a commit to test, saying "sorry, I cannot test
that exact version, please offer me something else to test".  And
each time you say that, you are not narrowing the search space in
any way, so it is understandable that the numver of candidate bad
commits will not decrease.


