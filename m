Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A11341F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933629AbeCMQc0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:32:26 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:41868 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeCMQcX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:32:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id w17so78333pgq.8
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Jzqdsfq/ygnRZKMlMFYBcGravWk8fDVHgI/2M0w9U0=;
        b=Ah6SZU/oRV45zicoflFmiZ42m3iRSnXgFdDuCFex0MYNc9rzFDIORa8XuwZGYAtaqX
         ZHQ7qiRG9IArzCl9eZmvLsUY0d+Z8sXhBZi2vAG0kBSHOeNUB8bRKKzd2fD9NmEmnkB9
         zMtkoFjFk6LsSYhtVSqra4tDZwYtsOyb4BGtNZx51jjxHz2brMH8Yntd7Rj8KnlHgLcP
         mpgNQv/Zdboznmjagl3EZ7adJBu3mOaC8jf/dU3bjBegLfP1nHWxZjjUOjaJNTuHqBU1
         Nta3q54blaekuDPw552jp1rm1+GEVocttUWSVo7CXiTBHOsavb2qKtl/mDuCvO/HORwL
         UfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Jzqdsfq/ygnRZKMlMFYBcGravWk8fDVHgI/2M0w9U0=;
        b=un2UuuzihbuH+l98hd8AyhIcOk7mOjowAkyY8gEGzdrVfaIjKk122lscIKG5sUM1uL
         Xbag7YTjaV1zzpAVsMoY6CFc9RN3FrL8ivbz94hh0VVsS3zR1v5lHMIq3AgrSaIz/DvX
         KFtGNJFo7dtiWimgD9t/9yw2vRepbZrpsThsLVQ/XQtzz+PwKJZha33Z7jyLiYX96Rco
         1qrUjfFvTS7kSXT+pA0HaeypXkfMIZqvOUiSggcOauTcJvA/EhwaRrNNr8GFg24BVs6X
         vqc/TWNltOwvKucZD8ceEAT7I+bxU9oyX7u7MRmTTPjBqzTIDjm8cT6X4QI0qAm16APB
         7hmQ==
X-Gm-Message-State: AElRT7FitSpbimm7QBqGHvrEUgCz/nojwk8fk39zs0mcaabLg1xq+QmE
        7Z5uU+Vx8LMcru3aBIzGZRvBmA==
X-Google-Smtp-Source: AG47ELv5TGTr3A6Yo2BSv84/r+7q8/MWF4BTseskO3j3/iUvmlBVc2SWTN+/F9PwyQUs8+NCmu0G5A==
X-Received: by 10.101.96.73 with SMTP id b9mr964179pgv.339.1520958743010;
        Tue, 13 Mar 2018 09:32:23 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id e23sm1005418pfi.76.2018.03.13.09.32.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:32:22 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:32:21 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 29/35] remote-curl: create copy of the service name
Message-Id: <20180313093221.1d63e5212d8572fb0d078577@google.com>
In-Reply-To: <20180228232252.102167-30-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-30-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:46 -0800
Brandon Williams <bmwill@google.com> wrote:

> Make a copy of the service name being requested instead of relying on
> the buffer pointed to by the passed in 'const char *' to remain
> unchanged.
> 
> Currently, all service names are string constants, but a subsequent
> patch will introduce service names from external sources.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

Once again,

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
