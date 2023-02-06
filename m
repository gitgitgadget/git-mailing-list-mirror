Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DEBC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjBFWH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBFWH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:07:26 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281C030198
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:07:19 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id be8so13693552plb.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6KI6Wksu9W0Doo3BSKZrQWJQdUmlOhQ0NLvS8ekXnlg=;
        b=f/IKO2Zduc3SYQdg2FRDovsLSHLnrKd3ffhcvTfDKxE2XyKmkVf/PWKeQD8p56TzqM
         1Pg1+GOKFkM+U01MfdhbJpeUPn9vIr5mjli7UYAanGnwnHMSJsEuABDWLXt7xLRdlRNN
         ovbus8ZKeZTzp3XvQA8htUN743fkRhuMs/DGzRewhdKGQKfGBDALZptXS95hudcYgaGy
         jljFM0QdFMWdLKzderFmOed9qxjNtFPiSmY7Q3+DV5GacADgqAWUu+FgsxAdwvKbOG/j
         iA8igAjagZ4LE8m9myVfNokMuNBZYIgIKPEOMI1WAtSvlD3MKPSC1uaRA9gEzFNoYBHp
         aRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6KI6Wksu9W0Doo3BSKZrQWJQdUmlOhQ0NLvS8ekXnlg=;
        b=za7ByscNz/g/AeIRjel3+5wzLhJTHtJ7gmqyx9J7SsqsnkJz4L0G80bsi16a5aGvln
         yIJfDZ5JlaLuZNDhXJpmeQ9dKQUBl0fJhr7cKRp0qSTMX8lakMvYHo6zi3Kc0hw+zK6D
         L7M+hWrEMh59QPMsQKnybCbFf56uayK/ckn5nUZRYR0uyRKwH6iPQYQE1CSnELDV3bA9
         UZgQDlOmHY9UYvN50hQblO+otmY6u9Il/3qPp7xGeqZofKWPtD+5RBLFNVPaSelfiGzl
         962/gxN19ICG2Bu/44ciRe2d4ox08eYlnoPF7m0MyhmykL9wqepCmih4xenClJBydgBI
         7aCw==
X-Gm-Message-State: AO0yUKX11+31KTzZYhu1lqWl94KF5QbQphuFl6ZZX2+BoxH08NOtyQEc
        Dl98+pcUcsgyuyHgMrSDygw=
X-Google-Smtp-Source: AK7set8gcxoCFB3MZpaHBQZwGSD3kZYO3Ov9n6C70pT8VnrV5Crqu9WogtnzO0v94QotBoHV7Nm8gA==
X-Received: by 2002:a17:903:11c7:b0:196:8d33:f08a with SMTP id q7-20020a17090311c700b001968d33f08amr554921plh.6.1675721238492;
        Mon, 06 Feb 2023 14:07:18 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902aa9600b001965f761e6dsm7417945plr.182.2023.02.06.14.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:07:17 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Wes Lord via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Wes Lord <weslord@gmail.com>
Subject: Re: [PATCH] new-command.txt: update reference to builtin docs
References: <pull.1451.git.git.1675477659972.gitgitgadget@gmail.com>
Date:   Mon, 06 Feb 2023 14:07:17 -0800
In-Reply-To: <pull.1451.git.git.1675477659972.gitgitgadget@gmail.com> (Wes
        Lord via GitGitGadget's message of "Sat, 04 Feb 2023 02:27:39 +0000")
Message-ID: <xmqqo7q64fe2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Wes Lord via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wes Lord <weslord@gmail.com>
>
> Commit ec14d4ecb5 (builtin.h: take over documentation from
> api-builtin.txt, 2017-08-02) deleted api-builtin.txt and moved the
> contents into builtin.h, but new-command.txt still references the old
> file.
>
> Signed-off-by: Wes Lord <weslord@gmail.com>
> ---
>     new-command.txt: update reference to builtin docs

I was sort of hoping that this document has outlived its usefulness
and been taken over by more recently written guies, but it does not
appear to be the case.  A more recently written MyFirstContribution
references this, so keeping its contents fresh does have value.

Thanks, will queue.

> diff --git a/Documentation/howto/new-command.txt b/Documentation/howto/new-command.txt
> index 15a4c8031f1..880c51112ba 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -1,13 +1,13 @@
>  From: Eric S. Raymond <esr@thyrsus.com>
>  Abstract: This is how-to documentation for people who want to add extension
> - commands to Git.  It should be read alongside api-builtin.txt.
> + commands to Git.  It should be read alongside builtin.h.
>  Content-type: text/asciidoc
>  
>  How to integrate new subcommands
>  ================================
>  
>  This is how-to documentation for people who want to add extension
> -commands to Git.  It should be read alongside api-builtin.txt.
> +commands to Git.  It should be read alongside builtin.h.
>  
>  Runtime environment
>  -------------------
>
> base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
