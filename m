Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01701F406
	for <e@80x24.org>; Fri, 12 Jan 2018 14:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933873AbeALOob (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 09:44:31 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36640 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933764AbeALOoa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 09:44:30 -0500
Received: by mail-wr0-f181.google.com with SMTP id d9so5515867wre.3
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 06:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=XSjSzJ1uk3q+2nALlbr5hGh7BGU35L5lQOj/VHwmAjA=;
        b=tJj6sOmOQQ58SCgqeryWAJPV+ooDZf8A2adDxspruKOX0X3tZ5OWqoFLwAjKhXJEoY
         uJBZNbfRhgGnWnXmWylUWCfIDPbiv/8h2fifazcuduOsRbd5PsDfLIWP91PAeBsZ1jgu
         M8MpmrDVwtuZPzdoyAhiUQvoIsz1vBE4PYH2qqeB6bSgn9p+A8oJQnpUXYvEIzvpiFwd
         aBMeMUoOUO80rfdQQ4NQXgaZk6INMVjMl1yRacw4pSrsNiCFDUKsI6pu8B0hNJ5DuLjI
         cdjAVeTPiS+MW2rW/bj4xVtlGpZL3OReuSPsnXtgRbFHX107TwPuFl/Jmsf+S2DyyHpd
         4Jwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=XSjSzJ1uk3q+2nALlbr5hGh7BGU35L5lQOj/VHwmAjA=;
        b=jEcaLmd6Slz/j8SpZYmakcx/b5S99mX2PelhJOWi/n4VizMyBFz3Ojb1DKX32VgbGT
         nPOnwfYIFM09VZqq+aYs2+dqib3gdmO3Fp9lBvi/kvyicStkabLPGMkmXvAmw/rjI9QY
         9JA5eNpuuFPMXEWXDW9ra66Xe1+QS2Mdka58K9bgmjNX8BlkoHKAjtqAxWMfZX5IXS5J
         zMZjrew0GcZbaEq6UnU45W2P5ead2OnM1yNxLG/sP171FVLSdYobEfAzZNvIVgUGHKoH
         7MyNWPF2/ETv87pGoGQhhqhVE4irSvJVsQ666whLg089Ep80qHrmDp7w0due9j/lXiFB
         Cg5g==
X-Gm-Message-State: AKwxytfa4gyw3B61DRAfwI8vcos9XLksRFCAc7kkXd/xZQ2Y8ao0aukn
        eGn1Ng/qHtMj3bC2mGN8mlPacvFN
X-Google-Smtp-Source: ACJfBovrlNZ1vTluFEXEIWs+UBmcZl25Pt2jk2LaZ9AdjevvFKqmJOJQwo4J0JJNNixQDNz4Ltu7oQ==
X-Received: by 10.223.192.65 with SMTP id c1mr3877030wrf.58.1515768268344;
        Fri, 12 Jan 2018 06:44:28 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id o12sm22829127wrf.14.2018.01.12.06.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jan 2018 06:44:27 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has >6700 loose objects
References: <87inc89j38.fsf@evledraar.gmail.com> <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
Date:   Fri, 12 Jan 2018 15:44:26 +0100
Message-ID: <87d12f9lx1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jan 12 2018, Duy Nguyen jotted:

> On Fri, Jan 12, 2018 at 4:33 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> For those rusty on git-gc's defaults, this is what it looks like in this
>> scenario:
>>
>>  1. User runs "git pull"
>>  2. git gc --auto is called, there are >6700 loose objects
>>  3. it forks into the background, tries to prune and repack, objects
>>     older than gc.pruneExpire (2.weeks.ago) are pruned.
>>  4. At the end of all this, we check *again* if we have >6700 objects,
>>     if we do we print "run 'git prune'" to .git/gc.log, and will just
>>     emit that error for the next day before trying again, at which point
>>     we unlink the gc.log and retry, see gc.logExpiry.
>>
>> Right now I've just worked around this by setting gc.pruneExpire to a
>> lower value (4.days.ago). But there's a larger issue to be addressed
>> here, and I'm not sure how.
>>
>> When the warning was added in [1] it didn't know to detach to the
>> background yet, that came in [2], shortly after came gc.log in [3].
>>
>> We could add another gc.auto-like limit, which could be set at some
>> higher value than gc.auto. "Hey if I have more than 6700 loose objects,
>> prune the <2wks old ones, but if at the end there's still >6700 I don't
>> want to hear about it unless there's >6700*N".
>
> Yes it's about time we make too_many_loose_objects() more accurate and
> complain less, especially when the complaint is useless.
>
>> I thought I'd just add that, but the details of how to pass that message
>> around get nasty. With that solution we *also* don't want git gc to
>> start churning in the background once we reach >6700 objects, so we need
>> something like gc.logExpiry which defers the gc until the next day. We
>> might need to create .git/gc-waitabit.marker, ew.
>
> Hmm.. could we save the info from the last run to help the next one?
> If the last gc --auto (which does try to remove some loose objects)
> leaves 6700 objects still loose, then it's "clear" that the next run
> may also leave those loose. If we save that number somewhere (gc.log
> too?) too_many_loose_objects() can read back and subtract it from the
> estimation and may decide not to do gc at all since the number of
> loose-and-prunable objects is below threshold.
>
> The problem is of course these 6700 will gradually become prunable
> over time. We can't just substract the same constant forever. Perhaps
> we can do something based on gc.pruneExpire?
>
> Say gc.pruneExpires specifies to keep objects in two weeks, we assume
> these object create time is spread out equally over 14 days. So after
> one day, 6700/14 objects are supposed to be prune-able and part of
> too_many_loose_objects estimation. The gc--auto that is run two weeks
> since the first run would count all loose objects as prunable again.
>
>> More generally, these hard limits seem contrary to what the user cares
>> about. E.g. I suspect that most of these loose objects come from
>> branches since deleted in upstream, whose objects could have a different
>> retention policy.
>
> Er.. what retention policy? I think gc.pruneExpire is the only thing
> that can keep loose objects around?

You answered this yourself in
CACsJy8CUYosOGK5tn0C=t=SkbS-fyaSxp536zx+9jh_O+WNaEQ@mail.gmail.com, yeah
I mean loose objects from branch deletions.

More generally, the reason we even have the 2 week limit is to pick a
good trade-off between performance and not losing someone's work that
they e.g. "git add"-ed but never committed.

I'm suggesting (but don't know if this is worth it, especially given
Jeff's comments) that one smarter approach might be to track where the
objects came from (e.g. by keeping reflogs for deleted upstream branches
for $expiry_time).

Then we could immediately delete loose objects we got from upstream
branches (or delete them more aggressively), while treating objects that
were originally created in the local repository differently.

>> But now I have git-gc on some servers yelling at users on every pull
>> command:
>>
>>    warning: There are too many unreachable loose objects; run 'git prune' to remove them.
>
> Why do we yell at the users when some maintenance thing is supposed to
> be done on the server side? If this is the case, should gc have some
> way to yell at the admin instead?

Sorry I didn't clarify this, this is a shared server (rollout system
with staged checkouts) that users log into and stage/test a rollout from
the git repo, so not the git server.

Because it's a shared repo there's a lot more loose object churn, Mostly
due to pulling more often (and thus more branches that later get
deleted), but also from rebasing and whatnot in the rollout repo.
