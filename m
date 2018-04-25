Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107D71F424
	for <e@80x24.org>; Wed, 25 Apr 2018 20:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbeDYUhJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 16:37:09 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:32834 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750991AbeDYUhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 16:37:08 -0400
Received: by mail-pf0-f176.google.com with SMTP id f15so16217557pfn.0
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 13:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLeFvOebWhrAj2rqHTpY6kJN1IJbhhjHbSunzqNo+j8=;
        b=h6GEc0pFJYT4xC+GtVPcOwe41AWeEiTGGZN7W6b2JtbReE5Hns8LUEcfvu9E7E8oU6
         zR2Q1fQadajFGfvg/BRvg0b4DDX0tL+xe1QMYRnxF6USpKG7dxJEOHdY5NDclCKTGEqm
         SnT5vAnZ4n1HiEQ/saVQ7/Br7fUSxD08BYRMdsv2RPf9S9wHSh0FClqFyLrfwCWW8MgK
         TOaB9HmPjJ9zEl8WoV4AEjgg06u26mcm7mLYOlcX9DcyXIsWqQl5QnLYYbWh9kGzk2Z3
         kNPh/IVVoCatWPElShBy6WqaaPQnzhbwArcp5gIistK0Xzprk5BbrD0NtQKK0PyTrKbk
         /YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLeFvOebWhrAj2rqHTpY6kJN1IJbhhjHbSunzqNo+j8=;
        b=t61E/KlobvUfWPiBoNA/rqW3l/ifEAOfJEC01A9xuEgikC3Wyt9o0YFjb0FCEQuFrl
         bODBX22uATqbEJ2F1fZUAQG1eHaDyKed99zCaNPWuoLQIYA3Q4nWxgV7AFT6vzdcIy7k
         ksdBP9n0vOG+FFnYn5jXcV1fBs74lmLS2pTsnCW0eGxRdIHLALQMgfUZ8yoPllkyoEze
         Utitz95ePajHda7fsFjoRluJ0RmQD9lJGmPolZ2F2E6C5A566zosi4dQ60jOww3+prhC
         DoO62JfJXM/OkLCFRxZ2c1rC41MLPjs+vP+AArxv2gRNk5HtAT+aonqH6NJrQ7qzo4kZ
         FGxw==
X-Gm-Message-State: ALQs6tC1TZJ8sUW68+DB9drNjJC6506BqWuOCCe9T22JK3aI8E4ilhzL
        ZlhwnU38TS+ymOhNAv3cnqmOpA==
X-Google-Smtp-Source: AIpwx48f9HXdYc1o+yPAWX8+2bBmdoBSOHF6wH9wQ4qXmqXqrNg5wpYRkElUHJglMBJUOFcpDg6h4g==
X-Received: by 10.101.81.11 with SMTP id f11mr24841790pgq.137.1524688627384;
        Wed, 25 Apr 2018 13:37:07 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id k66sm29921688pgk.24.2018.04.25.13.37.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 13:37:05 -0700 (PDT)
Date:   Wed, 25 Apr 2018 13:37:04 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCHv3 0/9] object store: oid_object_info is the next
 contender
Message-Id: <20180425133704.1a8914061b2712d986f1cbcb@google.com>
In-Reply-To: <20180425182106.162972-1-sbeller@google.com>
References: <20180424215910.22201-1-sbeller@google.com>
        <20180425182106.162972-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 25 Apr 2018 11:20:57 -0700
Stefan Beller <sbeller@google.com> wrote:

> v3:
> * fixed and extended the commit message of last commit
> * fixed the last patch, as Jonathan Tan suggested, see interdiff:

Thanks, all my comments have been addressed.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
