Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,URIBL_DBL_SPAM shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0598B20248
	for <e@80x24.org>; Tue,  9 Apr 2019 06:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfDIGbs (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 02:31:48 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38656 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfDIGbs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 02:31:48 -0400
Received: by mail-wr1-f54.google.com with SMTP id k11so19247364wro.5
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QkWPvkddWwHYykoIoVL9Rnh8OfsG6bY9+4jBMD4yq90=;
        b=qcq4TkLJizZftsNBx00JDw5iKBw+LkvD1kA5T4HMiLvdPQIFV/4d0SfOYMcomVt9aG
         wB5Kq+xbE4h1Es/dUUulTzi9tmOwPLyvH6hqPR5MpxVsHeNGK1IFJtChMpfI7FIaYE2E
         /Dzge/K/0gAe5c5bvn8qAWZmtkNPdph6qdHCexkHHqovgBUz0/KGhhoGaAeYBNk5cqr9
         A+YoAHCgkbzq5szE4HTzzP/ia7pc98EXGQImFbDzvuUG/3j06YrcHP9t567p+gk0Dyp0
         9F7ZT5EwwYNb4I5FCjQPbnpwJ0+AeaIyb2b+G3DGH8D6m8mXucARPLGF6a7L1cbg4WyG
         jb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QkWPvkddWwHYykoIoVL9Rnh8OfsG6bY9+4jBMD4yq90=;
        b=T07bUT3cZe0mT4YOWwtFsDi45Hozvysq117ttNtsUg73n/TL2Fmqc1eeBoDBVasTvn
         cKPwXj4lEhcjp5I9vuqpeE5fHpKt5xusInXJLLsr5kyXatdGQ1ZXjqSCphf7TV/3aVht
         UKATGyV99d82KwwMDQCiZuY3xxJuS1DryxAO5FNoG/UYubEY2FXPyvYoEWY70j2yvetY
         kX3hLbUUdpfEhHVtVBbhPYezm3/bHs5VJscg1FKLhLl6mpz6Nf6NB9kPZB27jjcaIOCq
         oPUQ7oUerluDjGDd2UuVu5y2aAmBeBHGMaucLxr/uYRz/+uluYh84anRr2Q3FDS36ABp
         3RFw==
X-Gm-Message-State: APjAAAUlQwbi72KdbwPFBaoB+MjzkaKc/7tjlGeJWrOgXbPYYd/G6O6z
        gqu1Iv5Qf9pfoN5tSc25eqg=
X-Google-Smtp-Source: APXvYqziupbvXWcqE+YDtgu5QaLnzYGNseL5YCJxulY7mX5FmEKGRJgTrECo+Zz9QODMD+NHv9BfZw==
X-Received: by 2002:adf:e648:: with SMTP id b8mr21106431wrn.132.1554791506380;
        Mon, 08 Apr 2019 23:31:46 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 13sm14739300wmf.23.2019.04.08.23.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 23:31:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: "commit --author=..." does not work if global email and name is not set
References: <CAA01Csp7y9=2n9=TNYMMw9LUO_cENz7FBeZjFrUd2FvHFT9NCQ@mail.gmail.com>
        <8636mvng8n.fsf@gmail.com>
        <xmqq36mt9e7l.fsf@gitster-ct.c.googlers.com>
        <CAA01CsqAt8osKArhdgATNj29+a9VO6wUwhX6=cRebnDBFx_EVg@mail.gmail.com>
        <86y34kn4c8.fsf@gmail.com>
        <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
Date:   Tue, 09 Apr 2019 15:31:45 +0900
In-Reply-To: <CAA01CspJAPnBFsQsXP4Dpweeg6oBVj==TB0aEnK5o1Et5zS30Q@mail.gmail.com>
        (Piotr Krukowiecki's message of "Mon, 8 Apr 2019 13:55:25 +0200")
Message-ID: <xmqq7ec38zam.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

>> If a real person making commits uses their own account (just on that
>> machine), he or she can set up `user.name` and `user.email` settings in
>> the per-user Git configuration file
>
> There is one common "test" (Windows) account which is used both by
> automatic test scripts and by real people who log into that machine,
> so this is not possible.
> ...
> Do you mean following?
>
> 1. set default user (user.name, user.email) to "automatic test user"
> on that machine
> 2. set commit hook to prevent commits with "automatic test user" AUTHOR
> 3. scripts will set AUTHOR (--author) to for example "script X" or
> "automatic script user" - different than the default user
> 4. real users will set AUTHOR to their own identity (--author=me)

I do not think 4. is what Jakub meant, which is to make the author
and committer identity for real humans come from the configuration
that becomes in effect automatically by merely logging in.

If that cannot be arranged, something like 4. may have to serve as a
rough approximation; that sound like the best you could do under
that limitation without breaking the general usability of the
system.
