Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35F2202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 01:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755430AbdKOBli (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:41:38 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:45267 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754031AbdKOBlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:41:36 -0500
Received: by mail-io0-f175.google.com with SMTP id i38so11980292iod.2
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E+N34AMmvCblGRXihTVAeJfx5Q0Vk7rWoxeThhfQHXQ=;
        b=dVUKxpyDxNEFospYfzVyZ6AYHo2UlE7y4HUIq7UwBwIfk+8GVNkqPXSD1NG2m74H0L
         8KKJyTgiuqj/uPqAHM2kWzt5J37hoMgBXTqdcf8Qm8Mf083mzgW4G3yQGCVAjK4cJd0l
         hbGeBNz/5ENsqYVNHV2JaCcKiRgmx5xsV/jLWmMLsMnGELpTEq5Rtg31B+i0d+ZY4n/R
         Jpwsze4IvVDqUeoqUMe3t4iYnf/DzsNMFtrnt5waFyITpskSKsEAzxmDoEPLILJGrZ+V
         3cR/hhPeswZJexVo18rc6nJpynei8Xgl2gV1JF81AZ+9xNAazwsMUYZcQlFn8XQm37iz
         Jh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E+N34AMmvCblGRXihTVAeJfx5Q0Vk7rWoxeThhfQHXQ=;
        b=QCS2TbQAqugOz0p+mD4iLeA8bnYH9kJzSiK7JUteUL6l1UgY79f4GeSs/hArsrjXDc
         sg6g0aNjl57aLR+/kF10dU3tlbqvHPgSVzEO8jOSbG5KpMYND1YfXTWLWmuYeAcjGUtG
         CFu19+jRG/4/IXh67uDBSXW+7iusEj+Ajt1/kqAZIJrMKbppqwwJrP6LSQyxVU2p9ofH
         fnD8RSgzleOSclQc+mCDlfMB02tLJI2n4IjZOp8Wp+LV6rSBHi4SlWZFkcvkAltJto1T
         uPjf09jU52jckMFT/fdpsnqRb/3sekjC94dRdy4eHpof4ZmgZenDeAKGG2RRZVFdbKTu
         4IKA==
X-Gm-Message-State: AJaThX4snUCHe8+YiABGvY/ptzM8s4sVwtiufsuYP9xpw6MRjvyHmR7O
        s/1NAEC/BCW+pI47lq4GMGAAnA==
X-Google-Smtp-Source: AGs4zMabgVX4w4bqazpVN5A1fkmIz9pWrt07AxAQm2u7aYzEIZigUTMt2pPhAmjndSbqvn1swD30TQ==
X-Received: by 10.107.181.130 with SMTP id e124mr2585973iof.124.1510710096128;
        Tue, 14 Nov 2017 17:41:36 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:68e8:a345:46:2771])
        by smtp.gmail.com with ESMTPSA id q1sm6064339itc.9.2017.11.14.17.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 17:41:35 -0800 (PST)
Date:   Tue, 14 Nov 2017 17:41:34 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv4 5/7] builtin/describe.c: print debug statements
 earlier
Message-Id: <20171114174134.51c5a41788ecb5675b8d93f8@google.com>
In-Reply-To: <20171115003043.24080-6-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-6-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017 16:30:41 -0800
Stefan Beller <sbeller@google.com> wrote:

> For debuggers aid we'd want to print debug statements early, so
> introduce a new line in the debug output that describes the whole
> function, and then change the next debug output to describe why we
> need to search. Conveniently drop the arg from the second line;
> which will be useful in a follow up commit, that refactors the
> describe function.
> 
> This re-arrangement of debug printing is solely done for a better
> refactoring in the next commit, not to aid debugging git-describe,
> which is expected to have the same information readily available
> with the new prints.

This paragraph ("not to aid debugging") contradicts the previous one
("For debuggers aid").

Looking at this patch and the subsequent patches, I would write the
commit message like this:

    When debugging, print the received argument at the start of the
    function instead of in the middle. This ensures that the received
    argument is printed in all code paths, and also allows a subsequent
    refactoring to not need to move the "arg" parameter.

Also change the title to "print arg earlier when debugging" or something
like that.
