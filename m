Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69DC433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05359611CE
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243383AbhDLRHm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 12 Apr 2021 13:07:42 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:38688 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbhDLRHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:07:41 -0400
Received: by mail-ej1-f45.google.com with SMTP id r12so21498578ejr.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JqgOXG66JvkDbIE5WMhCtAIQssBuZq+t6G6Fn0cZu84=;
        b=S6J7TSvnoKW2K6d/rxpL5o2/YoLLgM5GCXJC+hPBGWATPXATMs68012+/tG2TvukrL
         WlEEHwR/OioXU9iXIcytKX35khVENijng7dQk8s35CC9D15wEdSG/BSOFwPTXL5JIyiA
         7VATriV5uVnw5SHBocPN8EF5LVhEUvXdOXdjnPzjGFxvCAGntE0zRhpFRyyAKnzP8/7+
         qnnfdoWz+YC6uERM1eDVRchWtbUaVh9i3OpN9NLCY5QTMOA3hcCRmr64+PsfRXkWt2NF
         z2C7s4XehkMJFdnX7HG71AamPdZPDZQ7MFXcBYuQkrv6TFDyjxLnPJMk/Zlox7w1IeyQ
         7cyg==
X-Gm-Message-State: AOAM530B0kEoaHwbsWkYYjNvJFiMoHW6WJT8RSzWw7H6/QyMvIZUeuzl
        e5T0c4fwFF4a3hgT1dsuOc5FEF+V9ZhknbYXXFg=
X-Google-Smtp-Source: ABdhPJx2OKoS/nEBMDpMmc7BWoTZ6ivIWdGdiYrKYdaD9tRrFHMA07wq6aux7mFbBkV9D81dy78t0FNReZydKW3Tla0=
X-Received: by 2002:a17:906:cc46:: with SMTP id mm6mr2394754ejb.138.1618247242553;
 Mon, 12 Apr 2021 10:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com> <patch-05.16-6df03776940-20210412T110456Z-avarab@gmail.com>
In-Reply-To: <patch-05.16-6df03776940-20210412T110456Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Apr 2021 13:07:10 -0400
Message-ID: <CAPig+cTJNrTrV=oEDRgGeaqOLmj8gpHKfxJTqfXynBYibd=+Ag@mail.gmail.com>
Subject: Re: [PATCH 05/16] test-lib-functions: document test_commit --no-tag
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 7:09 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> In 76b8b8d05c (test-lib functions: document arguments to test_commit,
> 2021-01-12) I added missing documentation to test_commit, but in less
> than a month later in 3803a3a099 (t: add --no-tag option to
> test_commit, 2021-02-09) we got another undocumented option. Let's fix
> that.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> @@ -177,6 +177,9 @@ debug () {
> +#   --no-tag
> +#      Do not tag the resulting commit, if supplied giving the
> +#      optional "<tag>" argument is an error.

This is difficult to understand for a native English speaker/reader
due to the comma-splice[1]. A period or semicolon in place of the
comma would fix it.

[1]: https://lore.kernel.org/git/CAPx1GvfFPWvJsj+uJV7RZrv1rgEpio=pk6rKF2UrjHebVY=LPA@mail.gmail.com/
