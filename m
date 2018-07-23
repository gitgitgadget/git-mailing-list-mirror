Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D1791F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388574AbeGWRY0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:24:26 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:56058 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388443AbeGWRY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:24:26 -0400
Received: by mail-it0-f68.google.com with SMTP id 16-v6so2367897itl.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXvzWFLfxmy1jpsCKQMPed5h3vm/kPQm0gNPJVSXRKg=;
        b=bkm9Lk/v7UVAxb9XBm0gqinVWGfQKTba6UGC5pz0OULgWfr8B+6vrxwOkh+ed2pc6U
         e7M89IUcjUsirhQIvJW3xb1+NFWJgOklc1F3bzzX+VJ/ASrx1v+lbxj50VkMu8MWeVRy
         hxqzno5bPPRm9jqdPPCtiZHuc8HSd04czDLZVSu7/ptKioz4gaK+9AeRiGpvPqiNXaRL
         hYb8CNyyn7g442+Pd5QWuQ2jSXd7hirXPB3CROYSquEARPCDACi26y0LoOB+wy+9iEFD
         31l3dXn0lKM9P4v6CN2Z3RZY97McfHvCa1rQYx4Fguui4Z42Y9H3rhjXP+6qSjkMY2G+
         mgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXvzWFLfxmy1jpsCKQMPed5h3vm/kPQm0gNPJVSXRKg=;
        b=pW6ao3fnMf2QQPhOOtWST0kCVIwMfpu8xUjCltvPN3S6xsHYxAHN7XrZaUeKzm4Cb4
         FlpZ/J03FN+9FVCCDx1aRZdeIR+aEdUKBKFKj8GcFayUb39lU6EidsnMTFSKgXk9rUw2
         aZrj87tatKLHSld9P4oA7TaFCYR7QZ6JcTQoFYOmEGu+OpZjX3ushC6F0oT4701Z1Mc/
         cOsMoxoxe0EZ8Zzf+PSlLYDzNTu8uiPUvo6ewa4KN8FTgD6QMgjmiJ4SfoDUbP0+COCA
         VWWIPIKg7ymLMSmq7HWxzY0/8I8zqr2Kz9ek/VGkRsEWK7z8RtMf0rPrL8qdXTceVDss
         Horg==
X-Gm-Message-State: AOUpUlF2GbgkdcnAwWdAANWduqa+JhhbwtT4tch7ePRulPfGAdI/3Pa4
        rHcsdvGm7fQriThLR4CCcvtF5E/whMk4t0Op35o=
X-Google-Smtp-Source: AAOMgpcdulj5qsVm53Yz1hTsMq7MZZgkMzLB6bsWlnbXPaZ9oM1E7ULy32kjGP5yYbynarY6zxH4baidArKl6DD4ioM=
X-Received: by 2002:a24:610d:: with SMTP id s13-v6mr10973871itc.68.1532362946803;
 Mon, 23 Jul 2018 09:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-7-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-7-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 18:22:00 +0200
Message-ID: <CACsJy8Aw6R8-3kDfhCqunXziajCg9O_1WrEYc4rfKa+-=m1D5g@mail.gmail.com>
Subject: Re: [PATCH 06/14] format-patch: allow --interdiff to apply to a lone-patch
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

On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> diff --git a/log-tree.c b/log-tree.c
> index 9d38f1cf79..56513fa83d 100644
> --- a/log-tree.c
> +++ b/log-tree.c
> @@ -14,6 +14,7 @@
>  #include "sequencer.h"
>  #include "line-log.h"
>  #include "help.h"
> +#include "interdiff.h"
>
>  static struct decoration name_decoration = { "object names" };
>  static int decoration_loaded;
> @@ -736,6 +737,19 @@ void show_log(struct rev_info *opt)
>
>         strbuf_release(&msgbuf);
>         free(ctx.notes_message);
> +
> +       if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {

OK putting idiff stuff in rev_info is probably the right choice. But
we all three fields prefixed with idiff_, maybe you could just add a
new struct "idiff_options" to contain them and add a pointer to that
struct in rev_info. Then "opt->idiff" is enough to know if idiff is
requested instead of relying on idiff_oid1 (seems too random).

> +               struct diff_queue_struct dq;
> +
> +               memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
> +               DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +               next_commentary_block(opt, NULL);
> +               fprintf_ln(opt->diffopt.file, "%s", opt->idiff_title);
> +               show_interdiff(opt, 2);
> +
> +               memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
> +       }
>  }
-- 
Duy
