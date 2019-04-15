Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C61C20248
	for <e@80x24.org>; Mon, 15 Apr 2019 03:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfDODKB (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 23:10:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44508 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDODKB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 23:10:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id y7so19780721wrn.11
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 20:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Zp+9T/1MmTobD41eY9xM/wUA7lOmBnJkAWTLVBNmSi4=;
        b=pyGJtPccIULlLQNIbt4FwgiP2PU6sPOQBIB/f3VQ7oOBVo82cZ5YuOMvYBW0SE4Eu1
         TkYuFBTafrexjVdt4lANHwxu+UVSwDlamHcAGOWQGooFui47Zpx/7R463m6cxWZmOrIV
         apgqGz4ZBcV9nf9Me/gokTOMZpsXCQIBeQWJHPaPt9sK5dDHBJlPqgtu0lt0qgiI5qmZ
         mcylqfmD06igcbgCg7reIflOKjdFktAwfdBpg9uHAWdo/aZ7xPbt236WjOnK9B7GXEIJ
         iduaw8qsFI3deOyu5G3mpSw1MQtgDotZOlDnpfJjHnPrvVL47yh1A2/tS+fejYu3Q0P6
         K6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Zp+9T/1MmTobD41eY9xM/wUA7lOmBnJkAWTLVBNmSi4=;
        b=DFJlqRepA7dWrbj+cPVRxe5slzMsExtDoZoEHjr+Y+0f5FaQHkfnHoM4Kh2B+VIg/H
         9PqI3TFpNbi5KbwPWEwfhR4BOVg5mDysBHNbEJGKeibmxy+hNn3lVYMFFU0iXH2+GCT3
         KPkRf7zJro/Z9G/tlt4TOX5+l1dzWujHufh7YOzcoK//okLJeI9+HybZTzE+SVsrcYee
         qYmSHUogRnMPSffFa6tJCOJs07ZefyP9JQCf2FaNHAAAJE6lefl0xqlC1i+gM5Oq+sNf
         p0EufCW41hXr5hpARSv4zF0lZqVchH1h6V8bqwsGYdKDJYQZYsc6POWHJ+stT+MYsPPC
         /xBQ==
X-Gm-Message-State: APjAAAU8qnZFDgSnjeNS3kBVcnhk/aFi7Ihq82vPCKZ71ogkvrQYcBZ8
        zqRKPn0sAe07FDEJBv9wrOw=
X-Google-Smtp-Source: APXvYqwv4ruEdbg5aBcIDE6I0hZqdrJx2QbI1l9Cnksc5NrlThZyeofQO+gzcfccn3T2CAvD4zt7wQ==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr14673717wru.150.1555297799196;
        Sun, 14 Apr 2019 20:09:59 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s18sm16773979wmc.41.2019.04.14.20.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 20:09:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] docs: exclude documentation for commands that have been excluded
References: <pull.168.git.gitgitgadget@gmail.com>
        <31d8e43cbfaec36f662006a711b64bca47009e59.1555070430.git.gitgitgadget@gmail.com>
        <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
Date:   Mon, 15 Apr 2019 12:09:58 +0900
In-Reply-To: <CAPig+cTiF-9+pXnx19y0PUs3Nwek7N2cEg2r2jAPzEXPTvpxpA@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 12 Apr 2019 14:46:38 -0400")
Message-ID: <xmqqpnpoufp5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>> diff --git a/Makefile b/Makefile
>> @@ -2455,22 +2455,25 @@ $(VCSSVN_LIB): $(VCSSVN_OBJS)
>> +Documentation/GIT-EXCLUDED-PROGRAMS: Makefile config.mak.uname
>> +       $(QUIET_GEN)echo "EXCLUDED_PROGRAMS := $(EXCLUDED_PROGRAMS)" >$@
>
> Should this rule also have a dependency upon "config.mak.autogen"?

That is probably a good point.

> Perhaps like this:
>
> Documentation/GIT-EXCLUDED-PROGRAMS: Makefile $(wildcard config.mak*)

I'd rather not let changes to "config.mak-", which I keep in my
working tree (untracked and disabled copy of config.mak, that can be
readily activated by renaming), be part of dependency rules.

If we know 'autogen' is the only dependency that optionally can
exist, then depending explicitly on $(wildcard config.mak.autogen)
would be a better alternative.  To those who do not use the autoconf,
the macro will expand to an empty string, and to those who do have the
path on the filesystem, the macro parrots the constant string it was
given, which is exactly what we want.

Thanks.

