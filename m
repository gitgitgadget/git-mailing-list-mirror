Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5CB320248
	for <e@80x24.org>; Mon, 18 Mar 2019 04:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfCREyF (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 00:54:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfCREyF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 00:54:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id i8so15476132wrm.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aPb0UtbZV8dedw9/3vFluIz10dMWyOPHWqmlTEvJ0/s=;
        b=JP9VuJlFVOgh56O9htWQtHe3lR6hXiqqI13NsL8Jv9YXmMtEyb2n0881MOs4TYcHMo
         OBMb1aq22EtoXfw9OMevZPUCSdlAM/QwDQY1mhbdlrg4ouSZA2UBe9fMpJZlAljUuiRW
         IIlGgkkVnct10x9PWrCpjrH5Ue+sp2Il7aE4uiJgtQoHRNM/KWZbklFO+ZEJEIn8oPKN
         Z2JoXLXygUb7G1kXUl6E9VtUmefcI9imxFIEIopovD/Hj3rSFrJ8JjuY3AOvafMhQymB
         oFBBmXK67c2iTWqjk2ro7yoV/v5EgXskDX0HSXGPQaBHc9Jc3ZWEFE5+uSykJwCktRiu
         XY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aPb0UtbZV8dedw9/3vFluIz10dMWyOPHWqmlTEvJ0/s=;
        b=BJxwT0nqEb+pzTH8Fg6oVAi+SO6TdicLFbZcEQctshILg+Y6NBsES/efKcSU0ZZBDQ
         v2m97dtotq0jjRgKqqPEg/SbtLVwaPFAqo84DaMkNCvhKZ0PL46bSlOZkiXrfYbJkG7c
         tp1Q259ucsryA+Rhfx8C0RWTkibU+BEwjWq+8+CYibeqV99UzcFKC1PJ2enyCv5a/Ew7
         9Z58xJIyxYi3xoN383CnVHCdmKsCoa54bfrF1ucuRf7bXXw1HaXJb0+OGOqnejuDoLp/
         uckZnzqBdbHlnNLEK6Wpa5S2aBlqA8F+BTpuLUp8XS7WXElGhVEehAuvdpEgan495bFt
         pEMw==
X-Gm-Message-State: APjAAAVA2l9frorvhP+y7gogJEg5lvsQRTGQqeaaXM9tKmCjrYDNd/UE
        A33hXwxiCP9zdHWtiodl2tg=
X-Google-Smtp-Source: APXvYqx3Z65I5/Bb51LvjRqruDSrgIZx4srmQNMCbOjOMDdSWlaZbfSktjPU/3XFWQXElbIfry8qOA==
X-Received: by 2002:adf:f3c5:: with SMTP id g5mr10384669wrp.247.1552884843472;
        Sun, 17 Mar 2019 21:54:03 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 93sm23391327wrh.15.2019.03.17.21.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 21:54:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eckhard =?utf-8?Q?Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v4 00/26] Add new command 'switch'
References: <20190308095752.8574-1-pclouds@gmail.com>
        <20190317124926.17137-1-pclouds@gmail.com>
        <CACsJy8BevFGXt-RL_1G263ntXYee69N055TY8_GQL1unvJNPnw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 13:54:02 +0900
In-Reply-To: <CACsJy8BevFGXt-RL_1G263ntXYee69N055TY8_GQL1unvJNPnw@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 17 Mar 2019 19:58:02 +0700")
Message-ID: <xmqq4l806avp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I did forget one thing:
>
> - 'git switch' refuses to switch in the middle of
> rebase/bisect/cherry-pick/... session. Add --ignore-in-progress to
> override this

I think that is a sensible thing to do.  Once I did not realize that
a "checkout" from a failed cherry-pick with the state files left in
the .git/ directory took me to a strange state, causing some later
operation to act on these state files as if a cherry-pick were in
progress (and somehow the shell prompt support did not report it,
perhaps because the copy I use was out of sync with the binary).

Making sure that during a stateful operation the working tree won't
get switched to a different branch is probably a good idea.

I often find "git reset --hard <some other starting point>" after a
failed "git checkout -b new <starting point> && git am -s3c", so I'd
be opposed to a change to refuse a "reset --hard" during the middle
of such a stateful operation, but I do not think of a reason why I
would want to "switch" in the middle.

> Now that I mention this, --ignore-in-progress should probably be part
> of --force too. Hmm...

Probably.  You may want to decline other parts of what --force
allows but when you say --force, --ignore-in-progress should be
implied.

