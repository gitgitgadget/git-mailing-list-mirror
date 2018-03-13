Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E2821F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeCMQfu (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:35:50 -0400
Received: from mail-pg0-f46.google.com ([74.125.83.46]:40022 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeCMQfs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:35:48 -0400
Received: by mail-pg0-f46.google.com with SMTP id g8so85529pgv.7
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umQTPDyQZOVs6i7OvlPbG+/ScACJYmvNb++7yz/QGOY=;
        b=Fyp1Xb7ztLxA83joy5I+vWGWNbscdED5ReejFqShCpr7T36pg3zMUMb+akUpNzznqC
         Jf+LN4bTtP+iMG+HNFfO0KqRjoaEVGsKFRJYiw9O46QDzVNBLp+fn/JXP8NkMF4BR+EA
         tvCRX5zaxh0H9aNsw8QS7EWtbtt6ZJcBv9J+0L8K/KKvLx2eu7wuWuTxXGE6gh1Ouykm
         PUfVxW9ziVGJ/FXxlydV4AE/tJNsZPxqx9aJ2qb+LPi1j+XmLBIMuB0uufnXZTFsfSIz
         hS+52PPs1NYW7U8zeCYzCi0KS4IO9G96EkkrT7T0+D16HBFpqNLyh55vc23+1yDYtugy
         oaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umQTPDyQZOVs6i7OvlPbG+/ScACJYmvNb++7yz/QGOY=;
        b=Y9cnLHDWqWUxPayPYZ5BGzojc/Hb205xzGXVN/cMkOz7GYYTJ04Y/VVH0QwZ1l78lp
         T5jMYqzfhDsCfxTIyR0lNfGM4wSRXOPK56NKk96BiScx+sntOa69bMoiBibs5hwi4bf3
         CHJsPAlS2ZbogCokEE03OgH42ZhtK1bhRwe/kSFWXMjNAXAPgL/Vl+J0MHUtlyrg04Uv
         CJtUFupvizOOiAxr8HKLKapEIUL+vsXn2DPZnj4y+pxuhmpWr1FESY8OE3NoZzdVHISv
         KY4HaZe4Vw/fVYKN0gBtWsXPrH8pQxhFvqD069liF28Us2dqVayQOmSka34KypGUaqic
         dlFg==
X-Gm-Message-State: AElRT7E84VSiZ032RkThj+kzBBNnXrwy9ySXyHd2OMgFcjtTyQloF5Uf
        3kIgPO8Bt/N1Q62DKlvj6x7EVQ==
X-Google-Smtp-Source: AG47ELthdRRYzJn2S3pf27tKHncJdHA6auWA983C08xHCS2NpGq+elIxHlC5y/pvl7lQSsr92U2VjQ==
X-Received: by 10.101.75.140 with SMTP id t12mr1007491pgq.442.1520958948176;
        Tue, 13 Mar 2018 09:35:48 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id c62sm1241441pfk.127.2018.03.13.09.35.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:35:47 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:35:46 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 35/35] remote-curl: don't request v2 when pushing
Message-Id: <20180313093546.6ae2961e8fbb9e8bf7e590c3@google.com>
In-Reply-To: <20180228232252.102167-36-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-36-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:52 -0800
Brandon Williams <bmwill@google.com> wrote:

> In order to be able to ship protocol v2 with only supporting fetch, we
> need clients to not issue a request to use protocol v2 when pushing
> (since the client currently doesn't know how to push using protocol v2).
> This allows a client to have protocol v2 configured in
> `protocol.version` and take advantage of using v2 for fetch and falling
> back to using v0 when pushing while v2 for push is being designed.
> 
> We could run into issues if we didn't fall back to protocol v2 when
> pushing right now.  This is because currently a server will ignore a request to
> use v2 when contacting the 'receive-pack' endpoint and fall back to
> using v0, but when push v2 is rolled out to servers, the 'receive-pack'
> endpoint will start responding using v2.  So we don't want to get into a
> state where a client is requesting to push with v2 before they actually
> know how to push using v2.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

I noticed that my review comments have been addressed, so:

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
