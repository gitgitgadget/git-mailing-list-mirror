Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87DB51F576
	for <e@80x24.org>; Sun, 21 Jan 2018 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751347AbeAUSzY (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 13:55:24 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38977 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbeAUSzX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jan 2018 13:55:23 -0500
Received: by mail-wm0-f44.google.com with SMTP id b21so12765336wme.4
        for <git@vger.kernel.org>; Sun, 21 Jan 2018 10:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=B6rxj9SVHq2yFqx5hWtP0XBhY4GC5XxBvtCDHQlcDFE=;
        b=G1fUy0v91JQqErVWcDd7liMEgfxLWMHbQYtPLEFIbL9rrtlBy/xvXxAGtdWjT39Z5C
         AXOD+LhDzjveV19MTCfX8lo4Q7kdXgzgmv7MI3Vs0LTutNHZBXIp4BS9moIAFQfkNWZt
         KjNNiny6esrpokb1Ds7OlnBOHT+NrMFPDbEEJoI/txxBvvCfpGJIHaPndP5IfBxdh2GO
         c7TGql410sQyk0zGHVxhJ1fA9MOIErvKsgljHfe/zoY7qSyF9xYjKh/UDo3SaPyb7ADY
         7ik1UeI85UFsCjAyOx9HS8KB8XokQdmuxHw5RL8rt9+Jq5+EgFBnyP/12VuJcq9BnvKU
         eByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=B6rxj9SVHq2yFqx5hWtP0XBhY4GC5XxBvtCDHQlcDFE=;
        b=oIAuAqSFnQAoW5yvlQEVxigRskeIWWdSzjz4LzoNzu1oXWvT0gTJQ899HoMlApSMi/
         6TGrj8Z7L5GzCxE6Mzxzk6sfvPUXxGGphlKHq5B1J7ajEWHR2GkU022zBjVrvyow2Rg/
         nLm9FwYFKu96/BwFVKUnd8DUxOyMawSOMOznSebl9ki8Qe4o+9dgC7SEC6/OLsHV9DWA
         rKgUAhgvbqrFnos64Bjq1fcRHN8OyioRV7TpNqYzcjV8lGo+9z8NlyEKhlFgpraIs8rk
         3DbFjNyKUGlbutwiZH+w5BWEC6vFyFr4D7DWpUxiTZNfzDK2FMqwX8RPyfBg/vGQmWCl
         k92A==
X-Gm-Message-State: AKwxytfK1798NDoWa0BQ1KDtDhwGzDxSD4kxtcqwRxUD0sC6/Hgwp2pd
        XAA22+0CBACS9U7W2XuCzH0=
X-Google-Smtp-Source: AH8x2264MiFw4EQXNKa4AOGt+yCoBFeWhrkYrZCygFKDNXF8Uccn1ZD4i+itL5NgiYVW4qVdZUJQ6Q==
X-Received: by 10.80.214.8 with SMTP id x8mr9817570edi.129.1516560922419;
        Sun, 21 Jan 2018 10:55:22 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id u4sm8924397edc.91.2018.01.21.10.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jan 2018 10:55:21 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cheng <johnlicheng@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: cygwin git and golang: how @{u} is handled
References: <CAJzZBAQuOqwRmBLOdUEVMY74_xT2dWe3a+9qT9ufc4bp8gjgig@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAJzZBAQuOqwRmBLOdUEVMY74_xT2dWe3a+9qT9ufc4bp8gjgig@mail.gmail.com>
Date:   Sun, 21 Jan 2018 19:55:19 +0100
Message-ID: <87372zhwiw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 21 2018, John Cheng jotted:

> Actual result:
> Suppose that cygwin git is specified, the result becomes:
> exit status 128 fatal: ambiguous argument '@u': unknown revision or
> path not in the working tree.

Given that:

    $ git log @{x}
    fatal: ambiguous argument '@{x}': unknown revision or path not in the working tree.

Spews the output back at you as @{x} not @x the problem must be in
whatever is passing the argument to git, whether that's go or some other
wrapper.

Try putting a "git" first in your $PATH which is nothing but:

    #!/bin/sh
    echo "args: $@"
    exit 1

And seeing what you get.
