Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A358A1F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755728AbeATA7u (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:59:50 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34021 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754132AbeATA7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 19:59:48 -0500
Received: by mail-qt0-f194.google.com with SMTP id 33so8222210qtv.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 16:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zTX9V8C5pv3YCVRHqZRDmAh1x5W7cKyM6wFOQyizdHw=;
        b=pQVk7RuHkUEvUWMV8RPPd61c+7dRtX3ni44jgCvDech7LVy3Vpt0Mm6fMr+RXzjbCl
         dTEzvoedYK9nR7NjN5dINmUnkn6LuxnoBN++3TpDQlj6OaKmEbsY3W20aLho0Z2eXd3+
         K3rycqC4jqIqOd+SRtM9G3r2OUHNFYF649zT4u7dJ75xu9Cxa5XJ3kz7REE9fG7KNVM1
         yVCaa99wI/i9DpgnyiWh3lnQMBRsWjFOfu7uQ4v4tPkH9qv6iLOX3QfUEy3pDm0O7Sul
         xSxd/flpCrVUdhUk2dcTuav8a7sIyC3Zwh+FacI7nPRQvQ+OkiN0VsSLMosXgf2aU61s
         DJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zTX9V8C5pv3YCVRHqZRDmAh1x5W7cKyM6wFOQyizdHw=;
        b=DJbBp36xGEBdhgU9UFMAXGHAg4ih7NfM2WAF3ghOSYk15DNdDUBDJOqgykSiwpv+9y
         tyL4tPsqVNexz5AynUZxzf5c2DI1upXdXVkVWXoUQbzt/WQiJSMsXriOnEd15yzKKTzL
         GGDDdD21RAPOS0dzUL6awUAZfimkiG32fzHp+lDNDZ+ifmqm8UKeFPfd7i3WloHh/0ic
         mxx4OuHNf6K8LeLwp6vqF+c+BEdcFfRivlne35mgTIW0YUoGWyK0tmmkB7N0RH+/xa2B
         GddyqbGCmxCq8kC3EXJ8rtbcHb8hb4iB05nzGKTKeXXUoTUyQpdGhTtZAWcZ8sp4vA77
         /diQ==
X-Gm-Message-State: AKwxytf8Vo6RM7jYoTfsdohEFJCL7fQrK7styQGLxokI9QMMm1tITl3Y
        bK4G6fGKKXQynnAZvW9oYTEm3hjqR/mns30EM2s=
X-Google-Smtp-Source: AH8x2265y8hrPekbihh4AFrHblv5MA5+vDJfnMhO56sX8BmDgfA31itdUPkFnr5UwsdxIC29kRlDSjfXzGsQW5oHWF4=
X-Received: by 10.55.203.85 with SMTP id d82mr477241qkj.286.1516409988048;
 Fri, 19 Jan 2018 16:59:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 16:59:47 -0800 (PST)
In-Reply-To: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
References: <1516404987-3420-1-git-send-email-gs051095@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 19:59:47 -0500
X-Google-Sender-Auth: giqN--fSNW5MqogCA95p5RXVe8k
Message-ID: <CAPig+cQ9mMVvMLKSQOKxinc5iuRK61yTDQ511ZdNqEOtbCGoAQ@mail.gmail.com>
Subject: Re: [PATCH v3] mru: Replace mru.[ch] with list.h implementation
To:     Gargi Sharma <gs051095@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 6:36 PM, Gargi Sharma <gs051095@gmail.com> wrote:
> Replace the custom calls to mru.[ch] with calls to list.h. This patch is
> the final step in removing the mru API completely and inlining the logic.
> This patch leads to significant code reduction and the mru API hence, is
> not a useful abstraction anymore.

A couple minor style nits below... (may not be worth a re-roll)

> Signed-off-by: Gargi Sharma <gs051095@gmail.com>
> ---
> diff --git a/cache.h b/cache.h
> @@ -1587,10 +1588,10 @@ extern struct packed_git {
>  } *packed_git;
>
>  /*
> - * A most-recently-used ordered version of the packed_git list, which can
> - * be iterated instead of packed_git (and marked via mru_mark).
> + * A most-recently-used ordered version of the packed_git list.
>   */
> -extern struct mru packed_git_mru;
> +extern struct list_head packed_git_mru;
> +

Unnecessary extra blank line.

>  struct pack_entry {
>         off_t offset;
> diff --git a/packfile.c b/packfile.c
> @@ -859,9 +859,9 @@ static void prepare_packed_git_mru(void)
>  {
>         struct packed_git *p;
>
> -       mru_clear(&packed_git_mru);
> -       for (p = packed_git; p; p = p->next)
> -               mru_append(&packed_git_mru, p);
> +       for (p = packed_git; p; p = p->next) {
> +               list_add_tail(&p->mru, &packed_git_mru);
> +       }

Unnecessary braces on for-loop.

>  }
