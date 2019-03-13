Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8807820248
	for <e@80x24.org>; Wed, 13 Mar 2019 23:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfCMXN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 19:13:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38389 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfCMXN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 19:13:27 -0400
Received: by mail-wm1-f68.google.com with SMTP id a188so894365wmf.3
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NcfN3LjK+MLXszjl5HpbqUsQKlHzHbPj8zQFe4HAVEI=;
        b=OcsyjfreOt65wm926LrpdEwqfGmOWmX/j1DnlNeiRZHDZ4lz8XRJZ67YCiJKiIhPAY
         26dSBs3AZESnNBmE3FMHn927mt/8Szsr8xo0lChDZypy5W6ipspUqAFGx0qJdUuh8os8
         nFE4lUjxxaUyPniuoVZEGPt3wehDGj620brOCOv6dgAGej51IdBHMeYSEreB37vmxhpg
         D2B5FhzSJV3Wp8lnew4f/IrmInI+j227fPvmGxIexEKnl+UCvaaD4kS+/SjBdZ71qh7j
         7wzxnA50X8MOB7isFm62nBcGgAacGjH1sBroS6bpFBD4mMIkOL4q0+JJMHYSlC1CmzFj
         +E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NcfN3LjK+MLXszjl5HpbqUsQKlHzHbPj8zQFe4HAVEI=;
        b=k5mCSU1mgT73J8+L6YKbc5mMrbgbO6iovsRDqccVdpzsnBldgsKQ5YKyM6z5tFvaHp
         M4r5cLtxohBJXaDERQadj8GJtscCe0xePpPKN+7noga+T/nnz+vJas6KEWX8Tv+zuDXP
         26uUVZouOlBbCYFVQB3OvubePMohC31FH4AdnyCzC7KXD5e7eM20qLcDWIQ7Sg57Gzwt
         tYV6i1bLnMsVaLWaeerrH2l7/Qo6FrrtDyut207UBB6jK9bDUnqt7H8YUfh8G/yiMK+q
         eMqgdZGBry2PZ7BWD7aJBNg1/tF9xnx7ugiKdMCGHUY9v4oDzGOH1y5Fd6wtsf64pMIZ
         r+Yw==
X-Gm-Message-State: APjAAAWLnHqmngXxiziLbajeW6XiR38RcStegQIBYH26zAp8v4iYOblE
        /yJ6HuAOKDqDS/0cpYmLIMI=
X-Google-Smtp-Source: APXvYqzgAVzK4U2o/R62anN6eTsVsIaaBB0W9q/nyYMNevfq96A4hxaX3ssuSPt1qoxBQ3WAlutClw==
X-Received: by 2002:a1c:8088:: with SMTP id b130mr350286wmd.96.1552518805589;
        Wed, 13 Mar 2019 16:13:25 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u17sm39842045wrg.71.2019.03.13.16.13.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 16:13:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] submodule: explain first attempt failure clearly
References: <20190312174522.89306-1-jonathantanmy@google.com>
        <20190313175738.252961-1-jonathantanmy@google.com>
Date:   Thu, 14 Mar 2019 08:13:23 +0900
In-Reply-To: <20190313175738.252961-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Wed, 13 Mar 2019 10:57:38 -0700")
Message-ID: <xmqqmulycqr0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> It is additional to what fetch prints. To make it clearer, I have
> removed all mentions of "additional" from the commit message. But right
> now I'm not sure if that whole section is important (since what happens
> can be deduced quite easily by reading the fewer than 10 lines of code).

Hmph, perhaps.  It was lot easier to follow, at least to me, though ;-)

> If you mean a recommendation to the repository administrator, I guess we
> can recommend that their HEAD points to something, even if it's just a
> single orphan commit with a .txt file explaining what's going on.

Yeah, that might make sense, too.
