Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB501C6FA82
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 22:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiISWPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 18:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiISWPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 18:15:45 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F674E869
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 15:15:36 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 3so671062pga.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 15:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/J6vB60zhToC7vkPDdPETx+7hcSJLXOw2e6b630YcNg=;
        b=Quy+u87Fwtjjy0BlaaRgeNOYxF8XzY4R4rUfT38YU/qgZjlR/qAf1wvQXUmyjy3Ln2
         LtIKfm8Q0EMKI+8hZ8tfIHgXPXwnK4zsqD6TCLQoyJ4Uwjp5m7texyjdCtGJumxaIdVh
         Zz/lHXv169a0lvptcdfPzWux6z2LLSzWDRgEGiZTaxSbsBFT4vhs+orZgWshO8iNHXM5
         Qb4m5BDezbKx6fT97PXSfIS26Gwdc9z7xPLvRT+/ORg/K5zKdpwynxPvGbkQcfl8G2cs
         xsdgKj/4h2SCBcmeSGpeyXq42cNs0Sh7z6X0NdaH7+sOrz6F9Cc1yK1Dj9x4lVXNeMv8
         jjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/J6vB60zhToC7vkPDdPETx+7hcSJLXOw2e6b630YcNg=;
        b=qILDig1ENiI+PPoC1+NztVkgW0fScS7iVzKO+vtQcZQvX8hRDPr8awDvASFreCotWw
         maG7+YSOCEnMFse/YXuzXcLkaVhyRi8vRYZoI3OH6O6tHx9jPAPaXKkvSY//j+ZU33St
         wxKsYruxanLzSE+DegF2+/B+9uYBRmdTZIKLiPqSZShpxO6LFpYPvjvr8gbuu0DTLvfT
         lENCHzRPkcmUnxjMYNzJPklFgQJnogztKO3IxxAPM+O4XYRBCZlBlAGMXPQ0SAG9/nfF
         EY17LpQ/0jP3oli1JB+jUeFPfftkX/YxwdBRWcxsA5dDsflyIXvW8iA+nxUPv+brBUsL
         aM/w==
X-Gm-Message-State: ACrzQf0aMz0p9jqUohC4oxXoD7d52atOaMVuilrOABQYLcJtEt6Um8ec
        JevwysnojCSe9sjevKYv1Hyg
X-Google-Smtp-Source: AMsMyM58pxV//Sp6jZ+X01JNq0uLqta3Q/VZjLZmDnbzwdeA19KVLMwSa9F+/kEy7IzOAl2cMpMeng==
X-Received: by 2002:a63:5620:0:b0:429:9ad7:b4f2 with SMTP id k32-20020a635620000000b004299ad7b4f2mr17161813pgb.162.1663625735763;
        Mon, 19 Sep 2022 15:15:35 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id o9-20020a62cd09000000b0053e199aa99bsm20651307pfg.220.2022.09.19.15.15.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 15:15:35 -0700 (PDT)
Message-ID: <af319ab4-2351-2d74-e0c7-6153f229d88c@github.com>
Date:   Mon, 19 Sep 2022 15:15:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 00/34] doc/UX: make txt & -h output more consistent
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> We are currently wildly inconsistent in whether the SYNOPSIS in the
> manual page matches the first line of the -h output, and as we add new
> options we routinely forget to add them to one or the other (or both).
> 
> Without a more complex approach it's hard to do something about the
> "or both" case. But we can rather easily test whether the -h output
> matches the *.txt version, and report differences.
> 
> As this series shows that allows us to fix a lot of issues we've
> effectively already "fixed", we just fixed them in one version, but
> not the other.
> 
> We now have a test that checks that these are the same for all
> built-ins. Out of 141 built-in commands we still have 58 cases that
> differ at the end of this series, but that's a lot better than before.

Thanks! Codifying these expectations into an automated check will be
extremely helpful for avoiding easy-to-miss mistakes that could potentially
confuse end users.

> 
> This series is 34 patches, but it's been structured in a way that
> reviewers should be able to mostly trust the "doc txt & -h
> consistency" commits already. In all of those cases we already have
> the post-image in-tree, it's just in either the *.txt or -h version,
> not both. All of the "doc txt & -h consistency" commits merely make
> those consistent together.

In general, I don't think it's wise to implicitly trust *any* patches, no
matter how simple they appear. I know there are benefits to doing everything
at once, but the volume and variety of these changes makes it difficult to
review the series and *confidently* say we haven't introduced any
regressions, missed any cases, or made the "wrong" decisions w.r.t changing
either the .txt or -h documentation to make them consistent.

After reading through this series a few times, it looks like it contains a
mix of:

* updated syntax guidance in CodingGuidelines
* clear syntax or naming fixes (e.g., adding a missing "]" to a '-h' output,
  "keyid" -> "key-id" for translation purposes)
* internal refactoring
* changing an error message's content
* changing the listed options and/or usage in '-h' and/or the .txt SYNOPSIS
* adding an option description in a .txt doc
* adding the new test

If I could offer a suggestion, my preference would be that you split the
series into three parts: one with the straightforward, easier-to-review
changes, another with the more substantial updates to user-facing
docs/information (which might warrant more discussion, i.e. which options we
should be showing for a command in the SYNOPSIS/-h), and the last catching
any new inconsistencies & adding the test. That way, more involved
discussion on some patches doesn't prevent *all* of them from being merged.

I think the following patches would fit a "straightforward,
easier-to-review" series:

* Patch 1 (CodingGuidelines: update and clarify command-line conventions)
* Patch 2 (builtin/bundle.c: use \t, not fix indentation 2-SP indentation)
* Patch 3 (bundle: define subcommand -h in terms of command -h)
* Patch 5 (doc SYNOPSIS: don't use ' for subcommands)
* Patch 6 (doc SYNOPSIS: consistently use ' for commands)
* Patch 7 (doc SYNOPSIS & -h: fix incorrect alternates syntax)
* Patch 8 (built-ins: consistently add "\n" between "usage" and options)
* Patch 9 (doc txt & -h consistency: word-wrap)
* Patch 10 (doc txt & -h consistency: fix incorrect alternates syntax)
* Patch 12 (doc txt & -h consistency: add missing "]" to bugreport "-h")
* Patch 13 (doc txt & -h consistency: correct padding around "[]()")
* Patch 14 (stash doc SYNOPSIS & -h: correct padding around "[]()")
* Patch 15 (doc txt & -h consistency: use "<options>", not "<options>...")
* Patch 16 (t/helper/test-proc-receive.c: use "<options>", not
  "<options>...")
* Patch 17 (doc txt & -h consistency: fix mismatching labels)
* Patch 18 (doc txt & -h consistency: add or fix optional "--" syntax)

(basically, 1-18, skipping patch 4 because it changes the content of an
error message & patch 11 because it adds an option to the -h of 'cat-file')

In terms of review, my only comment on those patches is that 7 & 10 could
probably benefit from being squashed together [1]. Otherwise, with the
changes you mentioned in response to Junio's feedback [2], I think that
subset of the series would be ready to merge.

I hope that helps!
-Victoria

[1] https://lore.kernel.org/git/b1c44436-92d1-067c-fb0a-be4049f3031b@github.com/
[2] https://lore.kernel.org/git/220908.865yhyl31c.gmgdl@evledraar.gmail.com/

> 
> Ævar Arnfjörð Bjarmason (34):
>   CodingGuidelines: update and clarify command-line conventions
>   builtin/bundle.c: use \t, not fix indentation 2-SP indentation
>   bundle: define subcommand -h in terms of command -h
>   blame: use a more detailed usage_msg_optf() error on bad -L
>   doc SYNOPSIS: don't use ' for subcommands
>   doc SYNOPSIS: consistently use ' for commands
>   doc SYNOPSIS & -h: fix incorrect alternates syntax
>   built-ins: consistently add "\n" between "usage" and options
>   doc txt & -h consistency: word-wrap
>   doc txt & -h consistency: fix incorrect alternates syntax
>   doc txt & -h consistency: add "-z" to cat-file "-h"
>   doc txt & -h consistency: add missing "]" to bugreport "-h"
>   doc txt & -h consistency: correct padding around "[]()"
>   stash doc SYNOPSIS & -h: correct padding around "[]()"
>   doc txt & -h consistency: use "<options>", not "<options>..."
>   t/helper/test-proc-receive.c: use "<options>", not "<options>..."
>   doc txt & -h consistency: fix mismatching labels
>   doc txt & -h consistency: add or fix optional "--" syntax
>   doc txt & -h consistency: make output order consistent
>   doc txt & -h consistency: add missing options and labels
>   doc txt & -h consistency: make "rerere" consistent
>   doc txt & -h consistency: make "read-tree" consistent
>   doc txt & -h consistency: make "bundle" consistent
>   doc txt & -h consistency: use "git foo" form, not "git-foo"
>   doc txt & -h consistency: add missing options
>   doc txt & -h consistency: make "stash" consistent
>   doc txt & -h consistency: make "annotate" consistent
>   doc txt & -h consistency: use "[<label>...]" for "zero or more"
>   doc txt & -h consistency: make "diff-tree" consistent
>   doc txt & -h consistency: make "commit" consistent
>   reflog doc: list real subcommands up-front
>   worktree: define subcommand -h in terms of command -h
>   doc txt & -h consistency: make "worktree" consistent
>   tests: start asserting that *.txt SYNOPSIS matches -h output
> 
