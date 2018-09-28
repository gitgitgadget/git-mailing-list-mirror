Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A26011F453
	for <e@80x24.org>; Fri, 28 Sep 2018 17:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbeI1XZj (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 19:25:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46978 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeI1XZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 19:25:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id z3-v6so7106771wrr.13
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=xlgpY0gDt3yxssGR/tM0a8T1R07Mml7H8VGn/WUfLVs=;
        b=AyULbtalyfzVWUmNUEZJlfTGxyn82mZBJhPOWMcur/iln1mXGuleFE1VzPudkEmghP
         oEyjN5PvBjrVL6MxEjsgeRhBu1dAylfAYdx3RU2MbTHX7nmheJc/iaGMoJO6SiV4kyZ6
         gNxMmabbj0y6k6hOTGJkZSYnv/GhWwVtU2tqAcjaJKlvyL3zVYYjCppLL6SfWP94uqdW
         9F+BapvTI+BhuzrG6YNoFRl2GlX2QAzjEbqCiSOZ22dgA8xoSutksNf3YPrjJNC+Il71
         9+epq3y4TX2FjS64THnu5DjVyZxJFYiWdhNhrguOiCZyCQIyS5nOKs9RPNnszXxH6OES
         m8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=xlgpY0gDt3yxssGR/tM0a8T1R07Mml7H8VGn/WUfLVs=;
        b=cWiiJfKKcmfopeQZi1Br2UrsjKjVBXvsV5rFMoj5743TPNoXI7OeZjZ3Zbcn6yTKCb
         LD7Kmk4i4OC4Wj0lgmU+B2epHynn83FD6kgXznoORmtPxZ+RZVpCp6MSj9zlUTYJEtpw
         1JN97GR+yiVJey8OL0bj8wkuIa6aXGg+1UZZn0G/64lf9xVkb9jHYk18ul0mfjysWblN
         Q8ddMIDVWkPV0ZXSGzbxrG3MGN7nbGlSPGlFsemhdcaJm2F/gqRPWhZXZDEj5iFQZacK
         2IjW3WcovPHgbmzKtmuD6p+4cBvUqSj8KV8UD52OfSi6z80gijRz/zXLCnO17hMACBTu
         OCIQ==
X-Gm-Message-State: ABuFfoiGawVpXFbYjpEP6Fhb9hl0EPjE70vvSQPBKXjGX4jHd1OitWP1
        6BYa+msEN11blRWQbhtbwmUUFRIb
X-Google-Smtp-Source: ACcGV62cSb/HOHlTpvpyMCAriK2qW7ypbiJpO41PrJGEEk35rwcvWW+FRwZB4oiCJOXe4oRVAtN1yQ==
X-Received: by 2002:adf:bc84:: with SMTP id g4-v6mr6080477wrh.250.1538154058263;
        Fri, 28 Sep 2018 10:00:58 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w192-v6sm2988959wmf.33.2018.09.28.10.00.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 10:00:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
        <fb221514-4749-affa-c657-0e36dd28fb13@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 10:00:56 -0700
In-Reply-To: <fb221514-4749-affa-c657-0e36dd28fb13@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Fri, 28 Sep 2018 09:40:45 +0200")
Message-ID: <xmqqwor5d0af.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

>>> +		if (follow_alias > 0) {
>>> +			fprintf_ln(stderr,
>>> +				   _("Continuing to help for %s in %0.1f seconds."),
>>> +				   alias, follow_alias/10.0);
>>> +			sleep_millisec(follow_alias * 100);
>>> +		}
>>> +		return alias;
>> 
>> If you have "[alias] cp = cherry-pick -n", split_cmdline discards
>> "-n" and the follow-alias prompt does not even tell you that it did
>> so,
>
> That's not really true, as I deliberately did the split_cmdline after
> printing the "is an alias for", but before "continuing to help for", so
> this would precisely tell you
>
>   cp is an alias for 'cherry-pick -n'
>   continuing to help for 'cherry-pick' in 1.5 seconds

Yes, but notice that cherry-pick appears twice---I do not know about
you, but I know at least my eyes will be drawn to the last mention
that does not have '-n' stronger than the one before/above that
line.

In any case, I think Peff's "Let's teach 'git cp -h' to prefix what
'cp' is aliased to before invoking 'git cherry-pick -n -h' (and let
it fail)" approach is much more robust, so let's do that without
emulating that command-typo-correction codepath.


