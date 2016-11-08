Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10D9D2035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752690AbcKHXiK (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:38:10 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35147 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752472AbcKHXiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:38:09 -0500
Received: by mail-yw0-f196.google.com with SMTP id b66so4684938ywh.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HhE0M0Nk0ob3lC+tVKJ0z2kpiu9RfQrxdbtbvO1lpTU=;
        b=XJAhaspI4cpgoGv53ib4ohZeEIU/qEswqij4oDBiZc4x52HpIQKqr86S/xL7i2FB/U
         Z60d/vshSMRl2PE2sw4peUr2O+gXOuBSxSzCwjHS4KKrO5A+ILnPhg+4CLY3mrNFV/sM
         olmYiqgGXSN5y8W4/F96baCdLHmRi+HQ6gfnBcVwl5dQXvPYzPVKY8AjbWRcD8Tv2DEB
         9pg2IjVdRCDe5Z1pBl/LrSdwXszG2KcMTCYaTA+EavxmwS5L/iaOGUwfh0USCi4xIha0
         GHgl3pNaccjTVI6F7HiDU8nM+KBn0kE5AwU5H/4y81iRHtpYqrBnwcocmjMstyuQ8rDK
         SAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HhE0M0Nk0ob3lC+tVKJ0z2kpiu9RfQrxdbtbvO1lpTU=;
        b=SHw1Q+CRDKglK7JDf/Jli0nyyv9fbDa/Rp/vSDfNu2UVbB+BxJvo0n/IZjN9xuiaH+
         B0Fbskw2OQEvXuXG2d9cjaQooEHa5Qae4RM89m0ZuiZqdYnva2LxKNjs7zx7vbpkEvIY
         WgOCqp4DTzMuYZ1RqJE4q1DYknEh42wiHmIy4hBcKx8NFzhlufmSDACOtJkyL9yEATOH
         vL3r+qwjgtNfZo/p1BPznt/sujm9j7Ej5BpiZ/I49BzuWsa0wPbdFAFxrOIjV+6BKUgX
         KPSzSQQda0vZWcfmwgvhjHeEp6TSfl/2NoMs72Wu97qfHvD/NSVwGMJRDJKs4k9XOC5M
         ouCQ==
X-Gm-Message-State: ABUngvf78VKjNlZa0uQxehx/t29/lfIzOL0WT98LiMjNH6Q99iGbZee+NdTIUEiJiay9f32v7nNv0S3bQ5i+EA==
X-Received: by 10.129.102.132 with SMTP id a126mr14059481ywc.160.1478648288223;
 Tue, 08 Nov 2016 15:38:08 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:37:47 -0800 (PST)
In-Reply-To: <20161108201211.25213-8-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-8-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:37:47 -0800
Message-ID: <CA+P7+xoKxGiNJO4g=Nm+KY=5=u8g2edoLOoe5K0ZAPrvoGj-Ug@mail.gmail.com>
Subject: Re: [PATCH v7 07/17] ref-filter: make %(upstream:track) prints
 "[gone]" for invalid upstreams
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
> Borrowing from branch.c's implementation print "[gone]" whenever an
> unknown upstream ref is encountered instead of just ignoring it.
>

This makes sense.

> This makes sure that when branch.c is ported over to using ref-filter
> APIs for printing, this feature is not lost.
>

Right.

> Make changes to t/t6300-for-each-ref.sh and
> Documentation/git-for-each-ref.txt to reflect this change.
>

This will change behavior if people were expecting it to remain
silent, but I think this could be considered a bug.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Helped-by : Jacob Keller <jacob.keller@gmail.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt | 3 ++-
>  ref-filter.c                       | 4 +++-
>  t/t6300-for-each-ref.sh            | 2 +-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 92184c4..fd365eb 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -119,7 +119,8 @@ upstream::
>         "[ahead N, behind M]" and `:trackshort` to show the terse
>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
>         or "=" (in sync).  Has no effect if the ref does not have
> -       tracking information associated with it.
> +       tracking information associated with it. `:track` also prints
> +       "[gone]" whenever unknown upstream ref is encountered.
>

I think this is poorly worded. If I understand, "has no effect if the
ref does not have tracking information" so in that case we still print
nothing, right? but otherwise we print [gone] only when the upstream
ref no longer actually exists locally? I wonder if there is a better
wording for this? I don't have one. Any suggestions to avoid confusing
these two cases?

>  push::
>         The name of a local ref which represents the `@{push}` location
> diff --git a/ref-filter.c b/ref-filter.c
> index b8b8a95..6d51b80 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1049,8 +1049,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                 *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
>         else if (atom->u.remote_ref == RR_TRACK) {
>                 if (stat_tracking_info(branch, &num_ours,
> -                                      &num_theirs, NULL))
> +                                      &num_theirs, NULL)) {
> +                       *s = "[gone]";
>                         return;
> +               }
>
>                 if (!num_ours && !num_theirs)
>                         *s = "";
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 2be0a3f..a92b36f 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
>
>  test_expect_success 'Check that :track[short] works when upstream is invalid' '
>         cat >expected <<-\EOF &&
> -
> +       [gone]
>
>         EOF
>         test_when_finished "git config branch.master.merge refs/heads/master" &&
> --
> 2.10.2
>
