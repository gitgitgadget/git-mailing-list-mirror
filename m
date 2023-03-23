Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43BBC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 06:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCWGvP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 02:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjCWGvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 02:51:09 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B052D14F
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 23:51:08 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id c10so10989411vsh.12
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 23:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679554268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AFtgyvTHnBG8JVBC9FnwcsmmuXxK2zLzT5ag+CUeLWs=;
        b=adJDE9I2QYn9WIaUY2vy2ntZUDxMhscH0N28SJOrXSw+pFvp130YVnN4hsOSwUjeDL
         cO3kIEZ22hDhThZSpzG1RZH7ZNch2Uyh5RN4hafqsq4Ocqyr6s/0Sx5B69XscvpEJRHh
         YvPzcAavv5BsefNlX4oZ4vGP6rbsszlMQOkpPUA7MRLoazbiFMZIkLWuGlTZdKxVwttt
         8FQDPkcQswrxJ8ESrmArSxAwhPbJXkzFX8q5Z1KonLHtspB1pkwcMWvxZIUqpfCeXSxp
         dW5AR3y+auUYhNL5c921Vxtz6oxBpX6QY6xFPuVXpw5pGbvudpHMsB7xVET6Ii8msmLC
         PYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679554268;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFtgyvTHnBG8JVBC9FnwcsmmuXxK2zLzT5ag+CUeLWs=;
        b=v80lh+Pq0G/w9TrjzOfeqGQIjthnpMegbUIt/BiyKJEfTEEPY4yiMWqDTcuwGACV3q
         dd7MrWkGlRwPIbGfJyXSKDyhIjdyzhpE+vXR66KgIGb32xpR1gsG9H5twYapSSVHQLnO
         EMPjplBj6QIERCEc+ANJLYfcv6sqLx6QP1tdEctoEHKHnBt5FWz22g0S7nYvCPgVR0WK
         i6ncGE6JzXhU7mLmzpCk7aAs9vWp+0p2jKxWwSQOqqg3i3FT5xvWmeSxokDqT7z9X6Gw
         9flZSi3TC8WL7JmQzwMgyh0OHsb0lARbVEYHxwZ60Od3GACJ8uEy2x79eNwb97lGsRO/
         tjGg==
X-Gm-Message-State: AO0yUKVwMP9BruZiFpgopp1OmkLs3PbXDlTCOpukqt8/BmMcRQVE4Yxa
        7mTIyKcCZzd3zEkUz7/RITOVJO/nj/9JWEkBslv3oVBiHUA=
X-Google-Smtp-Source: AK7set9AA18gkIU/uUwoXvuQ4s4V8YxVkK0Wt+VnZacaVrPCu8y5Y9GroGwOLu2ZvrBUMETQX2biNp8QeCLST2rAc/k=
X-Received: by 2002:a67:d61a:0:b0:425:b38b:650 with SMTP id
 n26-20020a67d61a000000b00425b38b0650mr1169335vsj.7.1679554267656; Wed, 22 Mar
 2023 23:51:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230226083347.80519-1-gvivan6@gmail.com> <20230323063844.23222-1-gvivan6@gmail.com>
In-Reply-To: <20230323063844.23222-1-gvivan6@gmail.com>
From:   Vivan Garg <gvivan6@gmail.com>
Date:   Thu, 23 Mar 2023 00:50:56 -0600
Message-ID: <CACzddJq2USyx4ttdj9rjFJubkq-6GiEirrJJ-qym7ZmOPs+mOQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v3] GSoC 2023 proposal: more sparse index integration
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have taken into account Victoria's suggestions and made the necessary
changes to the previous draft. I would appreciate any feedback on the
revised version.

Additionally, I wanted to inform you that I had planned to begin working
on git describe, but unfortunately, I broke my ankle while skiing two to
three weeks ago. This unexpected event caused a delay in my plans.
However, now that I have adjusted to my new lifestyle, I am confident
that I can resume working on it.
