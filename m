Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DFBF200B9
	for <e@80x24.org>; Tue,  8 May 2018 00:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeEHAag (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 20:30:36 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37875 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753505AbeEHAaf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 20:30:35 -0400
Received: by mail-wr0-f196.google.com with SMTP id h5-v6so6534427wrm.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+HlgUU9hhbc/s2t+HNa5brUfQn6hDPwtsFOFyTn4gM4=;
        b=QQ0OJ8ByUXcODzaiICNk18+2GrnWsoRI20ksotxCTjrZ761tUo9FXWvZE29LPxGWjj
         B9pWMMV1oTCXzVsJecCDEw9SLkgN2z+1IvlSp0bkKdRcQs0KxbKJjlN2gbPozfXa4bwP
         INZAXMcFeXgR/d+llAmmdxZ3mT0Ufz4e2qeObn+Hn8owbOZvBKzeB4oo8mSG5e4KrI98
         jnPanWDvn043ldaWB2yThiJKTEZjTxoUuI6axnE42a9wIwFPsVFr7ee27Kq+WLyPqjDG
         IhCcOixgCPoUffy5VEui8B+V0NdNlNnycJ1Zmg5ePCz6SOYKm8FAkwqSchxAwOaEl1ib
         QHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+HlgUU9hhbc/s2t+HNa5brUfQn6hDPwtsFOFyTn4gM4=;
        b=cgz1o+ai2hbEyAj2vOnlg7of40RHh//8/IzvkqLwvYT39kqspaiObXqZpSMwWcDf2d
         H4vY8B1hs6itnFFx7vgPn7e0Reqijlc4CV2emjKb9Sspvk2EOaHexLWm1Kmk899VrI62
         ud+2twDcrYbFRh0cjtR78gFR7dZJcXjouuTdIwnkNnLnCMoLfHN8lS8VA9D+btjxJPjM
         AcXwSy5TckeIC+nmv7fQH6LdghzDENTP2T89M4J0ZI97VdpXQP3by82Cc4g5YFD88GPc
         NmKTShdLJeVrIU2ZVsUGrztTA3aS36ri4KYgiL5rOaXA3ut6EfP+06PJ4thY0Gr6TREH
         QzTA==
X-Gm-Message-State: ALQs6tBUbCBYuRqo6jFAcIcM27Gr8DNMDoOsPQeZJXRuUN+K7kL+aAkq
        mJ/ONEfArMRud25+MVhtIvw=
X-Google-Smtp-Source: AB8JxZpY0nS/JyxKmMO/LRdeyRByksLdrybF+VtqTZaPvbpdHmHAymjKD3+XP/UxAIs0Z+4vycGAow==
X-Received: by 2002:adf:a108:: with SMTP id o8-v6mr31553816wro.106.1525739433823;
        Mon, 07 May 2018 17:30:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 141sm12377537wmf.35.2018.05.07.17.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 May 2018 17:30:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
        <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182631.GC17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
        <xmqqk1shsecd.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1805061419530.77@tvgsbejvaqbjf.bet>
        <CAPig+cS0pvdg78fGUu8m2xspDDMHxi=uAMCkbLuthy7R4p3fQw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1805062155120.77@tvgsbejvaqbjf.bet>
        <20180507074843.GC31170@sigill.intra.peff.net>
Date:   Tue, 08 May 2018 09:30:32 +0900
In-Reply-To: <20180507074843.GC31170@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 7 May 2018 03:48:43 -0400")
Message-ID: <xmqqwowfng47.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> One of the things I don't like about "git branch --diff" is that this
> feature is not _just_ about branches at all.

I actually wouldn't be that much against the word "branch" in
"branch-diff" on the ground that we are typically not feeding
branches to the command (we are feeding two ranges, and one endpoint
of each range typically gets expressed using branch name), as we
have a precedent in "show-branch", for example, that often takes
branches but does not have to.

> It's really "diff-history" or something, I think. That's not very
> catchy, but I think the best name would imply that it was diffing a set
> of commits (so even "diff-commit" would not be right, because that again
> sounds like endpoints).

Sure.  This should't be a submode "--diff" of "git branch" just like
it shouldn't be a submode of "git commit" only because it is about
comparing two sets of commits.  "diff" is about comparing two
endpoints, and not about comparing two sets.  "log" is the closest
thing, if we really want to coerce it into an existing set of
commands, as it is about a set of commits, but it does not do
multiple sets, let alone comparing them.

"branch-diff" was just a good as "diff-history", except that both of
them may irritate command line completion users.  I do not think I
care too much about which exact command name it gets, but I think it
is a bad idea to tacked it to an existing command as a submode that
does unrelated thing to what the main command does.  So from that
point of view, "branch-diff" and "diff-history" are equally good
being a distinct command, and equally bad sharing prefix with common
existing command.

