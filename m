Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE041F404
	for <e@80x24.org>; Wed, 21 Feb 2018 21:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeBUVdK (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 16:33:10 -0500
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36160 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbeBUVdJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 16:33:09 -0500
Received: by mail-wr0-f171.google.com with SMTP id u15so8529723wrg.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 13:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=LCEzwjy212ib3aA9lXDjuwL/f/PY+WjhwrsUoFxb6zk=;
        b=PATiODxKgKZ80407qCV7uOhNUu+zTyWS2kSVklhn8DGD4NVrtqVLwPBVU60xpNthW0
         aKlS7+tf/+wxMcqLesUy8JrkqvxP0R3bOpLvMIKT31mvi3jO3LuXrR06XEQL+VQQA2q/
         /Hg9oe8XBfYJDl5SaDukY00UJlxQsPEJn65OSXlLkwtE1JaBgMt/yiCT9MfYz5u5J5jB
         djBJ/S6iNH0zaSrWOzFpjF4yBvYrUYXr8nuWS3ZB1BklADsXEaU0kExXCRUZHSVEAvkU
         4U05DhemvEoSC743YYCVlDvGi6nlGzAUgIS+/lAAObpSFwgHAZILRVUuy0N3y2OWtzND
         +NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=LCEzwjy212ib3aA9lXDjuwL/f/PY+WjhwrsUoFxb6zk=;
        b=sErAT3yWDY8IhuahW28rEJC4lDDCwsM7W0XIk+f9bXcboDCHqPDKVeIGEeAIcI3FEJ
         zjetcTf77G4Jr6CO4EhEQKROfppBMv7YAOoJ0mQi1VyZqf3OpVQ7qYoqx3pdQhe+Awsq
         v4TqUH6K1DBIrI/7xuzZHrmZJNliOB/EmpiG3vfFFFMPVMdqbh9tMPZVt0yeL2vMZgpb
         NoKJrlxkt938Eu50EwZrtW/pMNsg0LlUEjABg5QxqdeXSAw0j0HOWpI9J1tGdurPjBHh
         fjnv5WmDzO3Q9OKj4KgDNfWCrJChxotReCNnIEDk2fkWXRuu7jhYCA3NFs1gfDAIeL4G
         0q/A==
X-Gm-Message-State: APf1xPCRAXF/lw8Ai8vKKfy92k1Y5971CmnOCTDNLXNUnVwZUaNID19Z
        Chz8KYu9OROvLdsAU8sinvkYlTd8
X-Google-Smtp-Source: AH8x225pW7Csv/lavqleGB1nEnJu4Xq9Ws+Jk4Jk6vTg+t2rBCi9ggAW5/+Igzdg5ctmPz0zXiTCqw==
X-Received: by 10.28.249.22 with SMTP id x22mr2929911wmh.135.1519248787844;
        Wed, 21 Feb 2018 13:33:07 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id y1sm6685919wrh.80.2018.02.21.13.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 13:33:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derek Fawcus <dfawcus+lists-git@employees.org>
Cc:     Peter Backes <rtc@helen.PLASMA.Xg8.DE>, git@vger.kernel.org
Subject: Re: Git should preserve modification times at least on request
References: <20180219212235.GA9891@helen.PLASMA.Xg8.DE> <20180221210339.GA43094@accordion.employees.org>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180221210339.GA43094@accordion.employees.org>
Date:   Wed, 21 Feb 2018 22:33:05 +0100
Message-ID: <87bmgif2pa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 21 2018, Derek Fawcus jotted:

> On Mon, Feb 19, 2018 at 10:22:36PM +0100, Peter Backes wrote:
>>
>> It is pretty annoying that git cannot, even if I know what I am doing,
>> and explicitly want it to, preserve the modification time.
>
> The use case I've come across where it would be of value is for code
> archeology, either importing a bunch of tar files, or importing a
> repo from some other VCS.
>
> There preserving the mod times can be useful when one is subsequently
> figuring out what changed, and the scope of the 'commits' is too big
> (i.e. the granularity of the tar files themselves).
>
> e.g. initial commits are done on tar boundaries, but one may try to
> figure out individual changes from a ChangeLog file.  I've done this
> a couple of times, but to date it has required keeping the untarred
> trees around (or a timestamp list file from each tree), in addition
> to the git repro in to which one is then synthesizing smaller commits.

This sounds like a sensible job for a git import tool, i.e. import a
target directory into git, and instead of 'git add'-ing the whole thing
it would look at the mtimes, sort files by mtime, then add them in order
and only commit those files that had the same mtime in the same commit
(or within some boundary).

The advantage of doing this via such a tool is that you could tweak it
to commit by any criteria you wanted, e.g. not mtime but ctime or even
atime.

You'd get the same thing as you'd get if git's tree format would change
to include mtimes (which isn't going to happen), but with a lot more
flexibility.
