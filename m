Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 768BB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:49:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753728AbdJaVtH (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:49:07 -0400
Received: from mail-qt0-f172.google.com ([209.85.216.172]:53463 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbdJaVtG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:49:06 -0400
Received: by mail-qt0-f172.google.com with SMTP id n61so545033qte.10
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vuGBENzt3UPsCD4nNeFMgvlRD4bYqI1+gVpEfv3ftnc=;
        b=Yd9GW4Z0PwX23hTcpEL3jq08KdKOtWKOO/FpBwiDLOQy9eeFoUrOqY2sXwwCIXU+84
         UmHH9bjbcHURC40HxtfGwXo+nxCt/hVIG9rDrPBcQNExY5kNsNtlTq36ZTRlQNOVuzht
         77/cVWhqdnftKDbA/MLyprXaEZbDgjtGADI/OEGQrLh+wLIbt+o9RodhHQ6AZEUs1yJJ
         P6JOgak/9WrE4eBrsedMTUYuQbATWyfDGb0153GxeW5u92kA+n9HmFXquhOPah1BZiIQ
         fmdeB2m3bfkv/lq1tWvzVmcth6ot9zJoiml3aDVdnc57EEqW6h1Zr1PjEuzKlSAwIefa
         Oh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vuGBENzt3UPsCD4nNeFMgvlRD4bYqI1+gVpEfv3ftnc=;
        b=JxNURa4gJZZK5xUitT+zGbGk6Ta7pSOTSO3C6Ijuz1XJmfPqj1RmUfhBzSuNeCeyMR
         dmiw0l4kqIKDcl6x/NiEL5+nmZcOzXO2nd+aEmHoRrpa6xvzcXl4TqM1o6WltnUa7SJW
         qGV5Qe2NEHwOVBfdaxBRuiSPSwkh1NE8QhWudXAvtFZUsDKKIEMq9UNqfGx1obxCPKP7
         ixfODhlr6BgYpwLv78FhGGBoQGx/46OdkTiL7ffYcfPkr12nPVG6eriiK47Dm2TQj1Hn
         E9KZ5IwMkhiJeZW+xYSO/zFrzybYTkzRMtThzXd5jP92/Z/FO6ZWzFaHhQ2gI/JuX8VJ
         x68A==
X-Gm-Message-State: AMCzsaVgqIIJafq3iqRATjl6PWE+yxgHI1qshpcW9RPPLT3GIZb+DPxM
        gKgTnqZATIYnk++ZCjKT+7j4gac64nC2erFNf+SJ3w==
X-Google-Smtp-Source: ABhQp+TOFMgIYQKnuieHSplcNCZDHUzhwQNh8flx5WffWjhJhm9jZ60lhn2muV6PXhvmv0CaT9W+iASMobslD+//qmE=
X-Received: by 10.200.46.114 with SMTP id s47mr5122647qta.165.1509486545411;
 Tue, 31 Oct 2017 14:49:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Tue, 31 Oct 2017 14:49:05 -0700 (PDT)
In-Reply-To: <20171031211852.13001-7-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com> <20171031211852.13001-1-sbeller@google.com>
 <20171031211852.13001-7-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 31 Oct 2017 17:49:05 -0400
X-Google-Sender-Auth: KlWz4GZuSqMeAmmkH5H-Zr2JtaM
Message-ID: <CAPig+cRz6EjdEGUjdMiB8979VybKN8Xza9uUDKNuxKNn+pY8jA@mail.gmail.com>
Subject: Re: [PATCHv2 6/7] builtin/describe.c: describe a blob
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Kevin Daudt <me@ikke.info>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 5:18 PM, Stefan Beller <sbeller@google.com> wrote:
> When describing commits, we try to anchor them to tags or refs, as these
> are conceptually on a higher level than the commit. And if there is no ref
> or tag that matches exactly, we're out of luck.  So we employ a heuristic
> to make up a name for the commit. These names are ambivalent, there might

I guess you meant s/ambivalent/ambiguous/ ?

> be different tags or refs to anchor to, and there might be different
> path in the DAG to travel to arrive at the commit precisely.
>
> [1] https://stackoverflow.com/questions/223678/which-commit-has-this-blob
> Signed-off-by: Stefan Beller <sbeller@google.com>

Blank line before sign-off.

> ---
> diff --git a/builtin/describe.c b/builtin/describe.c
> @@ -445,11 +495,16 @@ static void describe(const char *arg, int last_one)
>
>         if (get_oid(arg, &oid))
>                 die(_("Not a valid object name %s"), arg);
> -       cmit = lookup_commit_reference(&oid);
> -       if (!cmit)
> -               die(_("%s is not a valid '%s' object"), arg, commit_type);
> +       cmit = lookup_commit_reference_gently(&oid, 1);
>
> -       describe_commit(&oid, &sb);
> +       if (cmit) {
> +               describe_commit(&oid, &sb);
> +       } else {
> +               if (lookup_blob(&oid))
> +                       describe_blob(oid, &sb);
> +               else
> +                       die(_("%s is neither a commit nor blob"), arg);
> +       }

Not at all worth a re-roll, but less nesting and a bit less noisy:

    if (cmt)
        describe_commit(...);
    else if (lookup_blob(...))
        describe_blob(...);
    else
        die(...);
