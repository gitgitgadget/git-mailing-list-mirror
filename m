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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBAE1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 15:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeJCWIf (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 18:08:35 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33138 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeJCWIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 18:08:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id g26-v6so5739076edp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 08:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=9NM2grs9soOCxy+Ssx4bb/qep9sqkp3EXELZATzZ9JY=;
        b=prlIyWHpU6CTeeOlvF6roHore07WS2Xn9G+1awQg5BBG1cEltKNgOIbkU2R7TI1+It
         I4U0+0jXaS3Xkmq4VJ/CKmsW1i5i/OzsBzBpCaXaldNtmWOJKTz5yhj8c3jIp8mSgyIO
         HjyrFMdwcBgxP9F5jRxCTPlPa+2CMtNMuLETpolwSZ7kp3J6AtfFE46K1D4kQD376US6
         Igqys0F34f999VNOqkZp2JHOPK6sblT8ixlKJwox3QI1mvSyeP+KgphcmowUYVez224Y
         B7g8Qk3UK1jbLx3GJxs8y9DFFzP791kbe2qOqpwGsMpflBWZf5RXFqyFFAetMl75a676
         V+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=9NM2grs9soOCxy+Ssx4bb/qep9sqkp3EXELZATzZ9JY=;
        b=V/rR8mjqxBpKhUDg7m0aaEE1yne7oikMHe+XLfmZKf/BNwEgIH6l4cmNubSBRwWOoV
         KzURgfm7vm/OgtB4O+tL6viqFzal2WOSMyyhkSND+lDoyCxB5hpbOwbp37bXMM8YQgUN
         Wh4uVHhxXIrQJkidkanrxosJp2hhpyiRY+w6cwcA4lV35CIhHO+WhrjCh4nZvnvWOuQE
         G7IdgwYQ56qZYYFD+CZQQdVOEwEly4mZ/BviofDgCrVbkoFqnAYbbWCtxIaDpBj+SOoE
         n3dvZVTDwu49KBKFtiUQT3FbjXqIDmnTvVJttkYvlQmL1JXo/TFyQPr6FHesdMarKxd5
         ZfMQ==
X-Gm-Message-State: ABuFfoh1d77MF3zl5V7F/mRLKxSI0Vn0UJLsVzTMmbftotBo1HihqgLC
        TUNsn5AdaIHV1JY5RtOiUNgj5+ov
X-Google-Smtp-Source: ACcGV62+z9MOWJwRlZynM1uQKXQKVAHzLprk7RMg+oFFBgPDKMCX+3yupHF4lheITV1IB46Pe98wfg==
X-Received: by 2002:a17:906:33c7:: with SMTP id w7-v6mr2461394eja.28.1538579983102;
        Wed, 03 Oct 2018 08:19:43 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id b26-v6sm550199edw.0.2018.10.03.08.19.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:19:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost> <87r2h7gmd7.fsf@evledraar.gmail.com> <20181003141732.GO23446@localhost> <87o9cbglez.fsf@evledraar.gmail.com> <20181003145308.GP23446@localhost>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181003145308.GP23446@localhost>
Date:   Wed, 03 Oct 2018 17:19:41 +0200
Message-ID: <87murvgir6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 03 2018, SZEDER Gábor wrote:

> On Wed, Oct 03, 2018 at 04:22:12PM +0200, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Oct 03 2018, SZEDER Gábor wrote:
>>
>> > On Wed, Oct 03, 2018 at 04:01:40PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> >>
>> >> On Wed, Oct 03 2018, SZEDER Gábor wrote:
>> >>
>> >> > On Wed, Oct 03, 2018 at 03:23:57PM +0200, Ævar Arnfjörð Bjarmason wrote:
>> >> >> Don't have time to patch this now, but thought I'd send a note / RFC
>> >> >> about this.
>> >> >>
>> >> >> Now that we have the commit graph it's nice to be able to set
>> >> >> e.g. core.commitGraph=true & gc.writeCommitGraph=true in ~/.gitconfig or
>> >> >> /etc/gitconfig to apply them to all repos.
>> >> >>
>> >> >> But when I clone e.g. linux.git stuff like 'tag --contains' will be slow
>> >> >> until whenever my first "gc" kicks in, which may be quite some time if
>> >> >> I'm just using it passively.
>> >> >>
>> >> >> So we should make "git gc --auto" be run on clone,
>> >> >
>> >> > There is no garbage after 'git clone'...
>> >>
>> >> "git gc" is really "git gc-or-create-indexes" these days.
>> >
>> > Because it happens to be convenient to create those indexes at
>> > gc-time.  But that should not be an excuse to run gc when by
>> > definition no gc is needed.
>>
>> Ah, I thought you just had an objection to the "gc" name being used for
>> non-gc stuff,
>
> But you thought right, I do have an objection against that.  'git gc'
> should, well, collect garbage.  Any non-gc stuff is already violating
> separation of concerns.

Ever since git-gc was added back in 30f610b7b0 ("Create 'git gc' to
perform common maintenance operations.", 2006-12-27) it has been
described as:

    git-gc - Cleanup unnecessary files and optimize the local repository

Creating these indexes like the commit-graph falls under "optimize the
local repository", and 3rd party tools (e.g. the repo tool doing this
came up on list recently) have been calling "gc --auto" with this
assumption.

>>  but if you mean we shouldn't do a giant repack right after
>> clone I agree.
>
> And, I also mean that since 'git clone' knows that there can't
> possibly be any garbage in the first place, then it shouldn't call 'gc
> --auto' at all.  However, since it also knows that there is a lot of
> new stuff, then it should create a commit-graph if enabled.

Is this something you think just because the tool isn't called
git-gc-and-optimzie, or do you think this regardless of what it's
called?

I don't see how splitting up the entry points for "detect if we need to
cleanup or optimize the repo" leaves us with a better codebase for the
reasons noted in
https://public-inbox.org/git/87pnwrgll2.fsf@evledraar.gmail.com/
