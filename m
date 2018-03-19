Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641AE1F404
	for <e@80x24.org>; Mon, 19 Mar 2018 17:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967386AbeCSRgR (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 13:36:17 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33195 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966792AbeCSRgN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 13:36:13 -0400
Received: by mail-wr0-f170.google.com with SMTP id z73so15224704wrb.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=sI0GOODGLZuO2DrPcZRJtgD9tiy6WbdpMEYGZy5HHkA=;
        b=qlLfS3A0sFb1hz/oGKzmj7TBRE7vrjVM0Yqb/SO+DPOvda0EslGo4QwsXhbWyNb/GS
         swYnByBO6uH7vPRqdsmtWRlu1fmz2FCocmzXtILB2Mx0yWR3KPHea+Dx5vtd0/clYIni
         xAxl375DGxRw1rE9PzsI+jGUify1X/WQSfCcN6u9nqBO+QzjBAlgy0OCqpP4TkLGFBDW
         krfCr/fQIeOdHgZKYX0eXjElMWXncpuQ/bCzik0KE0hJgce5oNNOw5LmhtzWuX2dtbzS
         wDaT9vAAra7l3EWnT5/S3uqrUYTsKEDpLu54KV5KwJioj16z7biQvvPFuo+EoAW9sZEh
         1SaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=sI0GOODGLZuO2DrPcZRJtgD9tiy6WbdpMEYGZy5HHkA=;
        b=mKhDfl2vr4cgQIn0ZUK4KjxngualKqX8abchO7VAFF5OoeMGFU6FNqdG6VmPqObJ74
         mcS5zemZQTTi17QUEFf+v50fHlnTakRyedqMN9+hidPZ0DLwFAV+x5QBn9xrCwib8yFN
         ks9iwC7t0epfPKfUXWDnFaQZHgfcwjHXEdQj6osjR/fDO5bVEdPfA0ik7HgvnoFEuSfx
         fh3T/Ce4GcTA1Vl4mpz0AFYC8sZgaqXVZ2Q2W9DrbIKvb6pdy3qDzxc1m9hF+W8rr6Bv
         KEZY0HxLxxEkT4Hdg1i/7agDH2icdDjF5V16UfEgNqBGuaqIXkiscSo6lpgR585GFMIN
         VTJw==
X-Gm-Message-State: AElRT7GKFr5auYGyjhu8vQ2v4TJy6IaJJVppIZXqTZLHKW/MOuRxjVfM
        /C7zKZa3DuuhDOvkkwRdLMA=
X-Google-Smtp-Source: AG47ELuA+SBh1gJDdzQTZI2b747OQ5ekCSJ5zMtHvyHRgtVrINcEK6NQYIafUQHd0HS0UXsiDa4MLQ==
X-Received: by 10.223.141.143 with SMTP id o15mr10833975wrb.272.1521480972332;
        Mon, 19 Mar 2018 10:36:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 43sm683032wru.40.2018.03.19.10.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Mar 2018 10:36:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luciano Joublanc <ljoublanc@dinogroup.eu>
Cc:     git@vger.kernel.org
Subject: Re: Bad refspec messes up bundle.
References: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com>
Date:   Mon, 19 Mar 2018 10:36:11 -0700
In-Reply-To: <CAO+-ZX_-COVpzqoAZLRGu4mvLMkLYiR3y7rkCtwmnvJ8kA7txQ@mail.gmail.com>
        (Luciano Joublanc's message of "Mon, 19 Mar 2018 08:39:02 +0000")
Message-ID: <xmqq370wvugk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luciano Joublanc <ljoublanc@dinogroup.eu> writes:

> Yesterday I created a git bundle as best as I can remember like this
>
> git bundle save chunk chunk.bundle --all master
>
> Note the 'master' I added accidentally at the end - this was a user
> error but still the bundle was created.
>
> When I tried to clone this, I get
>
> ~\local\src> git clone 'G:\My Drive\chunk.bundle' fs2-columns
> Cloning into 'fs2-columns'...
> Receiving objects: 100% (31/31), done.
> Resolving deltas: 100% (5/5), done.
> fatal: multiple updates for ref 'refs/remotes/origin/master' not allowed.
> ~\local\src> git bundle verify chunk.bundle
> The bundle contains these 3 refs:
> 3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
> 3c804437a5f8537db1bfb5d09b7bff4f9950605e HEAD
> 3c804437a5f8537db1bfb5d09b7bff4f9950605e refs/heads/master
> The bundle records a complete history.
> chunk.bundle is okay
>
> After trying a couple of things, I finally managed to clone it using
>
> ~\local\src> git clone -b master --single-branch .\chunk.bundle fs2-columns
>
> i.e. the '--single-branch' option saved me.
>
> Is this a bug? Should bundle allow providing multiple refspecs when
> `--all` is provided? I admit this was clearly a case of 'caveat
> emptor', but shouldn't this be disallowed (i.e. is there any situation
> when this is useful?)

Thanks for a report.

Just like a remote repository that reports the same ref more than
once in its initial advertisement (i.e. "git ls-remote $remote"
gives duplicate entries), a bundle file that records the same ref
more than once *is* a bug, I would think.

A "git bundle create" command that creates such a bundle file
shouldn't.  It is not very useful to diagnose it as an error; it
probably makes more sense to dedup the refs instead when writing the
bundle file.  Of course, we should abort with an error *if* the code
ever tries to store the same ref twice with different object name
(i.e. attempt to dedup, in vain).

Also, "git clone" from such a bundle file (or for that matter, a
remote repository that advertises the same ref twice) probably
should do a similar deduping, with a warning message.

