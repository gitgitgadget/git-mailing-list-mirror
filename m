Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D1AC433FE
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 18:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiKRSJZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 13:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbiKRSJX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 13:09:23 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E048FC5D
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:09:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id z3so4415444iof.3
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 10:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=49tvU5+0WnQoRSQtNfQyJqmsZIbxcKfL98AHUVhNka8=;
        b=cZqyvOMCyxCYDwvsvasSwxk1e6HMXaiTDzbqLfM0pAZviDQnpvxj1pS+YD9HrT9x2S
         sCDkKTLakDa5ddHuPWypcV5xOGtm0+OdrDWN/JNVbkRUFp9SFLSpOZkQVut/CduyWjCw
         nHBbHREHGJcuycft/AtZmQcOhwX/QUox7mDHxmm3R6XYJpMRpOg8F3bFO9gyseg9Wvq5
         4+vZzrK9L62p5r7owZYul0VTsY08GMmOUtkv6j+quBNB16VpRwoKvfX3pKtylmiq7mn4
         A3d5GyUMJY0gPRuDSFHO4JGa2gU8puN6LH1Es4q9C6EZFUnBHUhgj+nElp3ea/43/x8d
         RVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49tvU5+0WnQoRSQtNfQyJqmsZIbxcKfL98AHUVhNka8=;
        b=JInt4OFUQtLfL4/h3EqXzVSdtiNEAvD+mcVh4BN2lpPpHP74Akpn93aFmGaNbWelEI
         rXIfjsrdh61PxQOeexChnnOBq5t7ESrPSo4YlfqgDHRPVSsWYSrUuLfeS+tnaxMeo717
         QPchO7DULvY59ubrng25DVjzm27w1kWHAA+lRwaY07tNuFypFLXtQTrkbclw8ZVw9IQS
         UkGPOsATUgCxVXkBDn39dpxZuhD+zZKUAC5WGfsRsBh17rIEZSqOzcVrBx0GWKozKgQs
         3i/a+ofs4KVjw5h4OTxKtGcnG8nqhR0v3SK/JM+I2a5CrgukhWs9Sho0eP3y5vPGu6CZ
         sMKQ==
X-Gm-Message-State: ANoB5pk6Wj8ysV6dAD3JWS3voIgEiYLpy7qk/cTWSOeJPmJu9niQ642n
        9G951FFbJ6Bdi6sAW8u7Hp9LT9yVyXzAkw==
X-Google-Smtp-Source: AA0mqf70VPAX0jZ22zVqfiiee3D93tBq97LQO2rv74++k3TdTjGF9ABE0uuYKX1+ozaxkol0vmX3gQ==
X-Received: by 2002:a05:6638:296:b0:363:79c4:b889 with SMTP id c22-20020a056638029600b0036379c4b889mr3568188jaq.292.1668794961249;
        Fri, 18 Nov 2022 10:09:21 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c29-20020a02331d000000b00377ea22b66csm1358398jae.177.2022.11.18.10.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 10:09:20 -0800 (PST)
Date:   Fri, 18 Nov 2022 13:09:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     David Cowden <dcow@pm.me>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git-subtree docs missing
Message-ID: <Y3fKTpufVB5oTfkD@nand.local>
References: <MzUvo2TfR7gGs7FQsyF-0TqfSNT6X_9eZlBkFBDoa2IrpnT81MYqhNJUKh_aSsNJaH0HrM9PeoQhx6LMlFy3bd3bVCo9aqlT_7Ul-wE6LkE=@pm.me>
 <mG2PHaCBIK7N--HeRqPn3Vn9Dc7MzTiahRjTxZq9_7T7UWF1YN1LT4wVeDSpFABOyeH-YjXGRMq8HVE_VFOBOYvkdwBNwhS3eDyGkqW-0Nw=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mG2PHaCBIK7N--HeRqPn3Vn9Dc7MzTiahRjTxZq9_7T7UWF1YN1LT4wVeDSpFABOyeH-YjXGRMq8HVE_VFOBOYvkdwBNwhS3eDyGkqW-0Nw=@pm.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 06:03:36PM +0000, David Cowden wrote:
> However I'm now aware that `git-subtree` is part of contrib and not
> officially part of git so my expectations for finding documentation
> there may be wrong.

Right. We don't have any standardized documentation in the contrib tree,
so it isn't built for git-scm.com.

The documentation we do have for 'git subtree' is at
contrib/subtree/git-subtree.txt.

Thanks,
Taylor
