Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2C0C433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 22:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiKPWfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiKPWfm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 17:35:42 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329556B228
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:35:42 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id o13so51514ilc.7
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CIh7bOEwTFy9pyL8aLA/FhBZM+omu4eqQq/AvF4jcjY=;
        b=ECmIUy0B4DjWCfzKlqSJLQbkSmEbEHPvLNktCsApzuBCGnaBCPh4uKUIQTAYhfm0WV
         T2Y7QFdngXRN4agoP0O60cQCW1b00LxZ0uHjHJ30mdLVa9okXvCj6T9x7dw/iv/d7ZA4
         VMxsPK8pLlwaGdQXidyJnT0CK4syXpM4rkZSVJzungm2Dnq0/cite3zEsvnSWK7uYDxY
         egJGnG0w0bM4mtqa9V+WX70Hby4nmoo232lPLmUFeIUFiq6yO06/kTduZOgV8G5x3iqv
         yfyuHHUx1g6fhXUGUMrGkHxecb5KuI8Ra4XQpqJkOwh2k+8a0FXt8k2cWNwKFikUN7OZ
         ffIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIh7bOEwTFy9pyL8aLA/FhBZM+omu4eqQq/AvF4jcjY=;
        b=vwRXSbjochcV7YYzUJGKOf4pBI407h0WJoUgbytk2Fdyq64gtX+O3SJJJL+swwkETf
         jnYp8JYIP4HksdThl5MD28hZ7g69tE0tu7xdG8MgwXduzilR3q7BK/BZu+X2Cot6U+Ma
         N1LIClrsYTpGNR1aZB45bQux5lxEi++iWnYjLmr0kjYLNDU2eWokYghup7uguPbCFA4t
         3rpNhvn8R2BS3Hc5/i22vfjkSmC87UJjCH95/a1utoRLOUbd65+Aztn2MGE2eMXbRkaf
         18b4TMFm2A1dxgznQN5kplg/EjhVPvQ1AnZhHla6gMhLHmAfx0J2XJ93ZkodjhezO3pV
         2BLQ==
X-Gm-Message-State: ANoB5pkK8gzgupebmsLaI/VAh1E/ILqrt6cR1QH7PskCNeV3AuBTSsi7
        vTWSX0gxBW60awmSyerDSHeGDg==
X-Google-Smtp-Source: AA0mqf4QycIO1peU7uXD5l9h4ZZk/BkI0/enqshjPMSKe9e6k1jF65Vm8aVrZvX7GU6WM7p8jKxraA==
X-Received: by 2002:a92:c0c7:0:b0:302:84c4:8158 with SMTP id t7-20020a92c0c7000000b0030284c48158mr45795ilf.127.1668638141575;
        Wed, 16 Nov 2022 14:35:41 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l2-20020a6b3e02000000b006bbddd49984sm7098179ioa.9.2022.11.16.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:35:40 -0800 (PST)
Date:   Wed, 16 Nov 2022 17:35:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        me@ttaylorr.com
Subject: Re: [PATCH v2] Doc: document push.recurseSubmodules=only
Message-ID: <Y3Vluzd9Jck25TAd@nand.local>
References: <20221115184702.169258-1-jonathantanmy@google.com>
 <kl6lpmdmvbnk.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kl6lpmdmvbnk.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2022 at 01:21:03PM -0800, Glen Choo wrote:
> At any rate, do treat this as just a suggestion. I won't block this if
> both you and Taylor find this clear enough :)

I admit that I do not care too much either way ;-).

Thanks,
Taylor
