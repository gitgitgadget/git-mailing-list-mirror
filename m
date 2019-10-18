Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAAB61F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 16:27:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394844AbfJRQ1O (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:27:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34722 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732948AbfJRQ1N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:27:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id k20so3664157pgi.1
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=runtime-io.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OjMNOmOvMJuVzHPdIQZ9FE9QCIsIQ/4OmmSTMKq035A=;
        b=lmW2CVCyEPpuVHi++1tzgr7oBr3n+8yKsJTSsFRxJEchoan/pmA+BnYueudmrsVVLF
         nEMF0wOkKH6jMKS+2oom+AG1O7dmfD9gwBQ0XZ5ZlktnyC3ZZkWLksSlFqL0FAqPE0w/
         Se27JmQKGIdhht59N7bBi595/DAzPUcI3nI4NsmII2GpsoiJPGD4uV3bHIEQrxQOSxjY
         yPAZRai79YUMJBsscq7OpeoG5KD1RA6ZR4YnJ8T14y9il3Oc415aISvRshKLURGYXjir
         4NqJmfF7029+lR2jWueTfgCprwvjHYxpESnqcGYfK4OiRjclM6Atjkw5Ld4g+Ieyf+0J
         ESpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OjMNOmOvMJuVzHPdIQZ9FE9QCIsIQ/4OmmSTMKq035A=;
        b=GgDF3TvoYohfnWPguvchpljalk9i0AXIFMdK9fOcQ56ZgcTuGq5aUbMDTJElymJl91
         5cb4tL+vbecNBxiVIBAJkpZ04/KDQ08zInZ79CGzBMIhKbGvW4O80SbWNAzc5MtQ0TFx
         7tD2Wgz+SqxgnW9mERyZcxo9WS7rViFVX9f7SY5I5yRMkYU5PE95/P2yO15kUbVOu1eA
         f7CG/rbQwMruXzBOV+oK5KxrTUyTJRoCOVQ827qXMDsRptoN8PzvimWcbUQ0G0iPrssO
         P8jW9kvH9TbUzC7liJmltOG9KXuhlvTLnqdZHIBS8tZkLHnd/L2ZCPuuEMvgkzCRh4ji
         fokg==
X-Gm-Message-State: APjAAAVehBWyj9840eGDQqBKBwXcWTc8FRVXNe60gqIQKXTL9DuqHXuO
        qWjodrxY7Mc9bHllxib5SlV2htfXIko=
X-Google-Smtp-Source: APXvYqzkCJRWwKOw0EI8StOWQu3KI/cSwlwj38zJiQEzHGUGv1fUXgzwK/N/svk7PoxT170eAiBMIQ==
X-Received: by 2002:a62:7689:: with SMTP id r131mr7450704pfc.68.1571416033190;
        Fri, 18 Oct 2019 09:27:13 -0700 (PDT)
Received: from localhost (c-24-23-248-29.hsd1.ca.comcast.net. [24.23.248.29])
        by smtp.gmail.com with ESMTPSA id 7sm5613950pgx.26.2019.10.18.09.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:27:12 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:30:11 -0700
From:   Christopher Collins <chris@runtime.io>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
Subject: Re: bug: Directory replaced by submodule -> checkout fails
Message-ID: <20191018163011.GF4049@pseudoephedrine.nightmare-heaven.no-ip.biz>
References: <20191017230751.GC4049@pseudoephedrine.nightmare-heaven.no-ip.biz>
 <f66f0587-4d61-71e8-fc87-3278f1023e3d@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66f0587-4d61-71e8-fc87-3278f1023e3d@virtuell-zuhause.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

On Fri, Oct 18, 2019 at 02:02:29PM +0200, Thomas Braun wrote:
> This is a known bug unfortunately. See
> https://public-inbox.org/git/CAGZ79kYTY6U0eNwvU0PcDyt_QXGyYGm5VkDvWLtuQgQG6BbtFA@mail.gmail.com/
> for reference.

Good to know.  Thanks for the reference.

Chris
