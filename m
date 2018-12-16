Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582331F405
	for <e@80x24.org>; Sun, 16 Dec 2018 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeLPLsF (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 06:48:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37495 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbeLPLsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 06:48:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so8457864edb.4
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=DVPK9Cqdh1hKMpoE3NjAFkzGDOsUdRU26EcCjwugsBI=;
        b=O0Jr7NIs4wVnauSU19bY4CHGl7Kb7rGYbLJvcLbzGo4klbFxwf8lOeo7jqgsScAzrA
         mtezNFFbSW3ITXa6Is4d+YYglpzPC6SDMlMGTdZkCVDUFpsIeKjgkgNnjUyHeGeuvNTr
         u7n1epqkiZT5xRJ1KH4LWTIJmtGmqhiRguW3V/ToU/5XNCrbnoRTthSNDZ8Jqim00aOg
         bQwB4BCFXJ70aq9wCcI7MG4oIeWZoxBl+MLngpJUyG1eaAiD2tYlVQIOW5+4etBBz3Lj
         HZzgImpVf/Q2NCrbiw/ZyzvxjFZvh1mANdtqutV+sgdyv251sC0KC6o5Bl4r3gAakKBE
         ERlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=DVPK9Cqdh1hKMpoE3NjAFkzGDOsUdRU26EcCjwugsBI=;
        b=j2iitnONLPVdBpZc45HsmERgkab0lxIjUqg6b3vN1aSGbN9KcOnFBp6cyvBjbxtUG3
         KzEQTTR8DlfBkG948168j8xTAPV1S0tE0xuzjsCf0pPLqC4LsDGIkAdrYWI8olOp0WSz
         5ewN8+nNyABp1T+c8egmUAlmHSTnYv2OzKSX3WAsHuhMvBNLvfSKmxuSWbNYs3DM2rk7
         XyWV3K++u9libZ9iPuUjx6SEZUUXEu5A02kQorI46n/CZYoBr9JdaTXlS7GPp/bNgKRp
         dd6ggV2ihR+L2bdSdiXfCuJc+uz1LtNZXEUYWFGx/DgXK2wz8Ys6hutp3Li2a0YdbGMX
         LZFg==
X-Gm-Message-State: AA+aEWaqsrHGkwrVJjpUUyrsgq+//BMaW99oL0fl6JX81o11XuwPcMqX
        fjzykVR9bVW3iyPqpsQYQp2C7KoO
X-Google-Smtp-Source: AFSGD/VnemyPVOuHgmeCGdfofiejw+d0dn2GyVBb0YBAdEcz1Fl7ZmjYhyqecCXyp0OWVbGYeyWuNQ==
X-Received: by 2002:a17:906:3548:: with SMTP id s8-v6mr7241302eja.161.1544960882620;
        Sun, 16 Dec 2018 03:48:02 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id n11-v6sm1483513ejh.74.2018.12.16.03.48.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 03:48:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        bwilliamseng@gmail.com
Subject: Re: [PATCH 0/3] protocol v2 and hidden refs
References: <20181211104236.GA6899@sigill.intra.peff.net>
        <20181213195305.249059-1-jonathantanmy@google.com>
        <20181214083507.GB11777@sigill.intra.peff.net>
        <87d0q21s8w.fsf@evledraar.gmail.com>
        <20181216104017.GB13704@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181216104017.GB13704@sigill.intra.peff.net>
Date:   Sun, 16 Dec 2018 12:47:59 +0100
Message-ID: <87bm5l1ymo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Dec 16 2018, Jeff King wrote:

> On Sat, Dec 15, 2018 at 08:53:35PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
>> > So I'm a bit worried that the unified endpoint model is going to be a
>> > dead end, at which point carrying around git-serve just makes things
>> > more complicated.
>>
>> This is from wetware memory of something discussed at a previous Git
>> Merge, so I may have (inadvertently) made it up, but wasn't part of the
>> idea of "git-serve" to have an extensible next-gen protocol where we
>> could add new actions & verbs unrelated to sending or receiving packs?
>
> Yes, I think that's a goal (and we already have upload-archive, which is
> a similar thing).
>
>> Of course that's not in itself an argument for having a general "serve"
>> command, actually the opposite for the reasons you mention with locking
>> down things. E.g. maybe I want to support server-side git-grep on my
>> server, but not git-log, and if it's one command it becomes a hassle to
>> do that via SSH config or HTTPD config for the reasons you mention.
>
> Right, exactly. It pushes more of the information down into Git's own
> protocol. Of course we _can_ build mechanisms at that level for
> configuring which verbs are allowed. But if some context is available at
> the higher protocol level, then we can use the mechanisms at that higher
> level.
>
> I think of it as a tradeoff. By including the endpoint in the transport
> protocol (e.g., in ssh the command name, in HTTP the URL), we get to use
> the mechanisms in those transports to make policy decisions on the
> server. But it also means we _have_ to implement those policies twice,
> once per transport.
>
> IMHO having to deal with both transports is not that big a loss,
> considering that there are only two, and really not likely to be more.
> git:// is already unauthenticated, and IMHO is mostly a dead-end for
> future protocol work since it provides no advantage over HTTP, and the
> future is mostly HTTP, with ssh for people who really prefer its
> authentication mode.
>
>> The upside would be that once a host understands "git serve" I'm more
>> likely to be able to get past whatever middle layer there is between my
>> client and the "git" binary on the other side. E.g. if I have a newly
>> compiled "git" client/server binary, but something like GitLab's
>> "gitaly" sitting between the two of us.
>
> But I think that's what makes it dangerous, too. :)
>
> Gitaly (and we have our own equivalent at GitHub) is responsible for
> making those policy decisions about who can run what. Opening a pipe
> between the client and the backend that can issue arbitrary verbs is
> exactly what they _don't_ want to do.
>
> So they have to intercept the conversation at least at the verb level.
> It _is_ nice if conversation for each verb is standardized (so once a
> verb is issued, they can just step out of the way and proxy bytes[1]),
> and v2 helps with that.
>
> That's not too hard for a Git-aware endpoint to implement.  But when
> that verb interception can be done at the HTTP/ssh level, then it's easy
> for tools that _aren't_ Git-aware to do handle it (again, like the
> Apache config we recommend in git-http-backend(1)).
>
> -Peff
>
> [1] Actually, we do much more intimate interception than that at GitHub
>     already. The upload-pack conversation is mostly vanilla, but for
>     receive-pack we handle replication at that layer. So your pack is
>     streamed to 3-6 backend receive-packs simultaneously, and that
>     endpoint layer handles quorum for updating refs, etc.

Yeah I think overall this makes sense. I was just thinking we'd have
stuff like this needing to be maintained in all middleware:
https://gitlab.com/gitlab-org/gitlab-shell/blob/v8.4.4/lib/gitlab_shell.rb#L15-28

Which, if and when we have a lot of verbs would be a pain, but of course
server operators might want to explicitly whitelist them.

Also for things like "git-grep" I can see e.g. "no POSIX regex" (due to
well known DoS issues0 being a configuration we ourselves would want to
carry, at that point server operators would need to maintain two
whitelists anyway, one in their custom code & another in /etc/gitconfig.

But I think that trade-off is worth it as you note because when you want
to filter these it's handy to be able to do it in a dumb ssh/web server.

Another thing to consider is not having a proliferation of things in
git-<TAB> completion again. AFAIK these things can't have spaces in them
for /etc/passwd & inetd tab completion. So perhaps call them all
git-serve-*, or not put them in our bin/ install path as a special case?
