Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0FD207EC
	for <e@80x24.org>; Tue,  4 Oct 2016 05:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbcJDFsx (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 01:48:53 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34310 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbcJDFsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 01:48:53 -0400
Received: by mail-yw0-f171.google.com with SMTP id g192so121847604ywh.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2016 22:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KS1KOuDJM0y0unJ7Q4AHVJ+12dRVu1745B3A4wJKyXU=;
        b=Fubz1gezp2HVqWTXCTE2xEq8D/KevlbXEBwbCFiUC0y5uhwBG+QMbLY5iUHOsJ1/v5
         vB2mKJLrc6ftZffTQLnuVaLEnQ7ntWKYZ5GJWcvGmSwlN74qOAeMClA2/KesV/bJyQzk
         O/yDey3XogFwvkTX0nx+2FVMfh9BDMNIKqpK3PYmHTKHK5olkF0120pp/SVHU5jhjiB/
         AWPAMJCWKDwONlIxAYgGV0rgWMALkC5ml0D6UIuz8X3L1wZL/Ow2s6iv0SbQEeIWB+Bk
         Fp1kqPGCOgrv+xCrUx9C4WPfJx3UlVvdX1vy8n2pmZccbO10+Hv5roJAYkqegcbhEEdE
         2DWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KS1KOuDJM0y0unJ7Q4AHVJ+12dRVu1745B3A4wJKyXU=;
        b=PX9x7MQZSKZr9sWFqkMxHn4ajiVUdhd0QTqnRSvUPsP4hdUmLd/oqgLvj9J73cPRGu
         v3sqLDFtgt9zHq60QIIWk0G2nRwL/00OhbdyxzJDyj6RFmzH53yvANmW2xwk8X36BBe5
         HcFF2TNeetsw7oMc94vTfavelFlGUzwhWwelWjK/R6i/Ip/A5Adhd7T88eBGlZi35Owf
         lYs/ZV9rbCb1SN55Z2BEkQFGNXnOsmFtUST+GRHe00AKs9bn6L72eyXj9Gf727O6/owP
         XKEG9tSylJPMNU7hZUdXlgidCMxQw1hp9z0vXCKBziq2XHT5Ft3MnOcmmGyXkEO6smMw
         ufzw==
X-Gm-Message-State: AA6/9Rk8hUB+JTuvLizm5hI/3L9ClvB/+hcQPtntAFTe6TVBqlBq4AP594+tKHW29ktnvow0zR58+IqABX5NIw==
X-Received: by 10.13.209.131 with SMTP id t125mr1386123ywd.204.1475560132200;
 Mon, 03 Oct 2016 22:48:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 3 Oct 2016 22:48:31 -0700 (PDT)
In-Reply-To: <20161003203350.3u6ddr6ndr3jwr74@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net> <20161003203350.3u6ddr6ndr3jwr74@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 3 Oct 2016 22:48:31 -0700
Message-ID: <CA+P7+xq3G=CNHNNQ5YpkHkud_5SUrTBOwZ3y7d8DvM9nKyXV9g@mail.gmail.com>
Subject: Re: [PATCH 01/18] t5613: drop reachable_via function
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 3, 2016 at 1:33 PM, Jeff King <peff@peff.net> wrote:
> This function was never used since its inception in dd05ea1
> (test case for transitive info/alternates, 2006-05-07).
> Which is just as well, since it mutates the repo state in a
> way that would invalidate further tests, without cleaning up
> after itself. Let's get rid of it so that nobody is tempted
> to use it.
>

Makes sense. It wouldn't be a good idea to leave this around since it
didn't clean up after itself. Curious why no test actually used it
though..

Thanks,
Jake
