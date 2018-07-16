Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DF861F597
	for <e@80x24.org>; Mon, 16 Jul 2018 19:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbeGPTjs (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 15:39:48 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36075 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729466AbeGPTjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 15:39:48 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so15852576ybk.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 12:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bugm38/h0WfZiGgNRMjF9v+Qhb0hvoIxPePq33HITV8=;
        b=CHoxj29+8Ka2jslTYhkr4gpcHX6EGaStX8w5/x0BAivNXVOIYgkuBw8jpFxvrOz37/
         4MfUkum8j0SIJp4VfuN5tr7hJztC2wGRUQ2pLfG6iALPPcMDZ8vC4l5FZ5hSX5IoP1QE
         MGaGHqB625p8id5vjVX/pyai1NKnerv+K4GlTb+755WM6HIT0PDDR+hHTx5glbdBOSYx
         HP9X6fXFu/awp9ZxZ3NJjmscio9SLhiDw6mrXugNsBgobRnHaYu7L+BaodoOhZWlocZg
         p+9B93B2J1jrIOrd0DHttlzXrbqfafFu4mPnk93ssnBzAEhpo5QtRTKxbhymZakATx+W
         +koA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bugm38/h0WfZiGgNRMjF9v+Qhb0hvoIxPePq33HITV8=;
        b=RsY8EBbmdsrp0Cgte3df/MIRSjIWBAmtQcCxAQfc4S98xuoYyHXzFcFlwYOjrRyglz
         eR51bDQE05kOGZ0cdkv4kpcPVwXQ+F10tTi8btxHwlpsZc0yy/8GPvJg8RYxkppPwOD/
         4eDBQmz0eBSEsE+4egTBgX+M3BuFZHz+1j+/DJKh7t0rVrL8MX534zLU43WgZv71rKUz
         zZvn/C5J/87EIHLsAujKesCBSGFKZcW+w05+Z2EcedADeaRF80m35s5hGNDpROm96Evc
         yxpBw7aYyGnKfYF0WlmOyO5ddrBeUizRkxBNVqg/q77S9KU17DRqayR+3cx4pXLWLRtt
         Jpcg==
X-Gm-Message-State: AOUpUlHRf+uAODpfFr+6Dp6oVpT7FhjmrwdfrcXUOPUuXmf0EEnhE/I0
        iJMv5KlRMW0p5RmDcmwKGOTBgZ5SYIuizg0iAYWjNg==
X-Google-Smtp-Source: AAOMgpew9q0vZaqOL314+WiMcyepA62KMui5lLCccEQWnmkcQpnjHP1UkkcEjr0H7YeZr1F0Hhqdhu9QNcH2+BNVlw4=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr9497485ybi.247.1531768261008;
 Mon, 16 Jul 2018 12:11:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <7a6d1cbe12efa0a452a977f1f6bb8c618421040b.1531746010.git.gitgitgadget@gmail.com>
In-Reply-To: <7a6d1cbe12efa0a452a977f1f6bb8c618421040b.1531746010.git.gitgitgadget@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 16 Jul 2018 12:10:50 -0700
Message-ID: <CAGZ79kZh42em1mQ+LQuzN8UTqY2MCutrS8eXAh-FvzEBVGcmGg@mail.gmail.com>
Subject: Re: [PATCH 02/16] commit-reach: move ref_newer from remote.c
To:     gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

Another verbatim move!
(I'll just re-iterate that the --color-moved option is very helpful in
these reviews)

Thanks,
Stefan

> +++ b/commit-reach.h
> @@ -38,4 +38,6 @@ struct commit_list *reduce_heads(struct commit_list *heads);
>   */
>  void reduce_heads_replace(struct commit_list **heads);
>
> +int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
> +

Bonus points for docs on ref_newer!

> +++ b/http-push.c
> @@ -14,6 +14,7 @@
>  #include "argv-array.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "commit-reach.h"
>
>

Double new line here?
I missed that in p1, it would be nice if you could fix that up.
