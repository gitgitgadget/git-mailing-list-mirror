Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF3C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F56206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHNUj4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:39:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35576 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUjz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:39:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id f1so9430472wro.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lXhWHGpr7qYr/qzWNR0nXBdVvK/3roIZP9Qcjw8YA5M=;
        b=pb5KKmu1tYRJhIhuzpLv9T0V5jqG2yBRCC8sQ0BGmVfbcrDZYR2ooGSsXrVmhqGsBL
         nxI7/slbLrmQymhXpjnOZ8MpcP7BUPjSM0qfM7Em4BU0XJv4EqDsT9Dc9570OKTFk3zy
         XuaGgBMVNI5WS1/dKg0eG42+Jm2UKN/pO6SecwJ0OFBwSk+tVeaC3Tr5FqnCbmT7j940
         45Pm+D5jPcrb/PLgWMsrZE8rWnz0Byocu74BOIAQp2KnjmfdNKtRxjKu1+5dqILkS6Ds
         +dmB/+uNUnTLnDZZUNkoLmE2zJSUrKf90H1keFOwCO9+01hpbtBTgRfQe954Tvh6N55r
         PYtA==
X-Gm-Message-State: AOAM531XtG2NZ4KjUIfEzPjQZ+5jDuROxUxZDOaHtRNWclzeOu1Tncd1
        oqymT77eBokENSIh30tDtjhOKvFzCD62cXn496A=
X-Google-Smtp-Source: ABdhPJznAr5q0ilua+e+ZdCl3sPw67nO6RVCs8Zq5jzCS/tpjEtA/55yf8e8jw6tbNpmhiV9SiEpB5LeEu6//YbYf4M=
X-Received: by 2002:adf:fc45:: with SMTP id e5mr4425417wrs.226.1597437594272;
 Fri, 14 Aug 2020 13:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.703.git.1597428440.gitgitgadget@gmail.com> <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
In-Reply-To: <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 14 Aug 2020 16:39:43 -0400
Message-ID: <CAPig+cQLR1=6W-Y1y1XiWg1pC9FKikpqVsMrDKeK=exLJFDgLg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/README: document GIT_TEST_DEFAULT_HASH
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 14, 2020 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/t/README b/t/README
> @@ -421,6 +421,9 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true> +GIT_TEST_DEFAULT_HASH=<sha1|sha256> specifies which hash algorithm to use
> +in the test scripts.

Nit: The documentation for all the other environment variables has the
form `GIT_VAR=<generic-value-indicator>` rather than placing the
possible literal values within the angle brackets. So, perhaps this
can be written as:

    GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm
    to use in the test scripts. Recognized values for <hash-algo> are
    "sha1" and "sha256".
