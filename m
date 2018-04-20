Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F128D1F404
	for <e@80x24.org>; Fri, 20 Apr 2018 17:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbeDTRCd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 13:02:33 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:36555 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDTRCc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 13:02:32 -0400
Received: by mail-ua0-f176.google.com with SMTP id v4so6148964uaj.3
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 10:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t1DKd4VGLmuDTkIKEBdMLjO/LPV5QahMdFZmB4zEMH4=;
        b=PGthWTbOqpMWvSlFjeGCc7+CGU63alqrcdH6/AWAL2wC7AB5XkwsHLpyrUbynIVQ9I
         BKvYW/GWXUhs3ObSmXzU23CVNuJktslEAlysldcV+E4oIyKWsOlMI0bcMx79ZQ2mCxL5
         oyHjB/z/V1IFGCVDDYv8oK/XWQMPdFLGH2kGhFdADIVCQgCozsDiKHgk1r/X0QXNlLNq
         tWKhcXztpaZsd4pyKCZt9PQckK+te5GtYzRIsNpYFAeQcasv4p2fhTXSsiDDs9yaCtaj
         C2z7kn8N/oQTn81c5OLKTFSCe3ZWaVc5Rou62kV1K19C0CRfoGU/dZWVmGKqePElS5U0
         LToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t1DKd4VGLmuDTkIKEBdMLjO/LPV5QahMdFZmB4zEMH4=;
        b=KxP9ew1PNrO0+dcGi9TMcGf0HUAcff3VUr0Sir5mDY4s6IWW847hpvbECmGKYICk3m
         FI5D5bLFiQSzrTS6nQ45ZiEhy/y1e5V/0myC2gGVo02jVgDNfvusFtq+JNBUV9NYW2K/
         HfQ1Pc2UdkgRSS5IBXTVyO5uK4g8lWkmktbu+FfubR6g0crxF73K0/MQ/w79oN8UYDSk
         zf1aEypWyGukTDBKyz6cVkr9Js+eQqaiheQs6EzY44gjhT8IqF7iouzjCQeDNHy8NEyK
         /GNa80ELx+G95x8crfi4iCPSF5Vtt+rNo7Vgx3jK4P+bRy3BZA5uW+8XvCbIwIiYJBAg
         G7xQ==
X-Gm-Message-State: ALQs6tDnVrk4rBH2kHy0C2VCJB9va2kIvSyBvrbyRV3c9nXrh4rwFOvc
        NfMGtr5iEw8aQ+lnZRGGx1H7kaQO0aG0OedHL0E=
X-Google-Smtp-Source: AIpwx49sAIxEqfcAGZPEf+mlKT+829uRj/QSM4X4b9aFmBsD2AuKky6wOfAKEryy3Agc4fbEKrzYQS6CrdTNrJYCQ6o=
X-Received: by 10.159.56.15 with SMTP id p15mr5085804uad.112.1524243751853;
 Fri, 20 Apr 2018 10:02:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 20 Apr 2018 10:02:30 -0700 (PDT)
In-Reply-To: <20180420133632.17580-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com> <20180420133632.17580-2-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Apr 2018 10:02:30 -0700
Message-ID: <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> --- a/Documentation/merge-config.txt
> +++ b/Documentation/merge-config.txt
> @@ -37,6 +37,11 @@ merge.renameLimit::
>         during a merge; if not specified, defaults to the value of
>         diff.renameLimit.
>
> +merge.renames::
> +       Whether and how Git detects renames.  If set to "false",
> +       rename detection is disabled. If set to "true", basic rename
> +       detection is enabled. This is the default.

One can already control o->detect_rename via the -Xno-renames and
-Xfind-renames options.  I think the documentation should mention that
"false" is the same as passing -Xno-renames, and "true" is the same as
passing -Xfind-renames.  However, find-renames does take similarity
threshold as a parameter, so there's a question whether this option
should provide some way to do the same.  I'm not sure the answer to
that; it may be that we'd want a separate config option for that, and
we can wait to add it until someone actually wants it.

>  merge.renormalize::
>         Tell Git that canonical representation of files in the
>         repository has changed over time (e.g. earlier commits record
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 9c05eb7f70..cd5367e890 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3256,6 +3256,7 @@ static void merge_recursive_config(struct merge_options *o)
>         git_config_get_int("merge.verbosity", &o->verbosity);
>         git_config_get_int("diff.renamelimit", &o->diff_rename_limit);
>         git_config_get_int("merge.renamelimit", &o->merge_rename_limit);
> +       git_config_get_bool("merge.renames", &o->detect_rename);
>         git_config(git_xmerge_config, NULL);
>  }

I would expect an explicitly passed -Xno-renames or -Xfind-renames to
override the config setting.  Could you check if that's the case?

Also, if someone sets merge.renameLimit (to anything) and sets
merge.renames to false, then they've got a contradictory setup.  Does
it make sense to check and warn about that anywhere?
