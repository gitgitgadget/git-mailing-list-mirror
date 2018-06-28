Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A73B1F516
	for <e@80x24.org>; Thu, 28 Jun 2018 08:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934654AbeF1IIP (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 04:08:15 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53993 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932245AbeF1IIN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 04:08:13 -0400
Received: by mail-it0-f66.google.com with SMTP id a195-v6so11415374itd.3
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q94AO9YtIziw8ckhx2zKPmwNN42OxQA0kUyEHKjw7Dk=;
        b=TjLCIHS412auDraZqpHjFRmA3XDET4B4w3Pooigm3K534PuqDxCO5wt6UzBxu7FWeT
         Gn54xLgp468Ghwpj20zkcsbclZYlauTENqDFLjSvHG5B7Z6gKmcm0eteYLi6lBCVe69l
         cI6OvZRZ1Ke7LB0UrMmCq/hInE/ipyFNuTM3+Cb/gj0U8x1UW0dQBOvAniRAjsC5+Xze
         AubGfQLALSoORSxNfsxiFts/8DUwj3qvOwuhO7eL6q5muaqBr8BLssqjE32pziSz/IqO
         tf2d9wDm5vnAbkNX1kL4gJm+mB0drT6KMKQIIhHYjW5Q0nYmR47DgplHxfeKG2CX4VHs
         axWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q94AO9YtIziw8ckhx2zKPmwNN42OxQA0kUyEHKjw7Dk=;
        b=eyNUmCNlbvfQKP2ErVg0n24Z5sR3OLoNKfyq0aEKxNcwA/leBOOqYpfy2R/VgiClwV
         8YSPNal1FRanr4Z2QuCyuGxwsilC7QkFrhUpH3L8Qcy//ZDM7T6sQEHzX6YUXq2U1JqX
         eJpQkfgVXQooRzi2GmHr8/CQiW9yFnwzlSHNkUOw0KIVM8yZJzBeIGxbwAo7wJjn9mB3
         zEJ5n8CzP7nABt3UhwcYMadDt4sMDN/38PVCvt96XbvSfHEGs2j2LVcMgVwRqUQpijKs
         cTEhZfsS4MQyvLVUZrdjPHSptfz8O6zt66bW00rwHUDWw/fFIgSuAAY61XxJW3ea17+G
         FVjQ==
X-Gm-Message-State: APt69E1YX+W8OPgjX63LIg07jY4VQ9WZ01r4277tKcpDwqvc3QAF7Mg+
        DZculMvWFWUZ6vtQxZKl6tEKheuoh5HURmJJN7o=
X-Google-Smtp-Source: AAOMgpfI2dasnYlrZjnGiRRFMMxnCJJwtxKO69iVismKLxjBcB+t7XhOLCCFdcIgRfYKsZNczUuUNTbpkl9Fis6oDRM=
X-Received: by 2002:a24:6bd7:: with SMTP id v206-v6mr7204141itc.129.1530173292988;
 Thu, 28 Jun 2018 01:08:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:2293:0:0:0:0:0 with HTTP; Thu, 28 Jun 2018 01:08:12
 -0700 (PDT)
In-Reply-To: <20180628074655.5756-3-predatoramigo@gmail.com>
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-3-predatoramigo@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 28 Jun 2018 10:08:12 +0200
Message-ID: <CAP8UFD2+7hRAHOTrYRZZad6OkGDM3CjnOJ3qcWUhS3R9-dn6bg@mail.gmail.com>
Subject: Re: [PATCH 2/5] rebase: start implementing it as a builtin
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 9:46 AM, Pratik Karki <predatoramigo@gmail.com> wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> new file mode 100644
> index 000000000..1152b7229
> --- /dev/null
> +++ b/builtin/rebase.c
> @@ -0,0 +1,55 @@
> +/*
> + * "git rebase" builtin command
> + *
> + * Copyright (c) 2018 Pratik Karki
> + */

[...]

> +       die("TODO");
> +}
> \ No newline at end of file

Please add a newline at the end of the files you create.
