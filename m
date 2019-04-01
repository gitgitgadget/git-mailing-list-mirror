Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372B120248
	for <e@80x24.org>; Mon,  1 Apr 2019 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbfDAVAn (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 17:00:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44187 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfDAVAm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 17:00:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so5073683pll.11
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 14:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2hTqJVqeQD4dzPXrdGwvYh3fM4POvbbrHU54G2avGk=;
        b=rP+kN99Xj+drcltaOHQt2WLF6518GCTTt9+rh4dzUUJgQz4YhUoDVeZ0JJ1YtQt40c
         3D4mq9n47KgXqV7ltU0qCSSx6RzJ2mee2BNGqcGHiVXSKSBftb0AQoLwSATr0JzJxIan
         ra1I9ePgBYtx6R/Zm0CdV4Gaf4nWUu9FPzJh2fAVeZ09pulMukI2cerxiAmg+iCXyTFf
         xM8G35MKnkUc200zkR1P9yg9IqILnJy+5U1cAD6NmVUeN0/zEUsG/Xfk4HOXGVWqfc4r
         YhLFAdoYqWz4iPbzdcfcZMyf5uhrBldBRrSCp1MZvmti+D14/wFKcO8oF/CesZuzDA8G
         IVUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=q2hTqJVqeQD4dzPXrdGwvYh3fM4POvbbrHU54G2avGk=;
        b=jq7zOw8+bo76n9yRgZUXlpSEwVIxKV2x47bIdEnYg81IcEgoqm+HeZfMgU5P3gUzdz
         QGLDhasHXSl/CUabbTCt3JO+4szP7kwag8L6EvzFHluGzoMf/XCaC25JQwqlnkHfjb+2
         IIyGKydVRtjfHjlOIhcHZwEvaeLRIBxHEyD1GQv/jGZvGgAgsceExAwhVrM/45ZZl6Xy
         iq2xrn7+KQeDAIiZ9fvpmADOK7ZzE2u0lyMPJBQ4miRTwh4uSwFIr2PX6Vkz4QyvcRJc
         tbNW3lMakVLu4teTt0HJ/wQc53FARjWtlevww5thUczkLZI1ip5fdQ4txneVSwUmvkSm
         px0Q==
X-Gm-Message-State: APjAAAUBfqawBobev4l2c5yDfW84hAl7JvWjHHRs2UIkmyfrMl203FYe
        8n2u+6OPZSdUBKl7yGFvuy+thxyo3xDaYw==
X-Google-Smtp-Source: APXvYqx6cYTnYZyUVciqKRhQoe/V/yzzHxR1B+wxtpHaELxgyXfm6yInQWe6rB0h9mjgCL/CbgauJA==
X-Received: by 2002:a17:902:bd92:: with SMTP id q18mr16928731pls.136.1554152441902;
        Mon, 01 Apr 2019 14:00:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id y10sm18508173pfm.27.2019.04.01.14.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 14:00:40 -0700 (PDT)
Date:   Mon, 1 Apr 2019 14:00:34 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] trace2: use system config for default trace2
 settings
Message-ID: <20190401210034.GD60888@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.169.git.gitgitgadget@gmail.com>
 <pull.169.v2.git.gitgitgadget@gmail.com>
 <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d048f3ffb801adc7f1b4e48248ca31ebade1b37d.1553879063.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.03.29 10:04, Jeff Hostetler via GitGitGadget wrote:
[...]
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index baaa1153bb..13ca595c69 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -117,6 +117,37 @@ values are recognized.
>  Socket type can be either `stream` or `dgram`.  If the socket type is
>  omitted, Git will try both.
>  
> +== Trace2 Settings in System Config
> +
> +Trace2 also reads configuration information from the system config.
> +This is intended to help adminstrators to gather system-wide Git
> +performance data.
> +
> +Trace2 only reads the system configuration, it does not read global,
> +local, worktree, or `-c` config settings.
> +
> +Trace2 will try to load the following system configuration settings
> +and then read the corresponding environment variables at startup.
> +
> +....
> +---------------------------------------------------
> +trace2.normalTarget          GIT_TR2
> +trace2.normalBrief           GIT_TR2_BRIEF
> +
> +trace2.perfTarget            GIT_TR2_PERF
> +trace2.perfBrief             GIT_TR2_PERF_BRIEF
> +
> +trace2.eventTarget           GIT_TR2_EVENT
> +trace2.eventBrief            GIT_TR2_EVENT_BRIEF
> +trace2.eventNesting          GIT_TR2_EVENT_NESTING
> +
> +trace2.configParams          GIT_TR2_CONFIG_PARAMS
> +
> +trace2.destinationDebug      GIT_TR2_DST_DEBUG
> +---------------------------------------------------
> +....
> +
> +

A question for the list: should these new config vars also be documented
in the git-config manpage, or is it better to keep these separate since
they are only read from the system config?
