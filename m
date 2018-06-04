Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 051901F403
	for <e@80x24.org>; Mon,  4 Jun 2018 03:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbeFDDEj (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 23:04:39 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:46775 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeFDDEi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 23:04:38 -0400
Received: by mail-wr0-f176.google.com with SMTP id v13-v6so29876120wrp.13
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 20:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WpDCoHxuI5WERxMNh5sMRJmImmVwjwSn8nWqmL7gSvQ=;
        b=OsjT0MZpm8ijk781pE7b8YKQCtJOZLal+uDxx1LSg+rNiboeuWcIywWLADv+rjiTLo
         qyIZUzICxixb/4/6KXusXwJ3S8QRDKLyrEeEPplCZszz2jY3Z8E2ipedyHl+BKV2E/qL
         xGYjajXN2tSU1eQt2dKRJWQ1ISeuTCCqIXmfhobhrYR8WZ4BFXG+08zZE7m4HR9EikJU
         3Lfe2ynYVdAof30PAil7rnTDtLvaAak/zX+qRdYrgMDDJRYQ2H+p10bE+KXPVruLVi3X
         bWMxUTHru9vBwQN08bODED/YPmUA4eWxxp8yiaBba987X4paYbmnvJyEu0kybsP+ovlX
         5t+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WpDCoHxuI5WERxMNh5sMRJmImmVwjwSn8nWqmL7gSvQ=;
        b=p3XEDNfCUZvgKfO5O10Esx4Q2dPGFjOoxDQAejEw/RUvN0jdzToRcQlMR+psEkpubb
         zYrjuseTa6jlOKiYhC2q70FKek7KgL20XyleLc10Q8P6gxQpJuxkcKOKUHhjRxlTd03w
         /iWWH5YmgREIP8I/sbxMxeDIDz7mJzn/wN/nX4ENtgUh9Ucxlv1se7066ZHnj+SfZqSw
         wer/HkUyPiyK+U/PTYsIn41CMwIXX2587rfrkJYWurbcsYYr6VldO072mA4iYydtMq53
         oWHqZP/liN7p5RPtDOup0XjY1ytagV+oKjMDsGYrVgwnPhqUKZvUBdmdTgsBhwxoHKkA
         BhUw==
X-Gm-Message-State: APt69E0PILzphh+l5s2yIbPO8ROGmIeJXqrceGIvVSxHoE7ktsiiroOv
        wdsXMEE6a3rrPSoH3YfXp1c=
X-Google-Smtp-Source: ADUXVKIqf9SQB8KuDZ/1KlMny+vTIGy+5nJGC2elM2bTU+VQAdsb3a7S9M+7TG6rWvmuvmU+aRf2HQ==
X-Received: by 2002:adf:a9c1:: with SMTP id b59-v6mr2385433wrd.48.1528081476696;
        Sun, 03 Jun 2018 20:04:36 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h4-v6sm1723854wre.89.2018.06.03.20.04.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Jun 2018 20:04:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: does a stash *need* any reference to the branch on which it was created?
References: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain>
Date:   Mon, 04 Jun 2018 12:04:35 +0900
In-Reply-To: <alpine.LFD.2.21.1806021525120.19865@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 2 Jun 2018 15:28:09 -0400 (EDT)")
Message-ID: <xmqq4lij6ym4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   i realize that, when you "git stash push", stash graciously saves
> the branch you were on as part of the commit message, but does any
> subsequent stash operation technically *need* that branch name?

It is not "saves", but "the message it automatically generates
includes <branch> and <commit title> as a human readable reminder".

"git stash" does not have to read that message, as it is not
prepared to read and understand what you wrote after you ran your
own "git stash push -m 'my random message'" anyway.  It is merely
for your consumption, especially when it appears in "git stash list".
