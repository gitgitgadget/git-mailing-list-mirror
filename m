Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E31DC433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 11:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236869AbhLOLK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 06:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbhLOLKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 06:10:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A51C06173E
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 03:10:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i22so7714360wrb.13
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 03:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=moBJxNVNHqjcADB75ewrh6sTc2cYJr3S0I7eO7naIuY=;
        b=iu6OMHQ6irX079/iwsZMk5HdDQTAwxX2K6k/HA3ZAESiVhg8Q2oxUEMqcGaHV7StPn
         WyqYLk6wEbuozB0T9kVncKn/BmZhIxYLoHBsJXS3XIv3X87CJ814EbxrZj3l4cyEHtvn
         9VMN7GE0Jg1no8VATGuHytE3aLFY1ecsNmnnDRfog3/rAOvtdKdSg2at0aGFCIWw9T2D
         AGL7SijXI87NDjLPmT8jAKeIq3rCSZiJ4GrSV3Jt00DiUI93BXAYNCvhE0TPWzvPEy+E
         IU9FNz4wTuwyKvlkxT/f9uIkXqHUKx5TL4UiSj69Ef/Wv7bN0LgDhQ9o3ZaoysN+gRos
         XrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=moBJxNVNHqjcADB75ewrh6sTc2cYJr3S0I7eO7naIuY=;
        b=bJRxGw2N7f8NlUKdOYritZuBpt2xZIZ+qxvsKxcEYIZdB0uv3ySEIqkFW4+KX/Kscr
         RjT1WLuNuM3SS0gxN6c0PKDEtzPsRyyaYmEJxb28l3PGwsuRY99nbapCiouGjIZ8s/UG
         K08lFrKkut5Slvy6Avby8ooC2eZGMwG/rFhGosmGfbUqRhVTaC8ZtbUQ8zXLRFnY2EAR
         8Zf+qRF5YghXE9MgS43YiNOAKRKNxM6+bJX01RAOK+Q4+b6XrZd8IuMA29KqixSsQnQI
         /QUkLOYw+WTutjkEe3g33ltndZheT4b+5OASNclwih6lBZ+Z+X+PmxuFlc2RosH0luvD
         VXxQ==
X-Gm-Message-State: AOAM532v2gVoVtkiGWWcjTo9NwJdltDzrjq+EAG6TURZ1xRwJphRsV8f
        N0dSmLyL4HI5ohR78u70xqME6/HLj6Y=
X-Google-Smtp-Source: ABdhPJwpOYc99z9vQHW1WCzLBw53O6NgQRb6GdtLexICW4HtQk/1uviIIjMwk+5Y3lNJWUXA0JtqZA==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr106458wro.404.1639566623669;
        Wed, 15 Dec 2021 03:10:23 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id u17sm1642922wrp.58.2021.12.15.03.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Dec 2021 03:10:23 -0800 (PST)
Message-ID: <fa070547-45f3-e3d9-e5ac-ffc9fa5261c0@gmail.com>
Date:   Wed, 15 Dec 2021 11:10:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Dec 2021, #03; Fri, 10)
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqilvvluoa.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqilvvluoa.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On 11/12/2021 02:52, Junio C Hamano wrote:
> * pw/fix-some-issues-in-reset-head (2021-12-08) 14 commits
>   - rebase -m: don't fork git checkout
>   - rebase --apply: set ORIG_HEAD correctly
>   - rebase --apply: fix reflog
>   - reset_head(): take struct rebase_head_opts
>   - rebase: cleanup reset_head() calls
>   - reset_head(): make default_reflog_action optional
>   - reset_head(): factor out ref updates
>   - create_autostash(): remove unneeded parameter
>   - reset_head(): remove action parameter
>   - rebase --apply: don't run post-checkout hook if there is an error
>   - rebase: do not remove untracked files on checkout
>   - rebase: pass correct arguments to post-checkout hook
>   - t5403: refactor rebase post-checkout hook tests
>   - rebase: factor out checkout for up to date branch
> 
>   Fix "some issues" in a helper function reset_head().
>   source: <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>

Thanks for your comments on this series, I'll re-roll but probably not 
until the new year now.

> * pw/diff-color-moved-fix (2021-12-09) 15 commits
>   - diff --color-moved: intern strings
>   - diff: use designated initializers for emitted_diff_symbol
>   - diff --color-moved-ws=allow-indentation-change: improve hash lookups
>   - diff --color-moved: stop clearing potential moved blocks
>   - diff --color-moved: shrink potential moved blocks as we go
>   - diff --color-moved: unify moved block growth functions
>   - diff --color-moved: call comparison function directly
>   - diff --color-moved-ws=allow-indentation-change: simplify and optimize
>   - diff: simplify allow-indentation-change delta calculation
>   - diff --color-moved: avoid false short line matches and bad zebra coloring
>   - diff --color-moved=zebra: fix alternate coloring
>   - diff --color-moved: rewind when discarding pmb
>   - diff --color-moved: factor out function
>   - diff --color-moved: clear all flags on blocks that are too short
>   - diff --color-moved: add perf tests
> 
>   Correctness and performance update to "diff --color-moved" feature.
> 
>   Will merge to 'next'?

I think it's ready, Dscho had a fairly detailed look at it and seemed 
happy, Elijah and Ævar read through previous versions. I'm not aware of 
any issues with it.

Best Wishes

Phillip
