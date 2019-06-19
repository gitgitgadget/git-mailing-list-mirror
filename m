Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06321F462
	for <e@80x24.org>; Wed, 19 Jun 2019 00:51:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfFSAvv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 20:51:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42510 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFSAvv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 20:51:51 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so34144118ior.9
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 17:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIjaSTMphxDH8t5+mWSNNSSVY0LvlFrcELS2PjBBwgw=;
        b=p1wpseFJIQoi+IGJLkYq5owWoCP9Ctn5lWRFBGe7KlGc/CrNzNWdjcj5n8wigPA/oY
         bCBebOdPcM/TDvs8ugwmfMbzRFqOGX+YSTD1wSE9b9AM6f0rWKKh5YYOOl3KB7RIaISM
         sIu2m4OgnCothD9KVslZ7SioZ1qbs9kH6rl6JnywUOMo62/qlZwvVEWjI2g8tn83vAy4
         58PwRIyMBPcd9jZ3MurCHxGQCoAk+4nJYkbMcif/zHQYLTmh0/ZcR2ELShq/b6cy9Gjg
         my7hzNqG2qP1UIcM9WjjvIi6T62EJbmGaJWLKe1h5FFLJhYn2HExBUEZXhBhQ63cFjsj
         yU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIjaSTMphxDH8t5+mWSNNSSVY0LvlFrcELS2PjBBwgw=;
        b=FKdiBwvFVUXQObbIbkC/cLl9kln0khU0rUOsiI5sDSuQbC6zwDazZCmULYDur1kw2U
         kCt4TFc3bGV/ObYcsXvxDEdtis0qqgEGoKxxHtlOaKUWuISYSexMeI1Wr6TSjU0UAdhI
         B9jE/zFTL5xBY18dZghQrRGKu6CYWlYAWUJ/9UxfvWfEsiCo9reYmtyHmyZyA6HPeDxZ
         XA6U98YHqR/qvkXbfTgi9QxZnD+AU1Lbt3Iymcb2hnkHZlUzOwuNmw2GVvlvoEHKZhaM
         UAHGxeB8fYhwFC0ZKy9qALUsHgp61a+fDkoBvrfgwY/buEM/QaNisYBDKto73QgO8CIn
         6gnQ==
X-Gm-Message-State: APjAAAVvr1KpnV8TedPONs6ZlG/ROubWGa11vGtznD11UYVmaUWGs2Ve
        ek/1kHYLWvv4VAVZGKUXmlSLJl7fyDWXsn/JbmL9MQ==
X-Google-Smtp-Source: APXvYqxquagulULLURxhTsnK3XsUOmzaXHLyUuECdyEHG4FKVvF+v6n1OzHdrPqHfa2+QMe+W7iLoV2sUrHhLGdf7nw=
X-Received: by 2002:a5d:968b:: with SMTP id m11mr5739433ion.16.1560905510684;
 Tue, 18 Jun 2019 17:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <pull.149.git.gitgitgadget@gmail.com> <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com>
In-Reply-To: <587cbcf61903693139ad4a02b32727bddd6d116d.1560860634.git.gitgitgadget@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 18 Jun 2019 17:51:39 -0700
Message-ID: <CAPUEsphHXxa6xbckKym7Nbx_E6aOzJYL+5j=xXa0oe3BLMrtbQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] msvc: support building Git using MS Visual C++
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 18, 2019 at 5:26 AM Jeff Hostetler via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> diff --git a/compat/mingw.c b/compat/mingw.c
> index d14d33308d..667285887a 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2388,6 +2388,12 @@ static void maybe_redirect_std_handles(void)
>                                   GENERIC_WRITE, FILE_FLAG_NO_BUFFERING);
>  }
>
> +#ifdef _MSC_VER
> +#ifdef _DEBUG

why not use DEBUG instead (without the leading underscore), then you
could also drop the -D_DEBUG below

...
> +       # BASIC_CLFAGS += -DUSE_MSVC_CRTDBG

typo

Carlo
