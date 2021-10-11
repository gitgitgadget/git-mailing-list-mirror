Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D53C433EF
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D053C60E74
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 14:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhJKOb3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 10:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhJKObX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 10:31:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8506FC018DB3
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:09:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y12so55425970eda.4
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 07:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=1Jj9WK6b9Q187+iTyU3+tXVNNSewz/Gt9rtsyNN/Vuc=;
        b=Ay99JLRil5B6miMsIsC0v6MVuQ9qnFhgg1YCvc9kOvaaq4XA8R4I2KclCPqCO0YjAq
         bIamIdfyYzAtfjUmKcqGX+boZVAZcq/BXRAIqtaoZ7KT2cgn4s4fvW7Qw0tofrW4v5OJ
         x2a2n+r1u0gYzeuV9h6mEomXVJ5opsc7A2v+CVqOPmLdj4omORa2li6DBO5GTxeiPuXb
         mxm3kfEjQb0l/WvqAWHt7Ob/GVWNLsYB70JfwE1U+9aEFQyO847UrSozc43yNYGzO6uA
         TTmkxLe4CO75l2m/+dUsNeUZkSF4RnrJiW3rSARP65KWMvSFqb6TLaENQ5iUjdLZ/K3w
         mvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=1Jj9WK6b9Q187+iTyU3+tXVNNSewz/Gt9rtsyNN/Vuc=;
        b=ylDBOC0kk3PvlRnNp+vKZqWtz3+YxapWIrsV7e7jDixaA/lQMJ7ZPHJe3ToFqVTlim
         f8IwelQz9+9nI/S+uFsqkFv55m6CbyPaXHTA1Ji+kC5kbSLc4q7IXiQ+teQbF2EEnGHh
         D2/ZJoLm4FwzRFaREt/YmQTMv3h4EdhCnsNkSDcFCtymeMPkSVH1SuPP2lIUmt4H5Q21
         rOBSRwdRQWATIJU77rsCZDUMiSKV+N4MGpTS2/lZNGm2Qwo2I4+zqTxjCzCfSU7N/9hR
         KqklOt7D2J0M2VIsc17EtssqwvevuCS9gLsCCSuKv1DAbyFb6/+bJw7jzyNAiMmu96pY
         l4AA==
X-Gm-Message-State: AOAM532TRzRF0bywGaSiWutvOmcmLMa6yBYpIP3QNAPUwHjgsTIDscZA
        vFLygbjFbUaqamP1WXN3RhtYo7OfgQH8qDtQ
X-Google-Smtp-Source: ABdhPJzVM0WdtshCY5PwhncrywnBGcS/6n7y9+sibLZPQXZQ6lOMji79cVM+oeQu8rxVSpcXx4+Zuw==
X-Received: by 2002:a17:906:5e01:: with SMTP id n1mr27046313eju.385.1633961395822;
        Mon, 11 Oct 2021 07:09:55 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 6sm3589830ejx.82.2021.10.11.07.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 07:09:55 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Thiago Perrotta <tbperrotta@gmail.com>
Cc:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v7 0/3] send-email: shell completion improvements
Date:   Mon, 11 Oct 2021 15:46:20 +0200
References: <YWE41xTLhBFWqUFl@carlos-mbp.lan>
 <20211011041033.20004-1-tbperrotta@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <20211011041033.20004-1-tbperrotta@gmail.com>
Message-ID: <87fst7lkjx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 11 2021, Thiago Perrotta wrote:

> Differences from V6:
>
> 2/3: Addresses all of Carlos's comments:
>   - make indentation consistent (tabs): note that there's a giant diff
>     for the largest GetOptions now, it adds a bit of noise to the patch

I took Carlo's suggestion to mean to indent your uniq function, not to
re-indent a bunch of existing code while at it...

>   - do not reuse the options variable, for improved readability.

...I think that re-indentation is better left alone for the patch
readability.

Anyway, sorry about not looking at this sooner after my off-the-cuff
[1]; I think this looks mostly good-ish, but there's a few broken things
here:

First, in your 1/3 you're adding a \n, but in 2/3 we end up with \n\n. I
think you can just skip 1/3, maybe mention "how it also has a "\n" in
the commit message.

I.e. you start implicitly picking up the newline because you changed
from a "print" to a "split", and latter imposes Perl's scalar context on
its argument, but the former doesn't. That's a combination of some Perl
trivia and our own Git.pm being overly clever about wantarray(), but
there you go.

More importantly in [1] I meant that last paragraph as a "and as an
excercise for the reader..".

I.e. we should not simply strip the trailing "=" etc., we need to parse
those out of the Perl GetOptions arguments, and come up with mapping to
what we do in parse-options.c. I think that's basically adding a "=" at
the end of all options that end with "=s", ":i", "=d", ":s" etc.

You then strip out "--" arguments from the combined list, but isn't this
something we do need to emit? I.e. it's used as syntax by the bash
completion isn't it? (I just skimmed the relevant C code in
parse-options.c).
    
    $ git clone --git-completion-helper | tr ' ' '\n' | grep -C2 -- ^--$
    --hardlinks
    --tags
    --
    --no-verbose
    --no-quiet

For --no-foo arguments we emit both a --foo and --no-foo in it, that
sort of (maybe entirely) works in your version because some/all (I
haven't checked all) options have corresponding "foo" arguments for
"no-foo", so maybe it sort of works out, but does the ordering
before/after the "--", and that we strip out the "--" but e.g. "git
clone" will emit it?

We then don't want to emit "-h", but you strip out "--h", first we
mapped "h" to "--h" in the loop above, so we should do that there. But
better yet we have a "%dump_aliases_options" already, maybe it +
"git-completion-helper" can be moved to another "%not_for_completion"
hash or something.

The map/map/keys loop also will silently do something odd if it starts
getting input data it didn't expect, i.e. it would be more reliable as a
regex check, and then die() if we start getting somethnig we don't
expect, i.e. if someone adds an option not covered by our regex.

That it's a map/map/keys is just some off-the-cuff Perl hacking on my
part, I think for validation etc. it's usually better to just turn it
into a plain old boring for-loop.

1. https://lore.kernel.org/git/87bl4h3fgv.fsf@evledraar.gmail.com/
