Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D86C433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8522C64ED2
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 21:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhBIVlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 16:41:00 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:41944 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhBIUwy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 15:52:54 -0500
Received: by mail-lj1-f178.google.com with SMTP id e17so3687009ljl.8
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 12:52:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EN2IUCQ7KpaQRKojACjN6YNv8AYabjSM1ul1O3FpyeY=;
        b=b/SpBChId8qYs1OlWjs3vUGv78u5SL5Kpr+CMj1hTH1B2fPKEU0iev6IxPqc4WczUf
         7Gki7fTnDZVcU8PbCfjxlizE3x1k+OYECBCWgLwceI1r7X/KcdPfDyL5GZ9ZYj4NE+Jx
         uDtfPFxcuQrMKQRxmIMbWl0a0n9pyUldQcgvdPdhvjHTzMxJoBjAfHiH74aFW/PAsbfz
         j/gxSBdINKz9it2EgP1qSiNkk7SAM/MtSzg+mfzG7KmqNQApITBvLql8oFS4TduQc0F0
         qeUbrahmieR/sX1tDxATZc7TjogpoLBtvkElaYG7r+IGG4lVjMPnLMVFfhYtR+OXw7VP
         p9SA==
X-Gm-Message-State: AOAM532tdincn967OvuVgEs9dI25U4bnc+FEHCba+Mw9OT2gflkWjbj3
        44soubj/cvCpFFqoRRqD4b8NeOk94/gQ2wILz3iLRPQymVM=
X-Google-Smtp-Source: ABdhPJzl4iZtykuCGfh+u8yftoVjP5TLvJgK70LQ/VAdmJ5aufWOMeQuRpew7JpO4i9dw6BLGWDvPgG/pCLzqeQloCo=
X-Received: by 2002:a17:906:3649:: with SMTP id r9mr23288234ejb.202.1612897249210;
 Tue, 09 Feb 2021 11:00:49 -0800 (PST)
MIME-Version: 1.0
References: <CAD6AYr-BD08FcbnVfHpOUt7ZwFH0PgoATgyegKnBQ3GOe9isdA@mail.gmail.com>
 <YB148VZJqKIPC8P2@coredump.intra.peff.net> <CAGyf7-EB=J1j1LOUiUBHE+g-hA1WXUNy3F4y84rCRwzGc2zo_A@mail.gmail.com>
 <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
In-Reply-To: <YCLGgpfkJzg5nP7v@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 9 Feb 2021 14:00:37 -0500
Message-ID: <CAPig+cSdTCYV=2OMEZTqahrfBypaHeD40ToMFJ1zbRNpkiPbYw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: only look for .mailmap in work tree
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>, SURA <surak8806@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 12:31 PM Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] mailmap: only look for .mailmap in work tree
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> @@ -113,6 +113,10 @@ MAPPING AUTHORS
> +Note that if `git shortlog` is run outside of a repository (to process
> +log contents on stdin), it will look for a `.mailmap` file in the
> +current directory.

Elsewhere in this same document, techy-jargon "stdin" is spelled out
fully as "standard input".
