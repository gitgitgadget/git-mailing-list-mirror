Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4731020135
	for <e@80x24.org>; Thu,  9 Mar 2017 02:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750940AbdCIC3P (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 21:29:15 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35755 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdCIC3O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2017 21:29:14 -0500
Received: by mail-pf0-f180.google.com with SMTP id j5so22386343pfb.2
        for <git@vger.kernel.org>; Wed, 08 Mar 2017 18:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DN4f94rk3qFMUZ6NGJ5ziMgedo61hAT/yi3SJjuVe44=;
        b=Ewnhg/L0taEgfVN8dItEk8kJVIi3u/5P9luAcidQN0ej+ysSjF0qBQjcCQPewfBdEx
         93e0WGL0NZLkI1LOmcVZdC5L8OjQRwiYcUhQdZJcRsiBmnoCWooxrDQfjoJxyAwPdyIa
         9rgx10Uj7vjWCrP2+1X9RK59ayPkyReLa91oY0KhlCSNy0DMu/E8O8vXOpJ19+5YYqig
         +cSg+WA5dJ8h9at1PaAu+djwTTR5MspZfk45KgVXra1yQ02tE2ez/sl6eHsTkXqjwJwb
         nV5m04962IKg2qRUv7sPs7l5uZaBriRvn3Oqt8vpUN4q9QhuNRgFh3vJ18BFX9B6GhTu
         hASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DN4f94rk3qFMUZ6NGJ5ziMgedo61hAT/yi3SJjuVe44=;
        b=bhA45OdGryVJx5QwJWml9qy0zKrlGnibRUnZipbRhbqhRc31U7hrLlgoUx0VY5H2zK
         2D989yfrifIgTzJvA5izZCzWr59hilVmaQMXXkP7W+eTZHOfVraVI0kmTc06sYLm28Bk
         odGQCdbPEbby9/uS34+JaWKh02GeeB37s9lgMgEiP2WLMrbrZ2fo3wn1ctxRjMzssfFc
         oIvzQ9l5exD+kkEx/sUTJ7PHH6FDHtyf/zavi9kdwN23nn0YoBdQe3hCdbPD5xcsb7Ef
         r0vjQEqFWQpuvuODGsz4GSgkUbtF5fYBqH4z7+HeSEo3PhTBKupSG1D0y4EEz9aJpwQp
         NDwA==
X-Gm-Message-State: AMke39nA8r6BnD7S0Ct5/Q0iqc33cQKhZl8SiUVjlwt8gKe88d/mrIUtOYI23nx0cEMgP1mEbNIJxThIkOf9uNlf
X-Received: by 10.98.112.134 with SMTP id l128mr11001513pfc.81.1489026515445;
 Wed, 08 Mar 2017 18:28:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 8 Mar 2017 18:28:35 -0800 (PST)
In-Reply-To: <20170309012345.180702-11-bmwill@google.com>
References: <20170223234728.164111-1-bmwill@google.com> <20170309012345.180702-1-bmwill@google.com>
 <20170309012345.180702-11-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Mar 2017 18:28:35 -0800
Message-ID: <CAGZ79kYspNw4=dSnDtyWp7bEhggAM-gRo3g9GJ78jZ8HW7pUFQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] submodule--helper init: set submodule.<name>.active
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 8, 2017 at 5:23 PM, Brandon Williams <bmwill@google.com> wrote:
> When initializing a submodule set the submodule.<name>.active config to
> true to indicate that the submodule is active.

So by this patch an init of a submodule performs both
a "regular init" (copy URL and the update setting)
as well as setting the new submodule.<name>.active.

And both happens in the same config file (i.e. no worktree
support here)

Later on we *could* remove the URL as the .active is the new
flag of existence.

But enough of my speculation, I am left wondering what this
patch accomplishes, as this states no agenda as why it is useful
on its own.

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/submodule--helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index bceb62a20..44f2c02ba 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -329,6 +329,13 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>                 die(_("No url found for submodule path '%s' in .gitmodules"),
>                         displaypath);
>
> +       /* Set active flag for the submodule being initialized */
> +       if (!is_submodule_initialized(path)) {
> +               strbuf_reset(&sb);
> +               strbuf_addf(&sb, "submodule.%s.active", sub->name);
> +               git_config_set_gently(sb.buf, "true");
> +       }
> +
>         /*
>          * Copy url setting when it is not set yet.
>          * To look up the url in .git/config, we must not fall back to
> --
> 2.12.0.246.ga2ecc84866-goog
>
