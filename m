Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C78FC20372
	for <e@80x24.org>; Fri,  6 Oct 2017 21:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbdJFVMy (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 17:12:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:52775 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdJFVMx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 17:12:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id o52so33837517qtc.9
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 14:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZxFD4cXOJsFCofXT/SifqRciih1baKtOUZYTTqZ2i8s=;
        b=eha2NzYn7AraiA2IDAFdbZM7vDARnhyneUaKCvsJTdFRphWZQwEHQveM5b6DPQTedm
         ndv6lMY4phTELgZpVTXhS2u6Go1pDwR3rsUBrIEVTBJVnl4mbUJi7XXkrvVqHTrZKvv9
         evogdOaLwEKh9SXf1GSvSY/dEctpi79MXE5IzWvH9LqCzAvWkAQfZr6EkYba5kLyXZKd
         UskJ+cEr3Mh4i9cGkJsXaGL+nplavjGqaoI/KLdb0hmLu88jc3VtNCOXTiyWhWCePbZc
         xXCwivlfjDL138X1bHvyBAXdidmFYcDT98E+KYafJ0sxwPMUVuWGSaxose3sltcssHsq
         /itw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZxFD4cXOJsFCofXT/SifqRciih1baKtOUZYTTqZ2i8s=;
        b=NzeZa9lNcSn8CAZhx076EZjVWZVTxELEoosdqBfhzb3zCmJ3EpBbLLB27m/wWiFfc+
         +P+YlPaRcGcIi/ZI8qx6f/LWdSAl1iT9ZNdpSOlCumpZDDaFcDtq05yrdQ5iHVAMz3TD
         sDJPCXOJllx4plHuDctvAUgzPbwu4buwTDOfwtM3O5I3W1773pz6vCqZ+QD7gMPGImv9
         tR5Rk3fESD1rjCBwbPCDqtWjHxoAjGdsBALoVwf088DaEu8XcVItjYy0KQ5H4lnYtKsT
         N4qb954bh4AHFR0cW4psZ0sWQCMCjKxari0R9pxKDaXVQuow3Nho/7TIJZ7JBdwPm7EO
         0btg==
X-Gm-Message-State: AMCzsaX8H4ElC2li713UD/pwLOGJehObrp1nyq7QYz3gAf0kTALLuWzk
        tMk5YhE96kkXiVlkJze2bILl1LQJURQo6b+XQz+18g==
X-Google-Smtp-Source: AOwi7QATyECPV+qhgTzMUcJ5PjDP3jId7yYBIChuBdy8/uId2jAYbMoqHibaGKK8VHUTof/qHPqvuCJ9/c/4qTbKF/E=
X-Received: by 10.200.33.131 with SMTP id 3mr4866635qty.177.1507324372445;
 Fri, 06 Oct 2017 14:12:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Fri, 6 Oct 2017 14:12:52 -0700 (PDT)
In-Reply-To: <20171006132415.2876-2-pc44800@gmail.com>
References: <xmqqy3ouqruh.fsf@gitster.mtv.corp.google.com> <20171006132415.2876-1-pc44800@gmail.com>
 <20171006132415.2876-2-pc44800@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 6 Oct 2017 17:12:52 -0400
X-Google-Sender-Auth: joGzeZgl59J3xgtY29o6flWGqhA
Message-ID: <CAPig+cTEMH=RVfqekuP-oWOoRmNWEdvdFZz4bOdS321oND1Ypg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] submodule--helper: introduce get_submodule_displaypath()
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>, hanwen@google.com,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I didn't find a URL in the cover letter pointing at previous
iterations of this patch series and related discussions, so forgive me
if comments below merely repeat what was said earlier...

On Fri, Oct 6, 2017 at 9:24 AM, Prathamesh Chavan <pc44800@gmail.com> wrote:
> Introduce function get_submodule_displaypath() to replace the code
> occurring in submodule_init() for generating displaypath of the
> submodule with a call to it.
>
> This new function will also be used in other parts of the system
> in later patches.
>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> @@ -219,6 +219,26 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
> +/* the result should be freed by the caller. */
> +static char *get_submodule_displaypath(const char *path, const char *prefix)
> +{
> +       const char *super_prefix = get_super_prefix();
> +
> +       if (prefix && super_prefix) {
> +               BUG("cannot have prefix '%s' and superprefix '%s'",
> +                   prefix, super_prefix);
> +       } else if (prefix) {
> +               struct strbuf sb = STRBUF_INIT;
> +               char *displaypath = xstrdup(relative_path(path, prefix, &sb));
> +               strbuf_release(&sb);
> +               return displaypath;
> +       } else if (super_prefix) {
> +               return xstrfmt("%s%s", super_prefix, path);
> +       } else {
> +               return xstrdup(path);
> +       }
> +}

At first glance, this appears to be a simple code-movement patch which
shouldn't require deep inspection by a reviewer, however, upon closer
examination, it turns out that it is doing rather more than that,
which increases reviewer burden, especially since these additional
changes are not mentioned in the commit message. At a minimum, it
includes these changes:

* factors out calls to get_super_prefix()
* adds extra context to the "BUG" message
* changes die("BUG...") to BUG(...)
* allocates/releases a strbuf
* changes assignments to returns

The final two are obvious necessary (or clarifying) changes which a
reviewer would expect to see in a patch which factors code out to its
own function; the others not so.

This isn't to say that the other changes are not reasonable -- they
are -- but if one of your goals is to make the patches easy for
reviewers to digest, then you should make the changes as obvious as
possible for reviewers to spot. One way would be to mention in the
commit message that you're taking the opportunity to also make these
particular cleanups to the code. A more common approach is to place
the various cleanups in preparatory patches before this one, with one
cleanup per patch. I'd prefer to see the latter (if my opinion carries
any weight).

More below...

> @@ -334,15 +354,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>         struct strbuf sb = STRBUF_INIT;
>         char *upd = NULL, *url = NULL, *displaypath;
>
> -       if (prefix && get_super_prefix())
> -               die("BUG: cannot have prefix and superprefix");
> -       else if (prefix)
> -               displaypath = xstrdup(relative_path(path, prefix, &sb));
> -       else if (get_super_prefix()) {
> -               strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
> -               displaypath = strbuf_detach(&sb, NULL);
> -       } else
> -               displaypath = xstrdup(path);
> +       displaypath = get_submodule_displaypath(path, prefix);
>
>         sub = submodule_from_path(&null_oid, path);
>
> @@ -357,9 +369,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>          * Set active flag for the submodule being initialized
>          */
>         if (!is_submodule_active(the_repository, path)) {
> -               strbuf_reset(&sb);
>                 strbuf_addf(&sb, "submodule.%s.active", sub->name);
>                 git_config_set_gently(sb.buf, "true");
> +               strbuf_reset(&sb);

This strbuf_reset() movement, and those below, are pretty much just
"noise" changes. They add extra burden to the review process without
really improving the code. The reason they add to reviewer burden is
that they do not seem to be related to the intention stated in the
commit message, so the reviewer must spend extra time trying to
understand their purpose and correctness.

More serious, though, is that these strbuf_reset() movements may
actually increase the burden on someone changing the code in the
future. Presumably, your reason for making these changes is that you
reviewed the code after factoring out the get_submodule_displaypath()
logic and discovered that the strbuf was no longer touched before this
point, therefore resetting it before strbuf_addf() is unnecessary.
While this may be true today, it may not be so in the future. If
someone comes along and adds code above this point which does touch
the strbuf, then these code movements either need to be reverted by
that person (more noise) or that person needs to remember to add a
strbuf_reset() at the end of the new code.

Moreover, it's somewhat easier to reason about the strbuf_reset()'s
and the corresponding strbuf_addf()'s when they are kept together, as
in the original code, so, for that reason alone, one could argue that
moving the strbuf_reset()'s does not really improve the code.

I'd suggest dropping these changes in the re-roll.

>         }
>
>         /*
> @@ -367,7 +379,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>          * To look up the url in .git/config, we must not fall back to
>          * .gitmodules, so look it up directly.
>          */
> -       strbuf_reset(&sb);
>         strbuf_addf(&sb, "submodule.%s.url", sub->name);
>         if (git_config_get_string(sb.buf, &url)) {
>                 if (!sub->url)
> @@ -404,9 +415,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
>                                 _("Submodule '%s' (%s) registered for path '%s'\n"),
>                                 sub->name, url, displaypath);
>         }
> +       strbuf_reset(&sb);
>
>         /* Copy "update" setting when it is not set yet */
> -       strbuf_reset(&sb);
>         strbuf_addf(&sb, "submodule.%s.update", sub->name);
>         if (git_config_get_string(sb.buf, &upd) &&
>             sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
> --
> 2.14.2
