Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D1A1F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753223AbeDBR5u (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:57:50 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:45454 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752920AbeDBR5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:57:49 -0400
Received: by mail-wr0-f177.google.com with SMTP id u11so14892886wri.12
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m8KDIbhYsQDZq/SkkcUpecIN942n7XcnYs0TzHGKRNw=;
        b=nIGaZfJ+cfnnu+K69oycLBBGEeQDYkLuCftas0IYjq4jaINSKTPEg0G7uLr5joWKHc
         PZf5q7WL8bYCDn0C+pNwf3X/1Z24v2kdPiCfIifuRaJW+rvHD18DUM0YtuVANvBhkGqz
         nLBbQ8KAyQ5kLPtiy5nuxs+6KdFzBFzyWauf20cASjTkl5PD8dU2L3S6CGCx2vvOrGQG
         Pu5VPRE0J+hNMWjS1ttOXsvlbkGelckwKt7bSC0WXlUHcJuNEb7mrWu0Qa3FE5qTshqK
         j/nMyjRH5+5zowyA7p0XE8cj7AItCSkPyw8K2wYAPI58JdzeEtt6N17vKo2eiUvRwJFx
         w1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m8KDIbhYsQDZq/SkkcUpecIN942n7XcnYs0TzHGKRNw=;
        b=UWSeRHRduyUxnmObgvcYpCBjvjrU1O4RudIMjXgEuE+BXvhVLblQipX169oZeQUn1H
         BKlqy5Um3huCxrywgYZNCZgJ0xS8OYCkv3uqG6n9zgl5GC6vQykb+xz1ARTu9ekIO3N3
         D+2jMjN2NlEaADdHRvmFdofJiTDZRj1wtqtqWEBfIzFuyiAuZ7ssSzssrdgPKjysgyrN
         UH7IuQjGDCsJSHfxc3WD+Fd1P/tZK+fxaUJTRCxF1SDhZqikRLn5Ev+RsEqrV/olmGsZ
         tLHf2+ndjvL4++pGo1rEs7mJl2qz1JN8SBqPCL3iss2kw42A5cNn1ghNpZQHYYBTD9G6
         bNKw==
X-Gm-Message-State: AElRT7Eu+Eypn+9TdFjLnjQiKy1W/R//SdNwBJwRb8TH9mQi8csbRH9l
        mq7vcSQXnaoh3tcELgLXjaE=
X-Google-Smtp-Source: AIpwx4+cov6CnETMaLf8I8g2Z5/OxX4aM+C6ibvjB18S9DQo32Ljx+OKUgck6w4uEluRS8ZYr82uOA==
X-Received: by 10.223.225.76 with SMTP id f12mr7133584wri.128.1522691867862;
        Mon, 02 Apr 2018 10:57:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 140sm832770wmy.38.2018.04.02.10.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 10:57:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lyubomyr Shaydariv <lsh.dev@ukr.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] graph.c: log.showRootMark to indicate root commits
References: <0102016283000c69-b09d1499-8a50-45a7-9f41-01be648398bc-000000@eu-west-1.amazonses.com>
Date:   Mon, 02 Apr 2018 10:57:46 -0700
In-Reply-To: <0102016283000c69-b09d1499-8a50-45a7-9f41-01be648398bc-000000@eu-west-1.amazonses.com>
        (Lyubomyr Shaydariv's message of "Sun, 1 Apr 2018 20:57:21 +0000")
Message-ID: <xmqqk1tpze1x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lyubomyr Shaydariv <lsh.dev@ukr.net> writes:

> When log.showRootMark is set, root commits are marked with
> the at sign (@).
>
> When log.showRootMark is not set, root commits are marked with
> the asterisk sign (*). This is the default behavior.
>
> Signed-off-by: Lyubomyr Shaydariv <lsh.dev@ukr.net>
> ---

So the idea is when you have a history like this:

    R1--A---B
              \
    R2--C---D---M

to show "git log --oneline --graph D B" like

        * B
        * A
        @ R1
        * D
        * C
        @ R2

because you cannot tell that between R1 and D there is no
parent-child relationship otherwise?

One downside of that approach is that it is not clear how this
feature should interact with --left-right.  I do not think there is
a clean way to do that, unless you come up with a pair of symbols,
not just a single '@'.

Another way to show that there is no parent-child relationship
between R1 and D is to show it like this instead:

        * B
        * A
         \
          * R1
        * D
        * C
        * R2

and that would work well with --left-right automatically (as you
would just do the same thing as you would to a normal asterisk).
