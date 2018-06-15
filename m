Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F151F403
	for <e@80x24.org>; Fri, 15 Jun 2018 21:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756562AbeFOVUk (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 17:20:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33704 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753741AbeFOVUj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 17:20:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id z6-v6so8067060wma.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aOusa8OaJbdTonzTkIR8YFq7uvypgxtuL1Ae7A2K9Rg=;
        b=bCMUSsCGcWru1rdUFoWGP2eANT8f96+KfpsRxktcz4ZmtzdUxmkdVyh7jvQYuw4gLT
         70jhAzbz/k3/EOQonZjnYVTTpyQ0DrG3Xi/deztfB2RyYh98cFEscTGaCAwMoPku0Syk
         D+toZpMhOkbzYAimhC0UKztED3iL7bsvpaeYWmvNs1kJ9ZP8syMJbAjgaR9tt/F4KZIT
         OxAurZ4feUo+k8q3XHgqb12LTo1GTz8kMb18AVVbv7aPXgLqwfZji5MwYs3B2xow7Mm4
         zK5BthnrIIqMX1Vv4VDrWR8mocpdA+W7iVyrbvIeHvuARH12DJuG6eA8MChDyOZr+s/d
         JrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aOusa8OaJbdTonzTkIR8YFq7uvypgxtuL1Ae7A2K9Rg=;
        b=CViPWHRvbX8toVokc8GZYg+KHdZOVBDXxeCE0Ryad4E9o/DYkL5GaxMPjE8JMj74pz
         BnaY9UBPNOJ7TdESZ94ssJPCpq2C6VvfNd5ha5pMKNDLIaT+bJttFpSKDpi9fd2e45Ju
         FFun6kw6SROmIjZWq8PLPtQHYSntZC66ZMCnpSdZhbEdNG/Jzg1CVR+xNWzsyScvHjKH
         7ewa2ukhL0EZ9R4et21ygxR57cMM3MHJmFZXuu11j83IbXrMT+G4ewXVGLqCrkK6DUB9
         MiU5Uy48xW5B2BLDyfdQuhYXhJhZH2G3m6reOSm0OKKZhpA5tlFX1w4zLJzFtrnJmDY1
         1WUw==
X-Gm-Message-State: APt69E3x/dfpexL/e98nIg+FMfuZJ/paoyqv4XUGctNf8N+i4h6lf7XJ
        IIu9eoo+Xq6fOd7ZgPFb4Es=
X-Google-Smtp-Source: ADUXVKJY0e1hFh+ewDa186imceDsIhWhNTlxxQM3qhFG+YvRcDmc86WwRf6u7KckNY8/6DN0Cxor9Q==
X-Received: by 2002:a1c:4845:: with SMTP id v66-v6mr2331031wma.56.1529097638326;
        Fri, 15 Jun 2018 14:20:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id w15-v6sm12864836wro.52.2018.06.15.14.20.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 14:20:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v2 0/8] ref-in-want
References: <20180605175144.4225-1-bmwill@google.com>
        <20180613213925.10560-1-bmwill@google.com>
Date:   Fri, 15 Jun 2018 14:20:37 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com> (Brandon Williams's
        message of "Wed, 13 Jun 2018 14:39:17 -0700")
Message-ID: <xmqqwouzycey.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v2:
> * issuing a want-ref line to a ref which doesn't exist is just ignored.
> * fixed some typos 

Do I lock some (logical) prerequisite changes?  On 2.18-rc2 they
apply cleanly but the series fails its own test.

t5703-upload-pack-ref-in-want.sh
expecting success:
        test-pkt-line pack >in <<-EOF &&
        command=fetch
        0001
        no-progress
        want-ref refs/heads/non-existent
        done
        0000
        EOF

        test_must_fail git serve --stateless-rpc 2>out <in &&
        grep "unknown ref" out

test_must_fail: command succeeded: git serve --stateless-rpc
not ok 3 - invalid want-ref line
