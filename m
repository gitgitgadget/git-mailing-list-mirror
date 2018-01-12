Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E7A1F406
	for <e@80x24.org>; Fri, 12 Jan 2018 12:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933113AbeALMHg (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 07:07:36 -0500
Received: from mail-ot0-f182.google.com ([74.125.82.182]:33385 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932705AbeALMHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 07:07:35 -0500
Received: by mail-ot0-f182.google.com with SMTP id x15so4880421ote.0
        for <git@vger.kernel.org>; Fri, 12 Jan 2018 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L1Qxz9K1mIXBeDVQiwMwV2pD/dBRMNponYI2yvGmBTw=;
        b=a8trE1OevrtRGF4W+ZvB+Cxem2XMuXFrurmoJAQMdLKi6aSvbcFvaujuYdRff/pWUp
         pDXXN5AvSAz5SiQA5TSJ2ujPwMtHtBeY84ln8o/MJJ+S3p94qLuWROHkXSmCyzoxmMro
         La8hkLVVYQ6IsyOtN4ylHJZw0ZdjIcvAYa+UcT2elCSQjnuP0rWh3A4jlLJGp9+5rHhZ
         iBQQHbx7tSpU5HH28h19SvVPDOK0kDhNiAGGIDMHL8hT3aslNPe1A3DIN41EElMrSj6u
         cFHdXpwMjqvkyuYMfscFXuXKXSF0UbcqzGM3RISSn4vKlR8Nkky0AO9jjyLQXpobjqE1
         96Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L1Qxz9K1mIXBeDVQiwMwV2pD/dBRMNponYI2yvGmBTw=;
        b=B/AvuyvoO6vgL3RgceYl1DihyF/vYnxrB6En9GuQjVBQR6rZLSRK07lmHE7LDYzQoH
         n0d/DfnL25ZhJe/awg2LFqm8EGt+V5TKta7Wftv4b3ev/b7ToUHBDxAe4+137M/t0711
         Nkvzsn4VBNVwz7XZvRvUa3RK3oh0UTKys+ntbEIe6LTi9IpMXBo7hKbJbluCPXjvjj7F
         Szm2JaaxfJHDfmMrQ7JioWruyIJxeMdGfM25hB1BZloEUGUTLpnI9WDUkWuwNDw4Sv4P
         wzttZPN5oQS2ETwvK4fOCe5+CFlqFDpQ6V9gDzQmtW3ZFX3EazoEKEV/3InaM4fC6Al5
         DpmA==
X-Gm-Message-State: AKwxytckzbQIRbkpCJXzbL2gQKEog0IZ0580BE7WV2Rte/Ixt89KPVL/
        WsdLnO8h0AMR4N8jziRoGC2ZYQIIb+0fliTXz5Mjrg==
X-Google-Smtp-Source: ACJfBotQUUs42tfmKz4KOmK9dnFpCqB4Q5t3d1KW7KEhmsrJNXnYq+HmubtcMcMpHUZeHvGkRP+KmepBxYmI6t/jmsU=
X-Received: by 10.157.32.108 with SMTP id n99mr16226141ota.301.1515758854805;
 Fri, 12 Jan 2018 04:07:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Fri, 12 Jan 2018 04:07:04 -0800 (PST)
In-Reply-To: <87inc89j38.fsf@evledraar.gmail.com>
References: <87inc89j38.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 12 Jan 2018 19:07:04 +0700
Message-ID: <CACsJy8AWO5Vk-Qz3VVBUezWL=oAd9YkeGq=_TXGSb0GSs5bLcg@mail.gmail.com>
Subject: Re: git gc --auto yelling at users where a repo legitimately has
 >6700 loose objects
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 12, 2018 at 4:33 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> For those rusty on git-gc's defaults, this is what it looks like in this
> scenario:
>
>  1. User runs "git pull"
>  2. git gc --auto is called, there are >6700 loose objects
>  3. it forks into the background, tries to prune and repack, objects
>     older than gc.pruneExpire (2.weeks.ago) are pruned.
>  4. At the end of all this, we check *again* if we have >6700 objects,
>     if we do we print "run 'git prune'" to .git/gc.log, and will just
>     emit that error for the next day before trying again, at which point
>     we unlink the gc.log and retry, see gc.logExpiry.
>
> Right now I've just worked around this by setting gc.pruneExpire to a
> lower value (4.days.ago). But there's a larger issue to be addressed
> here, and I'm not sure how.
>
> When the warning was added in [1] it didn't know to detach to the
> background yet, that came in [2], shortly after came gc.log in [3].
>
> We could add another gc.auto-like limit, which could be set at some
> higher value than gc.auto. "Hey if I have more than 6700 loose objects,
> prune the <2wks old ones, but if at the end there's still >6700 I don't
> want to hear about it unless there's >6700*N".

Yes it's about time we make too_many_loose_objects() more accurate and
complain less, especially when the complaint is useless.

> I thought I'd just add that, but the details of how to pass that message
> around get nasty. With that solution we *also* don't want git gc to
> start churning in the background once we reach >6700 objects, so we need
> something like gc.logExpiry which defers the gc until the next day. We
> might need to create .git/gc-waitabit.marker, ew.

Hmm.. could we save the info from the last run to help the next one?
If the last gc --auto (which does try to remove some loose objects)
leaves 6700 objects still loose, then it's "clear" that the next run
may also leave those loose. If we save that number somewhere (gc.log
too?) too_many_loose_objects() can read back and subtract it from the
estimation and may decide not to do gc at all since the number of
loose-and-prunable objects is below threshold.

The problem is of course these 6700 will gradually become prunable
over time. We can't just substract the same constant forever. Perhaps
we can do something based on gc.pruneExpire?

Say gc.pruneExpires specifies to keep objects in two weeks, we assume
these object create time is spread out equally over 14 days. So after
one day, 6700/14 objects are supposed to be prune-able and part of
too_many_loose_objects estimation. The gc--auto that is run two weeks
since the first run would count all loose objects as prunable again.

> More generally, these hard limits seem contrary to what the user cares
> about. E.g. I suspect that most of these loose objects come from
> branches since deleted in upstream, whose objects could have a different
> retention policy.

Er.. what retention policy? I think gc.pruneExpire is the only thing
that can keep loose objects around?

BTW

> But now I have git-gc on some servers yelling at users on every pull
> command:
>
>    warning: There are too many unreachable loose objects; run 'git prune'=
 to remove them.

Why do we yell at the users when some maintenance thing is supposed to
be done on the server side? If this is the case, should gc have some
way to yell at the admin instead?
--=20
Duy
