Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6E42023D
	for <e@80x24.org>; Wed,  2 May 2018 20:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeEBUeJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 16:34:09 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:35720 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751403AbeEBUeH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 16:34:07 -0400
Received: by mail-pf0-f174.google.com with SMTP id j5so12764858pfh.2
        for <git@vger.kernel.org>; Wed, 02 May 2018 13:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x15/sypR0xzbPGJ9FY4duMW4xDKSwmxii7LhY+Xzx8A=;
        b=KYi3yP8D1nIdzene3XMUOd1DbDf68RwaCVGURfV7KfcIa6HPfA71oW4U/d/RlPiKm1
         N//81PU5FviXZFHAtc66mhHjI+DpcC+6xiXplZJSS8eqCageGq/Ngtkqmg3cTuv4xcgU
         GeaHOMvFp0tSLuQul9Ml/o1QR5NkI+50gqge0AycZMs/j3ZN0TYPi161XxtCiNTsQ1vi
         7Aqo/q9Cc50wGgTYNJdHhVEcZg7ojr8RVxNqcRkFu1+ua9TYG+tfUYd3IF5wp23asHqm
         vbfLURqQrDv857l8Gl05EeRH+8QXZ5VWijJnzcCv78/vjiceZbv2Y5RW5dXjnHlP7l3o
         dlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x15/sypR0xzbPGJ9FY4duMW4xDKSwmxii7LhY+Xzx8A=;
        b=c38NyRU6LbrLtzrlHigcafeVbXJHF4V9yrzMqlYVG8a8ae6DqYyQwu3jiyf4PL99Wb
         M37B04VxC8AYxW0vaDfD0d4euo5bOb2jRl8mpP9+WuS/CSF1/jtEJcH+tIDve964H6Jm
         Lq5mNslenyKIOJAFDJUBfFCiUcoBacA1YvispzatfwA/BmKF5aIzilPu0+XXCXiO4X9H
         m9z+sSeSvHv109Lyo+GAUF6o0cbwerPzXIC3EbAwcH6gG0ZbOWqkfOTQMI2WBS2ff6bF
         FudhBvWWvEGwF6XEaziE4v7S9sTUUaLUPbEWH2XXNWillv6SylTPT8OHP/7OeFg6om6e
         hbkA==
X-Gm-Message-State: ALQs6tApkIgHtA87WMAJ1PFcJ+Cj+WPtkYL7s3u0pIgJKZ5mj18jkaqa
        IE5x9NEhXqa2okYeibi1ZMtiAKzYtQE=
X-Google-Smtp-Source: AB8JxZorn8RDHi7U8lQvS5BdKO/NYyM6Qzy6dDVAGnzAHYJlFbMC1lBXbr5DxYcB33Y63jWr1EcI5Q==
X-Received: by 2002:a17:902:44c:: with SMTP id 70-v6mr21146135ple.354.1525293246842;
        Wed, 02 May 2018 13:34:06 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id h65sm29650588pfj.54.2018.05.02.13.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 May 2018 13:34:05 -0700 (PDT)
Date:   Wed, 2 May 2018 13:34:04 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jamill@microsoft.com
Subject: Re: [PATCH 04/13] alloc: add repository argument to alloc_blob_node
Message-Id: <20180502133404.d039e81a6279213ae6943cc7@google.com>
In-Reply-To: <20180501213403.14643-5-sbeller@google.com>
References: <20180501213403.14643-1-sbeller@google.com>
        <20180501213403.14643-5-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  1 May 2018 14:33:54 -0700
Stefan Beller <sbeller@google.com> wrote:

> Signed-off-by: Stefan Beller <sbeller@google.com>

Add the same boilerplate explanation to this and subsequent commits. If
editing it for every new function name is cumbersome, maybe use this
shortened version:

  This is a small mechanical change; it doesn't change the
  implementation to handle repositories other than the_repository yet.
  Use a macro to catch callers passing a repository other than
  the_repository at compile time.
