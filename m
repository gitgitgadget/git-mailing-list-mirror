Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F260A1F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 16:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbeKLCok (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 21:44:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43843 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbeKLCok (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 21:44:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id e4so5469409edv.10
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 08:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dJsrMVbU7QSnHZOjiYlDvH17Dg6z9sTSiScu44ViWGA=;
        b=aBqHv3sp0PtHnBkq+TT+dpSQO9ZW/UCmCrC2SFbp+Zy9qdjpGaturJ6vGvkhxXsXe6
         f/x4h/kTFggRdk2kizBFiSr6gbOoGqdlPrrZ08bc3wcHLhjHi1iM9H8b4JUZe9qTA91F
         xOwZRb4w99W+pGS31swiiU+dlV9z2J/JjkSCaG8kDljIiqwJl0dBrHYghNSghhoVhZm3
         YJroEJksYp3olVAgUX/VFO4ucnOV0WGr/vY7WXjFir7r1EWBWOJnAB5w9eLmidb73WG0
         AahJk2TrisOc4n33k0IWEOY7MONoAytgBi0UpdIuTt7KxNM55n/gmqiy8JhSXriS0RJi
         1vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=dJsrMVbU7QSnHZOjiYlDvH17Dg6z9sTSiScu44ViWGA=;
        b=sWSWg85+Dv9HQUVKNAPl3O8eezvL0p37w7l/dubeIPqrnxXtQz0yPuwR3Ti7Sg5VfY
         DxMaansYMgFqHv9N8R+F1678NKwQFf65ClMeEARkm5IkqgpWYNzEiqLlyrjYqvTuWUvj
         nBaRekD1fzCuWgZ0tk5wXmJaop62rB7YhywaZ5GTHRH55S6zCgdK7VMYIZ4b5Wc6xLww
         8Bdx60OeYnNKLqSY/0irOENV7lKmE41tt1zgMaDupumhR0xO0ULnX2dyNMYwNpFWZ0iO
         q4U1rrEqZGZNHQfJejV2Tyl3ghJLxYW1aRnV9EoUR7QUgNVxsaDnLBS8uEXLzpwYvibj
         jMYQ==
X-Gm-Message-State: AGRZ1gKKRCT3P+3mN+2zFZhePtMTdEjrfFRCN9/NmzkXI5+RqRZFRSNH
        F/Q28ERBIsOiMGSbJ6RZrlo=
X-Google-Smtp-Source: AJdET5fi3ip3kaErpMZiN0jY6+aBobl0jEfHk8OAzCaNnz1AuQMfSMW1iEHsuWwT+FVb/pnjQ+IQDA==
X-Received: by 2002:aa7:d145:: with SMTP id r5-v6mr8417228edo.65.1541955336234;
        Sun, 11 Nov 2018 08:55:36 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id i10-v6sm1980263ejh.71.2018.11.11.08.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 08:55:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        per.lundberg@hibox.tv, Junio C Hamano <gitster@pobox.com>,
        git@matthieu-moy.fr, Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <875zxa6xzp.fsf@evledraar.gmail.com>
        <20181111095254.30473-1-pclouds@gmail.com>
        <871s7r4wuv.fsf@evledraar.gmail.com>
        <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8CYpuc7-CZhk7kQQVQFxOfLFZu4TVpG=b0a7j8P1J394Q@mail.gmail.com>
Date:   Sun, 11 Nov 2018 17:55:34 +0100
Message-ID: <87wopj3661.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 11 2018, Duy Nguyen wrote:

> On Sun, Nov 11, 2018 at 1:33 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> The users who need protection against git deleting their files the most
>> are exactly the sort of users who aren't expert-level enough to
>> understand the nuances of how the semantics of .gitignore and "precious"
>> are going to interact before git eats their data.
>>
>> This is pretty apparent from the bug reports we're getting about
>> this. None of them are:
>>
>>     "Hey, I 100% understood .gitignore semantics including this one part
>>     of the docs where you say you'll do this, but just forgot one day
>>     and deleted my work. Can we get some more safety?"
>>
>> But rather (with some hyperbole for effect):
>>
>>     "ZOMG git deleted my file! Is this a bug??"
>>
>> So I think we should have the inverse of this "precious"
>> attribute". Just a change to the docs to say that .gitignore doesn't
>> imply these eager deletion semantics on tree unpacking anymore, and if
>> users want it back they can define a "garbage" attribute
>> (s/precious/garbage/).
>>
>> That will lose no data, and in the very rare cases where a checkout of
>> tracked files would overwrite an ignored pattern, we can just error out
>> (as we do with the "Ok to overwrite" branch removed) and tell the user
>> to delete the files to proceed.
>
> There's also the other side of the coin. If this refuse to overwrite
> triggers too often, it can become an annoyance. So far I've seen two
> reports of accident overwriting which make me think turning precious
> to trashable may be too extreme. Plus ignored files are trashable by
> default (or at least by design so far), adding trashable attribute
> changes how we handle ignored files quite significantly.

Yeah I'm not trying to make the argument that we should just go with
these user bug reports, clearly that's just going to give us selection
bias and we could continue to flip between the two behaviors with that
approach. Just that an advanced opt-in feature to prevent dataloss will
not prevent it in practice.

Is taking my patch the right thing? I don't know. I'm leaning in that
direction, but more making a devil's advocate argument to see if anyone
finds good cases that'll demonstrate how it's bad. I haven't read/seen
them so far, and the test suite didn't have any.

I did go through the list archives as Junio suggested in
https://public-inbox.org/git/7viq39avay.fsf@alter.siamese.dyndns.org/
and found these two:
https://public-inbox.org/git/?q=d%3A20070301..20070331+verify_absent

It seems to me that the reason we ended up with this behavior is a bug
report from Shawn that was describing a similar but not quite the same
problem:

    "[...]a bug in read-tree -m that prevents him from switching
    branches when the type of a path changes between a directory and a
    file.[...]"

That's not the same as when a now-tracked file clobbers a .gitignored
file. As far as I can tell (but may not have read carefully enough) that
wasn't a problem anyone reported, but was changed while fixing another
bug in c81935348b ("Fix switching to a branch with D/F when current
branch has file D.", 2007-03-15).
