Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7740A20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 19:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLLTTc (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 14:19:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46447 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbeLLTTc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 14:19:32 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so18785088wrt.13
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 11:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zFFT7GdkG1ZG9N3i9sKXYYQPZcW08m893F95Be6lKYg=;
        b=crSoip7h4CYpOX3/S0P4WSva1I+hIKWz0w4Q0W19+TeZ5Qkd/WIQ1dM8JlHL8ELgGb
         OUkA1r63WbJSlgwEsNdtfF2cu4RIjhmAx8sijVZ0TS/vsLSRG9LzaYpYlL9OT/ZsKA5/
         J3AYsYGN6+dbKjcuvmoJ4ksWIfRmRfwLKhnMLM81++Qxk18nyFepHQOn/U1pIwd7RL4r
         dVSBIW6zdkmFIsxcGaOB0i6tWjGb14WAGQxHdl7yDsc9q81PsdSqxeomcfHMGMn6rK2i
         eViN6WKHFbtu/WtXmlOY7Q8FTtVemAWeRCcEwAtFuLHr/auNXR3D2DHod6tLsigVN6zq
         rNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zFFT7GdkG1ZG9N3i9sKXYYQPZcW08m893F95Be6lKYg=;
        b=EFl36uDuZ9KZQkpVFcnAozJMEzT7cIpR3KSGsb7CMEIwHjSs1EqM7Jcph9v9WbtUJQ
         2dhlF7ry2CM9ADgRQHagAZtMBP5Rm6b0nPCj6MMnSdStovXt4DGV3bwZNcq8qM2+YUV3
         CBkrBBiCw30WlXMHVx3kiOfzm6E65RYWIqxZYhYHoMBqBMiV/6IgT7Y82loRPY3zejbk
         dJ7xTTE8vvwW8Is3y2JgjE1ZqsaEa6LFUyExV1frXPOVGuqzQUpaWR62ighoARysTT13
         lf7rn2nU1s4CGr4Jq7m0GIaQUTqiMCSshety+1JDsQNB1zJ2GOkIJ/LDiAw3nKAUKXxN
         NSiw==
X-Gm-Message-State: AA+aEWYyJr8WGfEvxjAeLgP+HAM04AfCnC9Dq1zAf5QtA1bBZdEvgUTd
        mIKCmbVreWKoUkZhOWxwRLk=
X-Google-Smtp-Source: AFSGD/WMt02d/OOvHVm7pqVBaPDCNfe5k8qKh4TfVXg/XfHbiaG++ENkXGGHVEAmrQ71L4swN2ncgw==
X-Received: by 2002:a5d:42ce:: with SMTP id t14mr1646373wrr.51.1544642369654;
        Wed, 12 Dec 2018 11:19:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n82sm3941891wma.42.2018.12.12.11.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 11:19:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     CB Bailey <cb@hashpling.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] shortlog: pass the mailmap into the revision walker
References: <20181212164134.12922-1-cb@hashpling.org>
        <20181212171052.13415-1-cb@hashpling.org>
Date:   Thu, 13 Dec 2018 04:19:28 +0900
In-Reply-To: <20181212171052.13415-1-cb@hashpling.org> (CB Bailey's message of
        "Wed, 12 Dec 2018 17:10:52 +0000")
Message-ID: <xmqq5zvyimdb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CB Bailey <cb@hashpling.org> writes:

> From: CB Bailey <cbailey32@bloomberg.net>
>
> shortlog always respects the mailmap in its output. Pass the mailmap
> into the revision walker to allow the mailmap to be used with revision
> limiting options such as '--author'.

I am a bit torn on this.  

If an author of interest has entries in the mailmap, with the same
name but three or more different e-mail addresses, you could do

    $ git shortlog --author=junio@kernel.org --author=junio@twinsun.com

to find commits by the author under these two addresses, and exclude
commits by the same author made under other addresses.  With this
patch applied, it becomes no longer possible, and you can only look
for commits written under all of my identities, or none of them,
which is a minor annoyance.

But more importantly, the user now needs to know which one is the
"canonical" spelling of the author's ident [*1*].  Asking for
commits written by junio@kernel.org will not yield any result with
the patch applied, no?

For the author in the above example, luckily, AUTHOR_NAME is the
same and unique, so without your patch, you could still do

    $ git shortlog --author="Junio C"

to grab all of them, but there may be authors for whom there is no
catch-all substring that would match all of the idents they ever
used but still unique enough to match only that author, and I do
agree that the new feature proposed by the patch in question would
have uses in such a case.

Which nudges me to say that there needs a way to ask for the
original behaviour, disabling the rewriting of commit author
identity before --author filter kicks in.

There may also need a way to ask omitting mailmap processing even at
the output phase.  I do not think it is a particularly interesting
feature to be able to ask for my commits under only two of my
identities [*2*], but as long as that "feature" exists, it also
should be possible to see the result of that "feature" more clearly
by not merging them into a single list.  "shortlog --no-use-mailmap"
may be a way to do so, but unlike "log", the command currently does
not take the "--[no-]use-mailmap" option.


[Footnote]

*1* Passing the query string given as --author=... through the
    mailmap machinery _might_ be a possible ingredient to solve "the
    user needs to know the caonical spelling of the author ident"
    issue this patch has, but I do not think it generally is
    possible (e.g. how would you rewrite --author='.*@kernel.org').

*2* In other words, I think the loss of "find only my @kernel.org
    and @twinsun.com commits" is mere annoyance and people can live
    with it.  But I think "you must look for gitster@pobox.com, and
    looking for junio@kernel.org will not find my commits made under
    that identity" is a show stopper.  That is why I use a very weak
    "may also need" to this "optionally not using mailmap at all"
    feature.
