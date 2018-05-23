Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC041F51C
	for <e@80x24.org>; Wed, 23 May 2018 06:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753918AbeEWGIp (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 02:08:45 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38841 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbeEWGIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 May 2018 02:08:44 -0400
Received: by mail-wr0-f193.google.com with SMTP id 94-v6so24129269wrf.5
        for <git@vger.kernel.org>; Tue, 22 May 2018 23:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nPqoYqDZvTrN5DbZOnPt58O5FqSx9rj9eJ9EHYNUCpw=;
        b=S2GXtAJyx+ypBihYCjdqkF6HHy17ewW6TJ75K8epOL6RU8QQvHowdySuYg9NqgnnJS
         d3vbjOIpliCm8t1nO5kqQTYJ+SNVD5IIYgi88z6Y4vsP+9ZNvOy3McGM8O9FAtU3BdG8
         9BjE+xUTReSSfBNKELO994zcBRgg67O315DZXQ+1UXudofkiGuxHlJVD4hekk5psHqsO
         KvU07p1TFYDiATtHNKWZhHcRr3EOsf9sZNiOQsVGKuIt/V4iRWnfA6995tTBeEKjRBzA
         Z3TVO7kDWO82b0DyBN3vu3YLJiBUhBnG8f4u1lvPA5IY7+5PEU4yPp+Ce/j7Y5WJkWuW
         Ktkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nPqoYqDZvTrN5DbZOnPt58O5FqSx9rj9eJ9EHYNUCpw=;
        b=NwoGjDiK3mjNYWCm5jt1J0NuUhQ6R+lLcp/r3b4oxE+F9ZoejygNb+nOalus7tW35m
         9AtEUZ5SBpoZ+oX7n2BnAk0fO8RXDA2YQXyyn6LBFD/gwFCualaVQkA+5MiUBVTVi+Mn
         AxanGNZCAh+DYvU9O35w6rtSzlbMtNy5iLQNvynuA/91EajWMZjFkD9u27Apa5eA8k0N
         O0sPWMAbzvJfBB+QwBYPM/q1G8sMocGPYMpeZkzIZiq8epDe6LIxybUQt3v7/O+BPY7b
         QjcbKn/ErNrCEh8fwtOUXGEpj4+AUhUne3GzMNgYhA+YgoAnu5yvHHJhrdGgLLEGh4X3
         nFEA==
X-Gm-Message-State: ALKqPwdnl5rPIItZKA4p9IdW4IDAyLg1r2IyrFP/Eh1ciex5pUH4zcil
        Fg0mV8Qo+o9LrImU00t1d68=
X-Google-Smtp-Source: AB8JxZpiq+46mlqRkeDeF3eFQ3602X7NLY4d9LsQLuNITaZ3oxJjOInBcRdhTls27K1aXp2jnwbneQ==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr1171397wrc.56.1527055723278;
        Tue, 22 May 2018 23:08:43 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e80-v6sm1677573wmd.1.2018.05.22.23.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 May 2018 23:08:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
References: <20180523052517.4443-1-chriscool@tuxfamily.org>
Date:   Wed, 23 May 2018 15:08:42 +0900
In-Reply-To: <20180523052517.4443-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Wed, 23 May 2018 07:25:17 +0200")
Message-ID: <xmqqo9h6vr85.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> The internals of the loose refs backend are still tested in
> t1400-update-ref.sh, whereas the tests changed in this patch focus
> on testing other aspects.
>
> This patch just takes care of many low hanging fruits. It does not
> try to completely solves the issue.

Thanks.  All conversions in this patch look correct to me.

Will queue.
