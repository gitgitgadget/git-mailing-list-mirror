Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607ACC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbiCWU1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbiCWU1X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:27:23 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6F47EB2F
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:25:53 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id j15so1813309ila.13
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNO6kwQ0Mlcewj8XX9PtnbrQAvWSOECqM8K2ryLuWMc=;
        b=f0WHPIIUhBJp7UY5NynXu1IeXNAm0AHh28olykmnEWIlHHASK11X03+z/RZCELSv1R
         8tLsQqo+fuKBSR9pkR4Tu7Z+2fzPsjyub25q5G7+4wSq3GvGFZ6+JmPMPCa3NfmEXSgD
         RTXckQbNxGiYhUmMQQi/eyv7olX+r8mFueZgjBi8T2nDdaH/3MUSE005UY6mpvg+5a6Z
         AcnPx2fBJbFPTcZKO2N0MVN/BnM2hMP6HL8BPbD0B/WnXPUbuzZRuoP7FOdDgdx2pwGI
         vnpniXHAQeg9N4l+kiXueyu3fmlSIS1blMDcpNmNgSYDHrmGcv9se8D+lbAjImYQ46Gt
         Rdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNO6kwQ0Mlcewj8XX9PtnbrQAvWSOECqM8K2ryLuWMc=;
        b=VSGOjtwpfB4scK5wDd/rVnE/K2jaPDeTQHqLudJQUHgwXr7c4VLvm9CfRMOR1nkc+5
         eYECO/PdojC7eI74MqaylFY1zc3qJg/wCPFFhljuQ9RzHwf5ti05IPS+VnXu+xM9HFPn
         hAdsUGYOOqhXE+vaVwPy7AJE3KqhEtdlDNXo1L++vPr0Ew0cSMag3hkBtphbv6JO6wGK
         dIxjwN7ndI1oElB3sPInM+MZJvlbD9Y88fPSkL1pPo+KOm1d9kjSl3yRPy3KsjY0Q/Fr
         ZTk2dOMqOASIEYXtntKkk4/Q9hx30rhJlk3Fhg/o63zVs+ZV9VulTWGuADJz2mPY+KfE
         SR+Q==
X-Gm-Message-State: AOAM530FfKKElLAg3ijmpOkVrNZDSHtRRhpvcH6HbRrjg2pIvZ9IGzB2
        J0dHQutqvaLr1pyDvOZn0IewONW8lTbca7z0
X-Google-Smtp-Source: ABdhPJxJeh6s7Z69PxeSzf0bCkNV8LEORFEazz2w/XpVTsGwm2eQvhXsfNhU3RCk0BIZzEgDrqoeJw==
X-Received: by 2002:a05:6e02:144d:b0:2c8:5cfb:8fe3 with SMTP id p13-20020a056e02144d00b002c85cfb8fe3mr932802ilo.35.1648067152978;
        Wed, 23 Mar 2022 13:25:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u5-20020a056e02170500b002c7d08a5d95sm579604ill.45.2022.03.23.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:25:52 -0700 (PDT)
Date:   Wed, 23 Mar 2022 16:25:46 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     John Garry <john.garry@huawei.com>
Cc:     git@vger.kernel.org
Subject: Re: [Question] .git folder file updates for changing head commit
Message-ID: <YjuCSpAHD6xHkb5G@nand.local>
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 03:19:06PM +0000, John Garry wrote:
> For building the linux perf tool we use the git head commit id as part of
> the tool version sting. To save time in re-building, the Makefile rule has a
> dependency on .git/HEAD for rebuilding. An alternative approach would be to
> compare git log output to check current versus previous build head commit,
> but that is seen as inefficient time-wise.

Having a Makefile recipe that depends on $GIT_DIR/HEAD seems strange to
me.

Presumably your Makefile rules would map out which parts of your program
depend on each other, and would get invalidated when the source itself
changes, no?

Perhaps you also care about the commit you're building from in order to
embed something into your program. But it seems like you could inject
the output of "git rev-parse HEAD" when you construct the version
identifier whenever you do need to rebuild.

Thanks,
Taylor
