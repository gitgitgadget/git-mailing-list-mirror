Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A996020188
	for <e@80x24.org>; Fri, 12 May 2017 12:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755468AbdELMAp (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 08:00:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36239 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdELMAo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 08:00:44 -0400
Received: by mail-pf0-f193.google.com with SMTP id n23so5718929pfb.3
        for <git@vger.kernel.org>; Fri, 12 May 2017 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mc3x1kciOTQaXWOFJq1gjvGrrXvBpchGbbuTDuY34yY=;
        b=dx9uf5jippnWBGVBhnkDMoQq6XP+7F4n0OungM5GrrZFsTu8CFdlmOuNMjDLw/hmJH
         w3LVgtSOuN2GIwHpOnbqlyC7JbZdgto8LJDswNKwfwRsOnDkZ+ZQGMAJ5ycOHfNS0Txh
         bJ5d32F6Nsj97SrdM4oHOepuhWKKdUq9SX50/YW81ikYWbffp8h60nuvHRuHTRwZclxj
         KeeMew3cLD7librXo8NI6WRtWxOUB89HTGhAcV+4AXEgXHz/30UgTOjPsvRJvFG8BvuG
         4bhrudcjuOcuYU0HeN2oqyLeBnjCVqUDDXzqDEaAprOGZWU4b0bRkKLdMspXNWD/7q6Y
         cc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mc3x1kciOTQaXWOFJq1gjvGrrXvBpchGbbuTDuY34yY=;
        b=h+PAI8NFgAaKImYHiU/an967FxBz4MAQKZkt1AwxSk+fR67XyUNjMzocZ1ogK9tOnb
         DD9Us5y5gx5s1svDDyE5E8/gNSgPVnh3JkS/LwXTZ4EphSR05GEBeZ2mK/iqa9GOX3IL
         TLLBk531Bq9+rYegSx8RHgF9iVgcI75NjXf3SDvymPDhrpP+ul7/OumdLxiz06nHq+xe
         0oT7F2fk2v+D2dDAeIvLY/upJm/Tloj5GtCmjIpJjXRmc6yoLix/dlXGqATkiVB7RpnX
         b5uJM4cWmnuEbRqfD59pW0f4juPzLejdObyoaIuMr3Yq37gXBaaTItP3+2HuheJV+pG4
         ajFg==
X-Gm-Message-State: AODbwcBhYyCL24x9misdOeohl7sBdSgoEdhwkiqtukT80Q0vc62etKGj
        rslbUer8HMhOIQ==
X-Received: by 10.99.97.83 with SMTP id v80mr4180787pgb.94.1494590443526;
        Fri, 12 May 2017 05:00:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id u19sm5558621pfd.63.2017.05.12.05.00.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 05:00:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/11] Start retiring .git/remotes/ and .git/branches/ for good
References: <cover.1494509599.git.johannes.schindelin@gmx.de>
        <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 12 May 2017 21:00:41 +0900
In-Reply-To: <xmqqk25m98rd.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 12 May 2017 10:14:14 +0900")
Message-ID: <xmqqfuga5lp2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Git uses the config for remote/upstream information in favor of the
>> previously-used .git/remotes/ and .git/branches/ for a decade now.
>
> The last time I thought about trying this several years ago, I found
> that people who need to grab things from many places still do use
> .git/branches/ and their use case is hard to migrate to .git/config,
> primarily because the former is "one per file" and it is easy to
> add/remove/tweak without affecting others.  Ask akpm@ if he still
> prefers to use .git/branches/ for example.

FWIW, I do not think there is any reason for people to be using
.git/remotes/, but for .git/branches/, I do not think I can offer a
more efficient and easier to use alternative based on .git/config to
do these things:

 $ grep <substring> .git/branches/* ;# what did I call that remote?
 $ cat .git/branches/$name ;# where do I get that from?
 $ echo "$URL#$branch" >.git/branches/$name ;# I just learned a new src
 $ rm .git/branch/$name ;# I no longer need it

without having to learn things experienced CLI/UNIX person already
knows.  We simply cannot beat the above with anything like 

    $ git config remote.$name.fetch refs/heads/$branch

even though the config based remote definition may be infinitely
more powerful.

> Is it really hurting us having to support these old information
> sources we treat as read-only?

And this one is also important.  I do not think we had to touch any
code that handles .git/remotes/ or .git/branches when we extended
the .git/config based configuration for remotes, simply because the
old data source are pretty much frozen read-only places these days.

