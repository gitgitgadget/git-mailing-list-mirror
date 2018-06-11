Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3B721F403
	for <e@80x24.org>; Mon, 11 Jun 2018 22:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753942AbeFKWov (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 18:44:51 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:45658 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752768AbeFKWou (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 18:44:50 -0400
Received: by mail-wr0-f170.google.com with SMTP id o12-v6so22008771wrm.12
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 15:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=448h4iAU9OaP6+cwAqGbz2WsNQokDXSvkzzPrH8+BMU=;
        b=KLr11B5K/F+e4Ol6CsCzctPswR0c1vIzz3KBKDpvo8l8f++6s2/s/no3vqW1F+pqlM
         SXfaDW+6fhKND+UyWNRF0WaixSDMVb0xBe5s2wVeIPJiQ1cCPCaT5a5g5XUHxoSf4uUJ
         09kN4/DQkKwMxU96nv/+hgrYE31GwusWT0/1WeD6TcgN6x1f7aN1m121CzgZcKUDbQq/
         iCe6OQD6bOYiL+YjymF97eBHOwAV0qzqmKNnzNdom/+ojRN4iHbkx2Wf3LDnZpJ4YM3Z
         bqff50coesBWvj1hIPE+WkhOYDJH7vH1d6fETkKw34QOBZOvhBXSyANbnrO0eVv5CRzY
         NJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=448h4iAU9OaP6+cwAqGbz2WsNQokDXSvkzzPrH8+BMU=;
        b=JfOxfp8tzBcpGoSwQ3n5Y3cehqD5qEM2UQnPU3iJWrTA5AW+q7ujE8YEGyJKzAL/Zr
         QAZxcv44XMnY6ARHpXj599gNJ+SKcUXTnL3Bs0jO1Qk1tCbFo+LIkA4p0g9FIXwiBTn6
         OOvzTkfY11MnLywpTbAWSHOexeMMTg/noOEGHkmK9A6LkaBoDYgZXQpk09JpKQHvyniH
         1ogQzCo9aE1WSN+gNi95GP6BS/fqo+rYzYXJwiIpm9DbQEGOcontCGYLNPILxnV8sejv
         cK1bvYvJFCpbyIA3mfNfv+CnsjsZVmj7ZiZ+wIEaTBLeKxNlcgLoImD6C6IV0K2+r9L6
         G1hA==
X-Gm-Message-State: APt69E2tA8YccEZWmmhLlChAaVvmEb+6Re6bZyhAfpS7cimyowGL9mq6
        68uiIntwKKFwhbJLryGLcns=
X-Google-Smtp-Source: ADUXVKJqs6rNhUkAaooHrBogljrquhd/V9EU9VgdcpzdqRafMnpkiFy7DeY0oKchQ/XjlcVWF0VZ7Q==
X-Received: by 2002:adf:aadd:: with SMTP id i29-v6mr691972wrc.149.1528757088886;
        Mon, 11 Jun 2018 15:44:48 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137-v6sm10529037wmv.28.2018.06.11.15.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 15:44:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
        <20180530160908.GA8340@D-10-19-29-76.dhcp4.washington.edu>
        <20180530161210.GA9211@D-10-19-29-76.dhcp4.washington.edu>
        <20180611200429.GA38947@syl.local>
Date:   Mon, 11 Jun 2018 15:44:47 -0700
In-Reply-To: <20180611200429.GA38947@syl.local> (Taylor Blau's message of
        "Mon, 11 Jun 2018 15:04:29 -0500")
Message-ID: <xmqqefhdaqow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Since it's past the date that I said I would re-roll this, I wanted to
> provide a quick update. I am back in the office, and have discovered a
> new wrinkle that `--invert --not -e ...` prints a column offset of 1,
> when it should recover the pattern and display the offset of the pattern
> match, treating the double negation as a no-op.
>
> I am going to continue to polish this until I can figure out a clean way
> to work around this issue. Sorry for the delay.

No need to be sorry; there is no need, especially after we hit the
-rc0 mark, to rush a topic that is about a new feature.

Thanks for an update, anyway.

