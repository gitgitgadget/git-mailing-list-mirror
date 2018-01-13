Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17A3C1F404
	for <e@80x24.org>; Sat, 13 Jan 2018 22:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753644AbeAMWau (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jan 2018 17:30:50 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46942 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752945AbeAMWat (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jan 2018 17:30:49 -0500
Received: by mail-wr0-f195.google.com with SMTP id g21so8276378wrb.13
        for <git@vger.kernel.org>; Sat, 13 Jan 2018 14:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PAYwPpAiyrASy+A3VAL7gfWHAfwoClaHmJmPlbNeQvI=;
        b=GhcWyPUKPWyAXsIwyRKMdSPhUcepZ9tGJHiaV4PQJKQR6D1Ls/clkgTKkkZUc0XL+M
         zKCdAAjy2Dcp6SLibEN1mAfcdDLVXSVG3cT8z5OOyBY6cIzaDdeIlBM3Utr5+ExyoBjO
         jnvUWCG5JxACV0V1xqvrX2VZPGcV1cSMu2nfcdPshZXshYkVIIrfMUiGh2d/UPoDEQN7
         CGHFZzYGZE7CJqUKG91sWiojEOH9KW/UcrjQB3ecpR29Y6+Sh1TMT4W95UB408hdcbRO
         GjEFXtarq6W0r10jZ6Ihzt4DVI25w2F/Gn43eW4BeyT4Ck/+3LB3qvX3uP4nhngU6gaz
         WwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAYwPpAiyrASy+A3VAL7gfWHAfwoClaHmJmPlbNeQvI=;
        b=QoVi0bwcGYbPlm6lJVg9aM80Dnk9zoIyki/AWdJTJvGg7xZeJRP85E5F/iTv3nU0IT
         QgBAW8yjwXqIUlnc702jdtSpu1IWC1qf7v0x4hIdmK1mkQKSDikLezrwMdt5+n3vGR/3
         MHGEdYYk14Lt9m2PAqW4N1+Y8CdXqdivaHbHf3KJGH5JbSC9gU8MVlRNJV2jG6tbMNxc
         vMG9xZLp/E1V9W3X+Pwkrt5g+LkhmKuwV1WcnU42g0NvRR6tLLzoEKT4KBYcTV7rQ9w3
         JPLzo3dzFtiOO7Qhg3+4JTajwlFo5MbpLoyHfykXwz7tWyiUwj4agu7aTXt0K45JBbYn
         fcEg==
X-Gm-Message-State: AKGB3mJKum+g4B1S/Z6uESXfBkOUgfCUJueluLViiLHH+rfxOyghZm6c
        qeOCUq83N47FGg+5aGIrOqcnFT7r
X-Google-Smtp-Source: ACJfBosV5NJxufQFk81TMnv7bCu1CFNO6JXrbKcKrUdwDoyzy32z2JbVguwUQaUTSirDbwhOtkPpVQ==
X-Received: by 10.223.189.130 with SMTP id l2mr28109951wrh.61.1515882648047;
        Sat, 13 Jan 2018 14:30:48 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id p132sm9249983wmb.0.2018.01.13.14.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jan 2018 14:30:46 -0800 (PST)
Date:   Sat, 13 Jan 2018 22:33:03 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] read-cache: fix reading the shared index for
 other repos
Message-ID: <20180113223303.GI2641@hank>
References: <20171217225122.28941-1-t.gummerer@gmail.com>
 <20180107223015.17720-1-t.gummerer@gmail.com>
 <20180107223015.17720-2-t.gummerer@gmail.com>
 <CACsJy8DBkAwoNWSma-+WkOUkQrenbkT5c1-Ez2jmmf-+wGRbxQ@mail.gmail.com>
 <20180108224110.GH2641@hank>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108224110.GH2641@hank>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/08, Thomas Gummerer wrote:
> On 01/08, Duy Nguyen wrote:
> > On Mon, Jan 8, 2018 at 5:30 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > > @@ -1896,16 +1895,17 @@ int read_index_from(struct index_state *istate, const char *path)
> > >                 split_index->base = xcalloc(1, sizeof(*split_index->base));
> > >
> > >         base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> > > -       base_path = git_path("sharedindex.%s", base_sha1_hex);
> > > +       base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
> > 
> > Personally I prefer the repo_git_path() from v2 (sorry I was away and
> > could not comment anything).
> 
> It felt slightly nicer to me as well, but it threw up a bunch of
> questions about how worktrees will fit together with struct
> repository.  As I don't feel very strongly about this either way I
> decided to go with what Brandon suggested as an alternative, which
> allows us to defer that decision.  I'd be happy to revert this to the
> way I had it in v2, but I don't want to drag the discussion on too
> long either, as this series does fix some real regressions.
> 
> > The thing is, git_path() and friends
> > could do some path translation underneath to support multiple
> > worktrees. Think of the given path here as a "virtual path" that may
> > be translated to something else, not exactly <git_dir> + "/" +
> > "sharedindex.%s". But in practice, we're not breaking the relationship
> > between $GIT_DIR/index and $GIT_DIR/sharedindex.* any time soon, doing
> > manual path transformation here is fine.
> >
> > What about the other git_path() in this file? With patch applied I still get
> > 
> > > ~/w/git/temp $ git grep git_path read-cache.c
> > read-cache.c:           shared_index_path = git_path("%s", de->d_name);
> > read-cache.c:   temp = mks_tempfile(git_path("sharedindex_XXXXXX"));
> > read-cache.c:                         git_path("sharedindex.%s",
> > sha1_to_hex(si->base->sha1)));
> > read-cache.c:           const char *shared_index = git_path("sharedindex.%s",
> 
> Good point, I hadn't looked at these, I only looked at the current
> test failures.  I'm going to be away for the rest of the week, but
> I'll have a look at them when I come back.
> 
> > I suppose submodule has not triggered any of these code paths yet. Not
> > sure if we should deal with them now or wait until later.

Having had a look at these now, they are all in the write_locked_index
codepath.  We should probably have something like
'repo_write_locked_index()' for this.  But that probably requires a
bit more work/discussion to see what this should look like.  I'd
rather keep this patch series focused on the current breakages, and
deal with that in a separate patch series.

While looking at this, I did find another breakage in the split index
code, which I'll send as 4/3.

> > Perhaps if we add a "struct repository *" pointer inside index_state,
> > we could retrieve back the_repository (or others) and call
> > repo_git_path() everywhere without changing index api too much. I
> > don't know. I like the  'struct repository' concept but couldn't
> > follow its development so I don't if this is what it should become.
> 
> Interesting.  I didn't follow the development of  struct repository
> too closely either, so I'm not sure.  Brandon might have more of an
> opinion on that? :)
> 
> > -- 
> > Duy
