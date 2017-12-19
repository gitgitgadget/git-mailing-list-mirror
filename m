Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5EA21F406
	for <e@80x24.org>; Tue, 19 Dec 2017 13:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763180AbdLSNze (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 08:55:34 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:34267 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763174AbdLSNzd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 08:55:33 -0500
Received: by mail-wr0-f172.google.com with SMTP id y21so19391358wrc.1
        for <git@vger.kernel.org>; Tue, 19 Dec 2017 05:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eAJR1snEJ1bK3IiERAuZrJxPlQHCPEc9aQIIT1cxdlk=;
        b=tMl849XiLK1wbAyO/Lb7zgeIvBu+n7RbUqgg9jkf2/hO3ZMpxeT6Qhh/Arzij6rOwo
         hxn3sGVLCM8UGmf3rv/cWkecsuVg989k0ot5Fc3ahLhfkZp1BpK6zxknS37q5Oi/eJpI
         wZApRyokMlhwcKKmuWy5qFMGXOf/CADqHnDSJKK//TlwE5JsZIO0VGXrtEuU54O49oeb
         bNRenACfwolel4iDVnILnKxhahwCk+Kl62l421bMwWXejWTyB07BDDrWiHsxa7S//n85
         hW6a3SqTIM34RGn6K0E7RQ+g7LKzPMp2tYG19RTPLhnii0yHNLSA0AToKnDJlvtvQNhe
         T+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eAJR1snEJ1bK3IiERAuZrJxPlQHCPEc9aQIIT1cxdlk=;
        b=NpfPVidEkqkcP7KYodpURWjQHCOL2UZ5YO3LiQphjcTiUQ7eSar6qkTEd2cleivC9u
         +dVowSewv+4T9urdbZjHLYiNRpa/O3mKE9MnnzkZfPTIOro5mNQlrKFRw9Up4iO149dn
         StQpCBJ8xvs1nM39oNqnldfbg1yFJ268qbMNBKMvM8+ZYks0FELcJ499YAPGxWn8VbBA
         4ykqqBQhb+JIPhkaQQlWyNS4KpUdaCr6u9+GZTU40LW9goQdm698jwh53Rv923zztgG9
         5fod3g587Zt67402xOGTrojw1Jkl49pG1UMTAtlRXOK7kHfxxV5j3F8rIG10D4TebQHD
         hR3g==
X-Gm-Message-State: AKGB3mJfNDYat/nciF8bpRUeGdeaoNZV5AkVHleyTtANXrdlHbgtzql9
        ETbtLld/P9Aqgh4lO8QZBv+BSKQH
X-Google-Smtp-Source: ACJfBovPwgUO54syfSEc5MuFf4FgRcGnwU5DrmOPEPvRfBu3G8SMliyy7+MSkXncwpcFaRv4YW4ANw==
X-Received: by 10.223.141.133 with SMTP id o5mr5333390wrb.35.1513691732277;
        Tue, 19 Dec 2017 05:55:32 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id 62sm2511943wmo.33.2017.12.19.05.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Dec 2017 05:55:31 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eRIMk-0002fb-8X; Tue, 19 Dec 2017 14:55:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Satyakiran Duggina <satya0521@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Allowing remote git repos to set config & hook configuration
References: <CAMZug24WGWS3TaNPOVWPufGZ+67EbLggr4W3pxJtis9X375mag@mail.gmail.com> <CAGyf7-F8cCprvK-e2S0kO0Wo+6n4m_gigpSQjCjSj-dhozMsMw@mail.gmail.com> <CAMZug26A0e=AunMOjZNC_xH2E5uqHe46mt6=jawWe7ozF=Jn0Q@mail.gmail.com> <20171216095357.GB32706@sigill.intra.peff.net>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <20171216095357.GB32706@sigill.intra.peff.net>
Date:   Tue, 19 Dec 2017 14:55:30 +0100
Message-ID: <87zi6eakkt.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Dec 16 2017, Jeff King jotted:

> On Fri, Dec 15, 2017 at 12:48:07PM -0800, Satyakiran Duggina wrote:
>
>> To give the code pullers a chance to review, can we not have a
>> `trusted-hooks: default` and `trusted-SHA: <some sha>` field in .git/.
>> I'm assuming githooks/ are source tracked here.
>>
>> When developer tries to execute `git commit`, git can ask developer to
>> change `trusted-hooks` field to true or false. Let's say developer
>> sets it to true, git can record the SHA. If any latest pull has the
>> hooks changed, git can revert the `trusted-hook` to default.
>>
>> This way there is not much hassle for developers to manually copy
>> hooks all the time. And at the same time, they are not running scripts
>> that they haven't reviewed.
>
> We've talked about doing something like this (though more for config
> than for hooks). But what the discussion always come down to is that
> carrying a script like "import-hooks.sh" in the repository ends up being
> the exact same amount of work for the developer as any git-blessed "OK,
> trust these hooks" command.
>
> And it's a lot more flexible. The writer of that script can touch hooks,
> config, etc. They can base decisions about what values to use based on
> data that Git otherwise wouldn't care about (e.g., uname). And they only
> have to handle cases that the project cares about, whereas anything Git
> does has to work everywhere.

I brought this up at the dev meeting we had in NYC (and you can see how
much I care since it's not implemented): It would be really neat to have
a system supported in git which would work the same way Emacs treats
safe file variables:
https://www.gnu.org/software/emacs/manual/html_node/emacs/Safe-File-Variables.html#Safe-File-Variables

I.e. git would recognize a .gitconfig and .githooks/* shipped in any
repo, but completely ignore those by default, but you could then set
config (in .git/config or ~/.gitconfig etc) which would whitelist
certain types of config brought in from the repo.

This is how Emacs does it and it strikes a really good balance between
security and convenience, e.g. I can say a file is allowed to tweak my
tab width settings, but can't alter my load path, or is allowed to
specify a syntax highlighting mode etc.

So you could for example say that any repo you clone is allowed to alter
the value of sendemail.to, or the value of tag.sort. It would work
really well with includeIf, e.g. I could clone all my work repos to a
"safe" area in ~/work which is allowed to set more options,
e.g. aliases.

Other values would either be ignored, or you could set them to "ask", so
for example, when we clone a bunch of config would be accepted because
you'd said it was OK for any repo, and then client would ask you if you
wanted to setup a hook the repo is suggesting.

This would be a much better user experience than every repo that needs
this suggesting in a README that you should run some local shellscript,
and would strike a good balance between security and convenience since
we'd ignore all of this by default, with the user needing to granularly
opt-in.
