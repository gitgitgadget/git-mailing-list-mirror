Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C421D1F406
	for <e@80x24.org>; Wed, 16 May 2018 01:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeEPBgH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 21:36:07 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:42319 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeEPBgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 21:36:06 -0400
Received: by mail-ua0-f196.google.com with SMTP id f3-v6so1489031uan.9
        for <git@vger.kernel.org>; Tue, 15 May 2018 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dY3gPScjoR38jO2/7a5dgVJv/aU95ZK5bABF2g5Aezk=;
        b=B9V1PS7hD4EqFdbrpSA/RmGutjHXguAMHl/fpyAEk2xlwKQOGIWqnpCXquKxZ2KK9D
         YZEtPJ4k9G7TJcmSnomAaf7jOg+8behvVHMZuM7BQmNE3LkU9mYMhM5T29QQ9HBi0FgW
         gfOuVEOG6K6QWGh8gEGJZe/xaGwLxJS54sOcRElhkMVxI/6rddLikYoa8Wf34NIg9ec0
         tlvOtOx3KgdH6JoNrDWNsMA5z7fime+qSisL7KzqAnLcnNC9Q1sNACpv4e5x9ASlaeTT
         78h61QWyf9pra3C+ONpU91P8wqDojOqiYo8rro4vTnvCJe9ZWOi9iLsORI/yN0oKVZoF
         WekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dY3gPScjoR38jO2/7a5dgVJv/aU95ZK5bABF2g5Aezk=;
        b=bK4Glehvolo/2o2qzug/4VO/1xWlAmB49E44dB5pm5PbJPLJOVSB10lCmbnfbciE7w
         9p0kC42k9ZJqlnV2xpq5rKjvB0yAlC+TIzp0V8Au/joX6vg5eKq2XDrQc0SoJazs6ghe
         7nKD/RGjhO26MzH9aVq7iFpkEUL1cspOQex9/HtlH86T8yHStrRBibcEUY9bThd6xFhT
         4T9J+8pg1jpc0yvLF1rXKyeAdZPR+NfLZgems5nF1ksqNn24s6CdJaSJdBqe/2IqG/X4
         55zhcLlK6u+xGgHe4S/9+TKU+CYC96u0ovMaM2VdSOMfUMKuFK5xK8BPFLkyvtTeTPq9
         hzbQ==
X-Gm-Message-State: ALKqPwcfVhueFw9xlR42cr9AoEcFxhjtNn0IEMS/wGPvZl6a6zG7e0l1
        4OcourFAwNdmdMpTtzhuVd2pK0w8uK/XDv5dj1E=
X-Google-Smtp-Source: AB8JxZqOKMSQsJ6QfmerSWnJkAtAFsd4GxO+NtHkU6KgjWr7wquaFvf1k1XkggS4FPQd+ruj7yB3c2GVnPm9wUYBYXM=
X-Received: by 2002:a9f:380f:: with SMTP id p15-v6mr18543794uad.112.1526434566060;
 Tue, 15 May 2018 18:36:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 15 May 2018 18:36:04 -0700 (PDT)
In-Reply-To: <20180515200030.88731-6-sbeller@google.com>
References: <20180515200030.88731-1-sbeller@google.com> <20180515200030.88731-6-sbeller@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 May 2018 18:36:04 -0700
Message-ID: <CABPp-BH3mi5L+9QKXQAK0sp8z9zzfpwYY9R-itkfOo3CYTUo6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] Inform about fast-forwarding of submodules during merge
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Leif Middelschulte <leif.middelschulte@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 15, 2018 at 1:00 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Leif Middelschulte <Leif.Middelschulte@gmail.com>
>
> Inform the user about an automatically fast-forwarded submodule. The
> silent merge behavior was introduced by commit 68d03e4a6e44 ("Implement
> automatic fast-forward merge for submodules", 2010-07-07)).
>
> Signed-off-by: Leif Middelschulte <Leif.Middelschulte@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  merge-recursive.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 0571919ee0a..29a430c418a 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -1093,10 +1093,26 @@ static int merge_submodule(struct merge_options *o,
>         /* Case #1: a is contained in b or vice versa */
>         if (in_merge_bases(commit_a, commit_b)) {
>                 oidcpy(result, b);
> +               if (show(o, 3)) {
> +                       output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);

Seems slightly odd to mix 3 and 1 here; although it'll work just fine,
I would have expected use of 3 in both places (much like you did with
the 2 and 2 below).

> +                       output_commit_title(o, commit_b);
> +               } else if (show(o, 2))
> +                       output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(b));
> +               else
> +                       ; /* no output */
> +
>                 return 1;
>         }
>         if (in_merge_bases(commit_b, commit_a)) {
>                 oidcpy(result, a);
> +               if (show(o, 3)) {
> +                       output(o, 1, _("Fast-forwarding submodule %s to the following commit:"), path);

Same.

> +                       output_commit_title(o, commit_a);
> +               } else if (show(o, 2))
> +                       output(o, 2, _("Fast-forwarding submodule %s to %s"), path, oid_to_hex(a));
> +               else
> +                       ; /* no output */
> +
>                 return 1;
>         }
>
> --
> 2.17.0.582.gccdcbd54c44.dirty

Other than that nit-pick, looks good to me.
