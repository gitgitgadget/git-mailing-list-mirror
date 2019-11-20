Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6802AC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C522243F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 00:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKTAUl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 19:20:41 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37364 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727298AbfKTAUl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 19:20:41 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so5922000wmj.2
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 16:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxVJ+ddGG4tVMnzw8Td0Dpbx1MKo393ptfwMKsg29rc=;
        b=aj6lfkaPoJsxm27woWUxhf0C+bm/D5+zq9rKV7tpl2lBiPkeWbVR+J3uDl2TWK0LXe
         xih5+IaGwq/nXHGXfd2ZivsAsWzFzLZujHznvDjGtDIg3T2N9p4JrdmkWWtK6IAxgf+9
         4UOcPd3PQWN//knR1n9YvVOByAW2OmfRio2rXU0ACxxZPJ2uf34Do46hf/0icAZKhe86
         VXOb7PRTt4gLhfONgQ3A7FLp/qtSjKO1lh4NB+aomS6o+AQ38uyNexHGt4fYjpS7jjlw
         dg67UuAhnogNN95c9nS/ogXrJiflDJZWFFfI52kCdJZvMVXRZwqDYQTnPak4AyQ8Ubkn
         KE+A==
X-Gm-Message-State: APjAAAWfOa00DTwGljG/fNHidF7A9MVE6Ga4RpPNe7+KNV6bYBNDJ2je
        6c+YXJNxPU0Rj0sKlTk/W9eh0Gw9MTC67HK/05wjSQ==
X-Google-Smtp-Source: APXvYqwRqe7Hr2Cffj8OTBSJQBqVgzbPyxoVZGqetCzrr0FjNnqk/DmaKRHrX1k2BeaWOrptYbetuWDDfCin9BwgGNs=
X-Received: by 2002:a1c:3cc4:: with SMTP id j187mr74741wma.95.1574209237283;
 Tue, 19 Nov 2019 16:20:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574125554.git.liu.denton@gmail.com> <cover.1574207673.git.liu.denton@gmail.com>
 <16a90b70638b100afe4b7d68c0db20ffae7ce964.1574207673.git.liu.denton@gmail.com>
In-Reply-To: <16a90b70638b100afe4b7d68c0db20ffae7ce964.1574207673.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Nov 2019 19:20:26 -0500
Message-ID: <CAPig+cRnbnj3-ZjXiRkHU8JNREo1qCvbV9AYcq0TdUcQ8i4VhA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] t3206: remove spaces after redirect operators
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 19, 2019 at 6:55 PM Denton Liu <liu.denton@gmail.com> wrote:
> For shell scripts, the usual convention is for there to be no space
> after redirection operators, (e.g. `>file`, not `> file`). Remove the
> one instance of this.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> @@ -8,7 +8,7 @@ test_description='range-diff tests'
>  test_expect_success 'setup' '
> -       git fast-import < "$TEST_DIRECTORY"/t3206/history.export &&
> +       git fast-import <"$TEST_DIRECTORY"/t3206/history.export &&
>         test_oid_cache <<-EOF
>         # topic
>         t1 sha1:4de457d

While you're here cleaning style problems, you could also change this
here-doc from -EOF to -\EOF. (This is the only here-doc in this script
which can use -\EOF; all the others need -EOF.)
