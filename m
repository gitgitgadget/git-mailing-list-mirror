Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2896D20248
	for <e@80x24.org>; Sun, 24 Mar 2019 22:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCXWhj (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 18:37:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42949 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXWhi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 18:37:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id b7so95687lfg.9
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 15:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WfGyRnFJoqsx35KrAa+U8P0NtA2+X6o4XgCNN9wuwjI=;
        b=ViMwXgd1k+h3omF0qps0wK5STKk6T0W22rxD408CJTfAeEhLsEDJiUZDDYwkzYfQUv
         BhjeEDJGSO5EHzySDt2U7wv6YzA2nsb9qdKOtTYFPT8QjFJ0pkNNoCJnoj6M71P/zNEB
         vN7SZqZLYuRpxjAmtAcDZMzQ4EBeE/LVgt4jgmb4hxYq3tejpdFkqsjYuP/0zwdU7tYI
         wbYFijyMV+TN0/GsfxNKo/q7cVL9WHeC+lHPCvQ3Ar1we92aaOMdDFDAlnm+wiiThzxl
         mf6OyGMVm/SSmt/X1KSAU3JhVcyq8/uCR7hTvFDK5PpZcefUytf1GRaw6hIArK6Bw8NG
         pZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WfGyRnFJoqsx35KrAa+U8P0NtA2+X6o4XgCNN9wuwjI=;
        b=raqQd8lRR7b+etKp91QBQ5lygUxSVIHh43+QuTvXkpvtgkQXAO48YyVnEjUdxzXvEE
         XzbZTQyNz5fTG+6mLR7W3cEqxC7TtmixrO18j7/kkmkir2PmNZYxtnFm7mhLCod49MG/
         ug4nF0a2G/8XJLjZSxziV1MQOcynHBqa4OkKuaEjRoX+9WPsTFdUEbuQZ0gv3DqKqA6i
         miDRZZg8/cE+u03wSZCCApEZNN6lmz/rpm4YoFBfeiH4Ot1/EynYSsKoQnjDwqWXJSis
         Sz8JMpajpjOPuYO8TRGKo1N8IaDGsmkfO1LqkEs67KXOuyCTifWKUhSYeEWgmKZve7Ue
         /w/A==
X-Gm-Message-State: APjAAAVX7a9fGHfxpQVOsgFJHJTm7VnElBC+i0sGz81TWSXHiZrkmmSk
        V/zSkjc7C8IWuVU3g66HOMBSkl1fWUmFAwYECqA=
X-Google-Smtp-Source: APXvYqwhou+DXa/2g8qsRivf1K+mQirWT+4SnXNYY+T6Z59kGgLxs+eOqfCXaRzg+T178Uqx5Se8rNQMaE6YlLWQJto=
X-Received: by 2002:a19:9107:: with SMTP id t7mr10696791lfd.48.1553467056847;
 Sun, 24 Mar 2019 15:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190323041332.9743-1-alexhenrie24@gmail.com> <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36ncpgpe.fsf@gitster-ct.c.googlers.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Sun, 24 Mar 2019 16:37:25 -0600
Message-ID: <CAMMLpeQbz5qHyK8e4gZ0zKQ5na+zQCd49GZifKZ_iO-gXrs1Gg@mail.gmail.com>
Subject: Re: [PATCH] In `git log --graph`, default to --pretty=oneline --abbrev-commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 24, 2019 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Having --pretty=medium as the default almost always makes the graph too
> > difficult to follow.
> >
> > Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> > ---
>
> I too thought that "--graph" should make "--oneline" the default
> back when I originally accepted the patch series that introduced the
> "--graph" feature, but with frequent use of "--graph" myself, I
> stopped being sure that "--oneline" should be the default long time
> ago.  I find that the default level of prettiness goes reasonably
> well with the "--graph" option.
>
> This would be something that needs a long transition period if
> somebody really wants to force people to adapt to it.  I am not sure
> if the complication is worth it.

Can we compromise and make --pretty=short the default for --graph?

-Alex
