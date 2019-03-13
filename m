Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB74020248
	for <e@80x24.org>; Wed, 13 Mar 2019 01:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfCMBNm (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 21:13:42 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34301 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfCMBNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 21:13:41 -0400
Received: by mail-io1-f66.google.com with SMTP id n11so368686ioh.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 18:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pHJEZBuBLCLPk/CvQr4EmB9wzRhDIVds6fBeoJ9rsk0=;
        b=j2Y+9M+mUfxDJTR0jOAxNoiu5QfHwBA1gHaXZSppuPlDiF3GaEcQLm9VxC6cXmshDg
         K394jeCKl1fvSGpDG4B2O2bYIIIKUZWQS1v7NE7TnnkFaOYtbK7Bo4TIGyWiGOeYxOjN
         asjAHWEUQubOkfEC9Y42DXbBaVF+b4DztbpKhHI7oJnqm5iPSp2PJmr3lKHaZ4Daur3s
         0GGg+EQlvrsI02PB0PTaeTukWd0/ZrJId8qoq8d1uzdMCFiLQi5+jULsNgCu39ulUGF3
         LLiijSH/P62cO7LVNTF6uNeG7Trv3M88RlcYjF8H3ccNQx5H6NwsScHlgRL78zUfisC2
         xwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pHJEZBuBLCLPk/CvQr4EmB9wzRhDIVds6fBeoJ9rsk0=;
        b=i6f+B82wVUK5Z0vpOZmGNpnsv5HPmyc4MIJJuwhpOVYsXENXHpcH+heZqvq6jL48xf
         dFVjwXgPxxg+Xpu3iLvSLUD1P7eeJsAy45ZOqRfSyC0qrkXUl4hLZmXu+2P935L4+zEn
         YKsjChTXqYvywXIy64oyJjgzyW03T4uMb36JES6e073Bdv2DJ0byLQFow+Iwz7dsIVGZ
         ifqUASRau517w7mCXahAQ6snPlK4/RYqoUzfWZeJWy8IdwtGUL3EJ7wcuaSUTzmRqFWW
         KYvOWoCI/KMWKYl4ztJ/m9sNVeopzNyXRUjrpTmstiYXaFO5cXwv/jeb0byxnZcEXEyj
         SFVg==
X-Gm-Message-State: APjAAAV0HPOpQ1qhclzgJdnU2H6QFw7xwaAnXk7U0dF54rl/0STU/hse
        6nrhu43ul+v7TmLw/KCkShOPYLYejdU/5q9f8GM=
X-Google-Smtp-Source: APXvYqyZ4ephgvRn8hQ8uwlS4ptlSVpkWVHa3Bu2vwRgNmfwbEs1fD0dtd17H5KqsbpVTT9m9ElmaMmrqhcmgLTaNM4=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr6848575iom.118.1552439620816;
 Tue, 12 Mar 2019 18:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com> <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
 <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org> <CACsJy8D48YiWYkuLW8BbeYvRz=yMmb=XWoMJroPXFAcSV2VjHw@mail.gmail.com>
 <20190309172733.GC31533@hank.intra.tgummerer.com> <20190312233040.GE16414@hank.intra.tgummerer.com>
In-Reply-To: <20190312233040.GE16414@hank.intra.tgummerer.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Mar 2019 08:13:14 +0700
Message-ID: <CACsJy8B4gEwuyVV_T+vYdMNjs-01rxCk5G9yxbJOSkKWHGgnSg@mail.gmail.com>
Subject: Re: [PATCH v2] glossary: add definition for overlay
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 6:30 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> Add a definition for what overlay means in the context of git, to
> clarify the recently introduced overlay-mode in git checkout.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> ---
>
> v2 addresses Elijah's comments (thanks!), using the wording he
> suggested in [*1*], which I agree is slightly better, as no-overlay
> mode doesn't touch untracked files.

It could overwrite untracked files (e.g. the file is present in the
source, but not tracked) but never delete them. But I think it's the
little detail that we could skip.
-- 
Duy
