Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0D7B1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeF2Rm5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 13:42:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:42063 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeF2Rmy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 13:42:54 -0400
Received: by mail-wr0-f195.google.com with SMTP id p1-v6so9591816wrs.9
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 10:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kDlmEK03qRJliGz5kEiZjdNvzKZ9mrmcJF+l2+/VSr0=;
        b=fCaZzeGmT05RWBgQL5hOl6btcl0rnEPJNkIb2Y8SKonV12HCePLtgk5scmlbc1nnd5
         5P98/lwdJgrTKK942VX6Ii1nFdngFhvymqdxi2grup8DcSn3IAyBea7CMhAfZt6WLX9S
         pproev7THP3IVRTcmB0CHHWwyaZSO9IWMFv2qbV6Z3uYGeHP7HugjmQpi9avUX8K5kkv
         GPn1h3VLBghnf11FIqapvChp3/qgslheVabGnY5nW6MTuWcl2+E+ZPm8aunXgg5yIRGA
         2hldVDplXqDXEMAuNP9djMMdEo1T4xq74NAftpadvye62TAxkKHGPczMVpfZsG00ZJ6B
         Dweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kDlmEK03qRJliGz5kEiZjdNvzKZ9mrmcJF+l2+/VSr0=;
        b=iiGhf45DPqeBQ8C24NtE7Dc5Zpmj0LEEd8/mJnuJvLnptRmbLNh8IWXp1YDo55q1Iy
         RmihoVEczVyNLOb6KOfzOca7TNrIjUdoRQSXfeYKL9Gsr4zDYH+/MP7Z0ftePy1VjNv2
         qeMyvj+DPB6BMWFplifErv8vWrinj0+loFL5e1FkgX7eUywIB4ZedShIlXh3d3eK159K
         +2MsPyByRl8vVvcGeSzH8B5WK3WmNVI8tCppG+663b5TCXmKkn1R77jTzdnrOvMUrzVr
         sZRqsoscc6YAqEiNLJwZgj5cEfmQQfxRO+r3VWTwVpM8JKJmkHbQpq4HDsrRzkU4t4sv
         EzKw==
X-Gm-Message-State: APt69E0u/aLSAG2Ns845tqFHTy/8kQvoCqH2R/U5Oi6zK+vKtdNR0Xbl
        nW47nqpDIi/Dw95FkY0mnKjhtZiG
X-Google-Smtp-Source: AAOMgpf90vkfofH/ybXGjLNHFwia+FnicekwfX1n3kG2Ph9K2CeYEf2gAGI3kHPeDfeIDb/g/VHUYA==
X-Received: by 2002:adf:f9c5:: with SMTP id w5-v6mr1469052wrr.105.1530294173001;
        Fri, 29 Jun 2018 10:42:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b16-v6sm15007377wrm.15.2018.06.29.10.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 10:42:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] .mailmap: map names with multiple emails to the same author identity
References: <20180629021050.187887-1-sbeller@google.com>
        <20180629021050.187887-3-sbeller@google.com>
Date:   Fri, 29 Jun 2018 10:42:51 -0700
In-Reply-To: <20180629021050.187887-3-sbeller@google.com> (Stefan Beller's
        message of "Thu, 28 Jun 2018 19:10:50 -0700")
Message-ID: <xmqqh8llv690.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> There are multiple author idents who have different email addresses, but
> the same name; assume they are the same person, as the world of open source
> is actually rather small.

Thanks for an interesting experiment.  As with 2/3, I suspect that
most of the contents in the patch may be correct, but I'd rather see
these confirmed by those whose names appear in the patch.

IOW, I would not feel comfortable applying a patch, unless it looks
like this (just taking a single person as a random example), 
and I do not mind many such individual patches:

    Subject: .mailmap: unify the same Ben Peart

    These multiple author identities in our history are actually the
    same person.  Map them to the latest address.

    Signed-off-by: Stefan Beller <sbeller@google.com>
    Acked-by: Ben Peart <Ben.Peart@microsoft.com>
    ---

    diff --git a/.mailmap b/.mailmap
    index ff96ef7401f..2607846582a 100644
    --- a/.mailmap
    +++ b/.mailmap
    @@ -5,54 +5,86 @@
     Amos Waterland <apw@debian.org> <apw@us.ibm.com>
     Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
     Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
    +Ben Peart <Ben.Peart@microsoft.com> Ben Peart <benpeart@microsoft.com>
    +Ben Peart <Ben.Peart@microsoft.com> Ben Peart <peartben@gmail.com>
     Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
     Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>

It may be even better if we can arraange the author of the patch to
be the one who is involved, with "Helped-by: Stefan".

Thanks.
