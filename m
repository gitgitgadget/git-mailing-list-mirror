Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A9881F597
	for <e@80x24.org>; Wed, 25 Jul 2018 23:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbeGZBCo (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 21:02:44 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40558 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbeGZBCo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 21:02:44 -0400
Received: by mail-wr1-f48.google.com with SMTP id h15-v6so386538wrs.7
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5SGd8GjNDfSOXhOzR3P5H6N4rWkIdIdpr/MKKbwCCBM=;
        b=Fvd9d87HThi1+MHsGVjHgeU9RNKAF9CusmsDj/++ZRYfDtbghOf2TO4hz11Sh1xT/m
         dp1Td+V5yrqPQU9dPwdwMjE/zbNNXnWHX/xZkm1qMlf1SLXjoLbWTr9fGjv4UUUhfvXx
         0NgqwUnp4EDaVh3HR+GiIakLs1lQJ5xnMYcS3YHH49Z+9YiqR8eJj/Xqpst0GuG9eIcL
         4lYzgBzY/Q8Fk2vyD6o1cXDkQF9mof9xmfnq7SF2fsNt8MaUplJd+rDGwz2yLbNZx5yw
         UPjXxiWmXFFO44VRHfB/K5qtKglPbMzyF8TrQvaCiLDpUFPLBQf1NoC9Rj1y525B5teV
         kxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5SGd8GjNDfSOXhOzR3P5H6N4rWkIdIdpr/MKKbwCCBM=;
        b=b9oNdrKFkoZ5r5yJCCHMyRF794mOgYiv1dV9lUKHEgEj9jcxeGNlmk4MByZxbkOkBM
         A9ss0acoHh+Djn+T2Cs/CVDwZxYAySitr3SQV5beipS+D8EuohJcYSUH4fPdjn/gxlA5
         x5n/n3BW+FdOt3nMx/kAgPzKDSbh91kxI+EaBhJ544kkxzhijOePVfoQepgrVxCjpWJd
         i8JNblagd+uGmsHx3P23uEFRK+GyW2sXO/oaDQ2J38SXBVi9hFYaUWW/ajif8Ll14PzJ
         2tvNknZi6oQyOXWYhyeXsSpntRgs4yEBhOCRzQfKE9qkhKDb1bb2j89otQnI5Niholxt
         9oZg==
X-Gm-Message-State: AOUpUlGniErCoCzXytoS3I4B5ELbvZATgVjVRrR+2fntp0Z6U2HASLiE
        9YWieWTQIZdTHdwH7l0bOE4=
X-Google-Smtp-Source: AAOMgpcdHsauabnTztos47SKvj3KTqaEOcvCyTYQRj4jjPN4GhxCx957vSfiScdcDZumHYd8JD+TRQ==
X-Received: by 2002:adf:aadb:: with SMTP id i27-v6mr15671020wrc.149.1532562520955;
        Wed, 25 Jul 2018 16:48:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j6-v6sm21958543wrs.91.2018.07.25.16.48.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 16:48:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
Date:   Wed, 25 Jul 2018 16:48:40 -0700
In-Reply-To: <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        (Stefan Beller's message of "Wed, 25 Jul 2018 15:56:17 -0700")
Message-ID: <xmqqva92swpz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * ag/rebase-i-in-c (2018-07-10) 13 commits
> [...]
>>
>>  Piecemeal rewrite of the remaining "rebase -i" machinery in C.
>>
>>  A reroll (which is rumored to be quite good) exists, but hasn't
>>  been picked up yet.
>
> Forgot to state so on either the mailing list (or Github or IRC),
> but I read the tip of the reroll and I think it is good.

No, you did not forget (otherwise I wouldn't have said anything
about the rumor).  Skimming "git diff master..." is not a review
X-<.
