Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5303420188
	for <e@80x24.org>; Fri, 12 May 2017 08:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757092AbdELIoa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 04:44:30 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34077 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756827AbdELIo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 04:44:28 -0400
Received: by mail-pg0-f46.google.com with SMTP id u28so27253753pgn.1
        for <git@vger.kernel.org>; Fri, 12 May 2017 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=CddvWFmXEcH8Mkml9Ate+luaF3AAvkKT5Hzb+5klTUI=;
        b=XD5TA99BDYlUH6FfmglMGzkDlEgcPO9lgEOjFSq69nyj15MMS67sKOYCmiUL/UQKKE
         a7dH0JlXknoT7daxxxNmVRo3LEpgdXGWeX+dR2lEHDivnJJ61oqUfxp+80bza8tLrMqM
         QxGc7YU7XIKkBMK06Y/pFnQIUD5amwy/hShFb8NmXDik6tI4NbBC1k1qVZ5yA5QXVsLL
         2Ijoq8XKm5PR8rTzTYNzf6GGiENzGBQODMC/yZ68ID9T3rsxuf/Fwc8M1M7QEQluzeNv
         V/D2cGDnOVs0ljRO3LUn3kPL+h+E0IYvI2UpZhRUJJrhMjE1E9DJs0NxX/fL/DEgh3Vb
         1ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=CddvWFmXEcH8Mkml9Ate+luaF3AAvkKT5Hzb+5klTUI=;
        b=b2UiwsedAhe3SO+vx12ckFUdRtVfjYyV9Wd1dbwTOvyLqIPScQVgdiYN/0k2Zm0vGv
         Ai5NWw1J/ta5mAc9A2GfkSNDNcS0g65P6q1kVqTqccs5qaxeERfPJ8ihZPe5vjx/6LqA
         eHoASUw5kVFE2uqgpJGm59OfB5AHPu4nZaA87QIG+vXFBxWM4XIqICpsCt1toKIDskuU
         rsAnZgbsaOwz1Auzc6tou3iEtze4DJaAc2e0pCEq9fdNoBsC2aEQ4nq5YptqwngjXDot
         vSMemTIk2Nu0d/ZXi/1exE+2eWGS1NxxgQuWUrGtG2RkA7sm6sG0BpwoMGDxZM35lLeS
         QSbA==
X-Gm-Message-State: AODbwcCMQHZOEDacpiskRrtSoktwn8tU7E5ST6YbX3vqq2vjOTl1zQb8
        PkjEAsGthsiW3A==
X-Received: by 10.84.142.129 with SMTP id 1mr3206131plx.3.1494578667768;
        Fri, 12 May 2017 01:44:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:954c:c08b:c855:8b7f])
        by smtp.gmail.com with ESMTPSA id n71sm4859058pfg.46.2017.05.12.01.44.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 12 May 2017 01:44:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #04; Fri, 12)
References: <xmqqpofe60dy.fsf@gitster.mtv.corp.google.com>
        <CACBZZX700n_nFvYxy0Z4M2cUqaOF0bNhLxJ9XJYGNDu8bk5HNg@mail.gmail.com>
Date:   Fri, 12 May 2017 17:44:26 +0900
In-Reply-To: <CACBZZX700n_nFvYxy0Z4M2cUqaOF0bNhLxJ9XJYGNDu8bk5HNg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 12 May
 2017 09:47:37
        +0200")
Message-ID: <xmqqlgq25us5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Fri, May 12, 2017 at 8:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * ab/grep-preparatory-cleanup (2017-05-12) 15 commits
>>  - grep: add tests to fix blind spots with \0 patterns
>>  - grep: prepare for testing binary regexes containing rx metacharacters
>>  - SQUASH???
>>  - grep: add a test helper function for less verbose -f \0 tests
>>  - grep: add tests for grep pattern types being passed to submodules
>>  - grep: amend submodule recursion test for regex engine testing
>>  - grep: add tests for --threads=N and grep.threads
>>  - SQUASH???
>>  - grep: change non-ASCII -i test to stop using --debug
>>  - grep: add a test for backreferences in PCRE patterns
>>  - grep: add a test asserting that --perl-regexp dies when !PCRE
>>  - log: add exhaustive tests for pattern style options & config
>>  - test-lib: rename the LIBPCRE prerequisite to PCRE
>>  - grep & rev-list doc: stop promising libpcre for --perl-regexp
>>  - Makefile & configure: reword inaccurate comment about PCRE
>>
>>  (what is queued here is only the early part of a larger series)
>
> What's the reason for only queuing it up to this point?

No particular reason other than there is only so many hours in a day
and running out of time reading and queuing patches.

>> * ab/compat-regex-update (2017-05-12) 3 commits
>>  - DONTMERGE compat/regex: make it compile with -Werror=int-to-pointer-cast
>>  - compat/regex: update the gawk regex engine from upstream
>>  - compat/regex: add a README with a maintenance guide
>>
>>  Update compat/regex we borrowed from gawk.  It seems that some
>>  customizations we made to the older one were dropped by mistake.
>
> Do you prefer that I pick up JS's "compat/regex: fix compilation on
> Windows" patch & re-send, or for you to add that on top after that
> discussion is resolved?

The tip one is what I did only to see if that is the only reason why
Windows build is failing, without knowing Dscho did essentially the
same one hours before.  I'd prefer to drop it myself, and ask you
and Dscho to work the solution out, as I am farther than Dscho to
the machinery that can be used to validate the fix ;-)
