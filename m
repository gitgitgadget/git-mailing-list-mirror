Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F7CC33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF302083E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 21:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgAQVPZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:15:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42467 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQVPZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 16:15:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so23940926wro.9
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 13:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpZX5wbJ2wSQjWV+qMVYWZ6D963k6XV0iPn0/CEjecU=;
        b=KIJ9deYFkaZswkpt5/3DuePEO0dVDDC7AXalLce0tllzY0hKnC1z2oyDNmon7N4FUt
         y1vKgepqBCo7eCGF+0UQUOa5sdMVaTmOdcXNaFr53dhiU7CSkEARdVGgVPFSjIEp/4oj
         ehBk+wKbG02meJCkbVjWWGOzD+Gl5xXbUEJ6uG6WLUUoXECt2bFAbbKDj7XAiBqEtkjS
         246iYiVuYvFKEo4/z0DM9yn2np0P4H8lt76rXZrqaDplui7duaKYt3DfHVUnkRJu/vRT
         d3at+PWy83RMX7XW2/th54XPnpwSetmM4HSCFk256NUajVB4k5UupjNgZXO31AB0v3At
         ZKeQ==
X-Gm-Message-State: APjAAAWFABw6pmzNKA2Txqhj8wib/Y2q0clIDwqhD3DA7uN5Cg4rLP2K
        sj1e5KeuqQjfsFxlYlSZPTsBMZ9XAyraXEuHG0o=
X-Google-Smtp-Source: APXvYqx0+EEJ+VvrTkoSxKxwV485ZkajYUEKrT7z4pwGDjTQXYjuRpxTfcfGB1wgh+g/lx7a9l/oiSzj6d8AE5BSUK0=
X-Received: by 2002:a5d:534b:: with SMTP id t11mr5048747wrv.120.1579295722979;
 Fri, 17 Jan 2020 13:15:22 -0800 (PST)
MIME-Version: 1.0
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com> <20200117204426.9347-1-shouryashukla.oo@gmail.com>
 <20200117204426.9347-2-shouryashukla.oo@gmail.com>
In-Reply-To: <20200117204426.9347-2-shouryashukla.oo@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Jan 2020 16:15:12 -0500
Message-ID: <CAPig+cTW4hATiMYVE7kzcLqK3do9=K8X0nmYjWLOhabgOxZ-XA@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6025: modernize style
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 3:45 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
> [PATCH 1/3] t6025: modernize style

When sending a new version of a patch series, indicate this via
"[PATCH v2 1/3]", for instance. The -v option of "git format-patch"
can help automate this for you.

> The tests in `t6025-merge-symlinks.sh` were written a long time ago, and
> has a lot of style violations, including the mixed-use of tabs and spaces,
> missing indentations, and other shell script style violations. Update it to
> match the CodingGuidelines.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
> diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
> @@ -10,52 +10,55 @@ if core.symlinks is false.'
> +test_expect_success 'setup' '
> +       git config core.symlinks false &&
> +       >file &&
> +       git add file &&
> +       git commit -m initial &&
> +       git branch b-symlink &&
> +       git branch b-file &&
> +       l=$(printf file | git hash-object -t blob -w --stdin) &&
> +       echo "120000 $l symlink" |
> +       git update-index --index-info &&

As mentioned[1] in the review of v1, this should be written:

    echo "120000 $l symlink" | git update-index --index-info &&

[1]: https://lore.kernel.org/git/xmqqftgff1r0.fsf@gitster-ct.c.googlers.com/

> +       git commit -m master &&
> +       git checkout b-symlink &&
> +       l=$(printf file-different | git hash-object -t blob -w --stdin) &&
> +       echo "120000 $l symlink" |
> +       git update-index --index-info &&
> +       git commit -m b-symlink &&
> +       git checkout b-file &&
> +       echo plain-file >symlink &&
> +       git add symlink &&
> +       git commit -m b-file
> +'
