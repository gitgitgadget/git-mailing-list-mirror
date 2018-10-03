Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9446E1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 16:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJCXso (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 19:48:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40550 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJCXso (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 19:48:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so2518709wro.7
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=P96rK3+LvZZ5Mud3LHAJmHaycWzCZdgeq/Hbb61VsE4=;
        b=O8d35mA/VKO0/7fvPxfZr9XdDpItaZjC1nAYw8Q1rc78syLuDuZjf8LiUz4aFxdko2
         n4PrzvTyCn58oNoR2CcPmS44edE/87v4YI4DM2mwyTxsuRiSd1+ncpmsChJxRFYv/rZr
         IocN55t0pJSq5XLYDANMaPrWm5Z47K5Q/8KkFwqBBRKSlr3MoVYotYi0ywuWp0oG+Uj7
         J5QNTE8d0xey7/Unk3OeaaPaHQDoMFA/cDARZuF5VxNjhlos2TExQo5A9T0t5CDi2YD1
         xm83B6s7bioWtF9ah1TJlnDTdJAz1FIfq2MVIR+2ijnw2JxUNxmiE9UdGlM7XTqXkLXW
         /A4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=P96rK3+LvZZ5Mud3LHAJmHaycWzCZdgeq/Hbb61VsE4=;
        b=LAHqzsjSasz1bnwrd9ZNLPfFLnNk0T6PwgLLovGNYdxhKrCPSeMWMpzPgPJN4kjaPh
         ahHgAD6pjIfjfr5oQiNE5MjLwZgTyC8b9qpe+qCTXapyOK+eJgi8EKR00q5ziXTm5+FQ
         jW6P3sMvZ5km+WICBfcMvUcjltj7WgkRXImQcDBV6tl/hJPeSBbd2o4L1cJJ+jq4Aay/
         mXN/8zlIsyHRrQ0TBF32BGm8dTcxgYzFCKCCT5TkLFeZRZBPqEkA8vX8cmFb406trndv
         gx7XkIcyVC3J//1/HwUamwGMtHPD0s6v22/WPL0KGZ6dFhELXlCV9mILcYCPGq37SfVT
         PhxA==
X-Gm-Message-State: ABuFfoh003+X4emTkgFAsIIG8+fpwK0XK040oJniNAFHzOcHJsWeUbw3
        u6jb3af9RZhu7MEkloDliow=
X-Google-Smtp-Source: ACcGV60q4Yg9d4JJqbKSSpFYQI4lEQ5yC1a1IldJZThjGHI3G8jyCa5wzLUy8R32dc+E+ZszB1aSqQ==
X-Received: by 2002:a5d:618f:: with SMTP id j15-v6mr2166683wru.198.1538585969561;
        Wed, 03 Oct 2018 09:59:29 -0700 (PDT)
Received: from localhost (x4dbea401.dyn.telefonica.de. [77.190.164.1])
        by smtp.gmail.com with ESMTPSA id v76-v6sm3528495wmd.32.2018.10.03.09.59.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 09:59:28 -0700 (PDT)
Date:   Wed, 3 Oct 2018 18:59:26 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit
 graph
Message-ID: <20181003165926.GR23446@localhost>
References: <87tvm3go42.fsf@evledraar.gmail.com>
 <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com>
 <20181003141732.GO23446@localhost>
 <87o9cbglez.fsf@evledraar.gmail.com>
 <20181003145308.GP23446@localhost>
 <87murvgir6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87murvgir6.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 05:19:41PM +0200, Ævar Arnfjörð Bjarmason wrote:
> >> >> >> So we should make "git gc --auto" be run on clone,
> >> >> >
> >> >> > There is no garbage after 'git clone'...
> >> >>
> >> >> "git gc" is really "git gc-or-create-indexes" these days.
> >> >
> >> > Because it happens to be convenient to create those indexes at
> >> > gc-time.  But that should not be an excuse to run gc when by
> >> > definition no gc is needed.
> >>
> >> Ah, I thought you just had an objection to the "gc" name being used for
> >> non-gc stuff,
> >
> > But you thought right, I do have an objection against that.  'git gc'
> > should, well, collect garbage.  Any non-gc stuff is already violating
> > separation of concerns.
> 
> Ever since git-gc was added back in 30f610b7b0 ("Create 'git gc' to
> perform common maintenance operations.", 2006-12-27) it has been
> described as:
> 
>     git-gc - Cleanup unnecessary files and optimize the local repository
> 
> Creating these indexes like the commit-graph falls under "optimize the
> local repository",

But it doesn't fall under "cleanup unnecessary files", which the
commit-graph file is, since, strictly speaking, it's purely
optimization.

That description came about, because cleaning up unnecessary files,
notably combining lots of loose refs into a single packed-refs file
and combining lots of loose objects and pack files into a single pack
file, could not only make the repository smaller (barring too many
exploding unreachable objects), but, as it turned out, could also make
Git operations in that repository faster.

To me, the main goal of the command is cleanup.  Optimization, however
beneficial, is its side effect, and I assume the "optimize" part was
added to the description mainly to inform and "encourage" users.
After all, the command is called 'git gc', not 'git optimize-repo'.

> and 3rd party tools (e.g. the repo tool doing this
> came up on list recently) have been calling "gc --auto" with this
> assumption.
> 
> >>  but if you mean we shouldn't do a giant repack right after
> >> clone I agree.
> >
> > And, I also mean that since 'git clone' knows that there can't
> > possibly be any garbage in the first place, then it shouldn't call 'gc
> > --auto' at all.  However, since it also knows that there is a lot of
> > new stuff, then it should create a commit-graph if enabled.
> 
> Is this something you think just because the tool isn't called
> git-gc-and-optimzie, or do you think this regardless of what it's
> called?

Well, that still has 'gc' in it...

> I don't see how splitting up the entry points for "detect if we need to
> cleanup or optimize the repo" leaves us with a better codebase for the
> reasons noted in
> https://public-inbox.org/git/87pnwrgll2.fsf@evledraar.gmail.com/

Such a separation would be valuable for those having gc.auto = 0 in
their config.  Or, in general, to have a clearly marked entry point to
update all the enabled "purely-optimization" files without 'gc'
exploding a bunch of "just-became-unreachable" objects from deleted
reflog entries and packfiles, or without performing a comparatively
expensive repacking.  Note the "clearly marked"; I don't think
teaching 'gc [--auto]' various tricks to only create/update these
files without doing what it is fundamentally supposed to do qualifies
for that.


