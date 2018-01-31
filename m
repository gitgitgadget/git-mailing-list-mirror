Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D0D01F404
	for <e@80x24.org>; Wed, 31 Jan 2018 22:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeAaWpN (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 17:45:13 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51584 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeAaWpM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 17:45:12 -0500
Received: by mail-wm0-f67.google.com with SMTP id r71so2209143wmd.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 14:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=07WfrwVXr+ELxVtT+tipItCd+iJmwxuMqHopzUGViiU=;
        b=n3qV1mriLu39EYm17+KADdTOaHbzpTW3iL+kXxb03LrewhINGn8zPA/wdNtG3nfUK2
         BJBODooXKspf6nfKE9uHmi7+rsSJKknmOgHfI2ABcMpaPPbt1FTjGeAfN3T+8RNBmSQ7
         +TX8L3QbKQGkB4UF07WQ1M3GvkikqJ7VPXI27l7cdNX2hiXL9KmIACPW1YODL9izUf4s
         oS+DH5OSJXy+NiUqvhqNSk/bXn71k1ZQis+wrg2Y9HTlzYstqtB2V1d3g5wBAihA/F59
         W31BwO3GMNwZ9hc8B7YgH3HaLxtVSOHke3gMFnzy3hMTWsBrY5k/jzzGmsqZLFCzL9fT
         0KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=07WfrwVXr+ELxVtT+tipItCd+iJmwxuMqHopzUGViiU=;
        b=LmT2FFD0ov6RHExHRbmKG4u7xVhhf9wp6T3EFQDdouanNdzLnnVBWrfWoJDhTEqpC2
         sbn4Dz4EVKZ4aHS9/gLRgSGg0ErX6qaSxg4iLg8CYK6FsUvr9c7Wu4DNuraozoKsKLJ0
         j9PwSQGLe0dNRy8TOJIS3fX2JKJ/iOtNxynRcmfTAsXEQZ/UFcanZrhDb7Bpvv/CX7Q5
         0DeYXzPFTYoDpRa/pXi2s12U3pKjgKBMKAr4hVhDanzFBKvfPCCCbug1vkKZEedBT0Rn
         P52YLvRE8KzxZlyFkTAV1U7V+MerFjXpDVylvS3G6lMMGL+GmF78bBfKXnTvsoaOhg6O
         VmSg==
X-Gm-Message-State: AKwxyteU79xmkcz2JjHCbfZjAoGTsl14srzeSP1gjAPFZEvAYX8u8EVC
        7sG5dgjZdvrDGlP318kRgjQ=
X-Google-Smtp-Source: AH8x226z5L9XMeSA8mPYB3BiJN4cSmhvhWzzusOO0nOZWMQElzc7MAPeWjgXFSoW7Z9N9eBoupTsgQ==
X-Received: by 10.28.113.150 with SMTP id d22mr24128839wmi.127.1517438710498;
        Wed, 31 Jan 2018 14:45:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 62sm866305wml.24.2018.01.31.14.45.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Jan 2018 14:45:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5 5/7] convert: add 'working-tree-encoding' attribute
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201908.9398-1-tboegi@web.de>
        <xmqqzi4vt8n1.fsf@gitster-ct.c.googlers.com>
        <396FBDFA-606F-41D9-988C-D6886089BC15@gmail.com>
        <xmqqfu6nrowm.fsf@gitster-ct.c.googlers.com>
        <57086A32-6A2A-4B66-A355-10408C9FE0B0@gmail.com>
Date:   Wed, 31 Jan 2018 14:45:08 -0800
In-Reply-To: <57086A32-6A2A-4B66-A355-10408C9FE0B0@gmail.com> (Lars
        Schneider's message of "Wed, 31 Jan 2018 20:12:44 +0100")
Message-ID: <xmqqtvv1r6kr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> I am not sure why this is special cased and other codepaths have "if
>> WRITE_OBJECT then die, otherwise error" checks, so no, I do not
>> agree with your reasoning, at least not yet.
>
> The convert_to_git()/encode_to_git() machinery is used in two different
> kinds of code paths:
>
> Some code paths actually write to the Git database (indicated by the 
> CONV_WRITE_OBJECT flag). I consider these the "critical/important" code 
> paths and I don't want to tolerate any encoding errors in these cases as 
> the errors would be "forever" in the Git database. That's why I call 
> die() on errors for these cases to abort whatever we are doing. 
>
> Other code paths do not write to the Git database (e.g. during "git 
> checkout" we use the code to ensure that we are moving away from the 
> exact state that we think we are moving away). In these code paths I am 
> less concerned about encoding errors. I also don't want to abort the 
> operation (e.g. "git checkout") in these cases. That's why I only inform
> the user about the problem with an error message.

Warning the users early while they are doing non-writing
operation to give them chance to adjust the contents, before they
actually need to register the contents as objects by writing, at
which point we need to die.  That's a reasonable distinction and all
of that I already agree with.

What was questionable and left unexplained was why this roundtrip
thing needs to be different.

> The encoding round-trip check can be expensive. That's why I decided 
> initially to only execute the check in the "critical/important" 
> write-to-Git-database situations (CONV_WRITE_OBJECT flag!). I also 
> decided to run it only if the "SHIFT-JIS" encoding is used as this was
> the only encoding that I could find which reportedly does not round-trip
> with UTF-8 (although I was not able to replicate the round-trip 
> problems). 

I still do not see why you have problems with the approach of
maintaining a configurable set of "iffy" encodings (and throw SJIS
into the default list) to achieve all of the above and more.  For
SJIS users, instead of having to set environment variables to obtain
safe behaviour, they automatically get safe behaviour.  When using
encodings that are not problematic, they do not need to spend cycles
checking round-trip.  And when SJIS users know they do not care about
roundtrip checks, they can just configure SJIS away from the list.
