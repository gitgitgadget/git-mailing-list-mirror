Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED061F403
	for <e@80x24.org>; Mon, 11 Jun 2018 18:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933923AbeFKSKP (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 14:10:15 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:42969 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSKO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 14:10:14 -0400
Received: by mail-ot0-f193.google.com with SMTP id 92-v6so24862659otw.9
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 11:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=S+LtmzR2sjGgpSZG7GrGdqaGAg0DgHezIgaULNIvqVs=;
        b=UvEIiF+Syd95KHn4HjAj47ym1DI9U+BtaVDxXpIxGBnfqNH26SpyWPvwRBG7s9To1O
         rWwJgFvctRJk0qdcXrR72eVXo5I0X6zKH0VzmF+8kd20MW3SfqVUWGcLrST/gfn17N8e
         PZ+TlIF2gDyQWunwB+QENX56VqXqG5hyFKmUqc2Wzwufd4szd4pMcoX4DuxFuEIBJmwc
         98y1nJdfHHENImWEMOJskqXqir+7YIBXKDb9aNo4fkIzMY133vGFtJptF5TZFwPd5dRN
         ERqY4k507uI/VC3nGm0qWTX7LrIkoCTQUPDSZrG3PFbbWcIPbATIHF0Lke9Pj7NF6+BV
         jmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=S+LtmzR2sjGgpSZG7GrGdqaGAg0DgHezIgaULNIvqVs=;
        b=GGK0Y0FIFZi4vbu4nrZsOPtbuw/KD7vI/AM3v3G5llAbQBsTYaH8HZfeYYr+7lPikL
         48HV0kNqkVIGeeBoPKmduQ+Q+KzTuNvNlzepNY4OG4E5eSnu675LTjv3gHDtcPByCuCA
         XEVd1fC6tC04so0dK/SlMP31IQgMBkSKpgE6STuUH8aiLvMNuL3IV35cvJURb5I6MybJ
         OrI5PLmANt84ZatScxs4ID1uewi9//Fvse624A6sAML5eKQ3VkZXc+X3xAy2wLI7upFQ
         7yWnT40s2Vt3BPGZLljl8mRhOyh1JJYkhmP/svp+ojz1zWhqPzljFoGJ3F6+ncnmUCMu
         kMBQ==
X-Gm-Message-State: APt69E1K27oTt9Azqgbi2tEUAhTM5ObMGyZnbyRN+KLpSAiEpCfiQThT
        FIWd4zKFJyuFyob2Hc01kthcJMyB79Bpi8+HwOE=
X-Google-Smtp-Source: ADUXVKIqiDEd+Zt+w7XHwuTvgUFGoSpEG3cqiACHZ2+kXMxmjmlqYo1aHW182w6jeVP9jx1XK0jmSsajCzVOOzDmEfE=
X-Received: by 2002:a9d:2989:: with SMTP id n9-v6mr181115otb.152.1528740614205;
 Mon, 11 Jun 2018 11:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
In-Reply-To: <20180609205628.GB38834@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 11 Jun 2018 20:09:47 +0200
Message-ID: <CACsJy8CJrFCUnVMes=3_gQKNTiyHsKkawWNQ1aB_GCvOh1rKcw@mail.gmail.com>
Subject: Re: State of NewHash work, future directions, and discussion
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 9, 2018 at 10:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Since there's been a lot of questions recently about the state of the
> NewHash work, I thought I'd send out a summary.
>
> == Status
>
> I have patches to make the entire codebase work, including passing all
> tests, when Git is converted to use a 256-bit hash algorithm.
> Obviously, such a Git is incompatible with the current version, but it
> means that we've fixed essentially all of the hard-coded 20 and 40
> constants (and therefore Git doesn't segfault).

This is so cool!

> == Future Design
>
> The work I've done necessarily involves porting everything to use
> the_hash_algo.  Essentially, when the piece I'm currently working on is
> complete, we'll have a transition stage 4 implementation (all NewHash).
> Stage 2 and 3 will be implemented next.
>
> My vision of how data is stored is that the .git directory is, except
> for pack indices and the loose object lookup table, entirely in one
> format.  It will be all SHA-1 or all NewHash.  This algorithm will be
> stored in the_hash_algo.
>
> I plan on introducing an array of hash algorithms into struct repository
> (and wrapper macros) which stores, in order, the output hash, and if
> used, the additional input hash.

I'm actually thinking that putting the_hash_algo inside struct
repository is a mistake. We have code that's supposed to work without
a repo and it shows this does not really make sense to forcefully use
a partially-valid repo. Keeping the_hash_algo a separate variable
sounds more elegant.

> If people are interested, I've done some analysis on availability of
> implementations, performance, and other attributes described in the
> transition plan and can send that to the list.

I quickly skimmed through that document. I have two more concerns that
are less about any specific hash algorithm:

- how does larger hash size affects git (I guess you covered cpu
aspect, but what about cache-friendliness, disk usage, memory
consumption)

- how does all the function redirection (from abstracting away SHA-1)
affects git performance. E.g. hashcmp could be optimized and inlined
by the compiler. Now it still probably can optimize the memcmp(,,20),
but we stack another indirect function call on top. I guess I might be
just paranoid and this is not a big deal after all.
-- 
Duy
