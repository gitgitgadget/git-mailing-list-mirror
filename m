Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97AB81F576
	for <e@80x24.org>; Sat,  3 Mar 2018 10:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeCCKFW (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Mar 2018 05:05:22 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:39390 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeCCKFV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Mar 2018 05:05:21 -0500
Received: by mail-qk0-f173.google.com with SMTP id z197so15070628qkb.6
        for <git@vger.kernel.org>; Sat, 03 Mar 2018 02:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=gYP+/avVfYvIxslh4eb/jCwVoXztzeR1VD8orb4z/Gs=;
        b=PzPWnDvmNW21qvY8ItZf9oO5aR6oMxqvqeGEkNmA61gNbMplZ9A6iq2YovXlA/BzSR
         vOxFEmilH6+PEBzp+W40r+5R24TCwxoiSXX9izy0RYLGARkbrqRyI0MFoWiNBj2rspcs
         Pe406aPGmR0kiMi3Z8exwV+zRz64WgJqbHqQmBrQt/P1MpeWM9oASI6K+Tc0N+YylFcs
         2zrr783/nYdVtXzAFUu+i6zAJA2rmlBDNRePbNVj9qAJTYNCoirUTOT75paPWyjXCQ1N
         dh9Yguf/HQ3vGizFCBKrX+DsKOSIy9Cs2cUQNyTDTYTW8N/L+IUtNM4KDwTPurKxfPxk
         5yuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=gYP+/avVfYvIxslh4eb/jCwVoXztzeR1VD8orb4z/Gs=;
        b=C44gERUpTKU7YQ4U/QbIs51NTC8pXW+kdu0fiaN98deQ4RCUsTU4GfR+3NG4AC1VJr
         QkOd0unvP1D2oEHnj+EzoM4DUkp+QnjJpzmB5id1Bde1euAkJm9L4cviOqHt0rcYxCzq
         Wl0ujCv8LmpCkLDRY2d0TFXuJDP243VBwR9585AV26aD9JeDgAIHJ4/Uq9LkqJSqsUCB
         66Lua1sn0Bl//evpeoBoToPInH7aiwt/uTyeaNr1EXX3lE7/X0AI/2ZVEZMmIV4OM1+f
         0ynyF4nz1G0jyuRcf70t9gJKZ81aSBcmmHlyISNjtTcciI2PGjqWDIw/TF8vjSAMI8YE
         8Rfg==
X-Gm-Message-State: AElRT7HMFOIU/cX9hBhiOkPOud40il7gol6tL3+4bMJtCNvLPufZnb1s
        6ILZ7R/T7lwnhJddwT1oSqh9QJMKRAsea1BqNqY=
X-Google-Smtp-Source: AG47ELvqQH7dXptQImrHIaV+h90rmjkhC5eYaOwjR37lT3th5PKc5suWC6gerfacIGomyV1XfBC6S6zyxDMCP/xen6w=
X-Received: by 10.55.32.2 with SMTP id g2mr12552174qkg.176.1520071520531; Sat,
 03 Mar 2018 02:05:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sat, 3 Mar 2018 02:05:20 -0800 (PST)
In-Reply-To: <CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8SGW_Q@mail.gmail.com>
References: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
 <CAPig+cSGJhNR8dapLXN0TU8ZpTqi7m6OQf_cCGmHc9FLGcwNyg@mail.gmail.com>
 <adf7a7a0-3571-5b68-5d15-30a9067e3826@aegee.org> <CAPig+cTPFSbT7WxyoNEOSg=3Ft1pVzkgieGp44kHnZ9=NbYsqg@mail.gmail.com>
 <CACsJy8BUKCG-yiYX3ouMVa44iEo0swHpTkhW3ho_T0PCP81DSw@mail.gmail.com>
 <b34d74fa-f4c7-fb4a-49df-cd7ebd996d95@aegee.org> <CACsJy8CXEKG+WNdSPOWF7JDzPXidSRWZZ5zkdMW3N3Dg8SGW_Q@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 3 Mar 2018 05:05:20 -0500
X-Google-Sender-Auth: Xd7NgWCs_Qdy1tusI2x-TIUTJCw
Message-ID: <CAPig+cRGMEjVbJZKXOskN6=5zchisx7UuwW9ZKGwoq5GQZQ_rw@mail.gmail.com>
Subject: Re: Worktree silently deleted on git fetch/gc/log
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 2, 2018 at 6:53 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> I'm going to improve it a bit in this case either way, I think I have
> some idea: (mostly to Eric) since worktree B is alive and kicking, it
> should keep at least HEAD or index updated often. We can delay
> deleting a worktree until both of these are past expire time.

Make sense.

> Also Eric (and this is getting off topic), I wonder if the decision to
> store absolute path in worktrees/../gitdir and .git files is a bad one
> (and is my bad).

Your original implementation of worktrees was able to recover
automatically when a worktree was moved (via 'mv', for instance). That
feature pretty much required recording an absolute path in the
worktree's .git file. When the automatic-recovery feature was dropped,
I suppose the need for absolute path in the .git file disappeared, as
well.

I can't presently think of a reason why gitdir needed/used an absolute
or normalized path. Was it because there was some need to compare such
paths?

> If we stored relative path in ".git" file at least, the worktree would
> immediately fail after the user moves either the linked checkout, or
> the main one. This should send a loud and clear signal to the user
> "something has gone horribly" and hopefully make them connect it to
> the last rename and undo that. "git gc" would have near zero chance to
> kick in and destroy stale worktrees.

It would detect if the main or linked worktree moved up or down one or
more directory levels or elsewhere.

It would not detect if the worktree directory was merely renamed.

Still, detecting some cases of breakage early may be better than not
detecting breakage at all.

Another idea may be to store the worktree's own normalized/absolute
path as a second line in its .git file. It could then immediately
detect any manual movement or renaming of itself. A minor concern,
though, is if there are any external tools reading that file directly
since they could be confused by the second line. Of course, such tools
hopefully would be using "git rev-parse --git-dir", so maybe it
wouldn't be a big deal. On the other hand, older versions of Git
itself would be confused by the second line, so perhaps the idea isn't
viable.

> Another bad thing about absolute paths, if you backup both main and
> linked worktrees in a tar file, restoring from the backup won't work
> unless you restore at the exact same place.
> Hmm?

Yep, that's an issue. An even simpler case is the somewhat common
usage pattern of creating worktrees within the main worktree (Dscho
has a number of times mentioned working like this, and I've done it
myself). In such a case, even just moving or renaming the main
worktree breaks the linked ones when absolute paths are in play.

So, yes, these issue argue for use of relative paths.
