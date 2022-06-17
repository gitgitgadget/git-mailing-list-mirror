Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA2C43334
	for <git@archiver.kernel.org>; Fri, 17 Jun 2022 12:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382090AbiFQMMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 08:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239096AbiFQMMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 08:12:16 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D4E13F68
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 05:12:16 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id a184so2989119qkg.5
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XKqTkrDlJu+QVAOzhN+lwgQIphwkl+2amOC47Hv9LHk=;
        b=Gf9t1bxlFVQ4UPgst5OLLtAaa5fD38UY588ESbz/LAMYmdqirWnjpH7BQmOyb6R0WH
         Dwh1xFsT6WncOt0jSk8mBAypVo2kwvx45om4lXVVLmhwmTxSc/YmcUYspjae18aP7gWo
         KlwZI8aHwMc0q/JYI3Em5SngmSlN2mRSJAdjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XKqTkrDlJu+QVAOzhN+lwgQIphwkl+2amOC47Hv9LHk=;
        b=Ue0fV2YVDjPPFd+jmoKWA9HxyrYj4DcoysbEFl41tdq8lHv0WqMTplUvzfbi8hw8GR
         Sjr+KAQaPIOipCNdZFuY0GzsNjC7Cx2QrGf/XoBWGf5tYgvKJnwyuNiQIEsltzj6WRhn
         B3THl+MVAspQIKrdq/JvIsRvHDqS7mlC5OONB8Nw7t3O5XzHFjnB3m0UfAOYct7mZOnv
         TepdQ3aDFyzpQilYQJSE+ddK44Eej90DpA1tkrY3hiL0tJwPNGTFvQn0scO1ZBoqa5Oz
         7Cit3MZYSUUz4zZqMOsqumreehUVu/iANbxx4hpIIbQmLsFVChlUvBzClZShQWfH7dA7
         dtDA==
X-Gm-Message-State: AJIora8qJUJdcfe2RqyQh3Ys6v9Cj4b8+GpTg9/n3b8rhfu7rrMRrhpJ
        /Iv+c3125s1+bKUP/YIjJTtDOw==
X-Google-Smtp-Source: AGRyM1ty5XYRM3YrTnoLaWmunmdMdvAGULIht2H04j+7RvTLx4dA9ewCzjMR4uMVVHw95W9w8SgPjw==
X-Received: by 2002:a37:a906:0:b0:6a6:8eb9:31fd with SMTP id s6-20020a37a906000000b006a68eb931fdmr6733674qke.617.1655467935087;
        Fri, 17 Jun 2022 05:12:15 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id r67-20020ae9dd46000000b006a5d8d96681sm4011235qkf.100.2022.06.17.05.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 05:12:14 -0700 (PDT)
Date:   Fri, 17 Jun 2022 08:12:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: send PGP signed commits/patches with git-send-email(1)
Message-ID: <20220617121212.g7w7v3v4ynw6wlq7@meerkat.local>
References: <81caab7d-777e-13fe-89ea-820b7b2f0314@gmail.com>
 <20220617120016.txjksectzdugqiod@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220617120016.txjksectzdugqiod@fs>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 17, 2022 at 02:00:16PM +0200, Fabian Stelzer wrote:
> Konstantin Ryabitsev has done some work in this area especially for kernel
> development by using email headers:
> https://people.kernel.org/monsieuricon/end-to-end-patch-attestation-with-patatt-and-b4
> https://github.com/mricon/patatt

Greg refers specifically to patatt signatures. They aren't really specific to
kernel development at all -- they can be used for any patches sent via mail.

b4 (the tool used by many maintainers to retrieve patches from lists) will
check patatt-style signatures (in addition to DKIM signatures) to help verify
that the patches come from trusted sources and aren't someone pretending to be
someone else.

-K
