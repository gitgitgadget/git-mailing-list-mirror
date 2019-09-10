Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5251F463
	for <e@80x24.org>; Tue, 10 Sep 2019 08:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbfIJIyu (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 04:54:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33860 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbfIJIyu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 04:54:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so8286422plr.1
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GSg5t1Rr39c+ekfx7izseX4SoaarfuekmBpFhdHmAWk=;
        b=U39U0Ja4MoC807R0ZSR3Cav1PU1OueuX3OB1ZKPl0cwiIMemxVXVgZFu81ShHxUkkr
         7a9ELQqQ7Io1dya2pHS2ZQ6S23H7gvhhw6T/5RGty7s3dGWoazce5eVIfa+F+7cOH8x8
         HVwO6d9MDZV/bLzGKukuSkYoGZLAGdyLJCCdNZpmO5dLHOdbTXuhsuVyXVDsaoqAYMxV
         eCGeZy1wJdWQcm8dXRWiQIwZUk5b9Jtnq6bSVPTid+Z1WFjrAZ+10bu6ab9TslGKva5j
         FgGClm4JqigzjvpOZUwwtf+9qVqmz3w3zJpwznMmQPs6ITGprg+T8zmYHE1evNMZyRpm
         J5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GSg5t1Rr39c+ekfx7izseX4SoaarfuekmBpFhdHmAWk=;
        b=s17w5cwEdD6DOHN0iZk7dCDiEmu8x6cBGH3BQrfQc3BpX+qYqVF6l7l36WZM+hcIEW
         woMjHl0Hv/FBhfj5BZLeDm0bXV6+52EjcKIg5Dxrniuc/upcRNsZRi8XCMOn3n41qfvW
         wNAPzFtU/M6gJvmTS5QpXhFuD5kMKeStexAAfb5qx/1zHQJr0WrWgaHE/5PmQsuKOqmc
         EWoaoNhzTdyBKePAkHCnXcYjOGBFQPjer21ynLrSeV3wrTbCwQXnZeQRaTUpAGg2vU22
         sSYxGL0EMjV5cUwdlRGqkhftllwQFrqxRdcIhDNs0RCbzVD5rINWfskD4Xd2bltdQqxU
         O0NA==
X-Gm-Message-State: APjAAAUtkFYrEXRLHHUltFcF0FsIzL3QQbHfxX5LzllW8f7J0rTK3VS0
        0AyRVhEZewZfw3qq4RakD+g=
X-Google-Smtp-Source: APXvYqy61H+w56vWaKdBAM3Dg+zhuMyKKAUbpaNAUtZYYLUr2YuP+qUAZmWCy5ADmvYKVRZAdEBOvA==
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr1076293pll.15.1568105689187;
        Tue, 10 Sep 2019 01:54:49 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id r28sm33006303pfg.62.2019.09.10.01.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 01:54:48 -0700 (PDT)
Date:   Tue, 10 Sep 2019 01:54:46 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>, David <bouncingcats@gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
Message-ID: <20190910085446.GB32239@gmail.com>
References: <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com>
 <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com>
 <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
 <CAKPyHN3+Sr2QJGR7Sw02x0A9OXshVUQofqH=ShXDivmqP5X7vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPyHN3+Sr2QJGR7Sw02x0A9OXshVUQofqH=ShXDivmqP5X7vw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 04, 2019 at 09:03:02PM +0200, Bert Wesarg wrote:
> On Wed, Sep 4, 2019 at 8:52 PM Johannes Sixt <j6t@kdbg.org> wrote:
> >
> > Am 04.09.19 um 19:46 schrieb Pratyush Yadav:
> > > On 04/09/19 08:24AM, Johannes Sixt wrote:
> > >> That is worth a try. The check box title offers a natural hotkey then:
> > >> "_A_mend last commit", Alt-a.
> > >
> > > Right now, the binding proposed is Ctrl-e.  My mental model for the key
> > > bindings as of now is having the "actions" bound to Ctrl, and bindings
> > > that move you around in the UI bound to Alt.  So it makes more sense to
> > > me to have a "amend toggle" bound to Ctrl.  Maybe that's just me though.
> > > Anyone else care to chime in?
> >
> > "Amend last commit" is NOT an action. It switches a state.
> >
> > It is common in Windows GUIs that every control, including menu items,
> > has a hotkey associated, the underlined letter in the caption, and the
> > hotkey to access that UI control is Alt+that letter. It's not
> > necessarily a matter of moving around.
> >
> > And, BTW, this hotkey thing is also the case on my Linux desktop
> > (KDE-based).
> >
> > But of course, git-gui is different and totally off track here. It has
> > *zero* controls marked for hotkey-accessibility. I was just hoping to
> > spark an effort to make some of the controls marked and hotkey-accessible.
> 
> I'm in favor of making this a checkbox, also in the menu. As all menu
> entries have currently a CTRL+ binding assigned, I think this one
> should have one too. As CTRL+A is taken, and the proposal is CTRL+E, I
> would be fine with this. If the menus and the UX elements also honors
> mnemonic now or in the future, I don't think they need to match the
> CTRL+ binding. Thus if this gets Alt+A I'm fine with this too.
> 
> Bert
> 
> >
> > -- Hannes

git-gui might not be so focused on providing a fast way to launch a
visual $EDITOR, but Ctrl+E is the hotkey we use everywhere in git-cola
when lauching external editors on selected files.  Sometimes it's the
"hot" action so even "Enter" gets that action, but it's worth
considering if we ever want git-gui's status widget to be able to launch
editors.

We also let Ctrl+Enter launch the default xdg-open action on the
selected file (e.g. image files go to the default image editing program,
html files to a browser, etc).

While we're on the topic of hotkeys, some valuable hotkeys for an
English-centric keyboard are {J,K,L} because of the home row.

In web browsers, Ctrl-L is a very common hotkey for focusing the URL
input, so we stole that same hotkey for the "git log <...>" input
in the git-dag tool.  In that tool the arguments to "log" are very
much like a URL from the input perspective, so it's nice to be able
to use a familiar and convenient hotkey for that purpose.  The placement
of the input field[1] is also at the top of that tool, just like in a web
browser.

[1] https://git-cola.github.io/images/dag.png

Ctrl-L is also used to focus the "Commit summary" line edit for the main
git-cola commit message editor.  That seems like the most sensible
"main" behavior for the main commit GUI.  Maybe git-gui can do that too.

Ctrl-J is kinda like "down" in vim, and so we let that focus the "diff"
widget which is typically "down" below the status and commit widgets in
cola[2].

[2] https://git-cola.github.io/images/screenshot-dark-linux.png

Ctrl-K focuses the status widget because it's "up".  Also, K and L are
adjacent on the keyboard, and they are also adjacent visually in the UI
so there's a visual and muscle memory pairing there between the Status
and Commit widgets.

The JKL hotkeys are nice to have in addition to the numeric hotkeys
because they're so convenient.  In some cases (like when the diff widget
is focused) we allow Alt-{J,K} to jump down/up (next/prev) between the
files in the status widget, otherwise regular {J,K} can be used if it
has focus.

Thanks for at least trying to keep some parity with git-cola's hotkeys.
It's not completely possible in all situations, but it's good to at
least share notes on how we use the GUI.
-- 
David
