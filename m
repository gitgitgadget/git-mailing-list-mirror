Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EAAC433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 06:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiDYG0B (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 02:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiDYGZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 02:25:53 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EBA40A11
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 23:22:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z19so10191557iof.12
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XJI0cavHP6+QC1fVoHIhFmaxK35A4o9DnsHsQkl6LNg=;
        b=PgQMrXHx41KVPaXRxJVM5MnP6ekaBXzjzKxgLKYFyLh349zuZXs1Wm5kMLvWzz5Hfi
         EcN6h+U4ZGTlDv6dFqDvXE45iYjMbFvPxziado5mJ0wtHVq+IXrKIBHasbGLfV8uideU
         28yGOsMam/EOfAf9qTmVwk6iPfm2JgrW4n5Z16f6TOs7/862Xcweceg8ylrxW5orqVOX
         aM352rAqVZG1z7GJ/tq38GXoieFFK1WKk1PDra44axM1q/uXAviHUSfCpVX/uoWEa9eA
         HmH3+mD9ShWONIjqWMe7/0uGYex0UgnqA8rmkkk0lqmonWDaNz/ConR/fJyUbh/GyNkj
         9yiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XJI0cavHP6+QC1fVoHIhFmaxK35A4o9DnsHsQkl6LNg=;
        b=4UxhDsXUiAzSA1nmy5BsuSyLtM5pgk3Y6rYTk7wFZHABpTOIL+mlNcMUSv8gLb30Rv
         eJm8A3ae1F3DCfcQgzOyIwjAs+UKLPTo2k7ysv9b/gnrpGE2R1XwGfPmgS0CjpAcCnFF
         6TX6EMoBSxhf7Y34BJZsDcBV3FdVp95dvWkmyVAE8u1Sa3rGHbLsoyMijgWavfD2tNju
         RoSYpmOQ9sUkK5UVV9SB8/ceZjWN2wOMITFKwy1eM9v0pNjMxxHLCaCwzgV8tOfQE7MG
         X0OhWbeL4jGURKHmtnCO/Ba7/NE7gE7+82lWDGLOOFA83FkhK+CtxRSacWM3p7pBni3A
         fs9w==
X-Gm-Message-State: AOAM533YAauQLLeDUUjvFVBI7WbCO+vl5q0/0XtPoWlu/qvlUD5Qf+G6
        5CpxHhMpylL4e8+82S0j6v7b3mcTzz/1u/9YUmjnjia30pmprw==
X-Google-Smtp-Source: ABdhPJzvmcA6Rns7gnbVArhWHNODrNT6jknulyZI9kCvvgsK/lUhTTWRL7Cxq0bkvQiwsIcXfqDAAuEAABO6uoUCPtk=
X-Received: by 2002:a05:6638:12c2:b0:326:665f:5bc2 with SMTP id
 v2-20020a05663812c200b00326665f5bc2mr6501601jas.196.1650867767164; Sun, 24
 Apr 2022 23:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHZPcmD3xmsuM5XQzczqKQEcVXXXc=c9cH9cpqDNPTpBrwd2iA@mail.gmail.com>
In-Reply-To: <CAHZPcmD3xmsuM5XQzczqKQEcVXXXc=c9cH9cpqDNPTpBrwd2iA@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Mon, 25 Apr 2022 14:22:35 +0800
Message-ID: <CAJyCBORnAsJjC6+JmDX_nMMnAEZbLbhVNK9QKB7cb88KGUsARQ@mail.gmail.com>
Subject: Re: --help for git commands
To:     =?UTF-8?Q?Dorian_Mari=C3=A9?= <dorian@dorianmarie.fr>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2022 at 2:26 PM Dorian Mari=C3=A9 <dorian@dorianmarie.fr> w=
rote:
>
> Hi,
>
> I think it would be nice to have a simple help like other programs do
> when doing `git [subcommand] --help` or `git [subcommand] -h`.
>
> It would be a short version of the manual.

I think we do have a "simple help like other programs do".

You will get the git manual page for a command, for example, git-add,
with one of the followings:

`git add --help`
`git help add`
`man git-add`

Or, you can get a "short version of the manual", i.e. usage string, using t=
his:

`git add -h`

--=20
Thanks & Regards,
Shaoxuan
