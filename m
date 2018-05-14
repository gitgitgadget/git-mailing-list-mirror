Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 846651F406
	for <e@80x24.org>; Mon, 14 May 2018 03:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752102AbeENDdJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 23:33:09 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:41888 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeENDdI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 23:33:08 -0400
Received: by mail-qt0-f171.google.com with SMTP id g13-v6so14379958qth.8
        for <git@vger.kernel.org>; Sun, 13 May 2018 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=YO2Y3bJi6UsQwnBgSZOP31bjgGYwvyH4/SzM4Rv70zA=;
        b=bEkYr7cU4iefSvY4g0vW1s1a6Oeru7b9Ce0iyvoKwA2taq+eMp/3W1shYiwSem+Koo
         2MLB92mDepkM9DkFU/lClB6K3jRR2VLYdCbsnl9wOQkl5/FwnLNeDXXOeaL8vJsz2POd
         Jq1QZcLhcLqG1RkHNPct1i+zkdKxkZAncLmjEO6fpsCnorLV5QB0p1JAaHPamnS8SJ09
         KW16iPK5sahetHTO8NScSJqco4pTMW6OSBRhN2WrW02EaeUb7DhDd4jKImNnacF5DFQl
         TMPJRCH1wdzARWLwIsC48v4KbAicqMNT19o2s+N3PBGoVdIWTJGMwl84EawNlxLbZqmR
         l7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=YO2Y3bJi6UsQwnBgSZOP31bjgGYwvyH4/SzM4Rv70zA=;
        b=uDBJQ82VJt6u4ooRSL7YD3jcsOkV5K6yuWPNFwXAA3+vBktN0kUmul6ae3802ZmlOn
         nY1e8tU2rwoaTfycVWfiRAmAWU0LtHplDQmWD8qLc4WYcnGg/YUbnU9YhSWgZzLp7m3p
         bZix4ER+O4xar4GT3+2eIUoFvjCeXTRM1XsuVusmVtBLE/6IXNdcsgMZ902Pf17HrXb1
         ZO2NjusNYY3rMv/i3RMiwnZckxxDrPZGdWNPld6mp9WIpmJkG1WjD1gfXGAppZVKWOB+
         k/s4WzdL/OgqP+EfwLitzl/unXz98dI5+6xj/uo2hdiywXTTuyLPDtcVSwwZPpcEEd39
         8nTQ==
X-Gm-Message-State: ALKqPweEawcurkEYV9FEQN0+g3r7dSMR5M0vpoPg7bFYUhoGSoiwKS2Z
        YLiij/mJOLpQPdYUfD1n4w258emQONh1pcGntmA=
X-Google-Smtp-Source: AB8JxZqSsUFZEy5KfKwd2ufcqoeCLtWbKwJTtQxoUAoXsE8PcneD/7nArNTM6p1qyWKaYy2wmTBU9zCEFDU207w5RHI=
X-Received: by 2002:a0c:b7af:: with SMTP id l47-v6mr7431108qve.110.1526268787583;
 Sun, 13 May 2018 20:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Sun, 13 May 2018 20:33:07 -0700 (PDT)
In-Reply-To: <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com> <CAPig+cRkUrdtbyGEsY=DQCDoEWTrC-9n4=vKXHEap2gokB2uQg@mail.gmail.com>
 <CACsJy8BGs7EOYFKayL-bgvEbKOJiROF52o3SneLyG9Nm6nUngA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 13 May 2018 23:33:07 -0400
X-Google-Sender-Auth: vs6dyy2-WBCXrBJ9HX8hL55k7gM
Message-ID: <CAPig+cRUD7FnJqSZ=hkz0GAgOROiY+gvHKRjKVfkKtqDZyt5mA@mail.gmail.com>
Subject: Re: [PATCH/RFC] completion: complete all possible -no-<options>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 11:24 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Apr 23, 2018 at 7:36 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> I haven't looked at the implementation, so this may be an entirely
>> stupid suggestion, but would it be possible to instead render the
>> completions as?
>>
>>     % git checkout --<tab>
>>     --[no-]conflict=                   --[no-]patch
>>     --[no-]detach                      --[no-]progress
>>
>> This would address the problem of the --no-* options taking double the
>> screen space.
>
> It took me so long to reply partly because I remember seeing some guy
> doing clever trick with tab completion that also shows a short help
> text in addition to the complete words. I could not find that again
> and from my reading (also internet searching) it's probably not
> possible to do this without trickery.

Okay.

>> It's also more intuitive than that lone and somewhat weird-looking
>> "--no-" suggestion.
>
> It's not that weird if you think about file path completion, where you
> complete one path component at a time not full path, bash just does
> not show you full paths to everything.

The "path completion" analogy and the dotted configuration variable
analogy (below) don't really help me find "--no-" less weird. We're
used to "/" as a separator in paths, and "." a separator in
configuration variables, so they are easier to digest than "-" somehow
being a separator for --no-<option>.

It _might_ feel as bit less weird if it was presented as --no-<option>
or --no-{...} or --no-<...> or --no-... or something, but those seem
pretty weird too, so perhaps not. Anyhow, it's not a major issue; the
--[no-]foo idea seems pretty intuitive, but if it can't be easily
implemented, then falling back to your --no- idea makes sense.

> I'm arguing about this because I want to see your reaction, because
> I'm thinking of doing the very same thing for config completion. Right
> now "git config <tab>" gives you two pages of all available config
> variables. I'm thinking that we "git config <tab>" just shows the
> groups, e.g.
>
>> ~/w/git $ git config
> add.              interactive.
> advice.           log.
> alias.            mailmap.
> am.               man.
>
> Only when you do "git config log.<tab>" that it shows you log.*

Just wondering out loud (again): add.<var> | add.{...} | add.<...> |
add...; those aren't very attractive either, so plain "add." may
indeed be best.
