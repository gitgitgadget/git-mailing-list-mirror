Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2CBC1F404
	for <e@80x24.org>; Fri,  5 Jan 2018 05:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751255AbeAEFUs (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 00:20:48 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:43704 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751065AbeAEFUr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 00:20:47 -0500
Received: by mail-io0-f175.google.com with SMTP id w188so4567818iod.10
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 21:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8E5LSNIaJMotZD8KvhheEmFhbkYqD1OdHBMcN6yJDY0=;
        b=N3Ah+ptBhjaH4J2pja95/CNAFwu8gMZ8+5bxidhATP5phawSn9WdPL8Td7KAqDFUUF
         SaYDiBit7Pew/LQLJbZxRBTmUkxFmN9OhXUQBVqvuxVIvXmQGuFPwaRB2uAspyqIVDxg
         t9wlAFCM7sj9CG1roTHFXYgdFCSM5HTZG1D6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8E5LSNIaJMotZD8KvhheEmFhbkYqD1OdHBMcN6yJDY0=;
        b=ePEbAmniEJcpQlIpRjDPXbk0KTep8NfnqgPtQQRqV2EGp8ID3FYuT+VRRdf9f0n4C9
         YJdWAWHkZEIwvDTm+6XyOG89nACtFq7YQnYi6x/KcYkiswOahXyD4uJ/tIRyUQAvdRNI
         Y8FXjs18EllZsb04BdjAKQiobVXXnYlDeqmUE1zuP2hwwiQVe8z9ZQUpRD35iT36qLUi
         8oBtGB/cXTF01NS7KqcyZVCWpPPeVARSV3InIz7Y6rDLx25dOrcYLAPqR/ot58BjsAaG
         M7quAKbM49lzSbIub7wk+QeJcWmvEAhmnDXN5QPSqAeComjUVcI9urFTJe5o0jVo76BN
         v+Eg==
X-Gm-Message-State: AKwxytd6SCNibT0dewH77zJ/R9sgDD8yEULb2aZsnAGG+zMvVVEuzt7b
        dPDzmP1GSReyiJIDepeLsPG8sA==
X-Google-Smtp-Source: ACJfBotkwlBEsPlgNUzKWf2Om2PiRNemLHzoaQvXpHhUbLRLQ6bVaM35XRH6zh5utRUGJVk85eX0Bw==
X-Received: by 10.107.17.198 with SMTP id 67mr2061970ior.11.1515129647101;
        Thu, 04 Jan 2018 21:20:47 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:f0d7:a5cd:e618:32a7])
        by smtp.gmail.com with ESMTPSA id f202sm3056615itc.40.2018.01.04.21.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Jan 2018 21:20:46 -0800 (PST)
Date:   Thu, 4 Jan 2018 22:20:44 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20180105052043.GB14525@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171226060229.GB18783@Carl-MBP.ecbaldwin.net>
 <CA+P7+xpvuCjdnjyQxQg3B5iMwbnx-CerQMAP+bDQHR_-ALJOkQ@mail.gmail.com>
 <2180514.YZ24uruNv3@mfick-lnx>
 <20180105050919.GA14525@Carl-MBP.ecbaldwin.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105050919.GA14525@Carl-MBP.ecbaldwin.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 04, 2018 at 10:09:19PM -0700, Carl Baldwin wrote:
> This would be very cool. I've wanted to tackle this for a long time. I
> think I even filed an issue with gerrit about this years ago.

Yep, it turned out that it was a duplicate but I described what I did to
work around it.

https://bugs.chromium.org/p/gerrit/issues/detail?id=2375
