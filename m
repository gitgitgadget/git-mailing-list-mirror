Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A7541F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeK0Cfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:35:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42484 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0Cfq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:35:46 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so14276992ioa.9
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IXT/Yw9DLtbLV+qLl5+nQzgCjsuHXrcuq/q+GmCsfDI=;
        b=jNv7y/4Ptfyfd8JL+NKX9xB8fIR8VN4PAeF6+XMY6YknsY3YnqyPvhiV9Yb4lU9whj
         rNzL/1Lu/bec9nUlCapMFy0YZqQH6CjJt1WmMhIQdsn6zyxur/ASSy5bVDB1R4vg/j8I
         2E7ChD6XTKJEKr01fSV4fnS+fe+dDqXJlmomgJ9m56Yno4Tap7gSZ6qXjQ2GkJMvh4tv
         vu8fijzIPwLq/1BH5+V8EXMU1BoqS18p9rvC9MXZvPvHj5CDqgjZDkQQmHvpHgbVhPzW
         DQVxTkzfml1syN9GoErEeHv+KoLozlQFNr24mqj29pz0J+nRqEid8CmAKL9fFXNAc7r2
         uBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IXT/Yw9DLtbLV+qLl5+nQzgCjsuHXrcuq/q+GmCsfDI=;
        b=ng47f4pPqoNmt5gNEUzPo6L/URDEPFddZcIkGxqSLU6fOf/txj7Ldos4kvR1pRV2u8
         2psniYApBYD1RgGMJdtaWHdy9PVe74ZuqMM0l6pK1Rf35Q09vAjUdrEARiJQ4TbaalO+
         MO8hZr5L3KI6H+kLqL4Mo1BSkCy0wOezz5yOLrqIGAxhSAwwe3Bf1Io4o0tcNQhyrVah
         rCGEoFXpV6DHX9hKAqWNw8kjsuSyo/d3GB3Rk4tryzwKqc1LeNKJXhD24oi2Bg+fY1oj
         46uSVSJTNO9TZsj+5DePQcHBY9cf/52GWDK8SNmhB1D6CuCFLA8ilz6sNzSYUwOQ1xLu
         AAcg==
X-Gm-Message-State: AA+aEWZhZiYc7PaWX617MOgavxxSfJve3JkBD3pg9ckFf1ptDWlD0rGY
        EikWqo6b+xZQpyMCuHADVD3d4Bt8J0kqfiGrIVidjg==
X-Google-Smtp-Source: AFSGD/Vm0j0WcK5VpvIippVe67fpL4oMM41cX/CzSd+1iDkerOPcWwUOBPyrMyuGM+tG3bVHafWca/Pz0jW1/rr7Kgw=
X-Received: by 2002:a6b:6f18:: with SMTP id k24mr18165009ioc.236.1543246876678;
 Mon, 26 Nov 2018 07:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com>
 <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net>
 <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com>
 <87sgznzwcp.fsf@evledraar.gmail.com>
In-Reply-To: <87sgznzwcp.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Nov 2018 16:40:48 +0100
Message-ID: <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     per.lundberg@hibox.tv,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth (IKS)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 4:34 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Mon, Nov 26 2018, Duy Nguyen wrote:
>
> > On Mon, Nov 26, 2018 at 10:30 AM Per Lundberg <per.lundberg@hibox.tv> w=
rote:
> >>
> >> On 11/13/18 1:22 AM, brian m. carlson wrote:
> >> > This is going to totally hose automation.  My last job had files whi=
ch
> >> > might move from tracked to untracked (a file that had become generat=
ed),
> >> > and long-running CI and build systems would need to be able to check=
 out
> >> > one status and switch to the other.  Your proposed change will preve=
nt
> >> > those systems from working, whereas they previously did.
> >> >
> >> > I agree that your proposal would have been a better design originall=
y,
> >> > but breaking the way automated systems currently work is probably go=
ing
> >> > to be a dealbreaker.
> >>
> >> How about something like this:
> >>
> >> 1. Introduce a concept with "garbage" files, which git is "permitted t=
o
> >> delete" without prompting.
> >>
> >> 2. Retain the current default, i.e. "ignored files are garbage" for no=
w,
> >> making the new behavior _opt in_ to avoid breaking automated
> >> systems/existing scripts for anyone. Put the setting for this behind a
> >> new core.* config flag.
> >>
> >> 3. In the plan for version 3.0 (a new major version where some breakag=
e
> >> can be tolerable, according to Semantic Versioning), change the defaul=
t
> >> so that "only explicit garbage is garbage". Include very clear notices
> >> of this in the release notes. The config flag is retained, but its
> >> default changes from true->false or vice versa. People who dislike the
> >> new behavior can easily change back to the 2.x semantics.
> >
> > How does this garbage thing interact with "git clean -x"? My
> > interpretation of this flag/attribute is that at version 3.0 by
> > default all ignored files are _not_ garbage, so "git clean -x" should
> > not remove any of them. Which is weird because most of ignored files
> > are like *.o that should be removed.
> >
> > I also need to mark "precious" on untracked or even tracked files (*).
> > Not sure how this "garbage" attribute interacts with that.
> >
> > (*) I was hoping I could get the idea [1] implemented in somewhat good
> > shape before presenting here. But I'm a bit slow on that front. So
> > yeah this "precious" on untracked/tracked thingy may be even
> > irrelevant if the patch series will be rejected.
>
> I think a garbage (or trashable) flag, if implemented, wouldn't need any
> special case in git-clean, i.e. -x would remove all untracked files,
> whether ignored or garbage/trashable. That's what my patch to implement
> it does:
> https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
>
> I think that makes sense. Users running "git clean" have "--dry-run" and
> unlike "checkout a branch" or "merge this commit" where we'll now shred
> data implicitly it's obvious that git-clean is going to shred your data.

Then that't not what I want. If I'm going to mark to keep "config.mak"
around, I'm not going to carefully move it away before doing "git
clean -fdx" then move it back. No "git clean --dry-run" telling me to
make a backup of config.mak is no good.
--=20
Duy
