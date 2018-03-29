Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18181F404
	for <e@80x24.org>; Thu, 29 Mar 2018 14:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeC2OyQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Mar 2018 10:54:16 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:44582 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2OyO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Mar 2018 10:54:14 -0400
Received: by mail-ot0-f179.google.com with SMTP id p33-v6so413933otp.11
        for <git@vger.kernel.org>; Thu, 29 Mar 2018 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bx5ZO5a9/+ZZdDwvJvZ9wAws95xrCi4yIT9yqNWUDDI=;
        b=KzU+4XaLCtnNVf85c8AaKWiLZy8nLPGiMfsAL5EiiXDLCFBZBJOlVAN5uXpeqwhUlq
         76ZJM819La6emJE6JUuGviW0uPe0hCwYA+rfGxUiRokRCmnsmQ4ImaAnhV7d/3BeCEFY
         ftN/Jri3iC7r13v+JJ8eU2ASJapOHQ5pnZMoC3qAG/VvI2MkACKG8vnlVKqyDQF32KRv
         XDAQtkTs34Kn1+1l7F4T/VSvsZNUFACZPqNZwCXNBvesWNop778R/ma7//We+ximwnjr
         F2II24C2A+sq9ZfoqoNbpSLsBI8If8usaPpHXNbUuhUBmALl3cR162Gbn38G1cMr1N4l
         mGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bx5ZO5a9/+ZZdDwvJvZ9wAws95xrCi4yIT9yqNWUDDI=;
        b=NREjAVKuqBmOaHA8K+z2gy5bhB+7rV5EPIQTqNW3wObx3zQ5i7MiAjLceiCe03Woak
         oK4RWB4LYSrwy+REG2fLWlku2hLYSXXnAXrpwe73KXzcS9CdlPevCwOb4+6efM7Q4Z9I
         fryuNqXIQDKB3sY4lEJ/iljyZGWORyg68gZLcsADjg8XQdazVvKLGM6vkRFxHmCwC0en
         CiO+OPr7zz/tJ3YE2pYDdioeJYYAoN2xqgCzTwa0ixi2YImwsot/hMZBedfAMbKwi9G6
         Mr96VODEZ6gbPTKmYM9aINuVWOaUu6BEdg7oayAXD6wm8kfaFgADZQNIWlTjIdQgL78Q
         WlNw==
X-Gm-Message-State: ALQs6tC3k2U9FeP+GWFR4TBKoEM4ujzdD8BxJZWqQDTZWbqZnNKCk3ew
        1YxxcXnQP2qOHvQ6or0SnxOB97CYRZpPAEDvXY2NYg==
X-Google-Smtp-Source: AIpwx4/BkE2c62nmoi5l7Ua1/r9pQsKJbavjr7gYeTH++w3gsmMMvQNfU5vCGLLwhOhjw060JwlJwYBvxZexWs/BFVQ=
X-Received: by 2002:a9d:5190:: with SMTP id y16-v6mr2616721otg.173.1522335253693;
 Thu, 29 Mar 2018 07:54:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Thu, 29 Mar 2018 07:53:42 -0700 (PDT)
In-Reply-To: <20180328174041.GB16274@sigill.intra.peff.net>
References: <20180328173656.GA29094@sigill.intra.peff.net> <20180328174041.GB16274@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 29 Mar 2018 16:53:42 +0200
Message-ID: <CACsJy8CCvshwb8a5ZozJ+x0D1kAYbeLSgJ0LDm4Z=uUZLtpsjg@mail.gmail.com>
Subject: Re: [PATCH 2/4] add chdir-notify API
To:     Jeff King <peff@peff.net>
Cc:     Rafael Ascensao <rafa.almas@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 28, 2018 at 7:40 PM, Jeff King <peff@peff.net> wrote:
> +static void reparent_cb(const char *old_cwd,
> +                       const char *new_cwd,
> +                       void *data)
> +{
> +       char **path = data;

Maybe check data == NULL and return early. This is just for
convenience, e.g. instead of doing

path = getenv("foo");
if (path)
    chdir_notify_reparent(&path);

I could do

path = getenv("foo");
chdir_notify_reparent(&path);

> +       char *tmp = *path;
> +       *path = reparent_relative_path(old_cwd, new_cwd, tmp);
> +       free(tmp);
> +}
> +
> +void chdir_notify_reparent(char **path)
> +{
> +       if (!is_absolute_path(*path))

I think this check is a bit early. There could be a big gap between
chdir_notify_reparent() and reparent_cb(). During that time, *path may
be updated and become a relative path. We can check for absolute path
inside reparent_cb() instead.

> +               chdir_notify_register(reparent_cb, path);
> +}

Overall, I like this API very much! I will add another one similar to
chdir_notify_reparent() but it takes an env name instead and the
callback will setenv() appropriately. The result looks super good.
-- 
Duy
