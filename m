Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183CA203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 16:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbdGXQNa (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 12:13:30 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:38040 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932135AbdGXQNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 12:13:25 -0400
Received: by mail-pg0-f51.google.com with SMTP id s4so58972859pgr.5
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cz4NO9G+jyIpH3PfmW6lKzX+hsFfnQfyy1R7aXPp5sY=;
        b=kFeMNMa+qsVZ5eL4K/3Mn+OIwWmOq5viWs5fXyHw1szAOb2tdkRHJsjaZCsdk4z334
         pJ+LB/ROFZa5erZy3KBeQk7YIz8ortHJl6D5kEXWrsALHvMSbeEi7p7jE28KiFeGwjcW
         5nJ6CTvtSUCbA7laDCCFyRjsCSwMEHy3erZ4y7IASsiLRChXrgvnMVEBYIzjtDBKHeal
         U3tjmx6P5J10sgY0eplbq01WIRi/iIaGKWJJ9KVHzFKl4zDVJBk5khRLiJ+xdUQBKzZr
         u5MkMNWqi2anaDlbaFOFKi8HFM/KslgmYBhewlq//Fh/aAz7+bMN5L0n5ILjEUewUB7s
         EGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cz4NO9G+jyIpH3PfmW6lKzX+hsFfnQfyy1R7aXPp5sY=;
        b=f6HMFNwArsQBeynklgVHm0Kjb2mwsyW0vgr7WZtBihqQ7y+2veWkdbMPNDIs9nfIW7
         g8WTdQyhp80vMAb5TLF0apVaKSzp8isd0GSd/zGKsi5bzTXjPGTzuj27mvM0cQoiX7pI
         ckbZG7Sb6oyYUQht5zwlxHzbMUlacNXnS5BfILPFrxt+7LQf4tIkoZrYrd5asUsxVgJA
         wCr0DRYrQ1OBd2y45DslaL90ODsBObDuHIUn4Y2vyE68PfHlDMxWkha8GcMq6C9UNcTL
         FyP6yTjVJmU8rjMqUV5GvJKUQrC014BbYjcpvn6RgSuM+TWZZkKzM9FNt8kiubJk6ZWe
         F4rQ==
X-Gm-Message-State: AIVw111wpmpxWvFr5Rjpe+JeCKhpgY+CTlWI6tOEKXVkaAOs/rwsH6Sj
        TPe5wPNc1PnL/ZCn
X-Received: by 10.99.98.134 with SMTP id w128mr16875127pgb.362.1500912804597;
        Mon, 24 Jul 2017 09:13:24 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:4dd6:bfc8:8c58:4bc7])
        by smtp.gmail.com with ESMTPSA id t78sm24389272pfa.48.2017.07.24.09.13.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 09:13:24 -0700 (PDT)
Date:   Mon, 24 Jul 2017 09:13:19 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Orgad Shaneh <orgads@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: fetch-any-blob / ref-in-want proposal
Message-ID: <20170724091319.6818819d@twelve2.svl.corp.google.com>
In-Reply-To: <CAGHpTBLzN2g_ZXP4G6Eo5yZrvK_bB8KjBiSZ-Nc5JHNTRzv8qA@mail.gmail.com>
References: <CAGHpTBLzN2g_ZXP4G6Eo5yZrvK_bB8KjBiSZ-Nc5JHNTRzv8qA@mail.gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 23 Jul 2017 09:41:50 +0300
Orgad Shaneh <orgads@gmail.com> wrote:

> Hi,
> 
> Jonathan Tan proposed a design and a patch series for requesting a
> specific ref on fetch 4 months ago[1].
> 
> Is there any progress with this?
> 
> - Orgad
> 
> [1] https://public-inbox.org/git/ffd92ad9-39fe-c76b-178d-6e3d6a425037@google.com/

Do you mean requesting a specific blob (as referenced by your link)? If yes, it is still being discussed. One such discussion is here: [1]

If you mean ref-in-want, I don't recall anything being done since then.

[1] https://public-inbox.org/git/cover.1499800530.git.jonathantanmy@google.com/
