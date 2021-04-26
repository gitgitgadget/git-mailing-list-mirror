Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5C8C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5A60232
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 11:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhDZL7R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhDZL7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 07:59:16 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1F2C061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 04:58:33 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id z5so3162992qts.3
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 04:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MtSiIYlhqT93OjCrnvvKeJc5jRIhiU8tqgEQtAoyX84=;
        b=a1wqzJk0xVfGld3xUOhKDqQRnnZCbQsLO8/E35rYgoojXTLRtE7emPSeH+CpttALxd
         9qHZ05hbvCwgcQfnyj4eFWwJfkx+pvw+CIyDuz4BAJLGKdjVM61yeJhh8g6mGoOriWZQ
         q5L05sUCBdX/tdvdFyOFkkkMQrZgXYNMNnmbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MtSiIYlhqT93OjCrnvvKeJc5jRIhiU8tqgEQtAoyX84=;
        b=nd/zGyzUz8vJyHXpJuiaCNQbXGwVLOrqerKuWjrsnkkrcFv6eDqtVidEF1f4qfcyh6
         LBUO6wRuewwFESOz0/tvHcz9CX1XrodQpuYp54/ZUAxIP2zEzhF5+BDs/WYqFQxmK6oN
         Ohcnbva49geR75EThl506paMdgnDmmYrX9qdjt7GrJXfRT7bA7/g50x0CL5nVpGg3itm
         XqXHph3GFapILfjlVZni2Q53O2/2fRhqfDZYECiwL3BW6auTw4lqxcpvXsCT4fs+czSP
         05mk7eJ1HRmEonFDRsjHKQYfXNQVCLzYYJaWYTfGkKi5cKpcv6HXfls9+mlrzv+j2sYF
         P+fg==
X-Gm-Message-State: AOAM5326njhRg6KXBtpy0Yx69lPpctbqe2YXEZfWMjhAjtSJC9rzmAJn
        PxKRvEXZV17DwTb+Y76MdwmZEQ==
X-Google-Smtp-Source: ABdhPJx0y0pQj5V9AHcti3DbX+UkCaBjglCjWQrc3XLZn9OWH9CDkAlTMWEFxrEDU94b/D5+ffUmmg==
X-Received: by 2002:ac8:44d9:: with SMTP id b25mr1058355qto.257.1619438312280;
        Mon, 26 Apr 2021 04:58:32 -0700 (PDT)
Received: from nitro.local ([216.209.220.18])
        by smtp.gmail.com with ESMTPSA id x24sm11204508qtm.95.2021.04.26.04.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 04:58:31 -0700 (PDT)
Date:   Mon, 26 Apr 2021 07:58:27 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     zdl8255 <zdl8255@163.com>
Cc:     git@vger.kernel.org
Subject: Re: not found the clone or pull log
Message-ID: <20210426115827.h6ve3awl3xnpxdck@nitro.local>
Mail-Followup-To: zdl8255 <zdl8255@163.com>, git@vger.kernel.org
References: <b5770c8.42d8.1790d57af75.Coremail.zdl8255@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5770c8.42d8.1790d57af75.Coremail.zdl8255@163.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 04:42:00PM +0800, zdl8255 wrote:
> Hi,
> I want to retrieve the clone or pull log of someone project, but now I can only find the submitted log
> can you help me?

This is not possible, unless you have administrative access to the server
providing git access. As you can well imagine, the clone/pull information
would be considered private data (PII), so it cannot be shared without consent
or anonymization.

-K
