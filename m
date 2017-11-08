Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 205B51F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 20:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdKHUgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 15:36:03 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:44054 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdKHUgC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 15:36:02 -0500
Received: by mail-qk0-f177.google.com with SMTP id v137so5052070qkb.1
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 12:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BPmglLIB/r9do3j4ouVKl9Vxr6pKO8M/alix2pZ22M0=;
        b=DE5vS95g1TTUFVVwlfug97J1Fg7aPi0JqKiVbPQTTohaO1yGzyXfR5yq2TBWsdG7BU
         XD/zTQZn+u6+yjkNDinTqUCD+3DCjv2n2e8onuUMUBod+LnNhsq+olBplJllWx/1lfA2
         atq1M2yaJWcitz+jVVzvp79vmifg8TdJr51cRgrrtF/0Tt3OhykV8rzu1Trlvw69RtrO
         roL/jr/nmycKF/CZ4quXk+Bz+WnebLtw6NLHZBWTkTRrzDYJ14tEsTuNggm+MhRQgfib
         llXcDl5R/i9t2bFg7kN5b/oa16L5wfOAoEuFjfj4OQBESLO0mEsTBfK3oAJLBns3Qr4v
         dyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BPmglLIB/r9do3j4ouVKl9Vxr6pKO8M/alix2pZ22M0=;
        b=d1p0jAW5E+T/G2VxBS5sxqmPYScxdIWCh3hg20hL5JEkkgQzD66g3Kjm3LgPDuM6RM
         YS6T/y6ntiI/cgFU5Z/ZQJzjt0qy8CG9WI2zs9C4GS76NIbLEL9l3M65Li1TjVG3kY/a
         ZrGT9bRF+1vqbR/P0gpCg/KwR6CXWEEhtwygyz0V1bTFe2NKTSTd361wBiDvFwYm3kPH
         yFpuuKFh21IqjxK58BeOyIweU3FJdZ8/OOQzBSDAZVacktJ/h6DuspJTk94aBQK3WY/N
         YsvLU4AP/1HRrvaMfIK54NZnKqmp4K50WOY0ZenguFBX6uqjEipE/fnAJdqj9e99B0z6
         817w==
X-Gm-Message-State: AJaThX6CBPVFd8G6sa4G+W9g3Sf6QtlZ+lpEvdJKsF7eQWum73iX0Nse
        5zyaLGeVk+uIltzJtIMJSBVCZpu7qQ8qIKkDZnpn7g==
X-Google-Smtp-Source: AGs4zMZacZQ1c4wI+XT6CotHlKv3+vi7xkojvzL7UO718B+nsykfC2pL61KcGb1K9fzSal+hsxIGlC+4FhTnbYdDp4o=
X-Received: by 10.55.111.3 with SMTP id k3mr2728609qkc.332.1510173362122; Wed,
 08 Nov 2017 12:36:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Wed, 8 Nov 2017 12:36:01 -0800 (PST)
In-Reply-To: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
References: <cf38b57d-1424-0776-b67f-8cfd24e087bb@ramsayjones.plus.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Nov 2017 12:36:01 -0800
Message-ID: <CAGZ79kb3NpuWW=BpTjF_DrdVhXHh3d_8aF77Jdpi+8yTxtAbVw@mail.gmail.com>
Subject: Re: Test failures on 'pu' branch
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 12:28 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

> t5300-pack-object.sh                             (Wstat: 256 Tests: 40 Failed: 2)

> t5500-fetch-pack.sh                              (Wstat: 256 Tests: 355 Failed: 6)

These are series

> t5601-clone.sh                                   (Wstat: 256 Tests: 102 Failed: 4)

This one is a spurious test. I had that flake on me once in the last weeks, too.
But upon investigation I could not reproduce.
See https://public-inbox.org/git/xmqq376ipdpx.fsf@gitster.mtv.corp.google.com/
