Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4F5620A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLKWmn (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 17:42:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46269 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWmn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 17:42:43 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so15705216wrt.13
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 14:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T+B1jIbqFr/WxNEdqhc1ToA1xPSHaCuqthsXzq+MW0w=;
        b=aMzm/e4cm6TiPWgspBh0YygtIRWtunV7dO2UHlPIVSd3qez5aKgzSCgIlK3pzhIsQy
         YbynMDVGpiEPCZ5MMjMWVBguK6F6jqJHKg7clSuLMzKarB/JRv8nJrDKEWEzpqDgjxcO
         KxHtBjWcCY54Regb5wIom6CUex/ZBL/7xuN2KWvq86E0nG2i6dSgtcO1hCYyUbdXglfN
         qST6dSTu+OE0hd1ggz1hxgn6jtejmxhX9YHcKSAb1o0LKE7liQkyrmp4hfIwHA6YV9qn
         anXGkgLIcIgmFjzYk/M+f5TNca0srOmsIo5231UqO1l4Yl0lwyEG86iQUr2xKfl+Lz9o
         fQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T+B1jIbqFr/WxNEdqhc1ToA1xPSHaCuqthsXzq+MW0w=;
        b=em9G8F5kwHC6AwuakB0OkVnYbmS+kdbdRHYlvLaVzTaj4ARj10uI2qs8PM0d0pIiLY
         Ut7pBmUpBvFp79roO4cG/cX9LN9u+2EHuZzyMJ3nwBPOcFeQJcrbK2QpGsR/+OO0+gHJ
         14aroto/4qgM8TbEcn5dk3tKWGHh/MXA+sztQ0IM5RagSCikkoRADNifnt2ZEM5x97XY
         cdzZ8W6GGfLhlhGa+mWeImiVGQFqAWhnT83gi9VTduWms0mBYIAc9+DBlqf9TGAlihbx
         AcGCVeC7w56Kpgrl9PlBVNMyWiOGgAFGmzT/DGTUb/z7Kr1KBRghmT6fmK/ktixTik3E
         O3Mw==
X-Gm-Message-State: AA+aEWZ+IwryqDx6XpjspTDiplz9KuK0Uqqq0uMIJiLaXGvzzMDaLO4h
        FWBUxTIL1PpJGvEbNMvOb54=
X-Google-Smtp-Source: AFSGD/WdR2EY2JsZAV4ts/t/ze0OKY7XqPoP9SsxtCR0VKCK/dRWmQQjQ5ptUgPptLIgV+gZXcO2Ig==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr15268785wrw.64.1544568161267;
        Tue, 11 Dec 2018 14:42:41 -0800 (PST)
Received: from localhost ([2.24.105.121])
        by smtp.gmail.com with ESMTPSA id h16sm42541529wrb.62.2018.12.11.14.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:42:40 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:42:39 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 5/8] checkout: introduce --{,no-}overlay option
Message-ID: <20181211224239.GV4883@hank.intra.tgummerer.com>
References: <20181209200449.16342-1-t.gummerer@gmail.com>
 <20181209200449.16342-6-t.gummerer@gmail.com>
 <CACsJy8BWZyFWZ70y4beCEYvjbc2+X-2K+gOiY+=toK0y3xYzKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8BWZyFWZ70y4beCEYvjbc2+X-2K+gOiY+=toK0y3xYzKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10, Duy Nguyen wrote:
> On Sun, Dec 9, 2018 at 9:05 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > @@ -302,15 +310,29 @@ static int checkout_paths(const struct checkout_opts *opts,
> >                 ce->ce_flags &= ~CE_MATCHED;
> >                 if (!opts->ignore_skipworktree && ce_skip_worktree(ce))
> >                         continue;
> > -               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE))
> > -                       /*
> > -                        * "git checkout tree-ish -- path", but this entry
> > -                        * is in the original index; it will not be checked
> > -                        * out to the working tree and it does not matter
> > -                        * if pathspec matched this entry.  We will not do
> > -                        * anything to this entry at all.
> > -                        */
> > -                       continue;
> > +               if (opts->source_tree && !(ce->ce_flags & CE_UPDATE)) {
> > +                       if (!opts->overlay_mode &&
> > +                           ce_path_match(&the_index, ce, &opts->pathspec, ps_matched)) {
> > +                               /*
> > +                                * "git checkout --no-overlay <tree-ish> -- path",
> > +                                * and the path is not in tree-ish, but is in
> > +                                * the current index, which means that it should
> > +                                * be removed.
> > +                                */
> > +                               ce->ce_flags |= CE_MATCHED | CE_REMOVE | CE_WT_REMOVE;
> > +                               continue;
> > +                       } else {
> 
> In non-overlay mode but when pathspec does not match, we come here too.
> 
> > +                               /*
> > +                                * "git checkout tree-ish -- path", but this
> > +                                * entry is in the original index; it will not
> 
> I think the missing key point in this comment block is "..is in the
> original index _and it's not in tree-ish_". In non-overlay mode, if
> pathspec does not match then it's safe to ignore too. But this logic
> starts too get to complex and hurt my brain.

Yes, that would make it a bit easier to read. I took a while to try
and refactor this to make it easier to read, but couldn't come up with
anything much better unfortunately.  I'll have another stab at
simplifying the logic a bit for v2.

> > +                                * be checked out to the working tree and it
> > +                                * does not matter if pathspec matched this
> > +                                * entry.  We will not do anything to this entry
> > +                                * at all.
> > +                                */
> > +                               continue;
> > +                       }
> > +               }
> >                 /*
> >                  * Either this entry came from the tree-ish we are
> >                  * checking the paths out of, or we are checking out
> 
> > @@ -1266,6 +1299,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
> >                             "checkout", "control recursive updating of submodules",
> >                             PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
> >                 OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
> > +               OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
> 
> maybe add " (default)" to the help string.

Makes sense, will add.

> >                 OPT_END(),
> >         };
> >
> -- 
> Duy
