Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC1551F43C
	for <e@80x24.org>; Wed,  8 Nov 2017 16:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbdKHQMU (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 11:12:20 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:46056 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751658AbdKHQMT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 11:12:19 -0500
Received: by mail-it0-f66.google.com with SMTP id u132so3890363ita.0
        for <git@vger.kernel.org>; Wed, 08 Nov 2017 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BVsWu9CvYCxeKD75Biq7Yy1gvXV5q6ac09ajDEJshB4=;
        b=ObsaaZrNAG6A9Ad5xRrJ/J0Js+qNYn5/OXXmWQTxw1YzuG+OOzFpKOcUDoczga3Ura
         foc5fzEViPtFvWRFXc/DMZ3Zmh/6bw/2eiQSrtO7+1GCpzta5rj6a/7/cExtPs5axYEj
         Ju7qRjiK+208g8xxzcMXzJhpKy+eImJpCWHA6J23ddwZ7tojbwNtTjElgzN5ewdC2Pg5
         /hALONPu4KO6gjE/mrSdXxq2SEfmNQx5u8bjM1/ULaXMn4G/7xeIHa/D5NCFJ+WlcFar
         Vuth6JmE8r4+6m1l87Ib8sRuaw1v4385gwelsX7e+Ri2xiOkKT037LWzFTJLKFif0siM
         eIDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BVsWu9CvYCxeKD75Biq7Yy1gvXV5q6ac09ajDEJshB4=;
        b=MdB8IqV3uSUfpFiNeSXsaSLFTze+joxF3hoXNBS+u6KfS2gmI08fiGvVbdOHMxHhLi
         9jtboiWF160zs+AYF/MI43s/+CczVu/NXBK7HGsQ6xZmRbvj1pTgC7hTOSWj5Wzh7/Jd
         xn9xn5ODe21zqWXKhlIru02skA485tDqFmJIlRIZu1997DFCHXxX/KdPdahgZt1tYL/l
         2vU/a357nU5rtiVYSZNu3fuuPPgQSdz54HpHKoGGhM6zpYH/laKqK+1K2Vi3fiV9BfeP
         9ZllU4KgK5TpA3H4ubev3eJb6Is2y0bE+GvFnvIoodLbfgegZHa4OBw+tDBMpTnUKEpP
         wtbw==
X-Gm-Message-State: AJaThX72rzk1wbm+BME+BAUjU0wSPhxqRtnOpd6hASqtYknFNlUnVWU+
        Eub67W8pygjroUNRaVsgWscn0fqbz1rG71PUkQYbtA==
X-Google-Smtp-Source: ABhQp+Ty2DprQy6jOmf0xA2RAyQDD/q2lLAaLkPBUAemGz82BWW/ESggWz79RZPNejEIcu94YLa4WjmCElo3Laednus=
X-Received: by 10.36.246.76 with SMTP id u73mr1388006ith.55.1510157538919;
 Wed, 08 Nov 2017 08:12:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Wed, 8 Nov 2017 08:12:18 -0800 (PST)
In-Reply-To: <20171108135931.166880-1-adam@dinwoodie.org>
References: <20171108135931.166880-1-adam@dinwoodie.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 8 Nov 2017 17:12:18 +0100
Message-ID: <CAP8UFD015i76L4BgSZdr2k2TZk+C0vRAqOsj4DaqtNYuJjtNxQ@mail.gmail.com>
Subject: Re: [RFC PATCH] rebisect: add script for easier bisect log editing
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 8, 2017 at 2:59 PM, Adam Dinwoodie <adam@dinwoodie.org> wrote:
> Add a short script, vaguely inspired by `git rebase --interactive`, to
> ease the process described in the `git bisect` documentation of saving
> off a bisect log, editing it, then replaying it.

Nice idea.

> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> ---
>
> When I'm bisecting, I find I need to semi-regularly go back and change
> my good/bad/skip response for some commits.  The bisect documentation
> describes doing this by saving `git bisect log` output, editing it, then
> using `git bisect replay`.  Which is a perfectly fine technique, but
> automation is A Good Thing(TM).  The below script is a short proof of
> concept for changing this process to be a single command.
>
> Ideally (at least from my perspective), this function would be rolled
> into the main `git bisect` tool, as `git bisect edit` or similar.

I agree and I don't think it would be very difficult to convert to
such a sub command.

> Before I start working on that, however, I wanted to see what the list
> thought of the idea.
>
>  contrib/git-rebisect.sh | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>  create mode 100755 contrib/git-rebisect.sh
>
> diff --git a/contrib/git-rebisect.sh b/contrib/git-rebisect.sh
> new file mode 100755
> index 000000000..60f20b278
> --- /dev/null
> +++ b/contrib/git-rebisect.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +GIT_EDITOR="$(git var GIT_EDITOR)"
> +GIT_DIR="$(git rev-parse --git-dir)"
> +GIT_BISECT_LOG_TMP="${GIT_DIR}/BISECT_LOG_EDIT"
> +
> +git bisect log >"$GIT_BISECT_LOG_TMP"
> +"$GIT_EDITOR" "$GIT_BISECT_LOG_TMP"
> +git bisect reset HEAD

I guess that using "reset HEAD" could be cheaper than just "reset" and
that's the reason you are using it.

> +git bisect start

Are you sure that this "start" is necessary? The doc says that "reset"
followed by "replay that-file" should be enough.

> +git bisect replay "$GIT_BISECT_LOG_TMP"
> +rm -f "$GIT_BISECT_LOG_TMP"

Thanks,
Christian.
