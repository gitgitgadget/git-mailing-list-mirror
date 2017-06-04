Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372A01F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 07:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbdFDHhc (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 03:37:32 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:33715 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751005AbdFDHhb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 03:37:31 -0400
Received: by mail-qk0-f179.google.com with SMTP id y201so83850781qka.0
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 00:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vOUafMIFr9JN/CYg14siWdXp53lDjAKwUNLzYZRFQbc=;
        b=s1tOouHXqiK53QCXtzacq6lytmK/84WLn8GOuXA1EMc43pFZehrUxgi2QKUvo7yEcJ
         8L9xuyMvJcDhhGWqc8/2UYGiHWvBIUoo4BOgZlPm1ciUoNr3/jFmni0HXajGrPKYQZ+U
         RCpy1k5zcN5EheO7hlXgTu7QU14vIJTC3G7wbsZd0hONBDW/94MxPpyGRXL7RG2N7pZn
         IvFZJ82QC7+h1OoWM0DpjdGVHCriyqr94hm8MedSgnyZMNsJ4UQaoSLhd/glFVfgWL0r
         5hJ+/ZKkfxHqj/xe19i+2O/nyDWuNdGIN6UQzodQd3SMrQ/M8gwmMHeR384/aI7LQQ03
         weCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vOUafMIFr9JN/CYg14siWdXp53lDjAKwUNLzYZRFQbc=;
        b=egRudVLZ/m+JMDGlLNJ0gYM3VtqQ8DtYdg5/4142jey/bA2+tDbHahQD72KBZIzaqm
         0dyYD0rm2ASs4oGPS4+IoZZE7IdAOzO5MmuQ04yXnEk9GqtJGAgv2TLFo0+5K/j3iJf+
         bkfbPpU5NGxsE6W5Nln6FH1E0MiTzDgIahfptauScT3c891t8Bx07Cfm+d7i9EX6E6Jb
         zvU2hUM8GKI8zBqHzT20ATlq07RRpUk6oCSMWhP+QdYuItxiP9oGc+sTeGudK57T+1A/
         2O5ENwzk37n0WGlw2AyhE4LNRlxfG1Zs/YSzQvJ5Pw/w3m4R09OtefeDAoqLrxRn30MT
         p74w==
X-Gm-Message-State: AKS2vOzApF7WNVjzNjoXX6hrbZfdsuXRxslZPYHNj4n7VFE8TD0g0BAB
        7Gr/RB7TS/CF/hZBLxMg9dNK2ZewQg==
X-Received: by 10.55.5.135 with SMTP id 129mr16957698qkf.181.1496561850239;
 Sun, 04 Jun 2017 00:37:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.162.85 with HTTP; Sun, 4 Jun 2017 00:37:29 -0700 (PDT)
In-Reply-To: <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
References: <20170602103330.25663-1-avarab@gmail.com> <20170602184506.x2inwswmcwafyvfy@sigill.intra.peff.net>
 <xmqqd1amx80f.fsf@gitster.mtv.corp.google.com> <CACBZZX52O9Pf=5Xtq1Lg1=ZU26tm7pupvubk1ZjNJZp7kR450g@mail.gmail.com>
 <xmqqefv0wrj7.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 4 Jun 2017 09:37:29 +0200
Message-ID: <CAP8UFD1u-C-T2X+H8WxxB7O+ajcGfygRBLN0t7+zJcOh_SrvFQ@mail.gmail.com>
Subject: Re: [PATCH] perf: work around the tested repo having an index.lock
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 2:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> My feeling exactly.  Diagnosing and failing upfront saying "well you
>>> made a copy but it is not suitable for testing" sounds more sensible
>>> at lesat to me.
>>
>> This change makes the repo suitable for testing when it wasn't before.
>
> Perhaps "not suitable" was a bit too vague.
>
> The copy you made is not in a consistent state that is good for
> testing.  This change may declare that it is now in a consistent
> state, but removal of a single *.lock file does not make it so.  We
> do not know what other transient inconsistency the resulting copy
> has; it is inherent to git-unaware copy---that is why we discouraged
> and removed rsync transport after all.

If we don't like git-unaware copies, maybe we should go back to the
reasons why we are making one here.
In 342e9ef2d9 (Introduce a performance testing framework, 2012-02-17),
Thomas wrote:

    3. Creating test repos from scratch in every test is extremely
       time-consuming, and shipping or downloading such large/weird repos
       is out of the question.

       We leave this decision to the user.  Two different sizes of test
       repos can be configured, and the scripts just copy one or more of
       those (using hardlinks for the object store).  By default it tries
       to use the build tree's git.git repository.

       This is fairly fast and versatile.  Using a copy instead of a clone
       preserves many properties that the user may want to test for, such
       as lots of loose objects, unpacked refs, etc.

Is a local clone really much slower these days? Wouldn't it is use
hard links too?
By the way the many properties that are preserved might not be worth
preserving as they could make results depend a lot on the current
state of the original repo.
