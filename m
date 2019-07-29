Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D22D1F462
	for <e@80x24.org>; Mon, 29 Jul 2019 14:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbfG2OGJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jul 2019 10:06:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36244 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfG2OGI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jul 2019 10:06:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id r7so28105559pfl.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2019 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=L/pEyk89AD7GjxMUviedJCLt9q5DR7BC67Om0SwaSV0=;
        b=Ys6dpLQTigwhGrKzdB9mD6zgiJjM2hIWtd2u1UuhGm0rWYPliIOFkLHt8h+97Gha9g
         tjgdO0GfLwIx03vAGPSu8VEBa9Tp1HsNwljbm0MrofCUkNIzouVF7d1PS9jLgTtH4U0T
         KXsHffsBWKSc/R102tlvIJfnaEZi8dRPDZ032yGGspzMF5VqFVPQlyDgaHCDq2zjzAdH
         xuAzZNZl7u2mt1zxWEBV3sX3j0YkBAb8Px+S5BavZc/5mMCk0Dm8TEm7OY0oDsi85uxs
         neUMlOXgLHaVGWmB8mNB8+WIIiyPGuhxqQ/XvbOyoxK8igB2ctDeSxQ3NmPoreiM3tCP
         bhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=L/pEyk89AD7GjxMUviedJCLt9q5DR7BC67Om0SwaSV0=;
        b=PONCNiHF1669fEB+eVFWJaUTMYrmUlhNCTlM6sMqMvrLXDw2o45UbGNYbVxl8dnuh+
         gRSlLmyFkj3r2In8sp5UZuoTZs6ZQYUahVCJyym5bpYdw7XemSdB1tIesJCyYcypK47F
         wHau0mQYhYL6Xsral05qnt9HAQ/gr7DDue2dLUr5pd7qvztjzLmW7KnkNp6yrb1gjebL
         4s55zlgWYqHY7mShVTQ2vohINsH2QDp9L5xOVlI1AKrSOkym3Gzp0n71xPMcrMUhnZMt
         YfTdq+X8jH3S0hjvfF0+AJEL2mqsK1GKUqpkQrFbWZhekZbr1Bp1yCSe2wo/EJ28zXWg
         +y6w==
X-Gm-Message-State: APjAAAXpCVF1TU4iJGWab9pi3NHCACys+eNZAwlP8CES+IUWDxBYW8ea
        MSonAsOAKBBc5Q+vMl0D/uD6yUAIY42BTVznP08y+Z9b
X-Google-Smtp-Source: APXvYqy3JDP6DuKASrIn+IfYlpq/QuBjJziyyP+XL/cf+qzsjO3Q5I5FBIb8i0cpZyyTtiw8JYKyK2yP7uiiX+2azSI=
X-Received: by 2002:aa7:989a:: with SMTP id r26mr24589989pfl.232.1564409168065;
 Mon, 29 Jul 2019 07:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190719053952.13516-1-eantoranz@gmail.com>
In-Reply-To: <20190719053952.13516-1-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Mon, 29 Jul 2019 08:05:57 -0600
Message-ID: <CAOc6etZaNG9gU89S491emSr7PHj9a+p+_0gNYT+BWcydadM+NA@mail.gmail.com>
Subject: Re: [PATCH v3] builtin/merge: support --squash --commit
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 18, 2019 at 11:40 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> Using --squash made git stop regardless of conflicts so that the
> user could finish the operation with a later call to git-commit.
>
> Now --squash --commit allows for the operation to finish with the
> new revision if there are no conflicts. If the user does not use
> --commit, then --no-commit is used as default so that it doesn't
> break previous git behavior.
>

What should I do to get this patch to move forward? Either get
comments (as the previous versions did... thanks, Junio!) or be
accepted? Given that I didn't get a feedback I thought that it had
made it (always the optimistic) but I see that it's not in Junio's
'what's cooking' mail from friday so I think it's fair to assume that
this version of the patch is not gonna fly.

Thanks in advance!
