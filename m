Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01FEE1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 17:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeIZX3F (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 19:29:05 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50213 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeIZX3F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 19:29:05 -0400
Received: by mail-wm1-f51.google.com with SMTP id s12-v6so3110158wmc.0
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rS9xR/p0RuIfMV9hp0QJNvkdk1fvdwr0uhF3xjPiwaU=;
        b=VbhalyBEPLG0PggkqcZzFrt5isJJFUqAqIdwI7ZXnpAbwBr6ptbkDw7/QnigJaFxK6
         wmYRWbPNwXMw1hOIM4BsOOZFWYwS57hMce+lEvplX9k7uVcGXe9875Te/688Fd9E4+9B
         epF69oF9I9GGEHi8epRk8ojQSKRxEJUZm6OYEf6qWQtUM0Sln1q+tbpbuzc0e5r/LWAD
         VRyYkbiTGl1ao91QCZaU45QUTsOu+pqrwfQTPPuhX+0Tdc0UUTTfu51a0xEk4slL+pLS
         gWLgNmJopNG/n2AEwGY9pYNgwb7oeDiVxFuqTNvups+H2Hs8ffp310C1oNcIX/k8RL1I
         qUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=rS9xR/p0RuIfMV9hp0QJNvkdk1fvdwr0uhF3xjPiwaU=;
        b=UFbaWXZuDZhMRKK890bu0bqMnZiWjhVDQHDk/6w+QAqzTzbdVxDQgtYhipPhYanBEl
         x8zy4kU3gQXU4n37SnGhlZWue+QDouILUJhsznNRll1SdWmeuURCpUCLMzgkYi3sML88
         VECo5mX8+52EPROT9c9fm3KPjG8uQOE770WcIcUUwYAzeZ7a5nTmU2PUHLgnmo2WS0I9
         oetLDsKrpL0L7B9+wNdakhba1LhC3A77vR6mHB7S+mC5iUHk9Uu5A5Fz/CHs3/dvehpV
         Qm1xHPoD+YJBJZwAb0JuM9IY4Jj/tQgaevKsj8xiQis0BjCI6NNOoScL8hJvwLC6sQD/
         V/ng==
X-Gm-Message-State: ABuFfoi/OjDhvyHO36TlRizInW0zsPDkBQ2HdbQh6Dg8obKpQopWQ8k8
        hf7hGtWk5Kt3/jfTFkqbD1E=
X-Google-Smtp-Source: ACcGV61LIN7O7RtXzlQKpJX/yDmfDQi+Fmd2P7U5Bw14depsHCRRHQMmUFd3E1DJbHwX6vJQloRQvQ==
X-Received: by 2002:a1c:f53:: with SMTP id 80-v6mr1840293wmp.58.1537982107413;
        Wed, 26 Sep 2018 10:15:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1-v6sm6406237wrt.9.2018.09.26.10.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 10:15:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tacitus Aedifex <aedifex@sdf.org>
Cc:     git@vger.kernel.org
Subject: Re: Fixing constant preference prompts during tests
References: <20180926162638.GA28077@SDF.ORG>
Date:   Wed, 26 Sep 2018 10:15:06 -0700
In-Reply-To: <20180926162638.GA28077@SDF.ORG> (Tacitus Aedifex's message of
        "Wed, 26 Sep 2018 16:26:38 +0000")
Message-ID: <xmqqh8icmb8l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tacitus Aedifex <aedifex@sdf.org> writes:

> I keep getting prompted for my algorithm preferences while running all
> of the git test suite:
>
> Set preference list to:
>     Cipher: AES256, AES192, AES, 3DES
>     Digest: SHA512, SHA384, SHA256, SHA224, SHA1
>     Compression: Uncompressed
>     Features: MDC, Keyserver no-modify
>
> What is the best way to prevent this from happening? I want to run the
> entire test suite unattended and have it complete on its own.

Nobody raised this so far as far as I recall; thanks for the first
one to do so, as it is a sign that you are doing something unusual
(e.g. have newer or different version of GPG than most other people)
and others will hit by the same symptom later when whatever thing
you are using as a minority right now becomes more prevalent.

In other words, we need to have a bit more detail of your
environment.  I made a blind guess that the above may be coming from
GnuPG, and the test framework (t/test-lib.sh, t/lib-gpg.sh, etc.)
tries to run our tests in a stable environment that is not affected
by real $HOME etc. owned by the user who happens to be running the
tests, but it could be that your copy of GnuPG may require a bit
more seeding than we do in our test framework to squelch that
preference prompt.

It may not be GnuPG and something else, but I think you got the
general idea.


