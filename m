Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96B151FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 17:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbdFMRPl (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 13:15:41 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36526 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753217AbdFMRPh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 13:15:37 -0400
Received: by mail-pf0-f171.google.com with SMTP id x63so70895249pff.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 10:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ldn9q1i6oFEK4an2LDHpyfzUWuHrj4IJr+6A4eREr/E=;
        b=aN7UV2HqhjHQI+A8aXD9L4ZwXY/Ew1tev9AGn9OVAn5rLmPdBzbmIWgNSrxujHAPH2
         58NwKXleqbOvV3JZJAs6Gg9dCIucFmEqRggzgcI8/+q6EK4wOQbVNODE+zVSRL4fJEXb
         WLoVvQHOGPCgc5ei9HCZ0cZnQGZ5Bm2+YFPH3JnwZ1fWFSiZlX1OCTNX3b2AIVq72M6m
         3EWd+gN7nSmDtIcV2m5KH7BUCYrMxfPMkxZUi0JvM+p3lVz0FyQGus5KzZHXp/PZQu0D
         4rACC1rlT38EJ+JrUqlUm+hLFDYqyY3j5FN4JNwB8mw8BcyGokBd3XSgfTxBrEnmYsP3
         eD2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ldn9q1i6oFEK4an2LDHpyfzUWuHrj4IJr+6A4eREr/E=;
        b=t40MWUhRqCdW7ZPyRPwcV7kFYF+6lAE56Mise90CzHfxyw7Vd7U1zKSQh7IxbV1D6Q
         rRz/oz8vqKUaedTzmSKV5M01hmwlRpkN8TfbAW4SNB67+wvQhFZKi0+GU6KOfEUUtrEO
         WwUJrIcYpQ9siM7qW1nzIZosifCMlAWH2WFLGjiOraf8/dSsX4RmDdtXgRL+ypTSiZMS
         DOWrxgTlLneUXe+VQXgc4q2ov/6HRSvQYFmtSwTgi5yjWWAIAoN2kJl7ap661xt/iwO8
         HoG3koNbt3X1PQtssybdCidBNd0o2PeeVe4YT9ouCPn+GulTdBPHwdhkkAq+fjzFBcbJ
         Pp+Q==
X-Gm-Message-State: AKS2vOxtF299ybDe4BQG0CKW1oeSBmaqWm70SL4zC+CupHiEyLpNIF/A
        LgF6S93rwe5grzCB5YsSrdyqByspe2u6
X-Received: by 10.98.68.156 with SMTP id m28mr632140pfi.48.1497374136778; Tue,
 13 Jun 2017 10:15:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 10:15:36 -0700 (PDT)
In-Reply-To: <20170613092419.hzrtbn2jvykoxsry@sigill.intra.peff.net>
References: <20170613091452.ew2rwx5r6axxo65p@sigill.intra.peff.net> <20170613092419.hzrtbn2jvykoxsry@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 10:15:36 -0700
Message-ID: <CAGZ79kaHXwEBJN-D6u+Zj4-Df-tMKBHz3S2uuOuH9mH5b6jd_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] t: move "git add submodule" into test blocks
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 2:24 AM, Jeff King <peff@peff.net> wrote:
> Some submodule tests do some setup outside of a test_expect
> block. This is bad because we won't actually check the
> outcome of those commands. But it's doubly so because "git
> add submodule" now produces a warning to stderr, which is
> not suppressed by the test scripts in non-verbose mode.

Makes sense.

> This patch does the minimal to fix the annoying warnings.
> All three of these scripts could use more cleanup of related
> setup.

agreed.

>
> Signed-off-by: Jeff King <peff@peff.net>

Reviewed-by: Stefan Beller <sbeller@google.com>
