Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F571F954
	for <e@80x24.org>; Sat, 18 Aug 2018 21:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHSBDB (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 21:03:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45620 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeHSBDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 21:03:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id s16-v6so6373337edq.12
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=z6Hv0iG2So0V+XkPFRyG7i25Re4Hk3ltdBwVru27160=;
        b=lSrnFMnatqGBQY8S4JHxlYxn+jRa1bE1iSbaEm4ZoO9P1URqI8LVO3jteDf8x63ySV
         qZ5EL+gLC9XoxgP4ov3jpMeMlxq5u/QHg7H6tXCfkhV4OA8LeAMuJ81jX1hUwIE3aGI4
         Yn2KqCL8ARmUmhUY9PbuffcOX9OBwr/8oCi60iZAJy5fkEm4sWFMiDxvzcwQvaJX6j3p
         b5JAKu3VzSyu6LvgWDlxmSx3M4R3RqARCm0SaRwbjQtQkPH05bp4CBzcsbiCDRewLZnM
         /vHOPJ8BoTtEdvYoRwQE/RE1FvCVbzjj8O4sobyCib3nNIV8rKwqXc/PScsxIHcRSPTv
         UDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=z6Hv0iG2So0V+XkPFRyG7i25Re4Hk3ltdBwVru27160=;
        b=QspEJ78w+/0zGn0Rt1XDvTRsHi2dbwgrevqLJMEGSK/y1EwpJyWIFoMb6iZ+2mLvec
         Jt1BGpFY2uuEpCR9mn9TiWonXfQgJZ053K/L8ALci6F/FXkS/JtOQN11ezGnVCIyywvX
         peH8cSxcril3byeiCxOHTXeeEj0KMlflqCD7v5Anp0jDn4vJ5JfnAYuzoLPA+mc9KrLh
         HodXVHNuXxXLLAD7BHrZojTtWyhHyLG1IysUsUDoOPI9EVxjUlLmsmoWMZA7Iw5qKMTv
         7bfIeCwASbulsZGNpSXzszdW9h7j7JTuUlD+7b/XjN0tI/57kU4KLYq4jyq4Itu5CGLR
         hIxg==
X-Gm-Message-State: AOUpUlHcPYvfjv7wa7NyOzhoNYabAyyN/tdGd/jn9kJILRA8lt1Ge/ld
        3/SKdX8vhGBuVmbI14Ea0yI=
X-Google-Smtp-Source: AA+uWPw8C4YYs0RVTjP48vlvzkq/PQ5yS7mQsnNk1bkOaoD6AqQFw6DDUqQQwogAZdM3NHCBCfsYzA==
X-Received: by 2002:a50:8f84:: with SMTP id y4-v6mr49463309edy.71.1534629232003;
        Sat, 18 Aug 2018 14:53:52 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id w3-v6sm5945272edb.16.2018.08.18.14.53.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 14:53:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Michael =?utf-8?Q?Mur=C3=A9?= <batolettre@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bug: Distributed bug tracker embedded in git
References: <CACSZ0Pwzs2e7E5RUEPDcEUsa=inzCyBAptU7YaCUw+5=MutSsA@mail.gmail.com>
        <20180818054300.GB241538@aiede.svl.corp.google.com>
        <874lfrrhfp.fsf@evledraar.gmail.com>
        <20180818204243.GA136983@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180818204243.GA136983@aiede.svl.corp.google.com>
Date:   Sat, 18 Aug 2018 23:53:50 +0200
Message-ID: <8736vbqr2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Aug 18 2018, Jonathan Nieder wrote:

> Hi,
>
> Ævar Arnfjörð Bjarmason wrote:
>> On Sat, Aug 18 2018, Jonathan Nieder wrote:
>>> Michael Muré wrote:
>
>>>> I released today git-bug, a distributed bug tracker
> [...]
>>> I am a bit unhappy about the namespace grab.  Not for trademark
>>> reasons: the Git trademark rules are pretty clear about this kind of
>>> usage being okay.  Instead, the unhappiness comes because a future Git
>>> command like "git bug" to produce a bug report with appropriate
>>> diagnostics for a bug in Git seems like a likely and useful thing to
>>> get added to Git some day.  And now the name's taken.
>>>
>>> Is it too late to ask if it's possible to come up with a less generic
>>> name?
>>
>> Wouldn't we call such a thing "git-reportbug", or "git gitbug", with
>> reference to Debian reportbug or perl's perlbug?
>
> I hope you're kidding about "git gitbug".

It sounds a bit silly, but such a tool is going to be rarely used enough
that we probably don't want to squat a 3 letter command to invoke it.

> [...]
>> 1) Accept the status quo where people do create third party tools, much
>>    of which are way too obscure to matter (e.g. I'm sure someone's
>>    created a tool/alias called range-diff before, but we didn't
>>    care).
>>
>>    If those tools become popular enough in the wild they get own that
>>    namespace, e.g. we're not going to ship a "git-annex" or "git-lfs"
>>    ourselves implementing some unrelated features
>
> That's fair.  Let me spell out my thinking a little more.
>
> This framework would lead me to rephrase my question to Michael a
> different way.  Instead of saying that I'm not happy with the
> namespace grab, I should say something more severe:
>
>   Don't be surprised if Git itself makes a "git bug" command in the
>   future, and be prepared to rename.
>
> Is that preferable, in your opinion?

We're not going to make some blanket policy that doesn't recognize the
difference between say git-lfs and git-tool_nobody_has_ever_heard_of,
and then decide that it would be just as reasonable for us to ship a new
git-lfs ourselves (which would do something different) as it were for us
to ship git-tool_nobody_has_ever_heard_of.

The reason I can drop a "git-whatever" in my $PATH and invoke it as "git
whatever" is just a historical accident of how git was implemented.

But because that feature has been exposed since the very beginning it's
become an implicit API. There's thousands of git-whatever tools, and
people do use these. The likes of git-lfs and git-annex are used a *lot*
more than some builtins we ship.

So we don't get to say "you never asked us about git-annex, we're using
that name now" without considering how widely used it is. It's us who
decided to expose the API of seamlessly integrating 3rd party tools.
