Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC002095B
	for <e@80x24.org>; Sat, 18 Mar 2017 21:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751269AbdCRVSS (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 17:18:18 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:36154 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdCRVSM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 17:18:12 -0400
Received: by mail-it0-f51.google.com with SMTP id w124so55125118itb.1
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 14:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FBZoATPYPuagYLbmsl+Ds0RLCwjcnYNLKq2Bu+v/Dy4=;
        b=ewBIyOL61Bm62aZiHnmFA16YSH+UtO/QrdOMW2e2OIWbyJJ5iqsc3ClDwHaj42IRBo
         RiTXasWxCkNHkFMTr/M2U5hVjQMPcfI6qM7yDjtMs8IASQkjXxxf3yRtMWVOS0F1fJC+
         Mj5Is2b9seaOeBFc/PX8VtURab9ycf5F50VNfYnL7qoOGJl8OrTZXT8h+258sAkGclKt
         gTEsyrQuzknOIQk5yKrwpYI0UuZkpK6uqG7Fl+JZqr95Mc2MemNzWvS/wwM2/u1q+PoZ
         KfA/EP5VPgQkrSxIID8cZrRwTFTvUjWaIh7yyK+xQXtkPreGQ64NKXhfu8O/0kVeW8Jv
         0ZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FBZoATPYPuagYLbmsl+Ds0RLCwjcnYNLKq2Bu+v/Dy4=;
        b=oN5mvs5TTQhfiLZZ++OZD+6X02K5UwnF/0bV8wSPXYM5eowzE2KhDFquUkabCpzwiG
         Ylz2dSFw4yquSj7YW1Vf1Zo5FWpGQbhmSQ0tO8E/gmoQdlOYecrYgoBUYQorba2CzJ97
         oQHo8Ul0IGiO8EjwPpM1A4Dw2fxynbCCRFJaThNwY5KfkC7DQReWMVwnRsPUObFytp58
         Mpp67t7uQAIWZl0VSLIs2OG3AYhfoBH+lGPYGuOgw2PIM0qkUrQG9ra8ytjR1uGvISlb
         6i1IE24rwLaWnP6vDwHp2CsuUlaqNCaZKMcbs5xeOSKlKpIzx0xig9WSCR6/KXmCFFyw
         av4Q==
X-Gm-Message-State: AFeK/H36OxOEwBp5H3cvKrIqtp3MKlNm/YRIaZlojOCz1WdfHkaibqEqJITtBF5IlJ6koT74Aa4Gji4iAGvrPA==
X-Received: by 10.36.103.9 with SMTP id u9mr3700217itc.91.1489871890736; Sat,
 18 Mar 2017 14:18:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 18 Mar 2017 14:17:50 -0700 (PDT)
In-Reply-To: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
References: <148971018136.2144.12683278043600094739@richardiv.omgwallhack.org>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 18 Mar 2017 22:17:50 +0100
Message-ID: <CACBZZX4VApZnO1u708nxqq711K7PD66U=mTT2tjnbt2XjxmQew@mail.gmail.com>
Subject: Re: Shared repositories no longer securable against privilege escalation
To:     Joe Rayhawk <jrayhawk@freedesktop.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2017 at 1:23 AM, Joe Rayhawk <jrayhawk@freedesktop.org> wrote:
> Git has started requiring write access to the root of bare repositories
> in order to create /HEAD.lock. This is a major security problem in
> shared environments as it also entails control over the /config link
> i.e. core.hooksPath. Permission to write objects and update refs should
> be entirely separate from permission to edit hook execution logic.

[Full disclosure: I implemented core.hooksPath]

The core.hooksPath facility doesn't introduce any sort of new security
problems that didn't exist already, and if you're just focusing on the
sort of problems changing core.hooksPath might bring up you're still
vulnerable to those.

If you give me general shell access to some repo where I can write
refs and objects you can't use hooks to sanity check anything I push.
E.g. let's say you have an "update" hook which makes sure I can't push
binaries (malware) to your "master" branch. I can just push that to
some other branch, then log in and run:

    echo <new_sha1> > /path/to/bare/repo.git/refs/heads/master

Ah ha! You might say, you'll just make that update hook run for any
branch or reference! That doesn't matter either, if you give me write
access to objects/ and refs/ I can just manually echo the objects I
want there, and then manually update the ref.

If you want to run a shared repository via ssh login where you want to
reliably execute hooks you need to either use something like Gitolite,
as Jakub points out, or e.g. set the user's shell to git-shell or some
similar facility which whitelists the commands the user can run.
Anything else is just security through obscurity.
