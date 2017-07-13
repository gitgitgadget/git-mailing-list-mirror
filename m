Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C90DD1FA4D
	for <e@80x24.org>; Thu, 13 Jul 2017 20:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbdGMUSt (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jul 2017 16:18:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34011 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752745AbdGMUSs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2017 16:18:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id j186so8068779pge.1
        for <git@vger.kernel.org>; Thu, 13 Jul 2017 13:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V9LJFFAX8P1AGJ8Whc6/7Wt2ZV+u/5+TLHooEm7zl3c=;
        b=bRu5Bpz+SbNYeevhgGNhkHi8e1RSvO5Oi1E6eJqApFo3vTwu+Helk1+ENKoLdcit2w
         Giei9sRSMj3m2zBL44c6sXRaUKlX27WGzEn3hu/cB5oe6YHFQSQlK2gHwUDinSDWWUNl
         TPJqwbMU7bHX244QXmDb/IfqnOs/6blivuMyysTZ2iuCWOJBGklHjbTydtIb7prYREji
         l3Ry3ogvwkdGNUoJUplKd3J4SlDH3jiyvaoAiy1zh7kD7qiKcVhC2pgZApB5fNoMHy2u
         h6u1FKIpXx8ii/GIQE6slJrYVABMg9GoaYYFikjbQBWNRyq7+cHSPvUY/BV/b1OGqIBi
         FdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V9LJFFAX8P1AGJ8Whc6/7Wt2ZV+u/5+TLHooEm7zl3c=;
        b=HsuTOnnSQJYST4HAdMnS77i68bR/QnVRUfhAKv/4bFb4AnM7VA2XXxKuTRDkkzpi9i
         WhxxaYhzq3WKsC5GEpuYO4XkTPt4IQwd4Mk03i0fxECJk16v8vh0NJQ0qzE1k4sOQg10
         6CwH8yM7l1D+zOfNnIzc28XPQ0dcIJOlh3ONxfduMzuow8L9N0xh0FIsm8tGui+terce
         HQv0GZOXXs3xy3+5JzmfH+Qhe6Lpvlk6x5Is5+PfWgSLi9cFo1rcLsAlaMITBpktNrwU
         AJJA7tIPLRLZ7pBp8r6q8lLIeLFLBZdi8esAMBSattXjd4oWHuUHr8iK600PigK5OYv4
         myaQ==
X-Gm-Message-State: AIVw110j+k+RtJvy/XGMd62hLnQNUyfQvQWF/H+lfZE7HU/2LsYCRhrT
        HQi0+Glz4gKieA==
X-Received: by 10.84.229.7 with SMTP id b7mr12057469plk.216.1499977127730;
        Thu, 13 Jul 2017 13:18:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3079:9e61:8883:4f9c])
        by smtp.gmail.com with ESMTPSA id k19sm14011927pfk.16.2017.07.13.13.18.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Jul 2017 13:18:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 03/15] t: use test_decode_color rather than literal ANSI codes
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
        <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
Date:   Thu, 13 Jul 2017 13:18:46 -0700
In-Reply-To: <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 13 Jul 2017 10:58:41 -0400")
Message-ID: <xmqqshi0um3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we put literal ANSI terminal codes into our test
> scripts, it makes diffs on those scripts hard to read (the
> colors may be indistinguishable from diff coloring, or in
> the case of a reset, may not be visible at all).
>
> Some scripts get around this by including human-readable
> names and converting to literal codes with a git-config
> hack. This makes the actual code diffs look OK, but test_cmp
> output suffers from the same problem.
>
> Let's use test_decode_color instead, which turns the codes
> into obvious text tags.

Nice.  Thanks.

