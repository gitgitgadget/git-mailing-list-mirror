Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BB7207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750852AbdEAXV5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:21:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34503 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750771AbdEAXVz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:21:55 -0400
Received: by mail-pg0-f66.google.com with SMTP id t7so18095991pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=e1CGQJTBPSOamGssdRlG3uSfn63IDciKL5oFZ0KNjmI=;
        b=PwZrToVseYUMdZ8PtwGJAETchsva0DYajhJoU/Q1NbhI+56z9Ap/UxYmXvhneWfDBk
         xMgmC6XRwGp7UjtLtnYc7cofwqLeh6bFHkDNaVRuNNkazVO/6C/m7wrTzA+P3vPX+oKG
         2btaCR4qnDWXT1R7hYrKM62gWftIU78k5hWZoUHLg738KmxzH7pI27f1STcU07X9KnRD
         UlreAxZAQ4ZJPFSHZ/IbhwFZdgF2CJjcBWCz5Mn2vElRSUhi59B0yo6SslPhFgdWdJDk
         +g5CiJT6OQUoBBHDrUyGiYMO0/WPTjbQD32Vx6skhz6mCS8U+bei2dT3/d7T6+pbhJNk
         p5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=e1CGQJTBPSOamGssdRlG3uSfn63IDciKL5oFZ0KNjmI=;
        b=GiVjTk8AkivM9+AeK/x//hDkTlvsf32OslHTE/WMkzeKXxdGv4XCQ7VcrJTWOTVHcT
         +uUIoG7QfLalO8lOXOiQuEXMqTn6XjDFrvDQmo5q+u//hNd/ZL+IXl7p7RCwy1oHprqa
         ES8j5kx+np6HUSv250jkFJ9eCUWfulMGwi6kTqHO3A8uNOu6HBr8m+t2CsJdQFPMMG6J
         lQlvH72MTVRkcKk5FdWhxQNqPwX2sGB/FyCO47pt405iv0xR7GFkBZdMPEjC/czfq+rO
         sUXZTgPCzawEqXN1xbvUC0F+DK14wPOwr96aLiPnVD+CSWdjl2KTrawHxXSHMGh5Sdzd
         rD/g==
X-Gm-Message-State: AN3rC/74+Z/M3bOdk4aGlfdUfpgbcJeFi9+x1YCyEV1BEHb8GHfJqNnA
        psRZSdN2awCS2A==
X-Received: by 10.98.13.19 with SMTP id v19mr28863774pfi.89.1493680915049;
        Mon, 01 May 2017 16:21:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id t2sm24302728pfl.34.2017.05.01.16.21.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 16:21:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (May 2017, #01; Mon, 1)
References: <xmqqefw9gmvq.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
Date:   Mon, 01 May 2017 16:21:52 -0700
In-Reply-To: <CACBZZX4ty91vh=ykMtpF0pV8Ru3BKWBXyQYsFRdPkKkxMd8pzw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Mon, 1 May
 2017 16:25:14
        +0200")
Message-ID: <xmqqa86wgo33.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> * ab/grep-pcre-v2 (2017-04-25) 20 commits
>>  - SQUASH???
>>  - Makefile & configure: make PCRE v2 the default PCRE implementation
>>  - grep: remove support for concurrent use of both PCRE v1 & v2
>>  - grep: add support for PCRE v2
>>  - grep: add support for the PCRE v1 JIT API
>>  - perf: add a performance comparison test of grep -E and -P
>>  - grep: change the internal PCRE code & header names to be PCRE1
>>  - grep: change the internal PCRE macro names to be PCRE1
>>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>>  - grep: make grep.patternType=[pcre|pcre1] a synonym for "perl"
>>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>>  - log: add -P as a synonym for --perl-regexp
>>  - log: add exhaustive tests for pattern style options & config
>>  - grep: add a test for backreferences in PCRE patterns
>>  - Makefile & configure: reword outdated comment about PCRE
>>  - grep: remove redundant `regflags &= ~REG_EXTENDED` assignments
>>  - grep: remove redundant regflags assignment under PCRE
>>  - grep: submodule-related case statements should die if new fields are added
>>  - grep: add tests for grep pattern types being passed to submodules
>>  - grep: amend submodule recursion test in preparation for rx engine testing
>>
>>  PCRE2, which has an API different from and incompatible with PCRE,
>>  can now be chosen to support "grep -P -e '<pattern>'" and friends.
>
> That squash looks good to me.

Thanks.

That is not a particulary helpful comment, by the way.  I can help
topics by contributors by queuing emergency fix at the tip to make
ones that do not build correctly buildable and testable (which is
what the "SQUASH???" commits are about), but I'd rather not see me
forced to find among 19 commits which one is broken and needs the
hotfix squashed in myself.

>> * ab/grep-threading-cleanup (2017-04-16) 8 commits
>>  - grep: given --threads with NO_PTHREADS=YesPlease, warn
>>  - pack-objects: fix buggy warning about threads under NO_PTHREADS=YesPlease
>>  - pack-object & index-pack: add test for --threads warning under NO_PTHREADS
>>  - tests: add a PTHREADS prerequisite
>>  - grep: skip pthreads overhead when using one thread
>>  - grep: don't redundantly compile throwaway patterns under threading
>>  - grep: add tests for --threads=N and grep.threads
>>  - grep: assert that threading is enabled when calling grep_{lock,unlock}
>>
>>  Code cleanup.
>>
>>  Needs review.
>
> Between these two series there's 27 patches, and I understand it's a
> bit of a PITA to review/get comments on it.
>
> Anything I should be doing differently here other than just waiting
> for 2.13 to come out so they can be cooked further & merged down to
> next & then master if there's no objections?

There are topics that need fresh eyes to be reviewed by other
contributors, so perhaps you can help unblock them by reviewing,
while they pick lints from yours?
