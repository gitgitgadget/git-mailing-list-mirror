Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BA84208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 23:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdHRXgj (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 19:36:39 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33871 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdHRXgj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 19:36:39 -0400
Received: by mail-pg0-f54.google.com with SMTP id n4so9325728pgn.1
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3W0mMtX1exl753x09pQgUmDFSlnJcebEohgftBN3dE=;
        b=uD+Y657/QNYptpBitIoMfgNZW+DvSFdx0vqqilfNoZG+VGBef9ZmHPS7SZ8sZtduLR
         da6yo1cXa0k2Zy6mN1vgfC//p6emj5qNuML131odEaiom5yrd4kQC4z8DhiY9EX/O65w
         DMSiqUSu9RbZtfhrK4RbNNQxBbYNbDSrMFgBTlE1wbQ3lT8405cH3T2VmmpHaLj6NnFq
         qFsFpVtYPHXJ88/CoaQvkNjtQ5EUyP7R1ysXqWCrKl/WJ96GYms7QrsYhaHK/4SKWuf1
         W9JtHNIcK5RS5fR+ZQPZhad9tlg41piffckxHXMKJ5a7U3wwK5AFNqlquJIqjnpf/I2B
         dkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3W0mMtX1exl753x09pQgUmDFSlnJcebEohgftBN3dE=;
        b=BFqzttpBDXFOTLg3x45jA9O5qDM/iJu4RFw/wjzqISzPZBE0NJvE7mmNxnQS1cNixJ
         5pwjtK3LMej6vazVzs6SUmGg/1phGtKeA9AoKN5+PrIoTMR7Wa4jbEld8q9X/+GQLcu4
         T7e/VD85smKoJmEAbNQzX00tIG6TMzsXQtsNzHq0xf1h/OUs5oPRrkioUtUgCMoK2ubf
         /jKCVLmpe0ZoDK82vtl1jdnm3sBahp+/F3LLSkyfIyxxQAvVFJtruwZKUeNEVGvoS3Me
         v5cpEr8LgvGdYfA2l/ymrTiLi1HCt9Hy5XY3MuGbONfx9tpO4wSEkymbCeFrKb4FJEfx
         pEZQ==
X-Gm-Message-State: AHYfb5hVhmzpD45VN+c0oqhubdsFrzjOSPi6MhPxSSBxVH5tgRN4dXzd
        ITTuMoZ5Mdpj223/
X-Received: by 10.99.121.14 with SMTP id u14mr9755812pgc.423.1503099398756;
        Fri, 18 Aug 2017 16:36:38 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:ecbe:10b8:47b2:41c3])
        by smtp.gmail.com with ESMTPSA id 133sm11932739pge.29.2017.08.18.16.36.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 18 Aug 2017 16:36:38 -0700 (PDT)
Date:   Fri, 18 Aug 2017 16:36:36 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
Message-ID: <20170818163636.07b593ad@twelve2.svl.corp.google.com>
In-Reply-To: <588e6770-58f8-0320-014b-0ce195d498ac@gmail.com>
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502241234.git.jonathantanmy@google.com>
        <588e6770-58f8-0320-014b-0ce195d498ac@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 11 Aug 2017 15:41:28 -0400
Ben Peart <peartben@gmail.com> wrote:

> Nice to see the pack file functions being refactored out.  I looked at 
> the end result and it looked good to me.

Thanks.

> Do you have the energy to do a similar refactoring for the remaining 
> public functions residing in sha1_file.c?  Perhaps a new sha1_file.h? It 
> would be nice to get more things out of cache.h. :)

I agree that that would be desirable, but for now I'll leave that for
someone else to do :-)
