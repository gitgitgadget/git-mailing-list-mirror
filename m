Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B1681F405
	for <e@80x24.org>; Thu, 20 Dec 2018 00:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeLTAS3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Dec 2018 19:18:29 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35758 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbeLTAS2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Dec 2018 19:18:28 -0500
Received: by mail-ed1-f68.google.com with SMTP id x30so243637edx.2
        for <git@vger.kernel.org>; Wed, 19 Dec 2018 16:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=W8J8sUNPzsubHXuCio+1ty3ih+EhyJVdmL9F2fBtsDs=;
        b=nPnj3Ig1p3Z+3vLQ3YZGjwa0gWjFAjsb1ggqF5VSiiocenxfGytWvaslS5YXISQLuK
         aV8ukg2QtXIPX4PftQFJ1erffQWNRbz+KOpIIsFTcdbYVjDJe41IBKWqWLBSfoHSx/1l
         ffn8OwD/stfY802S4uU9jSQ5iC4xYAPMd1og1zatXjDIPQBKtMFRzCsDONZIq7tDrjDW
         vV+gJzF8xtZSmbVJuvbdq55R2f2DcWMTV6O4d2YJEqsg+MCV31C7u7BOCvgrnrf3FVLC
         ssWQxYiJEwyn981RwyioMhUX+x4sTTmA6tJOXov5xLi4vWwwXJj77iDVFfJ2h2zlxl8G
         C2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=W8J8sUNPzsubHXuCio+1ty3ih+EhyJVdmL9F2fBtsDs=;
        b=FdQIce199lCBoY30ifAK4u5mmU9SMkMWhjBXpUgUtu2eyBCg4PnGnAJ3pGD8/xltUi
         yFKzFBxOZh35bvsNSDEoDIj2IBK7FPdUt3ocfMsdSxNL+uwsNMQUSVv6YQN3xqiIfyv8
         N4IY1WqOoPDJ7z+jldWctlYYzyplV/B/NkLwbQ7bv816XRY8OjTmvklRnduexDf4AB6P
         igZD9VuedOpKSzU2BBMFZmjGqpmunxUNG/KorVOjf+SZxvutuUIzykz2ZxAj3+OVQ+oQ
         XbaTXPD8L9tw+Dv6lkSdvsyVkF525kGaTBdzVSiEfPiMbsAbgAT61n+L76PlQu/Rdq6G
         G91A==
X-Gm-Message-State: AA+aEWblCFXK8/g3FMXLMbZAkzzx4YXPkITezcyHD6ElXKlumHtnHbE9
        m09NOzfapSYDHVvriHtBVMk=
X-Google-Smtp-Source: AFSGD/UT53JjW8nIqjGGV6FTW5cqetdB8K20390fh+Vx6yiVN//54KBnZF2z8SLJWtRKldJ1CIGQiQ==
X-Received: by 2002:a50:fc07:: with SMTP id i7mr21782828edr.153.1545265106116;
        Wed, 19 Dec 2018 16:18:26 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w10sm5703789eda.77.2018.12.19.16.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 16:18:23 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff King <peff@peff.net>
Subject: Re: Referring to commits in commit messages
References: <20181217165957.GA60293@google.com> <877eg5fwd5.fsf@evledraar.gmail.com> <CACsJy8DdgjjQLEn=O7ePBo7ndLuv22RGQA3nM1Lyizz=59Pj9Q@mail.gmail.com> <20181219221401.GC228469@google.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181219221401.GC228469@google.com>
Date:   Thu, 20 Dec 2018 01:18:22 +0100
Message-ID: <8736qtf3u9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 19 2018, Jonathan Nieder wrote:

> Hi,
>
> Duy Nguyen wrote:
>> On Wed, Dec 19, 2018 at 6:04 PM Ævar Arnfjörð Bjarmason
>
>>> E.g. when composing
>>> https://public-inbox.org/git/878t0lfwrj.fsf@evledraar.gmail.com/ I
>>> remembered PERLLIB_EXTRA went back & forth between
>>> working/breaking/working with your/my/your patch, so:
>>>
>>>     git log --grep=0386dd37b1
>>>
>>> Just found the chain up to my breaking change, but not your 7a7bfc7adc,
>>> which refers to that commit as v1.9-rc0~88^2.
> [...]
>> To follow email model, this sounds like a good trailer for related
>> commits, like In-Reply-To for email. We could even have special
>> trailer "Fixes" to indicate what commit is the problem that this
>> commit fixes.
>
> In Linux kernel land, Documentation/process/submitting-patches.rst
> contains the following:
>
> -- >8 --
> If your patch fixes a bug in a specific commit, e.g. you found an issue using
> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> the SHA-1 ID, and the one line summary.  For example::
>
> 	Fixes: e21d2170f366 ("video: remove unnecessary platform_set_drvdata()")
>
> The following ``git config`` settings can be used to add a pretty format for
> outputting the above style in the ``git log`` or ``git show`` commands::
>
> 	[core]
> 		abbrev = 12
> 	[pretty]
> 		fixes = Fixes: %h (\"%s\")
> -- 8< --
>
> I like it because (1) the semantics are clear, (2) it's very concrete
> (e.g. "first 12 characters", (3) it goes in a trailer, where other
> bits intended for machine consumption already go.
>
> Should we adopt it?  In other words, how about something like the
> following?
>
> If it seems like a good idea, I can add a commit message.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git i/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
> index ec8b205145..36ce1ac5d8 100644
> --- i/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -367,6 +367,20 @@ If you like, you can put extra tags at the end:
>  You can also create your own tag or use one that's in common usage
>  such as "Thanks-to:", "Based-on-patch-by:", or "Mentored-by:".
>
> +If your patch fixes a bug in a specific commit, e.g. you found an issue using
> +``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
> +the SHA-1 ID, and the one line summary.  For example::
> +
> +	Fixes: 539047c19e ("revert: introduce --abort to cancel a failed cherry-pick")
> +
> +The following ``git config`` settings can be used to add a pretty format for
> +outputting the above style in the ``git log`` or ``git show`` commands::
> +
> +	[core]
> +		abbrev = 12
> +	[pretty]
> +		fixes = Fixes: %h (\"%s\")
> +
>  == Subsystems with dedicated maintainers
>
>  Some parts of the system have dedicated maintainers with their own

The core.abbrev=12 part of this I don't think would be a good idea, and
have submitted a patch to the kernel to remove it:
https://lore.kernel.org/lkml/20181220000112.24891-1-avarab@gmail.com/

If we find ourselves wanting to tweak core.abbrev for git.git, we should
really take a step back and see if we can just fix the
find_unique_abbrev_r() behavior so neither us nor anyone else should
need to fiddle with it.

As noted on LKML I have upcoming patches to support core.abbrev relative
values, e.g. "+2" will give you really future-proof SHAs. That should be
Good Enough(TM) for most.

The only real improvement over the approximate_object_count() method I
can think of is something where in gc / index-pack (for clone) we write
out some statistics that allow us to later cheaply estimate the
long-term growth curve of the repository, and e.g. say that a short
SHA-1 should always be good for at least N years before it becomes
ambiguous.

OTOH we could also just say that if you're a repo with >= 11 characters
for abbreviation we might as well consider you in big boy territory, and
just snap it to say 16 and be done with it. We'll have problems with 32
bit ints somewhere in git overflowing before we'd roll over to "17".
