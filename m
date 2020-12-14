Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640CEC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7AF20679
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 19:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502910AbgLNT5Q convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 14 Dec 2020 14:57:16 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35837 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502895AbgLNT5M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 14:57:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id u19so18520595edx.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 11:56:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bh6RQu6jDd8QuYmbCs1whyjf77JKL7xW04u3208Whhc=;
        b=V93UuqM+9moWKzokd3RuST0ZyM3hXDUKLa+b91DVXuqqeJCulTw/o93XK0mP+FvI/d
         uFEoTnSFL+bSrMGLSifkcv5dwTl/SYnosmYImHjMSCsHSgHH/9BWahrsh9UqWGqe6cxl
         K3EgBorKRGv8n3djVPCNJm8vAMiyuk9kA/4sqUbWxJcsse2hHfeTQaKQi20Idbpt3tsn
         QEfnl39wDjFFjxN35FOrXkKPsPuIcvgXGT9RehxkCol7iOHwIq4eXReP0TZ6FLx6BtFv
         ArLRNJ+VLAEG99fcB4JhEsp1Cl1RxL7ZYLNkdBDMI81Pj2yv6ZhaZqIK/I9kfWyZpagB
         Mwvg==
X-Gm-Message-State: AOAM531z3hvNi+IPL58n6OI36vBy9oy/zx8R0kWoV8H5qu01h6OKZpOB
        F/kZ1qsmPRcaSq8gJFjCdY7zbFFE6MY/vHgt44QD6IYW
X-Google-Smtp-Source: ABdhPJzrXdZ01j0ajDa68J+7aSPS9DKlwss5j5yojAFqXyhhT9bakIphliHYTyveBK5K/BlZVIUrL7uGM5gPXx/ias0=
X-Received: by 2002:a05:6402:1592:: with SMTP id c18mr26110548edv.181.1607975790402;
 Mon, 14 Dec 2020 11:56:30 -0800 (PST)
MIME-Version: 1.0
References: <20201210125321.19456-2-avarab@gmail.com> <20201214191700.16405-3-avarab@gmail.com>
In-Reply-To: <20201214191700.16405-3-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 14 Dec 2020 14:56:19 -0500
Message-ID: <CAPig+cTWoBaoQxNvbFhKNVSvYP_TFOqdfLsu5tOW32uO5TEoaQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] refs: warn on non-pseudoref looking .git/<file> refs
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 14, 2020 at 2:17 PM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> [...]
> Our own test suite makes use of a few refs in .git/ that aren't
> produced by git itself, e.g. "FOO", "TESTSYMREFTWO" etc. External
> tools probably rely on this as well, so I don't think it's viable to
> e.g. have a whitelist of them. That list is quite large just fr

You want a s/fr/from/ here or something?

> git.git, I counted 12 names used in the C code before I abandoned that
> approach.
> [...]
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Modified-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Is the Modified-by: footer intentional?
