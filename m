Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38DDD208EB
	for <e@80x24.org>; Wed,  8 Aug 2018 00:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHHCbI (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 22:31:08 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:50382 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHHCbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 22:31:08 -0400
Received: by mail-wm0-f41.google.com with SMTP id s12-v6so868062wmc.0
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 17:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fPYyq7XflsGG3DZm8HesXm56YOKPopQ5VAQb/+c/kqk=;
        b=Xh6f9i62hiZhkvmcI17HdbTZDtNOjWFbL0Wf9Q5MhcI+QuSLB6kAVBULk6+fCcymE1
         0x7xu4A23WzDNDWkRJncpu4mu8VIqylsNULdzW4LYpCse9Lhk0wSuPD6+A/EhEcq9Yyf
         UkNfNiEl1DX5Y9r2ks9JaIOCQ/RWnDD4JA0mgz3ruzUsajf9ZswZJlec12WIIgMvyTh9
         5xawUWGFwkVxO+DiTmmPUi7i6nYIhA00sol88DPol5ZAR0ONOq4Y8Lp0yXBnFtdAxzSn
         UpWlAUXhK8QskvbtNW/vtcUckmOKpoI7NkgmGhWuZQl4PDPfnfyUM1BEjg9KhTfZLR/+
         chgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fPYyq7XflsGG3DZm8HesXm56YOKPopQ5VAQb/+c/kqk=;
        b=fF8qcHQgR3Vm2ldUJgr3/qSdDaBjrep2ss1HrdPPjDg8VpkVKjjxzXSqs82G+wNu8m
         zW0mOm9kDW3GJ4PHJSgEUfnPR7YzVfbJRh9+CO0aQ2LAOlIGygM3fq/ArgFOQawOqnpG
         qXnu41nBi/swfyh+WWj41u11nX20RScz9BuHrJjztzuYr8UWQMq5urjN/4QB8ln6+zIu
         VVeEP9VR1jLd8yCj2UfMXKA4U9WMkTYuw83ee1wn3HhuvVYkynYCPTKNZLG1te+kKTn5
         PhtFlHOpNfswY/ik5DHwGLM/5ZYLGIwLJpuYkgBUTk+HwsuBnbgYjrhibyUoMGIchjfG
         MMPA==
X-Gm-Message-State: AOUpUlGngx4UbUgHK2uudxoq6OZkabSRVhxWddyMBEkzoAfcVtYrPNc1
        voTxi1bYPJ1Cdlqq3r62tusdJa3F
X-Google-Smtp-Source: AA+uWPxkMnMLUcQwFV0Mg9zdqbnLEeGSHXmt8nn+NJ1POdvZKq1OeAZdCiVuaUPmYmgQGk8BQ3wSxg==
X-Received: by 2002:a1c:6d17:: with SMTP id i23-v6mr325864wmc.139.1533687252216;
        Tue, 07 Aug 2018 17:14:12 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p12-v6sm2187415wrw.3.2018.08.07.17.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:14:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] submodule: munge paths to submodule git directories
References: <20180807230637.247200-1-bmwill@google.com>
Date:   Tue, 07 Aug 2018 17:14:11 -0700
In-Reply-To: <20180807230637.247200-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 7 Aug 2018 16:06:37 -0700")
Message-ID: <xmqq36vpk94c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Introduce a function "strbuf_submodule_gitdir()" which callers can use
> to build a path to a submodule's gitdir.  This allows for a single
> location where we can munge the submodule name (by url encoding it)
> before using it as part of a path.

I am not sure about the name with "strbuf_" prefix; it is as bad as
using hungarian notation for variable names.

There probably are some existing offenders, but it is merely an
implementation detail (or a function signature) that the returned
value is communicated using a strbuf (contrast it with things like
strbuf_add() that is _about_ doing something to a strbuf), and in
the longer term I prefer to see them lose "strbuf_" from their names
and optionally use the same number of bytes to describe what they do
more clearly.  For this particular case, "submodule" and "gitdir"
are sufficient to signal what the function is about, I think, so the
"optionally use..." is not necessary---instead we get a name that is
shorte to type and to remember.

> Using submodule names as is continues to be not such a good idea.  Maybe
> we could apply something like this to stop using them as is.  url
> encoding seems like the easiest approach, but I've also heard
> suggestions that would could use the SHA1 of the submodule name.

Being human readable is a good trait to keep when possible.  

When you have two submodules with vastly different names
(e.g. "hello" and "bye"), and for some reason you need to go in to
.gitmodules and manually fix their entries up, "hash of name" does
not help you avoid mistakes (hashing "hello" and hashing "helo"
would give a name as different as hashing "bye", so when you see
[module "hel$something"] in .gitmodules, you would know that entry
is not about the "bye" module, but "hello" module, even if you do
not remember exactly if the module you want to manipulate was called
"hello" or "helo").  The same discussion applies against UUID.
