Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081A41FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 23:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932639AbdC1X6c (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 19:58:32 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33555 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932392AbdC1X6b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 19:58:31 -0400
Received: by mail-pg0-f44.google.com with SMTP id x125so368536pgb.0
        for <git@vger.kernel.org>; Tue, 28 Mar 2017 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aLmO968bZzya59lZiBZJZB9+Fs6qUQjmVHnEaqOHDo8=;
        b=FHWvDcsDE7mdD5wCXTfRHcr+XGaEy/6RzDzJkubWUFY2PWQ5PXHh0SnzAUr4p5th4X
         mfsUSMJFZZMJdF9BNwLUnQLI02XJkoXJ3vSr0s8Ma4wlLL8I78fEhdGESUE8soIZ22So
         SUZsjZk5NJDxHIr/4tdN2Xh2E/eEIWGmpBRYqe4Ly6sO+IyQBfdD7EISWYKD9Sg6sZvS
         NN6S27HLwZWU0fDQpzhwyyxrTbrHdS+t/EG1qRfQD9q0FLaT4KY43kMTknsoY8KXymGK
         vHQwGrvChYJNZrIB9BdU6kZ9Jh+2ZiSQpedcLZxjb4TFCxRdKRishkx5Abu287u6XHgc
         MOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aLmO968bZzya59lZiBZJZB9+Fs6qUQjmVHnEaqOHDo8=;
        b=P1q9VfgB/mNbOSVf60ow6QQD3TCt0xyLnHtLvd6QEKun6VZTzzQLDa9cP/ofbYPTxJ
         +OQn6qy7rWg8BwDRCd0KpSqGXiBkK0eb/8cfJZQH6xC1SsK3PxiOZ/h3YfS/Z2HbISY6
         9/bJ6Kp8inMHSIZl28CHwkeEphEGdh10LNtZ/kjfTl4C4xCYRAE1tVPmD+1rl4jFtyj3
         B0q38OR0Wy3q9ADKKEJwuJ27+bLJS/nHyl5fg7FAdyiIncRa0qN9hG6bnDDB9WzGpsqa
         cE3oVSIOjkoQQbcNXObt3vduLvO9bvnVJtytC5Ek+jgQaB81HH75h8Rz5OMTSnFcxc12
         dcqQ==
X-Gm-Message-State: AFeK/H1Q+8yodChocIpcGvEiWek+T1Dp0N8AVkzzPnI8SFZ8V2M8w1sjO36o1m9Hg4eT2OoXoqAPeNxfnevjPiKh
X-Received: by 10.99.119.140 with SMTP id s134mr32136180pgc.162.1490745509953;
 Tue, 28 Mar 2017 16:58:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Tue, 28 Mar 2017 16:58:29 -0700 (PDT)
In-Reply-To: <20170320223418.GB188475@google.com>
References: <20170314221100.24856-1-bmwill@google.com> <20170317172257.4690-1-bmwill@google.com>
 <20170317172257.4690-3-bmwill@google.com> <CAGZ79kZAZeb5rsL80dty_tRM5SDCAXVq_yATpDQREq_vV4Yj+Q@mail.gmail.com>
 <xmqq60j77lx3.fsf@gitster.mtv.corp.google.com> <20170317192103.GE110341@google.com>
 <xmqqy3w363yx.fsf@gitster.mtv.corp.google.com> <20170317210031.GA63813@google.com>
 <xmqqinn761f7.fsf@gitster.mtv.corp.google.com> <20170320223418.GB188475@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 28 Mar 2017 16:58:29 -0700
Message-ID: <CAGZ79kbCxhs82PD7wiB6UXh2=5k_EfnFYTZYqUs-FJU2WuxDxg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] setup: allow for prefix to be passed to git commands
To:     Brandon Williams <bmwill@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2017 at 3:34 PM, Brandon Williams <bmwill@google.com> wrote:
> That the gist of how I'm hoping to solve the problem.  Hopefully that was
> clear enough to get some feedback on.

Junio wrote in  "What's cooking in git.git (Mar 2017, #10; Fri, 24)"
> I saw no particular issues myself.  Do others find this series good
> (not just "meh--it is harmless" but I want to hear a positive "yes
> these are good changes")?

So I reviewed them again, and I think they are good to go.
As a followup we may want to consider this

diff --git a/setup.c b/setup.c
index 56cd68ba93..bdc294091a 100644
--- a/setup.c
+++ b/setup.c
@@ -944,6 +944,10 @@ const char *setup_git_directory_gently(int *nongit_ok)
         prefix = setup_git_directory_gently_1(nongit_ok);
         env_prefix = getenv(GIT_TOPLEVEL_PREFIX_ENVIRONMENT);

+        if (prefix && env_prefix)
+                die("BUG: can't invoke command in sub directory with %s set",
+                    GIT_TOPLEVEL_PREFIX_ENVIRONMENT);
+
         if (env_prefix)
                 prefix = env_prefix;
--

Thanks,
Stefan
