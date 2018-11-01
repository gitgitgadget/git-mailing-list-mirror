Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E509C1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 11:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeKAURf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 16:17:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37784 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbeKAURf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 16:17:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id z3-v6so839304wru.4
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 04:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=phn17lmzqWvrM0CGA5fx2hvEJ4ofQjohEAbMoBP8OAY=;
        b=rV2ng5QgieGpUWogqnqjrZNTJ4PZM7E8PCQrXst/Mpt87kK5Kak1Ez5kmj6tDEuOV0
         1fuNb1iUUmbDULzXTSw9Do0LZZJTfuqwgmAZMLQyHu45Boi3dneTgSV2Y2aV4LFAIhpR
         8ZmsIWkVsn+lTg2I7Lqw29rZwToyFJO1KVlpOv1SydJsUbNQ+4f2Z+Dzj3bJ+yr502hX
         GC6uXU4TxEM3WWmSMDYY2fThLFkpLfxUEHc3An8wcGK/GXZVC2VJdegGRcmd8WKZxe/A
         haiSrYcytp/LfjwMaD7BLCMTVIxhsm1jxSwdhJMqdwf5BG4T+1TtiB7Yp9oiOhwbXFDr
         dhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=phn17lmzqWvrM0CGA5fx2hvEJ4ofQjohEAbMoBP8OAY=;
        b=WeeP1fmc4Te4MPDfQL/1cIfP3uHDNEwfARlBdeXAulgLFf5LBzdTQadPoHOAV37bJB
         X1s+DiM+lLSOWxB9AB+KxccHvHvP43xwohZlLWShLDfIP6O9SbpXEfZuv6XwCN4aWAi6
         Ve3vBRdUirLpLNO66tbFPvbC6OZZGp5UeaFTibsxsrsoFvRSGlksoVDI6SN2DHHg2Nzb
         10rvKGK7s2XvGKH5gcC9ClxiCbEcXqtDGtkxkepvFvadA7tc3ec9vv6e646UKV55a94i
         wgKe9nE01XMaURNMB2mwbl6onB0kaMqGdj+woOK/YjrRgDG086ABVgzgrKSYaDzszo1G
         J1Mg==
X-Gm-Message-State: AGRZ1gKZaQuExmxFoQU8fCJW8wD6LZC4eWwL04xHCOhwoIe7oQcZm+bi
        wRb2/SVZY+qb3l6zub7SYno=
X-Google-Smtp-Source: AJdET5fBdb9cXk4Zi2RdgTvJ3X2ROLakPB5wNXpe1E5FclyuZYste2f7UtF6TfQEGaWKzk1ZLs1t3w==
X-Received: by 2002:a5d:5012:: with SMTP id e18-v6mr5598024wrt.99.1541070903577;
        Thu, 01 Nov 2018 04:15:03 -0700 (PDT)
Received: from evledraar ([2001:981:2f6f:1:6765:91b4:348a:a673])
        by smtp.gmail.com with ESMTPSA id b71-v6sm24781391wma.13.2018.11.01.04.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 04:15:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFE] Please add a standard ref object to releases
References: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net>
Date:   Thu, 01 Nov 2018 12:15:01 +0100
Message-ID: <871s85kq16.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 01 2018, Nicolas Mailhot wrote:

> git makes no provision for versioned release references.
>
> However, software projects need versioned releases. Software project
> integrators need versionned releases. Security auditors need versioned
> release. Software project users need versioned releases.
>
> Versioned releases are not the same thing as free-form tags. They have
> semantics to allow deducing upgrade paths (usually, a form of semver).
> They imply some form of API stability promise. They imply release
> documentation completion. They're not just a random point in the project
> history like tags are.
>
> This is why most git hosting sites provide a way to select versioned
> releases, even if it's not a native git concept. And this way is clearly
> separate and distinct from git tag selection.
>
> Unfortunately, since git makes no provision for versioned release
> references, git hosting sites have to shove release refs into tag refs.
> And it's a huge mess.
>
> Some put release ids in tags as-is, others add a v prefix, others a
> version_ prefix, it's all hoster-specific, it's all inconsistent. It
> ends up being inconsistent within projects, as they migrate from a
> hoster to another, are mirrored from one hoster to another. It depends
> on the habits of the person cutting a release, and the release manager
> of a project can change over time. It ends up being inconsistent in
> release archives, as the version munging can percolate in the archive
> name and structure, or not, for mysterious heuristic reasons that change
> over time.
>
> As a result, when assembling a project that uses other git repositories,
> you spend more time checking repository by repository and version by
> version how the version ref was mangled in a tag ref for this specific
> (repo,version,date) tuple, than doing actual software dev and QA work.
>
> Please add a specific release reference to git, so software projects
> that do versioned releases can use this ref object directly, without
> needing to invent custom version rewriting rules to shove them in tags
> while marking they are not just tags but release references.

For both this and your other report, it would be helpful if you describe
in concrete terms (with examples of git commands, or UI etc.) what git
commands do now, what's wrong with it, and some sketch of what you
expect an alternate interface to look like.

As for this report: I know this area of git quite well, but I still have
no idea quite what you're asking for.

Do you just mean that we should have some other second-level namespace
for tags, i.e. in addition to refs/tags/* we'd have
refs/this-time-I-really-meant-it-tags/*., and e.g. linux.git and git.git
v* tags would go into that, and have some "git tag --i-really-mean-it"
interface?

If we assume this is a good idea, how do you imagine this would work
once you don't just have two levels (random labels v.s. "real" releases)
but three or more (random labels v.s. "real" releases v.s. "LTS"
releases, ....)?
