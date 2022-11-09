Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C7C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 21:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiKIVZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 16:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKIVZI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 16:25:08 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828CF21AC
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 13:25:07 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id z9so90190ilu.10
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 13:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKXaeW3OJ6wI4YU3BSoRd2ul+FrmnIESC5ZKzakoS1w=;
        b=09gpwZxakjY/m8hbf/Z339UlegayRFcjfMJpmmKNq/8YWKVqLCDjWuWGStIR4NaPr4
         gSRu0dSzKwJp2ayxsuu5z5yYwU5cCEp6dSChVQOZdHlwyOX3K6w5oeIkME5Y33C29KSc
         yDFjuLuwce2F3t6WJ7P66rkdcOXdIaanYeguTUXX9DkdwLo45O3mVccorzkBycwlV5wc
         eX3sXGQBSi65o8f+5MbjhXZGgktMF2FhByO9KS10mTJNCW7qCrH1SNZ6hnkxnqhw4kml
         sLlk2JlWtoOyA4b9C1+PpaV1sEwE95KwGOqUKAV9KMTWtlTgIOV4PD3CDKSAK953nYFV
         G1AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKXaeW3OJ6wI4YU3BSoRd2ul+FrmnIESC5ZKzakoS1w=;
        b=gHvelbsbHBHJIVTjPBRFtppL0ap1uDEobhDZZFbtDzmxeJNYpL6sDhgdgnlI/1oz84
         xg97D9HlelYsdb7RUlo+5fr8ZVhdpkMSMzmY08G6LXlkKSb+z7RDGICdSR+WAecYccgq
         TZq7VSZblDGI58OCFYgeyNHqo83F6UimcZuSEVqc1TC5h9ljHeeY+XpJ69ThbcReb5K1
         vyLbzSOdn8NbEr9ogdkaB+D6BllurybVE3EQxsZZIw/y3bpuvUUzFYiyTEdzeK32qFjH
         ZEfOwnJxYVpseh/wSo1tEp32yw/MVHyEIEc06uD9kgLDlagd4v5R48GIF08UO2mL20Y1
         Jjpw==
X-Gm-Message-State: ACrzQf257SE3uB7qFqXnebBLcCdCx61P63AP9P+LLKOqQnyY7GnhSwnd
        KTgJyv0SIYKZMyQTwBEq+jtYOELc0MNGbA==
X-Google-Smtp-Source: AMsMyM6CkLPqtrKa3uE/REOfbpZbk3MYQ91OwxH9UVJJFT/kbg+KYQLg8drHOEGUjp55B9wp9M8WBg==
X-Received: by 2002:a92:dac6:0:b0:300:a1b0:9f7d with SMTP id o6-20020a92dac6000000b00300a1b09f7dmr2105293ilq.293.1668029106783;
        Wed, 09 Nov 2022 13:25:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j62-20020a026341000000b0036e605a3e79sm5138931jac.17.2022.11.09.13.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 13:25:06 -0800 (PST)
Date:   Wed, 9 Nov 2022 16:25:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org, me@ttaylor.com, derrickstolee@github.com
Subject: Re: [PATCH v3 0/2] git-maintenance quality-of-life improvements
Message-ID: <Y2wasWB58cEZBWA8@nand.local>
References: <20221109190708.22725-1-ronan@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221109190708.22725-1-ronan@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ronan,

On Wed, Nov 09, 2022 at 12:07:06PM -0700, Ronan Pigott wrote:
> Changes in v3:
>  - Report an error in unregister when the user specifies a config where
>    the repo is not already registered
>  - Add a test case for the above
>  - Correct option description in the docs

Since this series is already in 'next', the existing patches are frozen
and won't be changed.

Would you mind re-submitting this as one or more patches on top of the
'rp/maintenance-qol' branch in my fork at
https://github.com/ttaylorr/git?

If you have any questions about how to do that, please feel free to
contact me off-list and I can give you a hand.

Thanks,
Taylor
