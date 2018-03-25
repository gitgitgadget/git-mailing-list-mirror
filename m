Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DBD1F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 06:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeCYGva (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 02:51:30 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:40212 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYGv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 02:51:29 -0400
Received: by mail-qk0-f177.google.com with SMTP id o64so17083387qkl.7
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 23:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=UrZemzLauE6O9DqoUxkkatLwPwgcA9j8JS7X9F54qWM=;
        b=N/46coJnAfR3E1P/RNumdWu6TcwGbBw1v4gsde/JcZHu58ysnmY2g/KCVXY4XTdUp8
         W2oeLF5upSkNjdRV6ZRLUzJr2OIXoSGBT9k+0o47gtenrDqbT0GA4MPzbLwLkMLeaHdG
         C1qFqbJPAaLQLxW6ELhAsD3hLy7AOJehM41VtDUaplT/j9NSXSXig5lVWngfJkJrsT36
         JOQq/+6oa5WCLBhiehhM+8MkrfFASxrPGqX64P9iBGwRkepkUgeOmKsyWHFNn2XwoA1E
         G5a1j4ZFNoY6eBD/o4eDaKw8urCosG3Fr/dDOaVGrcjcinIeYC3+zq/pdjVw3Z8WA6OY
         +g3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=UrZemzLauE6O9DqoUxkkatLwPwgcA9j8JS7X9F54qWM=;
        b=NQMU8vgJ7IbYspX8TcBjZf0wz2YT5WCXsQtTeyJAmvA1QL22jZbxcA2c3D9Ja4a+Sz
         qeDuKYJQSd29S/anpaJ4ibWryOwm19TQcp2bGQSJGSVRBdYi9DT8AYPmqR9KxBRyg7WE
         dR9kFlMhJ2iC4MCF7QRILDBEG02GY+CoiTS07lmhXGbfRSGCzyrHVWQDx2xVD3kbRTfi
         L4WVinfnMmC0MNUkp3wnCo2bvhy8/oj58p9IOxpQtqIjc/hmbHJbuTfak2RMTvQN4FFH
         JSZ8qQi67uSpvYsrPmxZwzGVy3E+sx4S4/5IPpYZzH3cq9hO+9uXTNQOqVxK6Yp9a+q4
         W67w==
X-Gm-Message-State: AElRT7GbPojUuVsQIrEM4NcVFnSIriKxfqD/hqTn8ucrR7FXFVvSuWR+
        rgYa1+PUKM/uLseU+Uam4xkufFYUf1SO+WH5ggA=
X-Google-Smtp-Source: AG47ELu4XanGk1ebl+PSHI+3d0BIEEqbI5vw1SUZ4JEt5iaHrFETbYdKBmjwb8sQeknbSnBxbRu/zgpWH/XhL78HKT8=
X-Received: by 10.55.120.66 with SMTP id t63mr48646560qkc.42.1521960688557;
 Sat, 24 Mar 2018 23:51:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sat, 24 Mar 2018 23:51:28 -0700 (PDT)
In-Reply-To: <20180324173707.17699-5-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-5-joel@teichroeb.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 02:51:28 -0400
X-Google-Sender-Auth: fa0dpuOB-HhGxvy5tOoJ6laXMeE
Message-ID: <CAPig+cQ7XdEMyL=mT4RGfnsz-fjs6RxG=ztGC3oLprxKUBnJoA@mail.gmail.com>
Subject: Re: [PATCH 4/4] stash: convert pop to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 1:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> @@ -402,6 +408,36 @@ static int drop_stash(int argc, const char **argv, const char *prefix)
> +static int pop_stash(int argc, const char **argv, const char *prefix)
> +{
> +       int index = 0;
> +       const char *commit = NULL;
> +       struct stash_info info;
> +       struct option options[] = {
> +               OPT__QUIET(&quiet, N_("be quiet, only report errors")),
> +               OPT_BOOL(0, "index", &index,
> +                       N_("attempt to ininstate the index")),

"ininstate"??

> +               OPT_END()
> +       };
> +
> +       argc = parse_options(argc, argv, prefix, options,
> +                       git_stash_helper_pop_usage, 0);
> +
> +       if (argc == 1)
> +               commit = argv[0];

Seems fragile. What if there are two arguments?

> +       if (get_stash_info(&info, commit))
> +               return -1;
> +
> +       if (!info.is_stash_ref)
> +               return error(_("'%s' is not a stash reference"), commit);
> +
> +       if (do_apply_stash(prefix, &info, index))
> +               return -1;
> +
> +       return do_drop_stash(prefix, &info);
> +}
