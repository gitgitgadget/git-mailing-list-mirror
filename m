Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F001F453
	for <e@80x24.org>; Thu, 27 Sep 2018 20:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeI1DBj (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 23:01:39 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34582 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeI1DBi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 23:01:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id q19-v6so6289360edr.1
        for <git@vger.kernel.org>; Thu, 27 Sep 2018 13:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=UX2sfCza/2jg5jZUc54Q5CC+npgXZxTdSkDIDS5rzJM=;
        b=TU+XYbCQBqosE3In3bLrI6ZrteoY0w6xXV84Fu3sKAdU0Yxgnyw6T54Q3T+0iFr2Lr
         AJUnG1HJuFn3S3JwpNpdLg0mpfd6T0/WurLOVQqz4pLN1uSOAk1LwDpTETjmo5OQ4hc1
         7db3mZUI3bIEr841h6m+/66QQlmSI0iJmtxvNqTaT8GnBte0WPYc+MU2jfS0pNs2FvVl
         /A7jyAlUEOxXlyM0KKPSgHv4wkB+QRRI21mB7gW+S/Ak3K51H372M+FWzmonQJT8Ph5J
         CdzSTJJ5OZa+G2S1GwG8ufjVHe6zpel9kz8dWBXuo4J37zPmnnxIrpzt2XPnUOS7UKwP
         3r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=UX2sfCza/2jg5jZUc54Q5CC+npgXZxTdSkDIDS5rzJM=;
        b=Uy/uXa8Ketv4Z98K0UlWNdzE1+rzsgz1gh1KnXdM9BUIS43n7BHEbQwDv1V/fwU1U4
         zVUV5ZrXkjLckBNsfpy/MhQ3C8wrA8x/YeutqL2hn2cHkkWaEsgK4b2X9haOy/6b9ITT
         QJP+J4uigoDhor6viw4bebHsYhaPARXjZtmLxoZbC0yZZn1k6js9YtYWxidcXrEXEFvk
         zGJPOwZpWLou3JwDpm8Kkl4sOUkIl/MralfMnH7DegCKzRK9yeipEfup2O8fvrv7vVnz
         lpZPZOV0d3/Zpmby6Etac8iu9j8Uui1P3FCDSAVqx7uRhRTYfQmlVCpDmGKrfTWBy2zK
         4fUw==
X-Gm-Message-State: ABuFfojAR5ghgi8cMMfSse/3pT4HhZENv+DPqUVXH/miDSNTJkNi4xfK
        6JhxTgTGghnJTcyzAJGgdGb6JDmc0P8=
X-Google-Smtp-Source: ACcGV612lqAeevVV1YEdjH38vGnYrMvm/B/Kvy1/NJCcTcPoJswkF02ughTF9FllS6YU7H2xozN/Mg==
X-Received: by 2002:a50:90a6:: with SMTP id c35-v6mr5493460eda.31.1538080891133;
        Thu, 27 Sep 2018 13:41:31 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b58-v6sm3567321ede.37.2018.09.27.13.41.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:41:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] negotiator: improve recent behavior + docs
References: <87in4tu6wb.fsf@evledraar.gmail.com> <20180927194125.8380-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180927194125.8380-1-jonathantanmy@google.com>
Date:   Thu, 27 Sep 2018 22:41:29 +0200
Message-ID: <87o9ciisg6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 27 2018, Jonathan Tan wrote:

>> > If you wanted to do this, it seems better to me to just declare a "null"
>> > negotiation algorithm that does not perform any negotiation at all.
>>
>> I think such an algorithm is a good idea in general, especially for
>> testing, and yeah, maybe that's the best way out of this, i.e. to do:
>>
>>     if git rev-parse {}/HEAD 2>/dev/null
>>     then
>>         git fetch --negotiation-tip={}/HEAD {}
>>     else
>>         git -c fetch.negotiationAlgorithm=null fetch {}
>>     fi
>>
>> Would such an algorithm be added by overriding default.c's add_tip
>> function to never add anything by calling default_negotiator_init()
>> followed by null_negotiator_init(), which would only override add_tip?
>> (yay C OO)
>>
>> If so from fetch-pack.c it looks like there may be the limitation on the
>> interface that the negotiator can't exit early (in
>> fetch-pack.c:mark_tips). But I've just skimmed this, so maybe I've
>> missed something.
>
> (I was reminded to reply to this offlist - sorry for the late reply.)
>
> I think too many things need to be replaced (known_common, add_tip, and
> ack all need to do nothing), so it's best to start from scratch. That
> way, we also don't need to deal with the subtleties of C OO :-)
>
>> Also, looks like because of the current interface =null and
>> --negotiation-tip=* would (somewhat confusingly) do a "real" negotiation
>> if done that way, since it'll bypass the API and insert tips for it to
>> negotiate, but it looks like overriding next() will get around that.
>
> If you do it as I suggest (in particular, add_tip doing nothing) then
> there is the opposite problem that it won't be easy to inform the user
> that --negotiation-tip does nothing in this case. Maybe there needs to
> be an "accepts_tips" field in struct fetch_negotiator that, if false,
> means that custom tips (or any tips) are not accepted, allowing the
> caller of the negotiator to print a warning message in this case.

Thanks, yeah it seems the interface would need to be tweaked for such a
"null" negotiator.

Some more general questions (which I can turn into docs once I
understand this). If I run this, as a testcase for two random repos
where I "fetch" an unrelated one and use the first ever commit to
git.git as an alias for this "null" negotiatior, i.e. "just present this
one commit":

    (
        rm -rf /tmp/git &&
        git clone https://github.com/git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add gitlab-shell https://github.com/cr-marcstevens/sha1collisiondetection &&
        GIT_TRACE_PACKET=/tmp/git/packet.trace git fetch --negotiation-tip=$(git log --reverse|head -n 1|cut -d ' ' -f2) gitlab-shell &&
        grep -c "fetch-pack> have" /tmp/git/packet.trace
    )

I get:

    warning: Ignoring --negotiation-tip because the protocol does not support it.

And the grep -c shows we tried to present 55170 commits in "have" lines
to the server. Now, change that to SSH and all is well:

    (
        rm -rf /tmp/git &&
        git clone git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add gitlab-shell git@github.com:cr-marcstevens/sha1collisiondetection &&
        GIT_TRACE_PACKET=/tmp/git/packet.trace git fetch --negotiation-tip=$(git log --reverse|head -n 1|cut -d ' ' -f2) gitlab-shell &&
        grep -c "fetch-pack> have" /tmp/git/packet.trace
    )

I don't understand this limitation. With the SSH version we skip
straight to saying we "want" with just the 1 "have" line of
"e83c5163316f89bfbde7d9ab23ca2e25604af290".

Why aren't we doing the same over http? I don't get how protocol support
is needed, it's us who decide to send over the "have" lines. Some
variant of this does work over "skipping":

    (
        rm -rf /tmp/git &&
        git clone https://github.com/git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add gitlab-shell https://github.com/cr-marcstevens/sha1collisiondetection &&
        GIT_TRACE_PACKET=/tmp/git/packet.trace git -c fetch.negotiationAlgorithm=skipping fetch gitlab-shell &&
        grep -c "fetch-pack> have" /tmp/git/packet.trace
    )

There we send 14002 "have" lines, which seems expected, but then with
the same thing over SSH we don't send any:

    (
        rm -rf /tmp/git &&
        git clone git@github.com:git/git.git /tmp/git &&
        cd /tmp/git &&
        git remote add gitlab-shell git@github.com:cr-marcstevens/sha1collisiondetection &&
        GIT_TRACE_PACKET=/tmp/git/packet.trace git -c fetch.negotiationAlgorithm=skipping fetch gitlab-shell &&
        grep -c "fetch-pack> have" /tmp/git/packet.trace
    )

So that seems like another bug, and as an aside, a "skipping"
implementation that sends ~1/4 of the commits in the repo seems way less
aggressive than it should be. I was expecting something that would
gradually "ramp up" from the tips. Where say starting at master/next/pu
we present every 100th commit as a "have" until the 1000th commit, then
every 1000 commits until 10k and quickly after that step up the size
rapidly.
