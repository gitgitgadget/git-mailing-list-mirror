Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F986C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 21:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiF1V0u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 17:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF1V0s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 17:26:48 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB153A730
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:26:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id t16so22064584qvh.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2YWxDtFgYFeelIPOZ0IDESDU3Klo6KT8MqeWjqayUOU=;
        b=39HZGxzIx8YTgEsrTve6IE4thXli3A7PtBFaOsN0POnnr24Qy2YjWg+UPu67g0t6Ui
         bKZkz0lk9O3yUfKPOtx5p4c9LqteRZbixNi+y2pk+JnFEDbO+mRydPSule7+5bSbQxNx
         9vBIbAzs1c87OZOUoBoekPFF8lSEmbEYJN7vmb6s20Xh7cOgQg71mxmOd45tkkuXoQbF
         LNIYkl6WBA4bnfzu385KQUEvo3QQkvc4GjzsnIPHLDXocBTNsLUQ44d6ppEUqdKlzB0q
         2AONIxZ6el92mnBYin+NsyG6+iQ+lb3f0Pleqt1ga+FdBmvLUOsQGgXG/sxwRlNUJjxz
         lFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2YWxDtFgYFeelIPOZ0IDESDU3Klo6KT8MqeWjqayUOU=;
        b=AZ3scma1TiwRq2YzvD6yiou3lElJHrH7pYF5xFRnEku6ummAKQbKcJXwG07fBHFAOd
         PcWsLeR4yAIdjej4cgqnunjGjLqWHM4LMke1a0wiwAslW8YdO/luKdMU8hlT+XsNLl+8
         l37UETExEk48pVJS9JGYiv8ga8bq2PzXKlZANOzR/pSC+pUUV7hkj3CeyLVp+7MzKnDV
         eadbtSSSj9L5tCsZv0Av/Shldh37yd+Njg56VqbaDQQyqkQrmDmmnw1J/vS9DfRVmWGL
         dGljphQbadMgUL8PORgPCrA+ZVwezeo9QIoEDxdOH32gSlSYmkdE1B67nu502qmbWx8j
         mV8A==
X-Gm-Message-State: AJIora/Y72kY+q1npdgDp//2y1lpf/nFDGqzCwPmT16uCWMMkVJoQtbI
        oaCAjS/dd/sUtzk2FiW24/838mIascfZ/Q==
X-Google-Smtp-Source: AGRyM1tVNnlwa/IA8zIvBiCA0TuFkqA2sopU9Gf2dEayuw6B9bgMofQTdKOfFX9VWCVeB5zD9QLoqg==
X-Received: by 2002:ac8:5b85:0:b0:31c:b896:fb7d with SMTP id a5-20020ac85b85000000b0031cb896fb7dmr48025qta.188.1656451603797;
        Tue, 28 Jun 2022 14:26:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bk32-20020a05620a1a2000b006af1d3e8080sm7692354qkb.85.2022.06.28.14.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:26:43 -0700 (PDT)
Date:   Tue, 28 Jun 2022 17:26:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, pclouds@gmail.com
Subject: Re: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <YrtyEjGvE7MyLBPl@nand.local>
References: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
 <Yrts22oGOS/igqH/@tapette.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yrts22oGOS/igqH/@tapette.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 28, 2022 at 09:04:27PM +0000, brian m. carlson wrote:
> > Even though this comment was written in a good spirit, it is updated
> > infrequently enough that is serves to confuse rather than to encourage
>
> I think you wanted to say, "that it serves:.

Oops. Thanks for pointing it out.

> > contributors to update the appropriate values when the modify the
> > definition of object_entry.
> >
> > For that reason, eliminate the confusion by removing the comment
> > altogether.
> >
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
> I agree with your rationale and that we should remove this.

I'm glad that you agree.

Thanks,
Taylor
