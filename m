Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63BF9200B9
	for <e@80x24.org>; Sat,  5 May 2018 13:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeEENkj (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 09:40:39 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:54234 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEENki (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 09:40:38 -0400
Received: by mail-it0-f42.google.com with SMTP id n64-v6so876821itb.3
        for <git@vger.kernel.org>; Sat, 05 May 2018 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U0jJxW4NadUCeYdr1lWGHpncc+myhuuUjNBkWhAVDek=;
        b=GbtNDpeLxA2eqiJN5k05XDJPEMNhEbd5p0AGfscZwgjCvok+4wv4fV+eg1OmkTvZNB
         E83jaK/zRhSJq6/f4DZb5ubZ4oeKZrM1TVZZh0Of8JjAkWxB+MbSRANxSkdYsFyvuINs
         VvcIc2Y6v950x1e7SsF4U1zEAjwXjBUqRDI7vkCkJ07H31+W57iVck0PkJKEAbt/7Agj
         F4OsQGdOOFd6Kft58W5B4SytGxdnrq+M2gRgJvxUiscsl7nRqWhoyarJohKbzjZnbWCB
         4+41+o1vjVAk8JfHmkZlmK9rRNDXUOzeFhVRpN/p0BKaV9tqbjr+WEuKho70p3ykm4el
         N93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U0jJxW4NadUCeYdr1lWGHpncc+myhuuUjNBkWhAVDek=;
        b=r0PQYvSGAtgcnMzv9w+NFxBWXFosRfkGvRSwJORvUKBnp44TPQbiskCnmEt+oStG1D
         /XzzSsI14tYfxakmsiuInvL18+Wo0w2XIUJCrXjUmqbRi4t8wezSM9pliJmmi528GP7h
         a+CGF5y+qooOeBiyIlTrjnNn7bbgkgXRaroAqjHEkU+/2hLsUuE+sntyfe51fF1u+oH+
         Gr7IZ9o1lLVz9IAF+WY2wWAu4rih+/5I1InI8wsuKs89/u5kX+op3M6dZXXY8gLsOncN
         QjRC14daAAr3Kh8VguZtJXb8A4wRgionpochaZla21Q3v0tRe7VujgfiAVD8WXm0nj+x
         MIWg==
X-Gm-Message-State: ALQs6tCJl31sI59kpKwfKNJScLnBGdTyRmt6MCIjcx9erYSrgkC3TGuH
        007CIv47e8CiEB7VWjFH4yCvxy1Z89a/bPN1qHw=
X-Google-Smtp-Source: AB8JxZoyn6YCtAEn7bhfjJtSN92fQuMDtDkZwZh1WLtjo5Rsbo4gm2oxgUSFqBmOQI9xUjlTBBgIxK3V5qajxzpDMQo=
X-Received: by 2002:a24:8a47:: with SMTP id v68-v6mr30284790itd.21.1525527637715;
 Sat, 05 May 2018 06:40:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Sat, 5 May 2018 06:40:37 -0700 (PDT)
In-Reply-To: <20180505132423.18324-1-ydirson@free.fr>
References: <20180505132423.18324-1-ydirson@free.fr>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 5 May 2018 15:40:37 +0200
Message-ID: <CAP8UFD3jc6Aops56pgQCw7cYKW9ujkUmtDgLfwo=VyBy-QNKAg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Fix support for merge options.
To:     Yann Dirson <ydirson@free.fr>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yann,

On Sat, May 5, 2018 at 3:24 PM, Yann Dirson <ydirson@free.fr> wrote:
> ---
>  git-reintegrate | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-reintegrate b/git-reintegrate

It looks like git-reintegrate is not managed in Git but in this repository :

https://github.com/felipec/git-reintegrate

So could be a bit confusing to send those patches to the Git mailing
list without telling that your patches are not to be integrated into
Git itself.

Nice to see you again on the list anyway!

Best,
Christian.
