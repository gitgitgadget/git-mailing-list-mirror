Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08D26201C8
	for <e@80x24.org>; Mon, 13 Nov 2017 03:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751602AbdKMDQt (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 22:16:49 -0500
Received: from mail-pf0-f175.google.com ([209.85.192.175]:44042 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbdKMDQs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 22:16:48 -0500
Received: by mail-pf0-f175.google.com with SMTP id x7so10906833pfa.1
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 19:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sr/co8/581bnn9vlqcUT0pDSfy47+1b8Pf8UagC+aEQ=;
        b=kCtVkZrEgloheIqdsNxUZZBOhiIyb7UBjrGgTH9+F/W1PLBeFy22U91tD5aKYxGMAn
         2bGbs4uHeJQNrVj/OY1HAOD1NP21FiZZE8ZwlOa9KJgFzw4puiAU9+vH2QSxbDhxKHJd
         kfY9mMwL7YBc5OCL03MZhgh/nyYcpwiX4qacA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sr/co8/581bnn9vlqcUT0pDSfy47+1b8Pf8UagC+aEQ=;
        b=C9XUHusTLnbSYIxwqnI1Isv06bafzpvV6kWiOfyTC1Q+6tKG0u6EzjH2ZkwHDk4Bo7
         B9bgsN4ezrI4DwTR1JSd8y+X4uB1RhHVgCxEVOxBndzqYt/Mfg4kcA2jjnj0jHo+dvOf
         Vu6d0UPOc3gSPVr6xfgHfjrsZw8ASIZYRvvu1J33P/1byddaaT98WJ7QQyMow7UY85Xl
         nQCXHEkyRsk8nFAPkBcm6mwh2zJWw2wqj55LLtme2bOeg2Lu24M2TP1ll7OQHvqpU+QT
         WEzG0a0yUgOgz60Lwcb/B3yNu8V1U4ijKkYBb74SEQXP74mjW+wX3wwi4haCniymzw8M
         PeSg==
X-Gm-Message-State: AJaThX7kic0Jers+mgQesxipY4in5gBmQECOB+xY19LIspsWKi3k7ACR
        gTfjHtvpZLrAp0YLATJ7goru4A==
X-Google-Smtp-Source: AGs4zMZzNtAb7hwVLYWFEC4aWrRgyiO1laLSJHFrkv70zRH7M6juHFg2yHO9ktQea48avno5C9SE/Q==
X-Received: by 10.84.213.9 with SMTP id f9mr7366290pli.76.1510543008454;
        Sun, 12 Nov 2017 19:16:48 -0800 (PST)
Received: from localhost ([122.172.166.155])
        by smtp.gmail.com with ESMTPSA id i129sm25851083pgd.21.2017.11.12.19.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Nov 2017 19:16:46 -0800 (PST)
Date:   Mon, 13 Nov 2017 08:46:43 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [Query] Separate hooks for Git worktrees
Message-ID: <20171113031643.GA4305@vireshk-i7>
References: <CAKohponsPQC6qTw99+xh1RSu0bZNDSo5TbbZZcYmup3NOW6QmA@mail.gmail.com>
 <CAGZ79ka9VnzYTYgtWgGAhvgn2LRpP_BCQyVvQ8iC1w9XJnRxEw@mail.gmail.com>
 <xmqq60aihgod.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZ8PKBwe+aWTUOgPwV2tNQS7+dUrLTVsWhzemj-e35kaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ8PKBwe+aWTUOgPwV2tNQS7+dUrLTVsWhzemj-e35kaA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10-11-17, 10:00, Stefan Beller wrote:
> Well it is the same project with different upstream workflows.
> For example I would imagine that Viresh wants to cherry-pick
> from one branch to another, or even send the same patch
> (just with different commit messages, with or without the
> ChangeId) to the different upstreams?

Right.

-- 
viresh
