Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CA371F453
	for <e@80x24.org>; Tue, 25 Sep 2018 21:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeIZDfj (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 23:35:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33321 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbeIZDfi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 23:35:38 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so3793529wrs.0
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=VQrD0DK11H/6MQyMz4OHr6dfpBmq+dzb0CFF70bUw7U=;
        b=M8NZ5DtGlKodyNAC25l3GntWcAxyQ0OZHqzEYjfRg3z9ahqM1PrjXVdLQQbAnvqFZQ
         UAsoELPh80TZyudWl5EbIzUBKVAGU9+8FldWcPB4j9nsbdHE5RfgiEUjk2KZQ7HNgfYI
         reICXrOZJtKMu2YP0BB7pqLRJMNhiUsS9YMqB/iUfF8byPeZaZ6d9YX7JHLiIj6KsVGv
         wX7nM7GayJETy7hoghXX7sc83ZTFg+3jbq3V3d7Y5+GLiOdv+wkTJNRZXDRtD9SaKBHe
         Yx6sE+g0I5tW5JG4mtdLNfk/p3deId2n5/Ev3/ZDLSUKrQ/STGXVN5ZWoz/wtXrwqHbL
         1zhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=VQrD0DK11H/6MQyMz4OHr6dfpBmq+dzb0CFF70bUw7U=;
        b=tFEO5hG8/+7jyN+tS1+oEQKxYst5IWD+zbdCVCg7R4SJZlur8CLpaKHPFs1kz8dxNd
         b8cxxlC8RBRv8+KVTfSYeNsAXD0z81yf1SZ6Sp7Vu8UxBiCsRf38TtJlVJhaSzWbFB3o
         lWhK2m46hlZMfr2tIgLjkhGfwPmQBuNaw/tU6C6U5i3rKJBjOOVkbQtwJhO1JcNQ6y1C
         qoq5dNradMxnt4vvnmVhRs0yvFLsQA6R33RxOFrc4HyQVA64k/DaODE4zo2hApJ3yiXr
         0AJGI3jH8aW4MAEAUl1bQEQS1B7xmfTN5sG8xVfK+ZEgW5KMlvev9uGvt+pAFukePR/t
         ighg==
X-Gm-Message-State: ABuFfoiZDoM7L46i7iPVuGMEap+wiTfGRfEsMmvhahPkBE9aMIp2ipOr
        hyU8SUDd+5yXns+JBja2MQ0=
X-Google-Smtp-Source: ACcGV62E/+b/fW8trEK2Cd+3aMEoZlxlTfBdUge0URYRPceJTd9Yp9F2NSnIyTpv71SCIDmVf3/Ddg==
X-Received: by 2002:adf:9227:: with SMTP id 36-v6mr2600306wrj.275.1537910765345;
        Tue, 25 Sep 2018 14:26:05 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j133-v6sm5230812wmd.12.2018.09.25.14.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 14:26:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] worktree: add per-worktree config files
References: <20180923170438.23610-1-pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 14:26:04 -0700
In-Reply-To: <20180923170438.23610-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 23 Sep 2018 19:04:38 +0200")
Message-ID: <xmqqtvmdnuab.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> This extension is most useful in multiple worktree setup because you
> now have an option to store per-worktree config (which is either
> .git/config.worktree for main worktree, or
> .git/worktrees/xx/config.worktree for linked ones).

Heh.  "This is useful if you have multiple" is true without saying,
because this is totally useless if you have only a single worktree.
I'd suggest writing the above without "most useful".

> This design places a bet on the assumption that the majority of config
> variables are shared so it is the default mode. A safer move would be
> default writes go to per-worktree file, so that accidental changes are
> isolated.

Warning: devil's advocate mode on.

Done in either way, this will confuse the users.  What is the reason
why people are led to think it is a good idea to use multiple
worktrees, even when they need different settings?  What do they
want out of "multiple worktrees linked to a single repository" as
opposed to just a simple "as many clones as necessary"?  Reduced
disk footprint?  Is there a better way to achieve that without the
downside of multiple worktrees (e.g. configuration need to be
uniform)?

> (*) "git config --worktree" points back to "config" file when this
>     extension is not present so that it works in any setup.

Shouldn't it barf and error out instead?  A user who hasn't enabled
the extension uses --worktree option and misled to believe that the
setting affects only a single worktree, even though the change is
made globally---that does not sound like a great end-user experience.
