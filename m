Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAE3F1F404
	for <e@80x24.org>; Sat, 21 Apr 2018 06:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbeDUGHD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 02:07:03 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:44924 "EHLO
        mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeDUGHC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Apr 2018 02:07:02 -0400
Received: by mail-io0-f170.google.com with SMTP id d11-v6so5012883iof.11
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 23:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AFhaV4IWS2Xykh3etMY4wU8QRWJloRyOPAhPRHBMyus=;
        b=stf4WMzLI4fQUkiHOR4ZQktX/pxjwHVLp7qhFYOzatr1qBQX5IQ0vWIuSGutEwUzWe
         rf3xnyAJCfemh56gyAcK+LmB06TN3X/KHoLOE3YEk1pnBTFhzz2+gxJp/uIjC+EEgvSC
         cPMHjUgH8jsiL8j7RPeNMT+scJFMq5WgriFtHEaTMVdmEguLToDBoepwoWMzpWd3JSyb
         Tnbe1/ZthXO0c1W4VKPgjmncJA+qgY4TMtTamQ1HiV6QoksVIdUWTdo4yx7RF3Do8nKe
         9qf021DJb/GVx+zhcU1ylX46x9mQy026BieAxhNAvtMQz6Um71p+RbwoN/usmBsaeE9K
         oRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AFhaV4IWS2Xykh3etMY4wU8QRWJloRyOPAhPRHBMyus=;
        b=MPWVmNgOOct4JX1s0+Hqzj2cGU3+Ij4P7ohRr8aTgq8KhOQSqxDWNw76rOhJbgXaEJ
         DaxYCHubkkjUnv47bB8g8BfM9pk8F/XPkPJPS0y8fFns5d2VjPdMi45zQkVEDwa4KdKt
         Ry9bda2zk3psRDEMfPaJuo7VqbjEwme+KV7bL7XYw9Wdw7lB6vxWBTaFCOTiqsYBnlIo
         qS+odrtECSbGF85wsKpsx8b0m5dfvAyW538GMzgvtA5fDv7HeXXYakkAUvxji0ixQNww
         Twgw6LSdkMISYpaTEIXkK/bg1PINolBa4SzeTm6pfeHPYWyqSdFesHraxV7ET7EVAukM
         lq7A==
X-Gm-Message-State: ALQs6tDwQ8ZiIWN7xKtDSiFEhIEbOa2rrlvuRSji2qE9fkqkAnypfkq+
        L9UZxKYNcZ3nMCdkyhukDEC+CgIRQ2WYN4nQYqo=
X-Google-Smtp-Source: AIpwx49J1ZX4qIpjU+7DUj6hnNl4mXRAJhptLmk4IBAlYt/K9dAVzDlJIgNG0t6rDxvoccx/go45oJGdDBgzgzzk2Fo=
X-Received: by 2002:a6b:900b:: with SMTP id s11-v6mr12825513iod.223.1524290821909;
 Fri, 20 Apr 2018 23:07:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Fri, 20 Apr 2018 23:07:01
 -0700 (PDT)
In-Reply-To: <xmqqlgdhb6ba.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFxSZLuk++Dz6SonD+JhbbSDt9G9VcBx5f1CV=6nJC9hvg@mail.gmail.com>
 <xmqqr2ncezdc.fsf@gitster-ct.c.googlers.com> <xmqqmuy0ez8b.fsf@gitster-ct.c.googlers.com>
 <xmqqfu3seyad.fsf@gitster-ct.c.googlers.com> <CA+55aFztDdB9tVHREhQ7T0COs7p9ng81XfAHZCL3rx9WT2ecEQ@mail.gmail.com>
 <xmqqh8o7eq7j.fsf@gitster-ct.c.googlers.com> <20180420072701.GB13462@ruderich.org>
 <xmqqlgdhb6ba.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 21 Apr 2018 08:07:01 +0200
Message-ID: <CAP8UFD0_LvWkKSYd1MWrdoK-tqBcQqm32CUNrBqEfmjWdHkJgg@mail.gmail.com>
Subject: Re: Silly "git gc" UI issue.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 21, 2018 at 5:13 AM, Junio C Hamano <gitster@pobox.com> wrote:

> @@ -388,6 +389,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>         if (argc > 0)
>                 usage_with_options(builtin_gc_usage, builtin_gc_options);
>
> +       if (prune_expire && parse_expiry_date(prune_expire, &dummy))
> +               die(_("Failed to parse prune expiry value %s"), prune_expire);

Micronit: I thought we prefer error messages to start with a lower
case letter, like:

               die(_("failed to parse prune expiry value %s"), prune_expire);
