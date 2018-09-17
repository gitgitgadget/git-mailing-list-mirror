Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8581F404
	for <e@80x24.org>; Mon, 17 Sep 2018 18:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeIRAKj (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:10:39 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55644 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeIRAKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:10:38 -0400
Received: by mail-it0-f65.google.com with SMTP id d10-v6so12557802itj.5
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 11:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBl8+4U2MbEhXBitkW1jYRmQQ8p1cMboOiso2pa3drc=;
        b=uMJcNnqsWE0i2zSr7M4hbqF8PF+nYkHpye8dmFss3tHZpo9iUWsdMFQfPFd5teMUNC
         +cd9q09ws0e06CDd4dNVEEPG6bZMpoSv55I1+Icq9OqNaKSyOjlyKMCeGsLpuCqHzIY9
         V10PcMxavzmZv9TDW9Fna0PIz59839o0enILA8kNCFu35Xr0KDf8ye67Bt9nEbJWdfRo
         k9SRmJxEb9k/YcqwCpQEmYNKsbl/NHj1baUAlyO1k0EjhqR0BSuSe2IOgQkJf/4jRAVj
         +5Quw6Jmp64bjqnTPM2ZaYwcOZBMvtc5BerTwjF8z+VmufW4732YEa9l2fA6XdSsoeie
         U04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBl8+4U2MbEhXBitkW1jYRmQQ8p1cMboOiso2pa3drc=;
        b=ldGM+9Fj1CHxdChPAuIlRZDpmgGGRIa8/DYbOGzxfx2jc8rt0qy24i0QvKq7sBr2F9
         zA8YiwDVpS512gqaNAuPX/smfvLo/hXxSXvVL6MZRvMamFGJv6pmaXbAdMttK7+O8SeZ
         CYXGeZLlhbkyo4L+n3ywp7rojZnxLrs1+mZc2hoVHBDG/le9U5Izsm/OHdHB0NOHEdmD
         tn+PYVlHKsqywW5Egc3uasrMQPgwac0MmDj84o90RW1ZuJQofLFxwgrEe7DcmHwXxnxG
         rSwOr/da5ShWen3ymE1xixIDQcBNEdCId01+jygFf/kth0vVibqr+KcNP75Yh1vG7nAw
         fsDw==
X-Gm-Message-State: APzg51Bq+rccW86gj6AO+k1GQAVIq0fG1PQV2oNqrbvJCvRZi2hV2A7e
        E/oj/RktUWOSo4jd4Rq2IHg7mBUJ2tRxIJ1iGMCc/A==
X-Google-Smtp-Source: ANB0VdbnjT7gQe5Zfwg22ieKcNCmSUGDdaG7I2SbApKtKt3bT4heh83DeTgJvCENrZInodwEEi4cgV7lL39piajBLig=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr13777075ita.5.1537209723063;
 Mon, 17 Sep 2018 11:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com> <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <20180917181511.GA3894@sigill.intra.peff.net>
In-Reply-To: <20180917181511.GA3894@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 17 Sep 2018 20:41:36 +0200
Message-ID: <CACsJy8CFf7mVMbxWO9ASfVKE_PLdiLmxSN3CuMC=_sEsL_5pmQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 8:15 PM Jeff King <peff@peff.net> wrote:
> On Mon, Sep 17, 2018 at 07:29:26PM +0200, Duy Nguyen wrote:
> > I don't see a good way to get to recover this situation. I could go
> > back to the "index log" idea, where we keep a log of index changes (or
> > just "interesting" changes). That way there's no behavior change at
> > all. The user who accidentally updates/deletes something can always
> > retrieve the old content back (assuming that they realize quickly
> > since we can't keep very long log).
>
> FWIW, I like that approach much better, since:
>
>   1. It does not bother or restrict anybody in their workflow; instead,
>      they pay the complexity price only when they know they have made a
>      mistake.
>
>   2. It covers many more cases (e.g., just doing the wrong thing via
>      "add -p").
>
> A naive index log would be pretty cheap in CPU, at least for POSIX-ish
> systems. You could just hard link "index" to "index.N" before renaming
> "index.lock" over "index". But I guess if you have a gigantic index,
> that's less appealing. So maybe storing the equivalent of a "--raw" diff
> between the two index states would make more sense (and after all, you
> don't really need the stat-cache or cache-tree). It would cost more to
> reconstruct the index on the fly, but then the point is that you would
> create these logs a lot more than you access them.

Yeah. The problem though is extracting the information out of these
index.N files.

> > I've been thinking about allowing to undo worktree changes too (e.g.
> > accidental "git reset --hard") and this log can cover it as well.
>
> I like that, too. It's a little more costly just because it may involve
> object-db writes, but I think in most cases it would be fine. I almost
> always "git stash" away discarded changes these days instead of "git
> reset --hard", because it effectively provides this kind of log.

Yeah the added cost is pretty much given. You want safety, you pay extra :)

> > The only downside is we need a new command for the UI (or perhaps I
> > can just add "git add --log" or something like that).
>
> I think the reflog approach has been successful: give these intermediate
> states a name. So in theory I could do something like:
>
>   git checkout -p :@{2.minutes.ago}
>
> though it would probably be useful to be able to walk the states, too,
> just like we have "log --reflog-walk".
>
> The syntax above is off-the-cuff (and based on the ":<stage>" index
> syntax). I guess if we had a separate log for "stuff in the worktree
> that got thrown away by reset" we might need a separate syntax.

I'm leaning towards reflog too. Not because of the syntax but because
of reusing the current code base. I don't have to worry about pruning,
walking, gc-ing... because it's pretty much already there. And the UI
is not so urgent since reflog file is very readable, early adopters
can just open the file and get the hash.

This also lets me handle logging worktree changes in the future
(keeping track of untracked files is impossible with the "index.N"
approach)

I'm trying to quickly make something that writes to
"$GIT_DIR/logs/index" and see how it goes. But yeah I'll probably drop
this patch. The ":@{2.minutes.ago}" just makes me like this direction
more, even though I don't know if I could even make that work.
-- 
Duy
