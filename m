Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D6C47097
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC5CD613B8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFCS1k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 14:27:40 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44978 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbhFCS1j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 14:27:39 -0400
Received: by mail-ed1-f45.google.com with SMTP id u24so8186793edy.11
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 11:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P87smCWxjPydcIYTaL0H5pG/1ngY8Jr34P3pjTON4rg=;
        b=gF5Ym4+Brq2Mncz4peKtEV88R1aFKeHHJhFj8SalGo7OUFh97+OlEy8JD+Nm21h7Qm
         OEoFBPhXZ9dt3/cuWsY8WSXmJw+oUPQGIJ7Y3WU3bRGlSnn/z+ZUq2K7TH4sdfFefMNM
         m634Ls0vjnqgXlnx7KnGBNJh/rtLd2oblYrAdpvBXsjEHICAFUWALfdOmJNtn5dxlVQI
         /4a9VpwqQ+xnqz4fUoXHSf+r5n1oGcIB4MhbTUGd3HOW+773LvcezdraZTQSnjL3hWqM
         t96VvokxFIpQogjsCEfraNUftmjhq3FYxrd6UjxsD09qLmpcQdaU3iFXpKcCTtEwARxy
         qqqw==
X-Gm-Message-State: AOAM5312dQIdg4QFSmRV7r/D4R06y0dVbS9bJLAiVAHW30MrWkjbkr9T
        c87eM39vEaCAI/RBDSbQX/Jw0vJ47cY2IPBeuZ51u/R5aVUu/w==
X-Google-Smtp-Source: ABdhPJwS3IL7kgThq117oRHBB6jcjQjxqKCkoQhIpGpgmoSXyIuJizbbE7uKK/ITBR6a+8Qto4nT+Aw7hycLAlVy6es=
X-Received: by 2002:a50:9d8d:: with SMTP id w13mr823822ede.94.1622744753816;
 Thu, 03 Jun 2021 11:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <d93a3024-ba8d-3469-2dba-2e0032334232@gmail.com> <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
In-Reply-To: <20210603180851.5tbnuvfb6auxrhvm@nitro.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Jun 2021 14:25:42 -0400
Message-ID: <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
Subject: Re: Gmail OAuth2 in git send-email
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 3, 2021 at 2:09 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Thu, Jun 03, 2021 at 12:02:08PM +0700, Bagas Sanjaya wrote:
> > But for users that use Gmail (like me), we must either enable 2FA and
> > generate app-specific password for use with git send-email
>
> Is there a general problem with this approach? Gmail has been my
> recommendation for everyone needing a free email account -- it's still
> possible to configure it to be perfectly usable with patch-based workflows,
> even if it has its own ideas about web ui treading.
>
> The fact that Gmail forces folks to enable 2fa for app passwords is an added
> bonus in my book. :)

The 2fa requirement is a problem for those of us who don't have
smartphones or SMS. (I see now that they also offer 8-digit backup
codes to print out for 2fa; perhaps that might be a workable option,
though I haven't tested it.)
