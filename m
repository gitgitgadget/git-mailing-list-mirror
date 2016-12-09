Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C3511FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752937AbcLITkH (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:40:07 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35915 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbcLITkG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:40:06 -0500
Received: by mail-qk0-f171.google.com with SMTP id n21so27852543qka.3
        for <git@vger.kernel.org>; Fri, 09 Dec 2016 11:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EM4vgEYY6K4vs9dk+zLOkNKkz/ehlB73gc9mmHUGj5A=;
        b=eNjdcGT6RUytyszlGW08kkQPcFvo5pbb45Bl8RzPeVS4N4DCnsvibYnfrBt8qwD4EQ
         gQ8fj1w1JgLQdFceWMdBiPA0BqjiKEwBKe1DD4hWXe5fLrlhV+AKiFK7ksIZqHDo6mNp
         afoEn3k8t6ImtlA79C93dWKSPgyp97ufas/+A1fqlCKkJfwL/rvXR3KrNKh6H12q+8il
         Kny0bMGvRymn4D5pElC783EBgBV17Hb0VesUOFLldQTXYJjraqHywNxSsOk/oqx9Pg+1
         pZPB5NBtz5B8ECRxL/gp8/NxYU1pJrrMFFDBrHdau9R7IfqZFEPbBGFm0Mra3vJATzE6
         MPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EM4vgEYY6K4vs9dk+zLOkNKkz/ehlB73gc9mmHUGj5A=;
        b=auzYkyC5ARVqXUAX2aVxFetUuJH5PLN4lII7661OYNSW4IQyYgmevvqQbPda+yKT+t
         4zFJAvV9rp9CAAwr6JgSdcxlvFxbbSe7W+dnXDSFBbpxjO7dQbP08I3hkZ2qXC1AcGCw
         3FafXFsJc246MaJ/97ADFiu3NhJJ0RttM7+KUfituES9LiYWG4aEBQY1lssYxj82DFw5
         Ghn5Uacr8m4B9ZdT5CrJ626W7mrlirBM2WjzTFl0lWvNOVoOMGkqaIMZBPqJLPpXbBjP
         o3ZhYfuUQqJjq9A2a3qo3fIFamafUmnVkkCQs4NAv7DjOrfVWk1sjNFsgEndXXZjtqr2
         g6KQ==
X-Gm-Message-State: AKaTC01nSMBPnBVaRhXVAks8gtlVrsk30wXkf6M/j800kow17qNpdegH1FzhdLgTX5bl/yJBetx64/IHkwsPMK2A
X-Received: by 10.55.16.147 with SMTP id 19mr70023176qkq.255.1481312405402;
 Fri, 09 Dec 2016 11:40:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Fri, 9 Dec 2016 11:40:04 -0800 (PST)
In-Reply-To: <1481311118-174146-1-git-send-email-bmwill@google.com>
References: <CACsJy8AX6C8Tux9_8ZynBMNS2EW2pKQOGK8k0hVmbWvbZ8pa=Q@mail.gmail.com>
 <1481311118-174146-1-git-send-email-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 9 Dec 2016 11:40:04 -0800
Message-ID: <CAGZ79kYVumubF58fdwejE2hvCLfgdVqTxn_w=S-CBFY-NdgqQg@mail.gmail.com>
Subject: Re: [PATCH 14/16] pathspec: create strip submodule slash helpers
To:     Brandon Williams <bmwill@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 11:18 AM, Brandon Williams <bmwill@google.com> wrote:
> Factor out the logic responsible for stripping the trailing slash on
> pathspecs referencing submodules into its own function.
>
> Change-Id: Icad62647c04b4195309def0e3db416203d14f9e4

I think we should come up with a solution to wipe out change ids
before sending emails. ;)

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  pathspec.c | 68 ++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 42 insertions(+), 26 deletions(-)
>
> diff --git a/pathspec.c b/pathspec.c
> index 84a57cf..4d9a6a0 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -258,6 +258,44 @@ static const char *parse_element_magic(unsigned *magic, int *prefix_len,
>                 return parse_short_magic(magic, elem);
>  }
>
> +static void strip_submodule_slash_cheap(struct pathspec_item *item)
> +{
> +       if (item->len >= 1 && item->match[item->len - 1] == '/') {
> +               int i = cache_name_pos(item->match, item->len - 1);
> +
> +               if (i >= 0 && S_ISGITLINK(active_cache[i]->ce_mode)) {
> +                       item->len--;
> +                       item->match[item->len] = '\0';
> +               }
> +       }
> +}
> +
> +static void strip_submodule_slash_expensive(struct pathspec_item *item)
> +{
> +       int i;
> +
> +       for (i = 0; i < active_nr; i++) {
> +               struct cache_entry *ce = active_cache[i];
> +               int ce_len = ce_namelen(ce);
> +
> +               if (!S_ISGITLINK(ce->ce_mode))
> +                       continue;
> +
> +               if (item->len <= ce_len || item->match[ce_len] != '/' ||
> +                   memcmp(ce->name, item->match, ce_len))
> +                       continue;
> +
> +               if (item->len == ce_len + 1) {
> +                       /* strip trailing slash */
> +                       item->len--;
> +                       item->match[item->len] = '\0';
> +               } else {
> +                       die(_("Pathspec '%s' is in submodule '%.*s'"),
> +                           item->original, ce_len, ce->name);
> +               }
> +       }
> +}
> +
>  /*
>   * Take an element of a pathspec and check for magic signatures.
>   * Append the result to the prefix. Return the magic bitmap.
> @@ -278,7 +316,7 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
>         unsigned magic = 0, element_magic = 0;
>         const char *copyfrom = elt;
>         char *match;
> -       int i, pathspec_prefix = -1;
> +       int pathspec_prefix = -1;
>
>         /* PATHSPEC_LITERAL_PATH ignores magic */
>         if (flags & PATHSPEC_LITERAL_PATH) {
> @@ -329,33 +367,11 @@ static unsigned prefix_pathspec(struct pathspec_item *item, unsigned flags,
>         item->len = strlen(item->match);
>         item->prefix = prefixlen;
>
> -       if ((flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP) &&
> -           (item->len >= 1 && item->match[item->len - 1] == '/') &&
> -           (i = cache_name_pos(item->match, item->len - 1)) >= 0 &&
> -           S_ISGITLINK(active_cache[i]->ce_mode)) {
> -               item->len--;
> -               match[item->len] = '\0';
> -       }
> +       if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
> +               strip_submodule_slash_cheap(item);
>
>         if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
> -               for (i = 0; i < active_nr; i++) {
> -                       struct cache_entry *ce = active_cache[i];
> -                       int ce_len = ce_namelen(ce);
> -
> -                       if (!S_ISGITLINK(ce->ce_mode))
> -                               continue;
> -
> -                       if (item->len <= ce_len || match[ce_len] != '/' ||
> -                           memcmp(ce->name, match, ce_len))
> -                               continue;
> -                       if (item->len == ce_len + 1) {
> -                               /* strip trailing slash */
> -                               item->len--;
> -                               match[item->len] = '\0';
> -                       } else
> -                               die (_("Pathspec '%s' is in submodule '%.*s'"),
> -                                    elt, ce_len, ce->name);
> -               }
> +               strip_submodule_slash_expensive(item);
>
>         if (magic & PATHSPEC_LITERAL)
>                 item->nowildcard_len = item->len;
> --
> 2.8.0.rc3.226.g39d4020
>
