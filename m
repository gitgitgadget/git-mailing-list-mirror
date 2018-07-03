Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44F451F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 21:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeGCVNL (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 17:13:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34933 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752466AbeGCVNK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 17:13:10 -0400
Received: by mail-wr0-f194.google.com with SMTP id h40-v6so3277698wrh.2
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fO2DOvXG6ow2thLFQn9FmuG7cHt9e1DwFBO4uYbOXNc=;
        b=HYp6zCaHPsqCZnjs86WZH+GUbhILN7g1nnesWo/9AasyZeg9OCndBVjlgGwHbIdVp2
         eIeDpWrr4BIFxOZt5WcbsvfzCDZw2s2/LYGm6ewkw3/vI/7hcDGX0cT2HPLZgLmkw7p1
         mq/xGUrvT23GYZVhP0Tdt3c51nqhgEXtzIkXzeIAYwxtwtoOGaJZ0P4+h3RQjeCNClCf
         UuwWnAKVgTI4VdKGQYi+4GRecEG/FKi6pVqEnha88vacRpLrZwf+WtqhiOpzlxshQs0z
         BX83ZLhtBLpcVeX17m8AY8LEInBPpctL68Aom8ngmD9uOpcXTrNRs4ecbc9bhlTudw2p
         sU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fO2DOvXG6ow2thLFQn9FmuG7cHt9e1DwFBO4uYbOXNc=;
        b=izxyVXGBSRL5QcBjIQnz5m00/d+2GE2htQgaYx49euszpTRe0EDSSFJiRBgHINhFCW
         5yvesQKlGVJpG7Ew17s78BRtOGzOSJRcjbWHfKHemWXaeDhwFh9dJUt4/K/BokbjpG+R
         iKCA5FUzKWN9J7UdI/BS5fk61wU71/GNUJoIrZ1J7bW3CE3s9q7C+gulhk6LHxrL8jcn
         h0EXK3i7sMASllJi4THNd6JdLSyXzQ3EKfJz0P0SX/qSQVl5miaSRVlvNwT8B2+1S9yo
         XF4OP0IaaLU+sILWzBqAQ1SdCebrCgLkJKlOe+UQCiTf2TGUjM9eg9/JXEjyAuZv3xh5
         Yi7Q==
X-Gm-Message-State: APt69E3rGeN5i8Vw1gZ2NeF2+hgLpfI4mqD26WnAzlyjkgQFRxpq1P1y
        W66qOfVdIM2ZL2UFTc7N/vs=
X-Google-Smtp-Source: AAOMgpdiShavbhvzpFiOUB8sAhyW5FG+I6mkSlk3m+XNncMfJNpXZpO9JUn1nEkSx60wYk/DDV8SZA==
X-Received: by 2002:adf:9485:: with SMTP id 5-v6mr19101262wrr.82.1530652389091;
        Tue, 03 Jul 2018 14:13:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u7-v6sm4489008wmd.3.2018.07.03.14.13.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 14:13:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH v2 2/4] rebase: refactor common shell functions into their own file
References: <20180628074655.5756-1-predatoramigo@gmail.com>
        <20180702091509.15950-1-predatoramigo@gmail.com>
        <20180702091509.15950-3-predatoramigo@gmail.com>
Date:   Tue, 03 Jul 2018 14:13:08 -0700
In-Reply-To: <20180702091509.15950-3-predatoramigo@gmail.com> (Pratik Karki's
        message of "Mon, 2 Jul 2018 15:00:07 +0545")
Message-ID: <xmqqr2kknhuj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratik Karki <predatoramigo@gmail.com> writes:

> The function present in `git-legacy-rebase.sh` are used by backends
> so, this refactor tries to extract the functions out so that, the
> `git-legacy-rebase.sh` can be retired easily as the
> `git-rebase--common.sh` will provide the functions for now.

Makes sense.
