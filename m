Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029CFC2D0DC
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C5B2073D
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 08:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgAAIeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 03:34:12 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53150 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgAAIeM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 03:34:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3224097wmc.2
        for <git@vger.kernel.org>; Wed, 01 Jan 2020 00:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfCQ9iQzUXw1j37RrpOzP2a8OzXSmFWEFCB7L0PhCEU=;
        b=KaUffeSWpM4ZKnrP1HAcXGAi9ViM/7OtJO4oXRLn/ugFEf7+q0AQUGL/MDTq+NXtrX
         k3+Ytx6SXSJT7UXTrNjHwx76oWzUxbh0l28jpC8eLWHs+DXovFwiDbE9FXojclKkQs5g
         M8n32HZFDB5bouY4S8aGANggEkomcxWriZgDpIANKwWWaxBgGPKleBXvNC1LVKypZEva
         uQLB2xFZe4yCiRdywguQDnaiOyzd11aNLhhQsE+3eavwaAgnUusbkvzhjOeog7O1Bs3c
         N1KZrztof4jtJ7ZgOQs2KfAqbbviirLZkg62gNC0XfCbZTpAsLLyBjN/nhCkA0JCXGk1
         gDuw==
X-Gm-Message-State: APjAAAVfK2FOjg4XLsSKr8/LypNmSEpSaRdoNNJfd/VV8+P92U+DBn6E
        fwBZTqhu4Wr9kTML8kNlNHIxZdj+7A4BZRYTU/c=
X-Google-Smtp-Source: APXvYqxrNjc7AId3jCz3Sb9jn9VeeHBFA7qCygkhW5ivlVyi0zdqDmqLIU84c7s/25oA35L4JCdktteOcjROvM5vlXY=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr8274402wmj.75.1577867650670;
 Wed, 01 Jan 2020 00:34:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577454401.git.liu.denton@gmail.com> <54315fecfe373d8020f2172b9b43e02c0dae137d.1577454401.git.liu.denton@gmail.com>
 <868smt2zqh.fsf@gmail.com> <xmqqfth1fl72.fsf@gitster-ct.c.googlers.com> <20200101082443.GB5152@generichostname>
In-Reply-To: <20200101082443.GB5152@generichostname>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Jan 2020 03:33:59 -0500
Message-ID: <CAPig+cQWgH2MPZWZm1iL20at7BWN7-0p2=ogf8pHjGKvHDLL6g@mail.gmail.com>
Subject: Re: [PATCH 16/16] t4124: let sed open its own files
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 1, 2020 at 3:25 AM Denton Liu <liu.denton@gmail.com> wrote:
> I assumed that letting these programs open their own input was one of
> those minor "style cleanup" things that was done such as removing
> spaces after redirection operators, indenting compound command blocks,
> etc. Whenever I've been cleaning tests up, if I noticed a `sed <` in the
> area, I'd apply the transformation as a style cleanup.
>
> Anyway, if no one else feels strongly about this, I can drop this patch
> and I'll stop doing this cleanup in the future.

As a reviewer, I'd just as soon not see that particular change which
increases reviewer burden yet provides no practical benefit. This is
especially true for these lengthy patch series which can easily lead
to reviewer fatigue. (In fact, after reviewing this series -- and its
predecessors -- I was strongly considering asking you to limit these
cleanup series to 10 or fewer patches rather than 16, precisely due to
feeling reviewer fatigue.)
