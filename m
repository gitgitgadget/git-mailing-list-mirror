Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1843C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiAFRJs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:09:48 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44678 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241500AbiAFRJs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:09:48 -0500
Received: by mail-pg1-f171.google.com with SMTP id y9so3104649pgr.11
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 09:09:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fsQkwnkNlGce567WNlIzDn8fButrcgWoJezsBUSt9iI=;
        b=JGm/zIcs9Nfm1Y5Bw4WCTP3sS5Nx0Q4Cy8EN5drnNPU5solm4ANvirEeZIylhT14c4
         HExxpEkCYHtlonI2xMN//b0jJbORuRq9sjZNtmg28q5J3lK5tJyyxm6wO1z8UBr9Ra1x
         owKkHD+iif7eQ/O1yKjGkw8nTuMy3o/v8Z2eERmrE92zk6+4gEcsHeqQ2dOIgsX8cJ4b
         QxgLGFU8H6GMxiFHTbw4AQEgK7n/xFDgafPRmaLXeACvNyH98ScXjMwZbrlVmaHK9CZM
         uappE6vugUFxENPUo9gxV9o4ULhuajFDO4ZWfB36u4A7LIR6+P8hhJnfVo/6rUNhBmnk
         jBCQ==
X-Gm-Message-State: AOAM533My8IMn/U5vg+lKIsqoOmuCeOgNcK3wc2mUYfUdRN/y7hPSpGV
        /M25I93+87OYiWKHNN9ZBAYTAOm4ok9mMScfqYfXzHdgEas=
X-Google-Smtp-Source: ABdhPJwCYf9BPF+Z1xiJis3xPtXFJTzBA1FiU5x0Cx8AddvNhJPqL0YmSxT4uUcm7tiJ4c2wofyLIV1KWxk++efah4Y=
X-Received: by 2002:a63:380e:: with SMTP id f14mr53095572pga.227.1641488987678;
 Thu, 06 Jan 2022 09:09:47 -0800 (PST)
MIME-Version: 1.0
References: <20220105161451.56378-1-jholdsworth@nvidia.com> <20220105161451.56378-4-jholdsworth@nvidia.com>
In-Reply-To: <20220105161451.56378-4-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Jan 2022 12:09:36 -0500
Message-ID: <CAPig+cTeh=PKsvftWL_WPKBzqYkNr3+rEfqAgOsyksROBk8q1Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] git-p4: don't print shell commands as python lists
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 6, 2022 at 7:54 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> Previously the git-p4 script would log commands as stringified
> representations of the command parameter, leading to output such as
> this:
>
> Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']
>
> Now that all commands list objects, this patch instead joins the
> elements of the list into a single string so the output now looks more
> readable:

s/commands list/commands are list/

> Reading pipe: git config --bool git-p4.useclientspec
>
> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
