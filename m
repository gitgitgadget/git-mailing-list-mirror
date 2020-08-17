Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URI_TRY_3LD autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8A4C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76A8D2072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388464AbgHQR15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:27:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44322 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389522AbgHQRQy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 13:16:54 -0400
Received: by mail-ed1-f66.google.com with SMTP id l23so12883391edv.11
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 10:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NLh/HIgImrJYOP4dZrwybqbcnpFiSc5xSOHHPc4fik=;
        b=tWrj6JCGZ1glr4hYkIA6EKD54XTOAJgr1DcII7Haa5fXv1OMmipSkXZMdBrH7+k8sX
         /HCQxO1aLtGCxY+h7oI35EZ2rM7mVPe8TumuGzYPFNtqq8suJCdoSnJhYcJEf8NFnZcz
         67v4NBWimXTjtPmlAbkgbsyhPgn1ysvwgJcHsbSoEfpirln3ezKCA5F/AbnMQB0ZlaTu
         yV56mmCLrDmxFQXetbikJYvswuvWWfmnBHQLc8O3FxRJGAh+w1kWr+uudkBWxzZaAbcI
         AbGshe8ymEukjYLljKL5V4GirCLoMWtfli2iaeeUE/IT0mgmI+9mQ5XHcKI51aGXghPO
         7COQ==
X-Gm-Message-State: AOAM533W6+GTZQqpKlDwjBfwpgRiRzb8G0S94OYnaTSf7qFpcLkunoyC
        gmpqji8gT3r0RzU0oO6RzONiSCkmZYYRa2MkTOw=
X-Google-Smtp-Source: ABdhPJxzN0PT896alphK6Ys3iELPyk0ByJEUsk+3jAzwTT+7dLz7klCs6GBDfC8IfnxvhLVoyAHMdz/hbLyO//iPZtA=
X-Received: by 2002:aa7:d809:: with SMTP id v9mr15920754edq.94.1597684611910;
 Mon, 17 Aug 2020 10:16:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200817125419.1655-1-vvavrychuk@gmail.com>
In-Reply-To: <20200817125419.1655-1-vvavrychuk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 17 Aug 2020 13:16:40 -0400
Message-ID: <CAPig+cT8Kmh6LcoKqkcJX6imXaase07o8C_-7k7RkyhEyW02rQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/git-send-email.txt: Mention less secure app
 access might need to enable.
To:     Vasyl Vavrychuk <vvavrychuk@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 17, 2020 at 8:54 AM Vasyl Vavrychuk <vvavrychuk@gmail.com> wrote:
> Looks like Google changed gmail security and now less secure app access
> needs to be explicitly enabled if 2-factor authentication is not in
> place, otherwise send-mail fails with:
>
>   5.7.8 Username and Password not accepted. Learn more at
>   5.7.8  https://support.google.com/mail/?p=BadCredentials v5sm13756502ede.13 - gsmtp
> ---

Missing sign-off. Please see Documentation/SubmittingPatches.

> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> @@ -494,6 +494,10 @@ edit ~/.gitconfig to specify your account settings:
> +If you do not have multifactor authentication setup on your gmail account, you
> +need to allow less secure app access. Visit
> +https://myaccount.google.com/lesssecureapps to enable it.

Thanks. Make sense. A few comments:

I think multi-factor is usually hyphenated, so perhaps:
s/multifactor/multi-factor/

Since you are not using it as a noun: s/setup/set up/

Also, Gmail is normally capitalized, so: s/gmail/Gmail

> @@ -505,7 +509,7 @@ following commands:
> -The first time you run it, you will be prompted for your credentials.  Enter the
> +The first time you run it, you will be prompted for your credentials. Enter the

This unnecessary whitespace change just adds noise to the patch, thus
should be dropped.
