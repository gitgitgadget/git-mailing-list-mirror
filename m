Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09A1C1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 07:15:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbfGNHPe (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 03:15:34 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32871 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbfGNHPe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 03:15:34 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so6745660plo.0
        for <git@vger.kernel.org>; Sun, 14 Jul 2019 00:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=eKzl0qkdkHPn2nOG4b8wBXibC/N8QFgTMOX1UhRnWE8=;
        b=gbAgQ8OTnSXa5kkqit434pTINsw2/ex8z9DV6a8Gcz2Q5iNlIo0i4c7psAudLxw8iR
         xxJPOGRUWYxf75z9Iw69q/XwAe+3B4iC27CwlY+Iv492cwieO4uAZbRz1cO8cVIl5Lo7
         HXInPZ7sFrGlIn062B7XESg8yHkoazs8xlRc8r9KIHPNZuGGlFv2XxwAL+eQGgyvRWL9
         2rtYl0jedm5w609kfhWe47OiY6BS2hqePn/UweJURexg8fhqKhLqywhtz4//0ySO5ba4
         uYCgr0Waoq5/XsicgYAVvuj5ZmHGFBYYUJGcEXk14W90m9dBolhKvX7uADKpVvMNJfcb
         Jc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=eKzl0qkdkHPn2nOG4b8wBXibC/N8QFgTMOX1UhRnWE8=;
        b=FvMyKAs4aW95kRo1qgV5QlM6JsvQ0fwvxIFIf+6VhtSJAckWwUhPS2lBOkVYSl4177
         PnthuKFcAyvwKgU1dAvxZ/JzoObUo0zRFDKyrBCvjD1H7o+g+4jLFdLSMnQyJdXQKBkZ
         l7yh+fmSC9tFXv+lk12KBKa+r1umMGCawlWYR9avQsynR+FAagEd4UV2o9iqw/18Q+DF
         2bVAVE8jkDUszu6DrZmRzSEzybJCgqRKoSOt0NlkjeMdOff1BS42acwR5/K7ptJnxKXM
         R5poFJOTDYeicVvpU73BfpR2WzeOEwKaPp6/mbzuVEHIEboZtzE04qMi4zPwsAQRYye+
         OMBQ==
X-Gm-Message-State: APjAAAXQktAIva1bGlFnHkBY9uQHwuXV+ERXgEasIzcHh/EERKChn5EK
        pwT7ukBcUX5zMS2W7PDSqT6BLrqvfFNSF1l0YcUi5U+g
X-Google-Smtp-Source: APXvYqyKQ4e+HBc5YPelRQh8P/rB5SYP7VcyXy/Uh2BaBvjbDKkn2H/8U8PB1Vd/AxlHCB4q7/20/ZS0qxHV86fLYOM=
X-Received: by 2002:a17:902:2889:: with SMTP id f9mr20433715plb.230.1563088533798;
 Sun, 14 Jul 2019 00:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190713051804.12893-1-eantoranz@gmail.com>
In-Reply-To: <20190713051804.12893-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sun, 14 Jul 2019 01:15:22 -0600
Message-ID: <CAOc6eta-jX93k6twcrJOeRt+JHtLk4mUs7YD_bG=Ggvw4thAZQ@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/merge: allow --squash to commit if there are
 no conflicts
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 12, 2019 at 11:18 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Option -m can be used to defined the message for the revision instead
> of the default message that contains all squashed revisions info.
>

I have noticed that just adding the support for -m in squash is more
complex than this patch is reaching so I think I will break this patch
into two parts:
- squash in a shot if there are no conflicts
- support -m with squash
Disregard this patch, please.
