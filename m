Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD531F597
	for <e@80x24.org>; Sun,  5 Aug 2018 06:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeHEIiT (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 04:38:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42932 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbeHEIiT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 04:38:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so5281120pff.9
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 23:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c9Yd5zJclMe4O4xb8l+6gKowDfO6eZqiVc1vBq14pF4=;
        b=Et92X1Ut9HWFmPK1cMkkkBtUjWBj/YkNh8X3MlisjZLPSHmLkpNif6gV0gO7TCYGaz
         UjeA1tlI8mgk2uERYTTg8nCqbOtPgVrGdNkfpQWtYA8g5hLQnTkEJiqCJKMFTRKfzfvk
         5KXe1vD3NaumpjeCQUW2eKMC1Bj7dDGV20n09+cHwYUnTQpy7xyTY7s3pfD2HcoJt+I8
         RiXzMj8S5VdKL/TaSFCkv+mFU9RVEbZ6pkBm4h+yn0iqnO30xBaN8hA58gKAMf4gcvpS
         30c5ExhIrfd9Q5MQmdGMMrBNUaVA5Sxd1MpAN9VF4yPaXzUUBl/PDtZTeCXpxMJyoUs6
         sAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c9Yd5zJclMe4O4xb8l+6gKowDfO6eZqiVc1vBq14pF4=;
        b=CD87TEDnS+0ZLCcIQs7Ny/zR6cJjO8epmbSBxuz79DVzEMtTFb9FmU674Hegrn2Mii
         XQmm6CPq0BNU3K8eQvGPAY13Y9FfQ5LwRU4QOvy03L9/Rx1yiRIJ/SL5J0cGTy1d3rEN
         oz/GoBaErt2HMu2Aj+kG7gqc/FpP2z0xF5ZsFs94tT46qn6DXC2qt11AAb4jPpRCsHI8
         4moWHVhjTdJWh9NnLDnYZyAUA8XyGi/T2iuQR6wjGS5FstlldAl2mdx9rIpPSITPxs6f
         G5YPI4cUbtS9D80XACGizBvbCze2cTjkSU2fJjAFicRlTJCHppsTJ0cIyHRP0s0Imkeb
         45UQ==
X-Gm-Message-State: AOUpUlGY+6Dwp67NQ4LVEMIBwVaDtX8O0hIj/5bJpp27A2om8TRMkDd4
        KAccSkUMNQUFnCcyPeM7cbo=
X-Google-Smtp-Source: AAOMgpd5/k9oXuGyYt9NiFsFyZK3ko12rTwOKdNSzIUklF+jjTyb7zXZoPR/W/aXm4bV0WmjUnvQ+Q==
X-Received: by 2002:a63:eb0e:: with SMTP id t14-v6mr9835255pgh.198.1533450890257;
        Sat, 04 Aug 2018 23:34:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u9-v6sm18051125pfi.104.2018.08.04.23.34.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 23:34:49 -0700 (PDT)
Date:   Sat, 4 Aug 2018 23:34:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Chargin <wchargin@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] t/test-lib: make `test_dir_is_empty` more robust
Message-ID: <20180805063448.GC44140@aiede.svl.corp.google.com>
References: <20180805022002.28907-1-wchargin@gmail.com>
 <20180805022002.28907-2-wchargin@gmail.com>
 <20180805041956.GI258270@aiede.svl.corp.google.com>
 <CAFW+GMBrRUQ88XZzLMVAiEGDjLDwLaW6Qi1mSGrXYHoSu8iJag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFW+GMBrRUQ88XZzLMVAiEGDjLDwLaW6Qi1mSGrXYHoSu8iJag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Chargin wrote:
> Jonathan Nieder wrote:

>> This subject line will appear out of context in "git shortlog" output,
>> so it's useful to pack in enough information to briefly summarize what
>> the change does.
>
> I'm happy to do so. I think that "simplify" is misleading, because this
> is a bug fix, not a refactoring. I like your first suggestion, though it
> exceeds the 50-character soft limit. What do you think of:
>
>         test_dir_is_empty: find files with newline in name

Thanks.  I think we can ignore the 50-character soft limit.  It's
often too low and expressivity is more important.  So if you like my
first suggestion, then I'd say start with that and tweak to your taste
from there.

[...]
>> I don't think "xargs -0" is present on all supported platforms
>
> Wow---I'm shocked that it's not POSIX, but you're right. (That makes
> `xargs` so much less useful!)

To be clear, as Junio mentioned, POSIX is useful as a guide to what
*might* be portable, but what we care about is what is portable to the
platforms used in practice.

[...]
>> Not all filesystems support newlines in filenames.  I think we'd want
>> to factor out the FUNNYNAMES prereq from there into a test_lazy_prereq
>> so this test can be skipped on such filenames.
>
> This makes sense. Would you like me to send in a separate patch to add
> this `test_lazy_prereq` to `t/test-lib.sh`, fixing up existing uses (of
> which there are several), and then rebase this patch on top of it?

Thanks for the offer!  Yes, that would be nice: such a patch would be
nice as a cleanup in its own right, too.

Such a patch would be helpful at any time.  For rebasing this patch,
my advice would be to hold off until the discussion has settled down a
bit.  If we're lucky, people in other time zones might have an idea
beyond the ones we've come up with.

[...]
>> "ls -A" was added in POSIX.1-2017. [...]
>> That's very recent, but the widespread implementation it mentions is
>> less so.  This would be our first use of "ls -A", so I'd be interested
>> to hear from people on more obscure platforms.  It does seem to be
>> widespread.
>
> ...if you prefer, a variant of `test "$(ls -a1 | wc -l)" -eq 2` should
> satisfy all the crtieria that you mention above (POSIX since forever,
> should work on Mac). The assumption is that a file with a newline
> character may take up more than one line, but every file must take up
> _at least_ one line, and we get two lines from `.` and `..`. If this
> assumption is false, then I will have learned yet another new thing!

As a piece of trivia, '.' and '..' are allowed not to exist.  So this test
can have false negatives and false positives.

Filesystems omitting them are quite rare so this might work reasonably
well in practice, though.

Thanks,
Jonathan
