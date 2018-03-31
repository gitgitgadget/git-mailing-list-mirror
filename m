Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 603A21F42D
	for <e@80x24.org>; Sat, 31 Mar 2018 15:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeCaPnm (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 11:43:42 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:50356 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbeCaPnl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 11:43:41 -0400
Received: by mail-wm0-f45.google.com with SMTP id l201so19331972wmg.0
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 08:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FWKY88KfUxGkLDoappvZ3RQdMCMV5aczBOOS3aB8UwY=;
        b=NdS+6rUjj0oP4BwD2oZVMkN8cDFxWQrEXPEAKSkfFpkV99NclYRjpOD5c1fkAfe9d+
         gbg9pj/spacYG4Mi4HqH8V5AqkniiLr03WtlqiQ5cIg2u1ldYTikaOwQ9JNGuoe989YB
         Oe7DYkUhPwU2RNtF7KwozokJn5XFSwQELGD+uUFA6XayKhhHhgjQ82QLgCX0Rjf53YbB
         FEQGKCfYtd9ycqNIwL0CqAq1P8bLlqN7jATa2TSiiI1By5po6s942wFpIH4KFu4dxw6r
         VkDAce4qsDR4sYiOmtnIPzf1t3urPJm+wmUsOlKpZC8uc+hjOOtTGM43jSQW1jywuuA7
         W9pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=FWKY88KfUxGkLDoappvZ3RQdMCMV5aczBOOS3aB8UwY=;
        b=UJVqqz3kuhResNeROW+I8+1pdpbwv+keHwRTVjFzCfJ4pVI5ceZDZFvW9FIqVKstit
         c/FHAXrZhxJ4d/B0ssKYA+XNSJZduYedhXJ7dOnoMYvZLpEH7TpYj9wSUlWGB3KmlZka
         HqZTURt0sMJBS06rKHQ1DW8B7VTI9mJbGBg5bDj5rVn+m0ebk0YeW8CiYTUT50Sv5Wb1
         tX0b+n9B7SwX/ODeLhfdRJPV0TndnD3P3gqmkef9DmSrUJineHJZIZSRd1daxoJ0ZB4N
         S7jmDpRQSoLlAJlNeE6PLyFPNwd2rOjUi/rVpLIhrBnR95JLtilifwrmmGcvT9GAaxK/
         aOlQ==
X-Gm-Message-State: AElRT7FXVUli1+5zb5902caDQFie6z0ucRIWt3YaUfJ7edA/AJ0Ed9D1
        VPIAm2yXb7vWQNww6nak+8uyAr89
X-Google-Smtp-Source: AIpwx49cXIZp2h7VEok2QFFvlmJu3CjoLd0N5Gvj/DrIS7bzruEocvvjJgR+8GkVWza/s3uTTQlAZQ==
X-Received: by 10.80.144.119 with SMTP id z52mr6661958edz.79.1522511020387;
        Sat, 31 Mar 2018 08:43:40 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id h13sm6159643edi.91.2018.03.31.08.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 31 Mar 2018 08:43:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 00/15] nd/pack-objects-pack-struct updates
References: <20180324063353.24722-1-pclouds@gmail.com> <20180331100311.32373-1-pclouds@gmail.com> <87efk0wk7f.fsf@evledraar.gmail.com> <CACsJy8AAApXdxPwt6Yoc-gESXFLVNW8O2u_LF6HUBJTAQaCsTw@mail.gmail.com>
User-agent: Debian GNU/Linux 9.4 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CACsJy8AAApXdxPwt6Yoc-gESXFLVNW8O2u_LF6HUBJTAQaCsTw@mail.gmail.com>
Date:   Sat, 31 Mar 2018 17:43:38 +0200
Message-ID: <87d0zkw8r9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 31 2018, Duy Nguyen wrote:

> On Sat, Mar 31, 2018 at 1:36 PM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>> +GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
>>> +
>>>  GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
>>>  path where there are more than 1024 packs even if the actual number of
>>>  packs in repository is below this limit.
>>>
>>> -GIT_TEST_OE_SIZE_BITS=<bits> exercises the uncommon pack-objects
>>> -code path where we do not cache objecct size in memory and read it
>>> -from existing packs on demand. This normally only happens when the
>>> -object size is over 2GB. This variable forces the code path on any
>>> -object larger than 2^<bits> bytes.
>>
>> The docs here say set these env variables, but actually
>> GIT_TEST_FULL_IN_PACK_ARRAY is a special snowflake in requiring you to
>> set a bool value.
>>
>> I'd set GIT_TEST_SPLIT_INDEX=YesPlease already in my test setup & just
>> copied that as GIT_TEST_FULL_IN_PACK_ARRAY=YesPlease, but that'll error
>> out since it's expecting bool, not the env variable to be set.
>>
>> I really don't care which we use, but let's use either if(getenv()) or
>> if(git_env_bool()) consistently, and then have the docs either say "if
>> set" or "if set to a boolean value (see git-config(1))".
>
> I'll change GIT_TEST_SPLIT_INDEX to boolean too since I document it
> here anyway. Will wait for a while though to see if anything else
> should be part of v9.

Sounds good, FWIW (since I spied your forced push to your private branch
on Github) I mean something like this on top of what you just pushed:

    diff --git a/t/README b/t/README
    index 65dee935c0..583bede192 100644
    --- a/t/README
    +++ b/t/README
    @@ -298,7 +298,8 @@ Running tests with special setups
     The whole test suite could be run to test some special features
     that cannot be easily covered by a few specific test cases. These
     could be enabled by running the test suite with correct GIT_TEST_
    -environment set.
    +environment variable set to a boolean value, as documented in the
    +"Values" section of git-config(1).

     GIT_TEST_SPLIT_INDEX=<true|false> forces split-index mode on the whole
     test suite.

I.e. the part above where we just say it has to be set should be changed
to indicate it's a boolean as understood by git, since in shell/*nix
idiom saying something has to be set just means ensure getenv() won't
return NULL.
