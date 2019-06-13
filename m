Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98D061F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730014AbfFMQzY (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:55:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:45119 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbfFMCFV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 22:05:21 -0400
Received: by mail-io1-f67.google.com with SMTP id e3so14674472ioc.12
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 19:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yYwTY2i0qBRAcu9soVhu+93tpaOZkNJwiy+OtZ1r6Mc=;
        b=QkgKTKCu73EIChd41dud6ja+ozXQgrOOIUcj08z+Y0jeCbBPaTqZW9usY4ps1LGLkc
         z+5TKieNIGAiHAi8Qh+g6zX/fT6faThuPw0ZhnGzh7Bmanwi5RjT5sLnJsjmv/YtH8xp
         5i2cXD3t8m+nP2EzuKdeFjMFUsq5u8lAZZf3TtQhZLyJhkCZQt2krGmh8O6AYsK84nk5
         xuKbA9OkYr6V6ege9lnFt08pgA5YceIwIICNi9iRv/HSceMZ0hloNi+0P+qWm3XxjHe0
         sdVkZgoRQGqBMVPTteZbOq9ONTKO7qwUGsWhj8eEEraZgBy6E4op31B+Lmv/c21H7SyJ
         ntyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yYwTY2i0qBRAcu9soVhu+93tpaOZkNJwiy+OtZ1r6Mc=;
        b=uZAkbC12U8pqi872wiZMIGFA2GVSMYv7EixlFJ/vkjsbUvMlz0/L9o8kpNvEnYRYLW
         20qX0ruVfLLX4TDoilL6W+giN3nuApVsPaDgdFqG3upS4WChtWG4GWk/x9WXgXgqO/2a
         xBkEX5OcbP1gBpjSa+j2oKr+tq2m8oTQb+Rs8syEAJasFwnjSDhHd/ToSsvea5GGDPcN
         OOK9K+9hQvKtmqqkEMIR86u2GPPbCqql/GEp4/j/73XpSTCFpPjeI9NajxHsy5W3TvXp
         WmmM24YlMyrQv4nF63QEE3MbduBoujCde3HUPcmsWxbYUNoeCZ9ydm+/Yq+41HNujajx
         NbUg==
X-Gm-Message-State: APjAAAX16apaThrpN7R0R2GaNHKKLIBS2WKISquOH+6xj8x053ThBz95
        zLrA3j5m1Rm9M9EVSh5cAJI=
X-Google-Smtp-Source: APXvYqzhTnrq5zZe2aMuCbF7yzs+SspVIhhe4powa0DBglI5EHqyLxNho1p/NmQ7yPU6R7CNeIFFGA==
X-Received: by 2002:a6b:5d01:: with SMTP id r1mr17656035iob.19.1560391520442;
        Wed, 12 Jun 2019 19:05:20 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id c23sm609654iod.11.2019.06.12.19.05.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 19:05:19 -0700 (PDT)
Date:   Wed, 12 Jun 2019 22:05:17 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #03; Wed, 12)
Message-ID: <20190613020517.GA15030@archbookpro.localdomain>
References: <xmqqk1dqigz1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1dqigz1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Jun 12, 2019 at 03:20:02PM -0700, Junio C Hamano wrote:
> Here are the topics that have been cooking.  Commits prefixed with
> '-' are only in 'pu' (proposed updates) while commits prefixed with
> '+' are in 'next'.  The ones marked with '.' do not appear in any of
> the integration branches, but I am still holding onto them.
> 
> Git 2.22 final has been tagged.

Thanks for the hard work you put into Git!

> 
> You can find the changes described here in the integration branches
> of the repositories listed at
> 
>     http://git-blame.blogspot.com/p/git-public-repositories.html
> 
> --------------------------------------------------

[...]

> --------------------------------------------------
> [New Topics]

Would it be possible for you to queue the "teach branch-specific options
for format-patch" patchset[1]? Even if it doesn't make it in its current
form, I believe that this patchset contains some changes that should be
relatively uncontroversial.

Thanks,

Denton

[1]: https://public-inbox.org/git/cover.1558492582.git.liu.denton@gmail.com/
