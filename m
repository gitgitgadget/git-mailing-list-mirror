Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D461F404
	for <e@80x24.org>; Tue, 30 Jan 2018 21:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753965AbeA3VLj (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 16:11:39 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38087 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbeA3VLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 16:11:36 -0500
Received: by mail-wm0-f66.google.com with SMTP id 141so3882793wme.3
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 13:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wHTMO6RZP+oqwY3smQXfuG9Cr7tELoALf6psPn1IXu0=;
        b=bQ49dCilwUQ6wyawBFlGI7OONHVAp0y6LGagIIjGAk7hpCXldNjYUcuMEcguB95inn
         /DrHF3SBLKvNu3xlSiMFPTcWAa/dpKS4+OL/QkGW3FGgafeniNMshD1kiK9gHTB/4/Vn
         Ykd8yAfMaHdRi1O37UBUbJkDn3LkTc1Jr1LTzETqRSIoCTP9X9eqnH94Dhlmu2v6Ornp
         IxluerkUmrQx/il8Zi/VP71inSenPNYAqOxVl+husVtQKuKDDFWUdSbKFQc7mS3RLtGF
         FtZhnps0BtSSqHZvlOsFiJm50dqFmQ5N2qIA8tSyi/wJNdwhW5STOVy78ymIxt1jo+NO
         Ou4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wHTMO6RZP+oqwY3smQXfuG9Cr7tELoALf6psPn1IXu0=;
        b=bSXriZQ/YOtL/L+BaVvPpsNX1DVZ1J2exfXW9nHY5RoGSdz8TOdsOCoUrOewCEPS8/
         dL5B6YR1yKsq9XoExnfCA7Bp/OAhqplk2vfIHA5DU16wkNNnfG1JZ5P88o6P+K5c7fE0
         aXdPkY9NPWOJ8QJvM7CsW2Lkz0WITuuRD5L9B1TLJsk0FIycGPDomEK6olO1hqvltX05
         8lDZ5OzqeLKUhAfNE7+RnT7SS+hpHyWJNus3ZxSxnW+uc53WWbdVKq2546C8ujyrNpgM
         t9Fk8OjXxQmYfXfHy1Dcflv74qvgyqSZb7rsJw849K1joUsAupSzuGycvzjSIunvNX0I
         Bf7A==
X-Gm-Message-State: AKwxytc0GmVkhAIWN76MVKcZPped1NVckPFgAhcSjrFGzoXp5C5F7+ky
        si1UCTvCZZ801H5c28bZres=
X-Google-Smtp-Source: AH8x225Bh7EhO6lLjLIt5xriKKEzNGI3j79bVZQJoU0njkLMUNU0H2Doz/7w2BJAs05/5yTWVI51EQ==
X-Received: by 10.28.71.70 with SMTP id u67mr21089638wma.46.1517346695522;
        Tue, 30 Jan 2018 13:11:35 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h194sm26034785wma.8.2018.01.30.13.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 13:11:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: mention 'git show' defaults to HEAD
References: <20180128191607.31199-1-tmz@pobox.com>
Date:   Tue, 30 Jan 2018 13:11:34 -0800
In-Reply-To: <20180128191607.31199-1-tmz@pobox.com> (Todd Zullinger's message
        of "Sun, 28 Jan 2018 14:16:07 -0500")
Message-ID: <xmqqzi4vrr09.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> When 'git show' is called without any object it defaults to HEAD.  This
> has been true since d4ed9793fd ("Simplify common default options setup
> for built-in log family.", 2006-04-16).
>
> The SYNOPSIS suggests that the object argument is required.  Clarify
> that it is not required and note the default.
>
> Signed-off-by: Todd Zullinger <tmz@pobox.com>
> ---
> This was mentioned in #git today by qaz.  It seems reasonable to document the
> default.

Sounds sensible.

>
>  Documentation/git-show.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
> index 82a4125a2d..e73ef54017 100644
> --- a/Documentation/git-show.txt
> +++ b/Documentation/git-show.txt
> @@ -9,7 +9,7 @@ git-show - Show various types of objects
>  SYNOPSIS
>  --------
>  [verse]
> -'git show' [options] <object>...
> +'git show' [options] [<object>...]
>  
>  DESCRIPTION
>  -----------
> @@ -35,7 +35,7 @@ This manual page describes only the most frequently used options.
>  OPTIONS
>  -------
>  <object>...::
> -	The names of objects to show.
> +	The names of objects to show (defaults to 'HEAD').
>  	For a more complete list of ways to spell object names, see
>  	"SPECIFYING REVISIONS" section in linkgit:gitrevisions[7].
