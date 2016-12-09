Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64BC1FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 23:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752462AbcLIXAd (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 18:00:33 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34570 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751888AbcLIXAc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 18:00:32 -0500
Received: by mail-pg0-f49.google.com with SMTP id x23so12297052pgx.1
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 15:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6yrBTwaEE9a09DkMWKFDn9Rijme+9vWlXUmd6un1YU=;
        b=GOv61hyG+fxnUV7LtDB7vRZ/1Gnl2nY/mPAHwknDLw4I4FvLIRL3TsVh61KmPmR1o0
         43krKVXUZv5/0ybQoAEFQDlRXz3izY9FSxgkcXr+4NoibaNaoknWxPg86qK2OagdMrk9
         0WG5Td2C7KZ38B/xB4x8QurzyLzxqu0csiLngtxY61qU5tmRT1Iqb6ZcmAPtV6bZnWku
         Iwqjj2dcHV28FCpA7JwORi/rSoQpGzY2Mw8c0fBM1U/rBF44ypHMWRByBSJ6iCPFJSK9
         L2L5TZiAWnlELKERvDyMn7XfESDsEo87aKZ1gri0S+hur0xlElWim5a+4smXgAwnHdAF
         XRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6yrBTwaEE9a09DkMWKFDn9Rijme+9vWlXUmd6un1YU=;
        b=ZAuKRZMdLCOZkg5p+p5cCixcoiLtuQ3j8P8M9wdasiIfunhHZ2ALsZmvKfjk2uQ4LV
         eymF4lsy2PD0QOotVOP3rr/T6Jdh9KTUcWzaq4a4hicQ4p4rrJV9U2kZulb/+bZuMPhT
         6j8aOiXU3UUsGvlmCuHF3rRRNcHuUKDTzrzAhv1TVh7a4eJLRkUGFXf1FKw5lFYeNNaQ
         pmqVD4ZWd3rE1M1S3Bl64kf0xvKd/aHeWFYBWDuEDGpodhr09GPIQi7fsNgN/hd/KtFD
         yh8pqQSfMaHYHsYY+uNkxI15FUj5e6Eq03wX0ph/9e/V8P/14+fQZoOmA/94i7OFxqwM
         Q9kw==
X-Gm-Message-State: AKaTC01s0ZnS+T7VNK/rJoWIjkZh6K+gZRK1xG+n+DwvR7i6+R+FxOY1j5nXny3tUkp3v+Hb
X-Received: by 10.84.168.4 with SMTP id e4mr162341770plb.160.1481324432040;
        Fri, 09 Dec 2016 15:00:32 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b541:bdf2:ef3a:110f])
        by smtp.gmail.com with ESMTPSA id d197sm59838749pfd.38.2016.12.09.15.00.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Dec 2016 15:00:30 -0800 (PST)
Date:   Fri, 9 Dec 2016 15:00:29 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 4/7] worktree: get worktrees from submodules
Message-ID: <20161209230029.GF88637@google.com>
References: <20161208014623.7588-1-sbeller@google.com>
 <20161208014623.7588-5-sbeller@google.com>
 <CACsJy8Bs78ywGq5p6yAFGi1KACAXFEeroyQSJye5-RL5gqOS+Q@mail.gmail.com>
 <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kYtEUvuTX09sJm3C0rG0-BrBz4bN0FCs6E5d2jHhtKN6w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/08, Stefan Beller wrote:
> On Thu, Dec 8, 2016 at 2:09 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Dec 8, 2016 at 8:46 AM, Stefan Beller <sbeller@google.com> wrote:
> >>
> >>         worktree = xcalloc(1, sizeof(*worktree));
> >>         worktree->path = strbuf_detach(&worktree_path, NULL);
> >> @@ -101,7 +101,8 @@ static struct worktree *get_main_worktree(void)
> >
> > All the good stuff is outside context lines again.. Somewhere between
> > here we call add_head_info() which calls resolve_ref_unsafe(), which
> > always uses data from current repo, not the submodule we want it to
> > look at.
> 
> Unrelated side question: What would you think of "variable context line
> configuration" ? e.g. you could configure it to include anything from
> up that line
> that is currently shown after the @@ which is the function signature line.
> 
> As to the add_head_info/resolve_ref_unsafe what impact does that have?
> It produces a wrong head info but AFAICT it will never die(), such that for the
> purposes of this series (which only wants to know if a submodule uses the
> worktree feature) it should be fine.
> 
> It is highly misleading though for others to build upon this.
> So maybe I'll only add the functionality internally in worktree.c
> and document why the values are wrong, and only expose the
> "int submodule_uses_worktrees(const char *path)" ?
> 
> >> @@ -209,6 +211,30 @@ struct worktree **get_worktrees(unsigned flags)
> >>         return list;
> >
> > Right before this line is mark_current_worktree(), which in turn calls
> > get_git_dir() and not suitable for peeking into another repository the
> > way submodule code does. get_worktree_git_dir() called within that
> > function shares the same problem.
> 
> It actually works correctly: "No submodule is the current worktree".
> 
> 
> >
> >>  }
> >>
> >> +struct worktree **get_worktrees(unsigned flags)
> >> +{
> >> +       return get_worktrees_internal(get_git_common_dir(), flags);
> >> +}
> >> +
> >> +struct worktree **get_submodule_worktrees(const char *path, unsigned flags)
> >> +{
> >> +       char *submodule_gitdir;
> >> +       struct strbuf sb = STRBUF_INIT;
> >> +       struct worktree **ret;
> >> +
> >> +       submodule_gitdir = git_pathdup_submodule(path, "%s", "");
> >> +       if (!submodule_gitdir)
> >> +               return NULL;
> >> +
> >> +       /* the env would be set for the superproject */
> >> +       get_common_dir_noenv(&sb, submodule_gitdir);
> >
> > Technically we need to read submodule_gitdir/.config and see if we can
> > understand core.repositoryformatversion, or find any unrecognized
> > extensions. But the problem is not specific to this code. And fixing
> > it is no small task. But perhaps we could call a dummy
> > validate_submodule_gitdir() here? Then when we implement that function
> > for real, we don't have to search the entire code base to see where to
> > put it.
> >
> > Kinda off-topic though. Feel free to ignore the above comment.
> 
> ok I'll add a TODO/emptyfunction for that.

So is using resolve_gitdir not ok when trying to see if a submodule has
a gitdir at a particular path?

-- 
Brandon Williams
