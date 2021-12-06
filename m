Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3F2C433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 19:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348311AbhLFTQl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 14:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbhLFTQk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 14:16:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF690C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 11:13:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so606275wmb.0
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 11:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=911nXUOxNUKsSh+wMMZMPoyrnw4uQDDkw92xroEgvrI=;
        b=D1wgqXK+/kxSPocnKiXbmJzYzB2aHAyUa10HguX3J/iaO6Dj2CDnbpNE9hRTuKpMYu
         rEX7StRfp5gFovCbb1KQWN38yehQliIB0rsjhXhRuQzIzca38ntKKe2vsFQVWQT/6es1
         vzXAUv/460Nkhtp5vry8GWc8NEM1IhfZzyrltT+KveK0SZ3+vDSkFlrNDsFtJqbkY0fY
         7Xf2sQvL6zoE4EAEhWmMenhObbJcrYFK+Qq0404cUdwFfK2ns3r0MS+6B96AAmqVkkzK
         SJrQOc1fh9Cbckm4R/LXE9hANjA29NSTjUtqJ7mrauPPeZpBJbEJllsA/GEOr/TCnv9j
         RDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=911nXUOxNUKsSh+wMMZMPoyrnw4uQDDkw92xroEgvrI=;
        b=X89ANq9pNg38mPPEygPn1Hh6VMJl06+LH30Sl5M2PJD4UYVhqYrHnss3eEuwwfzbO6
         ehf0WJTKt1fHhQyppOUyXXDKs/22LOX7Wsio/CpqZXx65flRSw0ek5HyZo15bzmRZElc
         51L7+3YtyKy29/5wvV/9WhtXKpmGs6qlSxuzNKUJkNvrp5tB5sRxu8PTuCXfXfgkrha/
         v4NLVKwZxTExezLHgR8DN+e5YuyA+JIlQrRA1cOG++xYg8UX/HYk9/z0Xju8mmALBx5a
         DCFhLiJPicP+eDu2WqMEAFR/k0/Qh6jut6FhHmBA3LOVzx2qG3U36xiaqHH/WdnJXDRX
         65ag==
X-Gm-Message-State: AOAM533aavEt34m3qql+VnHEuYLKxEHmsDwy/InQyRL3IX4hD8jYQFt6
        m2qFdmobCXsQzXtD7BwaPO0=
X-Google-Smtp-Source: ABdhPJzZ0tZlmKpe7WOR9WhSvUJsUQ1LGr2LOACDmOiEWoRs6jp8q14FLLBoGZVr9D9Fh6bssb0lpA==
X-Received: by 2002:a1c:1906:: with SMTP id 6mr590524wmz.19.1638817990340;
        Mon, 06 Dec 2021 11:13:10 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id g16sm290542wmq.20.2021.12.06.11.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Dec 2021 11:13:10 -0800 (PST)
Message-ID: <e1aadd47-533c-fd8b-4fae-f64a53c81ec9@gmail.com>
Date:   Mon, 6 Dec 2021 19:13:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Dec 2021, #01; Fri, 3)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh7bpqhf0.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
In-Reply-To: <xmqqh7bpqhf0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/12/2021 01:37, Junio C Hamano wrote:
> This is probably the first issue of the "What's cooking" report, in
> which all topics have some sort of description.
> 
> That's a small achievement, at least for me.
> 
> Even better, each and every topic is annotated with some sort of
> verdict (like "Will discard", "Expecting a reroll", "Will merge to
> 'next'?" etc.).  There is no topic in the "Undecided" category when
> this report is fed to "cook -w" script (found in the 'todo' branch).
> 
> A handful of topics are added to 'next', and we have about 40 topics
> cooking there.  For them, the future is automated---they spend about
> a week in 'next', and if we find issues in them, we incrementally
> improve them, or get merged to 'master'.
> 
> Then we have about a dozen topics that are marked for 'next' (please
> raise your hand if you have objection before a real damage is done),
> and 8 more that may be ready for 'next' (please raise your hand if
> you want to nudge them in either direction, for or against).
>[...]
> * pw/fix-some-issues-in-reset-head (2021-10-01) 12 commits
>   - rebase -m: don't fork git checkout
>   - rebase --apply: set ORIG_HEAD correctly
>   - rebase --apply: fix reflog
>   - reset_head(): take struct rebase_head_opts
>   - rebase: cleanup reset_head() calls
>   - reset_head(): make default_reflog_action optional
>   - reset_head(): factor out ref updates
>   - reset_head(): remove action parameter
>   - reset_head(): don't run checkout hook if there is an error
>   - reset_head(): fix checkout
>   - rebase: factor out checkout for up to date branch
>   - Merge branch 'pw/rebase-of-a-tag-fix' into pw/fix-some-issues-in-reset-head
> 
>   Fix "some issues" in a helper function reset_head().
> 
>   Will discard.
>   This needs a lot better explanation, including what the issues are,
>   which codepaths the helper is used in and to do what, and tests to
>   protect the fixes.
>   source: <pull.1049.git.1633082702.gitgitgadget@gmail.com>

I've got a re-roll which I think is almost ready but feel free to drop 
it in the meantime.

> * pw/diff-color-moved-fix (2021-10-27) 15 commits
>   - diff --color-moved: intern strings
>   - diff: use designated initializers for emitted_diff_symbol
>   - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>   - diff --color-moved: stop clearing potential moved blocks
>   - diff --color-moved: shrink potential moved blocks as we go
>   - diff --color-moved: unify moved block growth functions
>   - diff --color-moved: call comparison function directly
>   - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>   - diff: simplify allow-indentation-change delta calculation
>   - diff --color-moved: avoid false short line matches and bad zerba coloring
>   - diff --color-moved=zebra: fix alternate coloring
>   - diff --color-moved: rewind when discarding pmb
>   - diff --color-moved: factor out function
>   - diff --color-moved: clear all flags on blocks that are too short
>   - diff --color-moved: add perf tests
> 
>   Long-overdue correctness and performance update to "diff
>   --color-moved" feature.
> 
>   Need to pick up the reroll before merging to 'next'.
>   cf. <pull.981.v4.git.1637056178.gitgitgadget@gmail.com>

Dscho spotted a typo which I was going to correct with a re-roll but 
I've been holding off in case he has time to read the rest of the series.

Best Wishes

Phillip
