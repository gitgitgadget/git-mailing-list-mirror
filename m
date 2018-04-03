Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9E471F404
	for <e@80x24.org>; Tue,  3 Apr 2018 18:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753017AbeDCSZH (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 14:25:07 -0400
Received: from mail-pl0-f44.google.com ([209.85.160.44]:43839 "EHLO
        mail-pl0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbeDCSYy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 14:24:54 -0400
Received: by mail-pl0-f44.google.com with SMTP id c21-v6so6396595plz.10
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R00r3vJPB62numpHpC7c+9Gl8PYjTkK4Txa7B4cmO3g=;
        b=GXYN1B156mNdxD8GNQYwTBniE6P3V03tbLj2dXYElJnJ73yQ1FZTNtfp37ZqQg5L5J
         NI2MgMmwfVOPoXxzGqlx1d2/kl26NNi4A9El7Id9q40S6SmetyRgC18CRnC4eZt6p2ly
         JTx5ECWbA2xY/GtGy6s414eEsSwzep10Oyne8VwYj7DOoiVTSYhVgIiCmrDEsBbFGHk5
         sAMaN/dmOalx3IbpC6427amTKigmN1Y5s58JobzgYLapVV24ZWSV4NlNL8G3GFyXe7hr
         146zfGqLqpV7GSsA0RYep5PqoPe8Kf0mVMYBBG/bt4FIcHflpj+pMPXJQO8Iv37vYUc5
         +Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R00r3vJPB62numpHpC7c+9Gl8PYjTkK4Txa7B4cmO3g=;
        b=D0YTHEdrLAGEVn+G5lhY2438Azu9z+dCtJ17+W26E155eILwRucEsQBWbH6zT9HZ/I
         9SvvWDz+jOPjpdFKZ1L/rpmYeUXxYl6f5tcxhXRikLv7QNS7tbVaAE8GZ0rUGl0Fv/ck
         A5dLsSlV0rlv4Wy9HTBxjAwPLY8zrNDPFBGgkUByFuo+GqFqeYCVCIGJQzyv3MVl4uXE
         Rjan1Ti7zAW8SeqExMuocSb0zq3SbtW9BA+Ye/9Ofgnar+d3IEJZDttNjkB20dlA6ONX
         llYDAQn3C1AvFCm43eEIYzfF0xljW31Csb6zcHlzX8JF5M7lq+TIJarZl1Yc5Ig8K6MB
         wPaQ==
X-Gm-Message-State: AElRT7HoHgerImlzOHnp++pxo7B6pQioTSW1SfP5Ts+sg9K3TsJgLfII
        XbTImAcEaGoBol2YyGW3y1cyJQ==
X-Google-Smtp-Source: AIpwx4+n8/m8XEsTvuHgL6gEcRjNFuMizDWJPIWFqzrBqrvNgWNUKcyzHTa9eaysKvYK5sUwQgpyMQ==
X-Received: by 10.98.198.7 with SMTP id m7mr7916337pfg.66.1522779894061;
        Tue, 03 Apr 2018 11:24:54 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id y20sm6087795pfe.20.2018.04.03.11.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 11:24:53 -0700 (PDT)
Date:   Tue, 3 Apr 2018 11:24:52 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, sbeller@google.com,
        larsxschneider@gmail.com, peff@peff.net
Subject: Re: [PATCH 2/6] commit: add generation number to struct commmit
Message-Id: <20180403112452.96ebcfcdfd68181d1d269171@google.com>
In-Reply-To: <20180403165143.80661-3-dstolee@microsoft.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
        <20180403165143.80661-3-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Apr 2018 12:51:39 -0400
Derrick Stolee <dstolee@microsoft.com> wrote:

> The generation number of a commit is defined recursively as follows:
> 
> * If a commit A has no parents, then the generation number of A is one.
> * If a commit A has parents, then the generation number of A is one
>   more than the maximum generation number among the parents of A.
> 
> Add a uint32_t generation field to struct commit so we can pass this
> information to revision walks. We use two special values to signal
> the generation number is invalid:
> 
> GENERATION_NUMBER_UNDEF 0xFFFFFFFF
> GENERATION_NUMBER_NONE 0
> 
> The first (_UNDEF) means the generation number has not been loaded or
> computed. The second (_NONE) means the generation number was loaded
> from a commit graph file that was stored before generation numbers
> were computed.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>

This looks straightforward and correct, thanks. I think some of the
description above should appear as code comments.

> +#define GENERATION_NUMBER_UNDEF 0xFFFFFFFF
> +#define GENERATION_NUMBER_NONE 0

I would include the description above here as documentation, and would
replace "was stored before generation numbers were computed" by "was
written by a version of Git that did not support generation numbers".
