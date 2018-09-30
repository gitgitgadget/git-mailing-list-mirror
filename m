Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECFB41F453
	for <e@80x24.org>; Sun, 30 Sep 2018 07:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeI3OIm (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 10:08:42 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55912 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeI3OIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 10:08:42 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so7490613itd.5
        for <git@vger.kernel.org>; Sun, 30 Sep 2018 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ePnscTDHLKYT17mfpLwbX248U44OU+X7Aj8RO6GfhA=;
        b=rzDePX/h9yZ09rOUrdIR80KZSmbm8eweuQ6kDRJl2mYobx9uDdxhzvL0djPzIGDRXo
         voHq0DSBiEd8TrUkoIOdSevQC87bP6qgtWiOFjiCDPXMpoLbhRuFlWvV/uWFO3kDGLsl
         FgQQcFaNvR7VwNv4upSdqGKt6waPD1PhCjFrt3kIob98bsqjataU93U6F/zUMJfivRDi
         nbtNaJ2upmrJ9xGM/d+oXBbUDXvh4hMNfaybClgWQk4hPSodUnlwFPOc+nhu+FZz0fwJ
         tNC75ZFBZCgW79Pf8QTzJz708VRtpY5KJNUXK8KtD14SwvQjJOCaUNe364mKmdmQug23
         tolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ePnscTDHLKYT17mfpLwbX248U44OU+X7Aj8RO6GfhA=;
        b=pO2v5FMEftCx5E+FkpYxU23kuZ5moD9rZ2zE6Z04/rnNYeiqMzaBOguk6OvDY7B8wA
         blKortG1kmeY5BhlUNaTcBefeBJV8o7N1/mCsU6tCu9mI7813RSvUbHU3GdWW/FsA6r/
         lYoLCTPHCtv9t3wi3CBGDkKitf7noBUdetmXriY6Ba7Gsoox0VLqEvbAL0TZ1uc9SCZf
         yipePf+4RRDfxeeSlMLI9vGiu/xj6jnc8S7/Xxmi8CQR/Pur78pYfG+Ecx4MNVSeKjm8
         IgLoK6tmewS6z6FLrBCf23P4ragkqDD6qCo3QvwAGu4i01d+5StlqS0gsm6GbNBkbyUW
         PWUw==
X-Gm-Message-State: ABuFfojiadUE2rvsw2gMZ1T9INUMTEZitJgMPpLPBnzXBPVjEbrgDR+n
        dqZW9MbR4G4/hxFeS/91oMEPLcd5V1kpJ4RdVHc=
X-Google-Smtp-Source: ACcGV60sFWbvfFP9m14tJ2PxmLlHT3DjXfQ2KM1uBp1MArLcFW/NF11WjeRQNIwDOu4RH2oatB3dSA+uvOA9JH72NRM=
X-Received: by 2002:a24:328d:: with SMTP id j135-v6mr6670448ita.5.1538293008209;
 Sun, 30 Sep 2018 00:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180923170438.23610-1-pclouds@gmail.com> <20180929153005.10599-1-pclouds@gmail.com>
 <20180929153005.10599-3-pclouds@gmail.com> <CAPig+cSv4P99ZJ=CtCC7HctfSg5W6sadiknhk9yXSaBDZ81ctw@mail.gmail.com>
 <CACsJy8AVowvXDkOh_fjdRpNtcXWchxFULbE8m9ZPQN9BsJx5ag@mail.gmail.com> <CAPig+cTJKuEkb5AVi=xyztfEo84NzaduNnX3mhec3xrYf4PGUg@mail.gmail.com>
In-Reply-To: <CAPig+cTJKuEkb5AVi=xyztfEo84NzaduNnX3mhec3xrYf4PGUg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 30 Sep 2018 09:36:22 +0200
Message-ID: <CACsJy8BrdXZx3+exwL-xDfdTxMa4Ez1y051CaKA3z2e7OC2FZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] worktree: add per-worktree config files
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 30, 2018 at 9:24 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Sep 30, 2018 at 3:16 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > On Sun, Sep 30, 2018 at 6:33 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > > diff --git a/builtin/config.c b/builtin/config.c
> > > > @@ -645,7 +649,20 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> > > > +       else if (use_worktree_config) {
> > > > +               struct worktree **worktrees = get_worktrees(0);
> > > > +               if (repository_format_worktree_config)
> > > > +                       given_config_source.file = git_pathdup("config.worktree");
> > > > +               else if (worktrees[0] && worktrees[1])
> > > > +                       die(_("--worktree cannot be used with multiple "
> > > > +                             "working trees unless the config\n"
> > > > +                             "extension worktreeConfig is enabled. "
> > > > +                             "Please read \"CONFIGURATION FILE\"\n"
> > > > +                             "section in \"git help worktree\" for details"));
> > > > +               else
> > > > +                       given_config_source.file = git_pathdup("config");
> > >
> > > I'm not sure I understand the purpose of allowing --worktree when only
> > > a single worktree is present and extensions.worktreeConfig is not set.
> > > Can you talk about it a bit more?
> >
> > Unified API. If I write a script to do stuff and want it to work in
> > multiple worktrees as well, I should not need to do "if single
> > worktree, use "git config --local", if multiple use "git config
> > --worktree"". By using "git config --worktree" I tell git "this config
> > is per-worktree" and git should do the right thing, single worktree or
> > not.
>
> That's what I thought, but I still don't understand how that unified
> API is going to help if the script writer happens to have multiple
> worktrees but doesn't have extensions.worktreeConfig set, in which
> case the command will error out. I don't see how that simplifies
> things, but perhaps I'm missing something obvious.

No it does not simplify that step. The user has to enable it manually
(at least for now). v1 tried to enable it automatically, but I think
it's safer to go one step at a time.
-- 
Duy
