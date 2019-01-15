Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C0E1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 22:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731879AbfAOWeJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 17:34:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45371 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbfAOWeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 17:34:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so4758876wrr.12
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=F3bIztUv+ZAPsni46ph6fo4zUZW5gGo13jvrQvcN05s=;
        b=XYlBeDDATvjsrXOe/MELdYLpYiyQqLrEye53vL1O+czYgcwM7CixS6Mzbo0JqoZO3L
         mlmlcJL/Xh6OMvJR6T5XorkJa5xWNTFBvTxSR/TmLhaSpdttSlyGhChO3S8hCidtKnNH
         p/YMSYvkFp9729kWo2W+OsHGA1kikLiZ3rR+O3AqbHDl1Z92QlsEkJYbh0RdHGuzAnh8
         4KGx2HlsdnsY+P8DWMNUQtaNfYW3TMwl9V4yfkNevnwquvzv1V/ozFSRmaRvzhyFOZ8/
         hzqIqAAi2tdfsz8LDCMjo0F6Bd1oZl//X+hcB1+I39zzelzaBQ9sIN2rVQ9uO/K2d3ZB
         3rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=F3bIztUv+ZAPsni46ph6fo4zUZW5gGo13jvrQvcN05s=;
        b=dO9l2P95GCRipPVv6gw++37bmHx7k5b23YdjDfD/NaXYhT8OYeZZtfcAnYFNgHZlkl
         7KwF2cGCSU3O1rQauyQXri24F4bGqw+V5Wi3K5yYvo2cqJchzC5WHVJjeod4FUU5A4YX
         2cg0fmYFSErBjwh8VN5ueov/leug0Z81gdZmX0Ip3pHVH+kc8II+sOGmcaXqRkfejdcf
         ubDUxD8X4SocvIXoeSgGsESPrikSO9JxArjUNqeeBtySstVyvVAN/bSvt2IGUPTE55FF
         xxYsIWh9gWlApC04TeTgPSkKO4PeIveC/iYqDa5q4d6HrGkz30F+PEb5LB91BNW9zheN
         5M1A==
X-Gm-Message-State: AJcUukeXhxau6h8JTNMYYDzL/hl66XPiDRQ3mKpHI7sxLPfaRK7VoTt/
        /D8jbgc3KL3Y9stNwIDcyfM=
X-Google-Smtp-Source: ALg8bN6apnXBShebSrN1Yq+JmFCFaNGDICOE4X7uLV8IvEq8jU4NH5HGBFf/Fvj5FiLRNRu8a29M4g==
X-Received: by 2002:adf:e8c1:: with SMTP id k1mr4684200wrn.104.1547591647876;
        Tue, 15 Jan 2019 14:34:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm19567010wmh.16.2019.01.15.14.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:34:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v5 3/3] Makefile: correct example fuzz build
References: <cover.1544048946.git.steadmon@google.com>
        <cover.1547582104.git.steadmon@google.com>
        <350ea5f7c97aa4166eea56aa57b66ddc9c53de4a.1547582104.git.steadmon@google.com>
        <xmqqimypr6yx.fsf@gitster-ct.c.googlers.com>
        <20190115215945.GB35794@google.com>
Date:   Tue, 15 Jan 2019 14:34:06 -0800
In-Reply-To: <20190115215945.GB35794@google.com> (Josh Steadmon's message of
        "Tue, 15 Jan 2019 13:59:45 -0800")
Message-ID: <xmqqzhs1pn35.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Sorry for being too vague. The problem with only including FUZZ_CXXFLAGS
> is that all the .c files need to be compiled with coverage tracking
> enabled, not just the fuzzer itself.

OK.

> We could fix the comment by setting both CFLAGS and FUZZ_CXXFLAGS, but
> since we're not including any C++-specific flags there's no reason to
> set both.

Yes.
