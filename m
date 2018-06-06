Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F67C1F403
	for <e@80x24.org>; Wed,  6 Jun 2018 19:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753068AbeFFTR1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 15:17:27 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41701 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752012AbeFFTR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 15:17:26 -0400
Received: by mail-oi0-f65.google.com with SMTP id a141-v6so6292937oii.8
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 12:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UDpwFKvx5zmUVdH6ZCc/B9qsV6UweCT9LwhWiSQAAZs=;
        b=L8e1L2T/W2W6zMQn4uPv+VQqkx/qHBz134I0FfvzxLSaZzcyGOi1g6j2Y6kLqZ16ug
         dWQRo6HRI7TxwwAJ/84pcc9lEu2vbuoGfBCWzp7uwDnYYI7gdZCt9uV706D59lwzKUJn
         tn9MXdTwuSmMk4ERgDvR3VUUxA3XEwrHFAaB3gPBnfWlDfJnB2SAzvc9g0JyrBo5xb64
         v1NdoooJ9arok/Oi25J5z8ZCPtvC1HkLWLrpXzq8HYphfptNaG//mqiu6FEClV8v29vf
         75YLk2BDK3h1gPZEOsVbNES5iLFhrq2s2O0ZSyatM1XWv2YIaXxuWty2uzxhfy6tuL7o
         bvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UDpwFKvx5zmUVdH6ZCc/B9qsV6UweCT9LwhWiSQAAZs=;
        b=HIcwVPTfAFr5YwiUmswtdGExbzrl6p0kJz1M4fnja2oi2tHuxajaMUSIdQj2qX8qKk
         ZqiD3zCgODAowK6Fucfz/5hmb1TdTBUT6Ef3uhDzHvxNtmC4Voh6+pHc6NnrJ//V1Sm+
         7Ggw/p2vN7nKEKExTD8hjJdkNcinfj+/WY5yyrcjE+/JWTWSA2URSi/GsrAUIYSI+k27
         5qo9cd3RiXNWl9ZQUgCN6Piyop4Iv7FMQgk+Iuk5/dGatRFJdgzfe+DDixk0ph7hvoPw
         DzSrfE3plYPf2ZVsBqeIUo3MIiJnnXGAWeo7+4r23/SG3GiNI1MkQw2W1wvwAMcxEdVL
         NC4g==
X-Gm-Message-State: APt69E1VtMzPOTuPYVHZIrkfyiIuB6HQ/IWd9jwNBQYXHIa9jaTqUFI0
        oQaDO2UlUv8k4Vjq7ED+nttmRjCbsoje0LT86zE=
X-Google-Smtp-Source: ADUXVKJkLJc9/qGQuKbO1p78RE4NuPlsn1I/FXNJB+QP2j7rbeCLzuUZWxdCUGLo50pc5ycE0Ty4Y/LfgBcoptVq0SQ=
X-Received: by 2002:aca:aa54:: with SMTP id t81-v6mr2480451oie.30.1528312646205;
 Wed, 06 Jun 2018 12:17:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:2082:0:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:16:55 -0700 (PDT)
In-Reply-To: <20180530080325.37520-1-sunshine@sunshineco.com>
References: <20180530080325.37520-1-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 6 Jun 2018 21:16:55 +0200
Message-ID: <CACsJy8D=6fAEpO5m4cc7KZyggAW1AosSkUWaunQBFH0nr-YrdA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 30, 2018 at 10:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Dscho recently implemented a 'tbdiff' replacement as a Git builtin named
> git-branch-diff[1] which computes differences between two versions of a
> patch series. Such a diff can be a useful aid for reviewers when
> inserted into a cover letter. However, doing so requires manual
> generation (invoking git-branch-diff) and copy/pasting the result into
> the cover letter.

Another option which I wanted to go is delegate part of cover letter
generation to a hook (or just a config key that contains a shell
command). This way it's easier to customize cover letters. We could
still have a good fallback that does shortlog, diffstat and tbdiff.
-- 
Duy
