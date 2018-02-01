Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424EC1F404
	for <e@80x24.org>; Thu,  1 Feb 2018 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBAVo0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 16:44:26 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:43779 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeBAVoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 16:44:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id f6so1854757pga.10
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 13:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Aast4X3y2aNVLvF1safCLqFu6DQSoPjcVZ+GathRtyU=;
        b=HA3z7kcpNX1xgwZiej5JPWSXFUZuJCpo+/chwR7UuFQKvw2mnHaWNVKwlUaKH63RaL
         W+YL3S+4OTcTH9kNrLg7kKxwJfXz/PTPph3KM0AXwGh7KkiI23QW7ve8hksy2EpbJKjU
         dqKeHiz1hDilH+LLI8sQ6WFmUXjh/9KFSpRvu0m06HumI9vS3gPoKWzNkSveMGDHQ4Sk
         brHAwyD59N0gqVLvJ/WrRB2jDp6tPV6qBBMpbsyDUPzvqfVzZk0Nf2EZn08bRoryvFUm
         iOFEWBFfcoRA8Ihdm41pYRH4jptGqFDU8jxvz+6WBtFQXeNSjDFtNlNZEzZttALNnkfn
         lpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Aast4X3y2aNVLvF1safCLqFu6DQSoPjcVZ+GathRtyU=;
        b=XHeZfi5h+cPaYPTFpN3clUJ0p9JXnROr73Pl4F5NjtR1xd90pQST+jghkmrwjAeGTv
         tKbv4YqPpX3K4G4Bg/EdSidO+4E8mlHkNgqOYq8M+6xmbzb9k0AS/cLWVxYn3p2o0Nqs
         Yd0DBZ+8kdVfSaSoualLe6oWHx5f6kDagU6l77RlvJbEv0dYCbysEhB5oM+b5eTTETeW
         bO6whZh9u5fr5CGSHQc7ak1iXKegdVk5MAPyiruO20JYz8N4Yr+thUBs4p8dB3GO8Ag/
         odoOzy4nzlfOiZ8YenYUIA3oXNBwdUHfudOg8ktZRBLc6CMxpHz7q96yd5i9NAM5qUEU
         TBKw==
X-Gm-Message-State: AKwxytcBdzI6CQpqWiAA1HD2XkL5MN5eps2iRXW9KrVpHAER9xr9M2QM
        iWIpkMqukUAjc2HsQydgPs7YFg==
X-Google-Smtp-Source: AH8x2249VTdjusSTG7Er1I4rVSj4adnRYZug+28MddoUv/8c4eK+5clBZJzcxqLRWsbG4BkoQeyMNQ==
X-Received: by 10.99.181.13 with SMTP id y13mr25398604pge.196.1517521464605;
        Thu, 01 Feb 2018 13:44:24 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id u25sm543071pfh.142.2018.02.01.13.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Feb 2018 13:44:23 -0800 (PST)
Date:   Thu, 1 Feb 2018 13:44:22 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH v2 01/14] commit-graph: add format document
Message-Id: <20180201134422.1662e936efb55b107cee2efa@google.com>
In-Reply-To: <1517348383-112294-2-git-send-email-dstolee@microsoft.com>
References: <1517348383-112294-1-git-send-email-dstolee@microsoft.com>
        <1517348383-112294-2-git-send-email-dstolee@microsoft.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 30 Jan 2018 16:39:30 -0500
Derrick Stolee <stolee@gmail.com> wrote:

> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
> +    * The first H bytes are for the OID of the root tree.
> +    * The next 8 bytes are for the int-ids of the first two parents
> +      of the ith commit. Stores value 0xffffffff if no parent in that
> +      position. If there are more than two parents, the second value
> +      has its most-significant bit on and the other bits store an array
> +      position into the Large Edge List chunk.

[snip]

> +  Large Edge List (ID: {'E', 'D', 'G', 'E'})
> +      This list of 4-byte values store the second through nth parents for
> +      all octopus merges. The second parent value in the commit data is a
> +      negative number pointing into this list. 

Looking at the paragraph which I quoted before the [snip], this sentence
is confusing (in particular, the second parent value is not interpreted
as the normal two's-complement negative value, and the semantics of
negative values indexing into the list is unclear). Maybe it's better to
omit it entirely.
