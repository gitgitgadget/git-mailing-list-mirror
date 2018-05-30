Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7B2D1F42D
	for <e@80x24.org>; Wed, 30 May 2018 01:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968498AbeE3BYN (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 21:24:13 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:35982 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968489AbeE3BYM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 21:24:12 -0400
Received: by mail-wr0-f178.google.com with SMTP id f16-v6so12468609wrm.3
        for <git@vger.kernel.org>; Tue, 29 May 2018 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=KDHysgTJ33N/O121B85OOIn0EXf4U5KjlALzuR8L72Q=;
        b=soS5MWuszjosIJaFiQoV54he0DeKFzpClPJENAeonPUJYb+QoftCf2MVNxl2vwsnY0
         rsIQiALzcG97N+uiymbJchtvjQNkuiKuTsJ2ydu8XyYFzyAwaOEN4x4xliZGo87j3RYx
         cfPRnQQEXfRVvC1OKpoK9vMjQgPKrQNBXOt5wSbindmYw/2mESWFlN6UUOyErpzdKapp
         QmnU+vPr5e1yISNplxEqUU2cBWc7iLylEmleYFsx+p0x4/E3gxJOwVo+c9JFyt+pmLdw
         nzTtsKkPFpikRixEJnB884yJB1LIVngXOMnBOv5axKtmu/m4Ibiz1yY0+S7r48Wovpxi
         dsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=KDHysgTJ33N/O121B85OOIn0EXf4U5KjlALzuR8L72Q=;
        b=nNqz7KePUJX5syXsfdrMGKuDXMXVbT0lvoK+6vHysic+Dp4aKlmh0CpYWTNDw3YZJm
         xtXRfBzG0sp50v8Bz+vubs8g5orlcHwbhcFx+Vsufy+JUnlzfPVAPfM9+CgQ6qnoxWP6
         zymHB27RW0rF8XAdBm6y3yoC0Y1KK6sddV/mSON9j1enB4lyMc+cUkngedcAE4ycfG+u
         26FgCbWWgdejZqG6OpURFaVsfgmiapbXWZidAN7PicSdqzqN4FBAItl7t2XRHfkcCuxT
         kSjtMJzTGI35eBmN+yudmeXOEd7g0PvBZ/MxbpTsQpg21Vck0oZ+Nvrf0fgvHDzxR1iG
         wOwg==
X-Gm-Message-State: ALKqPwdLIhkbQfOOMbfsYUK/PSzeAduLiTTSi9kvjcZ2zfm5I7bo1IJx
        8nXrcerhZNmiR68uOb+yYQJcV6bK
X-Google-Smtp-Source: ADUXVKIxMZUiM7PZef8/WQtWbOfQ/leKVJvyoj2EDEfO/bMmOOssZVRDs/rww73o8jXLltwwTZVVig==
X-Received: by 2002:adf:de08:: with SMTP id b8-v6mr430718wrm.39.1527643450825;
        Tue, 29 May 2018 18:24:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 69-v6sm22837936wmi.29.2018.05.29.18.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 May 2018 18:24:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
References: <87bmcyfh67.fsf@evledraar.gmail.com>
Date:   Wed, 30 May 2018 10:24:08 +0900
In-Reply-To: <87bmcyfh67.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 29 May 2018 20:30:40 +0200")
Message-ID: <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> If you make an initial commit and push to a remote repo "origin", you
> don't get a remote origin/HEAD reference, and a "fetch" won't create it
> either.
> ...
> Some code spelunking reveals remote_head_points_at, guess_remote_head()
> etc. in builtin/clone.c. I.e. this is special-cased as part of the
> "clone".

Correct.  Originally, there was *no* way in the protocol to carry
the information, so the code always had to guess.  The point of
setting origin/HEAD was mostly so that you can say "log origin.."
and rely on it getting dwimmed down to "refs/remotes/%s/HEAD..",
and it wasn't a common practice to interact with multiple remotes
with remote tracking branches (integrator interacting with dozens
of remotes, responding to pull requests using explicit URL but
without configured remotes was not uncommon), so it was sufficient
for "git clone" to create it, and "git remote add" did not exist
back then anyway.

There are two aspects in my answer to your question.

 - If we create additional remote (that is, other than the one we
   get when we create a repository via "clone", so if your "origin"
   is from "git init there && cd there && git remote add origin", it
   does count in this category), should we get a remote-tracking
   symref $name/HEAD so that we can say "log $name.."?  

   We absolutely should.  We (eh, rather, those who added "remote
   add"; this was not my itch and I am using "royal we" in this
   sentence) just did not bother to and I think it is a bug that you
   cannot say "log $name.."  Of course, it is just a "git symbolic-ref"
   away to make it possible locally, so it is understandable if
   "remote add" did not bother to.

 - When we fetch from a remote that has refs/remotes/$name/HEAD, and
   if the protocol notices that their HEAD today is pointing to a
   branch different from what our side has, should we repoint ours
   to match?  

   I am leaning against doing this, but mostly out of superstition.
   Namely, I feel uneasy about the fact that the meaning of "log
   ..origin" changes across a fetch in this sequence:

     log ..origin && fetch origin && log ..origin

   Without repointing origin/HEAD, two occurrences of "log ..origin"
   both means "how much ahead the primary branch we have been
   interested in from this remote is, relative to our effort?".
   Even though we fully expect that two "log ..origin" would report
   different results (after all, that is the whole point of doing
   another one after "fetch" in such a sequence like this example),
   our question is about the same "primary branch we have been
   interested in".  But once fetch starts messing with where
   origin/HEAD points at, that would no longer be the case, which is
   why I am against doing something magical like that.

