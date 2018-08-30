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
	by dcvr.yhbt.net (Postfix) with ESMTP id 85ADA1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 08:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbeH3M7h (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 08:59:37 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46791 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbeH3M7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 08:59:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id a108-v6so7271323wrc.13
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 01:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=l//zRk+zm/EGmek75kvywRaxMotF756HQwdfz81DpRs=;
        b=IGuoVzzfQ1c9LeKlIMRwAEJaUrf/x4/Zux9mYYYo9VpExGX8mshEhBEJSTBXhGqrnx
         GiGVZNB+z7Y8EaDxyuALIKF4acAfQ6QpYF+3lW4CKkiE02pTTCtT0OtpISKIonJr9RBK
         kOugcNQhuNdi4Y9sZ0csEJ+Oia+e8iQMMM7pqaOA3j0fAJ+z8dS+HP2HxyPACox3ow78
         x40ZUFC68/IUUB5Md/pqXV6JdQ5JsxWQF9XQPFaY5Wf02UEwtQf8rquIJtj3e31nRLmK
         AxZi9Yswz+YFRW3ajoFCu0tAmp05xdF85Uk5h+iq+6I9V27KL0PvQjoKSUY5iaw49nXH
         NJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=l//zRk+zm/EGmek75kvywRaxMotF756HQwdfz81DpRs=;
        b=K3/mx6lexOeKaMvFtHXh5WTo4mt9OHPdQsPjdmksfuJZbfJkfqeleZqYHClfyfVAi8
         0KAb5Ylm5XR5S9e84AKz859RhZbZ8rKuDC878VmApn/+h29KrFPqfuepkhxVXXvxNZf5
         +XPtkjU6KIvfTgmNL9YHCTMer+ulHcVaY4l/+Jhp3oo8c5Bme7E2FNHPg6sqGGPiGyWl
         P87qW+rrd0iMmQuBLvtY54n8N0Qx/XXjK4+DIa2gotW3f0WnyoiqVNw0JwyFmkC5EpPa
         z5r9FS1NGaUAHwTp+dddZhR1iABUC/PUlnjgbXpGivaL3koTmffmUHr6RTFAqeXGlhej
         Ki/A==
X-Gm-Message-State: APzg51Aiz1UW0AByXKjBxFhWOKUVtUBkndzVyq6kQm8lzmhnlTC/lvUQ
        /mfZUg6mTGKPxQlAZyLjTA0=
X-Google-Smtp-Source: ANB0VdZPpaju3CtghTP7NSeK+mDJ9PhCw0tjtmwSf4kYoxneHKzCDq8MnNEu5rnnePUEjyTYtGAq+w==
X-Received: by 2002:a5d:5450:: with SMTP id w16-v6mr7292617wrv.4.1535619509330;
        Thu, 30 Aug 2018 01:58:29 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id h82-v6sm1081030wme.11.2018.08.30.01.58.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 01:58:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2 4/4] branch: make "-l" a synonym for "--list"
References: <20180622092327.GA8361@sigill.intra.peff.net> <20180622092459.GD13573@sigill.intra.peff.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180622092459.GD13573@sigill.intra.peff.net>
Date:   Thu, 30 Aug 2018 10:58:27 +0200
Message-ID: <87wos8cjt8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Jun 22 2018, Jeff King wrote:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 1072ca0eb6..fc88e984e1 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -100,8 +100,6 @@ OPTIONS
>  	The negated form `--no-create-reflog` only overrides an earlier
>  	`--create-reflog`, but currently does not negate the setting of
>  	`core.logAllRefUpdates`.
> -+
> -The `-l` option is a deprecated synonym for `--create-reflog`.
>
>  -f::
>  --force::
> @@ -156,6 +154,7 @@ This option is only applicable in non-verbose mode.
>  --all::
>  	List both remote-tracking branches and local branches.
>
> +-l::
>  --list::
>  	List branches.  With optional `<pattern>...`, e.g. `git
>  	branch --list 'maint-*'`, list only the branches that match

I think it's better to have something like this on top:

    diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
    index 5552dfcec3..a03cb1ebc9 100644
    --- a/Documentation/git-branch.txt
    +++ b/Documentation/git-branch.txt
    @@ -163,6 +163,11 @@ This option is only applicable in non-verbose mode.
     This should not be confused with `git branch -l <branchname>`,
     which creates a branch named `<branchname>` with a reflog.
     See `--create-reflog` above for details.
    ++
    +
    +Until Git version 2.20 `-l` was the short form of
    +`--create-reflog`. As of version 2.19 using it would warn about a
    +future deprecation.

     -v::
     -vv::

We're about to release 2.19 with the deprecation (but it still means
--create-reflog), this patch is sitting in next.

Similarly to your 2/4 we'll have some scripts in the wild using -l,
let's at least give them a headsup that this changed in the docs, as
well as anyone on >=2.20 (or whenever we plan to merge this down from
next) a warning that if they're writing some script they can't rely on
`-l` for older clients.
