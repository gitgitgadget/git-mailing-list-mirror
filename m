Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3460215F4
	for <e@80x24.org>; Tue,  1 May 2018 19:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750769AbeEATYF (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 15:24:05 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39560 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEATYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 15:24:04 -0400
Received: by mail-wm0-f50.google.com with SMTP id f8so9966784wmc.4
        for <git@vger.kernel.org>; Tue, 01 May 2018 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=oSSYy8kB3sftUz6SdsR5WGPgUTzBUFHhmJw+ax+VXSc=;
        b=YWMhvW0MewjFb2dFEoj0VN8Fo6h/+0b8SNSc9MYToQLvqERwrQiWIUfhwi1jE2OlQZ
         W0+f0mid1Dsxd6mFOSm4iLVaoSR9pdxUeXsLx22ZuJyO+NF/Imi1HwF3gubjNAjf0ReY
         JZYSyEx03mtM09MRfCX5SW3IQ2YAO7uWzzHH2azAoNHACCgzB67not8dFEki/gxlKita
         nH6tpxNJEB5UC639LA+dw7rSAsVP3GU9BzNeP+wOqDoLqC6oCEhZ62CRr1a6yNvndYEj
         WUZRTu2V1+wjdgTVVqLu5Dx263N76bFRI7zW65kPFDMWFyrdOlOGwxwS5alGclRztt+8
         +i4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=oSSYy8kB3sftUz6SdsR5WGPgUTzBUFHhmJw+ax+VXSc=;
        b=Zh1WdGJ8lAA+6miZ+zM0SE5W6gsF6DjrGCB4XoBMbb0fLWeC6uX9nRr2ktpsGAP9gX
         lMRrzbzJ+SXU9CrlPKwWKb1IW1SHIkTcLtjHjmeGNBNNLQMpbb017yxnPdZpklCRIL3Z
         Wdlb3ry793qVt5KHdleatCHUg+3qattlqm2vljrcFLKgWruq3TSWdikF7l30cSg4OWXL
         KIbK18g0VvquOIIHE6iA/yTD6EGUMrAZjwztKtbW1Gub4zwtI0VFmxBRKf9Q9VN2jKMj
         gSRLjGcLfkJ08WbadXgqrRYMsvyEFPrViSpMbj7Ho80TB8BxnIJDSUA/fAsi3gYFiDrC
         kgKA==
X-Gm-Message-State: ALQs6tBnIrFp8oRMlLy2T+WNncdh61RHKM5x+lP7KwsaIY7HxJ13PX4C
        BhxyypRMtyrupg8IBkXow4o=
X-Google-Smtp-Source: AB8JxZprv8nD2s1cl9fSuVXXALFBHoI+oi0JrXzC+S9kYMTe3BKCnB2ZqMG6Z4lsO78h3Wi3lxQQFg==
X-Received: by 2002:a50:bb6c:: with SMTP id y99-v6mr8003224ede.175.1525202643608;
        Tue, 01 May 2018 12:24:03 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id b4-v6sm5317827edr.29.2018.05.01.12.24.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 May 2018 12:24:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH v4 0/3] Optional sub hierarchy for remote tags
References: <xmqqbme51rgn.fsf@gitster-ct.c.googlers.com> <20180501165931.25515-1-wink@saville.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180501165931.25515-1-wink@saville.com>
Date:   Tue, 01 May 2018 21:24:00 +0200
Message-ID: <87zi1jxjqn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, May 01 2018, Wink Saville wrote:

> As discussed on the git email list [1] with the subject
> "Fetching tags overwrites existing tags" there is a bug
> where fetching tags can overwrite existing tags.
>
> Ævar Arnfjörð Bjarmasono, has created a patch series [2]
> which requires a '--force' flag when fetching if the user
> actually wants to overwrite any existing flags.
>
> This patch series allows tags in remotes to be placed in
> a sub hierarchy, refs/remote-tags when "git remote add" is
> passed the --remote-tags option.
>
> The patch series also modifies tag so "git tag -l" will list
> tags in refs/remote-tags properly. It also test for
> "git remote add" which uses "git tag -l".

Thanks a lot for working on this, it's great to have something the
direction of getting rid of this discrepancy between the 1=1 mapping for
branches, but the 1=many mapping for tags. My recent patch series and
the pruneTags feature I added in 2.17.0 are really just hacks around not
having that.

My concern with your patches is not that they're not implementing some
mythical future where we're mapping each <remote>'s refs to
remotes/<fully qualified ref> and local refs to local/<fully qualified
ref>, which is what we should really be aiming for and would forever get
us out of this rut of 1=many and local & remote refs existing in the
same namespace, but that they might make it harder to get there.

So specifically, your 1/3 writes this to the config:

  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
    tagopt = --remote-tags

If the user clones with your patch, and then uses an older git version
on the same repo (a use case we need to support) that older version
doesn't know about --remote-tags, and will fetch them all.

As a workaround for that maybe we'll need something like:

  [remote "gbenchmark"]
    url = git@github.com:google/benchmark
    fetch = +refs/heads/*:refs/remotes/gbenchmark/*
    fetch = +refs/tags/*:refs/remote-tags/gbenchmark/*
	tagStyle = remote
    tagopt = --no-tags

Or whatever, i.e. something where only the new version will fetch the
tags and ignore the tagopt option (which I never liked anyway). It's a
hack, but at least you don't end up with crap it your ref namespace by
flip-flopping between versions.

Then as I alluded to in my
https://public-inbox.org/git/20180429202100.32353-6-avarab@gmail.com/ we
have a lot of stuff that hardcodes special behaviors for
refs/{tags,heads}/, including but not limited to:

    git grep -C2 -e TAG_REFSPEC -e tag_refspec -e '"refs/tags/' -- '*.[ch]'

So maybe we need to start this series with some set of patches where we
make the currently hardcoded behavior for refs/{heads,tags}/
configurable.

Sorry about this "nice shed you built, how about you make a cathedral
instead?" E-Mail. I really don't think we should make perfect the enemy
of the good, but at the same time it would be unfortunate if we can't
get perfect because we settled for good.
