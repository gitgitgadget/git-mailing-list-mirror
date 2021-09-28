Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78FEC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C406128B
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 17:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241943AbhI1RRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 13:17:48 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:45642 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbhI1RRr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 13:17:47 -0400
Received: by mail-ed1-f51.google.com with SMTP id r18so10102606edv.12
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 10:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5d2+Tt+w1uLp/cfNZS4OTI+vgDxAtyZ3LsORWlCtWA=;
        b=GCFR6HH7BDtQkpPlOZPHllsWJjyawMlcAsTuKr08gjhItaNRTXfEu6Kp18/CCtl8UX
         U26frGyu+dZqUh5EI2ZYd2TW9RRXVTfLYstAhi9YizsuVZvwz5yUrOSDq7uzV/AKcCgS
         +pwg5Bq0wXUJqJjIpMkQNcAGZHv3E0BtUHmnhVsU37vWPOKC23rs/W3LnJbvCiPakxN4
         UdZyuDH4XGSUfbEq6gGc6pOURp0CwvpsKPvl5lO+BFIIOse/MKo8KdVe5+CK0kVvyWcC
         N7X6g5y2d7zqiWEjPCb/suE6/7ER6gzxAJfM4ouzVS8xvzV+Yjc1vUdOS18jtYJb7ETN
         g6gw==
X-Gm-Message-State: AOAM531+fBfjP/UGEQoRST9w1hO1S3mP8B17b+1KYg64hzBLZj3bOz5B
        iCdBxCig5Q4KuELQYv+hvekeXRhyUXPM6lqZjcE=
X-Google-Smtp-Source: ABdhPJw2eS7JV0yC3qQ9u26S+KZgYapGQgyCEw+9gPE+PyShUGZxry15VpBTHAYLTKmTN6SYF30bodGiarM8ledYH7g=
X-Received: by 2002:a17:906:f0cc:: with SMTP id dk12mr7803776ejb.36.1632849367110;
 Tue, 28 Sep 2021 10:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
In-Reply-To: <8c266e58dede247b2c97ad2870c7c24c3b35ed55.1632848754.git.matheus.bernardino@usp.br>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Sep 2021 13:15:56 -0400
Message-ID: <CAPig+cS1xrXHBbxwcwL_WKdnU9_MSTZffMtn3FxdUGuQX85XbA@mail.gmail.com>
Subject: Re: [PATCH] grep: demonstrate bug with textconv attributes and submodules
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 1:08 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
> In some circumstances, "git grep --textconv --recurse-submodules"
> ignores the textconv attributes from the submodules and erroneuosly
> apply the attributes defined in the superproject on the submodules'
> files. The textconv cache is also saved on the superproject, even for
> submodule objects.

s/erroneuosly/erroneously/

Also, perhaps: s/apply/applies/

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
> @@ -441,4 +441,107 @@ test_expect_success 'grep --recurse-submodules with --cached ignores worktree mo
> +test_expect_failure 'grep --textconv corectly reads submodule .gitattributes' '

Here and in remaining newly added tests: s/corectly/correctly/

> +test_expect_failure 'grep saves textconv cache in the appropriated repository' '

s/appropriated/appropriate/
