Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BCD020899
	for <e@80x24.org>; Thu, 27 Jul 2017 17:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751446AbdG0RZy (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 13:25:54 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:37915 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdG0RZx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 13:25:53 -0400
Received: by mail-pg0-f42.google.com with SMTP id k190so35085579pgk.5
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 10:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WIrczF7AVjwCOk5dnwC+zwFj2ICXZUYvCPs8pODrgCs=;
        b=eENHIAPvXXSaAm6B2ib+fCHe7SVInicCcJFBqpy0n68oAp95gslbw6H8MRITAdqZby
         oFsJxZTHutbjSaTuvzxksultijQ4mPi8JNaPnURaWnaADw4d1CjMUoJtCLQApt1v2sBS
         bST0c5DeXCF9mu6jnrpZyx4XPa5wK3WZX8XX2zx0zDmQhjsaWXlCXWDxL7zeb7goryOU
         m01DK3ANHwciWnrs28BtGBVkQewDdLA/Ic5NV086NKdEALN8tDownVLgiaXuYY5lSi5k
         +IbTslRV4rvcAN8FE5JnSXzF3zYR8k3fkRyPchB1WMY/QuYn39CJ6Q2gS+snwiM/ui9+
         5Jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WIrczF7AVjwCOk5dnwC+zwFj2ICXZUYvCPs8pODrgCs=;
        b=ojVNG0Qc1XdwgWK8DyVwRln0i/avja+aXUrB7Fcf5mB97gDd/Vie2H95KbnlIb++bu
         938c7xojchrhapd/h51TOhNeJUhW6PXUKLK5Zfl+vR+M78TdgnpirudqgbfRgIrSLClT
         xW6bHHnYYSQoN41+75XAaUwkdEPt97H47YRGrjTxqvJk7uPZamthrdwYYIec93hHgSIj
         29MPYCSHOlojtejGxC+xvpU9ld5KLwYG9ISqv6eqvtv8z4c0VZJYRZi8EpWbFsW0myKf
         o6uR83HMSgxRyPDkFfmWKIey5rYv2mnI4Z6gSubiEOdZK2aI4nZN2OHOEt0Wy3Mi5X9O
         0fmg==
X-Gm-Message-State: AIVw1101s6ptMhQmwHUI813WQgB7IYPLU0heLLWEnrkq/kWvjDbY06Bn
        DdnXkAb61c+XBaSB
X-Received: by 10.84.237.8 with SMTP id s8mr653691plk.403.1501176352619;
        Thu, 27 Jul 2017 10:25:52 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6055:1975:96d0:9b69])
        by smtp.gmail.com with ESMTPSA id q13sm41620474pgn.48.2017.07.27.10.25.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Jul 2017 10:25:52 -0700 (PDT)
Date:   Thu, 27 Jul 2017 10:25:47 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 0/4] Some patches for fsck for missing objects
Message-ID: <20170727102547.0c45a8db@twelve2.svl.corp.google.com>
In-Reply-To: <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <20170726234238.2osugw2lheubmetw@genre.crustytoothpaste.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 26 Jul 2017 23:42:38 +0000
"brian m. carlson" <sandals@crustytoothpaste.net> wrote:

> I looked at this and I like the direction it's going.  It's pretty
> simple and straightforward, which I also like.

Thanks.

> What I'd recommend is that instead of making lazyObject a string, we
> make it an integer representing a protocol version.  We then add a
> different config setting that is the actual program to invoke, using the
> given protocol version.  This lets us change the way we speak to the
> tool without breaking backwards compatibility, and it also allows us to
> simply check the lazyObject script for supported protocols up front.

That's possible too. As for version negotiation, I think we'll end up
using a protocol similar to the clean/smudge long-running process
protocol (as documented as gitattributes), so that does not need to be
taken care of here, but making lazyObject be the version integer is fine
too.
