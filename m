Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A5F420248
	for <e@80x24.org>; Sat,  2 Mar 2019 04:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbfCBEYs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 23:24:48 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34034 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbfCBEYs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 23:24:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id o10so169572wmc.1
        for <git@vger.kernel.org>; Fri, 01 Mar 2019 20:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=fqVUsApXLtmk+nvvz5P3xVY0Krl/zBS1ZVxFMGtSprg=;
        b=SzQLcpo3RL40jaR1fH4J6vjOl6zp2YWN3LR/qP2jdr0TDA0S8Ou0vdvDX5vLScnUPA
         UI3xHZi9UqFd5hL2lH9Rx50w3IOf0Ft7gHNc865qzi/Z2yGPrYyfAjXOEvCohM5IIsKe
         tiBZIEEHwco/Va+lIWD98fQ2GePzZf4BpWSWs2ZjUWJs6yrXmTBE7DoKOLDV7OHHJMTL
         bpC4l4PokgdYI8Y8VFyfZEiDZUkyTODrVqSWoe3wz0wsZy8FkhkWHlj++MEKiTj6++63
         jiFjRoorSxfVHOmVvsfZEY9xa2/vOwKIlU4Km1NZb+ZdMdGonAJEu4CtNVgpY7/+jVvB
         PHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=fqVUsApXLtmk+nvvz5P3xVY0Krl/zBS1ZVxFMGtSprg=;
        b=FU5cZ4yTukQHBW/+L2G8SZu3QpUZpbvG1CkBaJ7Xb4TNuknLMT9Z9F5o2YndWhOOJd
         ZlFHlLGLrOLczckj7VK4WkTnIVbSoxke0E6CBEQ23o9Tb4VgchigzahH86zzyMdr6HlB
         teNm3fUL2tFLdmm1gByH8w0uJ1B1c8yYS3Y7i7bEj8df2Yf0RkSXZRb8uyjTgUrm2UMO
         8Jo4oRnHZ7xyuifjPilwMpmJHj8Vzl604qNacCGDE7CcSCMtNVM2xF2hGEptVnxpjMLH
         XMgDmD7dK81mJeORrfw0GV+s8dc2rmUoUvvCe2z19rwkoGgMjFdsqG8Qqh6Md5nFcEy5
         1VjQ==
X-Gm-Message-State: APjAAAVln4CX2/focX8HOGTFnY3pkCJDHkktFHwkfi+N6VxymCgYewif
        reCaS5a3DZj1AB2dbYcCFLM=
X-Google-Smtp-Source: AHgI3Iap6+W7U9oYkP4+QJV9l1gErBIyb0BSPH+IJK1kOFBMd8MgDg2zWnoYK4YBRj2MDmv9fOqLqw==
X-Received: by 2002:a1c:ce46:: with SMTP id e67mr5222009wmg.40.1551500685689;
        Fri, 01 Mar 2019 20:24:45 -0800 (PST)
Received: from rigel ([2001:8a0:604d:4901:e60:76ff:fe67:10eb])
        by smtp.gmail.com with ESMTPSA id y13sm18486376wrw.31.2019.03.01.20.24.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 01 Mar 2019 20:24:45 -0800 (PST)
Date:   Sat, 2 Mar 2019 04:24:14 +0000
From:   Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, git@matthieu-moy.fr,
        git@vger.kernel.org, martin.agren@gmail.com, pclouds@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: Feeling confused a little bit
Message-ID: <20190302042414.GA24599@rigel>
References: <xmqqef7r9uil.fsf@gitster-ct.c.googlers.com>
 <20190301131326.7898-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190301131326.7898-1-rohit.ashiwal265@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 01, 2019 at 06:43:26PM +0530, Rohit Ashiwal wrote:
> >
> > Simple things do not need that many letters to tell ;-)  The
> > suggestion of 72 is about the maximum. 
> >
> 
> Totally agree on this!
>

I was bikeshedding the patch and mentioned that the commit message body
is usually wrapped at 72 because I noticed you were wrapping the body at
50.

So to make things clear, when you're writing the subject, i.e. the first
line, you should aim towards 50 and do not exceed 72.

The body, i.e. 3rd line until EOF is usually wrapped at 72.

There are exceptions, these are guidelines. Sometimes commits will break
the first rule. (Merges are the most common example I can think of, but
you won't be doing any as a contributor).
Pre-formatted content, like the output of a program, will break the
second. Look at 3b41fb0cb217f4b4491f2e67ce4183e5d2a5d873 for an example.

But my nitpick wasn't necessarily because I didn't agree about the way
you line wrapped the patch. It was about figuring out if you had a
misconfigured editor (that could also be the cause of tabs and spaces
mix), which you later mentioned was probably the case.

Cheers,
Rafael Ascensão
