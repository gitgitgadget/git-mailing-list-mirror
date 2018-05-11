Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 887051F406
	for <e@80x24.org>; Fri, 11 May 2018 01:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751000AbeEKB5W (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 21:57:22 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38983 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeEKB5V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 21:57:21 -0400
Received: by mail-wm0-f49.google.com with SMTP id f8-v6so405159wmc.4
        for <git@vger.kernel.org>; Thu, 10 May 2018 18:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CWElzvvNe9NjjPF+SS9w31IpjDNndUzbt+f6kkOncuQ=;
        b=LCTIMb68n/lsY87AxmF0npc7Ixg2vLGNRB29Cz4jk1VrFsv1zPaueS45T/AHjNhyKY
         Gf78vMXfU1UJJwib5rYBJ/KZv4YefLN1LM0Gtvfbx0NgiAL9A0zxUjmoiaYv8U+Djwgf
         hnnGoYkcbr4pCtfopGcZk1RYU0ldzIv/zG7UoOihESy+g5R8ychVDso7RO5JmCb2CD6U
         kK7KpER468DpkGo8cbDfCQaFS+qu6APFqOPsjGAfZyH8OoNLr+MoXTTkGKW8o6WsfXCr
         hlyuXPHsE2eHb+jabkQizUNUmnLQmJH9YSAVKTonMuoOKw83qr7kGiEGEqohMhb23W2O
         urKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CWElzvvNe9NjjPF+SS9w31IpjDNndUzbt+f6kkOncuQ=;
        b=OucwZYcJt5CmoHkpsyOA/ERsJsONDjnXQvEbx0zyOBNFvO8stsX5CUrmImIVIZpnyz
         bHPxo0GtKoZ+ZtaO46nuz74eSMLPYpXNhuZNcZf1Sru+UGq8TLFbaMY6FRXPSOPWSXlR
         9Oj2PkIbb2csAeQwCl040AxIJvML71DpKjMjp3V/6o7wXHxAXX+LsCv2Apzh0YTN556E
         jcu/ZFKL2psrNyeAXYeIExRmbBV1Fumwjf7U8JNV+H17iNC9mjH8DbczRBlRHVsMz+So
         RbJAqzRfGQ6+MMbw8WRbE/ejxVl27kdRkbjhv2iLjmqaNkTOf1PpZQfi9TC/MPR9Q5Uu
         yEGw==
X-Gm-Message-State: ALKqPwcQXkixLRsSIjWLGr9H54y+yyDGBk6CI3uMCEDl5IKpmzS2foCt
        ZeeU5OVYhdJqVdXAE8EbLGI=
X-Google-Smtp-Source: AB8JxZoNP0vozhWky+0c21FqdyssRPyyUC6hehxrEhaYRqoNDyqI3j/17kWISoqW7RY/aNloKSnwnw==
X-Received: by 2002:a1c:e156:: with SMTP id y83-v6mr689876wmg.92.1526003839801;
        Thu, 10 May 2018 18:57:19 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v192-v6sm76681wme.45.2018.05.10.18.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 May 2018 18:57:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Alejandro Pauly <alpauly@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass\@googlemail.com" <eckhard.s.maass@googlemail.com>
Subject: Re: [PATCH v2] add status config and command line options for rename detection
References: <20180509144213.18032-1-benpeart@microsoft.com>
        <20180510141621.9668-1-benpeart@microsoft.com>
        <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
Date:   Fri, 11 May 2018 10:57:17 +0900
In-Reply-To: <CABPp-BGE6RXv3ka8wGXruFjk3W=kDEDJ6zpH3t5=_CGSTONCHQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 10 May 2018 09:19:00 -0700")
Message-ID: <xmqqfu2zhs3m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> Note: I removed the --no-breaks command line option from the original patch as
>> it will no longer be needed once the default has been changed [1] to turn it off.
>>
>> [1] https://public-inbox.org/git/20180430093421.27551-2-eckhard.s.maass@gmail.com/
>
> I'd just drop these lines from the commit message, and instead mention
> that your patch depends on em/status-rename-config.
>
>> Original-Patch-by: Alejandro Pauly <alpauly@microsoft.com>
>> Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> ---

Other things seem to have been resolved between you two already, so
I'll only comment on a minor tangent here.

>> Notes:
>>     Base Ref: master
>
> This patch does not apply to master; it has conflicts.
>
>>     Web-Diff: https://github.com/benpeart/git/commit/823212725b

As Git is distributed, unlike tags that are meant to be global among
project participants by convention, a branch name can never be used
as a trustable base among developers.  Your 'master' branch may
point at a different commit from mine, and my 'master' branch today
may point at a different commit from mine yesterday.

I've seen patches that used a similar note below the three-dash line
that named an exact commit object name.  That is a lot more reliable
way to convey the information necessary to consturct the exact state
the contributor worked on.

> This web diff shows em/status-rename-config as the parent commit, not
> master.  Since your commit message mentions you want the change to
> break detection provided by that series, just listing it as the
> explicit base seems like the right way to go.

Thanks for digging.  That would work well, too.
