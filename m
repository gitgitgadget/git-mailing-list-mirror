Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75E941F576
	for <e@80x24.org>; Fri, 19 Jan 2018 09:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755271AbeASI74 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 03:59:56 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:39083 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755220AbeASI7s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 03:59:48 -0500
Received: by mail-qt0-f177.google.com with SMTP id f4so2160185qtj.6
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 00:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=v7fnNN4KSI1oe5X4PgR7myiDzjXzA0ym2i0rASWP6Dc=;
        b=bofs5zL+ipMvAxfzyHBEJOCLCr9ApuLoIk2r/d0L2SV5fTCt52QHpkEej+WsVY82tT
         FTxKliu1b+amwQ5Y2kia+luY8L/5gRAE4DQwGEJqDQpq8FxbbTB98HE9I/Clz+/sv8jh
         q4oLHoM+JcMebSP2f2s4E2SBylQEWa9KRE4fx1ZRifWTf0qXU+FE7mzdZxLCOt4T8JoT
         1CnOg7ensVkDaZVK59eKserQUERCP5UTWVTTdqGn6D5DHO6hyxRKvF2mernOcltDtT6F
         +uSiDk+TOdDCYr7CSPJbXRY3iNAzV0kKkJ5Kg825Sm3UbX+9WfdApye6HbYbfIMKVQJd
         pJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=v7fnNN4KSI1oe5X4PgR7myiDzjXzA0ym2i0rASWP6Dc=;
        b=oBlJQJ4Mnca4w+ggL5T+jhHM4Ok6O4lh+fz4c1WU3ZwSwtP0BUYM2mWX+rsi5FR+kJ
         aeTwYL7Asn3s5TYiKC8BMZCMw+/Zj7bUlXwtmBJJsm8w4j97wwJAOHh0m3goRcSqQD8C
         OZSTgQywHCH9JpPJjTl5RG7UhUCaVh+i91cHnIlVFZroai2fACRd1SFG8xQZMKTfMerV
         KtApJA6M8RBE/Fiz5D1XPZkatyvAvJs1ja3sHuF5ZKj5+ux9Jd+EVD0ujTrKK1mYChY9
         qH74sNf8/5js1CxyX5A5EaDInGTSHaPZWDqOCr7adP51huggrKBQQUWykZWmp2gFHHKE
         QBXg==
X-Gm-Message-State: AKwxytfpAAj5TMc/IPCcSeXbLfKjSmf+k5HW9PVsewZkohU52voIRHk5
        Ka8ZDoaEUlAYV6+6ieI1Kvntoxm4bMDSPId7UJE=
X-Google-Smtp-Source: ACJfBovl7GfFrrVQtpTWXo7IQhFY8KWxje27W1lcNQXMspzen5jhrAdltKwObx4kMoOxzVSRoOzKF9hqaRETIXqxC1g=
X-Received: by 10.200.27.91 with SMTP id p27mr35335412qtk.254.1516352387319;
 Fri, 19 Jan 2018 00:59:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 00:59:47 -0800 (PST)
In-Reply-To: <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <8a91bf2184a3da4c0d5a13ba184813068e51f5c8.1516225925.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 03:59:47 -0500
X-Google-Sender-Auth: xYUA9zYQHzsUyYN2DRgUU6F9lZs
Message-ID: <CAPig+cQbG2s-LrAo9+7C7=dXifbWFJ3SzuNa-QePHDk7egK=jg@mail.gmail.com>
Subject: Re: [PATCH 1/8] sequencer: introduce new commands to reset the revision
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> [...]
> This commit implements the commands to label, and to reset to, given
> revisions. The syntax is:
>
>         label <name>
>         reset <name>
> [...]
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -1919,6 +1936,139 @@ static int do_exec(const char *command_line)
> +static int safe_append(const char *filename, const char *fmt, ...)
> +{
> +       [...]
> +       if (commit_lock_file(&lock) < 0) {
> +               rollback_lock_file(&lock);
> +               return error(_("failed to finalize '%s'."), filename);

s/\.//

> +       }
> +
> +       return 0;
> +}
> +
> +static int do_reset(const char *name, int len)
> +{
> +       [...]
> +       if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0)
> +               return -1;
> +
> +       for (i = 0; i < len; i++)
> +               if (isspace(name[i]))
> +                       len = i;

What is the purpose of this loop? I could imagine that it's trying to
strip all whitespace from the end of 'name', however, to do that it
would iterate backward, not forward. (Or perhaps it's trying to
truncate at the first space, but then it would need to invert the
condition or use 'break'.) Am I missing something obvious?

> +       read_cache_unmerged();
> +       if (!fill_tree_descriptor(&desc, &oid)) {
> +               error(_("Failed to find tree of %s."), oid_to_hex(&oid));

s/Failed/failed/
s/\.//

> +               rollback_lock_file(&lock);
> +               free((void *)desc.buffer);
> +               strbuf_release(&ref_name);
> +               return -1;
> +       }
