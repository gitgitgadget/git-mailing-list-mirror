Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAE01F404
	for <e@80x24.org>; Wed, 28 Mar 2018 17:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753134AbeC1R6U (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:58:20 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34374 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbeC1R6T (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:58:19 -0400
Received: by mail-qt0-f193.google.com with SMTP id l18so3503385qtj.1
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X9x4dFQPJHdW9X9WAsZUtPoa+cijHNYk3ArtBIKci7U=;
        b=HCMignL8zuh72lEZXmEZdLS31CJjTem92bFcs2wSm6BYC8HOlgsePw3OiOfOJiaSzx
         3mWGFuwCKxFYQXOIq/N8aodCV2/aDB3u5leWRcrbweUQ+QUh7BFEWnpaSgM08OWPphll
         s0hMX0ewCMJOrUi8jZHfN8hJtDSa8AQBYFeyy8dNc7KTEKXapeomzruocwL9rP5yBdDD
         bqY+My8UdjHfptiRFwQO5vA3XXBFgIn6QkGPZ4hA8l77rEqwsZlVylM4thSYh2AbrBEL
         he503oNVK0ZjUTWY0v7cJL98C4ua82NMcagnvDuAgsvqHmKbycPxNB66Gy63gSSidWS/
         Z48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X9x4dFQPJHdW9X9WAsZUtPoa+cijHNYk3ArtBIKci7U=;
        b=W8uNFxshxbqTqEBy3suSRDq213GKR9JfsS7zg+tG5HDl8wqVEVNmuymy3reGeL6/AQ
         riDwGd85zrIzRFqKghMuTlLVMAO7tROVN1p4hGHE1AjNwDKP0I7PBapLBmd0F+cEAWk0
         /luTp+7pl6iReDctrKwEIAa0X5cHBJBkRLCAq+vzZxfLzSS9+Co/BsOoqzlc8IPbj8Uj
         y2OjEe29LNfszINYPutls1cVsULFV8yT1abrB8PQX0N79I3rlKnEgrMVriY4XwYuEoof
         n+KqDjiG19v2msr7EATHM+ysKJIGQHUDKGDAnbSHizk0rrEJ2J64UKKshpGGlW9Li9e0
         NUVg==
X-Gm-Message-State: ALQs6tAec2BFl0pTVwX1RzsaSbPELIF2mdKB1M7tvHQLAeiCaSesVOhf
        Y31JgKTSm1apxACPmnNsNIC7+zW3dfmvgLKm8a0=
X-Google-Smtp-Source: AIpwx48IekbJQqQTyQwCUEq6kBzlyYtl/dgwOFlQkyZI8LCEoBoLxzQ408xlidYA5gAVCLziVgkZWRMxZrKC6TBzdxA=
X-Received: by 10.237.57.166 with SMTP id m35mr6307918qte.220.1522259899136;
 Wed, 28 Mar 2018 10:58:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Wed, 28 Mar 2018 10:58:18 -0700 (PDT)
In-Reply-To: <20180328174041.GB16274@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174041.GB16274@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 28 Mar 2018 13:58:18 -0400
X-Google-Sender-Auth: xa1pvDcVBYWfstydurCyI5p9s_g
Message-ID: <CAPig+cQ0D+k+WmDWcaFHQj7DBb1RPfaUYwOvLosWXdHOzsoLOw@mail.gmail.com>
Subject: Re: [PATCH 2/4] add chdir-notify API
To:     Jeff King <peff@peff.net>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 1:40 PM, Jeff King <peff@peff.net> wrote:
> [...]
> Let's provide an API to let code that stores relative paths
> "subscribe" to updates to the current working directory.
> This means that callers of chdir() don't need to know about
> all subscribers ahead of time; they can simply consult a
> dynamically built list.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/chdir-notify.c b/chdir-notify.c
> @@ -0,0 +1,71 @@
> +int chdir_notify(const char *new_cwd)
> +{
> +       struct strbuf old_cwd = STRBUF_INIT;
> +       struct list_head *pos;
> +
> +       if (strbuf_getcwd(&old_cwd) < 0)
> +               return -1;
> +       if (chdir(new_cwd) < 0)
> +               return -1;

This 'return' is leaking 'old_cwd', isn't it?

> +       list_for_each(pos, &chdir_notify_entries) {
> +               struct chdir_notify_entry *e =
> +                       list_entry(pos, struct chdir_notify_entry, list);
> +               e->cb(old_cwd.buf, new_cwd, e->data);
> +       }
> +
> +       strbuf_release(&old_cwd);
> +       return 0;
> +}
> diff --git a/chdir-notify.h b/chdir-notify.h
> @@ -0,0 +1,64 @@
> + * In practice most callers will want to move a relative path to the new root;
> + * they can use the reparent_relative_path() helper for that. If that's all
> + * you're doing, you can also use the convenience function:
> + *
> + *   chdir_notify_reparent(&my_path);
> + */
> +typedef void (*chdir_notify_callback)(const char *old_cwd,
> +                                     const char *new_cwd,
> +                                     void *data);
> +void chdir_notify_register(chdir_notify_callback cb, void *data);
> +void chdir_notify_reparent(char **path);

Can we have some documentation here (or in the chdir_notify_reparent()
example above) explaining that *path is a heap-allocated value? I had
to consult the implementation to understand ownership.
