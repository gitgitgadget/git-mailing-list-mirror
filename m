Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF98C5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 20:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjAIUMr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237858AbjAIUMY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 15:12:24 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD46F11E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:12:18 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so128114777b3.9
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 12:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5E2alWOGmZ1zXn4LUshCKoXjpvdzq19cLdJSlFwWJY8=;
        b=mJjZ3KEFX6QpGcfHRQLg7cVJWz+JRU0rC5liB3rQvKYhUrtTXbc3c2dcxXRb6ZfJuU
         PlNZfP3loyzSzr4tSjN+U3URJLbBFmQbJSHZLBulSn79OsUqY3iVR4iGCyf75oNdUO/v
         FDLy1jw3dLZ2GuQQ1nEz2AVCAcV67VjUUtr7L5rdwPJ1Xy3MeQKXU4tXqzfK2qpe8wtj
         Y6OYZsZ8pJHbDZ+ZwNgQhaZx8QMALKjMORH5MLhBknGBZLjNUFIRGf1OIYXfWf63KhhW
         LGLoDkuJ0J4Y7+j1M+LdAnzHcteKcei6bVvptdjaB88ZzRWJyUCz4r2C92+ZYJyYMblc
         9wXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5E2alWOGmZ1zXn4LUshCKoXjpvdzq19cLdJSlFwWJY8=;
        b=KHWZEY0Jny5QD5eYF1bCsPEfDcRbMbm6H0bGcFw6FmIbYt5y7F/3cZ0EUe0NBcaS1J
         dbIEieQPZRV9KsFlawhYDDhc1eNewk/pOknnztr9ZW/qZjxJ6T3/3AaKb32wtPF2HwQ8
         u4TW/y8kDM8PvnzCsPLqxvao7cSBzyg4vZmC2StYaPkF6AIheIIFcpN5KtjiuVkctZG5
         02GF2Vbpj98j9I9a4ShExJiD78iDnXLqEId3wMZEpjIHcza68luhBKJzEviUSrGvEUpo
         MUGFWB3pUR4Tys7k/0ONvtxEspaFE5Y+3dOwPnkRSTxoAeKvOKBY/+XMGXs3MEMzT54F
         xjBg==
X-Gm-Message-State: AFqh2kr4MFbD4K2fh4PK2v1Ra314D2hNgvLK1B6BQ5kNPuf7qtdOHtGU
        9sFRHjqvGjxWrobAxuURjP+UiYBdL0PznQ5JYKQ=
X-Google-Smtp-Source: AMrXdXsvgIVMccUrEGcX0Cciz+PHZD3ZJAP/1JxsQ58/eR3LFgef8q77S6Alv+p7rveEkEfeb3AJdjg90mXfgWJcMNE=
X-Received: by 2002:a05:690c:847:b0:391:7188:7454 with SMTP id
 bz7-20020a05690c084700b0039171887454mr900696ywb.212.1673295137940; Mon, 09
 Jan 2023 12:12:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com> <pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com>
In-Reply-To: <pull.1457.v2.git.1673293508399.gitgitgadget@gmail.com>
From:   Preston Tunnell Wilson <prestontunnellwilson@gmail.com>
Date:   Mon, 9 Jan 2023 14:12:07 -0600
Message-ID: <CAC-j02NxVbqu+TQvNgbwFtxmXTZBAJtG60BR+yfXcT9ubSn-jA@mail.gmail.com>
Subject: Re: [PATCH v2] githooks: discuss Git operations in foreign repositories
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 9, 2023 at 1:45 PM Eric Sunshine via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>  Documentation/githooks.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c8..62908602e7b 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -27,6 +27,18 @@ repository. An exception are hooks triggered during a push ('pre-receive',
>  'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
>  executed in $GIT_DIR.
>
> +Environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., are exported
> +so that Git commands run by the hook can correctly locate the repository.  If
> +your hook needs to invoke Git commands in a foreign repository or in a
> +different working tree of the same repository, then it should clear these
> +environment variables so they do not interfere with Git operations at the
> +foreign location.  For example:
> +
> +------------
> +local_desc=$(git describe)
> +foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
> +------------

This looks good to me! Thank you! (And I'm sorry about top-posting
*again*! I think I have the hang of it now.)
