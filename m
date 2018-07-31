Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28A491F597
	for <e@80x24.org>; Tue, 31 Jul 2018 15:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732435AbeGaReX (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 13:34:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37450 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732364AbeGaReW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 13:34:22 -0400
Received: by mail-wr1-f68.google.com with SMTP id q10-v6so17198583wrd.4
        for <git@vger.kernel.org>; Tue, 31 Jul 2018 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qzA+c2SGZNImMTy0HHxodNMQGVf7Y0mhM/p6rj9stvI=;
        b=aSewrckAcQNzrRqXP/t3p2UpdYBbnjlvR2mvgk4diFTGiWNm63vffXG5LGMOMVY/UG
         GoQcyXuKrcNu9btoIGoAIyalwZxigxivcNv7hZhbWWtIofzdRbFMkRu9LDQqQLoUXMYr
         nphqI9OUHoQMon6IL+vV6t+ww/0Ycx/rTGmARkfFxxOMp4hnAFgZQnyn07Ht9vMTOu7g
         zI9yLdGaoli14W1LJQgQ001kBA38MMLNJqYEpYGPkq2S8nc5DLA9oHcaqGl/uvpPSGMH
         sIje1V7rVAukqhtbw8aSrXWnpH4aSN7t2mseQsAZzLwiZ3Y5PDZsza0I55mjQdkYiRbd
         NtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qzA+c2SGZNImMTy0HHxodNMQGVf7Y0mhM/p6rj9stvI=;
        b=bmqxs+yzN3UENYCaxYkJ1jZCmWPyjaCcJ8X8RSiVoJEtdBClu3/zuDtW9mcQ+zc+G4
         2iwgUpEP4oJyDEC00uVF1QQ8vHb2EN3EN/DteepF7TMK1MMAwsS2x4iEFJefe+32N92B
         Khs1oQMM8s6icfCjSesC8yvyhGec0ur31eZ+dPrhBuEQpwlobRdJolRahrKU8A84e6Kw
         tc4g8bMMHEUcAHBXiZiU55oduPmKtL2xDt2qnOc/7LLIw1qfH699ZvHnYT2H5q/bRJdJ
         z5T2SsvTohiw1LgoiSbiMnIzvWPhEsERP+D44ugkblN4rQzVYG1a0yIp2zwKwLukX0JR
         yztg==
X-Gm-Message-State: AOUpUlGEK1jpkACUvaaruTwFfjkTsxL340UWTmDTtULsbwcOCfk0wxmv
        AX0O/Dr83sTaMQ5jDcdIe+Y=
X-Google-Smtp-Source: AAOMgpcr+D4XNNxQA+wj3/ooJ+80J7zz+cRh17cZide0GmFhMc951IsXhEP+nIJ47MIUa/ao5VRKLA==
X-Received: by 2002:adf:ed41:: with SMTP id u1-v6mr20849335wro.262.1533052404888;
        Tue, 31 Jul 2018 08:53:24 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s5-v6sm18397231wro.33.2018.07.31.08.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 08:53:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        George Shammas <georgyo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git merge -s subtree seems to be broken.
References: <CAF1Ko+FBP5UmETmh071dvn9iv8-N-3YgaP61q-4jQvxFdN0GTA@mail.gmail.com>
        <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
Date:   Tue, 31 Jul 2018 08:53:23 -0700
In-Reply-To: <CAF1Ko+FNfjWMteccfKDBjPEW76rGBLQkGb1icUHmzEZ0fKQJBA@mail.gmail.com>
        (George Shammas's message of "Tue, 31 Jul 2018 11:03:17 -0400")
Message-ID: <xmqqtvofcsgc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

George Shammas <georgyo@gmail.com> writes:

> Bisecting around, this might be the commit that introduced the breakage.
>
> https://github.com/git/git/commit/d8febde

Interesting.  I've never used the "-s subtree" strategy without
"-Xsubtree=..." to explicitly tell where the thing should go for a
long time, so I am not surprised if I did not notice if an update to
the heuristics made long time ago had affected tree matching.

d8febde3 ("match-trees: simplify score_trees() using tree_entry()",
2013-03-24) does touch the area that may affect the subtree matching
behaviour.

Because it is an update to heuristics, and as such, we need to be
careful when saying it is or is not "broken".  Some heuristics may
work better with your particular case, and may do worse with other
cases.

But from the log message description, it looks like it was meant to
be a no-op simplification rewrite that should not affect the outcome,
so it is a bit surprising.
