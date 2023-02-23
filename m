Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A975EC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 09:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbjBWJUc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 04:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbjBWJUa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 04:20:30 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F49748E0F
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:20:29 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id f31so14099176vsv.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 01:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677144028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAFjje7WeVw6N872Ok6IJabjpkz+/UmtkuE1tS2yjAk=;
        b=CDfaKQccKOaEUChrqE2qizRf4Nb2n9v0Fjc/bIYFs5yyN0oKx0Gm5hI2wdcwKTqD77
         t5znDNp/bjG8VSlEu73ZhVtyI8GYs5xsXp+lsGDXknwBt6N35vlGI7XxXgiH/KFgwqvb
         A4/BkcuOkq4MmAzDU6irsisVjITJyt5fSAnlF2f8InUedz/RddNxu908gHZFhjc6i8VV
         zWyUi7nIPF/L1II1+RqE2uRdeI+hfjT1ghtk0epa302IncCKdaXba8zWN3S1jwHBqyht
         QYitc4GWZOsc5Dj3zEkNFGX8est6zwoTLHgJetawHOfi5S6OwEcwTQD4ErTZjfxYt7hD
         AHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677144028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAFjje7WeVw6N872Ok6IJabjpkz+/UmtkuE1tS2yjAk=;
        b=RyX9GaxAXo3Wt9m7uuY2yQznorki/gaTZNSmW+r9z9LFnLmxlmWIep4Vi+N7nB2fbL
         MMvNMa2G4PH+T/bhExbUs1ooJ6n3A+iy9I6Cj+Co5YYyAi+KaKwgnXqH053t9OE2fRgm
         Km0pZUB/iJ5hvVmsKi9qUhGW4fRi7TV+u8aiU+p5JrnJOUFsYWEbmmBAO+7PvvRuO7dI
         QSONI4weg5ER4O2A225DRZnOjqkQRcK3KrD+W4ucc2NAedRFJZDl6gWZE2agCcy8WZRn
         HZot3W4iUdb8I2xx1NPiPzabbIYnpvrt7Ya26mBB8ZH0ztsiS/CXOogpoPxE0NANuE3s
         yiOQ==
X-Gm-Message-State: AO0yUKVfbKBCDSXIGJtL4FqQNAgDsZ04JePXNUHr+vEeInzy3W2qoCmU
        epnSqowR+PfQpCtE3icrFauvTzfuv4Sjd7m6G6BxtmDGVIY=
X-Google-Smtp-Source: AK7set+DK4OqxED00T9gKBcvANkNzP+wv4G1uZGipA5SBu7Ch0GcuINYWuhBO1AyPqSKgz1jf68lQOYVFUmuYfVDenA=
X-Received: by 2002:a1f:1889:0:b0:407:be44:62f1 with SMTP id
 131-20020a1f1889000000b00407be4462f1mr2050304vky.44.1677144028200; Thu, 23
 Feb 2023 01:20:28 -0800 (PST)
MIME-Version: 1.0
References: <20230222011317.97943-1-gvivan6@gmail.com> <20230223082759.36021-1-gvivan6@gmail.com>
 <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org>
In-Reply-To: <4de72b33-fb1a-ab8d-11b8-9e89554fa8ad@emailplus.org>
From:   Vivan Garg <gvivan6@gmail.com>
Date:   Thu, 23 Feb 2023 02:20:17 -0700
Message-ID: <CACzddJqv=CX8LC55_RHVi46GOUuVqY7C0iMLHaFn24uNHzPf9w@mail.gmail.com>
Subject: Re: [PATCH v3] MyFirstContribution: add note about SMTP server config
To:     Benson Muite <benson_muite@emailplus.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Maybe https://git-send-email.io/ is also helpful.
If you look at v1 of this patch, you'll notice that I added a template with
instructions that are nearly identical to the generic ones in the link.
I was told that it doesn't work for all setups. Although there are instructions
for a few different setups, they most likely do not cover all of them? Perhaps
it's best to leave it up to the contributor to decide what to do. Also, I'm not
sure how credible the configuration settings for the other setups are.
However, if the other setups are correct, I also believe it may be beneficial.
What are your thoughts? I suppose I'd like to hear what other people think
as well? Thanks!
