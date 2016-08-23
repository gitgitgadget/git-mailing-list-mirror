Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84CE11FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754122AbcHWW7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:59:25 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35604 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbcHWW7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:59:24 -0400
Received: by mail-yw0-f193.google.com with SMTP id r9so5788790ywg.2
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=txdqggXYVrRJ/GEpHn7hvaSmA+39Iuiq8z5J3dUA9Lw=;
        b=jMJbY9BWPNpSBVE1ernLkCBwA3d9fYZXf4A3Fy7jA7TafI7ZdY4af3m6qXRzlQNf5K
         9wCnfan6EQKDVd7nlsXY/KQ/uNpLAeLUbtGZx+tFuDsH7yW5ljzj78Df1wqgyIUFJsmZ
         Np+e9jPxdmJlpiyifWmnQUkoC/j/a0tXFLONa9oUxoIM+oyWgjF+xikJA9DEaFJe2W4M
         J7lUvMtHAG6oXJbOyYAp44CO7sJdEXiWA83x+ugvs4gLcwF/uoqyUkHojaL6itVNFfux
         GTquELifQNC8fEPX23uAkICxrWQWveJR591tdLaAAkSFXBD/Ayqq64kcOmm5fcc1AxKA
         vBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=txdqggXYVrRJ/GEpHn7hvaSmA+39Iuiq8z5J3dUA9Lw=;
        b=KNtz0oqlic7F+i4Cz5Pnp+eX3749CWx9Cz+azPfhRlNtMiZp2wLVV1Zd2Dxpd8XZ07
         h1hyXhQsAbrEs9YZrmVKiJwvbJl6PuUynMctye829NkyiOnTeVXTl4gQvoOdqeRVhCz5
         o1spv24ZZ2e3YPiyxu+rLRWcDNynbsKPUIZTlZ8VxJgifZYFyjUQvND6c1cnGhWqSSMM
         3q/NUNgz1tq/6bjXYB5mA4aSF0BAtz65XkyB3puxfQ2eJVi+omjSBfGm6nTIsDQ9fPgR
         aoUSr/TV49JktAiWCejMXNULhfySGCTjCyG4yvk4fAXLCSKZkGsJjZ4wxc+GqFeSmcOq
         lOig==
X-Gm-Message-State: AEkoouucpzBZoU7f8wc8A+avji13REgmz0i97dIrM5rpLpwcd1Y9loeUv0+nf0yrxbvtRkFiPbqTB/gI/IeE/g==
X-Received: by 10.13.249.135 with SMTP id j129mr24830927ywf.267.1471992231084;
 Tue, 23 Aug 2016 15:43:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:43:30 -0700 (PDT)
In-Reply-To: <20160815215327.15682-9-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:43:30 -0700
Message-ID: <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> When `--recursive` and `--reference` is given, it is reasonable to
> expect that the submodules are created with references to the submodules
> of the given alternate for the superproject.
>
>   An initial attempt to do this was presented to the mailing list, which
>   used flags that are passed around ("--super-reference") that instructed
>   the submodule clone to look for a reference in the submodules of the
>   referenced superproject. This is not well thought out, as any further
>   `submodule update` should also respect the initial setup.
>
>   When a new  submodule is added to the superproject and the alternate
>   of the superproject does not know about that submodule yet, we rather
>   error out informing the user instead of being unclear if we did or did
>   not use a submodules alternate.
>
> To solve this problem introduce new options that store the configuration
> for what the user wanted originally.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  Documentation/config.txt       | 12 ++++++
>  builtin/clone.c                | 19 +++++++++
>  builtin/submodule--helper.c    | 87 ++++++++++++++++++++++++++++++++++++++++++
>  t/t7408-submodule-reference.sh | 43 +++++++++++++++++++++
>  4 files changed, 161 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index bc1c433..602f43a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2837,6 +2837,18 @@ submodule.fetchJobs::
>         in parallel. A value of 0 will give some reasonable default.
>         If unset, it defaults to 1.
>
> +submodule.alternateLocation::
> +       Specifies how the submodules obtain alternates when submodules are
> +       cloned. Possible values are `no`, `superproject`.
> +       By default `no` is assumed, which doesn't add references. When the
> +       value is set to `superproject` the submodule to be cloned computes
> +       its alternates location relative to the superprojects alternate.
> +
> +submodule.alternateErrorStrategy
> +       Specifies how to treat errors with the alternates for a submodule
> +       as computed via `submodule.alternateLocation`. Possible values are
> +       `ignore`, `info`, `die`.
> +
>  tag.forceSignAnnotated::
>         A boolean to specify whether annotated tags created should be GPG signed.
>         If `--annotate` is specified on the command line, it takes
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 0182665..404c5e8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -947,6 +947,25 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>                 else
>                         fprintf(stderr, _("Cloning into '%s'...\n"), dir);
>         }
> +
> +       if (option_recursive) {
> +               if (option_required_reference.nr &&
> +                   option_optional_reference.nr)
> +                       die(_("clone --recursive is not compatible with "
> +                             "both --reference and --reference-if-able"));

So if you have multiple references that don't all match we basically
just refuse to allow recursive?

Would it be better to simply assume that we want to die on missing
references instead of failing the clone here? That is, treat it so
that multiple reference and reference-if-able will die, and only info
if we got only reference-if-able?

Probably what's here is fine, and mixing reference and
reference-if-able doesn't make much sense.

Thanks,
Jake
