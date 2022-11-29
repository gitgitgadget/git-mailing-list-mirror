Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C53C4332F
	for <git@archiver.kernel.org>; Tue, 29 Nov 2022 19:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiK2TIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Nov 2022 14:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbiK2TIe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2022 14:08:34 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D730556
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:08:33 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id o8-20020a170902d4c800b001898ea5e030so6643036plg.13
        for <git@vger.kernel.org>; Tue, 29 Nov 2022 11:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YBovPRX2Y18rjMN/HN/Gcl8la++QppsajRaLp9891G0=;
        b=WaucDfelUSawzqNEUDU1f6ftqX42LzPIpUPVI1Tp1dEu+ljiBTocjYqAQeOwVZlzrq
         m0qRLVbnn4IKTSBfkBBR5Y+ijdz0duP71XcIZ7SWlHDFZt2bXvMTLoFn17PYaVbxpSKP
         FTMMvAe/u7GXZCySp/GDgdk4iF1Yp5GJeIJKwvuL8Mb2bNrS09MMrmfEi844jIiBWf9t
         It2lv7HQoSHPo3LgoSg+nbLTsBT4+kGNnQG0LmQWJQ1SBdmDB3qFGlXSVaVEMrRwpUQA
         s8DjzSzZdrnCif5L8SJDdyVZRK6AyCCjNRV2sCd9vraGV/Vk1FzfbFOnWwWyIvMZkrvE
         wDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YBovPRX2Y18rjMN/HN/Gcl8la++QppsajRaLp9891G0=;
        b=CeSder8/6qI9atj2+X5DopTicDFPCbWPXRItjncoe1RFW6bGoJ9bv0N1YILNMMt0zQ
         jRpbhVhL5E4Z0X1W8gIcOm793kB26WaMEjCT0zBviVQXAtginuJb78viYCtEwj0NRePO
         WsCpkF8wkaEuvlmG9tGuyFEIIspx9Ynbn7ji7w3QSOPKySYQBm+xVvpz5VerRAlRE1U+
         1f0aujxxbOeG2qEo0hIbfSCSSI7siMvFb+drUiuH1+mqhsHcw5zPxjVxKQ95+Fm9KNPm
         keglxcOEYEPQOr3sRG5tiuhcrggZkSeAoT73bGkk9cLnSsnJ90jXby8EYuPGGZv11mSY
         PEdA==
X-Gm-Message-State: ANoB5pn7rVbZhNHL3SlkaAIhZj0254pdbKeKPy3nu+grCxyAl8ItIjhW
        sEHbTXYkaRzIz5npgjoXgzmQAAzE6C/m4Q==
X-Google-Smtp-Source: AA0mqf4IVuAPCHse7ktOTD8g7ZZZa6CFh32mpzxvhNrkm7mqlFid6yu3kBUs8Z2fB7JraFDN4jTJ5Eo5oaXdIw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:d086:b0:219:227d:d91f with SMTP
 id k6-20020a17090ad08600b00219227dd91fmr1702859pju.0.1669748913228; Tue, 29
 Nov 2022 11:08:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 11:08:31 -0800
In-Reply-To: <xmqqsfi22j67.fsf@gitster.g>
Mime-Version: 1.0
References: <xmqqsfi22j67.fsf@gitster.g>
Message-ID: <kl6lpmd5d1e8.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> * gc/submodule-clone-update-with-branches (2022-10-30) 8 commits
>  - clone, submodule update: create and check out branches
>  - submodule--helper: remove update_data.suboid
>  - submodule update: refactor update targets
>  - submodule: return target of submodule symref
>  - t5617: drop references to remote-tracking branches
>  - submodule--helper clone: create named branch
>  - repo-settings: add submodule_propagate_branches
>  - clone: teach --detach option
>
>  "git clone --recurse-submodules" and "git submodule update" learns
>  to honor the "propagete branches" option.
>
>  Waiting for review on the updated round.
>  source: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>

Jonathan left adequate feedback on the updated round, and we had decided
on a direction for the reroll in [1].

However, Calvin is also looking at how we could parallelize worktree
updates to speed up "git clone --recurse-submodules", so the Google
folks are taking an even bigger step back to figure out how worktree
updating should look, which will probably end in a different approach
from [1], but it should answer the questions on that thread about "git
checkout" with branches.

[1] https://lore.kernel.org/git/20221123013319.1597025-1-jonathantanmy@google.com
