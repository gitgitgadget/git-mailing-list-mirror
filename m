Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736EB2035F
	for <e@80x24.org>; Wed,  9 Nov 2016 00:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752902AbcKIAAx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 19:00:53 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34908 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbcKIAAw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 19:00:52 -0500
Received: by mail-yw0-f194.google.com with SMTP id b66so4702801ywh.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9byiTPKVxyE1iuFNoKfO7JzvCB0ZboloagykWAoNKhI=;
        b=uNZIDb1mJLDiKo0RKu9ghSqVkEtseLGOryeDsHDGL2Mhjcif0Cgma+FljiwWIhZUPu
         8/PLKolpdt/U7uwJq1go5tfVRlHVmEuIxDNxyu4qWY5O8AJlsSbrUtmqibRh0YJQsibB
         LgMl9Fxqu3decQzub96pqMYoiQOCav1rJB5NUuYArNuj8KWCNUmK+TsA+b6UQSIignBm
         CPqtmd8v4DEDmltGkUgqZQMOaUD6caCWtU2n9uCuLy4rf+dkNdCR4FiWRro6vvLvFuw6
         5ZVGvLp3ojwLv/gobuzbV6P1NkwWtLO//xz5CNhdVfxOgIEh36N06EozwMFhiq+iMCMd
         Nvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9byiTPKVxyE1iuFNoKfO7JzvCB0ZboloagykWAoNKhI=;
        b=SaNpd6cR33/2576NZF87Ml4dcizCKi0y+M4s8KJV6qwRO44g4g5ZIzpxhX8jwb0Ira
         y5EO8Fsa/I6v4i8ZzMBEyGGG/MLfbYxLKEysSUsyslT7LzlrBqd9FjnXd0fzkZbNAhHy
         hMvCBWwa86dBIHep9x4teAMb3Vrmvs/5rXrqBLov4jnQprsGdufPQrGnrC6aGZlWq2YD
         AIxcpca9scOx9OQqgUCHlb+l7Bb69Yh1Lo0qSodc8T32M4poTKkx/rCFlaHTIqOB3YZG
         fhKyJfHEk188pWbjyR93Qw/BhFkj7TPKzYxVK+O7usxhS5iJjWdaseqzH2AIvt/tfOy4
         e0RA==
X-Gm-Message-State: ABUngvehfc2NPwKemeGUN6nkmL1wCzt8bHMgq9zhUFQKcWtOHgYc65RV/0qY9rINIXpem8Y2nJozVEI2i2gvkw==
X-Received: by 10.13.254.71 with SMTP id o68mr11429267ywf.318.1478649651929;
 Tue, 08 Nov 2016 16:00:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 16:00:31 -0800 (PST)
In-Reply-To: <20161108201211.25213-15-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-15-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 16:00:31 -0800
Message-ID: <CA+P7+xo0yrafS0NxtCiDJqrU+Qbdjv7WEcdq9GK44bKt4pYagQ@mail.gmail.com>
Subject: Re: [PATCH v7 14/17] ref-filter: allow porcelain to translate
 messages in the output
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Introduce setup_ref_filter_porcelain_msg() so that the messages used in
> the atom %(upstream:track) can be translated if needed. This is needed
> as we port branch.c to use ref-filter's printing API's.
>

So any user that wants these translated calls
setup_ref_filter_porcelain_msg but this will impact all callers from
that point on. Ok, I think that's ok? Otherwise they get default
without translation.

> Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  ref-filter.c | 28 ++++++++++++++++++++++++----
>  ref-filter.h |  2 ++
>  2 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/ref-filter.c b/ref-filter.c
> index b47b900..944671a 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -15,6 +15,26 @@
>  #include "version.h"
>  #include "wt-status.h"
>
> +static struct ref_msg {
> +       const char *gone;
> +       const char *ahead;
> +       const char *behind;
> +       const char *ahead_behind;
> +} msgs = {
> +       "gone",
> +       "ahead %d",
> +       "behind %d",
> +       "ahead %d, behind %d"
> +};
> +
> +void setup_ref_filter_porcelain_msg(void)
> +{
> +       msgs.gone = _("gone");
> +       msgs.ahead = _("ahead %d");
> +       msgs.behind = _("behind %d");
> +       msgs.ahead_behind = _("ahead %d, behind %d");
> +}
> +
>  typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>
>  struct align {
> @@ -1130,15 +1150,15 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>         else if (atom->u.remote_ref.option == RR_TRACK) {
>                 if (stat_tracking_info(branch, &num_ours,
>                                        &num_theirs, NULL)) {
> -                       *s = xstrdup("gone");
> +                       *s = xstrdup(msgs.gone);
>                 } else if (!num_ours && !num_theirs)
>                         *s = "";
>                 else if (!num_ours)
> -                       *s = xstrfmt("behind %d", num_theirs);
> +                       *s = xstrfmt(msgs.behind, num_theirs);
>                 else if (!num_theirs)
> -                       *s = xstrfmt("ahead %d", num_ours);
> +                       *s = xstrfmt(msgs.ahead, num_ours);
>                 else
> -                       *s = xstrfmt("ahead %d, behind %d",
> +                       *s = xstrfmt(msgs.ahead_behind,
>                                      num_ours, num_theirs);
>                 if (!atom->u.remote_ref.nobracket && *s[0]) {
>                         const char *to_free = *s;
> diff --git a/ref-filter.h b/ref-filter.h
> index 0014b92..da17145 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -111,5 +111,7 @@ struct ref_sorting *ref_default_sorting(void);
>  int parse_opt_merge_filter(const struct option *opt, const char *arg, int unset);
>  /*  Get the current HEAD's description */
>  char *get_head_description(void);
> +/*  Set up translated strings in the output. */
> +void setup_ref_filter_porcelain_msg(void);
>
>  #endif /*  REF_FILTER_H  */
> --
> 2.10.2
>
