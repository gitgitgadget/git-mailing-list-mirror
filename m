Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C0F41F4F8
	for <e@80x24.org>; Mon, 17 Oct 2016 22:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933737AbcJQWtX (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 18:49:23 -0400
Received: from mail-qk0-f179.google.com ([209.85.220.179]:34144 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757548AbcJQWtW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 18:49:22 -0400
Received: by mail-qk0-f179.google.com with SMTP id f128so251300693qkb.1
        for <git@vger.kernel.org>; Mon, 17 Oct 2016 15:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=koU5YE6r93nyM3KpohRzh882n/RLiQpDje1QgYgHf+s=;
        b=AYfN2XXTxnRid7LjCadxY5QVq5J/mJV1h+E3tAupubbKW/AUCLQgHFbUiURAqAdReB
         IQ9BLo9u41m+ZRTncPvfGgE5iNgSuz+eDBOAUs3vH9KDf3wH/zfjZ6C2exJ/zhuh+l7+
         oJ4FTUwGvv1hW27ffsBDTdSVQ8+59n/0dNqq7UZVjT8cQhf54axt7T+++X1x2Ha7O5iv
         4YRR3jvNWdECsP3PVyByAkXnQ2/Dt7GdzejjopleC9SWO8w8B0miInREKBtACR8DKejO
         xkgESzXl/UOzvp42Zn9Y0Ti6JH7RNtpwWRXNeC8IDBFNrymiyPtGZ2I0xFdiKYvEou1J
         4qZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=koU5YE6r93nyM3KpohRzh882n/RLiQpDje1QgYgHf+s=;
        b=AZzJelSA2YNObV4MRHOaynfmGSH7Ktvl5z7ZRgvbZrH1+PKThZa3S2Z3V/PLkQfS66
         2F0orPvk3X2jYjrHIR4wXecApPQ+1ocAJS1o20XJJqs9FeH+EaV0LJqMKQFEGkcdxXp9
         aEqw78gjFaPrTEReuFTo0U8fi8tQug1xrGVmaNMujcG7YXF2yoMJZhB2Da9H2R8Rsjz5
         hZKkbyx5WiqYi8/8TCNLDNR+0c9mT/JwZId3SMUa6tsYIJwX1Qqsm1KIWyvzm4UT/rpl
         ymrmc38b/3J+tPxvaon/mzXAlY7MFMGf5tGU/E8CkOlNYNv+RvYPZWYsorAdj54X43hD
         p7IQ==
X-Gm-Message-State: AA6/9Rlyg8J6Y1aIjq66wN54tel0buHdaTw3ayoPZ4XuGXBa47Buwo+VY7C0SIIvJUahmBSv79g0fep4ETKNAYXs
X-Received: by 10.55.184.2 with SMTP id i2mr29663871qkf.47.1476744561367; Mon,
 17 Oct 2016 15:49:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Mon, 17 Oct 2016 15:49:21 -0700 (PDT)
In-Reply-To: <701ba7164b587a97ef380bc981c95c5d51db6781.1476466609.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com>
 <cover.1476466609.git.jonathantanmy@google.com> <701ba7164b587a97ef380bc981c95c5d51db6781.1476466609.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 17 Oct 2016 15:49:21 -0700
Message-ID: <CAGZ79kY80ysSfM-fsZwpHq=SUSmvfc3YUZSR54mRN2q-1OzOVA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] trailer: improve const correctness
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 14, 2016 at 10:37 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
> Change "const char *" to "char *" in struct trailer_item and in the
> return value of apply_command (since those strings are owned strings).
>
> Change "struct conf_info *" to "const struct conf_info *" (since that
> struct is not modified).
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>

Reviewed-by Stefan Beller <sbeller@google.com>

> ---
>  trailer.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/trailer.c b/trailer.c
> index c6ea9ac..1f191b2 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -27,8 +27,8 @@ static struct conf_info default_conf_info;
>  struct trailer_item {
>         struct trailer_item *previous;
>         struct trailer_item *next;
> -       const char *token;
> -       const char *value;
> +       char *token;
> +       char *value;
>         struct conf_info conf;
>  };
>
> @@ -95,8 +95,8 @@ static void free_trailer_item(struct trailer_item *item)
>         free(item->conf.name);
>         free(item->conf.key);
>         free(item->conf.command);
> -       free((char *)item->token);
> -       free((char *)item->value);
> +       free(item->token);
> +       free(item->value);
>         free(item);
>  }
>
> @@ -215,13 +215,13 @@ static struct trailer_item *remove_first(struct trailer_item **first)
>         return item;
>  }
>
> -static const char *apply_command(const char *command, const char *arg)
> +static char *apply_command(const char *command, const char *arg)
>  {
>         struct strbuf cmd = STRBUF_INIT;
>         struct strbuf buf = STRBUF_INIT;
>         struct child_process cp = CHILD_PROCESS_INIT;
>         const char *argv[] = {NULL, NULL};
> -       const char *result;
> +       char *result;
>
>         strbuf_addstr(&cmd, command);
>         if (arg)
> @@ -425,7 +425,7 @@ static int set_if_missing(struct conf_info *item, const char *value)
>         return 0;
>  }
>
> -static void duplicate_conf(struct conf_info *dst, struct conf_info *src)
> +static void duplicate_conf(struct conf_info *dst, const struct conf_info *src)
>  {
>         *dst = *src;
>         if (src->name)
> --
> 2.8.0.rc3.226.g39d4020
>
