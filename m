Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC0862013C
	for <e@80x24.org>; Thu, 16 Feb 2017 01:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752838AbdBPBdg (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 20:33:36 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35548 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752583AbdBPBdf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 20:33:35 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so375115pge.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 17:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RGYTVYH3uBi0NIT9+VVzKscPUOC7SeyA2t6zCfPu4a4=;
        b=OOpBAK6uD9Jh/SzPBLj1cTY84H65B4NnHYQptmMgPNMRfKbPa6p3oOZwITy1o/BSk3
         l9tjzNxihwiRme3wVJnGnUc0gOvdT2onlhzKU1h0w3nGbWWNi+Fba/BU5WcZwP7PWGoB
         kN1VlOyM4CLn5nuOs6E1pUexTB0i5VDiY1jCHmOM2m0oEoVu/sj6aDZj4ZGOvlB3WVvA
         FgcbW3GJxc3rxuP0sRae3SAy9y6G8WNpRZg8KlDl3CuBp4pIfMm4O6vTIAxPCaeRhoYP
         5ogNRM7XVhJr40m0APVUXwjzjnw0hIRSusr2ZGCst2l32iDT0A2l/gV91fb7hpm2lB4+
         +OwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RGYTVYH3uBi0NIT9+VVzKscPUOC7SeyA2t6zCfPu4a4=;
        b=Qe2D8FyW8kXLBoeUwrzYuJcgyn2kBVHKQho+jXgVPYvR7rIFX0AHg/E17zPo+u4lU2
         CTihnsZixCnNGJKTOSGlNqAg5/WDt01kJYkX6vhxmzfR2hRo5coa5sXwz5PwYf6nYy3K
         aFWGwg5NVIdjK3IBnq8qI+jCG/fP5EcR22+R0BivjDMo8G5NuWBiRIToj15cmfB+vJQn
         /h1OeieRbe10OeulJrSV02Po7LAkE7J/EhgGn/Rcf94B9Wy3DdtTk+C54XeS3XALD9U9
         HEOrW6u60NWKlIkJj9Ns8RrIS+QucLtJzKFRKpQRZ1kjz9jWpGw46+F918RN5XEYhrPE
         jVwg==
X-Gm-Message-State: AMke39nmFP3cidTNrIGzrhnQg1N5FB6nMMa8sFr1aw9d/b26jlZUgqnQjutPE3W8VqJEdQ==
X-Received: by 10.99.167.74 with SMTP id w10mr43099072pgo.2.1487208814397;
        Wed, 15 Feb 2017 17:33:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id i82sm9659946pfk.52.2017.02.15.17.33.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 17:33:32 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Christian Couder" <christian.couder@gmail.com>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git-for-windows@googlegroups.com>, "git" <git@vger.kernel.org>
Subject: Re: [git-for-windows] Re: Continuous Testing of Git on Windows
References: <alpine.DEB.2.20.1702101241210.3496@virtualbox>
        <xmqq60kdbqmy.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1702142150220.3496@virtualbox>
        <xmqqd1ek8oqo.fsf@gitster.mtv.corp.google.com>
        <CAP8UFD1+AgBVqSh=wHteM3uKO+55ZqqD4cHzBUfN0KTPXyvutQ@mail.gmail.com>
        <E2C1B7A8FBF94C8CB1C9C5754D882800@PhilipOakley>
        <xmqqshng5osz.fsf@gitster.mtv.corp.google.com>
        <7EA15219331242ABB08B9A9AA9F08CBE@PhilipOakley>
        <xmqqvasb2li8.fsf@gitster.mtv.corp.google.com>
        <72ADDC07AFEF4BD88EADCDAF75DFB2CB@PhilipOakley>
Date:   Wed, 15 Feb 2017 17:33:30 -0800
In-Reply-To: <72ADDC07AFEF4BD88EADCDAF75DFB2CB@PhilipOakley> (Philip Oakley's
        message of "Wed, 15 Feb 2017 23:33:27 -0000")
Message-ID: <xmqqpoiizzpx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> For an integrator, or especially a CI tool, simply checking the second
> parents of each topic merge (post fail) should at least indicate if
> the basics of the feature actually passed the tests, though it doesn't
> check for interaction issues. This could give direct author feedback!

I think that is essentially what Avery advocated for in the old
thread Christian gave us earlier in the thread, and I agree that is
a useful way to help contributors.

While we are on the topic of testing efficiently and effectively,
there are a few other things worth taking advantage of.

One obvious thing is that not all topic branches get updated every
day, even though the tip of 'pu' will be different every day (or on
days when I run the integration cycle more than once, after every
pushout), because we constantly acquire new topics or updated ones.
The tips of topics that are merged in 'pu^{/^### match next}..pu'
can be enumerated by following the first-parent chain, and they can
be tested all one-by-one, excluding the ones that have been tested
already in the previous runs.  When I counted these merges the other
day I had 27 of them, and as of this writing I have 20 of them
(because some topics were merged to 'next' in the meantime).  Among
them, only 3 are new.  Everything else would have already been
tested if such a test was done daily.  So from that point of view,
testing them all could be less expensive than bisecting; in order to
bisect a first-parent chain of 20 merges, you'd need to test 5 or
so.

Another thing that may help to prevent breakages from seeping into
'next' is that "pu^{/^### match next}..pu" are rebuilt every day,
and the order of topics that are merged are updated.  The topics
that are closer to be merged to 'next' are moved down, so that
testing the merge result would give us closer result to what would
testing 'next' in the near future would give us [*1*].  So paying
closer attention to the merges (not tips of topics) above the commit
marked as "pu^{/^### match next}" when testing would catch potential
breakage about to happen in 'next' due to unexpected interactions of
topics when merged together.

There is another point in the history that may be worth paying
closer attention, which is the tip of 'jch'.  This always is ahead
of "pu^{/^### match next}", and almost always has a handful more
topics, many of which are considered to be merged to 'next' in near
future.  The branch is meant to be at least stable enough for my
personal use (hence its name) in helping me run everyday integration
cycles.


[Footnote]

*1* Suppose there are three topics A, B and C that are not yet in
    'next', and 'pu' merges them in that order.  Further suppose
    that C is a lot better cooked than others.  Merging C directly
    to 'next' however can expose a hidden issue that changes C
    introduces alone is not sufficient and depends on A or B to be
    present.  To avoid such a surprise after merging C to 'next',
    when 'pu' is rebuilt, I try to reorder them so that C is merged
    first on top of an equivalent of 'next', and then A and B.  For
    the same reason, topics in 'master..pu^{/^### match next}' are
    also reordered so that ones that are planned to be merged to
    'master' soon comes at the bottom.

    One natural consequence of this is that 'pu' is rebuilt directly
    on top of 'master' and 'next' does not fast-forwared to 'pu'.
    This arrangement also helps to spot mismerges to 'next' and
    avoid the same mismerge to affect 'master' when topics are
    merged to it.
