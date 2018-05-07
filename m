Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637832023D
	for <e@80x24.org>; Mon,  7 May 2018 22:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753119AbeEGWF3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 18:05:29 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39812 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeEGWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 18:05:27 -0400
Received: by mail-wm0-f67.google.com with SMTP id f8-v6so18040613wmc.4
        for <git@vger.kernel.org>; Mon, 07 May 2018 15:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=arSa2LWTDVuxkIhuP30hBRs7KRI1zVCQ1ZO8j20CV/8=;
        b=BrfVN4U7aBxdJkmwnYlWAVN8DYBT9tQ6vG1KvUWsJQBQI2RrbE7LiUYfreswPcO0Ou
         xdIltrLcx0WUuIp/mPg5DWF+g8X68m+HATd1b364/tA/Nx46CNd+/T2YV2RA1KWi+YFJ
         B4k8prNCnhnCLNkggEIdB4muH7kBG/FFjxFAS3QvVYT91OImtkObnndYWVfZLpw2+tHK
         bR7DW72PMw8OfcU3df4iKqhk/okIBBpg3JKDZE/iz745rTgPB9jtKLmenYKdKGyUsA9s
         P0NbZcY5tJipcMej9xrexJ/WpIj3ADYPO9SUUXPMg3uvW1pwdT+eoX/uiFOAodktDXfp
         0VMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=arSa2LWTDVuxkIhuP30hBRs7KRI1zVCQ1ZO8j20CV/8=;
        b=YdbiAucbWZP1KGKGg08ZiC/0Y0Y/+/viQxVd0R5rULjMomiwm77dGdJH4h5o0KGB4K
         cw8J7gOhHZzU68tFvl2pPKfCPs9/JjGZ1bwMz8iHT/Fj4HYr+kQ3SJ2Q8T/YvGeJWn/A
         dI/DRwUayGzm1ecH0fqbAoWjHItipZZtme/ura2ndWfcK5iW6kfhFmV6YNegMzRnpipf
         pJNsUiYygZaqbJ8MnG6Avnny3FZ4O5rZAJR6N/ZGfQFtgSRiDESZSWjsP2n+sa/icfG8
         SQfKtmtqB3yL5Awa4FFpdxEyMBzqZMkQplD3iJTLJ9iFcXTfA7yJwKBwevWu+B/ANFO/
         85XA==
X-Gm-Message-State: ALKqPweOBenpOpaQambjAXYR5G+H4Wdd4v2ePpDQeduEoxdLn9LNTFIa
        SO9tNLRHmKD5c4KkcpFQMEk=
X-Google-Smtp-Source: AB8JxZqd14xWKjI5yWWJ+tER8n2+X9kuAyz1Sl9/DMMpM2byPyWJsgPmyjONXYFjypqbmV95fZxTjA==
X-Received: by 2002:a1c:2084:: with SMTP id g126-v6mr2014885wmg.52.1525730726421;
        Mon, 07 May 2018 15:05:26 -0700 (PDT)
Received: from [192.168.5.102] ([87.116.177.115])
        by smtp.gmail.com with ESMTPSA id j76sm17833543wmf.33.2018.05.07.15.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 May 2018 15:05:25 -0700 (PDT)
Subject: Re: [PATCH v2 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de>
 <a1ea0320b64527ee6ce9856dcf359513d13052b7.1525448066.git.johannes.schindelin@gmx.de>
 <20180505182631.GC17700@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1805052355190.77@tvgsbejvaqbjf.bet>
 <39282590-576f-1ac1-6a16-80ad317ec7ed@gmail.com>
 <nycvar.QRO.7.76.6.1805061408150.77@tvgsbejvaqbjf.bet>
 <e0db15c5-e897-5b03-20ff-d83f38496e61@gmail.com>
 <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <3b4591cd-6dde-31ee-f0b1-42b5353086e5@gmail.com>
Date:   Tue, 8 May 2018 00:05:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1805062124470.77@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 07/05/2018 03:34, Johannes Schindelin wrote:
> 
> > > I think Todd's idea to shift it from a full-blown builtin to a cmdmode
> > > of `branch` makes tons of sense.
> >
> > I don`t know, I still find it a bit strange that in order to "diff
> > something", you go to "something" and tell it to "diff itself" - not
> > because it`s a weird concept (OOP, anyone? :]), but because we already
> > have "diff" command that can accept different things, thus just teaching
> > it to accept additional "something" (branch, in this case), seems more
> > natural (to me) - "branch diff" being just another "diff" mode of
> > operation.
> 
> You also have to call `git branch` to list branches. And to rename
> branches. And to delete them. So why not also compare them at the same
> time?

Maybe because we already have a command that specifically does 
comparison? :)

List, rename, delete -- all these seem more as basic CRUD operations, 
where comparison is a more complex one. And not to get me wrong - I 
could see "branch diff" being part of "branch", but not really when 
"diff" already exists as a separate thing, already doing quite some 
(but still diff related, and configurable) stuff.

> > What about that side thought you left out from my original message,
> > making it `git diff --branch` instead?
> 
> I really did not like this, as all of the `git diff` options really are
> about comparing two revisions, not two *sets* of revisions.

I see what you mean, but I would argue this being a deliberate user 
choice here, like picking a diff "strategy" - I`d say it still utterly 
does compare two revisions (branch tips, in this case), just putting 
focus on comparing revisions that lead to them (branch history), 
instead of just files found in them (branch files).

> Further, if I put my unsuspecting user hat on, I would ask myself how you
> can compare branches with one another? That is what I would expect `git
> diff --branch` to do, not to compare two versions of *the same* branch.

I totally agree with you here, and thus I have a question - what 
determines "two versions of *the same* branch"? :) Do you still 
explicitly provide both "old" and "new" version branch tips?

I see "multiple versions of the same branch" more as a conceptual 
model, and not something Git is aware of (I think?) - BUT, even if it 
was, I don`t see why this should be a(n artificial) restriction?

Basically, what you (conceptually) call "two versions of the same 
branch", I simply call "two branches" (from usage standpoint).

And you may have a branch that got split, or more of them that got 
unified, so defining "previous branch version" may not be that 
straightforward - it`s really just "two commit ranges" (as man page 
defines it in general), with "two versions of a patch series" only 
being the most common/expected use case of the former.

Finally, if user picks two totally unrelated "branches" to compare, 
he won`t get a really useful diff - but it`s the same as if he would 
compare two totally unrelated commits (where tree state massively 
changed in between, or having unrelated histories, even).

Besides, while I might still not be much into the matter, but isn`t 
"branch" in Git just a pointer to revision? Being so, there is really 
no such thing as "branch" in terms of being a specific (sub)set of 
revisions (commits), other then "everything from branch head/pointer 
to root commit" (in general).

Yes, we do perceive "a branch" being a specific set of topic related 
commits, but which *exact* commits we are interested in ("branch" lower 
bounds) may differ in regards to what we aim for - how far do we consider 
one branch to reach in the past depends solely on the use case.

> So `git diff --branch` does not at all convey the same to me as `git
> branch --diff`, and I find that the latter does match better what this
> patch series tries to achieve.

I agree with the first part, but it seems to me your finding is 
biased due to your (expected) use case.

> > But if "branch diff" is considered to be too special-cased mode of
> > "diff" so that supporting it from `diff` itself would make it feel
> > awkward in both usage and maintenance (in terms of many other regular
> > `diff` specific options being unsupported), I guess I would understand
> > having it outside `diff` altogether (and implemented as proposed `git
> > branch --diff`, or something)... for the time being, at least :)
> 
> The branch diff is not even a special-cased mode of diff. It is *way* more
> complicated than that. It tries to find 1:1 correspondences between *sets*
> of commits, and then only outputs a "sort" of a diff between the commits
> that correspond with each other. I say "sort" of a diff because that diff
> does not look like `git diff <commit1> <commit2>` at all!

But there is not only one `git diff <commit1> <commit2>` looks, it 
depends on other options (like --name-status, for example), which is 
my point exactly :)

With something like `git diff --branch <commit1>...<commit2>` you 
would get yet another "diff look", useful for use case in question 
here.

Regards, Buga
