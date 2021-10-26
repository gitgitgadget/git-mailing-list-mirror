Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84205C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F5360F90
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 17:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237808AbhJZRb2 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 26 Oct 2021 13:31:28 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:39773 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbhJZRb0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 13:31:26 -0400
Received: by mail-ed1-f48.google.com with SMTP id r12so17411775edt.6
        for <git@vger.kernel.org>; Tue, 26 Oct 2021 10:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nxL+IJees+S6vTfK+Vi1KIFF0v6+WOzU7j2ytrIG69s=;
        b=6E51OSbuuRYQ7cTfFJfOWuFlKZekOlzGpvGwZMTkhYzkZ41rrrzTrd7Wks3k1Dzd4G
         YGFp7KoGyJIknyJQ21Ue/Hrw9uO7WgLrYy4y6LZIIreTiet+yeh2yJiX32t3/G5gh0vx
         R7vsBI3vL7UuIWPjrtwNKkF/HwzidZt4smmLSDE4kdtxW6CzSBZtVJFsQbeJfi+uP90v
         rSZEcscdoB33mwdcE+ACu1Zseo1xwr9XbLuZMeHAU8oMN2VwUXiuGDjC6vstC5sDsXIL
         4FPALOHpdW4e5qy781MjtInchGaOzUGATLfJSvrXAq63jHRLt+CwXIRdfotYka1tlx9I
         Q3QA==
X-Gm-Message-State: AOAM531lldblCUENxX5yHj136M+c3TMGUDhF+e8IYBJK/LCRIvnUcMVp
        h8a2lfj3TS8HBIPRgd61yrJFsqIWfaakSmMM49U=
X-Google-Smtp-Source: ABdhPJyHdhxz6cL0g7HrtoIMoag2aivlAyqAn7TcMFk7WMmnx5FPL2cHtaKDxEWzcLGH8rJ0vsihRJtCvptapBABHmo=
X-Received: by 2002:a05:6402:1693:: with SMTP id a19mr23603471edv.231.1635269341261;
 Tue, 26 Oct 2021 10:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211024014256.3569322-1-eschwartz@archlinux.org>
 <20211026013452.1372122-1-eschwartz@archlinux.org> <20211026013452.1372122-4-eschwartz@archlinux.org>
 <YXfvY3n9wEwctjUR@danh.dev>
In-Reply-To: <YXfvY3n9wEwctjUR@danh.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 26 Oct 2021 13:28:50 -0400
Message-ID: <CAPig+cQoNJpzpL_DYiDFFbZzKwRbwJzuS4+fUcwZ_OLx8onHtA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pretty: add abbrev option to %(describe)
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Eli Schwartz <eschwartz@archlinux.org>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 26, 2021 at 8:07 AM Đoàn Trần Công Danh
<congdanhqx@gmail.com> wrote:
> On 2021-10-25 21:34:52-0400, Eli Schwartz <eschwartz@archlinux.org> wrote:
> > +                                     if (!arglen)
> > +                                             return 0;
> > +                                     char* endptr;
>
> Other than the question pointed out by Eric,
>
> with DEVELOPER=1, -Werror=declaration-after-statement
> We'll need this change squashed in:
>
> +                                       char* endptr;
>                                         if (!arglen)
>                                                 return 0;
> -                                       char* endptr;

This highlights a style nit, as well; should be:

    char *endptr;
