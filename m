Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C817EC433E0
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3E920658
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 23:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgGZX5J (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:57:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33239 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgGZX5J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 19:57:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id f18so13109946wrs.0
        for <git@vger.kernel.org>; Sun, 26 Jul 2020 16:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ru8g47N7oFZTuB1ih/nTWrobwBKH5QMydf1boCJZWNs=;
        b=ZNHY4YUPwsyHCHYSBwC25kFe6RFKUzQxFTCnEMczo9yEJabfK5oYQ06k4zVfsXVDxI
         Yg0uZMQ7jFRM3TRYsZ1hXCZCTtgrO7F3uQHHwdG1X8GU3Q9++GWEE4xI62y1vd48See/
         8nFsok67F6KRJjwUnuq8hEMtVB51sT4GW42aQl2vJM3qyk7QuXJqyamVoV25/sdHDfY4
         +cjIbQSGFnxqV7cybIj3JatkgmxXPVkRXi+GaMHplWjNfmQLPSFHWIIQTD7tcCBY94B1
         /XozU9RE+l1mIFwMuBUX1oW78LKF6pE7AZIiHH8tWePSQM+ExZaR67OXPLfvDAp6tj5y
         pXuQ==
X-Gm-Message-State: AOAM531k83boKUlM1UaUWI9rhoCDCr6JlF6xUiRfmbfD17iugSzuNPAd
        Q5GbkCCUWftqrZRXcxaKcf1MVwFdvPU1EKe5CLg=
X-Google-Smtp-Source: ABdhPJyL8fX1Ok4XkQgyab6mTp9AoQRyRCX+wjvRUiT0R9wN/LVY+0JGwYkJIKQ0OnkfAWCoszR2ksmK3iPQThWr/tw=
X-Received: by 2002:adf:8061:: with SMTP id 88mr8970782wrk.277.1595807827880;
 Sun, 26 Jul 2020 16:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200726195424.626969-1-sandals@crustytoothpaste.net> <20200726195424.626969-39-sandals@crustytoothpaste.net>
In-Reply-To: <20200726195424.626969-39-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 26 Jul 2020 19:56:57 -0400
Message-ID: <CAPig+cRQN_JWEd-EZchDaa-BSeDynx_+b+h9SJ1o6MFS3DQ+JA@mail.gmail.com>
Subject: Re: [PATCH v4 38/39] docs: add documentation for extensions.objectFormat
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 26, 2020 at 3:56 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Document the extensions.objectFormat config setting.  Warn users not to
> modify it themselves.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/config/extensions.txt b/Documentation/config/extensions.txt
> @@ -0,0 +1,8 @@
> +extensions.objectFormat::
> +       Specify the hash algorithm to use.  The acceptable values are `sha1` and
> +       `sha256`.  If not specified, `sha1` is assumed.  It is an error to specify
> +       this key unless `core.repositoryformatversion` is 1.

Since this is user-facing, I think we'd want to write it in camelCase:

    this key unless `core.repositoryFormatVersion` is 1.
