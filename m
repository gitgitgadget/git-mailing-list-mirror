Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 138951F461
	for <e@80x24.org>; Wed,  4 Sep 2019 19:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfIDTDQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 15:03:16 -0400
Received: from mail-vk1-f172.google.com ([209.85.221.172]:35758 "EHLO
        mail-vk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732485AbfIDTDP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 15:03:15 -0400
Received: by mail-vk1-f172.google.com with SMTP id d66so2595337vka.2
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pr7o9SaNGjU/mr1vTD/dV/9/TW6FvW0AVomnjbbYPwY=;
        b=pckkVQ3ZIAXuIlq8H/BLDFWPDe5Ppt4UOUuYspjasKIIEzYa2sYgZUKHuKjbo4Ermr
         YZJlFytsZ6vws5hxjnHnjQFvKM0NSat7WhbFe91D5kwhwSoHLSncqzpBvJTg8WLC1M5j
         ZDFloFRGqWTpsVnXOmjiFNSZLjTw9VoabglJbFSrnR7nMopgVPrUeCeOHh+8x8VVf71p
         qzs8JCElOk7csSMmfzJx5KyXSdR+YzEexDSkHxbMQqmgl4n5ew44DSeSRu0tNOEh8jMH
         yZaDGLP33PjEwE9+vOTD16sKxCe/4BO5lta67BrKH+NGiijjwSWCfHDcPgBh2P/BWcbA
         d3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pr7o9SaNGjU/mr1vTD/dV/9/TW6FvW0AVomnjbbYPwY=;
        b=E2ZhgzERqejtOJbyW4ucrqUe5gLb+TCMbSUo3ne4SsBlozKVlIBSXawbXPYvwme0xJ
         QD4SDwteOoxeA8OQpQbO38dArLIXVqgfGcurqFVRoNulRct8CVFSmnLoyN49hPe+snNV
         vAeA4wGt5yjhLcgdX4u0MZuTtH0cdod80vraKdZl4kR/uKqSO1U05mK1OGG9IOq3MbcI
         De+muI8l+95UqNR42mdD15PRivlmcWrJO7INIkBJ5yr+z1zwB6eKg1pjMzN2MW2Rf9oo
         +m2K8Nnp7NqTZMJzcpw31ipichPHEUNJntPGG49tw7fNX/MYZIwaIObKEfDGyt5/CGPT
         azOQ==
X-Gm-Message-State: APjAAAUEWN1TuJAe9XTMT1u9Ak1lzKtKQjvFZsEl8ZuR4t/LDPtUxFOo
        Q294/YVcO3I+WCwoqd8g3yhmuizv61DF6i/fWL4=
X-Google-Smtp-Source: APXvYqz+z0R0nv2ClflYMXGXpY3zEukj09BBVKOasUyiuaz0Va3BERBbW4ysw0Dx8wTFzLbnjonOGW1ZHGRAKbQuIkA=
X-Received: by 2002:a1f:3cc9:: with SMTP id j192mr10959575vka.58.1567623794650;
 Wed, 04 Sep 2019 12:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=Jw4DAqTi3ROujtE=xBMYErMws6B6vhuXYMQA+5Q1ccow@mail.gmail.com>
 <CAGr--=JkNqcrcenp6F1_CHTun_9wPLVvEWGOFJW=ng=XfO+jHw@mail.gmail.com>
 <CAKPyHN3Zvf6gtKAq03s8AsguaOFG=g2huGRCTWmBVWioDBqFWw@mail.gmail.com>
 <CAGr--=JyJHTxtQWSnU7ivQ79qXcg7o4N142+5FSdre851xss6A@mail.gmail.com>
 <CAKPyHN3S-jLWmfHUyH9mCBPjHCEaBCbrkVQEKFqHv59U37=Kyg@mail.gmail.com>
 <CAKPyHN08Z_9oByA8ruKwwXRcAfYPU95JaMb=pqQWwGwPVG=_og@mail.gmail.com>
 <CAGr--=Jn87r_ySYkZmtqUBA40+fwdn0MbuN6_LNDO4mOWyoKTg@mail.gmail.com>
 <20190903124541.2p5hmknolh2dwqh5@yadavpratyush.com> <971bbc44-d3d4-552d-d18e-58a2315c6183@kdbg.org>
 <20190904174103.nrntgwv6zdqyjqsh@yadavpratyush.com> <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
In-Reply-To: <8a726eea-f461-db90-7e36-70b708ff8915@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 21:03:02 +0200
Message-ID: <CAKPyHN3+Sr2QJGR7Sw02x0A9OXshVUQofqH=ShXDivmqP5X7vw@mail.gmail.com>
Subject: Re: feature request, git-gui: add hotkey to toggle amend/new
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git List <git@vger.kernel.org>, David <bouncingcats@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 8:52 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.09.19 um 19:46 schrieb Pratyush Yadav:
> > On 04/09/19 08:24AM, Johannes Sixt wrote:
> >> That is worth a try. The check box title offers a natural hotkey then:
> >> "_A_mend last commit", Alt-a.
> >
> > Right now, the binding proposed is Ctrl-e.  My mental model for the key
> > bindings as of now is having the "actions" bound to Ctrl, and bindings
> > that move you around in the UI bound to Alt.  So it makes more sense to
> > me to have a "amend toggle" bound to Ctrl.  Maybe that's just me though.
> > Anyone else care to chime in?
>
> "Amend last commit" is NOT an action. It switches a state.
>
> It is common in Windows GUIs that every control, including menu items,
> has a hotkey associated, the underlined letter in the caption, and the
> hotkey to access that UI control is Alt+that letter. It's not
> necessarily a matter of moving around.
>
> And, BTW, this hotkey thing is also the case on my Linux desktop
> (KDE-based).
>
> But of course, git-gui is different and totally off track here. It has
> *zero* controls marked for hotkey-accessibility. I was just hoping to
> spark an effort to make some of the controls marked and hotkey-accessible.

I'm in favor of making this a checkbox, also in the menu. As all menu
entries have currently a CTRL+ binding assigned, I think this one
should have one too. As CTRL+A is taken, and the proposal is CTRL+E, I
would be fine with this. If the menus and the UX elements also honors
mnemonic now or in the future, I don't think they need to match the
CTRL+ binding. Thus if this gets Alt+A I'm fine with this too.

Bert

>
> -- Hannes
