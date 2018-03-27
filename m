Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEF91F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeC0Xu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:50:57 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:33523 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC0Xu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:50:56 -0400
Received: by mail-yb0-f176.google.com with SMTP id b4-v6so214114ybi.0
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WxmavZ//u7Sm4G+iarW6mmtZ7lwQ9l9PQ8j8rgWz0sw=;
        b=Y4s8Q39Fq+ejVUPw7hitd8eP72HN6czFHWLXlwNS+MKLgV/bEzc3yRX2+S5TJdgmPr
         WjR2fi1Uclm74F5kpBHl4vItnP27U3FJZKec4XqHoXIyS5/p7W/xlYphkzilgIQFEenc
         FPoK7+eed2ihJyckr8EbCBFmj3f3pSBNKokbbLz5CjmSlcrgC0eB92GSXuu/0SODo5Z4
         tL6Gu0D36YzohfBBII2ZB/VQWWjbJZ1oSLUW8havymCMOAA7rYaSwUe/r9MKIJIQOckG
         IwXjDzd8oEkpMgKsLUaHMcujOwE0iq6lXirBXwqFBmqE7Xo5UbQpP5Sy0CSuRoL4OJqG
         Ueog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WxmavZ//u7Sm4G+iarW6mmtZ7lwQ9l9PQ8j8rgWz0sw=;
        b=qUZxUK75g9a91V5GhCw+prcTeXP2xyHJ/KkXzUdlPnsfzdEBdhdjz8E5W+C7NLD1dO
         uA+m5N9EbOPK/J2iIM6SpgrCvXjK95QM7tqaTnZu2xxXSghpPgLMKDB+ZHZSmvqSiN8G
         BGlIveBYWUwsdlJTs+zvysfR2GpRzL3+yaRy2wG0vvL5MhN6DioUgj3I+mpenzpxHNYx
         01qLQGz/uqbo7gfVZDRX8y3ECCSkW1BMRGaJ/9cAFPM2YHEqexyshyaiPmNZzDAbCp2D
         R9wAAoyRcatxaYojcc6amQhslA6VqkorqiZT3OAPD27G6/tZIrUdkKmvFqkCR4cMLmOf
         39aQ==
X-Gm-Message-State: AElRT7GzxnHWND3B27mRLOEzxl70kx65PqGegJf7fM+lTIMN7cPl3FHw
        lRk54s46C2kZu5sy7108mloR7/Q+O3hO5O61wIZwUg==
X-Google-Smtp-Source: AIpwx48lsUtCITY9/6cIHtSzGnNuU05MldWmbxZ1mkuikoSp/ujLKO584tzA0UoVhGtTdEs6K1sZX7Pf+tUjejaVXIo=
X-Received: by 2002:a25:2782:: with SMTP id n124-v6mr917764ybn.307.1522194655281;
 Tue, 27 Mar 2018 16:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180325095046.GA687@feusi.co> <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
In-Reply-To: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 23:50:44 +0000
Message-ID: <CAGZ79kYagdvpOcZykF4JPQc9vpVb8_xyFiQkE9yznBQTD1PWJw@mail.gmail.com>
Subject: Re: Null pointer dereference in git-submodule
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     jeremy@feusi.co, git <git@vger.kernel.org>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 3:58 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:

> Am 25.03.2018 um 11:50 schrieb Jeremy Feusi:
> >
> > Hmm... That's weird. I can reproduce it on 3 independant systems with
> > versions 2.16.2 up, although it does not work with version 2.11.0.
> > Anyway, I figured out how to reproduce this bug. It is caused when a
> > submodule is added and then the directory it resides in is moved or
> > deleted without commiting. For example:
> >
> > git init
> > git submodule add https://github.com/git/git git
> > mv git git.BAK
> > git submodule status #this command segfaults

> With the patch I sent in my first reply the last command reports:

>          fatal: no ref store in submodule 'git'

> That may not be the most helpful message -- not just the ref store is
> missing, the whole submodule is gone!

> Come to think about it, this removal may be intended.  How about
> showing the submodule as not being initialized at that point?

At first I thought we could still retrieve the ref store via a lookup of
path -> name in .gitmodules and then navigate to
.git/modules<name>/ (as seen from the superproject)
and load the ref store. But loading the refstore is a mere detail.

"not initialized" is technically correct, the existing git directory
inside the superproject doesn't matter.


> -- >8 --
> Subject: [PATCH v2] submodule: check for NULL return of
get_submodule_ref_store()

Maybe more imperative, telling what we actually want
to achieve instead of what we do?

   submodule: report deleted submodules as not initialized

> If we can't find a ref store for a submodule then assume it the latter
> is not initialized (or was removed).  Print a status line accordingly
> instead of causing a segmentation fault by passing NULL as the first
> parameter of refs_head_ref().

Thanks for the message here. Looks good!

> Reported-by: Jeremy Feusi <jeremy@feusi.co>

Please also sign off instead of just claiming to report it.
(The sign off has legal implications, see
https://developercertificate.org/ or our copy in
Documentation/SubmittingPatches)

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> Test missing..

Which would be added in t/t7400-submodule-basic.sh

Thanks for coming up with a sensible patch!
Stefan


>   builtin/submodule--helper.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ee020d4749..ae3014ac5a 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -654,9 +654,13 @@ static void status_submodule(const char *path, const
struct object_id *ce_oid,
>                               displaypath);
>          } else if (!(flags & OPT_CACHED)) {
>                  struct object_id oid;
> +               struct ref_store *refs =3D get_submodule_ref_store(path);

> -               if (refs_head_ref(get_submodule_ref_store(path),
> -                                 handle_submodule_head_ref, &oid))
> +               if (!refs) {
> +                       print_status(flags, '-', path, ce_oid,
displaypath);
> +                       goto cleanup;
> +               }
> +               if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
>                          die(_("could not resolve HEAD ref inside the "
>                                "submodule '%s'"), path);

> --
> 2.17.0.rc1.38.g7c51fd80b8
