Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 682201F404
	for <e@80x24.org>; Mon,  9 Apr 2018 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754348AbeDIUz2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 16:55:28 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45906 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754050AbeDIUz1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 16:55:27 -0400
Received: by mail-qt0-f195.google.com with SMTP id f8so10860026qtg.12
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fNx2RVDvn8OZbuQg+/cqE63Z2aoQSKLlJZqvdMsd2wo=;
        b=ekJ5skmUnvp6DOWr8dMq+342+pZPWcXYUlXt+Is1LZtYB5OK74D95S+9mfgjFpBEAl
         0ZjZRkXNjnrZh2YW9dPWtVEGn89yyxAUQjfUx1hFpld0+to4yrwTUU5Q4HjwtlQZNB4V
         StiYuYTJBoy+MBHUqAv4D0r+pdIW+E4Lzj5z+HFgCoYtIJh4TPteHhwuiUsRc+UkvXEu
         XvlRrfLogMZ5nKMwAnhNOc7g8VA7m858p/DIzYVRySsdzi+cn2TuioyhHAgam6Tr9gbm
         f2/Nc0QtVR+7QyoZ8cbAi04kLTv1eIgKi/tkLbXfOWt2SZY/kpHT5GZGOuQjwEz5lWpo
         IuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fNx2RVDvn8OZbuQg+/cqE63Z2aoQSKLlJZqvdMsd2wo=;
        b=gT2sETWx+EiqS06EoKnsIJNztTvy1EMDaffCTsTVayboM7q5/w7j8vVrkW8JtlEiVo
         CGYeH0038nqJFK21G+tzKhSuAt3rYsMfhRD9fvInl1TRRBYqqdAxfZBPxHJLpCKEFpvm
         4V008dVYeozgE8vwDydKvHQ/Q3pX+7Wr7Y4BKuEhPWgqP2WSYkZK/9I5WP5cYZkkRrXX
         KIL2W7yncwhezmRJ47dmLX8z8qQZeQ73IjZh3KWcM/x4HENAwxl9rhJB4noxU+HaovuD
         0wQBdKF185wQ+11F4F/K/dp6kIZ1fOnna9YdY8PZX1sxK2ha335wlL05g0n4AC84qFuj
         SsEg==
X-Gm-Message-State: ALQs6tBRdYWAWwvTx5p/TU92M320OeQtQ5AbZTkh7krz2ofTr0IM7uOp
        wLk5KmaKWgn+SJjHBt/03dNxInrPZNNtdIfzxVU=
X-Google-Smtp-Source: AIpwx48g68OoGg256cKJHCKdBghgZRuDX0PsYvWTJZuVFikd73KnyhYKKc312co5vFylBijsg3beKHfu8j4CIJ1H3+A=
X-Received: by 10.200.69.131 with SMTP id l3mr12207945qtn.50.1523307326700;
 Mon, 09 Apr 2018 13:55:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Mon, 9 Apr 2018 13:55:26 -0700 (PDT)
In-Reply-To: <20180409204129.43537-2-mastahyeti@gmail.com>
References: <20180409204129.43537-1-mastahyeti@gmail.com> <20180409204129.43537-2-mastahyeti@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 9 Apr 2018 16:55:26 -0400
X-Google-Sender-Auth: 8GvYqqIogz8nSI4Hzr49F2uy9_M
Message-ID: <CAPig+cQb+ZDWgCNVPX8_eFqUy-_crQ4wtrYhv-6kwasGwLTWuA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpg-interface: handle bool user.signingkey
To:     Ben Toews <mastahyeti@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 9, 2018 at 4:41 PM, Ben Toews <mastahyeti@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> The config handler for user.signingkey does not check for a
> boolean value, and thus:
>
>   git -c user.signingkey tag
>
> will segfault. We could fix this and even shorten the code
> by using git_config_string(). But our set_signing_key()
> helper is used by other code outside of gpg-interface.c, so
> we must keep it (and we may as well use it, because unlike
> git_config_string() it does not leak when we overwrite an
> old value).
>
> Ironically, the handler for gpg.program just below _could_
> use git_config_string() but doesn't. But since we're going
> to touch that in a future patch, we'll leave it alone for
> now. We will add some whitespace and returns in preparation
> for adding more config keys, though.
> ---

Peff's Signed-off-by: is missing. Also, since you're forwarding this
patch on Peff's behalf, your Signed-off-by: should follow his. Same
comment applies to all patches by Peff in this series.

The patch itself looks reasonable.

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 4feacf16e5..61c0690e12 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -128,13 +128,19 @@ void set_signing_key(const char *key)
>  int git_gpg_config(const char *var, const char *value, void *cb)
>  {
>         if (!strcmp(var, "user.signingkey")) {
> +               if (!value)
> +                       return config_error_nonbool(var);
>                 set_signing_key(value);
> +               return 0;
>         }
> +
>         if (!strcmp(var, "gpg.program")) {
>                 if (!value)
>                         return config_error_nonbool(var);
>                 gpg_program = xstrdup(value);
> +               return 0;
>         }
> +
>         return 0;
>  }
