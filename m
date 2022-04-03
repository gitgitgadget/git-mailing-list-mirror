Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2B0C433F5
	for <git@archiver.kernel.org>; Sun,  3 Apr 2022 13:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237253AbiDCNWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 3 Apr 2022 09:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbiDCNWS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Apr 2022 09:22:18 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339ED29C80
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 06:20:24 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id q11so8289712iod.6
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 06:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AIuqFfNkqvp9dSWWAOGKf4w5ggTRNRa/E5pR67O4ZDM=;
        b=ch6KFmw/ohZD7n/OrBV2/rdqFoJZkMHyxA8uWRxxEbLTnEWVL8KyqvzKqWP+Xhiuhf
         YOoi0pkHM5dFYKEQN/sqQb+3IiOr/LmwXTBgEW+aowSIG0APlPw30ScVWp73N+ZrrZ+e
         QCq1I8+gw1hBNDpZmLkd/nIjD929L5gzLzwfjUmmSIb5snA2xz7Ko2iWsNn/uBkhytKP
         LqtaN5DxlYg8WZIGoaQw/xnxUNd1g+YOnDvUNJ+l4I/XYplknV3gILxWrYLZwBcyeg6K
         SsB4E7BNefv3/dc5NlmqrJ1PEdE9vuiWw7PI5/jbsqQy14siosfGnY8ty3DjU7tbbjVC
         th2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AIuqFfNkqvp9dSWWAOGKf4w5ggTRNRa/E5pR67O4ZDM=;
        b=UbprmEIC8gpGYIjn+FOzXiGw8+4kIL6gBOXKn5wSwk/+TL9fRa5vIam+4DXT1JnOKt
         +RbPoyFomn8V7asgROnmBUWMrMmQigROknU5pDKBgBXyNTpBYywPk8x02BtyJGI9h7vO
         Su3xwhCupEePQOhHpoAQIRNsE79JD94BGefBNhoBKjGuoVr6rpoDfmTHp5XveauNHTAn
         hIvQkr9Icpa9JBEbJZhGEOe6F0UbcyPnET4QdayeRGzg+dc7n/beDadfGtJXTR8OG4Or
         iUyvkWfZDem01PnSWEqJTsSSI5f2zTu5yAcGvFxJjYWzdnBIBzmjq22twFRc0qFzTMYS
         eVeA==
X-Gm-Message-State: AOAM53152nvdpBlNN+MC79YBfne9xSPi/MoiDBwhPr9YTrroCLo8ErUF
        gLqOQR5nH3a38UWrutja7spFw2t4uaBihYJJ/Dpu70Wlc9M=
X-Google-Smtp-Source: ABdhPJxELvqpvjQgX9DpE87pxBNkLmIibXZeDk8tEpIAfIci9prd9YyM2ADVaNw/81rlX56jpDob9H64eOl9BTjijWw=
X-Received: by 2002:a05:6602:2d10:b0:649:c671:2014 with SMTP id
 c16-20020a0566022d1000b00649c6712014mr3579681iow.39.1648992023480; Sun, 03
 Apr 2022 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220304130854.857746-1-a97410985new@gmail.com>
 <20220312164803.57909-1-a97410985new@gmail.com> <kl6lwngwqwm2.fsf@chooglen-macbookpro.roam.corp.google.com>
 <d8783660-1487-1899-19bf-10654801ea0a@kdbg.org> <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lee33xd5d.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   xing zhi jiang <a97410985new@gmail.com>
Date:   Sun, 3 Apr 2022 21:20:11 +0800
Message-ID: <CAN_FRNK5HKYF3R3+i=CqOkaLx6JxZjw6=VU4_6euYXThSbRf8w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v2] Add a diff driver for JavaScript languages.
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 16 Mar 2022 at 02:51, Glen Choo <chooglen@google.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
> So the question becomes "Is there a significant amount of code that uses
> this pattern?" Probably - this is a fairly common pattern in Node.js
> after all. But in my experience,
>
>  module.exports.RIGHT = function(document) {
>
>      return ChangeMe;
>  }
>
> is even more common. The difference between 'module.exports' and
> 'exports' isn't worth going into (StackOverflow has all the answers, for
> the curious), but if we're taking the approach of supporting CommonJS,
> I'd like to be consistent and also support 'module.exports', i.e.
> perhaps change:
>
>   "^(exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
>
> to something like:
>
>   "^((module.)?exports\\.[$_[:alpha:]][$_[:alnum:]]*[\t ]*=[\t ]*(\\(.*\\)|[$_[:alpha:]][$_[:alnum:]]*)[\t ]*=>.*)\n"
I agree on also support the "module.exports". This will be applied on
the v3 patch
