Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B487C1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbfA1R3Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 12:29:24 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35469 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730712AbfA1R3U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 12:29:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so19037004wrb.2
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 09:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/B6k9F5xXt37Toz27AoboLh3bTo63T+2KlxCdDPyvkk=;
        b=rAViGfGcTSRfXa4W+fQe0XpXVujCIqTXi0FzEL7NoZShM9ikIogTqwA8j40K6IGEXx
         UZzV/lSzYPxHT8HMjg3OYdRGD0389BTSqirDj3CdMBFlbtsXBTCT586ko1CuZRdmUAAh
         voCPQadGSftXk6YgTJbKHAf9Ke3zwx0yVXocSqEDyBGK7BeUDlR9S5PEIZG+o/PjvVpz
         Qpt98g4FqzI6HgPNmML7Kl65lriLlYewnlfooUEBsIl2Ea6LRC3eN2p83PVew1aIV7t4
         arvMXPLOOgxvhv7R/3an8FTXbUbWCq4D5tOe8J0Y1r+h4Z5Ayxa5vCHPzMVfVFNLLpz7
         qNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/B6k9F5xXt37Toz27AoboLh3bTo63T+2KlxCdDPyvkk=;
        b=ZDkWxfxz1ovWZrgpGMBEifkNc0cpRpjc30SD89YxZpQhEHX6K+94WuNLoep57pXNka
         vVI+H/U+9SXjga+R8Sj7s/l5sNUgEeV5YYpMCMxn1mFoABwqjuVgYwNtnuhztmHZo1sk
         auQUp0sHd7hAz+aOve+fQuL4n1zD9GFmexAbtaQINgz3BM3/hvMsMm/WTKtMEPXUIyHu
         C2pVu6y6jpJ8Kd48lkG1N0swvSrJFjRR4be1IKFaK6+V67JRiykLsV14k0f0wdMPy6zX
         FRG+JptU5Aj0EfceTqZAffat4UYo8M0PAS4T/I3DzBBU4mdzQnZ9t85b6qsNJCypC37D
         BqUA==
X-Gm-Message-State: AJcUukdYxYNgbexk5OtPLQq5FJ5Y6Dz+GakYY3Z1v1UexPXV7WqxcYOm
        SH9eMI4LBeex1bNr9fKPNwM=
X-Google-Smtp-Source: ALg8bN61A2Ne/TkPFKJXJYCNeWik9bIDRsKtoVFRH1eQEV8ra+QObct/K8oBxhfx8XcuwIa0gsBurA==
X-Received: by 2002:adf:b307:: with SMTP id j7mr23771751wrd.46.1548696558346;
        Mon, 28 Jan 2019 09:29:18 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n15sm88832287wrt.21.2019.01.28.09.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 09:29:17 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>,
        'COLLOMB Joris -EXT' <joris.collomb-ext@alstomgroup.com>,
        git@vger.kernel.org
Subject: Re: Git checkout multiple options issue
References: <HE1PR01MB3722DCA42B6E16CB9DEEC29EA9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
        <000201d4b713$7edcd3d0$7c967b70$@nexbridge.com>
        <HE1PR01MB3722D90668E75E4BCDBA71F2A9960@HE1PR01MB3722.eurprd01.prod.exchangelabs.com>
        <000701d4b71c$f3ba57f0$db2f07d0$@nexbridge.com>
        <20190128165515.GA25995@alpha>
Date:   Mon, 28 Jan 2019 09:29:17 -0800
In-Reply-To: <20190128165515.GA25995@alpha> (Kevin Daudt's message of "Mon, 28
        Jan 2019 17:55:15 +0100")
Message-ID: <xmqqtvhsbsia.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Mon, Jan 28, 2019 at 10:20:02AM -0500, Randall S. Becker wrote:
>> On January 28, 2019 9:25, COLLOMB Joris wrote:
>> ...
>> > git checkout -f -b "branch_name"
>> > gives me " Fatal: A branch named 'branch_name' already exists."
>> 
>> Once the branch is created, you can't force its creation, because it is
>> already created. Just
>> 
>> git checkout "branch_name"
>> 
>> is sufficient at this point. git is correct to complain that you are trying
>> to create a branch that already exists.
>
> git checkout -B exists, which does exactly that: force create a branch
> at a new positon if it already exists.

Correct.

"git checkout -b/-B" is for lazy people to perform two things,
i.e. "creating a branch" and "checking the branch out", at the same
time.

If we did not allow "git checkout -b newbranch othercommit" and only
allowed "git checkout -b newbranch", i.e. to start a branch at the
current HEAD, then we could make "git checkout -f -b newbranch" to
mean "git checkout -B newbranch", because creating a branch at HEAD
and checking it out will not have a risk of overwriting local
changes, i.e. no need to force the "checking the branch out" part,
so the "--force" option can only mean "force creating the branch".

But because the new branch can begin at the commit whose tree
differs at a path that has local modifications, there needs a way to
tell the command which part, either "creating a branch" or "checking
the branch out", is being forced.  Hence, "-f" tells the "checking
out the branch" part to do the forcing (e.g. allowing local changes
to be overwritten), and "creating a branch" part is told to force
with the distinction between "-b" and "-B".



