Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1ADF1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfGBKrT (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 06:47:19 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43290 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfGBKrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 06:47:19 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so26795323edr.10
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6ZcBamMrF7OdfrMAgrJlzOm1D6mOljyZI3/fv1W79ZQ=;
        b=L3ltciIEcK8mu/qQra1nJOM96EohBSOaYEjgJxWZUM+2yA/I9iNi+FQgqEdp9DP02X
         UEg2HhRNg39VZxMG7v1tcudhyxHX3o7Kh3JjhLVI+9YCOS1Oh9sfZ8TeA/HnhFBfw9xh
         ZLhQUpO+9NVllutMJVPjdDegryR00Y8Uyybao3/G45zaorwmM7fEfPFUUS5PwzddH6ap
         gxKH2M9QFr4fjsZmartQakqkmt5zIdM0Rgs4rj4YrRP73XjSxo8vv0k0WG6ShMtGsSsG
         sZkeZI8sZLYUPaZIuvRwheCvjO+DPeGUe3Dfkr5bdZZ5yltI7MUnf2Ni+G91wk9KijkB
         VpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6ZcBamMrF7OdfrMAgrJlzOm1D6mOljyZI3/fv1W79ZQ=;
        b=lcCKxUtD52Cyl4OCxUHPnQnktx/G4WWgyHx5LdnDDvku4nSW1FHOrNzohrWh4mJung
         FsWH/ZozGAfsGdrpCVrDyqlTLQAD3UHQ4KIYSHpAb9Yimu4lytVbsRzoG0+g73Htb13N
         q7ULU61Wq7mdmeCXT/yygbEOvqwOn8yT3LUwADtvUrHi6VoBQWUwpIxLCn9UjjzwrH4H
         6Y+9LEvoyBp70JIaO+ShX+wKhyZVRRhvV/dEXNc/ETyXpg00Ampp6g1rltXrsNmW/TKt
         EYBOGmwwVlqc1N8tAttwy14WkIZ9emkmRpSty8zxhhOrF7lcII3lr3KgrzbWmvEzHskY
         efpA==
X-Gm-Message-State: APjAAAV0v4Nwra+rDWHS1PSH3+4i2ZNP/y9233snLJQvl/uKoVbodrxC
        LFDtoh6DOOW4b16L+GprAtKoUXhHcxU=
X-Google-Smtp-Source: APXvYqwUeGtx5QtIdtKkW4sRnjLeuTfQByzLI+9dAbzlMcIKqwqusrIVAKFmkw55fmgXzjmQmIOF9w==
X-Received: by 2002:a17:906:2ecc:: with SMTP id s12mr7620762eji.110.1562064437149;
        Tue, 02 Jul 2019 03:47:17 -0700 (PDT)
Received: from evledraar (i237193.upc-i.chello.nl. [62.195.237.193])
        by smtp.gmail.com with ESMTPSA id h10sm4554263eda.85.2019.07.02.03.47.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 03:47:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/3] repo-settings: create core.featureAdoptionRate setting
References: <pull.254.git.gitgitgadget@gmail.com> <pull.254.v2.git.gitgitgadget@gmail.com> <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <bdaee3ea9df0533c268d6bebbd252c00cfbaccd6.1560957119.git.gitgitgadget@gmail.com>
Date:   Tue, 02 Jul 2019 12:47:15 +0200
Message-ID: <87sgro7lxo.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 19 2019, Derrick Stolee via GitGitGadget wrote:

>  core.commitGraph::
>  	If true, then git will read the commit-graph file (if it exists)
> -	to parse the graph structure of commits. Defaults to false. See
> +	to parse the graph structure of commits. Defaults to false, unless
> +	`core.featureAdoptionRate` is at least three. See
>  	linkgit:git-commit-graph[1] for more information.
>
>  core.useReplaceRefs::
> @@ -601,3 +602,21 @@ core.abbrev::
>  	in your repository, which hopefully is enough for
>  	abbreviated object names to stay unique for some time.
>  	The minimum length is 4.
> +
> +core.featureAdoptionRate::
> +	Set an integer value on a scale from 0 to 10 describing your
> +	desire to adopt new performance features. Defaults to 0. As
> +	the value increases, features are enabled by changing the
> +	default values of other config settings. If a config variable
> +	is specified explicitly, the explicit value will override these
> +	defaults:
> ++
> +If the value is at least 3, then the following defaults are modified.
> +These represent relatively new features that have existed for multiple
> +major releases, and present significant performance benefits. They do
> +not modify the user-facing output of porcelain commands.
> ++
> +* `core.commitGraph=true` enables reading commit-graph files.
> ++
> +* `gc.writeCommitGraph=true` eneables writing commit-graph files during

I barked up a similar tree in
https://public-inbox.org/git/CACBZZX5SbYo5fVPtK6LW1FF96nR5591RHHC-5wdjW-fmg1R0EQ@mail.gmail.com/

I wonder if you've seen that & what you think about that
approach. I.e. have a core.version=2.28 (or core.version=+6) or whatever
to opt-in to features we'd make default in 2.28. Would that be your
core.featureAdoptionRate=6 (28-28 = 6)?

I admit that question is partly rhetorical, because I think it suggests
how hard it would be for users to reason about this.

The "core.version" idea also sucks, but at least it's bound to our
advertised version number, so it's obvious if you set it to e.g. +2 what
feature track you're on, and furthermore when we'd commit to making that
the default for users who don't set core.version (although we could of
course always change our minds...). It's also something that mirrors how
e.g. Perl, C compilers (with --std=*) treat this sort of thing.

So I'm all for a facility to have a setting to collectively opt-in to
new things early. But I think for such a thing we really should a) at
least in principle commit to making those things the default eventually
(if they don't suck) b) it needs to be obvious to the user how the
"rate" relates to git releases.

This "core.featureAdoptionRate" value seems more like zlib compression
values & unrelated to release numbers. It's also for "performance
features" only but squats a more general name. I suggested
"core.version" & then "core.uiVersion" (in
https://public-inbox.org/git/87pnunxz5i.fsf@evledraar.gmail.com/).

Regardless of whether we want to pin opt-in early-bird features to
version numbers in some way, which I think is a good idea, but maybe
others disagree. I think if it's "just performance" it's good to put
that in the key name in such a way that we can have "early UI" features,
or other non-UI non-performance.

Thanks for working on this!
