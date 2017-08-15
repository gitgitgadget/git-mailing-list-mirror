Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B49208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753418AbdHOSRg (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:17:36 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33686 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753266AbdHOSRf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:17:35 -0400
Received: by mail-pg0-f45.google.com with SMTP id u5so10319141pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wmBiFb6WXD6B3f62I9qF0MCG7hJJ2wrUkWuKK5w1ggs=;
        b=uBqSAvflDnvvAvesfkGMN2e1NdL9mAjxXUQI42qQH3X4TUaPkpZRTqByr+/IHQ1EVO
         kIjK0Rm4zqNXmoGWc0aSXEjwt9y9+mVRPviYKlGZ7uj7rSgmwpsSKQPa7BTMar/9lHPZ
         dqLzNFZ/Pv+q2dfQkLz8onseLupBqIgJmda3PcBiiy0HudoIZLDlU0IjPtvp9wHmVrM7
         UFUtretCzEEcM/aC3qga9FOvUtY/NJHy0shMhJwBcQYBIKs8Ba92NFJqsnLSsgGGUhha
         i8IiXDHcPWpnQbGtm9doXENFeOjiZkxbQjjy2V51IovgQCuBSsIRcBpItFeB3mh5WCnn
         v/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wmBiFb6WXD6B3f62I9qF0MCG7hJJ2wrUkWuKK5w1ggs=;
        b=ZP/Dhvj7D9UkUWChXzwvdcpQ5d/8C0ZPQ/JBFoEhYJBbNN1+n3kbqmDWIAgZgKOksK
         HPs0CJnCYS3pU5vUTU/sVaNjQFp1N1lmCQET1zr2XDarkNbfC+EXrz6Gu3km5FpY4tlK
         8RflpNc7CAsPL7M+3z8CWQAxM+UWIrnzrcehMqCfewHGaMbXQ6eXwBAHUp2Po8vnEk56
         fhXLOrg17mQYZHbXR3IfK5HiTG10lmz5J79tu19BiyskJ3vfpzYOkbj7CueVNq7u62wD
         5/xIst61HBpuBJ0KvFKYEarcvlkZLzSNKtRlpMY91utEKWkxEqXwWhTrSZfRU3kOA3b+
         Q0Xg==
X-Gm-Message-State: AHYfb5iv7zCisTU+UN4AaUBufa0VD73v08wwMRKv8XkdaeJs+UWOh4YL
        1lShbO+1xULbLLqH
X-Received: by 10.84.231.9 with SMTP id f9mr32035853plk.257.1502821054313;
        Tue, 15 Aug 2017 11:17:34 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:5ca4:accf:3fb1:c802])
        by smtp.gmail.com with ESMTPSA id f15sm16860982pgu.90.2017.08.15.11.17.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Aug 2017 11:17:34 -0700 (PDT)
Date:   Tue, 15 Aug 2017 11:17:25 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] sub-process: print the cmd when a capability is
 unsupported
Message-ID: <20170815111725.5d009b66@twelve2.svl.corp.google.com>
In-Reply-To: <20170815173611.2267-1-chriscool@tuxfamily.org>
References: <20170815173611.2267-1-chriscool@tuxfamily.org>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 15 Aug 2017 19:36:11 +0200
Christian Couder <christian.couder@gmail.com> wrote:

> In handshake_capabilities() we use warning() when a capability
> is not supported, so the exit code of the function is 0 and no
> further error is shown. This is a problem because the warning
> message doesn't tell us which subprocess cmd failed.
> 
> On the contrary if we cannot write a packet from this function,
> we use error() and then subprocess_start() outputs:
> 
>     initialization for subprocess '<cmd>' failed
> 
> so we can know which subprocess cmd failed.
> 
> Let's improve the warning() message, so that we can know which
> subprocess cmd failed.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

This looks reasonable to me.

I am still wondering if protocol errors should be fatal, but that is
unrelated to this patch.
