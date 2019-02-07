Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9F761F453
	for <e@80x24.org>; Thu,  7 Feb 2019 23:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGXdc (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 18:33:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40611 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGXdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 18:33:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id q21so1624451wmc.5
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MU+YbqfNfQ+e+jEIqcNIdM33Yy0KU9W9JToznjYhnLQ=;
        b=QAn2aUC20UVxZggyQO/nk5bUO6mAdxxUdctXCeBfLtZMlNhd3MheeQs4+cR6Fv8b18
         ViCbum6yWg8ErgXZRA1A+9NMTwRu4p06fiPFKkm4TYma46rI7MgSGZ+Rrtdzdu6uYYVG
         EoKUuuqoQkahR0pC3V+T4zx1IY6o8OXTejKSsChuOUyQI9p4TCahOCJxcQ2xGXNso90F
         9gTVTLFVHqB7mm2bNzvvbgeRt7xUBphXXJNwMZtwnbvKQOEIAKCY9L81avD93YyBfQxA
         yM2qBlT/p77ObPEX4JDA5wzw4/zn/Y38VpPN3cQ7uuwHPXu48VX2V5fEq0/zBF7P0YL4
         IiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MU+YbqfNfQ+e+jEIqcNIdM33Yy0KU9W9JToznjYhnLQ=;
        b=hL9OkEnerDqjrDwVuR8fDPe/cDgS5u/7YCvnz3NUyFKMj+NZFbR3aBIqyjpRGp4fgI
         3QKMe9Slc1eo6tbHuJNSEaa3putVg0id7EG3rsJzCydoRJFLDUPcRbj7/JZnzTtpXUZc
         Bcz32lbMmqN8lk6Dn4H7JEYRRzUCVe1n36yYsWLx3RD2rwZeqTfBQ9jVYgSJ8Obsu9jM
         9KFsRy9J3lLPiEqRyXafPfPfifgUnHgAbLrLyBw+M6A0/mq8h9PqtQpihHfR5Imh26sP
         YSaquTVvjeyFPJ6fxIwd3hHY01eUGCSMFmh0y6iMKRHKAdP368f3967PDLwcCFye6/zr
         DAlw==
X-Gm-Message-State: AHQUAuZplO1GJxcjdqOFTbHE+dDw6FBSMx0Kyb+gmT/aB8apQ8FQVhcO
        PS1Mlk429ignAkzhhKXVJmM=
X-Google-Smtp-Source: AHgI3IaR2qE3XZsyuW+u/goT2IUOIyZ+kn0B7K7cv2JzA84WndObXrfuZmeuJKcgNrHRmLSSPkOjeg==
X-Received: by 2002:a1c:7a0b:: with SMTP id v11mr3077276wmc.59.1549582409823;
        Thu, 07 Feb 2019 15:33:29 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a4sm266668wrt.37.2019.02.07.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 15:33:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: make sure we build Git parallel
References: <20190207183736.9299-1-szeder.dev@gmail.com>
        <xmqqbm3npgox.fsf@gitster-ct.c.googlers.com>
        <xmqq1s4jpgh6.fsf@gitster-ct.c.googlers.com>
        <xmqqsgwzo0ib.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet>
Date:   Thu, 07 Feb 2019 15:33:28 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1902072331060.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Feb 2019 23:32:49 +0100 (STD)")
Message-ID: <xmqqh8dfmawn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  
>> +# Clear MAKEFLAGS that may come from the outside world.
>> +export MAKEFLAGS=
>> +
>>  # Set 'exit on error' for all CI scripts to let the caller know that
>>  # something went wrong.
>>  # Set tracing executed commands, primarily setting environment variables
>> @@ -101,7 +104,7 @@ then
>>  	BREW_INSTALL_PACKAGES="git-lfs gettext"
>>  	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>>  	export GIT_TEST_OPTS="--verbose-log -x --immediate"
>> -	export MAKEFLAGS="--jobs=2"
>> +	MAKEFLAGS="$MAKEFLAGS --jobs=2"
>>  elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
>>  then
>>  	CI_TYPE=azure-pipelines
>> @@ -126,7 +129,7 @@ then
>>  	BREW_INSTALL_PACKAGES=gcc@8
>>  	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>>  	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
>> -	export MAKEFLAGS="--jobs=10"
>> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>>  	test windows_nt != "$CI_OS_NAME" ||
>>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
>>  else
>> @@ -185,4 +188,4 @@ GIT_TEST_GETTEXT_POISON)
>>  	;;
>>  esac
>>  
>> -export MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
>> +MAKEFLAGS="$MAKEFLAGS CC=${CC:-cc}"
>
> Since this is intended to be run in a CI setting, there is not a whole lot
> of opportunity to set `MAKEFLAGS` outside of the script. And if there is,
> that might open a rabbit hole when debugging issues that somehow in the
> end turn out to come from a hard-coded `MAKEFLAGS` somewhere in the CI
> system.
>
> So I'd rather clear `MAKEFLAGS` at the beginning (i.e. where you `export
> MAKEFLAGS`, I'd simply append a `=`).

I meant to clear it at the beginning, where I "export MAKEFLAGS=".
Did your MUA ate the equal sign at the end, mistaking it with part
of text/plain; format=flawed or something?
