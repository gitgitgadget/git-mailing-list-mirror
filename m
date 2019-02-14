Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3191F453
	for <e@80x24.org>; Thu, 14 Feb 2019 22:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404880AbfBNWK5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 17:10:57 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40691 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388126AbfBNWK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 17:10:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id q1so8219304wrp.7
        for <git@vger.kernel.org>; Thu, 14 Feb 2019 14:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=bXdMgC1C1hHfnZMI0glrzcmdPTr1gkk7aBTn8rKtrek=;
        b=QfktuJ50Q6iZvaqb0Mn1w9EFU1QDCFFLU///aYVZKFc1ZLXrdPDbp0ubWYOm/d5tnf
         6RDwdkCzZe3MpVim/AbEzv/VLCF6oiahlHVHatVRPjmFotlgfksfSBP/KooG9JSxWLEx
         kHfkgXuZex2Uu/22IGCVMiBY/v15rfe/K8p/3TiaQbPH9Hu4aZfJrUJMwH0ruZaRv47n
         qaFhWYCa30qEiVvsx/2mTscc6y5m9D2J/EoOCt7q+JZZahyZfg7k1sd9CPyvDyOsx5fv
         71yFEM2TTxxoThNkhebHmGzp47PVHOxAzhpq/iQ2g8UCcfrYgdYIN2dznSrqHWtYZjtJ
         VewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=bXdMgC1C1hHfnZMI0glrzcmdPTr1gkk7aBTn8rKtrek=;
        b=kcc7JNhTNT5Q2VCYAYfg7Q4vKnw9tGSYIwa7nn+Aa7Y+GbU5FuCSDuQAgIONwj8pd9
         +oRuIxH87cMB/TAb3Ak5jeDi9zA8+ah9NqqOJarCWOV0mJlEAsKLDuc5nqe2yjQiZU7A
         xcJ8oGB8GSiUE7wfsxxOwNuyeItUo61eIJE5o6tE7p8MwFykGpRs+v2rSQcebjRdj9+z
         NySW8JJZTmVz8cv+ecywuJgC7nH/gwWoMaEtzrFxwTR4KL2A4h6c5nyK/Rq43nQ4gbhB
         f69ZiKX+EXrMxvRCI4fk8d4KRpf/XTF8dZvp/L5KjJZpcqyzX8R4r7PpzSDNjU8/yU1b
         5SEQ==
X-Gm-Message-State: AHQUAubjI40zlLg/iR6R5ELmlsuEP6zAML0DjlOvauemFg1tKqx65tQI
        T+bH/fYVhEJN8EDMdbaDPUw=
X-Google-Smtp-Source: AHgI3IaAvNht/+C4kV/+hrTfl0S9S3zAuFWtBI2Bii+izjzXh43gJXwPn0jmn8fr4iQhTa05zuF5xg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr4776445wru.59.1550182254555;
        Thu, 14 Feb 2019 14:10:54 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm2307694wmb.39.2019.02.14.14.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 14:10:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Git Mailing List <git@vger.kernel.org>,
        vincent.guittot@linaro.org
Subject: Re: [Bug report] git diff stat shows unrelated diff
References: <20190214082258.3mh3hcr2l6dl3wuf@vireshk-i7>
        <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
Date:   Thu, 14 Feb 2019 14:10:53 -0800
In-Reply-To: <CABPp-BGstumw1eyZ++0itk-AR0Bk5zd0AchgznBpMq35a6ScUg@mail.gmail.com>
        (Elijah Newren's message of "Thu, 14 Feb 2019 13:23:14 -0800")
Message-ID: <xmqqmumy6mxe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> The only thing I seem to be able to retain is the following:  "git
> diff D..E is totally useless and should be an error because (1) it
> doesn't do what I expect and (2) for folks that want the behavior
> currently gotten with that syntax can instead just use a space instead
> of a double dot."

That sums up pretty nicely.  diff is fundamentally an operation
between two endpoints, so the range notation a..b does not work
nicely with it at the conceptual level.

When we realized that we can take advantage of the above fact, and
reuse a range notation to mean something that is generally useful in
the context of diff, such as 'one end of the comparison is the merge
base between a and b, and the other end is b', it was too late to
use "a..b", as an early adopters of Git was already used to the fact
that "a..b" happened to mean the same thing as "comparison of one
end is a, the other end is b", pretty much implemented without much
thought.

It might be _possible_ to spend a year (i.e. 4 cycles) to start
warning when two-dot notation is used for "git diff" (only, not any
plumbing like "git diff-files") and tell the user to use the more
logical two-end notation "git diff A B" and then eventually error
out when two-dot notation is used, while retaining the three-dot
notation throughout and to the eternity.  I am not sure if it is
worth the deprecation cost, though.



