Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0245C433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 17:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245168AbhLORJe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244959AbhLORJd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 12:09:33 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC454C061574
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 09:09:31 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id p19so22439643qtw.12
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wCbkJZePN8EW/prqYpwog2TXewVQVEiVSyoZhUfNG6g=;
        b=pNk8SAHfjNK3w+t070cTdwHW2XA5aMOrLTekOFtHoxxZHseEbtPLVR9Cuwwj6C4Zxq
         z6xga8u4A29q4jX/ow3XDNNEl+x6p5iIg+CrLSYpKEfPgrcG/NPYeEu1KzNNQHswuvWT
         K6s4nxhuoB+ZNCvyUsKR60T9SzhiJ1LqqoJM/NUppC2OrvTEAsy3q45mv111dfpKnB5i
         1g1MTVOqrDTrh3b2z80L61tgRBwZbog5PcqNr6u+xrR44B2U6KvFbvWORYibQythPwyl
         GaMVvw31LAKDUJy9NbzGZ5ASKPQ4OCKhUILxACIJ4iosb1Wf37sVeMEJ+QOSkyW1wFTA
         URTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wCbkJZePN8EW/prqYpwog2TXewVQVEiVSyoZhUfNG6g=;
        b=mX1GUU+/gqZ0SMXC7SuG54KbnBueoaCYFZUoeptYYNPWxHrDCj/wao4F/5nd+Q2IgR
         V3xOFLfffsFisIrciy/mootRkUa3kHXytYiF/3b8K3ULt/gbU6ji5m7YqYeV6utiW3PA
         S5O2itXdt1dciN5fUyCUgcE+hx5cR5zdFFSTKZTcs//3hdEhBm39v5MCKXb6NYAyH46W
         FfMJ/j8hkvKGyMIdfEfo+qN/s6YW6Y2j25RvwheIvCm6M5wqEpU5aHMXC2TiP3/RseWe
         GdrJMFt2iBd3i9H2vQuE/qn5QN1n/ZH6g/4jIqpO/EhLrVC33Cwmnj/qTp+HbNjtEAxz
         kDBQ==
X-Gm-Message-State: AOAM533vO+GIKU5sme01jqlGm4rtoAyY4ZDzuG+fyI5ewYkk9eI1GDGq
        2BuEKbmKM/Ym/lmVQfzbysz40GgM9HA1jCaF
X-Google-Smtp-Source: ABdhPJwbgRTt37Th6KoNG1fnj4jrnyj80zCZB3bfkHxx83OVBBqKN6AE0FsUn4CV1PygkLQQDvyYig==
X-Received: by 2002:ac8:5946:: with SMTP id 6mr12781082qtz.373.1639588170919;
        Wed, 15 Dec 2021 09:09:30 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h3sm1339928qko.78.2021.12.15.09.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 09:09:28 -0800 (PST)
Date:   Wed, 15 Dec 2021 12:09:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: taking a break from Git
Message-ID: <YbohRy22vBuDZsG4@nand.local>
References: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YboaAe4LWySOoAe7@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 11:38:25AM -0500, Jeff King wrote:
> Hey all,
>
> I'm going to be offline and completely absent from the mailing list for
> five months starting at the end of December. After that, things are up
> in the air, but I may not be as involved in the project as I have been.
>
> Sorry, there's no juicy gossip or drama to share. I still like everyone,
> and think it's a cool project. ;) After 15 years, it just feels like
> it's time for a break and to perhaps apply my brain to something else
> for a while.

I am going to miss seeing patches and review from you tremendously.

As prolific as Peff has been on the mailing list for the past 15 years,
he has also spent a lot of effort behind the scenes at GitHub as my
manager. He has provided me invaluable guidance and mentorship over the
years, and given me the freedom to pick and choose interesting projects
to work on.

We were recently talking off-list about the projects that he and I have
worked on together, and I remarked that none of it really felt like
"work". I think it takes a special skill to create that environment for
people, and Peff certainly has that skill.

I am a better programmer and Git contributor directly because of Peff's
efforts. I am sure that anybody who has been fortunate enough to get
review or advice from Peff feels the same as I do.

> There are a couple logistical things related to this:
>
>   - I'm planning to step down from Git's Project Leadership Committee
>     (the entity that represents Git within Software Freedom Conservancy,
>     and which occasionally makes decisions on things like our project
>     funds or assets like the trademark).
>
>     That leaves Junio, Ævar, and Christian on the PLC, and the charter
>     calls for having at least 3 members. So I don't technically need to
>     be replaced, but maybe it's an opportunity for somebody else to get
>     involved.
>
>     We don't have a formal process here. The last discussion on adding
>     new members was this thread from a few years ago:
>
>       https://lore.kernel.org/git/20180816224138.GA15490@sigill.intra.peff.net/

I would be honored to serve on the PLC if that is something others would
be in favor of, too. I can talk a little bit about my background and
thoughts here in a separate thread from this one.

>   - I maintain the git-scm.com site (well, insofar as anybody does).
>     There are a few regulars who review and merge pull requests at
>     https://github.com/git/git-scm.com, but more help is always welcome
>     there.
>
>     The production parts of the site run on Heroku and Cloudflare. They
>     don't need touched often, though we do trigger a manual update and
>     flush the caches right after Junio releases, so that the site is
>     updated immediately.  The Git PLC has the necessary credentials for
>     those sites, though in practice I think I'm the only one there that
>     touched it. Taylor (cc'd) has been helping out with that and also
>     has access.

Yes, I have credentials to our Heroku and Cloudfare accounts, and (I
believe) write access to the git-scm.com repository on GitHub. So I can
help do some light triage there, and at least prevent the site from
bit-rotting.

I've been doing the post-release manual update and cache purging as part
of my usual release routine for the past several releases, so I don't
mind continuing to do that, either.

>   - I really am going to stop reading the list. Even if you cc me. So
>     please don't get mad if I don't review your patches, or respond to
>     bug reports. :)

Please do ;). Enjoy your well deserved time off, and thank you.

Taylor
