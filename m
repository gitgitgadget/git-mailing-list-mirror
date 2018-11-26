Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3E51F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbeK0C2q (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:28:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43443 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0C2q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:28:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so19363069wrs.10
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=KNi8THIbDm4ta35NuwvnlzUds7KbdYWgWq/ogEvgEsA=;
        b=oaL7qOWAeBuIAn6Z7c14bAD51j9U6ZuLkkDkJEDTefv1Gtilb5PxBeXyKS99WUWycw
         eokJGrk2DgLkY38iyDcRj6l6QwIXTUBtn6g8dRTFqth52y5IMy7VBmTEmp47NL1cvH4t
         Ao5CETFA0dspFw+o5LhGDdsMN5mi/uO6DENLQ5LWCfHKegYEDl+1YB42VOeupVk8g/Et
         My2F9LQH6/ktwdxkVdGOC1BKv1y9zojMhxp1hK8KeieimBfG4uyEWvUUqbyycEcSPKGk
         pg3pvVen/Qw2jGWSpSCCiuXXu91Jj2Ime8/lylH2FT8YvCdruBVQ6M2VUwulRB6NgEKk
         DTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=KNi8THIbDm4ta35NuwvnlzUds7KbdYWgWq/ogEvgEsA=;
        b=iCF1kAks8LHYAxDQazt6rlXYqcm0Ta+YrWxHh3Ew91vPN3lY/OSqnk/cn6/znjeQ0n
         Gu+z8uBTIm+LF5Y/v7p9Wk4yTxeat4BmRtd1xzSQZ16mq06Db99DJo1SjIEBsbk8CHeS
         6wKOfk5tXN5oZQ8/Tk4s2s+mm54x5FFqL9SLEuDIcIVrFriEoxsnZH+4XQPiPHNMBgPe
         X0cOIUYn/Zq0aJYuhZfzjHodPnn5df8vY7phvDm9xmtgsEW2AfuKwKDROpMfMKUIY5Nf
         L/u4uaFY6FVZWoHVCNPJqQmNNHNKT1HmVP2Vew9dWL8A87Yc4UNhavfWwIorP9LzYvHI
         WhzA==
X-Gm-Message-State: AA+aEWbIwvAdL9aZDIaKNYjqi8uBowBDaJOYuXvUg94VHJ4nkTPugQco
        5Rn8GvskqXFo+o7oRwaFigg=
X-Google-Smtp-Source: AFSGD/Uw61GUEeZp1yHo84/3+hL4CygR3Ua8ibplXvWPEGecmgnd+0CIfX5iJWn1d1r+RT3gL8AITQ==
X-Received: by 2002:adf:b502:: with SMTP id a2mr17878495wrd.264.1543246457162;
        Mon, 26 Nov 2018 07:34:17 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id z9sm734846wrs.63.2018.11.26.07.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:34:15 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     per.lundberg@hibox.tv,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net> <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
Date:   Mon, 26 Nov 2018 16:34:14 +0100
Message-ID: <87sgznzwcp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 26 2018, Duy Nguyen wrote:

> On Mon, Nov 26, 2018 at 10:30 AM Per Lundberg <per.lundberg@hibox.tv> wrote:
>>
>> On 11/13/18 1:22 AM, brian m. carlson wrote:
>> > This is going to totally hose automation.  My last job had files which
>> > might move from tracked to untracked (a file that had become generated),
>> > and long-running CI and build systems would need to be able to check out
>> > one status and switch to the other.  Your proposed change will prevent
>> > those systems from working, whereas they previously did.
>> >
>> > I agree that your proposal would have been a better design originally,
>> > but breaking the way automated systems currently work is probably going
>> > to be a dealbreaker.
>>
>> How about something like this:
>>
>> 1. Introduce a concept with "garbage" files, which git is "permitted to
>> delete" without prompting.
>>
>> 2. Retain the current default, i.e. "ignored files are garbage" for now,
>> making the new behavior _opt in_ to avoid breaking automated
>> systems/existing scripts for anyone. Put the setting for this behind a
>> new core.* config flag.
>>
>> 3. In the plan for version 3.0 (a new major version where some breakage
>> can be tolerable, according to Semantic Versioning), change the default
>> so that "only explicit garbage is garbage". Include very clear notices
>> of this in the release notes. The config flag is retained, but its
>> default changes from true->false or vice versa. People who dislike the
>> new behavior can easily change back to the 2.x semantics.
>
> How does this garbage thing interact with "git clean -x"? My
> interpretation of this flag/attribute is that at version 3.0 by
> default all ignored files are _not_ garbage, so "git clean -x" should
> not remove any of them. Which is weird because most of ignored files
> are like *.o that should be removed.
>
> I also need to mark "precious" on untracked or even tracked files (*).
> Not sure how this "garbage" attribute interacts with that.
>
> (*) I was hoping I could get the idea [1] implemented in somewhat good
> shape before presenting here. But I'm a bit slow on that front. So
> yeah this "precious" on untracked/tracked thingy may be even
> irrelevant if the patch series will be rejected.

I think a garbage (or trashable) flag, if implemented, wouldn't need any
special case in git-clean, i.e. -x would remove all untracked files,
whether ignored or garbage/trashable. That's what my patch to implement
it does:
https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/

I think that makes sense. Users running "git clean" have "--dry-run" and
unlike "checkout a branch" or "merge this commit" where we'll now shred
data implicitly it's obvious that git-clean is going to shred your data.
