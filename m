Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45927C636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbjBFVMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjBFVMU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:12:20 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04A222F8
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:12:18 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-526f0b3d8d9so106631597b3.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dlav9bRbqcpz4VoWPKvnK5EXVf3Uf5kiHtbIuThm+eg=;
        b=QcnNQ/AkXt1ZZR6bj5t7K34wDj9v2meyYHXCZRA6gle2H2O9GoVLjhd0+6UiqF1vTI
         4gXDT7eoA8HxxVEF/ygep/y5IzXGew/jRtpTL+iBKrMYV2FIrk+604VyEGVnznHb7aE7
         ln6r7xVgGGzYmLxFHa61zVxPFpqxwPOsFVP4JpELZQq8kyffvC1leGQuN9OdYfy8AoTu
         idcIMXeo/P531XwJ7WOVa4f2/SY/A0GawcztaUyaRhBKMeCjeU9ySriuYlKcHY+g1PCD
         9bTpVMNO9lKjdQZS7LCqdusJeoieikRauy34/F4h20/DwPBeZo7LK879zlavD7oaVsek
         qxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dlav9bRbqcpz4VoWPKvnK5EXVf3Uf5kiHtbIuThm+eg=;
        b=krqZYvxSosLhVuXRvf/8pK/jfYdYjaZ9sqrK5JLzgdjnRAuAJG6Omr8boUKXvRtU4R
         iFmrVYlBc7JrepKW5BoB92acX/gIlxDYphLbPOHcBJ9tjhS5mu1tT9+7kYMlg8SgVFeW
         EweCgtUJcTRdnBxaVx5ShLX+1iC7NqKa2ENvkI3BTt3ZVWyOkU1nICX65M3mv0eMHDLG
         nOVwe+Hu0EVkAQtOlGYAjPiHpWNHGcrQkg9SRrAHD2FgRlBSMGLNKxeNVnq6FvpLK1+K
         j1mq8d5GHBVrC539nM1oTsfHvFy0GUDPrS3AMHmIcDcIlHoow+apZ3nvcifu9EWqrokF
         yw0g==
X-Gm-Message-State: AO0yUKU49akAIpG8s7PU1IR+Q1j8bjH059YOR1q+MdE2XS6kTs9jWS++
        AkFF8EWM1/qR9Az2I9p1AGBcwg6ND7tMKZcMLyGT1AvadfsbFOfB/Q5T6g==
X-Google-Smtp-Source: AK7set/ik1lCQrhyp+I1pR/Jr5+3Wdv09U6fYiHcn1Uf2I2ryKNU3pShqF7WqO1ZDJ7EESxq3o5eCl4Cv82MitxGxvk=
X-Received: by 2002:a0d:f185:0:b0:52a:98c6:5dd2 with SMTP id
 a127-20020a0df185000000b0052a98c65dd2mr66723ywf.369.1675717936967; Mon, 06
 Feb 2023 13:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20230206195503.3113048-1-calvinwan@google.com> <230206.86k00u5ygg.gmgdl@evledraar.gmail.com>
In-Reply-To: <230206.86k00u5ygg.gmgdl@evledraar.gmail.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Mon, 6 Feb 2023 13:12:06 -0800
Message-ID: <CAFySSZCO7M8bm8Cc97x7MpZYHd0qWwRHF_YRDmw1rryF6Q7dnQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: clarify multiple pushurls vs urls
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Defining multiple `url` fields can cause confusion for users since
> > running `git config remote.<remote>.url` returns the last defined url
> > which doesn't align with the url `git fetch <remote>` uses (the first).
>
> I'm certainly confused, I had no idea it worked this way, I'd have thought it was last-set-wins like most things.
>
> From a glance fb0cc87ec0f (Allow programs to not depend on remotes
> having urls, 2009-11-18) mentions it as a known factor, but with:
>
>         diff --git a/transport.c b/transport.c
>         index 77a61a9d7bb..06159c4184e 100644
>         --- a/transport.c
>         +++ b/transport.c
>         @@ -1115,7 +1115,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
>                 helper = remote->foreign_vcs;
>
>                 if (!url && remote->url)
>         -               url = remote->url[0];
>         +               url = remote->url[remote->url_nr - 1];
>                 ret->url = url;
>
>                 /* maybe it is a foreign URL? */
>
> All tests pass for me, and it's selecting the last URL now. I can't find
> any other mention of these semantics in the docs (but maybe I didn't
> look in the right places).
>
> So is this just some accident, does anyone rely on it, and would we be
> better off just "fixing" this, rather than steering people away from
> "url"?

I should've mentioned running `git remote -v` on a config with multiple urls
 shows the correct fetch url, so functionally everything is working as
intended -- just needs a doc update somewhere.

> Surely if there's confusion about the priority of the *.url config
> variable we should be documenting that explicitly where we discuss "url"
> itself (e.g. in Documentation/config/remote.txt). Just mentioning it in
> passing as we document "pushUrl" feels like the wrong place.
>
> But I still don't quite see the premise. "git push" has a feature to
> push to all N urls, whether that's Url or pushUrl.
>
> When I configure it to have multiple URLs it pushes to the first
> configured one first, if the source of the confusion was that it didn't
> prefer the last configured one first, shouldn't it be doing them in
> reverse order?
>
> I don't think that would make sense, but I also don't see how
> recommending "pushurl" over "url" un-confuses things.
>
> So why is it confusing that "fetch" would use the same order, but due to
> the semantics of a "fetch" we'd stop after the first one?

I agree with you now that updating the documentation in
Documentation/config/remote.txt is the ideal way to go about this, but
I'll mention what my original thought process was:

If a user wants one url to push/fetch to, then he defines 'url'
If a user wants to push to multiple urls, then he can either define
multiple urls or pushurls (one of the pushurls can be the same as the url).
But if a user has say url #2 and #3 defined, they act as pushurls anyways,
so defining them as such removes any speculation as to what else they
could do (and also clears up the confusion when running
`git config remote.<remote>.url`).
