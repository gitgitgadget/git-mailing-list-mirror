Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94E9020229
	for <e@80x24.org>; Tue,  1 Nov 2016 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752305AbcKAQxM (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Nov 2016 12:53:12 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:36469 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751439AbcKAQxL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2016 12:53:11 -0400
Received: by mail-qk0-f182.google.com with SMTP id o68so206743726qkf.3
        for <git@vger.kernel.org>; Tue, 01 Nov 2016 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DEHjUFx44rvqmJj0hLttnVptoYZFWtyldHtjehPbh7s=;
        b=fyDjeHxA53uEE8JmLAE3cxSMvYGjCGLYYC1JOgmaG4LhFMCPB1osWq3QG7JT/eJrA/
         VyyGeQvLB+DPAcNtptzt0b/FOCyFi5GOX1u2yUbnLRo1WMwqf0T1IHsq1gnG4lw3RktN
         WdceP3DZDbJSv0435sxfdswOE59VYyaL7Dxk+/kwyX76qyVdQDdS0FO0l3xonvuVrmDq
         cCm8O3aHxxRYpenMIyB0Vp2Zfq7sOq2HhFuZOiqA9l324dT7XbfK9eSvj84vNuOPvvef
         L6uJxIndE3o5YkD4S1Chh6Jdw7Smw+lYTdRtD+cMApe3ZxminQ6PCrKdQZNTeYxChrNw
         vcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DEHjUFx44rvqmJj0hLttnVptoYZFWtyldHtjehPbh7s=;
        b=FT3bbyHkoyjJNwZcv0K0Z3JwfidKGZyDh4rQoVTYtrBTgx9Luk7hKyv4EOYYsZSKPH
         yfeAdShrMo9JAMByvdfIbVyu80DbDubyG+72QqA0YI0185p1PvS6NN6cYST8PWIYHrlF
         kB37SxIvRYEBmqlfeRDUvhdGAxEN+l6/gcjZX0z+C9IjV7SXPypL3KfOFxKjwjxF406y
         ku/4xP1L6on7saXCmttPwsOe+WIcbaLqKaDifnr0hVb/5b0DGqoPbI434RALYnlb/E6b
         k9JPxMm2/MCDQ2C2/+kIRFmVYAn4+RjzM39l/aKDwmAKcv6duuNgF35FknXCxgR699DA
         xi4Q==
X-Gm-Message-State: ABUngvejEJxhH44zLDKWZkUozSoATAFTp8gnzmnLshqbgDvNYYvjaZkzbRbSH6R0zI1smf03HQ78QdY781+UAeqs
X-Received: by 10.55.64.80 with SMTP id n77mr33274633qka.173.1478019190870;
 Tue, 01 Nov 2016 09:53:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Tue, 1 Nov 2016 09:53:10 -0700 (PDT)
In-Reply-To: <1477953496-103596-4-git-send-email-bmwill@google.com>
References: <20161027223834.35312-1-bmwill@google.com> <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-4-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 Nov 2016 09:53:10 -0700
Message-ID: <CAGZ79kYwuM7MszUZyWYxZkWM6wiNG+sw7F+sgt_TJA8Qxg_27g@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] grep: add submodules as a grep source type
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2016 at 3:38 PM, Brandon Williams <bmwill@google.com> wrote:
> Add `GREP_SOURCE_SUBMODULE` as a grep_source type and cases for this new
> type in the various switch statements in grep.c.
>
> When initializing a grep_source with type `GREP_SOURCE_SUBMODULE` the
> identifier can either be NULL (to indicate that the working tree will be
> used) or a SHA1 (the REV of the submodule to be grep'd).  If the
> identifier is a SHA1 then we want to fall through to the
> `GREP_SOURCE_SHA1` case to handle the copying of the SHA1.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>

This patch only adds the (de-)initialization for the new type,
it is not yet made use of. Looks good.

Thanks,
Stefan

> ---
>  grep.c | 16 +++++++++++++++-
>  grep.h |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/grep.c b/grep.c
> index 1194d35..0dbdc1d 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -1735,12 +1735,23 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
>         case GREP_SOURCE_FILE:
>                 gs->identifier = xstrdup(identifier);
>                 break;
> +       case GREP_SOURCE_SUBMODULE:
> +               if (!identifier) {
> +                       gs->identifier = NULL;
> +                       break;
> +               }
> +               /*
> +                * FALL THROUGH
> +                * If the identifier is non-NULL (in the submodule case) it
> +                * will be a SHA1 that needs to be copied.
> +                */
>         case GREP_SOURCE_SHA1:
>                 gs->identifier = xmalloc(20);
>                 hashcpy(gs->identifier, identifier);
>                 break;
>         case GREP_SOURCE_BUF:
>                 gs->identifier = NULL;
> +               break;
>         }
>  }
>
> @@ -1760,6 +1771,7 @@ void grep_source_clear_data(struct grep_source *gs)
>         switch (gs->type) {
>         case GREP_SOURCE_FILE:
>         case GREP_SOURCE_SHA1:
> +       case GREP_SOURCE_SUBMODULE:
>                 free(gs->buf);
>                 gs->buf = NULL;
>                 gs->size = 0;
> @@ -1831,8 +1843,10 @@ static int grep_source_load(struct grep_source *gs)
>                 return grep_source_load_sha1(gs);
>         case GREP_SOURCE_BUF:
>                 return gs->buf ? 0 : -1;
> +       case GREP_SOURCE_SUBMODULE:
> +               break;
>         }
> -       die("BUG: invalid grep_source type");
> +       die("BUG: invalid grep_source type to load");
>  }
>
>  void grep_source_load_driver(struct grep_source *gs)
> diff --git a/grep.h b/grep.h
> index 5856a23..267534c 100644
> --- a/grep.h
> +++ b/grep.h
> @@ -161,6 +161,7 @@ struct grep_source {
>                 GREP_SOURCE_SHA1,
>                 GREP_SOURCE_FILE,
>                 GREP_SOURCE_BUF,
> +               GREP_SOURCE_SUBMODULE,
>         } type;
>         void *identifier;
>
> --
> 2.8.0.rc3.226.g39d4020
>
